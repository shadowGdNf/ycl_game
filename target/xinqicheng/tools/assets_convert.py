#!/usr/bin/env python3
"""Decode the APK's LZ4/KTX ETC textures and statically parse its Lua atlases.

No APK, Lua, native target library, or bundled program is executed.
Install decoder dependencies into ./texture-deps, then run:
  python3 assets_convert.py --input EXTRACTED/assets/kr6-phone/images/ipadhd \
    --output ../web/assets --groups 'go_stage[0-9]+_bg|screen_main_menu_bg'
Omit --groups to convert every atlas. Re-running adds/replaces selected groups.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "texture-deps"))
import lz4.frame
import texture2ddecoder
from PIL import Image

KTX_MAGIC = b"\xabKTX 11\xbb\r\n\x1a\n"
FRAME_RE = re.compile(
    r'^\["(?P<name>[^"\\]+)"\]=\{size=\{(?P<size>[0-9, ]+)\}, '
    r'trim=\{(?P<trim>[0-9, ]+)\}, a_name="(?P<texture>[^"\\]+)", '
    r'a_size=\{(?P<atlas_size>[0-9, ]+)\}, f_quad=\{(?P<rect>[0-9, ]+)\}, '
    r'alias=\{(?P<aliases>[^}]*)\},?\s*(?:defer=true)?\s*\},?$'
)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def integers(raw: str) -> list[int]:
    return [int(v.strip()) for v in raw.split(",") if v.strip()]


def parse_atlas(path: Path) -> dict:
    """Accept only the observed literal atlas grammar; never evaluate Lua."""
    frames = {}
    for lineno, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.strip()
        if line in ("return {", "}", ""):
            continue
        match = FRAME_RE.fullmatch(line)
        if not match:
            raise ValueError(f"Unsupported atlas literal {path.name}:{lineno}")
        data = match.groupdict()
        name = data["name"]
        aliases = re.findall(r'"([^"\\]+)"', data["aliases"])
        # Reject extra tokens in aliases rather than silently accepting code.
        residue = re.sub(r'"[^"\\]+"', "", data["aliases"])
        if residue.replace(",", "").strip():
            raise ValueError(f"Unsupported aliases {path.name}:{lineno}")
        frame = {
            "sourceTexture": data["texture"],
            "size": integers(data["size"]),
            "trim": integers(data["trim"]),
            "atlasSize": integers(data["atlas_size"]),
            "rect": integers(data["rect"]),
        }
        if (len(frame["size"]), len(frame["trim"]), len(frame["atlasSize"]), len(frame["rect"])) != (2, 4, 2, 4):
            raise ValueError(f"Invalid dimensions {path.name}:{lineno}")
        x, y, w, h = frame["rect"]
        aw, ah = frame["atlasSize"]
        left, top, right, bottom = frame["trim"]
        if x + w > aw or y + h > ah:
            raise ValueError(f"Out-of-bounds frame {path.name}:{name}")
        if [left + w + right, top + h + bottom] != frame["size"]:
            raise ValueError(f"Invalid trim {path.name}:{name}")
        frames[name] = frame
        for alias in aliases:
            frames[alias] = {**frame, "aliasOf": name}
    return frames


def decode_texture(path: Path) -> tuple[Image.Image, dict]:
    source = path.read_bytes()
    payload = lz4.frame.decompress(source)
    if payload[:12] != KTX_MAGIC or len(payload) < 68:
        raise ValueError(f"Not a KTX1 file: {path.name}")
    endian = "<" if payload[12:16] == b"\x01\x02\x03\x04" else ">"
    fields = struct.unpack(endian + "13I", payload[12:64])
    marker, gltype, typesize, glformat, internal, base, w, h, depth, arrays, faces, levels, metadata_size = fields
    if marker != 0x04030201 or depth != 0 or arrays != 0 or faces != 1 or levels not in (0, 1):
        raise ValueError(f"Unsupported KTX layout: {path.name}, {fields}")
    image_offset = 64 + metadata_size
    image_size = struct.unpack_from(endian + "I", payload, image_offset)[0]
    pixels = payload[image_offset + 4:image_offset + 4 + image_size]
    decoders = {
        0x8D64: (texture2ddecoder.decode_etc1, 8, "ETC1_RGB8"),
        0x9274: (texture2ddecoder.decode_etc2, 8, "ETC2_RGB8"),
        0x9275: (texture2ddecoder.decode_etc2, 8, "ETC2_SRGB8"),
        0x9276: (texture2ddecoder.decode_etc2a1, 8, "ETC2_RGB8_A1"),
        0x9277: (texture2ddecoder.decode_etc2a1, 8, "ETC2_SRGB8_A1"),
        0x9278: (texture2ddecoder.decode_etc2a8, 16, "ETC2_RGBA8"),
        0x9279: (texture2ddecoder.decode_etc2a8, 16, "ETC2_SRGBA8"),
    }
    if internal not in decoders or gltype != 0 or glformat != 0:
        raise ValueError(f"Unsupported KTX format {internal:#x}: {path.name}")
    decoder, block_bytes, format_name = decoders[internal]
    expected_size = ((w + 3) // 4) * ((h + 3) // 4) * block_bytes
    if len(pixels) != expected_size or image_size != expected_size:
        raise ValueError(f"Truncated texture: {path.name}")
    rgba = decoder(pixels, w, h)
    image = Image.frombytes("RGBA", (w, h), rgba, "raw", "BGRA")
    return image, {
        "source": path.name,
        "sourceSha256": sha256(source),
        "ktxSha256": sha256(payload),
        "sourceBytes": len(source),
        "width": w,
        "height": h,
        "encoding": format_name,
        "glInternalFormat": hex(internal),
        "rgbaSha256": sha256(image.tobytes()),
    }


def write_json(path: Path, value: dict):
    path.write_text(json.dumps(value, ensure_ascii=False, separators=(",", ":")) + "\n", encoding="utf-8")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--input", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--groups", help="Full-match regex over atlas filenames without .lua")
    ap.add_argument("--format", choices=("webp", "png"), default="webp")
    ap.add_argument("--quality", type=int, default=90, help="WebP visual quality; 100 uses lossless")
    ap.add_argument("--force", action="store_true", help="Regenerate textures already recorded in manifest")
    args = ap.parse_args()
    source = args.input.resolve()
    output = args.output.resolve()
    texture_dir, atlas_dir = output / "textures", output / "atlases"
    texture_dir.mkdir(parents=True, exist_ok=True)
    atlas_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = output / "manifest.json"
    manifest = json.loads(manifest_path.read_text()) if manifest_path.exists() else {
        "version": 1,
        "provenance": {
            "artifact": "新启程.apk",
            "sourceDirectory": "assets/kr6-phone/images/ipadhd",
            "extractionEvidence": "ev_7c9409fed63b7b60b8519f5cecbce132705764a8062875b0418b6b27011be627",
            "method": "Static LZ4 decompression, KTX1 ETC decoding and literal Lua-table parsing; target not executed",
        },
        "textures": {},
        "atlases": {},
    }
    selected = [p for p in sorted(source.glob("*.lua")) if not args.groups or re.fullmatch(args.groups, p.stem)]
    if not selected:
        raise SystemExit("No atlas groups matched")
    for atlas_path in selected:
        frames = parse_atlas(atlas_path)
        used_textures = sorted({f["sourceTexture"] for f in frames.values()})
        for texture in used_textures:
            # All references are one filename in the same source directory.
            if Path(texture).name != texture:
                raise ValueError(f"Unsafe source reference: {texture}")
            name = texture.removesuffix(".pkm.lz4") + "." + args.format
            texture_output = texture_dir / name
            cached = manifest["textures"].get(texture)
            source_digest = sha256((source / texture).read_bytes())
            if args.force or not cached or not texture_output.exists() or cached.get("image") != "textures/" + name or cached.get("sourceSha256") != source_digest or cached.get("quality", 90) != args.quality:
                image, info = decode_texture(source / texture)
                if args.format == "webp":
                    image.save(texture_output, "WEBP", quality=args.quality, lossless=args.quality == 100, method=4)
                else:
                    image.save(texture_output, "PNG", compress_level=6)
                info.update({"image": "textures/" + name, "bytes": texture_output.stat().st_size, "outputSha256": sha256(texture_output.read_bytes()), "lossless": args.format == "png" or args.quality == 100, "quality": args.quality})
                manifest["textures"][texture] = info
                print(f"decoded {texture} -> {name} ({info['width']}x{info['height']}, {info['bytes']} bytes)", flush=True)
            for f in frames.values():
                if f["sourceTexture"] == texture:
                    info = manifest["textures"][texture]
                    if f["atlasSize"] != [info["width"], info["height"]]:
                        raise ValueError(f"Texture size disagrees with atlas: {atlas_path.name}/{texture}")
                    f["image"] = info["image"]
        result = {"version": 1, "name": atlas_path.stem, "sourceSha256": sha256(atlas_path.read_bytes()), "frames": frames}
        write_json(atlas_dir / (atlas_path.stem + ".json"), result)
        manifest["atlases"][atlas_path.stem] = {"url": "atlases/" + atlas_path.stem + ".json", "frames": len(frames), "textures": used_textures, "sourceSha256": result["sourceSha256"]}
        # Persist progress after each complete atlas, allowing incremental use.
        write_json(manifest_path, manifest)
        print(f"atlas {atlas_path.stem}: {len(frames)} frames", flush=True)
    print(f"Manifest: {manifest_path} ({len(manifest['textures'])} textures, {len(manifest['atlases'])} atlases)")


if __name__ == "__main__":
    main()

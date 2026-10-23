#!/usr/bin/env python3
"""Create a bounded static game bundle without executing game or shell code.

Requires Python 3.9+. GPL-3.0. This local helper is not upstream ATB code.
Operate on a stable input snapshot, not files concurrently changed by a build.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import stat
import sys
import unicodedata
import zipfile


EXTENSIONS = frozenset("""
.html .htm .css .js .mjs .json .xml .txt .csv .wasm .bin .data
.png .jpg .jpeg .gif .webp .avif .svg .ico .bmp
.mp3 .ogg .wav .m4a .aac .flac .mp4 .webm
.ttf .otf .woff .woff2 .fnt .atlas .webmanifest
""".split())
SENSITIVE_NAMES = {"credentials.json", "service-account.json", "service_account.json"}
WINDOWS_RESERVED = {"CON", "PRN", "AUX", "NUL"} | {
    prefix + str(n) for prefix in ("COM", "LPT") for n in range(1, 10)
}


class BundleError(ValueError):
    pass


def within(path, root):
    try:
        path.relative_to(root)
        return True
    except ValueError:
        return False


def checked_parts(relative):
    for part in relative.parts:
        if part.startswith(".") and part != ".nojekyll":
            raise BundleError("Hidden path is not distributable: " + str(relative))
        if part.lower() in SENSITIVE_NAMES:
            raise BundleError("Credential filename is not distributable: " + str(relative))
        if (any(ord(c) < 32 or c in '<>:"|?*\\' for c in part)
                or part.endswith((" ", "."))
                or part.split(".")[0].upper() in WINDOWS_RESERVED):
            raise BundleError("Non-portable archive path: " + str(relative))


def resolved_inside(path, root):
    try:
        real = path.resolve(strict=True)
    except (OSError, RuntimeError) as error:
        raise BundleError("Missing or cyclic input path: " + str(path)) from error
    if not within(real, root):
        raise BundleError("Input escapes game root: " + str(path))
    checked_parts(real.relative_to(root))
    return real


def file_chunks(path):
    # Reject final-component links and special files even if inputs change.
    flags = os.O_RDONLY | getattr(os, "O_NOFOLLOW", 0) | getattr(os, "O_NONBLOCK", 0)
    fd = os.open(str(path), flags)
    with os.fdopen(fd, "rb") as stream:
        if not stat.S_ISREG(os.fstat(stream.fileno()).st_mode):
            raise BundleError("Input is not a regular file: " + str(path))
        while True:
            chunk = stream.read(1024 * 1024)
            if not chunk:
                return
            yield chunk


def make_plan(game_root, web_dir, out_dir, game_id, max_files=10000, max_bytes=512 * 1024 * 1024):
    if not re.fullmatch(r"[a-z0-9][a-z0-9_-]{0,63}", game_id):
        raise BundleError("game-id must be 1–64 lowercase letters, digits, underscores or hyphens; start with a letter or digit")
    if max_files < 1 or max_bytes < 1:
        raise BundleError("Limits must be positive")
    root = game_root.resolve(strict=True)
    if not root.is_dir():
        raise BundleError("game-root must be a directory")
    web = resolved_inside(web_dir, root)
    if not web.is_dir():
        raise BundleError("web-dir must be a directory")
    if out_dir.exists() or out_dir.is_symlink():
        raise BundleError("Output already exists; choose a new output directory")
    parent = out_dir.parent.resolve(strict=True)
    if not parent.is_dir():
        raise BundleError("Output parent must already be a directory")
    output = parent / out_dir.name
    if within(output, root):
        raise BundleError("Output must be outside game-root")

    records = []
    portable_paths = set()
    total = 0

    def walk(path, relative, ancestors):
        nonlocal total
        checked_parts(relative)
        portable_key = unicodedata.normalize("NFC", relative.as_posix()).casefold()
        if portable_key in portable_paths:
            raise BundleError("Archive paths collide on a case-insensitive filesystem: " + str(relative))
        portable_paths.add(portable_key)
        real = resolved_inside(path, root)
        mode = real.stat().st_mode
        if stat.S_ISDIR(mode):
            if real in ancestors:
                raise BundleError("Directory symlink cycle: " + str(relative))
            if len(relative.parts) > 64:
                raise BundleError("Input directory nesting exceeds 64 levels")
            with os.scandir(real) as entries:
                names = sorted(entry.name for entry in entries)
            for name in names:
                walk(real / name, relative / name, ancestors | {real})
        elif stat.S_ISREG(mode):
            if relative.name != ".nojekyll" and relative.suffix.lower() not in EXTENSIONS:
                raise BundleError("Unreviewed file extension: " + str(relative))
            if len(records) >= max_files:
                raise BundleError("Input exceeds file-count limit")
            digest = hashlib.sha256()
            size = 0
            for chunk in file_chunks(real):
                size += len(chunk)
                if total + size > max_bytes:
                    raise BundleError("Input exceeds byte limit")
                digest.update(chunk)
            total += size
            records.append({"path": relative.as_posix(), "source": real.relative_to(root).as_posix(),
                            "bytes": size, "sha256": digest.hexdigest()})
        else:
            raise BundleError("Special input file is not supported: " + str(relative))

    walk(web, Path(), set())
    if not any(record["path"] == "index.html" for record in records):
        raise BundleError("web-dir must contain a regular index.html")
    if not any(record["path"] == ".nojekyll" for record in records):
        records.append({"path": ".nojekyll", "source": None, "bytes": 0,
                        "sha256": hashlib.sha256(b"").hexdigest()})
    plan = {"format": "atb-reviewed-static-v1", "game_id": game_id,
            "files": sorted(records, key=lambda row: row["path"]), "source_bytes": total,
            "limits": {"max_files": max_files, "max_bytes": max_bytes},
            "scope": "Static file packaging only; no game execution or malware scan"}
    return root, output, plan


def write_bundle(root, output, plan):
    # Exclusive creation: never clean, merge into, or overwrite a previous output.
    output.mkdir(mode=0o755, exist_ok=False)
    site = output / "site"
    site.mkdir()
    for record in plan["files"]:
        target = site / record["path"]
        target.parent.mkdir(parents=True, exist_ok=True)
        digest = hashlib.sha256()
        size = 0
        with target.open("xb") as destination:
            if record["source"] is not None:
                source = resolved_inside(root / record["source"], root)
                for chunk in file_chunks(source):
                    size += len(chunk)
                    if size > record["bytes"]:
                        raise BundleError("Source changed during packaging: " + record["path"])
                    destination.write(chunk)
                    digest.update(chunk)
        if size != record["bytes"] or digest.hexdigest() != record["sha256"]:
            raise BundleError("Source changed during packaging: " + record["path"])
        target.chmod(0o644)

    archive = output / (plan["game_id"] + "-web.zip")
    with zipfile.ZipFile(archive, "x", compression=zipfile.ZIP_DEFLATED) as zf:
        for record in plan["files"]:
            zf.write(site / record["path"], record["path"])
    archive_digest = hashlib.sha256()
    for chunk in file_chunks(archive):
        archive_digest.update(chunk)
    manifest = dict(plan, archive={"path": archive.name, "sha256": archive_digest.hexdigest()})
    with (output / "manifest.json").open("x", encoding="utf-8") as stream:
        json.dump(manifest, stream, ensure_ascii=False, indent=2)
        stream.write("\n")
    return manifest


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--game-root", type=Path, required=True)
    parser.add_argument("--web-dir", type=Path, required=True)
    parser.add_argument("--out-dir", type=Path, required=True)
    parser.add_argument("--game-id", required=True)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--max-files", type=int, default=10000)
    parser.add_argument("--max-bytes", type=int, default=512 * 1024 * 1024)
    args = parser.parse_args(argv)
    try:
        root, output, plan = make_plan(args.game_root, args.web_dir, args.out_dir, args.game_id,
                                       args.max_files, args.max_bytes)
        result = plan if args.dry_run else write_bundle(root, output, plan)
        print(json.dumps(dict(result, dry_run=args.dry_run, output=str(output)), ensure_ascii=False, indent=2))
        return 0
    except (BundleError, OSError, RuntimeError) as error:
        print("Bundle refused: " + str(error), file=sys.stderr)
        print("No existing output was deleted. A failed write may leave a new incomplete output; inspect it and use a fresh path.", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Extract named atlas frames without executing packaged code or altering artwork."""
import argparse
import json
import hashlib
from pathlib import Path
from assets_convert import parse_atlas, decode_texture


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--input", type=Path, required=True)
    ap.add_argument("--atlas", required=True)
    ap.add_argument("--frame", required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    frames = parse_atlas(args.input / (args.atlas + ".lua"))
    frame = frames[args.frame]
    texture, metadata = decode_texture(args.input / frame["sourceTexture"])
    x, y, w, h = frame["rect"]
    cropped = texture.crop((x, y, x + w, y + h))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    cropped.save(args.output, "PNG")
    args.output.with_suffix(".provenance.json").write_text(json.dumps({
        "atlas": args.atlas, "frame": args.frame, "rect": frame["rect"],
        "sourceTexture": frame["sourceTexture"], "sourceSha256": metadata["sourceSha256"],
        "outputSha256": hashlib.sha256(args.output.read_bytes()).hexdigest(),
        "method": "Lossless crop of ETC-decoded original texture", "width": w, "height": h,
    }, ensure_ascii=False, indent=2) + "\n")
    print(args.output)


if __name__ == "__main__":
    main()

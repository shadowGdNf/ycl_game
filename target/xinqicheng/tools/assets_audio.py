#!/usr/bin/env python3
"""Transcode five selected APK sounds to broadly supported browser MP3 audio."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

SELECTION = {
    "battle": ("kr6_bgmusic_t1_battle1_v3.ogg", "music", True),
    "map": ("kr6_bgmusic_WorldMap_v5.ogg", "music", True),
    "build": ("Sound_TowerBuilding.ogg", "effect", False),
    "wave": ("Sound_WaveIncoming.ogg", "effect", False),
    "explosion": ("kr6_sfx_towers_royalCatapult_basicAttack_impact_var1_v1.ogg", "effect", False),
}


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--input", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    manifest = {"version": 1, "tracks": {}}
    for key, (filename, category, loop) in SELECTION.items():
        source = args.input / filename
        target = args.output / (key + ".mp3")
        subprocess.run(["ffmpeg", "-hide_banner", "-loglevel", "error", "-y", "-i", str(source), "-vn", "-ar", "44100", "-c:a", "libmp3lame", "-b:a", "128k", str(target)], check=True)
        duration = float(subprocess.check_output(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "default=noprint_wrappers=1:nokey=1", str(target)]))
        manifest["tracks"][key] = {
            "url": "audio/" + target.name,
            "source": "assets/kr6-phone/sounds/files/" + filename,
            "sourceSha256": hashlib.sha256(source.read_bytes()).hexdigest(),
            "outputSha256": hashlib.sha256(target.read_bytes()).hexdigest(),
            "bytes": target.stat().st_size,
            "seconds": duration,
            "category": category,
            "loop": loop,
            "method": "FFmpeg decode of original OGG and MP3 encoding at 128 kbps; original source unchanged",
        }
        print(key, round(duration, 2), "seconds", target.stat().st_size, "bytes")
    (args.output / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")


if __name__ == "__main__":
    main()

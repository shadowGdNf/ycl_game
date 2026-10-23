#!/usr/bin/env python3
"""Export data-only exoskeleton files and recovered sprite animation tables."""
import argparse
import hashlib
import json
import re
from pathlib import Path
from assets_lua_literals import parse


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--exo-root", type=Path)
    ap.add_argument("--sprite-root", type=Path)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--groups")
    ap.add_argument("--names", help="Full-match regex selecting exoskeleton filenames without .exo3")
    args = ap.parse_args()
    output = args.output.resolve()
    anim_dir = output / "animations"
    exo_dir = anim_dir / "exo"
    exo_dir.mkdir(parents=True, exist_ok=True)
    atlas_for = {}
    for path in sorted((output / "atlases").glob("*.json")):
        doc = json.loads(path.read_text())
        for name in doc["frames"]:
            atlas_for.setdefault(name, doc["name"])
    index_path = anim_dir / "index.json"
    index = json.loads(index_path.read_text()) if index_path.exists() else {"version": 1, "exo": {}, "sprites": {}}
    if args.exo_root:
        for source in sorted(args.exo_root.rglob("*.exo3")):
            rel = source.relative_to(args.exo_root)
            group = rel.parts[0] if len(rel.parts) > 1 else "_root"
            if args.groups and not re.fullmatch(args.groups, group):
                continue
            if args.names and not re.fullmatch(args.names, source.stem):
                continue
            data = parse(source.read_text())
            if data.get("version") != 3:
                raise ValueError(f"Unexpected exoskeleton version: {source}")
            # Lua arrays can also carry attachment metadata as named fields.
            # Keep those fields separately so every JSON frame remains an array.
            for animation in data["animations"]:
                metadata = {}
                for frame_index, frame in enumerate(animation["frames"]):
                    if isinstance(frame, dict):
                        metadata[str(frame_index)] = {key: val for key, val in frame.items() if not isinstance(key, int)}
                        animation["frames"][frame_index] = [frame[key] for key in sorted(key for key in frame if isinstance(key, int))]
                if metadata:
                    animation["frameMetadata"] = metadata
            used = {part[0] for part in data["parts"]}
            # Parts unused by any selected frame may belong to another atlas.
            referenced = {data['parts'][part[1] - 1][0] for anim in data['animations'] for frame in anim['frames'] for part in frame if part[0] == 1}
            missing = sorted(referenced - atlas_for.keys())
            data["name"] = source.stem
            data["atlasScale"] = 0.5
            data["provenance"] = {"source": str(rel), "sha256": hashlib.sha256(source.read_bytes()).hexdigest(), "method": "Non-executing literal-table parsing"}
            target = exo_dir / (source.stem + ".json")
            target.write_text(json.dumps(data, separators=(",", ":")) + "\n")
            index["exo"][source.stem] = {
                "url": "animations/exo/" + target.name,
                "group": group,
                "fps": data["fps"],
                "atlasGroups": sorted({atlas_for[n] for n in referenced if n in atlas_for}),
                "clips": {a["name"]: len(a["frames"]) for a in data["animations"]},
                "missingFrames": missing,
            }
            print(f"exo {source.stem}: {len(data['animations'])} clips, {len(missing)} missing frames")
    if args.sprite_root:
        issues = []
        for source in sorted(args.sprite_root.rglob("*.lua")):
            text = source.read_text()
            # These decompiled files contain one literal table local a and return a.
            match = re.fullmatch(r"\s*local\s+a\s*=\s*({.*})\s*return\s+a\s*", text, re.S)
            try:
                if not match:
                    raise ValueError("not a single literal table")
                data = parse("return " + match.group(1))
                for name, spec in data.items():
                    if not isinstance(spec, dict) or not all(k in spec for k in ("prefix", "from", "to")):
                        raise ValueError(f"unexpected animation schema: {name}")
                    names = [f"{spec['prefix']}_{i:04d}" for i in range(spec["from"], spec["to"] + 1)]
                    if spec["from"] == spec["to"] == 1 and spec["prefix"] in atlas_for and names[0] not in atlas_for:
                        names = [spec["prefix"]]
                    groups = sorted({atlas_for[n] for n in names if n in atlas_for})
                    index["sprites"][name] = {**spec, "fps": spec.get("fps", 30), "frames": names, "atlasGroups": groups, "missingFrames": [n for n in names if n not in atlas_for]}
            except (ValueError, TypeError, KeyError) as error:
                issues.append({"source": str(source.relative_to(args.sprite_root)), "error": str(error)})
        index["spriteParseIssues"] = issues
    index_path.write_text(json.dumps(index, ensure_ascii=False, separators=(",", ":")) + "\n")
    (output / "frames-index.json").write_text(json.dumps(atlas_for, separators=(",", ":")) + "\n")
    print(f"Index: {len(index['exo'])} exoskeletons, {len(index['sprites'])} sprite animations")


if __name__ == "__main__":
    main()

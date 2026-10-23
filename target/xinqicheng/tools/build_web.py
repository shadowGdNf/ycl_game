#!/usr/bin/env python3
"""Prepare an explicit static runtime snapshot; never include reverse-engineering data."""
import argparse
import json
import pathlib
import shutil

ROOT = pathlib.Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--output', type=pathlib.Path, default=ROOT / 'dist')
args = parser.parse_args()
src, out = ROOT / 'web', args.output.resolve()
if out.exists():
    raise SystemExit('Output already exists; choose a new directory.')
files = [src / name for name in ('index.html', 'style.css', 'app.js', 'engine.js', 'render.js', 'app.webmanifest')]
files += [src / 'data' / name for name in ('mechanics.json', 'render-models.json', 'scenery.json')]
files += sorted(p for p in (src / 'assets').rglob('*') if p.is_file() and not p.name.startswith('.'))
for path in files:
    target = out / path.relative_to(src)
    target.parent.mkdir(parents=True, exist_ok=True)
    if path.suffix == '.json':
        target.write_text(json.dumps(json.loads(path.read_text()), ensure_ascii=False, separators=(',', ':')), encoding='utf-8')
    else:
        shutil.copyfile(path, target)
print(json.dumps({'output': str(out), 'files': len(files), 'bytes': sum(p.stat().st_size for p in out.rglob('*') if p.is_file())}, ensure_ascii=False))

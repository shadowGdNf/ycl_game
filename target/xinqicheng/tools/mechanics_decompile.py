#!/usr/bin/env python3
"""Offline, repeatable decompilation of the mechanic data carrier files only."""
import argparse
import concurrent.futures
import hashlib
import json
import subprocess
import sys
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--assets', required=True, type=Path)
    ap.add_argument('--ljd', default=Path(__file__).parent / 'ljd/main.py', type=Path)
    ap.add_argument('--out', default=Path(__file__).parent.parent / 'analysis/mechanics-decompiled', type=Path)
    args = ap.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)
    files = [f'kr6/data/levels/level{i:02d}_{kind}.lua' for i in range(1, 19) for kind in ('data', 'paths')]
    files += ['kr6/data/balance/balance.lua', 'kr6/templates_game.lua', 'all/constants.lua', 'main_globals.lua']

    def convert(rel):
        src = args.assets / 'gc32' / rel
        dest = args.out / Path(rel).name
        result = subprocess.run([sys.executable, str(args.ljd), '-f', str(src), '-o', str(dest)], capture_output=True, text=True)
        return {'source': str(src), 'output': str(dest), 'sourceSha256': hashlib.sha256(src.read_bytes()).hexdigest(), 'exitCode': result.returncode, 'outputSha256': hashlib.sha256(dest.read_bytes()).hexdigest() if result.returncode == 0 else None, 'diagnostics': result.stderr[-4000:] if result.returncode else ''}

    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        results = list(pool.map(convert, files))
    (args.out / 'mechanics-decompile-log.json').write_text(json.dumps(results, indent=2))
    failures = [r for r in results if r['exitCode']]
    print(json.dumps({'files': len(results), 'succeeded': len(results) - len(failures), 'failures': failures}, indent=2))
    return bool(failures)


if __name__ == '__main__':
    raise SystemExit(main())

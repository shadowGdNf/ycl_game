"""Statically decompile APK LuaJIT assets; never executes target Lua."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import subprocess, sys, json, time, hashlib, shutil

BASE = Path(__file__).resolve().parents[4]
SRC = BASE / 'source/xinqicheng/assets/gc64'
ROOT = BASE / 'target/xinqicheng'
DST = ROOT / 'love-probe/game'
LJD = ROOT / 'tools/ljd/main.py'
LOGS = ROOT / 'love-probe/decompile-logs'
LOGS.mkdir(parents=True, exist_ok=True)
SKIP = {'kr6/scripts_game.lua'}

def decompile(p):
    rel = p.relative_to(SRC)
    out = DST / rel
    out.parent.mkdir(parents=True, exist_ok=True)
    if str(rel) in SKIP:
        return {'path': str(rel), 'state': 'handled-by-parent'}
    if out.exists() and out.stat().st_size > 0:
        return {'path': str(rel), 'state': 'cached', 'bytes': out.stat().st_size}
    started = time.monotonic()
    if p.read_bytes()[:3] != b'\x1bLJ':
        shutil.copy2(p, out)
        return {'path': str(rel), 'state': 'plaintext', 'bytes': out.stat().st_size}
    log = LOGS / (str(rel).replace('/', '__') + '.log')
    try:
        with log.open('wb') as f:
            result = subprocess.run([sys.executable, str(LJD), '-f', str(p), '-o', str(out), '-c'], stdout=f, stderr=f, timeout=180)
        text = out.read_text(errors='replace') if out.exists() else ''
        state = 'decompiled' if result.returncode == 0 and text else 'failed'
        return {'path': str(rel), 'state': state, 'code': result.returncode, 'seconds': round(time.monotonic()-started,3), 'bytes': len(text), 'asserts': text.count('AssertionError'), 'errors': text.count('Decompilation error')}
    except subprocess.TimeoutExpired:
        return {'path': str(rel), 'state': 'timeout', 'seconds': 180}

rows = []
with ThreadPoolExecutor(max_workers=4) as pool:
    jobs = [pool.submit(decompile,p) for p in SRC.rglob('*.lua')]
    for job in as_completed(jobs):
        row = job.result()
        rows.append(row)
        if len(rows) % 50 == 0 or row['state'] in ('failed', 'timeout'):
            print(len(rows), row, flush=True)
        (ROOT/'analysis/engine-decompile-progress.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2))
print('finished',len(rows),flush=True)

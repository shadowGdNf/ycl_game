"""Package the built static game and complete portable source, with SHA-256 checksums."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
import hashlib
import json

root = Path(__file__).resolve().parents[1]
out = root.parent / 'releases'
out.mkdir(exist_ok=True)
if not (root / 'dist' / 'index.html').exists():
    raise SystemExit('Run npm run build first')
if list((root / 'dist').glob('_qa-*')):
    raise SystemExit('Remove temporary browser QA fixtures by rebuilding')

static = out / 'backpack-mecha-v0.1-web.zip'
with ZipFile(static, 'w', ZIP_DEFLATED, compresslevel=9) as archive:
    for file in sorted((root / 'dist').rglob('*')):
        if file.is_file():
            archive.write(file, file.relative_to(root / 'dist'))
    archive.writestr('START-HERE.txt', 'Backpack Mecha v0.1\nServe this directory over HTTP, for example: python3 -m http.server 4174\nOpen http://localhost:4174. Do not open index.html as file://.\nWASD/Arrows move; Space dash; E overdrive; P pause.\nChinese default; EN button switches language. Progress is local to each browser origin.\n')

source = out / 'backpack-mecha-v0.1-source.zip'
ignored = {'node_modules', '.git', 'dist', '.DS_Store', '.sites-runtime', '.sites-checkout'}
with ZipFile(source, 'w', ZIP_DEFLATED, compresslevel=9) as archive:
    for file in sorted(root.rglob('*')):
        relative = file.relative_to(root)
        if file.is_file() and not any(p in ignored for p in relative.parts):
            archive.write(file, Path('backpack-mecha-game') / relative)

manifest = {'version': '0.1.0', 'archives': []}
for file in [static, source]:
    with ZipFile(file) as archive:
        assert archive.testzip() is None
    manifest['archives'].append({'file': file.name, 'bytes': file.stat().st_size, 'sha256': hashlib.sha256(file.read_bytes()).hexdigest()})
(out / 'release-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps(manifest, indent=2))

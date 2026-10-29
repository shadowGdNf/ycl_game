"""Encode web delivery copies; preserve PNG masters, dimensions and sprite coordinates.

Run after changing atlas PNGs or the source manifest. Requires Pillow with WebP.
The checked-in copies make normal npm builds independent of Python/Pillow.
"""
from pathlib import Path
from PIL import Image, ImageChops
import hashlib
import json

ROOT = Path(__file__).resolve().parents[1]
source = ROOT / 'assets' / 'atlas-manifest.json'
manifest = json.loads(source.read_text())
out = ROOT / 'assets' / 'optimized'
(out / 'atlases').mkdir(parents=True, exist_ok=True)
manifest['sourceManifestSha256'] = hashlib.sha256(source.read_bytes()).hexdigest()
before = after = startup = 0
for name, relative in list(manifest['atlases'].items()):
    original = ROOT / 'assets' / relative
    image = Image.open(original).convert('RGBA')
    target = out / 'atlases' / f'{name}.webp'
    image.save(target, 'WEBP', quality=82, method=6, exact=True)
    decoded = Image.open(target).convert('RGBA')
    assert decoded.size == image.size
    assert ImageChops.difference(image.getchannel('A'), decoded.getchannel('A')).getbbox() is None
    data = target.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    relative = f'atlases/{name}.{digest[:12]}.webp'
    target.rename(out / relative)
    manifest['atlases'][name] = relative
    manifest['inspection'][name].update(bytes=len(data), sha256=digest)
    before += original.stat().st_size
    after += len(data)
    if name != 'environment':
        startup += len(data)
    print(f'{name}: {original.stat().st_size:,} -> {len(data):,} bytes')

keep = {Path(value).name for value in manifest['atlases'].values()}
for old in (out / 'atlases').glob('*.webp'):
    if old.name not in keep:
        old.unlink()
(out / 'atlas-manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2)+'\n')
print(f'Total: {before:,} -> {after:,} bytes ({1-after/before:.1%} smaller); startup: {startup:,} bytes')

"""Inspect original atlas pixels and validate runtime rectangles; never edits images."""
from pathlib import Path
from PIL import Image
import argparse
import hashlib
import json

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'assets' / 'atlas-manifest.json'
parser = argparse.ArgumentParser()
parser.add_argument('--write', action='store_true', help='Write rectangle metadata only')
args = parser.parse_args()
layout = json.loads((ROOT / 'assets' / 'source' / 'art-layout.json').read_text())
images = {}
entries = {}
report = {}
THRESHOLD = 24


def rect(name, key, region, trim=True, whole_cell=False):
    im = images[name]
    x, y, right, bottom = map(int, region)
    assert 0 <= x < right <= im.width and 0 <= y < bottom <= im.height, key
    if trim:
        alpha = im.getchannel('A').crop((x, y, right, bottom))
        box = alpha.point(lambda v: 255 if v > THRESHOLD else 0).getbbox()
        assert box, f'{key}: empty cell'
        x1, y1, x2, y2 = box
        if whole_cell:
            assert x1 > 0 and y1 > 0 and x2 < right-x and y2 < bottom-y, (
                f'{key}: visible pixels touch the cell edge; inspect layout cuts')
        x, y, right, bottom = (
            max(x, x+x1-2), max(y, y+y1-2),
            min(right, x+x2+2), min(bottom, y+y2+2))
    assert key not in entries, f'Duplicate sprite: {key}'
    entries[key] = {'atlas': name, 'x': x, 'y': y, 'w': right-x, 'h': bottom-y}


def cuts(spec, axis, count, size):
    values = spec.get(axis, [i/count for i in range(count+1)])
    assert len(values) == count+1 and values[0] == 0 and values[-1] == 1, axis
    assert all(a < b for a, b in zip(values, values[1:])), axis
    return [round(v*size) for v in values]


for name, spec in layout['atlases'].items():
    path = ROOT / 'assets' / 'atlases' / f'{name}.png'
    im = images[name] = Image.open(path)
    item = {
        'width': im.width, 'height': im.height, 'bytes': path.stat().st_size,
        'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
    }
    if not spec.get('opaque'):
        assert im.mode == 'RGBA', f'{name}: alpha channel missing'
        hist = im.getchannel('A').histogram()
        pixels = im.width*im.height
        assert hist[0]/pixels > .20, f'{name}: background is not transparent'
        assert sum(hist[240:])/pixels > .10, f'{name}: sprites lack opaque bodies'
        item['transparent_fraction'] = round(hist[0]/pixels, 4)
    report[name] = item
    cols, rows = spec['columns'], spec['rows']
    assert len(spec['keys']) == cols*rows, name
    ys = cuts(spec, 'yCuts', rows, im.height)
    for index, key in enumerate(spec['keys']):
        row, col = divmod(index, cols)
        row_spec = {'xCuts': spec['xCutsByRow'][row]} if 'xCutsByRow' in spec else spec
        xs = cuts(row_spec, 'xCuts', cols, im.width)
        rect(name, key, (xs[col], ys[row], xs[col+1], ys[row+1]),
             trim=not spec.get('opaque'), whole_cell=True)

for part in layout['parts']:
    parent = entries[part['parent']]
    left, top, right, bottom = part['bounds']
    assert 0 <= left < right <= 1 and 0 <= top < bottom <= 1, part['key']
    region = (
        parent['x']+round(parent['w']*left),
        parent['y']+round(parent['h']*top),
        parent['x']+round(parent['w']*right),
        parent['y']+round(parent['h']*bottom),
    )
    rect(parent['atlas'], part['key'], region)

content = json.loads((ROOT / 'assets' / 'content.json').read_text())
expected = {item['id'] for kind in ('modules', 'enemies', 'bosses') for item in content[kind]}
for chassis in content['chassis']:
    expected.update(f"{chassis['id']}.{part}" for part in (
        'body.0', 'body.1', 'body.2', 'body.3', 'legs', 'backpack'))
expected.update(f'floor.{i}' for i in range(1, 5))
expected.update(('B2B.left', 'B2B.right', 'B3B.left', 'B3B.right'))
assert len(entries) == 86 and set(entries) == expected, 'Sprite coverage does not match game content'
data = {
    'version': 2, 'style': layout['style'],
    'atlases': {name: f'atlases/{name}.png' for name in images},
    'sprites': entries, 'inspection': report,
}
if args.write:
    OUT.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n')
else:
    assert json.loads(OUT.read_text()) == data, 'Manifest is stale; run art-check.py --write'
print(json.dumps({'status': 'passed', 'style': layout['style'],
                  'sprites': len(entries), 'atlases': report}, ensure_ascii=False))

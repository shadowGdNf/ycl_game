"""Inspect atlas alpha and write rectangle metadata; never modifies image pixels."""
from pathlib import Path
from PIL import Image
import json, argparse

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'assets' / 'atlas-manifest.json'
parser = argparse.ArgumentParser()
parser.add_argument('--write', action='store_true')
args = parser.parse_args()
images = {name: Image.open(ROOT / 'assets' / 'atlases' / f'{name}.png') for name in ['actors', 'modules', 'enemies', 'environment']}
entries = {}
report = {}

def rect(name, key, region, trim=True):
    im = images[name]
    x, y, right, bottom = map(int, region)
    if trim:
        box = im.getchannel('A').crop((x, y, right, bottom)).point(lambda v: 255 if v > 24 else 0).getbbox()
        assert box, key
        x1, y1, x2, y2 = box
        x, y, right, bottom = max(x, x+x1-2), max(y, y+y1-2), min(right, x+x2+2), min(bottom, y+y2+2)
    assert 0 <= x < right <= im.width and 0 <= y < bottom <= im.height, key
    entries[key] = {'atlas': name, 'x': x, 'y': y, 'w': right-x, 'h': bottom-y}

chassis = ['scavenger', 'bulwark', 'kestrel', 'hive']
rows = [80, 307, 533, 795, 1003, 1224, 1480]
for row in range(6):
    for col in range(4):
        key = f'{chassis[row]}.body.{col}' if row < 4 else f'{chassis[col]}.legs' if row == 4 else f'{chassis[col]}.backpack'
        rect('actors', key, (col*256, rows[row], (col+1)*256, rows[row+1]))
module_rows = [0, 222, 425, 619, 829, 1014, 1254]
for row in range(6):
    for col in range(6):
        kind = ['W', 'S', 'U'][row//2]
        key = f'{kind}{(row%2)*6+col+1:02}'
        rect('modules', key, (col*209, module_rows[row], (col+1)*209, module_rows[row+1]))
enemy_boxes = [(54,95,241,245),(353,77,504,271),(598,34,847,280),(919,9,1124,280),(1218,56,1408,265),(1504,69,1725,266),(37,296,275,549),(331,325,561,548),(604,322,853,542),(897,325,1151,549),(1201,321,1428,549),(1470,289,1749,555)]
boss_boxes = [(13,575,303,863),(308,556,605,863),(593,572,895,861),(913,638,1155,800),(1167,573,1465,859),(1473,582,1759,840)]
for i, box in enumerate(enemy_boxes):
    rect('enemies', f'E{i+1:02}', box, False)
for key, box in zip(['B1A','B1B','B2A','B2B','B3A','B3B'], boss_boxes):
    rect('enemies', key, box, False)
for key, box in [('B2B.left',(913,638,1032,800)),('B2B.right',(1038,638,1155,800)),('B3B.left',(1473,638,1555,759)),('B3B.right',(1675,638,1759,759))]:
    rect('enemies', key, box, False)
im = images['environment']
for row in range(2):
    for col in range(2):
        rect('environment', f'floor.{row*2+col+1}', (col*im.width//2, row*im.height//2, (col+1)*im.width//2, (row+1)*im.height//2), False)
for name, im in images.items():
    path = ROOT / 'assets' / 'atlases' / f'{name}.png'
    item = {'width': im.width, 'height': im.height, 'bytes': path.stat().st_size}
    if name != 'environment':
        assert im.mode == 'RGBA', name
        hist = im.getchannel('A').histogram()
        assert hist[0]/(im.width*im.height) > .20, f'{name} background is not transparent'
        assert sum(hist[240:])/(im.width*im.height) > .10, f'{name} sprites lack opaque bodies'
        item['transparent_fraction'] = round(hist[0]/(im.width*im.height), 4)
    report[name] = item
assert len(entries) == 86
data = {'version': 1, 'atlases': {n: f'atlases/{n}.png' for n in images}, 'sprites': entries, 'inspection': report}
if args.write:
    OUT.write_text(json.dumps(data, ensure_ascii=False, indent=2))
else:
    assert json.loads(OUT.read_text()) == data, 'Manifest is stale; run art-check.py --write'
print(json.dumps({'status': 'passed', 'sprites': len(entries), 'atlases': report}, ensure_ascii=False))

#!/usr/bin/env python3
"""Recover render-only table assignments without running target Lua.

Scope: inherited sprite defaults, literal/vector arithmetic, component clone
declarations, and scene data overrides. Unknown expressions stay explicit.
"""
from __future__ import annotations

import copy
import json
import math
import re
from pathlib import Path

from mechanics_extract import LuaData, normalize, number

ROOT = Path(__file__).resolve().parent.parent
DEC = ROOT / 'analysis/mechanics-decompiled'
OUT = ROOT / 'web/data'
ASSETS = ROOT / 'web/assets'


class RenderData(LuaData):
    def primary(self):
        if self.peek() in ('vv', 'ady', 'adx', 'd2r') and self.peek(1) == '(':
            fn = self.take()
            self.take('(')
            value = self.expr()
            self.take(')')
            if fn == 'vv': return {'x': value, 'y': value}
            if fn == 'ady': return value - self.env['anchor_y'] * self.env['image_y']
            if fn == 'adx': return value - self.env['anchor_x'] * self.env['image_x']
            if fn == 'd2r': return value * math.pi / 180
        return super().primary()


def parse_expression(text, env):
    reader = RenderData(text, env)
    result = reader.expr()
    if reader.peek() in ('and', 'or'):
        raise ValueError('Conditional value requires runtime state')
    return result


def assign(target, path, value):
    for key in path[:-1]:
        if key not in target or not isinstance(target[key], dict):
            target[key] = {}
        target = target[key]
    target[path[-1]] = value


def model_tables():
    constants = {k: number(v) for k, v in re.findall(r'^([A-Z][A-Z_0-9]*) = ([0-9.]+)\s*$', (DEC / 'constants.lua').read_text(), re.M)}
    env = dict(constants)
    env.update(anchor_x=0, anchor_y=0, image_x=0, image_y=0)
    components_text = (DEC / 'scenery-components.lua').read_text()
    sprite_body = components_text.split('local sprite = E:register_c("sprite")', 1)[1].split('local render =', 1)[0]
    sprite = RenderData('local sprite = {}\n' + sprite_body + '\nreturn sprite', env).parse()
    models = {}
    register = re.compile(r'^(?:local )?(\w+) = (?:E:register_t|RT)\("([^"]+)"(?:, "([^"]+)")?[^\n]*', re.M)
    for file in (DEC / 'scenery-templates.lua', DEC / 'templates_game.lua'):
        text = file.read_text()
        matches = list(register.finditer(text))
        for index, match in enumerate(matches):
            var, name, base = match.groups()
            body = text[match.end():matches[index + 1].start() if index + 1 < len(matches) else len(text)]
            parent = models.get(base, {})
            model = copy.deepcopy(parent)
            model.update(id=name, base=base, source={'file': str(file.relative_to(ROOT)), 'line': text[:match.start()].count('\n') + 1})
            model.setdefault('data', {})
            model.setdefault('components', [])
            model.setdefault('unknowns', [])
            for c in re.finditer(r'(?:E:add_comps|AC)\(' + re.escape(var) + r',([^\)]*)\)', body):
                for comp in re.findall(r'"([^"]+)"', c[1]):
                    if comp not in model['components']: model['components'].append(comp)
                    if comp == 'render' and 'render' not in model['data']:
                        model['data']['render'] = {'sprites': {1: copy.deepcopy(sprite)}}
                    if comp == 'pos' and 'pos' not in model['data']:
                        model['data']['pos'] = {'x': 0, 'y': 0}
            current_env = dict(env)
            current_env[var] = model['data']
            current_env['tt'] = model['data']
            pattern = re.compile(r'^(?:local )?(' + re.escape(var) + r'\.(?:render(?:\.\w+|\[[^\]\n]+\])*|pos(?:\.\w+)?|flight_height)|anchor_[xy]|image_[xy])\s*=\s*', re.M)
            for assignment in pattern.finditer(body):
                lhs = assignment[1]
                rhs = body[assignment.end():]
                first_line = rhs.splitlines()[0]
                try:
                    if lhs.startswith(var + '.'):
                        path = RenderData(lhs, current_env).path()[1:]
                        if first_line in ('E:clone_c("sprite")', 'CC("sprite")'):
                            value = copy.deepcopy(sprite)
                        else:
                            value = parse_expression(rhs, current_env)
                        assign(model['data'], path, value)
                    else:
                        value = parse_expression(rhs, current_env)
                        current_env[lhs] = value
                        env[lhs] = value
                except (ValueError, KeyError, TypeError, IndexError, AttributeError) as error:
                    model['unknowns'].append({'field': lhs, 'expression': first_line, 'reason': str(error)[:160], 'source': model['source']})
            models[name] = model
    return sprite, models, constants


def as_layers(model):
    data = model.get('data', {})
    render = data.get('render') or {}
    sprites = render.get('sprites') or {}
    result = []
    for key in sorted(sprites):
        value = sprites[key]
        if not isinstance(value, dict): continue
        layer = {'index': key}
        for field in ('prefix', 'name', 'animated', 'exo', 'pos', 'offset', 'anchor', 'scale', 'z', 'sort_y', 'sort_y_offset', 'draw_order', 'hidden', 'alpha', 'r', 'flip_x', 'flip_y', 'loop', 'angles', 'angles_custom', 'angles_stickiness', 'angles_flip_horizontal', 'angles_flip_vertical', 'frame_idx', 'time_offset'):
            layer[field] = normalize(value.get(field))
        layer['spriteScale'] = layer['scale'] or {'x': 1, 'y': 1}
        layer['refScale'] = 0.5
        layer['sortY'] = layer.pop('sort_y')
        layer['sortYOffset'] = layer.pop('sort_y_offset')
        layer['drawOrder'] = layer.pop('draw_order')
        layer['flipX'] = bool(layer.pop('flip_x'))
        layer['flipY'] = bool(layer.pop('flip_y'))
        result.append(layer)
    return result


def main():
    sprite, models, constants = model_tables()
    mechanics = json.loads((OUT / 'mechanics.json').read_text())
    raw = json.loads((OUT / 'mechanics-raw-levels.json').read_text())
    atlas_frames = {}
    for p in sorted((ASSETS / 'atlases').glob('*.json')):
        atlas = json.loads(p.read_text())
        for name, frame in atlas['frames'].items():
            atlas_frames[name] = {'atlas': atlas['name'], **frame}
    all_render_models = {}
    wanted = {f'tower_{kind}_lvl{i}' for kind in ('archers', 'knights', 'wizard', 'catapult') for i in range(1, 5)}
    wanted.update({'hero_gerald', 'soldier_knight', 'soldier_militia', 'soldier_reinforcement_base', 'soldier_reinforcement_special'})
    wanted.update(f'soldier_knights_lvl{i}' for i in range(1, 5))
    wanted.update(mechanics['enemies'])
    wanted.update(name for name in models if name.startswith('tower_holder'))
    for name in sorted(wanted):
        if name not in models:
            all_render_models[name] = {'unknown': 'Template not found in inspected modules'}
            continue
        m = models[name]
        all_render_models[name] = {'id': name, 'base': m['base'], 'pos': m['data'].get('pos'), 'layers': as_layers(m), 'unknowns': m['unknowns'], 'source': m['source']}
    render_output = {'schemaVersion': 1, 'coordinateSystem': {'width': 1024, 'height': 768, 'yAxis': 'up'}, 'refScale': 0.5, 'defaults': sprite, 'models': all_render_models, 'notes': ['scale/spriteScale are entity sprite multipliers. refScale=0.5 applies to ordinary atlas frames, not to an exoskeleton as a whole.', 'For exoskeletons use source partScaleCompensation and part pivots through the separately recovered exo renderer.', 'pos=null means use entity.pos; offset is in reference-world coordinates with Y up.', 'frame_idx=1, hidden and animation names are initial template state and may change at runtime.']}
    scenery = {'schemaVersion': 1, 'coordinateSystem': {'width': 1024, 'height': 768, 'yAxis': 'up'}, 'textureRefScale': 0.5, 'levels': {}, 'renderFormula': {'x': 'pos.x + offset.x', 'y': '768 - (pos.y + offset.y)', 'originX': 'anchor.x * atlasFrame.size[0] - atlasFrame.trim[0]', 'originY': '(1 - anchor.y) * atlasFrame.size[1] - atlasFrame.trim[1]', 'ordinaryFrameScale': '0.5 * (sprite.scale or 1)'}, 'limitations': ['Only campaign entities (editor.game_mode 0 or 1).', 'decorations contains nonanimated sprites on entities without main_script, timed, tween or events components.', 'Pure visual animation loops without script components are retained separately as ambientAnimations.', 'Scripted nightfall background is included as a hidden background descriptor only; its transition logic is not implemented.']}
    validation = []
    def scene_record(e, m, layer):
        pos = layer.get('pos') or e.get('pos') or m['data'].get('pos')
        if pos is None: return None
        offs = layer.get('offset') or {'x': 0, 'y': 0}
        ss = layer.get('spriteScale') or {'x': 1, 'y': 1}
        exo = layer.get('prefix') if layer.get('exo') else None
        rec = {'template': e['template'], 'spriteIndex': layer['index'], 'x': pos['x'], 'y': pos['y'], 'offset': offs, 'anchor': layer.get('anchor'), 'spriteScale': ss, 'scale': ss if exo else {'x': 0.5 * ss['x'], 'y': 0.5 * ss['y']}, 'refScale': 0.5, 'z': layer.get('z'), 'sortY': layer.get('sortY'), 'sortYOffset': layer.get('sortYOffset'), 'drawOrder': layer.get('drawOrder'), 'rotation': layer.get('r') or 0, 'flipX': layer['flipX'], 'flipY': layer['flipY'], 'hidden': bool(layer.get('hidden')), 'alpha': layer.get('alpha'), 'source': m['source']}
        if exo:
            rec.update(exo=exo, animation=layer.get('name'), loop=layer.get('loop'))
        elif layer.get('animated'):
            rec.update(prefix=layer.get('prefix'), animation=layer.get('name'), loop=layer.get('loop'))
        else:
            rec['frame'] = layer.get('name')
            if rec['frame'] in atlas_frames:
                frame = atlas_frames[rec['frame']]
                rec.update(atlas=frame['atlas'], image=frame['image'], rect=frame['rect'], size=frame['size'], trim=frame['trim'])
                if not rec['rotation'] and not rec['flipX'] and not rec['flipY']:
                    ax, ay = rec['anchor']['x'], rec['anchor']['y']
                    sx, sy = rec['scale']['x'], rec['scale']['y']
                    rec['drawRect'] = {'x': pos['x'] + offs['x'] - (ax * frame['size'][0] - frame['trim'][0]) * sx, 'y': 768 - (pos['y'] + offs['y']) - ((1 - ay) * frame['size'][1] - frame['trim'][1]) * sy, 'width': frame['rect'][2] * sx, 'height': frame['rect'][3] * sy}
            else:
                rec['unknown'] = 'Static frame not found in currently exported atlas index'
        return rec
    for lid, info in raw.items():
        output = {'backgrounds': [], 'decorations': [], 'ambientAnimations': [], 'excluded': []}
        for e in info['data']['entities_list']:
            if not e['template'].startswith('decal_'): continue
            if e.get('editor.game_mode', 0) not in (0, 1): continue
            if e['template'] not in models:
                output['excluded'].append({'template': e['template'], 'reason': 'Template unavailable'})
                continue
            model = copy.deepcopy(models[e['template']])
            for key, value in e.items():
                if key.startswith('render.') or key == 'pos':
                    assign(model['data'], RenderData(key, {}).path(), value)
            layers = as_layers(model)
            is_background = e['template'] in ('decal_background', 'decal_stage_18_nightfall')
            forbidden = set(model['components']) & {'main_script', 'timed', 'tween', 'events'}
            if forbidden and not is_background:
                output['excluded'].append({'template': e['template'], 'reason': 'Runtime component: ' + ', '.join(sorted(forbidden))})
                continue
            for layer in layers:
                record = scene_record(e, model, layer)
                if record is None: continue
                if is_background:
                    record['phase'] = 'nightfall' if e['template'] == 'decal_stage_18_nightfall' else 'initial'
                    output['backgrounds'].append(record)
                elif layer['animated']:
                    output['ambientAnimations'].append(record)
                else:
                    output['decorations'].append(record)
        scenery['levels'][lid] = output
        for b in output['backgrounds']:
            validation.append({'level': int(lid), 'frame': b.get('frame'), 'hidden': b['hidden'], 'drawRect': b.get('drawRect')})
    (OUT / 'render-models.json').write_text(json.dumps(render_output, ensure_ascii=False, separators=(',', ':')) + '\n')
    (OUT / 'scenery.json').write_text(json.dumps(scenery, ensure_ascii=False, separators=(',', ':')) + '\n')
    summary = {'models': len(all_render_models), 'levels': len(scenery['levels']), 'staticDecorations': sum(len(l['decorations']) for l in scenery['levels'].values()), 'ambientAnimations': sum(len(l['ambientAnimations']) for l in scenery['levels'].values()), 'backgrounds': validation, 'unknownModels': {k: v['unknowns'] for k, v in all_render_models.items() if v.get('unknowns')}}
    (ROOT / 'analysis/mechanics-render-validation.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2))
    print(json.dumps({k: v for k, v in summary.items() if k != 'unknownModels'}, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()

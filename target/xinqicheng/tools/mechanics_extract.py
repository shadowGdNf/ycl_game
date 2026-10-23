#!/usr/bin/env python3
"""Statically recover shipped KR6 data. Never executes Lua or the target APK.

Input: REA-extracted APK assets, plus LJD's decompiled literal data files.
The tiny Lua reader accepts only literals, field references, arithmetic, and
four reviewed pure balance helpers; it is intentionally not a Lua interpreter.
"""
from __future__ import annotations

import argparse
import copy
import hashlib
import json
import math
import re
from collections import Counter
from pathlib import Path


TOKEN = re.compile(r'\s+|--\[\[.*?\]\]|--[^\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?|[A-Za-z_]\w*|\.\.|.', re.S)


def lua_string(s):
    def replacement(m):
        e = m.group(1)
        if e.isdigit():
            return chr(int(e))
        if e.startswith('x'):
            return chr(int(e[1:], 16))
        return {'n': '\n', 'r': '\r', 't': '\t', 'a': '\a', 'b': '\b', 'f': '\f', 'v': '\v', '\n': '\n'}.get(e, e)
    return re.sub(r'\\(\d{1,3}|x[0-9a-fA-F]{2}|.)', replacement, s[1:-1], flags=re.S)


def normalize(value):
    if isinstance(value, dict):
        if value and all(isinstance(k, int) and k > 0 for k in value) and max(value) <= max(50, len(value) * 3):
            return [normalize(value.get(i)) for i in range(1, max(value) + 1)]
        return {str(k): normalize(v) for k, v in value.items()}
    if isinstance(value, list):
        return [normalize(v) for v in value]
    return value


class LuaData:
    def __init__(self, source, environment=None):
        self.t = [m.group() for m in TOKEN.finditer(source) if not m.group().isspace() and not m.group().startswith('--')]
        self.i = 0
        self.env = environment if environment is not None else {}

    def peek(self, offset=0):
        return self.t[self.i + offset] if self.i + offset < len(self.t) else '<EOF>'

    def take(self, token=None):
        v = self.peek()
        if token is not None and v != token:
            raise ValueError(f'Expected {token}, found {v} near {self.t[max(0,self.i-5):self.i+12]}')
        self.i += 1
        return v

    def path(self):
        result = [self.take()]
        while self.peek() in ('.', '['):
            if self.take() == '.':
                result.append(self.take())
            else:
                result.append(self.expr())
                self.take(']')
        return result

    def resolve(self, path):
        if len(path) == 1 and path[0] not in self.env and re.fullmatch('[A-Z][A-Z_0-9]*', path[0]):
            return path[0]
        v = self.env
        for key in path:
            v = v[key]
        return copy.deepcopy(v)

    def table(self):
        self.take('{')
        result = {}
        index = 1
        while self.peek() != '}':
            if self.peek() == '[':
                self.take('[')
                key = self.expr()
                self.take(']')
                self.take('=')
            elif re.fullmatch('[A-Za-z_]\w*', self.peek()) and self.peek(1) == '=':
                key = self.take()
                self.take('=')
            else:
                key = index
                index += 1
            result[key] = self.expr()
            if self.peek() in (',', ';'):
                self.take()
            elif self.peek() != '}':
                raise ValueError(f'Expected comma, found {self.peek()} at {self.i}')
        self.take('}')
        return result

    def primary(self):
        v = self.peek()
        if v == '{':
            return self.table()
        if v == '-':
            self.take()
            return -self.primary()
        if v == '(':
            self.take()
            x = self.expr()
            self.take(')')
            return x
        if v[0] in ('"', "'"):
            return lua_string(self.take())
        if re.fullmatch(r'(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?', v):
            self.take()
            n = float(v)
            return int(n) if n.is_integer() else n
        if v in ('true', 'false', 'nil'):
            self.take()
            return {'true': True, 'false': False, 'nil': None}[v]
        path = self.path()
        if self.peek() != '(':
            return self.resolve(path)
        self.take('(')
        args = []
        while self.peek() != ')':
            args.append(self.expr())
            if self.peek() == ',':
                self.take()
            else:
                break
        self.take(')')
        name = '.'.join(path)
        if name == 'fts':
            return args[0] / self.env['FPS']
        if name == 'v':
            return dict(zip(('x', 'y'), args))
        if name in ('sub_one', 'slow_calc'):
            f = (lambda n: n - 1) if name == 'sub_one' else (lambda n: 1 - n)
            return {k: f(v) for k, v in args[0].items()} if isinstance(args[0], dict) else f(args[0])
        raise ValueError(f'Call outside reviewed pure-data allowlist: {name}')

    def expr(self, precedence=0):
        left = self.primary()
        levels = {'..': 1, '+': 2, '-': 2, '*': 3, '/': 3, '^': 4}
        while self.peek() in levels and levels[self.peek()] >= precedence:
            op = self.take()
            right = self.expr(levels[op] + (0 if op == '^' else 1))
            if op == '+': left += right
            elif op == '-': left -= right
            elif op == '*': left *= right
            elif op == '/': left /= right
            elif op == '^': left **= right
            elif op == '..': left = str(left) + str(right)
        return left

    def parse(self):
        while self.peek() != '<EOF>':
            if self.peek() == 'return':
                self.take()
                result = self.expr()
                if self.peek() != '<EOF>':
                    raise ValueError('Unexpected code after data return')
                return normalize(result)
            if self.peek() == 'local':
                self.take()
            path = self.path()
            self.take('=')
            val = self.expr()
            target = self.env
            for key in path[:-1]:
                target = target[key]
            target[path[-1]] = val
        raise ValueError('No data return')


def number(s, default=0):
    try:
        n = float(s)
        return int(n) if n.is_integer() else n
    except (ValueError, TypeError):
        return default


def parse_waves(file):
    """Preserve raw TSV commands and produce deterministic ordinary-wave spawns.

    Explicit lane '*' is retained as lane 0 (original engine selects a lane).
    Manual waves are kept separately because they are triggered by level scripts.
    """
    meta = {}
    waves = []
    manual = []
    raw = []
    current = None
    columns = {}
    inc_col = None
    elapsed = 0
    flags = {}
    for line_number, line in enumerate(file.read_text().splitlines(), 1):
        row = line.split('\t')
        if not row or row[0].strip():
            continue
        row += [''] * max(0, (max(columns, default=9) + 1 - len(row)))
        cmd = row[1].strip() if len(row) > 1 else ''
        if cmd == 'column_names':
            inc_col = row.index('inc')
            columns = {i: value for i, value in enumerate(row) if re.fullmatch(r'\d+:(?:\*|\d+)', value)}
            meta['columnNames'] = {str(i): v for i, v in columns.items()}
            continue
        if inc_col is None:
            continue
        row += [''] * max(0, (inc_col + 1 - len(row)))
        if not any(row):
            continue
        inc = number(row[inc_col], None)
        mapped = {columns[i]: row[i].strip() for i in columns if i < len(row) and row[i].strip()}
        raw.append({'line': line_number, 'command': cmd, 'increment': inc, 'parameters': row[2:inc_col], 'mapped': mapped})
        if cmd in ('description', 'lives', 'gold', 'gems', 'enemy_prefix', 'default_increment', 'default_interval'):
            meta[cmd] = number(row[2], row[2])
            continue
        if cmd in ('wave', 'manual_wave'):
            elapsed = 0
            current = {'id': int(row[3]) if cmd == 'wave' and row[3].strip().isdigit() else row[2], 'interval': inc if inc is not None else meta.get('default_interval', 20), 'spawns': [], 'events': [], 'sourceLine': line_number}
            if cmd == 'wave': waves.append(current)
            else: manual.append(current)
            continue
        if current is None:
            continue
        if cmd == 'flags':
            flags = mapped
            current['events'].append({'time': round(elapsed, 6), 'command': cmd, 'mapped': mapped, 'sourceLine': line_number})
            continue
        if cmd in ('signal', 'event', 'wait', 'wait_signal', 'manual_wave_repeat'):
            elapsed += max(0, inc if inc is not None else meta.get('default_increment', 1))
            current['events'].append({'time': round(elapsed, 6), 'command': cmd, 'parameters': row[2:inc_col], 'increment': inc, 'sourceLine': line_number})
            continue
        if cmd:
            current['events'].append({'time': round(elapsed, 6), 'command': cmd, 'parameters': row[2:inc_col], 'sourceLine': line_number})
            continue
        if mapped or inc is not None:
            elapsed += max(0, inc if inc is not None else meta.get('default_increment', 1))
            for key, enemy in mapped.items():
                path, lane = key.split(':')
                current['spawns'].append({'time': round(elapsed, 6), 'enemy': enemy if enemy.startswith(meta.get('enemy_prefix', 'enemy_')) else meta.get('enemy_prefix', 'enemy_') + enemy, 'path': int(path), 'lane': int(lane) if lane != '*' else 0, 'flags': flags.get(key, ''), 'sourceLine': line_number})
    for wave in waves + manual:
        wave['duration'] = max([s['time'] for s in wave['spawns']] + [e['time'] for e in wave['events']] + [0])
        wave['enemyCount'] = len(wave['spawns'])
    return {'metadata': meta, 'waves': waves, 'manualWaves': manual, 'records': raw}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def extract_template_metadata(text):
    matches = list(re.finditer(r'^tt = (?:E:register_t|RT)\("([^"]+)"(?:, "([^"]+)")?\)', text, re.M))
    templates = {}
    for i, match in enumerate(matches):
        body = text[match.end():matches[i + 1].start() if i + 1 < len(matches) else len(text)]
        name, base = match.groups()
        b = re.search(r'^b = balance\.([^\n]+)', body, re.M)
        prefixes = {int(m.group(1)): m.group(2) for m in re.finditer(r'tt\.render\.sprites\[(\d+)\]\.prefix = "([^"]+)"', body)}
        names = {int(m.group(1)): m.group(2) for m in re.finditer(r'tt\.render\.sprites\[(\d+)\]\.name = "([^"]+)"', body)}
        animations = sorted(set(re.findall(r'\.animation = "([^"]+)"', body)))
        key = re.search(r'tt\.info\.i18n_key = "([^"]+)"', body)
        flying = bool(re.search(r'tt\.vis\.flags = [^\n]*F_FLYING', body))
        templates[name] = {'id': name, 'base': base, 'balancePath': b.group(1) if b else None, 'spritePrefixes': prefixes, 'spriteNames': names, 'animations': animations, 'i18nKey': key.group(1) if key else None, 'flying': flying, 'sourceLine': text[:match.start()].count('\n') + 1}
    def inherit(name, trail=()):
        value = templates[name]
        if value.get('_resolved'):
            return value
        if value['base'] in templates and value['base'] not in trail:
            base = inherit(value['base'], trail + (name,))
            value['spritePrefixes'] = {**base['spritePrefixes'], **value['spritePrefixes']}
            value['spriteNames'] = {**base['spriteNames'], **value['spriteNames']}
            value['animations'] = sorted(set(base['animations'] + value['animations']))
            value['balancePath'] = value['balancePath'] or base['balancePath']
            value['i18nKey'] = value['i18nKey'] or base['i18nKey']
            value['flying'] = value['flying'] or base['flying']
        value['_resolved'] = True
        return value
    for name in templates:
        inherit(name)
    for value in templates.values():
        value.pop('_resolved', None)
    return templates


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--assets', type=Path, required=True)
    ap.add_argument('--decompiled', type=Path, default=Path('target/xinqicheng/analysis/mechanics-decompiled'))
    ap.add_argument('--out', type=Path, default=Path('target/xinqicheng/web/data'))
    args = ap.parse_args()
    out = args.out
    out.mkdir(parents=True, exist_ok=True)
    source_manifest = []
    def read_data(name, original=None):
        p = args.decompiled / name
        source_manifest.append({'source': original or name, 'decompiledSha256': digest(p), 'originalSha256': digest(args.assets / 'gc32' / original) if original else None})
        return LuaData(p.read_text()).parse()
    constants = {key: number(val) for key, val in re.findall(r'^([A-Z][A-Z_0-9]*) = ([0-9.]+)\s*$', (args.decompiled / 'constants.lua').read_text(), re.M)}
    btext = (args.decompiled / 'balance.lua').read_text()
    btext = btext[btext.index('local b ='):]
    balance = LuaData(btext, dict(constants)).parse()
    strings_file = args.assets / 'kr6-phone/strings/zh-Hans.lua'
    strings = LuaData(strings_file.read_text()).parse()
    templates = extract_template_metadata((args.decompiled / 'templates_game.lua').read_text())
    def find_stats(t):
        value = balance
        for k in (t.get('balancePath') or '').split('.'):
            if not isinstance(value, dict) or k not in value:
                return {}
            value = value[k]
        return copy.deepcopy(value)
    enemies = {}
    for name, template in templates.items():
        if not name.startswith('enemy_'): continue
        enemies[name] = {**template, 'name': strings.get(name.upper() + '_NAME', name), 'description': strings.get(name.upper() + '_DESCRIPTION', ''), 'stats': find_stats(template), 'spritePrefix': template['spritePrefixes'].get(1)}
    towers = {}
    for name, stats in balance['towers'].items():
        if name in ('common', 'upgrades'): continue
        levels = []
        for level in range(1, 5):
            key = f'tower_{name}_lvl{level}'
            t = templates.get(key, {})
            levels.append({**t, 'level': level, 'name': strings.get((t.get('i18nKey') or f'TOWER_{name.upper()}_{level}') + '_NAME', key)})
        towers[name] = {'id': name, 'stats': stats, 'levels': levels, 'name': levels[0]['name']}
    levels = []
    raw_levels = {}
    all_waves = {}
    extra_modes = {}
    for i in range(1, 19):
        name = f'level{i:02d}'
        data = read_data(name + '_data.lua', f'kr6/data/levels/{name}_data.lua')
        paths = read_data(name + '_paths.lua', f'kr6/data/levels/{name}_paths.lua')
        wfile = args.assets / 'gc32/kr6/data/waves' / (name + '_waves_campaign.tsv')
        wave_data = parse_waves(wfile)
        source_manifest.append({'source': str(wfile.relative_to(args.assets)), 'originalSha256': digest(wfile)})
        raw_levels[str(i)] = {'data': data, 'paths': paths}
        all_waves[str(i)] = wave_data
        entities = data['entities_list']
        slots = []
        special_towers = []
        for e in entities:
            if 'tower.holder_id' in e and e.get('editor.game_mode', 0) in (0, 1):
                if e['template'].startswith('tower_stage_'):
                    special_towers.append(e)
                    continue
                slots.append({'id': str(e['tower.holder_id']), **e['pos'], 'rally': e.get('tower.default_rally_pos'), 'template': e['template'], 'mode': e.get('editor.game_mode', 0), 'terrain': e.get('tower.terrain_style'), 'blocked': 'holder_blocked' in e['template'], 'existingTower': e['template'] if not e['template'].startswith('tower_holder') else None})
        l = {'id': i, 'name': strings.get(f'LEVEL_{i}_TITLE', name), 'history': strings.get(f'LEVEL_{i}_HISTORY', ''), 'width': constants['REF_W'], 'height': constants['REF_H'], 'lives': wave_data['metadata'].get('lives', 20), 'gold': wave_data['metadata'].get('gold', 0), 'paths': [], 'towerSlots': slots, 'waves': wave_data['waves'], 'manualWaves': wave_data['manualWaves'], 'background': next((e.get('render.sprites[1].name') for e in entities if e['template'] == 'decal_background'), None), 'lockedTowers': data.get('locked_towers', []), 'spawnFlags': [e for e in entities if e['template'] == 'editor_wave_flag'], 'exitFlags': [e for e in entities if e['template'].startswith('decal_defend_point')], 'requiredTextures': data.get('required_textures', [])}
        l['specialTowers'] = special_towers
        l['invalidPathRanges'] = data.get('invalid_path_ranges', [])
        l['pathConnections'] = paths.get('connections', {})
        for pi, lanes in enumerate(paths['paths'], 1):
            l['paths'].append({'id': pi, 'points': lanes[0], 'lanes': lanes, 'active': paths.get('active', [True] * len(paths['paths']))[pi - 1], 'widths': paths.get('curves', [{}] * len(paths['paths']))[pi - 1].get('widths', [])})
        levels.append(l)
        extra_modes[str(i)] = {}
        for file in sorted(wfile.parent.glob(name + '_waves_*.tsv')):
            mode = file.stem[len(name) + len('_waves_'):]
            if mode != 'campaign':
                extra_modes[str(i)][mode] = parse_waves(file)
                source_manifest.append({'source': str(file.relative_to(args.assets)), 'originalSha256': digest(file)})
    source_manifest.extend([{'source': 'gc32/kr6/data/balance/balance.lua', 'originalSha256': digest(args.assets / 'gc32/kr6/data/balance/balance.lua'), 'decompiledSha256': digest(args.decompiled / 'balance.lua')}, {'source': 'kr6-phone/strings/zh-Hans.lua', 'originalSha256': digest(strings_file)}, {'source': 'gc32/kr6/templates_game.lua', 'originalSha256': digest(args.assets / 'gc32/kr6/templates_game.lua'), 'decompiledSha256': digest(args.decompiled / 'templates_game.lua')}])
    for rel, recovered in [('all/constants.lua', 'constants.lua'), ('all/wave_db.lua', 'wave_db.asm')]:
        entry = {'source': 'gc32/' + rel, 'originalSha256': digest(args.assets / 'gc32' / rel)}
        if (args.decompiled / recovered).exists():
            entry['recoveredFile'] = recovered
            entry['recoveredSha256'] = digest(args.decompiled / recovered)
        source_manifest.append(entry)
    dataset = {'schemaVersion': 1, 'evidenceId': 'ev_7c9409fed63b7b60b8519f5cecbce132705764a8062875b0418b6b27011be627', 'coordinateSystem': {'width': constants['REF_W'], 'height': constants['REF_H'], 'yAxis': 'up', 'note': 'Canvas y = 768 - source y. Spawn paths can extend beyond the reference rectangle.'}, 'difficultyOrder': ['easy', 'normal', 'hard', 'impossible'], 'levels': levels, 'enemies': enemies, 'towers': towers, 'heroes': balance.get('heroes', {}), 'powers': balance.get('powers', {}), 'limitations': ['Static recovery; no APK or extracted target code was executed.', 'Regular wave schedules are flattened; manual waves, wait_signal and event commands require level-script integration.', 'Combat values are preserved; special attacks and boss scripts are not automatically reimplemented by this dataset.', 'Sprite prefixes reference the shipped animation/atlas metadata; many towers use multipart .exo3 skeletal animation.']}
    summary = {'levels': len(levels), 'regularWaves': sum(len(x['waves']) for x in levels), 'manualWaveGroups': sum(len(x['manualWaves']) for x in levels), 'regularSpawns': sum(len(w['spawns']) for x in levels for w in x['waves']), 'towerSlots': sum(len(x['towerSlots']) for x in levels), 'enemyTemplates': len(enemies), 'towerTypes': len(towers), 'levelsSummary': [{'id': x['id'], 'name': x['name'], 'lives': x['lives'], 'gold': x['gold'], 'paths': len(x['paths']), 'slots': len(x['towerSlots']), 'waves': len(x['waves']), 'spawns': sum(len(w['spawns']) for w in x['waves'])} for x in levels]}
    for name, value in [('mechanics.json', dataset), ('levels.json', levels), ('balance.json', balance), ('strings-zh-Hans.json', strings), ('mechanics-raw-levels.json', raw_levels), ('mechanics-raw-waves.json', all_waves), ('mechanics-extra-modes.json', extra_modes), ('mechanics-template-metadata.json', templates), ('mechanics-source-manifest.json', source_manifest), ('mechanics-summary.json', summary)]:
        (out / name).write_text(json.dumps(value, ensure_ascii=False, separators=(',', ':')) + '\n')
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()

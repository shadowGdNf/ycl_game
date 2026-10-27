import { BOSS_BY_ID, ENEMY_BY_ID, WAVES } from "./content.js";
import { nextRandom } from "./random.js";
export const ARENA = { width: 1600, height: 1200 };
const layouts = [
    [{ x: 320, y: 240, w: 180, h: 100 }, { x: 1100, y: 860, w: 180, h: 100 }, { x: 1100, y: 240, w: 100, h: 160 }, { x: 400, y: 830, w: 100, h: 170 }],
    [{ x: 320, y: 330, w: 120, h: 270 }, { x: 1160, y: 600, w: 120, h: 270 }, { x: 700, y: 160, w: 200, h: 90 }, { x: 700, y: 950, w: 200, h: 90 }],
    [{ x: 280, y: 260, w: 240, h: 100 }, { x: 1080, y: 260, w: 240, h: 100 }, { x: 280, y: 840, w: 240, h: 100 }, { x: 1080, y: 840, w: 240, h: 100 }],
    [{ x: 430, y: 270, w: 110, h: 180 }, { x: 1060, y: 750, w: 110, h: 180 }, { x: 1060, y: 270, w: 110, h: 180 }, { x: 430, y: 750, w: 110, h: 180 }],
];
const factoryLayouts = [
    [{ x: 260, y: 200, w: 120, h: 600 }, { x: 1220, y: 400, w: 120, h: 600 }, { x: 600, y: 200, w: 400, h: 100 }, { x: 600, y: 900, w: 400, h: 100 }],
    [{ x: 280, y: 270, w: 340, h: 110 }, { x: 980, y: 820, w: 340, h: 110 }, { x: 1120, y: 270, w: 140, h: 280 }, { x: 340, y: 650, w: 140, h: 280 }],
    [{ x: 420, y: 440, w: 180, h: 260 }, { x: 1000, y: 440, w: 180, h: 260 }, { x: 650, y: 170, w: 300, h: 90 }, { x: 650, y: 950, w: 300, h: 90 }],
    [{ x: 260, y: 300, w: 260, h: 130 }, { x: 1080, y: 300, w: 260, h: 130 }, { x: 380, y: 820, w: 220, h: 140 }, { x: 1000, y: 820, w: 220, h: 140 }],
];
const portLayouts = [
    [{ x: 300, y: 200, w: 250, h: 150 }, { x: 1050, y: 200, w: 250, h: 150 }, { x: 300, y: 850, w: 250, h: 150 }, { x: 1050, y: 850, w: 250, h: 150 }],
    [{ x: 270, y: 330, w: 350, h: 80 }, { x: 980, y: 330, w: 350, h: 80 }, { x: 270, y: 790, w: 350, h: 80 }, { x: 980, y: 790, w: 350, h: 80 }],
    [{ x: 300, y: 220, w: 150, h: 150 }, { x: 1150, y: 220, w: 150, h: 150 }, { x: 300, y: 830, w: 150, h: 150 }, { x: 1150, y: 830, w: 150, h: 150 }, { x: 700, y: 170, w: 200, h: 80 }, { x: 700, y: 950, w: 200, h: 80 }],
    [{ x: 650, y: 180, w: 300, h: 110 }, { x: 650, y: 910, w: 300, h: 110 }, { x: 300, y: 490, w: 190, h: 210 }, { x: 1110, y: 490, w: 190, h: 210 }],
];
export function createEncounter(run) {
    const wave = WAVES.find(w => w.n === run.wave);
    if (!wave)
        throw new Error(`Unknown wave ${run.wave}`);
    const [, v] = nextRandom((run.rng.map ^ Math.imul(run.wave, 2654435761)) >>> 0);
    const variant = Math.floor(v * 4), risk = run.route === 1 || Number(run.extra?.eventBudgetBonus || 0) > 0;
    const difficultyBudget = [1, 1.05, 1.05, 1.10, 1.15][Math.min(4, Math.max(0, run.difficulty))];
    const budget = Math.ceil(wave.budget * difficultyBudget * (risk ? 1.15 : 1));
    const extraElite = run.route === 2 || Boolean(run.extra?.eventExtraElite);
    let boss;
    if (wave.kind === 'boss') {
        boss = run.mode === 'full' ? (run.bosses[wave.act - 1] || `B${wave.act}A`) : `B${wave.act}A`;
        if (!BOSS_BY_ID[boss])
            boss = `B${wave.act}A`;
    }
    return { state: { mode: run.mode, budget, spent: 0, nextSpawn: 0, extraElite, eliteQueued: false, wave: { ...wave }, variant },
        obstacles: boss ? [] : [layouts, factoryLayouts, portLayouts][wave.act - 1][variant].map(r => ({ ...r })), ...(boss ? { boss } : {}) };
}
export function availableBudget(enc, time) {
    const p = Math.max(0, Math.min(1, time / enc.wave.duration));
    const fraction = p < .25 ? p * .8 : p < .75 ? .2 + (p - .25) : .7 + (p - .75) * 1.2;
    return Math.max(0, Math.floor(enc.budget * fraction + .000001) - enc.spent);
}
export function enemyPool(wave, mode) {
    const ids = wave === 1 ? ['E01', 'E02'] : wave === 2 ? ['E01', 'E02', 'E04'] :
        wave <= 4 ? ['E01', 'E02', 'E03', 'E04', 'E05'] : wave <= 6 ? ['E01', 'E02', 'E03', 'E04', 'E05', 'E06', 'E07'] :
            wave <= 8 ? ['E01', 'E02', 'E03', 'E04', 'E05', 'E06', 'E07', 'E08', 'E09'] :
                ['E01', 'E02', 'E03', 'E04', 'E05', 'E06', 'E07', 'E08', 'E09', 'E10', 'E11', 'E12'];
    return ids.filter(id => mode === 'full' || Number(id.slice(1)) <= (mode === 'prototype' ? 5 : 6));
}
export function chooseEnemy(enc, allowance, random) {
    const pool = enemyPool(enc.wave.n, enc.mode).filter(id => ENEMY_BY_ID[id].cost <= allowance);
    if (!pool.length)
        return undefined;
    const weights = pool.map(id => {
        const e = ENEMY_BY_ID[id], act = enc.wave.act;
        const group = id === 'E01' || id === 'E02' ? 'chase' : id === 'E04' || id === 'E11' ? 'ranged' : id === 'E06' || id === 'E09' ? 'support' : 'heavy';
        const weight = ({ chase: [.65, .4, .3], ranged: [.2, .25, .25], support: [0, .2, .2], heavy: [.15, .15, .25] }[group])[act - 1];
        return Math.max(.01, weight) / e.cost;
    });
    let at = random * weights.reduce((a, b) => a + b, 0);
    for (let i = 0; i < pool.length; i++) {
        at -= weights[i];
        if (at <= 0)
            return pool[i];
    }
    return pool[pool.length - 1];
}
export function insideArena(p, r, width = ARENA.width, height = ARENA.height) {
    return p.x >= r && p.y >= r && p.x <= width - r && p.y <= height - r;
}
export function circleHitsRect(p, r, b) {
    const x = Math.max(b.x, Math.min(p.x, b.x + b.w)), y = Math.max(b.y, Math.min(p.y, b.y + b.h));
    return (p.x - x) ** 2 + (p.y - y) ** 2 < r * r;
}
export function traversable(p, r, obstacles, width = ARENA.width, height = ARENA.height) {
    return insideArena(p, r, width, height) && !obstacles.some(b => circleHitsRect(p, r, b));
}
/** Shared navigation service; AI never changes collision rules. Paths are plain JSON. */
export function findPath(start, end, obstacles, radius, width = 1600, height = 1200) {
    if (!obstacles.length)
        return [{ ...end }];
    const size = 50, cols = Math.ceil(width / size), rows = Math.ceil(height / size);
    const toCell = (p) => Math.min(rows - 1, Math.max(0, Math.floor(p.y / size))) * cols + Math.min(cols - 1, Math.max(0, Math.floor(p.x / size)));
    const center = (i) => ({ x: (i % cols + .5) * size, y: (Math.floor(i / cols) + .5) * size });
    const a = toCell(start), target = toCell(end), queue = [a], prev = { [a]: -1 };
    let head = 0, best = a, bestD = Infinity;
    while (head < queue.length) {
        const here = queue[head++], p = center(here), d = (p.x - end.x) ** 2 + (p.y - end.y) ** 2;
        if (d < bestD) {
            best = here;
            bestD = d;
        }
        if (here === target) {
            best = here;
            break;
        }
        for (const [dx, dy] of [[1, 0], [-1, 0], [0, 1], [0, -1]]) {
            const x = here % cols + dx, y = Math.floor(here / cols) + dy;
            if (x < 0 || y < 0 || x >= cols || y >= rows)
                continue;
            const next = y * cols + x;
            if (prev[next] !== undefined || !traversable(center(next), radius + 3, obstacles, width, height))
                continue;
            prev[next] = here;
            queue.push(next);
        }
    }
    const path = [];
    let node = best;
    while (node !== a && node >= 0) {
        path.push(center(node));
        node = prev[node];
    }
    path.reverse();
    if (best === target)
        path.push({ ...end });
    return path;
}
const toward = (a, b) => Math.atan2(b.y - a.y, b.x - a.x);
function circle(p, radius, warning, damage, extra = {}) {
    return { ...p, kind: 'circle', radius, angle: 0, warning, active: .12, damage, ...extra };
}
function cone(p, angle, radius, width, warning, damage, extra = {}) {
    return { ...p, kind: 'cone', radius, width, angle, warning, active: .12, damage, ...extra };
}
function landings(p, count, spread, radius, warning, damage, extra = {}) {
    return Array.from({ length: count }, (_, i) => circle({ x: Math.max(radius + 30, Math.min(1570 - radius, p.x + Math.cos(i * Math.PI * 2 / count) * spread)), y: Math.max(radius + 30, Math.min(1170 - radius, p.y + Math.sin(i * Math.PI * 2 / count) * spread)) }, radius, warning, damage, extra));
}
/** Complete boss choreography. All damage is resolved by combat.ts, never here. */
export function bossTurn(id, phase, index, boss, player, difficulty = 0) {
    const a = toward(boss, player), slot = difficulty >= 4 && index % 4 === 3 ? 0 : index % 3;
    let plans = [], recovery = 1;
    if (id === 'B1A') {
        if (slot === 0) {
            const charge = { ...boss, kind: 'rect', radius: 0, w: 620, h: 90, angle: a, warning: 1, active: 1.4, damage: 20, effect: 'charge', speed: 400, target: { ...player } };
            plans = [charge];
            recovery = 2;
            if (phase >= 2) {
                plans.push({ ...charge, warning: .8, delay: 2.5, target: { ...player } });
                recovery = 3;
            }
        }
        if (slot === 1)
            plans = [cone(boss, a, 170, Math.PI * 2 / 3, .9, 18)];
        if (slot === 2) {
            plans = landings(player, 3, 85, 45, .8, 12);
            recovery = 2;
        }
    }
    else if (id === 'B1B') {
        if (slot === 0) {
            plans = [circle(boss, 450, 1, 0, { active: 2, effect: 'pull', speed: 60 }), circle(boss, 150, 3, 22)];
            recovery = 1.5;
        }
        if (slot === 1) {
            plans = [cone(boss, a - Math.PI / 2, 280, Math.PI / 5, .9, 18, { active: 1.5, innerRadius: 100, sweep: Math.PI, period: .5 })];
            if (phase >= 2)
                plans.push(cone(boss, a + Math.PI / 2, 280, Math.PI / 5, .8, 18, { delay: 2.4, active: 1.5, innerRadius: 100, sweep: -Math.PI, period: .5 }));
        }
        if (slot === 2)
            plans = [circle(boss, 75, 1, 0, { effect: 'spawn', enemy: 'E02', count: 3, limit: 6 })];
    }
    else if (id === 'B2A') {
        if (slot === 0) {
            plans = [cone(boss, a, 300, Math.PI / 2, 1, 12, { active: 1.6, period: .5 })];
            recovery = 3;
            if (phase >= 2)
                plans.push(...landings(player, 2, 70, 50, 1.1, 16, { delay: 2.6, effect: 'fire', active: 4, period: .5 }));
        }
        if (slot === 1)
            plans = landings(player, 4, 105, 50, 1.1, 16, { effect: 'fire', active: 4, period: .5 });
        if (slot === 2) {
            plans = landings(boss, 4, 130, 65, .8, 20);
            recovery = 1.8;
        }
    }
    else if (id === 'B2B') {
        if (slot === 0)
            plans = [{ x: boss.x - 145, y: boss.y, kind: 'line', radius: 0, angle: 0, w: 290, h: 22, warning: 1, active: 2, damage: 16, period: .5 }];
        if (slot === 1) {
            for (let i = 0; i < 4; i++)
                plans.push({ ...boss, x: boss.x + (i % 2 === 0 ? -145 : 145), kind: 'line', radius: 0, w: 650, h: 12, angle: phase >= 2 ? Math.PI / 4 : 0, warning: .8, delay: i * .4, active: .1, damage: 12, effect: 'projectile', count: 4, spread: Math.PI * 2, speed: 220 });
        }
        if (slot === 2)
            plans = [circle(boss, 90, 1, 0, { effect: 'spawn', enemy: 'E05', count: 2, limit: 4 })];
    }
    else if (id === 'B3A') {
        const s = phase === 1 ? index % 2 : slot;
        if (s === 0) {
            plans = [{ ...boss, kind: 'line', radius: 0, w: 800, h: 36, angle: a - .55, warning: 1.2, active: 1.5, damage: 14, sweep: 1.1, period: .5 }];
            if (phase >= 3) {
                plans.push(circle(player, 80, 1, 24, { delay: 2.7 }));
                plans.push(circle(player, 20, .4, 14, { delay: 3.7, kind: 'ring', active: 2.2, grow: 190, innerRadius: 0, period: .5 }));
            }
        }
        if (s === 1)
            plans = [circle(player, 80, 1, 24), circle(player, 20, .4, 14, { delay: 1.1, kind: 'ring', active: 2.2, grow: 190, innerRadius: 0, period: .5 })];
        if (s === 2)
            plans = [{ x: 0, y: 350, kind: 'rect', radius: 0, w: 1600, h: 120, angle: 0, warning: 1, active: 4, damage: 0, effect: 'conveyor', speed: 50 },
                { x: 1600, y: 850, kind: 'rect', radius: 0, w: 1600, h: 120, angle: Math.PI, warning: 1, active: 4, damage: 0, effect: 'conveyor', speed: 50 },
                circle(boss, 90, 1, 0, { effect: 'spawn', enemy: 'E01', count: 4, limit: 8 })];
        recovery = 3;
    }
    else if (id === 'B3B') {
        if (slot === 0)
            plans = [280, 800, 1320].map(x => ({ x, y: 0, kind: 'rect', radius: 0, w: 1200, h: 120, angle: Math.PI / 2, warning: 1.3, active: .15, damage: 24 }));
        if (slot === 1)
            plans = [circle(boss, 120, 1, 0, { effect: 'spawn', enemy: 'E02', count: 4, limit: 8, spawnHp: 30, spawnDamage: 8 })];
        if (slot === 2) {
            for (let i = 0; i < 5; i++)
                plans.push(cone(boss, a, 650, Math.PI * 5 / 3, 1, 10, { delay: i * .35, active: .1, effect: 'projectile', count: 9, spread: Math.PI * 5 / 3, speed: 220 }));
            recovery = 3;
        }
    }
    const duration = plans.reduce((max, p) => Math.max(max, (p.delay || 0) + p.warning + p.active), 0);
    return { plans, duration, recovery };
}
export function bossPhase(id, fraction) {
    if (id === 'B1A' || id === 'B2B')
        return fraction <= .5 ? 2 : 1;
    if (id === 'B1B')
        return fraction <= .55 ? 2 : 1;
    if (id === 'B2A')
        return fraction <= .3 ? 3 : fraction <= .6 ? 2 : 1;
    if (id === 'B3A')
        return fraction <= .3 ? 3 : fraction <= .65 ? 2 : 1;
    return fraction <= .35 ? 3 : fraction <= .7 ? 2 : 1;
}

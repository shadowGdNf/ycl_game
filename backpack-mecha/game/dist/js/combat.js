import { CHASSIS_BY_ID, MODULE_BY_ID, ENEMY_BY_ID, BOSS_BY_ID } from "./content.js";
import { nextRandom } from "./random.js";
import { ARENA, availableBudget, bossPhase, bossTurn, chooseEnemy, circleHitsRect, createEncounter, findPath, traversable } from "./encounters.js";
const DAMAGE_SCALE = [1, 1.35, 1.8];
const CONFIG = { bulletSpeed: 800, waterSpeed: 650, iceSpeed: 650, oilSpeed: 550, missileSpeed: 500, droneSpeed: 720, bulletRadius: 4,
    spawnWarning: .75, spawnGrace: .5, hitGrace: .35, pickupBase: 60, maxEnemies: 70, softEnemies: 45, enemyShotSpeed: 240 };
const clamp = (v, min, max) => Math.max(min, Math.min(max, v));
const distance = (a, b) => Math.hypot(a.x - b.x, a.y - b.y);
const angleTo = (a, b) => Math.atan2(b.y - a.y, b.x - a.x);
const angleDiff = (a, b) => Math.atan2(Math.sin(a - b), Math.cos(a - b));
const value = (id, tier) => tier ? (MODULE_BY_ID[id]?.values?.[tier - 1] || 0) : 0;
const scale = (tier) => DAMAGE_SCALE[tier - 1];
const zeros = () => ({ damageByModule: {}, damageTakenBy: {}, kills: 0, killedBudget: 0, goldEarned: 0, maxChain: 0, damageTaken: 0 });
function rand(w) { const [state, n] = nextRandom(w.rng); w.rng = state; return n; }
function event(w, type, p, extra = {}) {
    w.events.push({ id: w.nextEvent++, type, at: w.time, x: p.x, y: p.y, ...extra });
}
function groupKey(e) { return e.group || String(e.eid); }
function alive(e) { return !e.dead && e.hp > 0 && e.exposed; }
function support(weapon, id) { return value(id, weapon.supports[id]); }
function utility(w, id) { return value(id, w.utilities[id]); }
function protocol(w, id) { return w.protocols.includes(id); }
function enemySlow(w, e) { return Math.min(e.kind === 'boss' ? .1 : e.kind === 'elite' ? .25 : .4, Math.max(e.oilUntil > w.time ? .2 : 0, e.chill * e.chillStrength)); }
function syncBossHP(w, e) { if (e.group)
    for (const other of w.enemies)
        if (other.group === e.group)
            other.hp = e.hp; }
export function createBattle(run) {
    const chassis = CHASSIS_BY_ID[run.chassis];
    if (!chassis)
        throw new Error(`Unknown chassis ${run.chassis}`);
    const encounter = createEncounter(run), equipped = run.items.filter(i => !i.stored), utilities = {};
    for (const item of equipped)
        if (MODULE_BY_ID[item.id]?.kind === 'utility')
            utilities[item.id] = item.tier;
    const maxShield = chassis.shield + value('U02', utilities.U02) + (run.protocols.includes('P04') ? 20 : 0) + Number(run.extra?.temporaryShield || 0);
    const speed = chassis.speed * clamp(1 + value('U07', utilities.U07) - (utilities.U06 ? .03 : 0), .65, 1.6);
    const dashBase = Math.max(3.5, chassis.dash - (utilities.U07 ? [1, 1.3, 1.8][utilities.U07 - 1] : 0) + (run.protocols.includes('P04') ? .5 : 0));
    const weapons = equipped.filter(i => MODULE_BY_ID[i.id]?.kind === 'weapon').map((i, index) => ({ uid: i.uid, id: i.id, tier: i.tier, x: 800, y: 650, angle: -Math.PI / 2, cooldown: .1 + index * .05, shotCount: 0,
        supports: Object.fromEntries(equipped.filter(s => MODULE_BY_ID[s.id]?.kind === 'support' && s.link === i.uid).map(s => [s.id, s.tier])), targetUntil: 0, rectifierAt: 0, springUsed: true, fuseAt: {}, droneCount: 0 }));
    let drones = 0;
    for (const weapon of weapons)
        if (weapon.id === 'W11') {
            weapon.droneCount = Math.min(6 - drones, weapon.supports.S10 ? 3 : 2);
            drones += weapon.droneCount;
        }
    const world = { version: 1, tick: 0, time: 0, wave: run.wave, act: encounter.state.wave.act, difficulty: run.difficulty, status: 'playing', width: ARENA.width, height: ARENA.height,
        player: { x: 800, y: 650, hp: clamp(run.hp, 0, chassis.hp), maxHp: chassis.hp, shield: maxShield, maxShield, radius: 14, speed, armor: clamp(chassis.armor + value('U06', utilities.U06), 0, 60), angle: -Math.PI / 2, dashCooldown: 0, overloadCooldown: 0, dashTime: 0, overloadTime: 0, invulnerable: 0 },
        enemies: [], bullets: [], zones: [], weapons, drops: [], obstacles: encounter.obstacles, events: [], stats: zeros(), chassis: run.chassis, duration: encounter.state.wave.duration, insuranceUsed: run.insuranceUsed,
        rng: run.rng.combat, nextId: 1, nextEvent: 1, nextShot: 1, remainder: 0, encounter: encounter.state, utilities, protocols: [...run.protocols], lastDamage: -10,
        shieldRegen: 3 + (utilities.U02 ? [1, 1.5, 2][utilities.U02 - 1] : 0), dashBase, dashAngle: 0, dashOrigin: { x: 800, y: 650 }, dashReleased: true, overloadReleased: true, lastDash: -10,
        repairAt: 10, repairAmount: 0, pickupAt: 0, capacitorAt: 0, capacitorDefense: 0, recoveryAt: 0, emberHeal: 0, emergencyUsed: false, decoyAt: 0, priorityUntil: 0, slowUntil: 0, slowAmount: 0,
        bossClock: 2, bossTurn: 0, bossStarted: false, bossOverloadWarned: false, bossEnraged: false, slainGroups: [] };
    if (encounter.boss) {
        world.bossId = encounter.boss;
        world.bossCenter = { x: 800, y: 300 };
        world.bossStarted = true;
        spawnEnemy(world, { id: encounter.boss, x: encounter.boss === 'B2B' ? 655 : 800, y: 300, elite: false, affix: 0, reward: false, cost: 0, boss: true, group: encounter.boss });
        if (encounter.boss === 'B2B') {
            spawnEnemy(world, { id: encounter.boss, x: 945, y: 300, elite: false, affix: 0, reward: false, cost: 0, boss: true, group: encounter.boss });
            world.enemies[0].offsetX = -145;
            world.enemies[1].offsetX = 145;
        }
        if (encounter.boss === 'B3B')
            for (const x of [-150, 150]) {
                const e = spawnEnemy(world, { id: encounter.boss, x: 800 + x, y: 300, elite: false, affix: 0, reward: false, cost: 0, boss: true, group: encounter.boss });
                e.radius = 65;
                e.offsetX = x;
                e.exposed = false;
            }
    }
    event(world, 'battle-start', world.player);
    if (world.player.hp <= 0)
        complete(world, false, 'hull');
    return world;
}
/** Useful to deterministic scenario tests and development encounter previews. */
export function spawnEnemy(w, spec) {
    const boss = spec.boss ? BOSS_BY_ID[spec.id] : undefined, base = ENEMY_BY_ID[spec.id];
    if (!boss && !base)
        throw new Error(`Unknown enemy ${spec.id}`);
    const hpDifficulty = [1, 1.1, 1.1, 1.2, 1.3][clamp(w.difficulty, 0, 4)], damageDifficulty = w.difficulty >= 4 ? 1.15 : w.difficulty >= 2 ? 1.1 : 1;
    const hp = (boss ? boss.hp : base.hp * [1, 1.65, 2.55][w.act - 1]) * hpDifficulty * (spec.elite ? 1.8 : 1);
    const e = { eid: w.nextId++, id: spec.id, x: spec.x, y: spec.y, hp, maxHp: hp, radius: boss?.radius || base.radius, angle: Math.PI / 2, kind: boss ? 'boss' : spec.elite ? 'elite' : 'normal', phase: 1,
        ...(spec.group ? { group: spec.group } : {}), armor: (boss?.armor || base?.armor || 0) + (spec.elite && spec.affix === 1 ? 10 : 0), speed: (boss?.speed || base?.speed || 0) * (boss ? 1 : [1, 1.06, 1.1][w.act - 1]) * (spec.elite && spec.affix === 0 ? 1.15 : 1),
        damage: (base?.damage || 20) * (boss ? 1 : [1, 1.25, 1.5][w.act - 1]) * damageDifficulty * (spec.elite ? 1.2 : 1), cost: spec.cost,
        reward: spec.reward && w.encounter.budget > 0 ? w.encounter.wave.bonus * spec.cost / w.encounter.budget : 0,
        born: w.time, dead: false, cooldown: boss ? 2 : .5, contactAt: 0, path: [], pathAt: 0, aiUntil: 0, healingUntil: 0, affix: spec.elite ? spec.affix : -1,
        oilUntil: 0, oilAt: 0, chill: 0, chillUntil: 0, chillStrength: .06, frozen: 0, wet: 0, burns: [], stagger: 0, staggerUntil: 0, vulnerableUntil: 0, summon: !spec.reward, exposed: true, offsetX: 0 };
    w.enemies.push(e);
    event(w, 'spawn', e, { targetId: e.eid, source: e.id });
    return e;
}
function move(w, p, dx, dy) {
    const ox = p.x, oy = p.y;
    const x = clamp(p.x + dx, p.radius, w.width - p.radius);
    if (traversable({ x, y: p.y }, p.radius, w.obstacles, w.width, w.height))
        p.x = x;
    const y = clamp(p.y + dy, p.radius, w.height - p.radius);
    if (traversable({ x: p.x, y }, p.radius, w.obstacles, w.width, w.height))
        p.y = y;
    return Math.abs(p.x - ox - dx) > .1 || Math.abs(p.y - oy - dy) > .1;
}
function follow(w, e, target, speed, dt) {
    if (e.pathAt <= w.time || !e.path.length) {
        e.path = findPath(e, target, w.obstacles, e.radius, w.width, w.height);
        e.pathAt = w.time + .6 + (e.eid % 4) * .03;
    }
    while (e.path.length && distance(e, e.path[0]) < 28)
        e.path.shift();
    const next = e.path[0] || target;
    let a = angleTo(e, next);
    if (e.id === 'E02')
        a = e.angle + clamp(angleDiff(a, e.angle), -Math.PI * dt, Math.PI * dt);
    e.angle = a;
    move(w, e, Math.cos(a) * speed * dt, Math.sin(a) * speed * dt);
}
function addZone(w, plan, sourceId, source = 'hazard', spawn) {
    const z = { id: w.nextId++, x: plan.x, y: plan.y, kind: plan.kind, radius: plan.radius, w: plan.w, h: plan.h, angle: plan.angle, width: plan.width, innerRadius: plan.innerRadius,
        remaining: plan.warning, duration: plan.warning, active: false, color: '#F05B5B', type: 'warning', damage: plan.damage, plan: { ...plan }, sourceId, source, delay: plan.delay || 0, age: 0, pulse: 0, triggered: false, originalAngle: plan.angle, ...(spawn ? { spawn } : {}) };
    if (plan.sweep) {
        z.kind = 'cone';
        z.radius = plan.kind === 'line' ? plan.w || plan.radius : plan.radius;
        z.width = Math.min(Math.PI * 2, Math.abs(plan.sweep) + (plan.kind === 'cone' ? plan.width || 0 : .08));
        z.angle = plan.angle + plan.sweep / 2;
    }
    w.zones.push(z);
    event(w, 'warning', z, { source });
    return z;
}
function spawnAt(w, id, elite = false, reward = true) {
    const def = ENEMY_BY_ID[id], radius = def.radius;
    for (let attempt = 0; attempt < 24; attempt++) {
        const a = w.wave === 1 && w.time < 10 ? -Math.PI / 2 + (rand(w) - .5) * .5 : rand(w) * Math.PI * 2;
        const r = 400 + rand(w) * 150, p = { x: w.player.x + Math.cos(a) * r, y: w.player.y + Math.sin(a) * r };
        if (!traversable(p, radius + 10, w.obstacles, w.width, w.height) || w.enemies.some(e => alive(e) && distance(e, p) < e.radius + radius + 12))
            continue;
        if (w.zones.some(z => z.delay <= 0 && contains(z, p, radius)))
            continue;
        const spec = { ...p, id, elite, affix: Math.floor(rand(w) * 3), reward, cost: def.cost * (elite ? 2 : 1) };
        addZone(w, { ...p, kind: 'circle', radius: radius + 12, angle: 0, warning: CONFIG.spawnWarning, active: .01, damage: 0, effect: 'spawn' }, undefined, 'spawn', spec);
        return true;
    }
    return false;
}
function tickSpawns(w) {
    if (w.bossId || w.time < w.encounter.nextSpawn)
        return;
    w.encounter.nextSpawn = Math.floor(w.time) + 1;
    const pending = w.zones.filter(z => z.spawn).length, count = w.enemies.filter(alive).length + pending;
    if (count >= CONFIG.softEnemies)
        return;
    let allowance = Math.min(8, availableBudget(w.encounter, w.time)), spent = 0;
    while (allowance > 0 && w.enemies.length + w.zones.filter(z => z.spawn).length < CONFIG.maxEnemies) {
        const id = w.wave === 1 && w.time < 10 ? 'E01' : chooseEnemy(w.encounter, allowance, rand(w));
        if (!id)
            break;
        const cost = ENEMY_BY_ID[id].cost;
        if (cost > allowance || !spawnAt(w, id))
            break;
        allowance -= cost;
        spent += cost;
    }
    w.encounter.spent += spent;
    if (w.encounter.extraElite && !w.encounter.eliteQueued && w.time > w.duration * .45 && w.enemies.filter(e => e.kind === 'elite').length < (w.difficulty >= 2 ? 3 : 2)) {
        const id = w.act === 1 ? 'E03' : w.encounter.mode === 'full' ? 'E07' : 'E03';
        if (spawnAt(w, id, true, false))
            w.encounter.eliteQueued = true;
    }
}
function complete(w, won, reason) {
    if (w.status !== 'playing')
        return;
    w.status = won ? 'won' : 'lost';
    w.failureReason = reason;
    if (won) {
        for (const drop of w.drops)
            w.stats.goldEarned += drop.value;
        w.drops = [];
    }
    event(w, won ? 'victory' : 'defeat', w.player, { source: reason });
}
function killEnemy(w, e, kind, weapon, oilExplosion = false) {
    const key = groupKey(e);
    if (e.dead || w.slainGroups.includes(key))
        return;
    w.slainGroups.push(key);
    e.dead = true;
    e.hp = 0;
    if (e.group)
        for (const other of w.enemies)
            if (other.group === e.group) {
                other.hp = 0;
                other.dead = true;
            }
    w.stats.kills++;
    if (e.reward > 0) {
        w.stats.killedBudget += e.cost;
        const nearby = w.drops.find(d => distance(d, e) < 35);
        if (nearby)
            nearby.value += e.reward;
        else
            w.drops.push({ id: w.nextId++, x: e.x, y: e.y, value: e.reward });
    }
    event(w, 'kill', e, { source: weapon?.id || kind, targetId: e.eid });
    if (w.utilities.U09 && ['water', 'electric', 'fire', 'oil', 'ice'].includes(kind) && w.time >= w.recoveryAt) {
        w.player.shield = Math.min(w.player.maxShield, w.player.shield + utility(w, 'U09'));
        w.recoveryAt = w.time + .5;
    }
    if (oilExplosion && protocol(w, 'P02') && w.emberHeal < 10) {
        const heal = Math.min(1, w.player.maxHp - w.player.hp, 10 - w.emberHeal);
        w.player.hp += heal;
        w.emberHeal += heal;
    }
    if (e.id === 'E10')
        for (let i = 0; i < 2; i++)
            if (w.enemies.filter(alive).length + w.zones.filter(z => z.spawn).length < CONFIG.maxEnemies) {
                const p = { x: e.x + (i ? 22 : -22), y: e.y }, spec = { ...p, id: 'E01', elite: false, affix: 0, reward: false, cost: 0 };
                addZone(w, { ...p, kind: 'circle', radius: 20, angle: 0, warning: .75, active: .01, damage: 0, effect: 'spawn' }, undefined, 'split', spec);
            }
    if (e.affix === 2)
        addZone(w, { x: e.x, y: e.y, kind: 'circle', radius: 75, angle: 0, warning: .9, active: .15, damage: e.damage }, undefined, 'elite-pulse');
}
function stagger(w, e, amount) {
    if (e.kind !== 'boss' || w.time < e.staggerUntil || e.frozen > 0)
        return;
    const shared = w.enemies.find(x => x.group === e.group && x.kind === 'boss') || e;
    shared.stagger += amount;
    if (shared.stagger >= 100) {
        shared.stagger = 0;
        shared.frozen = 1.5;
        shared.controlReason = 'stagger';
        shared.staggerUntil = w.time + 9.5;
        event(w, 'stagger', e, { amount: 1.5 });
    }
    for (const other of w.enemies)
        if (other.group && other.group === e.group) {
            other.stagger = shared.stagger;
            other.frozen = shared.frozen;
            other.controlReason = shared.controlReason;
            other.staggerUntil = shared.staggerUntil;
        }
}
function applyStatus(w, e, weapon) {
    if (weapon.id === 'W03')
        e.wet = Math.max(e.wet, 3 + (protocol(w, 'P01') ? 2 : 0));
    if (weapon.id === 'W06')
        e.oilUntil = w.time + 4;
    if (weapon.id === 'W05' && weapon.shotCount % 2 === 0) {
        const layer = { expires: w.time + 4, next: w.time + .5, weapon: weapon.uid, damage: 1.5 };
        if (e.burns.length >= 5)
            e.burns.splice(e.burns.reduce((best, b, i) => b.expires < e.burns[best].expires ? i : best, 0), 1);
        e.burns.push(layer);
    }
    if (weapon.id === 'W12') {
        e.chill++;
        e.chillUntil = w.time + 3;
        e.chillStrength = weapon.supports.S12 ? .08 : .06;
        if (e.chill >= 5) {
            e.chill = 0;
            if (e.kind === 'boss')
                stagger(w, e, 15 + (weapon.supports.S12 ? [5, 7, 9][weapon.supports.S12 - 1] : 0));
            else {
                e.frozen = (e.kind === 'elite' ? .5 : 1.2) + support(weapon, 'S12');
                e.controlReason = 'ice';
            }
        }
    }
}
function areaDamage(w, p, radius, hit) {
    const seen = [];
    for (const e of w.enemies) {
        const key = groupKey(e);
        if (alive(e) && distance(e, p) <= radius + e.radius && !seen.includes(key)) {
            seen.push(key);
            hitEnemy(w, e, { ...hit, origin: p });
        }
    }
    event(w, 'explosion', p, { amount: radius, source: hit.weapon?.id || hit.kind, color: hit.kind === 'oil' ? '#F5A24E' : '#F6CF86' });
}
/** One resolver for every player-originating damage path, including secondary effects. */
function hitEnemy(w, e, hit) {
    if (!alive(e) || w.status !== 'playing')
        return 0;
    const weapon = hit.weapon, direct = hit.direct !== false, origin = hit.origin || w.player;
    let add = direct && weapon ? support(weapon, 'S01') : 0;
    if (weapon && w.chassis === 'hive')
        add += weapon.id === 'W11' ? .15 : direct ? -.1 : 0;
    if (direct && protocol(w, 'P03')) {
        const d = distance(w.player, e);
        add += d > 250 ? .15 : d < 120 ? -.1 : 0;
    }
    if (direct && protocol(w, 'P09') && (e.chill > 0 || e.frozen > 0))
        add += .15;
    if (hit.arcFirst && e.wet > 0 && protocol(w, 'P01'))
        add += .1;
    if (direct && weapon?.id === 'W11' && protocol(w, 'P05') && w.priority === e.eid && w.priorityUntil > w.time)
        add += .2;
    let vulnerable = (hit.kind === 'electric' && e.wet > 0 ? (weapon?.supports.S05 ? support(weapon, 'S05') : .25) : 0) + (e.vulnerableUntil > w.time ? .25 : 0);
    if (hit.oilExplosion && e.kind === 'boss' && protocol(w, 'P02'))
        add += .15;
    const crit = direct && rand(w) < Math.min(.7, .05 + utility(w, 'U05'));
    let amount = hit.base * (weapon ? scale(weapon.tier) : 1) * (1 + Math.min(2, add)) * (hit.factor ?? 1) * (crit ? 1.5 : 1) * Math.min(1.75, 1 + vulnerable) * 100 / (100 + Math.max(0, e.armor - (direct && weapon ? support(weapon, 'S07') : 0)));
    if (e.id === 'E07' && Math.abs(angleDiff(angleTo(e, origin), e.angle)) < Math.PI / 3)
        amount *= .5;
    const actual = Math.min(e.hp, amount);
    e.hp = Math.max(0, e.hp - amount);
    syncBossHP(w, e);
    const source = weapon?.id || hit.kind;
    w.stats.damageByModule[source] = (w.stats.damageByModule[source] || 0) + actual;
    event(w, crit ? 'critical' : 'hit', e, { amount: actual, source, targetId: e.eid, color: MODULE_BY_ID[source]?.color });
    if (direct && weapon?.supports.S08 && crit && w.time >= weapon.rectifierAt) {
        w.player.shield = Math.min(w.player.maxShield, w.player.shield + support(weapon, 'S08'));
        weapon.rectifierAt = w.time + 1;
    }
    if (hit.status && weapon)
        applyStatus(w, e, weapon);
    if (hit.kind === 'fire' && !hit.secondary && e.oilUntil > w.time && e.oilAt <= w.time) {
        e.oilUntil = 0;
        e.oilAt = w.time + 2;
        areaDamage(w, e, weapon?.supports.S06 ? 100 : 80, { base: weapon?.supports.S06 ? support(weapon, 'S06') : 18, kind: 'oil', weapon, direct: false, secondary: true, oilExplosion: true });
    }
    if (direct && !hit.secondary && weapon?.supports.S09 && MODULE_BY_ID[weapon.id].tags.includes('爆炸') && e.burns.length && (weapon.fuseAt[groupKey(e)] || 0) <= w.time) {
        weapon.fuseAt[groupKey(e)] = w.time + 1;
        if (e.hp > 0)
            hitEnemy(w, e, { base: support(weapon, 'S09'), kind: 'explosion', weapon, direct: false, secondary: true });
    }
    if (e.hp <= 0)
        killEnemy(w, e, hit.kind, weapon, hit.oilExplosion);
    return actual;
}
/** All enemy damage, including hazards, goes through this protection and death ordering. */
export function damagePlayer(w, raw, source, at = w.player) {
    const p = w.player;
    if (w.status !== 'playing' || p.dashTime > 0 || p.invulnerable > 0 || raw <= 0)
        return 0;
    const damage = raw * 100 / (100 + p.armor) * (w.capacitorDefense > w.time ? .7 : 1), beforeShield = p.shield, beforeHP = p.hp;
    const absorbed = Math.min(p.shield, damage);
    p.shield -= absorbed;
    p.hp = Math.max(0, p.hp - (damage - absorbed));
    p.invulnerable = CONFIG.hitGrace;
    w.lastDamage = w.time;
    const actual = Math.min(damage, beforeShield + beforeHP);
    w.stats.damageTaken += actual;
    w.stats.damageTakenBy[source] = (w.stats.damageTakenBy[source] || 0) + actual;
    event(w, 'player-hit', at, { amount: actual, source });
    if (beforeShield > 0 && p.shield <= 0) {
        event(w, 'shield-break', p);
        if (w.utilities.U08 && w.time >= w.capacitorAt) {
            w.capacitorAt = w.time + 8;
            w.capacitorDefense = w.time + 1;
            areaDamage(w, p, 150, { base: utility(w, 'U08'), kind: 'electric', direct: false, secondary: true });
        }
    }
    if (protocol(w, 'P07') && !w.emergencyUsed && beforeHP / p.maxHp >= .35 && p.hp / p.maxHp < .35) {
        w.emergencyUsed = true;
        p.shield = Math.min(p.maxShield, p.shield + 15);
    }
    if (p.hp <= 0) {
        if (w.utilities.U12 && !w.insuranceUsed) {
            w.insuranceUsed = true;
            p.hp = utility(w, 'U12');
            p.invulnerable = 1;
            event(w, 'insurance', p, { amount: p.hp });
        }
        else
            complete(w, false, source);
    }
    return damage;
}
function targetFor(w, weapon) {
    const range = MODULE_BY_ID[weapon.id].range || 400;
    const valid = (e) => alive(e) && distance(e, w.player) <= range + e.radius;
    const priority = w.priorityUntil > w.time ? w.enemies.find(e => e.eid === w.priority && valid(e)) : undefined;
    if (priority)
        return priority;
    const previous = weapon.targetUntil > w.time ? w.enemies.find(e => e.eid === weapon.target && valid(e)) : undefined;
    if (previous)
        return previous;
    const target = w.enemies.filter(valid).sort((a, b) => distance(w.player, a) - distance(w.player, b) || a.eid - b.eid)[0];
    weapon.target = target?.eid;
    weapon.targetUntil = w.time + .4;
    return target;
}
function makeBullet(w, p, angle, speed, base, kind, weapon, extra = {}) {
    const range = weapon ? MODULE_BY_ID[weapon.id].range || 400 : 900;
    const b = { eid: w.nextId++, x: p.x, y: p.y, vx: Math.cos(angle) * speed, vy: Math.sin(angle) * speed, radius: CONFIG.bulletRadius, damage: base, life: range / speed,
        color: weapon ? MODULE_BY_ID[weapon.id].color : '#EF7869', owner: weapon ? 'player' : 'enemy', weapon: weapon?.id, weaponUid: weapon?.uid, kind, factor: 1, shot: w.nextShot++, hitAt: {}, pierce: 1,
        bounces: weapon?.supports.S04 ? 2 : 0, bounceFactor: weapon ? support(weapon, 'S04') : 0, traveled: 0, range, slow: 0, applyStatus: true, source: weapon?.id || 'projectile', ...extra };
    if (b.bounces)
        b.life = range / speed * 3;
    w.bullets.push(b);
    return b;
}
function fireWeapon(w, weapon, target, extra = false) {
    const def = MODULE_BY_ID[weapon.id], origin = w.player, a = angleTo(origin, target);
    weapon.angle = a;
    weapon.x = origin.x;
    weapon.y = origin.y;
    if (!extra)
        weapon.shotCount++;
    let factor = 1;
    if (weapon.supports.S11 && w.time - w.lastDash <= 2 && !weapon.springUsed) {
        factor = 1 + [.4, .55, .7][weapon.supports.S11 - 1];
        weapon.springUsed = true;
    }
    event(w, 'fire', origin, { source: weapon.id, targetId: target.eid });
    if (weapon.id === 'W04') {
        const maximum = Math.min(5, 3 + (target.wet > 0 ? 1 : 0) + (weapon.supports.S05 ? 1 : 0)), seen = [];
        let current = target, previous = origin;
        for (let chain = 0; chain < maximum && current; chain++) {
            seen.push(groupKey(current));
            event(w, 'arc', previous, { targetId: current.eid, source: weapon.id, color: def.color });
            hitEnemy(w, current, { base: chain === 0 ? 10 : 6, kind: 'electric', weapon, factor, status: true, arcFirst: chain === 0 });
            previous = { x: current.x, y: current.y };
            current = w.enemies.filter(e => alive(e) && !seen.includes(groupKey(e)) && distance(e, previous) <= 140).sort((x, y) => distance(x, previous) - distance(y, previous) || x.eid - y.eid)[0];
        }
        w.stats.maxChain = Math.max(w.stats.maxChain, seen.length);
    }
    else if (weapon.id === 'W05' || weapon.id === 'W08' || weapon.id === 'W09') {
        const range = (def.range || 100) * (1 + support(weapon, 'S11')), angle = weapon.id === 'W09' ? Math.PI * 2 : weapon.id === 'W05' ? Math.PI / 2 : Math.PI * 2 / 3;
        const seen = [];
        let hits = 0;
        for (const e of [...w.enemies].sort((x, y) => distance(x, origin) - distance(y, origin))) {
            const key = groupKey(e);
            if (!alive(e) || seen.includes(key) || distance(e, origin) > range + e.radius || Math.abs(angleDiff(angleTo(origin, e), a)) > angle / 2)
                continue;
            if (weapon.id === 'W09' && hits >= 6)
                break;
            seen.push(key);
            hits++;
            hitEnemy(w, e, { base: def.damage || 0, kind: weapon.id === 'W05' ? 'fire' : 'melee', weapon, factor, status: true });
            if (weapon.id === 'W08' && alive(e)) {
                if (e.kind === 'boss')
                    stagger(w, e, 20);
                else {
                    const dir = angleTo(origin, e), push = e.kind === 'elite' ? 20 : 40;
                    move(w, e, Math.cos(dir) * push, Math.sin(dir) * push);
                }
            }
        }
        const z = addZone(w, { ...origin, kind: weapon.id === 'W09' ? 'circle' : 'cone', radius: range, angle: a, width: angle, warning: 0, active: .12, damage: 0 });
        z.type = 'friendly';
        z.active = true;
        z.remaining = .12;
        z.duration = .12;
        z.color = def.color;
    }
    else if (weapon.id === 'W11') {
        for (let i = 0; i < weapon.droneCount; i++) {
            const orbit = w.time * 1.2 + (i / Math.max(1, weapon.droneCount)) * Math.PI * 2 + (w.weapons.indexOf(weapon) % 2 ? Math.PI / 3 : 0), p = { x: origin.x + Math.cos(orbit) * 48, y: origin.y + Math.sin(orbit) * 48 };
            makeBullet(w, p, angleTo(p, target), CONFIG.droneSpeed, 4, 'drone', weapon, { factor: weapon.supports.S10 ? support(weapon, 'S10') : 1 });
        }
    }
    else {
        const split = Boolean(weapon.supports.S03) && def.tags.includes('单弹');
        const count = weapon.id === 'W02' ? 5 : split ? 2 : 1, spread = weapon.id === 'W02' ? Math.PI * 2 / 9 : split ? .14 : 0;
        const speed = weapon.id === 'W03' ? CONFIG.waterSpeed : weapon.id === 'W12' ? CONFIG.iceSpeed : weapon.id === 'W06' ? CONFIG.oilSpeed : weapon.id === 'W10' ? CONFIG.missileSpeed : weapon.id === 'W07' ? 1700 : CONFIG.bulletSpeed;
        const kind = weapon.id === 'W03' ? 'water' : weapon.id === 'W12' ? 'ice' : weapon.id === 'W06' ? 'oil' : weapon.id === 'W10' ? 'explosion' : 'ballistic';
        for (let i = 0; i < count; i++) {
            const angle = a + (count > 1 ? (i / (count - 1) - .5) * spread : 0), base = weapon.id === 'W02' ? 5 : def.damage || 0;
            // Start collision travel at the body center; a visual muzzle offset must never skip an overlapping enemy.
            makeBullet(w, { x: origin.x, y: origin.y }, angle, speed, base, kind, weapon, { factor: factor * (split ? support(weapon, 'S03') : 1), pierce: weapon.id === 'W07' ? 3 : 1, ...(weapon.id === 'W06' || weapon.id === 'W10' ? { target: { x: target.x, y: target.y }, radius: 6 } : {}) });
        }
    }
    if (!extra && w.utilities.U10 && weapon.id !== 'W11' && weapon.shotCount % utility(w, 'U10') === 0)
        fireWeapon(w, weapon, target, true);
}
function tickWeapons(w, dt) {
    for (const weapon of w.weapons) {
        weapon.x = w.player.x;
        weapon.y = w.player.y;
        weapon.cooldown = Math.max(0, weapon.cooldown - dt);
        if (weapon.cooldown > 1e-8 || w.status !== 'playing')
            continue;
        const target = targetFor(w, weapon);
        if (!target)
            continue;
        fireWeapon(w, weapon, target);
        let speed = support(weapon, 'S02') + (w.player.overloadTime > 0 ? .35 : 0) + (protocol(w, 'P07') && w.player.hp / w.player.maxHp < .35 ? .2 : 0);
        if (protocol(w, 'P06') && w.time - w.lastDash <= 3 && MODULE_BY_ID[weapon.id].tags.includes('实弹'))
            speed += .2;
        weapon.cooldown = Math.max(.08, (MODULE_BY_ID[weapon.id].interval || 1) / (1 + Math.min(1.5, speed)));
    }
}
function segmentDistance(p, a, b) {
    const dx = b.x - a.x, dy = b.y - a.y, t = clamp(((p.x - a.x) * dx + (p.y - a.y) * dy) / (dx * dx + dy * dy || 1), 0, 1);
    return Math.hypot(p.x - a.x - dx * t, p.y - a.y - dy * t);
}
function tickBullets(w, dt) {
    for (const b of w.bullets) {
        if (b.life <= 0 || w.status !== 'playing')
            continue;
        const before = { x: b.x, y: b.y };
        b.life -= dt;
        b.x += b.vx * dt;
        b.y += b.vy * dt;
        b.traveled += Math.hypot(b.vx, b.vy) * dt;
        const weapon = b.weaponUid ? w.weapons.find(a => a.uid === b.weaponUid) : undefined;
        if (b.target && distance(before, b.target) <= Math.hypot(b.vx, b.vy) * dt + 7) {
            areaDamage(w, b.target, b.kind === 'oil' ? 70 : 75, { base: b.damage, kind: b.kind, weapon, factor: b.factor, status: true });
            b.life = 0;
            continue;
        }
        const wallX = b.x < b.radius || b.x > w.width - b.radius, wallY = b.y < b.radius || b.y > w.height - b.radius, obstacle = w.obstacles.find(r => circleHitsRect(b, b.radius, r));
        if (wallX || wallY || obstacle) {
            if (b.bounces > 0) {
                b.bounces--;
                b.factor *= b.bounceFactor;
                b.traveled = 0;
                if (wallX || obstacle && !circleHitsRect({ x: before.x, y: b.y }, b.radius, obstacle))
                    b.vx *= -1;
                else if (wallY || obstacle)
                    b.vy *= -1;
                b.x = clamp(before.x, b.radius, w.width - b.radius);
                b.y = clamp(before.y, b.radius, w.height - b.radius);
                event(w, 'ricochet', b, { source: b.weapon });
            }
            else {
                if (b.target && weapon)
                    areaDamage(w, b, b.kind === 'oil' ? 70 : 75, { base: b.damage, kind: b.kind, weapon, factor: b.factor, status: true });
                b.life = 0;
            }
            continue;
        }
        if (b.traveled > b.range) {
            if (b.target && weapon)
                areaDamage(w, b, b.kind === 'oil' ? 70 : 75, { base: b.damage, kind: b.kind, weapon, factor: b.factor, status: true });
            b.life = 0;
            continue;
        }
        if (b.owner === 'enemy') {
            if (w.decoy && w.decoy.until > w.time && segmentDistance(w.decoy, before, b) < 16 + b.radius) {
                w.decoy.hp -= b.damage;
                b.life = 0;
                continue;
            }
            if (segmentDistance(w.player, before, b) < w.player.radius + b.radius) {
                const taken = damagePlayer(w, b.damage, b.source, b);
                if (taken > 0 && b.slow > 0) {
                    w.slowUntil = w.time + 2;
                    w.slowAmount = b.slow;
                }
                b.life = 0;
            }
        }
        else if (!b.target) {
            for (const e of w.enemies.filter(alive).sort((a, z) => distance(before, a) - distance(before, z) || a.eid - z.eid)) {
                const key = groupKey(e);
                if ((b.hitAt[key] ?? -100) > w.time - .3 || segmentDistance(e, before, b) > e.radius + b.radius)
                    continue;
                b.hitAt[key] = w.time;
                hitEnemy(w, e, { base: b.damage, kind: b.kind, weapon, factor: b.factor, status: b.applyStatus, origin: before });
                b.pierce--;
                if (weapon?.id === 'W07')
                    b.factor *= .75;
                if (b.pierce <= 0) {
                    if (b.bounces > 0 && weapon?.id !== 'W07') {
                        b.pierce = 1;
                        break;
                    }
                    b.life = 0;
                    break;
                }
            }
        }
    }
    w.bullets = w.bullets.filter(b => b.life > 0);
}
export function contains(z, p, radius = 0) {
    const dx = p.x - z.x, dy = p.y - z.y, d = Math.hypot(dx, dy);
    if (z.kind === 'circle')
        return d <= z.radius + radius;
    if (z.kind === 'ring')
        return d <= z.radius + radius && d >= Math.max(0, (z.innerRadius ?? z.radius - 22) - radius);
    if (z.kind === 'cone')
        return d <= z.radius + radius && d >= Math.max(0, (z.innerRadius || 0) - radius) && Math.abs(angleDiff(Math.atan2(dy, dx), z.angle)) <= (z.width || Math.PI / 2) / 2 + Math.asin(Math.min(1, radius / Math.max(d, 1)));
    const along = dx * Math.cos(z.angle) + dy * Math.sin(z.angle), across = -dx * Math.sin(z.angle) + dy * Math.cos(z.angle);
    return along >= -radius && along <= (z.w || z.radius) + radius && Math.abs(across) <= (z.h || z.width || 20) / 2 + radius;
}
function difficultyDamage(w) { return w.difficulty >= 4 ? 1.15 : w.difficulty >= 2 ? 1.1 : 1; }
function triggerZone(w, z) {
    const plan = z.plan, source = w.enemies.find(e => e.eid === z.sourceId);
    if (z.spawn) {
        spawnEnemy(w, z.spawn);
        z.remaining = 0;
        return;
    }
    if (plan.effect === 'spawn') {
        const existing = w.enemies.filter(e => alive(e) && e.id === plan.enemy && e.summon).length, count = Math.min(plan.count || 1, (plan.limit || 8) - existing, CONFIG.maxEnemies - w.enemies.filter(alive).length);
        for (let i = 0; i < count; i++) {
            const a = (i / Math.max(1, count)) * Math.PI * 2, p = { x: clamp(z.x + Math.cos(a) * 120, 40, w.width - 40), y: clamp(z.y + Math.sin(a) * 120, 40, w.height - 40) };
            const s = { ...p, id: plan.enemy || 'E01', elite: false, affix: 0, reward: false, cost: 0 };
            const e = spawnEnemy(w, s);
            if (plan.spawnHp)
                e.hp = e.maxHp = plan.spawnHp * [1, 1.1, 1.1, 1.2, 1.3][clamp(w.difficulty, 0, 4)];
            if (plan.spawnDamage)
                e.damage = plan.spawnDamage * difficultyDamage(w);
        }
        z.remaining = 0;
    }
    else if (plan.effect === 'projectile') {
        const count = plan.count || 1, spread = plan.spread || 0;
        for (let i = 0; i < count; i++) {
            const offset = count <= 1 ? 0 : spread >= Math.PI * 2 - .01 ? i / count * spread : ((i / (count - 1)) - .5) * spread;
            makeBullet(w, z, z.angle + offset, plan.speed || CONFIG.enemyShotSpeed, plan.damage, 'ballistic', undefined, { owner: 'enemy', source: z.source, slow: plan.slow || 0, radius: plan.projectileRadius || 5, life: 5, range: 1200 });
        }
        event(w, 'enemy-fire', z, { source: z.source });
        z.remaining = 0;
    }
    else if (plan.effect === 'charge' && source) {
        source.charge = { vx: Math.cos(z.angle) * (plan.speed || 260), vy: Math.sin(z.angle) * (plan.speed || 260), until: w.time + plan.active, damage: plan.damage, radius: (plan.h || source.radius * 2) / 2 };
    }
    else if (plan.effect === 'drill' && source) {
        source.x = z.x;
        source.y = z.y;
        source.aiUntil = 0;
        source.path = [];
    }
}
function tickZones(w, dt) {
    for (const z of w.zones) {
        if (w.status !== 'playing')
            break;
        if (z.type === 'friendly') {
            z.remaining -= dt;
            continue;
        }
        if (z.delay > 0) {
            z.delay -= dt;
            if (z.delay <= 0 && z.plan.effect === 'charge') {
                const e = w.enemies.find(e => e.eid === z.sourceId);
                if (e) {
                    z.x = e.x;
                    z.y = e.y;
                    z.angle = angleTo(e, w.player);
                    z.originalAngle = z.angle;
                    z.plan.x = z.x;
                    z.plan.y = z.y;
                    z.plan.angle = z.angle;
                }
            }
            continue;
        }
        if (z.sourceId !== undefined && !w.enemies.some(e => e.eid === z.sourceId && alive(e)) && z.plan.effect !== 'fire') {
            z.remaining = 0;
            continue;
        }
        z.remaining -= dt;
        if (z.active && z.remaining <= 0 && z.source === 'B2A' && z.kind === 'cone')
            for (const e of w.enemies)
                if (e.id === 'B2A')
                    e.vulnerableUntil = w.time + 3;
        if (!z.active) {
            if (z.remaining > 0)
                continue;
            z.active = true;
            z.type = 'hazard';
            z.duration = z.plan.active;
            z.remaining = z.plan.active;
            z.age = 0;
            z.kind = z.plan.kind;
            z.radius = z.plan.radius;
            z.width = z.plan.width;
            z.angle = z.plan.angle;
            triggerZone(w, z);
        }
        if (z.remaining <= 0)
            continue;
        z.age += dt;
        if (z.plan.sweep)
            z.angle = z.originalAngle + z.plan.sweep * Math.min(1, z.age / z.plan.active);
        if (z.plan.grow) {
            z.radius = z.plan.radius + z.plan.grow * z.age;
            z.innerRadius = Math.max(0, z.radius - 22);
        }
        if (z.plan.effect === 'charge')
            continue;
        if (z.plan.effect === 'pull' && contains(z, w.player, w.player.radius)) {
            const a = angleTo(w.player, z);
            move(w, w.player, Math.cos(a) * (z.plan.speed || 60) * dt, Math.sin(a) * (z.plan.speed || 60) * dt);
            continue;
        }
        if (z.plan.effect === 'conveyor' && contains(z, w.player, w.player.radius)) {
            move(w, w.player, Math.cos(z.angle) * (z.plan.speed || 50) * dt, Math.sin(z.angle) * (z.plan.speed || 50) * dt);
            continue;
        }
        z.pulse -= dt;
        if (z.pulse > 0)
            continue;
        z.pulse = z.plan.period || 1000;
        if (contains(z, w.player, w.player.radius)) {
            const amount = z.plan.effect === 'fire' && z.triggered ? 6 * difficultyDamage(w) : z.plan.damage;
            damagePlayer(w, amount, z.source, z);
        }
        if (z.source === 'E05' && !z.triggered) {
            const e = w.enemies.find(e => e.eid === z.sourceId);
            if (e) {
                e.dead = true;
                e.hp = 0;
                event(w, 'enemy-explosion', e, { source: e.id, targetId: e.eid, amount: z.radius });
            }
        }
        z.triggered = true;
    }
    w.zones = w.zones.filter(z => z.delay > 0 || z.remaining > 0);
}
function tickEnemyStatuses(w, dt) {
    for (const e of [...w.enemies]) {
        if (!alive(e))
            continue;
        e.wet = Math.max(0, e.wet - dt);
        e.frozen = Math.max(0, e.frozen - dt);
        if (!e.frozen)
            delete e.controlReason;
        if (e.chillUntil <= w.time)
            e.chill = 0;
        for (const layer of [...e.burns]) {
            if (layer.next <= w.time && layer.next <= layer.expires) {
                layer.next += .5;
                const weapon = w.weapons.find(v => v.uid === layer.weapon);
                hitEnemy(w, e, { base: layer.damage, kind: 'fire', weapon, direct: false });
            }
        }
        e.burns = e.burns.filter(b => b.expires > w.time);
    }
}
function tickEnemies(w, dt) {
    for (const e of [...w.enemies]) {
        if (!alive(e) || e.frozen > 0)
            continue;
        if (e.charge && e.charge.until > w.time) {
            const slow = 1 - enemySlow(w, e), blocked = move(w, e, e.charge.vx * dt * slow, e.charge.vy * dt * slow);
            e.angle = Math.atan2(e.charge.vy, e.charge.vx);
            if (e.kind === 'boss' && w.bossCenter) {
                w.bossCenter.x = e.x;
                w.bossCenter.y = e.y;
            }
            if (blocked) {
                e.charge.until = 0;
                e.frozen = e.kind === 'boss' ? 2 : 1.5;
                e.controlReason = 'impact';
                event(w, 'stagger', e, { source: e.id, amount: e.frozen });
            }
            continue;
        }
        if (e.kind === 'boss')
            continue;
        e.cooldown = Math.max(0, e.cooldown - dt);
        const target = w.decoy && w.decoy.until > w.time && w.decoy.hp > 0 ? w.decoy : w.player, d = distance(e, target), a = angleTo(e, target);
        const speed = e.speed * (1 - enemySlow(w, e));
        if (e.healingUntil > w.time) {
            for (const other of w.enemies)
                if (alive(other) && other.kind !== 'boss' && other.eid !== e.eid && distance(e, other) < 220)
                    other.hp = Math.min(other.maxHp, other.hp + 6 * dt);
            continue;
        }
        if (e.aiUntil > w.time)
            continue;
        if (e.id === 'E04' || e.id === 'E09') {
            if (d <= 360 && e.cooldown <= 0) {
                const tether = e.id === 'E09';
                e.angle = a;
                e.cooldown = tether ? 3 : 2.2;
                e.aiUntil = w.time + (tether ? .5 : .6);
                addZone(w, { x: e.x, y: e.y, kind: 'line', radius: 0, w: 360, h: 8, angle: a, warning: tether ? .5 : .6, active: .05, damage: e.damage, effect: 'projectile', count: 1, speed: tether ? 230 : 280, slow: tether ? .25 : 0 }, e.eid, e.id);
            }
            else if (d > 260)
                follow(w, e, target, speed, dt);
            else if (d < 160) {
                e.angle = a;
                move(w, e, -Math.cos(a) * speed * dt, -Math.sin(a) * speed * dt);
            }
        }
        else if (e.id === 'E05') {
            if (d < 95 && e.cooldown <= 0) {
                e.aiUntil = w.time + 2;
                e.cooldown = 1000;
                addZone(w, { x: e.x, y: e.y, kind: 'circle', radius: 70, angle: 0, warning: .8, active: .1, damage: e.damage }, e.eid, e.id);
            }
            else
                follow(w, e, target, speed, dt);
        }
        else if (e.id === 'E06') {
            const ally = w.enemies.filter(o => alive(o) && o.kind !== 'boss' && o.eid !== e.eid).sort((a, b) => (a.hp / a.maxHp) - (b.hp / b.maxHp) || distance(e, a) - distance(e, b))[0];
            if (ally) {
                if (distance(e, ally) > 160)
                    follow(w, e, ally, speed, dt);
                if (e.cooldown <= 0 && distance(e, ally) < 220) {
                    e.cooldown = 3;
                    e.healingUntil = w.time + 2;
                    event(w, 'heal', e, { source: e.id, targetId: ally.eid });
                }
            }
            else if (d < 200) {
                e.angle = a;
                move(w, e, -Math.cos(a) * speed * dt, -Math.sin(a) * speed * dt);
            }
        }
        else if (e.id === 'E08') {
            if (e.cooldown <= 0 && d < 650) {
                e.cooldown = 5;
                e.aiUntil = w.time + 1.1;
                addZone(w, { x: target.x, y: target.y, kind: 'circle', radius: 48, angle: 0, warning: 1, active: .1, damage: e.damage, effect: 'drill' }, e.eid, e.id);
            }
            else
                follow(w, e, target, speed, dt);
        }
        else if (e.id === 'E11') {
            if (e.cooldown <= 0 && d < 600) {
                e.cooldown = 3.5;
                e.aiUntil = w.time + .8;
                addZone(w, { x: e.x, y: e.y, kind: 'cone', radius: 300, width: Math.PI * 5 / 3, angle: a + Math.PI, warning: .8, active: .05, damage: e.damage, effect: 'projectile', count: 11, spread: Math.PI * 5 / 3, speed: 180 }, e.eid, e.id);
            }
            else if (d > 320)
                follow(w, e, target, speed, dt);
        }
        else if (e.id === 'E12') {
            if (e.cooldown <= 0 && d < 650) {
                e.cooldown = 6;
                e.aiUntil = w.time + 2.5;
                e.angle = a;
                addZone(w, { x: e.x, y: e.y, kind: 'rect', radius: 0, w: 390, h: 65, angle: a, warning: 1, active: 1.5, damage: e.damage, effect: 'charge', speed: 260 }, e.eid, e.id);
            }
            else
                follow(w, e, target, speed, dt);
        }
        else
            follow(w, e, target, speed, dt);
    }
    // Soft separation uses the same world collision helper, so crowds cannot push units through walls.
    for (let i = 0; i < w.enemies.length; i++) {
        const a = w.enemies[i];
        if (!alive(a) || a.kind === 'boss')
            continue;
        for (let j = i + 1; j < w.enemies.length; j++) {
            const b = w.enemies[j];
            if (!alive(b) || b.kind === 'boss')
                continue;
            const d = distance(a, b), minimum = (a.radius + b.radius) * .85;
            if (d >= minimum)
                continue;
            const angle = d > .001 ? angleTo(b, a) : ((a.eid * 1.7 + b.eid) % 6.28), push = Math.min(2, (minimum - d) / 2);
            move(w, a, Math.cos(angle) * push, Math.sin(angle) * push);
            move(w, b, -Math.cos(angle) * push, -Math.sin(angle) * push);
        }
    }
}
function tickBoss(w, dt) {
    if (!w.bossId)
        return;
    const bodies = w.enemies.filter(e => e.kind === 'boss' && !e.dead), root = bodies[0];
    if (!root)
        return;
    const overload = [90, 110, 130][w.act - 1];
    if (w.time >= overload - 10 && !w.bossOverloadWarned) {
        w.bossOverloadWarned = true;
        event(w, 'boss-overload-warning', root, { amount: 10 });
    }
    if (w.time >= overload && !w.bossEnraged) {
        w.bossEnraged = true;
        event(w, 'boss-overload', root);
    }
    if (root.frozen > 0)
        return;
    w.bossClock -= dt;
    if (w.bossClock <= 0) {
        const phase = bossPhase(w.bossId, root.hp / root.maxHp);
        if (phase !== root.phase) {
            event(w, 'phase', root, { amount: phase, source: root.id });
            for (const b of bodies) {
                b.phase = phase;
                if (b.id === 'B3B' && b.offsetX)
                    b.exposed = phase >= 2;
            }
        }
        const turn = bossTurn(w.bossId, phase, w.bossTurn++, w.bossCenter || root, w.player, w.difficulty);
        for (const plan of turn.plans)
            addZone(w, { ...plan, damage: plan.damage * (w.difficulty >= 4 ? 1.15 : w.difficulty >= 2 ? 1.1 : 1) }, root.eid, w.bossId);
        w.bossClock = turn.duration + turn.recovery * (w.bossEnraged ? .8 : 1);
    }
    else if (!w.zones.some(z => z.sourceId === root.eid && z.plan.effect !== 'fire') && (!root.charge || root.charge.until <= w.time)) {
        const center = w.bossCenter || root, a = angleTo(center, w.player), d = distance(center, w.player), speed = root.speed * (root.id === 'B2A' && root.phase >= 3 ? 1.15 : 1) * (1 - enemySlow(w, root));
        if (d > 240) {
            center.x = clamp(center.x + Math.cos(a) * speed * dt, 190, w.width - 190);
            center.y = clamp(center.y + Math.sin(a) * speed * dt, 150, w.height - 150);
        }
        for (const e of bodies) {
            e.x = center.x + e.offsetX;
            e.y = center.y;
            e.angle = a;
        }
    }
}
function contactDamage(w) {
    for (const e of w.enemies) {
        if (!alive(e) || e.frozen > 0 || w.time - e.born < CONFIG.spawnGrace || w.time < e.contactAt || e.damage <= 0)
            continue;
        if (w.decoy && w.decoy.until > w.time && e.kind !== 'boss' && distance(e, w.decoy) < e.radius + 16) {
            w.decoy.hp -= e.damage;
            e.contactAt = w.time + 1;
            continue;
        }
        const charging = e.charge && e.charge.until > w.time;
        if (distance(e, w.player) < (charging ? e.charge.radius : e.radius) + w.player.radius) {
            damagePlayer(w, charging ? e.charge.damage : e.damage, e.id, e);
            e.contactAt = w.time + 1;
        }
    }
}
function tickPlayer(w, input, dt) {
    const p = w.player, wasDashing = p.dashTime > 0;
    p.dashCooldown = Math.max(0, p.dashCooldown - dt);
    p.overloadCooldown = Math.max(0, p.overloadCooldown - dt);
    p.dashTime = Math.max(0, p.dashTime - dt);
    p.overloadTime = Math.max(0, p.overloadTime - dt);
    p.invulnerable = Math.max(0, p.invulnerable - dt);
    if (input.target) {
        const chosen = w.enemies.filter(alive).sort((a, b) => distance(a, input.target) - distance(b, input.target))[0];
        if (chosen && distance(chosen, input.target) < chosen.radius + 55) {
            w.priority = chosen.eid;
            w.priorityUntil = w.time + 2;
        }
    }
    if (w.priorityUntil <= w.time || !w.enemies.some(e => e.eid === w.priority && alive(e)))
        w.priority = undefined;
    if (wasDashing && p.dashTime === 0 && w.utilities.U11 && w.time >= w.decoyAt) {
        w.decoyAt = w.time + 10;
        w.decoy = { ...w.dashOrigin, hp: utility(w, 'U11'), until: w.time + [3, 4, 5][w.utilities.U11 - 1] };
        event(w, 'decoy', w.decoy);
    }
    if (w.decoy && (w.decoy.until <= w.time || w.decoy.hp <= 0))
        w.decoy = undefined;
    const length = Math.hypot(input.x, input.y), x = length > 1 ? input.x / length : input.x, y = length > 1 ? input.y / length : input.y;
    if (input.dash && w.dashReleased && p.dashCooldown <= 0) {
        w.dashAngle = length > .01 ? Math.atan2(y, x) : p.angle;
        p.dashTime = .18;
        p.dashCooldown = w.dashBase;
        w.dashOrigin = { x: p.x, y: p.y };
        w.lastDash = w.time;
        for (const weapon of w.weapons)
            weapon.springUsed = false;
        event(w, 'dash', p);
    }
    if (input.overload && w.overloadReleased && p.overloadCooldown <= 0) {
        p.overloadTime = 4;
        p.overloadCooldown = 20;
        event(w, 'overload', p);
    }
    w.dashReleased = !input.dash;
    w.overloadReleased = !input.overload;
    if (p.dashTime > 0) {
        p.angle = w.dashAngle;
        move(w, p, Math.cos(w.dashAngle) * p.speed * 3.2 * dt, Math.sin(w.dashAngle) * p.speed * 3.2 * dt);
    }
    else {
        const slow = w.slowUntil > w.time ? w.slowAmount : 0;
        if (length > .01)
            p.angle = Math.atan2(y, x);
        move(w, p, x * p.speed * (1 - slow) * dt, y * p.speed * (1 - slow) * dt);
    }
    if (w.time - w.lastDamage >= 4)
        p.shield = Math.min(p.maxShield, p.shield + w.shieldRegen * dt);
    if (w.utilities.U03 && w.time >= w.repairAt) {
        w.repairAt += 10;
        const cap = [8, 10, 12][w.utilities.U03 - 1], heal = Math.max(0, Math.min(utility(w, 'U03'), p.maxHp - p.hp, cap - w.repairAmount));
        p.hp += heal;
        w.repairAmount += heal;
        if (heal)
            event(w, 'heal', p, { amount: heal, source: 'U03' });
    }
    const pickup = (w.chassis === 'scavenger' ? 90 : CONFIG.pickupBase) + utility(w, 'U04');
    w.drops = w.drops.filter(drop => {
        if (distance(drop, p) > pickup)
            return true;
        w.stats.goldEarned += drop.value;
        event(w, 'pickup', drop, { amount: drop.value });
        if (w.utilities.U04 && w.time >= w.pickupAt) {
            p.dashCooldown = Math.max(0, p.dashCooldown - .2);
            w.pickupAt = w.time + 1;
        }
        return false;
    });
}
function stepFixed(w, input, dt) {
    if (w.status !== 'playing')
        return;
    if (!w.bossId && w.time + dt >= w.duration - 1e-8) {
        w.time = w.duration;
        w.tick++;
        complete(w, true);
        return;
    }
    w.time += dt;
    w.tick++;
    if (w.bossId && w.time >= 300) {
        complete(w, false, 'timeout');
        return;
    }
    tickPlayer(w, input, dt);
    tickSpawns(w);
    tickEnemyStatuses(w, dt);
    tickEnemies(w, dt);
    tickBoss(w, dt);
    tickWeapons(w, dt);
    tickBullets(w, dt);
    tickZones(w, dt);
    contactDamage(w);
    if (w.status === 'playing' && w.bossStarted && !w.enemies.some(e => e.kind === 'boss' && e.hp > 0 && !e.dead))
        complete(w, true);
    w.enemies = w.enemies.filter(e => !e.dead);
    w.events = w.events.filter(e => e.at >= w.time - 2).slice(-350);
}
/** Fixed 60Hz simulation. Rendering frequency does not alter combat rules or random draws. */
export function stepBattle(w, input, dt = 1 / 60) {
    if (w.status !== 'playing' || !Number.isFinite(dt) || dt <= 0)
        return;
    w.remainder += dt;
    while (w.remainder >= 1 / 60 - 1e-10 && w.status === 'playing') {
        w.remainder = Math.max(0, w.remainder - 1 / 60);
        stepFixed(w, input, 1 / 60);
    }
}
export function battleResult(w) {
    return { won: w.status === 'won', hp: w.player.hp, shield: w.player.shield, stats: JSON.parse(JSON.stringify(w.stats)), elapsed: w.time, insuranceUsed: w.insuranceUsed, rng: w.rng, ...(w.failureReason ? { reason: w.failureReason } : {}) };
}

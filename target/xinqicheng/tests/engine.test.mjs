import assert from 'node:assert/strict';
import { after, test } from 'node:test';
import fs from 'node:fs';
import { Game, TOWER_TYPES, campaignWaves } from '../web/engine.js';

const mechanics = JSON.parse(fs.readFileSync(new URL('../web/data/mechanics.json', import.meta.url)));
const options = { ...mechanics, seed: 703 };
const audit = { createdAt: new Date().toISOString(), scope: 'JavaScript reconstruction; structural probes are not claims of campaign victories.', checks: {}, campaign: [] };
const done = game => ['won', 'lost'].includes(game.phase);
const pointDistance = (a, b) => Math.hypot(a.x - b.x, a.y - b.y);

function fixture(overrides = {}, enemies = {}) {
  const level = {
    id: 0, width: 1024, height: 768, gold: 1000, lives: 20,
    paths: [{ id: 1, points: [{ x: 0, y: 300 }, { x: 512, y: 300 }, { x: 1024, y: 300 }] }],
    towerSlots: [{ id: 'a', x: 200, y: 350 }, { id: 'b', x: 500, y: 350 }, { id: 'c', x: 800, y: 350 }],
    waves: [{ id: 1, interval: 0, duration: 10, spawns: [{ enemy: 'dummy', path: 1, lane: 1, time: 2 }], events: [] }],
    manualWaves: [], lockedTowers: [], ...overrides
  };
  return new Game(level, { dummy: { name: 'test target', stats: { hp: 10000, speed: 10, gold: 5, armor: 0, basic_attack: { damage_min: 1, damage_max: 2, cooldown: 1 } } }, ...enemies }, options);
}

function advance(game, seconds, dt = .1) {
  const end = game.time + seconds;
  while (game.time < end - 1e-7 && !done(game)) game.update(Math.min(dt, end - game.time));
}

function assertFiniteState(game) {
  for (const key of ['time', 'gold', 'lives', 'wave', 'countdown']) assert.ok(Number.isFinite(game[key]), `${key} is finite`);
  assert.ok(game.gold >= 0, 'gold cannot go negative');
  for (const e of game.enemies) for (const k of ['x', 'y', 'hp', 'progress', 'speed']) assert.ok(Number.isFinite(e[k]), `${e.template}.${k} is finite`);
  for (const u of game.units) for (const k of ['x', 'y', 'hp']) assert.ok(Number.isFinite(u[k]), `unit.${k} is finite`);
}

function assertEconomy(game) {
  const spent = game.actions.filter(a => ['build', 'upgrade', 'clear-blocked'].includes(a.type)).reduce((s, a) => s + a.cost, 0);
  const refunds = game.actions.filter(a => a.type === 'sell').reduce((s, a) => s + a.refund, 0);
  const earlyWave = game.actions.filter(a => a.type === 'wave').reduce((s, a) => s + a.reward, 0);
  assert.equal(game.gold, game.level.gold + game.earned + refunds + earlyWave - spent, 'every coin is accounted for');
  return { initial: game.level.gold, killIncome: game.earned, earlyWave, refunds, spent, final: game.gold };
}

function playFirstLevel() {
  const g = new Game(mechanics.levels[0], mechanics.enemies, options);
  assert.equal(g.gold, 175);
  assert.ok(g.build('3', 'archer'));
  assert.ok(g.build('5', 'archer'));
  assert.ok(g.moveHero({ x: 565, y: 356 }));
  assert.ok(g.callWave());
  let decisionAt = 0;
  for (let frame = 0; frame < 9000 && !done(g); frame++) {
    if (g.time >= decisionAt) {
      decisionAt = g.time + 2;
      for (const id of ['2', '1', '4', '10', '6']) {
        const t = g.towers.find(t => t.id === id);
        if (!t.type && g.gold >= TOWER_TYPES.archer.cost) g.build(id, 'archer');
      }
      const visible = g.enemies.filter(e => e.x > 330 && e.x < 980 && e.y > 150 && e.y < 650);
      const dense = visible.map(e => ({ e, count: visible.filter(other => pointDistance(e, other) <= 60).length })).sort((a, b) => b.count - a.count)[0];
      if (dense) {
        if (dense.count >= 3 && g.spells.meteor <= 0) g.cast('meteor', dense.e);
        if (g.spells.reinforcements <= 0) g.cast('reinforcements', dense.e);
      }
      if (g.phase === 'waiting' && !g.enemies.length) g.callWave();
      assertFiniteState(g);
    }
    g.update(.1);
    // This is the UI event queue; draining it never changes simulation state.
    g.events.length = 0;
  }
  return g;
}

test('four baseline towers, Gerald, and difficulty stats match recovered data', () => {
  const g = new Game(mechanics.levels[0], mechanics.enemies, options);
  for (const [type, source] of Object.entries({ archer: 'archers', barracks: 'knights', mage: 'wizard', artillery: 'catapult' })) {
    const original = mechanics.towers[source].stats;
    const attack = original.basic_attack || original.soldier.basic_attack;
    for (let level = 1; level <= 4; level++) {
      const s = g.towerStats({ type, level });
      const value = v => Array.isArray(v) ? v[level - 1] : v;
      assert.equal(s.damageMin, value(attack.damage_min));
      assert.equal(s.damageMax, value(attack.damage_max));
      assert.equal(s.cooldown, value(attack.cooldown));
      assert.equal(s.prices[level - 1], original.price[level - 1]);
    }
  }
  assert.equal(g.hero.maxHp, 220);
  assert.equal(g.hero.damageMin, 10);
  assert.equal(g.hero.damageMax, 14);
  assert.equal(g.hero.attackCooldown, 2);
  assert.equal(g.hero.speed, 55);
  assert.equal(g.hero.respawnDuration, 30);
  const bandit = g.spawn({ enemy: 'enemy_bandit', path: 1, lane: 1 });
  const guard = g.spawn({ enemy: 'enemy_blackguard', path: 1, lane: 1 });
  assert.equal(bandit.maxHp, 40);
  assert.equal(guard.maxHp, 80);
  assert.equal(guard.gold, 8);
  assert.equal(guard.armor, .3);
  const hard = new Game(mechanics.levels[0], mechanics.enemies, { ...options, difficulty: 'hard' });
  assert.equal(hard.spawn({ enemy: 'enemy_blackguard', path: 1, lane: 1 }).maxHp, 100);
  audit.checks.recoveredStats = true;
});

test('first level can be won using only public player actions and original resources', () => {
  const g = playFirstLevel();
  assert.equal(g.phase, 'won');
  assert.equal(g.wave, 5);
  assert.ok(g.lives > 0 && g.lives <= 20);
  assert.ok(g.actions.some(a => a.type === 'meteor'));
  assert.ok(g.actions.some(a => a.type === 'reinforcements'));
  assert.ok(g.towers.filter(t => t.type).every(t => t.level === 1));
  audit.firstLevelPlayerStrategy = { snapshot: g.snapshot(), economy: assertEconomy(g), actions: g.actions, mutations: 'No gold, lives, damage, enemy health, wave, or position assignments; public build/moveHero/callWave/cast/update only.' };
});

test('all 18 campaigns simulate without invalid state, and no-operation first level loses', () => {
  for (const level of mechanics.levels) {
    const g = new Game(level, mechanics.enemies, options);
    assert.ok(g.callWave());
    for (let frame = 0; frame < 12000 && !done(g); frame++) {
      g.update(.25);
      if (g.phase === 'waiting' && g.countdown < 0) g.callWave();
      if (frame % 40 === 0) assertFiniteState(g);
      g.events.length = 0;
    }
    assert.ok(done(g), `level ${level.id} terminates with no combat input`);
    assert.equal(g.phase, 'lost', `level ${level.id} is not automatically won`);
    assertEconomy(g);
    audit.campaign.push({ level: level.id, noOperation: g.snapshot(), testedVictory: level.id === 1 });
  }
  audit.checks.noOperationLosses = 18;
});

test('pause freezes combat, queues, projectiles, countdowns and spell cooldowns', () => {
  const g = fixture();
  g.build('a', 'archer');
  g.callWave();
  g.cast('meteor', { x: 200, y: 300 });
  advance(g, .2);
  g.setPaused(true);
  const state = () => JSON.stringify({ snapshot: g.snapshot(), queue: g.queue, units: g.units, enemies: g.enemies, projectiles: g.projectiles, timers: g.towers.map(t => t.timer), rng: g.rng });
  const frozen = state();
  for (let i = 0; i < 100; i++) g.update(.25);
  assert.equal(state(), frozen);
  assert.equal(g.build('b', 'archer'), false);
  assert.match(g.lastError, /继续/);
  assert.equal(state(), frozen);
  g.setPaused(false);
  g.update(.1);
  assert.ok(g.time > .2);
  assert.ok(g.spells.meteor < 59.8);
  audit.checks.pause = true;
});

test('build, upgrade, refund, tower locks, blocked holders and gifted towers respect economy', () => {
  const g = fixture();
  assert.ok(g.build('a', 'archer'));
  assert.equal(g.gold, 930);
  assert.ok(g.upgrade('a'));
  assert.equal(g.gold, 830);
  assert.equal(g.sellValue(g.towers[0]), 170);
  assert.ok(g.sell('a'));
  assert.equal(g.gold, 1000);
  assert.ok(g.build('a', 'archer'));
  assert.ok(g.callWave());
  assert.ok(g.upgrade('a'));
  assert.equal(g.sellValue(g.towers[0]), 102);
  assert.ok(g.sell('a'));
  assert.equal(g.gold, 932);
  assertEconomy(g);
  const first = new Game(mechanics.levels[0], mechanics.enemies, options);
  assert.equal(first.maxTowerLevel('archer'), 1);
  assert.ok(first.build('3', 'mage'), 'level 1 allows the four baseline tower types');
  assert.equal(first.upgrade('3'), false);
  assert.match(first.lastError, /等级上限/);
  assert.equal(first.build('5', 'artillery'), false, 'insufficient funds cannot create a tower');
  assert.equal(first.gold, 75);
  const blocked = new Game(mechanics.levels[9], mechanics.enemies, options);
  const holder = blocked.towers.find(t => t.blocked);
  assert.equal(blocked.build(holder.id, 'archer'), false);
  assert.equal(blocked.clearCost(holder), 100);
  assert.ok(blocked.clearBlocked(holder.id));
  assert.ok(blocked.build(holder.id, 'archer'));
  assert.equal(blocked.gold, 1130);
  assertEconomy(blocked);
  const gift = new Game(mechanics.levels[1], mechanics.enemies, options);
  const prebuilt = gift.towers.find(t => t.existingTower);
  assert.equal(prebuilt.type, 'mage');
  assert.equal(prebuilt.level, 1);
  assert.equal(gift.gold, 300);
  assert.equal(gift.sellValue(prebuilt), 0);
  assert.ok(gift.upgrade(prebuilt.id));
  assert.equal(gift.sellValue(prebuilt), 150);
  assert.ok(gift.sell(prebuilt.id));
  assert.equal(gift.gold, 300);
  audit.checks.economy = true;
});

test('early-call rewards are seconds remaining and cannot be collected twice', () => {
  const g = fixture({ towerSlots: [], waves: [{ id: 1, interval: 0, duration: 0, spawns: [], events: [] }, { id: 2, interval: 15, duration: 10, spawns: [{ enemy: 'dummy', path: 1, lane: 1, time: 5 }], events: [] }] });
  g.callWave();
  g.update(.1);
  assert.equal(g.phase, 'waiting');
  const reward = Math.round(g.countdown);
  const gold = g.gold;
  assert.ok(g.callWave());
  assert.equal(g.gold, gold + reward);
  assert.equal(g.callWave(), false);
  assert.equal(g.gold, gold + reward);
  assertEconomy(g);
  audit.checks.waveReward = true;
});

test('physical armor, magic armor and explosion protection are distinct', () => {
  const g = fixture();
  const e = g.spawn({ enemy: 'dummy', path: 1, lane: 1 });
  e.armor = .75;
  e.magicArmor = .2;
  assert.equal(g.hit(e, 100, 'physical'), 25);
  assert.equal(g.hit(e, 100, 'magic'), 80);
  assert.equal(g.hit(e, 100, 'explosive'), 62);
  assert.equal(g.hit(e, 100, 'true'), 100);
  e.armor = 1;
  assert.equal(g.hit(e, 100, 'physical'), 0);
  assert.equal(g.hit(e, 100, 'magic'), 80);
  audit.checks.damageTypes = true;
});

test('one defender blocks one enemy and reinforcements expire on schedule', () => {
  const g = fixture({ paths: [{ id: 1, points: [{ x: 390, y: 300 }, { x: 1024, y: 300 }] }], towerSlots: [{ id: 'a', x: 390, y: 320 }] });
  for (let i = 0; i < 3; i++) g.spawn({ enemy: 'dummy', path: 1, lane: 1 });
  g.update(.1);
  assert.equal(g.enemies.filter(e => e.blocked).length, 1);
  assert.equal(new Set(g.enemies.filter(e => e.blocked).map(e => e.blockerId)).size, 1);
  assert.ok(g.enemies.filter(e => !e.blocked).every(e => e.progress > 0));
  const group = fixture({ paths: [{ id: 1, points: [{ x: 390, y: 300 }, { x: 1024, y: 300 }] }], towerSlots: [{ id: 'a', x: 390, y: 320 }] });
  const singleEnemy = group.spawn({ enemy: 'dummy', path: 1, lane: 1 });
  assert.ok(group.cast('reinforcements', { x: 390, y: 300 }));
  group.update(.1);
  assert.equal(group.units.filter(u => u.engaged === singleEnemy.id).length, 3, 'multiple defenders may attack one enemy without blocking other enemies');
  const spells = fixture();
  assert.ok(spells.cast('reinforcements', { x: 512, y: 300 }));
  assert.equal(spells.units.filter(u => u.kind === 'reinforcement').length, 2);
  assert.equal(spells.spells.reinforcements, 15);
  assert.equal(spells.cast('reinforcements', { x: 512, y: 300 }), false);
  advance(spells, 11.9);
  assert.equal(spells.units.filter(u => u.kind === 'reinforcement').length, 2);
  advance(spells, .2);
  assert.equal(spells.units.filter(u => u.kind === 'reinforcement').length, 0);
  assert.ok(spells.spells.reinforcements > 0);
  advance(spells, 3);
  assert.ok(spells.cast('reinforcements', { x: 512, y: 300 }));
  assert.ok(spells.cast('meteor', { x: 512, y: 300 }));
  assert.equal(spells.projectiles.filter(p => p.type === 'meteor').length, 3);
  assert.equal(spells.spells.meteor, 60);
  audit.checks.defenderAndSpells = true;
});

test('soldiers and Gerald respawn after recovered delays', () => {
  const g = fixture();
  assert.ok(g.build('a', 'barracks'));
  const soldiers = g.units.filter(u => u.kind === 'soldier');
  assert.equal(soldiers.length, 3);
  assert.ok(soldiers.every(u => u.maxHp === 40 && u.armor === .1));
  const oldIds = new Set(soldiers.map(u => u.id));
  for (const u of soldiers) u.hp = 0; // Isolated lifecycle test; not a campaign run.
  g.update(.1);
  advance(g, 11.8);
  assert.equal(g.units.filter(u => u.kind === 'soldier').length, 0);
  advance(g, .4);
  assert.equal(g.units.filter(u => u.kind === 'soldier').length, 3);
  assert.ok(g.units.filter(u => u.kind === 'soldier').every(u => !oldIds.has(u.id)));
  g.damageUnit(g.hero, { damageMin: 10000, damageMax: 10000, damageType: 'true' });
  assert.equal(g.hero.respawn, 30);
  advance(g, 29.9);
  assert.ok(g.hero.hp <= 0);
  advance(g, .2);
  assert.equal(g.hero.hp, g.hero.maxHp);
  audit.checks.respawns = true;
});

test('every original path, regular spawn and manual boss support spawn resolves to an exit', () => {
  let probes = 0, paths = 0, regular = 0, support = 0, bosses = 0;
  for (const level of mechanics.levels) {
    const g = new Game(level, mechanics.enemies, options);
    const waveData = campaignWaves(level);
    const ordinary = waveData.filter(w => w.kind === 'regular').flatMap(w => w.spawns);
    assert.equal(ordinary.length, level.waves.reduce((n, w) => n + w.spawns.length, 0));
    const originalManual = level.manualWaves.filter(w => /^boss/i.test(w.id));
    const extra = waveData.filter(w => w.kind === 'boss').flatMap(w => w.spawns);
    assert.equal(extra.filter(s => !s.boss).length, originalManual.reduce((n, w) => n + w.spawns.length, 0), `level ${level.id} has every manual support enemy`);
    assert.equal(waveData.filter(w => w.kind === 'boss').flatMap(w => w.events).length, originalManual.reduce((n, w) => n + w.events.length, 0), `level ${level.id} retains manual events`);
    regular += ordinary.length;
    support += extra.filter(s => !s.boss).length;
    bosses += extra.filter(s => s.boss).length;
    const route = descriptor => {
      const e = g.spawn(descriptor);
      assert.ok(e.hp > 0 && e.speed > 0);
      for (const k of ['x', 'y', 'hp', 'speed', 'armor', 'magicArmor', 'gold', 'damageMin', 'damageMax', 'attackCooldown', 'lives']) assert.ok(Number.isFinite(e[k]), `level ${level.id} ${e.template}.${k}`);
      const expected = [e.path.id];
      while (g.connections.has(expected.at(-1))) expected.push(g.connections.get(expected.at(-1)));
      const journey = g.remainingDistance(e);
      assert.ok(journey >= 0 && Number.isFinite(journey));
      g.events.length = 0;
      // Deliberately calls the transport primitive, not a combat/victory simulation.
      // Each probe is allowed to leak; no artificial resources are granted.
      g.advanceEnemy(e, (journey + 1) / e.speed);
      assert.deepEqual(e.route, expected);
      assert.equal(e.hp, -Infinity);
      assert.equal(g.events.filter(e => e.type === 'leak').length, 1);
      g.enemies.length = 0;
      probes++;
    };
    for (const p of g.paths.values()) { route({ enemy: ordinary[0].enemy, path: p.id, lane: p.lane, node: 1 }); paths++; }
    for (const w of waveData) for (const s of w.spawns) route(s);
  }
  assert.equal(regular, 6879);
  assert.equal(bosses, 9);
  audit.checks.transport = { probes, pathsAndLanes: paths, regularSpawns: regular, manualSupportSpawns: support, explicitBossEntities: bosses, allReachedAnExit: true, isCombatVictoryTest: false };
});

test('bosses prevent premature victory and final stage includes illusions plus real Veznan', () => {
  const stage = new Game(mechanics.levels[17], mechanics.enemies, options);
  assert.equal(stage.totalWaves, 17);
  const bosses = stage.campaignWaves.flatMap(w => w.spawns.filter(s => s.boss));
  assert.equal(bosses.filter(s => s.enemy === 'enemy_stage_18_veznan_illusion').length, 3);
  assert.equal(bosses.filter(s => s.enemy === 'enemy_stage_18_veznan').length, 1);
  for (const descriptor of bosses) {
    const e = stage.spawn(descriptor);
    assert.ok(e.boss && e.maxHp > 1000);
  }
  const g = fixture({ towerSlots: [], waves: [], manualWaves: [{ id: 'BOSS1', interval: 0, duration: 1, events: [], spawns: [{ enemy: 'boss', path: 1, lane: 1, time: 0, boss: true }] }] }, { boss: { base: 'boss_base', stats: { hp: 1000, speed: 0, armor: 0, gold: 1, lives: 999 } } });
  assert.ok(g.callWave());
  advance(g, 5);
  assert.equal(g.phase, 'playing');
  assert.equal(g.enemies.length, 1);
  g.hit(g.enemies[0], 1000, 'true'); // Synthetic gate test; not a real boss victory claim.
  g.update(.1);
  assert.equal(g.phase, 'won');
  audit.checks.bossGating = true;
});

after(() => fs.writeFileSync(new URL('../analysis/engine-gameplay-test-results.json', import.meta.url), JSON.stringify(audit, null, 2) + '\n'));

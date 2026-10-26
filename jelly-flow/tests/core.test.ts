import assert from 'node:assert/strict';
import test from 'node:test';
import { cloneState, createState, getHint, releaseQueue } from '../src/core.ts';
import type { CandyColor, GameState, Level } from '../src/core.ts';
import { LEVELS } from '../src/levels.ts';

const COLORS: CandyColor[] = ['pink', 'yellow', 'mint', 'purple'];

function fixture(overrides: Partial<Level> = {}): Level {
  return {
    id: 1001, name: 'Test workshop', subtitle: 'Deterministic fixture',
    queues: [['purple', 'purple'], ['pink', 'pink'], ['pink'], ['yellow'], ['mint']],
    cups: [
      { color: 'pink', capacity: 2 }, { color: 'yellow', capacity: 1 },
      { color: 'mint', capacity: 1 }, { color: 'purple', capacity: 2 },
      { color: 'pink', capacity: 1 },
    ],
    bufferSize: 2, solution: [0, 1, 2, 3, 4], par: 5, ...overrides,
  };
}

function checkInvariant(state: GameState): void {
  const outstanding = state.queues.flat().concat(state.buffer);
  assert.equal(state.collected + outstanding.length, state.total, 'candy must never disappear or duplicate');
  assert.ok(Number.isInteger(state.moves) && state.moves >= 0);
  assert.ok(state.collected >= 0 && state.collected <= state.total);
  assert.equal(state.activeCups.length, 3, 'exactly three active cup slots');
  const cups = [...state.activeCups.filter(c => c !== null), ...state.pendingCups];
  assert.equal(new Set(cups.map(c => c.id)).size, cups.length, 'remaining cup ids stay unique');
  for (const cup of cups) {
    assert.ok(Number.isInteger(cup.capacity) && cup.capacity > 0);
    assert.ok(Number.isInteger(cup.filled) && cup.filled >= 0 && cup.filled <= cup.capacity);
  }
  for (const color of COLORS) {
    const supply = outstanding.filter(c => c === color).length;
    const demand = cups.filter(c => c.color === color).reduce((n, c) => n + c.capacity - c.filled, 0);
    assert.equal(supply, demand, `${color} supply and outstanding demand remain equal`);
  }
  if (state.status !== 'lost') assert.ok(state.buffer.length <= state.bufferSize);
  if (state.status === 'won') {
    assert.equal(state.collected, state.total);
    assert.equal(outstanding.length, 0);
    assert.equal(cups.length, 0);
  }
}

function oracleCanWin(initial: GameState): boolean {
  const cache = new Map<string, boolean>();
  const search = (s: GameState): boolean => {
    if (s.status === 'won') return true;
    if (s.status === 'lost') return false;
    const key = JSON.stringify([s.queues, s.activeCups, s.pendingCups, s.buffer]);
    if (cache.has(key)) return cache.get(key)!;
    for (let i = 0; i < s.queues.length; i++) {
      if (!s.queues[i].length) continue;
      if (search(releaseQueue(s, i).state)) {
        cache.set(key, true); return true;
      }
    }
    cache.set(key, false); return false;
  };
  return search(initial);
}

test('the campaign contains exactly 20 uniquely numbered levels and legal inventory', () => {
  assert.equal(LEVELS.length, 20);
  assert.deepEqual(LEVELS.map(l => l.id), Array.from({ length: 20 }, (_, i) => i + 1));
  for (const level of LEVELS) {
    assert.ok(level.name.length > 0 && level.subtitle.length > 0);
    assert.ok(level.queues.length >= 1 && level.queues.length <= 6);
    assert.ok(level.queues.every(q => q.length > 0));
    assert.ok(level.queues.flat().every(c => COLORS.includes(c)));
    assert.ok(level.solution.length > 0, `level ${level.id} has a solution certificate`);
    assert.ok(level.par > 0);
    checkInvariant(createState(level));
  }
});

for (let id = 1; id <= 20; id++) {
  test(`level ${id}: published solution wins with conservation after every move`, () => {
    const level = LEVELS[id - 1];
    const untouched = structuredClone(level);
    let state = createState(level);
    for (const queue of level.solution) {
      assert.equal(state.status, 'playing', `level ${id}: no redundant certificate moves`);
      assert.ok(state.queues[queue]?.length, `level ${id}: solution chooses a nonempty queue`);
      const before = structuredClone(state);
      const result = releaseQueue(state, queue);
      assert.deepEqual(state, before, 'transition does not mutate its input');
      assert.equal(result.state.moves, state.moves + 1);
      state = result.state;
      checkInvariant(state);
    }
    assert.equal(state.status, 'won', `level ${id} certificate reaches victory`);
    assert.ok(state.moves <= level.par, `level ${id} is completable within its published par`);
    assert.deepEqual(level, untouched, 'campaign configuration is never mutated');
  });
}

test('buffer exactly at capacity is safe; a completed cup drains buffer and chains replacement', () => {
  let state = createState(fixture());
  state = releaseQueue(state, 0).state;
  assert.equal(state.status, 'playing');
  assert.deepEqual(state.buffer, ['purple', 'purple']);
  const previousCupIds = state.activeCups.map(c => c?.id);
  const next = releaseQueue(state, 1);
  assert.equal(next.state.collected, 4);
  assert.deepEqual(next.state.buffer, []);
  assert.equal(next.state.activeCups[0]?.color, 'pink');
  assert.equal(next.state.activeCups[0]?.filled, 0);
  assert.equal(next.state.activeCups[1]?.id, previousCupIds[1]);
  assert.equal(next.state.activeCups[2]?.id, previousCupIds[2]);
  assert.equal(next.events.filter(e => e.type === 'complete').length, 2);
  checkInvariant(next.state);
});

test('buffer overflow loses without losing track of candies', () => {
  const level = fixture({
    queues: [['purple', 'purple', 'purple'], ['pink', 'pink'], ['pink'], ['yellow'], ['mint']],
    cups: [
      { color: 'pink', capacity: 2 }, { color: 'yellow', capacity: 1 },
      { color: 'mint', capacity: 1 }, { color: 'purple', capacity: 3 }, { color: 'pink', capacity: 1 },
    ],
  });
  const result = releaseQueue(createState(level), 0);
  assert.equal(result.state.status, 'lost');
  assert.ok(result.state.buffer.length > level.bufferSize);
  assert.equal(result.events.filter(e => e.type === 'lose').length, 1);
  checkInvariant(result.state);
});

test('only the contiguous front color is released', () => {
  const level = fixture({
    queues: [['pink', 'pink', 'purple', 'pink']],
    cups: [{ color: 'pink', capacity: 3 }, { color: 'purple', capacity: 1 }],
    solution: [0, 0, 0], par: 3,
  });
  const result = releaseQueue(createState(level), 0);
  assert.deepEqual(result.state.queues[0], ['purple', 'pink']);
  assert.equal(result.state.collected, 2);
  assert.equal(result.state.activeCups[0]?.filled, 2);
  checkInvariant(result.state);
});

test('same-color cups fill in ascending slot order', () => {
  const level = fixture({
    queues: [['pink', 'pink', 'pink']],
    cups: [{ color: 'pink', capacity: 1 }, { color: 'pink', capacity: 2 }],
    solution: [0], par: 1,
  });
  const state = createState(level);
  const result = releaseQueue(state, 0);
  const completed = result.events.filter(e => e.type === 'complete');
  assert.equal(completed.length, 2);
  assert.equal(completed[0].slot, 0);
  assert.equal(completed[1].slot, 1);
  assert.equal(result.state.status, 'won');
});

test('invalid, empty, and terminal inputs are no-ops', () => {
  const state = createState(fixture());
  for (const i of [-1, state.queues.length, 1.5, NaN, Infinity]) {
    const result = releaseQueue(state, i);
    assert.deepEqual(result.state, state);
    assert.deepEqual(result.events, []);
  }
  const emptied = releaseQueue(state, 0).state;
  assert.deepEqual(releaseQueue(emptied, 0), { state: emptied, events: [] });
  let won = state;
  for (const i of fixture().solution) won = releaseQueue(won, i).state;
  assert.equal(won.status, 'won');
  assert.deepEqual(releaseQueue(won, 0), { state: won, events: [] });
  const lost = releaseQueue(createState(fixture({ bufferSize: 1 })), 0).state;
  assert.equal(lost.status, 'lost');
  assert.deepEqual(releaseQueue(lost, 1), { state: lost, events: [] });
});

test('clones independently own queue, cup, pending and buffer data', () => {
  const state = releaseQueue(createState(fixture()), 0).state;
  const before = structuredClone(state);
  const copy = cloneState(state);
  assert.deepEqual(copy, state);
  copy.queues[1].pop();
  copy.activeCups[0]!.filled++;
  copy.pendingCups[0].capacity++;
  copy.buffer.pop();
  assert.deepEqual(state, before);
});

test('hints choose a provably winning action and never recommend a known overflow', () => {
  const level = fixture({ bufferSize: 1 });
  const initial = createState(level);
  assert.equal(oracleCanWin(initial), true);
  const hint = getHint(initial);
  assert.notEqual(hint, null, 'small solvable fixture should yield a hint');
  assert.notEqual(hint, 0, 'the first queue overflows immediately');
  assert.equal(oracleCanWin(releaseQueue(initial, hint!).state), true);
  let state = initial;
  for (let n = 0; n < 12 && state.status === 'playing'; n++) {
    const before = structuredClone(state);
    const move = getHint(state);
    assert.deepEqual(state, before, 'hint search must not change game state');
    assert.notEqual(move, null);
    state = releaseQueue(state, move!).state;
    assert.equal(oracleCanWin(state), true);
  }
  assert.equal(state.status, 'won');
  assert.equal(getHint(state), null);
  const lost = releaseQueue(initial, 0).state;
  assert.equal(getHint(lost), null);
});

test('reachable fixture states get either no hint or a verified winning move', () => {
  const seen = new Set<string>();
  const visit = (s: GameState) => {
    const key = JSON.stringify(s);
    if (seen.has(key)) return;
    seen.add(key);
    const hint = getHint(s);
    if (hint !== null) {
      assert.ok(s.queues[hint]?.length);
      assert.equal(oracleCanWin(releaseQueue(s, hint).state), true);
    }
    if (s.status !== 'playing') return;
    for (let i = 0; i < s.queues.length; i++) {
      if (s.queues[i].length) visit(releaseQueue(s, i).state);
    }
  };
  visit(createState(fixture({ bufferSize: 1 })));
  assert.ok(seen.size > 10);
});

test('deterministic randomized action runs preserve state and inventory invariants', () => {
  let seed = 20261026;
  const random = () => {
    seed = (Math.imul(seed, 1664525) + 1013904223) >>> 0;
    return seed / 0x100000000;
  };
  for (const level of LEVELS) {
    for (let run = 0; run < 40; run++) {
      let state = createState(level);
      for (let step = 0; step < level.queues.flat().length && state.status === 'playing'; step++) {
        const choices = state.queues.map((q, i) => q.length ? i : -1).filter(i => i >= 0);
        assert.ok(choices.length > 0, 'nonterminal state must have a usable queue');
        const choice = choices[Math.floor(random() * choices.length)];
        const frozen = structuredClone(state);
        const a = releaseQueue(state, choice);
        const b = releaseQueue(state, choice);
        assert.deepEqual(a, b, 'same state and input produce identical events and state');
        assert.deepEqual(state, frozen);
        state = a.state;
        checkInvariant(state);
      }
    }
  }
});

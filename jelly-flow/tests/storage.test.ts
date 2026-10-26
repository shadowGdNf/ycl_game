import assert from 'node:assert/strict';
import test from 'node:test';
import { freshSave, readSave, sanitizeSave, writeSave } from '../src/storage.ts';

function withStorage(storage: { getItem(key: string): string | null; setItem(key: string, value: string): void }, run: () => void): void {
  const descriptor = Object.getOwnPropertyDescriptor(globalThis, 'localStorage');
  Object.defineProperty(globalThis, 'localStorage', { configurable: true, value: storage });
  try { run(); } finally {
    if (descriptor) Object.defineProperty(globalThis, 'localStorage', descriptor);
    else Reflect.deleteProperty(globalThis, 'localStorage');
  }
}

test('missing, invalid and unknown-version saves safely start a fresh campaign', () => {
  for (const raw of [undefined, null, false, 12, 'saved', [], {}, { version: 0 }, { version: 2 }, { version: '1' }]) {
    assert.deepEqual(sanitizeSave(raw), freshSave());
  }
});

test('fresh saves own independent mutable containers', () => {
  const a = freshSave();
  const b = freshSave();
  a.history.push(1);
  a.best['1'] = { moves: 4, stars: 3 };
  assert.deepEqual(b, freshSave());
});

test('valid partial saves retain preferences and clamp current level to unlocked progress', () => {
  const result = sanitizeSave({ version: 1, unlocked: 8, level: 20, sound: false, tutorialSeen: true });
  assert.equal(result.unlocked, 8);
  assert.equal(result.level, 8);
  assert.equal(result.sound, false);
  assert.equal(result.tutorialSeen, true);
  assert.deepEqual(result.best, {});
  assert.deepEqual(result.history, []);
});

test('save bounds reject out-of-campaign, fractional and nonnumeric progress', () => {
  for (const n of [-1, 0, 21, Infinity, NaN, 3.5, '4', null]) {
    const result = sanitizeSave({ version: 1, unlocked: n, level: n, sound: 'false', tutorialSeen: 'true' });
    assert.equal(result.unlocked, 1);
    assert.equal(result.level, 1);
    assert.equal(result.sound, true);
    assert.equal(result.tutorialSeen, false);
  }
});

test('assist count survives valid saves and rejects corrupt or unbounded values', () => {
  assert.equal(sanitizeSave({ version: 1 }).assists, 0);
  for (const assists of [0, 1, 2, 1000]) {
    assert.equal(sanitizeSave({ version: 1, assists }).assists, assists);
  }
  for (const assists of [-1, 1001, Infinity, NaN, 1.5, '2', null, true]) {
    assert.equal(sanitizeSave({ version: 1, assists }).assists, 0);
  }
});

test('valid history and scores are copied while corrupt score entries are dropped', () => {
  const raw = {
    version: 1, unlocked: 20, level: 20, history: [0, 2, 5, 1],
    best: {
      '1': { moves: 6, stars: 3 }, '20': { moves: 30, stars: 1 },
      '0': { moves: 1, stars: 3 }, '21': { moves: 1, stars: 3 },
      '2': { moves: 0, stars: 3 }, '3': { moves: 2, stars: 4 },
      '4': { moves: '2', stars: 2 }, '5': null,
      '6': { moves: 4.5, stars: 2 }, '7': { moves: 1000, stars: 2 },
    },
  };
  const result = sanitizeSave(raw);
  assert.deepEqual(result.best, { '1': { moves: 6, stars: 3 }, '20': { moves: 30, stars: 1 } });
  assert.deepEqual(result.history, [0, 2, 5, 1]);
  raw.history.push(3);
  raw.best['1'].stars = 1;
  assert.deepEqual(result.history, [0, 2, 5, 1]);
  assert.equal(result.best['1'].stars, 3);
});

test('malformed or unbounded histories are discarded', () => {
  for (const history of ['0,1', null, [0, -1], [0, 8], [0, 0.5], [0, '1'], Array(501).fill(0)]) {
    assert.deepEqual(sanitizeSave({ version: 1, history }).history, []);
  }
});

test('storage round trip retains a valid save and uses a stable namespace', () => {
  const memory = new Map<string, string>();
  withStorage({
    getItem: key => memory.get(key) ?? null,
    setItem: (key, value) => { memory.set(key, value); },
  }, () => {
    assert.deepEqual(readSave(), freshSave());
    const save = { ...freshSave(), unlocked: 3, level: 2, history: [0, 1], sound: false, assists: 2 };
    assert.equal(writeSave(save), true);
    assert.equal(memory.size, 1);
    assert.ok(memory.has('jelly-flow-save-v1'));
    assert.deepEqual(readSave(), save);
  });
});

test('corrupt JSON, blocked storage and quota errors never crash play', () => {
  withStorage({ getItem: () => '{bad JSON', setItem: () => {} }, () => {
    assert.deepEqual(readSave(), freshSave());
  });
  withStorage({
    getItem: () => { throw new Error('Storage blocked'); },
    setItem: () => { throw new Error('Quota exceeded'); },
  }, () => {
    assert.deepEqual(readSave(), freshSave());
    assert.equal(writeSave(freshSave()), false);
  });
});

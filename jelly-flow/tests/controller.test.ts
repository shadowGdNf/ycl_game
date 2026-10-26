import assert from 'node:assert/strict';
import test from 'node:test';
import { readFileSync } from 'node:fs';
import vm from 'node:vm';
import ts from 'typescript';
import * as core from '../src/core.ts';
import { LEVELS } from '../src/levels.ts';
import { freshSave, sanitizeSave } from '../src/storage.ts';
import type { SaveData } from '../src/storage.ts';

// This is a controller test harness, not a browser/layout substitute. It runs
// the actual app.ts with deterministic timers and minimal native-element stubs.
class ElementStub {
  textContent = ''; disabled = false; hidden = false; open = false;
  type = ''; className = ''; children: ElementStub[] = [];
  attrs = new Map<string, string>(); handlers = new Map<string, Function[]>();
  style = { width: '', setProperty() {} }; classList = { toggle() {}, add() {}, remove() {} };
  parentElement = { setAttribute() {} };
  setAttribute(k: string, v: string) { this.attrs.set(k, v); }
  querySelector() { return null; }
  replaceChildren(...children: ElementStub[]) { this.children = children; }
  append(...children: ElementStub[]) { this.children.push(...children); }
  addEventListener(name: string, cb: Function) { this.handlers.set(name, [...this.handlers.get(name) ?? [], cb]); }
  click() { if (!this.disabled) for (const cb of this.handlers.get('click') ?? []) cb({ target: this }); }
  close() { this.open = false; }
  showModal() { this.open = true; }
  getBoundingClientRect() { return { left: 0, right: 100, top: 0, bottom: 100 }; }
  matches() { return false; }
}

const appSource = readFileSync(new URL('../src/app.ts', import.meta.url), 'utf8');
const controllerCode = ts.transpileModule(appSource, {
  compilerOptions: { target: ts.ScriptTarget.ES2022, module: ts.ModuleKind.CommonJS },
}).outputText;

function harness(initial: unknown = freshSave()) {
  const elements = new Map<string, ElementStub>();
  const element = (id: string) => {
    if (!elements.has(id)) elements.set(id, new ElementStub());
    return elements.get(id)!;
  };
  let saved = sanitizeSave(initial), nextTimer = 1;
  const timers = new Map<number, { cb: Function; delay: number }>();
  const windowHandlers = new Map<string, Function[]>();
  let renderer: RendererStub;
  class RendererStub {
    state: core.GameState | null = null;
    onQueue: (i: number) => void;
    constructor(_canvas: unknown, onQueue: (i: number) => void) { this.onQueue = onQueue; renderer = this; }
    setState(state: core.GameState) { this.state = state; }
    animate(_before: core.GameState, after: core.GameState) { this.state = after; }
    cancel() {} showHint() {}
  }
  class AudioStub { enabled = true; unlock() {} tap() {} flow() {} win() {} lose() {} }
  const dependencies: Record<string, unknown> = {
    './core.ts': core, './levels.ts': { LEVELS },
    './renderer.ts': { GameRenderer: RendererStub, COLORS: Object.fromEntries(['pink', 'yellow', 'mint', 'purple'].map(c => [c, { name: c, fill: c }])) },
    './audio.ts': { CandyAudio: AudioStub },
    './storage.ts': { readSave: () => structuredClone(saved), writeSave: (data: SaveData) => { saved = structuredClone(data); return true; } },
  };
  vm.runInNewContext(controllerCode, {
    exports: {}, require: (name: string) => {
      assert.ok(name in dependencies, `known dependency ${name}`); return dependencies[name];
    },
    document: { getElementById: element, createElement: () => new ElementStub(), addEventListener() {}, hidden: false },
    window: {
      setTimeout: (cb: Function, delay: number) => { const id = nextTimer++; timers.set(id, { cb, delay }); return id; },
      clearTimeout: (id: number) => timers.delete(id),
      matchMedia: () => ({ matches: false }),
      addEventListener: (name: string, cb: Function) => windowHandlers.set(name, [...windowHandlers.get(name) ?? [], cb]),
    },
    console, Blob, URL,
  });
  return {
    element,
    state: () => renderer!.state!,
    saved: () => structuredClone(saved),
    move: (i: number) => renderer!.onQueue(i),
    finishAnimation: () => {
      for (const [id, timer] of [...timers]) if (timer.delay <= 1000) { timers.delete(id); timer.cb(); }
    },
    pagehide: () => { for (const cb of windowHandlers.get('pagehide') ?? []) cb(); },
    openDialogs: () => ['level-dialog', 'help-dialog', 'result-dialog'].filter(id => element(id).open),
  };
}

test('controller restores a partial run and undo after reload preserves the assist count', () => {
  const history = LEVELS[0].solution.slice(0, 2);
  const seeded = { ...freshSave(), tutorialSeen: true, history, assists: 1 };
  const game = harness(seeded);
  let expected = core.createState(LEVELS[0]);
  for (const q of history) expected = core.releaseQueue(expected, q).state;
  assert.deepEqual(game.state(), expected);
  game.element('undo-btn').click();
  assert.equal(game.state().moves, 1);
  assert.equal(game.saved().assists, 2);
  assert.deepEqual(game.saved().history, history.slice(0, 1));
  const reloaded = harness(game.saved());
  assert.deepEqual(reloaded.state(), game.state());
  assert.equal(reloaded.saved().assists, 2);
});

test('controller commits victory before animation so immediate pagehide cannot erase completion', () => {
  const solution = LEVELS[0].solution;
  const game = harness({ ...freshSave(), history: solution.slice(0, -1), tutorialSeen: true });
  game.move(solution.at(-1)!);
  assert.equal(game.state().status, 'won');
  game.pagehide();
  assert.equal(game.saved().unlocked, 2, 'next level must be unlocked before the delayed celebration');
  assert.equal(game.saved().best['1']?.stars, 3, 'win record survives reload during animation');
  assert.deepEqual(game.saved().history, []);
  assert.equal(harness(game.saved()).saved().unlocked, 2);
});

test('a modal opened during the last animation does not stack with the result modal', () => {
  const solution = LEVELS[0].solution;
  const game = harness({ ...freshSave(), history: solution.slice(0, -1), tutorialSeen: true });
  game.move(solution.at(-1)!);
  game.element('help-btn').click();
  game.finishAnimation();
  assert.ok(game.openDialogs().length <= 1, `only one modal at a time, got ${game.openDialogs().join(', ')}`);
});

test('restart invalidates an outstanding animation callback and clears run history', () => {
  const game = harness();
  game.move(LEVELS[0].solution[0]);
  game.element('restart-btn').click();
  game.finishAnimation();
  assert.deepEqual(game.state(), core.createState(LEVELS[0]));
  assert.deepEqual(game.saved().history, []);
  assert.deepEqual(game.openDialogs(), []);
});

test('rapid repeated actions while animation is running commit only once', () => {
  const game = harness();
  game.move(LEVELS[0].solution[0]);
  game.move(LEVELS[0].solution[1]);
  game.move(LEVELS[0].solution[1]);
  assert.equal(game.state().moves, 1);
  assert.equal(game.saved().history.length, 1);
});

/** Pure, deterministic game rules. The renderer never owns game state. */
export type CandyColor = 'pink' | 'yellow' | 'mint' | 'purple';
export interface CupSpec { color: CandyColor; capacity: number }
export interface Cup extends CupSpec { id: number; filled: number }
export interface Level {
  id: number; name: string; subtitle: string; queues: CandyColor[][];
  cups: CupSpec[]; bufferSize: number; solution: number[]; par: number;
}
export interface GameState {
  levelId: number; queues: CandyColor[][]; activeCups: (Cup | null)[];
  pendingCups: Cup[]; buffer: CandyColor[]; bufferSize: number;
  moves: number; collected: number; total: number; status: 'playing' | 'won' | 'lost';
}
export interface ActionEvent {
  type: 'release' | 'collect' | 'buffer' | 'complete' | 'enter' | 'win' | 'lose';
  color?: CandyColor; queue?: number; slot?: number; cupId?: number; amount?: number;
}
export interface ActionResult { state: GameState; events: ActionEvent[] }

const COLORS: CandyColor[] = ['pink', 'yellow', 'mint', 'purple'];
const certificates = new Map<string, number[]>();

export function cloneState(state: GameState): GameState {
  return {
    ...state, queues: state.queues.map(queue => [...queue]),
    activeCups: state.activeCups.map(cup => cup ? { ...cup } : null),
    pendingCups: state.pendingCups.map(cup => ({ ...cup })), buffer: [...state.buffer],
  };
}

function stateKey(state: GameState): string {
  const color = (c: CandyColor) => COLORS.indexOf(c);
  return [
    state.bufferSize,
    state.queues.map(q => q.map(color).join('')).join('/'),
    state.activeCups.map(c => c ? `${color(c.color)}:${c.capacity}:${c.filled}` : '-').join('/'),
    state.pendingCups.map(c => `${color(c.color)}:${c.capacity}:${c.filled}`).join('/'),
    state.buffer.map(color).join(''),
  ].join('|');
}

function matchingSlot(state: GameState, color: CandyColor): number {
  return state.activeCups.findIndex(cup => cup?.color === color && cup.filled < cup.capacity);
}

function collect(state: GameState, color: CandyColor, slot: number, events: ActionEvent[], queue?: number): void {
  const cup = state.activeCups[slot]!;
  cup.filled += 1;
  state.collected += 1;
  events.push({ type: 'collect', color, slot, cupId: cup.id, amount: 1, ...(queue === undefined ? {} : { queue }) });
  if (cup.filled === cup.capacity) {
    events.push({ type: 'complete', color, slot, cupId: cup.id, amount: cup.capacity });
    const next = state.pendingCups.shift() ?? null;
    state.activeCups[slot] = next;
    if (next) events.push({ type: 'enter', color: next.color, slot, cupId: next.id, amount: next.capacity });
  }
}

/** Fully settle waiting candy after every cup replacement, oldest match first. */
function drainBuffer(state: GameState, events: ActionEvent[]): void {
  for (;;) {
    const index = state.buffer.findIndex(color => matchingSlot(state, color) !== -1);
    if (index === -1) return;
    const [color] = state.buffer.splice(index, 1);
    collect(state, color, matchingSlot(state, color), events);
  }
}

export function releaseQueue(original: GameState, index: number): ActionResult {
  if (original.status !== 'playing' || !Number.isInteger(index) || index < 0 ||
      index >= original.queues.length || original.queues[index].length === 0) {
    return { state: original, events: [] };
  }
  const state = cloneState(original);
  const events: ActionEvent[] = [];
  const queue = state.queues[index];
  const color = queue[0];
  let amount = 1;
  while (amount < queue.length && queue[amount] === color) amount++;
  queue.splice(0, amount);
  state.moves++;
  events.push({ type: 'release', color, queue: index, amount });

  // A group is one atomic action, but candies arrive sequentially. On overflow,
  // the rest remain in the buffer too, preserving every candy in the lost state.
  let overflowed = false;
  for (let n = 0; n < amount; n++) {
    const slot = overflowed ? -1 : matchingSlot(state, color);
    if (slot !== -1) collect(state, color, slot, events, index);
    else {
      state.buffer.push(color);
      events.push({ type: 'buffer', color, queue: index, amount: 1 });
    }
    if (!overflowed) {
      drainBuffer(state, events);
      if (state.buffer.length > state.bufferSize) overflowed = true;
    }
  }
  if (overflowed) {
    state.status = 'lost';
    events.push({ type: 'lose' });
  } else if (state.collected === state.total && state.buffer.length === 0 &&
      state.queues.every(q => q.length === 0) && state.activeCups.every(c => c === null) &&
      state.pendingCups.length === 0) {
    state.status = 'won';
    events.push({ type: 'win' });
  }
  return { state, events };
}

export function createState(level: Level): GameState {
  if (!Number.isInteger(level.bufferSize) || level.bufferSize < 0) throw new Error('Invalid buffer capacity.');
  if (!level.queues.length || level.queues.some(q => q.some(c => !COLORS.includes(c)))) throw new Error('Invalid candy queues.');
  if (level.cups.some(c => !COLORS.includes(c.color) || !Number.isInteger(c.capacity) || c.capacity < 1)) throw new Error('Invalid cups.');
  for (const color of COLORS) {
    const candies = level.queues.flat().filter(c => c === color).length;
    const capacity = level.cups.filter(c => c.color === color).reduce((sum, c) => sum + c.capacity, 0);
    if (candies !== capacity) throw new Error(`Level ${level.id}: ${color} supply does not match cup capacity.`);
  }
  const cups: Cup[] = level.cups.map((cup, id) => ({ ...cup, id, filled: 0 }));
  const state: GameState = {
    levelId: level.id, queues: level.queues.map(q => [...q]),
    activeCups: Array.from({ length: 3 }, () => cups.shift() ?? null), pendingCups: cups,
    buffer: [], bufferSize: level.bufferSize, moves: 0, collected: 0,
    total: level.queues.reduce((sum, q) => sum + q.length, 0), status: 'playing',
  };
  if (state.total === 0) state.status = 'won';

  // Cache only replay-proven certificates. Hints on the planned route are instant.
  let check = state;
  const route: Array<[string, number[]]> = [];
  level.solution.forEach((move, step) => {
    route.push([stateKey(check), level.solution.slice(step)]);
    check = releaseQueue(check, move).state;
  });
  if (check.status === 'won') {
    if (certificates.size > 5000) certificates.clear();
    for (const [key, path] of route) certificates.set(key, path);
  }
  return state;
}

/** Exact winning-path search. A budget exhaustion returns null, never a guess. */
export function getHint(state: GameState): number | null {
  if (state.status !== 'playing') return null;
  const cached = certificates.get(stateKey(state));
  if (cached?.length) return cached[0];
  const dead = new Set<string>();
  const deadline = Date.now() + 90;
  let nodes = 0;
  let exhausted = false;
  function search(current: GameState): number[] | null {
    if (current.status === 'won') return [];
    if (current.status === 'lost') return null;
    if (++nodes > 15000 || Date.now() > deadline) { exhausted = true; return null; }
    const key = stateKey(current);
    const proof = certificates.get(key);
    if (proof) return [...proof];
    if (dead.has(key)) return null;
    const choices = current.queues.flatMap((queue, index) => {
      if (!queue.length) return [];
      const next = releaseQueue(current, index).state;
      return next.status === 'lost' ? [] : [{ index, state: next }];
    }).sort((a, b) =>
      (b.state.collected - a.state.collected) * 10 + a.state.buffer.length - b.state.buffer.length);
    for (const choice of choices) {
      const tail = search(choice.state);
      if (tail) {
        const path = [choice.index, ...tail];
        certificates.set(key, path);
        return path;
      }
      if (exhausted) return null;
    }
    dead.add(key);
    return null;
  }
  return search(state)?.[0] ?? null;
}

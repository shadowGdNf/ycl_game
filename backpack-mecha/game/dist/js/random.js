export function hashSeed(text) { let h = 2166136261; for (let i = 0; i < text.length; i++) {
    h ^= text.charCodeAt(i);
    h = Math.imul(h, 16777619);
} return h >>> 0 || 1; }
export function nextRandom(state) { let x = state || 1; x ^= x << 13; x ^= x >>> 17; x ^= x << 5; return [x >>> 0, (x >>> 0) / 4294967296]; }
export function sample(list, state) { if (!list.length)
    throw new Error('Empty random pool'); const [s, r] = nextRandom(state); return [s, list[Math.floor(r * list.length)]]; }

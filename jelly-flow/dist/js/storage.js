const KEY = 'jelly-flow-save-v1';
export const freshSave = () => ({ version: 1, unlocked: 1, level: 1, sound: true, best: {}, history: [], tutorialSeen: false, assists: 0 });
export function sanitizeSave(raw) {
    const fresh = freshSave();
    if (!raw || typeof raw !== 'object')
        return fresh;
    const x = raw;
    if (x.version !== 1)
        return fresh;
    const validLevel = (n) => Number.isInteger(n) && Number(n) >= 1 && Number(n) <= 20;
    if (validLevel(x.unlocked))
        fresh.unlocked = x.unlocked;
    if (validLevel(x.level))
        fresh.level = Math.min(x.level, fresh.unlocked);
    if (typeof x.sound === 'boolean')
        fresh.sound = x.sound;
    fresh.tutorialSeen = x.tutorialSeen === true;
    if (Number.isInteger(x.assists) && Number(x.assists) >= 0 && Number(x.assists) <= 1000)
        fresh.assists = Number(x.assists);
    if (Array.isArray(x.history) && x.history.length <= 500 && x.history.every(n => Number.isInteger(n) && n >= 0 && n < 8))
        fresh.history = [...x.history];
    if (x.best && typeof x.best === 'object') {
        for (const [id, value] of Object.entries(x.best)) {
            if (!validLevel(Number(id)) || !value || typeof value !== 'object')
                continue;
            const b = value;
            if (Number.isInteger(b.moves) && Number(b.moves) >= 1 && Number(b.moves) < 1000 && Number.isInteger(b.stars) && Number(b.stars) >= 1 && Number(b.stars) <= 3)
                fresh.best[id] = { moves: Number(b.moves), stars: Number(b.stars) };
        }
    }
    return fresh;
}
export function readSave() { try {
    return sanitizeSave(JSON.parse(localStorage.getItem(KEY) || 'null'));
}
catch {
    return freshSave();
} }
export function writeSave(data) { try {
    localStorage.setItem(KEY, JSON.stringify(data));
    return true;
}
catch {
    return false;
} }

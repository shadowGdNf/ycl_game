import { BUILD_VERSION, RULESET_VERSION } from "./version.js?v=07c9480d5be3";
import { MODULE_BY_ID, BOSS_BY_ID, PROTOCOL_BY_ID } from "./content.js?v=07c9480d5be3";
import { appendFrame, sanitizeFrameWindow, summarizeFrameWindow } from "./performance.js?v=07c9480d5be3";
const EVENT_LIMIT = 400;
export const FRAME_BUCKETS_MS = [17, 25, 34, 50, 100, 250, Infinity];
const clone = (value) => structuredClone(value);
export function ensureJournal(run, partial = true) {
    return run.journal ??= {
        version: 1, buildVersion: BUILD_VERSION, rulesVersion: RULESET_VERSION,
        startedAtWave: run.wave, partial, nextSequence: 1, droppedEvents: 0,
        events: [], waves: [], prepSeconds: {}, frames: {},
    };
}
/** Local, bounded observations. The journal never consumes game RNG. */
export function recordAction(run, detail) {
    const journal = ensureJournal(run);
    journal.events.push({
        sequence: journal.nextSequence++, wave: run.wave, action: detail.split(':')[0], detail,
        gold: run.gold, hp: run.hp, prepSeconds: journal.prepSeconds[run.wave] ?? 0,
        items: clone(run.items), shop: clone(run.shop), protocols: [...run.protocols],
        rewardOptions: [...run.rewardOptions], protocolOptions: [...run.protocolOptions], route: run.route,
        ...(run.eventId ? { eventId: run.eventId } : {}),
    });
    if (journal.events.length > EVENT_LIMIT) {
        journal.droppedEvents += journal.events.length - EVENT_LIMIT;
        journal.events.splice(0, journal.events.length - EVENT_LIMIT);
    }
}
export function beginWaveRecord(run) {
    const journal = ensureJournal(run);
    // A damaged combat save may legitimately restart this wave from preparation.
    journal.waves = journal.waves.filter(w => w.wave !== run.wave);
    journal.waves.push({
        wave: run.wave, ...(run.wave % 4 === 0 ? { boss: run.bosses[Math.ceil(run.wave / 4) - 1] } : {}),
        route: run.route, rulesVersion: RULESET_VERSION, prepSeconds: journal.prepSeconds[run.wave] ?? 0,
        start: { hp: run.hp, shield: run.shield, gold: run.gold, items: clone(run.items), protocols: [...run.protocols] },
    });
}
export function finishWaveRecord(run, result, income) {
    const journal = ensureJournal(run), wave = journal.waves.find(w => w.wave === run.wave);
    // Legacy saves can resume mid-combat: do not fabricate an opening loadout.
    if (!wave) {
        journal.partial = true;
        return;
    }
    wave.end = {
        won: result.won && result.hp > 0, hp: result.hp, shield: result.shield,
        gold: run.gold, income, seconds: result.elapsed, ...(result.reason ? { reason: result.reason } : {}),
        stats: clone(result.stats),
    };
}
export function recordPrepTime(run, seconds) {
    if (!['prep', 'reward', 'protocol', 'expansion'].includes(run.phase) || !Number.isFinite(seconds) || seconds <= 0)
        return;
    const journal = ensureJournal(run);
    journal.prepSeconds[run.wave] = (journal.prepSeconds[run.wave] ?? 0) + Math.min(seconds, 1);
}
export function recordFrame(run, milliseconds, renderMs, context = 'unspecified') {
    if (!Number.isFinite(milliseconds) || milliseconds <= 0)
        return;
    const journal = ensureJournal(run);
    const frame = journal.frames[run.wave] ??= { samples: 0, milliseconds: 0, over50ms: 0, maxMs: 0, buckets: FRAME_BUCKETS_MS.map(() => 0) };
    frame.samples++;
    frame.milliseconds += milliseconds;
    frame.over50ms += Number(milliseconds > 50);
    frame.maxMs = Math.max(frame.maxMs, milliseconds);
    frame.buckets[FRAME_BUCKETS_MS.findIndex(limit => milliseconds <= limit)]++;
    if (renderMs !== undefined && Number.isFinite(renderMs) && renderMs >= 0 && context.length <= 2048)
        frame.recent = appendFrame(frame.recent, milliseconds, renderMs, context);
}
/** Undo changes game state, while elapsed time and the audit of attempted choices stay intact. */
export function preserveJournal(before, restored, action) {
    if (before.journal)
        restored.journal = clone(before.journal);
    recordAction(restored, action);
}
export function exportRunReport(run) {
    const journal = ensureJournal(run);
    const windows = Object.entries(journal.frames).filter(([, f]) => f.recent).map(([wave, f]) => [wave, summarizeFrameWindow(f.recent)]);
    return clone({
        reportVersion: 1, buildVersion: BUILD_VERSION, rulesVersion: RULESET_VERSION,
        seed: run.seed, mode: run.mode, chassis: run.chassis, difficulty: run.difficulty,
        status: run.phase, wave: run.wave, battleSeconds: run.elapsed,
        prepSeconds: Object.values(journal.prepSeconds).reduce((sum, seconds) => sum + seconds, 0),
        stats: run.stats, items: run.items, history: run.history, journal,
        ...(windows.length ? { performance: { version: 1, method: 'Nearest-rank percentiles of retained foreground battle samples; whole-wave histogram remains in journal.frames.', waves: Object.fromEntries(windows) } } : {}),
    });
}
/** Diagnostics must never make an otherwise valid v0.1 save unusable. */
export function sanitizeJournal(value) {
    if (!value || typeof value !== 'object')
        return undefined;
    const j = value;
    const finite = (v) => typeof v === 'number' && Number.isFinite(v) && v >= 0;
    const record = (v) => !!v && typeof v === 'object' && !Array.isArray(v);
    const wave = (v) => Number.isInteger(v) && Number(v) >= 1 && Number(v) <= 12;
    const ids = (v, known) => Array.isArray(v) && v.every(id => typeof id === 'string' && !!known[id]);
    const items = (v) => Array.isArray(v) && v.length <= 20 && v.every(i => record(i) && typeof i.uid === 'string' && typeof i.id === 'string' && !!MODULE_BY_ID[i.id] && [1, 2, 3, 4].includes(Number(i.tier)));
    const stats = (v) => record(v) && ['kills', 'killedBudget', 'goldEarned', 'maxChain', 'damageTaken'].every(k => finite(v[k])) && record(v.damageByModule) && Object.values(v.damageByModule).every(finite) && record(v.damageTakenBy) && Object.values(v.damageTakenBy).every(finite);
    if (j.version !== 1 || typeof j.buildVersion !== 'string' || typeof j.rulesVersion !== 'string' ||
        !wave(j.startedAtWave) || typeof j.partial !== 'boolean' || !finite(j.nextSequence) || !finite(j.droppedEvents) ||
        !Array.isArray(j.events) || j.events.length > EVENT_LIMIT || !Array.isArray(j.waves) || j.waves.length > 12 ||
        !record(j.prepSeconds) || !Object.entries(j.prepSeconds).every(([k, v]) => wave(Number(k)) && finite(v)) ||
        !record(j.frames) || !Object.entries(j.frames).every(([k, f]) => wave(Number(k)) && record(f) &&
        ['samples', 'milliseconds', 'over50ms', 'maxMs'].every(key => finite(f[key])) && Array.isArray(f.buckets) && f.buckets.length === 7 && f.buckets.every(finite)) ||
        !j.events.every(e => record(e) && finite(e.sequence) && wave(e.wave) && typeof e.action === 'string' && typeof e.detail === 'string' &&
            finite(e.gold) && finite(e.hp) && finite(e.prepSeconds) && items(e.items) && Array.isArray(e.shop) && ids(e.protocols, PROTOCOL_BY_ID) &&
            ids(e.rewardOptions, MODULE_BY_ID) && ids(e.protocolOptions, PROTOCOL_BY_ID)) ||
        !j.waves.every(w => record(w) && wave(w.wave) && typeof w.rulesVersion === 'string' && finite(w.prepSeconds) && record(w.start) &&
            (w.boss === undefined || typeof w.boss === 'string' && !!BOSS_BY_ID[w.boss]) &&
            ['hp', 'shield', 'gold'].every(k => finite(w.start[k])) && items(w.start.items) && ids(w.start.protocols, PROTOCOL_BY_ID) &&
            (w.end === undefined || record(w.end) && typeof w.end.won === 'boolean' && ['hp', 'shield', 'gold', 'income', 'seconds'].every(k => finite(w.end[k])) && stats(w.end.stats))))
        return undefined;
    // Optional detailed samples are independent of valid progress and legacy journal data.
    const frames = Object.fromEntries(Object.entries(j.frames).map(([wave, f]) => {
        const { recent, ...base } = f, clean = sanitizeFrameWindow(recent);
        return [wave, { ...base, ...(clean ? { recent: clean } : {}) }];
    }));
    return clone({ ...j, frames });
}

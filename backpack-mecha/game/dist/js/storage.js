import { normalizeGrowth, chassisStats } from "./progression.js?v=17e930db7a48";
import { CHASSIS_BY_ID, MODULE_BY_ID, PROTOCOL_BY_ID, BOSS_BY_ID, EVENT_BY_ID, DEMO_IDS, PROTOTYPE_IDS } from "./content.js?v=17e930db7a48";
import { createBattle } from "./combat.js?v=17e930db7a48";
import { sanitizeJournal } from "./journal.js?v=17e930db7a48";
const DB = 'backpack-mecha-v1';
const finite = (v) => typeof v === 'number' && Number.isFinite(v);
const record = (v) => !!v && typeof v === 'object' && !Array.isArray(v);
const strings = (v) => Array.isArray(v) && v.every(s => typeof s === 'string');
function compatible(value, template) { if (typeof template === 'number')
    return finite(value); if (Array.isArray(template))
    return Array.isArray(value); if (record(template))
    return record(value) && Object.entries(template).every(([key, v]) => compatible(value[key], v)); return typeof value === typeof template; }
function validBattle(raw, run) {
    try {
        if (!record(raw) || !compatible(raw, createBattle(run)))
            return false;
        const b = raw;
        if (b.version !== 1 || b.wave !== run.wave || b.chassis !== run.chassis || !['playing', 'won', 'lost'].includes(b.status) || b.time < 0 || b.time > 301 || b.enemies.length > 100 || b.bullets.length > 2000 || b.zones.length > 1000)
            return false;
        const numeric = (v, fields) => record(v) && fields.every(k => finite(v[k]));
        // Missing skill fields are dev.10 saves; malformed new fields must not enter combat.
        const state = raw;
        if (b.bossIntent && (!record(b.bossIntent) || !['name', 'en', 'hint', 'hintEn'].every(k => typeof b.bossIntent[k] === 'string') || !finite(b.bossIntent.recoverAt) || !finite(b.bossIntent.until)))
            return false;
        if (['baseDamage', 'baseAttackSpeed'].some(k => !finite(state[k]) || Number(state[k]) < 1 || Number(state[k]) > 3))
            return false;
        if (['skillCooldown', 'skillTime'].some(k => { const n = b.player[k]; return n !== undefined && (!finite(n) || n < 0 || n > 24); }) ||
            state.skillReleased !== undefined && typeof state.skillReleased !== 'boolean' || state.skillPulseAt !== undefined && (!finite(state.skillPulseAt) || state.skillPulseAt < 0))
            return false;
        return b.enemies.every(e => numeric(e, ['eid', 'x', 'y', 'hp', 'maxHp', 'radius', 'angle', 'phase', 'armor', 'speed', 'damage', 'cost', 'reward', 'born', 'cooldown', 'contactAt', 'pathAt', 'aiUntil', 'healingUntil', 'affix', 'oilUntil', 'oilAt', 'chill', 'chillUntil', 'chillStrength', 'frozen', 'wet', 'stagger', 'staggerUntil', 'vulnerableUntil', 'offsetX']) && Array.isArray(e.burns) && Array.isArray(e.path)) && b.bullets.every(e => numeric(e, ['eid', 'x', 'y', 'vx', 'vy', 'radius', 'damage', 'life', 'factor', 'shot', 'pierce', 'bounces', 'bounceFactor', 'traveled', 'range', 'slow']) && record(e.hitAt)) && b.zones.every(e => numeric(e, ['id', 'x', 'y', 'radius', 'angle', 'remaining', 'duration', 'delay', 'age', 'pulse']) && record(e.plan)) && b.weapons.every(e => numeric(e, ['x', 'y', 'angle', 'cooldown', 'shotCount', 'tier', 'targetUntil', 'rectifierAt', 'droneCount']) && MODULE_BY_ID[e.id] && record(e.supports));
    }
    catch {
        return false;
    }
}
export function scoreRun(r) { return Math.round((r.phase === 'won' ? 10000 : 0) + Math.max(0, r.hp) * 20 + r.stats.killedBudget * 5 + r.difficulty * 2000); }
export function applyProgress(profile, run, completedWave, won, usedDrones) { const unlocked = []; const unlock = (id) => { if (!profile.unlocked.includes(id)) {
    profile.unlocked.push(id);
    unlocked.push(id);
} }; if (won && completedWave === 4)
    unlock('bulwark'); if (won && completedWave === 8 && usedDrones)
    unlock('hive'); if (won && run.phase === 'won') {
    profile.wins++;
    if (run.mode === 'full') {
        unlock('kestrel');
        profile.maxDifficulty = Math.max(profile.maxDifficulty, Math.min(4, run.difficulty + 1));
    }
    const key = `${run.mode}:${run.chassis}:${run.difficulty}`, score = scoreRun(run);
    if (!profile.best[key] || profile.best[key].score < score)
        profile.best[key] = { score, seconds: run.elapsed };
} return unlocked; }
export function freshProfile() { return { version: 1, language: 'zh', unlocked: ['scavenger'], maxDifficulty: 0, codex: ['W01', 'S01'], connections: [], best: {}, settings: { sound: true, music: true, reducedMotion: typeof matchMedia === 'function' && matchMedia('(prefers-reduced-motion: reduce)').matches, leftHanded: false, colorAssist: false, autoOverload: false, unlockAll: false, volume: .45 }, tutorial: false, totalRuns: 0, wins: 0 }; }
export function sanitizeSave(raw) {
    const fresh = { version: 1, profile: freshProfile(), run: null, battle: null, savedAt: 0 };
    if (!raw || typeof raw !== 'object')
        return fresh;
    const x = raw;
    if (x.profile && typeof x.profile === 'object') {
        const p = x.profile;
        if (p.language === 'en')
            fresh.profile.language = 'en';
        fresh.profile.unlocked = Array.isArray(p.unlocked) ? [...new Set(['scavenger', ...p.unlocked.filter(v => typeof v === 'string' && CHASSIS_BY_ID[v])])] : ['scavenger'];
        fresh.profile.maxDifficulty = Number.isInteger(p.maxDifficulty) ? Math.max(0, Math.min(4, p.maxDifficulty)) : 0;
        fresh.profile.codex = Array.isArray(p.codex) ? p.codex.filter(v => typeof v === 'string' && MODULE_BY_ID[v]) : ['W01', 'S01'];
        fresh.profile.connections = Array.isArray(p.connections) ? p.connections.filter(v => typeof v === 'string').slice(-100) : [];
        fresh.profile.tutorial = p.tutorial === true;
        fresh.profile.totalRuns = finite(p.totalRuns) ? Math.max(0, Math.floor(p.totalRuns)) : 0;
        fresh.profile.wins = finite(p.wins) ? Math.max(0, Math.floor(p.wins)) : 0;
        if (p.settings) {
            for (const k of ['sound', 'music', 'reducedMotion', 'leftHanded', 'colorAssist', 'autoOverload', 'unlockAll'])
                if (typeof p.settings[k] === 'boolean')
                    fresh.profile.settings[k] = p.settings[k];
            if (Number.isFinite(p.settings.volume))
                fresh.profile.settings.volume = Math.max(0, Math.min(1, p.settings.volume));
        }
        if (p.best && typeof p.best === 'object')
            for (const [key, value] of Object.entries(p.best)) {
                if (value && Number.isFinite(value.score) && Number.isFinite(value.seconds))
                    fresh.profile.best[key] = { score: Math.max(0, value.score), seconds: Math.max(0, value.seconds) };
            }
    }
    if (x.version !== 1)
        return fresh;
    if (finite(x.savedAt) && x.savedAt >= 0)
        fresh.savedAt = x.savedAt;
    const r = x.run;
    if (r && r.version === 1 && CHASSIS_BY_ID[r.chassis] && ['prototype', 'demo', 'full'].includes(r.mode) && ['prep', 'battle', 'reward', 'protocol', 'expansion', 'won', 'lost'].includes(r.phase) && Number.isInteger(r.wave) && r.wave >= 1 && r.wave <= (r.mode === 'full' ? 12 : r.mode === 'demo' ? 8 : 4) && finite(r.gold) && r.gold >= 0 && finite(r.hp) && finite(r.shield) && finite(r.elapsed) && finite(r.nextUid) && [1, 2, 3, 4].includes(r.maxTier) && finite(r.power) && finite(r.refreshes) && finite(r.shopPity) && Array.isArray(r.items) && r.items.length <= 20 && r.items.every(v => v && typeof v.uid === 'string' && MODULE_BY_ID[v.id] && [1, 2, 3, 4].includes(v.tier) && Number.isInteger(v.rotation) && v.rotation >= 0 && v.rotation <= 3 && finite(v.x) && finite(v.y) && typeof v.stored === 'boolean') && new Set(r.items.map(v => v.uid)).size === r.items.length && Array.isArray(r.shop) && r.shop.length <= 4 && r.shop.every(o => o && typeof o.id === 'string' && typeof o.locked === 'boolean' && (!o.id || MODULE_BY_ID[o.id]) && (o.tier === undefined || [1, 2, 3, 4].includes(o.tier))) && r.rng && ['shop', 'map', 'event', 'combat'].every(k => finite(r.rng[k])) && strings(r.protocols) && r.protocols.every(id => PROTOCOL_BY_ID[id]) && strings(r.rewardOptions) && r.rewardOptions.every(id => MODULE_BY_ID[id] && (r.mode === 'full' || (r.mode === 'demo' ? DEMO_IDS : PROTOTYPE_IDS).includes(id))) && strings(r.protocolOptions) && r.protocolOptions.every(id => PROTOCOL_BY_ID[id]) && (r.phase !== 'reward' || r.rewardOptions.length > 0) && (r.phase !== 'protocol' || r.protocolOptions.length > 0) && (!r.eventId || !!EVENT_BY_ID[r.eventId]) && typeof r.eventResolved === 'boolean' && strings(r.eventsSeen) && strings(r.history) && Array.isArray(r.unlockedCorners) && r.unlockedCorners.every(v => [0, 1, 2, 3].includes(v)) && strings(r.bosses) && r.bosses.length >= (r.mode === 'full' ? 3 : r.mode === 'demo' ? 2 : 1) && r.bosses.every((id, i) => BOSS_BY_ID[id]?.act === i + 1) && r.stats && record(r.stats.damageByModule) && record(r.stats.damageTakenBy) && Object.values(r.stats.damageByModule).every(finite) && Object.values(r.stats.damageTakenBy).every(finite) && ['kills', 'killedBudget', 'goldEarned', 'maxChain', 'damageTaken'].every(k => finite(r.stats[k]))) {
        fresh.run = structuredClone(r);
        fresh.run.growth = normalizeGrowth(r.growth);
        fresh.run.route = [0, 1, 2].includes(r.route) ? r.route : 0;
        fresh.run.preferredRoute = r.preferredRoute === 0 || r.preferredRoute === 1 || r.preferredRoute === 2 ? r.preferredRoute : fresh.run.route;
        const journal = sanitizeJournal(r.journal);
        if (journal)
            fresh.run.journal = journal;
        else
            delete fresh.run.journal;
        if (r.phase === 'battle') {
            const b = x.battle ? structuredClone(x.battle) : null;
            if (record(b)) {
                const stats = chassisStats(fresh.run);
                b.baseDamage ??= stats.attack / 100;
                b.baseAttackSpeed ??= stats.speed / 100;
            }
            if (validBattle(b, fresh.run)) {
                fresh.battle = structuredClone(b);
                for (const e of fresh.battle.enemies)
                    if (!['ice', 'impact', 'stagger'].includes(e.controlReason ?? ''))
                        delete e.controlReason;
            }
            else
                fresh.run.phase = 'prep';
        }
    }
    return fresh;
}
function openDB() { return new Promise((resolve, reject) => { if (typeof indexedDB === 'undefined') {
    reject(Error('Storage unavailable'));
    return;
} const request = indexedDB.open(DB, 1); request.onupgradeneeded = () => { if (!request.result.objectStoreNames.contains('saves'))
    request.result.createObjectStore('saves'); }; request.onsuccess = () => resolve(request.result); request.onerror = () => reject(request.error); request.onblocked = () => reject(Error('Storage blocked')); }); }
export async function loadSave() { try {
    const db = await openDB();
    const raw = await new Promise((resolve, reject) => { const request = db.transaction('saves', 'readonly').objectStore('saves').get('current'); request.onsuccess = () => resolve(request.result); request.onerror = () => reject(request.error); });
    db.close();
    return sanitizeSave(raw);
}
catch {
    return sanitizeSave(null);
} }
let saveDB = null, opening = null;
function writeSave(db, data) {
    return new Promise(resolve => {
        try {
            // put takes an immutable structured snapshot synchronously. Do not clone it a second time.
            // IndexedDB serializes transactions on this store in creation order.
            const tx = db.transaction('saves', 'readwrite');
            tx.objectStore('saves').put(data, 'current');
            tx.oncomplete = () => resolve(true);
            tx.onerror = tx.onabort = () => resolve(false);
        }
        catch {
            saveDB = null;
            opening = null;
            resolve(false);
        }
    });
}
export function saveGame(data) {
    if (saveDB)
        return writeSave(saveDB, data);
    try {
        // The initial async database open still needs an immutable call-time snapshot.
        const copy = structuredClone(data);
        opening ??= openDB().then(db => { saveDB = db; db.onversionchange = () => { db.close(); saveDB = null; opening = null; }; db.onclose = () => { saveDB = null; opening = null; }; return db; }, error => { opening = null; throw error; });
        return opening.then(db => writeSave(db, copy), () => false);
    }
    catch {
        return Promise.resolve(false);
    }
}

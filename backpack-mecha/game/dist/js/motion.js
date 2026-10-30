const clamp = (n) => Math.max(0, Math.min(1, n));
export function controlReason(enemy) {
    if (!(enemy.frozen && enemy.frozen > 0))
        return;
    const reason = enemy.controlReason;
    return reason === 'ice' || reason === 'impact' || reason === 'stagger' ? reason : 'unknown';
}
function action(e, z) {
    const effect = z.plan?.effect;
    if (effect === 'charge' || effect === 'pull' || effect === 'conveyor')
        return effect;
    if (effect === 'spawn')
        return 'summon';
    if (effect === 'projectile')
        return 'volley';
    if (effect === 'mortar' || effect === 'drill')
        return 'bombard';
    if (e.id === 'E05')
        return 'detonate';
    if (z.kind === 'ring')
        return 'ring';
    if (e.id === 'B1B' && z.kind === 'cone')
        return 'sweep';
    if (e.id === 'B2A' && z.kind === 'cone')
        return 'fire';
    if (z.kind === 'line' || e.id === 'B3A' && z.plan?.sweep)
        return 'beam';
    if (e.id === 'B3B' && z.kind === 'rect')
        return 'bombard';
    return 'slam';
}
export function motionFrame(view) {
    const byOwner = new Map(), groups = new Map(), hits = new Map(), hitAngles = new Map(), fires = new Map(), releases = new Map();
    const contacts = view.events.filter(ev => ev.type === 'player-hit' && ev.from && view.time >= ev.at && view.time - ev.at < .28);
    for (const e of view.enemies)
        if (e.group && !groups.has(e.group))
            groups.set(e.group, e.eid);
    for (const z of view.zones) {
        // A delayed attack has no visible wind-up yet. Persistent ground fire is not a body action.
        if (z.type === 'friendly' || z.sourceId === undefined || (z.delay ?? 0) > 0 || z.remaining <= 0 || z.plan?.effect === 'fire')
            continue;
        const list = byOwner.get(z.sourceId) ?? [];
        list.push(z);
        byOwner.set(z.sourceId, list);
    }
    let phaseAt = -Infinity;
    for (const ev of view.events) {
        if (ev.type === 'phase' && ev.at <= view.time)
            phaseAt = Math.max(phaseAt, ev.at);
        if (ev.type === 'enemy-fire' && ev.source && ev.at <= view.time && view.time - ev.at < .18)
            fires.set(ev.targetId ?? -1, Math.max(fires.get(ev.targetId ?? -1) ?? -Infinity, ev.at));
        if (ev.type === 'enemy-attack' && ev.cue !== 'projectile' && ev.targetId !== undefined && ev.at <= view.time && view.time - ev.at < .28)
            releases.set(ev.targetId, ev.at);
        if (ev.targetId !== undefined && /^(hit|critical)$/.test(ev.type) && ev.at <= view.time && ev.at >= (hits.get(ev.targetId) ?? -Infinity)) {
            hits.set(ev.targetId, ev.at);
            if (ev.from)
                hitAngles.set(ev.targetId, Math.atan2(ev.y - ev.from.y, ev.x - ev.from.x));
        }
    }
    const out = new Map();
    for (const e of view.enemies) {
        const own = byOwner.get(e.eid) ?? (e.group ? byOwner.get(groups.get(e.group)) : undefined) ?? [];
        // The crane's final slam must anticipate over the still-running pull field.
        const priority = (z) => (z.active ? 10 : 0) + (!z.active && (z.damage ?? 0) > 0 && z.remaining < .55 ? 12 : 0) + (z.plan?.effect === 'charge' ? 3 : 0) + (1 - z.remaining / Math.max(.001, z.duration));
        let zone;
        for (const z of own)
            if (!zone || priority(z) > priority(zone))
                zone = z;
        // Projectile warning zones disappear on release. The existing event keeps a short,
        // resumable muzzle pose; bullets, rather than a lingering zone, carry the danger.
        const fired = fires.has(e.eid);
        if (fired)
            zone = undefined;
        // Contact damage has no warning zone; the existing damage event supplies its strike pose.
        const contact = contacts.filter(ev => ev.source === e.id && Math.hypot(ev.from.x - e.x, ev.from.y - e.y) < 25).at(-1);
        const released = releases.get(e.eid) ?? contact?.at;
        const control = controlReason(e), charging = !!e.charge && e.charge.until > view.time && !control;
        const weak = (e.vulnerableUntil ?? 0) > view.time;
        const recovery = !zone && !charging && (weak || (e.kind === 'boss' && (view.bossTurn ?? 0) > 0 && (view.bossClock ?? 0) > 0) || (e.aiUntil ?? 0) > view.time);
        out.set(e.eid, { stage: charging || fired || (!zone && released !== undefined) ? 'active' : zone ? (zone.active ? 'active' : 'windup') : recovery ? 'recover' : 'idle',
            kind: charging ? 'charge' : fired ? 'volley' : zone ? action(e, zone) : released !== undefined ? 'slam' : 'idle', progress: fired ? 1 : zone ? clamp(1 - zone.remaining / Math.max(.001, zone.duration)) : 0,
            angle: charging ? Math.atan2(e.charge.vy, e.charge.vx) : zone ? (zone.active ? zone.angle : zone.plan?.angle ?? zone.angle) : e.angle,
            control, weak, fireAge: fires.has(e.eid) ? view.time - fires.get(e.eid) : undefined, releaseAge: released === undefined ? undefined : view.time - released,
            phaseAge: e.kind === 'boss' ? view.time - phaseAt : Infinity, hit: clamp(1 - (view.time - (hits.get(e.eid) ?? -Infinity)) / .24), hitAngle: hitAngles.get(e.eid), hitAge: hits.has(e.eid) ? view.time - hits.get(e.eid) : undefined, zone });
    }
    return out;
}
const names = { idle: ['', ''], charge: ['冲锋', 'CHARGE'], detonate: ['自爆', 'DETONATE'], pull: ['牵引', 'PULL'], sweep: ['摆锤', 'SWEEP'], fire: ['喷火', 'FIRE'], beam: ['光束', 'BEAM'], ring: ['扩散环', 'RING'], bombard: ['轰炸', 'BOMBARD'], volley: ['齐射', 'VOLLEY'], summon: ['增援', 'REINFORCE'], slam: ['重击', 'SLAM'], conveyor: ['输送带', 'CONVEYOR'] };
export function motionLabel(m, lang) {
    const en = lang === 'en';
    if (m.control)
        return ({ ice: en ? 'FROZEN' : '冰冻', impact: en ? 'IMPACT' : '撞墙硬直', stagger: en ? 'STAGGER' : '失衡', unknown: en ? 'IMMOBILE' : '行动受限' })[m.control];
    if (m.weak)
        return en ? 'WEAK POINT' : '弱点暴露';
    if (m.stage === 'recover')
        return en ? 'RECOVER' : '调整中';
    if (m.stage === 'idle')
        return '';
    return `${m.stage === 'windup' ? (en ? 'READY · ' : '准备 · ') : ''}${names[m.kind][en ? 1 : 0]}`;
}
/** Non-damaging displacement stays distinct from damaging hazards. */
export function zoneRole(z) {
    return ['pull', 'conveyor'].includes(z.plan?.effect ?? '') ? 'force' : z.plan?.effect === 'spawn' ? 'spawn' : 'damage';
}
/** A charge rectangle predicts travel; after impact there is no remaining charge. */
export function zoneVisible(view, z) {
    if ((z.delay ?? 0) > 0 && !z.beat || z.remaining <= 0)
        return false;
    if (z.plan?.effect !== 'charge' || !z.active)
        return true;
    const source = view.enemies.find(e => e.eid === z.sourceId);
    return !!source && source.hp > 0 && !!source.charge && source.charge.until > view.time;
}
export function chargeContactRadius(enemy, time) {
    if (enemy.hp <= 0 || (enemy.frozen ?? 0) > 0 || !enemy.charge || enemy.charge.until <= time)
        return;
    return enemy.charge.radius ?? enemy.radius;
}

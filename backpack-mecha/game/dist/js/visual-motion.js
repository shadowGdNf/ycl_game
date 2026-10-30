export function locomotion(previous, p, dt) {
    if (!previous)
        return { ...p, stride: 0, amount: 0, lean: 0 };
    if (dt <= 0)
        return previous;
    const dx = p.x - previous.x, dy = p.y - previous.y, distance = Math.hypot(dx, dy);
    // Teleports and reloads do not become a huge stride or body swing.
    const travel = distance < 90 ? distance : 0, speed = travel / dt, blend = 1 - Math.exp(-dt * 15);
    const target = Math.min(1, speed / 135);
    return { ...p, stride: previous.stride + travel / 90, amount: previous.amount + (target - previous.amount) * blend,
        lean: previous.lean + (Math.max(-1, Math.min(1, dx / (dt * 180))) - previous.lean) * blend };
}
export const easeOut = (v) => 1 - (1 - Math.max(0, Math.min(1, v))) ** 3;
export const smoothStep = (v) => { const t = Math.max(0, Math.min(1, v)); return t * t * (3 - 2 * t); };
/** Recoil has a fast kick and a damped return; preparation uses real remaining cooldown. */
export function weaponPose(id, age, cooldown, reduced) {
    const heavy = ['W02', 'W07', 'W08', 'W10', 'W14', 'W17'].includes(id), melee = id === 'W08';
    const duration = melee ? .34 : heavy ? .3 : .19;
    const t = Math.max(0, age) / duration, live = age >= 0 && t < 1;
    const kick = live ? Math.sin(Math.min(1, t / .12) * Math.PI / 2) * Math.exp(-t * 4.5) * (1 - t) : 0;
    const anticipation = cooldown > 0 && cooldown < .2 ? 1 - cooldown / .2 : 0;
    return { recoil: reduced ? 0 : kick * (heavy ? 11 : 6),
        swing: reduced ? 0 : melee ? (live ? -1.15 + easeOut(t) * 2.15 : -anticipation * .65) : live ? -kick * .09 : 0,
        charge: anticipation, heat: live ? 1 - t : 0 };
}
/** A quick displacement away from impact, with an exact zero after recovery. */
export function impactOffset(age, angle, strength, reduced) {
    if (reduced || age < 0 || age >= .24)
        return { x: 0, y: 0 };
    const k = age / .24, amount = Math.min(1, k / .12) * Math.exp(-k * 4) * (1 - k) * strength;
    return { x: Math.cos(angle) * amount, y: Math.sin(angle) * amount };
}

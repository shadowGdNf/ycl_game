/** A bounded, conservative check before a new combination commits its markers.
 * It needs a walking route after 250ms reaction, never assumes dash or invulnerability.
 * This checks announced geometry and existing projectiles, not a promise about future AI. */
import { contains } from "./hazards.js?v=b24d61249a59";
const DT = 1 / 30, REACTION = .25, TAU = Math.PI * 2;
const clamp = (n, a, b) => Math.max(a, Math.min(b, n));
export function routeInput(route, time) {
    if (time < REACTION)
        return { x: 0, y: 0 };
    if (time >= route.after && route.turn === Infinity)
        return { x: 0, y: 0 };
    const a = route.angle + (time >= route.after ? route.turn : 0);
    return { x: Math.cos(a), y: Math.sin(a) };
}
function forecast(w, turn) {
    const hazards = [], shots = [];
    const add = (plan, start, end) => {
        if (plan.effect === 'projectile') {
            const count = plan.count || 1, spread = plan.spread || 0, speed = plan.speed || 240;
            for (let i = 0; i < count; i++) {
                const a = plan.angle + (count === 1 ? 0 : spread >= TAU - .01 ? i / count * spread : (i / (count - 1) - .5) * spread);
                shots.push({ x: plan.x, y: plan.y, vx: Math.cos(a) * speed, vy: Math.sin(a) * speed, radius: plan.projectileRadius || 5, start, end: start + Math.min(5, 1200 / speed) });
            }
        }
        else if (plan.effect !== 'spawn')
            hazards.push({ plan, start, end });
    };
    for (const plan of turn.plans) {
        const start = (plan.delay || 0) + plan.warning;
        add(plan, start, start + plan.active);
    }
    for (const z of w.zones)
        if (z.type !== 'friendly') {
            const start = z.active ? -z.age : Math.max(0, z.delay) + z.remaining;
            add(z.plan, start, z.active ? z.remaining : start + z.plan.active);
        }
    for (const b of w.bullets)
        if (b.owner === 'enemy')
            shots.push({ ...b, start: 0, end: Math.min(b.life, (b.range - b.traveled) / Math.max(1, Math.hypot(b.vx, b.vy))) });
    const duration = Math.max(turn.duration, ...hazards.map(h => h.end), ...shots.map(s => s.end)) + .1;
    return { hazards, shots, duration };
}
function shape(h, t) {
    const p = h.plan, age = Math.max(0, t - h.start), radius = p.radius + (p.grow || 0) * age;
    return { ...p, radius, innerRadius: p.grow ? Math.max(0, radius - 22) : p.innerRadius, angle: p.angle + (p.sweep || 0) * Math.min(1, age / p.active) };
}
export function findEscapeRoute(w, turn) {
    const { hazards, shots, duration } = forecast(w, turn), r = w.player.radius;
    // Swept projectiles get half a timestep of padding. Geometry also has 8px clearance.
    const bodies = w.enemies.filter(e => !e.dead && e.exposed && e.hp > 0);
    const charges = hazards.filter(h => h.plan.effect === 'charge');
    const towardCenter = Math.atan2(w.height / 2 - w.player.y, w.width / 2 - w.player.x);
    for (const change of [0, Infinity, Math.PI / 2, -Math.PI / 2])
        for (let i = 0; i < 24; i++) {
            const route = { angle: towardCenter + i * TAU / 24, turn: change, after: 1.35, duration };
            const p = { x: w.player.x, y: w.player.y };
            let safe = true;
            for (let t = 0; t <= duration; t += DT) {
                const input = routeInput(route, t);
                const speed = w.player.speed * (w.slowUntil > w.time + t ? 1 - w.slowAmount : 1) * (w.chassis === 'kestrel' && (w.player.skillTime ?? 0) > t ? 1.35 : 1);
                p.x = clamp(p.x + input.x * speed * DT, r, w.width - r);
                p.y = clamp(p.y + input.y * speed * DT, r, w.height - r);
                for (const h of hazards) {
                    if (t < h.start - DT || t > h.end + DT)
                        continue;
                    const z = shape(h, t);
                    if (!contains(z, p, r + 8))
                        continue;
                    if (z.effect === 'pull' || z.effect === 'conveyor') {
                        const a = z.effect === 'pull' ? Math.atan2(z.y - p.y, z.x - p.x) : z.angle;
                        const force = (z.speed || 60) * DT;
                        p.x = clamp(p.x + Math.cos(a) * force, r, w.width - r);
                        p.y = clamp(p.y + Math.sin(a) * force, r, w.height - r);
                    }
                    else if (z.damage > 0) {
                        safe = false;
                        break;
                    }
                }
                if (!safe)
                    break;
                for (const s of shots) {
                    if (t < s.start - DT || t > s.end + DT)
                        continue;
                    const age = Math.max(0, t - s.start);
                    if (Math.hypot(p.x - s.x - s.vx * age, p.y - s.y - s.vy * age) < r + s.radius + 8 + Math.hypot(s.vx, s.vy) * DT / 2) {
                        safe = false;
                        break;
                    }
                }
                if (!safe)
                    break;
                for (const e of bodies) {
                    const charge = e.kind === 'boss' ? charges[0] : undefined;
                    const age = charge ? clamp(t - charge.start, 0, charge.plan.active) : 0;
                    const x = charge ? clamp(e.x + Math.cos(charge.plan.angle) * (charge.plan.speed || 260) * age, e.radius, w.width - e.radius) : e.x;
                    const y = charge ? clamp(e.y + Math.sin(charge.plan.angle) * (charge.plan.speed || 260) * age, e.radius, w.height - e.radius) : e.y;
                    if (Math.hypot(p.x - x, p.y - y) < r + e.radius + 8) {
                        safe = false;
                        break;
                    }
                }
                if (!safe)
                    break;
            }
            if (safe)
                return route;
        }
    return undefined;
}
export function guardBossTurn(w, turn) {
    for (const extra of [0, .35, .7, 1.05]) {
        const candidate = extra ? { ...turn, plans: turn.plans.map(p => ({ ...p, warning: p.warning + extra })), duration: turn.duration + extra } : turn;
        if (findEscapeRoute(w, candidate))
            return candidate;
    }
    // Wait for the existing danger to clear; do not advance the choreography or drop a marker.
    return undefined;
}

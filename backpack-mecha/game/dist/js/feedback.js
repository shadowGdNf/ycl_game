import { roundRect } from "./canvas.js?v=4294331e0428";
const TAU = Math.PI * 2;
const clamp = (v, a = 0, b = 1) => Math.max(a, Math.min(b, v));
const noise = (n) => { const v = Math.sin(n * 12.9898) * 43758.5453; return v - Math.floor(v); };
const circle = (c, x, y, r) => { c.beginPath(); c.arc(x, y, Math.max(.01, r), 0, TAU); };
function line(c, x, y, xx, yy) { c.beginPath(); c.moveTo(x, y); c.lineTo(xx, yy); c.stroke(); }
export function effectLife(e) {
    if (e.type === 'pickup')
        return 1;
    if (e.type === 'scrap-drop')
        return .75;
    if (e.type === 'player-hit')
        return .75;
    if (e.type === 'shield-break')
        return .65;
    if (e.type === 'hit' || e.type === 'critical')
        return .52;
    if (e.type === 'kill' || e.type === 'defeat')
        return .65;
    if (e.type === 'arc')
        return .24;
    if (e.type === 'fire')
        return ['W05', 'W08', 'W09'].includes(e.source ?? '') ? .28 : .16;
    if (e.type === 'explosion' || e.type === 'enemy-explosion' || e.type === 'enemy-attack')
        return .5;
    if (e.type === 'dash' || e.type === 'overload' || e.type === 'phase')
        return .5;
    return .4;
}
function sparks(c, id, k, count, reach, angle) {
    for (let i = 0; i < count; i++) {
        const a = angle === undefined ? noise(id + i * 7) * TAU : angle + (noise(id + i * 7) - .5) * 2.6;
        const r = (5 + k * reach) * (.45 + noise(id + i * 13) * .75), length = (1 - k) * (4 + noise(id + i * 3) * 8);
        line(c, Math.cos(a) * r, Math.sin(a) * r, Math.cos(a) * (r + length), Math.sin(a) * (r + length) + k * k * 8);
    }
}
function damageText(c, value, k, scale, color, critical, prefix = '') {
    c.font = `800 ${Math.max(critical ? 19 : 14, (critical ? 14 : 11) / scale)}px sans-serif`;
    c.textAlign = 'center';
    c.textBaseline = 'middle';
    c.lineJoin = 'round';
    c.strokeStyle = '#14212a';
    c.lineWidth = 4;
    c.fillStyle = color;
    const text = `${prefix}${Math.max(1, Math.round(value))}${critical ? '!' : ''}`, y = -27 - k * 30;
    c.strokeText(text, 0, y);
    c.fillText(text, 0, y);
}
export function drawProjectile(c, b, time, reduced) {
    const angle = Math.atan2(b.vy, b.vx), enemy = b.owner === 'enemy', id = b.weapon ?? '', r = b.radius;
    c.save();
    c.translate(b.x, b.y);
    c.rotate(angle);
    c.lineCap = 'round';
    const trail = reduced ? 9 : id === 'W07' ? 88 : id === 'W10' ? 34 : id === 'W03' ? 26 : enemy ? 19 : 24;
    c.strokeStyle = enemy ? '#ff754f' : b.color;
    c.lineWidth = id === 'W07' ? 7 : Math.max(3, r * 1.4);
    c.globalAlpha = .22;
    line(c, -trail, 0, 1, 0);
    c.globalAlpha = .9;
    c.lineWidth = id === 'W07' ? 2 : 2.5;
    line(c, -trail * .75, 0, 2, 0);
    c.globalAlpha = 1;
    if (id === 'W10') {
        c.fillStyle = '#ff963f';
        c.beginPath();
        c.moveTo(-6, -4);
        c.lineTo(-18 - (reduced ? 0 : Math.sin(time * 45) * 5), 0);
        c.lineTo(-6, 4);
        c.fill();
        c.fillStyle = '#e6ddc3';
        c.beginPath();
        c.moveTo(10, 0);
        c.lineTo(3, -4);
        c.lineTo(-6, -4);
        c.lineTo(-6, 4);
        c.lineTo(3, 4);
        c.closePath();
        c.fill();
        c.fillStyle = '#713b2b';
        c.fillRect(-5, -5, 5, 10);
    }
    else if (id === 'W12') {
        c.fillStyle = '#b5f3ff';
        c.strokeStyle = '#63bedf';
        c.lineWidth = 1.5;
        c.beginPath();
        c.moveTo(11, 0);
        c.lineTo(-3, -5);
        c.lineTo(-8, 0);
        c.lineTo(-3, 5);
        c.closePath();
        c.fill();
        c.stroke();
        c.fillStyle = '#ffffff';
        c.beginPath();
        c.moveTo(8, 0);
        c.lineTo(-3, -2);
        c.lineTo(-3, 2);
        c.fill();
    }
    else if (id === 'W06') {
        c.fillStyle = '#b4a04c';
        circle(c, 0, 0, r + 2);
        c.fill();
        c.fillStyle = '#293c35';
        circle(c, 0, 0, r);
        c.fill();
        c.fillStyle = '#e7d68c';
        circle(c, 2, -2, 2);
        c.fill();
    }
    else if (id === 'W03') {
        c.fillStyle = '#52c9ec';
        c.beginPath();
        c.ellipse(0, 0, r * 2, r * 1.2, 0, 0, TAU);
        c.fill();
        c.fillStyle = '#d4faff';
        circle(c, 3, -1, 2.2);
        c.fill();
        if (!reduced) {
            c.globalAlpha = .6;
            circle(c, -13, Math.sin(time * 20 + b.eid) * 4, 2.2);
            c.fill();
        }
    }
    else if (id === 'W07') {
        c.strokeStyle = '#fff2ce';
        c.lineWidth = 3;
        line(c, -24, 0, 9, 0);
        c.fillStyle = '#fff9e7';
        circle(c, 4, 0, 3);
        c.fill();
    }
    else {
        c.fillStyle = enemy ? '#ff754f' : b.color;
        c.beginPath();
        c.ellipse(0, 0, enemy ? 7 : 6, enemy ? 5 : 3.5, 0, 0, TAU);
        c.fill();
        c.fillStyle = '#fff3c4';
        circle(c, 1, 0, enemy ? 2.5 : 2);
        c.fill();
    }
    c.restore();
}
function weaponEffect(c, e, k, reduced) {
    const id = e.source, range = e.radius ?? 110;
    c.rotate(e.angle ?? 0);
    if (id === 'W04' || id === 'W11')
        return;
    if (id === 'W05') {
        const length = range * (.72 + .28 * (1 - k));
        c.globalAlpha *= .55;
        c.fillStyle = '#ff7a31';
        c.beginPath();
        c.moveTo(12, -5);
        for (let i = 0; i <= 10; i++) {
            const a = -.62 + i * .124, r = length * (.7 + noise(e.id + i) * .3);
            c.lineTo(Math.cos(a) * r, Math.sin(a) * r);
        }
        c.lineTo(12, 5);
        c.closePath();
        c.fill();
        c.globalAlpha *= 1.4;
        c.fillStyle = '#ffe5a1';
        for (let i = 0; i < 7; i++) {
            const x = 20 + i * length / 9, y = Math.sin(e.id + i * 2) * x * .17;
            c.beginPath();
            c.ellipse(x, y, Math.max(4, 16 - i), Math.max(3, 10 - i * .8), 0, 0, TAU);
            c.fill();
        }
    }
    else if (id === 'W08' || id === 'W09') {
        const saw = id === 'W09', r = range * (.82 + .15 * k), a = saw ? TAU : Math.PI * 2 / 3;
        c.strokeStyle = saw ? '#ffe09d' : '#a7f4ef';
        c.lineWidth = reduced ? 3 : 7 * (1 - k) + 2;
        c.beginPath();
        c.arc(0, 0, r, saw ? 0 : -a / 2, saw ? TAU : a / 2);
        c.stroke();
        c.globalAlpha *= .35;
        c.lineWidth = 16;
        c.beginPath();
        c.arc(0, 0, r * .9, saw ? 0 : -a / 2, saw ? TAU : a / 2);
        c.stroke();
        c.globalAlpha = 1 - k;
        c.lineWidth = 2;
        if (!reduced)
            for (let i = 0; i < (saw ? 16 : 7); i++) {
                const angle = saw ? i * TAU / 16 + e.at * 9 : -a / 2 + i * a / 6;
                line(c, Math.cos(angle) * r, Math.sin(angle) * r, Math.cos(angle + .03) * (r + 8), Math.sin(angle + .03) * (r + 8));
            }
    }
    else {
        const color = id === 'W03' ? '#a0edff' : id === 'W12' ? '#bffaff' : id === 'W07' ? '#ffe6ad' : '#ffd992';
        c.translate(20, 0);
        c.fillStyle = color;
        const length = (id === 'W02' ? 35 : id === 'W07' ? 45 : 24) * (1 - k) + 4;
        c.beginPath();
        c.moveTo(-3, -4);
        c.lineTo(4, -8 * (1 - k));
        c.lineTo(length, 0);
        c.lineTo(4, 8 * (1 - k));
        c.lineTo(-3, 4);
        c.closePath();
        c.fill();
        c.fillStyle = '#fff6db';
        c.beginPath();
        c.ellipse(3, 0, 7 * (1 - k) + 1, 3, 0, 0, TAU);
        c.fill();
        if (id === 'W02' && !reduced) {
            c.strokeStyle = '#ebc391';
            c.lineWidth = 1.5;
            for (const a of [-.28, 0, .28])
                line(c, 8, 0, Math.cos(a) * 48, Math.sin(a) * 48);
        }
    }
}
export function drawCombatEffect(c, e, age, life, reduced, lang, scale, label, end) {
    const k = clamp(age / life), alpha = 1 - k;
    if (age < 0 || k >= 1)
        return;
    c.save();
    c.translate(e.x, e.y);
    c.globalAlpha = alpha;
    c.lineCap = 'round';
    c.lineJoin = 'round';
    c.strokeStyle = e.color ?? '#ffd58f';
    c.fillStyle = e.color ?? '#ffd58f';
    if (e.type === 'pickup') {
        const target = e.to ?? e, dx = target.x - e.x, dy = target.y - e.y, travel = reduced ? 1 : 1 - (1 - Math.min(1, k * 2.3)) ** 3;
        c.translate(dx * travel, dy * travel - (reduced ? 0 : Math.sin(travel * Math.PI) * 20));
        c.fillStyle = '#ffd76d';
        c.strokeStyle = '#fff2b5';
        c.lineWidth = 2 / scale;
        circle(c, 0, 0, 5 / scale);
        c.fill();
        c.stroke();
        if (k > .25 || reduced) {
            const text = `+${Number((e.amount ?? 0).toFixed(1))} ${lang === 'zh' ? '碎片' : 'scrap'}`;
            c.font = `800 ${12 / scale}px sans-serif`;
            c.textAlign = 'center';
            c.strokeStyle = '#17262b';
            c.lineWidth = 4 / scale;
            c.fillStyle = '#ffe7a3';
            c.strokeText(text, 0, -18 / scale - k * 14);
            c.fillText(text, 0, -18 / scale - k * 14);
        }
    }
    else if (e.type === 'scrap-drop') {
        c.strokeStyle = '#ffd96b';
        c.lineWidth = 2 / scale;
        circle(c, 0, 0, (8 + 18 * k) / scale);
        c.stroke();
        if (!reduced)
            sparks(c, e.id, k, 5, 25);
    }
    else if (e.type === 'fire')
        weaponEffect(c, e, k, reduced);
    else if (e.type === 'hit' || e.type === 'critical') {
        const critical = e.type === 'critical', angle = e.from ? Math.atan2(e.y - e.from.y, e.x - e.from.x) : undefined;
        c.lineWidth = critical ? 2.8 : 2;
        c.strokeStyle = critical ? '#ffe390' : e.color ?? '#f6d39f';
        if (!reduced && age < .24)
            sparks(c, e.id, clamp(age / .24), critical ? 10 : 6, critical ? 40 : 23, angle);
        if (age < .12) {
            c.globalAlpha = reduced ? .3 : (1 - age / .12) * .85;
            circle(c, 0, 0, (critical ? 13 : 8) * (1 + k));
            c.fillStyle = '#fff3d5';
            c.fill();
        }
        c.globalAlpha = alpha;
        if (label)
            damageText(c, label, k, scale, critical ? '#ffe47f' : '#fdf0d0', critical);
    }
    else if (e.type === 'arc') {
        const target = e.to ?? end, dx = target ? target.x - e.x : 24, dy = target ? target.y - e.y : 0, n = Math.max(4, Math.ceil(Math.hypot(dx, dy) / 32));
        c.beginPath();
        c.moveTo(0, 0);
        for (let i = 1; i <= n; i++) {
            const j = i === n || reduced ? 0 : (noise(e.id + i * 3) - .5) * 18;
            c.lineTo(dx * i / n + j, dy * i / n - j);
        }
        c.strokeStyle = '#49cdbd';
        c.lineWidth = 7;
        c.globalAlpha = alpha * .3;
        c.stroke();
        c.strokeStyle = '#caffed';
        c.lineWidth = 2;
        c.globalAlpha = alpha;
        c.stroke();
    }
    else if (e.type === 'player-hit') {
        const shield = (e.shieldDamage ?? 0) > 0 && !(e.hullDamage ?? 0), ink = shield ? '#a6fff3' : '#ff9677';
        c.strokeStyle = ink;
        c.lineWidth = 3;
        if (!reduced)
            sparks(c, e.id, k, 8, 35);
        circle(c, 0, -3, 30 + k * 15);
        c.globalAlpha = alpha * .65;
        c.stroke();
        c.globalAlpha = alpha;
        if (label)
            damageText(c, label, k, scale, ink, false, shield ? '◈ −' : '−');
    }
    else if (e.type === 'kill' || e.type === 'explosion' || e.type === 'enemy-explosion' || e.type === 'shield-break' || e.type === 'defeat') {
        const shield = e.type === 'shield-break', radius = shield ? 45 : e.type === 'kill' ? clamp((e.radius ?? 18) * 1.6, 24, 95) : clamp(e.radius ?? e.amount ?? 48, 25, 160);
        c.strokeStyle = shield ? '#b8fff1' : '#ffd29c';
        c.lineWidth = 3.5 * (1 - k) + .5;
        const r = 8 + radius * (1 - (1 - k) ** 3);
        circle(c, 0, 0, r);
        c.stroke();
        if (age < .14) {
            c.globalAlpha = alpha * (reduced ? .12 : .28);
            c.fillStyle = shield ? '#a4f7ef' : '#ffc783';
            circle(c, 0, 0, r * .8);
            c.fill();
        }
        c.globalAlpha = alpha;
        c.lineWidth = 2;
        if (!reduced) {
            sparks(c, e.id, k, shield ? 12 : 10, radius * .9);
            c.fillStyle = shield ? '#8ecbca' : '#53616a';
            for (let i = 0; i < 6; i++) {
                const a = noise(e.id + i) * TAU, d = k * radius * (.5 + noise(i + e.id * 2));
                c.save();
                c.translate(Math.cos(a) * d, Math.sin(a) * d + k * k * 22);
                c.rotate(a + k * 5);
                c.fillRect(-3, -2, 5 + i % 3, 4);
                c.restore();
            }
        }
    }
    else if (e.type === 'enemy-attack') {
        if (e.cue === 'circle' || e.cue === 'drill') {
            const radius = clamp(e.radius ?? 60, 20, 160), r = radius * (.7 + .3 * k);
            c.strokeStyle = '#ffba83';
            c.lineWidth = 6 * (1 - k) + 1;
            circle(c, 0, 0, r);
            c.stroke();
            if (!reduced) {
                c.lineWidth = 2;
                sparks(c, e.id, k, 10, radius * .7);
            }
        }
        else if (e.cue === 'spawn') {
            c.strokeStyle = '#a3dcb8';
            c.lineWidth = 3;
            circle(c, 0, 0, 30 + k * 55);
            c.stroke();
        }
    }
    else if (e.type === 'enemy-fire') {
        c.fillStyle = '#ffb483';
        circle(c, 0, 0, 5 + (1 - k) * 10);
        c.fill();
    }
    else if (e.type === 'dash' || e.type === 'overload' || e.type === 'phase' || e.type === 'stagger') {
        c.strokeStyle = e.type === 'dash' ? '#91e8e1' : '#ffdb9b';
        c.lineWidth = 2;
        circle(c, 0, 0, 20 + k * (e.type === 'phase' ? 90 : 45));
        c.stroke();
    }
    else if (e.type === 'heal') {
        if (e.amount)
            damageText(c, e.amount, k, scale, '#a2efc6', false, '+');
    }
    c.restore();
}
/** Draw inside the authoritative zone transform, beneath its boundary strokes. */
export function drawHazardEnergy(c, z, time, reduced) {
    const effect = z.plan?.effect, progress = clamp(1 - z.remaining / Math.max(.001, z.duration));
    c.save();
    c.lineCap = 'round';
    if (effect === 'pull') {
        c.strokeStyle = '#9fd5df';
        c.lineWidth = 2;
        c.globalAlpha = z.active ? .5 : .2;
        for (let i = 0; i < 3; i++) {
            const t = reduced ? (i + 1) / 4 : (i / 3 + (z.active ? time * .65 : 0)) % 1, r = z.radius * (1 - t);
            circle(c, 0, 0, r);
            c.stroke();
        }
    }
    else if (z.active && z.kind === 'cone' && z.source === 'B1B') {
        const inner = z.innerRadius ?? 100, outer = z.radius;
        c.strokeStyle = '#ffc48c';
        c.globalAlpha = .3;
        c.lineWidth = 20;
        line(c, inner, 0, outer, 0);
        c.globalAlpha = 1;
        c.strokeStyle = '#fff0c0';
        c.lineWidth = 5;
        line(c, inner, 0, outer, 0);
        c.fillStyle = '#e3b170';
        c.strokeStyle = '#263138';
        c.lineWidth = 3;
        c.beginPath();
        roundRect(c, outer - 21, -13, 31, 26, 4);
        c.fill();
        c.stroke();
        if (!reduced) {
            c.strokeStyle = '#ffd6a0';
            c.lineWidth = 2;
            for (let i = 0; i < 3; i++) {
                c.beginPath();
                c.arc(0, 0, outer - 15 - i * 19, -.35, -.08);
                c.stroke();
            }
        }
    }
    else if (z.active && z.kind === 'line' && effect !== 'projectile') {
        c.strokeStyle = '#ffb77f';
        c.globalAlpha = .3;
        c.lineWidth = (z.h ?? 20) * .7;
        line(c, 0, 0, z.w ?? z.radius, 0);
        c.globalAlpha = .9;
        c.strokeStyle = '#fff0cf';
        c.lineWidth = 4;
        line(c, 0, 0, z.w ?? z.radius, 0);
    }
    else if (z.active && effect === 'fire') {
        c.fillStyle = '#ffb14c';
        c.globalAlpha = .5;
        for (let i = 0; i < 7; i++) {
            const a = i * TAU / 7, r = z.radius * .6, x = Math.cos(a) * r, y = Math.sin(a) * r;
            c.beginPath();
            c.ellipse(x, y - 5, 5, 8 + (reduced ? 0 : Math.sin(time * 8 + i) * 3), 0, 0, TAU);
            c.fill();
        }
    }
    else if (z.active && z.kind === 'cone' && z.source === 'B2A') {
        c.strokeStyle = '#ffc678';
        c.globalAlpha = .7;
        c.lineWidth = 4;
        for (let i = -2; i <= 2; i++) {
            const a = i * (z.width ?? 1) / 6;
            line(c, Math.cos(a) * 50, Math.sin(a) * 50, Math.cos(a) * z.radius * .94, Math.sin(a) * z.radius * .94);
        }
    }
    else if (!z.active && effect !== 'spawn' && z.kind === 'circle' && z.radius < 200) {
        c.strokeStyle = '#ffbb8a';
        c.globalAlpha = .25 + progress * .4;
        c.lineWidth = 2;
        circle(c, 0, 0, z.radius * (1 - progress * .82));
        c.stroke();
    }
    c.restore();
}

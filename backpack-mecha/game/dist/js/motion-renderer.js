import { roundRect } from "./canvas.js?v=430d749de471";
import { motionLabel, zoneRole } from "./motion.js?v=430d749de471";
import { smoothStep } from "./visual-motion.js?v=430d749de471";
const TAU = Math.PI * 2;
const special = (e) => e.kind === 'boss' || ['E05', 'E12'].includes(e.id);
const labelWidths = new Map();
const labelTiles = new Map();
let canCacheLabels = typeof OffscreenCanvas === 'function';
function stroke(c, x, y, dx, dy) { c.beginPath(); c.moveTo(x, y); c.lineTo(x + dx, y + dy); c.stroke(); }
function arrow(c, x, y, angle, length) {
    const ux = Math.cos(angle), uy = Math.sin(angle), endX = x + ux * length, endY = y + uy * length;
    c.beginPath();
    c.moveTo(x, y);
    c.lineTo(endX, endY);
    c.lineTo(endX - ux * 7 + uy * 5, endY - uy * 7 - ux * 5);
    c.moveTo(endX, endY);
    c.lineTo(endX - ux * 7 - uy * 5, endY - uy * 7 + ux * 5);
    c.stroke();
}
/** Draw parts in the original atlas perspective. All motion comes from this snapshot. */
export function enemyBody(c, art, key, e, m, size, time, reduced, gait) {
    const wind = m.stage === 'windup', active = m.stage === 'active', free = !m.control;
    const amount = smoothStep(m.intensity ?? (wind ? m.progress : active ? 1 : 0));
    const stride = (gait?.stride ?? 0) * TAU, walking = gait?.amount ?? 0;
    const bob = reduced || !free ? 0 : Math.sin(stride * 2) * Math.min(2.5, size * .04) * walking + Math.sin(time * 2 + e.eid) * .35;
    const shotKick = m.fireAge === undefined ? 0 : Math.exp(-m.fireAge * 22);
    const recoil = reduced || !free ? 0 : (m.hit * .055 + shotKick * .045) * size;
    if (!special(e)) {
        const tilt = m.control === 'impact' ? -.045 : m.control === 'stagger' ? .045 : reduced || !free ? 0 : Math.sin(stride) * .018 * walking + (gait?.lean ?? 0) * .02;
        c.save();
        c.translate(e.x - Math.cos(m.angle) * recoil, e.y - size * .08 + bob - Math.sin(m.angle) * recoil);
        c.rotate(tilt);
        const part = (u, v, w, h, x = 0, y = 0) => art.part(c, key, x, y, size, size, u, v, w, h);
        const strideLift = reduced || !free ? 0 : Math.sin(stride) * size * .035 * walking;
        if (['E03', 'E08', 'E15'].includes(e.id)) {
            // Separate track beds from the sprung hull; each side responds to travel.
            part(0, 0, .23, 1, 0, strideLift * .4);
            part(.77, 0, .23, 1, 0, -strideLift * .4);
            part(.23, 0, .54, 1, Math.cos(e.angle) * size * .015, wind ? size * .025 * amount : 0);
            c.strokeStyle = 'rgba(214,226,211,.45)';
            c.lineWidth = 1;
            if (walking > .1 && !reduced)
                for (const side of [-1, 1])
                    for (let j = 0; j < 3; j++) {
                        const yy = ((j / 3 + (gait?.stride ?? 0)) % 1 - .5) * size * .45;
                        stroke(c, side * size * .34 - size * .055, yy, size * .11, 0);
                    }
        }
        else if (e.id === 'E06') {
            part(0, 0, 1, .65, 0, -size * .025);
            part(0, .65, .5, .35, -size * .012 * amount, strideLift);
            part(.5, .65, .5, .35, size * .012 * amount, -strideLift);
            c.fillStyle = m.stage === 'active' ? 'rgba(255,212,120,.75)' : 'rgba(96,225,201,.4)';
            c.beginPath();
            c.ellipse(0, size * .33, size * .055, size * (reduced ? .05 : .055 + .02 * Math.sin(time * 9)), 0, 0, TAU);
            c.fill();
        }
        else {
            // Independent leg groups keep a stable center shell rather than scaling the whole sprite.
            part(0, .48, .32, .52, -strideLift * .3, strideLift);
            part(.68, .48, .32, .52, strideLift * .3, -strideLift);
            part(.32, .48, .36, .52);
            part(0, 0, 1, .48, Math.cos(e.angle) * size * .015, wind ? -size * .018 * amount : active ? size * .02 : 0);
        }
        if (['E04', 'E07', 'E09', 'E11', 'E14', 'E16'].includes(e.id) && m.stage !== 'idle' && free) {
            const px = Math.cos(m.angle) * size * .28, py = Math.sin(m.angle) * size * .22;
            c.strokeStyle = active ? '#fff4cf' : '#ffd397';
            c.lineWidth = 1.5;
            c.beginPath();
            c.arc(px, py, size * (.045 + amount * .025), 0, TAU);
            c.stroke();
            if (active) {
                c.fillStyle = '#ffe6a7';
                c.beginPath();
                c.arc(px, py, size * .04, 0, TAU);
                c.fill();
            }
        }
        enemyHardware(c, e, m, size, time, reduced);
        c.restore();
        return;
    }
    c.save();
    c.translate(e.x - Math.cos(m.angle) * recoil, e.y - size * .08 + bob - Math.sin(m.angle) * recoil);
    if (!reduced && free)
        c.rotate(Math.sin(stride) * .018 * walking);
    if (m.control === 'impact')
        c.rotate(-.045);
    else if (m.control === 'stagger')
        c.rotate(.045);
    const part = (u, v, w, h, x = 0, y = 0) => art.part(c, key, x, y, size, size, u, v, w, h);
    if (e.id === 'E05') {
        part(0, .3, 1, .7);
        part(0, 0, 1, .3, 0, -size * .045 * amount);
        if (wind) {
            c.fillStyle = '#ffdca1';
            for (let i = 0; i < 4; i++)
                if (m.progress > i / 4)
                    c.fillRect(-size * .17 + i * size * .09, -size * .03, size * .045, size * .16);
        }
    }
    else if (e.id === 'E12' || e.id === 'B1A') {
        part(0, .53, 1, .47);
        part(0, 0, 1, .53, 0, wind ? size * .045 * amount : m.control ? size * .025 : 0);
        if (m.kind === 'charge' && active && free && !reduced) {
            c.strokeStyle = '#cabda1';
            c.lineWidth = 2;
            c.save();
            c.rotate(m.angle);
            for (let i = -1; i <= 1; i++)
                stroke(c, -size * .43, i * size * .15, -size * (.12 + .04 * Math.sin(time * 15 + i)), 0);
            c.restore();
        }
    }
    else if (e.id === 'B1B') {
        part(0, .58, 1, .42);
        c.save();
        c.translate(-size * .12, size * .06);
        const swing = m.kind === 'sweep' ? (wind ? -.16 * amount : active ? Math.sin(m.angle) * .22 : 0) : -.07 * amount;
        c.rotate(free && !reduced ? swing : 0);
        part(0, 0, 1, .58, size * .12, -size * .06 - (reduced ? 0 : size * .025 * amount));
        c.restore();
        if (m.kind === 'pull' && active) {
            c.strokeStyle = '#a8dce6';
            c.lineWidth = 2;
            arrow(c, -size * .35, -size * .12, 0, size * .16);
            arrow(c, size * .35, -size * .12, Math.PI, size * .16);
        }
    }
    else if (e.id === 'B2A') {
        // Four surrounding regions leave a real opening; the two door halves slide apart.
        part(0, 0, 1, .42);
        part(0, .64, 1, .36);
        part(0, .42, .36, .22);
        part(.64, .42, .36, .22);
        const open = m.weak ? .055 : m.kind === 'fire' ? (active ? .04 : wind ? .012 * m.progress : 0) : 0;
        c.fillStyle = '#15221f';
        c.fillRect(-size * .14, -size * .07, size * .28, size * .192);
        if (open) {
            c.fillStyle = m.weak ? 'rgba(124,227,170,.3)' : 'rgba(255,168,74,.55)';
            c.beginPath();
            c.ellipse(0, size * .025, size * .07, size * .06, 0, 0, TAU);
            c.fill();
        }
        part(.36, .42, .14, .22, -size * open, 0);
        part(.5, .42, .14, .22, size * open, 0);
        if (m.weak) {
            c.strokeStyle = '#bbf4cd';
            c.lineWidth = 1.5;
            stroke(c, -size * .04, size * .025, size * .08, 0);
            stroke(c, 0, -size * .015, 0, size * .08);
        }
    }
    else if (e.id === 'B2B') {
        part(0, .28, 1, .72);
        part(0, 0, 1, .28, 0, wind ? -size * .03 * m.progress : 0);
        if (m.stage === 'windup' || m.stage === 'active') {
            c.strokeStyle = '#9edfe8';
            c.lineWidth = 2;
            c.beginPath();
            c.arc(0, -size * .17, size * .16, -Math.PI / 2, -Math.PI / 2 + (wind ? m.progress : 1) * TAU);
            c.stroke();
            if (active) {
                c.fillStyle = '#e0f7ef';
                c.fillRect(-size * .07, -size * .21, size * .14, size * .07);
            }
        }
    }
    else if (e.id === 'B3A') {
        part(0, 0, 1, .45);
        part(.33, .45, .34, .55);
        const spread = wind ? .025 * m.progress : active ? .045 : 0, lift = wind ? -.025 * m.progress : active ? .025 : 0;
        part(0, .45, .33, .55, -size * spread, size * lift);
        part(.67, .45, .33, .55, size * spread, size * lift);
        if (m.kind === 'beam' && m.stage !== 'idle') {
            c.fillStyle = active ? '#fff3cc' : '#efa96a';
            c.beginPath();
            c.ellipse(0, -size * .2, size * (wind ? .025 + .025 * m.progress : .065), size * .025, 0, 0, TAU);
            c.fill();
        }
    }
    else if (e.id === 'B3B') {
        const offset = e.offsetX ?? 0;
        if (!offset) {
            part(.2, 0, .6, 1);
            const open = (e.phase ?? 1) >= 2 ? .035 : 0, transition = reduced ? 1 : Math.min(1, Math.max(0, m.phaseAge / .5));
            part(0, 0, .2, 1, -size * open * transition, 0);
            part(.8, 0, .2, 1, size * open * transition, 0);
        }
        else
            art.draw(c, key, 0, 0, size, size);
        if (m.kind === 'bombard' || m.kind === 'volley') {
            c.fillStyle = active ? '#ffdf9e' : '#cf9f77';
            for (let i = -1; i <= 1; i++)
                if (active || m.progress > (i + 1) / 3)
                    c.fillRect(i * size * .15 - size * .025, size * .2, size * .05, size * .07);
        }
    }
    else
        art.draw(c, key, 0, 0, size, size);
    c.restore();
    if (e.id === 'B1B' && free && m.stage !== 'idle') {
        // Articulated boom and cable connect the machine to the real sweep endpoint.
        const sweeping = m.kind === 'sweep' && m.zone;
        const angle = m.zone ? (m.zone.active ? m.zone.angle : m.zone.plan?.angle ?? m.zone.angle) : m.angle;
        const end = sweeping ? { x: m.zone.x + Math.cos(angle) * m.zone.radius, y: m.zone.y + Math.sin(angle) * m.zone.radius } :
            { x: e.x + size * .13, y: e.y + size * .18 - (reduced ? 0 : wind ? size * .43 * amount : m.kind === 'pull' ? size * .2 : 0) };
        const start = { x: e.x - size * .08, y: e.y - size * .38 }, mid = { x: (start.x + end.x) * .5, y: Math.min(start.y, end.y) - size * .17 };
        c.save();
        c.lineJoin = 'round';
        c.lineCap = 'round';
        c.strokeStyle = '#1a2931';
        c.lineWidth = 12;
        c.beginPath();
        c.moveTo(start.x, start.y);
        c.lineTo(mid.x, mid.y);
        c.lineTo(end.x, end.y);
        c.stroke();
        c.strokeStyle = '#c6a477';
        c.lineWidth = 7;
        c.stroke();
        c.strokeStyle = '#f8d4a0';
        c.lineWidth = 2;
        c.stroke();
        c.fillStyle = '#546974';
        c.beginPath();
        c.arc(mid.x, mid.y, 7, 0, TAU);
        c.fill();
        c.strokeStyle = '#cbd5cb';
        c.lineWidth = 2;
        c.stroke();
        if (!sweeping || !active) {
            c.save();
            c.translate(end.x, end.y);
            c.rotate(sweeping ? angle : 0);
            c.fillStyle = '#71838a';
            c.strokeStyle = '#efc393';
            c.lineWidth = 3;
            c.beginPath();
            roundRect(c, -17, -11, 34, 22, 4);
            c.fill();
            c.stroke();
            c.fillStyle = active ? '#b7f6f2' : '#f1c383';
            c.fillRect(-9, 4, 18, 4);
            c.restore();
        }
        c.restore();
    }
    // These cues are directions and body status, never collision or damage boundaries.
    if (special(e) && m.stage !== 'idle' && !m.control && (m.zone || m.kind === 'charge') && ['charge', 'fire', 'sweep', 'volley', 'beam'].includes(m.kind) && e.id !== 'B2B') {
        c.strokeStyle = wind ? '#ffe2a5' : '#fff0c9';
        c.lineWidth = 2;
        arrow(c, e.x + Math.cos(m.angle) * (size * .42), e.y + Math.sin(m.angle) * (size * .42), m.angle, size * .18);
    }
    if (e.kind === 'boss' && (e.phase ?? 1) > 1) {
        c.strokeStyle = m.phaseAge < .8 ? '#f6dba7' : '#b8ac91';
        c.lineWidth = 2;
        for (let i = 0; i < (e.phase ?? 1); i++)
            stroke(c, e.x - size * .2 + i * size * .12, e.y + size * .35, 0, 6);
    }
}
/** Local-space articulated hardware differentiates new units from the donor chassis. */
export function enemyHardware(c, e, m, size, time, reduced) {
    const wind = m.stage === 'windup', active = m.stage === 'active', amount = wind ? smoothStep(m.progress) : active ? 1 : 0;
    const pulse = reduced || m.control ? 0 : Math.sin(time * 5 + e.eid) * .015;
    const kick = reduced || m.control || m.fireAge === undefined ? 0 : Math.exp(-m.fireAge * 22) * size * .08;
    c.save();
    c.lineJoin = 'round';
    c.lineCap = 'round';
    c.lineWidth = Math.max(1.4, size * .035);
    if (e.id === 'E13') {
        c.strokeStyle = '#6ee6bc';
        c.fillStyle = '#253d46';
        for (const side of [-1, 1]) {
            c.save();
            c.translate(side * size * .25, 0);
            c.rotate(side * (wind ? -.3 * amount : active ? .32 : .08));
            c.beginPath();
            c.moveTo(0, size * .22);
            c.lineTo(side * size * .22, -size * .16);
            c.lineTo(side * size * .09, -size * .34);
            c.lineTo(-side * size * .04, size * .02);
            c.closePath();
            c.fill();
            c.stroke();
            c.restore();
        }
        c.fillStyle = '#a7ffe0';
        c.fillRect(-size * .10, -size * .18, size * .2, size * .045);
    }
    else if (e.id === 'E14') {
        c.save();
        c.rotate(m.angle);
        c.translate(-kick, 0);
        c.strokeStyle = '#1a2834';
        c.lineWidth = size * .13;
        stroke(c, 0, 0, size * .56, 0);
        c.strokeStyle = '#b6d4e9';
        c.lineWidth = size * .065;
        stroke(c, 0, 0, size * .56, 0);
        c.strokeStyle = '#f38f7d';
        c.lineWidth = size * .025;
        stroke(c, size * .45, -size * .08, 0, size * .16);
        c.fillStyle = wind ? '#ffc4a3' : '#f17e6c';
        c.beginPath();
        c.arc(size * .12, -size * .1, size * (.035 + .03 * amount), 0, TAU);
        c.fill();
        c.restore();
    }
    else if (e.id === 'E15') {
        for (const side of [-1, 1]) {
            const x = side * size * .29, y = -size * (.10 + .07 * amount);
            c.fillStyle = '#253540';
            c.strokeStyle = '#eeb365';
            c.beginPath();
            roundRect(c, x - size * .10, y - size * .22, size * .20, size * .40, size * .04);
            c.fill();
            c.stroke();
            for (let i = 0; i < 3; i++) {
                c.fillStyle = wind && m.progress > i / 3 ? '#fff0b9' : '#b07e45';
                c.fillRect(x - size * .055, y - size * .14 + i * size * .1, size * .11, size * .055);
            }
        }
    }
    else if (e.id === 'E16') {
        c.strokeStyle = '#b89bf5';
        c.lineWidth = size * .035;
        c.beginPath();
        c.ellipse(0, -size * .1, size * (.42 + amount * .07), size * (.20 + amount * .035), 0, 0, TAU);
        c.stroke();
        for (let i = 0; i < 4; i++) {
            const a = i * TAU / 4 + (reduced || m.control ? 0 : time * .8), x = Math.cos(a) * size * .42, y = -size * .1 + Math.sin(a) * size * .2;
            c.fillStyle = wind || active ? '#f4e4ff' : '#937dcc';
            c.beginPath();
            c.arc(x, y, size * (.05 + pulse), 0, TAU);
            c.fill();
        }
        c.fillStyle = '#d8c6ff';
        c.beginPath();
        c.arc(0, -size * .1, size * (.06 + amount * .04), 0, TAU);
        c.fill();
    }
    c.restore();
}
export function enemyControl(c, e, m, size) {
    if (!m.control)
        return;
    c.save();
    c.translate(e.x, e.y);
    c.lineWidth = 2;
    if (m.control === 'ice') {
        c.fillStyle = 'rgba(152,222,243,.18)';
        c.strokeStyle = '#a4e7f7';
        c.beginPath();
        for (let i = 0; i < 6; i++) {
            const a = i * TAU / 6 - Math.PI / 6, x = Math.cos(a) * size * .48, y = Math.sin(a) * size * .44;
            i ? c.lineTo(x, y) : c.moveTo(x, y);
        }
        c.closePath();
        c.fill();
        c.stroke();
        c.translate(size * .35, -size * .38);
        for (let i = 0; i < 3; i++) {
            c.rotate(Math.PI / 3);
            stroke(c, -6, 0, 12, 0);
        }
    }
    else if (m.control === 'stagger') {
        c.strokeStyle = '#efd992';
        for (let i = -1; i <= 1; i++) {
            const x = i * size * .22, y = -size * .46 - Math.abs(i) * 3;
            stroke(c, x - 4, y, 8, 0);
            stroke(c, x, y - 4, 0, 8);
        }
    }
    else {
        c.strokeStyle = m.control === 'impact' ? '#ffc193' : '#d5dcde';
        for (const side of [-1, 1]) {
            const x = side * size * .48;
            stroke(c, x, -size * .2, 0, size * .4);
            stroke(c, x, -size * .2, -side * 7, 0);
            stroke(c, x, size * .2, -side * 7, 0);
        }
    }
    c.restore();
}
/** Labels render after hazards, with a CSS-size floor for narrow viewports. */
export function enemyMotionLabel(c, e, m, size, scale, lang, view, dpr = 1) {
    if (!special(e) && !m.control)
        return;
    if (e.id === 'B3B' && e.offsetX)
        return;
    if (e.x + size / 2 < view.x || e.x - size / 2 > view.x + view.w || e.y + size / 2 < view.y || e.y - size / 2 > view.y + view.h)
        return;
    const label = motionLabel(m, lang);
    if (!label)
        return;
    const font = Math.max(11, 10 / scale), y = Math.max(view.y + font, Math.min(view.y + view.h - font, e.y - size * .63 - font * .6));
    c.save();
    c.font = `bold ${font}px sans-serif`;
    c.textAlign = 'center';
    c.textBaseline = 'middle';
    const cacheKey = `${font}/${label}`;
    let width = labelWidths.get(cacheKey);
    if (width === undefined) {
        width = c.measureText(label).width + 12;
        if (labelWidths.size >= 256)
            labelWidths.clear();
        labelWidths.set(cacheKey, width);
    }
    const x = Math.max(view.x + width / 2 + 3, Math.min(view.x + view.w - width / 2 - 3, e.x));
    const ink = m.control === 'ice' ? '#b5eafa' : m.weak ? '#8ee9c1' : m.control ? '#f0d7ac' : m.stage === 'windup' ? '#ffe0a6' : '#f3ebd7';
    // Cache whole labels, not a new offscreen canvas for every enemy/frame. Older
    // browsers fall back to direct text; at most 48 raster labels stay resident.
    if (canCacheLabels) {
        const density = Math.max(1, scale * dpr), key = `${cacheKey}/${ink}/${density}`;
        let tile = labelTiles.get(key);
        if (!tile)
            try {
                const next = new OffscreenCanvas(Math.ceil(width * density), Math.ceil(font * 1.4 * density)), t = next.getContext('2d');
                if (t) {
                    t.scale(density, density);
                    t.fillStyle = 'rgba(12,24,31,.93)';
                    t.beginPath();
                    roundRect(t, 0, 0, width, font * 1.4, 3);
                    t.fill();
                    t.font = c.font;
                    t.textAlign = 'center';
                    t.textBaseline = 'middle';
                    t.fillStyle = ink;
                    t.fillText(label, width / 2, font * .7);
                    if (labelTiles.size >= 48)
                        labelTiles.delete(labelTiles.keys().next().value);
                    labelTiles.set(key, next);
                    tile = next;
                }
                else
                    canCacheLabels = false;
            }
            catch {
                canCacheLabels = false;
            }
        if (tile) {
            c.drawImage(tile, x - width / 2, y - font * .7, width, font * 1.4);
            c.restore();
            return;
        }
    }
    c.fillStyle = 'rgba(12,24,31,.93)';
    c.beginPath();
    roundRect(c, x - width / 2, y - font * .7, width, font * 1.4, 3);
    c.fill();
    c.fillStyle = ink;
    c.fillText(label, x, y);
    c.restore();
}
/** Same inner/outer geometry as combat.contains, including the crane's safe inner arc. */
export function zonePath(c, z) {
    c.beginPath();
    if (z.kind === 'circle')
        c.arc(0, 0, z.radius, 0, TAU);
    else if (z.kind === 'ring') {
        c.arc(0, 0, z.radius, 0, TAU);
        c.arc(0, 0, z.innerRadius ?? Math.max(0, z.radius - 22), 0, TAU, true);
    }
    else if (z.kind === 'cone') {
        const spread = z.width ?? Math.PI / 2, inner = z.innerRadius ?? 0;
        c.moveTo(Math.cos(-spread / 2) * inner, Math.sin(-spread / 2) * inner);
        c.arc(0, 0, z.radius, -spread / 2, spread / 2);
        if (inner)
            c.arc(0, 0, inner, spread / 2, -spread / 2, true);
        else
            c.lineTo(0, 0);
        c.closePath();
    }
    else
        c.rect(0, -(z.h ?? z.width ?? 20) / 2, z.w ?? z.radius, z.h ?? z.width ?? 20);
}
export function zoneSymbols(c, z, scale) {
    const role = zoneRole(z);
    c.lineWidth = 2;
    if (role === 'force') {
        c.strokeStyle = '#a8dce6';
        if (z.plan?.effect === 'pull')
            for (let i = 0; i < 4; i++) {
                const a = i * TAU / 4, r = z.radius * .65;
                arrow(c, Math.cos(a) * r, Math.sin(a) * r, a + Math.PI, 24);
            }
        else
            for (let x = 35; x < (z.w ?? z.radius); x += 100)
                arrow(c, x, 0, 0, 24);
    }
    else if (role === 'spawn') {
        c.strokeStyle = '#c4d9b5';
        stroke(c, -8, 0, 16, 0);
        stroke(c, 0, -8, 0, 16);
    }
    else if (z.kind === 'line') {
        c.strokeStyle = z.active ? '#fff1c5' : '#ffc9aa';
        for (const x of [0, z.w ?? z.radius]) {
            c.beginPath();
            c.arc(x, 0, 6, 0, TAU);
            c.stroke();
        }
    }
    if (!z.active && role === 'damage') {
        // Keep the exclamation at the origin, outside an annulus's intentionally empty center.
        if ((z.innerRadius ?? 0) > 0)
            return;
        c.fillStyle = '#ffe5c7';
        c.font = `bold ${Math.max(12, 10 / scale)}px sans-serif`;
        c.textAlign = 'center';
        c.textBaseline = 'middle';
        c.fillText('!', 0, 0);
    }
}

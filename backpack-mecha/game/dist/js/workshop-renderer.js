import { MODULE_BY_ID } from "./content.js?v=17e930db7a48";
import { activeSupports, getCells } from "./economy.js?v=17e930db7a48";
import { rarity } from "./rarity.js?v=17e930db7a48";
import { easeOut } from "./visual-motion.js?v=17e930db7a48";
const CELL = 150, TAU = Math.PI * 2;
const clamp = (n) => Math.max(0, Math.min(1, n));
const center = (item) => { const cells = getCells(item); return { x: cells.reduce((n, p) => n + p.x + .5, 0) / cells.length * CELL, y: cells.reduce((n, p) => n + p.y + .5, 0) / cells.length * CELL }; };
const signature = (i) => [i.id, i.x, i.y, i.rotation, i.tier, i.stored, i.link].join(':');
/** UI-only animation state. Inventory and hit-test coordinates stay authoritative. */
export class WorkshopRenderer {
    tiles = new Map();
    icons = new Map();
    links = new Map();
    departures = [];
    rejectedAt = -Infinity;
    rejectedUid = '';
    feedbackActive = false;
    session = '';
    needsFrame(reduced) { return !reduced || this.feedbackActive; }
    reject(uid, time) { this.rejectedUid = uid; this.rejectedAt = time; this.feedbackActive = true; }
    position(tile, time, reduced) {
        const to = center(tile.item), k = reduced ? 1 : easeOut((time - tile.at) / .3);
        return { x: tile.from.x + (to.x - tile.from.x) * k, y: tile.from.y + (to.y - tile.from.y) * k };
    }
    draw(canvas, run, o) {
        const session = `${run.seed}:${run.chassis}:${run.wave}`;
        if (session !== this.session) {
            this.tiles.clear();
            this.links.clear();
            this.departures = [];
            this.rejectedAt = -Infinity;
            this.feedbackActive = false;
            this.session = session;
        }
        const c = canvas.getContext('2d');
        if (!c)
            return;
        const first = this.tiles.size === 0, alive = new Set(run.items.map(i => i.uid));
        for (const item of run.items) {
            const old = this.tiles.get(item.uid);
            if (!old || signature(old.item) !== signature(item)) {
                if (old && !old.item.stored && item.stored)
                    this.departures.push({ tile: old, at: o.time });
                const to = center(item), from = old ? old.item.stored ? { x: to.x, y: to.y + 65 } : this.position(old, o.time, o.reduced) : { x: to.x, y: to.y + 28 };
                const turns = old ? ((item.rotation - old.item.rotation + 6) % 4 - 2) : 0;
                this.tiles.set(item.uid, { item: { ...item }, from, at: o.time, changed: !first, turn: turns * Math.PI / 2 });
            }
        }
        for (const [uid, tile] of this.tiles)
            if (!alive.has(uid)) {
                if (!tile.item.stored)
                    this.departures.push({ tile, at: o.time });
                this.tiles.delete(uid);
            }
        this.departures = this.departures.filter(d => o.time - d.at < .24).slice(-25);
        c.clearRect(0, 0, 750, 750);
        c.fillStyle = '#142126';
        c.fillRect(0, 0, 750, 750);
        c.lineWidth = 1;
        for (let y = 0; y < 5; y++)
            for (let x = 0; x < 5; x++) {
                const corner = x === 0 && y === 0 ? 0 : x === 4 && y === 0 ? 1 : x === 0 && y === 4 ? 2 : x === 4 && y === 4 ? 3 : -1, locked = corner >= 0 && !run.unlockedCorners.includes(corner);
                c.fillStyle = locked ? '#10191f' : '#1d2e34';
                c.fillRect(x * CELL + 5, y * CELL + 5, CELL - 10, CELL - 10);
                c.strokeStyle = '#324b51';
                c.strokeRect(x * CELL + 5.5, y * CELL + 5.5, CELL - 11, CELL - 11);
                if (locked) {
                    c.fillStyle = '#516167';
                    c.font = '27px monospace';
                    c.textAlign = 'center';
                    c.fillText('×', x * CELL + 75, y * CELL + 85);
                }
                else {
                    c.fillStyle = '#3d555d';
                    c.beginPath();
                    c.arc(x * CELL + 75, y * CELL + 75, 2, 0, TAU);
                    c.fill();
                }
            }
        for (const tile of this.tiles.values())
            if (!tile.item.stored)
                this.tile(c, tile, o, tile.item.uid === o.drag?.uid);
        if (!o.reduced)
            for (const departure of this.departures) {
                const k = clamp((o.time - departure.at) / .24);
                c.save();
                c.globalAlpha = (1 - k) * .65;
                c.translate(0, k * 30);
                this.tile(c, departure.tile, { ...o, selected: '' }, false);
                c.restore();
            }
        const active = activeSupports(run), linked = new Set();
        for (const support of active) {
            const a = this.tiles.get(support.uid), b = this.tiles.get(support.link);
            if (!a || !b)
                continue;
            const key = `${support.uid}:${support.link}`;
            linked.add(key);
            if (!this.links.has(key))
                this.links.set(key, o.time);
            const start = this.position(a, o.time, o.reduced), end = this.position(b, o.time, o.reduced);
            start.y += 40;
            end.y += 40;
            this.connection(c, start, end, o, this.links.get(key), support.uid === o.selected || support.link === o.selected);
        }
        for (const key of this.links.keys())
            if (!linked.has(key))
                this.links.delete(key);
        for (const option of o.placements) {
            const item = option.item;
            if (!item)
                continue;
            c.beginPath();
            c.arc((item.x + .5) * CELL, (item.y + .5) * CELL, 12, 0, TAU);
            const unlinked = MODULE_BY_ID[item.id].kind === 'support' && !option.linkedWeapon;
            c.fillStyle = unlinked ? '#f3ac62' : '#6ff3d3';
            c.fill();
            c.strokeStyle = '#10191f';
            c.lineWidth = 4;
            c.stroke();
            c.fillStyle = '#10191f';
            c.font = 'bold 22px sans-serif';
            c.textAlign = 'center';
            c.fillText(option.swappedUid ? '⇄' : option.autoRotated ? '↻' : unlinked ? '○' : '+', (item.x + .5) * CELL, (item.y + .5) * CELL + 8);
        }
        const preview = o.preview;
        if (preview?.item) {
            c.save();
            c.fillStyle = preview.ok ? (preview.swappedUid ? '#f3ac6244' : '#48d1c438') : '#f05b5b55';
            c.strokeStyle = preview.ok ? '#afffe4' : '#ff9d8d';
            c.lineWidth = 5;
            c.setLineDash([14, 9]);
            c.lineDashOffset = o.reduced ? 0 : -o.time * 45;
            for (const p of getCells(preview.item)) {
                c.fillRect(p.x * CELL + 8, p.y * CELL + 8, CELL - 16, CELL - 16);
                c.strokeRect(p.x * CELL + 8, p.y * CELL + 8, CELL - 16, CELL - 16);
            }
            c.restore();
            if (preview.ok && preview.linkedWeapon) {
                const a = center(preview.item), b = center(preview.linkedWeapon);
                a.y += 40;
                b.y += 40;
                this.connection(c, a, b, o, o.time - 1, true, true);
            }
        }
        if (o.drag) {
            const tile = this.tiles.get(o.drag.uid);
            if (tile) {
                c.save();
                c.translate(o.drag.point.x, o.drag.point.y - 12);
                c.rotate(o.reduced ? 0 : Math.sin(o.time * 5) * .035);
                c.fillStyle = '#09161a88';
                c.beginPath();
                c.ellipse(0, 30, 66, 24, 0, 0, TAU);
                c.fill();
                const icon = this.icon(tile.item.id, o);
                if (icon)
                    c.drawImage(icon, -72, -72, 144, 144);
                c.strokeStyle = preview?.ok ? '#afffe4' : '#ffb49a';
                c.lineWidth = 3;
                c.beginPath();
                c.arc(0, 0, 67, -.6, .6);
                c.stroke();
                c.restore();
            }
        }
        const reject = 1 - clamp((o.time - this.rejectedAt) / .38);
        if (reject > 0) {
            c.strokeStyle = `rgba(255,125,105,${reject})`;
            c.lineWidth = 7;
            c.strokeRect(4, 4, 742, 742);
        }
        else
            this.feedbackActive = false;
    }
    icon(id, o) {
        if (!o.ready)
            return;
        if (!this.icons.has(id)) {
            const canvas = document.createElement('canvas');
            canvas.width = 128;
            canvas.height = 128;
            o.icon(canvas, id);
            this.icons.set(id, canvas);
        }
        return this.icons.get(id);
    }
    tile(c, tile, o, dragging) {
        const item = tile.item, to = center(item), p = this.position(tile, o.time, o.reduced), cells = getCells(item), selected = item.uid === o.selected;
        const age = o.time - tile.at, k = clamp(age / .42), landing = tile.changed && !o.reduced ? Math.sin(k * Math.PI * 2) * Math.exp(-k * 4) * .14 : 0;
        const reject = item.uid === this.rejectedUid ? 1 - clamp((o.time - this.rejectedAt) / .38) : 0;
        const shake = o.reduced ? 0 : Math.sin(reject * TAU * 2) * reject * 9;
        c.save();
        c.translate(p.x + shake, p.y);
        c.scale(1 + landing, 1 - landing * .5);
        c.translate(-to.x, -to.y);
        c.globalAlpha *= dragging ? .3 : 1;
        c.fillStyle = rarity(item.tier).color + (selected ? '55' : '25');
        c.strokeStyle = selected ? '#fff5d4' : rarity(item.tier).color;
        c.lineWidth = selected ? 4 : 2;
        for (const cell of cells) {
            c.fillRect(cell.x * CELL + 9, cell.y * CELL + 9, CELL - 18, CELL - 18);
            c.strokeRect(cell.x * CELL + 9, cell.y * CELL + 9, CELL - 18, CELL - 18);
            for (const d of [{ x: 1, y: 0 }, { x: 0, y: 1 }])
                if (cells.some(q => q.x === cell.x + d.x && q.y === cell.y + d.y))
                    c.fillRect(cell.x * CELL + (d.x ? CELL - 15 : 10), cell.y * CELL + (d.y ? CELL - 15 : 10), d.x ? 30 : CELL - 20, d.y ? 30 : CELL - 20);
        }
        const icon = this.icon(item.id, o), lift = selected && !o.reduced ? 4 + Math.sin(o.time * 3) * 2 : 0;
        c.save();
        c.translate(to.x, to.y - 2 - lift);
        c.rotate(o.reduced ? 0 : -tile.turn * (1 - easeOut(age / .25)));
        if (icon)
            c.drawImage(icon, -64, -64, 128, 128);
        c.restore();
        c.textAlign = 'left';
        c.font = 'bold 19px monospace';
        c.fillStyle = rarity(item.tier).color;
        const first = cells.reduce((a, b) => a.y < b.y || a.y === b.y && a.x < b.x ? a : b);
        c.fillText(`${item.id} · ${rarity(item.tier).roman}`, first.x * CELL + 16, first.y * CELL + 29);
        if (selected) {
            c.strokeStyle = '#e6fff1';
            c.lineWidth = 4;
            const length = 18 + (o.reduced ? 0 : Math.sin(o.time * 4) * 3);
            for (const cell of cells)
                for (const sx of [-1, 1])
                    for (const sy of [-1, 1]) {
                        const x = (cell.x + .5) * CELL + sx * 61, y = (cell.y + .5) * CELL + sy * 61;
                        c.beginPath();
                        c.moveTo(x - sx * length, y);
                        c.lineTo(x, y);
                        c.lineTo(x, y - sy * length);
                        c.stroke();
                    }
        }
        if (tile.changed && k < 1 && !o.reduced) {
            c.strokeStyle = `rgba(173,255,222,${(1 - k) * .8})`;
            c.lineWidth = 3;
            c.beginPath();
            c.arc(to.x, to.y, 38 + 62 * easeOut(k), 0, TAU);
            c.stroke();
            for (let i = 0; i < 6; i++) {
                const a = i * TAU / 6, r = 50 + k * 65;
                c.beginPath();
                c.moveTo(to.x + Math.cos(a) * r, to.y + Math.sin(a) * r);
                c.lineTo(to.x + Math.cos(a) * (r + 10 * (1 - k)), to.y + Math.sin(a) * (r + 10 * (1 - k)));
                c.stroke();
            }
        }
        c.restore();
    }
    connection(c, a, b, o, born, selected, preview = false) {
        const middle = { x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 - 24 }, at = (t) => ({ x: (1 - t) ** 2 * a.x + 2 * (1 - t) * t * middle.x + t * t * b.x, y: (1 - t) ** 2 * a.y + 2 * (1 - t) * t * middle.y + t * t * b.y });
        c.save();
        c.lineCap = 'round';
        c.strokeStyle = '#102d30';
        c.lineWidth = 13;
        c.beginPath();
        c.moveTo(a.x, a.y);
        c.quadraticCurveTo(middle.x, middle.y, b.x, b.y);
        c.stroke();
        c.strokeStyle = preview ? '#b0e9e0' : '#6ff3d3';
        c.lineWidth = selected ? 5 : 3.5;
        if (preview)
            c.setLineDash([9, 8]);
        c.globalAlpha = preview ? .6 : .85;
        c.stroke();
        c.setLineDash([]);
        if (!o.reduced)
            for (let i = 0; i < 3; i++) {
                const progress = ((o.time - born) * .85 + i / 3) % 1, head = at(progress), tail = at(Math.max(0, progress - .11));
                c.strokeStyle = '#e5fff1';
                c.lineWidth = selected ? 6 : 4;
                c.globalAlpha = .9;
                c.beginPath();
                c.moveTo(tail.x, tail.y);
                c.lineTo(head.x, head.y);
                c.stroke();
            }
        c.globalAlpha = 1;
        for (const p of [a, b]) {
            c.fillStyle = '#153e3d';
            c.beginPath();
            c.arc(p.x, p.y, 9, 0, TAU);
            c.fill();
            c.strokeStyle = '#8cf7d8';
            c.lineWidth = 2;
            c.stroke();
            c.fillStyle = '#d1ffec';
            c.beginPath();
            c.arc(p.x, p.y, 3.5, 0, TAU);
            c.fill();
        }
        // Direction remains readable when animation is disabled.
        const mid = at(.62), angle = Math.atan2(b.y - a.y, b.x - a.x);
        c.translate(mid.x, mid.y);
        c.rotate(angle);
        c.strokeStyle = '#d1ffec';
        c.lineWidth = 3;
        c.beginPath();
        c.moveTo(-6, -6);
        c.lineTo(1, 0);
        c.lineTo(-6, 6);
        c.stroke();
        c.restore();
    }
}

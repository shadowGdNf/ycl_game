export const COLORS = {
    pink: { fill: '#F58EAE', light: '#FFD6E3', dark: '#C74D77', name: 'Strawberry', symbol: '♥' },
    yellow: { fill: '#F7D56A', light: '#FFF0B9', dark: '#B48C29', name: 'Lemon', symbol: '✦' },
    mint: { fill: '#83D7BB', light: '#C8F2E1', dark: '#378E74', name: 'Mint', symbol: '•' },
    purple: { fill: '#B7A1E6', light: '#E6DAFF', dark: '#8061B4', name: 'Grape', symbol: '◆' },
};
const INK = '#423C53';
const W = 440, H = 600;
const reduced = () => window.matchMedia('(prefers-reduced-motion: reduce)').matches;
export class GameRenderer {
    canvas;
    onQueue;
    ctx;
    state = null;
    previous = null;
    release = null;
    hover = -1;
    hint = -1;
    hintUntil = 0;
    raf = 0;
    observer;
    paused = false;
    constructor(canvas, onQueue) {
        this.canvas = canvas;
        this.onQueue = onQueue;
        const ctx = canvas.getContext('2d');
        if (!ctx)
            throw new Error('Canvas is not supported');
        this.ctx = ctx;
        this.observer = new ResizeObserver(() => this.resize());
        this.observer.observe(canvas);
        let down = null;
        canvas.addEventListener('pointerdown', e => { down = { x: e.clientX, y: e.clientY }; });
        canvas.addEventListener('pointerup', e => {
            if (down && Math.hypot(e.clientX - down.x, e.clientY - down.y) < 14) {
                const p = this.point(e);
                const q = this.hit(p.x, p.y);
                if (q >= 0)
                    this.onQueue(q);
            }
            down = null;
        });
        canvas.addEventListener('pointercancel', () => { down = null; });
        canvas.addEventListener('pointermove', e => { const p = this.point(e); this.hover = this.hit(p.x, p.y); canvas.style.cursor = this.hover >= 0 ? 'pointer' : 'default'; });
        canvas.addEventListener('pointerleave', () => { this.hover = -1; down = null; });
        document.addEventListener('visibilitychange', () => { this.paused = document.hidden; if (!this.paused && !this.raf)
            this.loop(); });
        this.resize();
        this.loop();
    }
    point(e) { const r = this.canvas.getBoundingClientRect(); return { x: (e.clientX - r.left) * W / r.width, y: (e.clientY - r.top) * H / r.height }; }
    geometry() { const n = this.state?.queues.length || 4; const gap = n > 5 ? 9 : 13; const width = Math.min(78, (W - 48 - gap * (n - 1)) / n); return { n, gap, width, left: (W - (n * width + (n - 1) * gap)) / 2 }; }
    hit(x, y) { if (!this.state || this.state.status !== 'playing' || this.release)
        return -1; const g = this.geometry(); if (y < 36 || y > 307)
        return -1; for (let i = 0; i < g.n; i++) {
        const l = g.left + i * (g.width + g.gap);
        if (x >= l - 3 && x <= l + g.width + 3 && this.state.queues[i].length)
            return i;
    } return -1; }
    resize() { const r = this.canvas.getBoundingClientRect(); const dpr = Math.min(window.devicePixelRatio || 1, 2); this.canvas.width = Math.max(1, Math.round(r.width * dpr)); this.canvas.height = Math.round(this.canvas.width * H / W); this.draw(performance.now()); }
    loop = () => { this.raf = 0; if (this.paused)
        return; this.draw(performance.now()); this.raf = requestAnimationFrame(this.loop); };
    setState(state) { this.state = state; this.previous = null; this.release = null; this.draw(performance.now()); }
    showHint(index, duration = 3500) { this.hint = index; this.hintUntil = performance.now() + duration; }
    cancel() { this.previous = null; this.release = null; }
    animate(before, after, events) {
        this.previous = before;
        this.state = after;
        const e = events.find(e => e.type === 'release');
        if (e && e.color && e.queue !== undefined)
            this.release = { queue: e.queue, color: e.color, count: e.amount || 1, start: performance.now(), events };
        this.hint = -1;
    }
    path(x, y, w, h, r = 12) { this.ctx.beginPath(); this.ctx.roundRect(x, y, w, h, r); }
    rect(x, y, w, h, r, fill, stroke) { this.path(x, y, w, h, r); this.ctx.fillStyle = fill; this.ctx.fill(); if (stroke) {
        this.ctx.strokeStyle = stroke;
        this.ctx.lineWidth = 1.5;
        this.ctx.stroke();
    } }
    text(value, x, y, size = 12, color = INK, align = 'center', weight = 600) { const c = this.ctx; c.fillStyle = color; c.font = `${weight} ${size}px "Trebuchet MS", sans-serif`; c.textAlign = align; c.textBaseline = 'middle'; c.fillText(value, x, y); }
    candy(x, y, w, h, color, face = true, angle = 0) {
        const c = this.ctx, p = COLORS[color];
        c.save();
        c.translate(x, y);
        c.rotate(angle);
        c.fillStyle = p.dark + '25';
        this.path(-w / 2 + 1, -h / 2 + 3, w, h, Math.min(12, h * .35));
        c.fill();
        const grad = c.createLinearGradient(0, -h / 2, 0, h / 2);
        grad.addColorStop(0, p.light);
        grad.addColorStop(.25, p.fill);
        grad.addColorStop(1, p.fill);
        this.path(-w / 2, -h / 2, w, h, Math.min(12, h * .35));
        c.fillStyle = grad;
        c.fill();
        c.lineWidth = 1;
        c.strokeStyle = p.dark + '50';
        c.stroke();
        c.fillStyle = '#FFFFFF85';
        c.beginPath();
        c.ellipse(-w * .2, -h * .26, w * .2, 2.5, -.08, 0, Math.PI * 2);
        c.fill();
        if (face && w >= 25 && h >= 20) {
            c.fillStyle = INK;
            c.beginPath();
            c.ellipse(-w * .13, 0, 1.6, 2.1, 0, 0, Math.PI * 2);
            c.ellipse(w * .13, 0, 1.6, 2.1, 0, 0, Math.PI * 2);
            c.fill();
            c.beginPath();
            c.arc(0, 1.7, 3, 0.15, Math.PI - .15);
            c.strokeStyle = INK;
            c.lineWidth = 1.2;
            c.stroke();
            c.fillStyle = p.dark + '35';
            c.beginPath();
            c.ellipse(-w * .25, 4, 3, 1.5, 0, 0, Math.PI * 2);
            c.ellipse(w * .25, 4, 3, 1.5, 0, 0, Math.PI * 2);
            c.fill();
        }
        else if (w > 14) {
            this.text(p.symbol, 0, 1, Math.min(11, h * .55), p.dark);
        }
        c.restore();
    }
    tube(index, queue, now) {
        const c = this.ctx, g = this.geometry(), x = g.left + index * (g.width + g.gap), w = g.width;
        const hinted = index === this.hint && now < this.hintUntil, hover = this.hover === index;
        const top = queue[0], p = top ? COLORS[top] : null;
        if (hinted) {
            c.save();
            c.globalAlpha = .2 + .08 * Math.sin(now / 180);
            this.rect(x - 5, 34, w + 10, 276, 24, '#E67691');
            c.restore();
        }
        this.rect(x, 40, w, 260, 20, hover ? '#FFF3F2' : '#F1EAE6', hover ? '#E8ACB6' : '#E6DCD7');
        this.rect(x + 5, 45, w - 10, 229, 15, '#FFFCF7');
        c.save();
        this.path(x + 7, 47, w - 14, 222, 12);
        c.clip();
        const visible = queue.slice(0, 6), ch = Math.min(30, (206 - (visible.length - 1) * 5) / Math.max(visible.length, 1));
        visible.forEach((color, j) => { const y = 251 - j * (ch + 5); this.candy(x + w / 2, y, w - 19, ch, color, true, ((index + j) % 3 - 1) * .025); });
        c.restore();
        if (queue.length > 6)
            this.text(`+${queue.length - 6}`, x + w / 2, 65, 11, '#9B8593');
        if (!queue.length) {
            this.text('✓', x + w / 2, 169, 25, '#BBB0B1');
            this.text('EMPTY', x + w / 2, 197, 8, '#B8AAB0');
        }
        this.rect(x + 3, 276, w - 6, 27, 10, p ? p.fill : '#E6DDDA', p ? p.dark + '45' : undefined);
        this.text(p ? `${index + 1} ${p.symbol}` : `${index + 1}`, x + w / 2, 289, 12, p ? p.dark : '#A99BA2');
        if (top) {
            let run = 0;
            while (queue[run] === top)
                run++;
            c.beginPath();
            c.arc(x + w - 5, 45, 11, 0, Math.PI * 2);
            c.fillStyle = '#FFFDF8';
            c.fill();
            c.strokeStyle = '#E6DCD7';
            c.lineWidth = 1;
            c.stroke();
            this.text(`${run}`, x + w - 5, 45, 10, p.dark);
        }
        if (hinted) {
            this.text('TAP', x + w / 2, 322, 10, '#C74D77');
        }
    }
    drawCup(slot, state, now) {
        const c = this.ctx, cup = state.activeCups[slot], x = 79 + slot * 141, y = 434, w = 98, h = 96;
        if (!cup) {
            this.rect(x - w / 2, y - h / 2, w, h, 18, '#F4EEEA', '#EAE0DB');
            this.text('✓', x, y, 25, '#C9BCBE');
            return;
        }
        const p = COLORS[cup.color];
        c.save();
        this.rect(x - w / 2 + 3, y - h / 2 + 8, w - 6, h, 18, '#E2D5D125');
        this.rect(x - w / 2, y - h / 2, w, h, 18, '#FFFFFFA8', p.dark + '55');
        const fillHeight = 72 * cup.filled / cup.capacity;
        if (fillHeight > 0) {
            c.save();
            this.path(x - w / 2 + 5, y - h / 2 + 5, w - 10, h - 10, 14);
            c.clip();
            this.rect(x - w / 2 + 5, y + h / 2 - 5 - fillHeight, w - 10, fillHeight + 8, 5, p.fill + 'AA');
            c.restore();
        }
        this.rect(x - w / 2 - 3, y - h / 2 - 2, w + 6, 10, 5, p.light, p.dark + '55');
        c.globalAlpha = .6;
        c.fillStyle = '#FFF';
        c.beginPath();
        c.roundRect(x - w / 2 + 9, y - h / 2 + 15, 5, 43, 3);
        c.fill();
        c.globalAlpha = 1;
        this.candy(x, y - 9, 29, 23, cup.color, false);
        this.text(`${cup.filled} / ${cup.capacity}`, x, y + 19, 16, p.dark);
        c.restore();
        this.text(p.name.toUpperCase(), x, y + 64, 9, '#8E7E8E');
    }
    drawBuffer(state) {
        const c = this.ctx;
        this.text('THE WAITING ROOM', 26, 532, 10, '#95838D', 'left');
        const overflow = state.buffer.length > state.bufferSize;
        this.text(`${state.buffer.length} / ${state.bufferSize}`, 414, 532, 11, overflow ? '#C94D68' : '#95838D', 'right');
        const n = state.bufferSize, gap = 8, size = Math.min(39, (388 - gap * (n - 1)) / n), left = (W - (n * size + (n - 1) * gap)) / 2;
        for (let i = 0; i < n; i++) {
            const x = left + i * (size + gap);
            this.rect(x, 552, size, 34, 10, '#EEE7E2', overflow ? '#D88190' : '#E5DBD6');
            if (state.buffer[i])
                this.candy(x + size / 2, 569, size - 5, 27, state.buffer[i], size > 32);
            else
                this.text('·', x + size / 2, 568, 20, '#C6B8BC');
        }
        if (overflow)
            this.text('+', 424, 568, 21, '#C94D68');
    }
    drawFlow(now) {
        if (!this.release)
            return;
        const r = this.release, t = (now - r.start) / (reduced() ? 80 : 620), c = this.ctx, g = this.geometry();
        if (t > 1.1) {
            this.release = null;
            this.previous = null;
            return;
        }
        const startX = g.left + r.queue * (g.width + g.gap) + g.width / 2;
        // Buffer cascades can interleave colors; only follow this release's arrivals.
        const arrivals = r.events.filter(e => e.queue === r.queue && (e.type === 'collect' || e.type === 'buffer'));
        for (let i = 0; i < Math.min(r.count, 10); i++) {
            const q = Math.max(0, Math.min(1, (t - i * .035) / .64));
            if (q <= 0 || q >= 1)
                continue;
            const target = arrivals[i], endX = target?.slot !== undefined ? 79 + target.slot * 141 : 220, endY = target?.type === 'collect' ? 425 : 565;
            const x = startX + (endX - startX) * (q * q * (3 - 2 * q)), y = 284 + (endY - 284) * q;
            c.save();
            c.globalAlpha = Math.min(1, q * 7, (1 - q) * 6);
            this.candy(x, y, 23, 20, r.color, false, Math.sin(q * 8 + i) * .18);
            c.restore();
        }
        const complete = r.events.filter(e => e.type === 'complete').length;
        if (complete && t > .5) {
            c.save();
            c.globalAlpha = Math.max(0, Math.sin((t - .5) / .6 * Math.PI));
            this.text(complete > 1 ? `${complete}× SWEET COMBO!` : 'SWEET!', 220, 343, complete > 1 ? 17 : 15, '#C75C7A', 'center', 800);
            c.restore();
        }
    }
    draw(now) {
        const c = this.ctx;
        c.setTransform(this.canvas.width / W, 0, 0, this.canvas.height / H, 0, 0);
        c.clearRect(0, 0, W, H);
        if (!this.state)
            return;
        const state = this.release && this.previous ? this.previous : this.state;
        this.text('PICK A CHUTE. LET THE GOOD STUFF FLOW.', W / 2, 17, 10, '#9A8290');
        state.queues.forEach((queue, i) => this.tube(i, queue, now));
        c.save();
        c.strokeStyle = '#E7DBD5';
        c.lineWidth = 2;
        c.setLineDash([3, 7]);
        c.beginPath();
        c.moveTo(36, 337);
        c.lineTo(404, 337);
        c.stroke();
        c.restore();
        this.text('FILL & FLY', 28, 367, 10, '#95838D', 'left');
        this.text('UP NEXT', 300, 367, 8, '#9E8D98', 'right');
        state.pendingCups.slice(0, 2).forEach((cup, i) => { this.candy(324 + i * 31, 367, 22, 18, cup.color, false); this.text(`${cup.capacity}`, 324 + i * 31, 367, 8, COLORS[cup.color].dark); });
        if (!state.pendingCups.length)
            this.text('—', 344, 367, 12, '#B9ABB2');
        for (let i = 0; i < 3; i++)
            this.drawCup(i, state, now);
        this.drawBuffer(state);
        this.drawFlow(now);
    }
}

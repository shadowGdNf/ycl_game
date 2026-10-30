import { ENEMY_BY_ID, MODULE_BY_ID } from "./content.js?v=92ce38fe5a4a";
const spriteKey = (key) => ENEMY_BY_ID[key]?.sprite ?? String(MODULE_BY_ID[key]?.sprite ?? key);
const REQUIRED = ['actors', 'modules', 'enemies', 'cargo'];
export class Art {
    images = new Map();
    manifest = null;
    pending = null;
    environmentPending = false;
    flashes = new Map();
    timeoutMs;
    constructor(timeoutMs = 15000) { this.timeoutMs = timeoutMs; }
    get ready() { return this.manifest !== null && REQUIRED.every(key => this.images.has(key)); }
    load(onProgress) {
        if (this.pending)
            return this.pending;
        this.pending = this.fetchAssets(onProgress).finally(() => { this.pending = null; });
        return this.pending;
    }
    async retry(operation) {
        try {
            return await operation();
        }
        catch {
            return operation();
        }
    }
    async fetchAssets(onProgress) {
        if (!this.manifest)
            this.manifest = await this.retry(async () => {
                const controller = new AbortController(), timer = setTimeout(() => controller.abort(), this.timeoutMs);
                try {
                    const response = await fetch(new URL('../assets/atlas-manifest.json?v=92ce38fe5a4a', import.meta.url), { signal: controller.signal });
                    if (!response.ok)
                        throw new Error(`Atlas manifest failed: ${response.status}`);
                    const data = await response.json();
                    if (!data.sprites || REQUIRED.some(key => !data.atlases?.[key]))
                        throw new Error('Incomplete atlas manifest');
                    return data;
                }
                finally {
                    clearTimeout(timer);
                }
            });
        const report = () => onProgress?.({ loaded: REQUIRED.filter(key => this.images.has(key)).length, total: REQUIRED.length });
        report();
        // Retain successful images across retries; settle every request before enabling retry.
        const results = await Promise.allSettled(REQUIRED.map(async (name) => {
            if (this.images.has(name))
                return;
            this.images.set(name, await this.retry(() => this.loadImage(this.manifest.atlases[name])));
            report();
        }));
        const failed = results.find(result => result.status === 'rejected');
        if (failed?.status === 'rejected')
            throw failed.reason;
    }
    loadImage(path) {
        return new Promise((resolve, reject) => {
            const img = new Image();
            img.decoding = 'async';
            const finish = (error) => {
                clearTimeout(timer);
                img.onload = null;
                img.onerror = null;
                if (error) {
                    img.src = '';
                    reject(error);
                }
                else
                    resolve(img);
            };
            const timer = setTimeout(() => finish(new Error(`Artwork timed out: ${path}`)), this.timeoutMs);
            img.onload = () => finish();
            img.onerror = () => finish(new Error(`Cannot load artwork: ${path}`));
            img.src = new URL(`../assets/${path}`, import.meta.url).href;
        });
    }
    /** Decorative ground loading never blocks the first playable frame. */
    prepareEnvironment() {
        if (this.environmentPending || !this.manifest)
            return;
        this.environmentPending = true;
        void this.retry(() => this.loadImage(this.manifest.atlases.environment))
            .then(img => { this.images.set('environment', img); }).catch(() => { });
    }
    has(key) { return Boolean(this.manifest?.sprites[spriteKey(key)]); }
    draw(ctx, key, x, y, w, h, angle = 0, opacity = 1, flip = false) {
        const sprite = this.manifest?.sprites[spriteKey(key)];
        if (!sprite)
            return false;
        const im = this.images.get(sprite.atlas);
        if (!im)
            return false;
        const fit = Math.min(w / sprite.w, h / sprite.h);
        const dw = sprite.w * fit, dh = sprite.h * fit;
        ctx.save();
        ctx.translate(x, y);
        ctx.rotate(angle);
        if (flip)
            ctx.scale(1, -1);
        ctx.globalAlpha *= opacity;
        ctx.drawImage(im, sprite.x, sprite.y, sprite.w, sprite.h, -dw / 2, -dh / 2, dw, dh);
        if (MODULE_BY_ID[key]?.sprite) {
            ctx.strokeStyle = MODULE_BY_ID[key].color;
            ctx.fillStyle = MODULE_BY_ID[key].color;
            ctx.lineWidth = Math.max(1.5, w * .035);
            const n = Number(key.slice(1)) - 12;
            if (n === 1) {
                for (const offset of [-.16, 0, .16]) {
                    ctx.beginPath();
                    ctx.moveTo(0, h * offset);
                    ctx.lineTo(w * .42, h * offset);
                    ctx.stroke();
                }
            }
            if (n === 2) {
                ctx.beginPath();
                ctx.moveTo(-w * .2, 0);
                ctx.lineTo(w * .45, 0);
                ctx.stroke();
                ctx.fillRect(w * .2, -h * .2, w * .09, h * .4);
            }
            if (n === 3) {
                ctx.beginPath();
                ctx.arc(0, 0, Math.min(w, h) * .38, 0, Math.PI * 2);
                ctx.stroke();
            }
            if (n === 4) {
                for (const offset of [-.15, .15]) {
                    ctx.beginPath();
                    ctx.moveTo(w * .12, h * offset);
                    ctx.lineTo(w * .4, h * (offset * 1.8));
                    ctx.stroke();
                }
            }
            if (n === 5) {
                ctx.beginPath();
                ctx.moveTo(w * .06, -h * .3);
                ctx.lineTo(w * .34, 0);
                ctx.lineTo(w * .06, h * .3);
                ctx.stroke();
            }
            if (n === 6) {
                for (const offset of [-.28, 0, .28]) {
                    ctx.beginPath();
                    ctx.arc(w * offset, -h * .22, w * .07, 0, Math.PI * 2);
                    ctx.fill();
                }
            }
        }
        ctx.restore();
        return true;
    }
    /** Bounded cached silhouette; no per-frame pixel reads or mask allocations. */
    flash(ctx, key, x, y, w, h, opacity, color = '#fff1cf') {
        const s = this.manifest?.sprites[spriteKey(key)], im = s && this.images.get(s.atlas);
        if (!s || !im || opacity <= 0)
            return;
        const cacheKey = `${key}/${color}`;
        let mask = this.flashes.get(cacheKey);
        if (!mask) {
            const fit = Math.min(1, 256 / Math.max(s.w, s.h)), mw = Math.ceil(s.w * fit), mh = Math.ceil(s.h * fit);
            mask = typeof OffscreenCanvas === 'function' ? new OffscreenCanvas(mw, mh) : document.createElement('canvas');
            mask.width = mw;
            mask.height = mh;
            const c = mask.getContext('2d');
            if (!c)
                return;
            c.drawImage(im, s.x, s.y, s.w, s.h, 0, 0, mw, mh);
            c.globalCompositeOperation = 'source-in';
            c.fillStyle = color;
            c.fillRect(0, 0, mw, mh);
            if (this.flashes.size >= 40)
                this.flashes.delete(this.flashes.keys().next().value);
            this.flashes.set(cacheKey, mask);
        }
        const fit = Math.min(w / s.w, h / s.h);
        ctx.save();
        ctx.globalAlpha *= opacity;
        ctx.drawImage(mask, x - s.w * fit / 2, y - s.h * fit / 2, s.w * fit, s.h * fit);
        ctx.restore();
    }
    tile(ctx, key, x, y, w, h) {
        const s = this.manifest?.sprites[spriteKey(key)];
        if (!s)
            return;
        const im = this.images.get(s.atlas);
        if (!im)
            return;
        ctx.drawImage(im, s.x, s.y, s.w, s.h, x, y, w, h);
    }
    /** A normalized portion of an existing sprite, aligned to its full fitted rectangle. */
    part(ctx, key, x, y, w, h, u, v, uw, vh) {
        const s = this.manifest?.sprites[spriteKey(key)];
        if (!s)
            return;
        const im = this.images.get(s.atlas);
        if (!im)
            return;
        const fit = Math.min(w / s.w, h / s.h), dw = s.w * fit, dh = s.h * fit;
        ctx.drawImage(im, s.x + s.w * u, s.y + s.h * v, s.w * uw, s.h * vh, x - dw / 2 + dw * u, y - dh / 2 + dh * v, dw * uw, dh * vh);
    }
}

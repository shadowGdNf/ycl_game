export class Art {
    images = new Map();
    manifest = null;
    pending = null;
    environmentPending = false;
    get ready() { return this.manifest !== null && ['actors', 'modules', 'enemies'].every(key => this.images.has(key)); }
    load() {
        if (this.pending)
            return this.pending;
        this.pending = this.fetchAssets().catch(error => { this.pending = null; throw error; });
        return this.pending;
    }
    async fetchAssets() {
        const response = await fetch(new URL('../assets/atlas-manifest.json', import.meta.url));
        if (!response.ok)
            throw new Error(`Atlas manifest failed: ${response.status}`);
        const data = await response.json();
        await Promise.all(Object.entries(data.atlases).filter(([name]) => name !== 'environment').map(async ([name, path]) => {
            const img = new Image();
            img.decoding = 'async';
            const loaded = new Promise((resolve, reject) => { img.onload = () => resolve(); img.onerror = () => reject(new Error(`Cannot load artwork: ${path}`)); });
            img.src = new URL(`../assets/${path}`, import.meta.url).href;
            await loaded;
            this.images.set(name, img);
        }));
        this.manifest = data;
    }
    /** The 2.7 MB ground atlas is decorative and starts loading only during battle. */
    prepareEnvironment() {
        if (this.environmentPending || !this.manifest)
            return;
        this.environmentPending = true;
        const img = new Image();
        img.decoding = 'async';
        img.onload = () => { this.images.set('environment', img); };
        img.src = new URL(`../assets/${this.manifest.atlases.environment}`, import.meta.url).href;
    }
    has(key) { return Boolean(this.manifest?.sprites[key]); }
    draw(ctx, key, x, y, w, h, angle = 0, opacity = 1, flip = false) {
        const sprite = this.manifest?.sprites[key];
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
        ctx.restore();
        return true;
    }
    tile(ctx, key, x, y, w, h) {
        const s = this.manifest?.sprites[key];
        if (!s)
            return;
        const im = this.images.get(s.atlas);
        if (!im)
            return;
        ctx.drawImage(im, s.x, s.y, s.w, s.h, x, y, w, h);
    }
}

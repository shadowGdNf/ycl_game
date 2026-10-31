/** Actual combat event names are deliberately mapped; unhandled events stay silent. */
export function combatSound(e) {
    if (e.type === 'player-hit')
        return (e.hullDamage ?? e.amount ?? 0) > 0 ? 'hurt' : 'shield';
    if (e.type === 'warning')
        return e.source?.startsWith('B') ? 'warning' : undefined;
    const names = { 'shield-break': 'break', critical: 'critical', 'enemy-explosion': 'explosion', 'enemy-fire': 'enemy-shot',
        'boss-overload-warning': 'warning', 'boss-overload': 'phase', stagger: 'break', skill: 'overload' };
    if (e.type === 'enemy-attack')
        return { circle: 'slam', drill: 'slam', mortar: 'explosion', rect: 'beam', line: 'beam', cone: 'slam', ring: 'pulse', charge: 'charge', pull: 'pull', conveyor: 'pull', fire: 'burn', spawn: 'summon', projectile: 'enemy-shot', damage: e.shape === 'rect' || e.shape === 'line' ? 'beam' : 'slam' }[e.cue ?? 'circle'];
    return names[e.type] ?? (['fire', 'hit', 'kill', 'explosion', 'dash', 'overload', 'phase', 'pickup', 'heal'].includes(e.type) ? e.type : undefined);
}
export class GameAudio {
    ctx = null;
    gain = null;
    timer;
    note = 0;
    last = 0;
    theme = 'home';
    settings;
    lastPlayed = {};
    constructor(settings) { this.settings = settings; }
    configure(s) { this.settings = s; if (this.gain)
        this.gain.gain.value = s.volume * .25; }
    unlock() { try {
        this.ctx ??= new AudioContext();
        if (!this.gain) {
            this.gain = this.ctx.createGain();
            this.gain.gain.value = this.settings.volume * .25;
            this.gain.connect(this.ctx.destination);
        }
        void this.ctx.resume();
    }
    catch { } }
    tone(frequency, length, type = 'sine', volume = .3, slide = 1) { if (!this.ctx || !this.gain || this.ctx.state !== 'running')
        return; const t = this.ctx.currentTime, o = this.ctx.createOscillator(), g = this.ctx.createGain(); o.type = type; o.frequency.setValueAtTime(frequency, t); o.frequency.exponentialRampToValueAtTime(Math.max(20, frequency * slide), t + length); g.gain.setValueAtTime(.001, t); g.gain.exponentialRampToValueAtTime(Math.max(.002, volume), t + .008); g.gain.exponentialRampToValueAtTime(.001, t + length); o.connect(g); g.connect(this.gain); o.onended = () => { o.disconnect(); g.disconnect(); }; o.start(t); o.stop(t + length + .02); }
    play(type, source = '') {
        if (!this.settings.sound || !this.ctx)
            return;
        const t = this.ctx.currentTime;
        const key = type === 'fire' ? type + source : type;
        if (t - (this.lastPlayed[key] ?? -100) < (type === 'fire' ? .10 : type === 'hit' ? .07 : .045))
            return;
        this.lastPlayed[key] = t;
        const weapon = source.slice(0, 3);
        if (type === 'fire') {
            const tones = { W01: [135, .06, 'square', .18], W02: [75, .12, 'sawtooth', .2], W03: [650, .09, 'sine', .14], W04: [420, .12, 'triangle', .18], W05: [94, .06, 'sawtooth', .10], W06: [190, .14, 'triangle', .18], W07: [92, .2, 'square', .25], W08: [55, .16, 'triangle', .3], W09: [110, .07, 'sawtooth', .1], W10: [85, .18, 'sawtooth', .2], W11: [320, .05, 'sine', .12], W12: [840, .09, 'triangle', .13], W13: [180, .04, 'square', .1], W14: [920, .18, 'sawtooth', .15], W15: [240, .2, 'sine', .18], W16: [1050, .09, 'triangle', .14], W17: [65, .23, 'sawtooth', .2], W18: [510, .06, 'triangle', .12] };
            const [f, l, k, v] = tones[weapon] ?? tones.W01;
            this.tone(f, l, k, v, .55);
            return;
        }
        const attacks = { beam: [95, .3, 'sawtooth', .28, 2.3], pulse: [280, .28, 'triangle', .27, .3], charge: [80, .3, 'sawtooth', .26, 3], pull: [360, .4, 'sine', .23, .35], burn: [65, .28, 'sawtooth', .23, .5], summon: [180, .3, 'triangle', .24, 2] };
        if (attacks[type]) {
            this.tone(...attacks[type]);
            return;
        }
        const presets = { click: [440, .04, 'sine', .13, 1.2], rotate: [290, .06, 'triangle', .15, 1.4], connect: [630, .12, 'sine', .24, 1.5], invalid: [110, .13, 'square', .12, .8], buy: [720, .14, 'triangle', .25, 1.5], upgrade: [420, .24, 'sine', .25, 2], sell: [500, .12, 'sine', .2, .65], dash: [180, .12, 'sawtooth', .2, 2.1], overload: [240, .35, 'triangle', .3, 3], hit: [180, .07, 'triangle', .19, .35], critical: [620, .11, 'square', .2, .35], 'enemy-shot': [140, .1, 'sawtooth', .15, .5], slam: [65, .24, 'triangle', .3, .3], heal: [680, .16, 'sine', .13, 1.4], hurt: [73, .15, 'sawtooth', .25, .7], shield: [740, .2, 'sine', .2, .4], break: [160, .23, 'square', .26, .25], explosion: [65, .25, 'sawtooth', .28, .35], kill: [180, .08, 'triangle', .12, .7], pickup: [980, .11, 'sine', .23, 1.5], warning: [520, .18, 'triangle', .3, .7], phase: [240, .4, 'square', .22, 1.6], win: [520, .5, 'sine', .3, 2], lose: [230, .6, 'triangle', .3, .35], pause: [320, .12, 'sine', .15, .7], resume: [320, .12, 'sine', .15, 1.4], reward: [610, .3, 'triangle', .25, 1.7] };
        const p = presets[type] ?? presets.click;
        this.tone(...p);
    }
    consume(events) { for (const e of events) {
        if (e.id <= this.last)
            continue;
        this.last = e.id;
        const sound = combatSound(e);
        if (sound)
            this.play(sound, e.source ?? '');
    } }
    resetEvents() { this.last = 0; }
    music(theme) { this.theme = theme; if (this.timer !== undefined)
        return; this.timer = window.setInterval(() => { if (!this.settings.music || !this.ctx || this.ctx.state !== 'running')
        return; const home = [130.81, 164.81, 196, 164.81, 146.83, 174.61, 220, 174.61], battle = [110, 110, 130.81, 98, 110, 146.83, 130.81, 98]; const notes = this.theme === 'home' ? home : battle; this.tone(notes[this.note % 8], .36, 'triangle', .07, 1); if (this.note % 4 === 0)
        this.tone(notes[this.note % 8] / 2, .65, 'sine', .11, 1); this.note++; }, this.theme === 'home' ? 390 : 240); }
    suspend() { if (this.ctx)
        void this.ctx.suspend(); }
    resume() { if (this.ctx)
        void this.ctx.resume(); }
    stop() { if (this.timer !== undefined)
        window.clearInterval(this.timer); this.timer = undefined; }
}

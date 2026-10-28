/** At most one minute at 60 Hz per wave. Exact percentiles describe this window only. */
export const FRAME_WINDOW_LIMIT = 3600;
export class ForegroundFrameClock {
    previous;
    context;
    reset() { this.previous = undefined; this.context = undefined; }
    sample(now, context) {
        if (!context || !Number.isFinite(now)) {
            this.reset();
            return;
        }
        const elapsed = this.context === context && this.previous !== undefined ? now - this.previous : undefined;
        this.context = context;
        this.previous = now;
        return elapsed !== undefined && elapsed > 0 ? elapsed : undefined;
    }
}
export function appendFrame(window, interval, render, context) {
    if (!window || window.context !== context)
        window = { context, resets: (window?.resets ?? -1) + 1, total: 0, next: 0, intervals: [], renders: [] };
    const index = window.next;
    window.intervals[index] = interval;
    window.renders[index] = render;
    window.next = (index + 1) % FRAME_WINDOW_LIMIT;
    window.total++;
    return window;
}
export function sanitizeFrameWindow(value) {
    if (!value || typeof value !== 'object')
        return;
    const w = value, integer = (n) => Number.isSafeInteger(n) && Number(n) >= 0;
    if (typeof w.context !== 'string' || w.context.length > 2048 || !integer(w.resets) || !integer(w.total) || !integer(w.next) ||
        !Array.isArray(w.intervals) || !Array.isArray(w.renders) || w.intervals.length === 0 || w.intervals.length > FRAME_WINDOW_LIMIT ||
        w.intervals.length !== w.renders.length || w.total < w.intervals.length || w.next !== w.total % FRAME_WINDOW_LIMIT ||
        w.intervals.length !== Math.min(w.total, FRAME_WINDOW_LIMIT) ||
        !w.intervals.every(n => Number.isFinite(n) && n > 0) || !w.renders.every(n => Number.isFinite(n) && n >= 0))
        return;
    return { context: w.context, resets: w.resets, total: w.total, next: w.next, intervals: [...w.intervals], renders: [...w.renders] };
}
function distribution(values) {
    const sorted = [...values].sort((a, b) => a - b), n = sorted.length;
    return { samples: n, p50Ms: sorted[Math.ceil(n * .5) - 1], p95Ms: sorted[Math.ceil(n * .95) - 1],
        maxMs: sorted[n - 1], over50ms: values.filter(n => n > 50).length,
        over50Pct: values.filter(n => n > 50).length / n * 100 };
}
export function summarizeFrameWindow(window) {
    return { scope: 'most-recent-frames-in-current-context', limit: FRAME_WINDOW_LIMIT, context: window.context,
        contextResets: window.resets, totalInContext: window.total, discardedOlderSamples: window.total - window.intervals.length,
        retainedSeconds: window.intervals.reduce((n, v) => n + v, 0) / 1000,
        interval: distribution(window.intervals), render: distribution(window.renders) };
}

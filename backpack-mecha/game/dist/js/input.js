/** A held accessibility preference must release the edge-triggered skill during cooldown. */
export function overloadRequested(pressed, automatic, cooldown) {
    return pressed || (automatic && cooldown <= 0);
}
/** A second finger releasing the movement stick must not cancel a focus gesture. */
export class FocusGesture {
    press = null;
    begin(id, x, y, at) { if (!this.press)
        this.press = { id, x, y, at }; }
    move(id, x, y) { if (this.press?.id === id && Math.hypot(x - this.press.x, y - this.press.y) > 12)
        this.press = null; }
    end(id) { if (this.press?.id === id)
        this.press = null; }
    clear() { this.press = null; }
    take(now) {
        if (!this.press || now - this.press.at < 350)
            return;
        const { x, y } = this.press;
        this.press = null;
        return { x, y };
    }
}

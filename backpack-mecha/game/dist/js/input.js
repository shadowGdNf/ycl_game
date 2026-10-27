/** A held accessibility preference must release the edge-triggered skill during cooldown. */
export function overloadRequested(pressed, automatic, cooldown) {
    return pressed || (automatic && cooldown <= 0);
}

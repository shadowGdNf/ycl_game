import { getCells, previewSmartPlacement } from "./economy.js?v=dd56a56e7e0a";
/** Board coordinates are continuous grid units; grab preserves the exact point held. */
export function snapPlacement(run, uid, pointer, grab, rotation) {
    const origin = { x: pointer.x - grab.x, y: pointer.y - grab.y };
    const fallback = () => previewSmartPlacement(run, uid, Math.round(origin.x), Math.round(origin.y), rotation);
    if (![pointer.x, pointer.y, grab.x, grab.y].every(Number.isFinite) || pointer.x < -.4 || pointer.y < -.4 || pointer.x > 5.4 || pointer.y > 5.4)
        return { ok: false, reason: '拖到背包附近的高亮位置再松手', reasonEn: 'Release near a highlighted backpack position.', power: 0, capacity: 0, cells: 0, ready: false };
    // The entire occupied footprint is a swap target, including non-origin cells.
    const target = run.items.find(i => i.uid !== uid && !i.stored && getCells(i).some(p => pointer.x >= p.x && pointer.x < p.x + 1 && pointer.y >= p.y && pointer.y < p.y + 1));
    if (target) {
        const swap = previewSmartPlacement(run, uid, target.x, target.y, rotation, true, true, target.uid);
        if (swap.ok)
            return swap;
    }
    const candidates = [];
    for (let y = 0; y < 5; y++)
        for (let x = 0; x < 5; x++)
            if (Math.abs(x - origin.x) <= 1.1 && Math.abs(y - origin.y) <= 1.1)
                candidates.push({ x, y });
    candidates.sort((a, b) => Math.hypot(a.x - origin.x, a.y - origin.y) - Math.hypot(b.x - origin.x, b.y - origin.y));
    let best, bestScore = Infinity;
    for (const pos of candidates) {
        const plan = previewSmartPlacement(run, uid, pos.x, pos.y, rotation);
        if (!plan.ok || !plan.item)
            continue;
        const distance = Math.hypot(plan.item.x - origin.x, plan.item.y - origin.y);
        if (distance > 1.3)
            continue; // Never jump across the board to an unrelated opening.
        const score = distance + (plan.swappedUid ? .35 : 0) + (plan.autoRotated ? .08 : 0);
        if (score < bestScore) {
            best = plan;
            bestScore = score;
        }
    }
    return best ?? { ...fallback(), ok: false, reason: '附近没有合适位置，请移动到其他高亮位置', reasonEn: 'No nearby fit. Move to another highlighted position.' };
}

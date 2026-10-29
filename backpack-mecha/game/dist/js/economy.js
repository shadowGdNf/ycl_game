import { moduleValue, equipmentPrice, offerTier, validTier, rollShopTier } from "./rarity.js?v=0ed06082a6ae";
import { BOSSES, CHASSIS, CHASSIS_BY_ID, DEMO_IDS, EVENTS, MODULES, MODULE_BY_ID, PROTOCOLS, PROTOTYPE_IDS, WAVES } from "./content.js?v=0ed06082a6ae";
import { createEncounter } from "./encounters.js?v=0ed06082a6ae";
import { waveScrapLimit } from "./progression.js?v=0ed06082a6ae";
import { hashSeed, nextRandom } from "./random.js?v=0ed06082a6ae";
import { ensureJournal, recordAction, beginWaveRecord, finishWaveRecord, preserveJournal } from "./journal.js?v=0ed06082a6ae";
const CORNERS = [{ x: 0, y: 0 }, { x: 4, y: 0 }, { x: 0, y: 4 }, { x: 4, y: 4 }];
const ok = () => ({ ok: true });
const fail = (reason, reasonEn) => ({ ok: false, reason, reasonEn });
const extra = (r) => r.extra ?? (r.extra = {});
const copy = (v) => structuredClone(v);
const active = (r) => r.items.filter(i => !i.stored);
const def = (i) => MODULE_BY_ID[i.id];
const act = (r) => Math.min(3, Math.ceil(r.wave / 4));
const finalWave = (r) => r.mode === 'prototype' ? 4 : r.mode === 'demo' ? 8 : 12;
const eligibleIds = (r) => r.mode === 'prototype' ? PROTOTYPE_IDS : r.mode === 'demo' ? DEMO_IDS : MODULES.map(m => m.id);
const editable = (r) => ['prep', 'reward', 'protocol', 'expansion'].includes(r.phase);
const maxHP = (r) => CHASSIS_BY_ID[r.chassis].hp;
const finite = (v) => Number.isFinite(v) && v >= 0;
function log(r, message) { r.history.push(message); if (r.history.length > 500)
    r.history.shift(); recordAction(r, message); }
function replace(target, value) { for (const key of Object.keys(target))
    delete target[key]; Object.assign(target, value); }
function transaction(r, fn) { const draft = copy(r); const result = fn(draft); if (result.ok)
    replace(r, draft); return result; }
function roll(r, stream) { const [state, value] = nextRandom(r.rng[stream]); r.rng[stream] = state; return value; }
function pick(r, list, stream = 'event') { return list[Math.floor(roll(r, stream) * list.length)]; }
function emptyStats() { return { damageByModule: {}, damageTakenBy: {}, kills: 0, killedBudget: 0, goldEarned: 0, maxChain: 0, damageTaken: 0 }; }
function normalizeRotation(r) { return ((r % 4) + 4) % 4; }
function shape(id, rotation) {
    const m = MODULE_BY_ID[id];
    if (!m)
        return [];
    let points = m.shape.flatMap((row, y) => [...row].flatMap((c, x) => c === '#' ? [{ x, y }] : []));
    for (let i = 0; i < normalizeRotation(rotation); i++)
        points = points.map(p => ({ x: -p.y, y: p.x }));
    const minX = Math.min(...points.map(p => p.x)), minY = Math.min(...points.map(p => p.y));
    return points.map(p => ({ x: p.x - minX, y: p.y - minY }));
}
export function getCells(item) { return shape(item.id, item.rotation).map(p => ({ x: p.x + item.x, y: p.y + item.y })); }
export function getCapacity(r) { const battery = active(r).find(i => i.id === 'U01'); return r.power + (battery ? moduleValue('U01', battery.tier) : 0); }
export function getShieldCapacity(r) { const shield = active(r).find(i => i.id === 'U02'); return CHASSIS_BY_ID[r.chassis].shield + (shield ? moduleValue('U02', shield.tier) : 0) + (r.protocols.includes('P04') ? 20 : 0) + Number(r.extra?.temporaryShield ?? 0); }
export function standardCost(item) { return equipmentPrice(item.id, item.tier); }
export function offerPrice(offer) { return equipmentPrice(offer.id, offerTier(offer)); }
function compatible(s, w) { return s.kind === 'support' && w.kind === 'weapon' && (s.tags.includes('全部') || s.tags.some(t => w.tags.includes(t))); }
function adjacent(a, b) { return getCells(a).some(p => getCells(b).some(q => Math.abs(p.x - q.x) + Math.abs(p.y - q.y) === 1)); }
function validLink(r, s, w) { return !!w && !s.stored && !w.stored && compatible(def(s), def(w)) && adjacent(s, w); }
function repairLinks(r) {
    const weapons = active(r).filter(i => def(i).kind === 'weapon').sort((a, b) => a.y - b.y || a.x - b.x || a.uid.localeCompare(b.uid));
    const supports = active(r).filter(i => def(i).kind === 'support');
    const counts = {};
    for (const s of supports) {
        const w = weapons.find(w => w.uid === s.link);
        if (!validLink(r, s, w) || (counts[s.link] ?? 0) >= 2)
            delete s.link;
        else
            counts[s.link] = (counts[s.link] ?? 0) + 1;
    }
    for (const s of supports)
        if (!s.link) {
            const w = weapons.find(w => (counts[w.uid] ?? 0) < 2 && validLink(r, s, w));
            if (w) {
                s.link = w.uid;
                counts[w.uid] = (counts[w.uid] ?? 0) + 1;
            }
        }
    for (const i of r.items)
        if (i.stored || def(i).kind !== 'support')
            delete i.link;
}
function checkInventory(r, complete, power = true) {
    const equipped = active(r), ids = new Set(), counts = {}, occupied = new Set();
    if (r.items.filter(i => i.stored).length > 3)
        return fail('备件架最多容纳3件模块', 'The reserve holds at most three modules.');
    for (const i of r.items) {
        if (ids.has(i.uid) || !MODULE_BY_ID[i.id] || !eligibleIds(r).includes(i.id))
            return fail('存在重复编号或未开放的模块', 'Duplicate instance or unavailable module.');
        ids.add(i.uid);
        if (!validTier(i.tier))
            return fail('无效装备稀有度', 'Invalid equipment rarity.');
        if (!Number.isInteger(i.rotation) || i.rotation < 0 || i.rotation > 3)
            return fail('旋转参数无效', 'Invalid rotation.');
        if (i.stored)
            continue;
        const m = def(i);
        counts[i.id] = (counts[i.id] ?? 0) + 1;
        if (counts[i.id] > (m.kind === 'weapon' ? 2 : 1))
            return fail('同名武器最多2件，其他同名模块最多1件', 'Equip at most two identical weapons or one identical support/utility.');
        if (!Number.isInteger(i.x) || !Number.isInteger(i.y))
            return fail('模块必须对齐格子', 'Modules must align to the grid.');
        for (const p of getCells(i)) {
            const key = `${p.x},${p.y}`;
            if (p.x < 0 || p.y < 0 || p.x >= 5 || p.y >= 5)
                return fail('模块超出背包边界', 'The module is outside the backpack.');
            const corner = CORNERS.findIndex(c => c.x === p.x && c.y === p.y);
            if (corner >= 0 && !r.unlockedCorners.includes(corner))
                return fail('这个角格尚未解锁', 'This corner is still locked.');
            if (occupied.has(key))
                return fail('模块之间不能重叠', 'Modules cannot overlap.');
            occupied.add(key);
        }
    }
    const weapons = equipped.filter(i => def(i).kind === 'weapon');
    if (weapons.length > 3)
        return fail('最多装备3件武器', 'Equip at most three weapons.');
    if (complete && !weapons.length)
        return fail('至少装备一件武器才能出战', 'Equip at least one weapon before battle.');
    if (power && equipped.reduce((sum, i) => sum + def(i).power, 0) > getCapacity(r))
        return fail('电力不足，请移出模块或装备扩容电池', 'Power exceeded. Remove modules or equip a battery.');
    return ok();
}
export function validateLoadout(r) { return checkInventory(r, true); }
/** One source of truth for both warning UI and combat effects, including stale links. */
export function activeSupports(r) {
    const slots = new Map();
    return active(r).filter(s => {
        if (def(s).kind !== 'support' || !validLink(r, s, r.items.find(w => w.uid === s.link)))
            return false;
        const count = slots.get(s.link) ?? 0;
        if (count >= 2)
            return false;
        slots.set(s.link, count + 1);
        return true;
    });
}
export function inactiveSupports(r) { const enabled = new Set(activeSupports(r).map(s => s.uid)); return active(r).filter(s => def(s).kind === 'support' && !enabled.has(s.uid)); }
export function rewardTier(r, index) { const tier = r.extra?.[`rewardTier${index}`]; return validTier(tier) ? tier : 1; }
function rollRewardTiers(r) { r.rewardOptions.forEach((_, i) => extra(r)[`rewardTier${i}`] = rollShopTier(r.wave, roll(r, 'event'))); }
/** Copy only rule state: pointer previews never clone growing reports or sale snapshots. */
function previewRun(r) { const { journal, saleUndo, ...rules } = r; return copy({ ...rules, history: [] }); }
export function previewPlacement(r, uid, x, y, rotation) {
    const d = previewRun(r), item = d.items.find(i => i.uid === uid);
    let result = ok();
    if (!editable(d))
        result = fail('只能在休整时修改装备', 'Equipment can only be changed between battles.');
    else if (!item)
        result = fail('找不到模块', 'Module not found.');
    else if (!Number.isInteger(rotation))
        result = fail('旋转参数无效', 'Invalid rotation.');
    else {
        Object.assign(item, { x, y, rotation: normalizeRotation(rotation), stored: false });
        repairLinks(d);
        result = checkInventory(d, false);
    }
    const linkedWeapon = item?.link ? d.items.find(w => w.uid === item.link) : undefined;
    return { ...result, item, linkedWeapon, power: active(d).reduce((n, i) => n + def(i).power, 0), capacity: getCapacity(d), cells: active(d).reduce((n, i) => n + getCells(i).length, 0), ready: result.ok && validateLoadout(d).ok && !!item && (def(item).kind !== 'support' || activeSupports(d).some(s => s.uid === item.uid)) };
}
export function placementOptions(r, uid, rotation) {
    const options = [];
    for (const rot of rotation === undefined ? [0, 1, 2, 3] : [rotation])
        for (let y = 0; y < 5; y++)
            for (let x = 0; x < 5; x++) {
                const p = previewPlacement(r, uid, x, y, rot);
                if (p.ok)
                    options.push(p);
            }
    return options;
}
export function linkOptions(r, uid) {
    const s = r.items.find(i => i.uid === uid);
    if (!s || def(s).kind !== 'support')
        return [];
    return active(r).filter(i => def(i).kind === 'weapon').map(weapon => {
        const reason = !compatible(def(s), def(weapon)) ? 'incompatible' :
            activeSupports(r).filter(i => i.uid !== uid && i.link === weapon.uid).length >= 2 ? 'slots-full' :
                s.stored || !adjacent(s, weapon) ? 'not-adjacent' : 'ready';
        const result = reason === 'incompatible' ? fail('标签不兼容', 'Incompatible tags') : reason === 'slots-full' ? fail('连接位已满', 'Support slots full') :
            reason === 'not-adjacent' ? fail('需要边缘相邻', 'Place along a shared edge') : ok();
        return { weapon, result, reason };
    });
}
export function previewPurchase(r, index) {
    const d = previewRun(r), access = requireShop(d), offer = d.shop[index];
    if (!access.ok)
        return { result: access, placements: [], canReserve: false };
    if (!Number.isInteger(index) || !offer?.id)
        return { result: fail('该商品已售出', 'This offer is unavailable.'), placements: [], canReserve: false };
    const canReserve = d.items.filter(i => i.stored).length < 3;
    // A full reserve does not prevent a direct board purchase. Keep the hypothetical item
    // outside reserve for placement checks; every candidate replaces its coordinates.
    const item = newItem(d, offer.id, offerTier(offer));
    d.items.push(item);
    const placements = placementOptions(d, item.uid);
    const result = r.gold < offerPrice(offer) ? fail('碎片不足', 'Not enough scrap.') :
        canReserve || placements.length ? ok() : fail('备件架已满，当前布局也放不下；请先整理', 'Reserve full and no board placement. Make room first.');
    return { result, placements, canReserve };
}
function inventoryAction(r, fn) { if (!editable(r))
    return fail('只能在休整时修改装备', 'Equipment can only be changed between battles.'); return transaction(r, fn); }
export function placeItem(r, uid, x, y, rotation) {
    return inventoryAction(r, d => {
        const item = d.items.find(i => i.uid === uid);
        if (!item)
            return fail('找不到模块', 'Module not found.');
        if (!Number.isInteger(rotation))
            return fail('旋转参数无效', 'Invalid rotation.');
        Object.assign(item, { x, y, rotation: normalizeRotation(rotation), stored: false });
        repairLinks(d);
        const result = checkInventory(d, false);
        if (result.ok)
            log(d, `place:${uid}:${x},${y},${item.rotation}`);
        return result;
    });
}
export function storeItem(r, uid) {
    return inventoryAction(r, d => {
        const item = d.items.find(i => i.uid === uid);
        if (!item)
            return fail('找不到模块', 'Module not found.');
        if (item.stored)
            return ok();
        if (d.items.filter(i => i.stored).length >= 3)
            return fail('备件架已满', 'The reserve is full.');
        Object.assign(item, { stored: true, x: -1, y: -1 });
        delete item.link;
        repairLinks(d);
        log(d, `store:${uid}`);
        return checkInventory(d, false, false);
    });
}
export function setLink(r, uid, targetUid) {
    return inventoryAction(r, d => {
        const s = d.items.find(i => i.uid === uid), w = d.items.find(i => i.uid === targetUid);
        if (!s || def(s).kind !== 'support' || s.stored)
            return fail('请先选择已装配的支持模块', 'Select an equipped support module.');
        if (!targetUid) {
            delete s.link;
            return ok();
        }
        if (!validLink(d, s, w))
            return fail('目标必须是相邻的兼容武器', 'The target must be an adjacent compatible weapon.');
        if (active(d).filter(i => i.uid !== uid && i.link === targetUid).length >= 2)
            return fail('该武器的两个连接位已占满', 'Both support slots are occupied.');
        s.link = targetUid;
        log(d, `link:${uid}:${targetUid}`);
        return ok();
    });
}
function packEquipped(r) {
    const items = active(r), weapons = items.filter(i => def(i).kind === 'weapon'), supports = items.filter(i => def(i).kind === 'support');
    if (items.reduce((n, i) => n + shape(i.id, 0).length, 0) > 21 + r.unlockedCorners.length)
        return false;
    let blocked = 0;
    CORNERS.forEach((p, n) => { if (!r.unlockedCorners.includes(n))
        blocked |= 1 << (p.y * 5 + p.x); });
    const options = {};
    for (const item of items) {
        const seen = new Set();
        options[item.uid] = [];
        for (let rotation = 0; rotation < 4; rotation++) {
            const pts = shape(item.id, rotation), key = JSON.stringify(pts.map(p => `${p.x},${p.y}`).sort());
            if (seen.has(key))
                continue;
            seen.add(key);
            const width = Math.max(...pts.map(p => p.x)) + 1, height = Math.max(...pts.map(p => p.y)) + 1;
            for (let y = 0; y <= 5 - height; y++)
                for (let x = 0; x <= 5 - width; x++) {
                    const cells = pts.map(p => ({ x: x + p.x, y: y + p.y })), mask = cells.reduce((n, p) => n | (1 << (p.y * 5 + p.x)), 0);
                    if (!(mask & blocked))
                        options[item.uid].push({ x, y, rotation, mask, cells });
                }
        }
    }
    supports.sort((a, b) => weapons.filter(w => compatible(def(a), def(w))).length - weapons.filter(w => compatible(def(b), def(w))).length);
    const assigned = {}, slots = {};
    let nodes = 0, limit = 18000;
    const touching = (a, b) => a.cells.some(p => b.cells.some(q => Math.abs(p.x - q.x) + Math.abs(p.y - q.y) === 1));
    function positions(placed, used) {
        if (++nodes > limit)
            return undefined;
        if (Object.keys(placed).length === items.length)
            return placed;
        let best, bestOptions = [];
        for (const item of items) {
            if (placed[item.uid])
                continue;
            const neighbors = Object.entries(assigned).flatMap(([s, w]) => s === item.uid ? [w] : w === item.uid ? [s] : []);
            const available = options[item.uid].filter(p => !(p.mask & used) && neighbors.every(n => !placed[n] || touching(p, placed[n])));
            if (!available.length)
                return undefined;
            if (!best || available.length < bestOptions.length) {
                best = item;
                bestOptions = available;
            }
        }
        for (const p of bestOptions) {
            const result = positions({ ...placed, [best.uid]: p }, used | p.mask);
            if (result)
                return result;
        }
        return undefined;
    }
    function links(index) {
        if (nodes > limit)
            return false;
        if (index === supports.length) {
            const result = positions({}, blocked);
            if (!result)
                return false;
            for (const i of items) {
                const p = result[i.uid];
                Object.assign(i, { x: p.x, y: p.y, rotation: p.rotation });
                if (def(i).kind === 'support')
                    i.link = assigned[i.uid];
            }
            return true;
        }
        const s = supports[index];
        const choices = weapons.filter(w => compatible(def(s), def(w))).sort((a, b) => Number(b.uid === s.link) - Number(a.uid === s.link));
        for (const w of choices) {
            if ((slots[w.uid] ?? 0) >= 2)
                continue;
            assigned[s.uid] = w.uid;
            slots[w.uid] = (slots[w.uid] ?? 0) + 1;
            if (links(index + 1))
                return true;
            slots[w.uid]--;
            delete assigned[s.uid];
        }
        // An unsupported part may remain in the bag. Space and activation are separate.
        return links(index + 1);
    }
    if (links(0))
        return true;
    // Start a fresh spatial-only budget if connection search exhausted its allowance.
    nodes = 0;
    limit = 10000;
    for (const key of Object.keys(assigned))
        delete assigned[key];
    const loose = positions({}, blocked);
    if (!loose)
        return false;
    for (const item of items) {
        const p = loose[item.uid];
        Object.assign(item, { x: p.x, y: p.y, rotation: p.rotation });
        delete item.link;
    }
    repairLinks(r);
    return true;
}
export function autoPack(r) {
    return inventoryAction(r, d => {
        const original = copy(d.items), originalValid = checkInventory(d, false, false).ok, connected = activeSupports(d).length;
        if (!packEquipped(d)) {
            if (!originalValid)
                return fail('已装备模块超过可用空间，请移出一件后再整理', 'Equipped modules exceed the available space. Store one and try again.');
            d.items = original;
            repairLinks(d);
        }
        else if (originalValid && activeSupports(d).length < connected) {
            d.items = original;
            repairLinks(d);
        }
        log(d, 'auto-pack');
        return checkInventory(d, false, false);
    });
}
function available(r) { const ids = eligibleIds(r); return MODULES.filter(m => ids.includes(m.id)); }
function useful(r, s) { return active(r).some(i => compatible(s, def(i))); }
function weighted(r, pool, stream) {
    const weights = act(r) === 1 ? { C: 70, U: 30, R: 0 } : act(r) === 2 ? { C: 45, U: 45, R: 10 } : { C: 25, U: 50, R: 25 };
    const tiers = ['C', 'U', 'R'].filter(t => weights[t] > 0 && pool.some(m => m.rarity === t));
    let threshold = roll(r, stream) * tiers.reduce((n, t) => n + weights[t], 0);
    let tier = tiers[tiers.length - 1];
    for (const t of tiers) {
        threshold -= weights[t];
        if (threshold < 0) {
            tier = t;
            break;
        }
    }
    return pick(r, pool.filter(m => m.rarity === tier), stream);
}
function generateShop(r, visit) {
    const locked = r.shop.findIndex(o => o.locked && o.id);
    const retained = locked >= 0 ? copy(r.shop[locked]) : undefined;
    const used = new Set(retained ? [retained.id] : []);
    const pool = available(r);
    const next = r.shop.map(() => ({ id: '', locked: false }));
    while (next.length < 4)
        next.push({ id: '', locked: false });
    next.length = 4;
    const guarantee = r.wave >= Number(r.extra?.guaranteedSupportFromWave ?? 0) ? String(r.extra?.guaranteedSupportTag ?? '') : '';
    for (let i = 0; i < 4; i++) {
        if (i === locked && retained) {
            next[i] = retained;
            continue;
        }
        let candidates = pool.filter(m => !used.has(m.id));
        if (i < 3)
            candidates = candidates.filter(m => m.kind === ['weapon', 'support', 'utility'][i]);
        else {
            const guaranteed = guarantee ? candidates.filter(m => m.kind === 'support' && (m.tags.includes('全部') || m.tags.includes(guarantee))) : [];
            const compatiblePool = candidates.filter(m => useful(r, m));
            if (guaranteed.length) {
                candidates = guaranteed;
                delete extra(r).guaranteedSupportTag;
                delete extra(r).guaranteedSupportFromWave;
            }
            else if (compatiblePool.length && (r.shopPity >= 2 || roll(r, 'shop') < .5))
                candidates = compatiblePool;
        }
        if (!candidates.some(m => m.rarity !== 'R') && act(r) === 1)
            candidates = pool.filter(m => !used.has(m.id) && m.rarity !== 'R');
        if (candidates.length) {
            const owned = candidates.filter(m => r.items.some(item => item.id === m.id && item.tier < 4));
            const m = owned.length && roll(r, 'shop') < .3 ? pick(r, owned, 'shop') : weighted(r, candidates, 'shop');
            next[i] = { id: m.id, locked: false, tier: rollShopTier(r.wave, roll(r, 'shop')) };
            used.add(m.id);
        }
    }
    r.shop = next;
    if (visit) {
        if (r.shop.some(o => o.id && useful(r, MODULE_BY_ID[o.id])))
            r.shopPity = 0;
        else
            r.shopPity++;
    }
    recordAction(r, visit ? 'shop:visit' : 'shop:refresh');
}
function requireShop(r) { return r.phase === 'prep' && r.wave > 1 && r.shop.length === 4 ? ok() : fail('当前不在商店', 'The shop is not available now.'); }
function newItem(r, id, tier = 1) { return { uid: `i${r.nextUid++}`, id, tier, x: -1, y: -1, rotation: 0, stored: true }; }
function receive(r, id, placement, tier = 1) {
    const item = newItem(r, id, tier);
    r.items.push(item);
    if (placement) {
        if (!Number.isInteger(placement.rotation))
            return fail('旋转参数无效', 'Invalid rotation.');
        Object.assign(item, placement, { rotation: normalizeRotation(placement.rotation), stored: false });
        repairLinks(r);
        return checkInventory(r, false);
    }
    if (r.items.filter(i => i.stored).length <= 3)
        return ok();
    // Rewards may find an open cell, but do not move or discard existing equipment.
    for (let rotation = 0; rotation < 4; rotation++)
        for (let y = 0; y < 5; y++)
            for (let x = 0; x < 5; x++) {
                Object.assign(item, { x, y, rotation, stored: false });
                repairLinks(r);
                if (checkInventory(r, true).ok)
                    return ok();
            }
    return fail('备件架已满且背包没有合法位置，请先腾出位置或领取碎片', 'No reserve or legal backpack space. Make room or take scrap.');
}
export function buy(r, index, placement) {
    return transaction(r, d => {
        const access = requireShop(d);
        if (!access.ok)
            return access;
        const offer = d.shop[index];
        if (!Number.isInteger(index) || !offer?.id)
            return fail('该商品已售出', 'This offer is unavailable.');
        const m = MODULE_BY_ID[offer.id], price = offerPrice(offer);
        if (!validTier(offerTier(offer)))
            return fail('无效商品稀有度', 'Invalid offer rarity.');
        if (d.gold < price)
            return fail('碎片不足', 'Not enough scrap.');
        if (!placement && d.items.filter(i => i.stored).length >= 3)
            return fail('备件架已满，请选择背包位置后购买', 'Reserve full. Select a backpack placement before buying.');
        const result = receive(d, m.id, placement, offerTier(offer));
        if (!result.ok)
            return result;
        d.gold -= price;
        d.shop[index] = { id: '', locked: false };
        log(d, `buy:${m.id}:${price}:tier${offerTier(offer)}`);
        return ok();
    });
}
export function sell(r, uid) {
    return inventoryAction(r, d => {
        if (d.phase !== 'prep' || d.wave === 1)
            return fail('只能在商店出售', 'Sell equipment at a shop.');
        const item = d.items.find(i => i.uid === uid);
        if (!item)
            return fail('找不到模块', 'Module not found.');
        const before = copy(d);
        delete before.saleUndo;
        d.saleUndo = JSON.stringify(before);
        const price = Math.floor(standardCost(item) * .5);
        d.gold += price;
        d.items = d.items.filter(i => i.uid !== uid);
        repairLinks(d);
        log(d, `sell:${item.id}:${price}`);
        return ok();
    });
}
export function undoSale(r) {
    if (r.phase !== 'prep' || !r.saleUndo)
        return fail('没有可撤销的出售', 'No sale can be undone.');
    try {
        const before = JSON.parse(r.saleUndo);
        if (!before || before.wave !== r.wave || before.seed !== r.seed || before.phase !== 'prep')
            return fail('已离开原商店，不能撤销', 'You have left the original shop.');
        const stringArray = (v) => Array.isArray(v) && v.every(x => typeof x === 'string');
        const valid = before.version === 1 && before.mode === r.mode && before.chassis === r.chassis &&
            [before.gold, before.hp, before.shield, before.elapsed, before.nextUid, before.power, before.refreshes, before.shopPity].every(finite) &&
            before.rng && Object.values(before.rng).length === 4 && Object.values(before.rng).every(finite) &&
            ['history', 'protocols', 'bosses', 'rewardOptions', 'protocolOptions', 'eventsSeen'].every(k => stringArray(before[k])) &&
            Array.isArray(before.unlockedCorners) && Array.isArray(before.shop) && before.shop.length === 4 && before.shop.every(o => o && typeof o.locked === 'boolean' && (!o.id || !!MODULE_BY_ID[o.id])) &&
            before.stats && before.stats.damageByModule && before.stats.damageTakenBy && ['kills', 'killedBudget', 'goldEarned', 'maxChain', 'damageTaken'].every(k => finite(before.stats[k])) && checkInventory(before, false, false).ok;
        if (!valid)
            return fail('撤销记录不完整，当前装备和碎片已保留', 'The undo record is incomplete. Current equipment and scrap were preserved.');
        preserveJournal(r, before, 'undo-sale');
        replace(r, before);
        return ok();
    }
    catch {
        return fail('无法读取撤销记录', 'Unable to read the undo record.');
    }
}
export function mergeCandidates(r, uid) {
    const target = r.items.find(i => i.uid === uid);
    if (!target || target.tier >= 4)
        return [];
    return r.items.filter(i => i.uid !== uid && i.id === target.id && i.tier === target.tier).sort((a, b) => Number(b.stored) - Number(a.stored) || a.uid.localeCompare(b.uid));
}
function mergeDraft(r, uid, otherUid) {
    if (!editable(r))
        return fail('只能在休整时合成', 'Combine equipment between battles.');
    const target = r.items.find(i => i.uid === uid);
    if (!target)
        return fail('找不到模块', 'Module not found.');
    if (target.tier >= 4)
        return fail('已达传说最高稀有度', 'Already at Legendary rarity.');
    const donor = otherUid ? r.items.find(i => i.uid === otherUid) : mergeCandidates(r, uid)[0];
    if (!donor || donor.uid === uid || donor.id !== target.id || donor.tier !== target.tier)
        return fail('需要另一件同名、同稀有度装备', 'Requires another identical module of the same rarity.');
    // Prefer the equipped instance, so combining from reserve never unequips the only weapon.
    const keep = target.stored && !donor.stored ? donor : target, consume = keep === target ? donor : target;
    keep.tier = (keep.tier + 1);
    r.items = r.items.filter(i => i.uid !== consume.uid);
    repairLinks(r);
    const check = checkInventory(r, false, false);
    if (!check.ok)
        return check;
    const disconnected = active(r).filter(i => def(i).kind === 'support' && !i.link).map(i => i.uid);
    log(r, `merge:${keep.id}:${keep.tier}:${consume.uid}`);
    return { ok: true, item: keep, consumedUid: consume.uid, disconnected };
}
export function previewMerge(r, uid, otherUid) { return mergeDraft(previewRun(r), uid, otherUid); }
export function merge(r, uid, otherUid) { return transaction(r, d => mergeDraft(d, uid, otherUid)); }
/** Retained for local probe callers; upgrades now consume a matching copy and never charge scrap. */
export const upgrade = merge;
export function purchaseMergeTargets(r, index) {
    const offer = r.shop[index];
    if (!offer?.id || offerTier(offer) >= 4)
        return [];
    return r.items.filter(i => i.id === offer.id && i.tier === offerTier(offer)).sort((a, b) => Number(a.stored) - Number(b.stored));
}
export function buyAndMerge(r, index, uid) {
    return transaction(r, d => {
        const access = requireShop(d);
        if (!access.ok)
            return access;
        const offer = d.shop[index];
        if (!Number.isInteger(index) || !offer?.id || !purchaseMergeTargets(d, index).some(i => i.uid === uid))
            return fail('商品与目标装备不满足合成条件', 'Offer and equipment do not match for combining.');
        const price = offerPrice(offer);
        if (d.gold < price)
            return fail('碎片不足', 'Not enough scrap.');
        const material = newItem(d, offer.id, offerTier(offer));
        d.items.push(material);
        const result = mergeDraft(d, uid, material.uid);
        if (!result.ok)
            return result;
        d.gold -= price;
        d.shop[index] = { id: '', locked: false };
        log(d, `buy-merge:${offer.id}:${price}:tier${offerTier(offer)}`);
        return ok();
    });
}
export function repair(r) {
    return transaction(r, d => {
        const access = requireShop(d);
        if (!access.ok)
            return access;
        if (extra(d).repairedWave === d.wave)
            return fail('本次商店已维修', 'Repairs have already been used at this shop.');
        if (d.hp >= maxHP(d))
            return fail('生命已满', 'HP is already full.');
        const price = Math.ceil([18, 24, 30][act(d) - 1] * (d.difficulty >= 3 ? 1.25 : 1));
        if (d.gold < price)
            return fail('碎片不足', 'Not enough scrap.');
        d.gold -= price;
        d.hp = Math.min(maxHP(d), d.hp + 30);
        extra(d).repairedWave = d.wave;
        log(d, `repair:${price}`);
        return ok();
    });
}
export function refreshShop(r) { return transaction(r, d => { const access = requireShop(d); if (!access.ok)
    return access; const price = Math.min(10, (d.refreshes + 1) * 2); if (d.gold < price)
    return fail('碎片不足', 'Not enough scrap.'); d.gold -= price; d.refreshes++; generateShop(d, false); log(d, `refresh:${price}`); return ok(); }); }
export function toggleLock(r, index) { return transaction(r, d => { const access = requireShop(d); if (!access.ok)
    return access; if (!Number.isInteger(index) || !d.shop[index]?.id)
    return fail('请选择有效商品', 'Select an available offer.'); const lock = !d.shop[index].locked; for (const o of d.shop)
    o.locked = false; d.shop[index].locked = lock; return ok(); }); }
function enterPrep(r) {
    r.phase = 'prep';
    r.refreshes = 0;
    r.route = 0;
    delete r.saleUndo;
    r.eventResolved = true;
    delete r.eventId;
    if (r.insuranceUsed) {
        r.items = r.items.filter(i => i.id !== 'U12');
        repairLinks(r);
    }
    if (r.mode === 'full' && (r.wave === 3 || r.wave === 7)) {
        const events = EVENTS.filter(e => !r.eventsSeen.includes(e.id) && (e.id !== 'EV03' || act(r) >= 2));
        if (events.length) {
            r.eventId = pick(r, events).id;
            r.eventsSeen.push(r.eventId);
            r.eventResolved = false;
        }
    }
    generateShop(r, true);
}
function rewardOptions(r, rarity) { const ids = []; for (let i = 0; i < 3; i++) {
    const pool = available(r).filter(m => !ids.includes(m.id) && (rarity !== 'U' || m.rarity === 'U'));
    if (!pool.length)
        break;
    ids.push(weighted(r, pool, 'event').id);
} return ids; }
function beginRewards(r, kinds, returnTo) {
    extra(r).pendingRewardKinds = JSON.stringify(kinds.slice(1));
    extra(r).rewardReturn = returnTo;
    r.rewardOptions = rewardOptions(r, kinds[0]);
    rollRewardTiers(r);
    r.phase = 'reward';
    recordAction(r, 'reward-offer');
}
function protocols(r) {
    const pool = PROTOCOLS.filter(p => !r.protocols.includes(p.id) && (r.mode === 'full' || p.id !== 'P05'));
    const tags = active(r).filter(i => def(i).kind === 'weapon').flatMap(i => def(i).tags), chosen = [];
    const add = (p) => { const candidates = p.filter(p => !chosen.includes(p.id)); if (candidates.length)
        chosen.push(pick(r, candidates).id); };
    add(pool.filter(p => p.tags.some(t => tags.includes(t))));
    if (!chosen.length)
        add(pool.filter(p => !p.tags.length));
    add(pool.filter(p => !p.tags.length));
    while (chosen.length < 3 && chosen.length < pool.length)
        add(pool);
    return chosen;
}
export function newRun(chassis, mode, difficulty, seed) {
    seed = seed || 'backpack-mecha';
    const allowedChassis = mode === 'prototype' ? ['scavenger'] : mode === 'demo' ? ['scavenger', 'bulwark'] : CHASSIS.map(c => c.id);
    if (!allowedChassis.includes(chassis))
        chassis = 'scavenger';
    const c = CHASSIS_BY_ID[chassis];
    const r = { version: 1, mode, seed: seed || 'backpack-mecha', chassis, difficulty: mode === 'full' ? Math.max(0, Math.min(4, Math.floor(difficulty) || 0)) : 0, phase: 'prep', wave: 1, gold: 40, hp: c.hp, shield: c.shield, power: 10, maxTier: 4, unlockedCorners: [], items: [], shop: [], refreshes: 0, shopPity: 0, protocols: [], bosses: [], nextUid: 1, rng: { shop: hashSeed(`${seed}:shop`), map: hashSeed(`${seed}:map`), event: hashSeed(`${seed}:event`), combat: hashSeed(`${seed}:combat`) }, route: 0, rewardOptions: [], protocolOptions: [], eventsSeen: [], eventResolved: true, insuranceUsed: false, stats: emptyStats(), elapsed: 0, history: [], extra: {} };
    const gun = newItem(r, 'W01'), support = newItem(r, 'S01');
    Object.assign(gun, { x: 1, y: 0, stored: false });
    Object.assign(support, { x: 0, y: 1, stored: false, link: gun.uid });
    r.items = [gun, support];
    for (let a = 1; a <= finalWave(r) / 4; a++)
        r.bosses.push(mode === 'full' ? pick(r, BOSSES.filter(b => b.act === a), 'map').id : `B${a}A`);
    ensureJournal(r, false);
    recordAction(r, 'new-run');
    return r;
}
export function startWave(r) {
    return transaction(r, d => {
        if (d.phase !== 'prep' || d.wave > finalWave(d))
            return fail('当前不能开始战斗', 'A battle cannot start now.');
        if (d.eventId && !d.eventResolved)
            return fail('请先处理事件，或选择离开', 'Resolve or skip the event first.');
        const valid = validateLoadout(d);
        if (!valid.ok)
            return valid;
        d.shield = getShieldCapacity(d);
        d.phase = 'battle';
        delete d.saleUndo;
        beginWaveRecord(d);
        log(d, `start:${d.wave}:${d.route}`);
        return ok();
    });
}
function mergeStats(r, s) {
    for (const key of ['damageByModule', 'damageTakenBy'])
        for (const [id, value] of Object.entries(s[key]))
            if (finite(value))
                r.stats[key][id] = (r.stats[key][id] ?? 0) + value;
    for (const key of ['kills', 'killedBudget', 'goldEarned', 'damageTaken'])
        r.stats[key] += finite(s[key]) ? s[key] : 0;
    r.stats.maxChain = Math.max(r.stats.maxChain, s.maxChain || 0);
}
export function resolveBattle(r, result) {
    return transaction(r, d => {
        if (d.phase !== 'battle')
            return fail('这场战斗已经结算', 'This battle has already been resolved.');
        if (!finite(result.hp) || !finite(result.shield) || !finite(result.elapsed))
            return fail('战斗结算数据无效', 'Invalid battle result.');
        const wave = WAVES[d.wave - 1], completed = d.wave, e = extra(d);
        if (!wave)
            return fail('战斗节点无效', 'Invalid battle node.');
        d.hp = Math.min(maxHP(d), result.hp);
        d.shield = result.shield;
        d.elapsed += result.elapsed;
        d.insuranceUsed ||= result.insuranceUsed;
        if (result.rng !== undefined)
            d.rng.combat = result.rng;
        const s = copy(result.stats);
        s.goldEarned = Math.max(0, Math.min(waveScrapLimit(d.wave, createEncounter(d).state.budget), Number.isFinite(s.goldEarned) ? s.goldEarned : 0));
        mergeStats(d, s);
        d.gold += s.goldEarned;
        if (!result.won || d.hp <= 0) {
            d.phase = 'lost';
            finishWaveRecord(d, { ...result, stats: s }, s.goldEarned);
            log(d, `lost:${completed}:${result.reason ?? ''}`);
            return ok();
        }
        const riskGold = wave.kind === 'normal' ? (d.route === 1 ? 30 : Number(e.eventRewardGold ?? 0)) : 0;
        const riskModule = wave.kind === 'normal' && (d.route === 2 || e.eventRewardModule === true);
        d.gold += wave.base + riskGold;
        log(d, `won:${completed}:${wave.base + s.goldEarned + riskGold}`);
        finishWaveRecord(d, { ...result, stats: s }, wave.base + s.goldEarned + riskGold);
        for (const key of ['eventBudgetBonus', 'eventExtraElite', 'eventRewardGold', 'eventRewardModule', 'temporaryShield', 'eventTargetUid', 'eventTargetTag'])
            delete e[key];
        d.shield = Math.min(d.shield, getShieldCapacity(d));
        d.route = 0;
        if (completed === finalWave(d)) {
            d.phase = 'won';
            return ok();
        }
        if (wave.kind === 'boss')
            d.hp = Math.min(maxHP(d), d.hp + 30 + (d.protocols.includes('P08') ? 10 : 0));
        else if (d.protocols.includes('P08'))
            d.hp = Math.min(maxHP(d), d.hp + 8);
        d.wave++;
        delete d.saleUndo;
        if (wave.kind === 'boss') {
            d.power = completed === 4 ? 12 : 14;
            d.maxTier = 4;
            d.phase = 'expansion';
            d.protocolOptions = protocols(d);
            return ok();
        }
        const rewards = [];
        if ([2, 6, 10].includes(completed))
            rewards.push('any');
        if (riskModule)
            rewards.push('U');
        if (rewards.length)
            beginRewards(d, rewards, 'newPrep');
        else
            enterPrep(d);
        return ok();
    });
}
export function chooseReward(r, index) {
    return transaction(r, d => {
        if (d.phase !== 'reward')
            return fail('当前没有模块奖励', 'No module reward is pending.');
        let queue;
        try {
            const parsed = JSON.parse(String(extra(d).pendingRewardKinds ?? '[]'));
            if (!Array.isArray(parsed) || !parsed.every(v => v === 'any' || v === 'U'))
                return fail('奖励记录损坏，请从之前的存档恢复', 'The reward record is damaged. Restore a previous save.');
            queue = parsed;
        }
        catch {
            return fail('奖励记录损坏，请从之前的存档恢复', 'The reward record is damaged. Restore a previous save.');
        }
        if (index === -1)
            d.gold += 12;
        else {
            if (!Number.isInteger(index) || !d.rewardOptions[index])
                return fail('奖励选项无效', 'Invalid reward choice.');
            const received = receive(d, d.rewardOptions[index], undefined, rewardTier(d, index));
            if (!received.ok)
                return received;
        }
        log(d, `reward:${index === -1 ? 'scrap' : d.rewardOptions[index]}`);
        if (queue.length) {
            const next = queue.shift();
            extra(d).pendingRewardKinds = JSON.stringify(queue);
            d.rewardOptions = rewardOptions(d, next);
            rollRewardTiers(d);
            recordAction(d, 'reward-offer');
            return ok();
        }
        d.rewardOptions = [];
        for (let i = 0; i < 3; i++)
            delete extra(d)[`rewardTier${i}`];
        delete extra(d).pendingRewardKinds;
        const returnTo = extra(d).rewardReturn;
        delete extra(d).rewardReturn;
        if (returnTo === 'existingPrep')
            d.phase = 'prep';
        else
            enterPrep(d);
        return ok();
    });
}
export function chooseExpansion(r, corners) {
    return transaction(r, d => {
        if (d.phase !== 'expansion')
            return fail('当前没有扩容奖励', 'No expansion reward is pending.');
        const available = [0, 1, 2, 3].filter(i => !d.unlockedCorners.includes(i));
        if (corners.length !== 2 || new Set(corners).size !== 2 || corners.some(c => !available.includes(c)))
            return fail('请选择两个尚未解锁的角格', 'Choose two locked corners.');
        d.unlockedCorners.push(...corners);
        d.unlockedCorners.sort();
        d.phase = 'protocol';
        log(d, `expand:${corners.join(',')}`);
        return ok();
    });
}
export function chooseProtocol(r, id) {
    return transaction(r, d => {
        if (d.phase !== 'protocol' || !d.protocolOptions.includes(id) || d.protocols.includes(id))
            return fail('协议选项无效', 'Invalid protocol choice.');
        d.protocols.push(id);
        d.protocolOptions = [];
        log(d, `protocol:${id}`);
        enterPrep(d);
        return ok();
    });
}
export function setRoute(r, route) {
    return transaction(r, d => {
        if (d.phase !== 'prep' || ![0, 1, 2].includes(route))
            return fail('当前不能更改路线', 'The route cannot be changed now.');
        if (route !== 0 && (d.wave === 1 || WAVES[d.wave - 1]?.kind === 'boss'))
            return fail('此战没有风险合同', 'This battle has no risk contract.');
        if (route !== 0 && (Number(d.extra?.eventBudgetBonus ?? 0) > 0 || Number(d.extra?.eventExtraElite ?? 0) > 0))
            return fail('事件已附加风险，不能叠加第二个合同', 'An event already adds risk; contracts cannot stack.');
        d.route = route;
        log(d, `route:${route}`);
        return ok();
    });
}
export function resolveEvent(r, choice) {
    return transaction(r, d => {
        if (d.phase !== 'prep' || d.mode !== 'full' || !d.eventId || d.eventResolved)
            return fail('当前没有可处理的事件', 'No event is available now.');
        if (![-1, 0, 1].includes(choice))
            return fail('事件选项无效', 'Invalid event choice.');
        const e = extra(d), id = d.eventId;
        if (choice === -1) {
            d.eventResolved = true;
            delete d.saleUndo;
            log(d, `event:${id}:skip`);
            return ok();
        }
        if (id === 'EV01' && choice === 0) {
            if (d.gold < 24)
                return fail('需要24碎片', 'Requires 24 scrap.');
            d.gold -= 24;
            beginRewards(d, ['U'], 'existingPrep');
        }
        else if (id === 'EV02' && choice === 0) {
            if (d.hp < 16)
                return fail('需要至少16生命', 'Requires at least 16 HP.');
            d.hp -= 15;
            d.gold += 35;
        }
        else if (id === 'EV03') {
            const candidates = d.items.filter(i => i.tier === 1);
            if (choice === 1 || !candidates.length)
                d.gold += 20;
            else {
                const item = candidates.find(i => i.uid === e.eventTargetUid);
                if (!item)
                    return fail('请选择一件I级模块', 'Select a tier I module.');
                item.tier = 2;
            }
        }
        else if (id === 'EV04' && choice === 0) {
            if (d.route !== 0 || e.eventBudgetBonus || e.eventExtraElite)
                return fail('已有风险合同，请先选择普通路线', 'Choose the normal route before accepting event risk.');
            e.eventExtraElite = 1;
            e.eventRewardModule = true;
        }
        else if (id === 'EV05') {
            if (choice === 0) {
                const item = d.items.find(i => i.uid === e.eventTargetUid);
                if (!item)
                    return fail('请选择要拆解的模块', 'Select a module to dismantle.');
                d.gold += Math.floor(standardCost(item) * .75);
                d.items = d.items.filter(i => i.uid !== item.uid);
                repairLinks(d);
            }
            else {
                if (d.gold < 12)
                    return fail('需要12碎片', 'Requires 12 scrap.');
                if (d.hp >= maxHP(d))
                    return fail('生命已满', 'HP is already full.');
                d.gold -= 12;
                d.hp = Math.min(maxHP(d), d.hp + 20);
            }
        }
        else if (id === 'EV06') {
            if (choice === 1)
                d.gold += 12;
            else {
                const tag = String(e.eventTargetTag ?? ''), tags = active(d).filter(i => def(i).kind === 'weapon').flatMap(i => def(i).tags);
                if (!tag || !tags.includes(tag))
                    return fail('请选择已装备武器的一个标签', 'Choose a tag from an equipped weapon.');
                e.guaranteedSupportTag = tag;
                e.guaranteedSupportFromWave = d.wave + 1;
            }
        }
        else if (id === 'EV07') {
            if (choice === 0)
                d.hp = Math.min(maxHP(d), d.hp + 25);
            else
                e.temporaryShield = 15;
        }
        else if (id === 'EV08' && choice === 0) {
            if (d.route !== 0 || e.eventBudgetBonus || e.eventExtraElite)
                return fail('已有风险合同，请先选择普通路线', 'Choose the normal route before accepting event risk.');
            e.eventBudgetBonus = .15;
            e.eventRewardGold = 30;
        }
        d.eventResolved = true;
        delete d.saleUndo;
        delete e.eventTargetUid;
        delete e.eventTargetTag;
        log(d, `event:${id}:${choice}`);
        return ok();
    });
}

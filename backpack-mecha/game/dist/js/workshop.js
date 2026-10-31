import { moduleValue, damageScale, TIER_EFFECTS } from "./rarity.js?v=17e930db7a48";
/** Read-only explanations derived from the same connection and placement checks as play. */
import { MODULE_BY_ID, label } from "./content.js?v=17e930db7a48";
import { getCapacity, linkOptions, validateLoadout, activeSupports, inactiveSupports } from "./economy.js?v=17e930db7a48";
const format = (n) => Number(n.toFixed(2)).toString();
export function supportBenefit(item, lang) {
    const m = MODULE_BY_ID[item.id], v = moduleValue(item.id, item.tier), pct = format(v * 100), en = lang === 'en';
    if (item.id === 'S01')
        return en ? `Direct damage +${pct}%.` : `直接伤害 +${pct}%。`;
    if (item.id === 'S02')
        return en ? `Attack speed +${pct}%.` : `攻击速度 +${pct}%。`;
    if (item.id === 'S03')
        return en ? `One extra single shot; each shot deals ${pct}% damage. Status effects remain.` : `单弹额外发射 1 枚；每枚伤害变为 ${pct}%，保留状态施加。`;
    if (item.id === 'S04')
        return en ? `Two extra wall bounces; damage ×${pct}% per bounce. Repeat hits are at least 0.30s apart.` : `额外碰墙反弹 2 次，每次伤害乘 ${pct}%；同目标重复命中间隔至少 0.30 秒。`;
    if (item.id === 'S05')
        return en ? `Wet electric bonus: 25% → ${pct}%; arc chains gain one extra jump, at most 5 targets.` : `潮湿电伤加成 25% → ${pct}%；电链多跳 1 个目标，全链最多 5 个目标。`;
    if (item.id === 'S06')
        return en ? `Igniting oil: explosion base damage 18 → ${format(v)}, radius 80 → 100.` : `引燃油污时：爆炸基础伤害 18 → ${format(v)}，半径 80 → 100。`;
    if (item.id === 'S07')
        return en ? `Direct hits ignore ${format(v)} armor, down to zero.` : `直接伤害忽略 ${format(v)} 点护甲，剩余护甲最低为 0。`;
    if (item.id === 'S08')
        return en ? `Direct critical hits restore ${format(v)} shield, at most once per second and once per shotgun volley.` : `直接暴击回复 ${format(v)} 护盾，每秒最多 1 次，同轮霰弹最多 1 次。`;
    if (item.id === 'S09')
        return en ? `Explosions hitting a burning target add ${format(v)} damage; 1s cooldown per target.` : `直接爆炸命中燃烧目标时额外造成 ${format(v)} 伤害；每目标冷却 1 秒。`;
    if (item.id === 'S10')
        return en ? `One extra drone for this hive; all its drone damage ×${pct}%.` : `该机巢增加 1 架无人机；该巢全部无人机伤害乘 ${pct}%。`;
    if (item.id === 'S11') {
        const hit = format(TIER_EFFECTS.springDamage[item.tier - 1] * 100);
        return en ? `Melee range +${pct}%; this weapon's first attack within 2s after a dash deals +${hit}% damage.` : `近战范围 +${pct}%；冲刺后 2 秒内，该武器首次攻击伤害 +${hit}%。`;
    }
    if (item.id === 'S12') {
        const stagger = TIER_EFFECTS.cryoStagger[item.tier - 1];
        return en ? `Chill slows 2 percentage points more per stack, capped at 40%; freeze +${format(v)}s. Bosses gain ${stagger} extra stagger instead of freezing.` : `每层寒冷额外减速 2 个百分点，总减速上限 40%；冻结时长 +${format(v)} 秒。Boss 不冻结，改为额外 ${stagger} 失衡。`;
    }
    // Keep future support descriptions sourced from the catalog.
    return en ? m.effectEn : m.effect;
}
export function supportFeedback(run, uid, lang) {
    const item = run.items.find(i => i.uid === uid);
    if (!item || MODULE_BY_ID[item.id].kind !== 'support')
        return;
    const en = lang === 'en', benefit = supportBenefit(item, lang), options = linkOptions(run, uid), linked = activeSupports(run).some(s => s.uid === uid) ? options.find(o => o.weapon.uid === item.link) : undefined;
    let status;
    if (item.stored)
        status = 'reserve';
    else if (run.items.filter(i => !i.stored).reduce((n, i) => n + MODULE_BY_ID[i.id].power, 0) > getCapacity(run))
        status = 'power';
    else if (linked)
        status = 'active';
    else if (!options.length)
        status = 'no-weapon';
    else if (options.every(o => o.reason === 'incompatible'))
        status = 'incompatible';
    else if (options.filter(o => o.reason !== 'incompatible').every(o => o.reason === 'slots-full'))
        status = 'slots-full';
    else if (options.some(o => o.reason === 'ready'))
        status = 'disconnected';
    else
        status = 'not-adjacent';
    const words = {
        reserve: ['备件尚未生效', 'Reserve item is inactive', '选中后点击背包中的＋标记；装入并连接后才提供增益。', 'Select it, then tap a + on the board to equip and connect.'],
        active: ['连接已生效', 'Connection active', '这件支持已作用于连接的武器。', 'This support now affects its linked weapon.'],
        power: ['电力超限，暂不能出击', 'Power exceeded; cannot deploy', '移出其他模块或装入扩容电池，恢复电力后再检查连接。', 'Remove equipment or add a battery, then recheck the connection.'],
        'no-weapon': ['还没有可连接的武器', 'No equipped weapon', '先装入一件兼容武器，再把支持放在它的边缘。', 'Equip a compatible weapon, then place this support along its edge.'],
        incompatible: ['武器标签不匹配', 'Weapon tags do not match', '当前武器无法使用这件支持；可先移入备件，寻找兼容武器。', 'Current weapons cannot use this support. Keep it in reserve until you find a compatible weapon.'],
        'slots-full': ['兼容武器的连接位已满', 'Compatible support slots are full', '每把武器最多两件支持。移开一件已有支持，或连接另一把兼容武器。', 'Each weapon holds two supports. Move one away or use another compatible weapon.'],
        'not-adjacent': ['还未与兼容武器边缘相邻', 'No shared edge with a compatible weapon', '把支持移到武器的上、下、左或右侧；只碰角不会连接。', 'Move it above, below, left or right of the weapon. Corners do not connect.'],
        disconnected: ['位置正确，尚未选择连接', 'Ready to connect', '在下方选择相邻武器，或重新放置以自动连接。', 'Choose an adjacent weapon below, or place the support again to connect automatically.'],
    };
    const row = words[status];
    let detail = en ? row[3] : row[2];
    if (status === 'incompatible') {
        const tags = { '全部': 'All', '实弹': 'Ballistic', '单弹': 'Single shot', '散射': 'Spread', '水': 'Water', '电': 'Electric', '火': 'Fire', '持续': 'Continuous', '油': 'Oil', '爆炸': 'Explosive', '近战': 'Melee', '召唤': 'Drone', '冰': 'Ice' };
        const required = MODULE_BY_ID[item.id].tags.map(tag => en ? tags[tag] ?? tag : tag).join(' / '), equipped = options.map(o => label(MODULE_BY_ID[o.weapon.id], lang)).join(' / ');
        detail = en ? `Requires a ${required} weapon. Equipped: ${equipped}. This support grants no bonus until connected to a matching weapon.` : `需要「${required}」武器；当前装备为「${equipped}」。连接到匹配武器前，这件配件不提供增益。`;
    }
    if (status === 'active' && linked) {
        detail = `${label(MODULE_BY_ID[item.id], lang)} → ${label(MODULE_BY_ID[linked.weapon.id], lang)} · ${benefit}`;
        if (item.id === 'S01' && linked.weapon.id === 'W01') {
            const base = (MODULE_BY_ID.W01.damage ?? 0) * damageScale(linked.weapon.tier), after = base * (1 + moduleValue('S01', item.tier));
            detail += en ? ` Reference hit: ${format(base)} → ${format(after)} (this support only; before armor, crits and other bonuses).` :
                ` 基准单发伤害 ${format(base)} → ${format(after)}（只计本连接，不含护甲、暴击与其他加成）。`;
        }
    }
    return { status, title: en ? row[1] : row[0], detail, benefit, weapon: linked?.weapon };
}
export function connectionLesson(run, tutorialDone, selectedUid) {
    if (tutorialDone || run.wave !== 2 || !['prep', 'reward', 'expansion', 'protocol'].includes(run.phase))
        return 'hidden';
    const coil = run.items.find(i => i.id === 'S01');
    if (!coil)
        return 'hidden';
    if (supportFeedback(run, coil.uid, 'en')?.status === 'active' && validateLoadout(run).ok)
        return 'ready';
    return selectedUid === coil.uid ? 'place' : 'select';
}
export function workshopHints(run, lang) {
    const en = lang === 'en', equipped = run.items.filter(i => !i.stored), hints = [];
    const disconnected = equipped.find(i => MODULE_BY_ID[i.id].kind === 'support' && supportFeedback(run, i.uid, lang)?.status !== 'active');
    if (disconnected) {
        const f = supportFeedback(run, disconnected.uid, lang);
        hints.push(`${label(MODULE_BY_ID[disconnected.id], lang)}：${f.title}`);
    }
    const has = (id) => equipped.some(i => i.id === id);
    if (has('W03') && !has('W04'))
        hints.push(en ? 'Water applies Wet. An arc weapon can turn it into chain damage.' : '水压枪可以施加潮湿；找到电弧武器后，可尝试潮湿电链。');
    else if (has('W06') && !has('W05'))
        hints.push(en ? 'Oil needs fire to ignite. A flame weapon can complete the combination.' : '油污需要火焰引燃；可留意火焰武器，补上引爆方式。');
    return hints.slice(0, 2);
}
export function deploymentWarnings(run, lang) {
    return inactiveSupports(run).map(item => { const f = supportFeedback(run, item.uid, lang); return { uid: item.uid, name: label(MODULE_BY_ID[item.id], lang), reason: f.title, detail: f.detail }; });
}

import { MODULE_BY_ID } from "./content.js?v=46fa266b192c";
import { rarity, rarityName, moduleValue, moduleStat, damageScale, TIER_EFFECTS } from "./rarity.js?v=46fa266b192c";
import { supportBenefit } from "./workshop.js?v=46fa266b192c";
export function rarityBadge(tier, lang) { return `<span class="rarity-badge rarity-${tier}">${rarity(tier).roman} · ${rarityName(tier, lang)}</span>`; }
export function equipmentDescription(item, lang) {
    const m = MODULE_BY_ID[item.id], t = item.tier - 1, v = moduleValue(item.id, item.tier), en = lang === 'en', fmt = (n) => Number(n.toFixed(2));
    const choose = (zh, english) => en ? english : zh;
    if (m.kind === 'support')
        return supportBenefit({ ...item, uid: 'description', x: 0, y: 0, stored: true, rotation: 0 }, lang);
    if (m.kind === 'weapon') {
        const factor = damageScale(item.tier), d = fmt((m.damage ?? 0) * factor), range = m.range, interval = m.interval;
        const patterns = {
            W01: [`单发直线弹，伤害 ${d}。`, `Straight shot, ${d} damage.`],
            W02: [`5 枚弹丸，每枚 ${fmt(5 * factor)} 伤害；40° 扇形。`, `5 pellets × ${fmt(5 * factor)} damage, 40° fan.`],
            W03: [`伤害 ${d}，施加潮湿 3 秒。`, `${d} damage, applies Wet for 3s.`],
            W04: [`主目标 ${d} 伤害，再跳 2 个目标各 ${fmt(6 * factor)}；潮湿时多跳一次。`, `${d} primary damage, two jumps × ${fmt(6 * factor)}; Wet adds a jump.`],
            W05: [`每次 ${d} 伤害；90° 火焰锥，每两次命中叠加燃烧。`, `${d} damage per tick in a 90° cone; every two hits add Burn.`],
            W06: [`伤害 ${d}，半径 70；施加油污 4 秒。`, `${d} damage, radius 70; applies Oil for 4s.`],
            W07: [`伤害 ${d}；穿透 3 个目标，后续伤害为 75% / 56.25%。`, `${d} damage; pierces 3 targets, subsequent damage 75% / 56.25%.`],
            W08: [`伤害 ${d}，120° 扇形；击退 40，对首领造成 20 失衡。`, `${d} damage in a 120° arc; knockback 40, boss stagger 20.`],
            W09: [`每次 ${d} 伤害；周身攻击，最多命中 6 个目标。`, `${d} damage around the mech; hits up to 6 targets.`],
            W10: [`伤害 ${d}，爆炸半径 75；同一目标只结算一次。`, `${d} damage in radius 75; one hit per target.`],
            W11: [`2 架无人机，每架每次 ${fmt(4 * factor)} 伤害。`, `2 drones, ${fmt(4 * factor)} damage per drone attack.`],
            W13: [`高速单发，每枚 ${d} 伤害。`, `Rapid single shots, ${d} damage each.`],
            W14: [`光束 ${d} 电伤，穿透最多 5 个目标，不穿墙。`, `Beam deals ${d} electric damage to up to 5 targets; blocked by walls.`],
            W15: [`周身脉冲 ${d} 电伤，命中范围内所有目标。`, `Pulse deals ${d} electric damage to all nearby targets.`],
            W16: [`4 枚冰弹，每枚 ${fmt(4 * factor)} 伤害；50° 散射，每弹叠加寒冷。`, `4 ice pellets × ${fmt(4 * factor)} damage; 50° fan, Chill on every hit.`],
            W17: [`爆炸 ${d} 火伤，半径 105；施加燃烧并引燃油污。`, `${d} fire damage in radius 105; applies Burn and ignites Oil.`],
            W18: [`3 架突击无人机，每架 ${fmt(5 * factor)} 伤害。`, `3 assault drones, ${fmt(5 * factor)} damage per drone.`],
            W12: [`伤害 ${d}，每次命中附加一层寒冷。`, `${d} damage; each hit adds one Chill stack.`],
        };
        return `${patterns[item.id][en ? 1 : 0]} ${choose(`间隔 ${interval} 秒 · 范围 ${range}。`, `Interval ${interval}s · range ${range}.`)}`;
    }
    const descriptions = {
        U01: [`电力上限 +${v}，同名只可装备一件。`, `Power capacity +${v}; equip one of this module.`],
        U02: [`护盾上限 +${v}，脱战恢复额外 +${TIER_EFFECTS.shieldRegen[t]}/秒。`, `Shield +${v}, out-of-combat regeneration +${TIER_EFFECTS.shieldRegen[t]}/s.`],
        U03: [`战斗每 10 秒恢复 ${v} 生命，单场最多 ${TIER_EFFECTS.repairCap[t]}。`, `Heal ${v} HP every 10 combat seconds, up to ${TIER_EFFECTS.repairCap[t]} per wave.`],
        U04: [`拾取半径 +${v}；拾取让冲刺冷却减少 0.2 秒，每秒最多一次。`, `Pickup range +${v}; pickups reduce dash cooldown by 0.2s, at most once per second.`],
        U05: [`直接伤害暴击率 +${fmt(v * 100)} 个百分点，全局上限 70%。`, `Direct critical chance +${fmt(v * 100)} percentage points, global cap 70%.`],
        U06: [`护甲 +${v}，移速 -3%。`, `Armor +${v}, movement speed -3%.`],
        U07: [`移速 +${fmt(v * 100)}%，冲刺冷却减少 ${TIER_EFFECTS.dashReduction[t]} 秒，最低 3.5 秒。`, `Speed +${fmt(v * 100)}%; dash cooldown -${TIER_EFFECTS.dashReduction[t]}s, minimum 3.5s.`],
        U08: [`破盾时造成 ${v} 电伤，半径 150；随后 1 秒减伤 30%，冷却 8 秒。`, `Shield break deals ${v} electric damage in radius 150, then 30% damage reduction for 1s; 8s cooldown.`],
        U09: [`元素或油污爆炸击杀回复 ${v} 护盾，冷却 0.5 秒。`, `Elemental or oil-explosion kills restore ${v} shield; 0.5s cooldown.`],
        U10: [`每把武器每 ${v} 次主攻击追加一次免费攻击，不递归计数。`, `Each weapon adds a free attack every ${v} primary attacks; no recursive counting.`],
        U11: [`冲刺结束留下 ${TIER_EFFECTS.decoyHP[t]} 生命的诱饵，持续 ${v} 秒，冷却 10 秒；不强制转移首领仇恨。`, `Dashing leaves a ${TIER_EFFECTS.decoyHP[t]} HP decoy for ${v}s; 10s cooldown; cannot force boss targeting.`],
        U12: [`一局一次：致命伤害后保留 ${v} 生命，并无敌 1 秒；合成和重购不会重置使用次数。`, `Once per run: survive lethal damage at ${v} HP and gain 1s immunity. Combining or repurchasing does not reset usage.`],
    };
    return descriptions[item.id]?.[en ? 1 : 0] ?? moduleStat(item.id, item.tier, lang);
}

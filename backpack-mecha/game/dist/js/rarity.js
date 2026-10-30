import { MODULE_BY_ID } from "./content.js?v=46fa266b192c";
export const TIERS = [1, 2, 3, 4];
export const RARITIES = [
    { tier: 1, roman: 'I', name: '普通', en: 'Common', color: '#c1cccf', damage: 1, price: 1, weaponPrice: 1 },
    { tier: 2, roman: 'II', name: '精良', en: 'Uncommon', color: '#70b8ff', damage: 1.35, price: 1.75, weaponPrice: 1.5 },
    { tier: 3, roman: 'III', name: '史诗', en: 'Epic', color: '#c595ff', damage: 1.8, price: 3, weaponPrice: 2.4 },
    { tier: 4, roman: 'IV', name: '传说', en: 'Legendary', color: '#ff897d', damage: 2.4, price: 5, weaponPrice: 3.75 },
];
export const validTier = (v) => TIERS.includes(v);
export const rarity = (tier) => RARITIES[tier - 1] ?? RARITIES[0];
export const rarityName = (tier, lang) => rarity(tier)[lang === 'en' ? 'en' : 'name'];
export const offerTier = (offer) => offer.tier ?? 1;
export const equipmentPrice = (id, tier) => { const m = MODULE_BY_ID[id], r = rarity(tier); return Math.ceil(m.price * (m.kind === 'weapon' ? r.weaponPrice : r.price)); };
export const damageScale = (tier) => rarity(tier).damage;
// Explicit values: fractional bonuses, discrete counts and cooldowns need different scaling.
const legendary = { S01: .48, S02: .36, S03: .95, S04: .95, S05: .62, S06: 54, S07: 24, S08: 6, S09: 19, S10: 1.25, S11: .48, S12: .55,
    U01: 5, U02: 60, U03: 2.4, U04: 168, U05: .24, U06: 24, U07: .29, U08: 48, U09: 6, U10: 3, U11: 6, U12: 35 };
export const moduleValues = (id) => { const values = MODULE_BY_ID[id]?.values ?? []; return values.length ? [...values.slice(0, 3), legendary[id]] : []; };
export const moduleValue = (id, tier) => tier === 4 ? legendary[id] ?? 0 : tier ? MODULE_BY_ID[id]?.values?.[tier - 1] ?? 0 : 0;
export const TIER_EFFECTS = { dashReduction: [1, 1.3, 1.8, 2.4], shieldRegen: [1, 1.5, 2, 2.7], cryoStagger: [5, 7, 9, 12], springDamage: [.4, .55, .7, .95], decoyHP: [20, 27, 36, 48], repairCap: [8, 10, 12, 16] };
/** Per-slot odds, adapted to a 12-wave run. They are independent of module-family supply weights. */
export function shopTierChances(wave) {
    const n = Math.max(1, Math.min(12, Math.floor(wave) || 1));
    const blue = n >= 2 ? Math.min(.38, .12 + (n - 2) * .026) : 0;
    const purple = n >= 5 ? Math.min(.26, .06 + (n - 5) * (.20 / 7)) : 0;
    const red = n >= 9 ? Math.min(.10, .04 + (n - 9) * .02) : 0;
    return [1 - blue - purple - red, blue, purple, red];
}
export function rollShopTier(wave, random) {
    let at = Math.max(0, Math.min(1 - Number.EPSILON, random));
    const chances = shopTierChances(wave);
    for (const tier of TIERS) {
        at -= chances[tier - 1];
        if (at < 0)
            return tier;
    }
    return 4;
}
export function moduleStat(id, tier, lang) {
    const m = MODULE_BY_ID[id], v = moduleValue(id, tier), n = (x) => Number(x.toFixed(2)), en = lang === 'en';
    if (m.kind === 'weapon')
        return `${en ? 'Damage' : '伤害'} ${n((m.damage ?? 0) * damageScale(tier))}`;
    const labels = { S01: ['伤害', 'Damage'], S02: ['攻速', 'Attack speed'], S03: ['每弹伤害', 'Damage/shot'], S04: ['反弹伤害', 'Bounce damage'], S05: ['潮湿增伤', 'Wet bonus'], S06: ['爆炸伤害', 'Blast damage'], S07: ['穿甲', 'Armor ignore'], S08: ['暴击回盾', 'Crit shield'], S09: ['追加伤害', 'Bonus damage'], S10: ['无人机伤害', 'Drone damage'], S11: ['近战范围', 'Melee range'], S12: ['冻结延长', 'Freeze duration'], U01: ['电力', 'Power'], U02: ['护盾', 'Shield'], U03: ['每10秒修复', 'Heal/10s'], U04: ['拾取范围', 'Pickup range'], U05: ['暴击率', 'Crit chance'], U06: ['护甲', 'Armor'], U07: ['移速', 'Speed'], U08: ['脉冲伤害', 'Pulse damage'], U09: ['击杀回盾', 'Kill shield'], U10: ['追加攻击间隔', 'Bonus attack every'], U11: ['诱饵持续', 'Decoy duration'], U12: ['保命生命', 'Survival HP'] };
    const percent = ['S01', 'S02', 'S03', 'S04', 'S05', 'S10', 'S11', 'U05', 'U07'].includes(id), seconds = id === 'S12' || id === 'U11';
    return `${labels[id]?.[en ? 1 : 0] ?? ''} ${['S03', 'S04', 'S10', 'U10', 'U11'].includes(id) ? '' : '+'}${n(v * (percent ? 100 : 1))}${percent ? '%' : seconds ? 's' : id === 'U10' ? (en ? ' hits' : ' 次') : ''}`;
}

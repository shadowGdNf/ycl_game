import { BOSS_BY_ID, ENEMY_BY_ID, MODULE_BY_ID, label } from "./content.js?v=dd56a56e7e0a";
import { ENEMY_TACTICS, localized } from "./bestiary.js?v=dd56a56e7e0a";
import { skillName } from "./skills.js?v=dd56a56e7e0a";
export function damageSourceName(id, lang) {
    const content = MODULE_BY_ID[id] ?? ENEMY_BY_ID[id] ?? BOSS_BY_ID[id];
    if (content)
        return label(content, lang);
    if (id.startsWith('skill-'))
        return skillName(id.slice(6), lang);
    const names = { burn: ['燃烧', 'Burn'], oil: ['油污爆炸', 'Oil explosion'], electric: ['电击', 'Electricity'], melee: ['震荡', 'Impact'], drone: ['无人机', 'Drones'], projectile: ['弹丸', 'Projectile'] };
    return names[id]?.[lang === 'en' ? 1 : 0] ?? (lang === 'en' ? 'Other damage' : '其他伤害');
}
const BOSS_ADVICE = {
    B1A: ['侧向躲开冲锋，利用撞墙后的硬直输出。', 'Sidestep the charge and attack during its wall-impact recovery.'],
    B1B: ['持续横移抵消牵引，注意环形攻击的缺口。', 'Keep moving against the pull and use the gaps in ring attacks.'],
    B2A: ['横向留出退路，避开火地后再靠近输出。', 'Leave a sideways escape route; avoid fire patches before closing in.'],
    B2B: ['避免停在双子中间，从脉冲间隙通过。', 'Stay out of the space between the twins and move through pulse gaps.'],
    B3A: ['先避开两拍预警，再利用收招窗口输出。', 'Dodge both telegraphed beats, then punish the recovery window.'],
    B3B: ['侧向避开船首火力，留意第二拍与环形缺口。', 'Move sideways from the bow; watch the second beat and ring gaps.'],
};
const ATTACKS = { contact: ['接触伤害', 'Contact'], charge: ['冲锋', 'Charge'], projectile: ['弹丸', 'Projectile'], circle: ['圆形范围攻击', 'Circular attack'], ring: ['环形攻击', 'Ring attack'], cone: ['扇形攻击', 'Cone attack'], line: ['直线攻击', 'Line attack'], rect: ['矩形范围攻击', 'Lane attack'] };
export function mainThreat(stats, lang) {
    const top = Object.entries(stats.damageTakenBy).filter(([, n]) => Number.isFinite(n) && n > 0).sort((a, b) => b[1] - a[1])[0];
    if (!top)
        return;
    const [id, damage] = top, en = lang === 'en';
    const attack = Object.entries(stats.damageTakenByAttack ?? {}).filter(([key, n]) => key.startsWith(id + ':') && Number.isFinite(n) && n > 0).sort((a, b) => b[1] - a[1])[0]?.[0].slice(id.length + 1);
    return { name: damageSourceName(id, lang), damage, attack: attack ? ATTACKS[attack]?.[en ? 1 : 0] : undefined,
        advice: BOSS_ADVICE[id]?.[en ? 1 : 0] ?? (ENEMY_TACTICS[id] ? localized(ENEMY_TACTICS[id].counter, lang) : (en ? 'Keep an escape route clear and watch the warnings.' : '保持退路畅通，留意攻击预警。')) };
}

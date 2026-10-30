/** Shared by combat, loadout descriptions and the touch HUD. */
export const CHASSIS_SKILLS = {
    scavenger: { name: '磁力回收', en: 'Salvage pulse', icon: '◎', color: '#f4ca73', cooldown: 18, duration: 3,
        effect: '修复6生命，3秒内拾取半径至少320。冷却18秒。', effectEn: 'Repair 6 HP; pickup radius is at least 320 for 3s. Cooldown: 18s.' },
    bulwark: { name: '铁壁震波', en: 'Bastion pulse', icon: '⬡', color: '#80c9ff', cooldown: 22, duration: 4,
        effect: '对180范围造成36震荡伤害，4秒内受到伤害减少50%。冷却22秒。', effectEn: 'Deal 36 shock damage within 180 range; take 50% less damage for 4s. Cooldown: 22s.' },
    kestrel: { name: '疾风掠影', en: 'Slipstream', icon: '»', color: '#b3dfef', cooldown: 16, duration: 3,
        effect: '立即重置冲刺，获得0.45秒无敌，3秒内移速提高35%。冷却16秒。', effectEn: 'Reset dash, gain 0.45s invulnerability and +35% movement speed for 3s. Cooldown: 16s.' },
    hive: { name: '援护蜂群', en: 'Escort swarm', icon: '✥', color: '#79e4bf', cooldown: 24, duration: 6,
        effect: '召唤3架援护机持续6秒，每0.6秒各造成6基础召唤伤害，射程450；无需装备无人机巢。冷却24秒。', effectEn: 'Summon 3 escorts for 6s. Each deals 6 base drone damage every 0.6s within 450 range; no Drone hive needed. Cooldown: 24s.' },
};
export function chassisSkill(id) { return CHASSIS_SKILLS[id] ?? CHASSIS_SKILLS.scavenger; }
export function skillName(id, lang) { const skill = chassisSkill(id); return lang === 'zh' ? skill.name : skill.en; }
export function skillDescription(id, lang) { const skill = chassisSkill(id); return lang === 'zh' ? skill.effect : skill.effectEn; }

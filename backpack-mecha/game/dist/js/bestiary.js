export const ENEMY_TACTICS = {
    E01: { role: ['近战追击', 'Pursuit'], skill: ['持续追击并绕过障碍，接触造成伤害。', 'Chases around cover and deals contact damage.'], counter: ['保持移动，优先清理聚集的小群。', 'Keep moving and clear clusters.'] },
    E02: { role: ['高速追击', 'Runner'], skill: ['高速直线接近，发现通路后立即追向机体。', 'Fast pursuit with direct routes when clear.'], counter: ['利用障碍与冲刺拉开距离。', 'Use cover and dash to create space.'] },
    E03: { role: ['重装近战', 'Armored'], skill: ['厚甲缓慢压迫，受到实弹伤害有护甲减免。', 'Slow armored pressure with ballistic protection.'], counter: ['绕侧输出，避免被围堵。', 'Flank it and avoid getting surrounded.'] },
    E04: { role: ['瞄准射手', 'Sentry'], skill: ['0.7 秒瞄准后射击；远离时追击，靠近时后撤。', 'Aimed shot after 0.7s. Closes distance and retreats when crowded.'], counter: ['横向移动躲开射线。', 'Strafe away from the aim line.'] },
    E05: { role: ['自爆冲锋', 'Demolition'], skill: ['近身后 0.8 秒预警自爆，爆炸半径 70。', 'Detonates after a 0.8s warning within radius 70.'], counter: ['预警开始后立即离开圆圈。', 'Leave the circle when the warning starts.'] },
    E06: { role: ['维修支援', 'Support'], skill: ['为周围友军持续维修；落单时释放防卫脉冲。', 'Repairs nearby allies; fires defensive pulses when alone.'], counter: ['优先击破，打断维修链。', 'Prioritize the healer to stop repairs.'] },
    E07: { role: ['盾卫齐射', 'Shield battery'], skill: ['正面护盾，0.7 秒预警后发射三连扇形弹。', 'Frontal shield and a three-shot fan after 0.7s.'], counter: ['绕到侧后，避开正面扇形。', 'Flank its shield and avoid the frontal fan.'] },
    E08: { role: ['钻地突袭', 'Burrower'], skill: ['锁定主角落点，1 秒预警后钻地重击。', 'Marks your position and strikes after 1s.'], counter: ['落点锁定后移动，不要停在圈内。', 'Move after the target circle appears.'] },
    E09: { role: ['牵制射手', 'Tether'], skill: ['0.7 秒预警后发射双减速弹，命中降低移速。', 'Two slowing bolts after a 0.7s warning.'], counter: ['横移躲弹，避免被追击怪夹住。', 'Dodge sideways and avoid being pinned by chasers.'] },
    E10: { role: ['迫击 / 分裂', 'Mortar / split'], skill: ['1.1 秒落点预警炮击，死亡后分裂成两只拾荒螨。', 'Mortar strike after 1.1s; splits into two mites on death.'], counter: ['躲开红色落点，准备清理分裂单位。', 'Leave the marked landing and clear the offspring.'] },
    E11: { role: ['磁暴弹幕', 'Pulse fan'], skill: ['朝主角发射五枚扇形弹，0.9 秒预警，可被障碍阻挡。', 'Five-shot fan aimed at you after 0.9s; cover blocks shots.'], counter: ['提前横移，利用弹幕间隙和掩体。', 'Strafe early, use gaps and cover.'] },
    E13: { role: ['侧翼突袭', 'Flanker'], skill: ['绕向侧翼，0.6 秒直线预警后短距突进；撞墙会硬直。', 'Flanks, then lunges after a 0.6s lane warning; wall impacts stagger it.'], counter: ['侧向走出窄预警，借障碍阻断突进。', 'Sidestep the narrow lane and use cover to stop its lunge.'] },
    E14: { role: ['远距狙击', 'Sniper'], skill: ['远距离蓄力 1.25 秒后射出高速单发；近身时后撤。', 'Charges for 1.25s, fires one fast shot, and retreats when approached.'], counter: ['瞄准线锁定后横移，利用掩体挡弹。', 'Strafe after the aim locks; cover blocks the shot.'] },
    E15: { role: ['布雷封路', 'Minelayer'], skill: ['1.2 秒预警后在落点两侧布置双雷区，持续 2.2 秒。', 'Places two minefields after 1.2s, lasting 2.2s.'], counter: ['保留中间通道，绕开两侧持续危险区。', 'Use the central lane and avoid the persistent side hazards.'] },
    E16: { role: ['环形弹幕', 'Ring sentinel'], skill: ['蓄力 1 秒后向四周发射十枚慢速弹，攻击后短暂停顿。', 'Charges for 1s, releases ten slow radial bolts, then briefly recovers.'], counter: ['从弹幕间隙穿过，避免贴身吃弹。', 'Move through the gaps and avoid point-blank bursts.'] },
    E12: { role: ['重型冲锋', 'Heavy charge'], skill: ['1 秒矩形预警后直线冲锋，撞墙会短暂失衡。', 'Charges after a 1s lane warning; walls cause a stagger.'], counter: ['侧向躲开，引导它撞上障碍。', 'Step sideways and bait it into cover.'] },
};
export const ELITE_AFFIXES = [
    { name: ['疾速', 'Haste'], detail: ['移动速度额外 +15%。', 'An additional 15% movement speed.'] },
    { name: ['铁甲', 'Plating'], detail: ['护甲额外 +10。', 'An additional 10 armor.'] },
    { name: ['脉冲', 'Aftershock'], detail: ['死亡后 0.9 秒预警，半径 75 的脉冲爆炸。', 'Death triggers a radius-75 blast after a 0.9s warning.'] },
];
export const localized = (pair, lang) => pair[lang === 'en' ? 1 : 0];

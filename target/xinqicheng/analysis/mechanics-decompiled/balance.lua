local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function fts(v)
	return v / FPS
end

local function sub_one(value)
	if type(value) == "table" then
		local result = {}

		for i, v in ipairs(value) do
			result[i] = v - 1
		end

		return result
	elseif type(value) == "number" then
		return value - 1
	else
		return -999
	end
end

local function slow_calc(value)
	if type(value) == "table" then
		local result = {}

		for i, v in ipairs(value) do
			result[i] = 1 - v
		end

		return result
	elseif type(value) == "number" then
		return 1 - value
	else
		return -999
	end
end

local b = {
	heroes = {}
}
b.heroes.common = {
	xp_level_steps = {
		1,
		nil,
		2,
		nil,
		nil,
		nil,
		3,
		[9.0] = 3
	},
	xp_level_steps_ulti = {
		1,
		[10.0] = 3,
		[5.0] = 2
	},
	melee_attack_range = 72
}
b.heroes.hero_gerald = {
	stats = {}
}
b.heroes.hero_gerald.stats.hp = 6.5
b.heroes.hero_gerald.stats.armor = 5
b.heroes.hero_gerald.stats.damage = 4
b.heroes.hero_gerald.stats.cooldown = 3.5
b.heroes.hero_gerald.dead_lifetime = 30
b.heroes.hero_gerald.speed = 55
b.heroes.hero_gerald.regen_cooldown = 1
b.heroes.hero_gerald.armor = {
	0.05,
	0.1,
	0.15,
	0.2,
	0.25,
	0.3,
	0.35,
	0.4,
	0.45,
	0.5
}
b.heroes.hero_gerald.hp_max = {
	220,
	240,
	260,
	280,
	300,
	320,
	340,
	360,
	380,
	400
}
b.heroes.hero_gerald.regen_health = {
	18,
	19,
	21,
	22,
	24,
	26,
	27,
	29,
	30,
	32
}
b.heroes.hero_gerald.basic_melee = {
	cooldown = 2,
	xp_gain_factor = 1,
	damage_min = {
		10,
		11,
		13,
		14,
		16,
		18,
		19,
		21,
		22,
		24
	},
	damage_max = {
		14,
		17,
		19,
		22,
		24,
		26,
		29,
		31,
		34,
		36
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_gerald.skill_a = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	duration = 4,
	radius = 60,
	armor_inc = 0.4,
	min_targets = 1
}
b.heroes.hero_gerald.skill_b = {
	cooldown = 24,
	xp_gain = {
		24,
		48,
		72
	},
	duration = 6,
	armor_inc = 0.3,
	spiked_armor = 0.3
}
b.heroes.hero_gerald.skill_c = {
	cooldown = 50,
	xp_gain = {
		50,
		100,
		150
	},
	hp_ptg = 0.4,
	nodes_teleport = 30
}
b.heroes.hero_gerald.ultimate = {
	cooldown = 25,
	xp_gain = {
		25
	},
	damage_min = 200,
	damage_max = 200,
	s_damage = 200,
	damage_radius = 50,
	damage_type = DAMAGE_TRUE,
	damage_ptg_to_others = 0.75,
	initial_stun_duration = 0.5,
	initial_stun_radius = 60,
	hit_stun_duration = 1
}
b.heroes.hero_gerald.talent_1 = {
	block_chance = 0.35
}
b.heroes.hero_gerald.talent_2 = {
	regen_ptg = 0.03,
	cooldown = fts(30)
}
b.heroes.hero_gerald.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_gerald.upgrades.upg_sa1.duration = 6
b.heroes.hero_gerald.upgrades.upg_sa2 = {
	duration = 10
}
b.heroes.hero_gerald.upgrades.upg_sb1 = {
	spiked_armor = 0.6
}
b.heroes.hero_gerald.upgrades.upg_sb2 = {
	armor_inc = 0.4,
	cooldown = 20
}
b.heroes.hero_gerald.upgrades.upg_sc1 = {
	cooldown = 50,
	hp_ptg = 0.7
}
b.heroes.hero_gerald.upgrades.upg_sc2 = {
	cooldown = 40,
	hp_ptg = 1
}
b.heroes.hero_gerald.upgrades.upg_a = {
	xp_inc_factor = 1.3
}
b.heroes.hero_gerald.upgrades.upg_a.s_xp_inc_factor = sub_one(b.heroes.hero_gerald.upgrades.upg_a.xp_inc_factor)
b.heroes.hero_gerald.upgrades.upg_b = {
	dmg_factor = 1.1
}
b.heroes.hero_gerald.upgrades.upg_b.s_dmg_factor = sub_one(b.heroes.hero_gerald.upgrades.upg_b.dmg_factor)
b.heroes.hero_gerald.upgrades.upg_c = {
	hp_ptg = 0.1
}
b.heroes.hero_gerald.upgrades.upg_d = {
	dead_lifetime = 20
}
b.heroes.hero_gerald.upgrades.upg_e = {
	armor_inc = 0.1
}
b.heroes.hero_zefira = {
	stats = {}
}
b.heroes.hero_zefira.stats.hp = 1.5
b.heroes.hero_zefira.stats.armor = 2
b.heroes.hero_zefira.stats.damage = 2.5
b.heroes.hero_zefira.stats.cooldown = 7.5
b.heroes.hero_zefira.dead_lifetime = 30
b.heroes.hero_zefira.speed = 70
b.heroes.hero_zefira.regen_cooldown = 1
b.heroes.hero_zefira.armor = {
	0.02,
	0.04,
	0.06,
	0.08,
	0.1,
	0.12,
	0.14,
	0.16,
	0.18,
	0.2
}
b.heroes.hero_zefira.hp_max = {
	150,
	160,
	170,
	180,
	190,
	200,
	210,
	220,
	230,
	240
}
b.heroes.hero_zefira.regen_health = {
	12,
	13,
	14,
	15,
	16,
	16,
	17,
	18,
	19,
	20
}
b.heroes.hero_zefira.basic_melee = {
	cooldown = 1,
	xp_gain_factor = 0.8,
	damage_min = {
		4,
		5,
		6,
		6,
		7,
		8,
		9,
		9,
		10,
		11
	},
	damage_max = {
		12,
		14,
		17,
		19,
		21,
		23,
		26,
		28,
		30,
		32
	},
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_zefira.basic_ranged = {
	cooldown = 1,
	xp_gain_factor = 0.8,
	max_range = 150,
	min_range = 70,
	damage_min = {
		4,
		5,
		6,
		6,
		7,
		8,
		9,
		9,
		10,
		11
	},
	damage_max = {
		12,
		14,
		17,
		19,
		21,
		23,
		26,
		28,
		30,
		32
	},
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_zefira.skill_a = {
	cooldown = 12,
	xp_gain = {
		12,
		24,
		36
	},
	damage_min = 20,
	damage_max = 40,
	damage_radius = 50,
	damage_type = DAMAGE_MAGICAL,
	min_targets = 1,
	stun_duration = 1
}
b.heroes.hero_zefira.skill_b = {
	cooldown = 18,
	xp_gain = {
		18,
		36,
		54
	},
	min_targets = 1,
	detection_radius = 80,
	radius = 45,
	damage_every = 0.25,
	damage_min = 2,
	damage_max = 2,
	s_damage_total_lvl1 = 32,
	s_damage_total_lvl2 = 48,
	damage_type = DAMAGE_MAGICAL,
	duration = 4,
	armor_inc = 0.3,
	magic_armor_inc = 0.3,
	s_resistance_inc = 0.3,
	slow_factor = 0.3
}
b.heroes.hero_zefira.skill_c = {
	cooldown = 2,
	xp_gain = {
		0,
		0,
		0
	},
	min_dist = 160,
	duration = 4,
	damage_factor = 1.3
}
b.heroes.hero_zefira.skill_c.s_damage_factor = sub_one(b.heroes.hero_zefira.skill_c.damage_factor)
b.heroes.hero_zefira.ultimate = {
	cooldown = 34,
	xp_gain = {
		34
	},
	spears_count = 21,
	min_targets = 3,
	max_range = 150,
	min_range = 50,
	damage_min = 20,
	damage_max = 20,
	s_total_damage = 210,
	damage_radius = 35,
	damage_type = DAMAGE_MAGICAL,
	duration = 0.8
}
b.heroes.hero_zefira.talent_1 = {
	radius = 50,
	armor_factor = 0.3,
	magic_armor_factor = 0.3,
	s_resistance_red = 0.3,
	debuff_duration = 1
}
b.heroes.hero_zefira.talent_2 = {
	crit_chance = 0.2
}
b.heroes.hero_zefira.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_zefira.upgrades.upg_sa1.min_damage = 50
b.heroes.hero_zefira.upgrades.upg_sa1.max_damage = 70
b.heroes.hero_zefira.upgrades.upg_sa2 = {
	min_damage = 80,
	max_damage = 100
}
b.heroes.hero_zefira.upgrades.upg_sb1 = {
	slow_factor = 0.75,
	s_slow_factor = 0.25
}
b.heroes.hero_zefira.upgrades.upg_sb2 = {
	duration = 6
}
b.heroes.hero_zefira.upgrades.upg_sc1 = {
	dmg_factor = 1.4
}
b.heroes.hero_zefira.upgrades.upg_sc1.s_dmg_factor = sub_one(b.heroes.hero_zefira.upgrades.upg_sc1.dmg_factor)
b.heroes.hero_zefira.upgrades.upg_sc1.duration = 6
b.heroes.hero_zefira.upgrades.upg_sc2 = {
	dmg_factor = 1.5
}
b.heroes.hero_zefira.upgrades.upg_sc2.s_dmg_factor = sub_one(b.heroes.hero_zefira.upgrades.upg_sc2.dmg_factor)
b.heroes.hero_zefira.upgrades.upg_sc2.duration = 8
b.heroes.hero_zefira.upgrades.upg_a = {
	dead_lifetime = 20
}
b.heroes.hero_zefira.upgrades.upg_b = {
	skill_red_factor = 0.1,
	ult_red_factor = 0.05
}
b.heroes.hero_zefira.upgrades.upg_c = {
	regen_factor = 1.2
}
b.heroes.hero_zefira.upgrades.upg_c.s_regen_factor = sub_one(b.heroes.hero_zefira.upgrades.upg_c.regen_factor)
b.heroes.hero_zefira.upgrades.upg_d = {
	hp_ptg = 0.2
}
b.heroes.hero_zefira.upgrades.upg_e = {
	dmg_factor = 1.05
}
b.heroes.hero_zefira.upgrades.upg_e.s_dmg_factor = sub_one(b.heroes.hero_zefira.upgrades.upg_e.dmg_factor)
b.heroes.hero_bolin = {
	stats = {}
}
b.heroes.hero_bolin.stats.hp = 2
b.heroes.hero_bolin.stats.armor = 1.5
b.heroes.hero_bolin.stats.damage = 7.5
b.heroes.hero_bolin.stats.cooldown = 1
b.heroes.hero_bolin.dead_lifetime = 30
b.heroes.hero_bolin.speed = 60
b.heroes.hero_bolin.regen_cooldown = 1
b.heroes.hero_bolin.armor = {
	0.05,
	0.06,
	0.07,
	0.08,
	0.09,
	0.1,
	0.11,
	0.12,
	0.13,
	0.15
}
b.heroes.hero_bolin.hp_max = {
	170,
	180,
	190,
	200,
	210,
	220,
	230,
	240,
	250,
	260
}
b.heroes.hero_bolin.regen_health = {
	14,
	14,
	15,
	16,
	17,
	18,
	18,
	19,
	20,
	21
}
b.heroes.hero_bolin.melee_attack_range = 40
b.heroes.hero_bolin.basic_melee = {
	cooldown = 1,
	xp_gain_factor = 1,
	damage_min = {
		8,
		9,
		10,
		10,
		11,
		12,
		13,
		14,
		14,
		15
	},
	damage_max = {
		12,
		13,
		14,
		16,
		17,
		18,
		19,
		20,
		22,
		23
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_bolin.basic_ranged = {
	cooldown = 2.75,
	xp_gain_factor = 0.8,
	max_range = 200,
	min_range = 70,
	damage_min = {
		20,
		22,
		24,
		26,
		28,
		30,
		32,
		34,
		36,
		38
	},
	damage_max = {
		30,
		33,
		36,
		39,
		42,
		45,
		48,
		52,
		54,
		57
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_bolin.death_explosion = {
	damage_min = 20,
	damage_max = 30,
	damage_radius = 70,
	damage_type = DAMAGE_EXPLOSION
}
b.heroes.hero_bolin.skill_a = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	min_range = 200,
	max_range = 300,
	min_targets = 3,
	mortar_gap = 10,
	damage_min = 10,
	damage_max = 15,
	damage_radius = 50,
	damage_type = DAMAGE_EXPLOSION,
	aura = {}
}
b.heroes.hero_bolin.skill_a.aura.slow_factor = 0.6
b.heroes.hero_bolin.skill_a.aura.radius = 60
b.heroes.hero_bolin.skill_a.aura.duration = 4
b.heroes.hero_bolin.skill_a.aura.slow_duration = 0.5
b.heroes.hero_bolin.skill_b = {
	cooldown = 6,
	xp_gain = {
		6,
		6,
		6
	},
	max_mines = 4,
	damage_min = 12,
	damage_max = 18,
	min_range = 40,
	max_range = 120,
	damage_type = DAMAGE_EXPLOSION,
	trigger_radius = 30,
	dmg_radius = 45
}
b.heroes.hero_bolin.skill_c = {
	hp_percentage = 0.01,
	boss_hp_percentage = 0.002,
	damage_cap = {
		50,
		50,
		50
	}
}
b.heroes.hero_bolin.ultimate = {
	cooldown = 35,
	xp_gain = {
		35
	},
	min_targets = 3,
	min_hp = 500,
	range = 200,
	shot_count = 8
}
b.heroes.hero_bolin.talent_1 = {
	armor_penetration = 0.25
}
b.heroes.hero_bolin.talent_2 = {
	shot_count = 5,
	explosion = {}
}
b.heroes.hero_bolin.talent_2.explosion.damage_min = 24
b.heroes.hero_bolin.talent_2.explosion.damage_max = 36
b.heroes.hero_bolin.talent_2.explosion.damage_type = DAMAGE_EXPLOSION
b.heroes.hero_bolin.talent_2.explosion.damage_radius = 50
b.heroes.hero_bolin.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_bolin.upgrades.upg_sa1.min_damage = 15
b.heroes.hero_bolin.upgrades.upg_sa1.max_damage = 20
b.heroes.hero_bolin.upgrades.upg_sa2 = {
	min_damage = 20,
	max_damage = 25
}
b.heroes.hero_bolin.upgrades.upg_sb1 = {
	min_damage = 17,
	max_damage = 28,
	max_mines = 6
}
b.heroes.hero_bolin.upgrades.upg_sb2 = {
	min_damage = 24,
	max_damage = 36,
	max_mines = 8
}
b.heroes.hero_bolin.upgrades.upg_sc1 = {
	hp_percentage = 0.02,
	boss_hp_percentage = 0.004
}
b.heroes.hero_bolin.upgrades.upg_sc2 = {
	hp_percentage = 0.03,
	boss_hp_percentage = 0.006
}
b.heroes.hero_bolin.upgrades.upg_a = {
	attack_cooldown = 2.5,
	s_attack_cooldown = 0.1
}
b.heroes.hero_bolin.upgrades.upg_b = {
	range_factor = 1.15
}
b.heroes.hero_bolin.upgrades.upg_b.s_range_factor = sub_one(b.heroes.hero_bolin.upgrades.upg_b.range_factor)
b.heroes.hero_bolin.upgrades.upg_c = {
	armor_inc = 0.1
}
b.heroes.hero_bolin.upgrades.upg_d = {
	dmg_factor = 1.05
}
b.heroes.hero_bolin.upgrades.upg_d.s_dmg_factor = sub_one(b.heroes.hero_bolin.upgrades.upg_d.dmg_factor)
b.heroes.hero_bolin.upgrades.upg_e = {
	skill_red_factor = 0.1,
	ult_red_factor = 0.05
}
b.heroes.hero_malik = {
	stats = {}
}
b.heroes.hero_malik.stats.hp = 9
b.heroes.hero_malik.stats.armor = 0
b.heroes.hero_malik.stats.damage = 3
b.heroes.hero_malik.stats.cooldown = 5.5
b.heroes.hero_malik.dead_lifetime = 30
b.heroes.hero_malik.speed = 60
b.heroes.hero_malik.regen_cooldown = 1
b.heroes.hero_malik.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
b.heroes.hero_malik.hp_max = {
	200,
	230,
	260,
	290,
	320,
	350,
	380,
	410,
	440,
	470
}
b.heroes.hero_malik.regen_health = {
	16,
	18,
	21,
	23,
	26,
	28,
	30,
	33,
	35,
	38
}
b.heroes.hero_malik.basic_melee = {
	cooldown = 1.5,
	xp_gain_factor = 0.9,
	damage_min = {
		10,
		11,
		12,
		13,
		14,
		16,
		17,
		18,
		19,
		20
	},
	damage_max = {
		14,
		16,
		18,
		20,
		22,
		23,
		25,
		27,
		29,
		31
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_malik.skill_a = {
	cooldown = 18,
	xp_gain = {
		18,
		36,
		54
	},
	duration = 6,
	hp_increase_ptg = 0.3,
	hp_base = 50
}
b.heroes.hero_malik.skill_b = {
	cooldown = 20,
	xp_gain = {
		20,
		40,
		60
	},
	damage_min = 48,
	damage_max = 72,
	damage_radius = 50,
	damage_type = DAMAGE_PHYSICAL,
	min_targets = 1,
	stun_duration = 2
}
b.heroes.hero_malik.skill_c = {
	cooldown = 40,
	xp_gain = {
		40,
		80,
		120
	},
	hp_threshold = 1500,
	current_hp_threshold = 80
}
b.heroes.hero_malik.ultimate = {
	cooldown = 28,
	xp_gain = {
		28
	},
	damage_min = 16,
	damage_max = 24,
	damage_radius = 80,
	damage_type = DAMAGE_PHYSICAL,
	duration = 5,
	min_targets = 3,
	self_speed_factor = 1.17,
	cycle_time = 0.5,
	s_total_min_damage = 160,
	s_total_max_damage = 240,
	slow_factor = 0.6,
	slow_duration = 0.5
}
b.heroes.hero_malik.talent_1 = {
	damage_radius = 70
}
b.heroes.hero_malik.talent_2 = {
	dmg_factor = 1.25
}
b.heroes.hero_malik.talent_2.s_dmg_factor = sub_one(b.heroes.hero_malik.talent_2.dmg_factor)
b.heroes.hero_malik.talent_2.detection_radius = 150
b.heroes.hero_malik.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_malik.upgrades.upg_sa1.hp_increase_ptg = 0.4
b.heroes.hero_malik.upgrades.upg_sa2 = {
	hp_increase_ptg = 0.5
}
b.heroes.hero_malik.upgrades.upg_sb1 = {
	stun_duration = 4
}
b.heroes.hero_malik.upgrades.upg_sb2 = {
	damage_radius = 120,
	s_damage_radius = 50
}
b.heroes.hero_malik.upgrades.upg_sc1 = {
	cooldown = 34
}
b.heroes.hero_malik.upgrades.upg_sc2 = {
	cooldown = 28
}
b.heroes.hero_malik.upgrades.upg_a = {
	regen_factor = 1.15
}
b.heroes.hero_malik.upgrades.upg_a.s_regen_factor = sub_one(b.heroes.hero_malik.upgrades.upg_a.regen_factor)
b.heroes.hero_malik.upgrades.upg_b = {
	movement_factor = 1.2
}
b.heroes.hero_malik.upgrades.upg_b.s_movement_factor = sub_one(b.heroes.hero_malik.upgrades.upg_b.movement_factor)
b.heroes.hero_malik.upgrades.upg_c = {
	dmg_factor = 1.15
}
b.heroes.hero_malik.upgrades.upg_c.s_dmg_factor = sub_one(b.heroes.hero_malik.upgrades.upg_c.dmg_factor)
b.heroes.hero_malik.upgrades.upg_c.hp_ptg_threshold = 0.75
b.heroes.hero_malik.upgrades.upg_d = {
	hp_ptg = 0.1
}
b.heroes.hero_malik.upgrades.upg_e = {
	chance = 0.2,
	hp_ptg = 1
}
b.heroes.hero_ashbite = {
	stats = {}
}
b.heroes.hero_ashbite.stats.hp = 9.5
b.heroes.hero_ashbite.stats.armor = 2.5
b.heroes.hero_ashbite.stats.damage = 9.5
b.heroes.hero_ashbite.stats.cooldown = 3.5
b.heroes.hero_ashbite.dead_lifetime = 30
b.heroes.hero_ashbite.speed = 150
b.heroes.hero_ashbite.regen_cooldown = 1
b.heroes.hero_ashbite.armor = {
	0.05,
	0.07,
	0.09,
	0.11,
	0.13,
	0.15,
	0.17,
	0.19,
	0.21,
	0.23
}
b.heroes.hero_ashbite.hp_max = {
	230,
	260,
	290,
	320,
	350,
	380,
	410,
	440,
	470,
	500
}
b.heroes.hero_ashbite.regen_health = {
	18,
	21,
	23,
	26,
	28,
	30,
	33,
	35,
	38,
	40
}
b.heroes.hero_ashbite.basic_attack = {
	min_range = 50,
	max_range = 220,
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 2,
	xp_gain_factor = 0.6,
	damage_min = {
		19,
		22,
		26,
		29,
		32,
		35,
		38,
		42,
		45,
		48
	},
	damage_max = {
		29,
		34,
		38,
		43,
		48,
		53,
		58,
		62,
		67,
		72
	},
	damage_radius = 40
}
b.heroes.hero_ashbite.skill_a = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	min_targets = 3,
	min_range = 50,
	max_range = 150,
	aura = {}
}
b.heroes.hero_ashbite.skill_a.aura.duration = 2
b.heroes.hero_ashbite.skill_a.aura.damage_min = 4
b.heroes.hero_ashbite.skill_a.aura.damage_max = 6
b.heroes.hero_ashbite.skill_a.aura.s_damage_min = 32
b.heroes.hero_ashbite.skill_a.aura.s_damage_max = 48
b.heroes.hero_ashbite.skill_a.aura.damage_type = DAMAGE_TRUE
b.heroes.hero_ashbite.skill_a.aura.damage_every = 0.25
b.heroes.hero_ashbite.skill_a.aura.damage_radius = 50
b.heroes.hero_ashbite.skill_b = {
	cooldown = 20,
	xp_gain = {
		20,
		40,
		60
	},
	min_range = 50,
	max_range = 200,
	damage_type = DAMAGE_PHYSICAL,
	damage_min = 32,
	damage_max = 32,
	damage_radius = 45,
	stun_duration = 2,
	embers_duration = 4,
	embers_radius = 45,
	embers_cycle_time = 0.5,
	burn = {}
}
b.heroes.hero_ashbite.skill_b.burn.duration = 0.5
b.heroes.hero_ashbite.skill_b.burn.damage = 4
b.heroes.hero_ashbite.skill_b.burn.damage_every = 0.25
b.heroes.hero_ashbite.skill_b.burn.damage_type = DAMAGE_TRUE
b.heroes.hero_ashbite.skill_b.burn.s_damage = 64
b.heroes.hero_ashbite.skill_c = {
	cooldown = 30,
	attack_cooldown = 2,
	melee_xp_gain_factor = 1,
	range = 120,
	xp_gain = {
		30,
		60,
		90
	},
	target_min_hp = 100,
	target_max_hp = 1000,
	duration = 8,
	damage_type = DAMAGE_PHYSICAL,
	damage_min = 80,
	damage_max = 120,
	heal_ptg = 0.2
}
b.heroes.hero_ashbite.ultimate = {
	cooldown = 35,
	xp_gain = {
		35
	},
	min_targets = 3,
	min_range = 100,
	max_range = 300,
	damage_min = 64,
	damage_max = 96,
	damage_type = DAMAGE_TRUE,
	damage_radius = 70
}
b.heroes.hero_ashbite.talent_1 = {
	burn = {}
}
b.heroes.hero_ashbite.talent_1.burn.duration = 4
b.heroes.hero_ashbite.talent_1.burn.damage = 2
b.heroes.hero_ashbite.talent_1.burn.damage_every = 0.25
b.heroes.hero_ashbite.talent_1.burn.damage_type = DAMAGE_TRUE
b.heroes.hero_ashbite.talent_1.burn.s_damage = 32
b.heroes.hero_ashbite.talent_2 = {
	armor_red = 0.01
}
b.heroes.hero_ashbite.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_ashbite.upgrades.upg_sa1.damage_min = 6
b.heroes.hero_ashbite.upgrades.upg_sa1.damage_max = 9
b.heroes.hero_ashbite.upgrades.upg_sa1.s_damage_min = 48
b.heroes.hero_ashbite.upgrades.upg_sa1.s_damage_max = 72
b.heroes.hero_ashbite.upgrades.upg_sa2 = {
	damage_min = 9,
	damage_max = 12,
	s_damage_min = 64,
	s_damage_max = 96
}
b.heroes.hero_ashbite.upgrades.upg_sb1 = {
	embers_duration = 6,
	stun_duration = 3,
	s_damage = 96
}
b.heroes.hero_ashbite.upgrades.upg_sb2 = {
	embers_duration = 8,
	stun_duration = 4,
	s_damage = 128
}
b.heroes.hero_ashbite.upgrades.upg_sc1 = {
	heal_ptg = 0.3
}
b.heroes.hero_ashbite.upgrades.upg_sc2 = {
	heal_ptg = 0.4
}
b.heroes.hero_ashbite.upgrades.upg_a = {
	hp_ptg = 0.1
}
b.heroes.hero_ashbite.upgrades.upg_b = {
	range_factor = 1.15
}
b.heroes.hero_ashbite.upgrades.upg_b.s_range_factor = sub_one(b.heroes.hero_ashbite.upgrades.upg_b.range_factor)
b.heroes.hero_ashbite.upgrades.upg_c = {
	skill_red_factor = 0.1,
	ult_red_factor = 0.05
}
b.heroes.hero_ashbite.upgrades.upg_d = {
	regen_factor = 1.3
}
b.heroes.hero_ashbite.upgrades.upg_d.s_regen_factor = sub_one(b.heroes.hero_ashbite.upgrades.upg_d.regen_factor)
b.heroes.hero_ashbite.upgrades.upg_e = {
	dmg_factor = 1.1
}
b.heroes.hero_ashbite.upgrades.upg_e.s_dmg_factor = sub_one(b.heroes.hero_ashbite.upgrades.upg_e.dmg_factor)
b.heroes.hero_rhodes = {
	stats = {}
}
b.heroes.hero_rhodes.stats.hp = 7
b.heroes.hero_rhodes.stats.armor = 5
b.heroes.hero_rhodes.stats.damage = 3
b.heroes.hero_rhodes.stats.cooldown = 5.5
b.heroes.hero_rhodes.dead_lifetime = 30
b.heroes.hero_rhodes.speed = 32
b.heroes.hero_rhodes.regen_cooldown = 1
b.heroes.hero_rhodes.armor = {
	0.23,
	0.26,
	0.29,
	0.32,
	0.35,
	0.38,
	0.41,
	0.44,
	0.47,
	0.5
}
b.heroes.hero_rhodes.hp_max = {
	180,
	205,
	230,
	255,
	280,
	305,
	330,
	355,
	380,
	405
}
b.heroes.hero_rhodes.regen_health = {
	14,
	16,
	18,
	20,
	22,
	24,
	26,
	28,
	30,
	32
}
b.heroes.hero_rhodes.basic_melee = {
	cooldown = 1.5,
	xp_gain_factor = 1,
	damage_min = {
		8,
		10,
		11,
		12,
		13,
		14,
		16,
		17,
		18,
		19
	},
	damage_max = {
		13,
		14,
		16,
		18,
		20,
		22,
		23,
		25,
		27,
		29
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_rhodes.skill_a = {
	cooldown = 10,
	xp_gain = {
		10,
		20,
		30
	},
	damage_min = 16,
	damage_max = 24,
	damage_type = DAMAGE_TRUE,
	min_range = 50,
	max_range = 200,
	stun_duration = 0.5
}
b.heroes.hero_rhodes.skill_b = {
	cooldown = 22,
	xp_gain = {
		22,
		44,
		66
	},
	duration = 6,
	hp_heal_ptg = 0.3,
	armor_inc = 0.3,
	trigger_hp_ptg = 0.7,
	time_blocking_to_trigger = 5
}
b.heroes.hero_rhodes.skill_c = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	range = 150,
	range_pre_block = 175,
	min_targets = 3,
	aura = {}
}
b.heroes.hero_rhodes.skill_c.aura.damage_min = 10
b.heroes.hero_rhodes.skill_c.aura.damage_max = 15
b.heroes.hero_rhodes.skill_c.aura.s_damage_min = 32
b.heroes.hero_rhodes.skill_c.aura.s_damage_max = 48
b.heroes.hero_rhodes.skill_c.aura.damage_type = DAMAGE_PHYSICAL
b.heroes.hero_rhodes.skill_c.aura.travel_distance = 18
b.heroes.hero_rhodes.skill_c.aura.range = 75
b.heroes.hero_rhodes.skill_c.aura.speed = 200
b.heroes.hero_rhodes.skill_c.aura.cycle_time = 0.25
b.heroes.hero_rhodes.skill_c.slow = {
	duration = 4,
	factor = 0.8
}
b.heroes.hero_rhodes.skill_c.slow.s_factor = 1 - b.heroes.hero_rhodes.skill_c.slow.factor
b.heroes.hero_rhodes.ultimate = {
	cooldown = 35,
	xp_gain = {
		35
	},
	damage_min = 30,
	damage_max = 42,
	damage_radius = 55,
	damage_type = DAMAGE_TRUE,
	range = 225,
	range_pre_block = 250,
	ray_duration = 3,
	min_targets = 3,
	move_speed = 40,
	cycle_time = 0.25,
	s_total_min_damage = 120,
	s_total_max_damage = 160,
	slow = {}
}
b.heroes.hero_rhodes.ultimate.slow.duration = 1
b.heroes.hero_rhodes.ultimate.slow.factor = 0.5
b.heroes.hero_rhodes.ultimate.slow.s_factor = 1 - b.heroes.hero_rhodes.ultimate.slow.factor
b.heroes.hero_rhodes.talent_1 = {
	hp_threshold = 0.75,
	armor_inc = 0.2
}
b.heroes.hero_rhodes.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_rhodes.upgrades.upg_sa1.cooldown = 9
b.heroes.hero_rhodes.upgrades.upg_sa1.damage_min = 28
b.heroes.hero_rhodes.upgrades.upg_sa1.damage_max = 42
b.heroes.hero_rhodes.upgrades.upg_sa2 = {
	cooldown = 8,
	damage_min = 40,
	damage_max = 60
}
b.heroes.hero_rhodes.upgrades.upg_sb1 = {
	hp_heal_ptg = 0.4,
	armor_inc = 0.4,
	trigger_hp_ptg = 0.7
}
b.heroes.hero_rhodes.upgrades.upg_sb2 = {
	hp_heal_ptg = 0.5,
	armor_inc = 0.5,
	trigger_hp_ptg = 0.7
}
b.heroes.hero_rhodes.upgrades.upg_sc1 = {
	slow_factor = 0.7
}
b.heroes.hero_rhodes.upgrades.upg_sc1.s_slow_factor = 1 - b.heroes.hero_rhodes.upgrades.upg_sc1.slow_factor
b.heroes.hero_rhodes.upgrades.upg_sc2 = {
	damage_min = 12,
	damage_max = 18,
	s_damage_min = 48,
	s_damage_max = 72
}
b.heroes.hero_rhodes.upgrades.upg_a = {
	regen_factor = 1.15
}
b.heroes.hero_rhodes.upgrades.upg_a.s_regen_factor = sub_one(b.heroes.hero_rhodes.upgrades.upg_a.regen_factor)
b.heroes.hero_rhodes.upgrades.upg_b = {
	hp_ptg = 0.1
}
b.heroes.hero_rhodes.upgrades.upg_b.s_hp_ptg = b.heroes.hero_rhodes.upgrades.upg_b.hp_ptg
b.heroes.hero_rhodes.upgrades.upg_c = {
	armor_inc = 0.15
}
b.heroes.hero_rhodes.upgrades.upg_d = {
	dmg_factor = 1.1
}
b.heroes.hero_rhodes.upgrades.upg_d.s_dmg_factor = sub_one(b.heroes.hero_rhodes.upgrades.upg_d.dmg_factor)
b.heroes.hero_rhodes.upgrades.upg_e = {
	skills_cd_red_factor = 0.1
}
b.heroes.hero_rhodes.upgrades.upg_e.skill_red_factor = b.heroes.hero_rhodes.upgrades.upg_e.skills_cd_red_factor
b.heroes.hero_drakkan = {
	stats = {}
}
b.heroes.hero_drakkan.stats.hp = 8.5
b.heroes.hero_drakkan.stats.armor = 2
b.heroes.hero_drakkan.stats.damage = 8
b.heroes.hero_drakkan.stats.cooldown = 3.5
b.heroes.hero_drakkan.dead_lifetime = 30
b.heroes.hero_drakkan.speed = 100
b.heroes.hero_drakkan.regen_cooldown = 1
b.heroes.hero_drakkan.armor = {
	0,
	0.02,
	0.04,
	0.06,
	0.08,
	0.1,
	0.12,
	0.14,
	0.16,
	0.18
}
b.heroes.hero_drakkan.hp_max = {
	230,
	255,
	280,
	305,
	330,
	355,
	380,
	405,
	430,
	455
}
b.heroes.hero_drakkan.regen_health = {
	18,
	20,
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36
}
b.heroes.hero_drakkan.basic_attack = {
	min_range = 50,
	max_range = 220,
	damage_type = DAMAGE_MAGICAL,
	cooldown = 2,
	xp_gain_factor = 0.6,
	damage_min = {
		13,
		16,
		19,
		22,
		26,
		29,
		32,
		35,
		38,
		42
	},
	damage_max = {
		19,
		24,
		29,
		34,
		38,
		43,
		48,
		53,
		58,
		62
	},
	damage_radius = 40
}
b.heroes.hero_drakkan.skill_a = {
	cooldown = 15,
	xp_gain = {
		15,
		30,
		45
	},
	min_targets = 3,
	min_range = 50,
	max_range = 160,
	silence = {}
}
b.heroes.hero_drakkan.skill_a.silence.duration = 8
b.heroes.hero_drakkan.skill_a.aura = {
	duration = fts(45),
	damage_min = 6,
	damage_max = 9,
	s_damage_min = 24,
	s_damage_max = 36,
	damage_type = DAMAGE_MAGICAL,
	damage_every = 0.25,
	damage_radius = 75
}
b.heroes.hero_drakkan.skill_b = {
	cooldown = 18,
	xp_gain = {
		18,
		36,
		54
	},
	min_targets = 3,
	min_range = 50,
	max_range = 90,
	aura = {}
}
b.heroes.hero_drakkan.skill_b.aura.damage_type = DAMAGE_MAGICAL
b.heroes.hero_drakkan.skill_b.aura.damage_min = 24
b.heroes.hero_drakkan.skill_b.aura.damage_max = 36
b.heroes.hero_drakkan.skill_b.aura.damage_radius = 90
b.heroes.hero_drakkan.skill_c = {
	cooldown = 28,
	range = 220,
	xp_gain = {
		28,
		56,
		84
	},
	clone = {}
}
b.heroes.hero_drakkan.skill_c.clone.speed = 100
b.heroes.hero_drakkan.skill_c.clone.regen_cooldown = 1
b.heroes.hero_drakkan.skill_c.clone.armor = 0.06
b.heroes.hero_drakkan.skill_c.clone.hp_max = 240
b.heroes.hero_drakkan.skill_c.clone.regen_health = 19
b.heroes.hero_drakkan.skill_c.clone.spawn_offset = v(-50, 15)
b.heroes.hero_drakkan.skill_c.clone.duration = 10
b.heroes.hero_drakkan.skill_c.clone.basic_attack = {
	min_range = b.heroes.hero_drakkan.basic_attack.min_range,
	max_range = b.heroes.hero_drakkan.basic_attack.max_range,
	damage_type = DAMAGE_MAGICAL,
	cooldown = b.heroes.hero_drakkan.basic_attack.cooldown,
	damage_min = 19,
	damage_max = 29,
	damage_radius = b.heroes.hero_drakkan.basic_attack.damage_radius
}
b.heroes.hero_drakkan.ultimate = {
	cooldown = 40,
	xp_gain = {
		40
	},
	min_targets = 7,
	max_range = 2000,
	shots = 7,
	damage_min = 40,
	damage_max = 60,
	damage_type = DAMAGE_MAGICAL,
	damage_radius = 70
}
b.heroes.hero_drakkan.talent_1 = {
	cooldown = 2,
	min_dist = 250
}
b.heroes.hero_drakkan.talent_2 = {
	skills_cd_red = 0.2
}
b.heroes.hero_drakkan.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_drakkan.upgrades.upg_sa1.damage_min = 8
b.heroes.hero_drakkan.upgrades.upg_sa1.damage_max = 12
b.heroes.hero_drakkan.upgrades.upg_sa1.s_damage_min = 48
b.heroes.hero_drakkan.upgrades.upg_sa1.s_damage_max = 72
b.heroes.hero_drakkan.upgrades.upg_sa1.silence_duration = 10
b.heroes.hero_drakkan.upgrades.upg_sa2 = {
	damage_min = 12,
	damage_max = 18,
	s_damage_min = 72,
	s_damage_max = 108,
	silence_duration = 12
}
b.heroes.hero_drakkan.upgrades.upg_sb1 = {
	damage_min = 48,
	damage_max = 72
}
b.heroes.hero_drakkan.upgrades.upg_sb2 = {
	damage_min = 82,
	damage_max = 114
}
b.heroes.hero_drakkan.upgrades.upg_sc1 = {
	duration = 13
}
b.heroes.hero_drakkan.upgrades.upg_sc2 = {
	duration = 16
}
b.heroes.hero_drakkan.upgrades.upg_a = {
	magic_res = 1
}
b.heroes.hero_drakkan.upgrades.upg_b = {
	regen_factor = 1.2
}
b.heroes.hero_drakkan.upgrades.upg_b.s_regen_factor = sub_one(b.heroes.hero_drakkan.upgrades.upg_b.regen_factor)
b.heroes.hero_drakkan.upgrades.upg_c = {
	skill_dmg_factor = 1.1
}
b.heroes.hero_drakkan.upgrades.upg_c.s_skill_dmg_factor = sub_one(b.heroes.hero_drakkan.upgrades.upg_c.skill_dmg_factor)
b.heroes.hero_drakkan.upgrades.upg_d = {
	dmg_factor = 1.1
}
b.heroes.hero_drakkan.upgrades.upg_d.s_dmg_factor = sub_one(b.heroes.hero_drakkan.upgrades.upg_d.dmg_factor)
b.heroes.hero_drakkan.upgrades.upg_e = {
	range_factor = 1.2
}
b.heroes.hero_drakkan.upgrades.upg_e.s_range_factor = sub_one(b.heroes.hero_drakkan.upgrades.upg_e.range_factor)
b.heroes.hero_myriath = {
	stats = {}
}
b.heroes.hero_myriath.stats.hp = 2
b.heroes.hero_myriath.stats.armor = 0
b.heroes.hero_myriath.stats.damage = 5
b.heroes.hero_myriath.stats.cooldown = 5.5
b.heroes.hero_myriath.dead_lifetime = 30
b.heroes.hero_myriath.speed = 90
b.heroes.hero_myriath.regen_cooldown = 1
b.heroes.hero_myriath.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
b.heroes.hero_myriath.hp_max = {
	170,
	180,
	190,
	200,
	210,
	220,
	230,
	240,
	250,
	260
}
b.heroes.hero_myriath.regen_health = {
	14,
	14,
	15,
	16,
	17,
	18,
	18,
	19,
	20,
	21
}
b.heroes.hero_myriath.basic_melee = {
	cooldown = 1.5,
	xp_gain_factor = 0.8,
	damage_min = {
		12,
		14,
		16,
		17,
		19,
		21,
		23,
		25,
		26,
		28
	},
	damage_max = {
		18,
		21,
		23,
		26,
		29,
		32,
		34,
		37,
		40,
		42
	},
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_myriath.basic_ranged = {
	cooldown = 1.5,
	xp_gain_factor = 0.8,
	max_range = 125,
	min_range = 70,
	damage_min = {
		12,
		14,
		16,
		17,
		19,
		21,
		23,
		25,
		26,
		28
	},
	damage_max = {
		18,
		21,
		23,
		26,
		29,
		32,
		34,
		37,
		40,
		42
	},
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_myriath.skill_a = {
	cooldown = 6,
	min_range = 75,
	max_range = 130,
	xp_gain = {
		6,
		12,
		18
	},
	damage_min = 12,
	damage_max = 18,
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_myriath.skill_b = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	min_distance_from_end = 200,
	distance = 50
}
b.heroes.hero_myriath.skill_c = {
	damage_min = 6,
	damage_max = 8,
	s_damage_min = 36,
	s_damage_max = 48,
	damage_type = DAMAGE_MAGICAL,
	cooldown = 12,
	xp_gain = {
		12,
		24,
		48
	}
}
b.heroes.hero_myriath.ultimate = {
	cooldown = 40,
	xp_gain = {
		40
	},
	min_targets = 3,
	distance = 40,
	min_detection_range = 20,
	max_detection_range = 80,
	damage_min = 60,
	damage_max = 90,
	damage_type = DAMAGE_MAGICAL,
	damage_radius = 55,
	max_speed = 80,
	clone_count = 3
}
b.heroes.hero_myriath.talent_1 = {
	health_inc = 25,
	s_health_inc = 110,
	duration_inc = 2,
	s_duration_inc = 8
}
b.heroes.hero_myriath.talent_2 = {
	radius = 75,
	damage_min = 48,
	damage_max = 72,
	damage_type = DAMAGE_MAGICAL
}
b.heroes.hero_myriath.clone = {
	stats = {}
}
b.heroes.hero_myriath.clone.stats.hp = 2
b.heroes.hero_myriath.clone.stats.armor = 0
b.heroes.hero_myriath.clone.stats.damage = 7
b.heroes.hero_myriath.clone.stats.cooldown = 8
b.heroes.hero_myriath.clone.speed = 100
b.heroes.hero_myriath.clone.regen_cooldown = 1
b.heroes.hero_myriath.clone.armor = 0
b.heroes.hero_myriath.clone.hp_max = 85
b.heroes.hero_myriath.clone.regen_health = 7
b.heroes.hero_myriath.clone.duration = 6
b.heroes.hero_myriath.clone.basic_melee_attack_ptg = 0.68
b.heroes.hero_myriath.clone.basic_ranged_attack_ptg = 0.68
b.heroes.hero_myriath.clone.skill_c_attack_ptg = 1
b.heroes.hero_myriath.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_myriath.upgrades.upg_sa1.min_damage = 24
b.heroes.hero_myriath.upgrades.upg_sa1.max_damage = 36
b.heroes.hero_myriath.upgrades.upg_sa2 = {
	min_damage = 36,
	max_damage = 54
}
b.heroes.hero_myriath.upgrades.upg_sb1 = {
	cooldown = 13
}
b.heroes.hero_myriath.upgrades.upg_sb2 = {
	cooldown = 10
}
b.heroes.hero_myriath.upgrades.upg_sc1 = {
	damage_min = 7,
	damage_max = 10,
	s_damage_min = 42,
	s_damage_max = 60
}
b.heroes.hero_myriath.upgrades.upg_sc2 = {
	damage_min = 8,
	damage_max = 12,
	s_damage_min = 48,
	s_damage_max = 72
}
b.heroes.hero_myriath.upgrades.upg_a = {
	movement_factor = 1.5
}
b.heroes.hero_myriath.upgrades.upg_a.s_movement_factor = sub_one(b.heroes.hero_myriath.upgrades.upg_a.movement_factor)
b.heroes.hero_myriath.upgrades.upg_b = {
	damage_factor = 1.05
}
b.heroes.hero_myriath.upgrades.upg_b.s_dmg_factor = sub_one(b.heroes.hero_myriath.upgrades.upg_b.damage_factor)
b.heroes.hero_myriath.upgrades.upg_c = {
	attack_cooldown = 1,
	s_attack_cooldown = 0.35
}
b.heroes.hero_myriath.upgrades.upg_d = {
	dodge_chance = 0.2
}
b.heroes.hero_myriath.upgrades.upg_e = {
	skill_red_factor = 0.15,
	ult_red_factor = 0.05
}
b.heroes.hero_connor = {
	stats = {}
}
b.heroes.hero_connor.stats.hp = 4.5
b.heroes.hero_connor.stats.armor = 2.5
b.heroes.hero_connor.stats.damage = 4.5
b.heroes.hero_connor.stats.cooldown = 4.5
b.heroes.hero_connor.dead_lifetime = 30
b.heroes.hero_connor.speed = 70
b.heroes.hero_connor.regen_cooldown = 1
b.heroes.hero_connor.armor = {
	0.07,
	0.09,
	0.11,
	0.13,
	0.15,
	0.17,
	0.19,
	0.21,
	0.23,
	0.25
}
b.heroes.hero_connor.hp_max = {
	200,
	215,
	230,
	245,
	260,
	275,
	290,
	305,
	320,
	335
}
b.heroes.hero_connor.regen_health = {
	16,
	17,
	18,
	20,
	21,
	22,
	23,
	24,
	26,
	27
}
b.heroes.hero_connor.basic_melee = {
	cooldown = 1.75,
	xp_gain_factor = 0.9,
	damage_min = {
		13,
		14,
		15,
		17,
		18,
		20,
		21,
		22,
		24,
		25
	},
	damage_max = {
		19,
		21,
		23,
		25,
		27,
		29,
		32,
		34,
		36,
		38
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_connor.skill_a = {
	cooldown = 16,
	xp_gain = {
		16,
		32,
		48
	},
	min_targets = 3,
	min_range = 0,
	max_range = 100,
	damage_min = 12,
	damage_max = 18,
	damage_radius = 170,
	damage_type = DAMAGE_PHYSICAL,
	bleed = {}
}
b.heroes.hero_connor.skill_a.bleed.duration = 4
b.heroes.hero_connor.skill_a.bleed.cycle_time = 0.25
b.heroes.hero_connor.skill_a.bleed.damage_min = 1
b.heroes.hero_connor.skill_a.bleed.damage_max = 1
b.heroes.hero_connor.skill_a.bleed.s_damage = 16
b.heroes.hero_connor.skill_a.bleed.sa1_damage = 24
b.heroes.hero_connor.skill_a.bleed.sa2_damage = 36
b.heroes.hero_connor.skill_a.bleed.damage_type = DAMAGE_TRUE
b.heroes.hero_connor.skill_b = {
	cooldown = 25,
	xp_gain = {
		25,
		50,
		75
	},
	min_range = 50,
	max_range = 90,
	time_to_block = 2,
	damage_min = 64,
	damage_max = 96,
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_connor.skill_c = {
	cooldown = 22,
	range = 220,
	xp_gain = {
		22,
		44,
		66
	},
	min_range = 0,
	max_range = 190,
	min_targets = 3,
	amount_of_aoes = 4,
	node_between_aoes = 5,
	damage_min = 44,
	damage_max = 68,
	damage_radius = 40,
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_connor.ultimate = {
	cooldown = 30,
	xp_gain = {
		30
	},
	min_targets = 1,
	min_range = 0,
	max_range = 120,
	duration = 10,
	basic_attack_cooldown = 1,
	s_basic_attack_cooldown = 0.55,
	base_damage_factor = 2
}
b.heroes.hero_connor.ultimate.s_base_damage_factor = sub_one(b.heroes.hero_connor.ultimate.base_damage_factor)
b.heroes.hero_connor.ultimate.movement_speed_factor = 1.3
b.heroes.hero_connor.ultimate.s_movement_speed = sub_one(b.heroes.hero_connor.ultimate.movement_speed_factor)
b.heroes.hero_connor.ultimate.basic_attack_xp_gain_factor = 0.8
b.heroes.hero_connor.ultimate.hp_ptg_to_trigger = 0.8
b.heroes.hero_connor.ultimate.stun = {
	damage_min = 20,
	damage_max = 20,
	damage_type = DAMAGE_PHYSICAL,
	range = 100,
	duration = 1
}
b.heroes.hero_connor.talent_1 = {
	hp_ptg_to_trigger = 0.4,
	skill_damage_factor = 1.4
}
b.heroes.hero_connor.talent_1.s_skill_damage_factor = sub_one(b.heroes.hero_connor.talent_1.skill_damage_factor)
b.heroes.hero_connor.talent_2 = {
	chance_to_revive = 1,
	cooldown = 180,
	hp_ptg_on_revive = 0.7,
	starting_cd = 0
}
b.heroes.hero_connor.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_connor.upgrades.upg_sa1.bleed_duration = 6
b.heroes.hero_connor.upgrades.upg_sa1.damage_min = 32
b.heroes.hero_connor.upgrades.upg_sa1.damage_max = 48
b.heroes.hero_connor.upgrades.upg_sa2 = {
	bleed_duration = 8,
	damage_min = 52,
	damage_max = 78
}
b.heroes.hero_connor.upgrades.upg_sb1 = {
	damage_min = 80,
	damage_max = 120,
	cooldown = 22
}
b.heroes.hero_connor.upgrades.upg_sb2 = {
	damage_min = 96,
	damage_max = 144,
	cooldown = 19
}
b.heroes.hero_connor.upgrades.upg_sc1 = {
	amount_of_aoes = 6,
	damage_min = 54,
	damage_max = 82
}
b.heroes.hero_connor.upgrades.upg_sc2 = {
	amount_of_aoes = 8,
	damage_min = 74,
	damage_max = 106
}
b.heroes.hero_connor.upgrades.upg_a = {
	hp_ptg = 0.1
}
b.heroes.hero_connor.upgrades.upg_b = {
	armor_inc = 0.1
}
b.heroes.hero_connor.upgrades.upg_c = {
	skills_cd_red_factor = 0.1,
	ult_cd_red_factor = 0.05
}
b.heroes.hero_connor.upgrades.upg_c.skill_red_factor = b.heroes.hero_connor.upgrades.upg_c.skills_cd_red_factor
b.heroes.hero_connor.upgrades.upg_d = {
	dmg_factor = 1.1
}
b.heroes.hero_connor.upgrades.upg_d.s_dmg_factor = sub_one(b.heroes.hero_connor.upgrades.upg_d.dmg_factor)
b.heroes.hero_connor.upgrades.upg_e = {
	attack_cooldown = 1.5,
	s_attack_cooldown = 0.15
}
b.heroes.hero_ignus = {
	throttled_cooldown = 1,
	stats = {}
}
b.heroes.hero_ignus.stats.hp = 5
b.heroes.hero_ignus.stats.armor = 0
b.heroes.hero_ignus.stats.damage = 3.5
b.heroes.hero_ignus.stats.cooldown = 7.5
b.heroes.hero_ignus.dead_lifetime = 30
b.heroes.hero_ignus.speed = 70
b.heroes.hero_ignus.regen_cooldown = 1
b.heroes.hero_ignus.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
b.heroes.hero_ignus.hp_max = {
	210,
	225,
	240,
	255,
	270,
	285,
	300,
	315,
	330,
	345
}
b.heroes.hero_ignus.regen_health = {
	17,
	18,
	19,
	20,
	22,
	23,
	24,
	25,
	26,
	28
}
b.heroes.hero_ignus.basic_melee = {
	xp_gain_factor = 0.7,
	damage_min = {
		3,
		3,
		4,
		4,
		5,
		5,
		6,
		7,
		7,
		8
	},
	damage_max = {
		4,
		5,
		6,
		7,
		7,
		8,
		9,
		10,
		11,
		11
	},
	damage_type = DAMAGE_TRUE
}
b.heroes.hero_ignus.skill_a = {
	cooldown = 10,
	xp_gain = {
		10,
		20,
		30
	},
	damage_min = 40,
	damage_max = 60,
	damage_type = DAMAGE_TRUE,
	min_range = 50,
	max_range = 120
}
b.heroes.hero_ignus.skill_b = {
	cooldown = 18,
	xp_gain = {
		18,
		36,
		54
	},
	min_targets = 3,
	detection_range = 90,
	damage_radius = 100,
	damage_min = 48,
	damage_max = 90,
	damage_type = DAMAGE_TRUE
}
b.heroes.hero_ignus.skill_c = {
	cooldown = 15,
	xp_gain = {
		15,
		30,
		45
	},
	detection_range = 100,
	bounce_range = 120,
	max_hits = 3,
	damage_min = 56,
	damage_max = 84,
	damage_type = DAMAGE_TRUE
}
b.heroes.hero_ignus.ultimate = {
	cooldown = 30,
	xp_gain = {
		30
	},
	duration = 3,
	min_targets = 2,
	detection_range = 80,
	damage_radius = 80,
	min_range = 20,
	damage_min = 20,
	damage_max = 30,
	s_damage_min = 240,
	s_damage_max = 360,
	damage_type = DAMAGE_TRUE,
	cycle_time = 0.25,
	movement_speed = 0.21
}
b.heroes.hero_ignus.talent_1 = {
	damage_radius = 50,
	damage_min = 2,
	damage_max = 2,
	s_total_damage = 8,
	damage_type = DAMAGE_TRUE,
	cycle_time = 0.25
}
b.heroes.hero_ignus.talent_2 = {
	heal_ptg = 0.15
}
b.heroes.hero_ignus.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_ignus.upgrades.upg_sa1.damage_min = 64
b.heroes.hero_ignus.upgrades.upg_sa1.damage_max = 96
b.heroes.hero_ignus.upgrades.upg_sa2 = {
	damage_min = 100,
	damage_max = 150
}
b.heroes.hero_ignus.upgrades.upg_sb1 = {
	damage_min = 64,
	damage_max = 120
}
b.heroes.hero_ignus.upgrades.upg_sb2 = {
	damage_min = 88,
	damage_max = 165
}
b.heroes.hero_ignus.upgrades.upg_sc1 = {
	damage_min = 80,
	damage_max = 120
}
b.heroes.hero_ignus.upgrades.upg_sc2 = {
	damage_min = 120,
	damage_max = 180
}
b.heroes.hero_ignus.upgrades.upg_a = {
	extra_speed_factor = 7.714,
	min_distance = 160,
	slide_distance = 12
}
b.heroes.hero_ignus.upgrades.upg_b = {
	dmg_factor = 1.1
}
b.heroes.hero_ignus.upgrades.upg_b.s_dmg_factor = sub_one(b.heroes.hero_ignus.upgrades.upg_b.dmg_factor)
b.heroes.hero_ignus.upgrades.upg_c = {
	skills_cd_red_factor = 0.1
}
b.heroes.hero_ignus.upgrades.upg_c.skill_red_factor = b.heroes.hero_ignus.upgrades.upg_c.skills_cd_red_factor
b.heroes.hero_ignus.upgrades.upg_d = {
	regen_factor = 1.15
}
b.heroes.hero_ignus.upgrades.upg_d.s_regen_factor = sub_one(b.heroes.hero_ignus.upgrades.upg_d.regen_factor)
b.heroes.hero_ignus.upgrades.upg_e = {
	hp_ptg = 0.1
}
b.heroes.hero_ignus.upgrades.upg_e.s_hp_ptg = b.heroes.hero_ignus.upgrades.upg_e.hp_ptg
b.heroes.hero_oni = {
	throttled_cooldown = 1,
	stats = {}
}
b.heroes.hero_oni.stats.hp = 4
b.heroes.hero_oni.stats.armor = 3.5
b.heroes.hero_oni.stats.damage = 8
b.heroes.hero_oni.stats.cooldown = 3.5
b.heroes.hero_oni.dead_lifetime = 30
b.heroes.hero_oni.speed = 70
b.heroes.hero_oni.regen_cooldown = 1
b.heroes.hero_oni.armor = {
	0.1,
	0.13,
	0.16,
	0.19,
	0.22,
	0.25,
	0.28,
	0.31,
	0.34,
	0.37
}
b.heroes.hero_oni.hp_max = {
	180,
	195,
	210,
	225,
	240,
	255,
	270,
	285,
	300,
	315
}
b.heroes.hero_oni.regen_health = {
	14,
	16,
	17,
	18,
	19,
	20,
	22,
	23,
	24,
	25
}
b.heroes.hero_oni.basic_melee = {
	cooldown = 2,
	xp_gain_factor = 0.7,
	damage_min = {
		5,
		7,
		9,
		10,
		12,
		13,
		15,
		17,
		18,
		20
	},
	damage_max = {
		8,
		11,
		13,
		15,
		18,
		20,
		23,
		25,
		27,
		30
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_oni.skill_a = {
	cooldown = 24,
	xp_gain = {
		24,
		48,
		72
	},
	damage_min = 95,
	damage_max = 105,
	damage_type = DAMAGE_TRUE
}
b.heroes.hero_oni.skill_b = {
	cooldown = 20,
	xp_gain = {
		20,
		40,
		60
	},
	duration = fts(90),
	cancel_time_refund = 0.5,
	s_duration = 3,
	trigger_threshold = 0.5,
	heal_ptg = 0.0208,
	s_heal_ptg = 0.25,
	heal_every = 0.25
}
b.heroes.hero_oni.skill_c = {
	cooldown = 18,
	xp_gain = {
		18,
		36,
		54
	},
	min_detection_range = 100,
	detection_range = 250,
	damage_min = {
		40,
		40,
		40
	},
	damage_max = {
		60,
		60,
		60
	},
	damage_type = DAMAGE_PHYSICAL,
	armor_red = 0.05
}
b.heroes.hero_oni.ultimate = {
	cooldown = 38,
	xp_gain = {
		38
	},
	damage_min = 160,
	damage_max = 180,
	damage_radius = 70,
	damage_type = DAMAGE_TRUE,
	min_targets = 2,
	prediction = fts(0)
}
b.heroes.hero_oni.talent_1 = {
	damage_factor = 2,
	s_damage_factor = 1,
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_oni.talent_2 = {
	s_lifesteal = 0.5,
	lifesteal = 0.5,
	block_time = 4
}
b.heroes.hero_oni.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_oni.upgrades.upg_sa1.damage_min = 165
b.heroes.hero_oni.upgrades.upg_sa1.damage_max = 175
b.heroes.hero_oni.upgrades.upg_sa2 = {
	damage_min = 235,
	damage_max = 245
}
b.heroes.hero_oni.upgrades.upg_sb1 = {
	heal_ptg = 0.0333,
	s_heal_ptg = 0.4
}
b.heroes.hero_oni.upgrades.upg_sb2 = {
	heal_ptg = 0.0458,
	s_heal_ptg = 0.55
}
b.heroes.hero_oni.upgrades.upg_sc1 = {
	damage_min = {
		52,
		52,
		52
	},
	damage_max = {
		78,
		78,
		78
	},
	armor_red = 0.07
}
b.heroes.hero_oni.upgrades.upg_sc2 = {
	damage_min = {
		64,
		64,
		64
	},
	damage_max = {
		96,
		96,
		96
	},
	armor_red = 0.1
}
b.heroes.hero_oni.upgrades.upg_a = {
	skills_cd_red_factor = 0.1
}
b.heroes.hero_oni.upgrades.upg_a.skill_red_factor = b.heroes.hero_oni.upgrades.upg_a.skills_cd_red_factor
b.heroes.hero_oni.upgrades.upg_a.s_skill_red_factor = b.heroes.hero_oni.upgrades.upg_a.skill_red_factor
b.heroes.hero_oni.upgrades.upg_b = {
	hp_ptg = 0.1
}
b.heroes.hero_oni.upgrades.upg_b.s_hp_ptg = b.heroes.hero_oni.upgrades.upg_b.hp_ptg
b.heroes.hero_oni.upgrades.upg_c = {
	armor_inc = 0.15
}
b.heroes.hero_oni.upgrades.upg_d = {
	attack_cooldown = 1.8,
	s_attack_cooldown = 0.1
}
b.heroes.hero_oni.upgrades.upg_e = {
	damage_factor = 1.12
}
b.heroes.hero_oni.upgrades.upg_e.s_dmg_factor = sub_one(b.heroes.hero_oni.upgrades.upg_e.damage_factor)
b.heroes.hero_illiana = {
	stats = {}
}
b.heroes.hero_illiana.stats.hp = 1
b.heroes.hero_illiana.stats.armor = 0
b.heroes.hero_illiana.stats.damage = 6
b.heroes.hero_illiana.stats.cooldown = 7.5
b.heroes.hero_illiana.dead_lifetime = 30
b.heroes.hero_illiana.speed = 70
b.heroes.hero_illiana.regen_cooldown = 1
b.heroes.hero_illiana.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
b.heroes.hero_illiana.hp_max = {
	140,
	150,
	160,
	170,
	180,
	190,
	200,
	210,
	220,
	230
}
b.heroes.hero_illiana.regen_health = {
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20
}
b.heroes.hero_illiana.basic_melee = {
	cooldown = 1,
	xp_gain_factor = 0.75,
	damage_min = {
		4,
		4,
		5,
		5,
		6,
		7,
		8,
		8,
		9,
		10
	},
	damage_max = {
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_illiana.basic_ranged = {
	cooldown = 1,
	xp_gain_factor = 0.75,
	max_range = 165,
	min_range = 70,
	damage_min = {
		4,
		7,
		8,
		9,
		10,
		12,
		13,
		14,
		15,
		16
	},
	damage_max = {
		10,
		13,
		15,
		17,
		20,
		22,
		24,
		26,
		29,
		31
	},
	damage_type = DAMAGE_PHYSICAL
}
b.heroes.hero_illiana.dragon = {
	basic_ranged = {}
}
b.heroes.hero_illiana.dragon.basic_ranged.damage_min = {
	4,
	5,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
b.heroes.hero_illiana.dragon.basic_ranged.damage_max = {
	7,
	8,
	9,
	11,
	12,
	14,
	15,
	17,
	18,
	20
}
b.heroes.hero_illiana.dragon.basic_ranged.damage_type = DAMAGE_MAGICAL
b.heroes.hero_illiana.dragon.basic_ranged.max_range = 165
b.heroes.hero_illiana.dragon.basic_ranged.cooldown = 1
b.heroes.hero_illiana.transfer = {
	min_distance = 160,
	extra_speed = 25
}
b.heroes.hero_illiana.skill_a = {
	cooldown = 12,
	xp_gain = {
		12,
		24,
		36
	},
	damage_min = 20,
	damage_max = 40,
	damage_type = DAMAGE_TRUE,
	max_range = 165,
	max_bounces = 2,
	bounce_range = 75,
	min_targets = 3,
	tag_duration = 4,
	basic_range = 165,
	armor_red = 0.25,
	magic_armor_red = 0
}
b.heroes.hero_illiana.skill_b = {
	cooldown = 15,
	xp_gain = {
		15,
		30,
		45
	},
	min_targets = 3,
	detection_radius = 165,
	stun_radius = 100,
	stun_duration = 2
}
b.heroes.hero_illiana.skill_c = {
	cooldown = 1,
	xp_gain = {
		8,
		16,
		24
	},
	damage_min = 42,
	damage_max = 58,
	damage_type = DAMAGE_PHYSICAL,
	detection_range = 165
}
b.heroes.hero_illiana.ultimate = {
	cooldown = 35,
	xp_gain = {
		35
	},
	detection_range = 200,
	min_targets = 3,
	distance = 50,
	distance_between_nodes = 4,
	random_for_node = 4,
	fire_stream = {}
}
b.heroes.hero_illiana.ultimate.fire_stream.damage_min = 55
b.heroes.hero_illiana.ultimate.fire_stream.damage_max = 85
b.heroes.hero_illiana.ultimate.fire_stream.damage_type = DAMAGE_TRUE
b.heroes.hero_illiana.ultimate.fire_stream.cycle_time = 0.25
b.heroes.hero_illiana.ultimate.fire_stream.damage_radius = 60
b.heroes.hero_illiana.ultimate.fire_decal = {
	damage_min = 3,
	damage_max = 5,
	s_damage_min = 12,
	s_damage_max = 20,
	damage_type = DAMAGE_TRUE,
	duration = 3,
	cycle_time = 0.25,
	damage_radius = 50
}
b.heroes.hero_illiana.talent_1 = {
	dodge_chance = 0.4
}
b.heroes.hero_illiana.talent_2 = {
	damage_factor = 2
}
b.heroes.hero_illiana.talent_2.s_damage_factor = sub_one(b.heroes.hero_illiana.talent_2.damage_factor)
b.heroes.hero_illiana.upgrades = {
	upg_sa1 = {}
}
b.heroes.hero_illiana.upgrades.upg_sa1.damage_min = 45
b.heroes.hero_illiana.upgrades.upg_sa1.damage_max = 70
b.heroes.hero_illiana.upgrades.upg_sa2 = {
	damage_min = 75,
	damage_max = 105
}
b.heroes.hero_illiana.upgrades.upg_sb1 = {
	stun_duration = 4
}
b.heroes.hero_illiana.upgrades.upg_sb2 = {
	stun_duration = 6
}
b.heroes.hero_illiana.upgrades.upg_sc1 = {
	damage_min = 62,
	damage_max = 88
}
b.heroes.hero_illiana.upgrades.upg_sc2 = {
	damage_min = 92,
	damage_max = 134
}
b.heroes.hero_illiana.upgrades.upg_a = {
	range_inc_factor = 1.1
}
b.heroes.hero_illiana.upgrades.upg_a.s_range_factor = sub_one(b.heroes.hero_illiana.upgrades.upg_a.range_inc_factor)
b.heroes.hero_illiana.upgrades.upg_b = {
	hp_ptg = 0.2
}
b.heroes.hero_illiana.upgrades.upg_b.s_hp_ptg = b.heroes.hero_illiana.upgrades.upg_b.hp_ptg
b.heroes.hero_illiana.upgrades.upg_c = {
	skills_cd_red_factor = 0.1
}
b.heroes.hero_illiana.upgrades.upg_c.skill_red_factor = b.heroes.hero_illiana.upgrades.upg_c.skills_cd_red_factor
b.heroes.hero_illiana.upgrades.upg_d = {
	dmg_factor = 1.1
}
b.heroes.hero_illiana.upgrades.upg_d.s_dmg_factor = sub_one(b.heroes.hero_illiana.upgrades.upg_d.dmg_factor)
b.heroes.hero_illiana.upgrades.upg_e = {
	dmg_factor = 1.15
}
b.heroes.hero_illiana.upgrades.upg_e.s_dmg_factor = sub_one(b.heroes.hero_illiana.upgrades.upg_e.dmg_factor)
b.enemies = {
	shadow_order = {}
}
b.enemies.shadow_order.bandit = {
	gold = 5,
	hp = {
		40,
		40,
		50,
		100
	},
	armor = 0,
	magic_armor = 0,
	speed = 40,
	basic_attack = {}
}
b.enemies.shadow_order.bandit.basic_attack.cooldown = 1
b.enemies.shadow_order.bandit.basic_attack.damage_min = 1
b.enemies.shadow_order.bandit.basic_attack.damage_max = 2
b.enemies.shadow_order.bandit.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.demon_spawn = {
	gold = 6,
	hp = {
		210,
		240,
		300,
		330
	},
	armor = 0,
	magic_armor = 0.4,
	speed = 40,
	basic_attack = {}
}
b.enemies.shadow_order.demon_spawn.basic_attack.cooldown = 1.2
b.enemies.shadow_order.demon_spawn.basic_attack.damage_min = 6
b.enemies.shadow_order.demon_spawn.basic_attack.damage_max = 10
b.enemies.shadow_order.demon_spawn.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.demon_spawn.death_explosion = {
	damage_min = 20,
	damage_max = 25,
	damage_radius = 45,
	damage_type = DAMAGE_EXPLOSION
}
b.enemies.shadow_order.demon_flareon = {
	gold = 8,
	hp = {
		230,
		280,
		330,
		360
	},
	armor = 0,
	magic_armor = 0.4,
	speed = 40,
	basic_attack = {}
}
b.enemies.shadow_order.demon_flareon.basic_attack.cooldown = 1.3
b.enemies.shadow_order.demon_flareon.basic_attack.damage_min = 10
b.enemies.shadow_order.demon_flareon.basic_attack.damage_max = 15
b.enemies.shadow_order.demon_flareon.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.demon_flareon.ranged_attack = {
	cooldown = 1.5,
	max_range = 150,
	min_range = 60,
	damage_min = 10,
	damage_max = 16,
	damage_type = DAMAGE_TRUE,
	burn_duration = 3,
	burn_damage_min = 8,
	burn_damage_max = 12
}
b.enemies.shadow_order.demon_flareon.death_explosion = {
	damage_min = 30,
	damage_max = 40,
	damage_radius = 45,
	damage_type = DAMAGE_EXPLOSION
}
b.enemies.shadow_order.blackguard = {
	gold = 8,
	hp = {
		70,
		80,
		100,
		200
	},
	armor = 0.3,
	magic_armor = 0,
	speed = 40,
	basic_attack = {}
}
b.enemies.shadow_order.blackguard.basic_attack.cooldown = 1.25
b.enemies.shadow_order.blackguard.basic_attack.damage_min = 3
b.enemies.shadow_order.blackguard.basic_attack.damage_max = 5
b.enemies.shadow_order.blackguard.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.shadow_blades = {
	gold = 10,
	hp = {
		60,
		70,
		80,
		160
	},
	armor = 0,
	magic_armor = 0,
	speed = 64,
	basic_attack = {}
}
b.enemies.shadow_order.shadow_blades.basic_attack.cooldown = 0.8
b.enemies.shadow_order.shadow_blades.basic_attack.damage_min = 7
b.enemies.shadow_order.shadow_blades.basic_attack.damage_max = 11
b.enemies.shadow_order.shadow_blades.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.shadow_blades.smokebomb = {
	radius = 60,
	duration = {
		3,
		3,
		3,
		5
	},
	min_nodes_to_exit = 35,
	hp_threshold = 0.2
}
b.enemies.shadow_order.shadow_archer = {
	gold = 15,
	hp = {
		100,
		110,
		140,
		280
	},
	armor = 0,
	magic_armor = 0.3,
	speed = 40,
	basic_attack = {}
}
b.enemies.shadow_order.shadow_archer.basic_attack.cooldown = 1.5
b.enemies.shadow_order.shadow_archer.basic_attack.damage_min = 3
b.enemies.shadow_order.shadow_archer.basic_attack.damage_max = 4
b.enemies.shadow_order.shadow_archer.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.shadow_archer.ranged_attack = {
	cooldown = 1.5,
	max_range = 150,
	min_range = 60,
	damage_min = 10,
	damage_max = 16,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.shadow_order.crow = {
	gold = 2,
	hp = {
		20,
		20,
		25,
		40
	},
	armor = 0,
	magic_armor = 0,
	speed = 64
}
b.enemies.shadow_order.crowcaller = {
	gold = 40,
	hp = {
		250,
		300,
		350,
		750
	},
	armor = 0,
	magic_armor = 0.6,
	speed = 32,
	basic_attack = {}
}
b.enemies.shadow_order.crowcaller.basic_attack.cooldown = 1
b.enemies.shadow_order.crowcaller.basic_attack.damage_min = 8
b.enemies.shadow_order.crowcaller.basic_attack.damage_max = 12
b.enemies.shadow_order.crowcaller.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.crowcaller.crowcall = {
	cooldown = 6,
	spawn_count = {
		1,
		1,
		1,
		2
	},
	max_crows = 10,
	node_limit = 60
}
b.enemies.shadow_order.headhunter = {
	gold = 80,
	hp = {
		650,
		800,
		900,
		1800
	},
	armor = 0.5,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.shadow_order.headhunter.basic_attack.cooldown = 1.5
b.enemies.shadow_order.headhunter.basic_attack.damage_min = 24
b.enemies.shadow_order.headhunter.basic_attack.damage_max = 36
b.enemies.shadow_order.headhunter.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.shadow_order.headhunter.instakill = {
	hp_threshold = {
		0.25,
		0.25,
		0.25,
		0.4
	},
	cooldown = 6,
	chance = 1
}
b.enemies.orcs = {
	goblin = {}
}
b.enemies.orcs.goblin.gold = 3
b.enemies.orcs.goblin.hp = {
	20,
	20,
	30,
	75
}
b.enemies.orcs.goblin.armor = 0
b.enemies.orcs.goblin.magic_armor = 0
b.enemies.orcs.goblin.speed = 50
b.enemies.orcs.goblin.basic_attack = {
	cooldown = 1,
	damage_min = 2,
	damage_max = 3,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.orcs.orc_warrior = {
	gold = 15,
	hp = {
		160,
		180,
		200,
		400
	},
	armor = 0.3,
	magic_armor = 0,
	speed = 32,
	basic_attack = {}
}
b.enemies.orcs.orc_warrior.basic_attack.cooldown = 1.5
b.enemies.orcs.orc_warrior.basic_attack.damage_min = 9
b.enemies.orcs.orc_warrior.basic_attack.damage_max = 14
b.enemies.orcs.orc_warrior.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.orc_warrior.rage = {
	radius = 60,
	duration = 6,
	damage_factor = 2
}
b.enemies.orcs.orc_shaman = {
	gold = 12,
	hp = {
		80,
		100,
		120,
		250
	},
	armor = 0,
	magic_armor = 0.8,
	speed = 32,
	basic_attack = {}
}
b.enemies.orcs.orc_shaman.basic_attack.cooldown = 1.25
b.enemies.orcs.orc_shaman.basic_attack.damage_min = 4
b.enemies.orcs.orc_shaman.basic_attack.damage_max = 6
b.enemies.orcs.orc_shaman.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.orc_shaman.ranged_attack = {
	cooldown = 1.25,
	min_range = 60,
	max_range = 120,
	damage_min = 4,
	damage_max = 6,
	damage_type = DAMAGE_MAGICAL
}
b.enemies.orcs.orc_shaman.heal = {
	cooldown = 8,
	range = 100,
	duration = 1,
	heal_per_second_min = {
		60,
		60,
		60,
		135
	},
	heal_per_second_max = {
		80,
		80,
		80,
		180
	},
	min_targets = 2,
	max_target_hp = 0.7
}
b.enemies.orcs.wulf = {
	gold = 4,
	hp = {
		35,
		40,
		40,
		80
	},
	armor = 0,
	magic_armor = 0,
	speed = 90,
	basic_attack = {}
}
b.enemies.orcs.wulf.basic_attack.cooldown = 0.8
b.enemies.orcs.wulf.basic_attack.damage_min = 2
b.enemies.orcs.wulf.basic_attack.damage_max = 3
b.enemies.orcs.wulf.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.wulf.dodge_chance = {
	0.3,
	0.3,
	0.3,
	0.5
}
b.enemies.orcs.orc_wildling = {
	gold = 20,
	hp = {
		240,
		280,
		320,
		640
	},
	armor = 0.6,
	magic_armor = 0,
	speed = 32,
	basic_attack = {}
}
b.enemies.orcs.orc_wildling.basic_attack.cooldown = 1
b.enemies.orcs.orc_wildling.basic_attack.damage_min = 6
b.enemies.orcs.orc_wildling.basic_attack.damage_max = 10
b.enemies.orcs.orc_wildling.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.orc_wildling.worg_mode = {
	speed_mult = {
		2,
		2,
		2,
		2.1875
	},
	range = 100
}
b.enemies.orcs.worg = {
	gold = 10,
	hp = {
		100,
		120,
		140,
		280
	},
	armor = 0,
	magic_armor = 0.5,
	speed = 64,
	basic_attack = {}
}
b.enemies.orcs.worg.basic_attack.cooldown = 1.25
b.enemies.orcs.worg.basic_attack.damage_min = 10
b.enemies.orcs.worg.basic_attack.damage_max = 15
b.enemies.orcs.worg.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.worg.dodge_chance = {
	0.3,
	0.3,
	0.3,
	0.5
}
b.enemies.orcs.rider_goblin = {
	gold = 10,
	hp = {
		120,
		140,
		160,
		320
	},
	armor = 0,
	magic_armor = 0.5,
	speed = 64,
	basic_attack = {}
}
b.enemies.orcs.rider_goblin.basic_attack.cooldown = 1.25
b.enemies.orcs.rider_goblin.basic_attack.damage_min = 10
b.enemies.orcs.rider_goblin.basic_attack.damage_max = 15
b.enemies.orcs.rider_goblin.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.rider_goblin.spawn = {
	max_nodes_to_exit = 70,
	min_nodes_ahead = 15,
	max_nodes_ahead = 25
}
b.enemies.orcs.ogre = {
	gold = 120,
	hp = {
		1100,
		1300,
		1600,
		2800
	},
	armor = 0,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.orcs.ogre.basic_attack.cooldown = 2
b.enemies.orcs.ogre.basic_attack.damage_min = {
	38,
	38,
	38,
	64
}
b.enemies.orcs.ogre.basic_attack.damage_max = {
	58,
	58,
	58,
	104
}
b.enemies.orcs.ogre.basic_attack.damage_radius = 25
b.enemies.orcs.ogre.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.boss = {
	hp = {
		5600,
		7200,
		8000,
		13000
	},
	armor = 0,
	magic_armor = 0,
	speed_cart = 16,
	speed_cart_rage = 100,
	rage_hp = 0.7,
	nodes_to_enrage = 30,
	nodes_knockback = 30,
	speed = 16,
	basic_attack = {}
}
b.enemies.orcs.boss.basic_attack.cooldown = 1
b.enemies.orcs.boss.basic_attack.damage_min = 120
b.enemies.orcs.boss.basic_attack.damage_max = 160
b.enemies.orcs.boss.basic_attack.damage_radius = 75
b.enemies.orcs.boss.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.orcs.boss.shout = {
	cooldown = 15,
	radius = 1200,
	min_targets = 3,
	damage_factor = 2,
	speed_mult = 1.25,
	buff_duration = 5,
	stun_duration = 2
}
b.enemies.deep_trolls = {
	troll_warrior = {}
}
b.enemies.deep_trolls.troll_warrior.gold = 8
b.enemies.deep_trolls.troll_warrior.hp = {
	90,
	100,
	120,
	180
}
b.enemies.deep_trolls.troll_warrior.armor = 0
b.enemies.deep_trolls.troll_warrior.magic_armor = 0
b.enemies.deep_trolls.troll_warrior.speed = 40
b.enemies.deep_trolls.troll_warrior.lives_cost = 1
b.enemies.deep_trolls.troll_warrior.basic_attack = {
	cooldown = 1,
	damage_min = 6,
	damage_max = 9,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.deep_trolls.troll_warrior.regeneration = {
	cooldown = fts(15),
	health = 3
}
b.enemies.deep_trolls.troll_champion = {
	gold = 30,
	hp = {
		340,
		380,
		450,
		675
	},
	armor = 0.3,
	magic_armor = 0,
	speed = 32,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.deep_trolls.troll_champion.basic_attack.cooldown = 1.5
b.enemies.deep_trolls.troll_champion.basic_attack.damage_min = 15
b.enemies.deep_trolls.troll_champion.basic_attack.damage_max = 24
b.enemies.deep_trolls.troll_champion.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.troll_champion.ranged_attack = {
	cooldown = 8,
	min_range = 30,
	max_range = 100,
	damage_min = 15,
	damage_max = 24,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.deep_trolls.troll_champion.regeneration = {
	cooldown = fts(15),
	health = 4
}
b.enemies.deep_trolls.troll_glider = {
	gold = 4,
	hp = {
		60,
		70,
		80,
		90
	},
	armor = 0,
	magic_armor = 0,
	speed = 50,
	lives_cost = 1,
	regeneration = {}
}
b.enemies.deep_trolls.troll_glider.regeneration.cooldown = fts(15)
b.enemies.deep_trolls.troll_glider.regeneration.health = 0
b.enemies.deep_trolls.troll_glider.suicide = {
	damage_min = 1000,
	damage_max = 1000,
	damage_type = DAMAGE_INSTAKILL
}
b.enemies.deep_trolls.troll_crusher = {
	gold = 130,
	hp = {
		1150,
		1300,
		1600,
		2400
	},
	armor = 0.5,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.deep_trolls.troll_crusher.basic_attack.cooldown = 2
b.enemies.deep_trolls.troll_crusher.basic_attack.damage_min = 40
b.enemies.deep_trolls.troll_crusher.basic_attack.damage_max = 60
b.enemies.deep_trolls.troll_crusher.basic_attack.damage_radius = 50
b.enemies.deep_trolls.troll_crusher.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.troll_crusher.pound_attack = {
	cooldown = {
		30,
		30,
		30,
		20
	},
	damage_min = 40,
	damage_max = 60,
	damage_type = DAMAGE_PHYSICAL,
	damage_radius = 70,
	stun = {}
}
b.enemies.deep_trolls.troll_crusher.pound_attack.stun.duration = 6
b.enemies.deep_trolls.troll_crusher.pound_attack.stun.range = 150
b.enemies.deep_trolls.troll_crusher.regeneration = {
	cooldown = fts(15),
	health = 10
}
b.enemies.deep_trolls.frost_icecaller = {
	gold = 80,
	hp = {
		700,
		800,
		900,
		1350
	},
	armor = 0,
	magic_armor = 0.8,
	speed = 32,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.deep_trolls.frost_icecaller.basic_attack.cooldown = 1.5
b.enemies.deep_trolls.frost_icecaller.basic_attack.damage_min = 6
b.enemies.deep_trolls.frost_icecaller.basic_attack.damage_max = 14
b.enemies.deep_trolls.frost_icecaller.basic_attack.damage_radius = 50
b.enemies.deep_trolls.frost_icecaller.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.frost_icecaller.ranged_attack = {
	cooldown = 1.5,
	min_range = 30,
	max_range = 150,
	damage_min = 28,
	damage_max = 43,
	damage_type = DAMAGE_MAGICAL
}
b.enemies.deep_trolls.frost_icecaller.death_explosion = {
	slow_factor = 0.5,
	slow_duration = 1,
	aura_duration = 16,
	aura_cycle_time = 0.1,
	range = 55
}
b.enemies.deep_trolls.frost_icecaller.icicles_attack = {
	cooldown = {
		15,
		15,
		15,
		10
	},
	rows = 4,
	row_spread = 5,
	row_anticipation = 5,
	amount_per_row = 3,
	spread = 5,
	y_offset = -8,
	scale_min = 0.9,
	scale_max = 1,
	duration = 0.7,
	damage_min = 20,
	damage_max = 40,
	damage_radius = 25,
	damage_type = DAMAGE_MAGICAL,
	min_range = 50,
	range = 150
}
b.enemies.deep_trolls.troll_pathfinder = {
	gold = 10,
	hp = {
		90,
		100,
		120,
		180
	},
	armor = 0.3,
	magic_armor = 0,
	speed = 50,
	slide_speed_factor = 2,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.deep_trolls.troll_pathfinder.basic_attack.cooldown = 1
b.enemies.deep_trolls.troll_pathfinder.basic_attack.damage_min = 6
b.enemies.deep_trolls.troll_pathfinder.basic_attack.damage_max = 9
b.enemies.deep_trolls.troll_pathfinder.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.troll_pathfinder.regeneration = {
	cooldown = fts(15),
	health = 3
}
b.enemies.deep_trolls.frost_baiter = {
	gold = 3,
	hp = {
		30,
		40,
		40,
		50
	},
	armor = 0,
	magic_armor = 0,
	speed = 64,
	ice_speed_factor = 1.33,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.deep_trolls.frost_baiter.basic_attack.cooldown = 1
b.enemies.deep_trolls.frost_baiter.basic_attack.damage_min = 3
b.enemies.deep_trolls.frost_baiter.basic_attack.damage_max = 4
b.enemies.deep_trolls.frost_baiter.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.frost_baiter.bait = {
	cooldown = 30,
	min_jump_distance = 20,
	max_jump_distance = 25,
	max_nodes_to_exit = 55
}
b.enemies.deep_trolls.frost_baiter.decoy = {
	gold = 0,
	hp = {
		30,
		40,
		40,
		50
	},
	armor = 0,
	magic_armor = 0,
	speed = 0,
	duration = 4
}
b.enemies.deep_trolls.frost_baiter.death_stun = {
	duration = 1,
	range = 50
}
b.enemies.deep_trolls.frost_brute = {
	gold = 260,
	hp = {
		1800,
		2200,
		2500,
		3400
	},
	armor = 1,
	magic_armor = 0.6,
	speed = 24,
	lives_cost = 2,
	ice_speed_factor = 1.2,
	basic_attack = {}
}
b.enemies.deep_trolls.frost_brute.basic_attack.cooldown = 2
b.enemies.deep_trolls.frost_brute.basic_attack.damage_min = 30
b.enemies.deep_trolls.frost_brute.basic_attack.damage_max = 46
b.enemies.deep_trolls.frost_brute.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.frost_brute.death_explosion = {
	slow_factor = 0.5,
	slow_duration = 1,
	aura_duration = 16,
	aura_cycle_time = 0.1,
	range = 70
}
b.enemies.deep_trolls.frost_brute.cold_breath = {
	cooldown = {
		35,
		35,
		35,
		16
	},
	damage_min = 20,
	damage_max = 30,
	damage_every = 0.5,
	damage_type = DAMAGE_PHYSICAL,
	min_targets = 1,
	trigger_radius = 110,
	radius = 110,
	freeze_duration = 6
}
b.enemies.deep_trolls.troll_chieftain = {
	gold = 60,
	hp = {
		1000,
		1200,
		1500,
		2100
	},
	armor = 0,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.deep_trolls.troll_chieftain.basic_attack.cooldown = 2
b.enemies.deep_trolls.troll_chieftain.basic_attack.damage_min = 40
b.enemies.deep_trolls.troll_chieftain.basic_attack.damage_max = 60
b.enemies.deep_trolls.troll_chieftain.basic_attack.damage_radius = 50
b.enemies.deep_trolls.troll_chieftain.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.troll_chieftain.drums = {
	cooldown = {
		20,
		20,
		20,
		14
	},
	radius = 100,
	min_targets = 3,
	speed_factor = 1.33,
	dmg_factor = 1.33,
	duration = 8
}
b.enemies.deep_trolls.troll_chieftain.regeneration = {
	cooldown = fts(15),
	health = 8
}
b.enemies.deep_trolls.troll_boss = {
	hp = {
		9000,
		10500,
		13000,
		17000
	},
	armor = 0,
	shielded_armor = 0.98,
	magic_armor = 0,
	shielded_magic_armor = 0.98,
	speed = 13,
	sunray_stun = 5,
	offstage_wait_min = 4,
	offstage_wait_max = 6,
	turn_off_wave_wait = 0.5,
	basic_attack = {}
}
b.enemies.deep_trolls.troll_boss.basic_attack.cooldown = 1
b.enemies.deep_trolls.troll_boss.basic_attack.damage_min = 150
b.enemies.deep_trolls.troll_boss.basic_attack.damage_max = 250
b.enemies.deep_trolls.troll_boss.basic_attack.damage_radius = 75
b.enemies.deep_trolls.troll_boss.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.deep_trolls.troll_boss.jump_progression = {
	left = {
		8,
		25,
		28,
		31,
		34,
		37
	},
	right = {
		26,
		29,
		32,
		35,
		38,
		38
	}
}
b.enemies.jt_boss = {
	hp = {
		6700,
		8400,
		9500,
		11000
	},
	armor = 0,
	magic_armor = 0,
	speed = 12,
	basic_attack = {}
}
b.enemies.jt_boss.basic_attack.cooldown = 1
b.enemies.jt_boss.basic_attack.damage_min = 150
b.enemies.jt_boss.basic_attack.damage_max = 200
b.enemies.jt_boss.basic_attack.damage_radius = 75
b.enemies.jt_boss.basic_attack.damage_type = DAMAGE_EAT
b.enemies.jt_boss.tower_freeze = {
	cooldown = 20,
	tired_time = 3,
	range = 400,
	duration = 15,
	targets = 4,
	taps_to_thaw = 5,
	random_icicles = 5,
	allies_icicles = 2
}
b.enemies.spiders = {
	spiderling = {}
}
b.enemies.spiders.spiderling.gold = 2
b.enemies.spiders.spiderling.hp = {
	15,
	20,
	20,
	30
}
b.enemies.spiders.spiderling.armor = 0
b.enemies.spiders.spiderling.magic_armor = 0.2
b.enemies.spiders.spiderling.speed = 80
b.enemies.spiders.spiderling.lives_cost = 1
b.enemies.spiders.spiderling.basic_attack = {
	cooldown = 0.8,
	damage_min = 2,
	damage_max = 3,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.spiders.giant_spider = {
	gold = 18,
	hp = {
		140,
		180,
		200,
		300
	},
	armor = 0,
	magic_armor = 0.2,
	speed = 36,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.spiders.giant_spider.basic_attack.cooldown = 1.5
b.enemies.spiders.giant_spider.basic_attack.damage_min = 14
b.enemies.spiders.giant_spider.basic_attack.damage_max = 21
b.enemies.spiders.giant_spider.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.spiders.spider_matriarch = {
	gold = 100,
	hp = {
		650,
		750,
		900,
		1350
	},
	armor = 0,
	magic_armor = 0.6,
	speed = 32,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.spiders.spider_matriarch.basic_attack.cooldown = 1.5
b.enemies.spiders.spider_matriarch.basic_attack.damage_min = 17
b.enemies.spiders.spider_matriarch.basic_attack.damage_max = 26
b.enemies.spiders.spider_matriarch.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.spiders.spider_matriarch.egg_spawn = {
	max_nodes_to_exit = 30,
	cooldown = 6,
	max_eggs = 4,
	time_to_spawn = 5,
	spawn_count = {
		3,
		3,
		3,
		4
	}
}
b.enemies.spiders.leaper_spider = {
	gold = 12,
	hp = {
		85,
		100,
		120,
		180
	},
	armor = 0.25,
	magic_armor = 0,
	speed = 40,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.spiders.leaper_spider.basic_attack.cooldown = 1
b.enemies.spiders.leaper_spider.basic_attack.damage_min = 14
b.enemies.spiders.leaper_spider.basic_attack.damage_max = 21
b.enemies.spiders.leaper_spider.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.spiders.leaper_spider.leap_attack = {
	cooldown = 3,
	min_nodes = 10,
	max_nodes = 20,
	max_nodes_to_exit = 30
}
b.enemies.spiders.leaper_spider.poison = {
	duration = 3,
	cycle_time = 0.25,
	damage = 2,
	damage_type = DAMAGE_TRUE
}
b.enemies.spiders.son_of_sarelgaz = {
	gold = 80,
	hp = {
		850,
		1000,
		1200,
		1800
	},
	armor = 0.4,
	magic_armor = 0.4,
	speed = 30,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.spiders.son_of_sarelgaz.basic_attack.cooldown = 1.5
b.enemies.spiders.son_of_sarelgaz.basic_attack.damage_min = 30
b.enemies.spiders.son_of_sarelgaz.basic_attack.damage_max = 45
b.enemies.spiders.son_of_sarelgaz.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.spiders.son_of_sarelgaz.stun_attack = {
	duration = 3,
	cooldown = 8
}
b.enemies.spiders.boss_spider = {
	hp = {
		7700,
		9000,
		11000,
		12000
	},
	armor = 0,
	magic_armor = 0.76,
	speed = 15,
	phases_health_thresholds = {
		0.75,
		0.45
	},
	basic_attack = {}
}
b.enemies.spiders.boss_spider.basic_attack.cooldown = 4
b.enemies.spiders.boss_spider.basic_attack.damage_min = 150
b.enemies.spiders.boss_spider.basic_attack.damage_max = 200
b.enemies.spiders.boss_spider.basic_attack.damage_radius = 45
b.enemies.spiders.boss_spider.basic_attack.damage_type = DAMAGE_EAT
b.enemies.dark_army = {
	skeleton = {}
}
b.enemies.dark_army.skeleton.gold = 2
b.enemies.dark_army.skeleton.hp = {
	70,
	80,
	100,
	125
}
b.enemies.dark_army.skeleton.armor = 0
b.enemies.dark_army.skeleton.magic_armor = 0
b.enemies.dark_army.skeleton.speed = 28
b.enemies.dark_army.skeleton.basic_attack = {
	cooldown = 1,
	damage_min = 4,
	damage_max = 7,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.dark_army.skeleton_big = {
	gold = 30,
	hp = {
		480,
		620,
		800,
		1000
	},
	lives_cost = 2,
	armor = 0,
	magic_armor = 0,
	speed = 24,
	basic_attack = {}
}
b.enemies.dark_army.skeleton_big.basic_attack.cooldown = 1.5
b.enemies.dark_army.skeleton_big.basic_attack.damage_min = 30
b.enemies.dark_army.skeleton_big.basic_attack.damage_max = 45
b.enemies.dark_army.skeleton_big.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.skeleton_goat = {
	gold = 5,
	hp = {
		60,
		100,
		100,
		120
	},
	lives_cost = 1,
	armor = 0,
	magic_armor = 0,
	speed = 64
}
b.enemies.dark_army.brigand = {
	gold = 20,
	hp = {
		250,
		280,
		350,
		450
	},
	armor = 0.4,
	magic_armor = 0,
	speed = 40,
	basic_attack = {}
}
b.enemies.dark_army.brigand.basic_attack.cooldown = 1
b.enemies.dark_army.brigand.basic_attack.damage_min = 9
b.enemies.dark_army.brigand.basic_attack.damage_max = 14
b.enemies.dark_army.brigand.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.brigand.bleed_strike = {
	cooldown = 10,
	damage_min = 9,
	damage_max = 14,
	damage_type = DAMAGE_PHYSICAL,
	bleed = {}
}
b.enemies.dark_army.brigand.bleed_strike.bleed.duration = 2
b.enemies.dark_army.brigand.bleed_strike.bleed.cycle_time = 0.25
b.enemies.dark_army.brigand.bleed_strike.bleed.damage_min = 3
b.enemies.dark_army.brigand.bleed_strike.bleed.damage_max = 3
b.enemies.dark_army.brigand.bleed_strike.bleed.damage_type = DAMAGE_TRUE
b.enemies.dark_army.rotten_tree = {
	gold = 60,
	hp = {
		1000,
		1100,
		1200,
		1500
	},
	armor = 0.5,
	magic_armor = 0,
	speed = 18,
	basic_attack = {}
}
b.enemies.dark_army.rotten_tree.basic_attack.cooldown = 1.5
b.enemies.dark_army.rotten_tree.basic_attack.damage_min = 30
b.enemies.dark_army.rotten_tree.basic_attack.damage_max = 45
b.enemies.dark_army.rotten_tree.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.dark_sapper = {
	gold = 30,
	hp = {
		600,
		600,
		720,
		900
	},
	armor = 0,
	magic_armor = 0,
	speed = 24,
	basic_attack = {}
}
b.enemies.dark_army.dark_sapper.basic_attack.cooldown = 1
b.enemies.dark_army.dark_sapper.basic_attack.damage_min = 20
b.enemies.dark_army.dark_sapper.basic_attack.damage_max = 30
b.enemies.dark_army.dark_sapper.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.dark_sapper.ranged_attack = {
	cooldown = 2,
	max_range = 170,
	min_range = 60,
	damage_min = 56,
	damage_max = 84,
	damage_radius = 70,
	damage_type = DAMAGE_EXPLOSION
}
b.enemies.dark_army.dark_sapper.death_explosion = {
	damage_min = 100,
	damage_max = 150,
	damage_radius = 60,
	damage_type = DAMAGE_EXPLOSION
}
b.enemies.dark_army.swamp_husk = {
	gold = 4,
	hp = {
		110,
		130,
		160,
		200
	},
	armor = 0.3,
	magic_armor = 0,
	speed = 24,
	basic_attack = {}
}
b.enemies.dark_army.swamp_husk.basic_attack.cooldown = 1.5
b.enemies.dark_army.swamp_husk.basic_attack.damage_min = 5
b.enemies.dark_army.swamp_husk.basic_attack.damage_max = 8
b.enemies.dark_army.swamp_husk.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.swamp_husk.poison = {
	duration = 2,
	cycle_time = 0.25,
	damage = 4,
	damage_type = DAMAGE_TRUE
}
b.enemies.dark_army.swamp_thing = {
	gold = 120,
	hp = {
		2000,
		2400,
		2800,
		3500
	},
	armor = 0,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.dark_army.swamp_thing.basic_attack.cooldown = 1.8
b.enemies.dark_army.swamp_thing.basic_attack.damage_min = 72
b.enemies.dark_army.swamp_thing.basic_attack.damage_max = 108
b.enemies.dark_army.swamp_thing.basic_attack.damage_radius = 40
b.enemies.dark_army.swamp_thing.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.swamp_thing.regeneration = {
	cooldown = fts(10),
	health = 4
}
b.enemies.dark_army.exalted_shadow_archer = {
	gold = 15,
	hp = {
		170,
		190,
		240,
		265
	},
	armor = 0,
	magic_armor = 0.3,
	speed = 40,
	basic_attack = {}
}
b.enemies.dark_army.exalted_shadow_archer.basic_attack.cooldown = 1
b.enemies.dark_army.exalted_shadow_archer.basic_attack.damage_min = 4
b.enemies.dark_army.exalted_shadow_archer.basic_attack.damage_max = 6
b.enemies.dark_army.exalted_shadow_archer.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.exalted_shadow_archer.ranged_attack = {
	shots = 3,
	cooldown = 2,
	max_range = 150,
	min_range = 60,
	damage_min = 10,
	damage_max = 15,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.dark_army.exalted_shadow_archer.cloud_of_crows = {
	speed = 64,
	nodes_to_explode = 56,
	spawn_count = 2
}
b.enemies.dark_army.exalted_shadow_blades = {
	gold = 10,
	hp = {
		110,
		120,
		150,
		170
	},
	armor = 0,
	magic_armor = 0,
	speed = 64,
	basic_attack = {}
}
b.enemies.dark_army.exalted_shadow_blades.basic_attack.cooldown = 0.8
b.enemies.dark_army.exalted_shadow_blades.basic_attack.damage_min = 12
b.enemies.dark_army.exalted_shadow_blades.basic_attack.damage_max = 18
b.enemies.dark_army.exalted_shadow_blades.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.exalted_shadow_blades.smokebomb = {
	radius = 120,
	amount_of_clouds = 20,
	duration = 3,
	min_nodes_to_exit = 35,
	hp_threshold = 0.3
}
b.enemies.dark_army.exalted_shadow_blades.cloud_of_crows = {
	speed = 64,
	nodes_to_explode = 25,
	spawn_count = 2
}
b.enemies.dark_army.exalted_crowcaller = {
	gold = 40,
	hp = {
		420,
		480,
		600,
		660
	},
	armor = 0,
	magic_armor = 0.8,
	speed = 32,
	basic_attack = {}
}
b.enemies.dark_army.exalted_crowcaller.basic_attack.cooldown = 1
b.enemies.dark_army.exalted_crowcaller.basic_attack.damage_min = 10
b.enemies.dark_army.exalted_crowcaller.basic_attack.damage_max = 15
b.enemies.dark_army.exalted_crowcaller.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.exalted_crowcaller.crowcall = {
	cooldown = 6,
	spawn_count = 2,
	max_crows = 10,
	node_limit = 60
}
b.enemies.dark_army.exalted_crow = {
	gold = 2,
	hp = {
		20,
		30,
		35,
		40
	},
	armor = 0,
	magic_armor = 0,
	speed = 70
}
b.enemies.dark_army.gargoyle = {
	gold = 8,
	hp = {
		105,
		120,
		150,
		165
	},
	armor = 0,
	magic_armor = 0,
	speed = 50,
	stone_form = {}
}
b.enemies.dark_army.gargoyle.stone_form.trigger_hp = 60
b.enemies.dark_army.gargoyle.stone_form.max_uses = 1
b.enemies.dark_army.gargoyle.stone_form.heal_per_second_min = 30
b.enemies.dark_army.gargoyle.stone_form.heal_per_second_max = 30
b.enemies.dark_army.gargoyle.stone_form.heal_every = 0.25
b.enemies.dark_army.gargoyle.stone_form.duration = {
	4,
	4,
	4,
	6
}
b.enemies.dark_army.gargoyle.stone_form.armor = 0
b.enemies.dark_army.gargoyle.stone_form.magic_armor = 0
b.enemies.dark_army.tainted_wolf = {
	gold = 12,
	hp = {
		180,
		225,
		250,
		315
	},
	armor = 0,
	magic_armor = 0.5,
	speed = 64,
	basic_attack = {}
}
b.enemies.dark_army.tainted_wolf.basic_attack.cooldown = 1.25
b.enemies.dark_army.tainted_wolf.basic_attack.damage_min = 16
b.enemies.dark_army.tainted_wolf.basic_attack.damage_max = 24
b.enemies.dark_army.tainted_wolf.basic_attack.damage_type = DAMAGE_MAGICAL
b.enemies.dark_army.tainted_wolf.dodge_chance = {
	0.4,
	0.4,
	0.4,
	0.55
}
b.enemies.dark_army.dark_disciple = {
	gold = 30,
	hp = {
		350,
		400,
		500,
		625
	},
	armor = 0,
	magic_armor = 0.9,
	speed = 20,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.dark_army.dark_disciple.basic_attack.cooldown = 1.5
b.enemies.dark_army.dark_disciple.basic_attack.damage_min = 10
b.enemies.dark_army.dark_disciple.basic_attack.damage_max = 16
b.enemies.dark_army.dark_disciple.basic_attack.damage_radius = 50
b.enemies.dark_army.dark_disciple.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.dark_disciple.ranged_attack = {
	cooldown = 2,
	min_range = 30,
	max_range = 120,
	damage_min = 36,
	damage_max = 68,
	damage_type = DAMAGE_MAGICAL
}
b.enemies.dark_army.dark_disciple.block_tower_attack = {
	cooldown = 2,
	min_range = 0,
	max_range = {
		240,
		240,
		240,
		300
	},
	tether_range = {
		240,
		240,
		240,
		300
	}
}
b.enemies.dark_army.dark_knight = {
	gold = 60,
	hp = {
		700,
		860,
		960,
		1200
	},
	armor = 0.8,
	magic_armor = 0,
	speed = 28,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.dark_army.dark_knight.basic_attack.cooldown = 1.5
b.enemies.dark_army.dark_knight.basic_attack.damage_min = 30
b.enemies.dark_army.dark_knight.basic_attack.damage_max = 46
b.enemies.dark_army.dark_knight.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.dark_knight.kills_to_transform = 1000
b.enemies.dark_army.dark_slayer = {
	gold = 160,
	hp = {
		1200,
		1440,
		1600,
		2000
	},
	armor = 1,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.dark_army.dark_slayer.basic_attack.cooldown = 2
b.enemies.dark_army.dark_slayer.basic_attack.damage_min = 35
b.enemies.dark_army.dark_slayer.basic_attack.damage_max = 52
b.enemies.dark_army.dark_slayer.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.dark_slayer.instakill_cooldown = 10
b.enemies.dark_army.dark_slayer.instakill_chance = {
	0.3,
	0.3,
	0.3,
	0.4
}
b.enemies.dark_army.dark_slayer.spiked_armor = 0.3
b.enemies.dark_army.death_rider = {
	gold = 70,
	hp = 800,
	armor = 0,
	magic_armor = 0,
	speed = 52,
	lives_cost = 1,
	plague_aura = {}
}
b.enemies.dark_army.death_rider.plague_aura.radius = 50
b.enemies.dark_army.death_rider.plague_aura.cycle_time = 0.25
b.enemies.dark_army.death_rider.plague_aura.damage_min = 8
b.enemies.dark_army.death_rider.plague_aura.damage_max = 16
b.enemies.dark_army.death_rider.plague_aura.damage_type = DAMAGE_MAGICAL
b.enemies.dark_army.death_rider.death_sliding = {
	speed = 46,
	slide_speed_factor = 2
}
b.enemies.dark_army.death_rider.gallop = {
	cooldown = 10,
	range = 70,
	speed_mult = 1.923,
	duration = 1.8
}
b.enemies.dark_army.necromancer = {
	gold = 50,
	hp = {
		450,
		500,
		600,
		800
	},
	armor = 0,
	magic_armor = 0.6,
	speed = 20,
	lives_cost = 1,
	basic_attack = {}
}
b.enemies.dark_army.necromancer.basic_attack.cooldown = 1.5
b.enemies.dark_army.necromancer.basic_attack.damage_min = 12
b.enemies.dark_army.necromancer.basic_attack.damage_max = 18
b.enemies.dark_army.necromancer.basic_attack.damage_radius = 50
b.enemies.dark_army.necromancer.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.dark_army.necromancer.custom_attack = {
	cooldown = 2.5,
	min_range = 30,
	max_range = 120,
	damage_min = 40,
	damage_max = 60,
	damage_type = DAMAGE_MAGICAL,
	duration = 0.5,
	lifesteal = 0.25
}
b.enemies.dark_army.necromancer.spawn_cooldown = 7
b.enemies.dark_army.necromancer.spawn_first_cooldown = 2
b.enemies.dark_army.necromancer.spawn_max_count = {
	4,
	5,
	5,
	6
}
b.enemies.dark_army.necromancer.max_skeleton_count = 20
b.enemies.dark_army.necromancer.summon_skeleton_node_limit = 60
b.enemies.dark_army.dark_construct = {
	gold = 200,
	hp = {
		1960,
		2240,
		2800,
		3080
	},
	armor = 0,
	magic_armor = 0,
	speed = 24,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.dark_army.dark_construct.basic_attack.cooldown = 2
b.enemies.dark_army.dark_construct.basic_attack.damage_min = 48
b.enemies.dark_army.dark_construct.basic_attack.damage_max = 72
b.enemies.dark_army.dark_construct.basic_attack.damage_radius = 80
b.enemies.dark_army.dark_construct.basic_attack.damage_type = DAMAGE_MAGICAL
b.enemies.dark_army.dark_construct.spawn = {
	spawn_count = 3,
	min_nodes_ahead = 10,
	max_nodes_ahead = 25,
	max_nodes_to_exit = 70
}
b.enemies.dark_army.darkling = {
	gold = 0,
	hp = 80,
	armor = 0,
	magic_armor = 0,
	speed = 64,
	lives_cost = 1,
	roll = {}
}
b.enemies.dark_army.darkling.roll.cooldown = 3
b.enemies.dark_army.darkling.roll.movement_speed = 120
b.enemies.dark_army.darkling.roll.duration = 1
b.enemies.dark_army.darkling.roll.range = 60
b.enemies.lord_blackburn_boss = {
	hp = {
		9000,
		11000,
		12000,
		14000
	},
	armor = {
		0.5,
		0.6,
		0.6,
		0.74
	},
	magic_armor = 0,
	speed = 12,
	start_path = 1,
	start_node = 50,
	basic_attack = {}
}
b.enemies.lord_blackburn_boss.basic_attack.cooldown = 1.5
b.enemies.lord_blackburn_boss.basic_attack.damage_min = 175
b.enemies.lord_blackburn_boss.basic_attack.damage_max = 225
b.enemies.lord_blackburn_boss.basic_attack.damage_radius = 75
b.enemies.lord_blackburn_boss.basic_attack.damage_type = DAMAGE_TRUE
b.enemies.lord_blackburn_boss.tower_block = {
	cooldown = 18,
	range = 250,
	duration = 4,
	targets = 4,
	damage_min = 175,
	damage_max = 225,
	damage_radius = 100,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.demons = {
	demon_imp = {}
}
b.enemies.demons.demon_imp.gold = 5
b.enemies.demons.demon_imp.hp = {
	180,
	200,
	250,
	280
}
b.enemies.demons.demon_imp.armor = 0
b.enemies.demons.demon_imp.magic_armor = 0.25
b.enemies.demons.demon_imp.speed = 60
b.enemies.demons.demon_hound = {
	gold = 6,
	hp = {
		245,
		350,
		450,
		500
	},
	armor = 0,
	magic_armor = 0.5,
	speed = 60,
	basic_attack = {}
}
b.enemies.demons.demon_hound.basic_attack.cooldown = 1
b.enemies.demons.demon_hound.basic_attack.damage_min = 21
b.enemies.demons.demon_hound.basic_attack.damage_max = 39
b.enemies.demons.demon_hound.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.demons.demon_hound.dodge_chance = 0.3
b.enemies.demons.demon_hound.death_explosion = {
	damage_min = 50,
	damage_max = 70,
	damage_radius = 45,
	damage_type = DAMAGE_EXPLOSION
}
b.enemies.demons.demon_lord = {
	gold = 20,
	hp = {
		910,
		1250,
		1350,
		1500
	},
	armor = 0,
	magic_armor = 0.8,
	speed = 32,
	basic_attack = {}
}
b.enemies.demons.demon_lord.basic_attack.cooldown = 1.5
b.enemies.demons.demon_lord.basic_attack.damage_min = 35
b.enemies.demons.demon_lord.basic_attack.damage_max = 65
b.enemies.demons.demon_lord.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.demons.demon_lord.shield = {
	range = 180,
	cooldown = 6,
	cast_time = fts(15),
	max_count = 4,
	ignore_hits = 4
}
b.enemies.demons.demon_lord.death_explosion = {
	damage_min = 90,
	damage_max = 120,
	damage_radius = 60,
	damage_type = DAMAGE_PHYSICAL
}
b.enemies.demons.magma_elemental = {
	gold = 110,
	hp = {
		2000,
		2500,
		2850,
		3200
	},
	armor = 0.8,
	magic_armor = 0,
	speed = 20,
	lives_cost = 2,
	basic_attack = {}
}
b.enemies.demons.magma_elemental.basic_attack.cooldown = 2.5
b.enemies.demons.magma_elemental.basic_attack.damage_min = 70
b.enemies.demons.magma_elemental.basic_attack.damage_max = 100
b.enemies.demons.magma_elemental.basic_attack.damage_type = DAMAGE_PHYSICAL
b.enemies.demons.magma_elemental.basic_attack.damage_radius = 50
b.enemies.demons.magma_elemental.basic_attack.count = 6
b.enemies.demons.magma_elemental.basic_attack.burn_duration = 3
b.enemies.demons.magma_elemental.basic_attack.burn_damage_min = 8
b.enemies.demons.magma_elemental.basic_attack.burn_damage_max = 12
b.towers = {
	common = {},
	archers = {}
}
b.towers.archers.price = {
	70,
	100,
	150,
	230
}
b.towers.archers.stats = {
	damage = 2,
	range = 5.5,
	cooldown = 9.5
}
b.towers.archers.basic_attack = {
	damage_min = {
		4,
		9,
		13,
		16
	},
	damage_max = {
		6,
		13,
		18,
		26
	},
	cooldown = {
		1,
		0.9,
		0.7,
		0.6
	},
	range = {
		165,
		180,
		200,
		220
	},
	damage_type = DAMAGE_PHYSICAL
}
b.towers.archers.skill_a = {
	price = {
		150,
		150,
		150
	},
	xp_gain = 15,
	cooldown = 15,
	damage_min = {
		16,
		20,
		24
	},
	damage_max = {
		24,
		30,
		36
	},
	damage_type = DAMAGE_PHYSICAL,
	stun_duration = {
		2,
		4,
		6
	},
	targets = 2
}
b.towers.archers.skill_b = {
	price = {
		120,
		120,
		120
	},
	xp_gain = 20,
	radius = 220,
	range_factor = {
		1.15,
		1.25,
		1.35
	}
}
b.towers.archers.skill_b.s_range_factor = {
	sub_one(b.towers.archers.skill_b.range_factor[1]),
	sub_one(b.towers.archers.skill_b.range_factor[2]),
	sub_one(b.towers.archers.skill_b.range_factor[3])
}
b.towers.archers.skill_c = {
	price = {
		200,
		200,
		200
	},
	xp_gain = 10,
	cooldown = 12,
	duration = {
		5,
		6,
		7
	},
	weak_factor = {
		1.3,
		1.5,
		1.75
	},
	boss_weak_factor = {
		1.15,
		1.25,
		1.35
	}
}
b.towers.archers.skill_c.s_weak_factor = {
	sub_one(b.towers.archers.skill_c.weak_factor[1]),
	sub_one(b.towers.archers.skill_c.weak_factor[2]),
	sub_one(b.towers.archers.skill_c.weak_factor[3])
}
b.towers.archers.skill_c.range = 200
b.towers.archers.skill_c.min_hp = 50
b.towers.archers.ultimate = {
	xp_gain = 30,
	cooldown = 36,
	duration = 6,
	attack_cd = 0.3,
	min_targets = 1,
	min_hp = 800
}
b.towers.knights = {
	price = {
		70,
		110,
		160,
		220
	},
	stats = {}
}
b.towers.knights.stats.damage = 1
b.towers.knights.stats.hp = 6
b.towers.knights.stats.armor = 4.5
b.towers.knights.rally_range = 150
b.towers.knights.max_soldiers = 3
b.towers.knights.soldier = {
	armor = {
		0.1,
		0.2,
		0.3,
		0.4
	},
	dead_lifetime = 12,
	hp = {
		40,
		80,
		130,
		200
	},
	regen_hp = {
		3,
		6,
		10,
		13
	},
	speed = 75,
	basic_attack = {}
}
b.towers.knights.soldier.basic_attack.damage_min = {
	2,
	3,
	6,
	9
}
b.towers.knights.soldier.basic_attack.damage_max = {
	4,
	5,
	10,
	13
}
b.towers.knights.soldier.basic_attack.cooldown = 1
b.towers.knights.soldier.basic_attack.range = 70
b.towers.knights.skill_a = {
	price = {
		120,
		120,
		120
	},
	xp_gain = 20,
	armor_inc_per_hero = {
		0.05,
		0.1,
		0.15
	},
	radius = 110
}
b.towers.knights.skill_b = {
	price = {
		180,
		180,
		180
	},
	xp_gain = 20,
	cooldown = 15,
	hp_ptg = {
		0.25,
		0.4,
		0.6
	}
}
b.towers.knights.skill_c = {
	price = {
		150,
		100,
		100
	},
	xp_gain = 20,
	cd_mult = {
		0.8,
		0.6,
		0.4
	},
	s_cd_mult = {
		0.2,
		0.4,
		0.6
	},
	duration = 8,
	radius = 100
}
b.towers.knights.ultimate = {
	xp_gain = 35,
	cooldown = 30,
	hp_trigger = 0.2,
	duration = 5
}
b.towers.wizard = {
	shared_min_cooldown = 2,
	price = {
		100,
		150,
		210,
		280
	},
	stats = {}
}
b.towers.wizard.stats.damage = 9.5
b.towers.wizard.stats.range = 4
b.towers.wizard.stats.cooldown = 7
b.towers.wizard.basic_attack = {
	damage_min = {
		6,
		14,
		24,
		36
	},
	damage_max = {
		9,
		24,
		43,
		66
	},
	cooldown = 2,
	range = {
		160,
		170,
		180,
		190
	},
	damage_type = DAMAGE_MAGICAL
}
b.towers.wizard.skill_a = {
	price = {
		120,
		120,
		120
	},
	damage_min = {
		40,
		100,
		160
	},
	damage_max = {
		40,
		100,
		160
	},
	s_damage = {
		40,
		100,
		160
	},
	cooldown = {
		20,
		20,
		20
	},
	range = {
		180,
		180,
		180
	},
	damage_radius = 60,
	burn = {}
}
b.towers.wizard.skill_a.burn.duration = 4
b.towers.wizard.skill_a.burn.damage = {
	2,
	3,
	4
}
b.towers.wizard.skill_a.burn.damage_every = 0.25
b.towers.wizard.skill_a.burn.s_damage = {
	32,
	48,
	64
}
b.towers.wizard.skill_b = {
	price = {
		200,
		160,
		160
	},
	enemy_check_range = 300,
	cooldown = {
		25,
		25,
		25
	},
	damage_factor = {
		1.5,
		1.75,
		2
	},
	s_damage_factor = {
		0.5,
		0.75,
		1
	},
	duration = {
		8,
		10,
		12
	}
}
b.towers.wizard.skill_c = {
	price = {
		160,
		160,
		160
	},
	hit_min_damage = 50,
	hit_max_damage = 50,
	cooldown = {
		25,
		25,
		25
	},
	book = {}
}
b.towers.wizard.skill_c.book.range = 140
b.towers.wizard.skill_c.book.min_damage = {
	34,
	52,
	62
}
b.towers.wizard.skill_c.book.max_damage = {
	60,
	92,
	108
}
b.towers.wizard.skill_c.book.bullet_count = {
	3,
	5,
	8
}
b.towers.wizard.ultimate = {
	damage = 620,
	cooldown = 36,
	range = {
		180,
		180,
		180,
		180
	},
	stun_duration = 1,
	damage_type = DAMAGE_MAGICAL,
	stun_range = 20
}
b.towers.catapult = {
	shared_min_cooldown = 3,
	price = {
		110,
		170,
		240,
		310
	},
	stats = {}
}
b.towers.catapult.stats.damage = 9
b.towers.catapult.stats.cooldown = 1.5
b.towers.catapult.stats.range = 9
b.towers.catapult.basic_attack = {
	damage_min = {
		12,
		30,
		52,
		80
	},
	damage_max = {
		18,
		44,
		78,
		120
	},
	damage_radius = 60,
	damage_type = DAMAGE_EXPLOSION,
	cooldown = 3,
	range = {
		250,
		265,
		280,
		300
	}
}
b.towers.catapult.skill_a = {
	price = {
		100,
		100,
		100
	},
	xp_gain = 15,
	damage_min = {
		80,
		80,
		80
	},
	damage_max = {
		120,
		120,
		120
	},
	damage_radius = 60,
	damage_type = DAMAGE_EXPLOSION,
	cooldown = {
		15,
		15,
		15
	},
	range = 300,
	slow_factor = {
		0.6,
		0.5,
		0.4
	},
	s_slow_factor = {
		0.4,
		0.5,
		0.6
	},
	slow_duration = {
		6,
		8,
		10
	}
}
b.towers.catapult.skill_b = {
	price = {
		200,
		200,
		200
	},
	xp_gain = 20,
	damage_min = {
		18,
		36,
		52
	},
	damage_max = {
		32,
		64,
		92
	},
	damage_radius = 60,
	damage_type = DAMAGE_EXPLOSION,
	explosion_delay = 0.1
}
b.towers.catapult.skill_c = {
	price = {
		150,
		100,
		100
	},
	xp_gain = 20,
	cooldown = {
		7,
		7,
		7
	},
	min_range = 20,
	max_range = 120,
	damage_min = {
		20,
		32,
		48
	},
	damage_max = {
		30,
		48,
		72
	},
	damage_radius = 40,
	damage_type = DAMAGE_PHYSICAL,
	stun_duration = {
		1,
		2,
		3
	},
	max_traps = {
		3,
		4,
		5
	},
	min_dist_between_traps = 50
}
b.towers.catapult.ultimate = {
	xp_gain = 35,
	cooldown = 30,
	min_range = 0,
	max_range = 300,
	min_targets = 3,
	speed = 100,
	hit_damage_min = 60,
	hit_damage_max = 60,
	hit_damage_radius = 55,
	hit_damage_type = DAMAGE_EXPLOSION,
	explosion_damage_min = 60,
	explosion_damage_max = 60,
	explosion_damage_radius = 55,
	explosion_damage_type = DAMAGE_EXPLOSION,
	damage_min = 75,
	damage_max = 75,
	damage_type = DAMAGE_EXPLOSION,
	s_total_damage = 195,
	radius = 60,
	nodes = 50,
	burn = {}
}
b.towers.catapult.ultimate.burn.duration = 4
b.towers.catapult.ultimate.burn.damage = {
	4,
	4,
	4
}
b.towers.catapult.ultimate.burn.s_damage = 64
b.towers.catapult.ultimate.burn.damage_every = 0.25
b.towers.ranger = {
	price = {
		80,
		120,
		180,
		260
	},
	stats = {}
}
b.towers.ranger.stats.damage = 5.5
b.towers.ranger.stats.cooldown = 9
b.towers.ranger.stats.range = 6
b.towers.ranger.basic_attack = {
	range = {
		190,
		200,
		215,
		235
	},
	cooldown = 1.5
}
b.towers.ranger.bullet = {
	damage_min = {
		6,
		16,
		32,
		52
	},
	damage_max = {
		10,
		24,
		42,
		66
	},
	damage_type = DAMAGE_PHYSICAL
}
b.towers.ranger.skill_a = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		15,
		15,
		15
	},
	bullet = {}
}
b.towers.ranger.skill_a.bullet.damage_min = {
	54,
	54,
	54
}
b.towers.ranger.skill_a.bullet.damage_max = {
	66,
	66,
	66
}
b.towers.ranger.skill_a.bullet.damage_type = DAMAGE_PHYSICAL
b.towers.ranger.skill_a.poison = {
	duration = {
		3,
		5,
		8
	},
	damage_min = {
		2,
		4,
		6
	},
	damage_max = {
		2,
		4,
		6
	},
	s_damage_total = {
		24,
		80,
		192
	},
	damage_every = {
		0.25,
		0.25,
		0.25
	},
	damage_type = DAMAGE_TRUE
}
b.towers.ranger.skill_b = {
	price = {
		150,
		150,
		150
	},
	cooldown = {
		25,
		25,
		25
	},
	stun_duration = {
		2,
		2,
		2
	},
	bullet = {}
}
b.towers.ranger.skill_b.bullet.damage_min = {
	80,
	120,
	160
}
b.towers.ranger.skill_b.bullet.damage_max = {
	120,
	180,
	240
}
b.towers.ranger.skill_b.bullet.damage_type = DAMAGE_PHYSICAL
b.towers.ranger.skill_b.aura = {
	slow_factor = {
		0.4,
		0.4,
		0.4
	},
	s_slow_factor = {
		0.6,
		0.6,
		0.6
	},
	slow_duration = {
		0.5,
		0.5,
		0.5
	},
	duration = {
		6,
		7,
		9
	},
	cycle_time = {
		0.25,
		0.25,
		0.25
	},
	radius = {
		60,
		60,
		60
	}
}
b.towers.ranger.skill_c = {
	price = {
		250,
		200,
		200
	},
	bounce_damage_mult = {
		0.25,
		0.5,
		0.75
	},
	damage_type = DAMAGE_PHYSICAL,
	bounce_range = {
		100,
		100,
		100
	},
	max_bounces = {
		3,
		3,
		3
	}
}
b.towers.ranger.ultimate = {
	damage_boss = 500,
	hp_threshold = 0.4,
	cooldown = 32
}
b.towers.culverine = {
	shared_min_cooldown = 3,
	price = {
		130,
		170,
		260,
		340
	},
	stats = {}
}
b.towers.culverine.stats.damage = 7
b.towers.culverine.stats.cooldown = 5
b.towers.culverine.stats.range = 3.5
b.towers.culverine.basic_attack = {
	damage_min = {
		9,
		21,
		41,
		66
	},
	damage_max = {
		13,
		30,
		55,
		86
	},
	damage_radius = 55,
	damage_type = DAMAGE_EXPLOSION,
	cooldown = 3,
	range = {
		180,
		180,
		180,
		180
	}
}
b.towers.culverine.skill_a = {
	price = {
		150,
		150,
		150
	},
	xp_gain = 15,
	cooldown = {
		16,
		16,
		16
	},
	damage_min = {
		66,
		108,
		156
	},
	damage_max = {
		86,
		148,
		218
	},
	damage_radius = 90,
	damage_type = DAMAGE_EXPLOSION,
	range = 200,
	aura_range = 90,
	min_targets = 3,
	min_magic_res = 0.3,
	aura_duration = {
		6,
		8,
		10
	},
	mod_duration = {
		0.3,
		0.3,
		0.3
	},
	mr_red = {
		1,
		1,
		1
	}
}
b.towers.culverine.skill_b = {
	price = {
		100,
		100,
		100
	},
	xp_gain = 10,
	armor_red = {
		0.03,
		0.05,
		0.07
	}
}
b.towers.culverine.skill_c = {
	price = {
		200,
		200,
		200
	},
	xp_gain = 20,
	cooldown = {
		25,
		25,
		25
	},
	rate_of_fire = {
		0.1,
		0.1,
		0.1
	},
	shots = {
		3,
		6,
		9
	},
	min_targets = 3,
	min_health = 600
}
b.towers.culverine.ultimate = {
	xp_gain = 35,
	cooldown = 35,
	attacks_to_trigger = 6,
	speed = 100,
	damage_min = 60,
	damage_max = 110,
	damage_radius = 200,
	damage_type = DAMAGE_EXPLOSION,
	stun = {}
}
b.towers.culverine.ultimate.stun.duration = 2
b.towers.sunray_master = {
	price = {
		110,
		150,
		220,
		280
	},
	stats = {}
}
b.towers.sunray_master.stats.damage = 1
b.towers.sunray_master.stats.range = 4
b.towers.sunray_master.stats.cooldown = 10
b.towers.sunray_master.baisc_attack_range = {
	160,
	170,
	180,
	190
}
b.towers.sunray_master.beam_attack = {
	damage_min = {
		3,
		7,
		13,
		20
	},
	damage_max = {
		5,
		12,
		21,
		32
	},
	cooldown = {
		0.5,
		0.5,
		0.5,
		0.5
	},
	damage_type = DAMAGE_MAGICAL,
	duration = fts(30),
	cycle_time = 0.25,
	damage_radius = 55,
	slow_factor = {
		0.8,
		0.8,
		0.8,
		0.8
	},
	slow_duration = {
		1,
		1,
		1,
		1
	}
}
b.towers.sunray_master.rapid_fire_attack = {
	damage_min = {
		1,
		3,
		5,
		9
	},
	damage_max = {
		3,
		7,
		13,
		16
	},
	cooldown = {
		0.2,
		0.2,
		0.2,
		0.2
	},
	damage_type = DAMAGE_MAGICAL,
	number_of_attacks = 4
}
b.towers.sunray_master.skill_a = {
	price = {
		200,
		100,
		50
	},
	rally_range = 150,
	max_soldiers = {
		2,
		2,
		2
	},
	soldier = {}
}
b.towers.sunray_master.skill_a.soldier.hp = {
	100,
	140,
	180
}
b.towers.sunray_master.skill_a.soldier.armor = {
	0.15,
	0.2,
	0.25
}
b.towers.sunray_master.skill_a.soldier.dead_lifetime = {
	12,
	12,
	12
}
b.towers.sunray_master.skill_a.soldier.regen_hp = {
	8,
	10,
	11
}
b.towers.sunray_master.skill_a.soldier.speed = 60
b.towers.sunray_master.skill_a.soldier.basic_attack = {
	damage_min = {
		3,
		4,
		5
	},
	damage_max = {
		5,
		6,
		7
	},
	cooldown = 2,
	range = 70
}
b.towers.sunray_master.skill_b = {
	price = {
		150,
		150,
		150
	},
	radius = {
		200,
		200,
		200
	},
	damage_min = {
		16,
		32,
		48
	},
	damage_max = {
		24,
		48,
		72
	},
	slow_factor = {
		0.8,
		0.7,
		0.6
	},
	s_slow_factor = {
		0.2,
		0.3,
		0.4
	},
	slow_duration = {
		3,
		3,
		3
	}
}
b.towers.sunray_master.skill_c = {
	price = {
		100,
		100,
		100
	},
	dmg_factor = {
		1.4,
		1.7,
		2
	}
}
b.towers.sunray_master.skill_c.s_dmg_factor = sub_one(b.towers.sunray_master.skill_c.dmg_factor)
b.towers.sunray_master.skill_c.armor_red = {
	0.02,
	0.03,
	0.04
}
b.towers.sunray_master.skill_c.rate = 4
b.towers.sunray_master.ultimate = {
	damage_min = 36,
	damage_max = 64,
	damage_type = DAMAGE_MAGICAL,
	damage_radius = 75,
	range = 200,
	number_of_beams = 4,
	min_targets = 3,
	cooldown = 40,
	delay_between_shots = fts(5),
	stun = {}
}
b.towers.sunray_master.ultimate.stun.duration = 2
b.towers.sunray_master.ultimate.min_spread = 75
b.towers.sunray_master.ultimate.max_spread = 100
b.towers.wildcat = {
	price = {
		80,
		130,
		190,
		260
	},
	stats = {}
}
b.towers.wildcat.stats.damage = 1.5
b.towers.wildcat.stats.hp = 8
b.towers.wildcat.stats.armor = 1.5
b.towers.wildcat.rally_range = 150
b.towers.wildcat.max_soldiers = 2
b.towers.wildcat.soldier = {
	hp = {
		80,
		120,
		160,
		220
	},
	armor = {
		0,
		0.05,
		0.1,
		0.15
	},
	dead_lifetime = 12,
	regen_hp = {
		6,
		8,
		11,
		15
	},
	speed = 75,
	extra_speed = 55,
	min_distance_extra_speed = 75,
	basic_attack = {}
}
b.towers.wildcat.soldier.basic_attack.damage_min = {
	3,
	7,
	10,
	16
}
b.towers.wildcat.soldier.basic_attack.damage_max = {
	5,
	10,
	14,
	20
}
b.towers.wildcat.soldier.basic_attack.damage_type = DAMAGE_PHYSICAL
b.towers.wildcat.soldier.basic_attack.cooldown = 1
b.towers.wildcat.soldier.basic_attack.range = 70
b.towers.wildcat.soldier.ranged_attack = {
	damage_min = {
		3,
		7,
		10,
		16
	},
	damage_max = {
		5,
		10,
		14,
		20
	},
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 1,
	min_range = 50,
	max_range = 175
}
b.towers.wildcat.skill_a = {
	price = {
		120,
		120,
		120
	},
	cooldown = {
		15,
		15,
		15
	},
	min_range = 0,
	max_range = 150,
	min_targets = 2,
	damage_min = {
		18,
		32,
		38
	},
	damage_max = {
		28,
		46,
		56
	},
	damage_type = DAMAGE_PHYSICAL,
	max_bounces = {
		2,
		3,
		4
	},
	bounce_range = {
		100,
		100,
		100
	},
	bounce_damage_mult = {
		1,
		1,
		1,
		1
	},
	bounce_speed_mult = 1
}
b.towers.wildcat.skill_b = {
	price = {
		160,
		160,
		160
	},
	cooldown = {
		12,
		12,
		12
	},
	damage_min = {
		27,
		80,
		134
	},
	damage_max = {
		42,
		120,
		200
	},
	damage_type = DAMAGE_PHYSICAL,
	bleed = {}
}
b.towers.wildcat.skill_b.bleed.cycle_time = 0.25
b.towers.wildcat.skill_b.bleed.damage_min = {
	3,
	4,
	5
}
b.towers.wildcat.skill_b.bleed.damage_max = {
	3,
	4,
	5
}
b.towers.wildcat.skill_b.bleed.s_damage = {
	48,
	64,
	80
}
b.towers.wildcat.skill_b.bleed.duration = {
	4,
	4,
	4
}
b.towers.wildcat.skill_c = {
	price = {
		180,
		180,
		180
	},
	cooldown = {
		18,
		18,
		18
	},
	damage_min = {
		14,
		24,
		30
	},
	damage_max = {
		22,
		34,
		44
	},
	damage_type = DAMAGE_PHYSICAL,
	damage_radius = 35,
	min_range = 75,
	max_range = 150,
	arrow_count = {
		8,
		10,
		12
	},
	min_targets = 3,
	nodes_between_arrows = 0.5
}
b.towers.wildcat.ultimate = {
	cooldown = 35,
	range = 150,
	damage_min = 160,
	damage_max = 240,
	damage_type = DAMAGE_PHYSICAL,
	number_of_attacks = 4,
	time_between_attacks = fts(8)
}
b.towers.light_priestess = {
	price = {
		90,
		130,
		200,
		260
	},
	stats = {}
}
b.towers.light_priestess.stats.damage = 4.5
b.towers.light_priestess.stats.range = 4
b.towers.light_priestess.stats.cooldown = 8
b.towers.light_priestess.basic_attack = {
	damage_min = {
		5,
		13,
		25,
		37
	},
	damage_max = {
		10,
		24,
		46,
		69
	},
	damage_type = DAMAGE_MAGICAL,
	cooldown = 1.25,
	range = {
		160,
		170,
		180,
		190
	}
}
b.towers.light_priestess.passive = {
	armor_inc = {
		0.1,
		0.15,
		0.2,
		0.25
	},
	duration = 0.1,
	range = {
		160,
		170,
		180,
		190
	}
}
b.towers.light_priestess.skill_a = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		16,
		16,
		16
	},
	range = 190,
	duration = {
		4,
		4,
		4
	},
	armor_inc = {
		0.1,
		0.2,
		0.3
	},
	heal_every = 0.25,
	heal_per_second_min = {
		24,
		32,
		48
	},
	heal_per_second_max = {
		24,
		32,
		48
	},
	s_total_heal = {
		96,
		128,
		192
	},
	heal_threshold = {
		0.6,
		0.6,
		0.6
	}
}
b.towers.light_priestess.skill_b = {
	price = {
		120,
		120,
		120
	},
	cooldown = {
		22,
		22,
		22
	},
	range = 190,
	min_targets = 2,
	slow_factor = {
		0.6,
		0.6,
		0.6
	},
	s_slow_factor = {
		0.4,
		0.4,
		0.4
	},
	slow_duration = {
		6,
		8,
		10
	},
	silence_duration = {
		6,
		8,
		10
	}
}
b.towers.light_priestess.skill_c = {
	price = {
		150,
		150,
		150
	},
	cooldown = {
		18,
		18,
		18
	},
	range = 300,
	dmg_factor = {
		1.5,
		1.75,
		2
	}
}
b.towers.light_priestess.skill_c.s_dmg_factor = {
	sub_one(b.towers.light_priestess.skill_c.dmg_factor[1]),
	sub_one(b.towers.light_priestess.skill_c.dmg_factor[2]),
	sub_one(b.towers.light_priestess.skill_c.dmg_factor[3])
}
b.towers.light_priestess.skill_c.dmg_inc_duration = {
	5,
	7,
	9
}
b.towers.light_priestess.skill_c.detection_range = {
	375,
	375,
	375
}
b.towers.light_priestess.ultimate = {
	cooldown = 37,
	range = 190,
	duration = 5,
	damage_min = 20,
	damage_max = 30,
	s_damage_min = 400,
	s_damage_max = 600,
	damage_type = DAMAGE_MAGICAL,
	cycle_time = 0.25,
	armor_red = 0.015,
	invulnerability_duration = 0.5
}
b.towers.tree = {
	price = {
		140,
		180,
		240,
		320
	},
	stats = {}
}
b.towers.tree.stats.damage = 4.5
b.towers.tree.stats.range = 2.5
b.towers.tree.stats.cooldown = 5
b.towers.tree.rally_range = 160
b.towers.tree.soldier = {
	armor = {
		0.1,
		0.1,
		0.15,
		0.15
	},
	dead_lifetime = 20,
	hp = {
		500,
		700,
		900,
		1100
	},
	regen_hp = {
		40,
		56,
		72,
		88
	},
	speed = 30,
	basic_attack = {}
}
b.towers.tree.soldier.basic_attack.damage_min = {
	8,
	19,
	35,
	56
}
b.towers.tree.soldier.basic_attack.damage_max = {
	12,
	29,
	53,
	84
}
b.towers.tree.soldier.basic_attack.damage_type = DAMAGE_EXPLOSION
b.towers.tree.soldier.basic_attack.damage_radius = 50
b.towers.tree.soldier.basic_attack.cooldown = 3
b.towers.tree.soldier.basic_attack.range = 70
b.towers.tree.basic_attack = {
	damage_min = {
		6,
		14,
		26,
		40
	},
	damage_max = {
		9,
		21,
		39,
		60
	},
	damage_radius = {
		160,
		160,
		160,
		160
	},
	damage_type = DAMAGE_EXPLOSION,
	cooldown = 3,
	range = {
		160,
		160,
		160,
		160
	}
}
b.towers.tree.skill_a = {
	price = {
		150,
		150,
		150
	},
	cooldown = {
		20,
		20,
		20
	},
	min_targets = 3,
	range = 160,
	aura = {}
}
b.towers.tree.skill_a.aura.radius_tower = 160
b.towers.tree.skill_a.aura.radius_unit = 50
b.towers.tree.skill_a.aura.range_unit = 160
b.towers.tree.skill_a.aura.duration = 0.3
b.towers.tree.skill_a.aura.cycle_time = 0.29
b.towers.tree.skill_a.blind = {
	damage_min = {
		2,
		3,
		4
	},
	damage_max = {
		2,
		3,
		4
	},
	s_damage = {
		32,
		72,
		128
	},
	damage_type = DAMAGE_TRUE,
	damage_every = 0.25,
	damage_factor = 0.1,
	s_damage_factor = 0.9,
	duration = {
		4,
		6,
		8
	}
}
b.towers.tree.skill_b = {
	price = {
		300,
		100,
		100
	},
	cooldown = {
		25,
		25,
		25
	},
	damage_type = DAMAGE_INSTAKILL,
	min_hp_max = {
		0,
		0,
		0
	},
	max_hp_max = {
		1500,
		2000,
		2800
	}
}
b.towers.tree.skill_c = {
	price = {
		180,
		100,
		100
	},
	cooldown = {
		14,
		14,
		14
	},
	range = 160,
	min_targets = 2,
	aura = {}
}
b.towers.tree.skill_c.aura.duration = 0.1
b.towers.tree.skill_c.aura.radius = 160
b.towers.tree.skill_c.aura.cycle_time = 0.09
b.towers.tree.skill_c.aura.max_targets = {
	4,
	5,
	6
}
b.towers.tree.skill_c.root = {
	duration = {
		2,
		3,
		4
	}
}
b.towers.tree.ultimate = {
	cooldown = 35,
	range = 160,
	damage_min = 80,
	damage_max = 120,
	damage_type = DAMAGE_EXPLOSION,
	damage_radius = 80,
	seedling_spawn_count = 3,
	seedling = {}
}
b.towers.tree.ultimate.seedling.duration = 25
b.towers.tree.ultimate.seedling.armor = 0
b.towers.tree.ultimate.seedling.dead_lifetime = 2
b.towers.tree.ultimate.seedling.hp = 60
b.towers.tree.ultimate.seedling.regen_hp = 5
b.towers.tree.ultimate.seedling.speed = 50
b.towers.tree.ultimate.seedling.basic_attack = {
	damage_min = 6,
	damage_max = 10,
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 1,
	range = 70
}
b.towers.alchemist = {
	price = {
		100,
		150,
		220,
		300
	},
	stats = {}
}
b.towers.alchemist.stats.damage = 8
b.towers.alchemist.stats.range = 2.5
b.towers.alchemist.stats.cooldown = 8.5
b.towers.alchemist.basic_attack = {
	range = {
		160,
		160,
		160,
		160
	},
	damage_min = {
		1,
		2,
		3,
		4
	},
	damage_max = {
		2,
		3,
		4,
		5
	},
	damage_radius = 48,
	damage_type = DAMAGE_TRUE,
	cycle_time = 0.3,
	cooldown = 0.94,
	duration = {
		2,
		3,
		4,
		5
	},
	slow_factor = {
		0.6,
		0.6,
		0.6,
		0.6
	},
	slow_duration = {
		0.5,
		0.5,
		0.5,
		0.5
	}
}
b.towers.alchemist.skill_a = {
	price = {
		100,
		100,
		100
	},
	cooldown = {
		15,
		15,
		15
	},
	min_targets = 3,
	min_detection_range = 50,
	max_detection_range = 180,
	projectile_count = {
		8,
		10,
		12
	},
	slow_factor = {
		0.6,
		0.45,
		0.3
	},
	s_slow_factor = {
		0.4,
		0.55,
		0.7
	},
	slow_duration = {
		1,
		1,
		1
	},
	slow_radius = 50,
	cycle_time = 0.25,
	duration = {
		5,
		6,
		7
	},
	min_distance_between_shots = 5
}
b.towers.alchemist.skill_b = {
	price = {
		150,
		150,
		150
	},
	cooldown = {
		22,
		22,
		22
	},
	max_range = 250,
	min_targets = 1,
	soldier = {}
}
b.towers.alchemist.skill_b.soldier.armor = {
	0,
	0,
	0
}
b.towers.alchemist.skill_b.soldier.magic_armor = {
	0,
	0,
	0
}
b.towers.alchemist.skill_b.soldier.hp = {
	150,
	180,
	210
}
b.towers.alchemist.skill_b.soldier.regen_hp = {
	10,
	13,
	16
}
b.towers.alchemist.skill_b.soldier.regen_cooldown = 1
b.towers.alchemist.skill_b.soldier.speed = 50
b.towers.alchemist.skill_b.soldier.duration = {
	30,
	30,
	30
}
b.towers.alchemist.skill_b.soldier.basic_attack = {
	damage_min = {
		16,
		32,
		64
	},
	damage_max = {
		24,
		48,
		96
	},
	damage_type = DAMAGE_TRUE,
	cooldown = 1.5,
	melee_range = 70
}
b.towers.alchemist.skill_c = {
	price = {
		200,
		200,
		200
	},
	bullet = {}
}
b.towers.alchemist.skill_c.bullet.damage_min = {
	10,
	28,
	46
}
b.towers.alchemist.skill_c.bullet.damage_max = {
	16,
	46,
	68
}
b.towers.alchemist.skill_c.bullet.damage_radius = 50
b.towers.alchemist.skill_c.bullet.damage_type = DAMAGE_EXPLOSION
b.towers.alchemist.skill_c.area = {
	damage_min = {
		5,
		6,
		7
	},
	damage_max = {
		7,
		8,
		9
	},
	damage_radius = 50,
	damage_type = DAMAGE_TRUE,
	cycle_time = 0.3,
	duration = {
		5,
		5,
		5
	},
	slow_factor = {
		0.6,
		0.6,
		0.6
	},
	slow_duration = {
		0.5,
		0.5,
		0.5
	}
}
b.towers.alchemist.ultimate = {
	cooldown = 40,
	detection_range = 160,
	transform_range = 80,
	polymorph_duration = 15,
	min_total_hp = 300,
	hp_cap = 600,
	gold_pig = {}
}
b.towers.alchemist.ultimate.gold_pig.extra_gold = 15
b.towers.alchemist.ultimate.gold_pig.armor = 0
b.towers.alchemist.ultimate.gold_pig.magic_armor = 0
b.towers.miners = {
	global = {}
}
b.towers.miners.global.gold_cap_per_wave = 300
b.towers.miners.price = {
	120,
	160,
	220,
	300
}
b.towers.miners.stats = {
	damage = 1,
	hp = 2.5,
	armor = 0
}
b.towers.miners.rally_range = 160
b.towers.miners.max_soldiers = 8
b.towers.miners.spawn_soldier_interval = 5
b.towers.miners.boss_spawn_soldier_interval = 6
b.towers.miners.soldier = {
	armor = {
		0,
		0,
		0,
		0
	},
	dead_lifetime = 3,
	hp = {
		40,
		60,
		90,
		120
	},
	regen_hp = {
		4,
		5,
		7,
		10
	},
	speed = 75,
	tunneling_time = 0.6,
	basic_attack = {}
}
b.towers.miners.soldier.basic_attack.damage_min = {
	3,
	4,
	7,
	10
}
b.towers.miners.soldier.basic_attack.damage_max = {
	5,
	7,
	11,
	15
}
b.towers.miners.soldier.basic_attack.cooldown = 1
b.towers.miners.soldier.basic_attack.range = 70
b.towers.miners.gold_generation = {
	min_gold = {
		1,
		1,
		2,
		2
	},
	max_gold = {
		2,
		3,
		3,
		4
	},
	tick_cooldown = {
		3,
		3,
		3,
		3
	},
	max_gold_cap = 100000
}
b.towers.miners.skill_a = {
	price = {
		150,
		150,
		150
	},
	cooldown = {
		20,
		20,
		20
	},
	max_range = 500,
	min_targets = 2,
	cart = {}
}
b.towers.miners.skill_a.cart.speed = 120
b.towers.miners.skill_a.cart.hit_radius = 40
b.towers.miners.skill_a.cart.damage_min = {
	18,
	40,
	52
}
b.towers.miners.skill_a.cart.damage_max = {
	28,
	60,
	78
}
b.towers.miners.skill_a.cart.damage_radius = 80
b.towers.miners.skill_a.cart.max_nodes = 80
b.towers.miners.skill_a.soldier = {
	hp = {
		50,
		65,
		90
	},
	armor = {
		0,
		0,
		0
	},
	regen_hp = {
		3,
		5,
		6
	},
	duration = {
		15,
		15,
		15
	},
	speed = 50,
	basic_attack = {}
}
b.towers.miners.skill_a.soldier.basic_attack.damage_min = {
	3,
	4,
	7
}
b.towers.miners.skill_a.soldier.basic_attack.damage_max = {
	5,
	7,
	11
}
b.towers.miners.skill_a.soldier.basic_attack.cooldown = 1
b.towers.miners.skill_a.soldier.basic_attack.melee_range = 70
b.towers.miners.skill_b = {
	price = {
		200,
		200,
		200
	},
	aura = {}
}
b.towers.miners.skill_b.aura.damage_min = {
	8,
	20,
	32
}
b.towers.miners.skill_b.aura.damage_max = {
	12,
	30,
	48
}
b.towers.miners.skill_b.aura.damage_type = DAMAGE_PHYSICAL
b.towers.miners.skill_b.aura.radius = 45
b.towers.miners.skill_b.stun = {
	duration = {
		1,
		1.5,
		2
	}
}
b.towers.miners.skill_c = {
	price = {
		250,
		100,
		100
	},
	gold_factor = {
		1,
		1.5,
		2
	}
}
b.towers.miners.ultimate = {
	cooldown = 50,
	duration = 1.5,
	tick_cooldown = 0.5,
	min_gold = 18,
	max_gold = 24
}
b.towers.miners.ultimate.s_min_gold = b.towers.miners.ultimate.min_gold * 4
b.towers.miners.ultimate.s_max_gold = b.towers.miners.ultimate.max_gold * 4
b.towers.miners.ultimate.skill_c_cooldown_factor = 1
b.towers.forger = {
	shared_min_cooldown = 2,
	price = {
		120,
		160,
		220,
		280
	},
	stats = {}
}
b.towers.forger.stats.damage = 6.5
b.towers.forger.stats.range = 4
b.towers.forger.stats.cooldown = 7
b.towers.forger.basic_attack = {
	cooldown = 0.57,
	range = {
		160,
		170,
		180,
		190
	},
	damage_min = {
		8,
		18,
		38,
		56
	},
	damage_max = {
		14,
		36,
		58,
		88
	},
	damage_type = DAMAGE_MAGICAL,
	damage_radius = 50
}
b.towers.forger.skill_a = {
	price = {
		250,
		250,
		250
	},
	cooldown = {
		18,
		18,
		18
	},
	detection_range = 180,
	damage_min = {
		30,
		60,
		90
	},
	damage_max = {
		45,
		90,
		135
	},
	s_damage_min = {
		60,
		120,
		180
	},
	s_damage_max = {
		90,
		180,
		270
	},
	damage_radius = 30,
	damage_type = DAMAGE_MAGICAL,
	cycle_time = 0.25,
	min_targets = 2,
	disc_speed = 120,
	distance = 60,
	max_spawn_distance = 220,
	distance_from_enemy = 8
}
b.towers.forger.skill_b = {
	price = {
		160,
		160,
		160
	},
	cooldown = {
		20,
		20,
		20
	},
	crystals = 2,
	detection_range = 190,
	min_targets = 1,
	spawn_distance = 5,
	crystal = {}
}
b.towers.forger.skill_b.crystal.detection_range = 120
b.towers.forger.skill_b.crystal.damage_min = {
	8,
	16,
	24
}
b.towers.forger.skill_b.crystal.damage_max = {
	12,
	24,
	36
}
b.towers.forger.skill_b.crystal.s_damage_min = {
	32,
	64,
	96
}
b.towers.forger.skill_b.crystal.s_damage_max = {
	48,
	96,
	144
}
b.towers.forger.skill_b.crystal.damage_type = DAMAGE_MAGICAL
b.towers.forger.skill_b.crystal.duration = {
	10,
	10,
	10
}
b.towers.forger.skill_b.crystal.max_damage = {
	100,
	200,
	300
}
b.towers.forger.skill_b.crystal.cycle_time = 0.25
b.towers.forger.skill_c = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		26,
		26,
		26
	},
	stun_duration = {
		5,
		7,
		9
	},
	detection_range = 120,
	min_targets = {
		2,
		2,
		2
	},
	max_targets = {
		2,
		3,
		4
	}
}
b.towers.forger.ultimate = {
	damage = 1000,
	cooldown = 40,
	detection_range = 180,
	radius = 50,
	stun_duration = 0.5,
	min_total_hp = 300,
	hp_cap = 1200,
	grouping_range = 80
}
b.towers.crossbows = {
	price = {
		90,
		110,
		170,
		250
	},
	stats = {}
}
b.towers.crossbows.stats.damage = 6
b.towers.crossbows.stats.range = 4
b.towers.crossbows.stats.cooldown = 7.5
b.towers.crossbows.basic_attack = {
	damage_min = {
		2,
		6,
		12,
		18
	},
	damage_max = {
		5,
		10,
		18,
		28
	},
	cooldown = 0.6,
	range = {
		160,
		170,
		180,
		190
	},
	damage_type = DAMAGE_PHYSICAL,
	retarget_range = 70
}
b.towers.crossbows.skill_a = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		25,
		25,
		25
	},
	damage_min = {
		18,
		18,
		18
	},
	damage_max = {
		28,
		28,
		28
	},
	damage_type = DAMAGE_PHYSICAL,
	min_targets = 1,
	detection_range = 200,
	duration = {
		4,
		6,
		9
	},
	attack_cooldown = 0,
	time_between_shots = fts(0),
	shots_per_attack = 1,
	retarget_range = 45
}
b.towers.crossbows.skill_b = {
	price = {
		150,
		150,
		150
	},
	radius = 60,
	slow_factor = {
		0.8,
		0.65,
		0.5
	},
	s_slow_factor = {
		0.2,
		0.35,
		0.5
	},
	slow_duration = {
		4,
		6,
		8
	},
	weak_factor = {
		0.9,
		0.75,
		0.6
	},
	boss_weak_factor = {
		0.95,
		0.9,
		0.85
	},
	s_weak_factor = {
		0.1,
		0.25,
		0.4
	},
	weak_factor_duration = {
		4,
		6,
		8
	},
	mod_duration = 0.15
}
b.towers.crossbows.skill_c = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		20,
		20,
		20
	},
	damage_min = {
		120,
		240,
		360
	},
	damage_max = {
		180,
		360,
		540
	},
	damage_type = DAMAGE_TRUE,
	detection_range = 190,
	instakill_chance = {
		0.1,
		0.25,
		0.4
	}
}
b.towers.crossbows.ultimate = {
	cooldown = 36,
	detection_range = 140,
	min_targets = 1,
	soldier = {}
}
b.towers.crossbows.ultimate.soldier.armor = 0.8
b.towers.crossbows.ultimate.soldier.magic_armor = 0
b.towers.crossbows.ultimate.soldier.hp = 250
b.towers.crossbows.ultimate.soldier.regen_hp = 20
b.towers.crossbows.ultimate.soldier.regen_cooldown = 1
b.towers.crossbows.ultimate.soldier.speed = 50
b.towers.crossbows.ultimate.soldier.duration = 30
b.towers.crossbows.ultimate.soldier.basic_attack = {
	damage_min = 32,
	damage_max = 48,
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 1.5,
	melee_range = 70
}
b.towers.sniper = {
	price = {
		100,
		140,
		180,
		250
	},
	stats = {}
}
b.towers.sniper.stats.damage = 10
b.towers.sniper.stats.range = 10
b.towers.sniper.stats.cooldown = 1
b.towers.sniper.ignore_nodes_start = 10
b.towers.sniper.ignore_nodes_end = 5
b.towers.sniper.coordinated_targeting = true
b.towers.sniper.coordinated_wasted_damage_factor = 1.5
b.towers.sniper.basic_attack = {
	damage_min = {
		26,
		65,
		114,
		174
	},
	damage_max = {
		34,
		80,
		144,
		218
	},
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 4,
	min_range = {
		150,
		150,
		150,
		150
	},
	max_range = {
		1e+99,
		1e+99,
		1e+99,
		1e+99
	},
	crosshair_time = fts(30),
	crosshair_duration = 2,
	max_retarget_range = 75
}
b.towers.sniper.skill_a = {
	price = {
		150,
		150,
		150
	},
	cd_red_factor = {
		0.25,
		0.25,
		0.25
	},
	damage_factor = {
		1.1,
		1.25,
		1.4
	}
}
b.towers.sniper.skill_a.s_damage_factor = sub_one(b.towers.sniper.skill_a.damage_factor)
b.towers.sniper.skill_b = {
	price = {
		200,
		200,
		200
	},
	cooldown = {
		12,
		12,
		12
	},
	min_hp = {
		50,
		50,
		50
	},
	bleed = {}
}
b.towers.sniper.skill_b.bleed.duration = 4
b.towers.sniper.skill_b.bleed.cycle_time = 0.25
b.towers.sniper.skill_b.bleed.damage_min = {
	8,
	16,
	24
}
b.towers.sniper.skill_b.bleed.damage_max = {
	10,
	19,
	29
}
b.towers.sniper.skill_b.bleed.s_damage_min = {
	128,
	256,
	384
}
b.towers.sniper.skill_b.bleed.s_damage_max = {
	160,
	320,
	480
}
b.towers.sniper.skill_b.bleed.damage_type = DAMAGE_TRUE
b.towers.sniper.skill_c = {
	price = {
		180,
		180,
		180
	},
	cooldown = {
		6,
		6,
		6
	},
	damage_min = {
		22,
		46,
		68
	},
	damage_max = {
		30,
		58,
		88
	},
	s_damage_min = {
		66,
		138,
		204
	},
	s_damage_max = {
		90,
		177,
		264
	},
	damage_type = DAMAGE_PHYSICAL
}
b.towers.sniper.ultimate = {
	cooldown = 50,
	retarget_range = 75,
	time_between_shots = fts(20),
	damage_factor = 1.1
}
b.towers.sniper.ultimate.s_damage_factor = sub_one(b.towers.sniper.ultimate.damage_factor)
b.towers.upgrades = {
	barracks = {}
}
b.towers.upgrades.barracks.l1 = {
	hp_factor = 1.1
}
b.towers.upgrades.barracks.l1.s_hp_factor = sub_one(b.towers.upgrades.barracks.l1.hp_factor)
b.towers.upgrades.barracks.l2 = {
	spawn_reduction = 2,
	spawn_reduction_miners = 0.5
}
b.towers.upgrades.barracks.l3a = {
	dmg_factor = 1.3
}
b.towers.upgrades.barracks.l1.s_dmg_factor = sub_one(b.towers.upgrades.barracks.l3a.dmg_factor)
b.towers.upgrades.barracks.l3b = {
	hp_factor = 1.1
}
b.towers.upgrades.barracks.l3b.s_hp_factor = sub_one(b.towers.upgrades.barracks.l3b.hp_factor)
b.towers.upgrades.barracks.l3b.armor_inc = 0.1
b.towers.upgrades.barracks.l4a = {
	dmg_factor = 2
}
b.towers.upgrades.barracks.l4b = {
	hp_ptg_threshold = 0.25,
	dmg_received_factor = 0.8,
	s_dmg_received_factor = 0.2
}
b.towers.upgrades.archers = {
	l1 = {}
}
b.towers.upgrades.archers.l1.range_factor = 1.1
b.towers.upgrades.archers.l1.s_range_factor = sub_one(b.towers.upgrades.archers.l1.range_factor)
b.towers.upgrades.archers.l2 = {
	dmg_factor = 1.1
}
b.towers.upgrades.archers.l2.s_dmg_factor = sub_one(b.towers.upgrades.archers.l2.dmg_factor)
b.towers.upgrades.archers.l3a = {
	disabled_dmg_factor = 1.15
}
b.towers.upgrades.archers.l3a.s_disabled_dmg_factor = sub_one(b.towers.upgrades.archers.l3a.disabled_dmg_factor)
b.towers.upgrades.archers.l3b = {
	attack_speed_factor = 0.9
}
b.towers.upgrades.archers.l3b.s_attack_speed_factor = slow_calc(b.towers.upgrades.archers.l3b.attack_speed_factor)
b.towers.upgrades.archers.l4a = {
	double_dmg_chance = 0.12
}
b.towers.upgrades.archers.l4b = {}
b.towers.upgrades.mages = {
	l1 = {}
}
b.towers.upgrades.mages.l1.min_dmg_factor = 1.15
b.towers.upgrades.mages.l1.s_min_dmg_factor = sub_one(b.towers.upgrades.mages.l1.min_dmg_factor)
b.towers.upgrades.mages.l2 = {
	build_cost_red_factor = 0.9
}
b.towers.upgrades.mages.l2.s_build_cost_red_factor = slow_calc(b.towers.upgrades.mages.l2.build_cost_red_factor)
b.towers.upgrades.mages.l3a = {
	skill_cost_red_factor = 0.85
}
b.towers.upgrades.mages.l3a.s_skill_cost_red_factor = slow_calc(b.towers.upgrades.mages.l3a.skill_cost_red_factor)
b.towers.upgrades.mages.l3b = {
	range_factor = 1.1
}
b.towers.upgrades.mages.l3b.s_range_factor = sub_one(b.towers.upgrades.mages.l3b.range_factor)
b.towers.upgrades.mages.l3b.dmg_factor = 1.1
b.towers.upgrades.mages.l3b.s_dmg_factor = sub_one(b.towers.upgrades.mages.l3b.dmg_factor)
b.towers.upgrades.mages.l4a = {
	skills_cd_red_factor = 0.8
}
b.towers.upgrades.mages.l4a.s_skills_cd_red_factor = slow_calc(b.towers.upgrades.mages.l4a.skills_cd_red_factor)
b.towers.upgrades.mages.l4b = {
	dmg_factors = {
		1,
		1.04,
		1.08,
		1.12,
		1.16,
		1.2,
		1.24,
		1.28,
		1.32
	},
	s_dmg_factors = 0.04,
	s_dmg_factors_max = 0.32
}
b.towers.upgrades.artillery = {
	l1 = {}
}
b.towers.upgrades.artillery.l1.area_inc_factor = 1.1
b.towers.upgrades.artillery.l1.s_area_inc_factor = sub_one(b.towers.upgrades.artillery.l1.area_inc_factor)
b.towers.upgrades.artillery.l2 = {
	dmg_factor = 1.1
}
b.towers.upgrades.artillery.l2.s_dmg_factor = sub_one(b.towers.upgrades.artillery.l2.dmg_factor)
b.towers.upgrades.artillery.l3a = {
	attack_speed_factor = 0.9
}
b.towers.upgrades.artillery.l3a.s_attack_speed_factor = slow_calc(b.towers.upgrades.artillery.l3a.attack_speed_factor)
b.towers.upgrades.artillery.l3b = {
	armor_ignore_factor = 0.75
}
b.towers.upgrades.artillery.l4a = {
	stun_duration = 0.25
}
b.towers.upgrades.artillery.l4b = {
	range_inc_factor = 1.1
}
b.towers.upgrades.artillery.l4b.s_range_inc_factor = sub_one(b.towers.upgrades.artillery.l4b.range_inc_factor)
b.towers.upgrades.artillery.l4b.dmg_factor = 1.15
b.towers.upgrades.artillery.l4b.s_dmg_factor = sub_one(b.towers.upgrades.artillery.l4b.dmg_factor)
b.specials = {
	terrain_1 = {}
}
b.specials.terrain_1.blocked_holders = {
	price = 60
}
b.specials.stage_01 = {
	tutorial_bandit = {}
}
b.specials.stage_01.tutorial_bandit.hp = 24
b.specials.stage_01.tutorial_bandit.speed = 48
b.specials.stage_01.king = {
	bullet = {}
}
b.specials.stage_01.king.bullet.damage_min = 80
b.specials.stage_01.king.bullet.damage_max = 120
b.specials.stage_01.king.bullet.damage_radius = 50
b.specials.stage_01.king.bullet.cooldown = 2
b.specials.stage_01.king.bullet.variation_chances = {
	0.3,
	0.6,
	0.1
}
b.specials.stage_02 = {
	teleport = {}
}
b.specials.stage_02.teleport.cooldown = 35
b.specials.stage_02.teleport.nodes_teleport = 50
b.specials.stage_02.teleport.radius = 40
b.specials.stage_02.teleport.max_targets = 4
b.specials.stage_03 = {
	jenkins = {}
}
b.specials.stage_03.jenkins.speed = 100
b.specials.stage_03.jenkins.damage_min = 25
b.specials.stage_03.jenkins.damage_max = 35
b.specials.stage_03.jenkins.damage_type = DAMAGE_TRUE
b.specials.stage_03.jenkins.radius = 60
b.specials.stage_03.fisherman = {
	reward = 20
}
b.specials.stage_05 = {
	tree = {}
}
b.specials.stage_05.tree.cooldown = 25
b.specials.stage_05.tree.cooldown_iron = 10
b.specials.stage_05.tree.damage_min = 20
b.specials.stage_05.tree.damage_max = 40
b.specials.stage_05.tree.damage_type = DAMAGE_TRUE
b.specials.stage_05.tree.radius = 260
b.specials.stage_05.tree.stun_duration = 4
b.specials.stage_05.tree.cat_hp_buff = 1.5
b.specials.stage_05.tree.cat_dmg_buff = 2
b.specials.stage_05.tree.alleria_speed_buff = 2
b.specials.stage_05.tree.alleria_regen_buff = 2.5
b.specials.stage_05.tree.alleria_multishots_buff = 5
b.specials.stage_06 = {
	nivus = {}
}
b.specials.stage_06.nivus.delay_between_spells = 15
b.specials.stage_06.nivus.magic_missiles = {
	cooldown = 17,
	min_range = 0,
	max_range = 400,
	count = 3,
	damage_min = 5,
	damage_max = 15,
	damage_type = DAMAGE_MAGICAL
}
b.specials.stage_06.nivus.books = {
	min_range = 0,
	max_range = 1000,
	soldier = {}
}
b.specials.stage_06.nivus.books.soldier.armor = 0
b.specials.stage_06.nivus.books.soldier.dead_lifetime = 12
b.specials.stage_06.nivus.books.soldier.hp = 35
b.specials.stage_06.nivus.books.soldier.regen_hp = 4
b.specials.stage_06.nivus.books.soldier.speed = 80
b.specials.stage_06.nivus.books.soldier.duration = 16
b.specials.stage_06.nivus.books.soldier.basic_attack = {
	damage_min = 10,
	damage_max = 14,
	cooldown = 1,
	range = 72
}
b.specials.stage_06.nivus.disintegrate = {
	min_range = 0,
	max_range = 1000,
	min_hp = 220,
	max_hp = 1000
}
b.specials.stage_06.nivus.brooms = {
	min_nodes = 40,
	max_range = 1000,
	max_brooms = 5,
	chain_range = 120,
	duration = 10,
	enemy = {}
}
b.specials.stage_06.nivus.brooms.enemy.hp = 1
b.specials.stage_06.nivus.brooms.enemy.armor = 0
b.specials.stage_06.nivus.brooms.enemy.magic_armor = 0
b.specials.stage_06.nivus.brooms.enemy.speed = 20
b.specials.stage_06.nivus.brooms.enemy.hp_mult = 0.6
b.specials.stage_06.nivus.brooms.enemy.lives_cost = 1
b.specials.stage_06.nivus.brooms.enemy.grant_original_enemy_gold = true
b.specials.stage_06.nivus.brooms.enemy.default_gold = 5
b.specials.stage_07 = {
	knight = {}
}
b.specials.stage_07.knight.speed = 130
b.specials.stage_07.knight.damage_min = 50
b.specials.stage_07.knight.damage_max = 100
b.specials.stage_07.knight.damage_type = DAMAGE_PHYSICAL
b.specials.stage_07.knight.radius = 60
b.specials.stage_08 = {
	templar_archer = {}
}
b.specials.stage_08.templar_archer.cooldown = 4
b.specials.stage_08.templar_archer.damage_min = 4
b.specials.stage_08.templar_archer.damage_max = 8
b.specials.stage_08.templar_archer.damage_type = DAMAGE_PHYSICAL
b.specials.stage_08.templar_archer.min_range = 25
b.specials.stage_08.templar_archer.max_range = 320
b.specials.stage_08.templar_swordsman = {
	spawn_cooldown = 12,
	spawn_count = 3,
	armor = 0.25,
	hp = 200,
	regen_hp = 6,
	speed = 40,
	basic_attack = {}
}
b.specials.stage_08.templar_swordsman.basic_attack.cooldown = 1.5
b.specials.stage_08.templar_swordsman.basic_attack.damage_min = 8
b.specials.stage_08.templar_swordsman.basic_attack.damage_max = 16
b.specials.stage_08.templar_swordsman.basic_attack.damage_type = DAMAGE_PHYSICAL
b.specials.stage_08.templar_swordsman.basic_attack.range = 70
b.specials.stage_08.templar_swordsman.arterial_strike = {
	cooldown = 4,
	damage_min = 16,
	damage_max = 32,
	damage_type = DAMAGE_PHYSICAL,
	bleed_duration = 3,
	bleed_damage_min = 4,
	bleed_damage_max = 5,
	bleed_every = 0.5
}
b.specials.stage_08.cloud_of_crows = {
	speed = 64,
	nodes_to_explode = 56,
	spawn_count = 4
}
b.specials.stage_08.goblin_catapult = {
	taps_to_explode = 6,
	nodes_ahead = 50
}
b.specials.stage_08.tower_stun = {
	wait_time = 5,
	cooldown_min = 90,
	cooldown_max = 120,
	repair_cost = 100,
	fire_duration = 45
}
b.specials.stage_09 = {
	easter_egg_mortal_kombat = {}
}
b.specials.stage_09.easter_egg_mortal_kombat.attack_cd = 10
b.specials.stage_09.easter_egg_mortal_kombat.stun_duration = 5
b.specials.stage_17 = {
	paladin = {}
}
b.specials.stage_17.paladin.armor = 0.8
b.specials.stage_17.paladin.dead_lifetime = 12
b.specials.stage_17.paladin.hp_max = 240
b.specials.stage_17.paladin.regen_hp = 0
b.specials.stage_17.paladin.speed = 50
b.specials.stage_17.paladin.range = 60
b.specials.stage_17.paladin.basic_attack = {
	damage_min = 14,
	damage_max = 20,
	cooldown = 1,
	range = 65
}
b.specials.stage_17.duel = {
	fight_duration = 4.5,
	clash_window = 2,
	tap_time_aid = 0.08,
	taps_required = 10,
	slayer_victory_wait = 2,
	paladin_victory_wait = 2,
	enemy_buffs = {}
}
b.specials.stage_17.duel.enemy_buffs.aura = {
	duration = 7
}
b.specials.stage_17.duel.enemy_buffs.mods = {
	armor_inc = 0.2,
	speed_factor = 1.1,
	duration = 5
}
b.specials.stage_17.duel.soldier_buffs = {
	aura = {}
}
b.specials.stage_17.duel.soldier_buffs.aura.duration = 7
b.specials.stage_17.duel.soldier_buffs.mods = {
	dmg_factor = 1.1,
	armor_inc = 0.2,
	duration = 5
}
b.specials.stage_17.joust = {
	bet_amount = 25,
	bet_payout_mult = 4,
	cooldown = 75
}
b.specials.terrain_2 = {
	blocked_holders = {}
}
b.specials.terrain_2.blocked_holders.price = 100
b.specials.terrain_2.pillar_tower_holders = {
	taps_to_break = 3,
	damage_min = 200,
	damage_max = 300,
	damage_radius = 65,
	damage_type = DAMAGE_INSTAKILL,
	friendly_damage = true
}
b.specials.stage_10 = {
	jt_mechanics = {}
}
b.specials.stage_10.jt_mechanics.icicles = {
	target_random = 3,
	target_allies = 2,
	target_enemies = 2,
	damage_min = 40,
	damage_max = 60,
	damage_radius = 50,
	damage_type = DAMAGE_PHYSICAL,
	icicles_per_cluster = 3,
	spread = 30,
	scale_min = 0.7
}
b.specials.stage_10.jt_mechanics.patrol = {
	cooldown = 40,
	duration = 4,
	attacks_until_tired = 1,
	damage_radius = 70,
	damage_type = DAMAGE_EAT
}
b.specials.stage_10.jt_mechanics.swipe = {
	cooldown = 40,
	max_wait = 3,
	damage_radius = 70,
	damage_type = DAMAGE_EAT
}
b.specials.stage_10.at_at = {
	damage_min = 40,
	damage_max = 60,
	damage_radius = 50
}
b.specials.stage_11 = {
	shadow_radius = {
		290,
		500,
		600
	},
	spider_mechanics = {}
}
b.specials.stage_11.spider_mechanics.tower_block = {
	default_active_waves = {
		3,
		5,
		6,
		7,
		9,
		10,
		12,
		13,
		15
	},
	interval_min = 15,
	interval_max = 30,
	time_to_block = 3,
	taps_to_remove = 5,
	block_duration = 6
}
b.specials.stage_11.spider_mechanics.eggs_spawn = {
	time_to_spawn = 5
}
b.specials.stage_11.spider_mechanics.rappel = {
	node_variation = 10
}
b.specials.stage_11.webs = {
	speed_factor = 1.25,
	slow_factor = 0.7,
	mod_duration = 0.25,
	range = 60
}
b.specials.stage_12 = {
	troll_rappel = {}
}
b.specials.stage_12.troll_rappel.node_variation = 8
b.specials.terrain_3 = {
	blocked_holders = {}
}
b.specials.terrain_3.blocked_holders.price = 120
b.specials.stage_14 = {
	graveyard = {}
}
b.specials.stage_14.graveyard.dead_time = 1
b.specials.stage_14.graveyard.spawn_interval = 1
b.specials.stage_14.graveyard.small_skeleton_hp_threshold = 599
b.specials.stage_14.graveyard.big_skeleton_hp_threshold = 1e+99
b.specials.stage_15 = {
	lord_blackburn = {}
}
b.specials.stage_15.lord_blackburn.hp_max = {
	450,
	650,
	800
}
b.specials.stage_15.lord_blackburn.armor = {
	0.3,
	0.5,
	0.6
}
b.specials.stage_15.lord_blackburn.magic_armor = {
	0,
	0,
	0
}
b.specials.stage_15.lord_blackburn.regen_health = {
	36,
	44,
	64
}
b.specials.stage_15.lord_blackburn.max_speed = 45
b.specials.stage_15.lord_blackburn.dead_lifetime = 18
b.specials.stage_15.lord_blackburn.basic_attack = {
	cooldown = 2,
	range = 75,
	damage_min = {
		26,
		34,
		52
	},
	damage_max = {
		40,
		50,
		78
	},
	damage_type = DAMAGE_PHYSICAL
}
b.specials.stage_15.lord_blackburn.explosion_radius = 120
b.specials.stage_15.swamp = {
	spawn_interval = 1,
	spawn_cooldown = 3
}
b.specials.stage_15.easter_egg_simpsons = {
	fish_duration = 15,
	min_time = 20,
	max_time = 80
}
b.specials.stage_18 = {
	veznan = {}
}
b.specials.stage_18.veznan.cast_time = 1
b.specials.stage_18.veznan.global_cooldown = 2
b.specials.stage_18.veznan.taunt_cooldown_min = 12
b.specials.stage_18.veznan.taunt_cooldown_max = 24
b.specials.stage_18.veznan.gem_blast = {
	start_wave = 2,
	cooldown = 15,
	count = 4,
	radius = 300,
	damage_min = 180,
	damage_max = 240
}
b.specials.stage_18.veznan.disable_towers = {
	default_count = 2,
	default_group = "*",
	click_time = 4,
	lock_duration = 6,
	taps_to_free = 3,
	taps_to_free_touch = 5
}
b.specials.stage_18.veznan.summon = {
	default_path = 1,
	default_group = 1,
	groups = {
		{
			{
				2,
				0,
				"enemy_demon_spawn"
			},
			{
				1,
				0.8,
				"enemy_demon_spawn"
			},
			{
				3,
				1,
				"enemy_demon_spawn"
			},
			{
				2,
				0.8,
				"enemy_demon_spawn"
			},
			{
				1,
				1.2,
				"enemy_demon_spawn"
			}
		},
		{
			{
				2,
				0,
				"enemy_demon_hound"
			},
			{
				1,
				1.6,
				"enemy_demon_hound"
			},
			{
				3,
				1,
				"enemy_demon_hound"
			},
			{
				2,
				0.8,
				"enemy_demon_hound"
			}
		},
		{
			{
				2,
				0,
				"enemy_demon_spawn"
			},
			{
				1,
				0.8,
				"enemy_demon_spawn"
			},
			{
				3,
				0.8,
				"enemy_demon_lord"
			},
			{
				2,
				1,
				"enemy_demon_flareon"
			},
			{
				1,
				1.2,
				"enemy_demon_flareon"
			}
		},
		{
			{
				2,
				0,
				"enemy_demon_imp"
			},
			{
				1,
				1,
				"enemy_demon_imp"
			},
			{
				3,
				1,
				"enemy_demon_imp"
			}
		}
	}
}
b.specials.stage_18.veznan.boss = {
	hp_max = {
		5666,
		6666,
		7666,
		8666
	},
	speed = 10,
	spawn_delay = 4,
	basic_attack = {}
}
b.specials.stage_18.veznan.boss.basic_attack.cooldown = 2.2
b.specials.stage_18.veznan.boss.basic_attack.damage_min = 250
b.specials.stage_18.veznan.boss.basic_attack.damage_max = 350
b.specials.stage_18.veznan.boss.basic_attack.damage_radius = 75
b.specials.stage_18.veznan.boss.gem_blast = {
	cooldown = 5,
	count = 1,
	radius = 260,
	min_radius = 100
}
b.specials.stage_18.veznan.boss.skill_master_delay = 2
b.specials.stage_18.veznan.boss.disable_towers = {
	cooldown = 15,
	count = 2,
	radius = 300
}
b.specials.stage_18.veznan.boss.siphon = {
	cooldown = 7,
	count = 5,
	radius = 250,
	min_radius = 0,
	damage_min = 550,
	damage_max = 750,
	heal_per_soul = 100,
	soul_time = 0.5,
	stagger = 0.25
}
b.specials.stage_18.veznan.boss.reveal_full_heal = true
b.specials.stage_18.veznan.boss.reveal = {
	loop_time = 4,
	soul_count = 12,
	soul_time = 0.8,
	soul_fade = 0.3,
	soul_offset_x = 250,
	soul_offset_y = {
		200,
		300
	},
	soul_curve = {
		60,
		120
	},
	taunt_pre_delay = 1,
	taunt_post_delay = 1,
	hero_damage_min = 0,
	hero_damage_max = 0,
	hero_stun_duration = 14
}
b.specials.stage_18.veznan.boss.illusion_blast = {
	radius = 200,
	soul_time = 2,
	soul_offset_x = 150,
	soul_offset_y = {
		200,
		300
	},
	death_soul_count = 15
}
b.specials.stage_18.veznan.boss.moloch_stun_duration = 4
b.specials.stage_18.veznan.boss.skill_stagger = 4
b.specials.stage_18.veznan.boss.real = {
	hp_max = {
		5999,
		6999,
		7999,
		9999
	},
	center_reveal = true,
	disable_towers_off = true
}
b.specials.stage_18.veznan.boss.melee_engage = {
	cooldown = 0,
	duration = 3
}
b.specials.stage_18.moloch = {
	cast_time = 1,
	global_cooldown = 2,
	claw_slam = {}
}
b.specials.stage_18.moloch.claw_slam.pos = {
	x = 812,
	y = 348
}
b.specials.stage_18.moloch.claw_slam.telegraph_time = 4.3
b.specials.stage_18.moloch.claw_slam.damage_radius = 280
b.specials.stage_18.moloch.claw_slam.tower_stun_duration = 3.5
b.specials.stage_18.moloch.claw_slam.shock_radius = 450
b.specials.stage_18.moloch.claw_slam.shock_damage_max = 700
b.specials.stage_18.moloch.claw_slam.shock_damage_min = 100
b.specials.stage_18.moloch.lava_ball = {
	count = 1,
	damage_min = 200,
	damage_max = 250,
	damage_radius = 90,
	speed = 1500,
	target_warn_time = 4,
	areas = {
		{
			range = 150,
			pos = {
				x = 383,
				y = 333
			}
		},
		{
			range = 100,
			pos = {
				x = 198,
				y = 355
			}
		},
		{
			range = 150,
			pos = {
				x = 415,
				y = 441
			}
		}
	},
	fire_duration = 5,
	fire_radius = 70,
	fire_cycle_time = 0.4,
	burn_duration = 3,
	burn_damage_min = 8,
	burn_damage_max = 12,
	spawn_template = "enemy_magma_elemental",
	exit_safezone = 300,
	unit_snap_radius = 80,
	paths = {
		9,
		13,
		15,
		17,
		22
	}
}
b.specials.stage_18.moloch.hellspawn_boost = {
	dmg_factor = 1.5,
	duration = 8,
	allowed_templates = {
		"enemy_demon_spawn",
		"enemy_demon_hound",
		"enemy_demon_imp",
		"enemy_demon_flareon",
		"enemy_demon_lord",
		"enemy_magma_elemental"
	}
}
b.specials.towers = {
	stage_04_crane = {}
}
b.specials.towers.stage_04_crane.attack_cost = 30
b.specials.towers.stage_04_crane.attack_cost_iron = 30
b.specials.towers.stage_04_crane.attack = {
	damage_min = 60,
	damage_max = 120,
	damage_radius = 60,
	range = 1400,
	damage_type = DAMAGE_EXPLOSION
}
b.specials.towers.stage_07_barn = {
	knight_cost = 50,
	max_soldiers = 3,
	soldier = {}
}
b.specials.towers.stage_07_barn.soldier.armor = 0.25
b.specials.towers.stage_07_barn.soldier.dead_lifetime = 12
b.specials.towers.stage_07_barn.soldier.hp = 100
b.specials.towers.stage_07_barn.soldier.regen_hp = 0
b.specials.towers.stage_07_barn.soldier.speed = 60
b.specials.towers.stage_07_barn.soldier.basic_attack = {
	damage_min = 4,
	damage_max = 6,
	cooldown = 1,
	range = 65
}
b.specials.towers.stage_08_catapult = {
	attack = {}
}
b.specials.towers.stage_08_catapult.attack.price = 50
b.specials.towers.stage_08_catapult.attack.damage_min = 100
b.specials.towers.stage_08_catapult.attack.damage_max = 150
b.specials.towers.stage_08_catapult.attack.damage_radius = 80
b.specials.towers.stage_08_catapult.attack.damage_type = DAMAGE_EXPLOSION
b.specials.towers.stage_11_tower_camp = {
	wave_level_up = {
		5,
		10
	},
	max_soldiers = {
		1,
		2,
		2
	},
	fire_arrow = {}
}
b.specials.towers.stage_11_tower_camp.fire_arrow.cooldown = 1.5
b.specials.towers.stage_11_tower_camp.fire_arrow.cost = 50
b.specials.towers.stage_11_tower_camp.attack = {
	range = 300,
	cooldown = 1,
	bullet = {}
}
b.specials.towers.stage_11_tower_camp.attack.bullet.damage_min = 10
b.specials.towers.stage_11_tower_camp.attack.bullet.damage_max = 16
b.specials.towers.stage_11_tower_camp.attack.bullet.damage_type = DAMAGE_PHYSICAL
b.specials.towers.stage_11_tower_camp.prices = {
	0,
	400,
	600
}
b.specials.towers.stage_11_tower_camp.soldier = {
	hp = 100,
	armor = 0,
	dead_lifetime = {
		30,
		30,
		26
	},
	regen_hp = 100,
	speed = 40,
	basic_attack = {}
}
b.specials.towers.stage_11_tower_camp.soldier.basic_attack.damage_min = 4
b.specials.towers.stage_11_tower_camp.soldier.basic_attack.damage_max = 6
b.specials.towers.stage_11_tower_camp.soldier.basic_attack.cooldown = 1
b.specials.towers.stage_11_tower_camp.soldier.basic_attack.range = 65
b.specials.towers.stage_13_sunray_tower = {
	price = 200,
	health_boss_hits = 3,
	sunray = {}
}
b.specials.towers.stage_13_sunray_tower.sunray.points_to_charge = 28
b.specials.towers.stage_13_sunray_tower.sunray.points_per_second = {
	0.61,
	0.74,
	0.87,
	1
}
b.specials.towers.stage_13_sunray_tower.sunray.sorcerers_to_charge = 1
b.specials.towers.stage_13_sunray_tower.sunray.sorcerer_spawn_time = 6
b.specials.towers.stage_13_sunray_tower.sunray.min_range = 0
b.specials.towers.stage_13_sunray_tower.sunray.max_range = 1500
b.specials.towers.stage_13_sunray_tower.sunray.bullet = {
	ray_duration = 2,
	cycle_time = 0.1,
	damage_min = 75,
	damage_max = 75,
	damage_radius = 50,
	damage_type = DAMAGE_TRUE
}
b.specials.towers.stage_13_sunray_tower.sunray.bullet_boss = {
	cycle_time = 0.25,
	damage_min = 40,
	damage_max = 50,
	damage_type = DAMAGE_TRUE
}
b.specials.towers.stage_13_sunray_tower.sorcerer = {
	time_to_reach_path = 4.3,
	armor = 0,
	dead_lifetime = 12,
	hp = 120,
	regen_hp = 0,
	speed = 50,
	basic_attack = {}
}
b.specials.towers.stage_13_sunray_tower.sorcerer.basic_attack.damage_min = 4
b.specials.towers.stage_13_sunray_tower.sorcerer.basic_attack.damage_max = 6
b.specials.towers.stage_13_sunray_tower.sorcerer.basic_attack.cooldown = 1
b.specials.towers.stage_13_sunray_tower.sorcerer.basic_attack.range = 35
b.specials.towers.stage_13_sunray_obelisk = {
	price = 150,
	sunray = {}
}
b.specials.towers.stage_13_sunray_obelisk.sunray.points_to_charge = 2
b.specials.towers.stage_13_sunray_obelisk.sunray.shots = 10
b.specials.towers.stage_13_sunray_obelisk.sunray.time_between_shots = fts(8)
b.specials.towers.stage_13_sunray_obelisk.sunray.min_range = 0
b.specials.towers.stage_13_sunray_obelisk.sunray.max_range = 200
b.specials.towers.stage_13_sunray_obelisk.sunray.bullet = {
	damage_min = 48,
	damage_max = 72,
	damage_type = DAMAGE_TRUE
}
b.specials.towers.stage_14_blacksmith = {
	towers_to_start_effect = 3,
	skill_a = {}
}
b.specials.towers.stage_14_blacksmith.skill_a.price = {
	150,
	150,
	150
}
b.specials.towers.stage_14_blacksmith.skill_a.aura = {
	radius = 250,
	dmg_factor = {
		1.1,
		1.2,
		1.35
	}
}
b.specials.towers.stage_14_blacksmith.skill_a.aura.s_dmg_factor = {
	sub_one(b.specials.towers.stage_14_blacksmith.skill_a.aura.dmg_factor[1]),
	sub_one(b.specials.towers.stage_14_blacksmith.skill_a.aura.dmg_factor[2]),
	sub_one(b.specials.towers.stage_14_blacksmith.skill_a.aura.dmg_factor[3])
}
b.specials.towers.stage_14_blacksmith.skill_a.aura.armor_factor = {
	0.1,
	0.2,
	0.35
}
b.specials.towers.stage_14_tavern = {
	towers_to_start_effect = 3,
	beer = {}
}
b.specials.towers.stage_14_tavern.beer.cooldown = 15
b.specials.towers.stage_14_tavern.beer.min_injury = 0.5
b.specials.towers.stage_14_tavern.beer.radius = 60
b.specials.towers.stage_14_tavern.beer.max_targets = 5
b.specials.towers.stage_14_tavern.beer.mod = {
	duration = 3,
	heal_every = 0.25,
	heal_per_second_min = 20,
	heal_per_second_max = 20
}
b.specials.towers.stage_14_tavern.aura = {
	radius = 250,
	respawn_time_reduction = 2
}
b.specials.towers.stage_14_armory = {
	price = 200,
	rally_range = 200,
	skill_a = {}
}
b.specials.towers.stage_14_armory.skill_a.price = {
	150
}
b.specials.towers.stage_14_armory.skill_b = {
	price = {
		100,
		100,
		100
	},
	respawn_times = {
		14,
		12,
		10
	}
}
b.specials.towers.stage_14_armory.soldier = {
	hp = {
		100,
		180
	},
	armor = {
		0.1,
		0.2
	},
	dead_lifetime = 16,
	regen_hp = {
		8,
		14
	},
	speed = {
		60,
		60
	},
	basic_attack = {}
}
b.specials.towers.stage_14_armory.soldier.basic_attack.damage_min = {
	4,
	6
}
b.specials.towers.stage_14_armory.soldier.basic_attack.damage_max = {
	6,
	10
}
b.specials.towers.stage_14_armory.soldier.basic_attack.damage_radius = {
	0,
	50
}
b.specials.towers.stage_14_armory.soldier.basic_attack.cooldown = 1
b.specials.towers.stage_14_armory.soldier.basic_attack.range = {
	65,
	65
}
b.specials.towers.stage_16_treant_attacker = {
	basic_attack = {}
}
b.specials.towers.stage_16_treant_attacker.basic_attack.range = 180
b.specials.towers.stage_16_treant_attacker.basic_attack.bullet_count = 3
b.specials.towers.stage_16_treant_attacker.basic_attack.cooldown = 4.5
b.specials.towers.stage_16_treant_attacker.basic_attack.bullet = {
	damage_min = 30,
	damage_max = 50,
	damage_radius = 50,
	damage_type = DAMAGE_EXPLOSION
}
b.specials.towers.stage_16_treant_killer = {
	basic_attack = {}
}
b.specials.towers.stage_16_treant_killer.basic_attack.range = 180
b.specials.towers.stage_16_treant_killer.basic_attack.bullet_count = 3
b.specials.towers.stage_16_treant_killer.basic_attack.cooldown = 40
b.specials.towers.stage_16_treant_killer.instakill = {
	detection_radius = 170,
	radius = 50
}
b.specials.towers.stage_16_treant_healer = {
	aura = {}
}
b.specials.towers.stage_16_treant_healer.aura.range = 180
b.specials.towers.stage_16_treant_healer.aura.cycle_time = 0.5
b.specials.towers.stage_16_treant_healer.aura.heal = {
	duration = 0.6,
	heal_every = 0.25,
	heal_per_second_min = 5,
	heal_per_second_max = 5
}
b.specials.towers.stage_16_treant_rooter = {
	aura = {}
}
b.specials.towers.stage_16_treant_rooter.aura.range = 175
b.specials.towers.stage_16_treant_rooter.aura.cycle_time = 0.5
b.specials.towers.stage_16_treant_rooter.aura.slow = {
	duration = 0.6,
	slow_factor = 0.6
}
b.specials.towers.stage_17_paladin_barracks = {
	knight_cost = 50,
	max_soldiers = 3,
	soldier = {}
}
b.specials.towers.stage_17_paladin_barracks.soldier.armor = 0.25
b.specials.towers.stage_17_paladin_barracks.soldier.dead_lifetime = 5
b.specials.towers.stage_17_paladin_barracks.soldier.hp = 100
b.specials.towers.stage_17_paladin_barracks.soldier.regen_hp = 0
b.specials.towers.stage_17_paladin_barracks.soldier.speed = 60
b.specials.towers.stage_17_paladin_barracks.soldier.basic_attack = {
	damage_min = 4,
	damage_max = 6,
	cooldown = 1,
	range = 65
}
b.specials.heroes = {
	hero_alleria = {}
}
b.specials.heroes.hero_alleria.dead_lifetime = 30
b.specials.heroes.hero_alleria.speed = 70
b.specials.heroes.hero_alleria.regen_cooldown = 1
b.specials.heroes.hero_alleria.armor = 0
b.specials.heroes.hero_alleria.hp_max = 160
b.specials.heroes.hero_alleria.regen_health = 13
b.specials.heroes.hero_alleria.regen_tree_mult = 1.5
b.specials.heroes.hero_alleria.basic_melee = {
	cooldown = 1,
	damage_min = 8,
	damage_max = 13,
	damage_type = DAMAGE_PHYSICAL
}
b.specials.heroes.hero_alleria.basic_ranged = {
	cooldown = 1,
	min_range = 70,
	max_range = 150,
	damage_min = 8,
	damage_max = 13,
	damage_type = DAMAGE_PHYSICAL
}
b.specials.heroes.hero_alleria.multishot = {
	cooldown = 20,
	damage_min = 8,
	damage_max = 14,
	damage_type = DAMAGE_PHYSICAL,
	max_range = 200,
	min_range = 100,
	min_targets = 3,
	shots = 3
}
b.specials.heroes.hero_alleria.wildcat = {
	cooldown = 28,
	min_targets = 2,
	soldier = {}
}
b.specials.heroes.hero_alleria.wildcat.soldier.armor = 0
b.specials.heroes.hero_alleria.wildcat.soldier.dead_lifetime = 12
b.specials.heroes.hero_alleria.wildcat.soldier.hp = 80
b.specials.heroes.hero_alleria.wildcat.soldier.regen_hp = 6
b.specials.heroes.hero_alleria.wildcat.soldier.speed = 80
b.specials.heroes.hero_alleria.wildcat.soldier.duration = 15
b.specials.heroes.hero_alleria.wildcat.soldier.basic_attack = {
	damage_min = 6,
	damage_max = 9,
	damage_type = DAMAGE_PHYSICAL,
	cooldown = 1,
	range = 150
}
b.specials.heroes.hero_denas = {
	dead_lifetime = 27,
	speed = 110,
	armor = 0.5,
	hp_max = 750,
	regen_health = 60,
	basic_melee = {}
}
b.specials.heroes.hero_denas.basic_melee.cooldown = 2
b.specials.heroes.hero_denas.basic_melee.damage_min = 35
b.specials.heroes.hero_denas.basic_melee.damage_max = 50
b.specials.heroes.hero_denas.basic_melee.damage_type = DAMAGE_PHYSICAL
b.specials.heroes.hero_denas.mighty_slash = {
	cooldown = 6,
	damage_min = 100,
	damage_max = 120
}
b.specials.heroes.hero_denas.bombardement = {
	cooldown = 20,
	max_range = 300,
	min_targets = 3,
	cluster_radius = 75,
	shots = 1,
	edge_margin = 150,
	hero_margin = 100,
	enter_scale = 1.7,
	arrive_scale = 0.7,
	damage_min = 200,
	damage_max = 450,
	radius = 60,
	damage_type = DAMAGE_EXPLOSION
}
b.specials.heroes.hero_denas.denas_guards = {
	cooldown = 15,
	range_nodes_min = 0,
	range_nodes_max = 30,
	max_path_dist = 60,
	ahead_nodes = 5,
	soldier = {}
}
b.specials.heroes.hero_denas.denas_guards.soldier.duration = 12
b.specials.heroes.hero_denas.denas_guards.soldier.hp_max = 150
b.specials.heroes.hero_denas.denas_guards.soldier.armor = 0.35
b.specials.heroes.hero_denas.denas_guards.soldier.regen_health = 8
b.specials.heroes.hero_denas.denas_guards.soldier.max_speed = 64
b.specials.heroes.hero_denas.denas_guards.soldier.melee_attack = {
	cooldown = 1,
	damage_min = 8,
	damage_max = 12,
	range = 72
}
b.specials.heroes.hero_denas.rally_speed_boost = {
	min_dist = 100,
	speed_factor = 1.5
}
b.powers = {
	reinforcements = {}
}
b.powers.reinforcements.xp_per_use = 100
b.powers.reinforcements.stats = {
	type = "summon",
	cooldown = 9.5,
	hp = 4
}
b.powers.reinforcements.soldier = {
	cooldown = 15,
	duration = 12,
	hp_max = 40,
	regen_health = 8,
	armor = 0,
	max_speed = 64,
	melee_attack = {}
}
b.powers.reinforcements.soldier.melee_attack.cooldown = 1
b.powers.reinforcements.soldier.melee_attack.damage_min = 2
b.powers.reinforcements.soldier.melee_attack.damage_max = 4
b.powers.reinforcements.soldier.melee_attack.range = 72
b.powers.reinforcements.special_soldier = {
	cooldown = 16,
	duration = 12,
	hp_max = 140,
	regen_health = 11,
	armor = 0.4,
	spiked_armor = 0,
	max_speed = 64,
	melee_attack = {}
}
b.powers.reinforcements.special_soldier.melee_attack.cooldown = 1
b.powers.reinforcements.special_soldier.melee_attack.damage_min = 10
b.powers.reinforcements.special_soldier.melee_attack.damage_max = 14
b.powers.reinforcements.special_soldier.melee_attack.range = 72
b.powers.reinforcements.special_soldier.aura_range = 70
b.powers.reinforcements.special_soldier.aura_duration = 0.2
b.powers.reinforcements.special_soldier.aura_cycle_time = 0.2
b.powers.reinforcements.special_soldier.buff_duration = 12
b.powers.reinforcements.special_soldier.buff_dmg_factor = 1.1
b.powers.reinforcements.special_soldier.s_buff_dmg_factor = sub_one(b.powers.reinforcements.special_soldier.buff_dmg_factor)
b.powers.reinforcements.special_soldier.buff_armor_max_factor = 0.15
b.powers.rain_of_fire = {
	cooldown = 60,
	min_spread = 25,
	max_spread = 40,
	meteor_count = 3,
	xp_per_use = 400,
	stats = {}
}
b.powers.rain_of_fire.stats.type = "damage"
b.powers.rain_of_fire.stats.cooldown = 4.5
b.powers.rain_of_fire.stats.damage = 6.5
b.powers.rain_of_fire.bullet = {
	radius = 60,
	damage_type = DAMAGE_TRUE,
	damage_min = 30,
	damage_max = 45
}
b.powers.royal_edict = {
	cooldown = 50,
	duration = 0.5,
	range = 200,
	buff_dmg_factor = 1.75
}
b.powers.royal_edict.s_buff_dmg_factor = sub_one(b.powers.royal_edict.buff_dmg_factor)
b.powers.royal_edict.mod_duration = 6
b.powers.royal_edict.xp_per_use = 320
b.powers.royal_edict.stats = {
	type = "utility",
	cooldown = 5.5,
	range = 8
}
b.powers.soaring_shop = {
	duration = 20,
	max_speed = 64,
	cooldown = 50,
	xp_per_use = 320,
	attack_1 = {}
}
b.powers.soaring_shop.attack_1.damage_type = DAMAGE_EXPLOSION
b.powers.soaring_shop.attack_1.radius = 50
b.powers.soaring_shop.attack_1.damage_min = 15
b.powers.soaring_shop.attack_1.damage_max = 25
b.powers.soaring_shop.attack_1.cooldown = 0.64
b.powers.soaring_shop.attack_1.range = 200
b.powers.soaring_shop.attack_1.special_1_rate = 3
b.powers.soaring_shop.attack_1.special_2_rate = 5
b.powers.soaring_shop.attack_1.prediction = fts(10)
b.powers.soaring_shop.attack_2 = {
	stun_duration = 1.5,
	damage_type = DAMAGE_EXPLOSION,
	radius = 75,
	damage_min = 10,
	damage_max = 20,
	cooldown = 20,
	range = 200
}
b.powers.soaring_shop.attack_3 = {
	damage_type = DAMAGE_EXPLOSION,
	radius = 90,
	damage_min = 100,
	damage_max = 300,
	cooldown = 10,
	range = 60,
	prediction = fts(6)
}
b.powers.soaring_shop.bottom_info_stats = {
	hp = 10,
	hp_max = 10,
	damage_min = b.powers.soaring_shop.attack_1.damage_min,
	damage_max = b.powers.soaring_shop.attack_1.damage_max,
	armor = 1,
	respawn = 10,
	cooldown = b.powers.soaring_shop.cooldown
}
b.powers.soaring_shop.stats = {
	type = "damage",
	cooldown = 5.5,
	damage = 5.5
}
b.powers.aspect_of_sol = {
	cooldown = 60,
	summon_target_radius = 50,
	xp_per_use = 400,
	stats = {}
}
b.powers.aspect_of_sol.stats.type = "summon"
b.powers.aspect_of_sol.stats.cooldown = 4.5
b.powers.aspect_of_sol.stats.hp = 10
b.powers.aspect_of_sol.soldier = {
	hp_max = 750,
	armor = 0.5,
	magic_armor = 0,
	max_speed = 30,
	duration = 18,
	melee_attack = {}
}
b.powers.aspect_of_sol.soldier.melee_attack.cooldown = 1.5
b.powers.aspect_of_sol.soldier.melee_attack.damage_min = 42
b.powers.aspect_of_sol.soldier.melee_attack.damage_max = 64
b.powers.aspect_of_sol.soldier.melee_attack.range = 72
b.powers.aspect_of_sol.soldier.melee_attack.damage_type = DAMAGE_TRUE
b.powers.aspect_of_sol.soldier.melee_attack.boss_damage_cap = 0.5
b.powers.aspect_of_sol.soldier.melee_attack.miniboss_damage_cap = 1
b.powers.aspect_of_sol.soldier.special_attack = {
	damage_min = 98,
	damage_max = 146,
	damage_type = DAMAGE_TRUE,
	boss_damage_cap = 0.5,
	miniboss_damage_cap = 1
}
b.powers.aspect_of_sol.warcry = {
	duration = 5,
	dmg_factor_inc = 1.3
}
b.powers.aspect_of_sol.warcry.s_dmg_factor_inc = sub_one(b.powers.aspect_of_sol.warcry.dmg_factor_inc)
b.powers.aspect_of_sol.warcry.armor_inc = 0.3
b.powers.aspect_of_sol.warcry.cooldown = 30
b.powers.aspect_of_sol.warcry.max_range = 100
b.powers.aspect_of_sol.warcry.slow_duration = 6
b.powers.aspect_of_sol.warcry.slow_factor = 0.5
b.powers.aspect_of_sol.warcry.s_slow_factor = 0.5
b.powers.aspect_of_sol.warcry.radius = 80
b.powers.aspect_of_sol.on_summon = {
	stun_duration = 2,
	radius = 100,
	damage_type = DAMAGE_TRUE,
	boss_damage_cap = 0.5,
	miniboss_damage_cap = 0.5
}
b.powers.aspect_of_sol.on_select_enemy = {
	damage = 300,
	damage_type = DAMAGE_TRUE,
	max_boss_damage = 300,
	max_miniboss_damage = 300
}
b.powers.aspect_of_sol.spawn_with_beam = false
b.powers.teleportation_sigil = {
	cooldown = 45,
	xp_per_use = 280,
	sigil_duration = 40,
	nodes_to_teleport = 50,
	nodes_limit = 10,
	tp_duration = 1,
	enemy_max_tp_count = 4,
	max_tp_count = 4,
	range = 50,
	stats = {}
}
b.powers.teleportation_sigil.stats.type = "utility"
b.powers.teleportation_sigil.stats.cooldown = 6
b.powers.teleportation_sigil.stats.range = 4
b.powers.wintersongs_wrath = {
	cooldown = 40,
	xp_per_use = 280,
	duration = 8,
	slow_factor = 0.6,
	s_slow_factor = 0.4,
	radius = 120,
	cycle_time = 0.1,
	stats = {}
}
b.powers.wintersongs_wrath.stats.type = "utility"
b.powers.wintersongs_wrath.stats.cooldown = 6.5
b.powers.wintersongs_wrath.stats.range = 5
b.powers.thunder_zapper = {
	cooldown = 50,
	xp_per_use = 320,
	duration = 10,
	max_speed = 60,
	spawn_detection_range = 80,
	damage_aura = {}
}
b.powers.thunder_zapper.damage_aura.damage_min = 6
b.powers.thunder_zapper.damage_aura.damage_max = 10
b.powers.thunder_zapper.damage_aura.s_damage_min = 240
b.powers.thunder_zapper.damage_aura.s_damage_max = 400
b.powers.thunder_zapper.damage_aura.damage_type = DAMAGE_TRUE
b.powers.thunder_zapper.damage_aura.radius = 80
b.powers.thunder_zapper.damage_aura.cycle_time = 0.25
b.powers.thunder_zapper.summon_aura = {
	damage_min = 30,
	damage_max = 42,
	damage_type = DAMAGE_TRUE,
	damage_radius = 110
}
b.powers.thunder_zapper.stats = {
	type = "damage",
	cooldown = 5.5,
	damage = 5.5
}
b.powers.musketeers = {
	xp_per_use = 133,
	cooldown = 20,
	stats = {}
}
b.powers.musketeers.stats.type = "summon"
b.powers.musketeers.stats.cooldown = 9
b.powers.musketeers.stats.hp = 2
b.powers.musketeers.soldier = {
	duration = 12,
	hp_max = 30,
	regen_health = 5,
	armor = 0,
	max_speed = 80,
	melee_attack = {}
}
b.powers.musketeers.soldier.melee_attack.cooldown = 1.5
b.powers.musketeers.soldier.melee_attack.damage_min = 2
b.powers.musketeers.soldier.melee_attack.damage_max = 4
b.powers.musketeers.soldier.melee_attack.range = 50
b.powers.musketeers.soldier.basic_ranged = {
	cooldown = 1.5,
	xp_gain_factor = 0.8,
	min_range = 20,
	max_range = 220,
	damage_min = 10,
	damage_max = 16,
	damage_type = DAMAGE_PHYSICAL
}
b.upgrades = {
	power_reinforcements = {}
}
b.upgrades.power_reinforcements.l2a = {
	duration_extra = 5
}
b.upgrades.power_reinforcements.l2b = {
	dmg_factor = 1.5
}
b.upgrades.power_reinforcements.l2b.s_damage_factor = sub_one(b.upgrades.power_reinforcements.l2b.dmg_factor)
b.upgrades.power_reinforcements.l3 = {
	armor = 0.4,
	hp_factor = 1.15
}
b.upgrades.power_reinforcements.l3.s_hp_factor = sub_one(b.upgrades.power_reinforcements.l3.hp_factor)
b.upgrades.power_reinforcements.l4a = {
	mov_speed_factor = 1.2,
	cooldown_decrease = 3
}
b.upgrades.power_reinforcements.l4b = {
	armor_increase = 0.15
}
b.upgrades.power_reinforcements.l5a = {
	dmg_factor = 1.5
}
b.upgrades.power_reinforcements.l5a.s_dmg_factor = sub_one(b.upgrades.power_reinforcements.l5a.dmg_factor)
b.upgrades.power_reinforcements.l5a.hp_factor = 1.15
b.upgrades.power_reinforcements.l5a.s_hp_factor = sub_one(b.upgrades.power_reinforcements.l5a.hp_factor)
b.upgrades.power_reinforcements.l5b = {
	spiked_armor = 0.2
}
b.upgrades.power_reinforcements.l6 = {}
b.upgrades.power_rain_of_fire = {
	l2a = {}
}
b.upgrades.power_rain_of_fire.l2a.cd_reduction = 5
b.upgrades.power_rain_of_fire.l2b = {
	damage_factor = 1.1
}
b.upgrades.power_rain_of_fire.l2b.s_damage_factor = sub_one(b.upgrades.power_rain_of_fire.l2b.damage_factor)
b.upgrades.power_rain_of_fire.l3 = {
	duration = 3,
	burn_duration = 0.5,
	cycle_time = 0.25,
	damage_min = 3,
	damage_max = 5,
	s_damage_min = 36,
	s_damage_max = 60,
	radius = 50,
	damage_type = DAMAGE_TRUE
}
b.upgrades.power_rain_of_fire.l4a = {
	duration_inc = 4,
	damage_inc = 1.5
}
b.upgrades.power_rain_of_fire.l4a.s_damage_inc = sub_one(b.upgrades.power_rain_of_fire.l4a.damage_inc)
b.upgrades.power_rain_of_fire.l4b = {
	meteor_inc = 2
}
b.upgrades.power_rain_of_fire.l5a = {
	duration = 7,
	slow_duration = 0.5,
	slow_factor = 0.5,
	s_slow_factor = 0.5,
	radius = 50,
	cycle_time = 0.3
}
b.upgrades.power_rain_of_fire.l5b = {
	damage_min = 20,
	damage_max = 25,
	damage_radius = 60,
	damage_type = DAMAGE_TRUE
}
b.upgrades.power_rain_of_fire.l6 = {
	cataclysm_count = 5,
	cd_reduction = 10
}
b.upgrades.power_royal_edict = {
	l2a = {}
}
b.upgrades.power_royal_edict.l2a.range_factor = 1.2
b.upgrades.power_royal_edict.l2a.s_range_factor = sub_one(b.upgrades.power_royal_edict.l2a.range_factor)
b.upgrades.power_royal_edict.l3 = {
	range_factor = 1.5
}
b.upgrades.power_royal_edict.l3.s_range_factor = sub_one(b.upgrades.power_royal_edict.l3.range_factor)
b.upgrades.power_royal_edict.l4a = {
	dmg_factor_inc = 0.2
}
b.upgrades.power_royal_edict.l4b = {
	mod = {}
}
b.upgrades.power_royal_edict.l4b.mod.gold = 4
b.upgrades.power_royal_edict.l5b = {
	duration_factor = 1.33
}
b.upgrades.power_royal_edict.l5b.s_duration_factor = sub_one(b.upgrades.power_royal_edict.l5b.duration_factor)
b.upgrades.power_soaring_shop = {
	l2a = {}
}
b.upgrades.power_soaring_shop.l2a.radius_factor = 1.2
b.upgrades.power_soaring_shop.l2a.s_radius_factor = sub_one(b.upgrades.power_soaring_shop.l2a.radius_factor)
b.upgrades.power_soaring_shop.l2b = {
	cd_reduction = 10
}
b.upgrades.power_soaring_shop.l4a = {
	damage_inc = 1.1
}
b.upgrades.power_soaring_shop.l4a.s_damage_inc = sub_one(b.upgrades.power_soaring_shop.l4a.damage_inc)
b.upgrades.power_soaring_shop.l4b = {
	cd_reduction = 5
}
b.upgrades.power_soaring_shop.l5a = {
	cd_reduction = 0.5,
	s_cd_reduction = 1.5
}
b.upgrades.power_soaring_shop.l5b = {
	duration_factor = 1.2,
	s_duration_factor = 24
}
b.upgrades.power_aspect_of_sol = {
	l2a = {}
}
b.upgrades.power_aspect_of_sol.l2a.duration_factor = 1.34
b.upgrades.power_aspect_of_sol.l2a.s_duration_factor = 24
b.upgrades.power_aspect_of_sol.l2b = {
	damage_inc = 1.3
}
b.upgrades.power_aspect_of_sol.l2b.s_damage_inc = sub_one(b.upgrades.power_aspect_of_sol.l2b.damage_inc)
b.upgrades.power_aspect_of_sol.l4a = {
	duration_factor = 2
}
b.upgrades.power_aspect_of_sol.l4a.s_duration_factor = sub_one(b.upgrades.power_aspect_of_sol.l4a.duration_factor)
b.upgrades.power_aspect_of_sol.l6 = {
	damage_min = 120,
	damage_max = 200
}
b.upgrades.power_teleportation_sigil = {
	l2a = {}
}
b.upgrades.power_teleportation_sigil.l2a.duration_factor = 2
b.upgrades.power_teleportation_sigil.l2a.s_duration_factor = 2
b.upgrades.power_teleportation_sigil.l2b = {
	slow_factor = 0.7,
	s_slow_factor = 0.3,
	slow_duration = 4
}
b.upgrades.power_teleportation_sigil.l3 = {
	second_tp_chance = 0.3,
	range = 50
}
b.upgrades.power_teleportation_sigil.l4a = {
	s_cd_reduction = 5
}
b.upgrades.power_teleportation_sigil.l4b = {
	max_tp_count = 6
}
b.upgrades.power_teleportation_sigil.l5a = {
	s_damage_red = 0.5,
	damage_red_duration = 5,
	silence_duration = 5,
	s_debuff_duration = 5
}
b.upgrades.power_teleportation_sigil.l5b = {
	stun_duration = 3
}
b.upgrades.power_teleportation_sigil.l6 = {
	instakill_chance = 0.2,
	instakill_min_hp = 50,
	range = 50
}
b.upgrades.power_thunder_zapper = {
	l2a = {}
}
b.upgrades.power_thunder_zapper.l2a.dmg_factor = 1.5
b.upgrades.power_thunder_zapper.l2a.s_dmg_factor = sub_one(b.upgrades.power_thunder_zapper.l2a.dmg_factor)
b.upgrades.power_thunder_zapper.l2b = {
	duration_factor = 1.2,
	s_duration_factor = 12
}
b.upgrades.power_thunder_zapper.l3 = {
	range = 100,
	cooldown = 2,
	min_targets = 1,
	damage_min = 25,
	damage_max = 35,
	damage_type = DAMAGE_TRUE,
	bounce_range = 100,
	bounce_damage_factor = 1,
	bounce_damage_factor_min = 1,
	bounce_damage_factor_inc = 0
}
b.upgrades.power_thunder_zapper.l4a = {
	cd_reduction = 7.5
}
b.upgrades.power_thunder_zapper.l4b = {
	slow_factor = 0.75
}
b.upgrades.power_thunder_zapper.l4b.s_slow_factor = slow_calc(b.upgrades.power_thunder_zapper.l4b.slow_factor)
b.upgrades.power_thunder_zapper.l4b.slow_duration = 1
b.upgrades.power_thunder_zapper.l5a = {
	radius_factor = 1.25
}
b.upgrades.power_thunder_zapper.l5a.s_radius_factor = sub_one(b.upgrades.power_thunder_zapper.l5a.radius_factor)
b.upgrades.power_thunder_zapper.l5b = {
	stun_duration = 3
}
b.upgrades.power_thunder_zapper.l6 = {
	cooldown = 3,
	damage_min = 80,
	damage_max = 125,
	damage_type = DAMAGE_TRUE,
	damage_radius = 120
}
b.upgrades.power_wintersongs_wrath = {
	l2a = {}
}
b.upgrades.power_wintersongs_wrath.l2a.duration_factor = 1.5
b.upgrades.power_wintersongs_wrath.l2a.s_duration = 12
b.upgrades.power_wintersongs_wrath.l2b = {
	radius_factor = 1.35
}
b.upgrades.power_wintersongs_wrath.l2b.s_radius_factor = sub_one(b.upgrades.power_wintersongs_wrath.l2b.radius_factor)
b.upgrades.power_wintersongs_wrath.l3 = {
	radius = 32,
	damage_min = 24,
	damage_max = 36,
	damage_type = DAMAGE_MAGICAL,
	spike_count = 3,
	distance_between_spikes = 5,
	delay_between_spikes = fts(3),
	cast_delay = 0.05
}
b.upgrades.power_wintersongs_wrath.l4a = {
	spike_count = 6
}
b.upgrades.power_wintersongs_wrath.l4b = {
	slow_factor = 0.3,
	s_slow_factor = 0.7
}
b.upgrades.power_wintersongs_wrath.l5a = {
	damage_inc = 1.3
}
b.upgrades.power_wintersongs_wrath.l5a.s_damage_inc = sub_one(b.upgrades.power_wintersongs_wrath.l5a.damage_inc)
b.upgrades.power_wintersongs_wrath.l5b = {
	stun_duration = 4
}
b.upgrades.power_wintersongs_wrath.l6 = {
	slow_factor = 0.5,
	s_slow_factor = 0.5,
	duration = 6
}
b.upgrades.power_musketeers = {
	l2a = {}
}
b.upgrades.power_musketeers.l2a.duration_inc = 4
b.upgrades.power_musketeers.l2b = {
	range_inc_factor = 1.2
}
b.upgrades.power_musketeers.l2b.s_range_factor = sub_one(b.upgrades.power_musketeers.l2b.range_inc_factor)
b.upgrades.power_musketeers.l2b.movement_factor = 1.2
b.upgrades.power_musketeers.l2b.s_movement_factor = sub_one(b.upgrades.power_musketeers.l2b.movement_factor)
b.upgrades.power_musketeers.l3 = {
	attack_cooldown = 1.3,
	s_attack_cooldown = 0.25,
	damage_inc = 1.5
}
b.upgrades.power_musketeers.l3.s_damage_inc = sub_one(b.upgrades.power_musketeers.l3.damage_inc)
b.upgrades.power_musketeers.l4a = {
	extra_damage = 0.35
}
b.upgrades.power_musketeers.l4b = {
	reduce_armor_factor = 0.5
}
b.upgrades.power_musketeers.l5a = {
	attack_cooldown = 1,
	s_attack_cooldown = 0.25,
	cd_reduction = 2
}
b.upgrades.power_musketeers.l5b = {
	instakill_chance = 0.2,
	hp_threshold = 0.25
}
b.upgrades.power_musketeers.l6 = {
	damage_radius = 50,
	damage_min = 56,
	damage_max = 80,
	damage_type = DAMAGE_EXPLOSION,
	stun_duration = 2
}
b.items = {
	hearts = {}
}
b.items.hearts.lives = 5
b.items.gold = {
	gold = 500
}
b.items.bomb = {
	damage_min = 2000,
	damage_max = 2000
}
b.kr1_mode = {
	towers = {}
}
b.kr1_mode.towers.archers = {
	price = {
		70,
		110,
		160
	},
	basic_attack = {}
}
b.kr1_mode.towers.archers.basic_attack.damage_min = {
	4,
	7,
	10
}
b.kr1_mode.towers.archers.basic_attack.damage_max = {
	6,
	11,
	16
}
b.kr1_mode.towers.archers.basic_attack.cooldown = {
	0.8,
	0.6,
	0.5
}
b.kr1_mode.towers.archers.basic_attack.range = {
	140,
	160,
	180
}
b.kr1_mode.towers.ranger = {
	price = 230,
	basic_attack = {}
}
b.kr1_mode.towers.ranger.basic_attack.damage_min = 13
b.kr1_mode.towers.ranger.basic_attack.damage_max = 19
b.kr1_mode.towers.ranger.basic_attack.cooldown = 0.4
b.kr1_mode.towers.ranger.basic_attack.range = 200
b.kr1_mode.towers.ranger.poison = {
	price = {
		250,
		250,
		250
	},
	mod = {}
}
b.kr1_mode.towers.ranger.poison.mod.duration = 3
b.kr1_mode.towers.ranger.poison.mod.damage_base = 0
b.kr1_mode.towers.ranger.poison.mod.damage_inc = 5
b.kr1_mode.towers.ranger.poison.mod.damage_every = 1
b.kr1_mode.towers.ranger.poison.mod.s0_damage_base = b.kr1_mode.towers.ranger.poison.mod.damage_base + b.kr1_mode.towers.ranger.poison.mod.damage_inc
b.kr1_mode.towers.ranger.poison.mod.s1_damage_base = b.kr1_mode.towers.ranger.poison.mod.s0_damage_base + b.kr1_mode.towers.ranger.poison.mod.damage_inc
b.kr1_mode.towers.ranger.poison.mod.s2_damage_base = b.kr1_mode.towers.ranger.poison.mod.s1_damage_base + b.kr1_mode.towers.ranger.poison.mod.damage_inc
b.kr1_mode.towers.ranger.thorn = {
	price = {
		300,
		150,
		150
	},
	mod = {}
}
b.kr1_mode.towers.ranger.thorn.mod.duration_base = 0.5
b.kr1_mode.towers.ranger.thorn.mod.duration_inc = 0.5
b.kr1_mode.towers.ranger.thorn.mod.s0_duration_base = b.kr1_mode.towers.ranger.thorn.mod.duration_base + b.kr1_mode.towers.ranger.thorn.mod.duration_inc
b.kr1_mode.towers.ranger.thorn.mod.s1_duration_base = b.kr1_mode.towers.ranger.thorn.mod.s0_duration_base + b.kr1_mode.towers.ranger.thorn.mod.duration_inc
b.kr1_mode.towers.ranger.thorn.mod.s2_duration_base = b.kr1_mode.towers.ranger.thorn.mod.s1_duration_base + b.kr1_mode.towers.ranger.thorn.mod.duration_inc
b.kr1_mode.towers.ranger.thorn.mod.damage_min = 20
b.kr1_mode.towers.ranger.thorn.mod.damage_max = 20
b.kr1_mode.towers.ranger.thorn.mod.s_damage_min_max = b.kr1_mode.towers.ranger.thorn.mod.damage_min * 2
b.kr1_mode.towers.ranger.thorn.mod.damage_every = 0.5
b.kr1_mode.towers.ranger.thorn.aura = {
	cooldown = 10,
	radius = 200,
	max_count_base = 2,
	max_count_inc = 2
}
b.kr1_mode.towers.musketeers = {
	price = 230,
	basic_attack = {}
}
b.kr1_mode.towers.musketeers.basic_attack.damage_min = 35
b.kr1_mode.towers.musketeers.basic_attack.damage_max = 65
b.kr1_mode.towers.musketeers.basic_attack.cooldown = 1.5
b.kr1_mode.towers.musketeers.basic_attack.range = 235
b.kr1_mode.towers.musketeers.sniper = {
	price = {
		250,
		250,
		250
	},
	cooldown = 14,
	shoot_time = fts(30),
	damage_factor_inc = 0.2,
	instakill_chance_inc = 0.2
}
b.kr1_mode.towers.musketeers.sniper.s0_instakill_chance = b.kr1_mode.towers.musketeers.sniper.instakill_chance_inc
b.kr1_mode.towers.musketeers.sniper.s1_instakill_chance = b.kr1_mode.towers.musketeers.sniper.s0_instakill_chance + b.kr1_mode.towers.musketeers.sniper.instakill_chance_inc
b.kr1_mode.towers.musketeers.sniper.s2_instakill_chance = b.kr1_mode.towers.musketeers.sniper.s1_instakill_chance + b.kr1_mode.towers.musketeers.sniper.instakill_chance_inc
b.kr1_mode.towers.musketeers.shrapnel = {
	price = {
		300,
		300,
		300
	},
	cooldown = 9,
	range_factor = 0.5,
	min_spread = 12.5,
	max_spread = 32.5,
	damage_min_base = 0,
	damage_min_inc = 10,
	damage_max_base = 0,
	damage_max_inc = 40,
	s_projectile = 6
}
b.kr1_mode.towers.musketeers.shrapnel.s0_damage_min_base = b.kr1_mode.towers.musketeers.shrapnel.damage_min_base + b.kr1_mode.towers.musketeers.shrapnel.damage_min_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.s0_damage_max_base = b.kr1_mode.towers.musketeers.shrapnel.damage_max_base + b.kr1_mode.towers.musketeers.shrapnel.damage_max_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.s1_damage_min_base = b.kr1_mode.towers.musketeers.shrapnel.s0_damage_min_base + b.kr1_mode.towers.musketeers.shrapnel.damage_min_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.s1_damage_max_base = b.kr1_mode.towers.musketeers.shrapnel.s0_damage_max_base + b.kr1_mode.towers.musketeers.shrapnel.damage_max_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.s2_damage_min_base = b.kr1_mode.towers.musketeers.shrapnel.s1_damage_min_base + b.kr1_mode.towers.musketeers.shrapnel.damage_min_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.s2_damage_max_base = b.kr1_mode.towers.musketeers.shrapnel.s1_damage_max_base + b.kr1_mode.towers.musketeers.shrapnel.damage_max_inc * b.kr1_mode.towers.musketeers.shrapnel.s_projectile
b.kr1_mode.towers.musketeers.shrapnel.damage_radius = 48
b.kr1_mode.towers.barracks = {
	price = {
		70,
		110,
		160
	},
	rally_range = {
		145,
		145,
		145
	},
	soldier = {}
}
b.kr1_mode.towers.barracks.soldier.hp_max = {
	50,
	100,
	150
}
b.kr1_mode.towers.barracks.soldier.armor = {
	0,
	0.15,
	0.3
}
b.kr1_mode.towers.barracks.soldier.regen = {
	5,
	7,
	10
}
b.kr1_mode.towers.barracks.soldier.damage_min = {
	1,
	3,
	6
}
b.kr1_mode.towers.barracks.soldier.damage_max = {
	3,
	4,
	10
}
b.kr1_mode.towers.paladins = {
	price = 230,
	rally_range = 145,
	soldier = {}
}
b.kr1_mode.towers.paladins.soldier.hp_max = 200
b.kr1_mode.towers.paladins.soldier.armor = 0.5
b.kr1_mode.towers.paladins.soldier.regen = 25
b.kr1_mode.towers.paladins.soldier.damage_min = 12
b.kr1_mode.towers.paladins.soldier.damage_max = 18
b.kr1_mode.towers.paladins.soldier.movement_speed = 75
b.kr1_mode.towers.paladins.healing = {
	price = {
		150,
		150,
		150
	},
	cooldown = 10,
	min_health_factor = 0.7,
	mod = {}
}
b.kr1_mode.towers.paladins.healing.mod.heal_min_base = 0
b.kr1_mode.towers.paladins.healing.mod.heal_min_inc = 40
b.kr1_mode.towers.paladins.healing.mod.heal_max_base = 0
b.kr1_mode.towers.paladins.healing.mod.heal_max_inc = 60
b.kr1_mode.towers.paladins.healing.mod.s0_heal_min_base = b.kr1_mode.towers.paladins.healing.mod.heal_min_base + b.kr1_mode.towers.paladins.healing.mod.heal_min_inc
b.kr1_mode.towers.paladins.healing.mod.s0_heal_max_base = b.kr1_mode.towers.paladins.healing.mod.heal_max_base + b.kr1_mode.towers.paladins.healing.mod.heal_max_inc
b.kr1_mode.towers.paladins.healing.mod.s1_heal_min_base = b.kr1_mode.towers.paladins.healing.mod.s0_heal_min_base + b.kr1_mode.towers.paladins.healing.mod.heal_min_inc
b.kr1_mode.towers.paladins.healing.mod.s1_heal_max_base = b.kr1_mode.towers.paladins.healing.mod.s0_heal_max_base + b.kr1_mode.towers.paladins.healing.mod.heal_max_inc
b.kr1_mode.towers.paladins.healing.mod.s2_heal_min_base = b.kr1_mode.towers.paladins.healing.mod.s1_heal_min_base + b.kr1_mode.towers.paladins.healing.mod.heal_min_inc
b.kr1_mode.towers.paladins.healing.mod.s2_heal_max_base = b.kr1_mode.towers.paladins.healing.mod.s1_heal_max_base + b.kr1_mode.towers.paladins.healing.mod.heal_max_inc
b.kr1_mode.towers.paladins.shield = {
	price = {
		250
	},
	armor_inc = 0.15
}
b.kr1_mode.towers.paladins.holystrike = {
	price = {
		220,
		150,
		150
	},
	damage_radius = 50,
	damage_min_base = 0,
	damage_min_inc = 25,
	damage_max_base = 0,
	damage_max_inc = 45
}
b.kr1_mode.towers.paladins.holystrike.s0_damage_min_base = b.kr1_mode.towers.paladins.holystrike.damage_min_base + b.kr1_mode.towers.paladins.holystrike.damage_min_inc
b.kr1_mode.towers.paladins.holystrike.s0_damage_max_base = b.kr1_mode.towers.paladins.holystrike.damage_max_base + b.kr1_mode.towers.paladins.holystrike.damage_max_inc
b.kr1_mode.towers.paladins.holystrike.s1_damage_min_base = b.kr1_mode.towers.paladins.holystrike.s0_damage_min_base + b.kr1_mode.towers.paladins.holystrike.damage_min_inc
b.kr1_mode.towers.paladins.holystrike.s1_damage_max_base = b.kr1_mode.towers.paladins.holystrike.s0_damage_max_base + b.kr1_mode.towers.paladins.holystrike.damage_max_inc
b.kr1_mode.towers.paladins.holystrike.s2_damage_min_base = b.kr1_mode.towers.paladins.holystrike.s1_damage_min_base + b.kr1_mode.towers.paladins.holystrike.damage_min_inc
b.kr1_mode.towers.paladins.holystrike.s2_damage_max_base = b.kr1_mode.towers.paladins.holystrike.s1_damage_max_base + b.kr1_mode.towers.paladins.holystrike.damage_max_inc
b.kr1_mode.towers.barbarians = {
	price = 230,
	rally_range = 145,
	soldier = {}
}
b.kr1_mode.towers.barbarians.soldier.hp_max = 250
b.kr1_mode.towers.barbarians.soldier.armor = 0
b.kr1_mode.towers.barbarians.soldier.regen = 30
b.kr1_mode.towers.barbarians.soldier.damage_min = 16
b.kr1_mode.towers.barbarians.soldier.damage_max = 24
b.kr1_mode.towers.barbarians.soldier.multi_hit_factor = {
	0.2,
	0.35,
	0.45
}
b.kr1_mode.towers.barbarians.soldier.movement_speed = 75
b.kr1_mode.towers.barbarians.dual = {
	price = {
		250,
		100,
		100
	},
	damage_inc = 5,
	twister_damage_inc = 20
}
b.kr1_mode.towers.barbarians.dual.s0_damage_inc = b.kr1_mode.towers.barbarians.dual.damage_inc * 2
b.kr1_mode.towers.barbarians.dual.s1_damage_inc = b.kr1_mode.towers.barbarians.dual.s0_damage_inc + b.kr1_mode.towers.barbarians.dual.damage_inc * 2
b.kr1_mode.towers.barbarians.dual.s2_damage_inc = b.kr1_mode.towers.barbarians.dual.s1_damage_inc + b.kr1_mode.towers.barbarians.dual.damage_inc * 2
b.kr1_mode.towers.barbarians.twister = {
	price = {
		150,
		100,
		100
	},
	damage_min = 5,
	damage_max = 25
}
b.kr1_mode.towers.barbarians.twister.s0_damage_min = b.kr1_mode.towers.barbarians.twister.damage_min + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.s0_damage_max = b.kr1_mode.towers.barbarians.twister.damage_max + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.s1_damage_min = b.kr1_mode.towers.barbarians.twister.s0_damage_min + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.s1_damage_max = b.kr1_mode.towers.barbarians.twister.s0_damage_max + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.s2_damage_min = b.kr1_mode.towers.barbarians.twister.s1_damage_min + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.s2_damage_max = b.kr1_mode.towers.barbarians.twister.s1_damage_max + b.kr1_mode.towers.barbarians.dual.twister_damage_inc
b.kr1_mode.towers.barbarians.twister.damage_radius = 50
b.kr1_mode.towers.barbarians.twister.chance_base = 0.1
b.kr1_mode.towers.barbarians.twister.chance_inc = 0.05
b.kr1_mode.towers.barbarians.twister.s0_chance_base = b.kr1_mode.towers.barbarians.twister.chance_base + b.kr1_mode.towers.barbarians.twister.chance_inc
b.kr1_mode.towers.barbarians.twister.s1_chance_base = b.kr1_mode.towers.barbarians.twister.s0_chance_base + b.kr1_mode.towers.barbarians.twister.chance_inc
b.kr1_mode.towers.barbarians.twister.s2_chance_base = b.kr1_mode.towers.barbarians.twister.s1_chance_base + b.kr1_mode.towers.barbarians.twister.chance_inc
b.kr1_mode.towers.barbarians.throwing = {
	price = {
		200,
		100,
		100
	},
	cooldown = 2.5,
	min_range = 55,
	max_range = 155,
	range_inc = 13,
	bullet = {}
}
b.kr1_mode.towers.barbarians.throwing.bullet.damage_min = 24
b.kr1_mode.towers.barbarians.throwing.bullet.damage_max = 32
b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc = 10
b.kr1_mode.towers.barbarians.throwing.bullet.s0_damage_min = b.kr1_mode.towers.barbarians.throwing.bullet.damage_min + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.barbarians.throwing.bullet.s0_damage_max = b.kr1_mode.towers.barbarians.throwing.bullet.damage_max + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.barbarians.throwing.bullet.s1_damage_min = b.kr1_mode.towers.barbarians.throwing.bullet.s0_damage_min + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.barbarians.throwing.bullet.s1_damage_max = b.kr1_mode.towers.barbarians.throwing.bullet.s0_damage_max + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.barbarians.throwing.bullet.s2_damage_min = b.kr1_mode.towers.barbarians.throwing.bullet.s1_damage_min + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.barbarians.throwing.bullet.s2_damage_max = b.kr1_mode.towers.barbarians.throwing.bullet.s1_damage_max + b.kr1_mode.towers.barbarians.throwing.bullet.damage_inc
b.kr1_mode.towers.mages = {
	prices = {
		100,
		160,
		240
	},
	basic_attack = {}
}
b.kr1_mode.towers.mages.basic_attack.damage_min = {
	9,
	23,
	40
}
b.kr1_mode.towers.mages.basic_attack.damage_max = {
	17,
	43,
	74
}
b.kr1_mode.towers.mages.basic_attack.cooldown = {
	1.5,
	1.5,
	1.5
}
b.kr1_mode.towers.mages.basic_attack.range = {
	140,
	160,
	180
}
b.kr1_mode.towers.arcane = {
	prices = 300,
	basic_attack = {}
}
b.kr1_mode.towers.arcane.basic_attack.damage_min = 76
b.kr1_mode.towers.arcane.basic_attack.damage_max = 140
b.kr1_mode.towers.arcane.basic_attack.cooldown = 2
b.kr1_mode.towers.arcane.basic_attack.range = 200
b.kr1_mode.towers.arcane.disintegrate = {
	price = {
		350,
		200,
		200
	},
	cooldown_base = 22,
	cooldown_inc = -2
}
b.kr1_mode.towers.arcane.disintegrate.s1_cooldown_base = b.kr1_mode.towers.arcane.disintegrate.cooldown_base + b.kr1_mode.towers.arcane.disintegrate.cooldown_inc
b.kr1_mode.towers.arcane.disintegrate.s2_cooldown_base = b.kr1_mode.towers.arcane.disintegrate.s1_cooldown_base + b.kr1_mode.towers.arcane.disintegrate.cooldown_inc
b.kr1_mode.towers.arcane.teleport = {
	price = {
		300,
		100,
		100
	},
	cooldown = 14,
	max_count_base = 3,
	max_count_inc = 1
}
b.kr1_mode.towers.arcane.teleport.s1_max_count_base = b.kr1_mode.towers.arcane.teleport.max_count_base + b.kr1_mode.towers.arcane.teleport.max_count_inc
b.kr1_mode.towers.arcane.teleport.s2_max_count_base = b.kr1_mode.towers.arcane.teleport.s1_max_count_base + b.kr1_mode.towers.arcane.teleport.max_count_inc
b.kr1_mode.towers.arcane.teleport.aura = {
	radius = 42.5
}
b.kr1_mode.towers.sorcerer = {
	prices = 300,
	rally_range = 180,
	basic_attack = {}
}
b.kr1_mode.towers.sorcerer.basic_attack.damage_min = 30
b.kr1_mode.towers.sorcerer.basic_attack.damage_max = 64
b.kr1_mode.towers.sorcerer.basic_attack.cooldown = 1.5
b.kr1_mode.towers.sorcerer.basic_attack.range = 200
b.kr1_mode.towers.sorcerer.basic_attack.mod_armor = {
	duration = 5,
	armor_red_factor = -0.5
}
b.kr1_mode.towers.sorcerer.basic_attack.mod_dps = {
	duration = 5,
	damage_min = 10,
	damage_max = 10,
	damage_every = 1.25
}
b.kr1_mode.towers.sorcerer.polymorph = {
	price = {
		300,
		150,
		150
	},
	cooldown_base = 22,
	cooldown_inc = -2
}
b.kr1_mode.towers.sorcerer.polymorph.s1_cooldown_base = b.kr1_mode.towers.sorcerer.polymorph.cooldown_base + b.kr1_mode.towers.sorcerer.polymorph.cooldown_inc
b.kr1_mode.towers.sorcerer.polymorph.s2_cooldown_base = b.kr1_mode.towers.sorcerer.polymorph.s1_cooldown_base + b.kr1_mode.towers.sorcerer.polymorph.cooldown_inc
b.kr1_mode.towers.sorcerer.polymorph.mod = {
	transfer_health_factor = 0.5,
	transfer_speed_factor = 0.8
}
b.kr1_mode.towers.sorcerer.elemental = {
	price = {
		350,
		150,
		150
	},
	soldier = {}
}
b.kr1_mode.towers.sorcerer.elemental.soldier.melee_range = 75
b.kr1_mode.towers.sorcerer.elemental.soldier.regen = 20
b.kr1_mode.towers.sorcerer.elemental.soldier.armor_base = 0.3
b.kr1_mode.towers.sorcerer.elemental.soldier.armor_inc = 0.1
b.kr1_mode.towers.sorcerer.elemental.soldier.hp_max_base = 500
b.kr1_mode.towers.sorcerer.elemental.soldier.hp_max_inc = 100
b.kr1_mode.towers.sorcerer.elemental.soldier.attack_cooldown = 2
b.kr1_mode.towers.sorcerer.elemental.soldier.damage_min = 20
b.kr1_mode.towers.sorcerer.elemental.soldier.damage_max = 40
b.kr1_mode.towers.sorcerer.elemental.soldier.damage_inc = 10
b.kr1_mode.towers.sorcerer.elemental.soldier.damage_radius = 37.5
b.kr1_mode.towers.engineers = {
	prices = {
		125,
		220,
		320
	},
	basic_attack = {}
}
b.kr1_mode.towers.engineers.basic_attack.damage_min = {
	8,
	20,
	30
}
b.kr1_mode.towers.engineers.basic_attack.damage_max = {
	15,
	40,
	60
}
b.kr1_mode.towers.engineers.basic_attack.cooldown = {
	3,
	3,
	3
}
b.kr1_mode.towers.engineers.basic_attack.range = {
	160,
	160,
	160
}
b.kr1_mode.towers.engineers.basic_attack.damage_radius = {
	62.400000000000006,
	62.400000000000006,
	67.2
}
b.kr1_mode.towers.bfg = {
	prices = 400,
	basic_attack = {}
}
b.kr1_mode.towers.bfg.basic_attack.damage_min = 50
b.kr1_mode.towers.bfg.basic_attack.damage_max = 100
b.kr1_mode.towers.bfg.basic_attack.damage_radius = 67.5
b.kr1_mode.towers.bfg.basic_attack.cooldown = 3
b.kr1_mode.towers.bfg.basic_attack.range = 180
b.kr1_mode.towers.bfg.missile = {
	price = {
		250,
		100,
		100
	},
	range_base = 180,
	range_inc_factor = 0.2,
	damage_inc = 40,
	cooldown_mixed = 14.1,
	cooldown_flying = 6.5,
	bullet = {}
}
b.kr1_mode.towers.bfg.missile.bullet.damage_min = 60
b.kr1_mode.towers.bfg.missile.bullet.damage_max = 100
b.kr1_mode.towers.bfg.missile.bullet.s0_damage_min = b.kr1_mode.towers.bfg.missile.bullet.damage_min + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.s0_damage_max = b.kr1_mode.towers.bfg.missile.bullet.damage_max + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.s1_damage_min = b.kr1_mode.towers.bfg.missile.bullet.s0_damage_min + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.s1_damage_max = b.kr1_mode.towers.bfg.missile.bullet.s0_damage_max + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.s2_damage_min = b.kr1_mode.towers.bfg.missile.bullet.s1_damage_min + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.s2_damage_max = b.kr1_mode.towers.bfg.missile.bullet.s1_damage_max + b.kr1_mode.towers.bfg.missile.damage_inc
b.kr1_mode.towers.bfg.missile.bullet.damage_radius = 41.25
b.kr1_mode.towers.bfg.cluster = {
	cooldown = 17,
	price = {
		250,
		150,
		150
	},
	fragment_count_base = 1,
	fragment_count_inc = 2
}
b.kr1_mode.towers.bfg.cluster.s0_fragment_count_base = b.kr1_mode.towers.bfg.cluster.fragment_count_base + b.kr1_mode.towers.bfg.cluster.fragment_count_inc
b.kr1_mode.towers.bfg.cluster.s1_fragment_count_base = b.kr1_mode.towers.bfg.cluster.s0_fragment_count_base + b.kr1_mode.towers.bfg.cluster.fragment_count_inc
b.kr1_mode.towers.bfg.cluster.s2_fragment_count_base = b.kr1_mode.towers.bfg.cluster.s1_fragment_count_base + b.kr1_mode.towers.bfg.cluster.fragment_count_inc
b.kr1_mode.towers.bfg.cluster.fragment = {
	damage_min = 60,
	damage_max = 80,
	damage_radius = 52.5
}
b.kr1_mode.towers.tesla = {
	prices = 400,
	basic_attack = {}
}
b.kr1_mode.towers.tesla.basic_attack.damage_min = 70
b.kr1_mode.towers.tesla.basic_attack.damage_max = 100
b.kr1_mode.towers.tesla.basic_attack.cooldown = 2.2
b.kr1_mode.towers.tesla.basic_attack.bounce_range = 95
b.kr1_mode.towers.tesla.basic_attack.bounce_damage_factor = 0.5
b.kr1_mode.towers.tesla.basic_attack.bounce_damage_factor_min = 0.5
b.kr1_mode.towers.tesla.basic_attack.bounce_damage_factor_inc = 0
b.kr1_mode.towers.tesla.basic_attack.range = 165
b.kr1_mode.towers.tesla.bolt = {
	price = {
		250,
		250
	},
	jump_base = 3,
	jump_inc = 1
}
b.kr1_mode.towers.tesla.bolt.s0_jump_base = b.kr1_mode.towers.tesla.bolt.jump_base + b.kr1_mode.towers.tesla.bolt.jump_inc
b.kr1_mode.towers.tesla.bolt.s1_jump_base = b.kr1_mode.towers.tesla.bolt.s0_jump_base + b.kr1_mode.towers.tesla.bolt.jump_inc
b.kr1_mode.towers.tesla.overcharge = {
	price = {
		250,
		125,
		125
	},
	aura = {}
}
b.kr1_mode.towers.tesla.overcharge.aura.radius = 165
b.kr1_mode.towers.tesla.overcharge.aura.damage_min = 0
b.kr1_mode.towers.tesla.overcharge.aura.damage_max = 8
b.kr1_mode.towers.tesla.overcharge.aura.damage_inc = 8
b.kr1_mode.towers.tesla.overcharge.aura.s0_damage_min = b.kr1_mode.towers.tesla.overcharge.aura.damage_min + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.towers.tesla.overcharge.aura.s0_damage_max = b.kr1_mode.towers.tesla.overcharge.aura.damage_max + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.towers.tesla.overcharge.aura.s1_damage_min = b.kr1_mode.towers.tesla.overcharge.aura.s0_damage_min + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.towers.tesla.overcharge.aura.s1_damage_max = b.kr1_mode.towers.tesla.overcharge.aura.s0_damage_max + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.towers.tesla.overcharge.aura.s2_damage_min = b.kr1_mode.towers.tesla.overcharge.aura.s1_damage_min + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.towers.tesla.overcharge.aura.s2_damage_max = b.kr1_mode.towers.tesla.overcharge.aura.s1_damage_max + b.kr1_mode.towers.tesla.overcharge.aura.damage_inc
b.kr1_mode.upgrades = {
	archers = {}
}
b.kr1_mode.upgrades.archers.archer_salvage = {
	refund_factor = 0.9
}
b.kr1_mode.upgrades.archers.archer_eagle_eye = {
	range_factor = 1.1
}
b.kr1_mode.upgrades.archers.archer_piercing = {
	reduce_armor_factor = 0.1
}
b.kr1_mode.upgrades.archers.archer_far_shots = {
	range_factor = 1.1
}
b.kr1_mode.upgrades.archers.archer_precision = {
	chance = 0.1,
	damage_factor = 2
}
b.kr1_mode.upgrades.barracks = {
	barrack_survival = {}
}
b.kr1_mode.upgrades.barracks.barrack_survival.health_factor = 1.1
b.kr1_mode.upgrades.barracks.barrack_better_armor = {
	armor_increase = 0.1
}
b.kr1_mode.upgrades.barracks.barrack_improved_deployment = {
	cooldown_factor = 0.8,
	rally_range_factor = 1.2
}
b.kr1_mode.upgrades.barracks.barrack_survival_2 = {
	health_factor = 1.0909
}
b.kr1_mode.upgrades.barracks.barrack_barbed_armor = {
	spiked_armor_factor = 0.1
}
b.kr1_mode.upgrades.mages = {
	mage_spell_reach = {}
}
b.kr1_mode.upgrades.mages.mage_spell_reach.range_factor = 1.08
b.kr1_mode.upgrades.mages.mage_arcane_shatter = {
	mr_red = 0.03
}
b.kr1_mode.upgrades.mages.mage_hermetic_study = {
	cost_factor = 0.9
}
b.kr1_mode.upgrades.mages.mage_empowered_magic = {
	damage_factor = 1.15
}
b.kr1_mode.upgrades.engineers = {
	engineer_concentrated_fire = {}
}
b.kr1_mode.upgrades.engineers.engineer_concentrated_fire.damage_factor = 1.1
b.kr1_mode.upgrades.engineers.engineer_range_finder = {
	range_factor = 1.1
}
b.kr1_mode.upgrades.engineers.engineer_field_logistics = {
	cost_factor = 0.9
}
b.kr1_mode.upgrades.engineers.engineer_industrialization = {
	cost_factor = 0.75
}

return b

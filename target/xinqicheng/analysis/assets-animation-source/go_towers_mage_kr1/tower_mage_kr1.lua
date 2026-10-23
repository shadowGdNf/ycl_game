local a = {
	shootermage_idleDown = {
		prefix = "arcane_wizard_tower_KR1_lvl1_mage",
		to = 1,
		from = 1
	},
	shootermage_idleUp = {
		prefix = "arcane_wizard_tower_KR1_lvl1_mage",
		to = 2,
		from = 2
	},
	shootermage_shootingDown = {
		prefix = "arcane_wizard_tower_KR1_lvl1_mage",
		to = 23,
		from = 3
	},
	shootermage_shootingUp = {
		prefix = "arcane_wizard_tower_KR1_lvl1_mage",
		to = 46,
		from = 24
	},
	towermagelvl1_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl1_tower",
		to = 1,
		from = 1
	},
	towermagelvl1_shoot = {
		prefix = "arcane_wizard_tower_KR1_lvl1_tower",
		to = 20,
		from = 1
	},
	towermagelvl2_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl2_tower",
		to = 1,
		from = 1
	},
	towermagelvl2_shoot = {
		prefix = "arcane_wizard_tower_KR1_lvl2_tower",
		to = 20,
		from = 1
	},
	towermagelvl3_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl3_tower",
		to = 1,
		from = 1
	},
	towermagelvl3_shoot = {
		prefix = "arcane_wizard_tower_KR1_lvl3_tower",
		to = 20,
		from = 1
	},
	mage_kr1_bolt_in = {
		prefix = "arcane_wizard_tower_KR1_lvl123_bolt",
		to = 9,
		from = 1
	},
	mage_kr1_bolt_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl123_bolt",
		to = 19,
		from = 11
	},
	mage_kr1_bolt_hit = {
		prefix = "arcane_wizard_tower_KR1_lvl123_hit",
		to = 6,
		from = 1
	},
	tower_arcane_wizard_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_arcane",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shoot = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_arcane",
		to = 44,
		from = 3
	},
	tower_arcane_wizard_teleport = {
		to = 241,
		from = 193,
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_arcane",
		post = {
			1
		}
	},
	fx_tower_arcane_wizard_teleport = {
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane_skill_teleport_fx",
		to = 10,
		from = 1
	},
	tower_arcane_wizard_shooter_idleDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shooter_idleUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		to = 2,
		from = 2
	},
	tower_arcane_wizard_shooter_shootingDown = {
		to = 44,
		from = 3,
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		post = {
			1
		}
	},
	tower_arcane_wizard_shooter_shootingUp = {
		to = 86,
		from = 45,
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		post = {
			2
		}
	},
	tower_arcane_wizard_shooter_teleportDown = {
		to = 241,
		from = 193,
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		post = {
			1
		}
	},
	tower_arcane_wizard_shooter_teleportUp = {
		to = 290,
		from = 242,
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane",
		post = {
			2
		}
	},
	ray_arcane = {
		prefix = "arcane_wizard_tower_KR1_lvl4_ray",
		to = 24,
		from = 1
	},
	ray_arcane_disintegrate = {
		prefix = "arcane_wizard_tower_KR1_lvl4_skill_disintegration_ray",
		to = 19,
		from = 1
	},
	fx_ray_arcane_start_run = {
		prefix = "arcane_wizard_tower_KR1_ray_start",
		to = 9,
		from = 1
	},
	fx_ray_arcane_end_run = {
		prefix = "arcane_wizard_tower_KR1_ray_end",
		to = 9,
		from = 1
	},
	fx_ray_arcane_disintegrate_hit = {
		prefix = "arcane_wizard_tower_KR1_lvl4_disintegration_hit",
		to = 17,
		from = 1
	},
	aura_teleport_arcane = {
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane_skill_teleport_decal",
		to = 13,
		from = 1
	},
	fx_teleport_arcane_small = {
		prefix = "arcane_wizard_tower_KR1_lvl4_arcane_skill_teleport_fx",
		to = 10,
		from = 1
	},
	tower_sorcerer_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer",
		to = 1,
		from = 1
	},
	tower_sorcerer_shoot = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer",
		to = 35,
		from = 2
	},
	tower_sorcerer_polymorph = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer",
		to = 35,
		from = 2
	},
	fx_tower_sorcerer_polymorph = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_fx",
		to = 19,
		from = 1
	},
	fx_mod_polymorph_sorcerer_small = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_explosion",
		to = 18,
		from = 1
	},
	fx_mod_polymorph_sorcerer_big = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_explosion",
		to = 18,
		from = 1
	},
	fx_polymorph_sorcerer_hit = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_hit",
		to = 12,
		from = 1
	},
	tower_sorcerer_shooter_idleDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 1,
		from = 1
	},
	tower_sorcerer_shooter_idleUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 2,
		from = 2
	},
	tower_sorcerer_shooter_shootingDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 36,
		from = 3
	},
	tower_sorcerer_shooter_shootingUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 126,
		from = 97
	},
	tower_sorcerer_shooter_polymorphUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 96,
		from = 69
	},
	tower_sorcerer_shooter_polymorphDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer",
		to = 68,
		from = 37
	},
	bolt_sorcerer_in = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer_bolt",
		to = 9,
		from = 1
	},
	bolt_sorcerer_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer_bolt",
		to = 32,
		from = 10
	},
	bolt_sorcerer_hit = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_hit",
		to = 6,
		from = 1
	},
	ps_bolt_sorcerer_run = {
		prefix = "arcane_wizard_tower_KR1_lvl4_tower_sorcerer_trail",
		to = 9,
		from = 1
	},
	ray_sorcerer_polymorph_run = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_ray",
		to = 27,
		from = 1
	},
	ray_sorcerer_polymorph_end = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_ray",
		to = 34,
		from = 28
	},
	mod_sorcerer_curse_small = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_modifire",
		to = 20,
		from = 1
	},
	mod_sorcerer_curse_medium = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_modifire_big",
		to = 20,
		from = 1
	},
	mod_sorcerer_curse_large = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_modifire_big",
		to = 20,
		from = 1
	},
	enemy_sheep_ground_death = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_sheep",
		to = 61,
		from = 50
	},
	enemy_sheep_ground_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_sheep",
		to = 1,
		from = 1
	},
	enemy_sheep_ground_walkingRightLeft = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_sheep",
		to = 17,
		from = 2
	},
	enemy_sheep_ground_walkingDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_sheep",
		to = 33,
		from = 18
	},
	enemy_sheep_ground_walkingUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_sheep",
		to = 49,
		from = 34
	},
	enemy_sheep_fly_death = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_flysheep",
		to = 76,
		from = 65
	},
	enemy_sheep_fly_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_flysheep",
		to = 1,
		from = 1
	},
	enemy_sheep_fly_walkingRightLeft = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_flysheep",
		to = 32,
		from = 2
	},
	enemy_sheep_fly_walkingDown = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_flysheep",
		to = 48,
		from = 33
	},
	enemy_sheep_fly_walkingUp = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_flysheep",
		to = 64,
		from = 49
	},
	soldier_elemental_idle = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_golem",
		to = 37,
		from = 37
	},
	soldier_elemental_running = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_golem",
		to = 69,
		from = 38
	},
	soldier_elemental_attack = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_golem",
		to = 106,
		from = 70
	},
	soldier_elemental_death = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_golem",
		to = 148,
		from = 107
	},
	soldier_elemental_raise = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_golem",
		to = 36,
		from = 1
	},
	ground_hit_decal = {
		prefix = "arcane_wizard_tower_KR1_lvl4_sorcerer_skill_sheep_decal",
		to = 12,
		from = 1
	}
}

return a

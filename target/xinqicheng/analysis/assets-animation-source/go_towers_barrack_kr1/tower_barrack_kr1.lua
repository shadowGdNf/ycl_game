local a = {
	soldiermilitia_idle = {
		prefix = "KR1_barracks_tower_lvl1_unit",
		to = 1,
		from = 1
	},
	soldiermilitia_running = {
		prefix = "KR1_barracks_tower_lvl1_unit",
		to = 21,
		from = 2
	},
	soldiermilitia_attack = {
		prefix = "KR1_barracks_tower_lvl1_unit",
		to = 40,
		from = 22
	},
	soldiermilitia_death = {
		prefix = "KR1_barracks_tower_lvl1_unit",
		to = 58,
		from = 41
	},
	soldierfootmen_idle = {
		prefix = "KR1_barracks_tower_lvl2_unit",
		to = 1,
		from = 1
	},
	soldierfootmen_running = {
		prefix = "KR1_barracks_tower_lvl2_unit",
		to = 21,
		from = 2
	},
	soldierfootmen_attack = {
		prefix = "KR1_barracks_tower_lvl2_unit",
		to = 40,
		from = 22
	},
	soldierfootmen_death = {
		prefix = "KR1_barracks_tower_lvl2_unit",
		to = 58,
		from = 41
	},
	soldierknight_idle = {
		prefix = "KR1_barracks_tower_lvl3_unit",
		to = 1,
		from = 1
	},
	soldierknight_running = {
		prefix = "KR1_barracks_tower_lvl3_unit",
		to = 21,
		from = 2
	},
	soldierknight_attack = {
		prefix = "KR1_barracks_tower_lvl3_unit",
		to = 40,
		from = 22
	},
	soldierknight_death = {
		prefix = "KR1_barracks_tower_lvl3_unit",
		to = 58,
		from = 41
	},
	soldier_paladin_idle = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 1,
		from = 1
	},
	soldier_paladin_running = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 21,
		from = 2
	},
	soldier_paladin_attack = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 44,
		from = 22
	},
	soldier_paladin_attack2 = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 69,
		from = 45
	},
	soldier_paladin_healing = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 109,
		from = 70
	},
	soldier_paladin_holystrike = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 145,
		from = 110
	},
	soldier_paladin_death = {
		prefix = "KR1_barracks_tower_lvl4_unit_paladin",
		to = 166,
		from = 146
	},
	decal_paladin_holystrike = {
		prefix = "KR1_barracks_tower_lvl4_paladin_decal",
		to = 22,
		from = 1
	},
	soldier_barbarian_idle = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		to = 1,
		from = 1
	},
	soldier_barbarian_running = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		to = 23,
		from = 2
	},
	soldier_barbarian_attack = {
		to = 42,
		from = 24,
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		post = {
			1
		}
	},
	soldier_barbarian_shoot = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		to = 61,
		from = 43
	},
	soldier_barbarian_twister = {
		to = 91,
		from = 62,
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		post = {
			1
		}
	},
	soldier_barbarian_death = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian",
		to = 108,
		from = 92
	},
	soldier_barbarian_idle2 = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		to = 1,
		from = 1
	},
	soldier_barbarian_running2 = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		to = 23,
		from = 2
	},
	soldier_barbarian_attack2 = {
		to = 53,
		from = 24,
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		post = {
			1
		}
	},
	soldier_barbarian_shoot2 = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		to = 75,
		from = 54
	},
	soldier_barbarian_twister2 = {
		to = 105,
		from = 76,
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		post = {
			1
		}
	},
	soldier_barbarian_death2 = {
		prefix = "KR1_barracks_tower_lvl4_unit_barbarian_skill_axe",
		to = 124,
		from = 106
	},
	towerbarracklvl1_door_open = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 10,
		from = 1
	},
	towerbarracklvl2_door_open = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 10,
		from = 1
	},
	towerbarracklvl3_door_open = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 10,
		from = 1
	},
	towerbarracklvl1_door_close = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 18,
		from = 11
	},
	towerbarracklvl2_door_close = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 18,
		from = 11
	},
	towerbarracklvl3_door_close = {
		prefix = "KR1_barracks_tower_lvl123_door",
		to = 18,
		from = 11
	},
	towerbarracklvl4_paladin_door_open = {
		prefix = "KR1_barracks_tower_lvl4_paladin_door",
		to = 10,
		from = 1
	},
	towerbarracklvl4_paladin_door_close = {
		prefix = "KR1_barracks_tower_lvl4_paladin_door",
		to = 18,
		from = 11
	},
	towerbarracklvl4_barbarian_door_open = {
		prefix = "KR1_barracks_tower_lvl4_barbarian_door",
		to = 10,
		from = 1
	},
	towerbarracklvl4_barbarian_door_close = {
		prefix = "KR1_barracks_tower_lvl4_barbarian_door",
		to = 18,
		from = 11
	},
	tower_paladin_flag = {
		prefix = "KR1_barracks_tower_lvl4_paladin_flag",
		to = 22,
		from = 1
	}
}

return a

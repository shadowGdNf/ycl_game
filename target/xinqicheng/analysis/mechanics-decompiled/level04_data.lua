return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 580,
				y = 684
			}
		},
		{
			pos = {
				x = 766,
				y = 684
			}
		},
		{
			pos = {
				x = 430,
				y = 376
			}
		},
		{
			pos = {
				x = 930,
				y = 376
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 645,
			y = 450
		}
	},
	entities_list = {
		{
			min_delay = 7,
			template = "background_sounds_kr5",
			max_delay = 13,
			only_on_preparation = true,
			sounds = {
				"Terrain1AmbienceSoundBirds",
				"Terrain1AmbienceSoundWind",
				"Terrain1AmbienceSoundCicadas"
			}
		},
		{
			template = "controller_show_buy_available"
		},
		{
			template = "controller_stage_04_wall_explosion",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "debug_path_renderer",
			["path_debug.background_color"] = {
				46,
				193,
				142,
				0
			},
			["path_debug.path_color"] = {
				168,
				199,
				169,
				0
			},
			pos = {
				x = -300,
				y = 868
			}
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "Stage04_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 9,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 580,
				y = 684
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 766,
				y = 684
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 515,
				y = 684
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 650,
				y = 684
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 701,
				y = 684
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 830,
				y = 684
			}
		},
		{
			template = "decal_stage_04_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_3",
			["editor.game_mode"] = 1,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_3",
			["editor.game_mode"] = 8,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_4",
			["editor.game_mode"] = 1,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_4",
			["editor.game_mode"] = 8,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_10",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_11",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_12",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_mask_water_9",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_minecraft",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_water_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_04_water_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 551,
				y = 72
			}
		},
		{
			["editor.r"] = 0.34906585039887,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1070,
				y = 214
			}
		},
		{
			["editor.r"] = -3.1415926535898,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 80,
				y = 353
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_archers_lvl1",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 631,
				y = 335
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_archers_lvl1",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 682,
				y = 179
			},
			["tower.default_rally_pos"] = {
				x = 600,
				y = 219
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 4,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 749,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 235
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 971,
				y = 268
			},
			["tower.default_rally_pos"] = {
				x = 929,
				y = 206
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 4,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 539,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 632,
				y = 334
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 308,
				y = 316
			},
			["tower.default_rally_pos"] = {
				x = 348,
				y = 405
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 765,
				y = 335
			},
			["tower.default_rally_pos"] = {
				x = 874,
				y = 311
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 843,
				y = 396
			},
			["tower.default_rally_pos"] = {
				x = 945,
				y = 429
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 676,
				y = 440
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 4,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 655,
				y = 441
			},
			["tower.default_rally_pos"] = {
				x = 602,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 416,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 431,
				y = 390
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 540,
				y = 465
			},
			["tower.default_rally_pos"] = {
				x = 541,
				y = 394
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 876,
				y = 568
			},
			["tower.default_rally_pos"] = {
				x = 814,
				y = 497
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 3,
			template = "tower_holder_terrain_1_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 669,
				y = 569
			},
			["tower.default_rally_pos"] = {
				x = 556,
				y = 586
			}
		},
		{
			["tower.holder_id"] = "1",
			["ui.nav_mesh_id"] = "1",
			template = "tower_stage_04_crane",
			["editor.game_mode"] = 0,
			pos = {
				x = 179,
				y = 394
			},
			["tower.default_rally_pos"] = {
				x = 157,
				y = 301
			}
		}
	},
	ignore_walk_backwards_paths = {
		3
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			locked_towers = {}
		},
		{
			locked_towers = {}
		},
		{
			available_towers = {
				"tower_build_culverine",
				"tower_build_knights"
			},
			locked_towers = {}
		},
		[5] = {
			comment = "SPELL RUSH MODE"
		},
		[6] = {
			comment = "HERO PARTY MODE"
		},
		[7] = {
			comment = "BLITZ MODE"
		},
		[8] = {
			comment = "KR1 MODE",
			max_upgrade_level = 1
		}
	},
	nav_mesh = {
		{
			2
		},
		{
			5,
			3,
			1
		},
		{
			4,
			nil,
			1,
			2
		},
		{
			7,
			nil,
			3,
			5
		},
		{
			10,
			4,
			2,
			8
		},
		{
			12,
			nil,
			4,
			7
		},
		{
			11,
			6,
			4,
			8
		},
		{
			9,
			7,
			5
		},
		{
			13,
			10,
			8
		},
		{
			11,
			7,
			5,
			9
		},
		{
			13,
			12,
			10
		},
		{
			13,
			nil,
			6,
			11
		},
		{
			nil,
			12,
			9
		}
	},
	required_exoskeletons = {
		"CraneDef",
		"CraneProjectileDef",
		"CraneProjectileFXDecalDef",
		"CraneProjectileFXDef",
		"GobliExplosionDef",
		"stage_4_water_1Def",
		"stage_4_water_2Def",
		"stage_04_easteregg_minecraftDef",
		"CraneSpeechBubbleDef"
	},
	required_sounds = {
		"music_stage04",
		"enemies_T1",
		"stage_04",
		"terrain_1_common",
		"tower_archers"
	},
	required_textures = {
		"go_stage04_bg",
		"go_stage04",
		"go_enemies_T1",
		"go_towers_archers"
	}
}

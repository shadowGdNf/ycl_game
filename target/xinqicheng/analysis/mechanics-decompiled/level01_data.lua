return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 324,
				y = 341
			}
		},
		{
			pos = {
				x = 324,
				y = 371
			}
		},
		{
			pos = {
				x = 410,
				y = 341
			}
		},
		{
			pos = {
				x = 410,
				y = 371
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 512,
			y = 500
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
			["render.sprites[1].name"] = "Stage01_0001",
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
				x = 330,
				y = 352
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 283,
				y = 287
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 299,
				y = 416
			}
		},
		{
			template = "decal_stage_01_cow",
			pos = {
				x = 500,
				y = 384.5
			}
		},
		{
			template = "decal_stage_01_hp_mask_1",
			["editor.game_mode"] = 6,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_king",
			["editor.game_mode"] = 1,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_merchant",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_01_sheep",
			pos = {
				x = 1064,
				y = 356
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_01_sheep",
			pos = {
				x = 1103,
				y = 370
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_01_sheep",
			pos = {
				x = 1079,
				y = 606.5
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_01_sheep",
			pos = {
				x = 1030,
				y = 620.5
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_01_sheep",
			pos = {
				x = 774,
				y = 656
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_01_sheep_small",
			pos = {
				x = 1098,
				y = 345
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_01_sheep_small",
			pos = {
				x = 806,
				y = 632
			}
		},
		{
			template = "decal_stage_01_statue",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_stone",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_water",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_01_worker_1",
			pos = {
				x = -7,
				y = 353
			}
		},
		{
			template = "decal_stage_01_worker_1f",
			pos = {
				x = 144,
				y = 225
			}
		},
		{
			template = "decal_stage_01_worker_2",
			pos = {
				x = 396,
				y = 510
			}
		},
		{
			template = "decal_stage_01_worker_2f",
			pos = {
				x = 279,
				y = 534
			}
		},
		{
			template = "decal_stage_01_worker_3",
			pos = {
				x = 78,
				y = 328
			}
		},
		{
			template = "decal_stage_01_worker_3f",
			pos = {
				x = 214,
				y = 657
			}
		},
		{
			template = "decal_stage_01_worker_4",
			pos = {
				x = 51,
				y = 208
			}
		},
		{
			template = "decal_stage_01_worker_statue",
			pos = {
				x = 622,
				y = 516
			}
		},
		{
			["editor.r"] = 0,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 1112,
				y = 241
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 524,
				y = 659
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 602,
				y = 263
			},
			["tower.default_rally_pos"] = {
				x = 650,
				y = 354
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 498,
				y = 264
			},
			["tower.default_rally_pos"] = {
				x = 480,
				y = 354
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 389,
				y = 267
			},
			["tower.default_rally_pos"] = {
				x = 382,
				y = 354
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 580,
				y = 415
			},
			["tower.default_rally_pos"] = {
				x = 570,
				y = 354
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 700,
				y = 416
			},
			["tower.default_rally_pos"] = {
				x = 729,
				y = 348
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 2,
			template = "tower_holder_terrain_1_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 829,
				y = 259
			},
			["tower.default_rally_pos"] = {
				x = 882,
				y = 338
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 2,
			template = "tower_holder_terrain_1_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 817,
				y = 415
			},
			["tower.default_rally_pos"] = {
				x = 811,
				y = 346
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			comment = "CAMPAIGN MODE"
		},
		{},
		{
			comment = "IRON MODE",
			available_towers = {
				"tower_build_archers",
				"tower_build_catapult"
			}
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
			max_upgrade_level = 0,
			locked_towers = {
				"tower_archer_kr1_lvl2",
				"tower_mage_kr1_lvl2",
				"tower_barrack_kr1_lvl2",
				"tower_engineer_kr1_lvl2"
			}
		}
	},
	locked_towers = {
		"tower_archers_lvl2",
		"tower_wizard_lvl2",
		"tower_knights_lvl2",
		"tower_catapult_lvl2",
		"tower_ranger_lvl2",
		"tower_culverine_lvl2",
		"tower_light_priestess_lvl2",
		"tower_sunray_master_lvl2",
		"tower_tree_lvl2",
		"tower_wildcat_lvl2",
		"tower_miners_lvl2",
		"tower_forger_lvl2",
		"tower_alchemist_lvl2",
		"tower_crossbows_lvl2",
		"tower_sniper_lvl2"
	},
	nav_mesh = {
		{
			2
		},
		{
			4,
			nil,
			1
		},
		{
			10,
			nil,
			nil,
			4
		},
		{
			6,
			3,
			2
		},
		{
			[3.0] = 10,
			[4.0] = 6
		},
		{
			nil,
			5,
			4
		},
		[10] = {
			5,
			nil,
			3
		}
	},
	required_exoskeletons = {
		"stage01_dude1Def",
		"stage01_dude2Def",
		"stage01_dude3Def",
		"stage01_dude4Def",
		"stage01_cowDef",
		"stage_1_merchantDef",
		"stage_1_sheepDef",
		"stage_1_sheep_smallDef",
		"stage_1_water_dotsDef",
		"stage_1_stoneDef",
		"stage_1_old_kingDef",
		"stage01_dude1_statueDef",
		"stage01_statueDef",
		"drag_tutorialDef",
		"geraldintroDef",
		"geraldintroportalDef"
	},
	required_sounds = {
		"music_stage01",
		"enemies_T1",
		"stage_01",
		"terrain_1_common"
	},
	required_textures = {
		"go_stage01_bg",
		"go_stage01",
		"go_enemies_T1"
	}
}

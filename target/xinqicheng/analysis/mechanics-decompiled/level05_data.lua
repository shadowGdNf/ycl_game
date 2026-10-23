return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 52,
				y = 287
			}
		},
		{
			pos = {
				x = 199,
				y = 481
			}
		},
		{
			pos = {
				x = 770,
				y = 440
			}
		},
		{
			pos = {
				x = 698,
				y = 260
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 460,
			y = 400
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
			template = "controller_stage_05_kodama",
			pos = {
				x = 511,
				y = 349
			}
		},
		{
			template = "controller_stage_05_leaves",
			pos = {
				x = 613,
				y = 411
			}
		},
		{
			template = "controller_stage_05_tree",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_stage_05_fire",
			pos = {
				x = 0,
				y = 0
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
			["render.sprites[1].name"] = "Stage05_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 52,
				y = 287
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 9,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 199,
				y = 481
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 6,
				y = 250
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 92,
				y = 321
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 176,
				y = 421
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 221,
				y = 527
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_05_citizen_basic",
			pos = {
				x = 242,
				y = 97
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_05_citizen_basic",
			pos = {
				x = 953,
				y = 264
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_05_citizen_basic",
			pos = {
				x = 1142,
				y = 328
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_05_citizen_basic_2",
			pos = {
				x = 294,
				y = 95
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_05_citizen_basic_2",
			pos = {
				x = 864,
				y = 214
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_05_citizen_basic_2",
			pos = {
				x = 1108,
				y = 331
			}
		},
		{
			template = "decal_stage_05_citizen_guitar",
			pos = {
				x = 124,
				y = 356
			}
		},
		{
			template = "decal_stage_05_citizen_house_on_fire",
			pos = {
				x = 826,
				y = 667
			}
		},
		{
			template = "decal_stage_05_citizen_old",
			pos = {
				x = 1007,
				y = 227
			}
		},
		{
			template = "decal_stage_05_citizen_old_window",
			pos = {
				x = 991,
				y = 342
			}
		},
		{
			template = "decal_stage_05_citizen_running",
			pos = {
				x = 360,
				y = 518
			}
		},
		{
			template = "decal_stage_05_citizen_window",
			pos = {
				x = 117,
				y = 131
			}
		},
		{
			template = "decal_stage_05_citizen_window",
			pos = {
				x = 132,
				y = 657
			}
		},
		{
			template = "decal_stage_05_kodama_1",
			pos = {
				x = 79,
				y = 579
			}
		},
		{
			template = "decal_stage_05_kodama_2",
			pos = {
				x = 1077,
				y = 331
			}
		},
		{
			template = "decal_stage_05_kodama_3",
			pos = {
				x = 726,
				y = 663
			}
		},
		{
			template = "decal_stage_05_lamp",
			pos = {
				x = 1149,
				y = 183
			}
		},
		{
			template = "decal_stage_05_lamp",
			pos = {
				x = 995,
				y = 399
			}
		},
		{
			template = "decal_stage_05_lamp",
			pos = {
				x = 465,
				y = 586
			}
		},
		{
			template = "decal_stage_05_lamp_f",
			pos = {
				x = 335,
				y = 125
			}
		},
		{
			template = "decal_stage_05_lamp_f",
			pos = {
				x = 394,
				y = 358
			}
		},
		{
			template = "decal_stage_05_lamp_f",
			pos = {
				x = 960,
				y = 573
			}
		},
		{
			template = "decal_stage_05_lamp_window",
			pos = {
				x = 935,
				y = 279
			}
		},
		{
			template = "decal_stage_05_light",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_light_spores",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_10",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_mask_9",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_tree",
			pos = {
				x = 598,
				y = 410
			}
		},
		{
			template = "decal_stage_05_tree_zone",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_05_upper_path",
			["editor.game_mode"] = 1,
			pos = {
				x = -186,
				y = 768
			}
		},
		{
			template = "decal_stage_05_upper_path",
			["editor.game_mode"] = 8,
			pos = {
				x = -186,
				y = 768
			}
		},
		{
			template = "decal_stage_05_wisps",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 691,
				y = 74
			}
		},
		{
			["editor.r"] = -1.5707963267949,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 736,
				y = 74
			}
		},
		{
			["editor.r"] = 0.52359877559829,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1070,
				y = 535
			}
		},
		{
			["editor.r"] = 6.8067840827779,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1070,
				y = 580
			}
		},
		{
			["editor.r"] = 1.3962634015955,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 614,
				y = 696
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 524,
				y = 183
			},
			["tower.default_rally_pos"] = {
				x = 497,
				y = 267
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 627,
				y = 185
			},
			["tower.default_rally_pos"] = {
				x = 635,
				y = 261
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 806,
				y = 280
			},
			["tower.default_rally_pos"] = {
				x = 726,
				y = 311
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 187,
				y = 292
			},
			["tower.default_rally_pos"] = {
				x = 156,
				y = 237
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 381,
				y = 295
			},
			["tower.default_rally_pos"] = {
				x = 465,
				y = 342
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 867,
				y = 380
			},
			["tower.default_rally_pos"] = {
				x = 871,
				y = 458
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 342,
				y = 394
			},
			["tower.default_rally_pos"] = {
				x = 369,
				y = 474
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 240,
				y = 397
			},
			["tower.default_rally_pos"] = {
				x = 257,
				y = 468
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 818,
				y = 521
			},
			["tower.default_rally_pos"] = {
				x = 795,
				y = 463
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 925,
				y = 521
			},
			["tower.default_rally_pos"] = {
				x = 942,
				y = 464
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 403,
				y = 555
			},
			["tower.default_rally_pos"] = {
				x = 452,
				y = 499
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 702,
				y = 585
			},
			["tower.default_rally_pos"] = {
				x = 668,
				y = 529
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 4,
			template = "tower_holder_terrain_1_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 522,
				y = 600
			},
			["tower.default_rally_pos"] = {
				x = 545,
				y = 534
			}
		}
	},
	ignore_walk_backwards_paths = {
		5
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
				"tower_build_ranger",
				"tower_build_wizard"
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
			max_upgrade_level = 2
		}
	},
	nav_mesh = {
		{
			4,
			2
		},
		{
			3,
			nil,
			nil,
			1
		},
		{
			nil,
			5,
			2,
			4
		},
		{
			6,
			3,
			1
		},
		{
			7,
			nil,
			nil,
			3
		},
		{
			8,
			nil,
			4
		},
		{
			9,
			nil,
			5,
			6
		},
		{
			10,
			nil,
			6
		},
		{
			11,
			nil,
			7,
			8
		},
		{
			12,
			12,
			8
		},
		{
			13,
			nil,
			9,
			12
		},
		{
			13,
			11,
			10,
			10
		},
		{
			[3.0] = 11,
			[4.0] = 12
		}
	},
	required_exoskeletons = {
		"stage05_pathDef",
		"stage05_pathburnDef",
		"stage05_pathburnlightDef",
		"treeauraDef",
		"treedecalDef",
		"treeDef",
		"treeleaffallDef",
		"treesoulsDef",
		"treeunitdecalDef",
		"treezoneDef",
		"treelightsDef",
		"treewispsDef",
		"treelampDef",
		"treestunbigDef",
		"treestunsmallDef",
		"stage05_elfDef",
		"stage05_elf2Def",
		"stage05_elfguitarDef",
		"stage05_elfhouseonfireDef",
		"stage05_elfoldDef",
		"stage05_elfoldwindowDef",
		"stage05_elfrunningDef",
		"stage05_elfwindowDef",
		"stage05_kodamaDef",
		"stage05_kodama2Def",
		"stage05_kodama3Def"
	},
	required_sounds = {
		"music_stage05",
		"enemies_T1",
		"stage_05",
		"terrain_1_common"
	},
	required_textures = {
		"go_stage05_bg",
		"go_stage05",
		"go_enemies_T1",
		"gui_extra_portraits"
	}
}

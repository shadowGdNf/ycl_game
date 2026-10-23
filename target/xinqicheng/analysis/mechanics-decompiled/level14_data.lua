return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 836,
				y = 681
			}
		},
		{
			pos = {
				x = 1092,
				y = 232
			}
		},
		{
			pos = {
				x = 695,
				y = 333
			}
		},
		{
			pos = {
				x = 477,
				y = 333
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 650,
			y = 425
		}
	},
	entities_list = {
		{
			min_delay = 7,
			template = "background_sounds_kr5",
			max_delay = 13,
			only_on_preparation = true,
			sounds = {
				"Terrain3Ambience"
			}
		},
		{
			template = "controller_graveyard_stage_14",
			["graveyard.spawn_pos"] = {
				{
					x = 465,
					y = 593
				},
				{
					x = 445,
					y = 613
				},
				{
					x = 491,
					y = 585
				},
				{
					x = 445,
					y = 592
				},
				{
					x = 521,
					y = 610
				}
			},
			pos = {
				x = 205,
				y = 510
			}
		},
		{
			template = "controller_show_buy_available"
		},
		{
			template = "controller_stage_14_community_building_achievement"
		},
		{
			template = "controller_stage_14_houses"
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
			["render.sprites[1].name"] = "Stage14_0001",
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
				x = 1092,
				y = 232
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 836,
				y = 681
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1092,
				y = 182
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 1092,
				y = 282
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 778,
				y = 681
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 894,
				y = 681
			}
		},
		{
			template = "decal_graveyard_stage_14",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_armory",
			pos = {
				x = 579,
				y = 448
			}
		},
		{
			template = "decal_stage_14_armory_alert",
			pos = {
				x = 477,
				y = 454
			}
		},
		{
			template = "decal_stage_14_blacksmith",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_blacksmith_alert",
			pos = {
				x = 649,
				y = 271
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 707,
				y = 67
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 1001,
				y = 157
			}
		},
		{
			template = "decal_easter_egg_stage_14_goat_fall",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 1047,
				y = 504
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 1074,
				y = 574
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 771,
				y = 108
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 1039,
				y = 144
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 1050,
				y = 562
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_skeleton",
			pos = {
				x = 622,
				y = 661
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 119,
				y = 560
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 455,
				y = 640
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 224,
				y = 654
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 382,
				y = 655
			}
		},
		{
			template = "decal_stage_14_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_10",
			pos = {
				x = 508,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_2",
			pos = {
				x = 512,
				y = 531
			}
		},
		{
			template = "decal_stage_14_mask_3",
			pos = {
				x = 512,
				y = 461
			}
		},
		{
			template = "decal_stage_14_mask_4",
			pos = {
				x = 512,
				y = 429
			}
		},
		{
			template = "decal_stage_14_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_6",
			pos = {
				x = 512,
				y = 84
			}
		},
		{
			template = "decal_stage_14_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_easter_egg_stage_14_delorean",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask11",
			pos = {
				x = 261,
				y = 672
			}
		},
		{
			template = "decal_stage_14_mask12",
			pos = {
				x = 243,
				y = 682
			}
		},
		{
			template = "decal_stage_14_smoke",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = -1.3264502315157,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 476,
				y = 120
			}
		},
		{
			["editor.r"] = -1.3264502315158,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 523,
				y = 120
			}
		},
		{
			["editor.r"] = 3.1660272631177,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -20,
				y = 444
			}
		},
		{
			["editor.r"] = 3.1590459461097,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -20,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 921,
				y = 381
			},
			["tower.default_rally_pos"] = {
				x = 825,
				y = 445
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 484,
				y = 481
			},
			["tower.default_rally_pos"] = {
				x = 581,
				y = 563.5
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 728,
				y = 486
			},
			["tower.default_rally_pos"] = {
				x = 746,
				y = 577
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 153,
				y = 491
			},
			["tower.default_rally_pos"] = {
				x = 219,
				y = 443
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 836,
				y = 519
			},
			["tower.default_rally_pos"] = {
				x = 900,
				y = 476
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 524,
				y = 232
			},
			["tower.default_rally_pos"] = {
				x = 429,
				y = 261
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 870,
				y = 243
			},
			["tower.default_rally_pos"] = {
				x = 794,
				y = 185
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 372,
				y = 318
			},
			["tower.default_rally_pos"] = {
				x = 454,
				y = 372
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 801,
				y = 320
			},
			["tower.default_rally_pos"] = {
				x = 722,
				y = 390
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 150,
				y = 352
			},
			["tower.default_rally_pos"] = {
				x = 102,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 307,
				y = 395
			},
			["tower.default_rally_pos"] = {
				x = 371,
				y = 464
			}
		},
		{
			["tower.holder_id"] = "42",
			["ui.nav_mesh_id"] = "42",
			template = "tower_stage_14_blacksmith",
			["editor.game_mode"] = 0,
			pos = {
				x = 638,
				y = 200
			},
			["tower.default_rally_pos"] = {
				x = 644,
				y = 109
			}
		},
		{
			["tower.holder_id"] = "46",
			["ui.nav_mesh_id"] = "46",
			template = "tower_stage_14_broken_armory",
			["editor.game_mode"] = 0,
			pos = {
				x = 590,
				y = 418
			},
			["tower.default_rally_pos"] = {
				x = 576,
				y = 332
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			locked_towers = {}
		},
		{
			locked_towers = {
				"tower_royal_archers_lvl4",
				"tower_paladin_covenant_lvl4",
				"tower_arcane_wizard_lvl4",
				"tower_tricannon_lvl4",
				"tower_arborean_emissary_lvl4",
				"tower_demon_pit_lvl4",
				"tower_elven_stargazers_lvl4",
				"tower_rocket_gunners_lvl4",
				"tower_necromancer_lvl4",
				"tower_ballista_lvl4",
				"tower_flamespitter_lvl4",
				"tower_barrel_lvl4",
				"tower_sand_lvl4",
				"tower_ghost_lvl4",
				"tower_ray_lvl4",
				"tower_dark_elf_lvl4",
				"tower_dwarf_lvl4",
				"tower_hermit_toad_lvl4",
				"tower_sparking_geode_lvl4"
			}
		},
		{
			available_towers = {
				"tower_build_light_priestess",
				"tower_build_archers"
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
			max_upgrade_level = 4
		}
	},
	nav_mesh = {
		{
			5,
			2
		},
		{
			3,
			nil,
			nil,
			1
		},
		{
			46,
			nil,
			2,
			4
		},
		{
			6,
			3,
			5,
			6
		},
		{
			3,
			nil,
			1,
			4
		},
		{
			42,
			46,
			4
		},
		[8] = {
			11,
			nil,
			46,
			9
		},
		[9] = {
			12,
			8,
			42,
			10
		},
		[10] = {
			12,
			9,
			42
		},
		[11] = {
			12,
			nil,
			8,
			12
		},
		[12] = {
			nil,
			11,
			9,
			10
		},
		[42] = {
			10,
			46,
			6
		},
		[46] = {
			8,
			nil,
			3,
			6
		}
	},
	required_exoskeletons = {
		"stage14_barracksDef",
		"stage14_blacksmithDef",
		"stage14_blacksmithauraDef",
		"s14_smokeDef",
		"stage14_graveyardDef",
		"stage14_barracks_alertDef",
		"stage14_blacksmith_alertDef",
		"deloreanDef"
	},
	required_sounds = {
		"music_stage14",
		"enemies_T3",
		"stage_14",
		"terrain_3_common"
	},
	required_textures = {
		"go_stage14_bg",
		"go_stage14",
		"go_enemies_T3"
	}
}

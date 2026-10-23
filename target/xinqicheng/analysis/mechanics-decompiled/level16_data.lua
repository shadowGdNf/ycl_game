return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 6,
	custom_spawn_pos = {
		{
			pos = {
				x = 178,
				y = 630
			}
		},
		{
			pos = {
				x = 626,
				y = 134
			}
		},
		{
			pos = {
				x = 197,
				y = 572
			}
		},
		{
			pos = {
				x = 626,
				y = 238
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 450,
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
			template = "controller_show_buy_available"
		},
		{
			template = "controller_stage_15_swamp_bubbles",
			path_spawner_map = {
				[8.0] = 1,
				[7.0] = 1
			},
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			swamp_id = 1,
			template = "controller_stage_15_swamp_bubbles_spawner",
			pos = {
				x = 80,
				y = 150
			}
		},
		{
			swamp_id = 1,
			template = "controller_stage_15_swamp_spawn_points",
			center_spawn = {
				x = 95,
				y = 145
			},
			["graveyard.spawn_pos"] = {
				{
					x = 50,
					y = 158
				},
				{
					x = 60,
					y = 123
				},
				{
					x = 76,
					y = 154
				},
				{
					x = 114,
					y = 145
				},
				{
					x = 90,
					y = 128
				},
				{
					x = 110,
					y = 168
				}
			},
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_stage_15_swamps",
			path_spawner_map = {
				[8.0] = 1,
				[7.0] = 1
			},
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
			["render.sprites[1].name"] = "Stage16_0001",
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
				x = 626,
				y = 134
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 178,
				y = 630
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 570,
				y = 134
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 690,
				y = 134
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 115,
				y = 630
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 240,
				y = 630
			}
		},
		{
			template = "decal_stage_16_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_16_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_easter_egg_stage_16_deku_sprout",
			pos = {
				x = 420,
				y = 240
			}
		},
		{
			["editor.r"] = -0.17453292519943,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1075,
				y = 250
			}
		},
		{
			["editor.r"] = 2.6947883650792,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -48,
				y = 318
			}
		},
		{
			["editor.r"] = -3.6651914291881,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = -48,
				y = 363
			}
		},
		{
			["editor.r"] = 0.36651914291881,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1075,
				y = 460
			}
		},
		{
			["editor.r"] = 0.29670597283903,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1028,
				y = 471
			}
		},
		{
			["editor.r"] = 0.36651914291881,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1075,
				y = 501
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 738,
				y = 196
			},
			["tower.default_rally_pos"] = {
				x = 703,
				y = 278
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 513,
				y = 231
			},
			["tower.default_rally_pos"] = {
				x = 627,
				y = 234
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 332,
				y = 240
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 282
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 362,
				y = 304
			},
			["tower.default_rally_pos"] = {
				x = 363,
				y = 383
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 661,
				y = 338
			},
			["tower.default_rally_pos"] = {
				x = 601,
				y = 296
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 833,
				y = 353
			},
			["tower.default_rally_pos"] = {
				x = 804,
				y = 289
			}
		},
		{
			["tower.holder_id"] = "15",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 951,
				y = 353
			},
			["tower.default_rally_pos"] = {
				x = 956,
				y = 290
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 750,
				y = 411
			},
			["tower.default_rally_pos"] = {
				x = 769,
				y = 508
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 504,
				y = 441
			},
			["tower.default_rally_pos"] = {
				x = 544,
				y = 375
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 380,
				y = 442
			},
			["tower.default_rally_pos"] = {
				x = 276,
				y = 445
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 584,
				y = 497
			},
			["tower.default_rally_pos"] = {
				x = 674,
				y = 461
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 143,
				y = 512
			},
			["tower.default_rally_pos"] = {
				x = 249,
				y = 536
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 14,
			template = "tower_holder_terrain_3_5",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 347,
				y = 570
			},
			["tower.default_rally_pos"] = {
				x = 368,
				y = 512
			}
		},
		{
			["tower.terrain_style"] = 10,
			["tower.holder_id"] = "1",
			["ui.nav_mesh_id"] = "1",
			template = "tower_stage_16_treant_killer",
			["editor.game_mode"] = 0,
			["tower.bullets_zone_radius"] = 90,
			["tower.tree_name"] = "tree_2",
			pos = {
				x = 137,
				y = 323
			},
			["tower.bullets_zone_1"] = {
				x = 100,
				y = 264
			},
			["tower.bullets_zone_2"] = {
				x = 444,
				y = 381
			},
			["tower.bullets_zone_3"] = {
				x = 506,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 188,
				y = 262
			}
		},
		{
			["render.sprites[2].flip_x"] = true,
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			["ui.nav_mesh_id"] = "14",
			template = "tower_stage_16_treant_killer",
			["editor.game_mode"] = 0,
			["tower.bullets_zone_radius"] = 90,
			["tower.tree_name"] = "tree_1",
			pos = {
				x = 962,
				y = 513
			},
			["tower.bullets_zone_1"] = {
				x = 795,
				y = 617
			},
			["tower.bullets_zone_2"] = {
				x = 642,
				y = 449
			},
			["tower.bullets_zone_3"] = {
				x = 889,
				y = 297
			},
			["tower.default_rally_pos"] = {
				x = 905,
				y = 462
			}
		}
	},
	ignore_walk_backwards_paths = {
		7,
		8
	},
	invalid_path_ranges = {
		{
			from = 92,
			to = 114,
			path_id = 2
		}
	},
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
				"tower_build_wildcat",
				"tower_build_tree"
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
			max_upgrade_level = 5
		}
	},
	nav_mesh = {
		{
			3,
			2
		},
		{
			5,
			nil,
			nil,
			1
		},
		{
			4,
			nil,
			1
		},
		{
			8,
			5,
			1,
			3
		},
		{
			7,
			6,
			2,
			4
		},
		{
			9,
			nil,
			2,
			5
		},
		{
			9,
			nil,
			5,
			8
		},
		{
			11,
			7,
			4
		},
		{
			12,
			nil,
			7,
			10
		},
		{
			13,
			9,
			8,
			11
		},
		{
			13,
			10,
			8
		},
		{
			14,
			nil,
			9,
			13
		},
		{
			15,
			12,
			10,
			11
		},
		{
			[3.0] = 12,
			[4.0] = 15
		},
		{
			nil,
			14,
			13
		}
	},
	required_exoskeletons = {
		"stage16_hiddentreesDef",
		"t_dadDef",
		"t_healerDef",
		"t_rooterDef",
		"t_swaptowersDef",
		"old_treantDef",
		"old_treant_decalDef",
		"old_treant_hitDef",
		"old_treant_proyectileDef",
		"old_treant_tangleDef",
		"old_treant_tongueDef",
		"stg16_fog_aDef",
		"stg16_fog_bDef",
		"stg16_fog_cDef",
		"stg16_fog_dDef",
		"stg16_rider_fog_trailDef"
	},
	required_sounds = {
		"music_stage16",
		"enemies_T3",
		"stage_16",
		"terrain_3_common"
	},
	required_textures = {
		"go_stage16_bg",
		"go_stage16",
		"go_enemies_T3"
	}
}

return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 930,
				y = 476
			}
		},
		{
			pos = {
				x = 993,
				y = 323
			}
		},
		{
			pos = {
				x = 796,
				y = 476
			}
		},
		{
			pos = {
				x = 796,
				y = 323
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
			template = "controller_show_buy_available"
		},
		{
			template = "controller_stage_15_accusation_cinematic",
			["editor.game_mode"] = 1
		},
		{
			template = "controller_stage_15_bubble_decorations",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_stage_15_easter_egg_simpsons",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_stage_15_swamp_bubbles",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			swamp_id = 2,
			template = "controller_stage_15_swamp_bubbles_spawner",
			pos = {
				x = 155,
				y = 185
			}
		},
		{
			swamp_id = 1,
			template = "controller_stage_15_swamp_bubbles_spawner",
			pos = {
				x = 308,
				y = 579
			}
		},
		{
			swamp_id = 2,
			template = "controller_stage_15_swamp_spawn_points",
			center_spawn = {
				x = 180,
				y = 193
			},
			["graveyard.spawn_pos"] = {
				{
					x = 150,
					y = 214
				},
				{
					x = 120,
					y = 210
				},
				{
					x = 104,
					y = 187
				},
				{
					x = 127,
					y = 171
				},
				{
					x = 156,
					y = 183
				},
				{
					x = 149,
					y = 152
				},
				{
					x = 205,
					y = 160
				},
				{
					x = 191,
					y = 181
				},
				{
					x = 218,
					y = 176
				},
				{
					x = 171,
					y = 200
				},
				{
					x = 172,
					y = 164
				}
			},
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			swamp_id = 1,
			template = "controller_stage_15_swamp_spawn_points",
			center_spawn = {
				x = 336,
				y = 572
			},
			["graveyard.spawn_pos"] = {
				{
					x = 314,
					y = 556
				},
				{
					x = 303,
					y = 540
				},
				{
					x = 280,
					y = 552
				},
				{
					x = 283,
					y = 575
				},
				{
					x = 299,
					y = 600
				},
				{
					x = 329,
					y = 597
				},
				{
					x = 329,
					y = 585
				},
				{
					x = 353,
					y = 602
				},
				{
					x = 367,
					y = 585
				},
				{
					x = 283,
					y = 534
				},
				{
					x = 343,
					y = 580
				}
			},
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_stage_15_swamps",
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
			["render.sprites[1].name"] = "Stage15_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 993,
				y = 323
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 930,
				y = 476
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1010,
				y = 268
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 974,
				y = 376
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 952,
				y = 417
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 905,
				y = 532
			}
		},
		{
			template = "decal_easter_egg_stage_15_the_ring",
			pos = {
				x = 408,
				y = 123
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = -24,
				y = 161
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 81,
				y = 164
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 136,
				y = 177
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 90,
				y = 190
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 94,
				y = 190
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 36,
				y = 209
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 140,
				y = 212
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 111,
				y = 214
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 79,
				y = 220
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 90,
				y = 251
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 63,
				y = 266
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 79,
				y = 291
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 208,
				y = 536
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 244,
				y = 543
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 223,
				y = 559
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 308,
				y = 561
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 268,
				y = 565
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 281,
				y = 581
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 296,
				y = 598
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 352,
				y = 598
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 325,
				y = 600
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 312,
				y = 621
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 357,
				y = 622
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 338,
				y = 632
			}
		},
		{
			template = "decal_stage_15_ambient_bubbles",
			pos = {
				x = 358,
				y = 642
			}
		},
		{
			template = "decal_stage_15_cabin_smoke",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_cauldron",
			["editor.game_mode"] = 1,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_flags",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_lord_blackburn_corrupt_level_1_idle",
			["editor.game_mode"] = 1,
			pos = {
				x = 850,
				y = 324
			}
		},
		{
			template = "decal_stage_15_lord_blackburn_corrupt_level_1_idle",
			["editor.game_mode"] = 8,
			pos = {
				x = 850,
				y = 324
			}
		},
		{
			template = "decal_stage_15_lord_blackburn_corrupt_level_3_idle",
			["editor.game_mode"] = 3,
			pos = {
				x = 850,
				y = 324
			}
		},
		{
			template = "decal_stage_15_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_water_ripples",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_15_witch",
			["editor.game_mode"] = 1,
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = -1.5533430342749,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 497,
				y = 149
			}
		},
		{
			["editor.r"] = 3.1590459461097,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -34,
				y = 411
			}
		},
		{
			["editor.r"] = 3.1660272631177,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -34,
				y = 457
			}
		},
		{
			["editor.r"] = 1.7976891295541,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 538,
				y = 675.5
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_crossbows_lvl2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_crossbows_lvl2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 625,
				y = 173
			},
			["tower.default_rally_pos"] = {
				x = 560,
				y = 254
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 390,
				y = 187
			},
			["tower.default_rally_pos"] = {
				x = 403,
				y = 274.5
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 799,
				y = 236
			},
			["tower.default_rally_pos"] = {
				x = 723,
				y = 297
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 254,
				y = 323
			},
			["tower.default_rally_pos"] = {
				x = 350,
				y = 333
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 624,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 659,
				y = 265
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 474,
				y = 336
			},
			["tower.default_rally_pos"] = {
				x = 486,
				y = 253.5
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 681,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 717,
				y = 474
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 532,
				y = 390
			},
			["tower.default_rally_pos"] = {
				x = 559,
				y = 465
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 215,
				y = 459
			},
			["tower.default_rally_pos"] = {
				x = 241,
				y = 392
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 344,
				y = 464
			},
			["tower.default_rally_pos"] = {
				x = 380,
				y = 403.5
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 523,
				y = 528
			},
			["tower.default_rally_pos"] = {
				x = 476,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 706,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 507
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 10,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 460,
				y = 592
			},
			["tower.default_rally_pos"] = {
				x = 578,
				y = 629
			}
		}
	},
	ignore_walk_backwards_paths = {
		5,
		6
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
			max_upgrade_level = 4
		}
	},
	nav_mesh = {
		[2] = {
			4,
			nil,
			nil,
			1
		},
		[3] = {
			6,
			2,
			1
		},
		[4] = {
			5,
			5,
			2,
			6
		},
		[5] = {
			8,
			nil,
			4
		},
		[6] = {
			11,
			4,
			3
		},
		[7] = {
			10,
			9,
			6,
			6
		},
		[8] = {
			13,
			nil,
			5,
			9
		},
		[9] = {
			10,
			8,
			7
		},
		[10] = {
			14,
			12,
			7,
			11
		},
		[11] = {
			14,
			10,
			6
		},
		[12] = {
			nil,
			13,
			9,
			14
		},
		[13] = {
			[3.0] = 8,
			[4.0] = 12
		},
		[14] = {
			nil,
			12,
			11
		}
	},
	required_exoskeletons = {
		"BB_decalDef",
		"BB_explosionDef",
		"BB_hit_01Def",
		"BB_hit_02Def",
		"BB_rayDef",
		"BB_V1Def",
		"BB_V2Def",
		"BB_V3Def",
		"flags_stg15Def",
		"smoke_stg15Def",
		"witch_stg15Def",
		"witch_stg15_witchstartDef",
		"blackburnDef",
		"BB_LoseDef",
		"water_ripples_stg15Def",
		"mist_stg15Def",
		"bubbles_stg15Def"
	},
	required_sounds = {
		"music_stage15",
		"enemies_T3",
		"stage_15",
		"terrain_3_common",
		"tower_crossbows"
	},
	required_textures = {
		"go_stage15_bg",
		"go_stage15",
		"go_enemies_T3",
		"go_towers_crossbows"
	}
}

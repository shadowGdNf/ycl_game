return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = -48,
				y = 410
			}
		},
		{
			pos = {
				x = -48,
				y = 370
			}
		},
		{
			pos = {
				x = 464,
				y = 310
			}
		},
		{
			pos = {
				x = 580,
				y = 440
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 360,
			y = 420
		}
	},
	entities_list = {
		{
			min_delay = 7,
			template = "background_sounds_kr5",
			max_delay = 13,
			only_on_preparation = true,
			sounds = {
				"Terrain2Ambience"
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
			["render.sprites[1].name"] = "Stage09_0001",
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
				x = -48,
				y = 401
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -58,
				y = 331
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -35,
				y = 464
			}
		},
		{
			template = "decal_stage_09_bg_brazier",
			pos = {
				x = 490,
				y = 603
			}
		},
		{
			template = "decal_stage_09_brazier",
			pos = {
				x = 484,
				y = 533
			}
		},
		{
			template = "decal_stage_09_cliff_mask_big",
			pos = {
				x = 529,
				y = 94
			}
		},
		{
			template = "decal_stage_09_cliff_mask_small",
			pos = {
				x = 177,
				y = 137
			}
		},
		{
			template = "decal_stage_09_cliff_mask_small",
			pos = {
				x = 865,
				y = 137
			}
		},
		{
			template = "decal_stage_09_entrance_cover",
			pos = {
				x = 940,
				y = 655
			}
		},
		{
			template = "decal_stage_09_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_09_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_09_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_09_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_09_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_09_mortal_kombat",
			pos = {
				x = 491,
				y = 606
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 178,
				y = 84
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 530,
				y = 84
			}
		},
		{
			["editor.r"] = -1.5707963267949,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 839,
				y = 84
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 884,
				y = 84
			}
		},
		{
			["editor.r"] = 0.17453292519943,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1031,
				y = 353
			}
		},
		{
			["editor.r"] = 0.17453292519942,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1031,
				y = 405
			}
		},
		{
			["editor.r"] = 0.87266462599716,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 100,
			pos = {
				x = 962,
				y = 626
			}
		},
		{
			["editor.r"] = 0.52359877559829,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 926,
				y = 635
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 1,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 4,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 5,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 6,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 7,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "12",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 8,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "12",
			["pillar.default_rally_pos"] = {
				x = 1001,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 968,
				y = 359
			},
			pos = {
				x = 968,
				y = 424
			}
		},
		{
			["pillar.holder_id"] = "1",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 0,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "1",
			["pillar.default_rally_pos"] = {
				x = 67,
				y = 365
			},
			["pillar.pillar_damage_center"] = {
				x = 125,
				y = 365
			},
			pos = {
				x = 126,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 1,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 4,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 5,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 6,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 7,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "3",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 8,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "3",
			["pillar.default_rally_pos"] = {
				x = 250,
				y = 364
			},
			["pillar.pillar_damage_center"] = {
				x = 296,
				y = 358
			},
			pos = {
				x = 297,
				y = 427
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 1,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 4,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 5,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 6,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 7,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["pillar.holder_id"] = "8",
			template = "tower_holder_pillar_terrain_2_1_top",
			["editor.game_mode"] = 8,
			["pillar.terrain_style"] = 6,
			["ui.nav_mesh_id"] = "8",
			["pillar.default_rally_pos"] = {
				x = 675,
				y = 378
			},
			["pillar.pillar_damage_center"] = {
				x = 748,
				y = 359
			},
			pos = {
				x = 749,
				y = 429
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 395,
				y = 237
			},
			["tower.default_rally_pos"] = {
				x = 465,
				y = 318
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 79,
				y = 275
			},
			["tower.default_rally_pos"] = {
				x = 162,
				y = 365
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 296,
				y = 275
			},
			["tower.default_rally_pos"] = {
				x = 373,
				y = 371
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 758,
				y = 275
			},
			["tower.default_rally_pos"] = {
				x = 759,
				y = 364
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 958,
				y = 275
			},
			["tower.default_rally_pos"] = {
				x = 938,
				y = 362
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 537,
				y = 365
			},
			["tower.default_rally_pos"] = {
				x = 513,
				y = 438
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 864,
				y = 424
			},
			["tower.default_rally_pos"] = {
				x = 860,
				y = 365
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 667,
				y = 471
			},
			["tower.default_rally_pos"] = {
				x = 617,
				y = 427
			}
		}
	},
	ignore_walk_backwards_paths = {
		3,
		4,
		5,
		6,
		7,
		8
	},
	invalid_path_ranges = {
		{
			to = 54,
			from = 0,
			path_id = 7,
			flags = NF_NO_BACKWARDS
		},
		{
			to = 125,
			from = 0,
			path_id = 8,
			flags = NF_NO_BACKWARDS
		}
	},
	level_mode_overrides = {
		{
			locked_towers = {}
		},
		{
			locked_towers = {}
		},
		{
			available_towers = {
				"tower_build_sunray_master",
				"tower_build_ranger"
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
			max_upgrade_level = 3
		}
	},
	nav_mesh = {
		{
			3,
			nil,
			nil,
			2
		},
		{
			4,
			1
		},
		{
			6,
			nil,
			1,
			4
		},
		{
			5,
			3,
			2
		},
		{
			9,
			6,
			4
		},
		{
			10,
			7,
			3,
			5
		},
		{
			8,
			nil,
			3,
			6
		},
		{
			10,
			nil,
			7,
			9
		},
		{
			11,
			8,
			5
		},
		{
			12,
			nil,
			8,
			11
		},
		{
			nil,
			12,
			9
		},
		{
			[3.0] = 10,
			[4.0] = 11
		}
	},
	required_exoskeletons = {
		"down_column_stg9Def",
		"top_column_stg9Def",
		"fire_small_stg9Def",
		"fire_stg9Def",
		"troll_door_stg9Def",
		"top_column_crumble_stg9Def",
		"down_column_crumble_stg9Def",
		"column_decal_stg9Def",
		"easter_egg_mortal_kombatDef"
	},
	required_sounds = {
		"enemies_T2",
		"music_stage09",
		"stage_09",
		"terrain_2_common"
	},
	required_textures = {
		"go_stage09_bg",
		"go_stage09",
		"go_enemies_T2"
	}
}

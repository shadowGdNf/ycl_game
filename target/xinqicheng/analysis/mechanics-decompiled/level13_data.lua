return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 347,
				y = 565
			}
		},
		{
			pos = {
				x = 679,
				y = 565
			}
		},
		{
			pos = {
				x = 282,
				y = 370
			}
		},
		{
			pos = {
				x = 730,
				y = 370
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 500,
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
			template = "controller_stage_13_achievement"
		},
		{
			template = "controller_stage_13_spawn_sorcerer"
		},
		{
			template = "controller_stage_13_sunray_tower_health"
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
			["render.sprites[1].name"] = "Stage13_0001",
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
				x = 347,
				y = 565
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 1,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 679,
				y = 565
			}
		},
		{
			template = "decal_stage_13_cliff_mask_small",
			pos = {
				x = 167,
				y = 97
			}
		},
		{
			template = "decal_stage_13_cliff_mask_small",
			pos = {
				x = 855,
				y = 105
			}
		},
		{
			template = "decal_stage_13_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_mask_2",
			pos = {
				x = 512,
				y = 466
			}
		},
		{
			template = "decal_stage_13_mask_3",
			pos = {
				x = 512,
				y = 546
			}
		},
		{
			template = "decal_stage_13_mask_4",
			pos = {
				x = 512,
				y = 466
			}
		},
		{
			template = "decal_stage_13_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_mask_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_mask_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_mask_9",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_13_water",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 141,
				y = 134
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 490,
				y = 134
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 540,
				y = 134
			}
		},
		{
			["editor.r"] = -1.5707963267949,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 890,
				y = 134
			}
		},
		{
			["editor.r"] = -3.1415926535898,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 16,
				y = 306
			}
		},
		{
			["editor.r"] = 1.1657341758564e-15,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1003,
				y = 308
			}
		},
		{
			["editor.r"] = -9.0757121103705,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 80,
			pos = {
				x = 149,
				y = 370
			}
		},
		{
			["editor.r"] = -12.915436464758,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 80,
			pos = {
				x = 869,
				y = 370
			}
		},
		{
			["editor.r"] = -10.995574287564,
			["editor.path_id"] = 11,
			template = "editor_wave_flag",
			["editor.len"] = 80,
			pos = {
				x = 149,
				y = 450
			}
		},
		{
			["editor.r"] = -10.995574287564,
			["editor.path_id"] = 12,
			template = "editor_wave_flag",
			["editor.len"] = 80,
			pos = {
				x = 874,
				y = 450
			}
		},
		{
			["editor.r"] = -3.8397243543875,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 4,
				y = 500
			}
		},
		{
			["editor.r"] = -5.4105206811824,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1019,
				y = 500
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 618,
				y = 200
			},
			["tower.default_rally_pos"] = {
				x = 552,
				y = 279
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 403,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 441,
				y = 268
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 228,
				y = 275
			},
			["tower.default_rally_pos"] = {
				x = 292,
				y = 355
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 795,
				y = 279
			},
			["tower.default_rally_pos"] = {
				x = 806,
				y = 365
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 408,
				y = 355
			},
			["tower.default_rally_pos"] = {
				x = 360,
				y = 294
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 610,
				y = 356
			},
			["tower.default_rally_pos"] = {
				x = 654,
				y = 299
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 73,
				y = 426
			},
			["tower.default_rally_pos"] = {
				x = 93,
				y = 359
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 949,
				y = 426
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 360
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 222,
				y = 433
			},
			["tower.default_rally_pos"] = {
				x = 195,
				y = 370
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 802,
				y = 435
			},
			["tower.default_rally_pos"] = {
				x = 727,
				y = 377
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 607,
				y = 506
			},
			["tower.default_rally_pos"] = {
				x = 708,
				y = 519
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 6,
			template = "tower_holder_terrain_2_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 415,
				y = 507
			},
			["tower.default_rally_pos"] = {
				x = 316,
				y = 494
			}
		},
		{
			["tower.holder_id"] = "41",
			["ui.nav_mesh_id"] = "41",
			template = "tower_stage_13_broken_sunray_obelisk",
			["editor.game_mode"] = 0,
			pos = {
				x = 107,
				y = 280
			},
			["tower.default_rally_pos"] = {
				x = 129,
				y = 226
			}
		},
		{
			["tower.holder_id"] = "41",
			["ui.nav_mesh_id"] = "41",
			template = "tower_stage_13_broken_sunray_obelisk",
			["editor.game_mode"] = 0,
			pos = {
				x = 918,
				y = 280
			},
			["tower.default_rally_pos"] = {
				x = 896,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "39",
			["ui.nav_mesh_id"] = "39",
			template = "tower_stage_13_sunray_tower",
			["editor.game_mode"] = 0,
			pos = {
				x = 514,
				y = 459
			},
			["tower.default_rally_pos"] = {
				x = 514,
				y = 502
			}
		}
	},
	ignore_walk_backwards_paths = {
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14
	},
	invalid_path_ranges = {
		{
			from = 99,
			to = 108,
			path_id = 1
		},
		{
			from = 97,
			to = 103,
			path_id = 2
		},
		{
			from = 114,
			to = 123,
			path_id = 3
		},
		{
			from = 113,
			to = 119,
			path_id = 4
		},
		{
			from = 104,
			to = 114,
			path_id = 5
		},
		{
			from = 104,
			to = 112,
			path_id = 6
		},
		{
			from = 95,
			to = 104,
			path_id = 13
		},
		{
			from = 94,
			to = 104,
			path_id = 14
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
				"tower_build_culverine"
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
			max_upgrade_level = 4
		}
	},
	nav_mesh = {
		{
			2
		},
		{
			5,
			nil,
			1,
			3
		},
		{
			5,
			2,
			1
		},
		{
			7,
			nil,
			2,
			5
		},
		{
			8,
			4,
			3,
			6
		},
		{
			9,
			5,
			3
		},
		{
			10,
			nil,
			4,
			8
		},
		{
			11,
			7,
			5,
			9
		},
		{
			11,
			8,
			6
		},
		{
			12,
			nil,
			8,
			11
		},
		{
			12,
			10,
			8
		},
		{
			[3.0] = 10,
			[4.0] = 11
		},
		[39] = {},
		[41] = {}
	},
	required_exoskeletons = {
		"trollbossDef",
		"trollboss_shieldflyDef",
		"trollboss_shieldfly_trailDef",
		"trollboss_shieldDef",
		"trollboss_landDef",
		"trollboss_decallandDef",
		"trollboss_decalattackDef",
		"trollboss_cinematicsDef",
		"trollboss_leveldecowhenlandDef",
		"sorcerersideDef",
		"sunraytowers13Def",
		"sunraytowers13baseDef",
		"sunraytowers13brokenDef",
		"sunraytowers13broken2Def",
		"sunraytowerminiDef",
		"sunraytowers13hurtoverlayDef",
		"watershineS13Def"
	},
	required_sounds = {
		"music_stage13",
		"enemies_T2",
		"stage_13",
		"terrain_2_common"
	},
	required_textures = {
		"go_stage13_bg",
		"go_stage13",
		"go_enemies_T2"
	}
}

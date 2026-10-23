return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 502,
				y = 51
			}
		},
		{
			pos = {
				x = 699,
				y = 51
			}
		},
		{
			pos = {
				x = 504,
				y = 192
			}
		},
		{
			pos = {
				x = 718,
				y = 192
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 510,
			y = 320
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
			template = "controller_stage_12_elevator",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			flip_spawns = true,
			template = "controller_stage_12_troll_rappel_spawner",
			spawner_id = 2,
			pos = {
				x = 811,
				y = 246
			}
		},
		{
			template = "controller_stage_12_troll_rappel_spawner",
			spawner_id = 1,
			pos = {
				x = 453,
				y = 266
			}
		},
		{
			template = "controller_stage_12_troll_rappel_spawning",
			pos = {
				x = 289,
				y = 620
			}
		},
		{
			template = "controller_stage_12_wreak_havoc_achievement"
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
			["render.sprites[1].name"] = "Stage12_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = -1,
			["editor.orientation"] = 6,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 502,
				y = 51
			}
		},
		{
			["editor.flip"] = -1,
			["editor.orientation"] = 6,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 699,
				y = 51
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 437,
				y = 51
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 579,
				y = 51
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 622,
				y = 51
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 762,
				y = 51
			}
		},
		{
			template = "decal_stage_12_campfire",
			pos = {
				x = 511,
				y = 383
			}
		},
		{
			template = "decal_stage_12_elevator",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_10",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_11",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_12",
			pos = {
				x = 512,
				y = 290
			}
		},
		{
			template = "decal_stage_12_mask_13",
			pos = {
				x = 512,
				y = 575
			}
		},
		{
			template = "decal_stage_12_mask_14",
			pos = {
				x = 512,
				y = 320
			}
		},
		{
			template = "decal_stage_12_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_4",
			pos = {
				x = 29,
				y = 583
			}
		},
		{
			template = "decal_stage_12_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_6",
			pos = {
				x = 512,
				y = 320
			}
		},
		{
			template = "decal_stage_12_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_mask_8",
			pos = {
				x = 512,
				y = 290
			}
		},
		{
			template = "decal_stage_12_mask_9",
			pos = {
				x = 512,
				y = 452
			}
		},
		{
			template = "decal_stage_12_torch",
			pos = {
				x = 358,
				y = 11
			}
		},
		{
			template = "decal_stage_12_torch",
			["render.sprites[1].flip_x"] = true,
			pos = {
				x = 549,
				y = 311
			}
		},
		{
			template = "decal_stage_12_torch",
			pos = {
				x = 823,
				y = 323
			}
		},
		{
			template = "decal_stage_12_torch",
			["render.sprites[1].flip_x"] = true,
			["render.sprites[1].z"] = 3101,
			pos = {
				x = -95,
				y = 464
			}
		},
		{
			template = "decal_stage_12_torch",
			pos = {
				x = 28,
				y = 505
			}
		},
		{
			template = "decal_stage_12_torch",
			["render.sprites[1].flip_x"] = true,
			pos = {
				x = 658,
				y = 554
			}
		},
		{
			template = "decal_stage_12_torch",
			["render.sprites[1].flip_x"] = true,
			pos = {
				x = 1157,
				y = 576
			}
		},
		{
			template = "decal_stage_12_trollcito",
			pos = {
				x = 511,
				y = 383
			}
		},
		{
			template = "decal_stage_12_vase_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_12_vase_7",
			pos = {
				x = 511,
				y = 388
			}
		},
		{
			template = "decal_stage_12_vase_8",
			pos = {
				x = 511,
				y = 388
			}
		},
		{
			["editor.r"] = -2.9670597283904,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -33,
				y = 242
			}
		},
		{
			["editor.r"] = -7.8539816339745,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 277
			}
		},
		{
			["editor.r"] = -4.8869219055842,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 60,
			pos = {
				x = 658,
				y = 280
			}
		},
		{
			["editor.r"] = -4.5378560551853,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 60,
			pos = {
				x = 719,
				y = 280
			}
		},
		{
			["editor.r"] = -3.4906585039887,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -33,
				y = 282
			}
		},
		{
			["editor.r"] = -4.5378560551853,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 60,
			pos = {
				x = 421,
				y = 322
			}
		},
		{
			["editor.r"] = -6.2831853071796,
			["editor.path_id"] = 11,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 324
			}
		},
		{
			["editor.r"] = -4.7123889803847,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 930,
				y = 361
			}
		},
		{
			["editor.r"] = -3.8397243543876,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 50,
			pos = {
				x = -42,
				y = 397
			}
		},
		{
			["editor.r"] = -4.7123889803847,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 312,
				y = 568
			}
		},
		{
			["editor.r"] = -4.7123889803847,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 369,
				y = 568
			}
		},
		{
			template = "ps_stage_12_snow",
			pos = {
				x = 867,
				y = 769
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_catapult_lvl1",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 602,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 522,
				y = 107
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 795,
				y = 132
			},
			["tower.default_rally_pos"] = {
				x = 756,
				y = 199
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 197,
				y = 154
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 227
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 397,
				y = 174
			},
			["tower.default_rally_pos"] = {
				x = 492,
				y = 242
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 898,
				y = 197
			},
			["tower.default_rally_pos"] = {
				x = 853,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 613,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 706,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 283,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 143,
				y = 294
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 225
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 337,
				y = 463
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 513
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 190,
				y = 552
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 488
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 486,
				y = 556
			},
			["tower.default_rally_pos"] = {
				x = 468,
				y = 498
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 9,
			template = "tower_holder_terrain_2_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 578,
				y = 562
			},
			["tower.default_rally_pos"] = {
				x = 634,
				y = 504
			}
		},
		{
			["tunnel.name"] = "1",
			["tunnel.place_pi"] = 3,
			template = "tunnel_KR6",
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 2,
			pos = {
				x = 377,
				y = 428
			}
		},
		{
			["tunnel.name"] = "1",
			["tunnel.place_pi"] = 6,
			template = "tunnel_KR6",
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 1,
			pos = {
				x = 377,
				y = 428
			}
		},
		{
			["tunnel.name"] = "2",
			["tunnel.place_pi"] = 4,
			template = "tunnel_KR6",
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 6,
			pos = {
				x = 377,
				y = 428
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
		13
	},
	invalid_path_ranges = {
		{
			flags = 1048576,
			to = 53,
			from = 0,
			path_id = 5
		},
		{
			from = 0,
			to = 80,
			path_id = 6
		},
		{
			flags = 1048576,
			to = 15,
			from = 0,
			path_id = 8
		},
		{
			flags = 1048576,
			to = 15,
			from = 0,
			path_id = 9
		},
		{
			flags = 1048576,
			to = 53,
			from = 0,
			path_id = 10
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
				"tower_build_knights",
				"tower_build_ranger"
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
			4,
			2,
			nil,
			3
		},
		{
			5,
			nil,
			nil,
			1
		},
		{
			6,
			1
		},
		{
			6,
			5,
			1,
			3
		},
		{
			7,
			nil,
			2,
			4
		},
		{
			10,
			5,
			3
		},
		{
			8,
			nil,
			5,
			6
		},
		{
			[3.0] = 7,
			[4.0] = 9
		},
		{
			11,
			8,
			6,
			10
		},
		{
			11,
			9,
			6
		},
		{
			12,
			9,
			10
		},
		{
			[3.0] = 11
		}
	},
	required_exoskeletons = {
		"stage12_elevatorDef",
		"stage12torchDef",
		"easteregg_trollcitoDef",
		"easteregg_trollsfogataDef",
		"easteregg_jarronroto_1Def",
		"easteregg_jarronroto_2Def",
		"easteregg_jarronroto_3Def",
		"easteregg_jarronroto_4Def",
		"easteregg_jarronroto_5Def",
		"easteregg_jarronroto_6Def",
		"easteregg_jarronroto_7Def",
		"easteregg_jarronroto_8Def"
	},
	required_sounds = {
		"music_stage12",
		"enemies_T2",
		"stage_12",
		"terrain_2_common",
		"tower_catapult"
	},
	required_textures = {
		"go_stage12",
		"go_stage12_bg",
		"go_enemies_T2",
		"go_towers_catapult"
	}
}

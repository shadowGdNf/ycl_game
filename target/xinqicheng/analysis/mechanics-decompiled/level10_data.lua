return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 1118,
				y = 381
			}
		},
		{
			pos = {
				x = 1118,
				y = 239
			}
		},
		{
			pos = {
				x = 981,
				y = 435
			}
		},
		{
			pos = {
				x = 981,
				y = 239
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 620,
			y = 360
		}
	},
	entities_list = {
		{
			pid = 3,
			template = "aura_stage_10_puddle_entrance",
			paths_involved = {},
			pos = {
				x = 196,
				y = 369
			}
		},
		{
			pid = 2,
			template = "aura_stage_10_puddle_entrance",
			pos = {
				x = 196,
				y = 369
			}
		},
		{
			pid = 6,
			template = "aura_stage_10_puddle_entrance",
			pos = {
				x = 418,
				y = 374
			}
		},
		{
			pid = 6,
			template = "aura_stage_10_puddle_exit",
			pos = {
				x = 639,
				y = 197
			}
		},
		{
			pid = 2,
			template = "aura_stage_10_puddle_exit",
			pos = {
				x = 639,
				y = 197
			}
		},
		{
			pid = 3,
			template = "aura_stage_10_puddle_exit",
			pos = {
				x = 436,
				y = 436
			}
		},
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
			template = "controller_stage_10_jt_icicles",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "controller_stage_10_jt_swipe",
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
			["render.sprites[1].name"] = "Stage10_0001",
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
				x = 1118,
				y = 239
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 1118,
				y = 381
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1118,
				y = 189
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1118,
				y = 288
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 1118,
				y = 328
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 1118,
				y = 434
			}
		},
		{
			template = "decal_stage_10_at_at",
			pos = {
				x = 509,
				y = 377
			},
			["shoot_pos.pos"] = {
				x = 960,
				y = 444
			}
		},
		{
			template = "decal_stage_10_sasquatch",
			pos = {
				x = 509,
				y = 377
			}
		},
		{
			template = "decal_stage_10_jacuzzi",
			pos = {
				x = 731,
				y = 662
			}
		},
		{
			template = "decal_stage_10_jt_door",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_10_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_10_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_10_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_10_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_10_waterfall",
			pos = {
				x = -88,
				y = 428
			}
		},
		{
			template = "decal_stage_10_well",
			pos = {
				x = 614,
				y = 232
			},
			paths = {
				2
			}
		},
		{
			template = "decal_stage_10_well",
			paths = {
				2,
				3
			},
			pos = {
				x = 177,
				y = 380
			}
		},
		{
			template = "decal_stage_10_well",
			paths = {
				6
			},
			pos = {
				x = 424,
				y = 396
			}
		},
		{
			["editor.r"] = -3.1415926535898,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 170,
			pos = {
				x = -64,
				y = 246
			}
		},
		{
			["editor.r"] = -4.014257279587,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -27,
				y = 488
			}
		},
		{
			["editor.r"] = -4.014257279587,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 8,
				y = 516
			}
		},
		{
			["editor.r"] = -4.014257279587,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 125,
				y = 561
			}
		},
		{
			["editor.r"] = -4.014257279587,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 157,
				y = 593
			}
		},
		{
			template = "ps_stage_10_jacuzzi",
			pos = {
				x = 731,
				y = 662
			}
		},
		{
			template = "ps_stage_10_snow",
			pos = {
				x = 524,
				y = 769
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 367,
				y = 258
			},
			["tower.default_rally_pos"] = {
				x = 365,
				y = 192
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 904,
				y = 348
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 112,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 55,
				y = 440
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 496,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 494,
				y = 166
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 757,
				y = 225
			},
			["tower.default_rally_pos"] = {
				x = 763,
				y = 161
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 242,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 238,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 126,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 124,
				y = 204
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 633,
				y = 298
			},
			["tower.default_rally_pos"] = {
				x = 733,
				y = 341
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 975,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 941,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 798,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 691,
				y = 385
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 562,
				y = 391
			},
			["tower.default_rally_pos"] = {
				x = 531,
				y = 462
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 305,
				y = 403
			},
			["tower.default_rally_pos"] = {
				x = 322,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_terrain_2_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 7,
			template = "tower_holder_blocked_terrain_2_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 203,
				y = 434
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 502
			}
		}
	},
	ignore_walk_backwards_paths = {
		2,
		3,
		6
	},
	invalid_path_ranges = {
		{
			from = 54,
			to = 128,
			path_id = 2
		},
		{
			from = 54,
			to = 102,
			path_id = 3
		},
		{
			from = 60,
			to = 104,
			path_id = 6
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
				"tower_build_catapult",
				"tower_build_sunray_master"
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
			5,
			nil,
			1,
			4
		},
		{
			6,
			3,
			2
		},
		{
			8,
			nil,
			3,
			6
		},
		{
			7,
			5,
			4
		},
		{
			9,
			8,
			6
		},
		{
			9,
			nil,
			5,
			7
		},
		{
			10,
			8,
			7
		},
		{
			13,
			11,
			9
		},
		{
			12,
			nil,
			9,
			10
		},
		{
			13,
			nil,
			11,
			13
		},
		{
			nil,
			12,
			10
		}
	},
	required_exoskeletons = {
		"bubbles_jacuzzi_st10Def",
		"steam_jacuzzi_st10Def",
		"well_st10Def",
		"JT_stage10_death_debrisDef",
		"JT_stage10_houseDef",
		"JT_stage10_unitDef",
		"JT_stage10_unit_decalDef",
		"JT_stage10_unit_tower_fxDef",
		"easteregg_starwars_st10Def",
		"starwars_projectileDef",
		"animations_hitDef",
		"easteregg_sasquatchDef"
	},
	required_sounds = {
		"music_stage10",
		"enemies_T2",
		"stage_10",
		"terrain_2_common"
	},
	required_textures = {
		"go_stage10_bg",
		"go_stage10",
		"go_enemies_T2"
	}
}

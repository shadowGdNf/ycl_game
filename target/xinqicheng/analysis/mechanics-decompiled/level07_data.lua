return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 1124,
				y = 310
			}
		},
		{
			pos = {
				x = 1124,
				y = 476
			}
		},
		{
			pos = {
				x = 828,
				y = 416
			}
		},
		{
			pos = {
				x = 868,
				y = 302
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 660,
			y = 350
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
			template = "controller_stage_07_barn",
			pos = {
				x = 823,
				y = 226
			}
		},
		{
			template = "controller_stage_07_bushes"
		},
		{
			template = "controller_stage_07_horse",
			pos = {
				x = 823,
				y = 226
			}
		},
		{
			template = "controller_stage_07_horse",
			pos = {
				x = 823,
				y = 226
			}
		},
		{
			template = "controller_stage_07_horse",
			pos = {
				x = 823,
				y = 226
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
			["render.sprites[1].name"] = "Stage07_0001",
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
				x = 1124,
				y = 310
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 9,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 1124,
				y = 476
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1124,
				y = 248
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1124,
				y = 369
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1124,
				y = 409
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1124,
				y = 536
			}
		},
		{
			template = "decal_stage_07_barn",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_bonfire",
			pos = {
				x = 891,
				y = 579
			}
		},
		{
			template = "decal_stage_07_bush",
			pos = {
				x = 415,
				y = 142
			}
		},
		{
			template = "decal_stage_07_bush",
			pos = {
				x = 544,
				y = 297
			}
		},
		{
			template = "decal_stage_07_bush",
			pos = {
				x = 201,
				y = 388
			}
		},
		{
			template = "decal_stage_07_bush",
			pos = {
				x = 709,
				y = 480
			}
		},
		{
			template = "decal_stage_07_horse_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_horse_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_horse_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_mask_1",
			pos = {
				x = 512,
				y = 650
			}
		},
		{
			template = "decal_stage_07_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_shield_eastereggs",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_07_tent",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = 4.7123889803847,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 742,
				y = 57
			}
		},
		{
			["editor.r"] = -3.1415926535898,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -33,
				y = 354
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 172,
				y = 660
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 221,
				y = 660
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 648,
				y = 157
			},
			["tower.default_rally_pos"] = {
				x = 633,
				y = 253
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 327,
				y = 164
			},
			["tower.default_rally_pos"] = {
				x = 377,
				y = 248
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 87,
				y = 253
			},
			["tower.default_rally_pos"] = {
				x = 166,
				y = 313
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 746,
				y = 335
			},
			["tower.default_rally_pos"] = {
				x = 835,
				y = 288
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 279,
				y = 342
			},
			["tower.default_rally_pos"] = {
				x = 258,
				y = 271
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 964,
				y = 379
			},
			["tower.default_rally_pos"] = {
				x = 952,
				y = 315
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 37,
				y = 410
			},
			["tower.default_rally_pos"] = {
				x = 53,
				y = 336
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 134,
				y = 424
			},
			["tower.default_rally_pos"] = {
				x = 204,
				y = 497
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 793,
				y = 484
			},
			["tower.default_rally_pos"] = {
				x = 828,
				y = 423
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 311,
				y = 509
			},
			["tower.default_rally_pos"] = {
				x = 266,
				y = 443
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_terrain_1_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 81,
				y = 532
			},
			["tower.default_rally_pos"] = {
				x = 191,
				y = 581
			}
		},
		{
			["tower.holder_id"] = "12",
			["ui.nav_mesh_id"] = "12",
			template = "tower_stage_07_barn",
			["editor.game_mode"] = 0,
			pos = {
				x = 1004,
				y = 579
			},
			["tower.default_rally_pos"] = {
				x = 936,
				y = 466
			}
		},
		{
			["tunnel.name"] = "1",
			["tunnel.place_pi"] = 5,
			template = "tunnel_KR6",
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 2,
			pos = {
				x = 377,
				y = 428
			}
		},
		{
			["tunnel.name"] = "2",
			["tunnel.place_pi"] = 6,
			template = "tunnel_KR6",
			["tunnel.pick_pi"] = 3,
			pos = {
				x = 377,
				y = 428
			}
		}
	},
	ignore_walk_backwards_paths = {
		7
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
			comment = "IRON MODE",
			available_towers = {
				"tower_build_ranger",
				"tower_build_catapult"
			},
			locked_towers = {
				"tower_build_archer",
				"tower_build_wizard"
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
			max_upgrade_level = 2
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
			4,
			nil,
			nil,
			1
		},
		{
			5,
			4,
			1
		},
		{
			5,
			2,
			1,
			3
		},
		{
			9,
			6,
			4,
			7
		},
		{
			10,
			nil,
			4,
			5
		},
		{
			8,
			5,
			3
		},
		{
			9,
			9,
			7
		},
		{
			11,
			10,
			5,
			8
		},
		{
			12,
			nil,
			6,
			9
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
		"stage_7_ambush_bushDef",
		"stage_7_ambush_out_fxDef",
		"stage_7_speech_bubbleDef",
		"stage_7_stable_frontDef",
		"stage_7_stable_horse1Def",
		"stage_7_stable_horse2Def",
		"stage_7_stable_horse3Def"
	},
	required_sounds = {
		"music_stage07",
		"enemies_T1",
		"stage_07",
		"terrain_1_common"
	},
	required_textures = {
		"go_stage07_bg",
		"go_stage07",
		"go_enemies_T1"
	}
}

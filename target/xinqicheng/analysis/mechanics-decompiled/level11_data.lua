return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 7,
	custom_spawn_pos = {
		{
			pos = {
				x = 255,
				y = 373
			}
		},
		{
			pos = {
				x = 770,
				y = 373
			}
		},
		{
			pos = {
				x = 360,
				y = 482
			}
		},
		{
			pos = {
				x = 651,
				y = 474
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 450,
			y = 400
		}
	},
	entities_list = {
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 654,
				y = 214
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 748,
				y = 228
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 822,
				y = 246
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 102,
				y = 486
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 783,
				y = 514
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 192,
				y = 518
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 687,
				y = 530
			}
		},
		{
			template = "aura_stage_11_spider_webs_slow",
			pos = {
				x = 603,
				y = 573
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 654,
				y = 214
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 748,
				y = 228
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 822,
				y = 246
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 102,
				y = 486
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 783,
				y = 514
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 192,
				y = 518
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 687,
				y = 530
			}
		},
		{
			template = "aura_stage_11_spider_webs_speed",
			pos = {
				x = 603,
				y = 573
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
			template = "controller_stage_11_boss_lower"
		},
		{
			template = "controller_stage_11_camp_barrack",
			default_rally_pos = {
				x = 312,
				y = 380
			},
			pos = {
				x = 403,
				y = 387
			}
		},
		{
			template = "controller_stage_11_camp_barrack",
			default_rally_pos = {
				x = 715,
				y = 374
			},
			pos = {
				x = 651,
				y = 401
			}
		},
		{
			template = "controller_stage_11_camp_barrack",
			default_rally_pos = {
				x = 652,
				y = 473
			},
			pos = {
				x = 598,
				y = 425
			}
		},
		{
			template = "controller_stage_11_camp_barrack",
			default_rally_pos = {
				x = 351,
				y = 479
			},
			pos = {
				x = 417,
				y = 434
			}
		},
		{
			template = "controller_stage_11_loss"
		},
		{
			template = "controller_stage_11_spider_block_and_spawn",
			active_waves = {
				3,
				5,
				6,
				7,
				9,
				10,
				12,
				13,
				15
			}
		},
		{
			template = "controller_stage_11_spider_eyes_decos",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "controller_stage_11_spider_rappel_spawner",
			spawner_id = 3,
			pos = {
				x = 345,
				y = 214
			}
		},
		{
			template = "controller_stage_11_spider_rappel_spawner",
			spawner_id = 2,
			pos = {
				x = 883,
				y = 305
			}
		},
		{
			template = "controller_stage_11_spider_rappel_spawner",
			spawner_id = 4,
			pos = {
				x = 120,
				y = 405
			}
		},
		{
			template = "controller_stage_11_spider_rappel_spawner",
			spawner_id = 1,
			pos = {
				x = 273,
				y = 574
			}
		},
		{
			template = "controller_stage_11_spider_rappel_spawning",
			pos = {
				x = 289,
				y = 620
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
			["render.sprites[1].name"] = "Stage11_0001",
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
				x = 714,
				y = 373
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 311,
				y = 380
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 651,
				y = 474
			}
		},
		{
			["editor.flip"] = -1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 360,
				y = 482
			}
		},
		{
			template = "decal_stage_11_camp_tents_back",
			pos = {
				x = 508,
				y = 420
			}
		},
		{
			template = "decal_stage_11_camp_tents_front",
			pos = {
				x = 508,
				y = 340
			}
		},
		{
			template = "decal_stage_11_camp_walls_back_p1",
			pos = {
				x = -167,
				y = 785
			}
		},
		{
			template = "decal_stage_11_camp_walls_back_p2",
			pos = {
				x = -177,
				y = 779
			}
		},
		{
			template = "decal_stage_11_camp_walls_front",
			pos = {
				x = 513,
				y = 340
			}
		},
		{
			template = "decal_stage_11_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_11_mask_2",
			pos = {
				x = 512,
				y = 476
			}
		},
		{
			template = "decal_stage_11_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_11_mask_4",
			pos = {
				x = 512,
				y = 700
			}
		},
		{
			template = "decal_stage_11_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_11_mask_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_11_shadows_lvl1",
			pos = {
				x = 300,
				y = 304
			}
		},
		{
			template = "decal_stage_11_shadows_lvl2",
			pos = {
				x = 300,
				y = 304
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 3,
			pos = {
				x = 393,
				y = 156
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 370,
				y = 268
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 616,
				y = 287
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 822,
				y = 304
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 3,
			pos = {
				x = 72,
				y = 381
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 3,
			pos = {
				x = 936,
				y = 411
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 227,
				y = 428
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 762,
				y = 470
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 483,
				y = 514
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 2,
			pos = {
				x = 561,
				y = 540
			}
		},
		{
			template = "decal_stage_11_torch",
			camp_level = 3,
			pos = {
				x = 474,
				y = 621
			}
		},
		{
			["editor.r"] = -1.5707963267949,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 533,
				y = 148
			}
		},
		{
			["editor.r"] = -7.8539816339745,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 579,
				y = 148
			}
		},
		{
			["editor.r"] = 0.90757121103705,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1082,
				y = 398
			}
		},
		{
			["editor.r"] = -5.5850536063819,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1051,
				y = 430
			}
		},
		{
			["editor.r"] = -3.9269908169873,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -33,
				y = 446
			}
		},
		{
			["editor.r"] = -4.014257279587,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -3,
				y = 479
			}
		},
		{
			["editor.r"] = -4.7123889803847,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 364,
				y = 638
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 409,
				y = 638
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 171,
				y = 300
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 300
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 772,
				y = 301
			},
			["tower.default_rally_pos"] = {
				x = 834,
				y = 243
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 930,
				y = 364
			},
			["tower.default_rally_pos"] = {
				x = 870,
				y = 300
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 858,
				y = 422
			},
			["tower.default_rally_pos"] = {
				x = 838,
				y = 494
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 181,
				y = 436
			},
			["tower.default_rally_pos"] = {
				x = 181,
				y = 380
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 8,
			template = "tower_holder_blocked_terrain_2_3_fog_of_war",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 354,
				y = 546
			},
			["tower.default_rally_pos"] = {
				x = 275,
				y = 546
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 557,
				y = 253
			},
			["tower.default_rally_pos"] = {
				x = 612,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 432,
				y = 254
			},
			["tower.default_rally_pos"] = {
				x = 400,
				y = 205
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 679,
				y = 285
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 369
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 345,
				y = 291
			},
			["tower.default_rally_pos"] = {
				x = 270,
				y = 310
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 731,
				y = 422
			},
			["tower.default_rally_pos"] = {
				x = 762,
				y = 374
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 269,
				y = 436
			},
			["tower.default_rally_pos"] = {
				x = 274,
				y = 373
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 550,
				y = 494
			},
			["tower.default_rally_pos"] = {
				x = 643,
				y = 478
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 8,
			template = "tower_holder_terrain_2_3",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 417,
				y = 506
			},
			["tower.default_rally_pos"] = {
				x = 360,
				y = 487
			}
		},
		{
			["tower.holder_id"] = "15",
			["ui.nav_mesh_id"] = "15",
			template = "tower_stage_11_camp_lvl1",
			["editor.game_mode"] = 1,
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			["ui.nav_mesh_id"] = "15",
			template = "tower_stage_11_camp_lvl1",
			["editor.game_mode"] = 2,
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			["ui.nav_mesh_id"] = "15",
			template = "tower_stage_11_camp_lvl1",
			["editor.game_mode"] = 4,
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			["ui.nav_mesh_id"] = "15",
			template = "tower_stage_11_camp_lvl1",
			["editor.game_mode"] = 8,
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			hand_insert = true,
			template = "tower_stage_11_camp_lvl3",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			hand_insert = true,
			template = "tower_stage_11_camp_lvl3",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			hand_insert = true,
			template = "tower_stage_11_camp_lvl3",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			["tower.holder_id"] = "15",
			hand_insert = true,
			template = "tower_stage_11_camp_lvl3",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 507,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 533,
				y = 430
			}
		},
		{
			path_id = 9,
			template = "tower_stage_11_spider_eggs_nest",
			nest_id = 3,
			["ui.nav_mesh_id"] = "16",
			pos = {
				x = 127,
				y = 250
			}
		},
		{
			path_id = 3,
			template = "tower_stage_11_spider_eggs_nest",
			nest_id = 2,
			["ui.nav_mesh_id"] = "17",
			pos = {
				x = 895,
				y = 542
			}
		},
		{
			path_id = 5,
			template = "tower_stage_11_spider_eggs_nest",
			nest_id = 1,
			["ui.nav_mesh_id"] = "18",
			pos = {
				x = 79,
				y = 553
			}
		}
	},
	ignore_walk_backwards_paths = {},
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
				"tower_build_miners",
				"tower_build_culverine"
			},
			locked_towers = {}
		},
		[5] = {
			comment = "TOWER RUSH MODE"
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
			3,
			18,
			2,
			2
		},
		{
			4,
			1,
			16,
			16
		},
		{
			6,
			5,
			1,
			4
		},
		{
			7,
			3,
			2
		},
		{
			6,
			nil,
			3,
			3
		},
		{
			8,
			5,
			3,
			7
		},
		{
			9,
			6,
			4
		},
		{
			11,
			nil,
			6,
			9
		},
		{
			10,
			8,
			7
		},
		{
			12,
			11,
			9
		},
		{
			13,
			nil,
			8,
			10
		},
		{
			14,
			11,
			10
		},
		{
			14,
			17,
			11
		},
		{
			17,
			13,
			12,
			12
		},
		{},
		{
			4,
			2,
			2
		},
		{
			14,
			nil,
			11,
			13
		},
		{
			3,
			nil,
			1,
			1
		}
	},
	required_exoskeletons = {
		"MainTentDef",
		"CampDef",
		"CampBackDef",
		"CampLevelsBackDef",
		"CampLevelsBack2Def",
		"CampLevelsDef",
		"CampSpiderTouchDef",
		"TorchDef",
		"TorchLightDef",
		"boss_stage_11Def",
		"boss_stage_11_shadowDef",
		"spiderdeco1Def",
		"spiderdeco2Def",
		"spiderdeco3Def",
		"spiderdeco4Def"
	},
	required_sounds = {
		"music_stage11",
		"enemies_spiders",
		"stage_11",
		"terrain_2_common"
	},
	required_textures = {
		"go_stage11",
		"go_stage11_bg",
		"go_enemies_spiders"
	}
}

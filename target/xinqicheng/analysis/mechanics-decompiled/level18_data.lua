return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 6,
	custom_spawn_pos = {
		{
			pos = {
				x = 202,
				y = 238
			}
		},
		{
			pos = {
				x = 817,
				y = 245
			}
		},
		{
			pos = {
				x = 202,
				y = 358
			}
		},
		{
			pos = {
				x = 817,
				y = 358
			}
		}
	},
	custom_start_pos = {
		zoom = 1,
		pos = {
			x = 512,
			y = 450
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
			template = "controller_stage_18_moloch",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "controller_stage_18_veznan",
			pos = {
				x = 518,
				y = 677
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
			["render.sprites[1].name"] = "Stage18_0001",
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
				x = 1,
				y = 204
			}
		},
		{
			["editor.flip"] = 1,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 1017,
				y = 204
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 45,
				y = 144
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 975,
				y = 144
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1062,
				y = 259
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -33,
				y = 260
			}
		},
		{
			["render.sprites[1].sort_y_offset"] = 116,
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3000,
			hide_from = "decal_stage_18_balcon_layer",
			["render.sprites[1].name"] = "stage_18_balcon_layer_02",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["render.sprites[1].sort_y_offset"] = 125,
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_18_18_puerta_terreno_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3100,
			hide_from = "decal_stage_18_mask_arbol_2",
			["render.sprites[1].name"] = "stage_18_16_terreno_2_arbol_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["render.sprites[1].sort_y_offset"] = 128,
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3000,
			hide_from = "decal_stage_18_spawner",
			["render.sprites[1].name"] = "stage18_1_spawner_noche",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3100,
			hide_from = "decal_stage_18_mask_ciudad_2",
			["render.sprites[1].name"] = "stage_18_14_terreno_2_ciudad_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3100,
			hide_from = "decal_stage_18_mask_arbol_1",
			["render.sprites[1].name"] = "stage_18_15_terreno_2_arbol_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_nightfall_overlay",
			["render.sprites[1].z"] = 3100,
			hide_from = "decal_stage_18_mask_ciudad_1",
			["render.sprites[1].name"] = "stage_18_13_terreno_2_ciudad_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_balcon_layer",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_mask_arbol_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_mask_arbol_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_mask_ciudad_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_mask_ciudad_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_nightfall",
			cut_list = {
				"fx_stage_18_explosion_entrada_denas"
			},
			notify_list = {},
			pos = {
				x = 512,
				y = 384
			},
			swap_list = {
				{
					from = "tower_holder_terrain_3_8",
					to = "tower_holder_terrain_3_10"
				},
				{
					from = "decal_stage_18_statue_mask",
					to = "decal_stage_18_statue_mask_noche"
				}
			}
		},
		{
			template = "decal_stage_18_portal_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_portal_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_portal_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_portal_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_portal_back",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_puerta",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_spawner",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_statue_mask",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_veznan_body",
			pos = {
				x = 518,
				y = 635
			}
		},
		{
			template = "decal_stage_18_water_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_18_water_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = -4.6949356878647,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 483,
				y = 489
			}
		},
		{
			["editor.r"] = -4.6949356878647,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 544,
				y = 490
			}
		},
		{
			["editor.r"] = -4.6949356878647,
			["editor.path_id"] = 22,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 500,
				y = 511
			}
		},
		{
			["editor.r"] = -4.6949356878647,
			["editor.path_id"] = 21,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 527,
				y = 511
			}
		},
		{
			["editor.r"] = 6.5170594269468,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 273,
				y = 600
			}
		},
		{
			["editor.r"] = 9.1176000124184,
			["editor.path_id"] = 11,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 752,
				y = 600
			}
		},
		{
			["editor.r"] = 9.2921329376178,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 752,
				y = 601
			}
		},
		{
			["editor.r"] = 6.5170594269468,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 226,
				y = 616
			}
		},
		{
			["editor.r"] = 9.1176000124184,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 799,
				y = 616
			}
		},
		{
			["editor.r"] = 6.5170594269468,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 315,
				y = 637
			}
		},
		{
			["editor.r"] = 9.1176000124184,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 710,
				y = 637
			}
		},
		{
			["editor.r"] = 6.5170594269468,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 263,
				y = 651
			}
		},
		{
			["editor.r"] = 9.222319767538,
			["editor.path_id"] = 12,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 762,
				y = 651
			}
		},
		{
			["editor.r"] = 9.2921329376178,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 762,
				y = 651
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 742,
				y = 164
			},
			["tower.default_rally_pos"] = {
				x = 829,
				y = 221
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 407,
				y = 198
			},
			["tower.default_rally_pos"] = {
				x = 505,
				y = 257
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 622,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 511,
				y = 202
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 1014,
				y = 271
			},
			["tower.default_rally_pos"] = {
				x = 964,
				y = 206
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 911,
				y = 272
			},
			["tower.default_rally_pos"] = {
				x = 894,
				y = 360
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 112,
				y = 274
			},
			["tower.default_rally_pos"] = {
				x = 110,
				y = 202
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 298,
				y = 279
			},
			["tower.default_rally_pos"] = {
				x = 218,
				y = 275
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 725,
				y = 280
			},
			["tower.default_rally_pos"] = {
				x = 639,
				y = 319
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 170,
				y = 423
			},
			["tower.default_rally_pos"] = {
				x = 172,
				y = 357
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 736,
				y = 425
			},
			["tower.default_rally_pos"] = {
				x = 739,
				y = 363
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 289,
				y = 430
			},
			["tower.default_rally_pos"] = {
				x = 361,
				y = 381
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 113,
				y = 492
			},
			["tower.default_rally_pos"] = {
				x = 85,
				y = 569
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 276,
				y = 527
			},
			["tower.default_rally_pos"] = {
				x = 210,
				y = 593
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 17,
			template = "tower_holder_terrain_3_8",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 741,
				y = 527
			},
			["tower.default_rally_pos"] = {
				x = 815,
				y = 595
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.name"] = "1",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 17,
			untargetable_distance = 3,
			["tunnel.place_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.pick_pi"] = 1,
			pos = {
				x = -13,
				y = 556
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.name"] = "2",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 18,
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 2,
			pos = {
				x = -13,
				y = 556
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.name"] = "3",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 19,
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 3,
			pos = {
				x = -13,
				y = 556
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.name"] = "4",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 20,
			untargetable_distance = 3,
			["tunnel.place_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.pick_pi"] = 4,
			pos = {
				x = -13,
				y = 556
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.name"] = "5",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 17,
			untargetable_distance = 3,
			["tunnel.place_fx"] = "fx_stage_18_portal_efecto_flip",
			["tunnel.pick_pi"] = 5,
			pos = {
				x = 1031,
				y = 597
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.name"] = "6",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 18,
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 6,
			pos = {
				x = 1027,
				y = 599
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.name"] = "7",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 19,
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 7,
			pos = {
				x = 1027,
				y = 599
			}
		},
		{
			["tunnel.pick_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.name"] = "8",
			template = "tunnel_stage_18",
			["tunnel.place_pi"] = 20,
			untargetable_distance = 3,
			["tunnel.place_fx"] = "fx_stage_18_portal_efecto",
			["tunnel.pick_pi"] = 8,
			pos = {
				x = 1027,
				y = 599
			}
		}
	},
	invalid_path_ranges = {
		{
			from = 0,
			to = 5,
			path_id = 1
		},
		{
			from = 0,
			to = 5,
			path_id = 2
		},
		{
			from = 0,
			to = 5,
			path_id = 3
		},
		{
			from = 0,
			to = 5,
			path_id = 4
		},
		{
			from = 0,
			to = 5,
			path_id = 5
		},
		{
			from = 0,
			to = 5,
			path_id = 6
		},
		{
			from = 0,
			to = 5,
			path_id = 7
		},
		{
			from = 0,
			to = 5,
			path_id = 8
		},
		{
			from = 0,
			to = 5,
			path_id = 13
		},
		{
			from = 0,
			to = 5,
			path_id = 14
		},
		{
			from = 0,
			to = 5,
			path_id = 15
		},
		{
			from = 0,
			to = 5,
			path_id = 16
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
				"tower_build_forger",
				"tower_build_crossbows"
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
			4,
			nil,
			nil,
			3
		},
		{
			6,
			3
		},
		{
			5,
			1,
			nil,
			2
		},
		{
			9,
			nil,
			1,
			5
		},
		{
			10,
			4,
			3,
			6
		},
		{
			7,
			5,
			2
		},
		{
			8,
			nil,
			6
		},
		{
			12,
			11,
			7
		},
		{
			[3.0] = 4,
			[4.0] = 10
		},
		{
			nil,
			9,
			5,
			11
		},
		{
			13,
			10,
			8,
			12
		},
		{
			13,
			11,
			8
		},
		{
			14,
			nil,
			11
		},
		{
			[3.0] = 13
		}
	},
	required_exoskeletons = {
		"MolochProyectileExplosionDef",
		"molochDef",
		"animations_denasDef",
		"animations_proyectilDef",
		"decal_piso_catapultaDef",
		"decal_piso_catapulta_terreno_1Def",
		"explosion_catapulta_terreno_1Def",
		"explosion_catapulta_terreno_2Def",
		"marker_piso_catapultaDef",
		"st_18_animations_portal_1Def",
		"st_18_animations_portal_2Def",
		"st_18_animations_portal_3Def",
		"st_18_animations_portal_4Def",
		"st_18_animations_portal_backDef",
		"stage_18_portal_efectoDef",
		"moloch_bottomDef",
		"veznan_fase1Def",
		"veznan_fase2Def",
		"veznan_fase2_balconDef",
		"veznan_stuntowerDef",
		"st_18_explosion_entrada_denasDef",
		"explosion_estatuaDef",
		"heal_decalDef",
		"healpump_decalDef",
		"teleportDef",
		"auraDef",
		"aura_bossDef",
		"aura_rayDef",
		"demon_circleDef",
		"st_18_terreno_2_animations_portal_1Def",
		"st_18_terreno_2_animations_portal_2Def",
		"st_18_terreno_2_animations_portal_3Def",
		"st_18_terreno_2_animations_portal_4Def",
		"st_18_terreno_2_portal_efectoDef",
		"MolochSmashDecalDef",
		"moloch_towerstunDef",
		"molochtargetDef",
		"animations_puerta_st_18_terreno_1Def",
		"animations_puerta_st_18_terreno_2Def",
		"moloch_handDef",
		"campanaDef",
		"grietaDef",
		"healDef",
		"shockwaveDef",
		"st_18_anims_agua_1Def",
		"st_18_anims_agua_2Def"
	},
	required_sounds = {
		"music_stage18",
		"enemies_T3",
		"terrain_3_common",
		"stage_18"
	},
	required_textures = {
		"go_stage18_bg",
		"go_stage18",
		"go_stage18_moloch",
		"go_stage18_denas",
		"go_stage18_veznan",
		"go_enemies_T3",
		"go_enemies_T3_demons",
		"gui_extra_portraits"
	}
}

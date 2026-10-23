return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 6,
	custom_spawn_pos = {
		{
			pos = {
				x = -72,
				y = 414
			}
		},
		{
			pos = {
				x = -72,
				y = 264
			}
		},
		{
			pos = {
				x = 28.3,
				y = 413
			}
		},
		{
			pos = {
				x = 15.3,
				y = 265
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 0,
			y = 384
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
			template = "controller_stage_17_castle_paladins",
			default_rally_pos = {
				x = 509,
				y = 428
			},
			pos = {
				x = 510,
				y = 542
			}
		},
		{
			template = "controller_stage_17_duel"
		},
		{
			template = "controller_stage_17_slayers",
			pos = {
				x = 510,
				y = 542
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
			["render.sprites[1].name"] = "Stage17_0001",
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
				x = -72,
				y = 264
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = -72,
				y = 414
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -72,
				y = 208
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -72,
				y = 324
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -72,
				y = 365
			}
		},
		{
			["editor.flip"] = 0,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -72,
				y = 466
			}
		},
		{
			template = "decal_stage_17_banners",
			pos = {
				x = 514,
				y = 385
			}
		},
		{
			template = "decal_stage_17_blacksmith",
			pos = {
				x = 524,
				y = 388
			}
		},
		{
			template = "decal_stage_17_bonfire",
			pos = {
				x = 704,
				y = 112
			}
		},
		{
			template = "decal_stage_17_bonfire",
			pos = {
				x = 942,
				y = 115
			}
		},
		{
			template = "decal_stage_17_bonfire",
			pos = {
				x = 984,
				y = 406
			}
		},
		{
			template = "decal_stage_17_bonfire",
			pos = {
				x = 913,
				y = 601
			}
		},
		{
			template = "decal_stage_17_bonfire_interactable",
			pos = {
				x = 174,
				y = 169
			}
		},
		{
			template = "decal_stage_17_duel",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_lady",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_2",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_3",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_4",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_mask_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_17_welders",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = -1.3439035240356,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 471,
				y = 114
			}
		},
		{
			["editor.r"] = -3.5672853559987e-14,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 292
			}
		},
		{
			["editor.r"] = 1.7437440380519e-14,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 332
			}
		},
		{
			["editor.r"] = -6.9333427887841e-14,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 468
			}
		},
		{
			["editor.r"] = 0.0069813170079673,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 1080,
				y = 508
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 16,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 15,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_6",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_7",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_7",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_7",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_7",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 11,
			template = "tower_holder_blocked_terrain_3_7",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 302,
				y = 212
			},
			["tower.default_rally_pos"] = {
				x = 383,
				y = 262
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 524,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 186
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 25,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 70,
				y = 407
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 142,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 264
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 460,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 580,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 5,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 6,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 7,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 8,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 270,
				y = 378
			},
			["tower.default_rally_pos"] = {
				x = 265,
				y = 303
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 576,
				y = 110
			},
			["tower.default_rally_pos"] = {
				x = 481,
				y = 191
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 718,
				y = 177
			},
			["tower.default_rally_pos"] = {
				x = 641,
				y = 248
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 820,
				y = 218
			},
			["tower.default_rally_pos"] = {
				x = 837,
				y = 299
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 784,
				y = 385
			},
			["tower.default_rally_pos"] = {
				x = 749,
				y = 475
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 11,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 890,
				y = 385
			},
			["tower.default_rally_pos"] = {
				x = 950,
				y = 313
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 15,
			template = "tower_holder_terrain_3_4",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 892,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 846,
				y = 480
			}
		},
		{
			["tower.holder_id"] = "54",
			["ui.nav_mesh_id"] = "54",
			template = "tower_stage_17_joust",
			["editor.game_mode"] = 0,
			pos = {
				x = 14,
				y = 516
			},
			["tower.default_rally_pos"] = {
				x = 120,
				y = 529
			}
		},
		{
			["tunnel.name"] = "1",
			["tunnel.place_pi"] = 7,
			template = "tunnel_stage_17",
			untargetable_distance = 3,
			["tunnel.pick_pi"] = 6,
			pos = {
				x = 377,
				y = 428
			}
		}
	},
	ignore_walk_backwards_paths = {
		7
	},
	invalid_path_ranges = {
		{
			from = 65,
			to = 100,
			path_id = 6
		}
	},
	level_mode_overrides = {
		{
			locked_towers = {}
		},
		{
			max_upgrade_level = 5,
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
				"tower_build_alchemist",
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
			max_upgrade_level = 5
		}
	},
	nav_mesh = {
		[2] = {
			[4.0] = 9
		},
		[3] = {
			4,
			54
		},
		[4] = {
			5,
			54,
			3,
			10
		},
		[5] = {
			6,
			nil,
			4,
			10
		},
		[6] = {
			7,
			nil,
			5,
			11
		},
		[7] = {
			8,
			nil,
			6,
			11
		},
		[8] = {
			9,
			2,
			7,
			13
		},
		[9] = {
			nil,
			2,
			8,
			13
		},
		[10] = {
			11,
			5,
			4
		},
		[11] = {
			12,
			7,
			10,
			14
		},
		[12] = {
			13,
			8,
			14
		},
		[13] = {
			nil,
			9,
			12
		},
		[14] = {
			12,
			nil,
			10
		},
		[54] = {
			[4.0] = 3
		}
	},
	required_exoskeletons = {
		"banner_stage_17Def",
		"blacksmith_stage_17Def",
		"bonfire_stage_17Def",
		"dark_welderDef",
		"justa_stage_17Def",
		"clash_stage_17Def",
		"stage14_blacksmithauraDef",
		"groupie_justaDef",
		"justa_win_coinsDef"
	},
	required_sounds = {
		"music_stage17",
		"enemies_T3",
		"stage_17",
		"terrain_3_common"
	},
	required_textures = {
		"go_stage17_bg",
		"go_stage17",
		"go_enemies_T3"
	}
}

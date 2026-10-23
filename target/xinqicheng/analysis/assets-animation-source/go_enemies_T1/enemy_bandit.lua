local a = {
	bandit_raise = {
		prefix = "bandit_enemy",
		to = 2,
		from = 2
	},
	bandit_idle = {
		prefix = "bandit_enemy",
		to = 1,
		from = 1
	},
	bandit_walkingRightLeft = {
		prefix = "bandit_enemy",
		to = 21,
		from = 2
	},
	bandit_walkingDown = {
		prefix = "bandit_enemy",
		to = 41,
		from = 22
	},
	bandit_walkingUp = {
		prefix = "bandit_enemy",
		to = 61,
		from = 42
	},
	bandit_attack = {
		prefix = "bandit_enemy",
		to = 82,
		from = 62
	},
	bandit_death = {
		prefix = "bandit_enemy",
		to = 96,
		from = 83
	}
}

return a

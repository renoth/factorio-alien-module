data:extend({
	{
		type = "bool-setting",
		name = "alien-module-ore-conversion",
		order = "a",
		setting_type = "startup",
		default_value = true
	},
	{
		type = "bool-setting",
		name = "alien-module-hyper-ammo-enabled",
		order = "aa",
		setting_type = "startup",
		default_value = true
	},
	{
		type = "double-setting",
		name = "alien-module-level-exponent",
		order = "b",
		minimum_value = 0.08, maximum_value = 0.20,
		setting_type = "startup",
		default_value = 0.10
	},
	{
		type = "double-setting",
		name = "alien-module-hyper-module-effect",
		order = "c",
		minimum_value = 0.001, maximum_value = 0.1,
		setting_type = "startup",
		default_value = 0.01
	},
	{
		type = "int-setting",
		name = "alien-module-drop-amount",
		order = "d",
		minimum_value = 1, maximum_value = 10000,
		setting_type = "startup",
		default_value = 100
	},
	{
		type = "int-setting",
		name = "rampant-alienmodule-compat-max-count-turret",
		setting_type = "startup",
		order = "2count-2-2",
		default_value = 5,
		minimum_value = 0,
		maximum_value = 50
	},
	{
		type = "int-setting",
		name = "rampant-alienmodule-compat-max-count-spawner",
		setting_type = "startup",
		order = "2count-3-2",
		default_value = 10,
		minimum_value = 0,
		maximum_value = 100
	},

})
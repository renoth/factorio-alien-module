data:extend({
	{
		type = "bool-setting",
		name = "alien-module-ore-conversion",
		order = "a",
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

})
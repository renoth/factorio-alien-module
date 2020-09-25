-- alien-ore and products --

data:extend({
	{
		type = "item",
		name = "artifact-ore",
		icons = { { icon = "__alien-module__/graphics/artifact-ore.png"} },
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "component",
		category = "alien-module",
		tier = 0,
		order = "a-1",
		stack_size = 500,
	},
})

data:extend({
	{
		type = "item",
		name = "alien-plate",
		icons = { { icon = "__base__/graphics/icons/iron-plate.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } },
		icon_size = 64,
		subgroup = "component",
		category = "alien-module",
		tier = 2,
		order = "a-2",
		stack_size = 200,
	},
})

data:extend({
	{
		type = "item",
		name = "alien-steel-plate",
		icons = { { icon = "__base__/graphics/icons/steel-plate.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } },
		icon_size = 64,
		subgroup = "component",
		category = "alien-module",
		tier = 2,
		order = "a-3",
		stack_size = 200,
	},
})

data:extend({
	{
		type = "item",
		name = "alien-fuel",
		icons = { { icon = "__base__/graphics/icons/solid-fuel.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } },
		icon_size = 64,
		fuel_category = "chemical",
		fuel_value = "200MJ",
		fuel_acceleration_multiplier = 1.4,
		fuel_top_speed_multiplier = 1.5,
		subgroup = "component",
		category = "alien-module",
		tier = 2,
		order = "a-4",
		stack_size = 500
	},
})

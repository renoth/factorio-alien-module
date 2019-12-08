data:extend({
	{
		type = "module-category",
		name = "alien-module"
	}
})

data:extend({
	{
		type = "item-group",
		name = "alien-module",
		order = "ff",
		inventory_order = "gf",
		icon = "__alien-module__/graphics/item-group/module.png",
		icon_size = 32,
	},
	{
		type = "item-subgroup",
		name = "component",
		group = "alien-module",
		order = "1"
	},
	{
		type = "item-subgroup",
		name = "alien-hyper-module",
		group = "alien-module",
		order = "2"
	},
	{
		type = "item-subgroup",
		name = "alien-module",
		group = "alien-module",
		order = "3"
	},
	{
		type = "item-subgroup",
		name = "warfare",
		group = "alien-module",
		order = "5"
	},
	{
		type = "item-subgroup",
		name = "economy",
		group = "alien-module",
		order = "4"
	}
})


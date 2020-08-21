-- alien modules --

data:extend({
	{
		type = "module",
		name = "alien-module-1",
		icon = "__alien-module__/graphics/alien-module-1.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 1,
		order = "a-1",
		stack_size = 50,
		effect = {
			consumption = { bonus = 0.1 },
			speed = { bonus = 0.05 },
			productivity = { bonus = 0.025 }
		},
	},
})

data:extend({
	{
		type = "module",
		name = "alien-module-2",
		icon = "__alien-module__/graphics/alien-module-2.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 2,
		order = "a-2",
		stack_size = 50,
		effect = {
			consumption = { bonus = 0.25 },
			speed = { bonus = 0.1 },
			productivity = { bonus = 0.05 }
		},
	},
})

data:extend({
	{
		type = "module",
		name = "alien-module-3",
		icon = "__alien-module__/graphics/alien-module-3.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 3,
		order = "a-3",
		stack_size = 50,
		effect = {
			consumption = { bonus = 0.4 },
			speed = { bonus = 0.15 },
			productivity = { bonus = 0.075 }
		},
	},
})

data:extend({
	{
		type = "module",
		name = "alien-module-4",
		icon = "__alien-module__/graphics/alien-module-4.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 4,
		order = "a-4",
		stack_size = 50,
		effect = {
			consumption = { bonus = 0.55 },
			speed = { bonus = 0.2 },
			productivity = { bonus = 0.1 }
		},
	},
})

data:extend({
	{
		type = "module",
		name = "alien-module-5",
		icon = "__alien-module__/graphics/alien-module-5.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 5,
		order = "a-5",
		stack_size = 50,
		effect = {
			consumption = { bonus = 0.75 },
			speed = { bonus = 0.25 },
			productivity = { bonus = 0.15 }
		},
	},
})

for i = 1, 100, 1 do
	local levelbonus = i * (settings.startup["alien-module-hyper-module-effect"].value + 0.00001)

	data:extend({
		{
			type = "module",
			name = "alien-hyper-module-" .. i,
			icons = {
				{
					icon = "__base__/graphics/icons/speed-module-3.png",
					tint = {
						r = 0.5 + 0.5 * i * 0.01,
						g = 0.55,
						b = 0.8,
						a = 1
					}
				}
			},
			icon_size = 64,
			subgroup = "alien-hyper-module",
			category = "alien-module",
			tier = i,
			order = "a-" .. i,
			stack_size = 50,
			effect = {
				consumption = { bonus = levelbonus * 2 },
				speed = { bonus = levelbonus },
				productivity = { bonus = levelbonus },
				pollution = { bonus = levelbonus * 2 }
			},
		},
	})
end





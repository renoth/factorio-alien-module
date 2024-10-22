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
			consumption = 0.1,
			speed = 0.05,
			productivity = 0.025
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
				consumption = levelbonus * 2,
				speed = levelbonus,
				productivity = levelbonus,
				pollution = levelbonus * 2,
				quality = levelbonus * 0.1
			},
		},
	})
end





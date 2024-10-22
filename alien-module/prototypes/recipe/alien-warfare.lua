-- alien-magazine --
data:extend({
	{
		type = "recipe",
		name = "alien-magazine",
		enabled = false,
		energy_required = 10,
		results = { { type = "item", name = "alien-magazine", amount = 1 } },
		ingredients = {
			{ type = "item", name = "alien-plate", amount = 1 }, { type = "item", name = "iron-plate", amount = 2 }, { type = "item", name = "copper-plate", amount = 2 }
		},
	},
})

data:extend({
	{
		type = "recipe",
		name = "alien-ore-magazine",
		enabled = false,
		energy_required = 2,
		results = { { type = "item", name = "alien-ore-magazine", amount = 1 } },
		ingredients = {
			{ type = "item", name = "artifact-ore", amount = 1 }
		},
	},
})

if (settings.startup["alien-module-hyper-ammo-enabled"].value) then
	for i = 1, 100, 1 do
		data:extend({
			{
				type = "recipe",
				name = "alien-hyper-magazine-" .. i,
				enabled = false,
				energy_required = i,
				results = { { type = "item", name = "alien-hyper-magazine-" .. i, amount = 1 } },
				ingredients = {
					{ type = "item", name = "alien-plate", amount = 2 }, { type = "item", name = "iron-plate", amount = 2 }, { type = "item", name = "copper-plate", amount = 2 }
				},
			},
		})
	end
end
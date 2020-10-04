-- alien-magazine --
data:extend({
	{
		type = "recipe",
		name = "alien-magazine",
		enabled = false,
		energy_required = 10,
		result = "alien-magazine",
		result_count = 1,
		ingredients = {
			{ "alien-plate", 1 }, { "iron-plate", 2 }, { "copper-plate", 2 },
		},
	},
})

data:extend({
	{
		type = "recipe",
		name = "alien-ore-magazine",
		enabled = false,
		energy_required = 2,
		result = "alien-ore-magazine",
		result_count = 1,
		ingredients = {
			{ "artifact-ore", 1 },
		},
	},
})

data:extend({
	{
		type = "recipe",
		name = "alien-gun-turret",
		enabled = false,
		energy_required = 10,
		result = "alien-gun-turret",
		result_count = 1,
		ingredients = {
			{ "alien-plate", 15 }, { "iron-plate", 15 }, { "copper-plate", 10 }, { "electronic-circuit", 10 }
		}
	}
})

if (settings.startup["alien-module-hyper-ammo-enabled"].value) then
	for i = 1, 100, 1 do
		data:extend({
			{
				type = "recipe",
				name = "alien-hyper-magazine-" .. i,
				enabled = false,
				energy_required = i,
				result = "alien-hyper-magazine-" .. i,
				result_count = 1,
				ingredients = {
					{ "alien-plate", 2 }, { "iron-plate", 2 }, { "copper-plate", 1 },
				},
			},
		})
	end
end
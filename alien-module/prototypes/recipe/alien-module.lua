-- make alien plate from alien ore --
data:extend({
	{
		type = "recipe",
		name = "alien-plate",
		category = "smelting",
		enabled = false,
		energy_required = 10,
		ingredients = { { type = "item", name = "artifact-ore", amount = 1 } },
		results = { { type = "item", name = "alien-plate", amount = 1 } }
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-steel-plate",
		category = "smelting",
		enabled = false,
		energy_required = 25,
		ingredients = { { type = "item", name = "alien-plate", amount = 5 } },
		results = { { type = "item", name = "alien-steel-plate", amount = 1 } }
	}
})

if (settings.startup["alien-module-ore-conversion"].value) then
	-- make iron ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-iron-ore",
			enabled = true,
			energy_required = 10,
			ingredients = { { type = "item", name = "artifact-ore", amount = 1 } },
			results = { { type = "item", name = "iron-ore", amount = 5 } }
		}
	})

	-- make copper ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-copper-ore",
			enabled = true,
			energy_required = 10,
			ingredients = { { type = "item", name = "artifact-ore", amount = 1 } },
			results = { { type = "item", name = "copper-ore", amount = 5 } }
		}
	})

	-- make stone ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-stone",
			enabled = true,
			energy_required = 10,
			ingredients = { { type = "item", name = "artifact-ore", amount = 1 } },
			results = { { type = "item", name = "stone", amount = 5 } }
		}
	})

	-- make uranium ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-uranium-ore",
			enabled = true,
			energy_required = 20,
			ingredients = { { type = "item", name = "artifact-ore", amount = 2 } },
			results = { { type = "item", name = "uranium-ore", amount = 1 } }
		}
	})

	-- make coal from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-coal",
			enabled = true,
			energy_required = 10,
			ingredients = { { type = "item", name = "artifact-ore", amount = 1 } },
			results = { { type = "item", name = "coal", amount = 5 } }
		}
	})
end

-- if bobs enemies is enabled, make conversion of alien artifacts possible
if data.raw["item"]["alien-artifact"] ~= nil then
	data:extend({
		{
			type = "recipe",
			name = "alien-artifact-to-ore",
			enabled = true,
			energy_required = 25,
			ingredients = { { type = "item", name = "alien-artifact", amount = 1 }, { type = "item", name = "stone", amount = 5 }, { type = "item", name = "iron-ore", amount = 5 } },
			results = { { type = "item", name = "artifact-ore", amount = 5 } }
		}
	})
end

data:extend({
	{
		type = "recipe",
		name = "alien-accumulator",
		energy_required = 10,
		enabled = false,
		ingredients = {
			{ type = "item", name = "alien-plate", amount = 5 },
			{ type = "item", name = "battery", amount = 10 }
		},
		results = { { type = "item", name = "alien-accumulator", amount = 1 } }
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-solarpanel",
		enabled = false,
		energy_required = 8,
		ingredients = { { type = "item", name = "alien-plate", amount = 10 }, { type = "item", name = "electronic-circuit", amount = 10 }, { type = "item", name = "steel-plate", amount = 5 } },
		results = { { type = "item", name = "alien-solarpanel", amount = 1 } }
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-mining-drill",
		enabled = true,
		energy_required = 8,
		ingredients = { { type = "item", name = "alien-plate", amount = 50 }, { type = "item", name = "electronic-circuit", amount = 10 }, { type = "item", name = "iron-gear-wheel", amount = 10 } },
		results = { { type = "item", name = "alien-mining-drill", amount = 1 } }
	}
})

-- alien-module-1 from alien-plate --
data:extend({
	{
		type = "recipe",
		name = "alien-module-1",
		enabled = false,
		energy_required = 20,
		results = { { type = "item", name = "alien-module-1", amount = 1 } },
		ingredients = {
			{ type = "item", name = "alien-plate", amount = 50 }
		}
	},
})

-- alien-fuel --

data:extend({
	{
		type = "recipe",
		name = "alien-fuel",
		enabled = false,
		energy_required = 5,
		results = { { type = "item", name = "alien-fuel", amount = 1 } },
		ingredients = {
			{ type = "item", name = "artifact-ore", amount = 2 },
			{ type = "item", name = "coal", amount = 10 }
		},
	},
})

for i = 1, 100, 1 do
	data:extend({
		{
			type = "recipe",
			name = "alien-hyper-module-" .. i,
			enabled = false,
			hidden_in_factoriopedia = true,
			energy_required = i,
			results = { { type = "item", name = "alien-hyper-module-" .. i, amount = 1 } },
			ingredients = {
				{ type = "item", name = "alien-plate", amount = 20 * i }
			},
		},
	})
end

-- make alien plate from alien ore --
data:extend({
	{
		type = "recipe",
		name = "alien-plate",
		category = "smelting",
		enabled = false,
		energy_required = 10,
		ingredients = { { "artifact-ore", 1 } },
		result = "alien-plate"
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-steel-plate",
		category = "smelting",
		enabled = false,
		energy_required = 25,
		ingredients = { { "alien-plate", 5 } },
		result = "alien-steel-plate"
	}
})

if(settings.startup["alien-module-ore-conversion"].value) then
	-- make iron ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-iron-ore",
			enabled = true,
			energy_required = 10,
			ingredients = { { "artifact-ore", 1 } },
			result = "iron-ore",
			result_count = 5
		}
	})

	-- make copper ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-copper-ore",
			enabled = true,
			energy_required = 10,
			ingredients = { { "artifact-ore", 1 } },
			result = "copper-ore",
			result_count = 5
		}
	})

	-- make stone ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-stone",
			enabled = true,
			energy_required = 10,
			ingredients = { { "artifact-ore", 1 } },
			result = "stone",
			result_count = 5
		}
	})

	-- make uranium ore from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-uranium-ore",
			enabled = true,
			energy_required = 20,
			ingredients = { { "artifact-ore", 2 } },
			result = "uranium-ore",
			result_count = 1
		}
	})

	-- make coal from alien ore --
	data:extend({
		{
			type = "recipe",
			name = "alien-ore-to-coal",
			enabled = true,
			energy_required = 10,
			ingredients = { { "artifact-ore", 1 } },
			result = "coal",
			result_count = 5
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
			result_count = 5,
			ingredients = { { "alien-artifact", 1 }, { "stone", 5 }, { "iron-ore", 5 } },
			result = "artifact-ore"
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
			{ "alien-plate", 5 },
			{ "battery", 10 }
		},
		result = "alien-accumulator"
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-solarpanel",
		enabled = false,
		energy_required = 8,
		result_count = 1,
		ingredients = { { "alien-plate", 10 }, { "electronic-circuit", 10 }, { "steel-plate", 5 } },
		result = "alien-solarpanel"
	}
})

data:extend({
	{
		type = "recipe",
		name = "alien-mining-drill",
		enabled = true,
		energy_required = 8,
		result_count = 1,
		ingredients = { { "alien-plate", 50 }, { "electronic-circuit", 10 }, { "iron-gear-wheel", 10 } },
		result = "alien-mining-drill"
	}
})

-- alien-module-1 from alien-plate --
data:extend({
	{
		type = "recipe",
		name = "alien-module-1",
		enabled = false,
		energy_required = 20,
		result = "alien-module-1",
		result_count = 1,
		ingredients = {
			{ "alien-plate", 50 }
		},
	},
})

-- alien-module-2 --
data:extend({
	{
		type = "recipe",
		name = "alien-module-2",
		enabled = false,
		energy_required = 40,
		result = "alien-module-2",
		result_count = 1,
		ingredients = {
			{ "alien-module-1", 3 },
			{ "electronic-circuit", 20 }
		},
	},
})

-- alien-module-3 --
data:extend({
	{
		type = "recipe",
		name = "alien-module-3",
		enabled = false,
		energy_required = 60,
		result = "alien-module-3",
		result_count = 1,
		ingredients = {
			{ "alien-module-2", 3 },
			{ "advanced-circuit", 20 }
		},
	},
})

-- alien-module-4 --
data:extend({
	{
		type = "recipe",
		name = "alien-module-4",
		enabled = false,
		energy_required = 80,
		result = "alien-module-4",
		result_count = 1,
		ingredients = {
			{ "alien-module-3", 3 },
			{ "processing-unit", 10 }
		},
	},
})

-- alien-module-5 --
data:extend({
	{
		type = "recipe",
		name = "alien-module-5",
		enabled = false,
		energy_required = 100,
		result = "alien-module-5",
		result_count = 1,
		ingredients = {
			{ "alien-module-4", 3 },
			{ "processing-unit", 20 }
		},
	},
})

-- alien-fuel --

data:extend({
	{
		type = "recipe",
		name = "alien-fuel",
		enabled = false,
		energy_required = 5,
		result = "alien-fuel",
		result_count = 1,
		ingredients = {
			{ "artifact-ore", 2 },
			{ "coal", 10 }
		},
	},
})

data:extend({
  {
    type = "recipe",
    name = "alien-steam-engine",
	enabled = true,
    normal =
    {
      ingredients =
      {
        {"iron-gear-wheel", 8},
        {"pipe", 5},
        {"alien-steel-plate", 10}
      },
      result = "alien-steam-engine"
    },
    expensive =
    {
      ingredients =
      {
        {"iron-gear-wheel", 15},
        {"pipe", 8},
        {"alien-steel-plate", 25}
      },
      result = "alien-steam-engine"
    }
  },
})

data:extend({
  {
    type = "recipe",
    name = "alien-wall",
	enabled = true,
    normal =
    {
      ingredients =
      {
        {"stone", 8},
        {"alien-plate", 2},
      },
      result = "alien-wall"
    },
    expensive =
    {
      ingredients =
      {
        {"stone", 15},
        {"alien-plate", 4},
      },
      result = "alien-wall"
    }
  },
})

for i = 1, 100, 1 do
	data:extend({
		{
			type = "recipe",
			name = "alien-hyper-module-" .. i,
			enabled = false,
			energy_required = i,
			result = "alien-hyper-module-" .. i,
			result_count = 1,
			ingredients = {
				{ "alien-plate", 20 * i }
			},
		},
	})
end

-- make alien plate from alien ore --

data:extend(
{
  {
    type = "recipe",
    name = "alien-plate",
    category = "smelting",
    enabled = false,
    energy_required = 10,
    ingredients = {{"artifact-ore", 1}},
    result = "alien-plate"
  }
}
)

data:extend(
{
  {
    type = "recipe",
    name = "alien-artifact-to-plate",
    category = "smelting",
    enabled = false,
    energy_required = 10,
	result_count = 5,	
    ingredients = {{"alien-artifact", 1}},
    result = "alien-plate"
  }
}
)

data:extend(
{
  {
    type = "recipe",
    name = "alien-solarpanel",
    category = "smelting",
    enabled = false,
    energy_required = 8,
	result_count = 1,	
    ingredients = {{"alien-plate", 5}, {"electronic-circuit", 3}, {"steel-plate", 5}},
    result = "alien-solarpanel"
  }
}
)

-- alien-module-1 from alien-plate --
data:extend(
{
  {
    type = "recipe",
    name = "alien-module-1",
    enabled = false,
    energy_required = 20,	
    result = "alien-module-1",
    result_count = 1,	
    ingredients =
    {
      {"alien-plate", 10}
    },
  },
}
)

-- alien-module-2 --
data:extend(
{
  {
    type = "recipe",
    name = "alien-module-2",
    enabled = false,
    energy_required = 40,
    result = "alien-module-2",
    result_count = 1,	
    ingredients =
    {
      {"alien-module-1", 3},
	  {"electronic-circuit", 3}
    },
  },
}
)

-- alien-module-3 --
data:extend(
{
   {
    type = "recipe",
    name = "alien-module-3",
    enabled = false,
    energy_required = 60,
    result = "alien-module-3",
    result_count = 1,
    ingredients =
    {
      {"alien-module-2", 3},
      {"advanced-circuit", 3}
    },
  },
}
)

-- alien-module-4 --
data:extend(
{
   {
    type = "recipe",
    name = "alien-module-4",
    enabled = false,
    energy_required = 80,
    result = "alien-module-4",
    result_count = 1,
    ingredients =
    {
      {"alien-module-3", 3},
      {"processing-unit", 3}
    },
  },
}
)
-- alien-module-3 --
data:extend(
{
   {
    type = "recipe",
    name = "alien-module-5",
    enabled = false,
    energy_required = 100,
    result = "alien-module-5",
    result_count = 1,
    ingredients =
    {
      {"alien-module-4", 3},
      {"processing-unit", 12}
    },
  },
}
)

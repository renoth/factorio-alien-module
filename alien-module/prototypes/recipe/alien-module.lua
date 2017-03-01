-- make alien plate from alien ore --

data:extend(
{
  {
    type = "recipe",
    name = "alien-plate",
    category = "smelting",
    enabled = true,
    energy_required = 10,
    ingredients = {{"alien-ore", 1}},
    result = "alien-plate"
  }
}
)

-- alien-module-1 from alien-plate --
data:extend(
{
  {
    type = "recipe",
    name = "alien-module-1",
    enabled = true,
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
    enabled = true,
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
    enabled = true,
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
    enabled = true,
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
    enabled = true,
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

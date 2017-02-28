
-- alien-module-1 from alien-module-component --
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
      {"alien-module-component", 10}
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
	  {"electronic-circuit", 1}
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
      {"advanced-circuit", 1}
    },
  },
}
)

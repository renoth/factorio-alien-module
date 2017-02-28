-- alien-module-component --

data:extend(
{
  {
    type = "item",
    name = "alien-module-component",
    icon = "__alien-module__/graphics/alien-module-component.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "component",
    category = "alien-module",
    tier = 1,
    order = "a-1",
    stack_size = 250,
  },
}
)

data:extend(
{
  {
    type = "module",
    name = "alien-module-1",
    icon = "__alien-module__/graphics/alien-module-1.png",
	flags = {"goes-to-main-inventory"},
    subgroup = "module",
    category = "alien-module",
    tier = 1,
    order = "a-1",
    stack_size = 50,
	effect = 
	{
	  consumption = {bonus = -0.025},
	  speed = {bonus = 0.1},
	  productivity = {bonus = 0.1},
	  pollution = {bonus = 0.1}
	},
  },
}
)

data:extend(
{
  {
    type = "module",
    name = "alien-module-2",
    icon = "__alien-module__/graphics/alien-module-2.png",
	flags = {"goes-to-main-inventory"},
    subgroup = "module",
    category = "alien-module",
    tier = 2,
    order = "a-2",
    stack_size = 50,
	effect = 
	{
	  consumption = {bonus = -0.05},
	  speed = {bonus = 0.2},
	  productivity = {bonus = 0.2},
	  pollution = {bonus = 0.25}
	},
  },
}
)

data:extend(
{
  {
    type = "module",
    name = "alien-module-3",
    icon = "__alien-module__/graphics/alien-module-3.png",
	flags = {"goes-to-main-inventory"},
    subgroup = "module",
    category = "alien-module",
    tier = 3,
    order = "a-3",
    stack_size = 50,
	effect = 
	{
	  consumption = {bonus = -0.075},
	  speed = {bonus = 0.3},
	  productivity = {bonus = 0.3},
	  pollution = {bonus = 0.5}
	},
  },
}
)






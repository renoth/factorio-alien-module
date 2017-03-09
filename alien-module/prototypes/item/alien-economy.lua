-- alien economy --

data:extend(
{
  {
    type = "item",
    name = "alien-solarpanel",
    icon = "__alien-module__/graphics/alien-solarpanel.png",
    flags = {"goes-to-quickbar"},
    subgroup = "economy",
    category = "alien-economy",
	place_result = "alien-solarpanel",
    order = "a",
    stack_size = 50
  },
    {
    type = "item",
    name = "alien-accumulator",
    icon = "__alien-module__/graphics/alien-accumulator.png",
    flags = {"goes-to-quickbar"},
    subgroup = "economy",
    category = "alien-economy",
	place_result = "alien-accumulator",
    order = "b",
    stack_size = 50
  },
  {
    type = "item",
    name = "alien-mining-drill",
    icon = "__alien-module__/graphics/alien-mining-drill.png",
    flags = {"goes-to-quickbar"},
    subgroup = "economy",
    category = "alien-economy",
	place_result = "alien-mining-drill",
    order = "c",
    stack_size = 50
  }
}
)



data:extend(
{
  {
    type = "solar-panel",
    name = "alien-solarpanel",
    icon = "__alien-module__/graphics/alien-solarpanel.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "alien-solarpanel"},
    max_health = 150,
    corpse = "big-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source =
    {
      type = "electric",
      usage_priority = "solar"
    },
    picture =
    {
      filename = "__alien-module__/graphics/entity/alien-solarpanel.png",
      priority = "high",
      width = 104,
      height = 96
    },
    production = "150kW"
  }
}
)

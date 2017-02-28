data:extend(
{
  {
    type = "module-category",
    name = "alien-module"
  }
}
)

data:extend({
  {
    type = "item-group",
    name = "alien-module",
    order = "ff",
    inventory_order = "gf",
    icon = "__alien-module__/graphics/item-group/module.png",
  },
  {
    type = "item-subgroup",
    name = "component",
    group = "alien-module",
    order = "1"
  }
  ,
  {
    type = "item-subgroup",
    name = "module",
    group = "alien-module",
    order = "2"
  }
}
)


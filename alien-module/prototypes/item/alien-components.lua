-- alien-ore and products --

data:extend({
    {
        type = "item",
        name = "artifact-ore",
        icon = "__alien-module__/graphics/artifact-ore.png",
        icon_size = 32,
        subgroup = "component",
        category = "alien-module",
        tier = 0,
        order = "a-1",
        stack_size = 200,
    },
})

data:extend({
    {
        type = "item",
        name = "alien-plate",
        icon = "__alien-module__/graphics/alien-plate.png",
        icon_size = 32,
        subgroup = "component",
        category = "alien-module",
        tier = 2,
        order = "a-2",
        stack_size = 200,
    },
})

data:extend({
    {
        type = "item",
        name = "alien-fuel",
        icon = "__alien-module__/graphics/alien-fuel.png",
        icon_size = 32,
        fuel_category = "chemical",
        fuel_value = "200MJ",
        fuel_acceleration_multiplier = 1.4,
        fuel_top_speed_multiplier = 1.5,
        subgroup = "component",
        category = "alien-module",
        tier = 2,
        order = "a-3",
        stack_size = 200
    },
})

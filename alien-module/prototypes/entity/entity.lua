data:extend({
    {
        type = "solar-panel",
        name = "alien-solarpanel",
        icon = "__alien-module__/graphics/alien-solarpanel.png",
        icon_size = 32,
        flags = { "placeable-neutral", "player-creation" },
        minable = { hardness = 0.2, mining_time = 0.5, result = "alien-solarpanel" },
        max_health = 150,
        corpse = "big-remnants",
        collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
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
    },
    {
        type = "mining-drill",
        name = "alien-mining-drill",
        icon = "__alien-module__/graphics/alien-mining-drill.png",
        icon_size = 32,
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 1, result = "alien-mining-drill" },
        max_health = 500,
        resource_categories = { "basic-solid" },
        corpse = "big-remnants",
        collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        working_sound =
        {
            sound =
            {
                filename = "__base__/sound/electric-mining-drill.ogg",
                volume = 0.75
            },
            apparent_volume = 1.5,
        },
        animations =
        {
            north =
            {
                priority = "extra-high",
                width = 110,
                height = 114,
                line_length = 8,
                shift = { 0.2, -0.2 },
                filename = "__alien-module__/graphics/entity/north.png",
                frame_count = 64,
                animation_speed = .5,
                run_mode = "forward-then-backward",
            },
            east =
            {
                priority = "extra-high",
                width = 129,
                height = 100,
                line_length = 8,
                shift = { 0.45, 0 },
                filename = "__alien-module__/graphics/entity/east.png",
                frame_count = 64,
                animation_speed = .5,
                run_mode = "forward-then-backward",
            },
            south =
            {
                priority = "extra-high",
                width = 109,
                height = 111,
                line_length = 8,
                shift = { 0.15, 0 },
                filename = "__alien-module__/graphics/entity/south.png",
                frame_count = 64,
                animation_speed = .5,
                run_mode = "forward-then-backward",
            },
            west =
            {
                priority = "extra-high",
                width = 128,
                height = 100,
                line_length = 8,
                shift = { 0.25, 0 },
                filename = "__alien-module__/graphics/entity/west.png",
                frame_count = 64,
                animation_speed = .5,
                run_mode = "forward-then-backward",
            }
        },
        mining_speed = 1,
        energy_source =
        {
            type = "electric",
            -- will produce this much * energy pollution units per tick
            emissions = 0.2 / 1.5,
            usage_priority = "secondary-input"
        },
        energy_usage = "200kW",
        mining_power = 3.0,
        resource_searching_radius = 3.49,
        vector_to_place_result = { 0, -1.85 },
        module_specification =
        {
            module_slots = 4
        },
        radius_visualisation_picture =
        {
            filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
            width = 12,
            height = 12
        },
        fast_replaceable_group = "mining-drill"
    }
})

-- #### ALIEN ACCUMULATOR  #### --

data:extend({
    {
        type = "accumulator",
        name = "alien-accumulator",
        icon = "__alien-module__/graphics/alien-accumulator.png",
        icon_size = 32,
        flags = { "placeable-neutral", "player-creation" },
        minable = { hardness = 0.2, mining_time = 0.5, result = "alien-accumulator" },
        max_health = 250,
        corpse = "medium-remnants",
        collision_box = { { -0.9, -0.9 }, { 0.9, 0.9 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        energy_source =
        {
            type = "electric",
            buffer_capacity = "15MJ",
            usage_priority = "terciary",
            input_flow_limit = "1MW",
            output_flow_limit = "1MW"
        },
        picture =
        {
            filename = "__alien-module__/graphics/entity/alien-accumulator.png",
            priority = "extra-high",
            width = 124,
            height = 103,
            shift = { 0.7, -0.2 }
        },
        charge_animation =
        {
            filename = "__alien-module__/graphics/entity/alien-accumulator-charge-animation.png",
            width = 138,
            height = 135,
            line_length = 8,
            frame_count = 24,
            shift = { 0.482, -0.638 },
            animation_speed = 0.5
        },
        charge_cooldown = 30,
        charge_light = { intensity = 0.3, size = 7 },
        discharge_animation =
        {
            filename = "__alien-module__/graphics/entity/alien-accumulator-discharge-animation.png",
            width = 147,
            height = 128,
            line_length = 8,
            frame_count = 24,
            shift = { 0.395, -0.525 },
            animation_speed = 0.5
        },
        discharge_cooldown = 60,
        discharge_light = { intensity = 0.7, size = 7 },
        vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        working_sound =
        {
            sound =
            {
                filename = "__base__/sound/accumulator-working.ogg",
                volume = 1
            },
            idle_sound = {
                filename = "__base__/sound/accumulator-idle.ogg",
                volume = 0.4
            },
            max_sounds_per_type = 5
        },
        circuit_wire_connection_point =
        {
            shadow =
            {
                red = { 0.984375, 1.10938 },
                green = { 0.890625, 1.10938 }
            },
            wire =
            {
                red = { 0.6875, 0.59375 },
                green = { 0.6875, 0.71875 }
            }
        },
        circuit_wire_max_distance = 7.5
    }
})


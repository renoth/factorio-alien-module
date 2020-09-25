local alien_tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 }

-- ### SOLAR PANEL ### --

local alien_solarpanel = util.table.deepcopy(data.raw["solar-panel"]["solar-panel"])

alien_solarpanel.name = "alien-solarpanel"
alien_solarpanel.icons = { { icon = "__base__/graphics/icons/solar-panel.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_solarpanel.minable.result = "alien-solarpanel"
alien_solarpanel.fast_replaceable_group = "solar-panel"
alien_solarpanel.production = "150kW"
alien_solarpanel.picture.layers[1].hr_version.tint = alien_tint
alien_solarpanel.picture.layers[1].tint = alien_tint
alien_solarpanel.picture.layers[2].hr_version.tint = alien_tint
alien_solarpanel.picture.layers[2].tint = alien_tint

data:extend({ alien_solarpanel })

-- ### MINING DRILL ### --

local alien_drill = util.table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])

alien_drill.name = "alien-mining-drill"
alien_drill.icons = { { icon = "__base__/graphics/icons/electric-mining-drill.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_drill.minable.result = "alien-mining-drill"
alien_drill.fast_replaceable_group = "mining-drill"
alien_drill.mining_speed = 1.5
alien_drill.energy_usage = "200kW"
alien_drill.resource_searching_radius = 3.49
alien_drill.module_specification.module_slots = 4
alien_drill.graphics_set.animation.north.layers[1].tint = alien_tint
alien_drill.graphics_set.animation.north.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.animation.east.layers[1].tint = alien_tint
alien_drill.graphics_set.animation.east.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.animation.south.layers[1].tint = alien_tint
alien_drill.graphics_set.animation.south.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.animation.west.layers[1].tint = alien_tint
alien_drill.graphics_set.animation.west.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].north_animation.layers[1].tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].north_animation.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].east_animation.layers[1].tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].east_animation.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].south_animation.layers[1].tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].south_animation.layers[1].hr_version.tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].west_animation.layers[1].tint = alien_tint
alien_drill.graphics_set.working_visualisations[3].west_animation.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.north.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.north.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.east.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.east.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.south.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.south.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.west.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.animation.west.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].north_animation.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].north_animation.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].east_animation.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].east_animation.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].south_animation.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].south_animation.layers[1].hr_version.tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].west_animation.layers[1].tint = alien_tint
alien_drill.wet_mining_graphics_set.working_visualisations[3].west_animation.layers[1].hr_version.tint = alien_tint

data:extend({ alien_drill })

if not data.raw["solar-panel"]["solar-panel"].fast_replaceable_group then
	data.raw["solar-panel"]["solar-panel"].fast_replaceable_group = "solar-panel"
else
	local group_name = data.raw["solar-panel"]["solar-panel"].fast_replaceable_group
	data.raw["solar-panel"]["alien-solarpanel"].fast_replaceable_group = group_name
end

if data.raw["solar-panel"]["solar-panel"].next_upgrade == nil then
	data.raw["solar-panel"]["solar-panel"].next_upgrade = "alien-solarpanel"
end

-- #### ALIEN ACCUMULATOR  #### --

local alien_accumulator = util.table.deepcopy(data.raw["accumulator"]["accumulator"])

alien_accumulator.name = "alien-accumulator"
alien_accumulator.icons = { { icon = "__base__/graphics/icons/accumulator.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_accumulator.minable.result = "alien-accumulator"
alien_accumulator.fast_replaceable_group = "accumulator"
alien_accumulator.energy_source.buffer_capacity = "15MJ"
alien_accumulator.energy_source.input_flow_limit = "1MW"
alien_accumulator.energy_source.output_flow_limit = "1MW"
alien_accumulator.picture.layers[1].tint = alien_tint
alien_accumulator.picture.layers[1].hr_version.tint = alien_tint
alien_accumulator.charge_animation.layers[1].layers[1].tint = alien_tint
alien_accumulator.charge_animation.layers[1].layers[1].hr_version.tint = alien_tint
alien_accumulator.discharge_animation.layers[1].layers[1].tint = alien_tint
alien_accumulator.discharge_animation.layers[1].layers[1].hr_version.tint = alien_tint

data:extend({ alien_accumulator })

if not data.raw["accumulator"]["accumulator"].fast_replaceable_group then
	data.raw["accumulator"]["accumulator"].fast_replaceable_group = "accumulator"
else
	local group_name = data.raw["accumulator"]["accumulator"].fast_replaceable_group
	data.raw["accumulator"]["alien-accumulator"].fast_replaceable_group = group_name
end

if data.raw["accumulator"]["accumulator"].next_upgrade == nil then
	data.raw["accumulator"]["accumulator"].next_upgrade = "alien-accumulator"
end

-- ### STEAM ENGINE ### --

local alien_engine = util.table.deepcopy(data.raw["generator"]["steam-engine"])

alien_engine.name = "alien-steam-engine"

alien_engine.icons = { { icon = "__base__/graphics/icons/steam-engine.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_engine.minable.result = "alien-steam-engine"
alien_engine.effectivity = 2
alien_engine.max_health = 600
alien_engine.horizontal_animation.layers[1].tint = alien_tint
alien_engine.horizontal_animation.layers[1].hr_version.tint = alien_tint
alien_engine.vertical_animation.layers[1].tint = alien_tint
alien_engine.vertical_animation.layers[1].hr_version.tint = alien_tint
alien_engine.fluid_usage_per_tick = 0.333,

data:extend({ alien_engine })

if data.raw["generator"]["steam-engine"].next_upgrade == nil then
	data.raw["generator"]["steam-engine"].next_upgrade = "alien-steam-engine"
end

-- ### ALIEN WALL ### --

local alien_wall = util.table.deepcopy(data.raw["wall"]["stone-wall"])

alien_wall.name = "alien-wall"

alien_wall.icons = { { icon = "__base__/graphics/icons/wall.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_wall.minable.result = "alien-wall"
alien_wall.effectivity = 2
alien_wall.max_health = 800
alien_wall.minable = {mining_time = 0.1, result = "alien-wall"}
alien_wall.resistances = { 
      {type = "physical", decrease = 1, percent = 70}, 
	  {type = "impact",   decrease = 25,percent = 90},
      {type = "explosion",decrease = 1,percent =  70},
      {type = "fire",     percent = 100},
      {type = "acid",     percent = 100 },
      {type = "laser",    percent = 70 }
    }
alien_wall.stack_size = 500
alien_wall.visual_merge_group = 1
alien_wall.pictures.single.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.straight_vertical.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.straight_horizontal.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.corner_right_down.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.corner_left_down.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.t_up.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.ending_right.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.ending_left.layers[1].hr_version.tint = alien_tint
alien_wall.pictures.filling.hr_version.tint = alien_tint
alien_wall.pictures.water_connection_patch.sheets[1].hr_version.tint = alien_tint
alien_wall.pictures.gate_connection_patch.sheets[1].hr_version.tint = alien_tint
data:extend({ alien_wall })

-- ### Gun Turret ### --

local alien_gun_turret = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

alien_gun_turret.name = "alien-gun-turret"
alien_gun_turret.icons = { { icon = "__base__/graphics/icons/gun-turret.png", tint = { r = 0.8, g = 0.4, b = 0.8, a = 0.8 } } }
alien_gun_turret.minable.result = "alien-gun-turret"
alien_gun_turret.max_health = 650
alien_gun_turret.base_picture.layers[1].tint = alien_tint
alien_gun_turret.base_picture.layers[1].hr_version.tint = alien_tint
alien_gun_turret.base_picture.layers[2].tint = alien_tint
alien_gun_turret.base_picture.layers[2].hr_version.tint = alien_tint
alien_gun_turret.attack_parameters.range = 30

data:extend({ alien_gun_turret })
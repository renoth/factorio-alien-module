-- alien modules --

data:extend({
	{
		type = "module",
		name = "alien-module-1",
		icon = "__alien-module__/graphics/alien-module-1.png",
		icon_size = 32,
		subgroup = "alien-module",
		category = "alien-module",
		tier = 1,
		order = "a-1",
		stack_size = 50,
		weight = 10000,
		effect = {
			consumption = 0.1,
			speed = 0.05,
			productivity = 0.025
		},
	},
})

local qualityenabled = settings.startup["alien-module-hyper-quality-enabled"].value
local quality_base_bonus = 0

if qualityenabled == true then
	quality_base_bonus = 1
end

log("Quality Base bonus is " .. quality_base_bonus)

for i = 1, 100, 1 do
	local levelbonus = i * (settings.startup["alien-module-hyper-module-effect"].value + 0.00001)

	data:extend({
		{
			type = "module",
			name = "alien-hyper-module-" .. i,
			icons = {
				{
					icon = "__base__/graphics/icons/speed-module-3.png",
					tint = {
						r = 0.5 + 0.5 * i * 0.01,
						g = 0.55,
						b = 0.8,
						a = 1
					}
				}
			},
			icon_size = 64,
			subgroup = "alien-hyper-module",
			category = "alien-module",
			tier = i,
			order = "a-" .. i,
			stack_size = 50,
			weight = 20000,
			effect = {
				consumption = levelbonus * 2,
				speed = levelbonus,
				productivity = levelbonus,
				pollution = levelbonus * 2
			},
		},
	})
	-- adds the quality effect only if quality is enabled, this prevents quality from being a required dependency
	if mods["quality"] and qualityenabled == true then
		data.raw["module"]["alien-hyper-module-" .. i].effect = {
			consumption = levelbonus * 2,
			speed = levelbonus,
			productivity = levelbonus,
			pollution = levelbonus * 2,
			quality = levelbonus * quality_base_bonus
		}
	end
end





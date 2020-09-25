table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-plate"
		})

table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-magazine"
		})

table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-wall"
		})

if settings.startup["alien-module-hyper-ammo-enabled"].value then
	table.insert(data.raw["technology"]["military"].effects,
			{
				type = "unlock-recipe",
				recipe = "alien-hyper-magazine-1"
			})
end

table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-ore-magazine"
		})

table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-fuel"
		})

table.insert(data.raw["technology"]["military"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-gun-turret"
		})


if data.raw["item"]["alien-artifact"] then
	table.insert(data.raw["technology"]["automation"].effects,
			{
				type = "unlock-recipe",
				recipe = "alien-artifact-to-ore"
			})
end

table.insert(data.raw["technology"]["advanced-material-processing"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-steel-plate"
		})

table.insert(data.raw["technology"]["automation-2"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-steam-engine"
		})

table.insert(data.raw["technology"]["automation"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-module-1"
		})

table.insert(data.raw["technology"]["automation"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-hyper-module-1"
		})

table.insert(data.raw["technology"]["automation"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-module-2"
		})

table.insert(data.raw["technology"]["automation"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-mining-drill"
		})

table.insert(data.raw["technology"]["advanced-electronics"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-module-3"
		})

table.insert(data.raw["technology"]["advanced-electronics"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-module-4"
		})

table.insert(data.raw["technology"]["advanced-electronics"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-module-5"
		})

table.insert(data.raw["technology"]["solar-energy"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-solarpanel"
		})

table.insert(data.raw["technology"]["electric-energy-accumulators"].effects,
		{
			type = "unlock-recipe",
			recipe = "alien-accumulator"
		})

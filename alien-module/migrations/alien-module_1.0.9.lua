for i, force in pairs(game.forces) do
	if force.technologies["military"].researched then
		force.recipes["alien-gun-turret"].enabled = true
	end

	if force.technologies["military"].researched then
		force.recipes["alien-wall"].enabled = true
	end

	local modifier = 0

	if force.technologies["physical-projectile-damage-1"].researched then
		modifier = modifier + 0.1
	end
	if force.technologies["physical-projectile-damage-2"].researched then
		modifier = modifier + 0.1
	end
	if force.technologies["physical-projectile-damage-3"].researched then
		modifier = modifier + 0.2
	end
	if force.technologies["physical-projectile-damage-4"].researched then
		modifier = modifier + 0.2
	end
	if force.technologies["physical-projectile-damage-5"].researched then
		modifier = modifier + 0.2
	end
	if force.technologies["physical-projectile-damage-6"].researched then
		modifier = modifier + 0.4
	end
	if force.technologies["physical-projectile-damage-7"].researched then
		modifier = modifier + 0.7 * force.technologies["physical-projectile-damage-7"].level
	end

	force.set_turret_attack_modifier("alien-gun-turret", modifier)
end
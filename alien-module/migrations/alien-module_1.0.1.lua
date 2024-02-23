for i, force in pairs(game.forces) do
	if force.technologies["advanced-material-processing"].researched then
		force.recipes["alien-steel-plate"].enabled = true
	end

	if force.technologies["automation-2"].researched then
		force.recipes["alien-steam-engine"].enabled = true
	end
end
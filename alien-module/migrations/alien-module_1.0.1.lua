for i, force in pairs(game.forces) do
	if force.technologies["advanced-material-processing"].researched then
		force.recipes["alien-steel-plate"].enabled = true
	end
end
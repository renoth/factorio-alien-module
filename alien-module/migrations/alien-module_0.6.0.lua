for i, force in pairs(game.forces) do
	if force.technologies["automation"].researched then
		force.recipes["alien-module-2"].enabled = true
	end
end
for i, force in pairs(game.forces) do
	if force.technologies["automation"].researched then
		force.recipes["alien-hyper-module-1"].enabled = true
	end
end
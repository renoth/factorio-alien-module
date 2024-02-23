for i, force in pairs(game.forces) do
	if force.technologies["military"].researched then
		force.recipes["alien-fuel"].enabled = true
	end
end
for i, force in pairs(game.forces) do
	if force.technologies["electric-energy-accumulators"].researched then
		force.recipes["alien-accumulator"].enabled = true
	end
end

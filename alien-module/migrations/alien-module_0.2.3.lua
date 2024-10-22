for i, force in pairs(game.forces) do
	if force.technologies["military"].researched then
		force.recipes["alien-plate"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["military"].researched then
		force.recipes["alien-magazine"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["automation"].researched then
		force.recipes["alien-module-1"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["solar-energy"].researched then
		force.recipes["alien-solarpanel"].enabled = true
	end
end

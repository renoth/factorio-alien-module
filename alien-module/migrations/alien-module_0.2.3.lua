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
	if force.technologies["electronics"].researched then
		force.recipes["alien-module-2"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["advanced-electronics"].researched then
		force.recipes["alien-module-3"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["advanced-electronics"].researched then
		force.recipes["alien-module-4"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["advanced-electronics"].researched then
		force.recipes["alien-module-5"].enabled = true
	end
end

for i, force in pairs(game.forces) do
	if force.technologies["solar-energy"].researched then
		force.recipes["alien-solarpanel"].enabled = true
	end
end

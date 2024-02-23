-- store counters from singleplayer
local killcount_cache = global.killcount
local currentmodulelevel_cache = global.currentmodulelevel
local modulelevel_cache = global.modulelevel

-- make global counters lists
global.killcount = {}
global.currentmodulelevel = {}
global.modulelevel = {}

-- store the previous single values in the for all farces
for i, force in pairs(game.forces) do
	global.killcount[force.name] = killcount_cache
	global.currentmodulelevel[force.name] = currentmodulelevel_cache
	global.modulelevel[force.name] = modulelevel_cache
end
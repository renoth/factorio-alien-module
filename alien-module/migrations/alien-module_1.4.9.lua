if (tonumber(global.killcount) ~= nil) then
	-- store counters from singleplayer
	local killcount_cache = global.killcount
	local currentmodulelevel_cache = global.currentmodulelevel
	local modulelevel_cache = global.modulelevel

	-- make global counters lists
	global.killcount = {}
	global.currentmodulelevel = {}
	global.modulelevel = {}

	global.killcount["player"] = killcount_cache
	global.currentmodulelevel["player"] = currentmodulelevel_cache
	global.modulelevel["player"] = modulelevel_cache
end



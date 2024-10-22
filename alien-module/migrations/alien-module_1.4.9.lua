if (tonumber(storage.killcount) ~= nil) then
	-- store counters from singleplayer
	local killcount_cache = storage.killcount
	local currentmodulelevel_cache = storage.currentmodulelevel
	local modulelevel_cache = storage.modulelevel

	-- make global counters lists
	storage.killcount = {}
	storage.currentmodulelevel = {}
	storage.modulelevel = {}

	storage.killcount["player"] = killcount_cache
	storage.currentmodulelevel["player"] = currentmodulelevel_cache
	storage.modulelevel["player"] = modulelevel_cache
end



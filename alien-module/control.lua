--***Debug Mode
local debug_mode
debug_mode = false
-- debug_mode = true
--***
-- Set the first pass variable (to be used in conjunction with debug_mode) 
local first_pass = true
-- Adds this many kills per update when debug_mode is enabled
local kills_per_update = 5000
-- Set tick frequency for updates
local tick_freq = 1
-- batch_size is the # of chunks per update that are scanned. 
local batch_size = 10


function modulelevel()
    if (global.killcount < 10000) then
        return math.max(math.log((global.killcount + 1) * 0.1) * math.pow((global.killcount), 0.1), 1) * math.sqrt((global.killcount * 0.0001))
    else
        return math.max(math.log((global.killcount + 1) * 0.1) * math.pow((global.killcount), 0.1), 1)
    end
end

function roundModuleLevel()
    return math.floor(modulelevel() * 1000 + 0.5) / 1000
end

function initVariables()
    if global.currentmodulelevel == nil then
        global.currentmodulelevel = 1
    end
    if global.modulelevel == nil then
        global.modulelevel = 1
    end
    if global.killcount == nil then
        global.killcount = 0
    end
end

function init_gui()
    for _, player in pairs(game.players) do
        player.gui.top.add { type = "frame", name = "alienmodule", direction = "vertical" }
        player.gui.top.alienmodule.add { type = "label", name = "killcount", caption = "TEST" }
        player.gui.top.alienmodule.add { type = "progressbar", name = "killbar" }

        player.gui.top.alienmodule.killbar.value = math.max(roundModuleLevel() - global.modulelevel, 0)
    end
end

-- pretty print a variable var
function pp(key, param)
    for _, player in pairs(game.players) do
        if type(key) == "string" then
            player.print({ key, param })
        end
    end
end

function update_gui()
    for _, player in pairs(game.players) do
        if player.gui.top.killcount ~= nil then
            player.gui.top.killcount.destroy()
        end

        if player.gui.top.killbar ~= nil then
            player.gui.top.killbar.destroy()
        end

        if player.gui.top.alienmodule == nil then
            player.gui.top.add { type = "frame", name = "alienmodule", direction = "vertical" }
        end

        if player.gui.top.alienmodule.killcount == nil then
            player.gui.top.alienmodule.add { type = "label", name = "killcount", caption = "0" }
        end

        if player.gui.top.alienmodule.killbar == nil then
            player.gui.top.alienmodule.add { type = "progressbar", name = "killbar" }
        end

        player.gui.top.alienmodule.killcount.caption = { 'gui.label', roundModuleLevel(), global.killcount }
        player.gui.top.alienmodule.killbar.value = math.max(roundModuleLevel() - global.modulelevel, 0)
    end
end

function update_modules(entities, entityType)
    for _, entity in pairs(entities) do
        local inventory --what type of inventory does this entity have?
        if entityType == "chest" then
            inventory = entity.get_inventory(defines.inventory.chest) --grab a chest's inventory
        elseif entityType == "machine" then
            inventory = entity.get_module_inventory() --grab a machine's inventory
        elseif entityType == "player" then
            inventory = entity.get_main_inventory(defines.inventory.player_main) --grab a player's inventory
        else
            return --error entity type not defined
        end

        if inventory == nil then
            return
        end

        for i = 1, #inventory, 1 do --loop through all of the entity's inventory slots
            local status, err = pcall(function()
                if string.find(inventory[i].name, "^alien%-hyper%-module") then --if theres a module in this inventory slot
                    if tonumber(string.match(inventory[i].name, "%d+$")) < global.currentmodulelevel then --and its level is less than the "current" one
                        local stacksize = inventory[i].count --record amount
                        inventory[i].clear() --clear the slot
                        inventory[i].set_stack({ name = "alien-hyper-module-" .. math.min(global.currentmodulelevel,100), count = stacksize }) --add the updated level modules with whatever amount we recorded
                    end
                end
            end)
        end
    end
end


function update_recipes(assemblers)
	local current_module_name = 'alien-hyper-module-' .. tostring(math.min(global.currentmodulelevel,100))
	for _, entity in pairs(assemblers) do
		local force = entity.force
		local input_inv = entity.get_inventory(defines.inventory.assembling_machine_input)
		local output_inv = entity.get_inventory(defines.inventory.assembling_machine_output)
		if force ~= nil then 
			local recipe = entity.get_recipe()
			if recipe ~= nil then
				local ingredients = recipe.ingredients
				local recipe_name = recipe.name
				if recipe_name ~= current_module_name and string.find(recipe_name,"^alien%-hyper%-module") then
					local finished_module_count = output_inv.get_item_count()
					entity.set_recipe(current_module_name)
					if finished_module_count > 0 then
						output_inv.insert { name =  current_module_name, count = finished_module_count }
					end
					for __, ingredient in pairs(ingredients) do
						input_inv.insert { name = ingredient.name, count = ingredient.amount }
					end
				end
			end
		end
	end
end


function update_enabled_recipe()
    for _, force in pairs(game.forces) do
        if force.technologies["automation"].researched then
            if global.currentmodulelevel > 1 and global.currentmodulelevel < 100 then
                force.recipes["alien-hyper-module-1"].enabled = false
                force.recipes["alien-hyper-module-" .. global.currentmodulelevel - 1].enabled = false
                force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
            end
        end
    end
end

-- Should be working now. 
function update_modules_on_surface(surface, chunk_pos)
	local names = {}
	local modulesOnGround
	local current_module_name = 'alien-hyper-module-' .. tostring(math.min(global.currentmodulelevel,100))
	--***When debug_mode is enabled, only locations around the first player are scanned.
	if debug_mode then
		modulesOnGround = surface.find_entities_filtered { name = 'item-on-ground', position = game.players[1].position, radius = 24}
	else
		modulesOnGround = surface.find_entities_filtered { name = 'item-on-ground', position = chunk_pos, radius = 24}
	end
	
	for index, module_on_ground in pairs(modulesOnGround) do
		--game.print(module_on_ground.stack.name)
		local real_name = module_on_ground.stack.name
		local module_pos = module_on_ground.position
		local item_count = module_on_ground.stack.count
		if (string.find(real_name, "^alien%-hyper%-module") and real_name ~= current_module_name) then
			module_on_ground.destroy()
			surface.create_entity {name = 'item-on-ground' , position = module_pos , stack = {name = current_module_name, count = item_count}}
		end
	end

end

local function copy_surfaces()
	global.surfaces = {}
	for k,v in pairs(game.surfaces) do
		global.surfaces[k] = v
	end
	global.current_surface_iter_index = next(global.surfaces, nil)
end

local function update_surface_iter_index()
	--Inputting a nil value to next() will get the first table index. 
	--Occasionally next will return nil, and we want to skip nil indexes
	if global.surfaces == nil then copy_surfaces() end
	global.current_surface_iter_index = next(global.surfaces, global.current_surface_iter_index)
	if global.current_surface_iter_index == nil then 
		global.current_surface_iter_index = next(global.surfaces, global.current_surface_iter_index)
	end
end


-- if an entity is killed, raise killcount
script.on_event(defines.events.on_entity_died, function(event)
    if (event.entity.type == "unit") then
        global.killcount = global.killcount + 1
    end
end)


local function init()
    initVariables()
    init_gui()
end

script.on_init(init)


-- At a defined tick frequency and chunk batch quantity: cycle through the game surfaces and scan the chunks for modules to upgrade. 
script.on_nth_tick(tick_freq, function(event)
    global.modulelevel = math.max(math.floor(modulelevel()), 1)
    update_gui()
	
	--***Debug Mode
	if debug_mode then
		global.killcount = global.killcount + kills_per_update
		if first_pass then
			game.players[1].insert{name='alien-hyper-module-1', count=50}
			game.players[1].insert{name='assembling-machine-3',count=50}
			game.players[1].insert{name='solar-panel',count=100}
			game.players[1].insert{name='medium-electric-pole',count=100}
			first_pass = false
		end
	end
    --***
	--If current iterator index is nil, then we start with the first surface. 
	
	if global.surfaces == nil then copy_surfaces() end
	
	--The following if statement should only execute as true on the first pass
	if global.surface_iterator == nil then
		local curr_surface = global.surfaces[global.current_surface_iter_index]
		global.surface_iterator = curr_surface.get_chunks()
	end
	--
	for i=1, batch_size do
		--***Want to get all the chunk logic in here so we can scan a surface more quickly per cycle.
		--Use the next(table, cached_index) function to get the next surface to scan-- if chunk_iterator() returns nil then move to next surface index. 
		local chunk = global.surface_iterator()
		if chunk == nil then
			-- Disable the printing if not in debug mode
			if debug_mode then
				game.print('Rescanning chunks on surface # ' .. tostring(global.current_surface_iter_index))
			end
			update_surface_iter_index()
			global.surface_iterator = global.surfaces[global.current_surface_iter_index].get_chunks()
		else
			--include logic here to scan each surface @ chunk.
			local surface = global.surfaces[global.current_surface_iter_index]
			if surface == nil then return end
			local chunk_position = { x = chunk.x * 32 + 16, y = chunk.y*32 + 16 } -- Offset + 16 in x and y to get center position of chunk.
			update_modules_on_surface(surface,chunk_position)
			--game.print(serpent.block(chunk_position))
			
			local assemblers = surface.find_entities_filtered { type = "assembling-machine", position = chunk_position, radius = 24}
			local miners = surface.find_entities_filtered { type = "mining-drill" , position = chunk_position, radius = 24}
			local labs = surface.find_entities_filtered { type = "lab" , position = chunk_position, radius = 24}
			local furnaces = surface.find_entities_filtered { type = "furnace" , position = chunk_position, radius = 24}
			local rocketSilos = surface.find_entities_filtered { name = "rocket-silo" , position = chunk_position, radius = 24}
			local chests = surface.find_entities_filtered { type = "container" , position = chunk_position, radius = 24}
			local logisticChests = surface.find_entities_filtered { type = "logistic-container" , position = chunk_position, radius = 24}
			local beacons = surface.find_entities_filtered { type = "beacon" , position = chunk_position, radius = 24}

			if debug_mode then
				rendering.draw_circle{color = {r = 1, g = 0, b = 0, a = 0.5}, radius = 24, target = chunk_position, filled = true, surface = global.surfaces[global.current_surface_iter_index], time_to_live = 30}
			end

			update_modules(assemblers, "machine")
			update_modules(miners, "machine")
			update_modules(labs, "machine")
			update_modules(furnaces, "machine")
			update_modules(rocketSilos, "machine")
			update_modules(chests, "chest")
			update_modules(logisticChests, "chest")
			update_modules(beacons, "machine")

			update_recipes(assemblers)

		end
	end




	if (global.modulelevel > global.currentmodulelevel) then
		global.currentmodulelevel = global.currentmodulelevel + 1
		pp('gui.module-upgraded', global.modulelevel)
		update_enabled_recipe()
		-- play level up sound
		if debug_mode then

		else
			for _, player in pairs(game.players) do
				player.play_sound { path = 'alien-level-up' }
			end
		end
	end

	local players = game.players
	update_modules(players, "player")
end)

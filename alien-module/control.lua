script.on_init(function()
    initVariables()
    init_gui()
end)

script.on_load(function()
    initVariables()
end)

function modulelevel()
    return math.max(math.log((global.killcount + 19) * 0.1) * math.pow((global.killcount + 19), 0.1), 1)
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
            player.gui.top.alienmodule.add { type = "label", name = "killcount", caption = "TEST" }
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
		local inventory--what type of inventory does this entity have?
		
		if entityType == "chest" then
			inventory = entity.get_inventory(defines.inventory.chest)--grab a chest's inventory
		elseif entityType == "machine" then
			inventory = entity.get_module_inventory()--grab a machine's inventory
		elseif entityType == "player" then
			inventory = entity.get_inventory(defines.inventory.player_main)--grab a player's inventory
		else
			return--error entity type not defined
		end

		for i=1,#inventory,1 do--loop through all of the entity's inventory slots
			local status, err = pcall(
				function ()
					if string.find(inventory[i].name, "^alien%-hyper%-module") then--if theres a module in this inventory slot
						local stacksize = inventory[i].count--record amount
						inventory[i].clear()--clear the slot
						inventory[i].set_stack({name = "alien-hyper-module-" .. level, count = stacksize})--add the updated level modules with whatever amount we recorded
					end
				end
			)
		end
	end
end

function update_recipes(assemblers, force)
	for _, entity in ipairs(assemblers) do
		if entity.get_recipe() ~= nil then--if the assembler has a set recipe
			if string.find(entity.get_recipe().name, "^alien%-hyper%-module") then--and its one of ours
				entity.set_recipe(force.recipes["alien-hyper-module-" .. global.currentmodulelevel])--set it to the updated recipe
			end
		end
	end
end

function update_enabled_recipe()
	for _, force in pairs(game.forces) do
		if force.technologies["automation"].researched then
			if global.currentmodulelevel > 1 then
				force.recipes["alien-hyper-module-1"].enabled = false
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel - 1].enabled = false
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end
		end
	end
end

-- if an entity is killed, raise killcount
script.on_event(defines.events.on_entity_died, function(event)
    if (event.entity.type == "unit") then
        global.killcount = global.killcount + 1
    end
end)

-- Every 2 seconds: calculate the module level and upgrade hyper modules if level floor value changed
script.on_nth_tick(120, function(event)

	--every 10 seconds update what module recipe is enabled
    if event.tick % 600 == 0 then
		update_enabled_recipe()
	end

	global.modulelevel = math.max(math.floor(modulelevel()), 1)

    update_gui()

    -- if the modulelevel is raised by the kill, increase the level of all hyper modules by finding and replacing them
    -- TODO: future API of factorio might have more convenient methods of doing that)
    if (global.modulelevel > global.currentmodulelevel) then
        global.currentmodulelevel = global.currentmodulelevel + 1
		
		--update what module recipe is enabled
		update_enabled_recipe()

        for _, surface in pairs(game.surfaces) do
			local assemblers = surface.find_entities_filtered{type = "assembling-machine"}
			local miners = surface.find_entities_filtered{type = "mining-drill"}
			local labs = surface.find_entities_filtered{type = "lab"}
			local furnaces = surface.find_entities_filtered{type = "furnace"}
			local rocketSilos = surface.find_entities_filtered{name = "rocket-silo"}
			local chests = surface.find_entities_filtered{type = "container"}
			local logisticChests = surface.find_entities_filtered{type = "logistic-container"}
				
			update_modules(assemblers, "machine")
			update_modules(miners, "machine")
			update_modules(labs, "machine")
			update_modules(furnaces, "machine")
			update_modules(rocketSilos, "machine")
			update_modules(chests, "chest")
			update_modules(logisticChests, "chest")
				
			for _, force in pairs(game.forces) do
				update_recipes(assemblers, force)
			end
        end

		local players = game.players
		update_modules(players, "player")

        pp('gui.module-upgraded', global.modulelevel)
    end
end)

-- every 10 seconds check if level 1 recipe is enabled when it should not be enabled
script.on_nth_tick(600, function(event)
    for _, force in pairs(game.forces) do
        if force.technologies["automation"].researched then
            if force.recipes["alien-hyper-module-1"].enabled == true and global.currentmodulelevel > 1 then
                force.recipes["alien-hyper-module-1"].enabled = false
            end
        end
    end
end)
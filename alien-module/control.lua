script.on_init(function()
	global.killcount = 0
	global.modulelevel = 0
	global.currentmodulelevel = 1
	init_gui()
end)

script.on_load(function()
	if global.currentmodulelevel == nil then
		global.currentmodulelevel = 1
	end
end)

function init_gui()
	for _, player in pairs(game.players) do
        player.gui.top.add{type="label", name="killcount", caption="Killcount"}
		player.gui.top.killcount.caption = "Killcount: " .. global.killcount
    end
end

-- pretty print a variable var
function pp(var)
    for _, player in pairs(game.players) do
      local msg
      if type(var) == "string" then
        msg = var
      else
        msg = serpent.dump(var, {name="var", compact=false, nocode=true, comment=false, sparse=false, sortkeys=true})
      end
      player.print(msg)
    end
end

function update_gui()
	for _, player in pairs(game.players) do
		if player.gui.top.killcount == nil then
			player.gui.top.add{type="label", name="killcount", caption="TEST"}
		end
		player.gui.top.killcount.caption = "Hypermodule level: " .. roundModuleLevel(3) .. " Killcount: " .. global.killcount
    end
end

function modulelevel()
	return math.log(global.killcount * 0.1) * math.pow(global.killcount, 0.1)
end

function roundModuleLevel(decimals)
	shift = 10^decimals
	return math.floor(modulelevel() * shift + 0.5) / shift
end

function update_modules_in_module_slot(entities, level)
	for _, entity in ipairs(entities) do
		local moduleInventory = entity.get_module_inventory()
		
		for i=1,6,1 do
			local status, err = pcall(function () 
				if string.find(moduleInventory[i].name, "^alien%-hyper%-module") then
					moduleInventory[i].clear()
					moduleInventory[i].set_stack({name ="alien-hyper-module-" .. level})
				end 
			end)
		end
	end
end

function MergeTables(t1,t2)
	for i=1,#t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end

function update_recipes(assemblers, level, newrecipe)
	for _, entity in ipairs(assemblers) do
		if entity.recipe ~= nil then
			if string.find(entity.recipe.name, "^alien%-hyper%-module") then
				entity.recipe = newrecipe
			end
		end
	end
end

-- todo optimization: break method call if max chest size has been reached
function updateChestContents(chest)
	local chestInventory = chest.get_inventory(defines.inventory.chest)

	for i=1,80,1 do
		if pcall(function ()
			if string.find(chestInventory[i].name, "^alien%-hyper%-module") then
				local stacksize = chestInventory[i].count
				chestInventory[i].clear()
				chestInventory[i].set_stack({name ="alien-hyper-module-" .. global.currentmodulelevel, count = stacksize})
			end
		end) then

		else

		end
	end
end

-- if an entity is killed, raise killcount
script.on_event(defines.events.on_entity_died, function(event)
	if (event.entity.type == "unit") then
		global.killcount = global.killcount + 1
		
		global.modulelevel = math.max(math.floor(modulelevel()), 1)
		
		update_gui()
		
		for _, force in pairs(game.forces) do
			if force.technologies["automation"].researched then
				force.recipes["alien-hyper-module-1"].enabled = false
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end
		end
		
		-- if the modulelevel is raised by the kill, increase the level of all hyper modules by finding and replacing them (future API of factorio might have more convenient methods of doing that)
		if (global.modulelevel > global.currentmodulelevel) then
			global.currentmodulelevel = global.currentmodulelevel + 1

			for _, force in pairs(game.forces) do
			    force.recipes["alien-hyper-module-" .. global.currentmodulelevel - 1].enabled = false
			    force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end

			for _, surface in pairs(game.surfaces) do
				local assemblers = surface.find_entities_filtered{type = "assembling-machine"}
				local miners = surface.find_entities_filtered{type = "mining-drill"}
				local labs = surface.find_entities_filtered{type = "lab"}
				local furnaces = surface.find_entities_filtered{type = "furnace"}
				local rocketSilos = surface.find_entities_filtered{name = "rocket-silo"}

				update_modules_in_module_slot(assemblers, global.currentmodulelevel)
				update_modules_in_module_slot(miners, global.currentmodulelevel)
				update_modules_in_module_slot(labs, global.currentmodulelevel)
				update_modules_in_module_slot(furnaces, global.currentmodulelevel)
				update_modules_in_module_slot(rocketSilos, global.currentmodulelevel)

				for _, force in pairs(game.forces) do
					update_recipes(assemblers, global.currentmodulelevel, force.recipes["alien-hyper-module-" .. global.currentmodulelevel])
				end

				local chests = surface.find_entities_filtered{type = "container"}

				for _, chest in ipairs(chests) do
					updateChestContents(chest)
				end

				local logisticChests = surface.find_entities_filtered{name = "logistic-chest-passive-provider"}
				MergeTables(logisticChests, surface.find_entities_filtered{name = "logistic-chest-active-provider"})
				MergeTables(logisticChests, surface.find_entities_filtered{name = "logistic-chest-storage"})
				MergeTables(logisticChests, surface.find_entities_filtered{name = "logistic-chest-requester"})

				for _, chest in ipairs(logisticChests) do
					updateChestContents(chest)
				end

			end
			
			for _, player in pairs(game.players) do
				local pinv = player.get_inventory(defines.inventory.player_main)
				
				for i=1,100,1 do 
					pcall(function () 
						if string.find(pinv[i].name, "^alien%-hyper%-module") then
							local stacksize = pinv[i].count
							pinv[i].clear()
							pinv[i].set_stack({name ="alien-hyper-module-" .. global.currentmodulelevel, count = stacksize})
						end
					end)
				end
			end
			
			pp("Alien Hyper Modules upgraded to level: " .. global.modulelevel)
		end
	end
end)

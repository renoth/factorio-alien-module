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
        player.gui.top.add{type="label", name="killcount", caption="TEST"}
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
		player.gui.top.killcount.caption = "Hypermodule level: " .. math.log(global.killcount * 0.1) * math.pow(global.killcount, 0.1) .. " Killcount: " .. global.killcount
    end
end

-- every 36000 ticks update modules in machines, to update those that werent in module slots and chests at update time
--script.on_event(defines.events.on_tick, function(event)
  --  if (event.tick % 36000) ~= 0 then return end
	
--	local assemblers = game.surfaces[1].find_entities_filtered{type = "assembling-machine"}
--	local miners = game.surfaces[1].find_entities_filtered{type = "mining-drill"}
	
	--update_modules_in_module_slot(assemblers, global.modulelevel)
	--update_modules_in_module_slot(miners, global.modulelevel)
--end)

function update_modules_in_module_slot(entities, level) 
	for _, entity in ipairs(entities) do
		local minv = entity.get_module_inventory()
		
		for i=1,4,1 do 
			local status, err = pcall(function () 
				if string.find(minv[i].name, "^alien%-hyper%-module") then
					minv[i].clear()
					minv[i].set_stack({name ="alien-hyper-module-" .. level})
				end 
			end)
		end
	end
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

-- if an entity is killed, raise killcount
script.on_event(defines.events.on_entity_died, function(event)
	if (event.entity.type == "unit") then
		global.killcount = global.killcount + 1
		
		global.modulelevel = math.max(math.floor(math.log(global.killcount * 0.1) * math.pow(global.killcount, 0.1)), 1)
		
		update_gui()
		
		for i, force in pairs(game.forces) do 
			if force.technologies["automation"].researched then 
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end
		end
		
		-- if the modulelevel is raised by the kill, increase the level of all hyper modules by finding and replacing them (future API of factorio might have more convenient methods of doing that)
		if (global.modulelevel > global.currentmodulelevel) then
			global.currentmodulelevel = global.currentmodulelevel + 1

			for i, force in pairs(game.forces) do
			    force.recipes["alien-hyper-module-" .. global.currentmodulelevel - 1].enabled = false
			    force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end

			for _, surface in pairs(game.surfaces) do
				local assemblers = surface.find_entities_filtered{type = "assembling-machine"}
				local miners = surface.find_entities_filtered{type = "mining-drill"}
				local labs = surface.find_entities_filtered{type = "lab"}
				local furnaces = surface.find_entities_filtered{type = "furnace"}

				update_modules_in_module_slot(assemblers, global.currentmodulelevel)
				update_modules_in_module_slot(miners, global.currentmodulelevel)
				update_modules_in_module_slot(labs, global.currentmodulelevel)
				update_modules_in_module_slot(furnaces, global.currentmodulelevel)

				for i, force in pairs(game.forces) do
					update_recipes(assemblers, global.currentmodulelevel, force.recipes["alien-hyper-module-" .. global.currentmodulelevel])
				end

				local chests = surface.find_entities_filtered{type = "container"}

				for _, chest in ipairs(chests) do
					local cinv = chest.get_inventory(defines.inventory.chest)

					for i=1,80,1 do
						if pcall(function ()
							if string.find(cinv[i].name, "^alien%-hyper%-module") then
								local stacksize = cinv[i].count
								cinv[i].clear()
								cinv[i].set_stack({name ="alien-hyper-module-" .. global.currentmodulelevel, count = stacksize})
							end
						end) then

						else

						end
					end
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

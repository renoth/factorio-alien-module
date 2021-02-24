script.on_init(function()
	initVariables()
	init_gui()
end)

script.on_load(function()
	initVariables()
end)

-- Calculate module level, minimum 1 maximum 100
function modulelevel()
	local exponent = settings.startup["alien-module-level-exponent"].value
	if (global.killcount < 10000) then
		return math.min(math.max(math.log((global.killcount + 1) * 0.1) * math.pow((global.killcount), exponent), 1) * math.sqrt((global.killcount * 0.0001)), 100)
	else
		return math.min(math.max(math.log((global.killcount + 1) * 0.1) * math.pow((global.killcount), exponent), 1), 100)
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

			for i = 1, entity.request_slot_count do
				local slot = entity.get_request_slot(i)
				if slot ~= nil and slot.name == "alien-hyper-module-" .. global.currentmodulelevel - 1 then
					entity.set_request_slot({ name = "alien-hyper-module-" .. global.currentmodulelevel, count = slot.count }, i)
				end

				if settings.startup["alien-module-hyper-ammo-enabled"].value and slot ~= nil and slot.name == "alien-hyper-magazine-" .. global.currentmodulelevel - 1 then
					entity.set_request_slot({ name = "alien-hyper-magazine-" .. global.currentmodulelevel, count = slot.count }, i)
				end
			end
		elseif entityType == "machine" then
			inventory = entity.get_module_inventory() --grab a machine's inventory
		elseif entityType == "player" then
			inventory = entity.get_main_inventory(defines.inventory.player_main) --grab a player's inventory

			-- update currently held items
			if entity.cursor_stack ~= nil and entity.cursor_stack.valid_for_read then
				if string.find(entity.cursor_stack.name, "^alien%-hyper%-module") then
					--if theres a module in this inventory slot
					if tonumber(string.match(entity.cursor_stack.name, "%d+$")) < global.currentmodulelevel then
						--and its level is less than the "current" one
						local stacksize = entity.cursor_stack.count --record amount
						entity.cursor_stack.clear() --clear the slot
						entity.cursor_stack.set_stack({ name = "alien-hyper-module-" .. math.min(global.currentmodulelevel, 100), count = stacksize }) --add the updated level modules with whatever amount we recorded
					end
				end

				if string.find(entity.cursor_stack.name, "^alien%-hyper%-magazine") then
					--if theres a module in this inventory slot
					if tonumber(string.match(entity.cursor_stack.name, "%d+$")) < global.currentmodulelevel then
						--and its level is less than the "current" one
						local stacksize = entity.cursor_stack.count --record amount
						entity.cursor_stack.clear() --clear the slot
						entity.cursor_stack.set_stack({ name = "alien-hyper-magazine-" .. math.min(global.currentmodulelevel, 100), count = stacksize }) --add the updated level modules with whatever amount we recorded
					end
				end
			end
		else
			return --error entity type not defined
		end

		if inventory == nil then
			return
		end

		for i = 1, #inventory, 1 do
			--loop through all of the entity's inventory slots
			local status, err = pcall(function()
				if string.find(inventory[i].name, "^alien%-hyper%-module") then
					--if theres a module in this inventory slot
					if tonumber(string.match(inventory[i].name, "%d+$")) < global.currentmodulelevel then
						--and its level is less than the "current" one
						local stacksize = inventory[i].count --record amount
						inventory[i].clear() --clear the slot

						if entityType == "player" and inventory.get_filter(i) ~= nil then
							-- check if slot is filtered
							inventory.set_filter(i, "alien-hyper-module-" .. math.min(global.currentmodulelevel, 100)) --update filter
						end

						inventory[i].set_stack({ name = "alien-hyper-module-" .. math.min(global.currentmodulelevel, 100), count = stacksize }) --add the updated level modules with whatever amount we recorded
					end
				end

				if string.find(inventory[i].name, "^alien%-hyper%-magazine") then
					--if theres a module in this inventory slot
					if tonumber(string.match(inventory[i].name, "%d+$")) < global.currentmodulelevel then
						--and its level is less than the "current" one
						local stacksize = inventory[i].count --record amount
						inventory[i].clear() --clear the slot

						if entityType == "player" and inventory.get_filter(i) ~= nil then
							-- check if slot is filtered
							inventory.set_filter(i, "alien-hyper-magazine-" .. math.min(global.currentmodulelevel, 100)) --update filter
						end

						inventory[i].set_stack({ name = "alien-hyper-magazine-" .. math.min(global.currentmodulelevel, 100), count = stacksize })
						--add the updated level modules with whatever amount we recorded
					end
				end
			end)
		end
	end
end

function update_ammo(turrets)
	for _, entity in pairs(turrets) do
		local inventory = entity.get_inventory(defines.inventory.chest) --grab a chest's inventory

		if inventory == nil then
			return
		end

		for i = 1, #inventory, 1 do
			--loop through all of the entity's inventory slots
			local status, err = pcall(function()
				if string.find(inventory[i].name, "^alien%-hyper%-magazine") then
					--if theres hyper ammo in the inventory slot
					if tonumber(string.match(inventory[i].name, "%d+$")) < global.currentmodulelevel then
						--and its level is less than the "current" one
						local stacksize = inventory[i].count --record amount
						inventory[i].clear() --clear the slot
						inventory[i].set_stack({ name = "alien-hyper-magazine-" .. math.min(global.currentmodulelevel, 100), count = stacksize })
					end
				end
			end)
		end
	end
end

function update_recipes(assemblers, force)
	for _, entity in ipairs(assemblers) do
		if entity.get_recipe() ~= nil then
			--if the assembler has a set recipe
			if string.find(entity.get_recipe().name, "^alien%-hyper%-module") then
				--and its one of ours
				local plates_to_refund = 0

				-- Save the number of modules in the output slot, crafting progress and bonus progress
				local finished_module_count = entity.get_inventory(defines.inventory.assembling_machine_output).get_item_count("alien-hyper-module-" .. global.currentmodulelevel - 1)
				local crafting_progress = entity.crafting_progress
				local bonus_progress = entity.bonus_progress

				entity.set_recipe(force.recipes["alien-hyper-module-" .. global.currentmodulelevel]) --set it to the updated recipe

				-- Add the modules back
				if finished_module_count > 0 then
					entity.get_inventory(defines.inventory.assembling_machine_output).insert { name = "alien-hyper-module-" .. global.currentmodulelevel, count = finished_module_count }
				end
				-- Restore previous progress
				entity.crafting_progress = crafting_progress
				entity.bonus_progress = bonus_progress
			end

			if settings.startup["alien-module-hyper-ammo-enabled"].value and string.find(entity.get_recipe().name, "^alien%-hyper%-magazine") then
				local finished_module_count = entity.get_inventory(defines.inventory.assembling_machine_output).get_item_count("alien-hyper-module-" .. global.currentmodulelevel - 1)

				entity.set_recipe(force.recipes["alien-hyper-magazine-" .. global.currentmodulelevel]) --set it to the updated recipe

				if finished_module_count > 0 then
					entity.get_inventory(defines.inventory.assembling_machine_output).insert {
						name = "alien-hyper-magazine-" .. global.currentmodulelevel,
						count = finished_module_count
					}
				end
			end
		end
	end
end

function update_quickbar(players)
	for _, player in pairs(players) do
		for i = 1, 100 do
			local slot = player.get_quick_bar_slot(i)
			if slot ~= nil and slot.name == "alien-hyper-module-" .. global.currentmodulelevel - 1 then
				player.set_quick_bar_slot(i, "alien-hyper-module-" .. global.currentmodulelevel)
			end
		end
	end
end

function update_logistic_slots(players)
	for _, player in pairs(players) do
		if player.character ~= nil then
			for i = 1, player.character.request_slot_count do
				local slot = player.get_personal_logistic_slot(i)
				if slot ~= nil and slot.name == "alien-hyper-module-" .. global.currentmodulelevel - 1 then
					player.set_personal_logistic_slot(i, { name = "alien-hyper-module-" .. global.currentmodulelevel, min = slot.min, max = slot.max })
				end

				if settings.startup["alien-module-hyper-ammo-enabled"].value and slot ~= nil and slot.name == "alien-hyper-magazine-" .. global.currentmodulelevel - 1 then
					player.set_personal_logistic_slot(i, { name = "alien-hyper-magazine-" .. global.currentmodulelevel, min = slot.min, max = slot.max })
				end
			end
		end
	end
end

--[[function update_trash_slots(players)
	for _, player in pairs(players) do
		local old_trash = player.auto_trash_filters
		local new_trash = {}

		for key, value in ipairs(old_trash) do
			player.print(key)
			player.print(value)
			if key ~= nil and key == "alien-hyper-module-" .. global.currentmodulelevel - 1 then
				new_trash.insert("alien-hyper-module-" .. global.currentmodulelevel, value)
			else
				new_trash.insert(key, value)
			end
		end

		player.print(new_trash)

		player.auto_trash_filters = new_trash
	end
end]]

function update_enabled_recipe()
	for _, force in pairs(game.forces) do
		if force.technologies["automation"].researched then
			if global.currentmodulelevel > 1 then
				force.recipes["alien-hyper-module-1"].enabled = false
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel - 1].enabled = false
				force.recipes["alien-hyper-module-" .. global.currentmodulelevel].enabled = true
			end
		end

		if force.technologies["military"].researched and settings.startup["alien-module-hyper-ammo-enabled"].value then
			if global.currentmodulelevel > 1 then
				force.recipes["alien-hyper-magazine-1"].enabled = false
				force.recipes["alien-hyper-magazine-" .. global.currentmodulelevel - 1].enabled = false
				force.recipes["alien-hyper-magazine-" .. global.currentmodulelevel].enabled = true
			else
				force.recipes["alien-hyper-magazine-1"].enabled = true
			end
		end
	end
end

-- not in use yet, prototype for later use
function update_modules_on_surface(surface)
	local names = {}
	local modulesOnGround = surface.find_entities_filtered { name = 'item-on-ground' }
	local current_module_name = 'alien-hyper-module-' .. tostring(math.min(global.currentmodulelevel, 100))
	local current_magazine_name = 'alien-hyper-magazine-' .. tostring(math.min(global.currentmodulelevel, 100))

	for index, module_on_ground in pairs(modulesOnGround) do
		--game.print(module_on_ground.stack.name)
		local real_name = module_on_ground.stack.name
		local module_pos = module_on_ground.position
		local item_count = module_on_ground.stack.count
		if (string.find(real_name, "^alien%-hyper%-module") and real_name ~= current_module_name) then
			module_on_ground.destroy()
			surface.create_entity { name = 'item-on-ground', position = module_pos, stack = { name = current_module_name, count = item_count } }
		end

		if settings.startup["alien-module-hyper-ammo-enabled"].value and (string.find(real_name, "^alien%-hyper%-magazine") and real_name ~= current_magazine_name) then
			module_on_ground.destroy()
			surface.create_entity { name = 'item-on-ground', position = module_pos, stack = { name = current_magazine_name, count = item_count } }
		end
	end
end

-- if an entity is killed, raise killcount
script.on_event(defines.events.on_entity_died, function(event)
	if (event.entity.type == "unit" and event.entity.force.name == "enemy") then
		global.killcount = global.killcount + 1
	end
end)

-- Every 2 seconds: calculate the module level and upgrade hyper modules if level floor value changed
script.on_nth_tick(120, function(event)
	global.modulelevel = math.max(math.floor(modulelevel()), 1)

	update_gui()

	-- if the modulelevel is raised by the kill, increase the level of all hyper modules by finding and replacing them
	if (global.modulelevel > global.currentmodulelevel) then
		global.currentmodulelevel = global.currentmodulelevel + 1

		--update what module recipe is enabled
		update_enabled_recipe()

		for _, surface in pairs(game.surfaces) do
			local assemblers = surface.find_entities_filtered { type = "assembling-machine" }
			local miners = surface.find_entities_filtered { type = "mining-drill" }
			local labs = surface.find_entities_filtered { type = "lab" }
			local furnaces = surface.find_entities_filtered { type = "furnace" }
			local rocketSilos = surface.find_entities_filtered { name = "rocket-silo" }
			local chests = surface.find_entities_filtered { type = "container" }
			local logisticChests = surface.find_entities_filtered { type = "logistic-container" }
			local beacons = surface.find_entities_filtered { type = "beacon" }
			local turrets = surface.find_entities_filtered { type = "ammo-turret" }

			update_modules(assemblers, "machine")
			update_modules(miners, "machine")
			update_modules(labs, "machine")
			update_modules(furnaces, "machine")
			update_modules(rocketSilos, "machine")
			update_modules(chests, "chest")
			update_modules(logisticChests, "chest")
			update_modules(beacons, "machine")

			if settings.startup["alien-module-hyper-ammo-enabled"].value then
				update_ammo(turrets)
			end

			for _, force in pairs(game.forces) do
				update_recipes(assemblers, force)
			end

			update_modules_on_surface(surface)
		end

		local players = game.players
		update_modules(players, "player")
		update_quickbar(players)
		update_logistic_slots(players)
		-- update_trash_slots(players)

		pp('gui.module-upgraded', global.modulelevel)

		-- play level up sound
		for _, player in pairs(game.players) do
			player.play_sound { path = 'alien-level-up' }
		end
	else
		--every 10 seconds update what module recipe is enabled
		if event.tick % 600 == 0 then
			update_enabled_recipe()
		end
	end
end)

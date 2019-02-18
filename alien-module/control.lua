script.on_init(function()
    initVariables()
    init_gui()
end)

script.on_load(function()
    initVariables()
end)

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
        local inventory --what type of inventory does this entity have?

        if entityType == "chest" then
            inventory = entity.get_inventory(defines.inventory.chest) --grab a chest's inventory
        elseif entityType == "machine" then
            inventory = entity.get_module_inventory() --grab a machine's inventory
        elseif entityType == "player" then
            -- TODO does not work for players any more, reason unknown
            inventory = entity.get_inventory(defines.inventory.player_main) --grab a player's inventory
        else
            return --error entity type not defined
        end

        for i = 1, #inventory, 1 do --loop through all of the entity's inventory slots
            local status, err = pcall(function()
                if string.find(inventory[i].name, "^alien%-hyper%-module") then --if theres a module in this inventory slot
                    if tonumber(string.match(inventory[i].name, "%d+$")) < global.currentmodulelevel then --and its level is less than the "current" one
                        local stacksize = inventory[i].count --record amount
                        inventory[i].clear() --clear the slot
                        inventory[i].set_stack({ name = "alien-hyper-module-" .. global.currentmodulelevel, count = stacksize }) --add the updated level modules with whatever amount we recorded
                    end
                end
            end)
        end
    end
end

function update_recipes(assemblers, force)
    for _, entity in ipairs(assemblers) do
        if entity.get_recipe() ~= nil then --if the assembler has a set recipe
            if string.find(entity.get_recipe().name, "^alien%-hyper%-module") then --and its one of ours
                local plates_to_refund = 0

                if entity.is_crafting() then -- refund ingredients if hyper modules are being crafted
                    plates_to_refund = (global.currentmodulelevel - 1) * 20 -- cost of currently crafting recipe
                    plates_to_refund = math.max(plates_to_refund, 0) -- dont add negative amount
                    entity.get_inventory(defines.inventory.assembling_machine_input).insert { name = "alien-plate", count = plates_to_refund }
                end

                local finished_module_count = entity.get_inventory(defines.inventory.assembling_machine_output).get_item_count("alien-hyper-module-" .. global.currentmodulelevel - 1)

                entity.set_recipe(force.recipes["alien-hyper-module-" .. global.currentmodulelevel]) --set it to the updated recipe

                if finished_module_count > 0 then
                    entity.get_inventory(defines.inventory.assembling_machine_output).insert { name = "alien-hyper-module-" .. global.currentmodulelevel, count = finished_module_count }
                end
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

-- not in use yet, prototype for later use
function update_modules_on_surface(surface)
    local modulesOnGround = surface.find_entities_filtered { name = "alien-hyper-module-" .. global.currentmodulelevel - 1 }

    for i = 1, #modulesOnGround, 1 do
        for _, player in pairs(game.players) do
            player.print("module" .. modulesOnGround[i].name)
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
    global.modulelevel = math.max(math.floor(modulelevel()), 1)

    update_gui()

    -- if the modulelevel is raised by the kill, increase the level of all hyper modules by finding and replacing them
    -- TODO: future API of factorio might have more convenient methods of doing that)
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

            update_modules(assemblers, "machine")
            update_modules(miners, "machine")
            update_modules(labs, "machine")
            update_modules(furnaces, "machine")
            update_modules(rocketSilos, "machine")
            update_modules(chests, "chest")
            update_modules(logisticChests, "chest")
			update_modules(beacons, "machine")

            for _, force in pairs(game.forces) do
                update_recipes(assemblers, force)
            end

            -- update_modules_on_surface(surface)
        end

        local players = game.players
        update_modules(players, "player")

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

local loot_to_add = { "artifact-ore" }

function RampantAddLootToCategory(category, c_max)
    for name, table_entry in pairs(data.raw[category]) do
        v, tier = string.match(name, "%-v(%d+)%-t(%d+)%-rampant")
        if v ~= nil and tier ~= nil then
            if table_entry.loot == nil then
                table_entry.loot = {}
            end
            for _, loot in pairs(loot_to_add) do
                local already_has_loot = false
                for _, loot_entry in pairs(table_entry.loot) do
                    if loot_entry.item == loot then
                        already_has_loot = true
                    end
                end
                if not already_has_loot then
                    table.insert(table_entry.loot, {
                        item = loot,
                        probability = 1,
                        count_min = 1,
                        count_max = c_max * tier,
                    })
                    -- log("added loot " .. loot .. " (" .. p .. "," .. c_min .. "," .. c_max .. ") to " .. name)
                else
                    -- log("skipping loot " .. loot .. " for " .. name)
                end

                log(name .. "current loot " .. serpent.line(table_entry.loot))
            end
        end
    end
end

RampantAddLootToCategory("turret", settings.startup["rampant-alienmodule-compat-max-count-turret"].value)
RampantAddLootToCategory("unit-spawner", settings.startup["rampant-alienmodule-compat-max-count-spawner"].value)


if (settings.startup["alien-module-productivity-everything"].value) then
    -- Allow Hyper Modules in any recipe (Cheaty)
    for _, recipe in pairs(data.raw.recipe) do
        recipe.allow_productivity = true
    end
end
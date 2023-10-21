local tech = data.raw["technology"]

local gun_turret_modifier = {
    [1] = 0.1,
    [2] = 0.1,
    [3] = 0.2,
    [4] = 0.2,
    [5] = 0.2,
    [6] = 0.4,
    [7] = 0.7
}
local tech_lv

for _, tech in pairs(tech) do
    if tech.name:match("^physical%-projectile%-damage%-") and tech.effects then
        for _, eff in pairs(tech.effects) do
            if eff.type == "turret-attack" and eff.turret_id == "gun-turret" then
                tech_lv = tech.name:match("[%a%s%-]+(%d+)")
                gun_turret_modifier[tech_lv] = eff.modifier
            end
        end
        table.insert(tech.effects, { type = "turret-attack", turret_id = "alien-gun-turret", modifier = gun_turret_modifier[tech_lv] })
    end
end

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
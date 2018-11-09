require("prototypes.entity.entity")

require("prototypes.item.alien-module")
require("prototypes.item.alien-components")
require("prototypes.item.alien-warfare")
require("prototypes.item.alien-economy")

require("prototypes.item-group.item-groups-module")

require("prototypes.recipe.alien-module")
require("prototypes.recipe.alien-warfare")

require("prototypes.technology.technology")

function AddLootToEntity(entityType, entityName, probability, countMin, countMax)
    if data.raw[entityType] ~= nil then
        if data.raw[entityType][entityName] ~= nil then
            if data.raw[entityType][entityName].loot == nil then
                data.raw[entityType][entityName].loot = {}
            end
            table.insert(data.raw[entityType][entityName].loot, { item = "artifact-ore", probability = probability, count_min = countMin, count_max = countMax })
        end
    end
end

function AddLootToBiters()
    local SMALL_LOOT_PROBABILITY = 0.2
    local MEDIUM_LOOT_PROBABILITY = 0.5
    local BIG_LOOT_PROBABILITY = 1

    AddLootToEntity("unit", "small-spitter", SMALL_LOOT_PROBABILITY, 1, 1)
    AddLootToEntity("unit", "small-biter", SMALL_LOOT_PROBABILITY, 1, 1)

    AddLootToEntity("unit", "medium-spitter", MEDIUM_LOOT_PROBABILITY, 1, 2)
    AddLootToEntity("unit", "medium-biter", MEDIUM_LOOT_PROBABILITY, 1, 2)

    AddLootToEntity("unit", "big-spitter", BIG_LOOT_PROBABILITY, 1, 5)
    AddLootToEntity("unit", "big-biter", BIG_LOOT_PROBABILITY, 1, 5)

    AddLootToEntity("unit", "behemoth-spitter", 1, 2, 20)
    AddLootToEntity("unit", "behemoth-biter", 1, 2, 20)

    AddLootToEntity("turret", "little-worm-turret", MEDIUM_LOOT_PROBABILITY, 1, 5)
    AddLootToEntity("turret", "medium-worm-turret", BIG_LOOT_PROBABILITY, 1, 10)
    AddLootToEntity("turret", "big-worm-turret", 1, 1, 25)
end

-- This is for the Natural Expansion Mod
for i = 1, 20 do
    local loot_probability = math.min(i * 0.06, 1)
    local loot_amount = math.floor(math.max(i * 0.101, 1))

    AddLootToEntity("unit", "ne-biter-breeder-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-biter-fire-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-biter-fast-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-biter-wallbreaker-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-biter-tank-" .. i, loot_probability, loot_amount, loot_amount)

    AddLootToEntity("unit", "ne-spitter-breeder-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-spitter-fire-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-spitter-ulaunch-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-spitter-webshooter-" .. i, loot_probability, loot_amount, loot_amount)
    AddLootToEntity("unit", "ne-spitter-mine-" .. i, loot_probability, loot_amount, loot_amount)
end

-- boss unit from NE
AddLootToEntity("unit", "ne-biter-megladon", 1, 50, 200)



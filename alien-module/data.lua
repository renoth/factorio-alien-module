require("prototypes.item.alien-module")
require("prototypes.item.alien-components")
require("prototypes.item-group.item-groups-module")
require("prototypes.recipe.alien-module")

function AddLootToEntity(entityType, entityName, itemName, probability, countMin, countMax)
    if data.raw[entityType] ~= nil then
        if data.raw[entityType][entityName] ~= nil then
            if data.raw[entityType][entityName].loot == nil then
                data.raw[entityType][entityName].loot = {}
            end
            table.insert(data.raw[entityType][entityName].loot, { item = itemName, probability = probability, count_min = countMin, count_max = countMax })
        end
    end
end

function AddLootToBiters() 
    SMALL_LOOT_PROBABILITY = 0.12
    MEDIUM_LOOT_PROBABILITY = 0.4
    BIG_LOOT_PROBABILITY = 0.75
    
    ALIEN_MODULE_ITEM_NAME = "alien-ore"

    AddLootToEntity("unit", "small-spitter", ALIEN_MODULE_ITEM_NAME, SMALL_LOOT_PROBABILITY, 1, 1)
    AddLootToEntity("unit", "small-biter", ALIEN_MODULE_ITEM_NAME, SMALL_LOOT_PROBABILITY, 1, 1)

    AddLootToEntity("unit", "medium-spitter", ALIEN_MODULE_ITEM_NAME, MEDIUM_LOOT_PROBABILITY, 1, 2)
    AddLootToEntity("unit", "medium-biter", ALIEN_MODULE_ITEM_NAME, MEDIUM_LOOT_PROBABILITY, 1, 2)

    AddLootToEntity("unit", "big-spitter", ALIEN_MODULE_ITEM_NAME, BIG_LOOT_PROBABILITY, 1, 5)
    AddLootToEntity("unit", "big-biter", ALIEN_MODULE_ITEM_NAME, BIG_LOOT_PROBABILITY, 1, 5)

    AddLootToEntity("unit", "behemoth-spitter", ALIEN_MODULE_ITEM_NAME, 1, 2, 5)
    AddLootToEntity("unit", "behemoth-biter", ALIEN_MODULE_ITEM_NAME, 1, 2, 5)

    AddLootToEntity("turret", "little-worm-turret", ALIEN_MODULE_ITEM_NAME, MEDIUM_LOOT_PROBABILITY, 1, 5)
    AddLootToEntity("turret", "medium-worm-turret", ALIEN_MODULE_ITEM_NAME, BIG_LOOT_PROBABILITY, 1, 10)
    AddLootToEntity("turret", "big-worm-turret", ALIEN_MODULE_ITEM_NAME, 1, 1, 25)
end

AddLootToBiters()


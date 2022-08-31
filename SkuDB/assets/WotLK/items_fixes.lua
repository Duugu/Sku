
    local itemKeys = {
        ['name'] = 1, -- string
        ['npcDrops'] = 2, -- table or nil, NPC IDs
        ['objectDrops'] = 3, -- table or nil, object IDs
        ['itemDrops'] = 4, -- table or nil, item IDs
        ['startQuest'] = 5, -- int or nil, ID of the quest started by this item
        ['questRewards'] = 6, -- table or nil, quest IDs
        ['flags'] = 7, -- int or nil, see: https://github.com/cmangos/issues/wiki/Item_template#flags
        ['foodType'] = 8, -- int or nil, see https://github.com/cmangos/issues/wiki/Item_template#foodtype
        ['itemLevel'] = 9, -- int, the level of this item
        ['requiredLevel'] = 10, -- int, the level required to equip/use this item
        ['ammoType'] = 11, -- int,
        ['class'] = 12, -- int,
        ['subClass'] = 13, -- int,
        ['vendors'] = 14, -- table or nil, NPC IDs
        ['relatedQuests'] = 15, -- table or nil, IDs of quests that are related to this item
    }

    local SkuItemFixes = {
        [33084] = {
            [itemKeys.npcDrops] = {},
        },
        [33123] = {
            [itemKeys.npcDrops] = {},
        },
        [33355] = {
            [itemKeys.npcDrops] = {},
        },
        [33628] = {
            [itemKeys.objectDrops] = {186659,186660,186661},
        },
        [34116] = {
            [itemKeys.npcDrops] = {24788},
        },
        [34118] = {
            [itemKeys.objectDrops] = {186944},
        },
        [34123] = {
            [itemKeys.objectDrops] = {186946},
        },
        [34623] = {
            [itemKeys.npcDrops] = {25226},
        },
        [34713] = {
            [itemKeys.npcDrops] = {},
        },
        [34842] = {
            [itemKeys.npcDrops] = {25342},
        },
        [34909] = {
            [itemKeys.npcDrops] = {},
        },
        [34972] = {
            [itemKeys.npcDrops] = {},
        },
        [35123] = {
            [itemKeys.npcDrops] = {},
        },
        [35126] = {
            [itemKeys.npcDrops] = {25841},
        },
        [35687] = {
            [itemKeys.objectDrops] = {188141},
        },
        [35701] = {
            [itemKeys.npcDrops] = {26219},
        },
        [35802] = {
            [itemKeys.npcDrops] = {},
        },
        [35803] = {
            [itemKeys.npcDrops] = {26503},
        },
        [36727] = {
            [itemKeys.npcDrops] = {},
        },
        [36733] = {
            [itemKeys.objectDrops] = {188539},
        },
        [36852] = {
            [itemKeys.npcDrops] = {},
        },
        [37359] = {
            [itemKeys.npcDrops] = {},
        },
        [37501] = {
            [itemKeys.objectDrops] = {189290},
        },
        [38326] = {
            [itemKeys.npcDrops] = {},
        },
        [38631] = {
            [itemKeys.objectDrops] = {190557,191746,191747,191748,},
        },
        [39160] = {
            [itemKeys.npcDrops] = {},
        },
        [40731] = {
            [itemKeys.npcDrops] = {},
        },
    }

function SkuDB:WotLKFixItemDB(aTargetTable)
    SkuDB:FixItemDB(aTargetTable)
    for i, v in pairs(SkuItemFixes) do
        local tNew = false
        for k, val in pairs(v) do
            if aTargetTable.itemDataTBC[i] then
                aTargetTable.itemDataTBC[i][k] = val
            else
                aTargetTable.itemDataTBC[i] = v
                tNew = true
            end
        end
        if tNew == true then
            aTargetTable.itemLookup["deDE"][i] = aTargetTable.itemDataTBC[i][itemKeys.name]
            aTargetTable.itemLookup["enUS"][i] = aTargetTable.itemDataTBC[i][itemKeys.name]
        end

    end
end
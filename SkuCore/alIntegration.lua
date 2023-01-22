local MODULE_NAME, MODULE_PART = "SkuCore", "alIntegration"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

--SkuCore.alIntegration = {}

local tExpansions = {
   [1] = "Classic",
   [2] = "Burning Crusade",
   [3] = "Wrath",
}

local tItemDropTable = nil
local tItemNameTable = nil

---------------------------------------------------------------------------------------------------------------------------------------
local DIFFICULTY
if AtlasLoot then
   DIFFICULTY = AtlasLoot.DIFFICULTY
end
local function BuildSource(ini, boss, typ, item, diffID)
   --print("BuildSource(", ini, boss, typ, item, diffID)
   if typ and typ > 3 then
       -- Profession
       local src = ""
       --RECIPE_ICON
       if Sources.db.showRecipeSource then
           local recipe = Recipe.GetRecipeForSpell(item)
           local sourceData
           for i = #SOURCE_DATA, 1, -1 do
               if recipe and SOURCE_DATA[i].ItemData[recipe] then
                   sourceData = SOURCE_DATA[i]
               end
           end
           if recipe and sourceData then
               if type(sourceData.ItemData[item]) == "number" then
                   sourceData.ItemData[item] = sourceData.ItemData[sourceData.ItemData[item]]
               end

               local data = sourceData.ItemData[recipe]
               if type(data[1]) == "table" then
                   for i = 1, #data do
                       src = src..format(TT_F, RECIPE_ICON, BuildSource(sourceData.AtlasLootIDs[data[i][1]],data[i][2],data[i][3],data[i][4] or item))..(i==#data and "" or "\n")
                   end
               else
                   src = src..format(TT_F, RECIPE_ICON, BuildSource(sourceData.AtlasLootIDs[data[1]],data[2],data[3],data[4] or item))
               end
           end
       end
       if Sources.db.showProfRank then
           local prof = Profession.GetProfessionData(item)
           if prof and prof[3] > 1 then
               return SOURCE_TYPES[typ].." ("..prof[3]..")"..(src ~= "" and "\n"..src or src)
           else
               return SOURCE_TYPES[typ]..(src ~= "" and "\n"..src or src)
           end
       else
           return SOURCE_TYPES[typ]..src
       end
   end
   if ini then
      local iniName, bossName = AtlasLoot.ItemDB:GetNameData_UNSAFE("AtlasLootClassic_DungeonsAndRaids", ini, boss)
      --print("iniName, bossName", iniName, bossName)

      local npcID = AtlasLoot.ItemDB:GetNpcID_UNSAFE("AtlasLootClassic_DungeonsAndRaids", ini, boss)
      if type(npcID) == "table" then npcID = npcID[1] end
      local dropRate = AtlasLoot.Data.Droprate:GetData(npcID, item)
      if bossName and diffID then
           -- diff 0 means just heroic
           if diffID == 0 then
               bossName = bossName.." ("..L["heroic"]..")"
           elseif type(diffID) == "table" then
               local diffString
               for i = 1, #diffID do
                   diffString = i>1 and (diffString.." / "..DIFFICULTY[diffID[i]].sourceLoc) or (DIFFICULTY[diffID[i]].sourceLoc)
               end
               if diffString then
                   bossName = bossName.." ("..diffString..")"
               end
           else
               if DIFFICULTY[diffID] and DIFFICULTY[diffID].sourceLoc then
                  bossName = bossName.." ("..DIFFICULTY[diffID].sourceLoc..")"
               else
                  bossName = bossName
               end
           end
       end
       if iniName and bossName then
           if dropRate then
               return iniName.." - "..bossName.." ("..dropRate.."%)"
           else
               return iniName.." - "..bossName
           end
       elseif iniName then
           if dropRate then
               return iniName.." ("..dropRate.."%)"
           else
               return iniName
           end
       end
   end
   return ""
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:alIntegrationItemMenuBuilder(aParent, aType, aId, aNpcId, aInternalDungeonName, aBossIndex, aTypeId, aDiffId)
   --print("SkuCore:alIntegrationItemMenuBuilder(",aParent, aType, aId, aNpcId, aInternalDungeonName, aBossIndex, aTypeId, aDiffId)
   if not aId then
      return
   end

   if aType == "set" then
      if not AtlasLoot.Data.ItemSet.GetSetName(aId) then
         return
      end
      --print("7)", "        ", "set", aId, AtlasLoot.Data.ItemSet.GetSetName(aId))
      local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["Set"].." "..AtlasLoot.Data.ItemSet.GetSetName(aId)}, SkuGenericMenuItem)
      tNewSubMenuEntry.dynamic = true
      tNewSubMenuEntry.filterable = true
      tNewSubMenuEntry.OnEnter = function(self, aValue, aName, aEnterFlag)
         local tTextFirstLine = SkuChat:Unescape(AtlasLoot.Data.ItemSet.GetSetName(aId))
         local tString = AtlasLoot.Data.ItemSet.GetSetBonusString(aId)
         if type(tString) == "boolean" then
            C_Timer.After(0.1, function()
               tString = AtlasLoot.Data.ItemSet.GetSetBonusString(aId)
               local textFull = tTextFirstLine.."\r\n"..SkuChat:Unescape((AtlasLoot.Data.ItemSet.GetSetDescriptionString(aId).."\r\n" or ""))..SkuChat:Unescape((AtlasLoot.Data.ItemSet.GetSetBonusString(aId) or ""))
               textFull = string.gsub(textFull, "iLvlAvg", L["iLvlAvg"])
               SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = tTextFirstLine, textFull
            end)
         end
         local textFull = tTextFirstLine.."\r\n"..SkuChat:Unescape((AtlasLoot.Data.ItemSet.GetSetDescriptionString(aId).."\r\n" or ""))..SkuChat:Unescape((AtlasLoot.Data.ItemSet.GetSetBonusString(aId) or ""))
         textFull = string.gsub(textFull, "iLvlAvg", L["iLvlAvg"])
         SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = tTextFirstLine, textFull
      end
      tNewSubMenuEntry.BuildChildren = function(self)
         --[[
         --button.Items = AtlasLoot.Data.ItemSet.GetSetItems(button.SetID)
         --button.ExtraFrameData = AtlasLoot.Data.ItemSet.GetSetDataForExtraFrame(button.SetID)
         local tExtraFrameData = AtlasLoot.Data.ItemSet.GetSetDataForExtraFrame(aId) --is item list table
         print("tExtraFrameData", tExtraFrameData)
         if tExtraFrameData then
            for i, v in pairs(AtlasLoot.Data.ItemSet.GetSetItems(aId)) do
               print("tExtraFrameData --------", i, v)
               SkuCore:alIntegrationItemMenuBuilder(self, "item", v)
            end
         end
         ]]
         for i, v in pairs(AtlasLoot.Data.ItemSet.GetSetItems(aId)) do
            SkuCore:alIntegrationItemMenuBuilder(self, "item", v)
         end
      end

   elseif aType == "item" then
      if not C_Item.GetItemNameByID(aId) then
         return
      end
      --print("7)", "        ", "item", SkuChat:Unescape(C_Item.GetItemNameByID(aId)))
      local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {SkuChat:Unescape(C_Item.GetItemNameByID(aId))}, SkuGenericMenuItem)
      tNewSubMenuEntry.OnEnter = function(self, aValue, aName, aEnterFlag)
         SkuCore:getItemComparisnSections(aId)
         C_Timer.After(0.1, function()
            local tSections = SkuCore:getItemComparisnSections(aId) or {}
            if tSections[1] then
               tSections[1] = L["currently equipped"].."\r\n"..tSections[1]
            end

            local tDropText = L["Dropped by"].."\r\n"
            if tItemDropTable[aId] then
               for iDrop, vDrop in pairs(tItemDropTable[aId]) do
                  tDropText = tDropText..vDrop.."\r\n"
               end
            end
            table.insert(tSections, 1, tDropText)

            if aNpcId then
               local Droprate = AtlasLoot.Data.Droprate:GetData(aNpcId, aId)
               if Droprate then
                  --print(aId, tTextFirstLine, aNpcId, Droprate)
                  table.insert(tSections, 1, L["Droprate"]..": "..Droprate.."%")
               end
            end

            local tTextFirstLine, tTextFull = "", ""
            _G["SkuScanningTooltip"]:ClearLines()
            _G["SkuScanningTooltip"]:SetItemByID(aId)
            if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
               if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
                  local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
                  tTextFirstLine, tTextFull = SkuCore:ItemName_helper(tText)
               end
            end

            table.insert(tSections, 1, tTextFull)
            

            SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = tTextFirstLine, tSections
         end)
      end
      
   elseif aType == "spell" then
      local tName = GetSpellInfo(aId)
      if tName then
         --print("7)", "        ", "spell", aId, tName)
         local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {SkuChat:Unescape(tName)}, SkuGenericMenuItem)
         tNewSubMenuEntry.OnEnter = function(self, aValue, aName, aEnterFlag)
            _G["SkuScanningTooltip"]:SetSpellByID(aId)

            C_Timer.After(0.1, function()
               local tSections = {}
      
               local tDropText = L["Dropped by"].."\r\n"
               if tItemDropTable[aId] then
                  for iDrop, vDrop in pairs(tItemDropTable[aId]) do
                     tDropText = tDropText..vDrop.."\r\n"
                  end
               end
               table.insert(tSections, 1, tDropText)
      
               if aNpcId then
                  local Droprate = AtlasLoot.Data.Droprate:GetData(aNpcId, aId)
                  if Droprate then
                     --print(aId, tTextFirstLine, aNpcId, Droprate)
                     table.insert(tSections, 1, L["Droprate"]..": "..Droprate.."%")
                  end
               end
      
               local tTextFirstLine, tTextFull = "", ""
               _G["SkuScanningTooltip"]:ClearLines()
               _G["SkuScanningTooltip"]:SetSpellByID(aId)
               if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
                  if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
                     local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
                     tTextFirstLine, tTextFull = SkuCore:ItemName_helper(tText)
                  end
               end
      
               table.insert(tSections, 1, tTextFull)
               
      
               SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = tTextFirstLine, tSections
            end)
         end         
         

      end

   elseif aType == "collection" then
      --print("7)", "        ", "coll", aId)
      --local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {aId}, SkuGenericMenuItem)

   elseif aType == "ac" then
      --print("7)", "        ", "ac", aId)
      --local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {aId}, SkuGenericMenuItem)

   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:alIntegrationMenuBuilder()
   if not AtlasLoot then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["AtlasLoot addon missing"]}, SkuGenericMenuItem)
   end

   if tItemDropTable == nil then
      SkuCore:alIntegrationQueryAll()
   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Search"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      for i, v in pairs(tItemNameTable) do
         SkuCore:alIntegrationItemMenuBuilder(self, "item", v.itemID, v.npcId, v.internalName, v.bossIndex, nil, v.difficultyIndex)
      end
   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Lists"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)
      --modules
      local tModules = AtlasLoot.Loader:GetLootModuleList()
      for pluginIndex = 1, #tModules.module do
         --print("1)", pluginIndex, tModules.module[pluginIndex].tt_title, tModules.module[pluginIndex].addonName, tModules.module[pluginIndex].name, tModules.module[pluginIndex].tt_text)
         if AtlasLoot.Loader:IsModuleLoaded(tModules.module[pluginIndex].addonName) == false then
            --print("2)", "loader", AtlasLoot.Loader:LoadModule(tModules.module[pluginIndex].addonName, LoadAtlasLootModule, LOADER_STRING))
         end
         local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {tModules.module[pluginIndex].tt_title}, SkuGenericMenuItem)
         tNewSubMenuEntry.dynamic = true
         tNewSubMenuEntry.filterable = true
         tNewSubMenuEntry.BuildChildren = function(self)
            --expansions
            for selectedGameVersion = 1, #tExpansions do
               local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {tExpansions[selectedGameVersion]}, SkuGenericMenuItem)
               tNewSubMenuEntry.dynamic = true
               tNewSubMenuEntry.filterable = true
               tNewSubMenuEntry.BuildChildren = function(self)
                  --cats
                  local tModulList = AtlasLoot.ItemDB:GetModuleList(tModules.module[pluginIndex].addonName)
                  local moduleData = AtlasLoot.ItemDB:Get(tModules.module[pluginIndex].addonName)
                  local contentTypes = moduleData:GetContentTypes()
                  local tDifficulties = moduleData:GetDifficultys()
                  for moduleIndex = 1, #tModulList do
                     local contentInteralName = tModulList[moduleIndex]
                     if moduleData[contentInteralName].gameVersion == selectedGameVersion or moduleData[contentInteralName].gameVersion == 0 then
                        local contentTypeName, contentIndex = moduleData[contentInteralName]:GetContentType()
                        local name		= moduleData[contentInteralName]:GetName()
                        local tt_title	= moduleData[contentInteralName]:GetName()
                        local tt_text		= moduleData[contentInteralName]:GetInfo()
            
                        --print("3)", "  ", moduleIndex, tDifficulties, contentTypeName, contentIndex, contentInteralName, name, tt_title, tt_text)
                        local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {SkuChat:Unescape(moduleData[contentInteralName]:GetName())}, SkuGenericMenuItem)
                        tNewSubMenuEntry.dynamic = true
                        tNewSubMenuEntry.filterable = true
                        tNewSubMenuEntry.BuildChildren = function(self)
                           --bosses
                           for bossIndex = 1, #moduleData[contentInteralName].items do
                              local tabVal = moduleData[contentInteralName].items[bossIndex]
                              if tabVal then
                                 local name
                                 local coinTexture
                                 local tt_title
                                 local tt_text
                                 
                                 if tabVal.ExtraList then
                                    name = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                                    coinTexture = tabVal.CoinTexture
                                    tt_title = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                                    tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
                                 else
                                    name = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                                    coinTexture = tabVal.CoinTexture
                                    tt_title = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                                    tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
                                 end

                                 --print("4)", "   ", bossIndex, tabVal.ExtraList, moduleData[contentInteralName].__numDiffEntrys, name, coinTexture, tt_title, tt_text)
                                 local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {SkuChat:Unescape(moduleData[contentInteralName]:GetNameForItemTable(bossIndex))}, SkuGenericMenuItem)
                                 tNewSubMenuEntry.dynamic = true
                                 tNewSubMenuEntry.filterable = true
                                 tNewSubMenuEntry.BuildChildren = function(self)
                                    local bossData = moduleData[contentInteralName].items[bossIndex]
                                    for difficultyIndex = 1, #tDifficulties do
                                       if bossData[difficultyIndex] then
                                          local name = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name
                                          local tt_title = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name
                  
                                          --print("5)", "    ", difficultyIndex, name, tt_title, moduleData:GetDifficulty(contentInteralName, bossIndex, difficultyIndex))
                                          local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {SkuChat:Unescape(bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name)}, SkuGenericMenuItem)
                                          tNewSubMenuEntry.dynamic = true
                                          tNewSubMenuEntry.filterable = true
                                          tNewSubMenuEntry.BuildChildren = function(self)
                                             --local bossData = AtlasLoot.ItemDB:GetBossTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex)
                                             local items, tableType, diffData = AtlasLoot.ItemDB:GetItemTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex, difficultyIndex)
                                             if items then
                                                --print("6)", "      ", type(items), #items, items, "--", tableType, "--", diffData, #diffData)
                                                for itemIndex = 1, #items do
                                                   if type(items[itemIndex][2]) == "number" then
                                                      
                                                      --local tSkuName = ""
                                                      --if SkuDB.itemDataTBC[items[itemIndex][2]] then
                                                         --tSkuName = SkuDB.itemDataTBC[items[itemIndex][2]][1]
                                                      --end
                                                      
                                                      if AtlasLoot.Data.ItemSet.GetSetName(items[itemIndex][2]) then
                                                         --print("7)", "        ", "set", items[itemIndex][2], AtlasLoot.Data.ItemSet.GetSetName(items[itemIndex][2]))
                                                         SkuCore:alIntegrationItemMenuBuilder(self, "set", items[itemIndex][2])

                                                      elseif (C_Item.GetItemNameByID(items[itemIndex][2])) and AtlasLoot.Data.Profession.IsProfessionSpell(items[itemIndex][2]) ~= true then
                                                      --elseif C_Item.GetItemNameByID(items[itemIndex][2]) then
                                                            --print("7)", "        ", "item", SkuChat:Unescape(items[itemIndex][1]), SkuChat:Unescape(items[itemIndex][2]), SkuChat:Unescape(C_Item.GetItemNameByID(items[itemIndex][2])), tSkuName)

                                                                                                --aParent, aType, aId,                aNpcId,       aDungeonName,     aBossIndex, aTypeId, aDiffId
                                                            SkuCore:alIntegrationItemMenuBuilder(self, "item", items[itemIndex][2], tabVal.npcID, contentInteralName, bossIndex, nil, difficultyIndex)
                                                      else
                                                         local tName = GetSpellInfo(items[itemIndex][2])
                                                         --print("7)", "        ", "spell", items[itemIndex][2], tName)
                                                         if tName then
                                                            SkuCore:alIntegrationItemMenuBuilder(self, "spell", items[itemIndex][2])
                                                         end
                                                      end
                        
                                                      if SkuDB.itemDataTBC[items[itemIndex][2]] then
                                                         --print("8)", "          ", SkuChat:Unescape(SkuDB.itemDataTBC[items[itemIndex][2]][1]))
                                                      end
                                                      if items[itemIndex][2] > 1000000 then
                                                         local tSetId = tostring(items[itemIndex][2])
                                                         tSetId = string.sub(tSetId, 5)
                                                         tSetId = tonumber(tSetId)
                                                         --print("9)", "          ", "set", tSetId, AtlasLoot.Data.ItemSet.GetSetName(tSetId))
                                                         SkuCore:alIntegrationItemMenuBuilder(self, "set", tSetId)
                                                      end
                                                   else
                                                      --print("7)", "        ", "coll", items[itemIndex][2], tName)
                                                      SkuCore:alIntegrationItemMenuBuilder(self, "collection", items[itemIndex][2])
                                                   end
                                                end
                                             else
                                                local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
                                             end
                                          end
                                       end
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            end
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function addToItemsRepos(aItemId, aNpcID, aContentInteralName, aBossIndex, aType, aDifficultyIndex)
   local tSourceText = BuildSource(aContentInteralName, aBossIndex, nil, aItemId, aDifficultyIndex)      
   if tSourceText and tSourceText ~= "" then
      tItemDropTable[aItemId] = tItemDropTable[aItemId] or {}
      tItemDropTable[aItemId][#tItemDropTable[aItemId] + 1] = tSourceText
   end

   --tItemNameTable
   local tName = C_Item.GetItemNameByID(aItemId)
   if tName and tName  ~= "" then
      tItemNameTable[tName] = {itemID = aItemId, npcId = aNnpcID, internalName = aContentInteralName, bossIndex = aBossIndex, ttype = nil, difficultyIndex = aDifficultyIndex}
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:alIntegrationQueryAll()
   if not AtlasLoot then
      return
   end

   tItemDropTable = tItemDropTable or {}
   tItemNameTable = tItemNameTable or {}

   --plugins
   local tModules = AtlasLoot.Loader:GetLootModuleList()
   for pluginIndex = 1, #tModules.module do
      --print("1)", pluginIndex, tModules.module[pluginIndex].tt_title, tModules.module[pluginIndex].addonName, tModules.module[pluginIndex].name, tModules.module[pluginIndex].tt_text)

      if AtlasLoot.Loader:IsModuleLoaded(tModules.module[pluginIndex].addonName) == false then
         --print("2)", "loader", AtlasLoot.Loader:LoadModule(tModules.module[pluginIndex].addonName, LoadAtlasLootModule, LOADER_STRING))
         AtlasLoot.Loader:LoadModule(tModules.module[pluginIndex].addonName, LoadAtlasLootModule, LOADER_STRING)
      end

      --if tModules.module[pluginIndex].addonName == "AtlasLootClassic_Collections" then

         local tModulList = AtlasLoot.ItemDB:GetModuleList(tModules.module[pluginIndex].addonName)
         local moduleData = AtlasLoot.ItemDB:Get(tModules.module[pluginIndex].addonName)
         local contentTypes = moduleData:GetContentTypes()
         local tDifficulties = moduleData:GetDifficultys()

         --expansions
         for selectedGameVersion = 1, #tExpansions do
            --if selectedGameVersion == 2 then

            --cats
            for moduleIndex = 1, #tModulList do
               local contentInteralName = tModulList[moduleIndex]
               if moduleData[contentInteralName].gameVersion == selectedGameVersion or moduleData[contentInteralName].gameVersion == 0 then
                  local contentTypeName, contentIndex = moduleData[contentInteralName]:GetContentType()
                  local name		= moduleData[contentInteralName]:GetName()
                  local tt_title	= moduleData[contentInteralName]:GetName()
                  local tt_text		= moduleData[contentInteralName]:GetInfo()
                  --print("3)", "  ", moduleIndex, tDifficulties, contentTypeName, contentIndex, contentInteralName, name, tt_title, tt_text)

                  --bosses
                  for bossIndex = 1, #moduleData[contentInteralName].items do
                     local tabVal = moduleData[contentInteralName].items[bossIndex]
                     if tabVal then
                        local name
                        local coinTexture
                        local tt_title
                        local tt_text
                        --moduleData:CheckForLink(contentInteralName, i)
                        
                        if tabVal.ExtraList then
                           name = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                           coinTexture = tabVal.CoinTexture
                           tt_title = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                           tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
                        else
                           name = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                           coinTexture = tabVal.CoinTexture
                           tt_title = moduleData[contentInteralName]:GetNameForItemTable(bossIndex)
                           tt_text = tabVal.info-- or AtlasLoot.EncounterJournal:GetBossInfo(tabVal.EncounterJournalID)
                        end

                        --local tprint = false
                        --if name == "Flasks" then
                           --tprint = true
                           --print("4)", "   ", bossIndex, tabVal.ExtraList, moduleData[contentInteralName].__numDiffEntrys, name, coinTexture, tt_title, tt_text)
                        --end

                        local bossData = moduleData[contentInteralName].items[bossIndex]
                        for difficultyIndex = 1, #tDifficulties do
                           if bossData[difficultyIndex] then
                              local name = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name
                              local tt_title = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name
                              --print("5)", "    ", difficultyIndex, name, tt_title, moduleData:GetDifficulty(contentInteralName, bossIndex, difficultyIndex))

                              local page = 0 -- Page number for first items on a page are <1, 101, 201, 301, 401, ...>
                              local bossData = AtlasLoot.ItemDB:GetBossTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex)
                              local items, tableType, diffData = AtlasLoot.ItemDB:GetItemTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex, difficultyIndex)
                              if items then
                                 --if tprint == true then
                                    --print("6)", "      ", type(items), #items, items, "--", tableType, "--", diffData, #diffData)
                                 --end

                                 for itemIndex = 1, #items do

                                    --if tprint == true then
                                       --print("7 0)", "        ", AtlasLoot.Data.Profession.IsProfessionSpell(items[itemIndex][2]))
                                    --end
                                       

                                    if type(items[itemIndex][2]) == "number" then
                                       local tSkuName = ""
                                       if SkuDB.itemDataTBC[items[itemIndex][2]] then
                                          tSkuName = SkuDB.itemDataTBC[items[itemIndex][2]][1]
                                       end
                                       
                                       if AtlasLoot.Data.ItemSet.GetSetName(items[itemIndex][2]) then
                                          --print("7)", "        ", "set", items[itemIndex][2], AtlasLoot.Data.ItemSet.GetSetName(items[itemIndex][2]))
                                          for i, v in pairs(AtlasLoot.Data.ItemSet.GetSetItems(items[itemIndex][2])) do
                                             addToItemsRepos(v, tabVal.npcID, contentInteralName, bossIndex, nil, difficultyIndex)


                                          end
                                       elseif (C_Item.GetItemNameByID(items[itemIndex][2]) or tSkuName ~= "") and AtlasLoot.Data.Profession.IsProfessionSpell(items[itemIndex][2]) ~= true then
                                          --if tprint == true then
                                             --print("7)", "        ", "item", SkuChat:Unescape(items[itemIndex][1]), SkuChat:Unescape(items[itemIndex][2]), SkuChat:Unescape(C_Item.GetItemNameByID(items[itemIndex][2])), tSkuName)
                                          --end
                                          addToItemsRepos(items[itemIndex][2], tabVal.npcID, contentInteralName, bossIndex, nil, difficultyIndex)



                                 
                                       else
                                          local tName = GetSpellInfo(items[itemIndex][2])
                                          --if tprint == true then
                                             --print("7)", "        ", "spell", items[itemIndex][2], tName)
                                          --end
                                       end
         
                                       --if SkuDB.itemDataTBC[items[itemIndex][2]] then
                                          --print("8)", "          ", SkuChat:Unescape(SkuDB.itemDataTBC[items[itemIndex][2]][1]))
                                       --end
                                       if items[itemIndex][2] > 1000000 then
                                          local tSetId = tostring(items[itemIndex][2])
                                          tSetId = string.sub(tSetId, 5)
                                          tSetId = tonumber(tSetId)
                                          --print("9)", "          ", "set", tSetId, AtlasLoot.Data.ItemSet.GetSetName(tSetId))
                                          for i, v in pairs(AtlasLoot.Data.ItemSet.GetSetItems(tSetId)) do
                                             addToItemsRepos(v, tabVal.npcID, contentInteralName, bossIndex, nil, difficultyIndex)



                                          end                                       
                                       end
                                    else
                                       --print("7)", "        ", "coll", items[itemIndex][2], tName)
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            end
         end
      --end
      --end
   end
end
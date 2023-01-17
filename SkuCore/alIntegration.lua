local MODULE_NAME, MODULE_PART = "SkuCore", "alIntegration"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.alIntegration = {}
SkuCore.alIntegration.selectedGameVersion = 3

function SkuCore:alIntegrationTest()
   if not AtlasLoot then
      return
   end

   --plugins
   local tModules = AtlasLoot.Loader:GetLootModuleList()
   for pluginIndex = 1, #tModules.module do
      print(pluginIndex,
      tModules.module[pluginIndex].tt_title,
      tModules.module[pluginIndex].addonName,
      tModules.module[pluginIndex].name,
      tModules.module[pluginIndex].tt_text
      )

      if AtlasLoot.Loader:IsModuleLoaded(tModules.module[pluginIndex].addonName) == false then
         print(" loader", AtlasLoot.Loader:LoadModule(tModules.module[pluginIndex].addonName, LoadAtlasLootModule, LOADER_STRING))
      end

      local tModulList = AtlasLoot.ItemDB:GetModuleList(tModules.module[pluginIndex].addonName)
      local moduleData = AtlasLoot.ItemDB:Get(tModules.module[pluginIndex].addonName)
      local contentTypes = moduleData:GetContentTypes()
      local tDifficulties = moduleData:GetDifficultys()

      --cats
      for moduleIndex = 1, #tModulList do
         local contentInteralName = tModulList[moduleIndex]
         if moduleData[contentInteralName].gameVersion == SkuCore.alIntegration.selectedGameVersion or moduleData[contentInteralName].gameVersion == 0 then
   			local contentTypeName, contentIndex = moduleData[contentInteralName]:GetContentType()

            local name		= moduleData[contentInteralName]:GetName()
				local tt_title	= moduleData[contentInteralName]:GetName()
				local tt_text		= moduleData[contentInteralName]:GetInfo()

            print("  ", moduleIndex, tDifficulties, contentTypeName, contentIndex, contentInteralName, name, tt_title, tt_text)

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
         

                  print("      ", i, tabVal.ExtraList, moduleData[contentInteralName].__numDiffEntrys, name, coinTexture, tt_title, tt_text)

                  local bossData = moduleData[contentInteralName].items[bossIndex]
                  for difficultyIndex = 1, #tDifficulties do
                     if bossData[difficultyIndex] then
                        local name = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name
                        local tt_title = bossData[difficultyIndex].diffName or tDifficulties[difficultyIndex].name

                        print("          ", difficultyIndex, name, tt_title, moduleData:GetDifficulty(contentInteralName, bossIndex, difficultyIndex))




                        local page = 0 -- Page number for first items on a page are <1, 101, 201, 301, 401, ...>
                        local bossData = AtlasLoot.ItemDB:GetBossTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex)
                        local items, tableType, diffData = AtlasLoot.ItemDB:GetItemTable(tModules.module[pluginIndex].addonName, contentInteralName, bossIndex, difficultyIndex)
                        if items then
                           print("             ", type(items), #items, items, tableType, diffData)
                     		for itemIndex = 1, #items do
                              print("                   ", items[itemIndex][1], items[itemIndex][2], C_Item.GetItemNameByID(items[itemIndex][2]))
                              if SkuDB.itemDataTBC[items[itemIndex][2]] then
                                 print("                       ", SkuDB.itemDataTBC[items[itemIndex][2]][1])
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
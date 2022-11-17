---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "Achievements"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsOnClose()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsOnOpen()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsOnInitialize()
   --[[
   todo: open menu on showing frame
   --SkuCore:RegisterEvent("")
   hooksecurefunc(_G["AchievementFrame"], "Show", SkuCore.AchievementsOnOpen)
   hooksecurefunc(_G["AchievementFrame"], "Hide", SkuCore.AchievementsOnClose)
   ]]
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsOnLogin()

end

---------------------------------------------------------------------------------------------------------------------------------------
local function AchievementsCleanupQuantityString(aString)
   aString = string.gsub(aString, "|TInterface\\MoneyFrame\\UI%-GoldIcon:0:0:2:0|t", " "..L["Gold"])
   aString = string.gsub(aString, "|TInterface\\MoneyFrame\\UI%-SilverIcon:0:0:2:0|t", " "..L["Silver"])
   aString = string.gsub(aString, "|TInterface\\MoneyFrame\\UI%-CopperIcon:0:0:2:0|t", " "..L["Copper"])
   return aString
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsInsertAchievement(aParent, aCatId, aAvmtId)
   local id, name, points, achievementcompleted, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(aCatId, aAvmtId)
   flags = flags or 0
   if id then
      local numCriteria = GetAchievementNumCriteria(id)
      local tCriteriaString = name.."\r\n"..AchievementsCleanupQuantityString(rewardText).."\r\n"..description
      for y = 1, numCriteria do
         local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(id, y, true)
         local tCompletedString = ""--"-"..tostring(quantityString).."-"
         if completed == true then
            tCompletedString = " "..L["Completed"]
         else
            if quantityString ~= "0" and quantityString ~= "1" then
               tCompletedString = ", "..L["Progress"]..": "..quantityString
            end
         end            
         tCriteriaString = tCriteriaString.."\r\n"..criteriaString..AchievementsCleanupQuantityString(tCompletedString)
      end

      local tName = name
      if achievementcompleted == true then
         tName = tName.." ("..L["Completed"]..")"
      end
      local tNewMenuEntryAvmt = SkuOptions:InjectMenuItems(aParent, {tName}, SkuGenericMenuItem)
      tNewMenuEntryAvmt.OnEnter = function(self, aValue, aName)
         SkuOptions.currentMenuPosition.textFull = tCriteriaString
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsInsertStatistic(aParent, aCatId, aAvmtId)
   local id, name, points, achievementcompleted, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(aCatId, aAvmtId)
   flags = flags or 0
   if id then
      local value, skip, ids = GetStatistic(id)
      if value == "--" then
         value = L["NA"]
      end
      local tNewMenuEntryAvmt = SkuOptions:InjectMenuItems(aParent, {AchievementsCleanupQuantityString(name)..": "..AchievementsCleanupQuantityString(value)}, SkuGenericMenuItem)
      tNewMenuEntryAvmt.OnEnter = function(self, aValue, aName)
         SkuOptions.currentMenuPosition.textFull = tCriteriaString
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsAchievementsBuilder(aParent, aCatId, aCatListProvider)
   if aCatId == 0 then
      --summary
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {LATEST_UNLOCKED_ACHIEVEMENTS}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.BuildChildren = function(self)
         for i, avmtId in pairs({GetLatestCompletedAchievements()}) do
            if avmtId then
               local tCatId = GetAchievementCategory(avmtId)
               SkuCore:AchievementsInsertAchievement(self, tCatId, avmtId)
            end
         end
      end

      local numAchievements, numCompleted = GetNumCompletedAchievements()
      local tCatsStrings = ACHIEVEMENTS_COMPLETED.." "..numCompleted.."/"..numAchievements
      local tCatsList = SkuCore:AchievementsBuildCatsList(aCatListProvider)
      for id, data in pairs(tCatsList) do
         if id ~= 0 then
            local total, completed, incompleted = GetCategoryNumAchievements(id, true)
            tCatsStrings = tCatsStrings.."\r\n"..data.name.." "..completed.."/"..total
         end
      end
      local tNewMenuEntrySub = SkuOptions:InjectMenuItems(aParent, {ACHIEVEMENTS_COMPLETED.." "..numCompleted.."/"..numAchievements}, SkuGenericMenuItem)
      tNewMenuEntrySub.OnEnter = function(self, aValue, aName)
         SkuOptions.currentMenuPosition.textFull = tCatsStrings
      end      
   else
      --regular cat
      local total, completed, incompleted = GetCategoryNumAchievements(aCatId, true)
      for x = 1, total do
         SkuCore:AchievementsInsertAchievement(aParent, aCatId, x)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsStatisticsBuilder(aParent, aCatId, aCatListProvider)
   if aCatId == 0 then
      --summary
      --[[
         todo: add list of all stats from all cats
      ]]    
   else
      --regular cat
      local total, completed, incompleted = GetCategoryNumAchievements(aCatId, true)
      for x = 1, total do
         SkuCore:AchievementsInsertStatistic(aParent, aCatId, x)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsBuildCatsList(aCatListProvider)
   local tCatsList = {[0] = {name = L["Summary"], childCats = {}, childAchievements = {},}}

   for i, v in pairs(aCatListProvider) do
      local title, parentCategoryID, flags = GetCategoryInfo(v)
      if parentCategoryID <= 0 then
         tCatsList[v] = {name = title, childCats = {}, childAchievements = {},}
      end
   end
   
   for i, v in pairs(aCatListProvider) do
      local title, parentCategoryID, flags = GetCategoryInfo(v)
      if parentCategoryID >= 0 then
         tCatsList[parentCategoryID].childCats[v] = tCatsList[parentCategoryID].childCats[v] or {name = title, childCats = {}, childAchievements = {},}
      end
   end

   return tCatsList
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AchievementsMenuBuilder()
   local tCatsList = SkuCore:AchievementsBuildCatsList(GetCategoryList())
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Achievements"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)
      for id, data in pairs(tCatsList) do
         local total, completed, incompleted = GetCategoryNumAchievements(id, true)
         local tNumString = " ("..completed.."/"..total..")"
         if not total or total == 0 then
            tNumString = ""
         end
         local tNewMenuEntryCat = SkuOptions:InjectMenuItems(self, {data.name..tNumString}, SkuGenericMenuItem)
         tNewMenuEntryCat.dynamic = true
         tNewMenuEntryCat.filterable = true
         tNewMenuEntryCat.BuildChildren = function(self)
            SkuCore:AchievementsAchievementsBuilder(self, id, GetCategoryList())
            for catid, catdata in pairs(data.childCats) do
               local total, completed, incompleted = GetCategoryNumAchievements(catid, true)
               local tNumString = " ("..completed.."/"..total..")"
               if not total or total == 0 then
                  tNumString = ""
               end               
               local tNewMenuEntryCatSub = SkuOptions:InjectMenuItems(self, {catdata.name..tNumString}, SkuGenericMenuItem)
               tNewMenuEntryCatSub.dynamic = true
               tNewMenuEntryCatSub.filterable = true
               tNewMenuEntryCatSub.BuildChildren = function(self)
                  SkuCore:AchievementsAchievementsBuilder(self, catid, GetCategoryList())
               end
            end
         end
      end
   end

   local tCatsList = SkuCore:AchievementsBuildCatsList(GetStatisticsCategoryList())
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Statistics"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)
      for id, data in pairs(tCatsList) do
         local tNewMenuEntryCat = SkuOptions:InjectMenuItems(self, {data.name}, SkuGenericMenuItem)
         tNewMenuEntryCat.dynamic = true
         tNewMenuEntryCat.filterable = true
         tNewMenuEntryCat.BuildChildren = function(self)
            SkuCore:AchievementsStatisticsBuilder(self, id, GetStatisticsCategoryList())
            for catid, catdata in pairs(data.childCats) do
               local tNewMenuEntryCatSub = SkuOptions:InjectMenuItems(self, {catdata.name}, SkuGenericMenuItem)
               tNewMenuEntryCatSub.dynamic = true
               tNewMenuEntryCatSub.filterable = true
               tNewMenuEntryCatSub.BuildChildren = function(self)
                  SkuCore:AchievementsStatisticsBuilder(self, catid, GetStatisticsCategoryList())
               end
            end
         end
      end
   end
end
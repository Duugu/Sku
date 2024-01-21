local MODULE_NAME, MODULE_PART = "SkuCore", "Heirlooms"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:HeirloomsMenuBuilder()
   local tHasEntries = false

   local tNumHLs = C_Heirloom.GetNumHeirlooms()
   local tHlItemIDs = C_Heirloom.GetHeirloomItemIDs()
   local tItems = {}

   for x = 1, tNumHLs do
      if C_Heirloom.PlayerHasHeirloom(tHlItemIDs[x]) == true then
         local name, itemEquipLoc, isPvP, itemTexture, upgradeLevel, source, searchFiltered, effectiveLevel, minLevel, maxLevel = C_Heirloom.GetHeirloomInfo(tHlItemIDs[x])
         if itemEquipLoc then
            tItems[itemEquipLoc] = tItems[itemEquipLoc] or {}
            tItems[itemEquipLoc][tHlItemIDs[x]] = name
            tHasEntries = true
         end
      end
   end

   for iCat, vCat in pairs(tItems) do
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {_G[iCat]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)         
         for iItem, _ in pairs(vCat) do
            local itemName = GetItemInfo(iItem)
            local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {itemName}, SkuGenericMenuItem)
            tNewMenuParentEntrySubSub.OnEnter = function(self, aValue, aName)
               _G["SkuScanningTooltip"]:ClearLines()
               _G["SkuScanningTooltip"]:SetItemByID(iItem)
               if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
                  if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
                     local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
                     SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = SkuCore:ItemName_helper(tText)
                  end
               end
            end
            tNewMenuParentEntrySubSub.BuildChildren = function(self)         
               tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Create"]}, SkuGenericMenuItem)
               tNewMenuSubSubEntry.OnAction = function(self, aValue, aName)
                  C_Heirloom.CreateHeirloom(iItem)
                  C_Timer.After(0.001, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                  end)
               end
            end      

         end
      end
   end

   if tHasEntries == false then
      SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
   end
   

   return tNewMenuEntry
end

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "LocalMenu"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
-- helpers
---------------------------------------------------------------------------------------------------------------------------------------
local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}
local function unescape(str)
   if not str then return end
	for k, v in pairs(escapes) do
		str = string.gsub(str, k, v)
	end
	return str
end

local maxItemNameLength = 40
local function ItemName_helper(aText)
	aText = unescape(aText)
	local tShort, tLong = aText, ""

	local tStart, tEnd = string.find(tShort, "\r\n")
	local taTextWoLb = aText
	if tStart then
		taTextWoLb = string.sub(tShort, 1, tStart - 1)
		tLong = aText
	end

	if string.len(taTextWoLb) > maxItemNameLength then
		local tBlankPos = 1
		while (string.find(taTextWoLb, " ", tBlankPos + 1) and tBlankPos < maxItemNameLength) do
			tBlankPos = string.find(taTextWoLb, " ", tBlankPos + 1)
		end
		if tBlankPos > 1 then
			tShort = string.sub(taTextWoLb, 1, tBlankPos).."..."
		else
			tShort = string.sub(taTextWoLb, 1, maxItemNameLength).."..."
		end		
		tLong = aText
	else
		tShort = taTextWoLb
	end

	return string.gsub(tShort, "\r\n", " "), tLong
end

--[[
---------------------------------------------------------------------------------------------------------------------------------------
local function TooltipLines_helper(...)

   local tQualityString = nil

	local itemName, ItemLink = _G["SkuScanningTooltip"]:GetItem()
	if not ItemLink then
		itemName, ItemLink = GameTooltip:GetItem()
	end

	if ItemLink then
      for x = 0, #ITEM_QUALITY_COLORS do
         local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
         if tItemCol == "ffa334ee" then 
            tItemCol = "ffa335ee"
         end
         if string.find(ItemLink, tItemCol) then
            if _G["ITEM_QUALITY"..x.."_DESC"] then
               tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
            end
         end
      end
   end

	local rText = ""
   for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
            if i == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
               rText = rText..text.." ("..tQualityString..")\r\n"
            else
				   rText = rText..text.."\r\n"
            end
			end
		end
	end
	return rText
end
]]
---------------------------------------------------------------------------------------------------------------------------------------
local function GetButtonTooltipLines(aButtonObj)
   GameTooltip:ClearLines()
   if aButtonObj:GetScript("OnEnter") then
      aButtonObj:GetScript("OnEnter")(aButtonObj)
   end

   local tQualityString = nil
	local itemName, ItemLink = GameTooltip:GetItem()
	if ItemLink then
      for x = 0, #ITEM_QUALITY_COLORS do
         local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
         if tItemCol == "ffa334ee" then 
            tItemCol = "ffa335ee"
         end
         if string.find(ItemLink, tItemCol) then
            if _G["ITEM_QUALITY"..x.."_DESC"] then
               tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
            end
         end
      end
   end


	local tTooltipText = ""
   for i = 1, select("#", GameTooltip:GetRegions()) do
		local region = select(i, GameTooltip:GetRegions())
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
            if i == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
               tTooltipText = tTooltipText..text.." ("..tQualityString..")\r\n"
            else
				   tTooltipText = tTooltipText..text.."\r\n"
            end

			end
		end
	end

   GameTooltip:SetOwner(UIParent, "Center")
   GameTooltip:Hide()
   if aButtonObj:GetScript("OnLeave") then
      aButtonObj:GetScript("OnLeave")(aButtonObj)
   end
   
   if tTooltipText ~= "asd" then
      if tTooltipText ~= "" then
         tTooltipText = unescape(tTooltipText)
         if tTooltipText then
            local tText, tTextf = ItemName_helper(tTooltipText)
            return tText, tTextf
         end
      end
   end

   return "", ""
end

---------------------------------------------------------------------------------------------------------------------------------------
-- menu items
---------------------------------------------------------------------------------------------------------------------------------------

function SkuCore:Build_BagnonInventoryFrame(aParentChilds)

   if not BagnonInventoryFrame1.bagGroup then
      BagnonInventoryFrame1.bagToggle:Click()
   end

   local dtc = { BagnonInventoryFrame1.bagGroup:GetChildren() }
   if dtc[6] then
      if dtc[6]:GetChecked() == true then
         dtc[6]:Click(dtc[6])
      end
   end

   local tEmptyCounter = 1
   local tCurrentBag
   local tCurrentParentContainer = nil
   local tBagResults = {}

   for frameNo = 1, 8 do
      for itemNo = 1, 36 do
         local tFrameName = "ContainerFrame"..frameNo.."Item"..itemNo
         if _G[tFrameName] then
            if _G[tFrameName].GetBag then
               if _G[tFrameName].bag >= 0 then
                  local bagId = _G[tFrameName]:GetBag() + 1
                  local slotId = _G[tFrameName]:GetID()

                  if bagId > 0 then
                     tCurrentBag = bagId
                     if not tBagResults[bagId] then

                        local tFriendlyName = L["Bag"].." "..bagId
                        local tText, tFullText = L["Bag"].." "..bagId, ""
                        table.insert(aParentChilds, tFriendlyName)
                        aParentChilds[tFriendlyName] = {
                           frameName = tFrameName,
                           RoC = "Child",
                           type = "Button",
                           obj = _G[tFrameName],
                           textFirstLine = tFriendlyName,
                           textFull = "",
                           noMenuNumbers = true,
                           childs = {},
                        }   

                        tBagResults[bagId] = {obj = aParentChilds[tFriendlyName], childs = {}}
                     end
                  end

                  local tFriendlyName = L["Bag"]..bagId.."-"..slotId
                  local tText, tFullText = L["Empty"], ""
                  if _G[tFrameName]:IsEnabled() == true then
                     aParentChilds[tFriendlyName] = {
                        frameName = tFrameName,
                        RoC = "Child",
                        type = "Button",
                        obj = _G[tFrameName],
                        textFirstLine = tText,
                        textFull = "",
                        noMenuNumbers = true,
                        childs = {},
                     }   
                     --get the onclick func if there is one
                     if aParentChilds[tFriendlyName].obj:IsMouseClickEnabled() == true then
                        if aParentChilds[tFriendlyName].obj:GetObjectType() == "Button" then
                           aParentChilds[tFriendlyName].func = aParentChilds[tFriendlyName].obj:GetScript("OnClick")
                        end
                        aParentChilds[tFriendlyName].containerFrameName = tFrameName
                        aParentChilds[tFriendlyName].onActionFunc = function(self, aTable, aChildName)

                        end
                        if aParentChilds[tFriendlyName].func then
                           aParentChilds[tFriendlyName].click = true
                        end
                     end


                     _G["SkuScanningTooltip"]:ClearLines()
                     local hsd, rc = _G["SkuScanningTooltip"]:SetBagItem(aParentChilds[tFriendlyName].obj:GetParent():GetID(), aParentChilds[tFriendlyName].obj:GetID())
                     if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
                        if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
                           local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
                           
                           if aParentChilds[tFriendlyName].obj.info then
                              if aParentChilds[tFriendlyName].obj.info.id then
                                 aParentChilds[tFriendlyName].itemId = aParentChilds[tFriendlyName].obj.info.id
                                 aParentChilds[tFriendlyName].textFirstLine = ItemName_helper(tText)
                                 aParentChilds[tFriendlyName].textFull = SkuCore:AuctionPriceHistoryData(aParentChilds[tFriendlyName].obj.info.id, true, true)
                              end
                           end
                           if not aParentChilds[tFriendlyName].textFull then
                              aParentChilds[tFriendlyName].textFull = {}
                           end
                           local tFirst, tFull = ItemName_helper(tText)
                           aParentChilds[tFriendlyName].textFirstLine = tFirst
                           if type(aParentChilds[tFriendlyName].textFull) ~= "table" then
                              aParentChilds[tFriendlyName].textFull = {(aParentChilds[tFriendlyName].textFull or aParentChilds[tFriendlyName].textFirstLine or ""),}
                           end
                           table.insert(aParentChilds[tFriendlyName].textFull, 1, tFull)
                        end
                     end

                     if aParentChilds[tFriendlyName].textFirstLine == "" and aParentChilds[tFriendlyName].textFull == "" and aParentChilds[tFriendlyName].obj.ShowTooltip then
                        GameTooltip:ClearLines()
                        aParentChilds[tFriendlyName].obj:ShowTooltip()
                        if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
                           if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
                              local tText = unescape(TooltipLines_helper(GameTooltip:GetRegions()))
                              aParentChilds[tFriendlyName].textFirstLine, aParentChilds[tFriendlyName].textFull = ItemName_helper(tText)
                           end
                        end
                     end
                     
                     

                     if _G[tFrameName.."Count"] and not _G[tFrameName].info then
                        if aParentChilds[tFriendlyName] and _G[tFrameName.."Count"]:GetText() then
                           if not string.find(aParentChilds[tFriendlyName].textFirstLine, L["Empty"].." ") then
                              aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ".._G[tFrameName.."Count"]:GetText()
                           else
                              aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine
                           end
                        end
                     end
                     if aParentChilds[tFriendlyName] and string.find(tFrameName, "ContainerFrame") then
                        if aParentChilds[tFriendlyName].textFirstLine then
                           aParentChilds[tFriendlyName].textFirstLine = (#tBagResults[bagId].childs + 1).." "..aParentChilds[tFriendlyName].textFirstLine
                           tEmptyCounter = tEmptyCounter + 1
                        end
                     end
                     if _G[tFrameName.."Count"] and aParentChilds[tFriendlyName] then
                        aParentChilds[tFriendlyName].stackSize = _G[tFrameName.."Count"]:GetText()
                     end
                     if _G[tFrameName].info then
                        aParentChilds[tFriendlyName].itemId = _G[tFrameName].info.id
                        if not _G[tFrameName].info.count then
                           aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine
                        else
                           if not string.find(aParentChilds[tFriendlyName].textFirstLine, L["Empty"].." ") and _G[tFrameName].info.count > 1 then
                              aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ".._G[tFrameName].info.count
                           else
                              aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine
                           end
                        end								
                     end							

                  end
                  
                  tBagResults[bagId].childs[#tBagResults[bagId].childs + 1] = aParentChilds[tFriendlyName]

               end
            end
         end
      end  
   end

   for i, v in pairs(tBagResults) do
      for ic, vc in pairs(v.childs) do
         table.insert(v.obj.childs, vc)
         v.obj.childs[vc] = vc
      end
   end


   local tFriendlyName = L["Bags"]
   local tText, tFullText = L["Bags"], ""
   table.insert(aParentChilds, tFriendlyName)
   aParentChilds[tFriendlyName] = {
      frameName = tFrameName,
      RoC = "Child",
      type = "Button",
      obj = _G[tFrameName],
      textFirstLine = tFriendlyName,
      textFull = "",
      noMenuNumbers = true,
      childs = {},
      func = nil,
      click = true,
   }   

   tCurrentParentContainer = aParentChilds[tFriendlyName]

   local dtc = { BagnonInventoryFrame1.bagGroup:GetChildren() }
   for x = 1, (#dtc - 1) do
      if dtc[x] then

         local tFriendlyName = L["Bag-slot"].." "..(x + 1)
         local tText, tFullText = L["Bag-slot"].." "..(x + 1), ""
         if dtc[x]:IsEnabled() == true then
            aParentChilds[tFriendlyName] = {
               frameName = L["Bag-slot"]..(x + 1),
               RoC = "Child",
               type = "Button",
               obj = dtc[x],
               textFirstLine = tFriendlyName,
               textFull = "",
               noMenuNumbers = true,
               childs = {},
               func = dtc[x]:GetScript("OnClick"),
               click = true,
               isBag = true,
            }   
            if x == 1 or x == 6 then
               aParentChilds[tFriendlyName].childs = {}
               aParentChilds[tFriendlyName].type = "Text"
               aParentChilds[tFriendlyName].func = nil
            end

            GameTooltip:ClearLines()
            aParentChilds[tFriendlyName].obj:GetScript("OnEnter")(aParentChilds[tFriendlyName].obj)
            if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
               if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
                  local tText = unescape(TooltipLines_helper(GameTooltip:GetRegions()))
                  --print("-",tText,"-")
                  if string.find(tText, "Equip Container") then
                     tText = L["Empty"]
                  end
                  tText = x.." "..tText
                  aParentChilds[tFriendlyName].textFirstLine, aParentChilds[tFriendlyName].textFull = ItemName_helper(tText)
               end
            end
         end
         

         table.insert(tCurrentParentContainer.childs, aParentChilds[tFriendlyName])
         tCurrentParentContainer.childs[aParentChilds[tFriendlyName]] = aParentChilds[tFriendlyName]
      end
   end      
end

function SkuCore:Build_CraftFrame(aParentChilds)

   local tFrameName = "CraftFrame"
   local tFriendlyName = L["Wildtierausbildung"]
   table.insert(aParentChilds, tFriendlyName)
   aParentChilds[tFriendlyName] = {
      frameName = tFrameName,
      RoC = "Child",
      type = "FontString",
      obj = _G[tFrameName],
      textFirstLine = tFriendlyName,
      textFull = "",
      childs = {},
   }

   if _G["CraftFramePointsText"] then
      local tFrameName = "CraftFramePointsText"
      local tFriendlyName = L["Verfügbare punkte: "]
      tFriendlyName = tFriendlyName..(_G["CraftFramePointsText"]:GetText() or "")
      table.insert(aParentChilds, tFriendlyName)
      aParentChilds[tFriendlyName] = {
         frameName = tFrameName,
         RoC = "Child",
         type = "FontString",
         obj = _G[tFrameName],
         textFirstLine = tFriendlyName,
         textFull = "",
         childs = {},
      }  
   end

   local tFrameName = "CraftListScrollFrameScrollBarScrollUpButton"
   if _G[tFrameName] then
      if tFrame:IsVisible() == true  then --IsMouseClickEnabled()
         local tFriendlyName = L["Hoch blättern"]
         table.insert(aParentChilds, tFriendlyName)
         aParentChilds[tFriendlyName] = {
            frameName = tFrameName,
            RoC = "Child",
            type = "Button",
            obj = _G[tFrameName],
            textFirstLine = tFriendlyName,
            textFull = "",
            childs = {},
            func = function(self, aButton)
               self:GetScript("OnClick")(self, aButton)             
               self:GetScript("OnClick")(self, aButton)             
            end,            
            click = true,
         }   
      end
   end

   for x = 1, 8 do
      local tFrameName = "Craft"..x
      if _G[tFrameName] then
         if _G[tFrameName.."Text"]:GetText() then
            local tKnown = ""
            local r, g, b = _G["Craft"..x].subR, _G["Craft"..x].subG, _G["Craft"..x].subB
            if r == 1 and g == 1 and b == 1 then
               r, g, b = CraftHighlight:GetVertexColor()
            end
            if r < 0.51 and g < 0.51 and b < 0.51 then
               tKnown = L["bekannt"]
            end
            local tFriendlyName = unescape(_G[tFrameName.."Text"]:GetText()).." ".. (unescape(_G[tFrameName.."SubText"]:GetText()) or "").." ".. (unescape(_G[tFrameName.."Cost"]:GetText()) or "").." "..tKnown
            local tText, tFullText = "", ""
            if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
               table.insert(aParentChilds, tFriendlyName)
               aParentChilds[tFriendlyName] = {
                  frameName = tFrameName,
                  RoC = "Child",
                  type = "Button",
                  obj = _G[tFrameName],
                  textFirstLine = tFriendlyName,
                  textFull = "",
                  childs = {},
                  func = _G[tFrameName]:GetScript("OnClick"),
                  click = true,
               }   
            end
         end
      end
   end

   local tFrameName = "CraftListScrollFrameScrollBarScrollDownButton"
   if _G[tFrameName] then
      if tFrame:IsVisible() == true then --IsMouseClickEnabled()
         local tFriendlyName = L["Runter blättern"]
         table.insert(aParentChilds, tFriendlyName)
         aParentChilds[tFriendlyName] = {
            frameName = tFrameName,
            RoC = "Child",
            type = "Button",
            obj = _G[tFrameName],
            textFirstLine = tFriendlyName,
            textFull = "",
            childs = {},
            func = function(self, aButton)
               self:GetScript("OnClick")(self, aButton)             
               self:GetScript("OnClick")(self, aButton)             
            end,            
            click = true,
         }   
      end
   end

   local tName = ""
   if _G["CraftName"] then
      tName = unescape(_G["CraftName"]:GetText()) or ""
   end
   local tRequirements = ""
   if _G["CraftRequirements"] then
      tRequirements = unescape(_G["CraftRequirements"]:GetText()) or ""
   end
   local tCost = ""
   if _G["CraftCost"] then
      tCost = unescape(_G["CraftCost"]:GetText()) or ""
   end
   local tDescription = ""
   if _G["CraftDescription"] then
      tDescription = unescape(_G["CraftDescription"]:GetText()) or ""
   end

   local tFrameName = "CraftDetailScrollChildFrame"
   if tName and tName ~= "" then
      local tFriendlyName = L["Ausgewählt: "]..tName
      table.insert(aParentChilds, tFriendlyName)
      aParentChilds[tFriendlyName] = {
         frameName = tFrameName,
         RoC = "Child",
         type = "FontString",
         obj = _G[tFrameName],
         textFirstLine = tFriendlyName,
         textFull = tName..(("\r\n"..tRequirements) or "")..(("\r\n"..tCost) or "")..(("\r\n"..tDescription) or ""),
         childs = {},
      }   
   end

   local tFrameName = "CraftCreateButton"
   if _G[tFrameName] then
      if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
         if _G[tFrameName]:GetText() then
            local tFriendlyName = unescape(_G[tFrameName]:GetText())
            table.insert(aParentChilds, tFriendlyName)
            aParentChilds[tFriendlyName] = {
               frameName = tFrameName,
               RoC = "Child",
               type = "Button",
               obj = _G[tFrameName],
               textFirstLine = tFriendlyName,
               textFull = "",
               childs = {},
               func = _G[tFrameName]:GetScript("OnClick"),
               click = true,
               containerFrameName = "CraftCreateButton",
               onActionFunc = function(self, aTable, aChildName) end,
            }   
         end
      end
   end

   local tFrameName = "CraftFrameCloseButton"
   local tFriendlyName = L["Schließen"]
   if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
      table.insert(aParentChilds, tFriendlyName)
      aParentChilds[tFriendlyName] = {
         frameName = tFrameName,
         RoC = "Child",
         type = "Button",
         obj = _G[tFrameName],
         textFirstLine = tFriendlyName,
         textFull = "",
         childs = {},
         func = _G[tFrameName]:GetScript("OnClick"),
         click = true,
      }   
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_PetStableFrame(aParentChilds)
   --dprint("SkuCore:Build_PetStableFrame")

   local tFrame = _G["PetStableCurrentPet"]
   local tText, tFullText = GetButtonTooltipLines(tFrame)
   table.insert(aParentChilds, L["Derzeitiger Begleiter"])
   aParentChilds[L["Derzeitiger Begleiter"]] = {
      frameName = "PetStableCurrentPet",
      RoC = "Child",
      type = "Button",
      obj = tFrame,
      textFirstLine = L["Derzeitiger Begleiter"].." "..tText,
      textFull = L["Derzeitiger Begleiter"].." "..tFullText,
      childs = {},
      func = function(...)
         local tCursorInfo = GetCursorInfo() 
         if tCursorInfo then
            tFrame:GetScript("OnReceiveDrag")(...)
         else
            tFrame:GetScript("OnDragStart")(...)
         end
      end,
      click = true,
   }   

   local tFrame = _G["PetStableStabledPet1"]
   if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
      local tText, tFullText = GetButtonTooltipLines(tFrame)
      table.insert(aParentChilds, L["Stall 1"])
      aParentChilds[L["Stall 1"]] = {
         frameName = "PetStableStabledPet1",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = L["Stall 1"].." "..tText,
         textFull = L["Stall 1"].." "..tFullText,
         childs = {},
         func = function(...)
            local tCursorInfo = GetCursorInfo() 
            if tCursorInfo then
               tFrame:GetScript("OnReceiveDrag")(...)
            else
               tFrame:GetScript("OnDragStart")(...)
            end
         end,
         click = true,
      }
   end

   local tFrame = _G["PetStableStabledPet2"]
   if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
      local tText, tFullText = GetButtonTooltipLines(tFrame)
      table.insert(aParentChilds, L["Stall 2"])
      aParentChilds[L["Stall 2"]] = {
         frameName = "PetStableStabledPet2",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = L["Stall 2"].." "..tText,
         textFull = L["Stall 2"].." "..tFullText,
         childs = {},
         func = function(...)
            local tCursorInfo = GetCursorInfo() 
            if tCursorInfo then
               tFrame:GetScript("OnReceiveDrag")(...)
            else
               tFrame:GetScript("OnDragStart")(...)
            end
         end,
         click = true,
      }
   end

   local tFrame = _G["PetStablePurchaseButton"]
   if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
      if tFrame:IsShown() == true then --IsMouseClickEnabled()
         table.insert(aParentChilds, L["Weiteren Platz kaufen"])
         aParentChilds[L["Weiteren Platz kaufen"]] = {
            frameName = "PetStablePurchaseButton",
            RoC = "Child",
            type = "Button",
            obj = tFrame,
            textFirstLine = L["Weiteren Platz kaufen"],
            textFull = "",
            childs = {},
            func = tFrame:GetScript("OnClick"),
            click = true,
         }   
      end
   end

   local tFrame = _G["PetStableFrameCloseButton"]
   if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
      table.insert(aParentChilds, L["Schließen"])
      aParentChilds[L["Schließen"]] = {
         frameName = "PetStableFrameCloseButton",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = L["Schließen"],
         textFull = "",
         childs = {},
         func = tFrame:GetScript("OnClick"),
         click = true,
      }   
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "LocalMenu"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
-- helpers
local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}
local function unescape(str)
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

---------------------------------------------------------------------------------------------------------------------------------------
local function GetButtonTooltipLines(aButtonObj)
   GameTooltip:ClearLines()
   if aButtonObj:GetScript("OnEnter") then
      aButtonObj:GetScript("OnEnter")(aButtonObj)
   end

	local tTooltipText = ""
   for i = 1, select("#", GameTooltip:GetRegions()) do
		local region = select(i, GameTooltip:GetRegions())
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				tTooltipText = tTooltipText..text.."\r\n"
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
function SkuCore:Build_CraftFrame(aParentChilds)

   local tFrameName = "CraftFrame"
   local tFriendlyName = "Wildtierausbildung"
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

   if _["CraftPointsText"] then
      local tFrameName = "CraftPointsLabel"
      local tFriendlyName = "Verfügbare punkte: "
      tFriendlyName = tFriendlyName..(_["CraftPointsText"]:GetText() or "")
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
         local tFriendlyName = "Hoch blättern"
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
               tKnown = "bekannt"
            end
            local tFriendlyName = _G[tFrameName.."Text"]:GetText().." ".. (_G[tFrameName.."SubText"]:GetText() or "").." ".. (_G[tFrameName.."Cost"]:GetText() or "").." "..tKnown
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
         local tFriendlyName = "Runter blättern"
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
      tName = _G["CraftName"]:GetText() or ""
   end
   local tRequirements = ""
   if _G["CraftRequirements"] then
      tRequirements = _G["CraftRequirements"]:GetText() or ""
   end
   local tCost = ""
   if _G["CraftCost"] then
      tCost = _G["CraftCost"]:GetText() or ""
   end
   local tDescription = ""
   if _G["CraftDescription"] then
      tDescription = _G["CraftDescription"]:GetText() or ""
   end

   local tFrameName = "CraftDetailScrollChildFrame"
   if tName and tName ~= "" then
      local tFriendlyName = "Ausgewählt: "..tName
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
            local tFriendlyName = _G[tFrameName]:GetText()
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
   local tFriendlyName = "Schließen"
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
   table.insert(aParentChilds, "Derzeitiger Begleiter")
   aParentChilds["Derzeitiger Begleiter"] = {
      frameName = "PetStableCurrentPet",
      RoC = "Child",
      type = "Button",
      obj = tFrame,
      textFirstLine = "Derzeitiger Begleiter "..tText,
      textFull = "Derzeitiger Begleiter "..tFullText,
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
      table.insert(aParentChilds, "Stall 1")
      aParentChilds["Stall 1"] = {
         frameName = "PetStableStabledPet1",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = "Stall 1 "..tText,
         textFull = "Stall 1 "..tFullText,
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
      table.insert(aParentChilds, "Stall 2")
      aParentChilds["Stall 2"] = {
         frameName = "PetStableStabledPet2",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = "Stall 2 "..tText,
         textFull = "Stall 2 "..tFullText,
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
         table.insert(aParentChilds, "Weiteren Platz kaufen")
         aParentChilds["Weiteren Platz kaufen"] = {
            frameName = "PetStablePurchaseButton",
            RoC = "Child",
            type = "Button",
            obj = tFrame,
            textFirstLine = "Weiteren Platz kaufen",
            textFull = "",
            childs = {},
            func = tFrame:GetScript("OnClick"),
            click = true,
         }   
      end
   end

   local tFrame = _G["PetStableFrameCloseButton"]
   if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
      table.insert(aParentChilds, "Schließen")
      aParentChilds["Schließen"] = {
         frameName = "PetStableFrameCloseButton",
         RoC = "Child",
         type = "Button",
         obj = tFrame,
         textFirstLine = "Schließen",
         textFull = "",
         childs = {},
         func = tFrame:GetScript("OnClick"),
         click = true,
      }   
   end
end


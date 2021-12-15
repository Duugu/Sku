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
         dprint(tCursorInfo)
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
            dprint(tCursorInfo)
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
            dprint(tCursorInfo)
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


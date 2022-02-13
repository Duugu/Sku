---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "aq"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

--[[
   Interface\AddOns\Sku\SkuCore\assets\audio\heal\numbers
Interface\AddOns\Sku\SkuCore\assets\audio\heal\other

/sku aq		on/off
		dispel	on/off
		self	on/off
		all	on/off
		1-40	on/off
		pet	on/off
		focus	on/off
		tank1-5	on/off
		hp	<value>,<value>,...
		mana	<value>,<value>,...
		channel	name?
		min sp	<value>
		max sp	<value>
]]

---------------------------------------------------------------------------------------------------------------------------------------
local function AqCreateControlFrame()
   local f = _G["SkuCoreAqControl"] or CreateFrame("Frame", "SkuCoreAqControl", UIParent)
   local ttime = 0
   f:SetScript("OnUpdate", function(self, time)
      ttime = ttime + time
      if ttime < 0.05 then return end



   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnInitialize()
   --AqCreateControlFrame()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqSlashHandler(aFieldsTable)
   for x = 2, #aFieldsTable do
      --print(x, aFieldsTable[x])
   end

end

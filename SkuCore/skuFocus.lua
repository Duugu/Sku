local MODULE_NAME, MODULE_PART = "SkuCore", "SkuFocus"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.SkuFocus = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocusOnLogin()


   
   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocusOnInitialize()
   --print("SkuFocusOnInitialize")




   --[[
	SkuDispatcher:RegisterEventCallback("PLAYER_ENTERING_WORLD", SkuCore.SkuFocus_PLAYER_ENTERING_WORLD)
   SkuDispatcher:RegisterEventCallback("PARTY_LEADER_CHANGED", SkuCore.SkuFocus_PARTY_LEADER_CHANGED)
   SkuDispatcher:RegisterEventCallback("GROUP_FORMED", SkuCore.SkuFocus_GROUP_FORMED)
   SkuDispatcher:RegisterEventCallback("GROUP_JOINED", SkuCore.SkuFocus_GROUP_JOINED)
   SkuDispatcher:RegisterEventCallback("GROUP_LEFT", SkuCore.SkuFocus_GROUP_LEFT)
   ]]
   SkuDispatcher:RegisterEventCallback("GROUP_ROSTER_UPDATE", SkuCore.SkuFocus_GROUP_ROSTER_UPDATE)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_PLAYER_ENTERING_WORLD()
   --print("SkuFocus_PLAYER_ENTERING_WORLD")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_PARTY_LEADER_CHANGED()
   --print("SkuFocus_PARTY_LEADER_CHANGED", UnitInRaid("player"), UnitInParty("player"))

   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_GROUP_FORMED()
   --print("SkuFocus_GROUP_FORMED")
   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_GROUP_JOINED()
   --print("SkuFocus_GROUP_JOINED")
   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_GROUP_LEFT()
   --print("SkuFocus_GROUP_LEFT")
   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:SkuFocus_GROUP_ROSTER_UPDATE()
   --print("SkuFocus_GROUP_ROSTER_UPDATE")
   
end

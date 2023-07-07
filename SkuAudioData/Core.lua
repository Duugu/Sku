local ADDON_NAME = ...
local _G = _G



local f = CreateFrame("Frame", "SkuCoreaqCombatControl", UIParent)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event)
   -- [[\Interface\AddOns\Sku\SkuAudioData\assets\audio\]]..Sku.Loc

   self:UnregisterAllEvents()
end)



---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "RangeCheck"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.RangeCheckValues = {
   Ranges = {
      Friendly = {},
      Hostile = {},
      Misc = {},
   },
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RangeCheckOnInitialize()
   SkuOptions.RangeCheck.RegisterCallback(self, SkuOptions.RangeCheck.CHECKERS_CHANGED, SkuCore.RangeCheckUpdateRanges)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RangeCheckOnEnable()
   SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
   SkuOptions.db.char[MODULE_NAME].RangeChecks = SkuOptions.db.char[MODULE_NAME].RangeChecks or {
      Friendly = {},
      Hostile = {},
      Misc = {},
   }
end

---------------------------------------------------------------------------------------------------------------------------------------
local tFirstRangeUpdateSilent = true
function SkuCore:RangeCheckUpdateRanges()
   if tFirstRangeUpdateSilent then
      tFirstRangeUpdateSilent = nil
   else
      SkuOptions.Voice:OutputString("Neue Reichweite verfügbar", true, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
   end

   SkuCore.RangeCheckValues.Ranges.Friendly = {}
   --query available ranges
   for i, v in SkuOptions.RangeCheck:GetFriendCheckers() do 
      SkuCore.RangeCheckValues.Ranges.Friendly[i] = v
   end
   --remove configured checks that a not longer available
   for i, v in pairs(SkuOptions.db.char[MODULE_NAME].RangeChecks.Friendly) do
      if not SkuCore.RangeCheckValues.Ranges.Friendly[i] then
         SkuOptions.db.char[MODULE_NAME].RangeChecks.Friendly[i] = nil
      end
   end

   for i, v in SkuOptions.RangeCheck:GetHarmCheckers() do 
      SkuCore.RangeCheckValues.Ranges.Hostile[i] = v
   end
   for i, v in pairs(SkuOptions.db.char[MODULE_NAME].RangeChecks.Hostile) do
      if not SkuCore.RangeCheckValues.Ranges.Hostile[i] then
         SkuOptions.db.char[MODULE_NAME].RangeChecks.Hostile[i] = nil
      end
   end   

   for i, v in SkuOptions.RangeCheck:GetMiscCheckers() do 
      SkuCore.RangeCheckValues.Ranges.Misc[i] = v
   end
   for i, v in pairs(SkuOptions.db.char[MODULE_NAME].RangeChecks.Misc) do
      if not SkuCore.RangeCheckValues.Ranges.Misc[i] then
         SkuOptions.db.char[MODULE_NAME].RangeChecks.Misc[i] = nil
      end
   end   
end
   
---------------------------------------------------------------------------------------------------------------------------------------
local tRangeCheckLastTarget
local tRangeCheckLastTargetminRange = 0
function SkuCore:DoRangeCheck()

   local tCheckRequired = false
   local tMinRange = SkuOptions.RangeCheck:GetRange("target")

   if tRangeCheckLastTarget ~= UnitName("target") then
      tRangeCheckLastTarget = UnitName("target")
      tRangeCheckLastTargetminRange = tMinRange
      tCheckRequired = true
   else
      if tRangeCheckLastTargetminRange ~= tMinRange then
         tCheckRequired = true
         tRangeCheckLastTargetminRange = tMinRange
      end
   end

   if tCheckRequired == true then
      local tCheckType = "Misc"
      if UnitIsDead("target") == false then
         if UnitCanAttack("player", "target") then
            tCheckType = "Hostile"
         elseif UnitCanAssist("player", "target") then
            tCheckType = "Friendly"
         end
      end

      if SkuOptions.db.char[MODULE_NAME].RangeChecks[tCheckType][tRangeCheckLastTargetminRange] then
         local tSoundChannel = SkuOptions.db.profile.SkuCore.UIErrors.ErrorSoundChannel or "Talking Head"
         if SkuOptions.db.char[MODULE_NAME].RangeChecks[tCheckType][tRangeCheckLastTargetminRange].sound == L["vocalized"] then
            --PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\"..tRangeCheckLastTargetminRange..".mp3", tSoundChannel)
            PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\"..tRangeCheckLastTargetminRange..".mp3", tSoundChannel)
         else
            PlaySoundFile(SkuOptions.db.char[MODULE_NAME].RangeChecks[tCheckType][tRangeCheckLastTargetminRange].sound, tSoundChannel)
         end
         
      end
   end

   -- local meleeChecker = rc:GetFriendMaxChecker(rc.MeleeRange) or rc:GetFriendMinChecker(rc.MeleeRange) -- use the closest checker (MinChecker) if no valid Melee checker is found
   -- for i = 1, 4 do
   --     -- TODO: check if unit is valid, etc
   --     if meleeChecker("party" .. i) then
   --         print("Party member " .. i .. " is in Melee range")
   --     end
   -- end

   -- local safeDistanceChecker = rc:GetHarmMinChecker(30)
   -- -- negate the result of the checker!
   -- local isSafelyAway = not safeDistanceChecker('target')
end

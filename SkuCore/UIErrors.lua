---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "UIErrors"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UIErrorsOnInitialize()
   SkuCore:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
   SkuCore:RegisterEvent("UI_ERROR_MESSAGE")
   SkuCore:RegisterEvent("UI_INFO_MESSAGE")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UI_INFO_MESSAGE(aEvent, tMessage, tMessage1)
   SkuCore:UIErrorEventHandler(aEvent, tMessage, tMessage1)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UI_ERROR_MESSAGE(aEvent, tMessage, tMessage1)
   SkuCore:UIErrorEventHandler(aEvent, tMessage, tMessage1)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tPrevError
local tPrevErrorLimit = 1
local tPrevErrorTime = time()
function SkuCore:UIErrorEventHandler(aEvent, tMessage, tMessage1)
      --https://wowwiki-archive.fandom.com/wiki/WoW_Constants/Errors#ERR_SPELL

   local tSoundChannel = SkuOptions.db.profile.SkuCore.UIErrors.ErrorSoundChannel or "Talking Head"
   local tOff = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"

   if tonumber(tMessage) and tMessage1 then
      tMessage = tMessage1
   end

   --ERR_BAG_FULL  That bag is full.

   local tIsBase

   tMessage = tMessage

   --OutOfRangeMelee
   if (tMessage == ERR_BADATTACKPOS or tMessage == ERR_OUT_OF_RANGE) then
      if SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeMelee ~= tOff then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeMelee, tSoundChannel, L["Range"])
      end
      tIsBase = true
   end

   --OutOfRangeCast
   if (tMessage == ERR_SPELL_OUT_OF_RANGE or tMessage == SPELL_FAILED_TOO_CLOSE) then
      if SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeCast ~= tOff then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeCast, tSoundChannel, L["Range"])
      end
      tIsBase = true
   end
   
   --Moving
   if (tMessage == SPELL_FAILED_MOVING) then
      if SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving ~= tOff then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving, tSoundChannel, L["Move"])
      end
      tIsBase = true
   end

   --NoLoS
   if (tMessage == SPELL_FAILED_LINE_OF_SIGHT or tMessage == SPELL_FAILED_VISION_OBSCURED) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS, tSoundChannel, L["LOS"])
      end
      tIsBase = true
   end

   --BadTarget
   if (tMessage == SPELL_FAILED_BAD_TARGETS or tMessage == ERR_INVALID_ATTACK_TARGET or tMessage == SPELL_FAILED_TARGETS_DEAD or tMessage == SPELL_FAILED_BAD_IMPLICIT_TARGETS or tMessage == ERR_NO_ATTACK_TARGET) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget, tSoundChannel, L["Target"])
      end
      tIsBase = true
   end

   --InCombat
   if (tMessage == SPELL_FAILED_AFFECTING_COMBAT and SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat, tSoundChannel, L["IC"])
      tIsBase = true
   end

   --NoMana
   if (tMessage == ERR_OUT_OF_MANA or tMessage == ERR_OUT_OF_RAGE or tMessage == ERR_OUT_OF_ENERGY) then
      if SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana ~= tOff then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana, tSoundChannel, L["Res"])
      end
      tIsBase = true
   end

   --ObjectBusy

   if (tMessage == ERR_OBJECT_IS_BUSY or tMessage == SPELL_FAILED_CHEST_IN_USE or tMessage == ERR_CHEST_IN_USE or tMessage == ERR_INV_FULL) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy, tSoundChannel, L["Busy"])
      end
      tIsBase = true
   end

   --NotFacing

   if (tMessage == ERR_BADATTACKFACING or tMessage == SPELL_FAILED_UNIT_NOT_INFRONT or tMessage == ERR_BADATTACKFACING or tMessage == SPELL_FAILED_NOT_BEHIND or tMessage == SPELL_FAILED_UNIT_NOT_BEHIND) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, L["Dir"])
      end
      tIsBase = true
   end

   --CrowdControlled

   if (tMessage == SPELL_FAILED_SILENCED or tMessage == SPELL_FAILED_STUNNED or tMessage == ERR_ATTACK_PACIFIED or tMessage == ERR_ATTACK_CHARMED or tMessage == ERR_ATTACK_CONFUSED or tMessage == ERR_ATTACK_FLEEING or string.find(tMessage, string.sub(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, 1, string.len(ERR_ATTACK_PREVENTED_BY_MECHANIC_S) - 5))) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, L["Stun"])
      end
      tIsBase = true
   end

   --cd
   if (tMessage == ERR_SPELL_COOLDOWN or tMessage == ERR_ABILITY_COOLDOWN) then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled ~= tOff) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.Cooldown, tSoundChannel, L["cooldown"])
      end
      tIsBase = true
   end
   
   --[ERR_SPELL_COOLDOWN] = true,
	--[ERR_ABILITY_COOLDOWN] = true,


   if tMessage == 50 then --"interrupted"; unknown constant
      if SkuCore:UNIT_SPELLCAST_INTERRUPTED("UNIT_SPELLCAST_INTERRUPTED", "player") then
         tIsBase = true
      end
   end

   if not tIsBase then
      if (SkuOptions.db.profile[MODULE_NAME].UIErrors.Other ~= tOff) then
         SkuCore:OutputError(nil, nil, tMessage)
      end
   end

end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_SPELLCAST_INTERRUPTED(aEvent, aUnit)
   local tSoundChannel = SkuOptions.db.profile.SkuCore.UIErrors.ErrorSoundChannel or "Talking Head"
   local tOff = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"
   
   --Interrupted
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.Interrupted ~= tOff) then
      if (aUnit == "player") then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.Interrupted, tSoundChannel, L["Inter"])
         return true
      end
   end
  
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:OutputError(aSound, aChannel, aMessage)
   --print(aSound, aChannel, aMessage)

   if aSound and aSound ~= "voice" then
      if tPrevError == aSound and (time() - tPrevErrorTime < tPrevErrorLimit) then
         return
      end

      PlaySoundFile(aSound, aChannel)

      tPrevError = aSound
      tPrevErrorTime = time()
   else
      SkuOptions.Voice:OutputStringBTtts(aMessage, false, false, 0.8, nil, nil, nil, 1, nil, nil, true)
   end
end
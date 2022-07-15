---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "UIErrors"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UIErrorsOnInitialize()
   SkuCore:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
   SkuCore:RegisterEvent("UI_ERROR_MESSAGE")
end

---------------------------------------------------------------------------------------------------------------------------------------
local tPrevError
local tPrevErrorLimit = 1
local tPrevErrorTime = time()
function SkuCore:UI_ERROR_MESSAGE(aEvent, tMessage, tMessage1)
   --https://wowwiki-archive.fandom.com/wiki/WoW_Constants/Errors#ERR_SPELL

   local tSoundChannel = SkuOptions.db.profile.SkuCore.UIErrors.ErrorSoundChannel or "Talking Head"
   local tOff = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"

   if tonumber(tMessage) and tMessage1 then
      tMessage = tMessage1
   end

   --ERR_BAG_FULL  That bag is full.

   local tIsBase

   tMessage = tMessage

   --OutOfRange
   if (tMessage == ERR_BADATTACKPOS  and SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange, tSoundChannel, tMessage)
      tIsBase = true
   end
   if (tMessage == ERR_SPELL_OUT_OF_RANGE and SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange, tSoundChannel, tMessage)
      tIsBase = true
   end
   if (tMessage == ERR_OUT_OF_RANGE and SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange, tSoundChannel, tMessage)
   end
   if (tMessage == SPELL_FAILED_TOO_CLOSE and SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange, tSoundChannel, tMessage)
      tIsBase = true
   end

   --Moving
   if (tMessage == SPELL_FAILED_MOVING and SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving, tSoundChannel, tMessage)
      tIsBase = true
   end

   --NoLoS
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS ~= tOff) then
      if (tMessage == SPELL_FAILED_LINE_OF_SIGHT) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_VISION_OBSCURED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS, tSoundChannel, tMessage)
         tIsBase = true
      end
   end

   --BadTarget
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget ~= tOff) then
      if (tMessage == SPELL_FAILED_BAD_TARGETS) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_INVALID_ATTACK_TARGET) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_TARGETS_DEAD) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget, tSoundChannel, tMessage)
         tIsBase = true
      end
   end

   --InCombat
   if (tMessage == SPELL_FAILED_AFFECTING_COMBAT and SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat, tSoundChannel, tMessage)
      tIsBase = true
   end

   --NoMana
   if (tMessage == ERR_OUT_OF_MANA and SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana, tSoundChannel, tMessage)
      tIsBase = true
   end
   if (tMessage == ERR_OUT_OF_RAGE and SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana, tSoundChannel, tMessage)
      tIsBase = true
   end
   if (tMessage == ERR_OUT_OF_ENERGY and SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana ~= tOff) then
      SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana, tSoundChannel, tMessage)
      tIsBase = true
   end

   --ObjectBusy
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy ~= tOff) then
      if (tMessage == ERR_OBJECT_IS_BUSY) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_CHEST_IN_USE) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_CHEST_IN_USE) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_INV_FULL) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy, tSoundChannel, tMessage)
         tIsBase = true
      end
   end

   --NotFacing
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing ~= tOff) then
      if (tMessage == ERR_BADATTACKFACING) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_UNIT_NOT_INFRONT) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_BADATTACKFACING) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_NOT_BEHIND) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_UNIT_NOT_BEHIND) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing, tSoundChannel, tMessage)
         tIsBase = true
      end
   end

   --CrowdControlled
   if (SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled ~= tOff) then
      if (tMessage == SPELL_FAILED_SILENCED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == SPELL_FAILED_STUNNED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_ATTACK_PACIFIED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_ATTACK_CHARMED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_ATTACK_CONFUSED) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == ERR_ATTACK_FLEEING) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_BANISH))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_CHARM))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_CONFUSE))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_CYCLONE))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_FEAR))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_HORROR))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_INCAPACITATE))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_PACIFY))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_PACIFYSILENCE))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_POLYMORPH))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_POSSESS))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_SAP))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_SLEEP))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_STUN))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
      if (tMessage == string.format(ERR_ATTACK_PREVENTED_BY_MECHANIC_S, string.lower(LOSS_OF_CONTROL_DISPLAY_TURN_UNDEAD))) then
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled, tSoundChannel, tMessage)
         tIsBase = true
      end
   end

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
         SkuCore:OutputError(SkuOptions.db.profile[MODULE_NAME].UIErrors.Interrupted, tSoundChannel, tMessage)
         return true
      end
   end
  
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:OutputError(aSound, aChannel, aMessage)
   dprint(aSound, aChannel, aMessage)

   if aSound and aSound ~= "voice" then
      if tPrevError == aSound and (time() - tPrevErrorTime < tPrevErrorLimit) then
         return
      end

      PlaySoundFile(aSound, aChannel)

      tPrevError = aSound
      tPrevErrorTime = time()
   else
      SkuOptions.Voice:OutputStringBTtts(aMessage, true, false, 0.8, nil, nil, nil, 1)
   end
end
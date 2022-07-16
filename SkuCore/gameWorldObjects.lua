---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "gameWorldObjects"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
local function unescape(String)
	local Result = tostring(String)
	Result = gsub(Result, "|c........", "") -- Remove color start.
	Result = gsub(Result, "|r", "") -- Remove color end.
	Result = gsub(Result, "|H.-|h(.-)|h", "%1") -- Remove links.
	Result = gsub(Result, "|T.-|t", "") -- Remove textures.
	Result = gsub(Result, "{.-}", "") -- Remove raid target icons.
	return Result
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsOnInitialize()
   SkuCore:RegisterEvent("CURSOR_UPDATE")
   SkuCore:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

   local tFrame = CreateFrame("Frame", "SkuCoregameWorldObjectsFrameCounter", _G["UIParent"])
   SkuCore.gameWorldObjectsFrameCounter = 0
   tFrame:SetSize(1, 1)
   tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
   tFrame:SetScript("OnUpdate", function(self, time)
      SkuCore.gameWorldObjectsFrameCounter = SkuCore.gameWorldObjectsFrameCounter + 1
      if SkuCore.gameWorldObjectsFrameCounter > 40000 then
         SkuCore.gameWorldObjectsFrameCounter = 0
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsOnLogin()
   -- set default values for scans to profile
   SkuOptions.db.char[MODULE_NAME].scanConfigs = SkuOptions.db.char[MODULE_NAME].scanConfigs or {}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[1] = SkuOptions.db.char[MODULE_NAME].scanConfigs[1] or {type = 2, objects = {7, 8,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[2] = SkuOptions.db.char[MODULE_NAME].scanConfigs[2] or {type = 1, objects = {9,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[3] = SkuOptions.db.char[MODULE_NAME].scanConfigs[3] or {type = 2, objects = {10,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[4] = SkuOptions.db.char[MODULE_NAME].scanConfigs[4] or {type = 2, objects = {1, 2,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[5] = SkuOptions.db.char[MODULE_NAME].scanConfigs[5] or {type = 3, objects = {7, 8,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[6] = SkuOptions.db.char[MODULE_NAME].scanConfigs[6] or {type = 3, objects = {10,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[7] = SkuOptions.db.char[MODULE_NAME].scanConfigs[7] or {type = 3, objects = {1, 2,},}
   SkuOptions.db.char[MODULE_NAME].scanConfigs[8] = SkuOptions.db.char[MODULE_NAME].scanConfigs[8] or {type = 5, objects = {12,},}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CURSOR_UPDATE()
   --print("CURSOR_UPDATE", SkuCore.gameWorldObjectsFrameCounter, GetTime())
   if SkuCore.gameWorldObjectsScanFrame and SkuCore.gameWorldObjectsScanFrame.isScanningActive == true and SkuCore.gameWorldObjectsScanFrame.isScanningPaused == false then
      
      SkuCore.lastCursorUpdateFrame = SkuCore.gameWorldObjectsFrameCounter
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UPDATE_MOUSEOVER_UNIT()
   --print("UPDATE_MOUSEOVER_UNIT", SkuCore.gameWorldObjectsFrameCounter, GetTime())
   if SkuCore.gameWorldObjectsScanFrame and SkuCore.gameWorldObjectsScanFrame.isScanningActive == true and SkuCore.gameWorldObjectsScanFrame.isScanningPaused == false then
      SkuCore.lastUpdateMouseoverUnitFrame = SkuCore.gameWorldObjectsFrameCounter
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsCenterMouseCursor(aPos)
   dprint("GameWorldObjectsCenterMouseCursor", aPos)
   SetCVar("CursorCenteredYPos", aPos)
   SetCVar("CursorFreelookCentering", 1)
   SetCVar("CursorStickyCentering", 1)
   MouselookStart()
   C_Timer.After(0.1, function() 
      MouselookStop()
      SetCVar("CursorFreelookCentering", 0)
      SetCVar("CursorStickyCentering", 0)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tResetRequired
function SkuCore:GameWorldObjectsRestoreView()
   if SkuCore.gameWorldObjectsScanFrame and tResetRequired then
      tResetRequired = nil
      SkuCore.gameWorldObjectsScanFrame.isScanningActive = false
      SkuCore.gameWorldObjectsScanFrame.isScanningPaused = true
      MoveViewUpStop()
      FlipCameraYaw(SkuCore.gameWorldObjectsScanFrame.CameraYaw * -1)
      SkuCore.gameWorldObjectsScanFrame.CameraYaw = 0
      SkuCore.noMouseOverNotification = nil
      SetCVar("cameraPitchMoveSpeed", SkuCore.gameWorldObjectsScanFrame.oldCameraPitchMoveSpeed)
      SetView(2)
      --[[
      if Questie_BaseFrame and SkuCore.inCombat == false then
         Questie_BaseFrame:Show()
      end
      ]]
      SkuOptions:StartStopBackgroundSound(false)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsTurnToWp(aWaypointName)
   aWaypointName = aWaypointName or SkuOptions.db.profile["SkuNav"].selectedWaypoint
   if aWaypointName and aWaypointName ~= "" then
      local fPlayerPosX, fPlayerPosY = UnitPosition("player")
      local tData = SkuNav:GetWaypointData2(aWaypointName)
      local _, _, degree = SkuNav:GetDirectionTo(fPlayerPosX, fPlayerPosY, tData.worldX, tData.worldY)
      SetView(2)
      --SkuCore:GameWorldObjectsCenterMouseCursor(0.5)
      
      local tOldCameraYawMoveSpeed = GetCVar("cameraYawMoveSpeed")

      local tFullTurnTime = 0.5
      local tOneDegreeTime = tFullTurnTime / 180
      local tYawMoveSpeedForOneSecond = 180 * (1 / tFullTurnTime)

      SetCVar("cameraYawMoveSpeed", tYawMoveSpeedForOneSecond)
      
      if degree < 0 then
         degree = degree - 5
      else
         degree = degree + 5
      end
      local tDuration = tOneDegreeTime * degree

      if tDuration < 0 then
         MoveViewRightStart(4)
         tDuration = tDuration * -1
      else
         MoveViewLeftStart(4)
      end
      C_Timer.After(tDuration / 4, function()
         MoveViewRightStop()
         MoveViewLeftStop()
         SetCVar("cameraYawMoveSpeed", tOldCameraYawMoveSpeed)
      end)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GameWorldObjectsVoiceOutput(aText, aSound)
   dprint("GameWorldObjectsVoiceOutput", aText, "------",  aSound)
   SkuOptions.Voice:OutputStringBTtts(aText, true, false, 0.2, nil, nil, nil, 4)
   if aSound then
      SkuOptions.Voice:OutputString(aSound, false, false, 0.2)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsCheckResult(aTextLeft1, aTextLeft2, aTextLeft3)
   local tIsUpdateMouseoverUnitFrame = SkuCore.lastUpdateMouseoverUnitFrame == SkuCore.gameWorldObjectsFrameCounter
   local tIsCursorUpdate = SkuCore.lastCursorUpdateFrame == SkuCore.gameWorldObjectsFrameCounter
   
   aTextLeft1 = unescape(aTextLeft1)
   aTextLeft2 = unescape(aTextLeft2)
   aTextLeft3 = unescape(aTextLeft3)

   dprint("GameWorldObjectsCheckResult", aTextLeft1, aTextLeft2, aTextLeft3, tIsUpdateMouseoverUnitFrame, tIsCursorUpdate)

   local tFind = SkuCore.gameWorldObjectsScanFrame.findList
   --local tFound = false

   local tSoundFile = "sound-on3_1"
   aTextLeft1 = aTextLeft1 or ""
   aTextLeft2 = aTextLeft2 or ""
   aTextLeft3 = aTextLeft3 or ""

   local tOutputText = aTextLeft1
   if aTextLeft2 ~= "nil" then
      tOutputText = tOutputText..", "..aTextLeft2
   end
   if aTextLeft3 ~= "nil" then
      tOutputText = tOutputText..", "..aTextLeft3
   end


   local tId = UnitGUID("mouseover") or "NoId"
   if not SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] then
      local taTextLeft1InCreatures
      local function taTextLeft1InCreaturesCheck()
         if not taTextLeft1InCreatures then
            for i, v in pairs(SkuDB.NpcData.Names[Sku.L["locale"]]) do
               if v[1] == aTextLeft1 then
                  GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
                  return true
               end
            end
         end
      end
      if tFind["CorpseLootable"] then
         if
            UnitName("mouseover") ~= nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == true and
            string.find(aTextLeft3, L["Skinnable"]) == nil and
            UnitIsDead("mouseover") == true
         then
            taTextLeft1InCreatures = taTextLeft1InCreaturesCheck()
            if taTextLeft1InCreatures then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end
      if tFind["CorpseSkinnable"] then
         if
            UnitName("mouseover") ~= nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == true and
            UnitIsDead("mouseover") == true and
            string.find(aTextLeft3, L["Skinnable"]) ~= nil
         then
            taTextLeft1InCreatures = taTextLeft1InCreaturesCheck()
            if taTextLeft1InCreatures then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end
      if tFind["CorpseNotLootable"] then
         if
            UnitName("mouseover") ~= nil and
            tIsUpdateMouseoverUnitFrame == true and
            tIsCursorUpdate == false and
            UnitIsDead("mouseover") == true
         then
            taTextLeft1InCreatures = taTextLeft1InCreaturesCheck()
            if taTextLeft1InCreatures then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end

      if tFind["CreaturePlayerTarget"] then
         if
            (UnitName("mouseover") ~= nil and UnitName("target") ~= nil and UnitName("mouseover") == UnitName("target")) and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == true and
            UnitIsDead("mouseover") ~= true
         then
            taTextLeft1InCreatures = taTextLeft1InCreaturesCheck()
            if taTextLeft1InCreatures then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end
      if tFind["CreatureAny"] then
         if
            UnitName("mouseover") ~= nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == true and
            UnitIsDead("mouseover") ~= true
         then
            taTextLeft1InCreatures = taTextLeft1InCreaturesCheck()
            if taTextLeft1InCreatures then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end

      local taTextLeft1InObjects
      local function taTextLeft1InObjectsCheck()
         if not taTextLeft1InObjects then
            for i, v in pairs(SkuDB.objectLookup[Sku.L["locale"]]) do
               if v == aTextLeft1 then
                  return true
               end
            end
            for i, v in pairs(SkuDB.SpellDataTBC) do
               if v[Sku.L["locale"]][1] == aTextLeft1 then
                  return true
               end
            end
         end
      end
      if tFind["ObjectCurrentQuest"] then
         if
            UnitName("mouseover") == nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == false
         then
            taTextLeft1InObjects = taTextLeft1InObjectsCheck()
            if taTextLeft1InObjects then
               local tIsMining
               local tIsherb
               for x = 1, #SkuCore.RessourceTypes.mining do
                  if SkuCore.RessourceTypes.mining[x][Sku.L["locale"]] == aTextLeft1 then
                     tIsMining = true
                  end
               end
               for x = 1, #SkuCore.RessourceTypes.herbs do
                  if SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]] == aTextLeft1 then
                     tIsherb = true
                  end
               end
               if not tIsherb and not tIsMining then
                  local tQuestObjects = SkuQuest:GetAllQuestObjects()
                  if tQuestObjects[aTextLeft1] then
                     SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
                     GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
                     return true
                  end
               end
            end
         end
      end
      if tFind["ObjectHerb"] then
         if
            UnitName("mouseover") == nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == false
         then
            taTextLeft1InObjects = taTextLeft1InObjectsCheck()
            if taTextLeft1InObjects then
               for x = 1, #SkuCore.RessourceTypes.herbs do
                  if SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]] == aTextLeft1 then
                     if SkuOptions.db.profile[MODULE_NAME].ressourceScanning.herbs[x] == true then
                        SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
                        GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
                        return true
                     end
                  end
               end
            end
         end
      end
      if tFind["ObjectVein"] then
         if
            UnitName("mouseover") == nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == false
         then
            taTextLeft1InObjects = taTextLeft1InObjectsCheck()
            if taTextLeft1InObjects then
               for x = 1, #SkuCore.RessourceTypes.mining do
                  if SkuCore.RessourceTypes.mining[x][Sku.L["locale"]] == aTextLeft1 then
                     if SkuOptions.db.profile[MODULE_NAME].ressourceScanning.miningNodes[x] == true then
                        SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
                        GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
                        return true
                     end
                  end
               end
            end
         end
      end
      if tFind["Bobber"] then
         if
            UnitName("mouseover") == nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == false and
            aTextLeft1 == L["Fishing Bobber"]
         then
            SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1] = aTextLeft1
            SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
            GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
            return true
         end
      end
      if tFind["ObjectUsable"] then
         if
            UnitName("mouseover") == nil and
            tIsCursorUpdate == true and
            tIsUpdateMouseoverUnitFrame == false
         then
            taTextLeft1InObjects = taTextLeft1InObjectsCheck()
            if taTextLeft1InObjects then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end
      if tFind["ObjectAny"] then
         if
            UnitName("mouseover") == nil and
            tIsUpdateMouseoverUnitFrame == false
         then
            taTextLeft1InObjects = taTextLeft1InObjectsCheck()
            if taTextLeft1InObjects then
               SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
               GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
               return true
            end
         end
      end

      if tFind["Any"] then
         SkuCore.gameWorldObjectsScanFrame.found[aTextLeft1..tId] = true
         GameWorldObjectsVoiceOutput(tOutputText, tSoundFile)
         return true
      end

   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GameWorldObjectsScan(aContinue, aFindList, aHStepSizeDeg, aHStepsMax, aVMoveSpeed, aVStepsMax, aCallback, aHStart)
   dprint("GameWorldObjectsScan", aContinue, aFindList, aHStepSizeDeg, aHStepsMax, aVMoveSpeed, aVStepsMax, aCallback, aHStart)
   local tFrame = _G["SkuCoreGameWorldObjectsScanTicker"] or CreateFrame("Frame", "SkuCoreGameWorldObjectsScanTicker", _G["UIParent"])
   tFrame:SetSize(1, 1)
   tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)

   SkuCore.gameWorldObjectsScanFrame = tFrame

   if aContinue == true and tFrame.isScanningActive ~= true then
      return
   end

   if aContinue ~= true and tFrame.isScanningActive == true then
      SkuCore:GameWorldObjectsRestoreView()
   end

   tFrame.stopUpFlag = false
   if aContinue ~= true then
      tFrame.findList = aFindList
      tFrame.oldCameraPitchMoveSpeed = GetCVar("cameraPitchMoveSpeed")
      tFrame.hStepSizeDeg = aHStepSizeDeg
      tFrame.hStepsMax = aHStepsMax
      tFrame.vMoveSpeed = aVMoveSpeed
      tFrame.vStepsMax = aVStepsMax
      tFrame.callback = aCallback
      tFrame.found = {}
   end
      
   tFrame:SetScript("OnUpdate", function(self, time)
      if self.isScanningActive == true and self.isScanningPaused == false then
         if self.stopUpFlag == true then
            self.stopUpFlag = false
            MoveViewUpStop()
         end
   
         self.isScanningPaused = true
         local tTextLeft1 = _G["GameTooltipTextLeft1"]:GetText()
         local tTextLeft2 = _G["GameTooltipTextLeft2"]:GetText()
         local tTextLeft3 = _G["GameTooltipTextLeft3"]:GetText()
         GameTooltip:ClearLines()
         --GameTooltip:Hide()

         local t = (self.hStepSizeDeg * self.CameraYawMod) * (((self.DownSteps + 1) / self.vStepsMax) * 0.75)
         dprint(t, self.hStepSizeDeg * self.CameraYawMod, ((self.DownSteps + 1) / self.vStepsMax), (((self.DownSteps + 1) / self.vStepsMax) * 5), self.DownSteps, self.vStepsMax)
         if tTextLeft1 and SkuCore:GameWorldObjectsCheckResult(tTextLeft1, tTextLeft2, tTextLeft3) then
            MoveViewUpStop()
            FlipCameraYaw((t) * -1)
            self.CameraYaw = self.CameraYaw + ((t) * -1)
            if self.callback then
               self.callback(tTextLeft1)
            end
            SkuOptions:StartStopBackgroundSound(false)
         else
            self.isScanningPaused = false
   
            FlipCameraYaw(t)
            self.CameraYaw = self.CameraYaw + t
   
            if self.CameraYaw >= (self.hStepSizeDeg * self.hStepsMax + self.DownSteps * 5)  or self.CameraYaw <= -(self.hStepSizeDeg * self.hStepsMax + self.DownSteps * 5) then
               self.CameraYawMod = self.CameraYawMod * -1
               self.DownSteps = self.DownSteps + 1
               SetCVar("cameraPitchMoveSpeed", self.vMoveSpeed)
               MoveViewUpStart(1)      
               self.stopUpFlag = true
               
               if self.DownSteps > self.vStepsMax then
                  SkuCore:GameWorldObjectsRestoreView()
               end
            end
         end
      end
   end)
   tFrame:Show()

   SkuCore.noMouseOverNotification = true

   if aContinue ~= true then
      SetView(2)
      SkuCore:GameWorldObjectsCenterMouseCursor(aHStart)
      tFrame.CameraYawMod = 1
      tFrame.CameraYaw = 0
      tFrame.DownSteps = 0
   end

   tResetRequired = true
   --[[
   if Questie_BaseFrame and SkuCore.inCombat == false then
      Questie_BaseFrame:Hide()
   end
   ]]

   tFrame.isScanningActive = true
   SkuOptions:StartStopBackgroundSound(true, SkuOptions.db.profile["SkuCore"].scanBackgroundSound)
   tFrame.isScanningPaused = false
end
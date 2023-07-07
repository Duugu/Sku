local MODULE_NAME, MODULE_PART = "SkuCore", "TurnToUnit"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.TurnToUnit = {
   searching = false,
   time = -1,
   CameraZoomSpeed = C_CVar.GetCVar("cameraZoomSpeed"),
   CameraZoom = GetCameraZoom(),
   unit = nil,
   gameMarker = nil,
   skuMarker = nil,
}

SkuCore.TurnToUnit.availableTargetsListNames = {
   [1] = "target",
   [2] = "party member 1",
   [3] = "party member 2",
   [4] = "party member 3",
   [5] = "party member 4",
	[6] = "raid marker "..L["Star"],
	[7] = "raid marker "..L["Circle"],
	[8] = "raid marker "..L["Diamond"],
	[9] = "raid marker "..L["Triangle"],
	[10] = "raid marker "..L["Moon"],
	[11] = "raid marker "..L["Square"],
	[12] = "raid marker "..L["Cross"],
	[13] = "raid marker "..L["Skull"],
   [14] = "sku marker "..L["Yellow"],
   [15] = "sku marker "..L["Orange"],
   [16] = "sku marker "..L["Purple"],
   [17] = "sku marker "..L["Green"],
   [18] = "sku marker "..L["Grey"],
   [19] = "sku marker "..L["Blue"],
   [20] = "sku marker "..L["Red"],
   [21] = "sku marker "..L["White"],
   [22] = "nothing",

}

SkuCore.TurnToUnit.availableTargetsList = {
   ["target"] = {"target", nil, nil,},
   ["party member 1"] = {"party1", nil, nil,},
   ["party member 2"] = {"party2", nil, nil,},
   ["party member 3"] = {"party3", nil, nil,},
   ["party member 4"] = {"party4", nil, nil,},
	["raid marker "..L["Star"]] = {nil, 1, nil,},
	["raid marker "..L["Circle"]] = {nil, 2, nil,},
	["raid marker "..L["Diamond"]] = {nil, 3, nil,},
	["raid marker "..L["Triangle"]] = {nil, 4, nil,},
	["raid marker "..L["Moon"]] = {nil, 5, nil,},
	["raid marker "..L["Square"]] = {nil, 6, nil,},
	["raid marker "..L["Cross"]] = {nil, 7, nil,},
	["raid marker "..L["Skull"]] = {nil, 8, nil,},
   ["sku marker "..L["Yellow"]] = {nil, nil, 1,},
   ["sku marker "..L["Orange"]] = {nil, nil, 2,},
   ["sku marker "..L["Purple"]] = {nil, nil, 3,},
   ["sku marker "..L["Green"]] = {nil, nil, 4,},
   ["sku marker "..L["Grey"]] = {nil, nil, 5,},
   ["sku marker "..L["Blue"]] = {nil, nil, 6,},
   ["sku marker "..L["Red"]] = {nil, nil, 7,},
   ["sku marker "..L["White"]] = {nil, nil, 8,},
   ["nothing"] = {nil, nil, nil,},
}

---------------------------------------------------------------------------------------------------------------------------------------
local function StopSearch()
   SkuCore.TurnToUnit.time = -1
   SkuCore.TurnToUnit.searching = false
   SkuCore.TurnToUnit.unit = nil
   SkuCore.TurnToUnit.gameMarker = nil
   SkuCore.TurnToUnit.skuMarker = nil

   MoveViewRightStart(0)
   MoveViewUpStart(0)
   MoveViewDownStart(0)
   MouselookStart()
   MouselookStop() 
   CameraZoomOut(SkuCore.TurnToUnit.CameraZoom)
   C_CVar.SetCVar("cameraZoomSpeed", SkuCore.TurnToUnit.CameraZoomSpeed)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreateControlFrame()
   local f = _G["SkuCoreTurnToUnitControl"] or CreateFrame("Frame", "SkuCoreTurnToUnitControl", UIParent)
   local ttime = 0

   f:SetScript("OnUpdate", function(self, time)
      if SkuCore.TurnToUnit.searching == true then
         if SkuCore.TurnToUnit.time ~= -1 then
            ttime = ttime + time
            if ttime > SkuCore.TurnToUnit.time then
               StopSearch()
               dprint("found nothing")
               SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].turnToUnit.soundOnFail, {overwrite = false, wait = false, length = 0.3, doNotOverwrite = true,})
               ttime = 0
               return
            end
            if UnitName("mouseover") then
               local tFound = false
               if SkuCore.TurnToUnit.unit and UnitIsUnit("mouseover", SkuCore.TurnToUnit.unit) then
                  tFound = true
               elseif SkuCore.TurnToUnit.gameMarker and GetRaidTargetIndex("mouseover") and SkuCore.TurnToUnit.gameMarker == GetRaidTargetIndex("mouseover") then
                  tFound = true
               elseif SkuCore.TurnToUnit.skuMarker and SkuCore:aqCombatGetSkuRaidTarget(UnitGUID("mouseover")) == SkuCore.TurnToUnit.skuMarker then
                  tFound = true
               end      
               if tFound == true then
                  StopSearch()
                  dprint("found mouseover")
                  SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].turnToUnit.soundOnSuccess, {overwrite = false, wait = false, length = 0.3, doNotOverwrite = true,})
                  ttime = 0
                  return
               end
            end
         end      
         return
      end

      ttime = 0
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnitOnInitialize()
	CreateControlFrame()
   SkuDispatcher:RegisterEventCallback("NAME_PLATE_UNIT_ADDED", SkuCore.TurnToUnit_NAME_PLATE_UNIT_ADDED)
   SkuDispatcher:RegisterEventCallback("UPDATE_MOUSEOVER_UNIT", SkuCore.TurnToUnit_UPDATE_MOUSEOVER_UNIT)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnitOnLogin()
   SetCVar("nameplateMaxDistance", 41)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnit_UPDATE_MOUSEOVER_UNIT(aEvent)
   if SkuCore.TurnToUnit.searching == true then
      if SkuCore.TurnToUnit.time ~= -1 then
         local tFound = false
         if SkuCore.TurnToUnit.unit and UnitIsUnit("mouseover",  SkuCore.TurnToUnit.unit) then
            dprint("found UPDATE_MOUSEOVER_UNIT")
            tFound = true
         end

         if UnitName("mouseover") then
            if SkuCore.TurnToUnit.gameMarker and GetRaidTargetIndex("mouseover") and SkuCore.TurnToUnit.gameMarker == GetRaidTargetIndex("mouseover") then
               tFound = true
            end
            if SkuCore.TurnToUnit.skuMarker then
               if SkuCore:aqCombatGetSkuRaidTarget(UnitGUID("mouseover")) == SkuCore.TurnToUnit.skuMarker then
                  tFound = true
               end
            end      
         end

         if tFound == true then
            StopSearch()
            SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].turnToUnit.soundOnSuccess, {overwrite = false, wait = false, length = 0.3, doNotOverwrite = true,})            
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnit_NAME_PLATE_UNIT_ADDED(aEvent, aNameplateId)
   if SkuCore.TurnToUnit.searching == true then
      local tFound = false
      if SkuCore.TurnToUnit.unit then
         if C_NamePlate.GetNamePlateForUnit(SkuCore.TurnToUnit.unit) then 
            if aNameplateId == C_NamePlate.GetNamePlateForUnit(SkuCore.TurnToUnit.unit).UnitFrame.unit then
               tFound = true
            end
         end
      end

      local tUnitFrame = C_NamePlate.GetNamePlateForUnit(aNameplateId).UnitFrame
      if SkuCore.TurnToUnit.gameMarker and GetRaidTargetIndex(aNameplateId) and SkuCore.TurnToUnit.gameMarker == GetRaidTargetIndex(aNameplateId) then
         tFound = true
      end

      if SkuCore.TurnToUnit.skuMarker then
         if SkuCore:aqCombatGetSkuRaidTarget(UnitGUID(aNameplateId)) == SkuCore.TurnToUnit.skuMarker then
            tFound = true
         end
      end      

      if tFound == true then
         dprint("found NAME_PLATE")
         SkuCore.TurnToUnit.time = -1
         SkuCore.TurnToUnit.searching = false
         SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].turnToUnit.soundOnSuccess, {overwrite = false, wait = false, length = 0.3, doNotOverwrite = true,})
         C_Timer.After((0.4 / SkuOptions.db.profile[MODULE_NAME].turnToUnit.enhancedSettings.delayOnPlate) / SkuOptions.db.profile[MODULE_NAME].turnToUnit.speed, function()
            StopSearch()
         end)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnitStartTuring(aUnitId, aGameMarker, aSkuMarker)
   if (aUnitId and UnitName(aUnitId) == nil) or SkuCore.TurnToUnit.searching == true then
      SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].turnToUnit.soundOnFail, {overwrite = false, wait = false, length = 0.3, doNotOverwrite = true,})
      return
   end

   SetCVar("CursorCenteredYPos", 0.6)
   SetCVar("CursorFreelookCentering", 1)
   SetCVar("CursorStickyCentering", 1)
   MouselookStart()
   C_Timer.After(0.01, function() 
      MouselookStop()
      SetCVar("CursorFreelookCentering", 0)
      SetCVar("CursorStickyCentering", 0)

      C_Timer.After(0.01, function() 
         SkuCore.TurnToUnit.unit = aUnitId
         SkuCore.TurnToUnit.gameMarker = aGameMarker
         SkuCore.TurnToUnit.skuMarker = aSkuMarker
      
         SkuCore.TurnToUnit.searching = true
         SkuCore.TurnToUnit.time = 1.5 / SkuOptions.db.profile[MODULE_NAME].turnToUnit.speed
         SetView(2)
         SkuCore.TurnToUnit.CameraZoom = GetCameraZoom()
         SkuCore.TurnToUnit.CameraZoomSpeed = C_CVar.GetCVar("cameraZoomSpeed")
         C_CVar.SetCVar("cameraZoomSpeed", 1000)
      
         CameraZoomIn(50)
         MoveViewRightStart(1 * SkuOptions.db.profile[MODULE_NAME].turnToUnit.speed)
         MoveViewDownStart(0)
         MoveViewUpStart(0)
      end)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TurnToUnitTurn180()
   if SkuCore.TurnToUnit.searching == true then
      return
   end

   SkuCore.TurnToUnit.searching = true
   MoveViewRightStart(6.7)
   MoveViewDownStart(0)
   MoveViewUpStart(0)
   C_Timer.After(0.1, function()
      SkuCore.TurnToUnit.searching = false
      MoveViewRightStart(0)
      MoveViewUpStart(0)
      MoveViewDownStart(0)
      MouselookStart()
      MouselookStop() 
   end)
end


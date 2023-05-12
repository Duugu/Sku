---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "tanking"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.RaidTargetValues = {
	[1] = {name = L["Star"], color = L["Yellow"]},
	[2] = {name = L["Circle"], color = L["Orange"]},
	[3] = {name = L["Diamond"], color = L["Purple"]},
	[4] = {name = L["Triangle"], color = L["Green"]},
	[5] = {name = L["Moon"], color = L["Grey"]},
	[6] = {name = L["Square"], color = L["Blue"]},
	[7] = {name = L["Cross"], color = L["Red"]},
	[8] = {name = L["Skull"], color = L["White"]},
}

SkuCore.SkuRaidTargetIndex = {
	[1] = 8,
	[2] = 7,
	[3] = 6,
	[4] = 4,
	[5] = 3,
	[6] = 1,
	[7] = 2,
	[8] = 5,
}

local tUnitsToTestOnGameRaidTargets = {
   "player",
   "pet",
   "focus",
   "target",
   "pettarget",
   "focustarget",
   "playertargettarget",
   "pettargettarget",
   "focustargettarget",
   "targettarget",
}
for x = 1, 4 do
   table.insert(tUnitsToTestOnGameRaidTargets, "party"..x)
   table.insert(tUnitsToTestOnGameRaidTargets, "partypet"..x)
   table.insert(tUnitsToTestOnGameRaidTargets, "party"..x.."target")
   table.insert(tUnitsToTestOnGameRaidTargets, "partypet"..x.."target")
   table.insert(tUnitsToTestOnGameRaidTargets, "party"..x.."targettarget")
   table.insert(tUnitsToTestOnGameRaidTargets, "partypet"..x.."targettarget")

end
for x = 1, 40 do
   table.insert(tUnitsToTestOnGameRaidTargets, "raid"..x)
   table.insert(tUnitsToTestOnGameRaidTargets, "raidpet"..x)
   table.insert(tUnitsToTestOnGameRaidTargets, "raid"..x.."target")
   table.insert(tUnitsToTestOnGameRaidTargets, "raidpet"..x.."target")
   table.insert(tUnitsToTestOnGameRaidTargets, "raid"..x.."targettarget")
   table.insert(tUnitsToTestOnGameRaidTargets, "raidpet"..x.."targettarget")
end
for x = 1, 40 do
   table.insert(tUnitsToTestOnGameRaidTargets, "nameplate"..x)
end


SkuCore.SkuRaidTargetRepo = {
	--[unitGUID] = SkuRaidTargetIndex,
}
SkuCore.SkuRaidTargetRepoDead = {
	--[unitGUID] = SkuRaidTargetIndex,
}

SkuCore.tanking = {}


---------------------------------------------------------------------------------------------------------------------------------------
local function TankingCreateControlFrame()
   local f = _G["SkuCoreTankingControl"] or CreateFrame("Frame", "SkuCoreTankingControl", UIParent)
   local ttime = 0

   f:SetScript("OnUpdate", function(self, time)
      ttime = ttime + time
      if ttime < 0.1 then
         return
      end


      --clearnup lost guids from SkuCore.SkuRaidTargetRepo?




      ttime = 0
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingOnInitialize()
	TankingCreateControlFrame()

   SkuDispatcher:RegisterEventCallback("COMBAT_LOG_EVENT_UNFILTERED", SkuCore.Tanking_COMBAT_LOG_EVENT_UNFILTERED)
   SkuDispatcher:RegisterEventCallback("SKU_UNIT_DIED", SkuCore.Tanking_SKU_UNIT_DIED)
   SkuDispatcher:RegisterEventCallback("PLAYER_ENTERING_WORLD", SkuCore.Tanking_PLAYER_ENTERING_WORLD)
   SkuDispatcher:RegisterEventCallback("RAID_TARGET_UPDATE", SkuCore.TankingCheckGameRaidTargets)
	SkuDispatcher:RegisterEventCallback("PLAYER_REGEN_DISABLED", SkuCore.Tanking_PLAYER_REGEN_DISABLED)
	SkuDispatcher:RegisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.Tanking_PLAYER_REGEN_ENABLED)
	SkuDispatcher:RegisterEventCallback("UNIT_THREAT_LIST_UPDATE", SkuCore.TankingUNIT_THREAT_LIST_UPDATE)
	SkuDispatcher:RegisterEventCallback("UNIT_THREAT_SITUATION_UPDATE", SkuCore.TankingUNIT_THREAT_SITUATION_UPDATE)

   hooksecurefunc("SetRaidTarget", function(aUnit, aIconIndex)
      if aIconIndex == 0 then
         local tGUID = UnitGUID(aUnit)
         if tGUID then
            SkuCore:TankingSetSkuRaidTarget(tGUID)
         end
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingOnLogin()
	SkuOptions.db.char[MODULE_NAME].tanking = SkuOptions.db.char[MODULE_NAME].tanking or {}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingUNIT_THREAT_LIST_UPDATE(aEven, aUnitId)
   --print("TankingUNIT_THREAT_LIST_UPDATE", aEven, aUnitId)
   for i = 1, #tUnitsToTestOnGameRaidTargets do
      local tguid = UnitGUID(tUnitsToTestOnGameRaidTargets[i])
      if tguid then
         local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation("player", tUnitsToTestOnGameRaidTargets[i])
         if status then
            --print(" ", i, tUnitsToTestOnGameRaidTargets[i], isTanking, status, scaledPercentage, rawPercentage, threatValue)

         end
      end
   end

   local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation("player", aUnitId)
   if status == nil then
      --print(" unit left combat", aUnitId)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingUNIT_THREAT_SITUATION_UPDATE(aEven, aUnitId)
   --print("TankingUNIT_THREAT_SITUATION_UPDATE", aEven, aUnitId)
   for i = 1, #tUnitsToTestOnGameRaidTargets do
      local tguid = UnitGUID(tUnitsToTestOnGameRaidTargets[i])
      if tguid then
         local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation("player", tUnitsToTestOnGameRaidTargets[i])
         if status then
            --print(" ", i, tUnitsToTestOnGameRaidTargets[i], isTanking, status, scaledPercentage, rawPercentage, threatValue)
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Tanking_COMBAT_LOG_EVENT_UNFILTERED()
   local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18 = CombatLogGetCurrentEventInfo()
   --print(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Tanking_SKU_UNIT_DIED(aEvent, aUnitGUID)
   dprint("Tanking_SKU_UNIT_DIED", aUnitGUID)
   
   if SkuCore.SkuRaidTargetRepo[aUnitGUID] then
      local tIndex = SkuCore.SkuRaidTargetRepo[aUnitGUID]
      SkuCore.SkuRaidTargetRepoDead[aUnitGUID] = tIndex
      SkuCore.SkuRaidTargetRepo[aUnitGUID] = nil
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Tanking_PLAYER_REGEN_DISABLED()


end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Tanking_PLAYER_REGEN_ENABLED()
   SkuCore:TankingClearSkuRaidTargets()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Tanking_PLAYER_ENTERING_WORLD()


end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingGetSkuRaidTarget(aUnitGUID)
   dprint("TankingGetSkuRaidTarget", aUnitGUID)
   for i, v in pairs(SkuCore.SkuRaidTargetRepo) do
      if i == aUnitGUID then
         return v
      end
   end
   for i, v in pairs(SkuCore.SkuRaidTargetRepoDead) do
      if i == aUnitGUID then
         return v, true
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingSetSkuRaidTarget(aUnitGUID, aRaidTargetId)
   if not aUnitGUID then
      return
   end

   dprint("TankingSetSkuRaidTarget", aUnitGUID, aRaidTargetId)

   if aRaidTargetId == nil then
      --clear
      if SkuCore.SkuRaidTargetRepo[aUnitGUID] then
         SkuCore.SkuRaidTargetRepo[aUnitGUID] = nil
         return true
      end
      if SkuCore.SkuRaidTargetRepoDead[aUnitGUID] then
         SkuCore.SkuRaidTargetRepoDead[aUnitGUID] = nil
         return true
      end
   elseif aRaidTargetId == 0 then
      for x = 1, #SkuCore.SkuRaidTargetIndex do
         local tAvailable = true
         for i, v in pairs(SkuCore.SkuRaidTargetRepo) do
            if v == SkuCore.SkuRaidTargetIndex[x] then
               tAvailable = false
            end
         end
         for i, v in pairs(SkuCore.SkuRaidTargetRepoDead) do
            if v == SkuCore.SkuRaidTargetIndex[x] then
               tAvailable = false
            end
         end
         if tAvailable == true then
            SkuCore.SkuRaidTargetRepo[aUnitGUID] = SkuCore.SkuRaidTargetIndex[x]
            return SkuCore.SkuRaidTargetIndex[x]
         end
      end
   elseif aRaidTargetId > 0 then
      --raid target index
      SkuCore.SkuRaidTargetRepo[aUnitGUID] = nil
      SkuCore.SkuRaidTargetRepoDead[aUnitGUID] = nil
      SkuCore.SkuRaidTargetRepo[aUnitGUID] = aRaidTargetId
      return aRaidTargetId
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingClearSkuRaidTargets()
   dprint("TankingClearSkuRaidTargets")
   SkuCore.SkuRaidTargetRepo = {}
   SkuCore.SkuRaidTargetRepoDead = {}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingCheckGameRaidTargets()
   dprint("TankingCheckGameRaidTargets")
   for i = 1, #tUnitsToTestOnGameRaidTargets do
      local tguid = UnitGUID(tUnitsToTestOnGameRaidTargets[i])
      if tguid then
         local tRti = GetRaidTargetIndex(tUnitsToTestOnGameRaidTargets[i])
         if tRti then
            SkuCore.SkuRaidTargetRepo[tguid] = nil
            SkuCore.SkuRaidTargetRepoDead[tguid] = nil
            break
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TankingMenuBuilder()
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"In development"}, SkuGenericMenuItem)

   --[[
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["In Combat"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)




   end
   ]]
end
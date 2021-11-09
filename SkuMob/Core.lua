local MODULE_NAME = "SkuMob"
local ADDON_NAME = ...
local _G = _G

---------------------------------------------------------------------------------------------------------------------------------------
SkuMob = LibStub("AceAddon-3.0"):NewAddon("SkuMob", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SkuMob", false)


---------------------------------------------------------------------------------------------------------------------------------------

local SkuMobDB = {
	lastTargetGuid = 0,
	nextAudioQ = "",
	lastAudioQ = "",
	soundFiles = {
		--[100] = [[Interface\AddOns\SkuAudioData\assets\audio\no^00.mp3]],
		--[90] = [[Interface\AddOns\SkuAudioData\assets\audio\no-90.mp3]],
		--[80] = [[Interface\AddOns\SkuAudioData\assets\audio\no-80.mp3]],
		--[70] = [[Interface\AddOns\SkuAudioData\assets\audio\no-70.mp3]],
		--[60] = [[Interface\AddOns\SkuAudioData\assets\audio\no-60.mp3]],
		--[50] = [[Interface\AddOns\SkuAudioData\assets\audio\no-50.mp3]],
		--[40] = [[Interface\AddOns\SkuAudioData\assets\audio\no-40.mp3]],
		--[30] = [[Interface\AddOns\SkuAudioData\assets\audio\no-30.mp3]],
		--[20] = [[Interface\AddOns\SkuAudioData\assets\audio\no-20.mp3]],
		--[10] = [[Interface\AddOns\SkuAudioData\assets\audio\no-10.mp3]],
		--[0] = [[Interface\AddOns\SkuAudioData\assets\audio\no-0.mp3]],
		--["tot"] = [[Interface\AddOns\SkuAudioData\assets\audio\tot.mp3]],
		[100] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-09.mp3]],
		[90] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-08.mp3]],
		[80] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-07.mp3]],
		[70] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-06.mp3]],
		[60] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-05.mp3]],
		[50] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-04.mp3]],
		[40] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-03.mp3]],
		[30] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-02.mp3]],
		[20] = [[Interface\AddOns\SkuAudioData\assets\audio\021321052314.mp3]],
		[10] = [[Interface\AddOns\SkuAudioData\assets\audio\021321052311.mp3]],
		[0] = [[Interface\AddOns\SkuAudioData\assets\audio\female2--0.mp3]],
		["tot"] = [[Interface\AddOns\SkuAudioData\assets\audio\0805210501-10.mp3]],
		},
	}

local SkuMobRaidTargetStrings = {
	[1] = "stern",
	[2] = "kreis",
	[3] = "diamant",
	[4] = "dreieck",
	[5] = "mond",
	[6] = "quadrat",
	[7] = "kreuz",
	[8] = "kopf",
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnInitialize()
	--print("SkuMob OnInitialize")
	SkuMob:RegisterEvent("VARIABLES_LOADED")
	SkuMob:RegisterEvent("PLAYER_TARGET_CHANGED")
	SkuMob:RegisterEvent("QUEST_TURNED_IN")


end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnEnable()
	--print("SkuMob OnEnable")
	-- Called when the addon is enabled
	local ttime = 0
	local f = _G["SkuMobControl"] or CreateFrame("Frame", "SkuMobControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
		if SkuOptions.db.profile[MODULE_NAME].enable == true then
 			ttime = ttime + time 
			if ttime > 0.25 then 
				
				if UnitGUID("target") then
					if UnitCanAttack("player","target") ~= false then
						local hp = math.floor(UnitHealth("target") / (UnitHealthMax("target") / 100))
						local hpPer = math.floor(((hp / 10)) + 1) * 10
						if hpPer < 100 and hpPer > 0 then
							if hpPer > 100 then hpPer = 100 end
							if hpPer < 10 then hpPer = 0 end
							if hp == 0 then hpPer = 0 end

							if (UnitGUID("target") ~= SkuMobDB.lastTargetGuid) then
								SkuMobDB.nextAudioQ = hpPer--SkuMobDB.soundFiles[hpPer]
							end
							
							if  (SkuMobDB.nextAudioQ ~= hpPer) then
								SkuMobDB.nextAudioQ = hpPer
							end
							
							if SkuMobDB.nextAudioQ ~= "" then
								if (SkuMobDB.nextAudioQ ~= SkuMobDB.lastAudioQ) or (UnitGUID("target") ~= SkuMobDB.lastTargetGuid) then
									Voice:OutputString(SkuMobDB.nextAudioQ, false, false, 0.3)
									SkuMobDB.lastAudioQ = SkuMobDB.nextAudioQ
									SkuMobDB.nextAudioQ = ""
								end
							end
						end
							
						SkuMobDB.lastTargetGuid = UnitGUID("target")
					end
				else
					SkuMobDB.lastTargetGuid = 0
					SkuMobDB.nextAudioQ = ""
					SkuMobDB.lastAudioQ = ""
				end
				
				ttime = 0 
			end 
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnDisable()
	-- Called when the addon is disabled
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:RefreshVisuals()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:VARIABLES_LOADED(...)
	-- process the event
  --print(...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:QUEST_TURNED_IN(...)
	-- process the event
	SkuMob.QuestTurnedIn = true
	C_Timer.After(5, function()
		SkuMob.QuestTurnedIn = false
		SkuOptions:SendTrackingStatusUpdates()
	end)
	SkuOptions:SendTrackingStatusUpdates("I-1")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:PLAYER_TARGET_CHANGED(arg1, arg2)
	if not UnitExists("target") then
		return
	end

	if UnitIsPlayer("target") == true then
		return
	end
	
	local tUnitName = GetUnitName("target", false)
	local tUnitLevel = UnitLevel("target")
	local tUnitIsEnemy = UnitIsEnemy("player","target")
	local tUnitIsFriend = UnitIsFriend("player","target")
	local tCreatureType = UnitCreatureType("target")
	local tCreatureFamily = UnitCreatureFamily("target")
	local tClassification = UnitClassification("target")
	local tInteractDistance = CheckInteractDistance("target", 4)
	local tUnitReaction = UnitReaction("player", "target")
		--[[
		1 Exceptionally hostile
		2 Very Hostile
		3 Hostile
		4 Neutral
		5 Friendly
		6 Very Friendly
		7 Exceptionally friendly
		8 Exalted
		]]

	--threat meter
	local status = UnitThreatSituation("player", "target")
	--print(tUnitLevel, tUnitIsEnemy, tUnitIsFriend, tCreatureType, tCreatureFamily, tClassification, tInteractDistance, tUnitReaction, status, isTanking, status, threatpct, rawthreatpct, threatvalue)
	if status then
		local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target") --https://wowwiki-archive.fandom.com/wiki/API_UnitDetailedThreatSituation
		--local statustxts = { "low on threat",  "overnuking", "losing threat", "tanking securely" }
		--print("You are " .. statustxts[status + 1] .. ".")
	end

	--target in combat indicator
	local tRosterNames = {}
	for x = 1, 4 do
		local name, realm = UnitName("party"..x)
		if name then
			tRosterNames[name] = name
		end
	end
	for x = 1, 40 do
		local name, realm = UnitName("raid"..x)
		if name then
			tRosterNames[name] = name
		end
	end
	local name, realm = UnitName("pet")
	if name then
		tRosterNames[name] = name
	end
	local name, realm = UnitName("player")
	tRosterNames[name] = name

	local status = nil
	for x = 1, 4 do
		if UnitThreatSituation("party"..x, "target") then
			status = UnitThreatSituation("party"..x, "target")
		end
	end
	for x = 1, 40 do
		if UnitThreatSituation("raid"..x, "target") then
			status = UnitThreatSituation("raid"..x, "target")
		end
	end
	if UnitThreatSituation("pet", "target") then
		status = UnitThreatSituation("pet", "target")
	end
	if UnitThreatSituation("player", "target") then
		status = UnitThreatSituation("player", "target")
	end

	local name, realm = UnitName("targettarget")
	if name then
		if tRosterNames[name] then
			status = true
		end
	end

	if status then
		--creature in combat indicator
		local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
	end

	--raidtarget
	local tRaidtarget = GetRaidTargetIndex("target")
	local tRaidTargetString = ""
	if tRaidtarget then
		if SkuMobRaidTargetStrings[tRaidtarget] then
			tRaidTargetString = SkuMobRaidTargetStrings[tRaidtarget]..";"
		end
	end
	
	local hp = math.floor(UnitHealth("target") / (UnitHealthMax("target") / 100))
	if hp == 0 then
		Voice:OutputString("tot", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		Voice:OutputString(tUnitName, false, true, 0.8)-- file: string, reset: bool, wait: bool, length: int
	else
		if tRaidTargetString ~= "" and SkuOptions.db.profile["SkuMob"].vocalizeRaidTargetOnly == true then
			Voice:OutputString(tRaidTargetString, true, true, 0.8)-- file: string, reset: bool, wait: bool, length: int
		else
			Voice:OutputString(tRaidTargetString..tUnitName, true, true, 0.8)-- file: string, reset: bool, wait: bool, length: int
		end
	end
	
	
	local tClassification = UnitClassification("target") or ""
	local tClassifications = {
		["worldboss"] = "Weltboss", 
		["rareelite"] = "Rare Elite", 
		["elite"] = "Elite", 
		["rare"] = "Rare", 
		["normal"] = "", 
		["trivial"] = "", 
		["minus"] = "",
	}

	--if SkuMobData[tUnitName] then
	if tRaidTargetString == "" or SkuOptions.db.profile["SkuMob"].vocalizeRaidTargetOnly == false then
		if tUnitLevel then
			if tUnitLevel ~= -1 then
				Voice:OutputString("level", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
				Voice:OutputString(string.format("%02d", tUnitLevel).." "..tClassifications[tClassification], false, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
			else
				Voice:OutputString("level", false, true, 2.2)-- file: string, reset: bool, wait: bool, length: int
				Voice:OutputString("unbekannt", false, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
			end
		end
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
		GameTooltip:SetUnit("target")
		GameTooltip:Show()
		local left = _G["GameTooltipTextLeft" .. 2]
		if left then
			local tLineTwoText = left:GetText()
			if tLineTwoText then
				if tLineTwoText ~= "" then
					if not string.find(tLineTwoText, "Stufe") then
						Voice:OutputString(tLineTwoText, false, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
					end
				end
			end
		end
	--end
	end
end


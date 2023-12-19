local MODULE_NAME = "SkuMob"
local _G = _G

---------------------------------------------------------------------------------------------------------------------------------------
SkuMob = LibStub("AceAddon-3.0"):NewAddon("SkuMob", "AceConsole-3.0", "AceEvent-3.0")
local L = Sku.L


---------------------------------------------------------------------------------------------------------------------------------------

local SkuMobDB = {
	lastTargetGuid = 0,
	nextAudioQ = "",
	lastAudioQ = "",
	soundFiles = {
		[100] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-09.mp3]],
		[90] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-08.mp3]],
		[80] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-07.mp3]],
		[70] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-06.mp3]],
		[60] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-05.mp3]],
		[50] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-04.mp3]],
		[40] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-03.mp3]],
		[30] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-02.mp3]],
		[20] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\021321052314.mp3]],
		[10] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\021321052311.mp3]],
		[0] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\female2--0.mp3]],
		[L["dead"]] = [[Interface\AddOns\]]..Sku.AudiodataPath..[[\assets\audio\0805210501-10.mp3]],
		},
	}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnInitialize()
	SkuMob:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuMob:RegisterEvent("VARIABLES_LOADED")
	SkuMob:RegisterEvent("PLAYER_TARGET_CHANGED")
	SkuMob:RegisterEvent("QUEST_TURNED_IN")
	SkuMob:RegisterEvent("PLAYER_SOFT_ENEMY_CHANGED")
	SkuMob:RegisterEvent("PLAYER_SOFT_FRIEND_CHANGED")
	SkuMob:RegisterEvent("PLAYER_SOFT_INTERACT_CHANGED")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OutputTargetHealth(aForce)
	if UnitGUID("target") then
		if UnitCanAttack("player","target") ~= false then
			if aForce then
				SkuMobDB.lastAudioQ = ""
			end

			local hp = math.floor(UnitHealth("target") / (UnitHealthMax("target") / 100))
			local hpPer = math.floor(((hp / 10)) + 1) * 10
			if (hpPer < 100 and hpPer > 0) or aForce then
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
						SkuOptions.Voice:OutputString(SkuMobDB.nextAudioQ, false, false, 0.3)
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

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnEnable()
	local ttime = 0
	local f = _G["SkuMobControl"] or CreateFrame("Frame", "SkuMobControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
		ttime = ttime + time 
		if ttime > 0.25 then 
			if SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled == true then
				if UnitExists("target") == true then
					if SkuOptions.db.profile["SkuOptions"].softTargeting.matchLocked == 1 or (SkuOptions.db.profile["SkuOptions"].softTargeting.matchLocked == 2 and UnitCanAttack("player", "target") == true) then
						SkuMob.interactTempDisabled = true
						SkuOptions:UpdateSoftTargetingSettings("all")
					else
						SkuMob.interactTempDisabled = nil
						SkuOptions:UpdateSoftTargetingSettings("all")
					end
				else
					SkuMob.interactTempDisabled = nil
					SkuOptions:UpdateSoftTargetingSettings("all")
				end
			end

			SkuMob:OutputTargetHealth()
			
			ttime = 0 
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
function SkuMob:PLAYER_ENTERING_WORLD(...)
	

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:VARIABLES_LOADED(...)
	SkuMob.InCombatSounds = {}
	SkuMob.InCombatSounds["Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3"] = L["Default beep sound"]
	for i, v in pairs(SkuAuras.outputSoundFiles) do
		if SkuAudioFileIndex[i] then
			SkuMob.InCombatSounds["Interface\\AddOns\\"..Sku.AudiodataPath.."\\assets\\audio\\"..SkuAudioFileIndex[i]] = v
		end
	end
	SkuMob.options.args.InCombatSound.values = SkuMob.InCombatSounds

	if SkuOptions.db.profile[MODULE_NAME].InCombatSound == nil then
		SkuOptions.db.profile[MODULE_NAME].InCombatSound = "Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3"
	end

	if SkuMob.InCombatSounds[SkuOptions.db.profile[MODULE_NAME].InCombatSound] == nil then
		SkuOptions.db.profile[MODULE_NAME].InCombatSound = "Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3"
	end
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
function SkuMob:GetTtsAwareUnitName(aUnitId)
	if SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts ~= true then
		return UnitName(aUnitId)
	else
		local tBestUnitId = aUnitId
		
		if UnitIsUnit(aUnitId, "player") then
			return L["du selbst"]
		end

		if UnitIsUnit(aUnitId, "pet") then
			return L["dein begleiter"]
		end

		for x = 1, 4 do
			if UnitIsUnit(aUnitId, "party"..x) then
				return "party "..x
			end
		end

		for x = 1, 40 do
			if UnitIsUnit(aUnitId, "raid"..x) then
				return "raid "..x
			end
		end

		return ""
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tLastSoftEnemyGuid
function SkuMob:PLAYER_SOFT_ENEMY_CHANGED(arg1, arg2)
	if not UnitGUID("softenemy") then
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.soundNoTarget ~= " " then
			if UnitGUID("softenemy") ~= tLastSoftEnemyGuid then
				SkuOptions.Voice:OutputString(SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.soundNoTarget, true, true, 0.3, true)
			end
		end
		tLastSoftEnemyGuid = UnitGUID("softenemy")
		return
	end
	if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.enabled ~= true then
		return
	end

	if UnitGUID("softenemy") ~= UnitGUID("target") then
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.forPlayers == false and (UnitIsPlayer("softenemy") == true and UnitIsEnemy("player", "softenemy") == true) then
			return
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.forPets == false and (UnitIsPlayer("softenemy") == false and UnitIsEnemy("player", "softenemy") == true and UnitPlayerControlled("softenemy") == true) then
			return
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.forPassive == false and (UnitReaction("player", "softenemy") >= 4 and UnitCanAttack("player", "softenemy") == true) then
			return
		end
		
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.sound ~= " " then
			SkuOptions.Voice:OutputString(SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.sound, true, true, 0.3, true)
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.outputName == true then
			if SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.muteInCombat ~= true or (SkuOptions.db.profile["SkuOptions"].softTargeting.enemy.muteInCombat == true and UnitAffectingCombat("player") ~= true) then
				SkuMob:PLAYER_TARGET_CHANGED("PLAYER_TARGET_CHANGED", "softenemy")
			end
		end
	end
	tLastSoftEnemyGuid = UnitGUID("softenemy")
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:PLAYER_SOFT_FRIEND_CHANGED(aEvent, aGuid)
	if not UnitGUID("softfriend") then
		return
	end

	if UnitGUID("softfriend") ~= UnitGUID("target") then
		if SkuOptions.db.profile["SkuOptions"].softTargeting.friend.forPlayers == false and (UnitIsPlayer("softfriend") == true and UnitIsFriend("player", "softfriend") == true) then
			return
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.friend.forPets == false and (UnitIsPlayer("softfriend") == false and UnitIsFriend("player", "softfriend") == true and UnitPlayerControlled("softfriend") == true) then
			return
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.friend.sound ~= " " then
			SkuOptions.Voice:OutputString(SkuOptions.db.profile["SkuOptions"].softTargeting.friend.sound, true, true, 0.3, true)
		end
		if SkuOptions.db.profile["SkuOptions"].softTargeting.friend.outputName == true then
			SkuMob:PLAYER_TARGET_CHANGED("PLAYER_TARGET_CHANGED", "softfriend")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:PLAYER_SOFT_INTERACT_CHANGED(aEvent, aGuid)
	if not UnitGUID("softinteract") then
		return
	end

	if SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled ~= true then
		return
	end
	if UnitGUID("softinteract") ~= UnitGUID("target") then
		--print("SkuMob:PLAYER_SOFT_INTERACT_CHANGED(aEvent, ", aGuid, UnitGUID("softinteract"))
		if ((SkuOptions.db.profile["SkuOptions"].softTargeting.interact.soundfor == 2 and UnitExists("softinteract") == false) 
			or (
					(SkuOptions.db.profile["SkuOptions"].softTargeting.interact.soundfor == 3 and UnitExists("softinteract") == true and UnitIsDead("softinteract") == true) 
						or 
					UnitExists("softinteract") == false
				)
			or SkuOptions.db.profile["SkuOptions"].softTargeting.interact.soundfor == 4) and SkuOptions.db.profile["SkuOptions"].softTargeting.interact.soundfor > 1
		then			
			if SkuOptions.db.profile["SkuOptions"].softTargeting.interact.sound ~= " " then
				SkuOptions.Voice:OutputString(SkuOptions.db.profile["SkuOptions"].softTargeting.interact.sound, true, true, 0.3, true)
			end
		end
		if ((SkuOptions.db.profile["SkuOptions"].softTargeting.interact.unitNameFor == 2 and UnitExists("softinteract") == false) 
			or ((SkuOptions.db.profile["SkuOptions"].softTargeting.interact.unitNameFor == 3 and UnitExists("softinteract") == true and UnitIsDead("softinteract") == true) or UnitExists("softinteract") == false) 
			or SkuOptions.db.profile["SkuOptions"].softTargeting.interact.unitNameFor == 4) and SkuOptions.db.profile["SkuOptions"].softTargeting.interact.unitNameFor > 1
		then
			if SkuOptions.db.profile["SkuOptions"].softTargeting.interact.outputBTTS == true then
				local tName = UnitName("softinteract")
				if tName then
					C_Timer.After(0.1, function()
						local hp = math.floor(UnitHealth("softinteract") / (UnitHealthMax("softinteract") / 100))
						if UnitHealthMax("softinteract") == 0 then
							hp = 100
						end
						if hp == 0 then
							SkuOptions.Voice:OutputStringBTtts(L["dead"].." "..tName, true, true, 0.2, true, nil, nil, 2)
						else
							SkuOptions.Voice:OutputStringBTtts(tName, true, true, 0.2, true, nil, nil, 2)
						end
					end)
				end
			else
				SkuMob:PLAYER_TARGET_CHANGED("PLAYER_SOFT_INTERACT_CHANGED", "softinteract")
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:PLAYER_TARGET_CHANGED(event, aUnitId)
	C_Timer.After(0.01, function() --this delay is to provide the combat monitor an option to first send output to the tts queue

		aUnitId = aUnitId or "target"

		dprint("SkuMob PLAYER_TARGET_CHANGED(event, ", event, aUnitId)

		if aUnitId == "target" then
			SkuCore:DoRangeCheck(true, nil, "target")

			if SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled == true then
				if UnitExists("target") == true then

					if SkuOptions.db.profile["SkuOptions"].softTargeting.matchLocked == 1 or (SkuOptions.db.profile["SkuOptions"].softTargeting.matchLocked == 2 and UnitCanAttack("player", "target") == true) then
						SkuMob.interactTempDisabled = true
						SkuOptions:UpdateSoftTargetingSettings("all")
					else
						SkuMob.interactTempDisabled = nil
						SkuOptions:UpdateSoftTargetingSettings("all")
					end
				else
					SkuMob.interactTempDisabled = nil
					SkuOptions:UpdateSoftTargetingSettings("all")
				end
			end
		end

		if not UnitExists(aUnitId) and aUnitId ~= "softinteract" then
			return
		end

		local tUnitName = GetUnitName(aUnitId, false)
		local tUnitLevel = UnitLevel(aUnitId)
		local tUnitIsEnemy = UnitIsEnemy("player",aUnitId)
		local tUnitIsFriend = UnitIsFriend("player",aUnitId)
		local tCreatureType = UnitCreatureType(aUnitId)
		local tCreatureFamily = UnitCreatureFamily(aUnitId)
		local tClassification = UnitClassification(aUnitId)
		local tInteractDistance = CheckInteractDistance(aUnitId, 4)

		local noSubText

		local tIsPlayerControled = false
		if UnitIsPlayer(aUnitId) then
			if SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholders == true then
				if UnitIsFriend("player", aUnitId) then
					if SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat == true and SkuCore.inCombat == true then
						tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)
					else
						tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["freundlicher spieler"]
					end
						tIsPlayerControled = true
				else
					if SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat == true and SkuCore.inCombat == true then
						tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)
					else
						tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["feindlicher spieler"]
					end
					tIsPlayerControled = true
				end
				noSubText = true
			else
				return
			end
		end
		if UnitPlayerControlled(aUnitId) == true and UnitIsPlayer(aUnitId) == false then
			if SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat == true and SkuCore.inCombat == true then
				tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)
			else
				tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["fremder begleiter"]
			end
			tIsPlayerControled = true
			noSubText = true
		end
		if UnitExists("pet") and (GetUnitName("pet", false) == GetUnitName(aUnitId, false)) then
			tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)--L["dein begleiter"]
			tIsPlayerControled = true
			noSubText = true
		end
		if GetUnitName(aUnitId, false) == GetUnitName("player", false) then
			tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)--L["du selbst"]
			tIsPlayerControled = true
			noSubText = true
		end

		local tUnitReaction = UnitReaction("player", aUnitId)
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
		local status = UnitThreatSituation("player", aUnitId)
		--dprint(tUnitLevel, tUnitIsEnemy, tUnitIsFriend, tCreatureType, tCreatureFamily, tClassification, tInteractDistance, tUnitReaction, status, isTanking, status, threatpct, rawthreatpct, threatvalue)
		if status then
			local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", aUnitId) --https://wowwiki-archive.fandom.com/wiki/API_UnitDetailedThreatSituation
			--local statustxts = { "low on threat",  "overnuking", "losing threat", "tanking securely" }
			--dprint("You are " .. statustxts[status + 1] .. ".")
		end

		--target in combat indicator
		local tRosterNames = {}
		for x = 1, 4 do
			local name, realm = SkuMob:GetTtsAwareUnitName("party"..x)
			if name then
				tRosterNames[name] = name
			end
		end
		for x = 1, 40 do
			local name, realm = SkuMob:GetTtsAwareUnitName("raid"..x)
			if name then
				tRosterNames[name] = name
			end
		end
		local name, realm = SkuMob:GetTtsAwareUnitName("pet")
		if name then
			tRosterNames[name] = name
		end
		local name, realm = SkuMob:GetTtsAwareUnitName("player")
		tRosterNames[name] = name

		local status = nil
		for x = 1, 4 do
			if UnitThreatSituation("party"..x, aUnitId) then
				status = UnitThreatSituation("party"..x, aUnitId)
			end
		end
		for x = 1, 40 do
			if UnitThreatSituation("raid"..x, aUnitId) then
				status = UnitThreatSituation("raid"..x, aUnitId)
			end
		end
		if UnitThreatSituation("pet", aUnitId) then
			status = UnitThreatSituation("pet", aUnitId)
		end
		if UnitThreatSituation("player", aUnitId) then
			status = UnitThreatSituation("player", aUnitId)
		end

		local name, realm = SkuMob:GetTtsAwareUnitName("targettarget")
		if name then
			if tRosterNames[name] then
				status = true
			end
		end

		if status and tIsPlayerControled == false then
			--creature in combat indicator
			local tAudioFile = SkuOptions.db.profile[MODULE_NAME].InCombatSound or "Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3"
			local willPlay, soundHandle = PlaySoundFile(tAudioFile, SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
		end

		--raidtarget
		local tRaidtarget = GetRaidTargetIndex(aUnitId)
		local tRaidTargetString = ""
		if tRaidtarget then
			if SkuCore.RaidTargetValues[tRaidtarget] then
				if SkuOptions.db.profile[MODULE_NAME].repeatRaidTargetMarkers == true then
					tRaidTargetString = SkuCore.RaidTargetValues[tRaidtarget].name..";"..SkuCore.RaidTargetValues[tRaidtarget].name..";"
				else
					tRaidTargetString = SkuCore.RaidTargetValues[tRaidtarget].name..";"
				end
			end
		end
		
		local tUnitGUID = UnitGUID(aUnitId)
		--sku raid target
		if tRaidtarget == nil or tRaidtarget == "" then
			if SkuCore:aqCombatGetSkuRaidTarget(tUnitGUID) ~= nil then
				tRaidTargetString = SkuCore.RaidTargetValues[SkuCore:aqCombatGetSkuRaidTarget(tUnitGUID)].color..";"
			else
				if UnitCanAttack("player", aUnitId) and tIsPlayerControled == false and status then
					if SkuOptions.db.profile[MODULE_NAME].autoSetSkuRaidTargetsToInCombatCreatures == true then
						local tNewRaidTargetId = SkuCore:aqCombatSetSkuRaidTarget(tUnitGUID, 0)
						if tNewRaidTargetId then
							tRaidTargetString = SkuCore.RaidTargetValues[tNewRaidTargetId].color..";"
						end
					end
				end
			end
			if SkuOptions.db.profile[MODULE_NAME].repeatRaidTargetMarkers == true then
				tRaidTargetString = tRaidTargetString..tRaidTargetString
			end
		end

		--for passive but attackable targets
		local tReactionText = ""
		if UnitCanAttack("player", aUnitId) then
			if TargetFrameNameBackground then
				local r, g, b, a = TargetFrameNameBackground:GetVertexColor()
				if r > 0.99 and g > 0.99 and b == 0 then
					tReactionText = L["passive"]..";"
				end
			end
		end

		local hp = math.floor(UnitHealth(aUnitId) / (UnitHealthMax(aUnitId) / 100))

		if aUnitId == "softinteract" then
			if UnitExists("softinteract") == false then
				noSubText = true
				tIsPlayerControled = false
				tUnitLevel = -1
				hp = 100
				tReactionText = ""
			end
			tUnitName = UnitName("softinteract")
		end

		local tOutputString = ""
		local tOutputStringB = ""


		if tUnitName then
			if hp == 0 then
				if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
					tOutputString = tRaidTargetString.." "..L["dead"].." "..tUnitName
				else
					tOutputStringB = tRaidTargetString.." "..L["dead"].." "..tUnitName
				end
			else
				if tRaidTargetString ~= "" and SkuOptions.db.profile["SkuMob"].vocalizeRaidTargetOnly == true then
					if tIsPlayerControled == false  or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
						tOutputString = tOutputString.." "..tRaidTargetString
					else
						tOutputStringB = tOutputStringB.." "..tRaidTargetString
					end
				else
					if tIsPlayerControled == false  or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
						tOutputString = tOutputString.." "..tRaidTargetString..tReactionText..tUnitName
					else
						tOutputStringB = tOutputStringB.." "..tRaidTargetString..tReactionText..tUnitName
					end
				end
			end
		end
		
		local tClassification = UnitClassification(aUnitId) or ""
		local tClassifications = {
			["worldboss"] = L["world boss"] , 
			["rareelite"] = L["Rare Elite"], 
			["elite"] = L["Elite"], 
			["rare"] = L["Rare"], 
			["normal"] = "", 
			["trivial"] = "", 
			["minus"] = "",
		}

		if tRaidTargetString == "" or SkuOptions.db.profile["SkuMob"].vocalizeRaidTargetOnly == false then
			if tUnitLevel then
				if tUnitLevel ~= -1 then
					if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
						if tIsPlayerControled ~= true or (SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat ~= true or SkuCore.inCombat == false) then
							tOutputString = tOutputString.." "..L["level"]
							tOutputString = tOutputString.." "..string.format("%02d", tUnitLevel).." "..tClassifications[tClassification]
						end
					else
						if tIsPlayerControled ~= true or (SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat ~= true  or SkuCore.inCombat == false) then
							tOutputStringB = tOutputStringB.." "..L["level"].." "..string.format("%02d", tUnitLevel)
						end
					end
				else
					if aUnitId ~= "softinteract" then
						if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
							if tIsPlayerControled ~= true or (SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat ~= true  or SkuCore.inCombat == false) then
								tOutputString = tOutputString.." "..L["level"]
								tOutputString = tOutputString.." "..L["Unknown"]
							end
						else
							if tIsPlayerControled ~= true or (SkuOptions.db.profile[MODULE_NAME].dontVocalizePlayerReactionAndLevelInCombat ~= true  or SkuCore.inCombat == false) then
								tOutputStringB = tOutputStringB.." "..L["level"].." "..L["Unknown"]
							end
						end
					end
				end
			end

			if noSubText ~= true then
				GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
				GameTooltip:SetUnit(aUnitId)
				GameTooltip:Show()
				local left = _G["GameTooltipTextLeft" .. 2]
				if left then
					local tLineTwoText = left:GetText()
					if tLineTwoText then
						if tLineTwoText ~= "" then
							if not string.find(tLineTwoText, L["level"]) then
								--SkuOptions.Voice:OutputString(tLineTwoText, false, true, 0.3)
								tOutputString = tOutputString.." "..tLineTwoText
							end
						end
					end
				end
			end
			
			--layer info
			if SkuDB.routedata["global"].WaypointLevels and (tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true) then
				local tLayerText = SkuNav:GetLayerText(SkuNav:GetNonAutoLevel(nil, nil, nil, true))
				if tLayerText then
					tOutputString = tOutputString.." "..tLayerText
					tOutputStringB = tOutputStringB.." "..tLayerText
				end
			end

		end

		if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
			SkuOptions.Voice:OutputString(tOutputString, true, true, 0.3)
		else
			SkuOptions.Voice:OutputStringBTtts(tOutputStringB, true, true, 0.3, nil, nil, nil, 1)
		end

	end)
end

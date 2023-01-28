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

local SkuMobRaidTargetStrings = {
	[1] = L["Star"],
	[2] = L["Circle"],
	[3] = L["Diamond"],
	[4] = L["Triangle"],
	[5] = L["Moon"],
	[6] = L["Square"],
	[7] = L["Cross"],
	[8] = L["Skull"],
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnInitialize()
	--dprint("SkuMob OnInitialize")
	SkuMob:RegisterEvent("VARIABLES_LOADED")
	SkuMob:RegisterEvent("PLAYER_TARGET_CHANGED")
	SkuMob:RegisterEvent("QUEST_TURNED_IN")
	SkuMob:RegisterEvent("PLAYER_SOFT_ENEMY_CHANGED")
	SkuMob:RegisterEvent("PLAYER_SOFT_FRIEND_CHANGED")
	SkuMob:RegisterEvent("PLAYER_SOFT_INTERACT_CHANGED")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:OnEnable()
	--dprint("SkuMob OnEnable")
	-- Called when the addon is enabled
	local ttime = 0
	local f = _G["SkuMobControl"] or CreateFrame("Frame", "SkuMobControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
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
function SkuMob:VARIABLES_LOADED(...)
	-- process the event
  --dprint(...)
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
function SkuMob:PLAYER_SOFT_ENEMY_CHANGED(arg1, arg2)
	if not UnitGUID("softenemy") then
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
			SkuMob:PLAYER_TARGET_CHANGED("PLAYER_TARGET_CHANGED", "softenemy")
		end
	end
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
	aUnitId = aUnitId or "target"

	--print("mob PLAYER_TARGET_CHANGED(event, ", aUnitId)

	if aUnitId == "target" then
		if SkuOptions.db.profile["SkuOptions"].softTargeting.matchLocked == 1 then
			if UnitExists("target") and not SkuMob.interactEnabledOrigin then
				SkuMob.interactEnabledOrigin = SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled
				SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled = false
				SkuOptions:UpdateSoftTargetingSettings("all")
			elseif UnitExists("target") ~= true and SkuMob.interactEnabledOrigin then
				SkuOptions.db.profile["SkuOptions"].softTargeting.interact.enabled = SkuMob.interactEnabledOrigin
				SkuMob.interactEnabledOrigin = nil
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
				tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["freundlicher spieler"]
				tIsPlayerControled = true
			else
				tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["feindlicher spieler"]
				tIsPlayerControled = true
			end
			noSubText = true
		else
			return
		end
	end
	if UnitPlayerControlled(aUnitId) == true and UnitIsPlayer(aUnitId) == false then
		tUnitName = SkuMob:GetTtsAwareUnitName(aUnitId)..", "..L["fremder begleiter"]
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
		local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuMob\\assets\\Target_in_combat_low.mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
	end

	--raidtarget
	local tRaidtarget = GetRaidTargetIndex(aUnitId)
	local tRaidTargetString = ""
	if tRaidtarget then
		if SkuMobRaidTargetStrings[tRaidtarget] then
			if SkuOptions.db.profile[MODULE_NAME].repeatRaidTargetMarkers == true then
				tRaidTargetString = SkuMobRaidTargetStrings[tRaidtarget]..";"..SkuMobRaidTargetStrings[tRaidtarget]..";"
			else
				tRaidTargetString = SkuMobRaidTargetStrings[tRaidtarget]..";"
			end
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
		--tRaidTargetString = ""
		if UnitExists("softinteract") == false then
			noSubText = true
			tIsPlayerControled = false
			tUnitLevel = -1
			hp = 100
			tReactionText = ""
		end
		tUnitName = UnitName("softinteract")
	end

	if tUnitName then
		if hp == 0 then
			if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
				SkuOptions.Voice:OutputString(L["dead"], true, true, 0.3)
				SkuOptions.Voice:OutputString(tUnitName, false, true, 0.8)
			else
				SkuOptions.Voice:OutputStringBTtts(L["dead"].." "..tUnitName, true, true, 0.3, nil, nil, nil, 1)
			end
		else
			if tRaidTargetString ~= "" and SkuOptions.db.profile["SkuMob"].vocalizeRaidTargetOnly == true then
				if tIsPlayerControled == false  or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
					SkuOptions.Voice:OutputString(tRaidTargetString, true, true, 0.8)
				else
					SkuOptions.Voice:OutputStringBTtts(tRaidTargetString, true, true, 0.8, nil, nil, nil, 1)
				end
			else
				if tIsPlayerControled == false  or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
					SkuOptions.Voice:OutputString(tRaidTargetString..tReactionText..tUnitName, true, true, 0.8)
				else
					SkuOptions.Voice:OutputStringBTtts(tRaidTargetString..tReactionText..tUnitName, true, true, 0.8, nil, nil, nil, 1)
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
					SkuOptions.Voice:OutputString(L["level"], false, true, 0.2)
					SkuOptions.Voice:OutputString(string.format("%02d", tUnitLevel).." "..tClassifications[tClassification], false, true, 0.3)
				else
					--aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine
					SkuOptions.Voice:OutputStringBTtts(L["level"].." "..string.format("%02d", tUnitLevel), false, true, 0.2, nil, nil, nil, 1)
				end
			else
				if tIsPlayerControled == false or SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts == true then
					SkuOptions.Voice:OutputString(L["level"], false, true, 2.2)
					SkuOptions.Voice:OutputString(L["Unknown"], false, true, 0.3)
				else
					SkuOptions.Voice:OutputStringBTtts(L["level"].." "..L["Unknown"], false, true, 2.2, nil, nil, nil, 1)
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
							SkuOptions.Voice:OutputString(tLineTwoText, false, true, 0.3)
						end
					end
				end
			end
		end
	end
end


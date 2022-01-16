---@diagnostic disable: undefined-field, undefined-doc-name, undefined-doc-param

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuOptions"
local L = Sku.L
local _G = _G

SkuOptions = SkuOptions or LibStub("AceAddon-3.0"):NewAddon("SkuOptions", "AceConsole-3.0", "AceEvent-3.0")
LibStub("AceComm-3.0"):Embed(SkuOptions)
SkuOptions.TTS = LibStub("SkuTTS-1.0"):Create("SkuOptions", false)
SkuOptions.Voice = LibStub("SkuVoice-1.0"):Create("SkuOptions", false)
SkuOptions.HBD = LibStub("HereBeDragons-2.0")
SkuOptions.BeaconLib = LibStub("SkuBeacon-1.0"):Create("SkuOptions", false)
SkuOptions.Serializer = LibStub("AceSerializer-3.0")
SkuOptions.RangeCheck = LibStub("LibRangeCheck-2.0")

SkuOptions.Menu = {}
SkuOptions.currentMenuPosition = nil
SkuOptions.MenuAccessKeysChars = {" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ö", "ü", "ä", "ß", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Ä", "Ö", "Ü", "shift-,",}
SkuOptions.MenuAccessKeysNumbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}

local ssplit = string.split

---------------------------------------------------------------------------------------------------------------------------------------
SkuOptions.DebugToChatFlag = true
function SkuOptions:DebugToChat(...)
	local args = {...}
	local tFirstLine = false
	if SkuOptions.DebugToChatFlag == true then
		for i, v in pairs(args) do
			if tFirstLine == false then
				print(v)
			else
				print("  ", v)
			end
			tFirstLine = true
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------
local options = {
name = "SkuOptions",
	handler = SkuOptions,
	type = "group",
	args = {},
	}

local defaults = {
	profile = {
		}
	}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:CloseMenu()
	if SkuOptions:IsMenuOpen() == true then
		_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:IsMenuOpen()
	if _G["OnSkuOptionsMain"]:IsVisible() == true then
		return true
	end
	return false
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param input string
function SkuOptions:SlashFunc(input)
	--SkuOptions.AceConfigDialog:Open("SkuOptions")
	input = input:gsub( ", ", ",")
	input = input:gsub( " ,", ",")

	input = string.lower(input)
	--dprint(input)
	local sep, fields = ",", {}
	local pattern = string.format("([^%s]+)", sep)
	input:gsub(pattern, function(c) fields[#fields+1] = c end)
	if fields then

		--[[
		if fields[1] == "on" then
			SkuOptions.db.profile[MODULE_NAME].enable = true
			--dprint("SkuOptions on")
		end

		if fields[1] == "off" then
			SkuOptions.db.profile[MODULE_NAME].enable = false
			--dprint("SkuOptions off")
		end
		]]
		if fields[1] == L["short"] then
			if SkuCore.inCombat == true then
				SkuCore.openMenuAfterCombat = true
				SkuCore.openMenuAfterPath = input
				return
			end
			if SkuCore.isMoving == true then
				SkuCore.openMenuAfterMoving = true
				SkuCore.openMenuAfterPath = input
				return
			end
			if #SkuOptions.Menu == 0 or SkuOptions:IsMenuOpen() == false then
				_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
			end

			local tMenu = SkuOptions.Menu
			local tFoundMenuPos = nil

			for x = 2, #fields do
				for y = 1, #tMenu do
					if tMenu[y].children then
						if #tMenu[y].children == 0 then
							tMenu[y]:BuildChildren()
						end
					end

					if fields[x] == string.lower(tMenu[y].name) then
						tFoundMenuPos = tMenu[y]
						tMenu[y].OnSelect(tMenu[y], true)
						tMenu = tMenu[y].children
						break
					end
				end
			end

			if tFoundMenuPos then
				SkuOptions.currentMenuPosition = tFoundMenuPos
				if SkuOptions.currentMenuPosition.children then
					if #SkuOptions.currentMenuPosition.children > 0 then
						SkuOptions.currentMenuPosition:OnSelect()
						SkuOptions:VocalizeCurrentMenuName()
					else
						SkuOptions.currentMenuPosition:OnSelect()
						SkuOptions:CloseMenu()
					end
				else
					SkuOptions.currentMenuPosition:OnSelect()
					SkuOptions:CloseMenu()
				end
			end
		elseif fields[1] == "mmreset" then
			SkuNavMMMainFrame:SetSize(200, 200) 
			SkuNavMMMainFrameResizeButton:GetScript("OnMouseDown")(_G["SkuNavMMMainFrameResizeButton"], "LeftButton") 
			SkuNavMMMainFrameResizeButton:GetScript("OnMouseUp")(_G["SkuNavMMMainFrameResizeButton"], "LeftButton")
		elseif fields[1] == "chatcover" then
			if _G["ChatFrame1"] then
				local tWidget = _G["SkuChatCover"]
				if not tWidget then
					tWidget = CreateFrame("Frame", "SkuChatCover", _G["ChatFrame1"])
					tWidget:SetWidth(_G["ChatFrame1"]:GetWidth())  
					tWidget:SetHeight(_G["ChatFrame1"]:GetHeight()) 
					tWidget:SetAllPoints()
					local tex = tWidget:CreateTexture(nil, "OVERLAY")
					tex:SetAllPoints()
					tex:SetColorTexture(0, 0, 0, 1)
					tWidget:Hide()
				end
				if tWidget:IsShown() then
					tWidget:Hide()
					SkuOptions.Voice:OutputString("Chat sichtbar", false, true, 0.2)
				else
					tWidget:Show()
					SkuOptions.Voice:OutputString("Chat verdeckt", false, true, 0.2)
				end
			end

		elseif fields[1] == "rdatareset" then
			dprint("/sku rdatareset")
			SkuOptions.db.profile["SkuNav"].Waypoints = SkuOptions:TableCopy(SkuDB.routedata["Waypoints"])
			SkuNav:CreateWaypointCache()
			SkuOptions.db.profile["SkuNav"].Links = SkuOptions:TableCopy(SkuDB.routedata["Links"])
			SkuNav:LoadLinkDataFromProfile()
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnProfileChanged()
	dprint("SkuOptions:OnProfileChanged")
	SkuNav:PLAYER_ENTERING_WORLD()

  	if SkuCore then
		SkuCore:OnEnable()
	end
	if SkuChat then
		SkuChat:OnEnable()
	end
	if SkuMob then
		SkuMob:OnEnable()
	end
	if SkuNav then
		SkuNav:OnEnable()
	end
	if SkuQuest then
		SkuQuest:OnEnable()
	end
	if SkuAuras then
		SkuAuras:OnEnable()
	end
	if SkuOptions then
		SkuOptions:OnEnable()
	end

	SkuOptions.Voice:OutputString("Profil gewechselt", false, true, 0.2)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnProfileCopied()
	dprint("SkuOptions:OnProfileCopied")
	SkuNav:PLAYER_ENTERING_WORLD()

  	if SkuCore then
		SkuCore:OnEnable()
	end
	if SkuChat then
		SkuChat:OnEnable()
	end
	if SkuMob then
		SkuMob:OnEnable()
	end
	if SkuNav then
		SkuNav:OnEnable()
	end
	if SkuQuest then
		SkuQuest:OnEnable()
	end
	if SkuAuras then
		SkuAuras:OnEnable()
	end
	if SkuOptions then
		SkuOptions:OnEnable()
	end

	SkuOptions.Voice:OutputString("Profil kopiert", false, true, 0.2)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnProfileReset()
	dprint("SkuOptions:OnProfileReset")
	local tVersion = GetAddOnMetadata("Sku", "Version") 
	if tVersion then tVersion = tonumber(tVersion) end
	SkuOptions.db.profile["SkuNav"].RtAndWpVersion = tVersion
	SkuOptions.db.profile["SkuNav"].Routes = nil
	SkuOptions.db.profile["SkuNav"].Waypoints = SkuOptions:TableCopy(SkuDB.routedata["Waypoints"])
	SkuNav:CreateWaypointCache()
	SkuOptions.db.profile["SkuNav"].Links = SkuOptions:TableCopy(SkuDB.routedata["Links"])
	SkuNav:LoadLinkDataFromProfile()


	SkuNav:PLAYER_ENTERING_WORLD()

  	if SkuCore then
		SkuCore:OnEnable()
	end
	if SkuChat then
		SkuChat:OnEnable()
	end
	if SkuMob then
		SkuMob:OnEnable()
	end
	if SkuNav then
		SkuNav:OnEnable()
	end
	if SkuQuest then
		SkuQuest:OnEnable()
	end
	if SkuAuras then
		SkuAuras:OnEnable()
	end
	if SkuOptions then
		SkuOptions:OnEnable()
	end

	SkuOptions.Voice:OutputString("Profil zurückgesetzt", false, true, 0.2)

end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aStartStop bool
function SkuOptions:StartStopBackgroundSound(aStartStop)
	if aStartStop == true then
		if SkuOptions.currentBackgroundSoundHandle == nil then
			local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuZOptions\\assets\\audio\\background\\"..SkuOptions.db.profile[MODULE_NAME].backgroundSound, "Talking Head")
			if soundHandle then
				SkuOptions.currentBackgroundSoundHandle = soundHandle
				if SkuOptions.currentBackgroundSoundTimerHandle then
					SkuOptions.currentBackgroundSoundTimerHandle:Cancel()
					SkuOptions.currentBackgroundSoundTimerHandle = nil
				end
				if SkuOptions.currentBackgroundSoundTimerHandle == nil then
					SkuOptions.currentBackgroundSoundTimerHandle = C_Timer.NewTimer(SkuOptions.BackgroundSoundFilesLen[SkuOptions.db.profile[MODULE_NAME].backgroundSound], function()
						--StopSound(SkuOptions.currentBackgroundSoundHandle, 0)
						SkuOptions.currentBackgroundSoundTimerHandle = nil
						SkuOptions.currentBackgroundSoundHandle = nil
						SkuOptions:StartStopBackgroundSound(true)
					end)
				else
					if SkuOptions.currentBackgroundSoundTimerHandle then
						SkuOptions.currentBackgroundSoundTimerHandle:Cancel()
						SkuOptions.currentBackgroundSoundTimerHandle = nil
					end
					SkuOptions.currentBackgroundSoundTimerHandle = nil
					SkuOptions.currentBackgroundSoundTimerHandle = C_Timer.NewTimer(SkuOptions.BackgroundSoundFilesLen[SkuOptions.db.profile[MODULE_NAME].backgroundSound], function()
						SkuOptions.currentBackgroundSoundTimerHandle = nil
						SkuOptions.currentBackgroundSoundHandle = nil
						SkuOptions:StartStopBackgroundSound(true)
					end)
				end
			end
		else
			StopSound(SkuOptions.currentBackgroundSoundHandle, 0)
			SkuOptions.currentBackgroundSoundHandle = nil
		end
	elseif aStartStop == false then
		if SkuOptions.currentBackgroundSoundHandle ~= nil then
			StopSound(SkuOptions.currentBackgroundSoundHandle, 0)
			SkuOptions.currentBackgroundSoundHandle = nil
		end
		if SkuOptions.currentBackgroundSoundTimerHandle then
			SkuOptions.currentBackgroundSoundTimerHandle:Cancel()
			SkuOptions.currentBackgroundSoundTimerHandle = nil
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function TooltipLines_helper(...)
	local rText = ""
    for i = 1, select("#", ...) do
        local region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            local text = region:GetText() -- string or nil
			if text then
				rText = rText..text.."\r\n"
			end
        end
    end
	return rText
end
local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}
local function unescape(str)
	for k, v in pairs(escapes) do
		str = string.gsub(str, k, v)
	end
	return str
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:UpdateOverviewText()
	local tSections = {}

	--party
	local tTmpText
	local tCount = 1

	local tPosX, tPosY = 0, 0
	if C_Map.GetBestMapForUnit("player") and C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player") then
		tPosX, tPosY = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player"):GetXY()
	end
	tTmpText = tCount.." "..UnitName("player")..", "..GetMinimapZoneText()..", "..math.floor(tPosX * 100).." "..math.floor(tPosY * 100).."\r\n"
	
	for x = 1, 5 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(x)
		if online then online = "online" else online = "offline" end
		if isDead then isDead = "tot" else isDead = "lebt" end
		if name then
			local tPlayerName = UnitName("player")
			if name ~= tPlayerName then
				tCount = tCount + 1
				tTmpText = tTmpText..tCount.." "..name..", "..class..", "..level..", "..zone..", "..online..", "..isDead.."\r\n"
			end
		end
	end

	--loot
	local lootStrings = 	{
		["freeforall"] = "Jeder gegen jeden",
		["roundrobin"] = "Reihum",
		["group"] = "Als Gruppe",
		["needbeforegreed"] = "Bedarf bevor Gier",
		["master"] = "Plündermeister",
		["personalloot"] = "Persönliche Beute",
	}
	local lootmethod, masterlooterPartyID, masterlooterRaidID = GetLootMethod()

	if tTmpText then
		table.insert(tSections, "Gruppe".."\r\n"..tTmpText.."\r\nPlündern: "..lootStrings[lootmethod])
	end

	--general
	--repair status
	local tGeneral = "Allgemeines"
	local tDurabilityStatus = {[0] = 0, [1] = 0, [2] = 0,}
	for index, value in pairs(INVENTORY_ALERT_STATUS_SLOTS) do
		tDurabilityStatus[GetInventoryAlertStatus(index)] = tDurabilityStatus[GetInventoryAlertStatus(index)] + 1
	end
	local tTmpText = ""
	if tDurabilityStatus[2] > 0 then
		tTmpText = tTmpText..tDurabilityStatus[2].." rot "
	end
	if tDurabilityStatus[1] > 0 then
		tTmpText = tTmpText..tDurabilityStatus[1].." gelb "
	end
	if tDurabilityStatus[0] > 0 then
		tTmpText = tTmpText..tDurabilityStatus[0].." ok "
	end
	tGeneral = tGeneral.."\r\n".."Reparatur status: "..tTmpText

	--money
	local tMoney = ContainerFrame1MoneyFrame.staticMoney
	if BagnonMoneyFrame1 then
		tMoney = BagnonMoneyFrame1.staticMoney
	end
	if tMoney then
		local tTmpText = GetCoinText(tMoney)
		tGeneral = tGeneral.."\r\n".."Geld: "..tTmpText
	end

	--bag space
	local tFreeCount = 0
	for x = 0, 4 do
		local t = GetContainerFreeSlots(x)
		if t then
			tFreeCount = tFreeCount + #t
		end
	end
	tGeneral = tGeneral.."\r\n".."Freie Taschenplätze: "..tFreeCount

	--time
	local tTime = date("*t")
	tGeneral = tGeneral.."\r\n".."Zeit: "..tTime.hour..":"..tTime.min.." Uhr"

	--mail
	local sender1, sender2, sender3 = GetLatestThreeSenders()
	local tTmpText = "keine"
	if sender1 then
		tTmpText = sender1
	end
	if sender2 then
		tTmpText = tTmpText .." "..sender2
	end
	if sender3 then
		tTmpText = tTmpText .." "..sender3
	end
	tGeneral = tGeneral.."\r\n".."Post: "..tTmpText

	--hearthstone
	local tTmpText = "Keiner vorhanden"
	local tHearthstoneId = PlayerHasHearthstone()
	if tHearthstoneId then
		local startTime, duration, enable = GetItemCooldown(tHearthstoneId)
		if duration == 0 then
			tTmpText = " bereit"
		else
			tTmpText = math.floor((duration / 60) + ((startTime -  GetTime()) / 60)).." Minuten"
		end
		tTmpText = tTmpText.." "..GetBindLocation()
	end
	tGeneral = tGeneral.."\r\n".."Ruhestein: "..tTmpText

	--xp
	local tPlayerXPExhaustion = GetXPExhaustion()
	tPlayerXPExhaustion = tPlayerXPExhaustion or 0
	local tPlayercurrXP, tPlayernextXP = UnitXP("player"), UnitXPMax("player")
	tGeneral = tGeneral.."\r\n".."XP: "..(math.floor(tPlayercurrXP / (tPlayernextXP / 100))).." Prozent ("..tPlayercurrXP.." von "..tPlayernextXP.." für "..(UnitLevel("player") + 1)..")\r\nRuhebonus: "..tPlayerXPExhaustion

	table.insert(tSections, tGeneral)

	--buffs/debuffs
	local tBuffs = "Buffs"
	local tFound
	for x = 1, 40  do
		local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff("player", x)
		if name then
			tFound = true
			local tTimeString = ""
			if expirationTime > 0 then
				local tRemainingSec = math.floor((expirationTime - GetTime()))
				if tRemainingSec > 60 then
					if tRemainingSec > 3600 then
						tTimeString = (math.floor(tRemainingSec / 3600) + 1).." Stunden"
					else
						tTimeString = (math.floor(tRemainingSec / 60) + 1).." Minuten"
					end
				else
					tTimeString = tRemainingSec.." Sekunden"
				end
			end
			tBuffs = tBuffs.."\r\n"..name.." "..tTimeString
		end
	end
	if not tFound then
		tBuffs = tBuffs.."\r\n".."Keine"
	end
	table.insert(tSections, tBuffs)

	local tDebuffs = "Debuffs"
	local tFound
	for x = 1, 40  do
		local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitDebuff("player", x)
		if name then
			tFound = true
			local tTimeString = ""
			if expirationTime > 0 then
				local tRemainingSec = math.floor((expirationTime - GetTime()))
				if tRemainingSec > 60 then
					if tRemainingSec > 3600 then
						tTimeString = (math.floor(tRemainingSec / 3600) + 1).." Stunden"
					else
						tTimeString = (math.floor(tRemainingSec / 60) + 1).." Minuten"
					end
				else
					tTimeString = tRemainingSec.." Sekunden"
				end
			end
			tDebuffs = tDebuffs.."\r\n"..name.." "..tTimeString
		end
	end
	if not tFound then
		tDebuffs = tDebuffs.."\r\n".."Keine"
	end
	table.insert(tSections, tDebuffs)

	--skills
	local tTmpText = ""
	for x = 1, GetNumSkillLines() do
		local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(x)
		if not header then
			tTmpText = tTmpText.."\r\n"..skillName.." ("..skillRank.." / "..skillMaxRank..")"
		end
	end
	table.insert(tSections, "Fertigkeiten:\r\n"..tTmpText)

	--reputation
	ExpandAllFactionHeaders()
	local tTmpText = ""
	for x = 1, GetNumFactions() do
		local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(x)
		if not isHeader then
			local tRep = {
			[8] = 42000,
			[7] = 21000,
			[6] = 9000,
			[5] = 3000,
			[4] = 0,
			[3] = -3000,
			[2] = -6000,
			[1] = -36000,
			}
			local tRepLevel = 0
			for y = 1, 8 do
				if barValue >= tRep[y] == true then
					tRepLevel = y
				end
			end
			barValue = barValue - tRep[tRepLevel]
			barMax = barMax - tRep[tRepLevel]
			if standingID then
				tTmpText = tTmpText.."\r\n"..name..", "..getglobal("FACTION_STANDING_LABEL"..tRepLevel).." ("..barValue.." / "..barMax..")"
			end
		end
	end
	table.insert(tSections, "Ruf:\r\n"..tTmpText)

	--guild members
	SetGuildRosterShowOffline(false)
	GuildRoster()
	local tTmpText = ""
	for x = 1, GetNumGuildMembers() do
		local name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding, GUID = GetGuildRosterInfo(x)
		if string.find(name,"-") then
			name = string.sub(name, 1, string.find(name,"-") - 1)
		end
		if name and isOnline == true then
			tTmpText = tTmpText.."\r\n"..name..", "..classDisplayName..", "..level..", "..zone..", "..publicNote
		end
	end
	table.insert(tSections, "Gilde:\r\n"..tTmpText)

	--pet
	local tPetcurrXP, tPetnextXP = GetPetExperience() --current XP total; XP total required for the next level
	if UnitName("playerpet") then
		table.insert(tSections, "Tier XP: "..tPetcurrXP.." von "..tPetnextXP.." für "..UnitLevel("playerpet") + 1)
	end
	--GetPetFoodTypes


	--consumables


	return tSections
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:CreateControlFrame()
	local ttime = 0
	local f = CreateFrame("Frame", "SkuOptionsControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		--if SkuOptions.db.profile[MODULE_NAME].enable == true then
			if IsRightShiftKeyDown() then
				SkuOptions.Voice:StopOutputEmptyQueue()
			end

			ttime = ttime + time
			if ttime > 0.1 then
				if SkuOptions.TTS:IsVisible() == true then
					if IsShiftKeyDown() == false and SkuOptions.ChatOpen ~= true then
						SkuOptions.TTS:Output("", -1)
						--SkuOptions.TTS.MainFrame:Hide()
						SkuOptions.TTS:Hide()
					end
				end

				ttime = 0
			end
		--end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:CreateMainFrame()
	local tFrame = CreateFrame("Button", "OnSkuOptionsMain", UIParent, "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("OnSkuOptionsMain")
	tFrame:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
	tFrame:SetPoint("CENTER")

	SkuOptions.TooltipReaderText = ""
	tFrame:SetScript("OnClick", function(self, a, b)
		--dprint("OnSkuOptionsMain OnClick ", a, b)
		if not SkuOptions.db.profile["SkuNav"].RtAndWpVersion or SkuOptions.db.profile["SkuNav"].RtAndWpVersion < 22 then
			print("Funktion erst nach Abschluss von Routen Umwandlung verfügbar")
			SkuOptions.Voice:OutputString("Funktion erst nach Abschluss von Routen Umwandlung verfügbar", true, true, 0.3, true)
			return
		end

		if SkuCore:IsPlayerMoving() == true or SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing == true then
			SkuCore.openMenuAfterMoving = true
			return
		end

		if a == "CTRL-SHIFT-F3" then
			Sku.debug = Sku.debug == false
			print("Debug:", Sku.debug)
		end
	
		if a == "CTRL-SHIFT-B" then
			if SkuOptions.nextRollFrameNumber then
				if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber] then
					if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber]:IsVisible() then
						_G["GroupLootFrame"..SkuOptions.nextRollFrameNumber].NeedButton:Click()
						SkuOptions.Voice:OutputString(L["Need rolled"], true, true, 0.3, true)
						C_Timer.NewTimer(0.5, function()
							if _G["StaticPopup1"]:IsVisible() then
								_G["StaticPopup1Button1"]:Click()
							end
						end)
					end
				end
			end
			return
		end
		if a == "CTRL-SHIFT-G" then
			if SkuOptions.nextRollFrameNumber then
				if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber] then
					if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber]:IsVisible() then
						_G["GroupLootFrame"..SkuOptions.nextRollFrameNumber].GreedButton:Click()
						SkuOptions.Voice:OutputString(L["Greed rolled"], true, true, 0.3, true)
						C_Timer.NewTimer(0.5, function()
							if _G["StaticPopup1"]:IsVisible() then
								_G["StaticPopup1Button1"]:Click()
							end
						end)
					end
				end
			end
			return
		end
		if a == "CTRL-SHIFT-X" then
			if SkuOptions.nextRollFrameNumber then
				if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber] then
					if _G["GroupLootFrame"..SkuOptions.nextRollFrameNumber]:IsVisible() then
						_G["GroupLootFrame"..SkuOptions.nextRollFrameNumber].PassButton:Click()
						SkuOptions.Voice:OutputString(L["Pass rolled"], true, true, 0.3, true)
					end
				end
			end
			return
		end
		if a == "CTRL-SHIFT-C" then
			local tItem
			SkuOptions.nextRollFrameNumber, tItem = SkuOptions:GetCurrentRollItem()
			if SkuOptions.nextRollFrameNumber then
				SkuOptions.Voice:OutputString(L["Roll on"].." "..tItem.name.." "..tItem.quality.." "..tItem.bind.." "..tItem.type.." "..tItem.subtype, true, true, 0.3, true)
			end
			return
		end

		if a == "CTRL-SHIFT-T" then
			SkuOptions.TooltipReaderText = ""

			if GameTooltip:IsVisible() == true then
				if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
					if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
						local tText = unescape(TooltipLines_helper(GameTooltip:GetRegions()))
						if tText then
							if string.len(tText) > 0 then
								SkuOptions.TooltipReaderText = tText
								SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
								SkuOptions.TTS:PreviousLine()
							end
						end
					end
				end
			end
			SkuOptions.nextRollFrameNumber, tItem = SkuOptions:GetCurrentRollItem()
			if SkuOptions.nextRollFrameNumber then
				if tItem.itemId then
					SkuScanningTooltip:ClearLines()
					SkuScanningTooltip:SetHyperlink(tItem.itemId)--("linkString"
					SkuScanningTooltip:Show()
					if TooltipLines_helper(SkuScanningTooltip:GetRegions()) ~= "asd" then
						if TooltipLines_helper(SkuScanningTooltip:GetRegions()) ~= "" then
							local tText = unescape(TooltipLines_helper(SkuScanningTooltip:GetRegions()))
							if tText then
								if string.len(tText) > 0 then
									SkuOptions.TooltipReaderText = tText
									SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
									SkuOptions.TTS:PreviousLine()
								end
							end
						end
					end
					--SkuScanningTooltip:Hide()
				end
			end			
			return
		end

		if a == "SHIFT-UP" then 
			SkuOptions.TooltipReaderText = SkuOptions:UpdateOverviewText()
			if SkuOptions.TooltipReaderText then
				if SkuOptions.TooltipReaderText ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
					end
					SkuOptions.TTS:PreviousLine(2, true)
				end
			end
			return
		end
		if a == "SHIFT-DOWN" then
			SkuOptions.TooltipReaderText = SkuOptions:UpdateOverviewText()
			if SkuOptions.TooltipReaderText then
				if SkuOptions.TooltipReaderText ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
						SkuOptions.TTS:PreviousLine(2, true)
					else
						SkuOptions.TTS:NextLine(2, true)
					end
				end
			end
			return
		end
		if a == "CTRL-SHIFT-UP" then
			SkuOptions.TooltipReaderText = SkuOptions:UpdateOverviewText()
			if SkuOptions.TooltipReaderText then
				if SkuOptions.TooltipReaderText ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
					end
					SkuOptions.TTS:PreviousSection(2, true)
				end
			end
			return
		end
		if a == "CTRL-SHIFT-DOWN" then
			SkuOptions.TooltipReaderText = SkuOptions:UpdateOverviewText()
			if SkuOptions.TooltipReaderText then
				if SkuOptions.TooltipReaderText ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.TooltipReaderText, 1000)
						SkuOptions.TTS:PreviousSection(2, true)
					else
						SkuOptions.TTS:NextSection(2, true)
					end
				end
			end
			return
		end


		if SkuCore.inCombat == true then
			SkuCore.openMenuAfterCombat = true
			return
		end
		if SkuCore.isMoving == true then
			--dprint("SkuCore.isMoving", SkuCore.isMoving)
			SkuCore.openMenuAfterMoving = true
			return
		end
		SkuCore.openMenuAfterCombat = false
		SkuCore.openMenuAfterMoving = false
		--dprint("SkuCore.isMoving1", SkuCore.isMoving)
		if a == "SHIFT-F1" or a == nil then
			if #SkuOptions.Menu == 0 then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuNav"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuNav:MenuBuilder(tNewMenuEntry)
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuMob"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuMob:MenuBuilder(tNewMenuEntry)
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuChat"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuChat:MenuBuilder(tNewMenuEntry)
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuQuest"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuQuest:MenuBuilder(tNewMenuEntry)
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuCore"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuCore:MenuBuilder(tNewMenuEntry)
				end
				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuAuras"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuAuras:MenuBuilder(tNewMenuEntry)
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {"SkuOptions"}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuOptions:MenuBuilder(tNewMenuEntry)
				end
				local tNewMenuEntry = SkuOptions:InjectMenuItems(SkuOptions.Menu, {L["Local"]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					SkuOptions:MenuBuilderLocal(tNewMenuEntry, {L["Empty"]}, function(a, b, c, d) 
						--dprint(a, b, c, d) 
					end)
				end
			end

			--set menu to entry first
			SkuOptions.currentMenuPosition = SkuOptions.Menu[1]
			SkuOptions.currentMenuPosition:OnFirst()

			if self:IsVisible() then
				self:Hide()
				local tExclude = {
					["QuestLogFrame"] = "QuestLogFrameCloseButton",
					--["GameMenuFrame"] = "GameMenuButtonContinue",
					["CharacterFrame"] = "CharacterFrameCloseButton",
					["PlayerTalentFrame"] = "PlayerTalentFrameCloseButton",
					["MerchantFrame"] = "MerchantFrameCloseButton",
					["GossipFrame"] = "GossipFrameCloseButton",
					["ClassTrainerFrame"] = "ClassTrainerFrameCloseButton",
					
					["QuestFrame"] = "QuestFrameCloseButton",
					["TaxiFrame"] = "TaxiCloseButton",
					["PetStableFrame"] = "PetStableFrameCloseButton",
					--["AuctionFrame"] = "AuctionFrameCloseButton",
					["ReputationFrame"] = "CharacterFrameCloseButton",
					["SkillFrame"] = "CharacterFrameCloseButton",
					["HonorFrame"] = "CharacterFrameCloseButton",
					["DropDownList1"] = "DropDownList1",
					["InspectFrame"] = "InspectFrameCloseButton",

				}
				for i, v in pairs(SkuCore.interactFramesList) do
					if not tExclude[v] then
						if _G[v] then
							if _G[v]:IsVisible() == true then
								--dprint("hide", v)
								_G[v]:Hide()
							end
						end
					else
						if _G[v] then
							if _G[v]:IsVisible() == true then
								if v == "DropDownList1" then
									--dprint("leave", v)
									_G["DropDownList1"]:GetScript("OnLeave")(_G["DropDownList1"])
								else
									--dprint("click", v)
									_G[tExclude[v]]:Click()
								end
							end
						end
					end
				end

				if (MailFrame:IsShown() ) then
					CloseMail();
				end

				if (AuctionFrame:IsShown() ) then
					_G["AuctionFrameCloseButton"]:Click()
				end
				

				SkuOptions.Voice:OutputString(L["Menu;closed"], false, true, 0.3, true)
				SkuCore.Debug("", L["Menu;closed"], true)

			else
				self:Show()
				SkuOptions.currentMenuPosition = SkuOptions.Menu[1]
				PlaySound(811)
				SkuOptions.Voice:OutputString(L["Menu;open"], true, true, 0.3, true)
				SkuOptions.Voice:OutputString(SkuOptions.Menu[1].name, false, true, 0.3)
				SkuCore.Debug("", SkuOptions.currentMenuPosition.name, true)
			end
		end

		if a == "SHIFT-F9" then
			SkuOptions:SlashFunc(L["short"]..","..SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect1)
		end
		if a == "SHIFT-F10" then
			SkuOptions:SlashFunc(L["short"]..","..SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect2)
		end
		if a == "SHIFT-F11" then
			SkuOptions:SlashFunc(L["short"]..","..SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect3)
		end
		if a == "SHIFT-F12" then
			SkuOptions:SlashFunc(L["short"]..","..SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect4)
		end

		if a == "CTRL-SHIFT-F9" or a == "CTRL-SHIFT-F10" or a == "CTRL-SHIFT-F11" or a == "CTRL-SHIFT-F12" then
			if self:IsVisible() then
				local tTable = SkuOptions.currentMenuPosition
				local tBread = SkuOptions.currentMenuPosition.name
				while tTable.parent.name do
					tTable = tTable.parent
					tBread = tTable.name..","..tBread
				end

				if a == "CTRL-SHIFT-F9" then
					SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect1 = tBread
					SkuOptions.Voice:OutputString(L["Shortcut"]..";F9;"..L["updated;to"]..";"..tBread, true, true, 0.3)
				end
				if a == "CTRL-SHIFT-F10" then
					SkuOptions.Voice:OutputString(L["Shortcut"]..";F10;"..L["updated;to"]..";"..tBread, true, true, 0.3)
					SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect2 = tBread
				end
				if a == "CTRL-SHIFT-F11" then
					SkuOptions.Voice:OutputString(L["Shortcut"]..";F11;"..L["updated;to"]..";"..tBread, true, true, 0.3)
					SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect3 = tBread
				end
				if a == "CTRL-SHIFT-F12" then
					SkuOptions.Voice:OutputString(L["Shortcut"]..";F12;"..L["updated;to"]..";"..tBread, true, true, 0.3)
					SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect4 = tBread
				end
			else
				SkuOptions.Voice:OutputString(L["Impossible. Menu is not open."], true, true, 0.3)
			end
		end

		if a and (self:IsVisible() == true) then
			SkuOptions:ShowVisualMenu()
			local tTable = SkuOptions.currentMenuPosition
			local tBread = SkuOptions.currentMenuPosition.name
			local tResult = {}
			while tTable.parent.name do
				tTable = tTable.parent
				tBread = tTable.name.." > "..tBread
				table.insert(tResult, 1, tTable.name)
			end
			table.insert(tResult, SkuOptions.currentMenuPosition.name)
			SkuOptions:ShowVisualMenuSelectByPath(unpack(tResult))
		end
	end)
	tFrame:Hide()
	tFrame:SetScript("OnHide", function(self, a, b)
		--dprint("OnSkuOptionsMain OnHide")
		--ClearOverrideBindings(self)
		SkuOptions:HideVisualMenu()
	end)

	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F3", tFrame:GetName(), "CTRL-SHIFT-F3")

	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-T", tFrame:GetName(), "CTRL-SHIFT-T")
	SetOverrideBindingClick(tFrame, true, "SHIFT-UP", tFrame:GetName(), "SHIFT-UP")
	SetOverrideBindingClick(tFrame, true, "SHIFT-DOWN", tFrame:GetName(), "SHIFT-DOWN")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-UP", tFrame:GetName(), "CTRL-SHIFT-UP")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-DOWN", tFrame:GetName(), "CTRL-SHIFT-DOWN")

	SetOverrideBindingClick(tFrame, true, "SHIFT-F1", tFrame:GetName(), "SHIFT-F1")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F9", tFrame:GetName(), "SHIFT-F9")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F10", tFrame:GetName(), "SHIFT-F10")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F11", tFrame:GetName(), "SHIFT-F11")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F12", tFrame:GetName(), "SHIFT-F12")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F9", tFrame:GetName(), "CTRL-SHIFT-F9")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F10", tFrame:GetName(), "CTRL-SHIFT-F10")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F11", tFrame:GetName(), "CTRL-SHIFT-F11")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F12", tFrame:GetName(), "CTRL-SHIFT-F12")

	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-B", tFrame:GetName(), "CTRL-SHIFT-B")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-G", tFrame:GetName(), "CTRL-SHIFT-G")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-X", tFrame:GetName(), "CTRL-SHIFT-X")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-C", tFrame:GetName(), "CTRL-SHIFT-C")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:CreateMenuFrame()
	local OnSkuOptionsMainOption1LastInputTime = GetTime()
	local OnSkuOptionsMainOption1LastInputTimeout = 0.5

	tFrame = CreateFrame("Button", "OnSkuOptionsMainOption1", _G["OnSkuOptionsMain"], "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("OnSkuOptionsMainOption1")
	tFrame:SetPoint("TOP", _G["OnSkuOptionsMain"], "BOTTOM", 0, 0)

	local OnSkuOptionsMainOnKeyPressTimer = GetTimePreciseSec()

	tFrame:SetScript("OnChar", function(self, aKey, aB)
		--dprint("OnSkuOptionsMainOption1 OnChar", aKey)
		OnSkuOptionsMainOption1:GetScript("OnClick")(self, aKey)
	end)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		--dprint("OnSkuOptionsMainOption1 click", aKey, SkuOptions.currentMenuPosition.textFull)

		if aKey == "PAGEDOWN" then
			if SkuOptions.currentMenuPosition then
				if _G["CraftListScrollFrameScrollBarScrollDownButton"] then
					_G["CraftListScrollFrameScrollBarScrollDownButton"]:Click()
					_G["CraftListScrollFrameScrollBarScrollDownButton"]:Click()
				end
				if _G["TradeSkillListScrollFrameScrollBarScrollDownButton"] then
					_G["TradeSkillListScrollFrameScrollBarScrollDownButton"]:Click()
					_G["TradeSkillListScrollFrameScrollBarScrollDownButton"]:Click()
				end
				SkuCore:CheckFrames()
			end
			return
		end

		if aKey == "PAGEUP" then
			if SkuOptions.currentMenuPosition then
				if _G["CraftListScrollFrameScrollBarScrollUpButton"] then
					_G["CraftListScrollFrameScrollBarScrollUpButton"]:Click()
					_G["CraftListScrollFrameScrollBarScrollUpButton"]:Click()
				end
				if _G["TradeSkillListScrollFrameScrollBarScrollUpButton"] then
					_G["TradeSkillListScrollFrameScrollBarScrollUpButton"]:Click()
					_G["TradeSkillListScrollFrameScrollBarScrollUpButton"]:Click()
				end
				SkuCore:CheckFrames()
			end
			return
		end

		if aKey == "SHIFT-RIGHT" then
			if SkuOptions.currentMenuPosition then
				if SkuOptions.currentMenuPosition.name ~= "" then
					SkuOptions.Voice:OutputString(SkuOptions.currentMenuPosition.name, false, true, 0, false, nil, nil, nil, true) -- for strings with lookup in string index
				end
			end
			return
		end

		local tIsDoubleDown = false
		local tSecondTime = GetTimePreciseSec() - OnSkuOptionsMainOnKeyPressTimer
		if tSecondTime < 0.25 then
			tIsDoubleDown = true
		end
		OnSkuOptionsMainOnKeyPressTimer = GetTimePreciseSec()

		if SkuOptions.MenuAccessKeysChars[aKey] then
			aKey = string.lower(aKey)
		end

		if aKey == "SPACE" then
			aKey = " "
		end

		if SkuCore.inCombat == true then
			SkuCore.openMenuAfterCombat = true
			return
		end
		if SkuCore.isMoving == true then
			SkuCore.openMenuAfterMoving = true
			return
		end
		SkuCore.openMenuAfterCombat = false
		SkuCore.openMenuAfterMoving = false

		if SkuOptions.currentMenuPosition.parent.filterable == true then
			if  SkuOptions.MenuAccessKeysChars[aKey] or SkuOptions.MenuAccessKeysNumbers[aKey] then
				if aKey == "shift-," then aKey = ";" end
				if SkuOptions.Filterstring == "" then
					--SkuCore:Debug("empty = rep")
					SkuOptions.Filterstring = aKey
				elseif string.len(SkuOptions.Filterstring) == 1 and ((GetTime() - OnSkuOptionsMainOption1LastInputTime) < OnSkuOptionsMainOption1LastInputTimeout) then
					--SkuCore:Debug("1 and in time = add")
					SkuOptions.Filterstring = SkuOptions.Filterstring..aKey
					aKey = ""
				elseif  string.len(SkuOptions.Filterstring) > 1  then
					--SkuCore:Debug("> 1 = add")
					SkuOptions.Filterstring = SkuOptions.Filterstring..aKey
					aKey = ""
				else
					--SkuCore:Debug("1 and out of time = rep")
					SkuOptions.Filterstring = aKey
				end
				OnSkuOptionsMainOption1LastInputTime = GetTime()

				if string.len(SkuOptions.Filterstring) > 1  then
					SkuOptions:ApplyFilter(SkuOptions.Filterstring)
					--SkuCore:Debug("filter by: ", SkuOptions.Filterstring)
					aKey = ""
				end
			end
			if  string.len(SkuOptions.Filterstring) > 1  then
				if aKey == "BACKSPACE" then
					SkuOptions.Filterstring = ""
					SkuOptions:ApplyFilter(SkuOptions.Filterstring)
					aKey = ""
				end
				if aKey == "LEFT" then
					SkuOptions.Filterstring = ""
					SkuOptions:ApplyFilter(SkuOptions.Filterstring)
				end
			end
		end

		local tVocalizeReset = true

		if aKey == "UP" then
			if tIsDoubleDown ~= true then
				SkuOptions.currentMenuPosition:OnPrev()
			else
				local tOut = false
				local tOldMenuName = ""
				while tOut == false do
					SkuOptions.currentMenuPosition:OnPrev()
					if not string.find(SkuOptions.currentMenuPosition.name, L["Empty"]) then
						tOut = true
					end
					if SkuOptions.currentMenuPosition.name == tOldMenuName then
						tOut = true
					end
					tOldMenuName = SkuOptions.currentMenuPosition.name
				end
			end
		end
		if aKey == "DOWN" then
			if tIsDoubleDown ~= true then
				SkuOptions.currentMenuPosition:OnNext()
			else
				local tOut = false
				local tOldMenuName = ""
				while tOut == false do
					SkuOptions.currentMenuPosition:OnNext()
					if not string.find(SkuOptions.currentMenuPosition.name, L["Empty"]) then
						tOut = true
					end
					if SkuOptions.currentMenuPosition.name == tOldMenuName then
						tOut = true
					end
					tOldMenuName = SkuOptions.currentMenuPosition.name
				end
			end
		end
		if aKey == "RIGHT" then
			if #SkuOptions.currentMenuPosition.children > 0 or SkuOptions.currentMenuPosition.dynamic == true then
				SkuOptions.currentMenuPosition:OnSelect()
				SkuOptions:ClearFilter()
			end
		end
		if aKey == "LEFT" then
			SkuOptions.currentMenuPosition:OnBack()
			SkuOptions:ClearFilter()
		end
		if aKey == "HOME" then
			SkuOptions.currentMenuPosition:OnFirst()
		end
		if aKey == "ENTER" then
			tVocalizeReset = false
			SkuOptions.currentMenuPosition:OnSelect(true)
			SkuOptions:ClearFilter()
		end
		if aKey == "BACKSPACE" then
			SkuOptions.currentMenuPosition:OnBack()
			SkuOptions:ClearFilter()
		end
		if aKey == "ESCAPE" then
			SkuOptions:CloseMenu()
			SkuOptions:ClearFilter()
		end
		if SkuOptions.MenuAccessKeysChars[aKey] or (SkuOptions.MenuAccessKeysNumbers[aKey]) then
			SkuOptions.currentMenuPosition:OnKey(aKey)
		end
		PlaySound(811)

		if aKey ~= "ESCAPE" and _G["OnSkuOptionsMainOption1"]:IsVisible() and aKey ~= "SHIFT-DOWN" then
			SkuOptions:VocalizeCurrentMenuName(tVocalizeReset)
			if string.len(SkuOptions.Filterstring) > 1  then
				--SkuOptions.Voice:OutputString("Filter", false, true, 0.3)
			end
		end

		if aKey ~= "SHIFT-UP" and aKey ~= "SHIFT-DOWN" and aKey ~= "CTRL-SHIFT-UP" and aKey ~= "CTRL-SHIFT-DOWN" then
			if SkuOptions.TTS:IsVisible() then
				--SkuOptions.TTS:Output("", -1)
				SkuOptions.TTS.MainFrame:Hide()
			end
		end

		if aKey == "CTRL-SHIFT-D" then
			SkuQuest:OnSkuQuestAbandon()
		end
		if aKey == "CTRL-SHIFT-T" then
			SkuQuest:OnSkuQuestPush()
		end

		if aKey == "SHIFT-UP" then 
			if SkuOptions.currentMenuPosition.textFull then
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.currentMenuPosition.textFull, 1000)
					end
					SkuOptions.TTS:PreviousLine(SkuOptions.currentMenuPosition.ttsEngine)
				end
			end
		end
		if aKey == "SHIFT-DOWN" then
			if SkuOptions.currentMenuPosition.textFull then
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.currentMenuPosition.textFull, 1000)
					end
					SkuOptions.TTS:NextLine(SkuOptions.currentMenuPosition.ttsEngine)
				end
			end
		end
		if aKey == "CTRL-SHIFT-UP" then
			if SkuOptions.currentMenuPosition.textFull then
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.currentMenuPosition.textFull, 1000)
					end
					SkuOptions.TTS:PreviousSection(SkuOptions.currentMenuPosition.ttsEngine)
				end
			end
		end
		if aKey == "CTRL-SHIFT-DOWN" then
			if SkuOptions.currentMenuPosition.textFull then
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(SkuOptions.currentMenuPosition.textFull, 1000)
					end
					SkuOptions.TTS:NextSection(SkuOptions.currentMenuPosition.ttsEngine)
				end
			end
		end
		if aKey ~= "ESCAPE" then
			SkuOptions:ShowVisualMenu()
			local tTable = SkuOptions.currentMenuPosition
			local tBread = SkuOptions.currentMenuPosition.name
			local tResult = {}
			while tTable.parent.name do
				tTable = tTable.parent
				tBread = tTable.name.." > "..tBread
				table.insert(tResult, 1, tTable.name)
			end
			table.insert(tResult, SkuOptions.currentMenuPosition.name)
			SkuOptions:ShowVisualMenuSelectByPath(unpack(tResult))
		end
	end)

	tFrame:SetScript("OnShow", function(self)
		--dprint("OnSkuOptionsMainOption1 OnShow")
		if SkuCore.inCombat == true then
			SkuCore.openMenuAfterCombat = true
			return
		end
		if SkuCore.isMoving == true then
			SkuCore.openMenuAfterMoving = true
			return
		end

		SkuCore.openMenuAfterCombat = false
		SkuCore.openMenuAfterMoving = false	
		PlaySound(88)
		--SkuOptions.Voice:OutputString("Navi geöffnet", true, true, 0.3)
		SetOverrideBindingClick(self, true, "PAGEUP", "OnSkuOptionsMainOption1", "PAGEUP")
		SetOverrideBindingClick(self, true, "PAGEDOWN", "OnSkuOptionsMainOption1", "PAGEDOWN")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-D", "SkuQuestMainOption1", "CTRL-SHIFT-D")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-T", "SkuQuestMainOption1", "CTRL-SHIFT-T")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-UP", "OnSkuOptionsMainOption1", "CTRL-SHIFT-UP")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-DOWN", "OnSkuOptionsMainOption1", "CTRL-SHIFT-DOWN")
		SetOverrideBindingClick(self, true, "SHIFT-UP", "OnSkuOptionsMainOption1", "SHIFT-UP")
		SetOverrideBindingClick(self, true, "SHIFT-DOWN", "OnSkuOptionsMainOption1", "SHIFT-DOWN")

		SetOverrideBindingClick(self, true, "SHIFT-RIGHT", "OnSkuOptionsMainOption1", "SHIFT-RIGHT")
		SetOverrideBindingClick(self, true, "HOME", "OnSkuOptionsMainOption1", "HOME")
		SetOverrideBindingClick(self, true, "UP", "OnSkuOptionsMainOption1", "UP")
		SetOverrideBindingClick(self, true, "DOWN", "OnSkuOptionsMainOption1", "DOWN")
		SetOverrideBindingClick(self, true, "LEFT", "OnSkuOptionsMainOption1", "LEFT")
		SetOverrideBindingClick(self, true, "RIGHT", "OnSkuOptionsMainOption1", "RIGHT")
		SetOverrideBindingClick(self, true, "BACKSPACE", "OnSkuOptionsMainOption1", "BACKSPACE")
		SetOverrideBindingClick(self, true, "ESCAPE", "OnSkuOptionsMainOption1", "ESCAPE")
		for x = 1, #SkuOptions.MenuAccessKeysChars do
			--SetOverrideBindingClick(self, true, SkuOptions.MenuAccessKeysChars[x], "OnSkuOptionsMainOption1", SkuOptions.MenuAccessKeysChars[x])
			SetOverrideBindingClick(UIParent, true, SkuOptions.MenuAccessKeysChars[x], "UIParent", SkuOptions.MenuAccessKeysChars[x])
			SkuOptions.MenuAccessKeysChars[SkuOptions.MenuAccessKeysChars[x]] = SkuOptions.MenuAccessKeysChars[x]
		end
		--SetOverrideBindingClick(self, true, "SPACE", "OnSkuOptionsMainOption1", "SPACE")
		SetOverrideBindingClick(UIParent, true, "SPACE", "UIParent", "SPACE")
		for x = 1, #SkuOptions.MenuAccessKeysNumbers do
			--SetOverrideBindingClick(self, true, SkuOptions.MenuAccessKeysNumbers[x], "OnSkuOptionsMainOption1", SkuOptions.MenuAccessKeysNumbers[x])
			SetOverrideBindingClick(UIParent, true, SkuOptions.MenuAccessKeysNumbers[x], "UIParent", SkuOptions.MenuAccessKeysNumbers[x])
			SkuOptions.MenuAccessKeysNumbers[SkuOptions.MenuAccessKeysNumbers[x]] = SkuOptions.MenuAccessKeysNumbers[x]
		end
		SkuOptions:StartStopBackgroundSound(true)

		SkuOptions:ShowVisualMenu()
		local tTable = SkuOptions.currentMenuPosition
		local tBread = SkuOptions.currentMenuPosition.name
		local tResult = {}
		while tTable.parent.name do
			tTable = tTable.parent
			tBread = tTable.name.." > "..tBread
			table.insert(tResult, 1, tTable.name)
		end
		table.insert(tResult, SkuOptions.currentMenuPosition.name)
		SkuOptions:ShowVisualMenuSelectByPath(unpack(tResult))
	end)

	tFrame:SetScript("OnHide", function(self)
		--dprint("OnSkuOptionsMainOption1 OnHide")
		if SkuCore.inCombat == true then
			return
		end
		--SkuOptions.Voice:OutputString("Navi geschlossen", true, true, 0.3)
		ClearOverrideBindings(self)
		ClearOverrideBindings(UIParent)
		PlaySound(89)

		if _G["CraftFrame"] then
			if _G["CraftFrame"]:IsVisible() == true then
				--_G["QuestFrameDetailPanel"]:Hide()
				_G["CraftFrameCloseButton"]:GetScript("OnClick")(_G["CraftFrameCloseButton"])
			end
		end
		if _G["TradeSkillFrame"] then
			if _G["TradeSkillFrame"]:IsVisible() == true then
				--_G["QuestFrameDetailPanel"]:Hide()
				_G["TradeSkillFrameCloseButton"]:GetScript("OnClick")(_G["TradeSkillFrameCloseButton"])
			end
		end

		if _G["QuestFrameDetailPanel"]:IsVisible() == true then
			--_G["QuestFrameDetailPanel"]:Hide()
			_G["QuestFrameDeclineButton"]:GetScript("OnClick")(_G["QuestFrameDeclineButton"])
		end
		if _G["QuestFrameProgressPanel"]:IsVisible() == true then
			--_G["QuestFrameProgressPanel"]:Hide()
			_G["QuestFrameGoodbyeButton"]:GetScript("OnClick")(_G["QuestFrameGoodbyeButton"])
		end
		if _G["TaxiFrame"]:IsVisible() == true then
			_G["TaxiCloseButton"]:GetScript("OnClick")(_G["TaxiCloseButton"])
			--_G["TaxiFrame"]:Hide()
		end
		if _G["StaticPopup1"]:IsVisible() == true then
			_G["StaticPopup1"]:Hide()
		end
		if _G["GossipFrame"]:IsVisible() == true then
			_G["GossipFrameGreetingGoodbyeButton"]:GetScript("OnClick")(_G["GossipFrameGreetingGoodbyeButton"])
		end
		if _G["QuestFrameGreetingPanel"]:IsVisible() == true then
			_G["QuestFrameGoodbyeButton"]:GetScript("OnClick")(_G["QuestFrameGoodbyeButton"])
		end

		SkuOptions.TTS:Output("", -1)
		SkuOptions:StartStopBackgroundSound(false)
		SkuOptions:HideVisualMenu()
		if QuestLogFrame:IsVisible() == true then
			ToggleQuestLog()
		end
	end)

	tFrame:Show()

	tFrame = CreateFrame("Button", "SecureOnSkuOptionsMainOption1", _G["OnSkuOptionsMain"], "SecureActionButtonTemplate")
	tFrame:SetText("SecureOnSkuOptionsMainOption1")
	tFrame:SetPoint("TOP", _G["OnSkuOptionsMain"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnShow", function(self)
		SetOverrideBindingClick(self, true, "ENTER", "SecureOnSkuOptionsMainOption1", "ENTER")
	end)
	tFrame:SetScript("OnHide", function(self)
		ClearOverrideBindings(self)
	end)
	tFrame:HookScript("OnClick", _G["OnSkuOptionsMainOption1"]:GetScript("OnClick"))
	tFrame:Show()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnInitialize()
	--dprint("SkuOptions OnInitialize")

	if SkuOptions then
		options.args["SkuOptions"] = SkuOptions.options
		defaults.profile["SkuOptions"] = SkuOptions.defaults
	end
	if SkuCore then
		options.args["SkuCore"] = SkuCore.options
		defaults.profile["SkuCore"] = SkuCore.defaults
	end
	if SkuAuras then
		options.args["SkuAuras"] = SkuAuras.options
		defaults.profile["SkuAuras"] = SkuAuras.defaults
	end
	if SkuChat then
		options.args["SkuChat"] = SkuChat.options
		defaults.profile["SkuChat"] = SkuChat.defaults
	end
	if SkuMob then
		options.args["SkuMob"] = SkuMob.options
		defaults.profile["SkuMob"] = SkuMob.defaults
	end
	if SkuNav then
		options.args["SkuNav"] = SkuNav.options
		defaults.profile["SkuNav"] = SkuNav.defaults
	end
	if SkuQuest then
		options.args["SkuQuest"] = SkuQuest.options
		defaults.profile["SkuQuest"] = SkuQuest.defaults
	end

	SkuOptions:RegisterChatCommand("Sku", "SlashFunc")
	SkuOptions.AceConfig = LibStub("AceConfig-3.0")
	SkuOptions.AceConfig:RegisterOptionsTable("Sku", options, {"taop"})
	SkuOptions.AceConfigDialog = LibStub("AceConfigDialog-3.0")
	SkuOptions.AceConfigDialog:AddToBlizOptions("Sku")
	SkuOptions.db = LibStub("AceDB-3.0"):New("SkuOptionsDB", defaults) -- TODO: fix default values for subgroups
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(SkuOptions.db)
	SkuOptions.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	SkuOptions.db.RegisterCallback(self, "OnProfileCopied", "OnProfileCopied")
	SkuOptions.db.RegisterCallback(self, "OnProfileReset", "OnProfileReset")

	SkuOptions:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuOptions:RegisterEvent("START_LOOT_ROLL")
	SkuOptions:RegisterEvent("CANCEL_LOOT_ROLL")
	SkuOptions:RegisterEvent("LOOT_SLOT_CHANGED")

	SkuOptions:CreateControlFrame()
	SkuOptions:CreateMainFrame()
	SkuOptions.Filterstring = ""
	SkuOptions:CreateMenuFrame()
end

local tOldChildren = false
---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ClearFilter()
	if tOldChildren ~= false then
		tOldChildren = false
		--SkuCore:Debug("ClearFilter: filter cleared, no menu update")
	else
		--SkuCore:Debug("ClearFilter: error: no old child data", tOldChildren)
	end
	SkuOptions.Filterstring = ""
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ApplyFilter(aFilterstring)
	--dprint("aFilterstring", aFilterstring, SkuOptions.currentMenuPosition.parent.filterable)

	aFilterstring = string.lower(aFilterstring)

	if SkuOptions.currentMenuPosition.parent.filterable ~= true then
		--SkuCore:Debug("ApplyFilter: not filterable")
		return
	end

	if aFilterstring ~= "" then
		if tOldChildren ~= false then
			--SkuCore:Debug("ApplyFilter: is already filtered; will unfilter first", tOldChildren)
			SkuOptions:ApplyFilter("")
		end

		tOldChildren = SkuOptions.currentMenuPosition.parent.children

		local tChildrenFiltered = {}
		local tFilterEntry = SkuOptions:TableCopy(tOldChildren[1])
		tFilterEntry.name = L["Filter"]..";"..aFilterstring
		table.insert(tChildrenFiltered, tFilterEntry)
		for x = 1, #tOldChildren do
			local tHayStack = string.lower(tOldChildren[x].name)
			tHayStack = string.gsub(tHayStack, L["OBJECT"]..";%d+;", L["OBJECT"]..";")
			tHayStack = string.gsub(tHayStack, ";", " ")
			tHayStack = string.gsub(tHayStack, "#", " ")

			local tTempHayStack = tHayStack
			for i, v in pairs({strsplit(tHayStack, " ")}) do
				local tNumberTest = tonumber(v)
				if tNumberTest then
					local tFloat = math.floor(tNumberTest)
					if (tNumberTest > 20000) or (tNumberTest - tFloat > 0) then
						tTempHayStack = string.gsub(tTempHayStack, v)
					end
				end
			end
			tHayStack = tTempHayStack

			if string.find(string.lower(tHayStack), string.lower(aFilterstring))  then
					table.insert(tChildrenFiltered, tOldChildren[x])
			end
		end

		if #tChildrenFiltered == 0 then
			table.insert(tChildrenFiltered, tOldChildren[1])
			--SkuCore:Debug("ApplyFilter: keine Ergebnisse f�r filter, element 1 wird angezeigt")
			SkuOptions.Voice:OutputString(L["No results"], true, true, 0.2)
		end

		for x = 1, #tChildrenFiltered do
			if tChildrenFiltered[x+1] then
				tChildrenFiltered[x].next = tChildrenFiltered[x+1]
			else
				tChildrenFiltered[x].next = nil
			end
			if tChildrenFiltered[x-1] then
				tChildrenFiltered[x].prev = tChildrenFiltered[x-1]
			else
				tChildrenFiltered[x].prev = nil
			end
		end

		SkuOptions.currentMenuPosition.parent.children = tChildrenFiltered--tOldChildren)
		SkuOptions.currentMenuPosition:OnFirst()

		SkuOptions.Voice:OutputString(L["Filter applied"], true, true, 0.3)
		--SkuCore:Debug("ApplyFilter: filter applied, menu updated")
	end
	if aFilterstring == "" then
		if tOldChildren ~= false then
			SkuOptions.currentMenuPosition.parent.children = tOldChildren--tOldChildren)
			for x = 1, #SkuOptions.currentMenuPosition.parent.children do
				if SkuOptions.currentMenuPosition.parent.children[x+1] then
					SkuOptions.currentMenuPosition.parent.children[x].next = SkuOptions.currentMenuPosition.parent.children[x+1]
				else
					SkuOptions.currentMenuPosition.parent.children[x].next = nil
				end
				if SkuOptions.currentMenuPosition.parent.children[x-1] then
					SkuOptions.currentMenuPosition.parent.children[x].prev = SkuOptions.currentMenuPosition.parent.children[x-1]
				else
					SkuOptions.currentMenuPosition.parent.children[x].prev = nil
				end
			end
			SkuOptions.currentMenuPosition:OnFirst()
			tOldChildren = false

			SkuOptions.Voice:OutputString(L["Filter removed"], true, true, 0.3)
			--SkuCore:Debug("ApplyFilter: filter cleared, menu updated")
		else
			--SkuCore:Debug("ApplyFilter: error: no old child data. this should not happen!")
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnEnable()
	--dprint("SkuOptions OnEnable")
	if SkuCore.inCombat == true then
		return
	end

	--check if this profile already has specific sound settings (is not first load). copy current blizz settings if not.
	if SkuOptions.db.profile["SkuOptions"].soundChannels.MasterVolume == -1 then
		SkuOptions.db.profile["SkuOptions"].soundChannels.MasterVolume = math.floor(BlizzardOptionsPanel_GetCVarSafe("Sound_MasterVolume") * 100)
		SkuOptions.db.profile["SkuOptions"].soundChannels.SFXVolume = math.floor(BlizzardOptionsPanel_GetCVarSafe("Sound_SFXVolume") * 100)
		SkuOptions.db.profile["SkuOptions"].soundChannels.MusicVolume = math.floor(BlizzardOptionsPanel_GetCVarSafe("Sound_MusicVolume") * 100)
		SkuOptions.db.profile["SkuOptions"].soundChannels.AmbienceVolume = math.floor(BlizzardOptionsPanel_GetCVarSafe("Sound_AmbienceVolume") * 100)
		SkuOptions.db.profile["SkuOptions"].soundChannels.DialogVolume = math.floor(BlizzardOptionsPanel_GetCVarSafe("Sound_DialogVolume") * 100)
	end

	--set the sound channel volumes
	BlizzardOptionsPanel_SetCVarSafe("Sound_MasterVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.MasterVolume / 100)
	BlizzardOptionsPanel_SetCVarSafe("Sound_SFXVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.SFXVolume / 100)
	BlizzardOptionsPanel_SetCVarSafe("Sound_MusicVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.MusicVolume / 100)
	BlizzardOptionsPanel_SetCVarSafe("Sound_AmbienceVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.AmbienceVolume / 100)
	BlizzardOptionsPanel_SetCVarSafe("Sound_DialogVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.DialogVolume / 100)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnDisable()

end

---------------------------------------------------------------------------------------------------------------------------------------
local oDCFAddMessage = nil--DEFAULT_CHAT_FRAME.AddMessage
function nDCFAddMessage(...)
	local _, b = ...
	if b then
		local tResult = string.find(b, L["is no player with"])
		if not tResult then
			oDCFAddMessage(...)
		else
			local _, tTargetName, _ = string.split("'", b)

			if SkuOptions then
				if SkuOptions.TrackingTargets then
					for x = 1, #SkuOptions.TrackingTargets do
						if SkuOptions.TrackingTargets[x] then
							if SkuOptions.TrackingTargets[x] == tTargetName then
								table.remove(SkuOptions.TrackingTargets, x)
							end
						end
					end
				end
			end
			if SkuFluegel then
				if SkuFluegel.TrackingTarget then
					for q = 1, 4 do
						if tTargetName == SkuFluegel.TrackingTarget[q] then
							SkuFluegel.TrackingTarget[q] = L["No target"]
							SkuFluegel:RefreshVisuals()
						end
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...

	if isInitialLogin == true or isReloadingUi == true then
		SkuOptions:RegisterComm("Sku")
		if not oDCFAddMessage then
			oDCFAddMessage = DEFAULT_CHAT_FRAME.AddMessage
			DEFAULT_CHAT_FRAME.AddMessage = nDCFAddMessage
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuOptions.nextRollFrameNumber = 0
function SkuOptions:START_LOOT_ROLL(rollID, rollTime, lootHandle, a, b)
	--dprint("START_LOOT_ROLL(rollID, rollTime, lootHandle, a, b", rollID, rollTime, lootHandle, a, b)
	local tItem
	SkuOptions.nextRollFrameNumber, tItem = SkuOptions:GetCurrentRollItem()
	if SkuOptions.nextRollFrameNumber then
		SkuOptions.Voice:OutputString(L["Roll on"].." "..tItem.name.." "..tItem.quality.." "..tItem.bind.." "..tItem.type.." "..tItem.subtype, true, true, 0.3, true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:CANCEL_LOOT_ROLL(rollID, a, b)
	--dprint("CANCEL_LOOT_ROLL(rollID, a, b", rollID, a, b)
	local tItem
	SkuOptions.nextRollFrameNumber, tItem = SkuOptions:GetCurrentRollItem()
	if SkuOptions.nextRollFrameNumber then
		SkuOptions.Voice:OutputString(L["Roll on"].." "..tItem.name.." "..tItem.quality.." "..tItem.bind.." "..tItem.type.." "..tItem.subtype, true, true, 0.3, true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:LOOT_SLOT_CHANGED(lootSlot, a, b)
	--dprint("OT_CHANGED(lootSlot, a, b", lootSlot, a, b)
	local tItem
	SkuOptions.nextRollFrameNumber, tItem = SkuOptions:GetCurrentRollItem()
	if SkuOptions.nextRollFrameNumber then
		SkuOptions.Voice:OutputString(L["Roll on"].." "..tItem.name.." "..tItem.quality.." "..tItem.bind.." "..tItem.type.." "..tItem.subtype, true, true, 0.3, true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:GetCurrentRollItem()
	local tLootFrameNumber = nil
	local tLootItem = nil
	for x = 1, 6 do
		if _G["GroupLootFrame"..x] then
			if _G["GroupLootFrame"..x]:IsVisible() then
				tLootFrameNumber = x
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(GetLootRollItemLink(_G["GroupLootFrame"..x].rollID))
				tLootItem = {name = _G["GroupLootFrame"..x.."Name"]:GetText(), quality = _G["ITEM_QUALITY"..itemQuality.."_DESC"], type = itemType, subtype = itemSubType, bind = SkuOptions.BindTypeStrings[bindType], itemId = GetLootRollItemLink(_G["GroupLootFrame"..x].rollID), rollId = _G["GroupLootFrame"..x].rollID}
			end
		end
	end
	return tLootFrameNumber, tLootItem
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aStr string string to vocalize
---@param aReset bool if the queue should be reseted
---@param aWait bool if this should be queued
---@param aDuration number duration of the audio
---@param aDoNotOverride bool if this audio could be reseted by others
function SkuOptions:VocalizeMultipartString(aStr, aReset, aWait, aDuration, aDoNotOverride, engine, aVocalizeAsIs)
	--dprint("VocalizeMultipartString", aStr)
	-- don't vocalize object numbers
	local tTempHayStack = string.gsub(aStr, L["OBJECT"]..";%d+;", L["OBJECT"]..";")
	aStr = tTempHayStack

	if not engine then
		local sep, fields = ";", {}
		local pattern = string.format("([^%s]+)", sep)
		aStr:gsub(pattern, function(c) fields[#fields+1] = c end)
		if fields then
			--first part (with q reset)
			--if SkuAudioFileIndex[tostring(fields[1])] or tonumber(fields[x]) then --element is in string index
				SkuOptions.Voice:OutputString(fields[1], aReset, aWait, 0.2, aDoNotOverride, nil, nil, nil, nil, aVocalizeAsIs)
			--else
				--SkuOptions.Voice:Output(fields[1]:lower()..".mp3", true, true, 0.2)
				--SkuOptions.Voice:OutputString("Keine Audiodatei", true, true, 0.2)
			--end
			--remaining parts (w/o q reset)
			for x = 2, #fields do
				--if SkuAudioFileIndex[tostring(fields[x])] or tonumber(fields[x]) then --element is in string index
					SkuOptions.Voice:OutputString(fields[x], false, aWait, 0.2, aDoNotOverride, nil, nil, nil, nil, aVocalizeAsIs)
					--else
					--SkuOptions.Voice:Output(fields[x]:lower()..".mp3", false, true, 0.2)
				--	SkuOptions.Voice:OutputString("Keine Audiodatei", false, true, 0.2)
				--end
			end
		end
	else
		SkuOptions.Voice:OutputString(aStr, aReset, aWait, 0.2, aDoNotOverride, false, nil, engine, nil, aVocalizeAsIs)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aReset bool reset queue
function SkuOptions:VocalizeCurrentMenuName(aReset)
	--dprint("VocalizeCurrentMenuName", aReset)
	if aReset == nil then aReset = true end
--dprint(aReset)
	local tTable = SkuOptions.currentMenuPosition

	--get menu pos
	local tMenuNumber = nil
	if tTable.parent then
		if tTable.parent.children then
			if tTable.parent.children ~= {} then
				for x = 1, #tTable.parent.children do
					if tTable.parent.children[x].name == SkuOptions.currentMenuPosition.name then
						tMenuNumber = x
					end
				end
			end
		else
			for x = 1, #SkuOptions.Menu do
				if SkuOptions.Menu[x].name == SkuOptions.currentMenuPosition.name then
					tMenuNumber = x
				end
			end
		end
	end
	SkuOptions.currentMenuPosition:BuildChildren(SkuOptions.currentMenuPosition)

	--handle filter placeholder
	local tUncleanValue = SkuOptions.currentMenuPosition.name
	--handle unicode chars
	local tString = ""
	if string.find(tUncleanValue, L["Filter"]..";") then
		tUncleanValue = string.lower(tUncleanValue:sub(string.len(L["Filter"]..";") + 1))
		for tChr in tUncleanValue:gmatch("[\33-\127\192-\255]?[\128-\191]*") do
			tString = tString..tChr..";"
		end
		while string.find(tString, ";;") do
			tString = string.gsub(tString, ";;", ";")
		end
		tUncleanValue = tString
	end


	if string.sub(tUncleanValue, 1, string.len(L["Filter"]..";")) == L["Filter"]..";" then
		local tSecondSegment = string.sub(tUncleanValue, string.len(L["Filter"]..";") + 1)
		tUncleanValue = L["Filter"]..";"
		for q = 1, string.len(tSecondSegment) do
			tUncleanValue = tUncleanValue..string.sub(tSecondSegment, q, q)..";"
		end
	end

	local tCleanValue = tUncleanValue--SkuOptions.currentMenuPosition.name
	local tPrefix
	local tPos = string.find(tUncleanValue, "#")
	if tPos ~= nil then
		tPrefix = string.sub(tUncleanValue, 1, tPos - 1)
		tCleanValue = string.sub(tUncleanValue,  tPos + 1)
	end

	local tFinalString = ""

	if SkuOptions.db.profile[MODULE_NAME].vocalizeMenuNumbers == true and  SkuOptions.currentMenuPosition.noMenuNumbers ~= true then
		tFinalString = tFinalString..tMenuNumber..";"
	end
	if tPrefix then
		tFinalString = tFinalString..tPrefix..";"
	end
	tFinalString = tFinalString..tCleanValue
	if SkuOptions.db.profile[MODULE_NAME].vocalizeSubmenus == true then
		if #SkuOptions.currentMenuPosition.children > 0 then
			tFinalString = tFinalString..";"..L["plus"]
		end
	end

	SkuOptions:VocalizeMultipartString(tFinalString, aReset, true, nil, nil, SkuOptions.currentMenuPosition.ttsEngine, SkuOptions.currentMenuPosition.vocalizeAsIs)

	--debug as text
	local tBread = SkuOptions.currentMenuPosition.name
	while tTable.parent.name do
		tTable = tTable.parent
		tBread = tTable.name.." > "..tBread
	end
	SkuCore:Debug(tBread, true)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:InjectMenuItems(aParentMenu, aNewItems, aItemTemplate)
	local rValue = nil

	if aItemTemplate then
		local tParentMenu = aParentMenu.children or aParentMenu
		for x = 1, #aNewItems do
			tParentMenu = tParentMenu + aItemTemplate
			tParentMenu[#tParentMenu].name = aNewItems[x]
			tParentMenu[#tParentMenu].parent = aParentMenu
			if tParentMenu[#tParentMenu - 1] then
				tParentMenu[#tParentMenu].prev = tParentMenu[#tParentMenu - 1]
				tParentMenu[#tParentMenu - 1].next = tParentMenu[#tParentMenu]
			end
			rValue = tParentMenu[#tParentMenu]
		end
	else
		aParentMenu.children = aNewItems
		for x = 1, #aNewItems do
			aNewItems[x].parent = aParentMenu
		end
	end

	return rValue
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:TableCopy(t, deep, seen)
	seen = seen or {}
	if t == nil then return nil end
	if seen[t] then return seen[t] end
	local nt = {}
	for k, v in pairs(t) do
		if type(v) ~= "userdata" and k ~= "frame" and k ~= 0  then
			if deep and type(v) == 'table' then
				nt[k] = SkuOptions:TableCopy(v, deep, seen)
			else
				nt[k] = v
			end
		end
	end
	--setmetatable(nt, getmetatable(t), deep, seen))
	seen[t] = nt
	return nt
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuIterateGossipList(aGossipListTable, aParentMenuTable, aTab)
	
	for x = 1, #aGossipListTable do
		local index = aGossipListTable[x]

		if #aGossipListTable[index].childs == 0 then
			--dprint(aTab, x, "ENTRIY: "..aGossipListTable[index].textFirstLine)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentMenuTable, {aGossipListTable[index].textFirstLine}, SkuGenericMenuItem)
			tNewMenuEntry.filterable = true
			if aGossipListTable[index].textFull then
				--[[if aGossipListTable[index].textFull ~= "" then
					local tNewSubMenuEntry = SkuOptions:InjectMenuItems(tNewMenuEntry, {"Anzeigen"}, SkuGenericMenuItem)
					tNewSubMenuEntry.OnAction = function()
						--print("anzeigen: ", aGossipListTable[index].textFull)
					end
				end]]
				tNewMenuEntry.textFull = aGossipListTable[index].textFull
			end
			if tNewMenuEntry and aGossipListTable[index].click == true then
				if aGossipListTable[index].func then
					local tNewSubMenuEntry = SkuOptions:InjectMenuItems(tNewMenuEntry, {L["Left click"]}, SkuGenericMenuItem)
					if aGossipListTable[index].containerFrameName then
						tNewSubMenuEntry.macrotext = "/click "..aGossipListTable[index].containerFrameName.." LeftButton\r\n/script SkuCore:CheckFrames()"
						if aGossipListTable[index].obj.GetParent then
							if aGossipListTable[index].obj:GetParent() then
								if aGossipListTable[index].obj:GetParent().rollID then
									tNewSubMenuEntry.macrotext = "/script RollOnLoot("..aGossipListTable[index].obj:GetParent().rollID..", "..aGossipListTable[index].obj:GetID()..") SkuCore:CheckFrames()"
								end
								if aGossipListTable[index].obj:GetParent():GetName() == "StaticPopup1" then
									tNewSubMenuEntry.macrotext = "/script StaticPopup1Button1:GetScript(\"OnClick\")(_G[\"StaticPopup1Button1\"]) SkuCore:CheckFrames()"
								end
							end
						end
					else
						tNewSubMenuEntry.OnAction = function()
							--dprint("links func", aGossipListTable[index].containerFrameName, aGossipListTable[index].obj)
							aGossipListTable[index].func(aGossipListTable[index].obj, "LeftButton") --"LeftButton", "RightButton", "MiddleButton", "Button4", "Button5"
							--dprint("2L")
							--dprint(aGossipListTable[index].obj:GetName(), string.find(aGossipListTable[index].obj:GetName(), "Tab"))
							if string.find(aGossipListTable[index].obj:GetName(), "Tab") then
								SkuCore:CheckFrames(true)
							else
								SkuCore:CheckFrames()
							end
						end
					end
					local tNewSubMenuEntry = SkuOptions:InjectMenuItems(tNewMenuEntry, {L["Right click"]}, SkuGenericMenuItem)
					if aGossipListTable[index].containerFrameName then
						tNewSubMenuEntry.macrotext = "/click "..aGossipListTable[index].containerFrameName.." RightButton\r\n/script SkuCore:CheckFrames()"
						--dprint("rechts mac", aGossipListTable[index].containerFrameName, tNewSubMenuEntry.macrotext)
					else
						tNewSubMenuEntry.OnAction = function()
							aGossipListTable[index].func(aGossipListTable[index].obj, "RightButton") --"LeftButton", "RightButton", "MiddleButton", "Button4", "Button5"
							--dprint("rechts func", aGossipListTable[index].containerFrameName, aGossipListTable[index].obj)
							--dprint("2R")
							--dprint(aGossipListTable[index].obj:GetName(), string.find(aGossipListTable[index].obj:GetName(), "Tab"))
							if string.find(aGossipListTable[index].obj:GetName(), "Tab") then
								SkuCore:CheckFrames(true)
							else
								SkuCore:CheckFrames()
							end
						end
					end

					if SkuCore.AuctionHouseOpen == true then
						if aGossipListTable[index].obj:GetParent() then
							if string.find(aGossipListTable[index].obj:GetName() or "", "ContainerFrame") or string.find(aGossipListTable[index].obj:GetParent():GetName() or "", "ContainerFrame") then									
								SkuCore:AuctionHouseBuildItemSellMenu(tNewMenuEntry, aGossipListTable[index])
							end
						end
					end
				end
			end
		else
			--dprint(aTab, x, "SUB: "..aGossipListTable[index].textFirstLine)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentMenuTable, {aGossipListTable[index].textFirstLine}, SkuGenericMenuItem)
			tNewMenuEntry.filterable = true
			if aGossipListTable[index].textFull then
				if aGossipListTable[index].textFull ~= "" then
					tNewMenuEntry.textFull = aGossipListTable[index].textFull
				end
			end
			SkuIterateGossipList(aGossipListTable[index].childs, tNewMenuEntry, aTab.."  ")
		end

	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:MenuBuilderLocal(aParentEntry, aEntryDataTable, aOnActionFunc)
	--dprint("SkuOptions:MenuBuilderLocal", aParentEntry, aEntryDataTable, aOnActionFunc)

	SkuCore.GossipList = SkuCore.GossipList or {}
	if #SkuCore.GossipList < 1 then
		table.insert(SkuCore.GossipList, L["Empty"])
		SkuCore.GossipList[L["Empty"]] ={
				frameName = L["Empty"],
				RoC = "Region",
				type = "FontString",
				childs = {},
				obj = nil,
				textFirstLine = L["Empty"],
				textFull = "",
			}
	end

	if SkuCore.GossipList and #SkuCore.GossipList > 0 then
		--dprint("===========SkuIterateGossipList Start ==============")
		SkuIterateGossipList(SkuCore.GossipList, aParentEntry, "  ")
		--dprint("===========SkuIterateGossipList End ==============")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:IterateOptionsArgs(aArgTable, aParentMenu, tProfileParentPath)

	for i, v in SkuSpairs(aArgTable, function(t, a, b) if t[b].order and t[a].order then return t[b].order > t[a].order end end) do
		if v.args and v.forAudioMenu ~= false then
			local tParentMenu =  SkuOptions:InjectMenuItems(aParentMenu, {v.name}, SkuGenericMenuItem)
			SkuOptions:IterateOptionsArgs(v.args, tParentMenu, tProfileParentPath[i])
		else
			if v.type == "toggle" then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentMenu, {v.name}, SkuGenericMenuItem)
				tNewMenuEntry.optionsPath = aArgTable
				tNewMenuEntry.profilePath = tProfileParentPath
				tNewMenuEntry.profileIndex = i
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					if aName == L["On"] then
						self.profilePath[self.profileIndex] = true
					elseif aName == L["Off"] then
						self.profilePath[self.profileIndex] = false
					end
					--PlaySound(835)
				end
				tNewMenuEntry.BuildChildren = function(self)
					tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["On"]}, SkuGenericMenuItem)
					tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Off"]}, SkuGenericMenuItem)
				end
				tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
					local tValue = L["On"]
					--if self.profilePath[self.profileIndex] == true then
					if self.optionsPath[self.profileIndex]:get() == true then
						tValue = "Ein"
					else
						tValue = L["Off"]
					end
					return tValue
				end

			elseif v.type == "select" then
				local tNewMenuEntry =SkuOptions:InjectMenuItems(aParentMenu, {v.name}, SkuGenericMenuItem)
				tNewMenuEntry.optionsPath = aArgTable
				tNewMenuEntry.profilePath = tProfileParentPath
				tNewMenuEntry.profileIndex = i
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					--dprint("type select OnAction", self, aValue, aName)
					for ia, va in pairs(v.values) do
						if va == aName then
							self.profilePath[self.profileIndex] = ia
						end
					end

					local tFlag
					for is, vs in pairs(SkuOptions.BackgroundSoundFiles) do
						if aName == is or aName == vs then
							SkuOptions:StartStopBackgroundSound(false)
							SkuOptions:StartStopBackgroundSound(true)
						end
					end
				end
				tNewMenuEntry.BuildChildren = function(self)
					for ia, va in pairs(v.values) do
						--dprint(ia, va)
						SkuOptions:InjectMenuItems(self, {va}, SkuGenericMenuItem)
					end
				end
				tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
					local tValue = ""
					for ia, va in pairs(v.values) do
						--if ia == self.profilePath[self.profileIndex] then
						if ia == self.optionsPath[self.profileIndex]:get() then
							tValue = va
						end
					end
					return tValue
				end
			elseif v.type == "range" then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentMenu, {v.name}, SkuGenericMenuItem)
				tNewMenuEntry.optionsPath = aArgTable
				tNewMenuEntry.profilePath = tProfileParentPath
				tNewMenuEntry.profileIndex = i
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					--self.profilePath[self.profileIndex] = tonumber(aName)
					self.optionsPath[self.profileIndex]:set(tonumber(aName))
					--PlaySound(835)
				end
				tNewMenuEntry.BuildChildren = function(self)
					local tList = {}
					for q = 100, 0, -1 do
						--table.insert(tList, q)
						local tNewSMenuEntry =SkuOptions:InjectMenuItems(self, {q}, SkuGenericMenuItem)
						tNewSMenuEntry.noMenuNumbers = true
					end
					--SkuOptions:InjectMenuItems(self, tList, SkuGenericMenuItem)
				end
				tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
					return self.optionsPath[self.profileIndex]:get()
					--return self.profilePath[self.profileIndex]
				end

			elseif v.type == "execute" then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentMenu, {v.name}, SkuGenericMenuItem)
				tNewMenuEntry.optionsPath = aArgTable
				tNewMenuEntry.profilePath = tProfileParentPath
				tNewMenuEntry.profileIndex = i
				--tNewMenuEntry.dynamic = true
				--tNewMenuEntry.isSelect = true
				--tNewMenuEntry.filterable = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					--self.profilePath[self.profileIndex] = tonumber(aName)
					self.optionsPath[self.profileIndex]:func()
					--PlaySound(835)
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:StopSounds(aNumberOfSounds)
	local _, currentSoundHandle = PlaySoundFile([[Interface\AddOns\SkuAudioData\assets\audio\silence_1s.mp3]], "Dialog")--PlaySound(871, "Dialog")

	if currentSoundHandle then
		for i = 1, aNumberOfSounds do
			StopSound(currentSoundHandle - i)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:OnCommReceived(aPrefix, aData, aChannel, aSender, ...)
	--dprint("SkuOptions:OnCommReceived(", aPrefix, aData, aChannel, aSender, ...)
	if aPrefix == "Sku" and aData then
		SkuOptions:ProcessComm(aSender, string.split("-", aData))
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ProcessComm(aSender, aIndex, aValue)
	--dprint("SkuOptions:ProcessComm", aSender, aIndex, aValue)

	if aIndex == "ping" then
		SkuOptions.TrackingTargets = SkuOptions.TrackingTargets or {}
		local tFound = false
		for x = 1, #SkuOptions.TrackingTargets do
			if SkuOptions.TrackingTargets[x] == aSender then
				tFound = true
			end
		end
		if tFound == false then
			table.insert(SkuOptions.TrackingTargets, aSender)
		end

		SkuOptions:SendTrackingStatusUpdates()
	elseif aIndex == "followme" then
		FollowUnit(aSender)

	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:SendTrackingStatusUpdates(aStatusUpdate)
	--dprint("SendTrackingStatusUpdates")
	local tUpdateList = {}

	if not aStatusUpdate then
		local tFound = false
		local tFrames = {
			"QuestFrame",--o
			"GossipFrame",--o
			"MerchantFrame",--o
			"StaticPopup1",
			"StaticPopup2",
			"StaticPopup3",
		}
		for i, v in pairs(tFrames) do
			if _G[v] then
				if _G[v]:IsVisible() == true then
					tFound = true
				end
			end
		end
		if tFound == true then
			SkuStatus.interacting = 2
		else
			SkuStatus.interacting = 0
		end
		if SkuMob.QuestTurnedIn == true then
			SkuStatus.interacting = 1
		end

		local tFound = false
		local tFrames = {
			"GroupLootContainer",--o
		}
		for i, v in pairs(tFrames) do
			if _G[v] then
				if _G[v]:IsVisible() == true then
					tFound = true
				end
			end
		end
		if tFound == true then
			SkuStatus.looting = 1
		else
			SkuStatus.looting = 0
		end

		local tIndex, tValue

		if SkuStatus.follow == 0 then
			tIndex, tValue = "F", 4
		else
			tIndex, tValue = "F", 1
		end
		table.insert(tUpdateList, tIndex.."-"..tValue)
		
		if SkuStatus.followUnitName then
			table.insert(tUpdateList, "FN".."-"..SkuStatus.followUnitName)
		end
		if SkuStatus.follow == 0 then
			tIndex, tValue = "F", 4
		else
			tIndex, tValue = "F", 1
		end
		table.insert(tUpdateList, tIndex.."-"..tValue)
		if SkuStatus.interacting == 2 then
			tIndex, tValue = "I", 2
		elseif SkuStatus.interacting == 1 then
			tIndex, tValue = "I", 1
		else
			tIndex, tValue = "I", 4
		end
		table.insert(tUpdateList, tIndex.."-"..tValue)
		if SkuStatus.riding == 0 then
			tIndex, tValue = "M", 4
		else
			tIndex, tValue = "M", 1
		end
		table.insert(tUpdateList, tIndex.."-"..tValue)
		if SkuStatus.casting == 0 then
			tIndex, tValue = "C", 4
		else
			tIndex, tValue = "C", 1
		end
		table.insert(tUpdateList, tIndex.."-"..tValue)
	else
		table.insert(tUpdateList, aStatusUpdate)
	end

	for x = 1, #tUpdateList do
		if UnitInRaid("player") == true then
			SkuOptions:SendCommMessage("Sku", tUpdateList[x], "RAID", nil, "ALERT")
		elseif UnitInParty("player") == true then
			SkuOptions:SendCommMessage("Sku", tUpdateList[x], "PARTY", nil, "ALERT")
		else
			if SkuOptions.TrackingTargets then
				for y = 1, #SkuOptions.TrackingTargets do
					SkuOptions:SendCommMessage("Sku", tUpdateList[x], "WHISPER", SkuOptions.TrackingTargets[y], "ALERT")
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:Deserialize(aSerializedString)
	return SkuOptions.Serializer:Deserialize(aSerializedString)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:Serialize(...)
	return SkuOptions.Serializer:Serialize(...)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuOptionsEditBoxOkScript(...)
	
end
---------------------------------------------------------------------------------------------------------------------------------------
---@param aText string
---@param aOkScript function
function SkuOptions:EditBoxShow(aText, aOkScript)
	if not SkuOptionsEditBox then
		local f = CreateFrame("Frame", "SkuOptionsEditBox", UIParent, "DialogBoxFrame")
		f:SetPoint("CENTER")
		f:SetSize(600, 500)

		f:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
			edgeSize = 16,
			insets = { left = 8, right = 6, top = 8, bottom = 8 },
		})
		f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue

		-- Movable
		f:SetMovable(true)
		f:SetClampedToScreen(true)
		f:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				self:StartMoving()
			end
		end)
		f:SetScript("OnMouseUp", f.StopMovingOrSizing)

		-- ScrollFrame
		local sf = CreateFrame("ScrollFrame", "SkuOptionsEditBoxScrollFrame", SkuOptionsEditBox, "UIPanelScrollFrameTemplate")
		sf:SetPoint("LEFT", 16, 0)
		sf:SetPoint("RIGHT", -32, 0)
		sf:SetPoint("TOP", 0, -16)
		sf:SetPoint("BOTTOM", SkuOptionsEditBoxButton, "TOP", 0, 0)

		-- EditBox
		local eb = CreateFrame("EditBox", "SkuOptionsEditBoxEditBox", SkuOptionsEditBoxScrollFrame)
		eb:SetSize(sf:GetSize())
		--eb:SetMultiLine(true)
		eb:SetAutoFocus(false) -- dont automatically focus
		eb:SetFontObject("ChatFontNormal")
		eb:SetScript("OnEscapePressed", function() 
			PlaySound(89)
			f:Hide()
		end)
		eb:SetScript("OnTextSet", function(self)
			self:HighlightText()
		end)

		sf:SetScrollChild(eb)

		-- Resizable
		f:SetResizable(true)
		f:SetMinResize(150, 100)

		local rb = CreateFrame("Button", "SkuOptionsEditBoxResizeButton", SkuOptionsEditBox)
		rb:SetPoint("BOTTOMRIGHT", -6, 7)
		rb:SetSize(16, 16)

		rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
		rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
		rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

		rb:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				f:StartSizing("BOTTOMRIGHT")
				self:GetHighlightTexture():Hide() -- more noticeable
			end
		end)
		rb:SetScript("OnMouseUp", function(self, button)
			f:StopMovingOrSizing()
			self:GetHighlightTexture():Show()
			eb:SetWidth(sf:GetWidth())
		end)

		SkuOptionsEditBoxEditBox:HookScript("OnEnterPressed", function(...) SkuOptionsEditBoxOkScript(...) SkuOptionsEditBox:Hide() end)
		SkuOptionsEditBoxButton:HookScript("OnClick", SkuOptionsEditBoxOkScript)

		f:Show()
	end

	SkuOptionsEditBoxEditBox:Hide()
	SkuOptionsEditBoxEditBox:SetText("")
	if aText then
		SkuOptionsEditBoxEditBox:SetText(aText)
		SkuOptionsEditBoxEditBox:HighlightText()
	end
	SkuOptionsEditBoxEditBox:Show()
	if aOkScript then
		SkuOptionsEditBoxOkScript = aOkScript
	end

	SkuOptionsEditBox:Show()

	SkuOptionsEditBoxEditBox:SetFocus()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:HideVisualMenu()
	if SkuOptions.SkuOptionsVisualMenuContainer then
		SkuOptions.SkuOptionsVisualMenuContainer:Hide()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tInMenuFlag = false
function SkuOptions:ShowVisualMenu()
	if SkuOptions.db.profile["SkuOptions"].visualAudioMenu ~= true then
		if SkuOptions.SkuOptionsVisualMenuContainer then
			if SkuOptions.SkuOptionsVisualMenuContainer:IsVisible() then
				SkuOptions:HideVisualMenu()
			end
		end
	else

		local AceGUI = LibStub("AceGUI-3.0")
		if not SkuOptions.SkuOptionsVisualMenuContainer then
			SkuOptions.SkuOptionsVisualMenuContainer = AceGUI:Create("Frame")
			SkuOptions.SkuOptionsVisualMenuContainer:SetCallback("OnClose",function(widget) 
				SkuOptions:CloseMenu()
			end)
			SkuOptions.SkuOptionsVisualMenuContainer:SetTitle("Sku-Audiomenü")
			--SkuOptions.SkuOptionsVisualMenuContainer:SetStatusText("Status Bar")
			SkuOptions.SkuOptionsVisualMenuContainer:SetLayout("Fill")
			SkuOptions.SkuOptionsVisualMenuContainer.tree = AceGUI:Create("TreeGroup")
			SkuOptions.SkuOptionsVisualMenuContainer.tree:EnableButtonTooltips(false)
			SkuOptions.SkuOptionsVisualMenuContainer.tree:SetWidth(600)
			SkuOptions.SkuOptionsVisualMenuContainer.tree:SetLayout("Fill")
			SkuOptions.SkuOptionsVisualMenuContainer.tree:SetCallback("OnClick", function(self, event, value, unknownbool, skuFFunction, b) 
				--dprint(self, event, value, unknownbool, skuFFunction, b)
				skuFFunction()
				SkuOptions:ShowVisualMenu()
				local tTable = SkuOptions.currentMenuPosition
				local tBread = SkuOptions.currentMenuPosition.name
				local tResult = {}
				while tTable.parent.name do
					tTable = tTable.parent
					tBread = tTable.name.." > "..tBread
					table.insert(tResult, 1, tTable.name)
				end
				--table.insert(tResult, SkuOptions.currentMenuPosition.name)
				C_Timer.NewTimer(0.1, function()
					SkuOptions:ShowVisualMenuSelectByPath(unpack(tResult))
				end)			
			end)
			SkuOptions.SkuOptionsVisualMenuContainer.tree:SetCallback("OnGroupSelected", function(self, event, path, a, b, c) 
				--dprint("OnGroupSelected",self, event, path, a, b, c) 
			end)
			SkuOptions.SkuOptionsVisualMenuContainer.tree:SetCallback("OnButtonEnter", function(a, b, c, d) 
				--dprint("OnButtonEnter", a, b, c, d) 
			end)
			SkuOptions.SkuOptionsVisualMenuContainer:AddChild(SkuOptions.SkuOptionsVisualMenuContainer.tree)
		end

		local function NumberOfChildren(aTable)
			local tNumber = 0
			for i, v in pairs(aTable) do 	
				tNumber = tNumber + 1
			end
			return tNumber
		end

		local function AddItem(aTable, aResult, aPad)
			for i, v in pairs(aTable) do
				--dprint(i, v)
				--if i < 20 then
					if NumberOfChildren(v.children) > 0 then
						local tChilds = {}
						AddItem(v.children, tChilds, aPad.."  ")
						table.insert(aResult, {
							skuFunction = function()
								--dprint("vname", v.name)
								v:BuildChildren()
								SkuOptions.currentMenuPosition = v
								SkuOptions.currentMenuPosition:OnSelect()
								SkuOptions:VocalizeCurrentMenuName()
							end,
							value = v.name,
							text = v.name,
							children = tChilds,
						})
					else
						table.insert(aResult, {
							skuFunction = function()
								--dprint("vname", v.name)
								v:BuildChildren()
								SkuOptions.currentMenuPosition = v
								SkuOptions.currentMenuPosition:OnSelect()
								SkuOptions:VocalizeCurrentMenuName()
							end,
							value = v.name,
							text = v.name,
						})
					end
				--end
			end
			return aResult
		end

		local treeData = {}
		AddItem(SkuOptions.Menu, treeData, "")
		SkuOptions.SkuOptionsVisualMenuContainer.tree:SetTree(treeData)

		SkuOptions.SkuOptionsVisualMenuContainer:Show()
		--SkuOptions.SkuOptionsVisualMenuContainer:DoLayout()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ShowVisualMenuSelectByPath(...)
	if SkuOptions.db.profile["SkuOptions"].visualAudioMenu == true then
		--dprint("SelectByPath", ...)
		SkuOptions.SkuOptionsVisualMenuContainer.tree:SetStatusTable({
			groups = {},
			fullwidth = 600,
			treewidth = 600,
		})
		SkuOptions.SkuOptionsVisualMenuContainer.tree:SelectByPath(...)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:EditBoxPasteShow(aText, aOkScript)
	if not _G["SkuOptionsEditBoxPaste"] then
		local f = CreateFrame('frame', "SkuOptionsEditBoxPaste", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)

		f:SetBackdrop({		 bgFile = 'Interface/Tooltips/UI-Tooltip-Background',		 edgeFile = 'Interface/Tooltips/UI-Tooltip-Border', edgeSize = 16,		 insets = {left = 4, right = 4, top = 4, bottom = 4}	})
		f:SetBackdropColor(0.2, 0.2, 0.2)
		f:SetBackdropBorderColor(0.2, 0.2, 0.2)
		f:SetPoint('CENTER')
		f:SetSize(400, 300)
		
		local cursor = f:CreateTexture() -- make a fake blinking cursor, not really necessary
		cursor:SetTexture(1, 1, 1)
		cursor:SetSize(4, 8)
		cursor:SetPoint('TOPLEFT', 8, -8)
		cursor:Hide()
		
		local editbox = CreateFrame('editbox', nil, f)
		f.EB = editbox
		editbox:SetMaxBytes(1) -- limit the max length of anything entered into the box, this is what prevents the lag
		editbox:SetAutoFocus(true)
		
		local timeSince = 0
		local function UpdateCursor(self, elapsed)
			timeSince = timeSince + elapsed
			if timeSince >= 0.5 then
				timeSince = 0
				cursor:SetShown(not cursor:IsShown())
			end
		end
		
		local fontstring = f:CreateFontString(nil, nil, 'GameFontHighlightSmall')
		f.FS = fontstring
		fontstring:SetPoint('TOPLEFT', 8, -8)
		fontstring:SetPoint('BOTTOMRIGHT', -8, 8)
		fontstring:SetJustifyH('LEFT')
		fontstring:SetJustifyV('TOP')
		fontstring:SetWordWrap(true)
		fontstring:SetNonSpaceWrap(true)
		fontstring:SetText('Click me!')
		fontstring:SetTextColor(0.6, 0.6, 0.6)
		f.SkuOptionsTextBuffer = {}
		local i, lastPaste = 0, 0
		
		local function clearBuffer(self)
			self:SetScript('OnUpdate', nil)
			if i > 10 then -- ignore shorter strings
				local paste = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))
				-- the longer this font string, the more it will lag trying to draw it
				fontstring:SetText(strsub(paste, 1, 2500))
				editbox:ClearFocus()
				SkuOptionsEditBoxOkScript()
				_G["SkuOptionsEditBoxPaste"]:Hide()
			end
		end
		
		editbox:SetScript('OnChar', function(self, c) -- runs for every character being pasted
			if lastPaste ~= GetTime() then -- a timestamp can be used to track how many characters have been added within the same frame
				_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer, i, lastPaste = {}, 0, GetTime()
				self:SetScript('OnUpdate', clearBuffer)
			end
			
			i = i + 1
			_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer[i] = c -- store entered characters in a table to concat into a string later
		end)
		
		editbox:SetScript('OnEditFocusGained', function(self)
			fontstring:SetText('')
			timeSince = 0
			cursor:Show()
			f:SetScript('OnUpdate', UpdateCursor)
		end)
		
		editbox:SetScript('OnEditFocusLost', function(self)
			f:SetScript('OnUpdate', nil)
			cursor:Hide()
		end)


		editbox:SetScript("OnEscapePressed", function() _G["SkuOptionsEditBoxPaste"]:Hide() end)

	end
	
	if aOkScript then
		SkuOptionsEditBoxOkScript = aOkScript
	end

	_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer = {}

	_G["SkuOptionsEditBoxPaste"].EB:HookScript("OnEnterPressed", function(...) SkuOptionsEditBoxOkScript(...) _G["SkuOptionsEditBoxPaste"]:Hide() end)

	--_G["SkuOptionsEditBoxPaste"].EB:SetText("")
	_G["SkuOptionsEditBoxPaste"]:Show()
	--return 
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ImportWpAndLinkData()
	PlaySound(88)
	SkuOptions.Voice:OutputString(L["Paste data to import now"], false, true, 0.2)

	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))

		local tImportCounterLinks = 0
		local tImportCounterWps = 0
		local tIgnoredCounterWps = 0

		if tSerializedData ~= "" then
			local tSuccess, tVersion, tLinks, tWaypoints = SkuOptions:Deserialize(tSerializedData)

			if tVersion ~= 22 then
				SkuOptions.Voice:OutputString("Import fehlgeschlagen. Falsche Version.", false, true, 0.2)										
				return
			end
			if tSuccess ~= true then
				SkuOptions.Voice:OutputString("Import fehlgeschlagen. Daten fehlerhaft.", false, true, 0.2)										
				return
			end

			SkuOptions.Voice:OutputString("Import erfolgreich", true, true, 0.2, true)			

			--do tWaypoints
			local tFullCounterWps = 0
			SkuOptions.db.profile["SkuNav"].Waypoints = {}
			for tWpName, tWpData in pairs(tWaypoints) do
				if not SkuOptions.db.profile["SkuNav"].Waypoints[tWpName] then
					--table.insert(SkuOptions.db.profile["SkuNav"].Waypoints, tWpName)
					--SkuOptions.db.profile["SkuNav"].Waypoints[tWpName] = tWpData
					SkuOptions.db.profile["SkuNav"].Waypoints[tFullCounterWps + 1] = tWpName
					SkuOptions.db.profile["SkuNav"].Waypoints[tWpName] = tWpData
					tImportCounterWps = tImportCounterWps + 1
				else
					tIgnoredCounterWps = tIgnoredCounterWps + 1
				end
				tFullCounterWps = tFullCounterWps + 1
			end

			SkuNav:CreateWaypointCache()

			--do tLinks
			for _ in pairs(tLinks) do
				tImportCounterLinks = tImportCounterLinks + 1
			end
			SkuOptions.db.profile["SkuNav"].Links = tLinks or {}

			SkuNav:LoadLinkDataFromProfile()

			--done
			print("Links importiert:", tImportCounterLinks)
			print("Wegpunkte importiert:", tImportCounterWps)
			print("Wegpunkte ignoriert:", tIgnoredCounterWps)
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ExportWpAndLinkData()
	SkuNav:SaveLinkDataToProfile()

	local tExportDataTable = {
		version = 22,
		links = {},
		waypoints = {},
	}

	--build Links
	tExportDataTable.links = SkuOptions.db.profile["SkuNav"].Links
	tDataToExport = true
	--build Waypoints without quick wps
	for i, v in ipairs(SkuOptions.db.profile["SkuNav"].Waypoints) do
		if not string.find(v, L["Quick waypoint"]) then
			if SkuOptions.db.profile["SkuNav"].Waypoints[v] then
				local tWpData = SkuOptions.db.profile["SkuNav"].Waypoints[v]
				if tWpData then
					tExportDataTable.waypoints[v] = tWpData
				end
			end
		end
	end
	
	--complete export
	PlaySound(88)
	local tCount = 0
	for _, _ in pairs(tExportDataTable.links) do
		tCount = tCount + 1
	end
	print("Links exportiert:", tCount)
	tCount = 0
	for _, _ in pairs(tExportDataTable.waypoints) do
		tCount = tCount + 1
	end
	print("Wegpunkte exportiert:", tCount)

	SkuOptions.Voice:OutputString("Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken", false, true, 0.3)		

	--setmetatable(tExportDataTable, SkuPrintMT)
	--SkuOptions:EditBoxShow(tostring(tExportDataTable), function(self) PlaySound(89) end)
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable.version, tExportDataTable.links, tExportDataTable.waypoints), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:ImportPre22WpAndRouteData()
	PlaySound(88)
	SkuOptions.Voice:OutputString(L["Paste data to import now"], false, true, 0.2)

	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))

		local tRenameCounterWps = 0
		local tRenameCounterRts = 0
		local tImportCounterWps = 0
		local tImportCounterRts = 0
		local tIgnoredCounterWps = 0
		local tIgnoredCounterRts = 0

		if tSerializedData ~= "" then
			local tSuccess, tRoutes, tWaypoints = SkuOptions:Deserialize(tSerializedData)
			--setmetatable(tRoutes, SkuNav.PrintMT)
			--setmetatable(tWaypoints, SkuNav.PrintMT)

			if tSuccess == true then
				SkuOptions.db.profile["SkuNav"].Routes = {}
				SkuOptions.db.profile["SkuNav"].Waypoints = {}

				--collect wps in importable routes
				local tImprableRouteWps = {}
				if aAreaId then
					for iR, vR in ipairs(tRoutes) do
						for iWp, vWp in ipairs(tRoutes[vR].WPs) do
							local tWayp = tWaypoints[vWp] or SkuNav:GetWaypointData2(vWp)
							if tWayp then
								if (SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(tWayp.areaId)) ~= tonumber(aAreaId)) then
									tImprableRouteWps[vWp] = true
									SkuOptions:DebugToChat("\124cffff0000RT-WP ignoriert\124r", iR, vR, "Wegpunkt nicht in Zone:", iWp, vWp, tWayp.areaId, aAreaId)
								end
							else
								tIgnoredCounterRts = tIgnoredCounterRts + 1
								SkuOptions:DebugToChat("\124cffff0000RT ignoriert\124r", iR, vR, "Unbekannter Wegpunkt:", iWp, vWp)
							end
						end
					end
				end

				--import wps
				for i, v in ipairs(tWaypoints) do
					--in area?
					if not string.find(v, L["Quick waypoint"]) then
						local tWayp = tWaypoints[v] or SkuNav:GetWaypointData2(v)

						if (aAreaId and SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(tWayp.areaId)) == aAreaId) or not aAreaId or tImprableRouteWps[v] then
							if not SkuOptions.db.profile["SkuNav"].Waypoints[v] then
								--dprint("wp exists NOT: ", v)
								--new wp name > import
								table.insert(SkuOptions.db.profile["SkuNav"].Waypoints, v)
								SkuOptions.db.profile["SkuNav"].Waypoints[v] = tWaypoints[v]
								tImportCounterWps = tImportCounterWps + 1
							else
								--wp name exists
								--dprint("wp exists: ", v)
								if (
										SkuOptions.db.profile["SkuNav"].Waypoints[v].worldX ~= tWaypoints[v].worldX 
										or SkuOptions.db.profile["SkuNav"].Waypoints[v].worldY ~= tWaypoints[v].worldY
									) 
									or SkuOptions.db.profile["SkuNav"].Waypoints[v].areaId ~=  tWaypoints[v].areaId  
									or SkuOptions.db.profile["SkuNav"].Waypoints[v].contintentId ~= tWaypoints[v].contintentId 
								then
									--dprint("wp name exists and data NOT same")
									--update name of wp and update the wp name in all import routes and import
									local tNewWpName = v
									local tCounter = 1
									local tInsert = true
									while SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter] do
										if 
											SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter].worldX == tWaypoints[v].worldX 
											and SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter].worldY == tWaypoints[v].worldY 
											and SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter].areaId ==  tWaypoints[v].areaId 
											and SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter].contintentId == tWaypoints[v].contintentId 
											and SkuOptions.db.profile["SkuNav"].Waypoints[v..";"..tCounter].comments == tWaypoints[v].comments 
										then
											tInsert = false
											--dprint("renamed as", tNewWpName, "found")
											tIgnoredCounterWps = tIgnoredCounterWps + 1
											SkuOptions:DebugToChat("\124cffffff00WP ignoriert(*)\124r", i, v, "Schon identisch vorhanden:", v..";"..tCounter)
											break
										else
											tCounter = tCounter + 1
										end
									end
									tNewWpName = v..";"..tCounter
									--update the importing rts wps
									for iR, vR in ipairs(tRoutes) do
										for iWp, vWp in ipairs(tRoutes[vR].WPs) do
											if vWp == v then
												tRoutes[vR].WPs[iWp] = tNewWpName
											end
										end
										--Update rts start/endpoints
										if tRoutes[vR].tStartWPName == v then
											tRoutes[vR].tStartWPName = tNewWpName
										end
										if tRoutes[vR].tEndWPName == v then
											tRoutes[vR].tEndWPName = tNewWpName
										end
									end
									if tInsert == true then
										--dprint("no renamed as", tNewWpName, "found and inserted")
										table.insert(SkuOptions.db.profile["SkuNav"].Waypoints, tNewWpName)
										SkuOptions.db.profile["SkuNav"].Waypoints[tNewWpName] = tWaypoints[v]
										tRenameCounterWps = tRenameCounterWps + 1
										tImportCounterWps = tImportCounterWps + 1
									end
								else
									if SkuOptions.db.profile["SkuNav"].Waypoints[v].comments ~= tWaypoints[v].comments then
										--same name, same data, but different comments > update comments
										SkuOptions.db.profile["SkuNav"].Waypoints[v].comments = tWaypoints[v].comments
									else
										--same name, same data > ignore
										tIgnoredCounterWps = tIgnoredCounterWps + 1
										SkuOptions:DebugToChat("\124cffffff00WP ignoriert\124r", i, v, "Schon identisch vorhanden")
									end
								end
							end
						else
							tIgnoredCounterWps = tIgnoredCounterWps + 1
							SkuOptions:DebugToChat("\124cffff0000WP ignoriert\124r", i, v, "Nicht in Zone:", aAreaId)
						end
					else
						tIgnoredCounterWps = tIgnoredCounterWps + 1
						SkuOptions:DebugToChat("WP ignoriert", i, v, "Ist Schnell-WP")
					end
				end

				SkuNav:CreateWaypointCache()

				--import rts
				for i, v in ipairs(tRoutes) do
					local tStartWP, tEndWP
					if tRoutes[v] then
						tStartWP = tWaypoints[tRoutes[v].tStartWPName] or SkuNav:GetWaypointData2(tRoutes[v].tStartWPName)
						tEndWP = tWaypoints[tRoutes[v].tEndWPName] or SkuNav:GetWaypointData2(tRoutes[v].tEndWPName)
					end
					if not tStartWP or not tEndWP then
						tIgnoredCounterRts = tIgnoredCounterRts + 1
						SkuOptions:DebugToChat("\124cffff0000RT ignoriert\124r", i, v, "Start/End fehlt:", tStartWP ~= false, tEndWP ~= false)
					else
						if 
							(((aAreaId and SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(tStartWP.areaId)) == aAreaId) == true or not aAreaId) 
							or ((aAreaId and SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(tEndWP.areaId)) == aAreaId) == true or not aAreaId) ) == true
						then
							if (tRoutes[v].tStartWPName == tRoutes[v].tEndWPName) and #tRoutes[v].WPs <= 2 then
								tIgnoredCounterRts = tIgnoredCounterRts + 1
								SkuOptions:DebugToChat("RT ignoriert", i, v, "Start/End identisch, keine IM-WPs:", tRoutes[v].tStartWPName)
							else
								if not SkuOptions.db.profile["SkuNav"].Routes[v] then
									-- new rt name
									table.insert(SkuOptions.db.profile["SkuNav"].Routes, v)
									SkuOptions.db.profile["SkuNav"].Routes[v] = tRoutes[v]
									tImportCounterRts = tImportCounterRts + 1
								else
									--rt name exists
									--is the same as existing?
									local tExistingRtData = ""
									tExistingRtData = tExistingRtData..v
									tExistingRtData = tExistingRtData..(SkuOptions.db.profile["SkuNav"].Routes[v].tStartWPName or "nil")
									tExistingRtData = tExistingRtData..(SkuOptions.db.profile["SkuNav"].Routes[v].tEndWPName or "nil")
									for iWp, vWp in ipairs(SkuOptions.db.profile["SkuNav"].Routes[v].WPs) do
										tExistingRtData =  tExistingRtData..vWp
									end

									local tImportRtData = ""
									tImportRtData = tImportRtData..v
									tImportRtData = tImportRtData..(tRoutes[v].tStartWPName or "nil")
									tImportRtData = tImportRtData..(tRoutes[v].tEndWPName or "nil")
									for iWp, vWp in ipairs(tRoutes[v].WPs) do
										tImportRtData =  tImportRtData..vWp
									end

									if tExistingRtData ~= tImportRtData then
										--not the same update import rts name
										local tNewRtName = v
										local tCounter = 1
										local tInsert = true
										while SkuOptions.db.profile["SkuNav"].Routes[v..";"..tCounter] do
											local tExistingRtData = ""
											tExistingRtData = tExistingRtData..v
											tExistingRtData = tExistingRtData..(SkuOptions.db.profile["SkuNav"].Routes[v].tStartWPName or "nil")
											tExistingRtData = tExistingRtData..(SkuOptions.db.profile["SkuNav"].Routes[v].tEndWPName or "nil")
											for iWp, vWp in ipairs(SkuOptions.db.profile["SkuNav"].Routes[v].WPs) do
												tExistingRtData =  tExistingRtData..vWp
											end
				
											local tImportRtData = ""
											tImportRtData = tImportRtData..v
											tImportRtData = tImportRtData..(tRoutes[v].tStartWPName or "nil")
											tImportRtData = tImportRtData..(tRoutes[v].tEndWPName or "nil")
											for iWp, vWp in ipairs(tRoutes[v].WPs) do
												tImportRtData =  tImportRtData..vWp
											end

											if tExistingRtData ~= tImportRtData then
												tInsert = false
												tIgnoredCounterRts = tIgnoredCounterRts + 1
												SkuOptions:DebugToChat("\124cffff0000RT ignoriert\124r", iR, vR, "Unbekannter Wegpunkt:", iWp, vWp)

												break
											else
												tCounter = tCounter + 1
											end
										end
										tNewRtName = v..";"..tCounter

										if tInsert == true then
											table.insert(SkuOptions.db.profile["SkuNav"].Routes, tNewRtName)
											SkuOptions.db.profile["SkuNav"].Routes[tNewRtName] = tRoutes[v]
											tImportCounterRts = tImportCounterRts + 1
											tRenameCounterRts = tRenameCounterRts + 1
										end
									else
										--same name same data, ignore
										tIgnoredCounterRts = tIgnoredCounterRts + 1
										--SkuOptions:DebugToChat("RT ignoriert", i, v, "Identische RT vorhanden (inkl. Daten):", tExistingRtData)

									end
								end
							end
						else
							tIgnoredCounterRts = tIgnoredCounterRts + 1
							SkuOptions:DebugToChat("\124cffff00ffRT ignoriert\124r", i, v, "Start/End nicht in zone:", aAreaId)
						end
					end

				end

				SkuOptions.Voice:OutputString("Import erfolgreich", true, true, 0.2)			
				SkuOptions.Voice:OutputString(tImportCounterRts.." von "..#tRoutes.." Routen", false, true, 0.3, true)
				SkuOptions.Voice:OutputString(tImportCounterWps.." von "..#tWaypoints.." Wegpunkt", false, true, 0.3, true)

				print("Routen ("..#tRoutes..")")
				print("  Importiert: ", tImportCounterRts)
				print("  Umbenannt: ", tRenameCounterRts)
				print("  Ignoriert: ", tIgnoredCounterRts)
				print("  Gelöscht: ", tImportDeleteCounterRts)
				print("Wegpunkte ("..(#tWaypoints)..")")
				print("  Importiert: ", tImportCounterWps)
				print("  Umbenannt: ", tRenameCounterWps)
				print("  Ignoriert: ", tIgnoredCounterWps)





				--start conversion
				SkuOptions.db.profile["SkuNav"].RtAndWpVersion = nil
				SkuNav:PLAYER_ENTERING_WORLD()







			else
				SkuOptions.Voice:OutputString("Import fehlgeschlagen", false, true, 0.2)										
			end
			--_G["SkuOptionsEditBoxPaste"]:Hide()
		end
	end)
end


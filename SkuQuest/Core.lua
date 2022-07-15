﻿---@diagnostic disable: undefined-global
local MODULE_NAME = "SkuQuest"
local _G = _G

SkuQuest = LibStub("AceAddon-3.0"):NewAddon("SkuQuest", "AceConsole-3.0", "AceEvent-3.0")
local L = Sku.L

local PLAYER_ENTERING_WORLD_flag = true

SkuQuest.MenuAccessKeysNumbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

local EnumItemQuality = {
[0] = ITEM_QUALITY0_DESC,
[1] = ITEM_QUALITY1_DESC,
[2] = ITEM_QUALITY2_DESC,
[3] = ITEM_QUALITY3_DESC,
[4] = ITEM_QUALITY4_DESC,
[5] = ITEM_QUALITY5_DESC,
[6] = ITEM_QUALITY6_DESC,
[7] = ITEM_QUALITY7_DESC,
[8] = ITEM_QUALITY8_DESC,
}

SkuQuest.racesFriendly = {
	ALL_ALLIANCE = L["Allianz"],
	ALL_HORDE = L["Horde"],
	--ALL = VANILLA and 255 or 2047,
	NONE = L["Keine"],

	HUMAN = L["Mensch"],
	ORC = L["Ork"],
	DWARF = L["Zwerg"],
	NIGHT_ELF = L["Nachtelf"],
	UNDEAD = L["Untoter"],
	SCOURGE = L["Scourge"],
	TAUREN = L["Taure"],
	GNOME = L["Gnom"],
	TROLL = L["Troll"],
	--GOBLIN = L["Goblin"],
	BLOOD_ELF = L["Blutelf"],
	DRAENEI = L["Draenei"],
}

SkuQuest.classesFriendly = {
	NONE = L["Keine"],
	WARRIOR = L["Krieger"],
	PALADIN = L["Paladin"],
	HUNTER = L["Jäger"],
	ROGUE = L["Schurke"],
	PRIEST = L["Priester"],
	SHAMAN = L["Shamane"],
	MAGE = L["Magier"],
	WARLOCK = L["Hexer"],
	DRUID = L["Druide"],
}

SkuDB.QuestFlagsFriendly = {
	NONE = L["Keine"],
	SHARABLE = L["Teilbar"],
	EPIC = L["Episch"],
	RAID = L["Raid"],
	DAILY = L["Täglich"],
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnInitialize()
	--dprint("SkuQuest OnInitialize")
	
	--SkuQuest:RegisterChatCommand("skuquest", "SlashFunc")

	SkuQuest:RegisterEvent("VARIABLES_LOADED")
	SkuQuest:RegisterEvent("QUEST_LOG_UPDATE")
	SkuQuest:RegisterEvent("UPDATE_FACTION")
	SkuQuest:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
	SkuQuest:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuQuest:RegisterEvent("PLAYER_LOGIN")

	SkuQuest:RegisterEvent("QUEST_ACCEPTED")
	SkuQuest:RegisterEvent("QUEST_REMOVED")
	SkuQuest:RegisterEvent("QUEST_TURNED_IN")

	--SkuQuestDB = SkuQuestDB or {}
	--SkuQuestDB = LibStub("AceDB-3.0"):New("SkuQuestDB", defaults) -- TODO: fix default values for subgroups

	--SkuQuest.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(SkuQuestDB)


	
	local ttime = 0
	local f = _G["SkuQuestControl"] or CreateFrame("Frame", "SkuQuestControl", UIParent)
	--[[
	f:SetScript("OnUpdate", function(self, time) 
		if SkuOptions.db.profile[MODULE_NAME].enable == true then
 			ttime = ttime + time 
			if ttime > 0.25 then 
				
				ttime = 0 
			end 
		end
	end)
	]]
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnEnable()
	--dprint("SkuQuest OnEnable")

	if SkuCore.inCombat == true then
		return
	end
	
	local tFrame = _G["SkuQuestMain"] or CreateFrame("Button", "SkuQuestMain", UIParent, "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("SkuQuestMain")
	tFrame:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
	tFrame:SetPoint("CENTER")
	tFrame:SetScript("OnClick", function(self, a, b) 
		--dprint("SkuQuestMain OnClick", a, b)
		if _G["SkuQuestMainOption1"]:IsVisible() then
			HideUIPanel(QuestLogFrame)
			--_G["SkuQuestMainOption1"]:Hide()
		else
			ShowUIPanel(QuestLogFrame)
			--_G["SkuQuestMainOption1"]:Show()
			--SkuQuest.currentMenuPosition = tMenu[1]
			PlaySound(811)	
		end
	end)
	tFrame:SetScript("OnShow", function(self)
		--dprint("SkuQuestMain OnShow")
		SetOverrideBindingClick(self, true, "CTRL-Q", "SkuQuestMain", "CTRL-Q")
	end)
	tFrame:Show()
	--SetBindingClick("CTRL-Q", tFrame:GetName())
	
	
	tFrame = _G["SkuQuestMainOption1"] or  CreateFrame("Button", "SkuQuestMainOption1", _G["SkuQuestMain"], "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("SkuQuestMainOption1")
	tFrame:SetPoint("TOP", _G["SkuQuestMain"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		--dprint("SkuQuestMainOption1 OnClick", aKey, aB)
		if SkuCore.inCombat == true then
			return
		end
		
		if aKey == "SHIFT-UP" then
			SkuOptions.TTS:PreviousLine()
		end
		if aKey == "SHIFT-DOWN" then
			SkuOptions.TTS:NextLine()
		end
		if aKey == "CTRL-SHIFT-UP" then
			SkuOptions.TTS:PreviousSection()
		end
		if aKey == "CTRL-SHIFT-DOWN" then
			SkuOptions.TTS:NextSection()
		end


		if aKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTABANDON"].key then
			SkuQuest:OnSkuQuestAbandon()
		end
		if aKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTSHARE"].key then
			SkuQuest:OnSkuQuestPush()
		end
		if aKey == "UP" then
			SkuQuest:OnSkuQuestUP()
		end
		if aKey == "DOWN" then
			SkuQuest:OnSkuQuestDOWN()
		end
		if aKey == "ESCAPE" then
			--SkuQuest:ToggleQuestLogHook()
			self:Hide(self)
			--if _G["SkuQuestMain"] then
--				_G["SkuQuestMain"]:Hide()
			--end
			--_G["QuestLogFrame"]:Hide()
			--SkuOptions.TTS:Output("", -1)--HideUIPanel(QuestLogFrame)
			--SkuQuest:ToggleQuestLogHook()
			HideUIPanel(QuestLogFrame)
			--self:GetScript("OnHide")(self)
		end
		if  SkuQuest.MenuAccessKeysNumbers[aKey] then
			local numEntries, numQuests = GetNumQuestLogEntries()
			if tonumber(aKey) <= numEntries then
				SkuQuest.SelectedQuest = aKey
				SelectQuestLogEntry(SkuQuest.SelectedQuest)
				--SkuQuest:ShowForTTS()
			end
		end
	end)
	tFrame:SetScript("OnShow", function(self)
		--dprint("SkuQuestMainOption1 OnShow")
		if SkuCore.inCombat == true then
			return
		end
		
		PlaySound(88)
		SkuOptions.Voice:OutputStringBTtts(L["Quest;geöffnet"], true, true, 0.3)
		--[[
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-UP", "SkuQuestMainOption1", "CTRL-SHIFT-UP")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-DOWN", "SkuQuestMainOption1", "CTRL-SHIFT-DOWN")
		SetOverrideBindingClick(self, true, "SHIFT-UP", "SkuQuestMainOption1", "SHIFT-UP")
		SetOverrideBindingClick(self, true, "SHIFT-DOWN", "SkuQuestMainOption1", "SHIFT-DOWN")

		SetOverrideBindingClick(self, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTABANDON"].key, "SkuQuestMainOption1", SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTABANDON"].key)
		SetOverrideBindingClick(self, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTSHARE"].key, "SkuQuestMainOption1", SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUESTSHARE"].key)
		SetOverrideBindingClick(self, true, "UP", "SkuQuestMainOption1", "UP")
		SetOverrideBindingClick(self, true, "DOWN", "SkuQuestMainOption1", "DOWN")
		]]
		SetOverrideBindingClick(self, true, "ESCAPE", "SkuQuestMainOption1", "ESCAPE")
		for x = 1, #SkuQuest.MenuAccessKeysNumbers do
			--SetOverrideBindingClick(self, true, SkuQuest.MenuAccessKeysNumbers[x], "SkuQuestMainOption1", SkuQuest.MenuAccessKeysNumbers[x])
			--SkuQuest.MenuAccessKeysNumbers[SkuQuest.MenuAccessKeysNumbers[x]] = SkuQuest.MenuAccessKeysNumbers[x]
		end
	end)
	tFrame:SetScript("OnHide", function(self)
		--dprint("SkuQuestMainOption1 OnHide")
		if SkuCore.inCombat == true then
			return
		end
		
		SkuOptions.Voice:OutputStringBTtts(L["Quest;geschlossen"], true, true, 0.3)
		--SkuOptions.TTS:Output("", -1)
		ClearOverrideBindings(self)
		PlaySound(89)
	end)
	
	tFrame:Hide()
	
	SkuQuest.SelectedQuest = 1
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnDisable()
	-- Called when the addon is disabled
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnSkuQuestPush()
	if (GetQuestLogPushable()) then
		QuestLogPushQuest()
		SkuOptions.Voice:OutputStringBTtts(L["quest;geteilt"], true, true, 0.2, true)
	else
		SkuOptions.Voice:OutputStringBTtts(L["quest;nicht;teilbar"], true, true, 0.2, true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnSkuQuestAbandon()
	SetAbandonQuest() --Sets the currently selected quest to be abandoned.
	AbandonQuest()
	--SkuQuest:ToggleQuestLogHook()
	HideUIPanel(QuestLogFrame)
	--SkuOptions.TTS:Output("", -1)
	SkuOptions.Voice:OutputStringBTtts(L["quest;abgebrochen"], true, true, 0.2, true)
	SkuOptions:CloseMenu()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnSkuQuestUP()
	if ( not QuestLogFrame:IsVisible() ) then
		return
	end

	--local tFirstSelectableQuest = QuestLog_GetFirstSelectableQuest()
	SkuQuest.SelectedQuest = SkuQuest.SelectedQuest or 1

	--dprint("q up")
	if ( not QuestLogFrame:IsVisible() ) then
		ShowUIPanel(QuestLogFrame)
		ExpandQuestHeader(0)
		SelectQuestLogEntry(SkuQuest.SelectedQuest)
	end
	
	local numEntries, numQuests = GetNumQuestLogEntries()
		
	SkuQuest.SelectedQuest = SkuQuest.SelectedQuest - 1
	if SkuQuest.SelectedQuest < 1 then 
		SkuQuest.SelectedQuest = 1
	end

	--SkuQuest:ShowForTTS()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnSkuQuestDOWN()
	if ( not QuestLogFrame:IsVisible() ) then
		return
	end

	SkuQuest.SelectedQuest = SkuQuest.SelectedQuest or 0
	--dprint("q down")
	if ( not QuestLogFrame:IsVisible() ) then
		ShowUIPanel(QuestLogFrame)
		ExpandQuestHeader(0)
		SelectQuestLogEntry(SkuQuest.SelectedQuest)
	end

	local numEntries, numQuests = GetNumQuestLogEntries()

	SkuQuest.SelectedQuest = SkuQuest.SelectedQuest + 1
	if SkuQuest.SelectedQuest > numEntries then 
		SkuQuest.SelectedQuest = numEntries
	end

	--SkuQuest:ShowForTTS()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetQuestTitlesList()
	local questList = {}
	local numEntries, numQuests = GetNumQuestLogEntries()
	if (numEntries == 0) then
		return
	end

	for questLogID = 1, numEntries do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
		--dprint(questLogID, title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory)
		table.insert(questList, title)
	end

	return questList
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:CheckQuestProgress(aSilent)
	--print("CheckQuestProgress(aSilent)", aSilent, SkuOptions.db.char["SkuQuest"].CheckQuestProgressList) 
	if not SkuOptions.db.char[MODULE_NAME] then
		SkuOptions.db.char["SkuQuest"]  = {}
	end
	if not SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList then
		SkuOptions.db.char["SkuQuest"].CheckQuestProgressList  = {}
		aSilent = true
	end

	local numEntries, numQuests = GetNumQuestLogEntries()
	if (numEntries == 0) then
		return
	end

	for questLogID = 1, numEntries do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)

		if not isHeader then

			if not SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID] then
				--print(questID, "  new objective in db")
				table.insert(SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList, questID)
				SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID] = {
					["objectives"] = {},
				}
			end

			local numObjectives = GetNumQuestLeaderBoards(questLogID) --number of objectives for a given quest questID
			if ( numObjectives > 0 ) then
				local objectivesChanged = false
				local objectivesCompleted = 0
				for j = 1, numObjectives do

					local text, ttype, finished = GetQuestLogLeaderBoard(j, questLogID)
					--print("    text, ttype, finished", text, ttype, finished, aSilent)
					if not aSilent then
						if type(SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID]) == "table" then
							if not SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j] then
								-- new objective
								--print("      new objective", j)
								table.insert(SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives, j)
								SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j] = text
							else
								-- updated objective
								--print("      updated objective", j, SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j], "-", text)
								if SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j] ~= text then
									objectivesChanged = true
									--print("         success 1", SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j], text)
									if not aSilent then
										SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
									end
									SkuOptions.db.char[MODULE_NAME].CheckQuestProgressList[questID].objectives[j] = text
								end
							end
						end
						if ( finished ) then
							objectivesCompleted = objectivesCompleted + 1
						end
					end
				end

				if ( objectivesCompleted == numObjectives ) then
					if objectivesChanged == true then
						-- quest completed
						if not aSilent then
							SkuOptions.Voice:OutputString("sound-success2", true, true, 0.1, true)
						end
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetTTSText(aQuestID)

--dprint("============================")
	--if 1 == 1 then return end


	local questID = aQuestID--SkuQuest.SelectedQuest
	local id = questID - FauxScrollFrame_GetOffset(QuestLogListScrollFrame)

	SelectQuestLogEntry(questID)

	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questID)
	--dprint("questLogTitleText", questLogTitleText, questID, aQuestID)	
	if not questLogTitleText then
		return
	end

	local titleButton = _G["QuestLogTitle"..id]
	local titleButtonTag = _G["QuestLogTitle"..id.."Tag"]
	aQuestID = aQuestID or questID
	QuestLogFrame.selectedButtonID = aQuestID
	local scrollFrameOffset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
	if (questID > scrollFrameOffset and questID <= (scrollFrameOffset + QUESTS_DISPLAYED) and questID <= GetNumQuestLogEntries()) then
		titleButton:LockHighlight()
		titleButtonTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		QuestLogSkillHighlight:SetVertexColor(titleButton.r, titleButton.g, titleButton.b)
		QuestLogHighlightFrame:SetPoint("TOPLEFT", "QuestLogTitle"..id, "TOPLEFT", 5, 0)
		QuestLogHighlightFrame:Show()
	end
	if ( GetQuestLogSelection() > GetNumQuestLogEntries() ) then
		return
	end
	QuestLog_UpdateQuestDetails()

	local questDescription, questObjectives = GetQuestLogQuestText()
	--questDescription = questDescription:gsub("[\n\r]", " ")
	questTag = questTag or ""

	local tText = ""
	local tSections = {}
	local tTextObjectives = ""
	local tTextFailedCompleted = ""
	local tTextProgresss = ""

	if isHeader then
		tText = L["Nr: "]..SkuQuest.SelectedQuest.."\r\n\r\n"..L["Zone: "]..questLogTitleText
		table.insert(tSections, SkuQuest.SelectedQuest..L[" Zone "]..questLogTitleText)
	else
		if ( isComplete and isComplete < 0 ) then
			questTag = FAILED
			--tText = tText.."\r\n".."FAILED"
			tTextFailedCompleted = L["Fehlgeschlagen"]
		elseif ( isComplete and isComplete > 0 ) then
			questTag = COMPLETE
			--tText = tText.."\r\n".."COMPLETE"
			tTextFailedCompleted = L["Abgeschlossen"]
		else
			--tText = tText.."\r\n".."isComplete nil"
			tTextFailedCompleted = nil
		end

		local numObjectives = GetNumQuestLeaderBoards()

		tText = tText.."\r\n".."numObjectives: "..numObjectives
		--table.insert(tSections, "numObjectives: "..numObjectives)

		for i=1, numObjectives, 1 do
			local string = _G["QuestLogObjective"..i]
			local text
			local ttype
			local finished
			text, ttype, finished = GetQuestLogLeaderBoard(i)
			if ( not text or strlen(text) == 0 ) then
				text = ttype
			end
			if ( not text or strlen(text) == 0 ) then
				text = L["Keine Informationen vorhanden"]
			end

			if ( finished ) then
				string:SetTextColor(0.2, 0.2, 0.2)
				text = text.." ("..COMPLETE..")"
				--tText = tText.."\r\n"..text.." ("..COMPLETE..")"
				tTextProgresss = tTextProgresss..text.."\r\n"

			else
				string:SetTextColor(0, 0, 0)
				--tText = tText.."\r\n NO COMPLETE"
				tTextProgresss = tTextProgresss..text.."\r\n"
			end
		end

		local numRewards = GetNumQuestLogRewards()
		local numChoices = GetNumQuestLogChoices()
		local money = GetQuestLogRewardMoney()
		--tText = tText.."\r\n numRewards: "..numRewards
		--tText = tText.."\r\n numChoices: "..numChoices
		--tText = tText.."\r\n money: "..money

		local tGold, tSilver, tCopper
		tCopper = string.sub(money, string.len(money) - 1, string.len(money))
		tSilver = string.sub(money, string.len(money) - 3, string.len(money) - 2)
		tGold = string.sub(money, 1, string.len(money) - 4)
		local tCurrencyFormated 
		if tonumber(money) > 0 then
			tCurrencyFormated = GetCoinText(tonumber(money), " ")
		else
			tCurrencyFormated = L["Kein Gold"]
		end
		local tRewardsText = {tCurrencyFormated, numRewards..L[" feste Gegenstände"], numChoices..L[" Gegenstände zur Auswahl"]}

		local tTtipText = ""

		if numRewards > 0 then
			tTtipText = tTtipText..L["\r\nFeste Gegenstände\r\n"]
			for i=1, numRewards, 1 do
				local link
				local tQuestLogItem = _G["QuestLogItem"..i]

				if (tQuestLogItem.rewardType == "item") then
					link = GetQuestLogItemLink(tQuestLogItem.type, tQuestLogItem:GetID())
				elseif (self.rewardType== "spell") then
					link = GetQuestLogSpellLink(tQuestLogItem:GetID())
				end
				if link then
					local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(link) --GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")						
					itemEquipLoc = _G[itemEquipLoc]
					itemRarity = EnumItemQuality[itemRarity]

					GameTooltip_SetBasicTooltip(GameTooltip, "lskjdf", 10, 10)
					GameTooltip:Show()
					GameTooltip:SetHyperlink(link)

					--dprint("Rew ---- "..i)
					--dprint(link)
					local function EnumerateTooltipLines_helper(...)
						for x = 1, select("#", ...) do
							local region = select(x, ...)
							if region and region:GetObjectType() == "FontString" then
								local text = region:GetText() -- string or nil
								if text then
									if text == _G["QuestLogItem"..i.."Name"]:GetText() then
										tTtipText = tTtipText..i..": "..text.."\r\n"
										tTtipText = tTtipText..itemRarity.."\r\n"
									else
										tTtipText = tTtipText..text.."\r\n"
									end
								end
							end
						end
					end					
					EnumerateTooltipLines_helper(GameTooltip:GetRegions())
					GameTooltip:Hide()
				end
			end
		end

		if numChoices > 0 then
			tTtipText = tTtipText..L["\r\nGegenstände zur Auswahl\r\n"]
			for i=1, numChoices, 1 do
				local link
				local tQuestLogItem = _G["QuestLogItem"..i]

				if (tQuestLogItem.rewardType == "item") then
					link = GetQuestLogItemLink(tQuestLogItem.type, tQuestLogItem:GetID())
				elseif (self.rewardType== "spell") then
					link = GetQuestLogSpellLink(tQuestLogItem:GetID())
				end
				if link then
					local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(link) --GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")						
					itemEquipLoc = _G[itemEquipLoc]
					itemRarity = EnumItemQuality[itemRarity]

					GameTooltip_SetBasicTooltip(GameTooltip, "lskjdf", 10, 10)
					GameTooltip:Show()
					GameTooltip:SetHyperlink(link)

					--dprint("Rew ---- "..i)
					--dprint(link)
					local function EnumerateTooltipLines_helper(...)
						for x = 1, select("#", ...) do
							local region = select(x, ...)
							if region and region:GetObjectType() == "FontString" then
								local text = region:GetText() -- string or nil
								if text then
									if text == _G["QuestLogItem"..i.."Name"]:GetText() then
										tTtipText = tTtipText..i..": "..text.."\r\n"
										tTtipText = tTtipText..itemRarity.."\r\n"
									else
										tTtipText = tTtipText..text.."\r\n"
									end
								end
							end
						end
					end					
					EnumerateTooltipLines_helper(GameTooltip:GetRegions())
					GameTooltip:Hide()
				end
			end
		end

		tText = "\r\n"..L["Nr: "]..SkuQuest.SelectedQuest.."\r\n\r\n"
		local tTemptext = ""
		--table.insert(tSections, "Nr: "..SkuQuest.SelectedQuest)
		if tTextFailedCompleted then
			tText = tText..L["Titel: "]..questLogTitleText.." ("..tTextFailedCompleted..")\r\n\r\n"
			--table.insert(tSections, "Titel: "..questLogTitleText.." ("..tTextFailedCompleted..")")
			tTemptext = tTemptext..questLogTitleText.." ("..tTextFailedCompleted..")"
		else
			tText = tText..L["Titel: "]..questLogTitleText.."\r\n\r\n"
			--table.insert(tSections, "Titel: "..questLogTitleText)
			tTemptext = tTemptext..questLogTitleText
		end
		table.insert(tSections, tTemptext)
		tText = tText..L["Level: "]..level.."\r\n\r\n"
		table.insert(tSections, L["Level "]..level)
		--tText = tText.."Tag: "..questTag.."\r\n\r\n"
		if tTextProgresss ~= "" then
			tText = tText..L["Fortschritt:\r\n"]..tTextProgresss.."\r\n\r\n"
			table.insert(tSections, L["Fortschritt\r\n"]..tTextProgresss)
		end
		if table.getn(tRewardsText) > 0 then
			tText = tText..L["Belohnungen:\r\n"]
			local tmpText = L["Belohnungen\r\n"]
			for y = 1, table.getn(tRewardsText) do
				tText = tText..y..". "..tRewardsText[y].."\r\n"
				tmpText = tmpText..y..". "..tRewardsText[y].."\r\n"
				--dprint(y, tRewardsText[y])
			end
			table.insert(tSections, tmpText)
		end
		if tTtipText ~= "" then
			table.insert(tSections, L["Belohnungen:\r\n"]..tTtipText)
		end


		tText = tText..L["Ziele:\r\n"]..questObjectives.."\r\n"
		table.insert(tSections, L["Ziele\r\n"]..questObjectives)
		-- Die Belohnungen mit Nummerierung - Kopf, Leder, RÃ¼stung, Stats (+1 Int, +2 Ausdauer) in textform
		tText = tText..L["Questtext:\r\n"]..questDescription.."\r\n\r\n"
		table.insert(tSections, L["Questtext\r\n"]..questDescription)
	end

	--SkuOptions.TTS:Output(tSections, 10000)
	--SkuOptions.Voice:OutputString(string.format("%02d", SkuQuest.SelectedQuest), false, true, 0.3)
	return tSections


end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:ShowForTTS(aQuestID)
--dprint("============================")
	--if 1 == 1 then return end


	local questID = SkuQuest.SelectedQuest
	local id = questID - FauxScrollFrame_GetOffset(QuestLogListScrollFrame)

	SelectQuestLogEntry(questID)

	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questID)
--dprint("questLogTitleText", questLogTitleText)	
	if not questLogTitleText then
		return
	end

	local titleButton = _G["QuestLogTitle"..id]
	local titleButtonTag = _G["QuestLogTitle"..id.."Tag"]
	aQuestID = aQuestID or questID
	QuestLogFrame.selectedButtonID = aQuestID
	local scrollFrameOffset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
	if (questID > scrollFrameOffset and questID <= (scrollFrameOffset + QUESTS_DISPLAYED) and questID <= GetNumQuestLogEntries()) then
		titleButton:LockHighlight()
		titleButtonTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		QuestLogSkillHighlight:SetVertexColor(titleButton.r, titleButton.g, titleButton.b)
		QuestLogHighlightFrame:SetPoint("TOPLEFT", "QuestLogTitle"..id, "TOPLEFT", 5, 0)
		QuestLogHighlightFrame:Show()
	end
	if ( GetQuestLogSelection() > GetNumQuestLogEntries() ) then
		return
	end
	QuestLog_UpdateQuestDetails()

	local questDescription, questObjectives = GetQuestLogQuestText()
	--questDescription = questDescription:gsub("[\n\r]", " ")

	questTag = questTag or ""

	local tText = ""
	local tSections = {}
	local tTextObjectives = ""
	local tTextFailedCompleted = ""
	local tTextProgresss = ""

	if isHeader then
		tText = L["Nr: "]..SkuQuest.SelectedQuest.."\r\n\r\n"..L["Zone: "]..questLogTitleText
		table.insert(tSections, SkuQuest.SelectedQuest..L[" Zone "]..questLogTitleText)
	else
		if ( isComplete and isComplete < 0 ) then
			questTag = FAILED
			--tText = tText.."\r\n".."FAILED"
			tTextFailedCompleted = L["Fehlgeschlagen"]
		elseif ( isComplete and isComplete > 0 ) then
			questTag = COMPLETE
			--tText = tText.."\r\n".."COMPLETE"
			tTextFailedCompleted = L["Abgeschlossen"]
		else
			--tText = tText.."\r\n".."isComplete nil"
			tTextFailedCompleted = nil
		end

		local numObjectives = GetNumQuestLeaderBoards()

		tText = tText.."\r\n".."numObjectives: "..numObjectives
		--table.insert(tSections, "numObjectives: "..numObjectives)

		for i=1, numObjectives, 1 do
			local string = _G["QuestLogObjective"..i]
			local text
			local ttype
			local finished
			text, ttype, finished = GetQuestLogLeaderBoard(i)
			if ( not text or strlen(text) == 0 ) then
				text = ttype
			end
			if ( finished ) then
				string:SetTextColor(0.2, 0.2, 0.2)
				text = text.." ("..COMPLETE..")"
				--tText = tText.."\r\n"..text.." ("..COMPLETE..")"
				tTextProgresss = tTextProgresss..text.."\r\n"

			else
				string:SetTextColor(0, 0, 0)
				--tText = tText.."\r\n NO COMPLETE"
				tTextProgresss = tTextProgresss..text.."\r\n"
			end
		end

		local numRewards = GetNumQuestLogRewards()
		local numChoices = GetNumQuestLogChoices()
		local money = GetQuestLogRewardMoney()
		--tText = tText.."\r\n numRewards: "..numRewards
		--tText = tText.."\r\n numChoices: "..numChoices
		--tText = tText.."\r\n money: "..money

		local tGold, tSilver, tCopper
		tCopper = string.sub(money, string.len(money) - 1, string.len(money))
		tSilver = string.sub(money, string.len(money) - 3, string.len(money) - 2)
		tGold = string.sub(money, 1, string.len(money) - 4)
		local tCurrencyFormated 
		if tonumber(money) > 0 then
			tCurrencyFormated = GetCoinText(tonumber(money), " ")
		else
			tCurrencyFormated = L["Kein Gold"]
		end
		local tRewardsText = {tCurrencyFormated, numRewards..L[" feste Gegenstände"], numChoices..L[" Gegenstände zur Auswahl"]}

		local tTtipText = ""

		if numRewards > 0 then
			tTtipText = tTtipText..L["\r\nFeste Gegenstände\r\n"]
			for i=1, numRewards, 1 do
				local link
				local tQuestLogItem = _G["QuestLogItem"..i]

				if (tQuestLogItem.rewardType == "item") then
					link = GetQuestLogItemLink(tQuestLogItem.type, tQuestLogItem:GetID())
				elseif (self.rewardType== "spell") then
					link = GetQuestLogSpellLink(tQuestLogItem:GetID())
				end
				if link then
					local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(link) --GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")						
					itemEquipLoc = _G[itemEquipLoc]
					itemRarity = EnumItemQuality[itemRarity]

					GameTooltip_SetBasicTooltip(GameTooltip, "lskjdf", 10, 10)
					GameTooltip:Show()
					GameTooltip:SetHyperlink(link)

					--dprint("Rew ---- "..i)
					--dprint(link)
					local function EnumerateTooltipLines_helper(...)
						for x = 1, select("#", ...) do
							local region = select(x, ...)
							if region and region:GetObjectType() == "FontString" then
								local text = region:GetText() -- string or nil
								if text then
									if text == _G["QuestLogItem"..i.."Name"]:GetText() then
										tTtipText = tTtipText..i..": "..text.."\r\n"
										tTtipText = tTtipText..itemRarity.."\r\n"
									else
										tTtipText = tTtipText..text.."\r\n"
									end
								end
							end
						end
					end					
					EnumerateTooltipLines_helper(GameTooltip:GetRegions())
					GameTooltip:Hide()
				end
			end
		end

		if numChoices > 0 then
			tTtipText = tTtipText..L["\r\nGegenstände zur Auswahl\r\n"]
			for i=1, numChoices, 1 do
				local link
				local tQuestLogItem = _G["QuestLogItem"..i]

				if (tQuestLogItem.rewardType == "item") then
					link = GetQuestLogItemLink(tQuestLogItem.type, tQuestLogItem:GetID())
				elseif (self.rewardType== "spell") then
					link = GetQuestLogSpellLink(tQuestLogItem:GetID())
				end
				if link then
					local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(link) --GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")						
					itemEquipLoc = _G[itemEquipLoc]
					itemRarity = EnumItemQuality[itemRarity]

					GameTooltip_SetBasicTooltip(GameTooltip, "lskjdf", 10, 10)
					GameTooltip:Show()
					GameTooltip:SetHyperlink(link)

					--dprint("Rew ---- "..i)
					--dprint(link)
					local function EnumerateTooltipLines_helper(...)
						for x = 1, select("#", ...) do
							local region = select(x, ...)
							if region and region:GetObjectType() == "FontString" then
								local text = region:GetText() -- string or nil
								if text then
									if text == _G["QuestLogItem"..i.."Name"]:GetText() then
										tTtipText = tTtipText..i..": "..text.."\r\n"
										tTtipText = tTtipText..itemRarity.."\r\n"
									else
										tTtipText = tTtipText..text.."\r\n"
									end
								end
							end
						end
					end					
					EnumerateTooltipLines_helper(GameTooltip:GetRegions())
					GameTooltip:Hide()
				end
			end
		end

		tText = "\r\n"..L["Nr: "]..SkuQuest.SelectedQuest.."\r\n\r\n"
		local tTemptext = SkuQuest.SelectedQuest.." "
		--table.insert(tSections, "Nr: "..SkuQuest.SelectedQuest)
		if tTextFailedCompleted then
			tText = tText..L["Titel: "]..questLogTitleText.." ("..tTextFailedCompleted..")\r\n\r\n"
			--table.insert(tSections, "Titel: "..questLogTitleText.." ("..tTextFailedCompleted..")")
			tTemptext = tTemptext..questLogTitleText.." ("..tTextFailedCompleted..")"
		else
			tText = tText..L["Titel: "]..questLogTitleText.."\r\n\r\n"
			--table.insert(tSections, "Titel: "..questLogTitleText)
			tTemptext = tTemptext..questLogTitleText
		end
		table.insert(tSections, tTemptext)
		tText = tText..L["Level: "]..level.."\r\n\r\n"
		table.insert(tSections, L["Level "]..level)
		--tText = tText.."Tag: "..questTag.."\r\n\r\n"
		if tTextProgresss ~= "" then
			tText = tText..L["Fortschritt:\r\n"]..tTextProgresss.."\r\n\r\n"
			table.insert(tSections, L["Fortschritt\r\n"]..tTextProgresss)
		end
		if table.getn(tRewardsText) > 0 then
			tText = tText..L["Belohnungen:\r\n"]
			local tmpText = L["Belohnungen\r\n"]
			for y = 1, table.getn(tRewardsText) do
				tText = tText..y..". "..tRewardsText[y].."\r\n"
				tmpText = tmpText..y..". "..tRewardsText[y].."\r\n"
				--dprint(y, tRewardsText[y])
			end
			table.insert(tSections, tmpText)
		end
		if tTtipText ~= "" then
			table.insert(tSections, L["Belohnungen:\r\n"]..tTtipText)
		end


		tText = tText..L["Ziele:\r\n"]..questObjectives.."\r\n"
		table.insert(tSections, L["Ziele\r\n"]..questObjectives)
		-- Die Belohnungen mit Nummerierung - Kopf, Leder, RÃ¼stung, Stats (+1 Int, +2 Ausdauer) in textform
		tText = tText..L["Questtext:\r\n"]..questDescription.."\r\n\r\n"
		table.insert(tSections, L["Questtext\r\n"]..questDescription)
	end

	SkuOptions.TTS:Output(tSections, 10000)
	--SkuOptions.Voice:OutputStringBTtts(string.format("%02d", SkuQuest.SelectedQuest), false, true, 0.3)

	if isHeader then
		SkuOptions.Voice:OutputStringBTtts(string.format("%02d", SkuQuest.SelectedQuest)..L[" Zone "]..questLogTitleText, true, true)
		--SkuOptions.Voice:OutputStringBTtts(questLogTitleText, false, true)
	--elseif SkuQuest_QuestTitlesAudioIndex[questID] then
	else
		if tTextFailedCompleted then
			if tTextFailedCompleted == L["Abgeschlossen"] then
				--SkuOptions.Voice:OutputStringBTtts("abgeschlossen", false, true, 0.8)
			elseif tTextFailedCompleted == L["Fehlgeschlagen"] then
				--SkuOptions.Voice:OutputStringBTtts("fehlgeschlagen", false, true, 0.8)
			end
		else
			tTextFailedCompleted = ""
		end
	
		--SkuOptions.Voice:Output(SkuQuest_QuestTitlesAudioIndex[questID])
		SkuOptions.Voice:OutputStringBTtts(string.format("%02d", SkuQuest.SelectedQuest).." "..tTextFailedCompleted.." "..questLogTitleText, true, true)
	end
	
	--SkuOptions.TTS:Output(tText, 10000)


end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:OnQuestLog_OnEvent(obj, event, ...)
	-- Called when the addon is enabled
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:ToggleQuestLogHook(...)
	--dprint("ToggleQuestLogHook", ...)
	if ( QuestLogFrame:IsVisible() ) then
		ExpandQuestHeader(0)
	end
	--if 1 == 1 then return end

	if SkuCore.inCombat == true then
		return
	end

	if ( QuestLogFrame:IsVisible() ) then
		--SkuOptions.TTS:Output("", 10000)--HideUIPanel(QuestLogFrame)
		C_Timer.NewTimer(0.1, function()
			SkuOptions:SlashFunc("short,"..L["SkuQuestMenuEntry"])
			--SkuOptions.Voice:OutputStringBTtts(self.name, true, true, 0.3, true)
		end)

		--[[
		if _G["SkuQuestMainOption1"] then
			_G["SkuQuestMainOption1"]:Show()
		end
		]]
		SkuQuest.SelectedQuest = SkuQuest.SelectedQuest + 1 or 1
		SkuQuest:OnSkuQuestUP()
	else
		SkuOptions:CloseMenu()
		--[[
		if _G["SkuQuestMainOption1"] then
			_G["SkuQuestMainOption1"]:Hide()
		end
		]]
		--SkuOptions.TTS:Output("", -1)--ShowUIPanel(QuestLogFrame)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:RefreshVisuals()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:QUEST_LOG_UPDATE(...)
	--print("QUEST_LOG_UPDATE", SkuOptions.db.char[MODULE_NAME])
	SkuQuest:CheckQuestProgress(PLAYER_ENTERING_WORLD_flag, SkuOptions.db.char["SkuQuest"].CheckQuestProgressList)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:UPDATE_FACTION(...)
	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	--print("UPDATE_FACTION", SkuOptions.db.char[MODULE_NAME])
	SkuQuest:CheckQuestProgress(PLAYER_ENTERING_WORLD_flag, SkuOptions.db.char["SkuQuest"].CheckQuestProgressList)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:UNIT_QUEST_LOG_CHANGED(...)
	--print("UNIT_QUEST_LOG_CHANGED", SkuOptions.db.char["SkuQuest"].CheckQuestProgressList)
	SkuQuest:CheckQuestProgress(PLAYER_ENTERING_WORLD_flag)
end

--[[ Questie integration test
local QuestieQuest
local QuestieDB
local QuestiePlayer
]]
---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:PLAYER_LOGIN(...)
	SkuDB:FixQuestDB()
	SkuDB:FixItemDB()
	SkuDB:FixCreaturesDB()
	SkuDB:FixObjectsDB()
	SkuQuest:BuildQuestZoneCache()

	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	C_Timer.NewTimer(10, function() PLAYER_ENTERING_WORLD_flag = false end)

	SkuQuest:UpdateAllQuestObjects()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:PLAYER_ENTERING_WORLD(...)
	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	--print("PLAYER_ENTERING_WORLD", SkuOptions.db.char["SkuQuest"].CheckQuestProgressList)

	SkuQuest:CheckQuestProgress(PLAYER_ENTERING_WORLD_flag)
	SkuQuest:CheckQuestProgress(PLAYER_ENTERING_WORLD_flag)

	C_Timer.After(20, function()
		SkuQuest:LoadEventHandler()
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:VARIABLES_LOADED(...)
	--dprint(...)
	HideUIPanel(QuestLogFrame)
	--hooksecurefunc("QuestLog_Update", SkuQuest.OnQuestLog_OnEvent)
	hooksecurefunc("ToggleQuestLog", SkuQuest.ToggleQuestLogHook)
	--hooksecurefunc("HideUIPanel", SkuQuest.ToggleQuestLogHook)
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuQuest.QuestWpCache = {}
function SkuQuest:GetAllQuestWps(aQuestID, aStart, aObjective, aFinish, aOnly3)
	--dprint("GetAllQuestWps", aQuestID, aStart, aObjective, aFinish, aOnly3)

	if aStart == true then
		if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][1] 
			or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][2]
			or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][3]
		then
			local tstartedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]]
			if tstartedBy then
				local tTargets = {}
				local tTargetType = nil
				tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tstartedBy)
				if	tTargetType then
					local tResultWPs = {}
					SkuQuest:GetResultingWps(tTargets, tTargetType, aQuestID, tResultWPs, aOnly3)
					for i, v in pairs(tResultWPs) do
						for ri, rv in pairs(v) do
							SkuQuest.QuestWpCache[rv] = true
						end
					end
				end
			end
		end
	end

	if aObjective == true then
		local tObjectives = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["objectives"]]
		if tObjectives then
			local tTargets = {}
			local tTargetType = nil
			tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tObjectives)
			if	tTargetType then
				local tResultWPs = {}
				SkuQuest:GetResultingWps(tTargets, tTargetType, aQuestID, tResultWPs, aOnly3)
				for i, v in pairs(tResultWPs) do
					for ri, rv in pairs(v) do
						SkuQuest.QuestWpCache[rv] = true
					end
				end
			end
		end
	end
	if aFinish == true then
		if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][1] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][2] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][3] then
			local tFinishedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]]
			if tFinishedBy then
				local tTargets = {}
				local tTargetType = nil
				tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tFinishedBy)
				if	tTargetType then
					local tResultWPs = {}
					SkuQuest:GetResultingWps(tTargets, tTargetType, aQuestID, tResultWPs, aOnly3)
					for i, v in pairs(tResultWPs) do
						for ri, rv in pairs(v) do
							SkuQuest.QuestWpCache[rv] = true
						end
					end
				end
			end
		end
	end

end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetCreatureArea(aQuestID, aCreatureId)
	if SkuDB.NpcData.Data[aCreatureId] then
		local tSpawns = SkuDB.NpcData.Data[aCreatureId][7]
		if tSpawns then
			for is, vs in pairs(tSpawns) do
				SkuQuest.QuestZoneCache[aQuestID][is] = is
			end
		end
	end
end
local function GetObjectArea(aQuestID, aObjectId)
	if not SkuDB.objectDataTBC[aObjectId] then
		return
	end
	if SkuDB.objectDataTBC[aObjectId][SkuDB.objectKeys['spawns']] then
		for sAreaID, vi in pairs(SkuDB.objectDataTBC[aObjectId][SkuDB.objectKeys['spawns']]) do
			SkuQuest.QuestZoneCache[aQuestID][sAreaID] = sAreaID
		end
	end
end
function SkuQuest:BuildQuestZoneCache()
	SkuQuest.QuestZoneCache = {}
	for aQuestID = 1, 100000 do
		if SkuDB.questDataTBC[aQuestID] then
			SkuQuest.QuestZoneCache[aQuestID] = {}

			--starts
			local tstartedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]]
			if tstartedBy[1] then
				--creatureStart
				for i, v in pairs(tstartedBy[1]) do
					GetCreatureArea(aQuestID, v)
				end
			end
			if tstartedBy[2] then
				--objectStart
				for i, id in pairs(tstartedBy[2]) do
					GetObjectArea(aQuestID, id)
				end
			end
			if tstartedBy[3] then
				--itemStart
				for i, v in pairs(tstartedBy[3]) do
					--dprint("  itemStart", i, v)
					if SkuDB.itemDataTBC[v][SkuDB.itemKeys['npcDrops']] then
						for z = 1, #SkuDB.itemDataTBC[v][SkuDB.itemKeys['npcDrops']] do
							GetCreatureArea(aQuestID, SkuDB.itemDataTBC[v][SkuDB.itemKeys['npcDrops']][z])
						end
					end
					if SkuDB.itemDataTBC[v][SkuDB.itemKeys['objectDrops']] then
						for z = 1, #SkuDB.itemDataTBC[v][SkuDB.itemKeys['objectDrops']] do
							GetObjectArea(aQuestID, SkuDB.itemDataTBC[v][SkuDB.itemKeys['objectDrops']][z])
						end
					end
					if SkuDB.itemDataTBC[v][SkuDB.itemKeys['itemDrops']] then
						for z = 1, #SkuDB.itemDataTBC[v][SkuDB.itemKeys['itemDrops']] do
							local tItemId = SkuDB.itemDataTBC[v][SkuDB.itemKeys['itemDrops']][z]
							if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] then
								for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] do
									GetCreatureArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']][z])
								end
							end
							if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] then
								for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] do
									GetObjectArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']][z])
								end
							end
						end
					end
				end
			end

			--objectives
			local objectives = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["objectives"]]
			if objectives then
				--['creatureObjective'] = 1, -- table {{creature(int), text(string)},...}, If text is nil the default "<Name> slain x/y" is used
				if objectives[1] then
					for i, v in pairs(objectives[1]) do
						GetCreatureArea(aQuestID, v[1])
					end
				end
				--['objectObjective'] = 2, -- table {{object(int), text(string)},...}
				if objectives[2] then
					for i, v in pairs(objectives[2]) do
						GetCreatureArea(aQuestID, v[1])
					end
				end
				--['itemObjective'] = 3, -- table {{item(int), text(string)},...}
				if objectives[3] then
					--dprint("  objectives itemObjective")
					for i, v in pairs(objectives[3]) do
						local tItemId = v[1]
						if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] then
							for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] do
								GetCreatureArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']][z])
							end
						end
						if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] then
							for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] do
								GetObjectArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']][z])
							end
						end
						if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['itemDrops']] then
							for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['itemDrops']] do
								local tItemId = SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['itemDrops']][z]
								if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] then
									for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']] do
										GetCreatureArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['npcDrops']][z])
									end
								end
								if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] then
									for z = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']] do
										GetObjectArea(aQuestID, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys['objectDrops']][z])
									end
								end
							end
						end
					end
				end
			end

			--finishs
			local finishedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]]
			if finishedBy[1] then
				--creature
				for i, v in pairs(finishedBy[1]) do
					GetCreatureArea(aQuestID, v)
				end
			end
			if finishedBy[2] then
				--object
				for i, id in pairs(finishedBy[2]) do
					GetObjectArea(aQuestID, id)
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuQuest.questObjects = {}
function SkuQuest:GetAllQuestObjects()
	return SkuQuest.questObjects
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:UpdateAllQuestObjects()
	SkuQuest.questObjects = {}
	if GetNumQuestLogEntries() > 0 then
		for x = 1, GetNumQuestLogEntries() do
			if GetNumQuestLeaderBoards(x) > 0 then
				for y = 1, GetNumQuestLeaderBoards(x) do
					local description, objectiveType, isCompleted = GetQuestLogLeaderBoard(y, x)
					if isCompleted == false then
						if objectiveType == "object" then
							dprint(x, y, description)
						elseif objectiveType == "item" then
							for i, v in pairs(SkuDB.itemLookup[Sku.L["locale"]]) do
								if string.find(description, v) then
									if SkuDB.itemDataTBC[i] and SkuDB.itemDataTBC[i][SkuDB.itemKeys.objectDrops] then
										for _, tObjectId in pairs(SkuDB.itemDataTBC[i][SkuDB.itemKeys.objectDrops]) do
											dprint(v, tObjectId, SkuDB.objectLookup[Sku.L["locale"]][tObjectId])
											if SkuDB.objectLookup[Sku.L["locale"]][tObjectId] then
												SkuQuest.questObjects[SkuDB.objectLookup[Sku.L["locale"]][tObjectId]] = tObjectId
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:QUEST_ACCEPTED()
	SkuQuest:UpdateAllQuestObjects()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:QUEST_REMOVED()
	SkuQuest:UpdateAllQuestObjects()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:QUEST_TURNED_IN()
	SkuQuest:UpdateAllQuestObjects()
end

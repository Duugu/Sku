local MODULE_NAME = "SkuChat"

local L = Sku.L

local play = 2	--this is just a local constant for output type (play, true, false)

SkuChat.CombatConfigUnitTypes = {
	--[[
	{
		text = COMBATLOG_FILTER_STRING_ME,
		type = COMBATLOG_FILTER_ME,
	},
	]]
	{
		text = COMBATLOG_FILTER_STRING_ME,
		type = COMBATLOG_FILTER_MINE,
	},
	{
		text = COMBATLOG_FILTER_STRING_MY_PET,
		type = COMBATLOG_FILTER_MY_PET,
	},
	{
		text = COMBATLOG_FILTER_STRING_FRIENDLY_UNITS,
		type = COMBATLOG_FILTER_FRIENDLY_UNITS,
	},
	{
		text = COMBATLOG_FILTER_STRING_HOSTILE_PLAYERS,
		type = COMBATLOG_FILTER_HOSTILE_PLAYERS,
	},
	{
		text = COMBATLOG_FILTER_STRING_HOSTILE_UNITS,
		type = COMBATLOG_FILTER_HOSTILE_UNITS,
	},
	{
		text = COMBATLOG_FILTER_STRING_NEUTRAL_UNITS,
		type = COMBATLOG_FILTER_NEUTRAL_UNITS,
	},
	{
		text = COMBATLOG_FILTER_STRING_UNKNOWN_UNITS,
		type = COMBATLOG_FILTER_UNKNOWN_UNITS,
	},
	--[[
	{
		text = "Everything",
		type = COMBATLOG_FILTER_EVERYTHING,
	},
	]]
}

SkuChat.CombatConfigMessageTypes = {
	{
		text = MELEE.." "..DAMAGE,
		type = {"SWING_DAMAGE"},
	},
	{
		text = MELEE.." "..MISSES,
		type = {"SWING_MISSED"},
	},
	{
		text = RANGED.." "..DAMAGE,
		type = {"RANGE_DAMAGE"},
	},
	{
		text = RANGED.." "..MISSES,
		type = {"RANGE_MISSED"},
	},
	{
		text = AURAS.." "..BENEFICIAL,
		type = {"SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE", "SPELL_AURA_REMOVED", "SPELL_AURA_REMOVED_DOSE", "SPELL_AURA_REFRESH"},
	},
	{
		text = AURAS.." "..HOSTILE,
		type = {"SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE", "SPELL_AURA_REMOVED", "SPELL_AURA_REMOVED_DOSE"},
	},
	{
		text = AURAS.." "..DISPELS,
		type = {"SPELL_STOLEN", "SPELL_DISPEL_FAILED", "SPELL_DISPEL"},
	},
	{
		text = AURAS.." "..ENCHANTS,
		type = {"ENCHANT_APPLIED", "ENCHANT_REMOVED"},
	},
	{
		text = PERIODIC.." "..DAMAGE,
		type = {"SPELL_PERIODIC_DAMAGE"},
	},
	{
		text = PERIODIC.." "..MISSES,
		type = {"SPELL_PERIODIC_MISSED"},
	},
	{
		text = PERIODIC.." "..HEALS,
		type = {"SPELL_PERIODIC_HEAL"},
	},
	{
		text = PERIODIC.." "..OTHER,
		type = {"SPELL_PERIODIC_DRAIN","SPELL_PERIODIC_LEECH"},
	},
	{
		text = SPELLS.." "..DAMAGE,
		type = {"SPELL_DAMAGE"},
	},
	{
		text = SPELLS.." "..MISSES,
		type = {"SPELL_MISSED"},
	},
	{
		text = SPELLS.." "..HEALS,
		type = {"SPELL_HEAL"},
	},
	{
		text = SPELLS.." "..POWER_GAINS,
		type = {"SPELL_ENERGIZE"},
	},
	--[[
	[5] = {
		text = SPELLS.." "..DRAINS,
		type = {"SPELL_DRAIN", "SPELL_LEECH"},
	},
	[5] = {
		text = SPELLS.." "..INTERRUPTS,
		type = {"SPELL_INTERRUPT"},
	},
	]]
	{
		text = SPELLS.." "..SPECIAL,
		type = {"SPELL_INSTAKILL", "SPELL_DURABILITY_DAMAGE", "SPELL_DURABILITY_DAMAGE_ALL"},
	},
	{
		text = SPELLS.." "..EXTRA_ATTACKS,
		type = {"SPELL_EXTRA_ATTACKS"},
	},
	{
		text = SPELLS.." "..SUMMONS,
		type = {"SPELL_SUMMON"},
	},
	{
		text = SPELLS.." "..RESURRECT,
		type = {"SPELL_RESURRECT"},
	},
	{
		text = SPELL_CASTING.." "..START,
		type = {"SPELL_CAST_START"},
	},
	{
		text = SPELL_CASTING.." "..SUCCESS,
		type = {"SPELL_CAST_SUCCESS"},
	},
	{
		text = SPELL_CASTING.." "..FAILURES,
		type = {"SPELL_CAST_FAILED"},
	},
	{
		text = OTHER.." "..KILLS,
		type = {"PARTY_KILL"},
	},
	{
		text = OTHER.." "..DEATHS,
		type = {"UNIT_DIED", "UNIT_DESTROYED", "UNIT_DISSIPATES"},
	},
	{
		text = OTHER.." "..L["Damage Split"],
		type = {"DAMAGE_SPLIT"},
	},
	{
		text = OTHER.." "..ENVIRONMENTAL_DAMAGE,
		type = {"ENVIRONMENTAL_DAMAGE"},
	},
}


SkuChat.WowTtsVoices = {
	[1] = L["def Microsoft Hedda Desktop - German"],
}

SkuChat.timeStampFormats = {
	[1] = L["No timestamp"],
	[2] = TIMESTAMP_FORMAT_HHMM,
	[3] = TIMESTAMP_FORMAT_HHMMSS,
	[4] = TIMESTAMP_FORMAT_HHMM_AMPM,
	[5] = TIMESTAMP_FORMAT_HHMMSS_AMPM,
	[6] = TIMESTAMP_FORMAT_HHMM_24HR,
	[7] = TIMESTAMP_FORMAT_HHMMSS_24HR,
}

SkuChat.DeleteTabTimes = {
	[1] = -1,
	[2] = 2,
	[3] = 5,
	[4] = 10,
	[5] = 20,
	[6] = 40,
	[7] = 90,
	[8] = 180,
}

local exampleTime = {
	year = 2010,
	month = 12,
	day = 15,
	hour = 21,
	min = 43,
	sec = 38,
}

SkuChat.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		chatSettings = {
			name = L["Chat settings"],
			order = 1,
			type = "group",
			args = {

				--short channel names
				shortenChannelNames = {
					name = L["shorten Channel Names"],
					order = 1,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.shortenChannelNames = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.shortenChannelNames
					end,
				},

				--line numbers
				addLineNumbers = {
					name = L["add line numbers"],
					order = 2,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.addLineNumbers = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.addLineNumbers
					end,
				},

				--timestamp (pre, post, off)
				timeStamp = {
					order = 3,
					name = L["add timestamps"],
					desc = "",
					type = "select",
					values = {
						[1] = SkuChat.timeStampFormats[1],
						[2] = L["Format"].." 1: "..BetterDate(SkuChat.timeStampFormats[2], time(exampleTime)),
						[3] = L["Format"].." 2: "..BetterDate(SkuChat.timeStampFormats[2], time(exampleTime)),
						[4] = L["Format"].." 3: "..BetterDate(SkuChat.timeStampFormats[3], time(exampleTime)),
						[5] = L["Format"].." 4: "..BetterDate(SkuChat.timeStampFormats[4], time(exampleTime)),
						[6] = L["Format"].." 5: "..BetterDate(SkuChat.timeStampFormats[5], time(exampleTime)),
						[7] = L["Format"].." 6: "..BetterDate(SkuChat.timeStampFormats[6], time(exampleTime)),
					},
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStamp = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStamp
					end,
				},

				timeStampAtLineEnd = {
					name = L["add timestamp to line end"],
					order = 4,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStampAtLineEnd = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStampAtLineEnd
					end,
				},

				--go to 1st line
				firstLineOnTabSwitch = {
					name = L["go to first line on tab switch"],
					order = 5,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.firstLineOnTabSwitch = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.firstLineOnTabSwitch
					end,
				},

				--delete history on login
				deleteHistoryOnLogin = {
					name = L["delete chat history on login"],
					order = 6,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteHistoryOnLogin = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteHistoryOnLogin
					end,
				},

				--whispers in new tab
				openWhispersInNewTab = {
					name = L["show Whispers In New Tab"],
					order = 7,
					type = "toggle",
					desc = "",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.openWhispersInNewTab = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.openWhispersInNewTab
					end,
					OnAction = function(self, info, val)
						C_Timer.After(0.1, function()
							if SkuOptions.db.profile[MODULE_NAME].chatSettings.openWhispersInNewTab == false then
								if SkuOptions.db.profile["SkuChat"].tabs[1] then
									local tTab = SkuOptions.db.profile["SkuChat"].tabs[1]
									tTab.messageTypes["PLAYER_MESSAGES"][6] = 2
									tTab.messageTypes["PLAYER_MESSAGES"][7] = 2
									tTab.messageTypes["CREATURE_MESSAGES"][4] = 2
									tTab.messageTypes["CREATURE_MESSAGES"][6] = 2		
								end

								for z = 1, #SkuOptions.db.profile["SkuChat"].tabs do
									if SkuOptions.db.profile["SkuChat"].tabs[z].privateMessages then
										SkuChat:DeleteTab(z)
									else
										SkuChat:InitTab(z)
									end
								end
							end
						end)
					end,
				},
				deleteWhisperTabsAfter = {
					order = 3,
					name = L["delete whisper tabs without activity after"],
					desc = "",
					type = "select",
					values = {
						[1] = L["Never"] ,
						[2] = SkuChat.DeleteTabTimes[2]..L[" Minuten"],
						[3] = SkuChat.DeleteTabTimes[3]..L[" Minuten"],
						[4] = SkuChat.DeleteTabTimes[4]..L[" Minuten"],
						[5] = SkuChat.DeleteTabTimes[5]..L[" Minuten"],
						[6] = SkuChat.DeleteTabTimes[6]..L[" Minuten"],
						[7] = SkuChat.DeleteTabTimes[7]..L[" Minuten"],
						[8] = SkuChat.DeleteTabTimes[8]..L[" Minuten"],
					},
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteWhisperTabsAfter = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteWhisperTabsAfter
					end,
				},				
				audioOnNewMessage = {
					name = L["Audio notification on chat message"],
					order = 8,
					type = "toggle",
					desc = L["Enables / disables audio on new line"],
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnNewMessage = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnNewMessage
					end,
					OnAction = function() 
						if SkuOptions.db.profile["SkuChat"].tabs then
							for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs) do
								v.audioOnNewMessage = SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnNewMessage
							end
						end
					end,
				},
				audioOnMessageEnd = {
					name = L["Audio notification on the end of chat messages"],
					desc = L["Controls whether a sound is played at the end of a chat message."],
					order = 9,
					type = "toggle",
					set = function(info,val)
						C_TTSSettings.SetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks, val)
					end,
					get = function(info) 
						return C_TTSSettings.GetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks)
					end,
					OnAction = function() 
						C_TTSSettings.SetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks, SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnMessageEnd)
					end,
				},

			},
		},
		WowTtsVoice = {
			order = 3,
			name = L["TTS voice"],
			desc = "",
			type = "select",
			values = SkuChat.WowTtsVoices,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].WowTtsVoice = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].WowTtsVoice
			end,
		},
		WowTtsSpeed = {
			order = 4,
			name = L["TTS speed"],
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed
			end,
		},
		WowTtsVolume = {
			order = 5,
			name = L["TTS volume"],
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].WowTtsVolume = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].WowTtsVolume
			end,
		},
		WowTtsTags = {
			order = 5,
			name = L["TTS pause tags"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].WowTtsTags = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].WowTtsTags
			end,
		},
		joinSkuChannel = {
			order = 7,
			name = L["Sku Chat Channel beitreten"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].joinSkuChannel = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].joinSkuChannel
			end,
			OnAction = function()
				C_Timer.After(0.1, function()
					SkuChat:JoinOrLeaveSkuChatChannel()
				end)
			end,
		},
		neverResetQueues = {
			order = 8,
			name = L["Never reset audio queues"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].neverResetQueues = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].neverResetQueues
			end,
		},
		allChatViaBlizzardTts = {
			order = 9,
			name = L["All voice output via blizzard tts"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].allChatViaBlizzardTts = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].allChatViaBlizzardTts
			end,
		},
		doNotReadoutEmojis = {
			order = 20,
			name = L["Do not read out emojis"] ,
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].doNotReadoutEmojis = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].doNotReadoutEmojis
			end
		},

	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuChat.defaults = {
	chatSettings = {
		shortenChannelNames = false,
		openWhispersInNewTab = true,
		deleteWhisperTabsAfter = 3,
		addLineNumbers = true,
		timeStamp = 6,
		timeStampAtLineEnd = true,
		firstLineOnTabSwitch = true,
		deleteHistoryOnLogin = false,
		audioOnNewMessage = false,
		audioOnMessageEnd = false,
	},
	WowTtsVoice = 1,
	WowTtsSpeed = 3,
	WowTtsVolume = 50,
	WowTtsTags = true,
	joinSkuChannel = true,
	neverResetQueues = false,
	allChatViaBlizzardTts = false,
	doNotReadoutEmojis = false,
}

--------------------------------------------------------------------------------------------------------------------------------------
function CleanStringHelper(aString)
	--todo: remove multiple spaces, linebreaks, links, restrict length and other cleanup stuff










	if aString == " " then
		aString = ""
	end

	return aString
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:MenuBuilder(aParentEntry)
	BN_WHISPER = L["Battle Net whisper"]

	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Tabs"]}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.filterable = true
	tNewMenuSubEntry.BuildChildren = function(self)
		for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			local tTabEntry = SkuOptions:InjectMenuItems(self, {SkuOptions.db.profile["SkuChat"].tabs[x].name}, SkuGenericMenuItem)
			if SkuOptions.db.profile["SkuChat"].tabs[x].name == L["Combat Log"] or SkuOptions.db.profile["SkuChat"].tabs[x].name == L["Audio Log"] then
				tTabEntry.dynamic = false
				



			else
				tTabEntry.dynamic = true
				tTabEntry.filterable = true
				tTabEntry.tabIndex = x
				tTabEntry.BuildChildren = function(self)
					local tNewTabEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
					tNewTabEntry.isSelect = true
					tNewTabEntry.OnAction = function(self, aValue, aName)
						--print("OnAction Rename", "aValue", aValue, "aName", aName, self.name, self.parent.name, self.parent.tabIndex)
						PlaySound(88)
						SkuOptions.Voice:OutputStringBTtts(L["Enter name and press ENTER key"], false, true, 0.2, nil, nil, nil, 2)
						SkuOptions:EditBoxShow(" ", function(self)
							PlaySound(89)
							local tText = CleanStringHelper(SkuOptionsEditBoxEditBox:GetText())
							if tText ~= "" then
								SkuOptions.db.profile["SkuChat"].tabs[SkuOptions.currentMenuPosition.tabIndex].name = tText
								SkuChat:InitTab(SkuOptions.currentMenuPosition.tabIndex)
								SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
								SkuOptions.Voice:OutputStringBTtts(L["Umbenannt"], false, true, 0.2, nil, nil, nil, 2)
							end
						end)					
					end
					local tNewTabEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
					tNewTabEntry.isSelect = true
					tNewTabEntry.OnAction = function(self, aValue, aName)
						--print("OnAction Delete", "aValue", aValue, "aName", aName, self.name, self.parent.name)
						SkuChat:DeleteTab(self.parent.tabIndex)
						self.parent:OnUpdate(self.parent)
						SkuOptions.Voice:OutputStringBTtts(L["Deleted"], false, true, 0.2, nil, nil, nil, 2)
					end
			
					local tNewTabEntry = SkuOptions:InjectMenuItems(self, {L["set all message types and channels to inactive"]}, SkuGenericMenuItem)
					tNewTabEntry.isSelect = true
					tNewTabEntry.tabIndex = x
					tNewTabEntry.OnAction = function(self, aValue, aName)
						for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[self.tabIndex].messageTypes) do
							for u = 1, #v do
								v[u] = false
							end
						end
						for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[self.tabIndex].channels) do
							v.status = false
						end

						SkuChat:InitTab(self.tabIndex)
						self.parent:OnUpdate(self.parent)
					end

					local tNewTabEntry = SkuOptions:InjectMenuItems(self, {L["set all message types and channels to text"]}, SkuGenericMenuItem)
					tNewTabEntry.isSelect = true
					tNewTabEntry.tabIndex = x
					tNewTabEntry.OnAction = function(self, aValue, aName)
						for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[self.tabIndex].messageTypes) do
							for u = 1, #v do
								v[u] = true
							end
						end
						for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[self.tabIndex].channels) do
							v.status = true
						end

						SkuChat:InitTab(self.tabIndex)
						self.parent:OnUpdate(self.parent)
					end

					local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {L["Nachrichtentypen"]}, SkuGenericMenuItem)
					tNewMenuSubEntry.dynamic = true
					tNewMenuSubEntry.filterable = true
					tNewMenuSubEntry.BuildChildren = function(self)
						for i, v in pairs(SkuChat.ChatFrameMessageTypes) do
							if i ~= "SKU" then
								local tCatEntry = SkuOptions:InjectMenuItems(self, {_G[i]}, SkuGenericMenuItem)
								tCatEntry.dynamic = true
								tCatEntry.filterable = true
								tCatEntry.catType = i
								tCatEntry.BuildChildren = function(self)
									for w = 1, #v do
										local tName = _G[v[w].type]
										if v[w].text then
											tName = v[w].text
										end

										local tActive = SkuOptions.db.profile["SkuChat"].tabs[x].messageTypes[i][w]
										if tActive == true then
											tName = tName.." ("..L["Text"]..")"
										elseif tActive == play then
											tName = tName.." ("..L["Audio"]..")"
										else
											tName = tName.." ("..L["Inactive"]..")"
										end

										local tTypeEntry = SkuOptions:InjectMenuItems(self, {tName}, SkuGenericMenuItem)
										tTypeEntry.dynamic = true
										tTypeEntry.isSelect = true
										tTypeEntry.typeType = w
										tTypeEntry.tabIndex = x
										tTypeEntry.OnAction = function(self, aValue, aName)
											dprint("OnAction", "aValue", aValue, "aName", aName, "self.name", self.name, "self.typeType", self.typeType, "self.parent.name", self.parent.name, "self.parent.catType", self.parent.catType)
											dprint(self.parent.parent.name)

											local tNewValue = play
											if aName == L["Audio"] then
												tNewValue = play
											elseif aName == L["Text"] then
												tNewValue = true
											elseif aName == L["Inactive"] then
												tNewValue = false
											end
											
											SkuOptions.db.profile["SkuChat"].tabs[self.tabIndex].messageTypes[self.parent.catType][self.typeType] = tNewValue

											SkuChat:InitTab(self.tabIndex)

											self:OnUpdate(self)
										end
										tTypeEntry.BuildChildren = function(self)
											if tActive == play then
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Inactive"]}, SkuGenericMenuItem)
											elseif tActive == true then
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Audio"]}, SkuGenericMenuItem)
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Inactive"]}, SkuGenericMenuItem)
											else
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Audio"]}, SkuGenericMenuItem)
												local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
											end
										end
									end
								end
							end
						end
					end

					local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {L["Channels"]}, SkuGenericMenuItem)
					tNewMenuSubEntry.dynamic = true
					tNewMenuSubEntry.filterable = true
					tNewMenuSubEntry.BuildChildren = function(self)
						local tChannelList = {GetChannelList()}
						for q = 1, C_ChatInfo.GetNumActiveChannels() * 3, 3 do 
							local tNumber = ""
							local tStatus = L["Inactive"]
							local tActive = false
							local tFoundC
							for y = 1, #SkuOptions.db.profile["SkuChat"].tabs[x].channels do
								if SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].name == tChannelList[q + 1] then
									tNumber = tChannelList[q]
									if SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].status == true then
										tStatus = L["Text"]
										tActive = true
									elseif SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].status == play then
										tStatus = L["Audio"]
										tActive = play
									end
									tFoundC = true
								end
							end
							if not tFoundC then
								SkuOptions.db.profile["SkuChat"].tabs[x].channels[#SkuOptions.db.profile["SkuChat"].tabs[x].channels + 1] = {name = tChannelList[q + 1], status = false}
							end

							local tTypeEntry = SkuOptions:InjectMenuItems(self, {tNumber.."#"..tChannelList[q + 1].." ("..tStatus..")"}, SkuGenericMenuItem)
							tTypeEntry.dynamic = true
							tTypeEntry.isSelect = true
							tTypeEntry.shortName = tChannelList[q + 1] 
							tTypeEntry.tabIndex = x
							tTypeEntry.OnAction = function(self, aValue, aName)
								for y = 1, #SkuOptions.db.profile["SkuChat"].tabs[x].channels do
									if SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].name == self.shortName then
										if aName == L["Audio"] then
											SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].status = play
										elseif aName == L["Text"] then
											SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].status = true
										elseif aName == L["Inactive"] then
											SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].status = false
										end
									end
								end									

								self:OnUpdate(self)
								SkuChat:InitTab(self.tabIndex)
							end
							tTypeEntry.BuildChildren = function(self)
								if tActive == play then
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Inactive"]}, SkuGenericMenuItem)
								elseif tActive == true then
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Audio"]}, SkuGenericMenuItem)
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Inactive"]}, SkuGenericMenuItem)
								else
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Audio"]}, SkuGenericMenuItem)
									local tEDEntry = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
								end
							end
						end
					end			
					
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Audio notification on chat message"]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.isSelect = true
					tNewMenuEntry.filterable = true
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						for i, v in pairs(SkuCore.outputSoundFiles) do
							if "aura;sound#"..aName == v then
								SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage = i
							end
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						for i, v in pairs(SkuCore.outputSoundFiles) do
							tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
						end
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						for i, v in pairs(SkuCore.outputSoundFiles) do
							if SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage == i then
								return v
							end
						end
					end
					--[[
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Audio notification on chat message"]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						if aName == L["On"] then
							SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage = true
						elseif aName == L["Off"] then
							SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage = false
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["On"]}, SkuGenericMenuItem)
						tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Off"]}, SkuGenericMenuItem)
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						local tValue = L["On"]
						if SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage == true then
							tValue = L["On"]
						else
							tValue = L["Off"]
						end
						return tValue
					end
					]]
				end
			end
		end

		local tNewTabEntry = SkuOptions:InjectMenuItems(self, {L["New Tab"]}, SkuGenericMenuItem)
		tNewTabEntry.isSelect = true
		tNewTabEntry.OnAction = function(self, aValue, aName)
			--print("OnAction New Tab", "aValue", aValue, "aName", aName, self.name, self.parent.name)
			PlaySound(88)
			SkuOptions.Voice:OutputStringBTtts(L["Enter name and press ENTER key"], false, true, 0.2, nil, nil, nil, 2)
			SkuOptions:EditBoxShow(" ", function(self)
				PlaySound(89)
				local tText = CleanStringHelper(SkuOptionsEditBoxEditBox:GetText())
				if tText ~= "" then
					local tNewIndex = SkuChat:NewTab(tText)
					SkuChat:InitTab(tNewIndex)
					SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
					SkuOptions.Voice:OutputStringBTtts(L["Erstellt"], false, true, 0.2, nil, nil, nil, 2)
				end
			end)		
		end
	end


	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Filters"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.isSelect = true
	tNewMenuEntry.deleteName = nil
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		if aName == L["Add new entry"] then
			SkuOptions:EditBoxShow("", function() 
				local tText = SkuOptionsEditBoxEditBox:GetText()
				if tText and tText ~= "" then
					SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms[string.lower(tText)] = true
					C_Timer.After(0.001, function()
						SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
					end)
				end
			end,
			false,
			function() 
				SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
			end)
			C_Timer.After(0.01, function()
				SkuOptions.Voice:OutputStringBTtts(L["Enter filter term and press enter"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
			end)
		else
			if self.deleteName then
				self.deleteName = string.lower(self.deleteName)
				if SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms[self.deleteName] then
					SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms[self.deleteName] = nil
				end
			end
			C_Timer.After(0.001, function()
				SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
			end)
		end
	end
	tNewMenuEntry.BuildChildren = function(self)
		local tEntry = SkuOptions:InjectMenuItems(self, {L["Add new entry"]}, SkuGenericMenuItem)
		tEntry.OnEnter = function(self, aValue, aName)
			self.selectTarget.deleteName = nil
		end			

		for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].chatSettings.filter.terms) do
			local tEntry = SkuOptions:InjectMenuItems(self, {i}, SkuGenericMenuItem)
			tEntry.dynamic = true
			tEntry.OnEnter = function(self, aValue, aName)
				self.selectTarget.deleteName = i
			end			
			tEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
			end
		end
	end

	-- combat log
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Combat Log"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
		tEntry.dynamic = true
		tEntry.isSelect = true
		tEntry.GetCurrentValue = function(self, aValue, aName)
			if SkuOptions.db.profile["SkuChat"].CombatLog.enabled == true then
				return L["Yes"]
			else
				return L["No"]
			end
		end
		tEntry.OnAction = function(self, aValue, aName)
			if aName == L["No"] then
				SkuOptions.db.profile["SkuChat"].CombatLog.enabled = false
			elseif aName == L["Yes"] then
				SkuOptions.db.profile["SkuChat"].CombatLog.enabled = true
			end
			SkuChat:InitCombatLogTab()	
		end
		tEntry.BuildChildren = function(self)
			SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
		end		

		local tFiltersEntry = SkuOptions:InjectMenuItems(self, {L["Filters"]}, SkuGenericMenuItem)
		tFiltersEntry.dynamic = true
		tFiltersEntry.BuildChildren = function(self)
			for i, v in pairs(SkuOptions.db.global["SkuChat"].CombatLogFilters) do
				local tName = v.name .. (v.custom == true and " ("..L["custom"]..")" or "")
				if i == SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter then
					tName = tName.." ("..L["current filter"]..")"
				end

				local tFilterEntry = SkuOptions:InjectMenuItems(self, {tName}, SkuGenericMenuItem)
				tFilterEntry.dynamic = true
				tFilterEntry.BuildChildren = function(self)
					local tNewFilterEntry = SkuOptions:InjectMenuItems(self, {L["Select"]}, SkuGenericMenuItem)
					tNewFilterEntry.isSelect = true
					tNewFilterEntry.OnAction = function(self, aValue, aName)
						SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter = i
						Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
						Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)

						C_Timer.After(0.001, function()
							SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
						end)
					end

					local tEventsEntry = SkuOptions:InjectMenuItems(self, {L["Events"]}, SkuGenericMenuItem)
					tEventsEntry.dynamic = true
					tEventsEntry.BuildChildren = function(self)
						for iMainMtype, vMainMtype in pairs(SkuChat.CombatConfigMessageTypes) do
							local tEnabled = true
							for iEvent, vEvent in pairs(vMainMtype.type) do
								if v.filters[1].eventList[vEvent] ~= true then
									tEnabled = false
								end
							end
							local tMenuname = vMainMtype.text .. (tEnabled == true and " (enabled)" or "")
							local tEventEntry = SkuOptions:InjectMenuItems(self, {tMenuname}, SkuGenericMenuItem)
							tEventEntry.dynamic = true
							tEventEntry.isSelect = true
							tEventEntry.GetCurrentValue = function(self, aValue, aName)
								if tEnabled == true then
									return L["Yes"]
								else
									return L["No"]
								end
							end
							tEventEntry.OnAction = function(self, aValue, aName)
								for iEvent, vEvent in pairs(vMainMtype.type) do
									if aName == L["No"] then
										v.filters[1].eventList[vEvent] = false
										v.filters[2].eventList[vEvent] = false
									elseif aName == L["Yes"] then
										v.filters[1].eventList[vEvent] = true
										v.filters[2].eventList[vEvent] = true
									end
								end
								Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
								Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)
							
								C_Timer.After(0.001, function()
									SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
								end)								
							end
							tEventEntry.BuildChildren = function(self)
								SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
								SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
							end	
					
						end
					end

					local tEventsEntry = SkuOptions:InjectMenuItems(self, {L["Source"]}, SkuGenericMenuItem)
					tEventsEntry.dynamic = true
					tEventsEntry.BuildChildren = function(self)
						for iMainMtype, vMainMtype in pairs(SkuChat.CombatConfigUnitTypes) do
							local tEnabled = true
							if v.filters[1].sourceFlags[vMainMtype.type] ~= true then
								tEnabled = false
							end

							local tMenuname = vMainMtype.text .. (tEnabled == true and " (enabled)" or "")
							local tEventEntry = SkuOptions:InjectMenuItems(self, {tMenuname}, SkuGenericMenuItem)
							tEventEntry.dynamic = true
							tEventEntry.isSelect = true
							tEventEntry.GetCurrentValue = function(self, aValue, aName)
								if tEnabled == true then
									return L["Yes"]
								else
									return L["No"]
								end
							end
							tEventEntry.OnAction = function(self, aValue, aName)
								if aName == L["No"] then
									v.filters[1].sourceFlags[vMainMtype.type] = false
								elseif aName == L["Yes"] then
									v.filters[1].sourceFlags[vMainMtype.type] = true
								end
								Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
								Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)
							
								C_Timer.After(0.001, function()
									SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
								end)								
							end
							tEventEntry.BuildChildren = function(self)
								SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
								SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
							end	
					
						end
					end

					local tEventsEntry = SkuOptions:InjectMenuItems(self, {L["Destination"]}, SkuGenericMenuItem)
					tEventsEntry.dynamic = true
					tEventsEntry.BuildChildren = function(self)
						for iMainMtype, vMainMtype in pairs(SkuChat.CombatConfigUnitTypes) do
							local tEnabled = true
							if v.filters[2].destFlags[vMainMtype.type] ~= true then
								tEnabled = false
							end

							local tMenuname = vMainMtype.text .. (tEnabled == true and " (enabled)" or "")
							local tEventEntry = SkuOptions:InjectMenuItems(self, {tMenuname}, SkuGenericMenuItem)
							tEventEntry.dynamic = true
							tEventEntry.isSelect = true
							tEventEntry.GetCurrentValue = function(self, aValue, aName)
								if tEnabled == true then
									return L["Yes"]
								else
									return L["No"]
								end
							end
							tEventEntry.OnAction = function(self, aValue, aName)
								if aName == L["No"] then
									v.filters[2].destFlags[vMainMtype.type] = false
								elseif aName == L["Yes"] then
									v.filters[2].destFlags[vMainMtype.type] = true
								end
								Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
								Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)
							
								C_Timer.After(0.001, function()
									SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
								end)								
							end
							tEventEntry.BuildChildren = function(self)
								SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
								SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
							end	
					
						end
					end

					if i > 3 then
						local tNewFilterEntry = SkuOptions:InjectMenuItems(self, {L["Delete this filter"]}, SkuGenericMenuItem)
						tNewFilterEntry.isSelect = true
						tNewFilterEntry.OnAction = function(self, aValue, aName)
							SkuOptions.db.global["SkuChat"].CombatLogFilters[i] = nil

							if SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter == i then
								SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter = 1
							end
							
							Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
							Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)

							C_Timer.After(0.001, function()
								SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition)
							end)
						end
					end

				end
			end

			local tNewFilterEntry = SkuOptions:InjectMenuItems(self, {L["Add new filter"]}, SkuGenericMenuItem)
			tNewFilterEntry.isSelect = true
			tNewFilterEntry.OnAction = function(self, aValue, aName)
				SkuOptions:EditBoxShow(
					"",
					function(self)
						local tFilterName = SkuOptionsEditBoxEditBox:GetText()
						if tFilterName and tFilterName ~= "" then
							table.insert(SkuOptions.db.global["SkuChat"].CombatLogFilters, {
								custom = true,
								name = tFilterName,
								hasQuickButton = true,
								quickButtonName = tFilterName,
								quickButtonDisplay = {
									solo = true,
									party = true,
									raid = true,
								},
								tooltip = tFilterName,
								settings = CopyTable(COMBATLOG_DEFAULT_SETTINGS),
								colors = CopyTable(COMBATLOG_DEFAULT_COLORS),
								filters = {
									[1] = {
										eventList = Blizzard_CombatLog_GenerateFullEventList(),
										sourceFlags = {
											--[COMBATLOG_FILTER_ME] = true,
											[COMBATLOG_FILTER_MINE] = true,
											[COMBATLOG_FILTER_MY_PET] = true,
											[COMBATLOG_FILTER_FRIENDLY_UNITS] = true,
											[COMBATLOG_FILTER_HOSTILE_PLAYERS] = true,
											[COMBATLOG_FILTER_HOSTILE_UNITS] = true,
											[COMBATLOG_FILTER_NEUTRAL_UNITS] = true,
											[COMBATLOG_FILTER_UNKNOWN_UNITS] = true,
											--[COMBATLOG_FILTER_EVERYTHING] = false,
										},
									},
									[2] = {
										eventList = Blizzard_CombatLog_GenerateFullEventList(),
										destFlags = {
											--[COMBATLOG_FILTER_ME] = true,
											[COMBATLOG_FILTER_MINE] = true,
											[COMBATLOG_FILTER_MY_PET] = true,
											[COMBATLOG_FILTER_FRIENDLY_UNITS] = true,
											[COMBATLOG_FILTER_HOSTILE_PLAYERS] = true,
											[COMBATLOG_FILTER_HOSTILE_UNITS] = true,
											[COMBATLOG_FILTER_NEUTRAL_UNITS] = true,
											[COMBATLOG_FILTER_UNKNOWN_UNITS] = true,
											--[COMBATLOG_FILTER_EVERYTHING] = false,
										},
									},				
								},
							})
			
							Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
							Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)
						
							C_Timer.After(0.001, function()
								SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
							end)			
						end
					end,
					nil
				)
				PlaySound(89)
				C_Timer.After(0.1, function()
					SkuOptions.Voice:OutputStringBTtts(L["Enter name and press ENTER key"], true, true, 1, true)
				end)

			end			
		end
	end

	--audio log
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Audio Log"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
		tEntry.dynamic = true
		tEntry.isSelect = true
		tEntry.GetCurrentValue = function(self, aValue, aName)
			if SkuOptions.db.profile["SkuChat"].AudioLog.enabled == true then
				return L["Yes"]
			else
				return L["No"]
			end
		end
		tEntry.OnAction = function(self, aValue, aName)
			if aName == L["No"] then
				SkuOptions.db.profile["SkuChat"].AudioLog.enabled = false
			elseif aName == L["Yes"] then
				SkuOptions.db.profile["SkuChat"].AudioLog.enabled = true
			end
			SkuChat:InitAudioLogTab()
		end
		tEntry.BuildChildren = function(self)
			SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
		end	
	end


	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
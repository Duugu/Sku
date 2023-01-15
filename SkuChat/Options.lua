local MODULE_NAME = "SkuChat"

local L = Sku.L
local play = 2	--this is just a local constant for output type (play, true, false)

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
									tTab.messageTypes["PLAYER_MESSAGES"][6] = true
									tTab.messageTypes["PLAYER_MESSAGES"][7] = true
									tTab.messageTypes["CREATURE_MESSAGES"][4] = true
									tTab.messageTypes["CREATURE_MESSAGES"][6] = true		
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
		audioOnNewMessage = true,
		audioOnMessageEnd = false,
	},
	WowTtsVoice = 1,
	WowTtsSpeed = 3,
	WowTtsVolume = 50,
	WowTtsTags = true,
	joinSkuChannel = true,
	neverResetQueues = false,
	allChatViaBlizzardTts = false,
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

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
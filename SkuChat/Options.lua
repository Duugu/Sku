local MODULE_NAME = "SkuChat"

	local L = Sku.L
	
	SkuChat.WowTtsVoices = {
	[1] = L["def Microsoft Hedda Desktop - German"],
}


SkuChat.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
			order = 1,
			name = L["Module enabled"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].enable = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].enable
			end,
		},
		audioSettings = {
			name = L["Audio-Settings"],
			order = 2,
			type = "group",
			args = {
				audioOnNewMessage = {
					name = L["Audio notification on chat message"],
					order = 1,
					type = "toggle",
					desc = L["Enables / disables audio on new line"],
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].audioSettings.audioOnNewMessage = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].audioSettings.audioOnNewMessage
					end,
				},
				audioOnMessageEnd = {
					name = L["Audio notification on the end of chat messages"],
					desc = L["Controls whether a sound is played at the end of a chat message."],
					order = 2,
					type = "toggle",
					set = function(info,val)
						--print("val:", SkuOptions.db.profile[MODULE_NAME].audio.audioOnNewMessage, "tts-setting:", C_TTSSettings.GetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks))
						C_TTSSettings.SetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks, val)
					end,
					get = function(info) 
						return C_TTSSettings.GetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks)
					end,
					OnAction = function() 
							C_TTSSettings.SetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks, SkuOptions.db.profile[MODULE_NAME].audioSettings.audioOnMessageEnd)
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





		autoPlaySettings = {
			name = L["auto play Settings"],
			order = 6,
			type = "group",
			args = {

				autoPlayPartyChat = {
					order = 1,
					name = L["Gruppen Chat automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayPartyChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayPartyChat
					end,
				},
				autoPlayGuildChat = {
					order = 2,
					name = L["Gilden Chat automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayGuildChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayGuildChat
					end,
				},
				autoPlayTellChat = {
					order = 3,
					name = L["Flüster Chat automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayTellChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayTellChat
					end,
				},
				autoPlayCreatureChat = {
					order = 4,
					name = L["Chat von kreaturen automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayCreatureChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayCreatureChat
					end,
				},
				autoPlaySkuChannelChat = {
					order = 5,
					name = L["SkuChat automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlaySkuChannelChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlaySkuChannelChat
					end,
				},		
				autoPlayRaidChat = {
					order = 5,
					name = L["Raid Chat automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayRaidChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayRaidChat
					end,
				},		
				autoPlayRaidWarningChat = {
					order = 5,
					name = L["Raid Warnung automatisch lesen"],
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayRaidWarningChat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].autoPlaySettings.autoPlayRaidWarningChat
					end,
				},		
			},
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
				SkuChat:JoinOrLeaveSkuChatChannel()
			end,
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuChat.defaults = {
	enable = true,
	audioSettings  = {
		audioOnNewMessage = true,
		audioOnMessageEnd = false,
	},
	WowTtsVoice = 1,
	WowTtsSpeed = 3,
	WowTtsVolume = 50,
	WowTtsTags = true,
	autoPlaySettings = {
		autoPlayPartyChat = true,
		autoPlayGuildChat = true,
		autoPlayTellChat = true,
		autoPlayCreatureChat = true,
		autoPlaySkuChannelChat = true,
		autoPlayRaidChat = true,
		autoPlayRaidWarningChat = true,
	},
	joinSkuChannel = true,
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:MenuBuilder(aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end



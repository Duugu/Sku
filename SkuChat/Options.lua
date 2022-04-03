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
		autoPlayPartyChat = {
			order = 6,
			name = L["Gruppen Chat automatisch lesen"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayPartyChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayPartyChat
			end,
		},
		autoPlayGuildChat = {
			order = 6,
			name = L["Gilden Chat automatisch lesen"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayGuildChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayGuildChat
			end,
		},
		autoPlayTellChat = {
			order = 6,
			name = L["Flüster Chat automatisch lesen"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayTellChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayTellChat
			end,
		},
		autoPlayCreatureChat = {
			order = 6,
			name = L["Chat von kreaturen automatisch lesen"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayCreatureChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayCreatureChat
			end,
		},
		autoPlaySkuChannelChat = {
			order = 6,
			name = L["SkuChat automatisch lesen"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlaySkuChannelChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlaySkuChannelChat
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
	autoPlayPartyChat = true,
	autoPlayGuildChat = false,
	autoPlayTellChat = true,
	autoPlayCreatureChat = false,
	autoPlaySkuChannelChat = true,
	joinSkuChannel = true,
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:MenuBuilder(aParentEntry)
	--dprint("SkuChat:MenuBuilderTest", aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end



local MODULE_NAME = "SkuChat"
local L = Sku.L

SkuChat.WowTtsVoices = {
	[1] = "def Microsoft Hedda Desktop - German",
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
			end
		},
		audio = {
			order = 2,
			name = L["Audio notification on chat message"],
			desc = L["Enables / disables audio on new chat line"],
			type = "toggle",
			set = function(info,val) 
				SkuOptions.db.profile[MODULE_NAME].audio = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].audio
			end
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
			end
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
			end
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
			end
		},
		autoPlayPartyChat = {
			order = 6,
			name = "Gruppen Chat automatisch lesen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayPartyChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayPartyChat
			end
		},
		autoPlayGuildChat = {
			order = 6,
			name = "Gilden Chat automatisch lesen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayGuildChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayGuildChat
			end
		},
		autoPlayTellChat = {
			order = 6,
			name = "Flüster Chat automatisch lesen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayTellChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayTellChat
			end
		},
		autoPlayCreatureChat = {
			order = 6,
			name = "Chat von kreaturen automatisch lesen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoPlayCreatureChat = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoPlayCreatureChat
			end
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuChat.defaults = {
	enable = true,
	audio = false,
	WowTtsVoice = 1,
	WowTtsSpeed = 3,
	WowTtsVolume = 50,
	autoPlayPartyChat = true,
	autoPlayGuildChat = false,
	autoPlayTellChat = false,
	autoPlayCreatureChat = false,
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:MenuBuilder(aParentEntry)
	--dprint("SkuChat:MenuBuilderTest", aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end



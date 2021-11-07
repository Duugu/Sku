local MODULE_NAME = "SkuChat"

SkuChat.WowTtsVoices = {
	[1] = "def Microsoft Hedda Desktop - German",
}


SkuChat.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
			order = 1,
			name = "Modul aktiviert" ,
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
			name = "Audiomeldung bei Chatnachricht" ,
			desc = "Enables / disables audio on new chat line",
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
			name = "TTS Stimme" ,
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
			name = "TTS Geschwindigkeit" ,
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
			name = "TTS Lautstärke" ,
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].WowTtsVolume = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].WowTtsVolume
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
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:MenuBuilder(aParentEntry)
	--print("SkuChat:MenuBuilderTest", aParentEntry)

	--optionen
	--to add: ace slider, dropdown widgets
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Optionen"}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuChat.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])

end



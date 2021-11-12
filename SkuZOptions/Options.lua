local MODULE_NAME = "SkuOptions"
local L = Sku.L

SkuOptions.options = {
	name = MODULE_NAME,
	handler = SkuOptions,
	type = "group",
	args = {
		vocalizeMenuNumbers = {
			order = 1,
			name = "Menünummern ansagen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].vocalizeMenuNumbers = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].vocalizeMenuNumbers
			end
		},
		vocalizeSubmenus = {
			order = 2,
			name = "Untermenüs ansagen" ,
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].vocalizeSubmenus = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].vocalizeSubmenus
			end
		},
		TTSSepPause = {
			order = 3,
			name = "Audio Dauer Pause" ,
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].TTSSepPause = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].TTSSepPause
			end
		},
		backgroundSound = {
			order = 4,
			name = "Hintergrund Audio" ,
			desc = "",
			type = "select",
			values = SkuOptions.BackgroundSoundFiles,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].backgroundSound = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].backgroundSound
			end
		},
		localActive = {
			order = 5,
			name = "Lokal aktiv" ,
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].localActive = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].localActive
			end
		},
		visualAudioMenu = {
			order = 6,
			name = "Audio Menü visuell" ,
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile["SkuOptions"].visualAudioMenu = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].visualAudioMenu
			end
		},
		soundChannels={
			name = "Audio-Kanäle",
			type = "group",
			order = 4,
			args= {
					MasterVolume = {
						order = 2,
						name = "Gesamt Lautstärke" ,
						desc = "",
						type = "range",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.MasterVolume = val
							BlizzardOptionsPanel_SetCVarSafe("Sound_MasterVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.MasterVolume / 100)
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.MasterVolume
						end
					},
					SFXVolume = {
						order = 3,
						name = "Soundeffekte Lautstärke" ,
						desc = "",
						type = "range",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.SFXVolume = val
							BlizzardOptionsPanel_SetCVarSafe("Sound_SFXVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.SFXVolume / 100)
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.SFXVolume
						end
					},
					MusicVolume = {
						order = 5,
						name = "Musik Lautstärke" ,
						desc = "",
						type = "range",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.MusicVolume = val
							BlizzardOptionsPanel_SetCVarSafe("Sound_MusicVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.MusicVolume / 100)
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.MusicVolume
						end
					},
					AmbienceVolume = {
						order = 4,
						name = "Umgebung Lautstärke" ,
						desc = "",
						type = "range",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.AmbienceVolume = val
							BlizzardOptionsPanel_SetCVarSafe("Sound_AmbienceVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.AmbienceVolume / 100)
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.AmbienceVolume
						end
					},
					DialogVolume = {
						order = 6	,
						name = "Dialog Lautstärke" ,
						desc = "",
						type = "range",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.DialogVolume = val
							BlizzardOptionsPanel_SetCVarSafe("Sound_DialogVolume", SkuOptions.db.profile["SkuOptions"].soundChannels.DialogVolume / 100)
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.DialogVolume
						end
					},
					SkuChannel = {
						order = 1,
						name = "Sku Kanal" ,
						desc = "",
						type = "select",
						values = SKU_KONSTANTS.SOUNDCHANNELS,
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].soundChannels.SkuChannel = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].soundChannels.SkuChannel
						end
					},
				},
			},
			debugOptions={
				name = "Debug Optionen",
				type = "group",
				order = 4,
				args= {
					soundOnError = {
						order = 2,
						name = "Sound bei Fehler" ,
						desc = "",
						type = "toggle",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].debugOptions.soundOnError = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].debugOptions.soundOnError
						end
					},
					showError = {
						order = 2,
						name = "Fehler anzeigen" ,
						desc = "",
						type = "execute",
						set = function(info,val)
							--SkuOptions.db.profile[MODULE_NAME].debugOptions.showError = val
						end,
						get = function(info)
							--return SkuOptions.db.profile[MODULE_NAME].debugOptions.showError
						end,
						func = function(info,val)
							SkuOpenSack()
						end,
					},
				},
			},
	
		allModules={
			name = "Schnellwahl",
			type = "group",
			order = 5,
			args={
					MenuQuickSelect1 = {
						order = 1,
						name = "Schnellwahl 1" ,
						desc = "",
						type = "input",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect1 = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect1
						end
					},
					MenuQuickSelect2 = {
						order = 2,
						name = "Schnellwahl 2" ,
						desc = "",
						type = "input",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect2 = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect2
						end
					},
					MenuQuickSelect3 = {
						order = 3,
						name = "Schnellwahl 3" ,
						desc = "",
						type = "input",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect3 = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect3
						end
					},
					MenuQuickSelect4 = {
						order = 4,
						name = "Schnellwahl 4" ,
						desc = "",
						type = "input",
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect4 = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].allModules.MenuQuickSelect4
						end
					},
				},
			},
		},
}
---------------------------------------------------------------------------------------------------------------------------------------
SkuOptions.defaults = {
	vocalizeMenuNumbers = false,
	vocalizeSubmenus = false,
	TTSSepPause = 85,
	backgroundSound = "silence.mp3",
	localActive = true,
	visualAudioMenu = false,
	allModules  = {
		MenuQuickSelect1 = "SkuNav,Wegpunkt,Auswählen,Aktuelle Karte Entfernung",
		MenuQuickSelect2 = "SkuNav,Route,Route folgen,Ziele Entfernung",
		MenuQuickSelect3 = "SkuNav,Alles abwählen",
		MenuQuickSelect4 = "SkuNav,Route",
		},
	soundChannels  = {
		MasterVolume = -1, --this is to check if the profile has sound settings. take the current blizz settings, if not.
		SFXVolume = 100,
		MusicVolume = 100,
		AmbienceVolume = 100,
		DialogVolume = 100,
		SkuChannel = "Talking Head",
		},
	debugOptions = {
		soundOnError = false,
		showError = "fehler anzeigen default",
		},
	}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:MenuBuilder(aParentEntry)
	--print("SkuOptions:MenuBuilder", aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuOptions.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(tNewMenuEntry, {"Profil"}, menuEntryTemplate_Menu)
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Auswählen"}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:SetProfile(aName)
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tList = SkuOptions.db:GetProfiles()
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tList, menuEntryTemplate_Menu)
	end
	tNewMenuSubEntry.GetCurrentValue = function(self, aValue, aName)
		return SkuOptions.db:GetCurrentProfile()
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {L["New"]}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		--SkuOptions.db:New(aName)
		--https://www.wowace.com/projects/ace3/pages/api/ace-db-3-0
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Kopieren von"}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:CopyProfile(aName, true)
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tList = SkuOptions.db:GetProfiles()
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tList, menuEntryTemplate_Menu)
	end
	tNewMenuSubEntry.GetCurrentValue = function(self, aValue, aName)
		return SkuOptions.db:GetCurrentProfile()
	end

	--[[
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Löschen"}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		--SkuOptions.db:DeleteProfile(name, silent)
	end
	]]
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Zurücksetzen"}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		print(SkuOptions.db:ResetProfile())
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuEntry, {"Fehlende Audio Wörter kopieren"}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		if SkuOptions.db.realm then
			if SkuOptions.db.realm.missingAudio then
				local tText = ""
				if SkuOptions.db.realm.missingAudio then
					for i, v in pairs(SkuOptions.db.realm.missingAudio) do 
						tText = tText..i.."\r\n"
					end
				end
				PlaySound(88)
				SkuOptions.Voice:OutputString("Jetzt wort liste mit Steuerung plus C kopieren und Escape drücken", true, true, 0.2)-- file: string, reset: bool, wait: bool, length: int										
				SkuOptions:EditBoxShow(tText, function(self) PlaySound(89) end)
				SkuOptions.db.realm.missingAudio = {}
			end
		end
	end

end

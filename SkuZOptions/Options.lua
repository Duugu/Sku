local MODULE_NAME = "SkuOptions"
local L = Sku.L

SkuOptions.options = {
	name = MODULE_NAME,
	handler = SkuOptions,
	type = "group",
	args = {
		vocalizeMenuNumbers = {
			order = 1,
			name = L["Menünummern ansagen"],
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
			name = L["Untermenüs ansagen"] ,
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
			name = L["Audio Dauer Pause"] ,
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
			name = L["Hintergrund Audio"] ,
			desc = "",
			type = "select",
			values = SkuCore.BackgroundSoundFiles,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].backgroundSound = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].backgroundSound
			end
		},
		localActive = {
			order = 5,
			name = L["Lokal aktiv"] ,
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].localActive = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].localActive
			end
		},
		useBlizzTtsInMenu = {
			order = 6,
			name = L["Use Blizzard TTS for audio menu"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile["SkuOptions"].useBlizzTtsInMenu = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].useBlizzTtsInMenu
			end
		},
		soundChannels={
			name = L["Audio-Kanäle"],
			type = "group",
			order = 4,
			args= {
					MasterVolume = {
						order = 2,
						name = L["Gesamt Lautstärke"] ,
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
						name = L["Soundeffekte Lautstärke"] ,
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
						name = L["Musik Lautstärke"] ,
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
						name = L["Umgebung Lautstärke"] ,
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
						name = L["Dialog Lautstärke"] ,
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
						name = L["Sku Kanal"] ,
						desc = "",
						type = "select",
						values = SKU_CONSTANTS.SOUNDCHANNELS,
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
			name = L["Debug Optionen"],
			type = "group",
			order = 4,
			args= {
				soundOnError = {
					order = 2,
					name = L["Sound bei Fehler"] ,
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
					name = L["Fehler anzeigen"] ,
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
			name = L["Schnellwahl"],
			type = "group",
			order = 5,
			args={
					MenuQuickSelect1 = {
						order = 1,
						name = L["Schnellwahl 1"] ,
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
						name = L["Schnellwahl 2"] ,
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
						name = L["Schnellwahl 3"] ,
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
						name = L["Schnellwahl 4"] ,
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
	vocalizeMenuNumbers = true,
	vocalizeSubmenus = true,
	TTSSepPause = 85,
	backgroundSound = "silence.mp3",
	localActive = true,
	visualAudioMenu = false,
	useBlizzTtsInMenu = false,
	allModules  = {
		MenuQuickSelect1 = L["SkuNav,Wegpunkt,Auswählen,Aktuelle Karte Entfernung"],
		MenuQuickSelect2 = L["SkuNav,Route,Route folgen,Ziele Entfernung"],
		MenuQuickSelect3 = L["SkuCore,Aktionsleisten"],
		MenuQuickSelect4 = L["SkuNav,Alles abwählen"],
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
		showError = L["fehler anzeigen default"],
		},
	}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:MenuBuilder(aParentEntry)
	--dprint("SkuOptions:MenuBuilder", aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuOptions.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(tNewMenuEntry, {L["Profil"]}, SkuGenericMenuItem)
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {L["Auswählen"]}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:SetProfile(aName)
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tList = SkuOptions.db:GetProfiles()
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tList, SkuGenericMenuItem)
	end
	tNewMenuSubEntry.GetCurrentValue = function(self, aValue, aName)
		return SkuOptions.db:GetCurrentProfile()
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {L["New"]}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		--SkuOptions.db:New(aName)
		--https://www.wowace.com/projects/ace3/pages/api/ace-db-3-0
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {L["Kopieren von"]}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:CopyProfile(aName, true)
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tList = SkuOptions.db:GetProfiles()
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tList, SkuGenericMenuItem)
	end
	tNewMenuSubEntry.GetCurrentValue = function(self, aValue, aName)
		return SkuOptions.db:GetCurrentProfile()
	end

	--[[
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Löschen"}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		--SkuOptions.db:DeleteProfile(name, silent)
	end
	]]
	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {L["Zurücksetzen"]}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:ResetProfile()
		SkuOptions.db.char["SkuCore"] = {}
		SkuOptions.db.char["SkuCore"].RangeChecks = {
			Friendly = {},
			Hostile = {},
			Misc = {},
		}
		SkuOptions:OnProfileReset()
	end

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuEntry, {L["Fehlende Audio Wörter kopieren"]}, SkuGenericMenuItem)
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
				SkuOptions.Voice:OutputString(L["Jetzt wort liste mit Steuerung plus C kopieren und Escape drücken"], true, true, 0.2)										
				SkuOptions:EditBoxShow(tText, function(self) PlaySound(89) end)
				SkuOptions.db.realm.missingAudio = {}
			end
		end
	end

end

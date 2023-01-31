local MODULE_NAME = "SkuOptions"
local L = Sku.L


SkuCore.SoftTargetingArcValues = {
	[0] = L["Only directly in front"],
	[1] = L["15 degrees in front"],
	[2] = L["180 degrees in front"],
}
SkuCore.SofttargetingForceValues  = {
	[0] = L["Off"],
	[1] = L["Enemies"],
	[2] = L["Friends"],
}
SkuCore.SofttargetingMatchLockedValues  = {
	[0] = L["Always"],
	[1] = L["If no hard target locked"],
	[2] = L["No attackable hard target locked"],
	--[2] = L["Targets you attack"],
}
SkuCore.SofttargetingInteractNameForValues  = {
	[1] = L["Nothing"],
	[2] = L["Objects"],
	[3] = L["Objects and lootable/skinnable"],
	[4] = L["Objects and lootable/skinnable and units"],
}
do
	SkuCore.SofttargetingSoundsValue = {}
	SkuCore.SofttargetingSoundsValue[" "] = L["silent"]
	for i, v in pairs (SkuAuras.outputSoundFiles) do
		SkuCore.SofttargetingSoundsValue[i] = v
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
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
		--[[
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
		]]
		soundChannels={
			name = L["Audio-Kanäle"],
			type = "group",
			order = 6,
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
						order = 6,
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
						order = 7	,
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
						order = 8,
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
		soundSettings={
			name = L["Sound Settings"],
			type = "group",
			order = 7,
			args= {
				Sound_EnableReverb = {
					order = 1,
					name = L["Reverb"],
					desc = "",
					type = "toggle",
					OnAction = function(self, info, val)
						if val == true then
							C_CVar.SetCVar("Sound_EnableReverb", 1)
						else
							C_CVar.SetCVar("Sound_EnableReverb", 0)
						end
					end,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableReverb = val
						if val == true then
							C_CVar.SetCVar("Sound_EnableReverb", 1)
						else
							C_CVar.SetCVar("Sound_EnableReverb", 0)
						end
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableReverb
					end
				},
				Sound_EnablePositionalLowPassFilter = {
					order = 2,
					name = L["Positional Low Pass Filter"],
					desc = "",
					type = "toggle",
					OnAction = function(self, info, val)
						if val == true then
							C_CVar.SetCVar("Sound_EnablePositionalLowPassFilter", 1)
						else
							C_CVar.SetCVar("Sound_EnablePositionalLowPassFilter", 0)
						end
					end,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnablePositionalLowPassFilter = val
						if val == true then
							C_CVar.SetCVar("Sound_EnablePositionalLowPassFilter", 1)
						else
							C_CVar.SetCVar("Sound_EnablePositionalLowPassFilter", 0)
						end
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnablePositionalLowPassFilter
					end
				},
				Sound_EnableDSPEffects = {
					order = 3,
					name = L["DSP Effects"],
					desc = "",
					type = "toggle",
					OnAction = function(self, info, val)
						if val == true then
							C_CVar.SetCVar("Sound_EnableDSPEffects", 1)
						else
							C_CVar.SetCVar("Sound_EnableDSPEffects", 0)
						end
					end,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableDSPEffects = val
						if val == true then
							C_CVar.SetCVar("Sound_EnableDSPEffects", 1)
						else
							C_CVar.SetCVar("Sound_EnableDSPEffects", 0)
						end
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableDSPEffects
					end
				},
				Sound_EnableSoundWhenGameIsInBG = {
					order = 4,
					name = L["Sound When Game Is In Background"],
					desc = "",
					type = "toggle",
					OnAction = function(self, info, val)
						if val == true then
							C_CVar.SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)
						else
							C_CVar.SetCVar("Sound_EnableSoundWhenGameIsInBG", 0)
						end
					end,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableSoundWhenGameIsInBG = val
						if val == true then
							C_CVar.SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)
						else
							C_CVar.SetCVar("Sound_EnableSoundWhenGameIsInBG", 0)
						end
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_EnableSoundWhenGameIsInBG
					end
				},
				Sound_ZoneMusicNoDelay = {
					order = 5,
					name = L["Zone Music No Delay"],
					desc = "",
					type = "toggle",
					OnAction = function(self, info, val)
						if val == true then
							C_CVar.SetCVar("Sound_ZoneMusicNoDelay", 1)
						else
							C_CVar.SetCVar("Sound_ZoneMusicNoDelay", 0)
						end
					end,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_ZoneMusicNoDelay = val
						if val == true then
							C_CVar.SetCVar("Sound_ZoneMusicNoDelay", 1)
						else
							C_CVar.SetCVar("Sound_ZoneMusicNoDelay", 0)
						end
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].soundSettings.Sound_ZoneMusicNoDelay
					end
				},
			},
		},

						
		debugOptions={
			name = L["Debug Optionen"],
			type = "group",
			order = 8,
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
				--[[
				showError = {
					order = 3,
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
						if SkuOpenSack then
							SkuOpenSack()
						else
							print("bugsack addon not installed")
						end
					end,
				},
				]]
			},
		},
	
		allModules={
			name = L["Schnellwahl"],
			type = "group",
			order = 9,
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
			softTargeting={
				name = L["Soft targeting"],
				type = "group",
				order = 10,
				args= {
					enemy={
						name = L["Enemies"],
						type = "group",
						order = 1,
						args= {
							enabled = {
								order = 1,
								name = L["Enabled"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.enabled = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.enabled
								end
							},
							arc = {
								order = 2,
								name = L["Arc"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SoftTargetingArcValues,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.arc = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.arc
								end
							},							
							range = {
								order = 3,
								name = L["Range"] ,
								desc = "",
								type = "range",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								min = 1,
								max = 60,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.range = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.range
								end
							},		
							forPlayers = {
								order = 4,
								name = L["Include players"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPlayers = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPlayers
								end
							},
							forPets = {
								order = 5,
								name = L["Include pets"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPets = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPets
								end
							},							
							forPassive = {
								order = 5,
								name = L["Include passive units"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPassive = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.forPassive
								end
							},
							sound = {
								order = 6,
								name = L["sound"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SofttargetingSoundsValue,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.sound = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.sound
								end
							},									
							outputName = {
								order = 7,
								name = L["Output unit name"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.outputName = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.enemy.outputName
								end
							},

						},
					},
					friend={
						name = L["Friends"],
						type = "group",
						order = 2,
						args= {
							enabled = {
								order = 1,
								name = L["Enabled"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.enabled = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.enabled
								end
							},
							arc = {
								order = 2,
								name = L["Arc"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SoftTargetingArcValues,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.arc = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.arc
								end
							},							
							range = {
								order = 3,
								name = L["Range"] ,
								desc = "",
								type = "range",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								min = 1,
								max = 60,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.range = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.range
								end
							},		
							forPlayers = {
								order = 4,
								name = L["Include players"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.forPlayers = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.forPlayers
								end
							},
							forPets = {
								order = 5,
								name = L["Include pets"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.forPets = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.forPets
								end
							},
							sound = {
								order = 6,
								name = L["sound"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SofttargetingSoundsValue,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.sound = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.sound
								end
							},								
							outputName = {
								order = 7,
								name = L["Output unit name"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.outputName = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.friend.outputName
								end
							},													
						},
					},
					interact={
						name = L["Interact"],
						type = "group",
						order = 3,
						args= {
							enabled = {
								order = 1,
								name = L["Enabled"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.enabled = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.enabled
								end
							},
							arc = {
								order = 2,
								name = L["Arc"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SoftTargetingArcValues,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.arc = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.arc
								end
							},							
							range = {
								order = 3,
								name = L["Range"] ,
								desc = "",
								type = "range",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								min = 1,
								max = 15,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.range = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.range
								end
							},		
							soundfor = {
								order = 4,
								name = L["Output sound for"],
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SofttargetingInteractNameForValues,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.soundfor = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.soundfor
								end
							},				
							sound = {
								order = 5,
								name = L["sound"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SofttargetingSoundsValue,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.sound = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.sound
								end
							},											
							unitNameFor = {
								order = 6,
								name = L["Output name for"] ,
								desc = "",
								type = "select",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								values = SkuCore.SofttargetingInteractNameForValues,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.unitNameFor = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.unitNameFor
								end
							},							

							outputBTTS = {
								order = 8,
								name = L["Name output via Blizzard TTS"] ,
								desc = "",
								type = "toggle",
								OnAction = function(self, info, val)
									SkuOptions:UpdateSoftTargetingSettings("all")
								end,
								set = function(info,val)
									SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.outputBTTS = val
								end,
								get = function(info)
									return SkuOptions.db.profile[MODULE_NAME].softTargeting.interact.outputBTTS
								end
							},									
						},
					},
					force = {
						order = 5,
						name = L["Auto set hard target to soft target for"] ,
						desc = "",
						type = "select",
						OnAction = function(self, info, val)
							SkuOptions:UpdateSoftTargetingSettings("all")
						end,
						values = SkuCore.SofttargetingForceValues,
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].softTargeting.force = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].softTargeting.force
						end
					},							
					matchLocked = {
						order = 6,
						name = L["Do interact soft targeting if"],
						desc = "",
						type = "select",
						OnAction = function(self, info, val)
							SkuOptions:UpdateSoftTargetingSettings("all")
						end,
						values = SkuCore.SofttargetingMatchLockedValues,
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].softTargeting.matchLocked = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].softTargeting.matchLocked
						end
					},		
					enableDisableOutputInChat = {
						order = 7,
						name = L["Chat notification on enabling/disabling soft targeting categories"] ,
						desc = "",
						type = "toggle",
						OnAction = function(self, info, val)
							SkuOptions:UpdateSoftTargetingSettings("all")
						end,
						set = function(info,val)
							SkuOptions.db.profile[MODULE_NAME].softTargeting.enableDisableOutputInChat = val
						end,
						get = function(info)
							return SkuOptions.db.profile[MODULE_NAME].softTargeting.enableDisableOutputInChat
						end
					},									

				}
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
	--useBlizzTtsInMenu = false,
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
	soundSettings  = {
		Sound_EnableReverb = false, --this is to check if the profile has sound settings. take the current blizz settings, if not.
		Sound_EnablePositionalLowPassFilter = false,
		Sound_EnableDSPEffects = false,
		Sound_EnableSoundWhenGameIsInBG = false,
		Sound_ZoneMusicNoDelay = false,
		},
	softTargeting = {
		enemy = {
			enabled = false,
			arc = 1,
			range = 60,
			forPassive = true,
			forPlayers = false,
			forPets = false,
			sound = "sound-waterdrop4",
			outputName = true,
		},
		friend = {
			enabled = false,
			arc = 1,
			range = 60,
			forPlayers = false,
			forPets = false,
			sound = "sound-waterdrop4",
			outputName = true,
		},
		interact = {
			enabled = true,
			arc = 2,
			range = 15,
			soundfor = 3,
			unitNameFor = 3,
			sound = "sound-waterdrop4",
			outputBTTS = true,
		},
		force = 0, --0 1 2 target wird softtarget 		Auto-set target to match soft target. 1 = for enemies, 2 = for friends
		matchLocked = 2, --0 1 softtarget immer locked wenn target 2?	Match appropriate soft target to locked target. 1 = hard locked target only, 2 = for targets you attack
		enableDisableOutputInChat = true,
	},		
	debugOptions = {
		soundOnError = false,
		showError = L["fehler anzeigen default"],
		},
	}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:MenuBuilder(aParentEntry)
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuOptions.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])


	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(tNewMenuEntry, {L["Overview pages"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		for q = 1, 2 do
			local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(self, {L["Overview page "]..q}, SkuGenericMenuItem)
			tNewMenuParentEntry.dynamic = true
			tNewMenuParentEntry.isSelect = true
			tNewMenuParentEntry.pageId = nil
			tNewMenuParentEntry.tEntry = nil
			tNewMenuParentEntry.OnAction = function(self, aValue, aName)
				local tlName, tPos = string.split(";", self.tEntry)
				for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections) do
					if v.locName == tlName then
						if aName == L["Up"] then
							for i1, v1 in pairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections) do
								if v1.pos == (tonumber(tPos) - 1) then
									v1.pos = tonumber(tPos)
									SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections[i].pos = tonumber(tPos) - 1
									break
								end
							end
						elseif aName == L["Down"] then
							for i1, v1 in pairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections) do
								if v1.pos == (tonumber(tPos) + 1) then
									v1.pos = tonumber(tPos)
									SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections[i].pos = tonumber(tPos) + 1
									break
								end
							end
						elseif aName == L["Show"] then
							local tMax = 0
							for i1, v1 in pairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections) do
								if tonumber(v1.pos) > tMax and tonumber(v1.pos) ~= 999 then
									tMax = v1.pos
								end
							end
							v.pos = tMax + 1
						elseif aName == L["Hide"] then
							local tFrom = tonumber(v.pos)
							for i1, v1 in pairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[self.pageId].overviewSections) do
								if v1.pos >= tFrom and v1.pos ~= 999 then
									v1.pos = v1.pos - 1
								end
							end
							v.pos = 999
						end

						return
					end
				end
			end
			tNewMenuParentEntry.BuildChildren = function(self)
				local tSorted = {}
				for k, v in SkuSpairs(SkuOptions.db.profile[MODULE_NAME].overviewPages[q].overviewSections, function(t,a,b) return t[b].pos > t[a].pos end) do
					table.insert(tSorted, k)
				end
				local tNumberItems = #tSorted
				for x = 1, #tSorted do
					local tPos = SkuOptions.db.profile[MODULE_NAME].overviewPages[q].overviewSections[tSorted[x]].pos
					local tPosName = tPos
					if tPosName == 999 then
						tPosName = L["hidden"]
						tNumberItems = tNumberItems - 1
					end
					local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {SkuOptions.db.profile[MODULE_NAME].overviewPages[q].overviewSections[tSorted[x]].locName..";"..tPosName}, SkuGenericMenuItem)
					tNewMenuSubEntry.dynamic = true
					tNewMenuSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.pageId = q
						self.selectTarget.tEntry = SkuOptions.db.profile[MODULE_NAME].overviewPages[q].overviewSections[tSorted[x]].locName..";"..tPosName
					end

					tNewMenuSubEntry.BuildChildren = function(self)
						if tPos > 1 and tPos < 999 then
							local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Up"]}, SkuGenericMenuItem)
						end
						if tPos < tNumberItems then
							local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Down"]}, SkuGenericMenuItem)
						end
						if tPos == 999 then
							local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Show"]}, SkuGenericMenuItem)
						else
							local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Hide"]}, SkuGenericMenuItem)
						end

					end
				end
			end
		end
	end

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
	tNewMenuSubEntry.dynamic = false
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions:EditBoxShow(
			"",
			function(self)
				local tText = SkuOptionsEditBoxEditBox:GetText()
				if tText and tText ~= "" then
					for i, v in pairs(SkuOptions.db:GetProfiles()) do
						if v == tText then
							C_Timer.After(0.1, function()
								SkuOptions.Voice:OutputStringBTtts(L["name already taken"], true, true, 1, true)
							end)
							return
						end
					end
					SkuOptions.db:SetProfile(tText)
				end
			end,
			nil
		)
		C_Timer.After(0.1, function()
			SkuOptions.Voice:OutputStringBTtts(L["enter profile name now"], true, true, 1, true)
		end)
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

	local tNewMenuSubEntry =SkuOptions:InjectMenuItems(tNewMenuParentEntry, {"Löschen"}, SkuGenericMenuItem)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.isSelect = true
	tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db:DeleteProfile(aName, silent)
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tList = SkuOptions.db:GetProfiles()
		local tClean = {}
		for i, v in pairs(tList) do
			if v ~= SkuOptions.db:GetCurrentProfile() then
				table.insert(tClean, v)
			end
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tClean, SkuGenericMenuItem)
	end
	
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

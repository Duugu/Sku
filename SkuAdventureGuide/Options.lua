local MODULE_NAME = "SkuAdventureGuide"
local L = Sku.L
local slower = string.lower	

SkuAdventureGuide.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		formatEnumsInArticles = {
			order = 1,
			name = L["Bullet lists as numbers"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].formatEnumsInArticles = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].formatEnumsInArticles
			end,
		},
		history = {
			order = 2,
			name = L["Link History"],
			type = "group",
			args = {
				soundOnNewLinkInHistory = {
					order = 1,
					name = L["Sound on new link in history"],
					desc = "",
					type = "select",
					values = SkuAdventureGuide.HistoryNotifySounds,
					set = function(info, val) 
						SkuOptions.db.profile[MODULE_NAME].history.soundOnNewLinkInHistory = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].history.soundOnNewLinkInHistory
					end,
				},
				ignoreSeenLinks = {
					order = 2,
					name = L["Do not add seen links in history"],
					desc = "",
					type = "toggle",
					set = function(info, val) 
						SkuOptions.db.profile[MODULE_NAME].history.ignoreSeenLinks = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].history.ignoreSeenLinks
					end,
				},
			},
		},
		links = {
			order = 3,
			name = L["Links"],
			type = "group",
			args = {
				enableLinksInTooltips = {
					order = 1,
					name = L["List links in tooltips"],
					desc = "",
					type = "toggle",
					set = function(info, val) 
						SkuOptions.db.profile[MODULE_NAME].links.enableLinksInTooltips = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].links.enableLinksInTooltips
					end,
				},
				tooltipLinksIndicator = {
					order = 2,
					name = L["Link indicator in tooltips"],
					desc = "",
					type = "select",
					values = SkuAdventureGuide.tooltipLinksIndicatorValues,
					set = function(info, val) 
						SkuOptions.db.profile[MODULE_NAME].links.tooltipLinksIndicator = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].links.tooltipLinksIndicator
					end,
				},
				--[[
				globalLinkListOnly = {
					order = 2,
					name = L["Only global link list in last line"],
					desc = "",
					type = "toggle",
					set = function(info, val) 
						SkuOptions.db.profile[MODULE_NAME].links.globalLinkListOnly = val
					end,
					get = function(info) 
						return SkuOptions.db.profile[MODULE_NAME].links.globalLinkListOnly
					end,
				},
				]]
			},
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuAdventureGuide.defaults = {
	formatEnumsInArticles = true,
	history = {
		soundOnNewLinkInHistory = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		ignoreSeenLinks = true,
	},
	links = {
		enableLinksInTooltips = false,
		tooltipLinksIndicator = "word",
		--globalLinkListOnly = false,
	},
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:MenuBuilder(aParentEntry)
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Tutorials"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Tutorial list"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			SkuAdventureGuide.Tutorial:TutorialsMenuBuilder(self, true)
		end		

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Tutorial Editor"].." ("..L["for tutorial creators"]..")"}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			SkuAdventureGuide.Tutorial:EditorMenuBuilder(self)
		end		

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Tutorial help"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["In this help section you will find basic information on how to use the tutorial. Press the Down or Up key to hear all information."])}, SkuGenericMenuItem)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["The basics: When following the tutorial, you should strictly follow the instructions in the tutorial. Listen closely to what you are supposed to do, and then do exactly that. Do not do anything else while the tutorial is in progress. You can of course do other things in between. But then you may find it difficult to get back to the point you need to go to for the next step of the tutorial. So, unless you already know your way around, you should only do the tutorial steps and not do anything else."])}, SkuGenericMenuItem)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Tutorial flow: The tutorial consists of many individual steps. In each step you will first hear an information text. It explains what you have to do next. When you have performed that activity, you will hear a success sound. Then you can proceed to the next step. To proceed to the next step, press the shortcut %SKU_KEY_TUTORIALSTEPFORWARD%. The tutorial will not continue until you have completed the current step (success sound) and pressed %SKU_KEY_TUTORIALSTEPFORWARD%."])}, SkuGenericMenuItem)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Replaying the step instructions: You can listen to the instructions of the current tutorial step again at any time. To do this, press the shortcut %SKU_KEY_TUTORIALSTEPREPEAT%."])}, SkuGenericMenuItem)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Tutorial duration: The tutorial can last several hours. However, it usually takes about an hour to complete. But that will depend on your pace. It is better to spend some more time learning how the game and the addon are working. After that, you have to deal with everthing without the tutorial supporting you. You can always create a new character to play the tutorial again."])}, SkuGenericMenuItem)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Breaks: If you can't finish the tutorial because you don't have enough time or unexpected events such disconnects are disrupting the tutorial, you may resume the tutorial once you are back. Open this help with (F1). Go to the bottom. There, you will be offered to continue the tutorial."])}, SkuGenericMenuItem)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Log out: If you would like to exit the game, do not use Alt + (F4). For the game to save settings you need to log out from the game. To do this type slash logout and press Enter. The wait until you hear the background audio changing. That can take up to 20 seconds. Then close the game using Alt + (F4)."])}, SkuGenericMenuItem)		

			local tBestTutName, tLocRaceText, tLocClassText = SkuAdventureGuide.Tutorial:GetBestTutorialNameForFirstTimeUser()
			if tBestTutName then
				local tProgress = SkuOptions.db.char["SkuAdventureGuide"].Tutorials.progress[tBestTutName]
				local tNewMenuEntryC
				if tProgress and tProgress < #SkuDB.Tutorials[Sku.Loc][tBestTutName].steps and tProgress ~= 0 then
					tNewMenuEntryC = SkuOptions:InjectMenuItems(self, {L["To continue your newbie tutorial from step"]" "..tProgress.." "..L["press the Enter key now"]}, SkuGenericMenuItem)
				else
					tNewMenuEntryC = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Starting your newbie tutorial: There is a first steps tutorial specifically for your as a "]..tLocRaceText.." "..tLocClassText..". "..L["To start this tutorial now, please press the ENTER key."])}, SkuGenericMenuItem)
				end
				tNewMenuEntryC.isSelect = true
				tNewMenuEntryC.OnAction = function(self, aValue, aName)
					SkuAdventureGuide.Tutorial:StopCurrentTutorial()
					SkuOptions:CloseMenu()                     
					SkuAdventureGuide.Tutorial:StartTutorial(tBestTutName, 1, SkuDB, nil, true)
				end
			else
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Starting the newbie tutorial: Unfortunately at the moment there is no first steps tutorial for you as a "]..tLocRaceText.." "..tLocClassText..". "..L["We are working on more tutorials. Feel free to ask in our Discord for help or more tutorials."])}, SkuGenericMenuItem)
			end

      end

	end

	local tNewMenuParentEntryWiki =  SkuOptions:InjectMenuItems(aParentEntry, {L["Wiki"]}, SkuGenericMenuItem)
	tNewMenuParentEntryWiki.dynamic = true
	tNewMenuParentEntryWiki.BuildChildren = function(self)
		local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(tNewMenuParentEntryWiki, {L["Link History"]}, SkuGenericMenuItem)
		tNewMenuParentEntry.dynamic = true
		tNewMenuParentEntry.filterable = true
		tNewMenuParentEntry.BuildChildren = function(self)
			if #SkuAdventureGuide.linkHistory > 0 then
				for x = #SkuAdventureGuide.linkHistory, 1, -1 do
					local tDataLink = SkuDB.Wiki[Sku.Loc].lookup[slower(SkuAdventureGuide.linkHistory[x])]
					if tDataLink then
						if string.len(SkuDB.Wiki[Sku.Loc].data[tDataLink].content) > 0 and SkuDB.Wiki[Sku.Loc].data[tDataLink].content ~= "\r\n" then
							--check if that link actually is redirect and has a valid final target in that case
							local tFinalLink = SkuOptions:GetLinkFinalRedirectTarget(tDataLink)
							if tFinalLink then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDataLink}, SkuGenericMenuItem)
								--tNewMenuEntry.dynamic = true
								tNewMenuEntry.filterable = true
								tNewMenuEntry.OnEnter = function(self, aValue, aName)
									SkuOptions.currentMenuPosition.linksHistory = {}
									if tFinalLink ~= tDataLink then
										SkuOptions.currentMenuPosition.textFull = SkuOptions:FormatAndBuildSectionTable(SkuDB.Wiki[Sku.Loc].data[tFinalLink].content, tFinalLink, tDataLink)
									else
										SkuOptions.currentMenuPosition.textFull = SkuOptions:FormatAndBuildSectionTable(SkuDB.Wiki[Sku.Loc].data[tFinalLink].content, tFinalLink)
									end
								end
							end
						end
					end
				end
			else
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
			end
		end

		local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(tNewMenuParentEntryWiki, {L["All entries"]}, SkuGenericMenuItem)
		tNewMenuParentEntry.dynamic = true
		tNewMenuParentEntry.filterable = true
		tNewMenuParentEntry.BuildChildren = function(self)
			for i, v in pairs(SkuDB.Wiki[Sku.Loc].data) do
				if string.len(v.content) > 0 and v.content ~= "\r\n" then
					local tFinalLink = SkuOptions:GetLinkFinalRedirectTarget(i)
					if tFinalLink then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {i}, SkuGenericMenuItem)
						--tNewMenuEntry.dynamic = true
						tNewMenuEntry.filterable = true
						tNewMenuEntry.OnEnter = function(self, aValue, aName)
							SkuOptions.currentMenuPosition.linksHistory = {}
							if tFinalLink ~= i then
								SkuOptions.currentMenuPosition.textFull = SkuOptions:FormatAndBuildSectionTable(SkuDB.Wiki[Sku.Loc].data[tFinalLink].content, tFinalLink, i)
							else
								SkuOptions.currentMenuPosition.textFull = SkuOptions:FormatAndBuildSectionTable(SkuDB.Wiki[Sku.Loc].data[tFinalLink].content, tFinalLink)
							end
						end
					end
				end
			end
		end
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuAdventureGuide.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end



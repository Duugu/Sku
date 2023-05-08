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
			SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["In this help you will find information about our tutorials for newbies. Press down arrow or up arrow to listen to the info, or press Escape to close this help. Press F1 to open the help again."])}, SkuGenericMenuItem)
			local tBestTutName, tLocRaceText, tLocClassText, tBestTutGuid = SkuAdventureGuide.Tutorial:GetBestTutorialNameForFirstTimeUser()
			if tBestTutGuid then
				--If valid race + class
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["For you as (%race%) (%class%) there is a tutorial. Use down arrow to learn how to start it."])}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["First a few infos: If you are following the tutorial, you should strictly follow the instructions from the tutorial. Listen carefully to what you are supposed to do, and then do exactly that. Don't do anything else while the tutorial is running. Do not deviate from the tutorial. Otherwise the tutorial will not work anymore!"])}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["The tutorial will take about 2 hours. You can log out at any time and continue the tutorial later via this help. Just press F1 again after logging in."])}, SkuGenericMenuItem)
				local tProgress = SkuOptions.db.char[MODULE_NAME].Tutorials.progress[tBestTutGuid]
				if tProgress == nil or tProgress < #SkuDB.AllLangs.Tutorials[tBestTutGuid].steps and tProgress < 1 then
					--if step 1
					local tNewMenuEntryC = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Press ENTER now, to start your tutorial."])}, SkuGenericMenuItem)
					tNewMenuEntryC.isSelect = true
					tNewMenuEntryC.OnAction = function(self, aValue, aName)
						SkuAdventureGuide.Tutorial:StopCurrentTutorial()
						SkuOptions:CloseMenu()                     
						SkuAdventureGuide.Tutorial:StartTutorial(tBestTutGuid, 1, SkuDB, nil, true)
					end
				else	
					--if step > 1
					local tNewMenuEntryC = SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Press ENTER, to continue your tutorial."])}, SkuGenericMenuItem)
					tNewMenuEntryC.isSelect = true
					tNewMenuEntryC.OnAction = function(self, aValue, aName)
						SkuAdventureGuide.Tutorial:StopCurrentTutorial()
						SkuOptions:CloseMenu()                     
						SkuAdventureGuide.Tutorial:StartTutorial(tBestTutGuid, tProgress, SkuDB, nil, true)
					end
				end
			else
				--If not valid race + class
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Unfortunately there is no tutorial for you as (%race%) (%class%) yet. The Sku addon contains tutorials for (Human) Warriors, Paladins, Rogues, Priests, Mages, and Warlocks, and for (Night Elf) Hunters, and Druids."])}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["If you would like to be supported by a tutorial, you can logout now by typing /logout and pressing enter."])}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Then you can create a second character using one of the mentioned race and class combinations. With the second character you can play the tutorial. That takes about 2 hours."])}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {SkuAdventureGuide.Tutorial:ReplacePlaceholders(L["Afterwards you have mastered the basics and can return to your first character and play it without assistance, or you can continue playing with the second character."])}, SkuGenericMenuItem)
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



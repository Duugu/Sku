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
		soundOnNewLinkInHistory = "sound-notification15",
		ignoreSeenLinks = true,
	},
	links = {
		enableLinksInTooltips = true,
		tooltipLinksIndicator = "word",
		--globalLinkListOnly = false,
	},
}

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:MenuBuilder(aParentEntry)
	--dprint("SkuAdventureGuide:MenuBuilderTest", aParentEntry)
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



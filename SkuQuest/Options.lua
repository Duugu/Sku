local MODULE_NAME = "SkuQuest"
local L = Sku.L

SkuQuest.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
			name = L["Module enabled"] ,
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].enable = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].enable
			end
		},
		TestDropdown = {
			name = "Test Dropdown" ,
			desc = "",
			values = {
				["Master"] = "Master",
				["SFX"] = "SFX",
				["Music"] = "Music",
				["Ambience"] = "Ambience",
				["Dialog"] = "Dialog",
			},
			type = "select",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].enable = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].enable
			end
		},
	}
}
---------------------------------------------------------------------------------------------------------------------------------------
SkuQuest.defaults = {
	enable = true,
	TestDropdown = "Dialog",
}

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuSpairs(t, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, function(a,b) return order(t, a, b) end)
	else
		table.sort(keys)
	end
	local i = 0
	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tStatesFriendly = {["false"] = L["No"], ["true"] = L["Yes"], ["nil"] = L["Unknown"],}
local function GetQuestDataStringFromDB(aQuestID, aZoneID)
	local tSections = {}

	local i = aQuestID

	table.insert(tSections, L["Quest ID"]..": "..i)

	table.insert(tSections, SkuDB.questLookup[Sku.Loc][i][1]) --de name

	local tCurrentQuestLogQuestsTable = {}
	local numEntries = GetNumQuestLogEntries()
	if (numEntries > 0) then
		for questLogID = 1, numEntries do
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
			tCurrentQuestLogQuestsTable[questID] = true
		end
	end
	if not tCurrentQuestLogQuestsTable[aQuestID] then
		table.insert(tSections, L["Completed"]..": "..tStatesFriendly[tostring(C_QuestLog.IsQuestFlaggedCompleted(i))]) --https://wowpedia.fandom.com/wiki/API_C_QuestLog.GetAllCompletedQuestIDs
	else
		table.insert(tSections, L["Completed: In log"])
	end

	if SkuDB.InternalAreaTable[aZoneID] then
		table.insert(tSections, L["Zone"]..": "..SkuDB.InternalAreaTable[aZoneID].AreaName_lang[Sku.Loc])
	else
		table.insert(tSections, L["Zone: Unknown"])
	end

	table.insert(tSections, L["Level"]..": "..SkuDB.questDataTBC[i][SkuDB.questKeys["questLevel"]].." ("..SkuDB.questDataTBC[i][SkuDB.questKeys["requiredLevel"]]..")")

	if SkuDB.questLookup[Sku.Loc][i][3] then
		table.insert(tSections, L["Objectives"].."\r\n"..(SkuDB.questLookup[Sku.Loc][i][3][1] or ""))
	else
		table.insert(tSections, L["Objectives"].."\r\n")
	end
	--table.insert(tSections, "Questtext\r\n"..questDescription

	local rRaces = {}
	local tFlagH = nil
	local tFlagA = nil
	for iR, vR in pairs(SkuDB.raceKeys) do
		if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredRaces"]]) > 0 then
			table.insert(rRaces, iR)
			if iR == "ALL_HORDE" then
				tFlagH = true
			end
			if iR == "ALL_ALLIANCE" then
				tFlagA = true
			end
		end
	end
	local tRaceText = ""
	if tFlagH then
		tRaceText = tRaceText..SkuQuest.racesFriendly["ALL_HORDE"]..";"
	end
	if tFlagA then
		tRaceText = tRaceText..SkuQuest.racesFriendly["ALL_ALLIANCE"]..";"
	end
	if not tFlagA and not tFlagH then
		for i, v in pairs(rRaces) do
			--dprint(i, v)
			tRaceText = tRaceText..SkuQuest.racesFriendly[v]..";"
		end
	end
	table.insert(tSections, L["Races"]..": "..tRaceText)

	local tClasses = {}
	for iR, vR in pairs(SkuDB.classKeys) do
		if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
			if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]]) > 0 then
				table.insert(tClasses, iR)
			end
		end
	end
	local tClassText = ""
	for i, v in pairs(tClasses) do
		--dprint(i, v)
		tClassText = tClassText..SkuQuest.classesFriendly[v]..";"
	end
	table.insert(tSections, L["Classes"]..": "..tClassText)

	if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
		local preQuestGroup = ""
		for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]]) do
			preQuestGroup = preQuestGroup.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
		end
		table.insert(tSections, L["Pre Quests"]..": "..preQuestGroup)
	end
	if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
		local preQuestSingle = ""
		for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]]) do
			preQuestSingle = preQuestSingle.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
		end
		table.insert(tSections, L["Pre Quest"]..": "..preQuestSingle)
	end
	if SkuDB.questDataTBC[i][SkuDB.questKeys["inGroupWith"]] then -- table: {quest(int)} - to be completed additional to this before next in series
		local inGroupWith = ""
		for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["inGroupWith"]]) do
			inGroupWith = inGroupWith.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
		end
		table.insert(tSections, L["Quests group"]..": "..inGroupWith)
	end

	if SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]] then -- table: {quest(int)} - to be completed additional to this before next in series
		local parentQuest = ""
		parentQuest = parentQuest.."\r\n"..SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]].." "..SkuDB.questLookup[Sku.Loc][SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]]][1]
		table.insert(tSections, L["Parent quest"]..": "..parentQuest)
	end


	--if SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]] then -- 
		--table.insert(tSections, "parentQuest: "..SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]])
	--end
	--if SkuDB.questDataTBC[i][SkuDB.questKeys["childQuests"]] then -- table: {quest(int)} - to be completed additional to this before next in series
		--local childQuests = ""
		--for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["childQuests"]]) do
			--childQuests = childQuests..";"..iR.."-"..vR
		--end
		--table.insert(tSections, "childQuests: "..childQuests)
	--end									

	local tFlags = {}
	for iR, vR in pairs(SkuDB.QuestFlags) do
		if SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]] then
			--dprint(iR, vR, SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]])
			if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]]) > 0 then
				table.insert(tFlags, iR)
			end
		end
	end
	local tFlagText = ""
	for i, v in pairs(tFlags) do
		tFlagText = tFlagText..SkuDB.QuestFlagsFriendly[v]..";"
	end
	table.insert(tSections, L["Attributes"]..": "..tFlagText)

	--[[
	['requiredSkill'] = 18, -- table: {skill(int), value(int)}
	['requiredMinRep'] = 19, -- table: {faction(int), value(int)}
	['requiredMaxRep'] = 20, -- table: {faction(int), value(int)}
	['requiredSourceItems'] = 21, -- table: {item(int), ...} Items that are not an objective but still needed for the quest.

	['specialFlags'] = 24, -- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags

	['reputationReward'] = 26, -- table: {{FACTION,VALUE}, ...}, A list of reputation reward for factions
	]]

	return tSections
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreatureIdHelper(aCreatureIds, aTargetTable, aOnly3)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())

	for i, tNpcID in pairs(aCreatureIds) do
		--dprint("CreateRtWpSubmenu", i, tNpcID)		
		local i = tNpcID
		if SkuDB.NpcData.Data[i] then
			local tSpawns = SkuDB.NpcData.Data[i][7]
			if tSpawns then
				for is, vs in pairs(tSpawns) do
					local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
					--we don't care for stuff that isn't in the open world
					if isUiMap then
						local tData = SkuDB.InternalAreaTable[is]
						if tData then
							if tData.ContinentID == tPlayerContinentID then
								local tNumberOfSpawns = #vs
								if tNumberOfSpawns > 3 and aOnly3 == true then
									tNumberOfSpawns = 3
								end
								if SkuDB.NpcData.Names[Sku.Loc][i] then
									local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
									local tRolesString = ""
									if not tSubname then
										local tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.Names[Sku.Loc][i], i)
										if #tRoles > 0 then
											for i, v in pairs(tRoles) do
												tRolesString = tRolesString..";"..v
											end
											tRolesString = tRolesString..""
										end
									else
										tRolesString = tRolesString..";"..tSubname
									end
									for sp = 1, tNumberOfSpawns do
										if not aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] then
											aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] = {}
										end
										table.insert(aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString], SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])
									end
								end
							else
								if SkuDB.NpcData.Names[Sku.Loc][i] then
									local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
									local tRolesString = ""
									if not tSubname then
										local tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.Names[Sku.Loc][i], i)
										if #tRoles > 0 then
											for i, v in pairs(tRoles) do
												tRolesString = tRolesString..";"..v
											end
											tRolesString = tRolesString..""
										end
									else
										tRolesString = tRolesString..";"..tSubname
									end
									if not aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] then
										aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] = {}
									end
									table.insert(aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString], "Anderer Kontinent;"..SkuNav:GetContinentNameFromContinentId(tData.ContinentID)..";"..tData.AreaName_lang[Sku.Loc])
								end

							end
						end
					end
				end
			end
		end
	end
	return aTargetTable
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetResultingWps(aSubIDTable, aSubType, aQuestID, tResultWPs, aOnly3)
	--dprint("GetResultingWps", aSubIDTable, aSubType, aQuestID, tResultWPs, aOnly3)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tCurrentAreaId = SkuNav:GetCurrentAreaId()
	if aSubType == "item" then
		for i, tItemId in pairs(aSubIDTable) do
			--dprint("  i, tItemId", i, tItemId)
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]] then
				for x = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]] do
					--dprint("     item drops from object", x, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]][x])
					local tObjectId = SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]][x]
					local tObjectData = SkuDB.objectDataTBC[tObjectId]
					if tObjectData then					
						local tObjectSpawns = tObjectData[SkuDB.objectKeys["spawns"]]
						local tObjectName = SkuDB.objectLookup[Sku.Loc][tObjectId] or SkuDB.objectDataTBC[tObjectId][1]
						if tObjectSpawns then
							for is, vs in pairs(tObjectSpawns) do
								local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
								if isUiMap then
									--if is == tCurrentAreaId then
										local tData = SkuDB.InternalAreaTable[is]
										if tData then
											if tData.ContinentID == tPlayerContinentID then
												local tNumberOfSpawns = #vs
												if tNumberOfSpawns > 3 and aOnly3 == true then
													tNumberOfSpawns = 3
												end
												for sp = 1, tNumberOfSpawns do
													if not tResultWPs[tObjectName] then
														tResultWPs[tObjectName] = {}
													end
													table.insert(tResultWPs[tObjectName], L["OBJECT"]..";"..tObjectId..";"..tObjectName..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])
												end
											end
										end
									--end
								end
							end
						end
					end
				end
			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["npcDrops"]] then
				CreatureIdHelper(SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["npcDrops"]], tResultWPs, aOnly3)
			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["itemDrops"]] then
				--dprint("item drop from item")

			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["vendors"]] then
				CreatureIdHelper(SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["vendors"]], tResultWPs, aOnly3)
			end
		end
	elseif aSubType == "object" then
		local tWpList = {}
		for i, tObjectId in pairs(aSubIDTable) do
			if SkuDB.objectDataTBC[tObjectId] then
				local tSpawns = SkuDB.objectDataTBC[tObjectId][4]
				if tSpawns then
					for is, vs in pairs(tSpawns) do
						local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
						--we don't care for stuff that isn't in the open world
						if isUiMap then
							local tData = SkuDB.InternalAreaTable[is]
							if tData then
								if tPlayerContinentID == tData.ContinentID then
									if (not aAreaId) or aAreaId == isUiMap then
										local tNumberOfSpawns = #vs
										if tNumberOfSpawns > 3 and aOnly3 == true then
											tNumberOfSpawns = 3
										end
										for sp = 1, tNumberOfSpawns do
											local tObjectName = SkuDB.objectLookup[Sku.Loc][tObjectId] or SkuDB.objectDataTBC[tObjectId][1] or "Object name missing"
											if not tResultWPs[tObjectName] then
												tResultWPs[tObjectName] = {}
											end
											table.insert(tResultWPs[tObjectName], L["OBJECT"]..";"..tObjectId..";"..tObjectName..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])

										end
									end
								end
							end
						end
					end
				end
			end
		end
	elseif aSubType == "creature" then
		CreatureIdHelper(aSubIDTable, tResultWPs, aOnly3)
	end

end
---------------------------------------------------------------------------------------------------------------------------------------
local function CreateRtWpSubmenu(aParent, aSubIDTable, aSubType, aQuestID)
	dprint("CreateRtWpSubmenu aSubIDTable ", aSubIDTable, " - aSubType ", aSubType, " - aQuestID ", aQuestID)
	local tResultWPs = {}

	SkuQuest:GetResultingWps(aSubIDTable, aSubType, aQuestID, tResultWPs)

	local tPlayX, tPlayY = UnitPosition("player")
	local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(tPlayX, tPlayY, 1000)--SkuOptions.db.profile["SkuNav"].nearbyWpRange)
	
	local tHasContent = false
	for unitGeneralName, wpTable in pairs(tResultWPs) do
		--dprint(unitGeneralName, wpTable)
		tHasContent = true
		local tNewMenuGeneralName = SkuOptions:InjectMenuItems(aParent, {unitGeneralName}, SkuGenericMenuItem)
		tNewMenuGeneralName.dynamic = true
		tNewMenuGeneralName.BuildChildren = function(self)
			if string.find(wpTable[1], "Anderer Kontinent") then
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {wpTable[1]}, SkuGenericMenuItem)
			else
				local tCoveredWps = {}

				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {L["Route"]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--print("Route onaction", self, aValue, aName)
					if SkuOptions.db.profile["SkuNav"].routeRecording == true then
						SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
						return
					end
					if SkuOptions.db.profile["SkuNav"].metapathFollowing == true or SkuOptions.db.profile["SkuNav"].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end
					SkuOptions.db.profile["SkuNav"].metapathFollowing = false

					if SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths then
						if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
							SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, aName)--
						if not SkuOptions.db.profile["SkuNav"].metapathFollowingTarget then
							SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = aName
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
						SkuOptions.db.profile["SkuNav"].metapathFollowing = true
		
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
						SkuOptions.Voice:OutputString(L["Following metaroute"], false, true, 0.2)
		
						SkuOptions:CloseMenu()
					end

				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
					local tSortedWaypointList = {}
					for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
						local tFnd = false
						for tK, tV in pairs(tSortedWaypointList) do
							if tV == v.nearestWpRange..";"..L["Meter"].."#"..v.nearestWP then
								tFnd = true
							end
						end
						if tFnd == false then
							table.insert(tSortedWaypointList, v.nearestWpRange..";"..L["Meter"].."#"..v.nearestWP)
						end
					end

					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
					else
						local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs)--
						SkuOptions.db.profile["SkuNav"].metapathFollowingStart = tSortedWaypointList[1]
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = tMetapaths
						SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = nil

								
						local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {L["By distance"]}, SkuGenericMenuItem)
						tNewMenuGeneralSort.dynamic = true
						tNewMenuGeneralSort.filterable = true
						tNewMenuGeneralSort.BuildChildren = function(self)
							local tData = {}
							for i, v in pairs(tMetapaths) do
								for wpIndex, wpName in pairs(wpTable) do
									if string.find(i, wpName) then
										tData[i] = tMetapaths[i].distance
									end
								end
							end
							local tSortedList = {}
							for k,v in SkuSpairs(tData, function(t,a,b) return t[b] > t[a] end) do --nach wert
								table.insert(tSortedList, k)
							end
							if #tSortedList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedList) do
									for wpIndex, wpName in pairs(wpTable) do
										if string.find(tV, wpName) then
											local tDistText = tMetapaths[tV].distance..";"..L["Meter"]
											if tMetapaths[tV].distance >= SkuNav.MaxMetaRange then
												tDistText = "weit"
											end
											local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistText.."#"..tV}, SkuGenericMenuItem)
											tNewMenuEntry.OnEnter = function(self, aValue, aName)
												SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tV
											end
											tCoveredWps[tV] = true
											--tHasContent = true
										end
									end
								end
							end
						end
						local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {L["By name"]}, SkuGenericMenuItem)
						tNewMenuGeneralSort.dynamic = true
						tNewMenuGeneralSort.filterable = true
						tNewMenuGeneralSort.BuildChildren = function(self)
							local tRoutesList = {}

							for v, i in pairs(tMetapaths) do
								for wpIndex, wpName in pairs(wpTable) do
									if string.find(v, wpName) then
										--print("find:", v, wpName)
										tRoutesList[v] = v
									end
								end
							end

							local tSortedWaypointList = {}
							for k,v in SkuSpairs(tRoutesList) do
								table.insert(tSortedWaypointList, k)
							end
							if #tSortedWaypointList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedWaypointList) do
									local tDistText = tMetapaths[tV].distance..";"..L["Meter"]
									if tMetapaths[tV].distance >= SkuNav.MaxMetaRange then
										tDistText = "weit"
									end
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistText.."#"..tV}, SkuGenericMenuItem)
									tNewMenuEntry.OnEnter = function(self, aValue, aName)
										SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tV
									end
									tCoveredWps[tV] = true
									--tHasContent = true
								end
							end
						end						
					end
				end
			
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {L["Closest route"]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--dprint("OnAction", self.name, aValue, aName)
					if SkuOptions.db.profile["SkuNav"].routeRecording == true then
						SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
						return
					end
					if SkuOptions.db.profile["SkuNav"].metapathFollowing == true or SkuOptions.db.profile["SkuNav"].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end
					SkuOptions.db.profile["SkuNav"].metapathFollowing = false
					if SkuOptions.db.profile["SkuNav"].metapathFollowingStart then
						if SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths then
							if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
								SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
							end
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, SkuOptions.db.profile["SkuNav"].metapathFollowingTarget, true)--
							--setmetatable(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths, SkuPrintMTWo)
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[#SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths+1] = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget] = SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingTarget]
							table.insert(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget].pathWps, SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget)
							SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
							SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
							SkuOptions.db.profile["SkuNav"].metapathFollowing = true
							SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
							SkuOptions.Voice:OutputString("Metaroute folgen gestartet", false, true, 0.2)
							SkuOptions:CloseMenu()
						end
					end
				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					local tMaxAllowedDistanceToTargetWp = 500
					local tSortedWaypointList = {}
					for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
						local tFnd = false
						for tK, tV in pairs(tSortedWaypointList) do
							if tV == v.nearestWpRange..";Meter#"..v.nearestWP then
								tFnd = true
							end
						end
						if tFnd == false then
							table.insert(tSortedWaypointList, v.nearestWpRange..";Meter#"..v.nearestWP)
						end
					end
					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
					else
						local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, nil, true)
						SkuOptions.db.profile["SkuNav"].metapathFollowingStart = tSortedWaypointList[1]
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = tMetapaths

						local tResults = {}
						for wpIndex, wpName in pairs(wpTable) do
							local tNearWps = SkuNav:GetNearestWpsWithLinksToWp(wpName, 10, tMaxAllowedDistanceToTargetWp)
							local tBestRouteWeightedLength = 100000
							for x = 1, #tNearWps do
								if tMetapaths[tNearWps[x].wpName] then
									local EndMetapathWpObj = SkuNav:GetWaypointData2(tNearWps[x].wpName)
									local tEndTargetWpObj = SkuNav:GetWaypointData2(wpName)
									local tDistToEndTargetWp = SkuNav:Distance(EndMetapathWpObj.worldX, EndMetapathWpObj.worldY, tEndTargetWpObj.worldX, tEndTargetWpObj.worldY)
									if (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp < tBestRouteWeightedLength then
										tBestRouteWeightedLength = (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp
										tResults[wpName] = {
											metarouteIndex = tNearWps[x].wpName, 
											metapathLength = tMetapaths[tNearWps[x].wpName].distance, 
											distanceTargetWp = tNearWps[x].distance,
											targetWpName = wpName,
											weightedDistance = tBestRouteWeightedLength,
										}
									end
								end
							end
						end

						local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {L["By distance"]}, SkuGenericMenuItem)
						tNewMenuGeneralSort.dynamic = true
						tNewMenuGeneralSort.filterable = true
						tNewMenuGeneralSort.BuildChildren = function(self)
							local tSortedList = {}
							for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].weightedDistance > t[a].weightedDistance end) do
								table.insert(tSortedList, k)
							end
							if #tSortedList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedList) do
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tResults[tV].metapathLength..";plus;"..tResults[tV].distanceTargetWp..";Meter#"..tV}, SkuGenericMenuItem)
									tNewMenuEntry.OnEnter = function(self, aValue, aName)
										SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
										SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
									end
									tCoveredWps[tV] = true
									--tHasContent = true
								end
							end
						end

						local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {"Nach Name"}, SkuGenericMenuItem)
						tNewMenuGeneralSort.dynamic = true
						tNewMenuGeneralSort.filterable = true
						tNewMenuGeneralSort.BuildChildren = function(self)
							local tSortedWaypointList = {}
							for k,v in SkuSpairs(tResults) do
								table.insert(tSortedWaypointList, k)
							end
							if #tSortedWaypointList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedWaypointList) do
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tV.."#"..tResults[tV].metapathLength..";plus;"..tResults[tV].distanceTargetWp..";"..L["Meter"]}, SkuGenericMenuItem)
									tNewMenuEntry.OnEnter = function(self, aValue, aName)
										SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
										SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
									end
									tCoveredWps[tV] = true
									--tHasContent = true
								end
							end
						end						
					end
				end
			
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {"Wegpunkt"}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--dprint("OnAction Wegpunkt auswählen", self.name, aValue, aName)
					if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
						SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
						return
					end

					if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end

					if SkuNav:GetWaypointData2(SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint) then
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint)
						SkuOptions:CloseMenu()
					else
						SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputString("Wegpunkt nicht ausgewählt", false, true, 0.3, true)
					end

				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {L["By distance"]}, SkuGenericMenuItem)
					tNewMenuGeneralSort.dynamic = true
					tNewMenuGeneralSort.filterable = true
					tNewMenuGeneralSort.BuildChildren = function(self)
						local tPlayX, tPlayY = UnitPosition("player")

						local tResults = {}
						for wpIndex, wpName in pairs(wpTable) do
							local tWpObj = SkuNav:GetWaypointData2(wpName)
							local tDistanceTargetWp = SkuNav:Distance(tPlayX, tPlayY, tWpObj.worldX, tWpObj.worldY)
							tResults[wpName] = {wpName = wpName, distance = tDistanceTargetWp}
						end

						local tSortedList = {}
						for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].distance > t[a].distance end) do
							table.insert(tSortedList, k)
						end
						if #tSortedList == 0 then
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
						else
							for tK, tV in ipairs(tSortedList) do
								local tNewMenuGeneralSp = SkuOptions:InjectMenuItems(self, {tResults[tV].distance..";Meter#"..tV}, SkuGenericMenuItem)
								tNewMenuGeneralSp.OnEnter = function(self, aValue, aName)
									SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint = tV
								end
								--tHasContent = true
							end
						end
					end
					local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {"Nach Name"}, SkuGenericMenuItem)
					tNewMenuGeneralSort.dynamic = true
					tNewMenuGeneralSort.filterable = true
					tNewMenuGeneralSort.BuildChildren = function(self)
						SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
						local tPlayX, tPlayY = UnitPosition("player")

						local tResults = {}
						for wpIndex, wpName in pairs(wpTable) do
							local tWpObj = SkuNav:GetWaypointData2(wpName)
							local tDistanceTargetWp = SkuNav:Distance(tPlayX, tPlayY, tWpObj.worldX, tWpObj.worldY)
							tResults[wpName] = {wpName = wpName, distance = tDistanceTargetWp}
						end

						local tSortedList = {}
						for k,v in SkuSpairs(tResults, function(t,a,b) return b > a end) do
							table.insert(tSortedList, k)
						end
						if #tSortedList == 0 then
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
						else
							for tK, tV in ipairs(tSortedList) do
								local tNewMenuGeneralSp = SkuOptions:InjectMenuItems(self, {tV.."#"..tResults[tV].distance..";"..L["Meter"]}, SkuGenericMenuItem)
								tNewMenuGeneralSp.OnEnter = function(self, aValue, aName)
									SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint = tV
								end
								--tHasContent = true
							end
						end
					end

				end
			end
		end
	end

	if tHasContent == false then
		local tNewMenuGeneralName = SkuOptions:InjectMenuItems(aParent, {L["Empty"]}, SkuGenericMenuItem)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetQuestTargetIds(aQuestID, aList)
	local tTargets = {}
	local tTargetType = nil

	if aList[1] then --creatures
		for i, v in pairs(aList[1]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "creature"

	elseif aList[2] then --objects
		for i, v in pairs(aList[2]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "object"

	elseif aList[3] then --items
		for i, v in pairs(aList[3]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "item"

	elseif aList[4] then--rep
		-- TO IMPLEMENT


	elseif aList[5] then--kills
		tTargets = aList[5][1]
		tTargetType = "creature"
	end
	
	return tTargets, tTargetType
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreateQuestSubmenu(aParent, aQuestID)
	local tHasEntries
	--parent qs
	local tPreQuestTable = {}
	if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
		local preQuestGroup = ""
		for iR, vR in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestGroup"]]) do
			tPreQuestTable[#tPreQuestTable+1] = vR
		end
	end
	if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
		local preQuestSingle = ""
		for iR, vR in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestSingle"]]) do
			tPreQuestTable[#tPreQuestTable+1] = vR
		end
	end

	if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["parentQuest"]] then -- table: {quest(int)} - one to be completed before next in series
		local parentQuest = ""
		tPreQuestTable[#tPreQuestTable+1] = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["parentQuest"]]
	end

	if #tPreQuestTable > 0 then
		tHasEntries = true
		local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {"Pre Quests"}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.OnAction = function(self, aValue, aName)

		end
		tNewMenuSubEntry.BuildChildren = function(self)
			for i, v in pairs(tPreQuestTable) do
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.questLookup[Sku.Loc][v][1]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					C_Timer.NewTimer(0.1, function()
						SkuOptions:SlashFunc("short,SkuQuest,Questdatenbank,Alle,"..self.name)
						SkuOptions.Voice:OutputString(self.name, true, true, 0.3, true)
					end)
				end
			end
		end
	end

	if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][1] 
		or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][2]
		or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][3]
	then
		tHasEntries = true
		local tstartedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]]
		if tstartedBy then
			local tTargets = {}
			local tTargetType = nil
			
			tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tstartedBy)

			local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {"Annahme"}, SkuGenericMenuItem)
			tNewMenuSubEntry.dynamic = true
			tNewMenuSubEntry.filterable = true
			tNewMenuSubEntry.BuildChildren = function(self)
				tHasEntries = true
				CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
				--CreateRtWpSubmenu(self, SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][1], "creature", aQuestID)
			end
		end
	end

	local tObjectives = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["objectives"]]
	if tObjectives then
		tHasEntries = true
		local tTargets = {}
		local tTargetType = nil

		tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tObjectives)

		if	tTargetType then
			local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {"Ziel"}, SkuGenericMenuItem)
			tNewMenuSubEntry.dynamic = true
			--tNewMenuSubEntry.filterable = true
			tNewMenuSubEntry.OnAction = function(self, aValue, aName)
			end
			tNewMenuSubEntry.BuildChildren = function(self)
				tHasEntries = true
				CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
			end
		end
	end

	if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][1] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][2] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][3] then
		tHasEntries = true
		local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {"Abgabe"}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		local tFinishedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]]
		if tFinishedBy then
			local tTargets = {}
			local tTargetType = nil

			tTargets, tTargetType =SkuQuest: GetQuestTargetIds(aQuestID, tFinishedBy)

			tNewMenuSubEntry.BuildChildren = function(self)
				tHasEntries = true
				CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
			end
		end
	end

	if not tHasEntries then
		local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Empty"]}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = false
	end
	return tHasEntries
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:MenuBuilder(aParentEntry)
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Aktuelle Quests"}, SkuGenericMenuItem)
	--Alle
	--Zonen
	--Entfernung Questgeber
	--Level
	tNewMenuParentEntry.dynamic = true
	--tNewMenuParentEntry.isSelect = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)

	end
	tNewMenuParentEntry.BuildChildren = function(self)
		if QuestLogFrame:IsVisible() ~= true then
			ToggleQuestLog()
		end
		if (QuestLogFrame:IsVisible()) then
			ExpandQuestHeader(0)
		end

		local numEntries, numQuests = GetNumQuestLogEntries()
		--numEntries = 0	
		if (numEntries == 0) then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
		else
			local tQuestsByHeader = {}
			--setmetatable(tQuestsByHeader, SkuNav.PrintMT)

			local tHeader = ""
			for questLogID = 1, numEntries do
				local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
				local tAddTitle = ""
				if isComplete == 1 then
					tAddTitle = "(Fertig) "
				elseif isComplete == -1 then
					tAddTitle = "(Fehlgeschlagen) "
				end
				if suggestedGroup then
					tAddTitle = tAddTitle.."("..suggestedGroup..") "
				end
				if frequency == 2 then
					tAddTitle = tAddTitle.."(Daily) "
				end
				if isHeader == false then
					tQuestsByHeader[tHeader][tAddTitle..title] = questLogID
				else
					tQuestsByHeader[title] = {}
					tHeader = title
				end
			end
			--all
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle"}, SkuGenericMenuItem)
			tNewMenuEntry.filterable = true
			for ih, vh in pairs(tQuestsByHeader) do
				for iq, vq in pairs(vh) do
					local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntry, {iq}, SkuGenericMenuItem)
					tNewMenuEntry1.questLogId = vq
					tNewMenuEntry1.dynamic = true
					tNewMenuEntry1.OnAction = function(self, aValue, aName)
					end
					tNewMenuEntry1.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = SkuQuest:GetTTSText(self.questLogId)
					end
					local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(vq)
					tNewMenuEntry1.BuildChildren = function(self)
						CreateQuestSubmenu(self, questID)
					end
				end
			end
			--by zone
			for ih, vh in pairs(tQuestsByHeader) do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {ih}, SkuGenericMenuItem)
				tNewMenuEntry.filterable = true
				for iq, vq in pairs(vh) do
					local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntry, {iq}, SkuGenericMenuItem)
					tNewMenuEntry1.questLogId = vq
					tNewMenuEntry1.dynamic = true
					tNewMenuEntry1.OnAction = function(self, aValue, aName)
					end
					tNewMenuEntry1.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = SkuQuest:GetTTSText(self.questLogId)
					end
					local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(vq)
					tNewMenuEntry1.BuildChildren = function(self)
						CreateQuestSubmenu(self, questID)
					end
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Questdatenbank"}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)	
		local tNewMenuSubEntry =SkuOptions:InjectMenuItems(self, {"Start in Zone"}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		end
		tNewMenuSubEntry.BuildChildren = function(self)
			local tUiMap = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
			local tPlayX, tPlayY = UnitPosition("player")
			local tShowQuestsTable = {}

			tCurrentQuestLogQuestsTable = {}
			local numEntries, numQuests = GetNumQuestLogEntries()
			if (numEntries >= 0) then
				for questLogID = 1, numEntries do
					local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
					tCurrentQuestLogQuestsTable[questID] = true
					--dprint(title, questID)
				end
			end

			for i, v in pairs(SkuDB.questLookup[Sku.Loc]) do
				if SkuDB.questDataTBC[i] then
					local tZoneId
					if SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then --creatures
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1]
						tZoneId = SkuDB.NpcData.Data[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]][SkuDB.NpcData.Keys['zoneID']]
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then --objects
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]
						if SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]] then
							tZoneId = SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]]
						end
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3] then --items
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3]
					end

					if tZoneId == tUiMap then

						local tnextQuestInChain = SkuDB.questDataTBC[i][SkuDB.questKeys["nextQuestInChain"]]
						local tOutFlag = false
						if tnextQuestInChain then
							if tCurrentQuestLogQuestsTable[tnextQuestInChain] then
								tOutFlag = true
							end
							if C_QuestLog.IsQuestFlaggedCompleted(tonumber(tnextQuestInChain)) == true then
								tOutFlag = true
							end
						end

						if (C_QuestLog.IsQuestFlaggedCompleted(i) == false)
							and (SkuDB.questDataTBC[i][SkuDB.questKeys["requiredLevel"]] <= UnitLevel("player"))
							and not tCurrentQuestLogQuestsTable[i]
							and tOutFlag ~= true
						then
							local rRaces = {}
							local tFlagH = nil
							local tFlagA = nil
							local tFlagC = nil
							local tPlayerFactionEn, tPlayerFactionLoc = UnitFactionGroup("player")
							local tPlayerclassName, tPlayerclassFilename, tPlayerclassId = UnitClass("player")
							for iR, vR in pairs(SkuDB.raceKeys) do
								if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredRaces"]]) > 0 then
									rRaces[#rRaces+1] = iR
									if iR == "ALL_HORDE" then
										tFlagH = true
									end
									if iR == "ALL_ALLIANCE" then
										tFlagA = true
									end

									if tPlayerclassFilename == iR then
										tFlagC = true
									end
								end
							end
							if not SkuDB.raceKeys then
								tFlagC = true
							end

							if (tPlayerFactionEn == "Alliance" and tFlagA) or (tPlayerFactionEn == "Horde" and tFlagH) or (tFlagC) then
								local tClasses = {}
								local tFlagClass = nil
								if not SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
									tFlagClass = true
								end
								for iR, vR in pairs(SkuDB.classKeys) do
									if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
										if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]]) > 0 then
											tClasses[#tClasses+1] = iR
										end
									end
								end
								for i, v in pairs(tClasses) do
									if tPlayerclassFilename == v then
										tFlagClass = true
									end
								end
																
								if tFlagClass == true then
									local tPreQuestsTable = {}
									if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
										for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]]) do
											tPreQuestsTable[vR] = vR
										end
									end
									if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
										for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]]) do
											tPreQuestsTable[vR] = vR
										end
									end
										
									local tAllCompletedFlag = true
									for iPQ, vPQ in pairs(tPreQuestsTable) do
										if C_QuestLog.IsQuestFlaggedCompleted(tonumber(vPQ)) == false then
											tAllCompletedFlag = false
										end
									end
									if tAllCompletedFlag == true then
										local tIsOk = true
										--dprint(i, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]])
										if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]] then
											local tFaction = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]][1]
											if tFaction then
												local tMinRep = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]][2]
												local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(tFaction)
												if earnedValue then
													if earnedValue < tMinRep then
														tIsOk = false
													end
												else
													tIsOk = false
												end
											end
										end
										if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]] then
											local tFaction = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]][1]
											if tFaction then
												local tMaxRep = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]][2]
												local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(tFaction)
												if earnedValue then
													if earnedValue > tMaxRep then
														tIsOk = false
													end
												else
													tIsOk = false
												end
											end
										end
											
										if SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]] then
											for x = 1, #SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]] do
												local tExQuestId = SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]][x]
												if C_QuestLog.IsQuestFlaggedCompleted(tExQuestId) == true then
													tIsOk = false
												end
												if tCurrentQuestLogQuestsTable[tExQuestId] then
													tIsOk = false
												end
											end
										end
										--['requiredSkill'] = 18, -- table: {skill(int), value(int)}
										--['requiredSourceItems'] = 21, -- table: {item(int), ...} Items that are not an objective but still needed for the quest.


										if tIsOk == true then
											tShowQuestsTable[i] = {textFull = GetQuestDataStringFromDB(i, tZoneId)}
										end
									end
								end
							end
						end
					end
				end
			end

			local tNewMenuSubEntryDist =SkuOptions:InjectMenuItems(self, {L["By distance"]}, SkuGenericMenuItem)
			tNewMenuSubEntryDist.dynamic = true
			tNewMenuSubEntryDist.filterable = true
			tNewMenuSubEntryDist.OnAction = function(self, aValue, aName)

			end
			tNewMenuSubEntryDist.BuildChildren = function(self)
				local tcount = 0
				local tUnSortedTable = {}
				local tIdTable = {}
				local tPlayerTopAreaId = SkuNav:GetAreaIdFromUiMapId(tUiMap)
				for i, v in pairs(tShowQuestsTable) do
				--dprint(i, v)
					local tDistanceToQuestGiver = 0
					if SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then
						local tQuestGiverID = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]
						if SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]] then
							if SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap] then
								local tSpawnX, tSpawnY = SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap][1][1], SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap][1][2]
								local tContintentId = select(3, SkuNav:GetAreaData(is))
								local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetUiMapIdFromAreaId(tUiMap), CreateVector2D(tonumber(tSpawnX) / 100, tonumber(tSpawnY) / 100))
								local tX, tY = worldPosition:GetXY()
								local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tX, tY)
								tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = tDistance
								tIdTable[tDistance..";Meter#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
							end
						end
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then
						local tObjectID = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]
						local tObjectData = SkuDB.objectDataTBC[tObjectID]
						local tObjectSpawns = tObjectData[SkuDB.objectKeys["spawns"]]
						if tObjectSpawns then
							if tObjectSpawns[tUiMap] then
								local tSpawnX, tSpawnY = tObjectSpawns[tUiMap][1][1], tObjectSpawns[tUiMap][1][2]
								local tContintentId = select(3, SkuNav:GetAreaData(is))
								local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetUiMapIdFromAreaId(tUiMap), CreateVector2D(tonumber(tSpawnX) / 100, tonumber(tSpawnY) / 100))
								local tX, tY = worldPosition:GetXY()
								local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tX, tY)
								tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = tDistance
								tIdTable[tDistance..";Meter#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
							end
						end
					else
						tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = 99999
						tIdTable["99999;Meter#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
					end

					if not tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] then
						tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = 99999
						tIdTable["99999;Meter#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
					end
				end

				local tSortedTable = {}
				for k,v in SkuSpairs(tUnSortedTable, function(t,a,b) return t[b] > t[a] end) do --nach wert
					tSortedTable[#tSortedTable+1] = v..";Meter#"..k
				end
				if #tSortedTable > 0 then
					for iS, vS in ipairs(tSortedTable) do
						local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {vS}, SkuGenericMenuItem)
						tNewSubMenuEntry2.OnEnter = function(self, aValue, aName)
							SkuOptions.currentMenuPosition.textFull = GetQuestDataStringFromDB(tIdTable[vS])
						end
						CreateQuestSubmenu(tNewSubMenuEntry2, tIdTable[vS])--iS)
						tcount = tcount + 1
					end
				else
					local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
				end
			end

			--[[
			local tNewMenuSubEntryDist =SkuOptions:InjectMenuItems(self, {"Nach Schwierigkeit"}, SkuGenericMenuItem)
			tNewMenuSubEntryDist.dynamic = true
			tNewMenuSubEntryDist.filterable = true
			]]
		end

		local tNewMenuSubEntry =SkuOptions:InjectMenuItems(self, {"Alle"}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		tNewMenuSubEntry.OnAction = function(self, aValue, aName)
			--SkuOptions.db:SetProfile(aName)
		end
		tNewMenuSubEntry.BuildChildren = function(self)
			local tNameCache = {}
			for i, v in pairs(SkuDB.questLookup[Sku.Loc]) do
				if SkuDB.questDataTBC[i] then
					local tZoneId
					if SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then --creatures
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1]
						tZoneId = SkuDB.NpcData.Data[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]][SkuDB.NpcData.Keys['zoneID']]
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then --objects
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2]
						if SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]] then
							tZoneId = SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]]
						end
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3] then --items
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3]
					end

					local tUniqueName = v[1]
					if not tNameCache[v[1]] then
						tNameCache[v[1]] = 0
					else
						tNameCache[v[1]] = tNameCache[v[1]] + 1
						tUniqueName = tUniqueName.." "..tNameCache[v[1]]
					end

					local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {tUniqueName}, SkuGenericMenuItem)
					tNewSubMenuEntry2.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = GetQuestDataStringFromDB(i, tZoneId)
					end
					if not CreateQuestSubmenu(tNewSubMenuEntry2, i) then
						--self.dynamic = false
					end
				end
			end
		end
	end


	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuQuest.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end

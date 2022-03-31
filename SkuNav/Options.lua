local MODULE_NAME = "SkuNav"
local L = Sku.L

SkuNav.ClickClackSoundsets = {
	["off"] = L["Nichts"],
	["click"] = L["Klick"],
	["beep"] = L["Ping"],
}

SkuNav.StandardWpReachedRanges = {
   [1] = L["1 Meter"],
   [2] = L["3 Meter"],
   [3] = L["Auto"],
}

SkuNav.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
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
		--[[
		includeDefaultMapWaypoints = {
			name = "Standard-WPs Karten",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].includeDefaultMapWaypoints = val
				SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
				SkuNav:PLAYER_ENTERING_WORLD()
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].includeDefaultMapWaypoints
			end
		},
		includeDefaultInkeeperWaypoints = {
			name = "Standard-WPs Gastwirte ",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].includeDefaultInkeeperWaypoints = val
				SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
				SkuNav:PLAYER_ENTERING_WORLD()
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].includeDefaultInkeeperWaypoints
			end
		},
		includeDefaultPostboxWaypoints = {
			name = "Standard-WPs Briefkästen",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].includeDefaultPostboxWaypoints = val
				SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
				SkuNav:PLAYER_ENTERING_WORLD()
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].includeDefaultPostboxWaypoints
			end
		},
		includeDefaultTaxiWaypoints = {
			name = "Standard-WPs Flugpunkte",
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].includeDefaultTaxiWaypoints = val
				SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
				SkuNav:PLAYER_ENTERING_WORLD()
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].includeDefaultTaxiWaypoints
			end
		},
]]		
		beaconVolume = {
			order = 2,
			name = L["Beacon Volume"],
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].beaconVolume = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].beaconVolume
			end
		},
		vocalizeFullDirectionDistance = {
			name = L["Detailed direction and distance"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].vocalizeFullDirectionDistance = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].vocalizeFullDirectionDistance
			end
		},
		vocalizeZoneNames = {
			name = L["Announce zone names"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames
			end
		},
		showRoutesOnMinimap = {
			name = L["Show routes on minimap"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap
			end
		},
		showSkuMM = {
			name = L["Show extra minimap"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].showSkuMM = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].showSkuMM
			end
		},
		nearbyWpRange = {
			order = 4,
			name = L["Range for near route starts"],
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].nearbyWpRange = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].nearbyWpRange
			end
		},
		tomtomWp = {
			order = 4,
			name = L["Auto sound on Tom Tom arrow"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].tomtomWp = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].tomtomWp
			end
		},
		standardWpReachedRange = {
			order = 4,
			name = L["Waypoint reached at"],
			desc = "",
			type = "select",
			values = SkuNav.StandardWpReachedRanges,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange
			end
		},
		clickClackEnabled = {
			order = 4,
			name = L["Klick bei Beacons"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].clickClackEnabled = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].clickClackEnabled
			end
		},
		clickClackRange = {
			order = 4,
			name = L["Winkel für Klick bei Beacons"],
			desc = "",
			type = "range",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].clickClackRange = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].clickClackRange
			end
		},
		clickClackSoundset = {
			order = 4,
			name = L["Ton für Klick bei Beacons"],
			desc = "",
			type = "select",
			values = SkuNav.ClickClackSoundsets,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].clickClackSoundset = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].clickClackSoundset
			end
		},
		autoGlobalDirection = {
			order = 4,
			name = L["Auto announce global direction"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].autoGlobalDirection = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoGlobalDirection
			end
		},
	}
}
---------------------------------------------------------------------------------------------------------------------------------------
SkuNav.defaults = {
	enable = true,
	--[[
	includeDefaultMapWaypoints = true,
	includeDefaultInkeeperWaypoints = true,
	includeDefaultPostboxWaypoints = true,
	includeDefaultTaxiWaypoints = true,
	]]
	beaconVolume = 100,
	vocalizeFullDirectionDistance = true,
	vocalizeZoneNames = true,
	showRoutesOnMinimap = false,
	showSkuMM = false,
	nearbyWpRange = 30,
	tomtomWp = false,
	standardWpReachedRange = 3,
	clickClackEnabled = true,
	clickClackRange = 5,
	clickClackSoundset = "beep",
	autoGlobalDirection = false,
}

local slower = string.lower
local sfind = string.find

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuSpairs(t, order)
	local tSFunction = function(a,b) return order(t, a, b) end
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, tSFunction)
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
local function SkuNav_MenuBuilder_WaypointSelectionMenu(aParent, aSortedWaypointList)
	--dprint("SkuNav_MenuBuilder_WaypointSelectionMenu")
	for i, waypointName in pairs(aSortedWaypointList) do
		local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {waypointName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC = nil
			SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil

			--select wp
			local tNewMenuEntrySub = SkuOptions:InjectMenuItems(self, {L["Auswählen"]}, SkuGenericMenuItem)
			tNewMenuEntrySub.OnEnter = function(self)
				SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC = self.parent.name
			end

			--close rts
			local tNewMenuEntrySub = SkuOptions:InjectMenuItems(self, {L["Nahe Routen"]}, SkuGenericMenuItem)
			tNewMenuEntrySub.dynamic = true
			tNewMenuEntrySub.BuildChildren = function(self)
				local tPlayX, tPlayY = UnitPosition("player")
				local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(tPlayX, tPlayY, SkuNav.MaxMetaEntryRange)--SkuOptions.db.profile["SkuNav"].nearbyWpRange)
				if string.find(SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC, "#") then
					SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC = string.sub(SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC, string.find(SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC, "#") + 1)
				end
				local wpTable = {SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC}
				local tCoveredWps = {}
				local tMaxAllowedDistanceToTargetWp = 500
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
					local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, nil, true)
					SkuOptions.db.profile["SkuNav"].metapathFollowingStart = SkuNav:GetCleanWpName(tSortedWaypointList[1])
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
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tResults[tV].metapathLength..";"..L["plus"]..";"..tResults[tV].distanceTargetWp..";"..L["Meter"].."#"..tV}, SkuGenericMenuItem)
								tNewMenuEntry.OnEnter = function(self, aValue, aName)
									SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
									SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
									SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = true
								end
								tCoveredWps[tV] = true
								--tHasContent = true
							end
						end
					end

					local tNewMenuGeneralSort = SkuOptions:InjectMenuItems(self, {L["Nach Name"]}, SkuGenericMenuItem)
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
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tV.."#"..tResults[tV].metapathLength..";"..L["plus"]..";"..tResults[tV].distanceTargetWp..";"..L["Meter"]}, SkuGenericMenuItem)
								tNewMenuEntry.OnEnter = function(self, aValue, aName)
									SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
									SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
									SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = true
								end
								tCoveredWps[tV] = true
								--tHasContent = true
							end
						end
					end
										
				end			

			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:MenuBuilder(aParentEntry)
	--dprint("SkuNav:MenuBuilder", aParentEntry)
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Deselect all"]}, SkuGenericMenuItem)
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		--dprint("Route und Wegpunkt abwählen", self.name, aName)
		SkuNav:EndFollowingWpOrRt()
		PlaySound(835)
	end

	--wps
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Waypoint"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:BuildMenuSegment_TitleBuilder(self, L["New"])
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--dprint("Wegpunkt neu OnAction", self.name, aName, self.TMPSize, self.selectTarget, self.selectTarget.name, self.selectTarget.TMPSize)
			--dprint(self.selectTarget.TMPSize)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			if aName == L["Nothing selected"] then
				return
			end

			if sfind(aName, L["Selected"]..";") > 0 then
				aName = string.sub(aName, string.len(L["Selected"]..";") + 1)
			end
			if SkuNav:GetWaypointData2(aName) then
				SkuOptions.Voice:OutputString(L["nicht erstellt"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["name schon vorhanden"], false, true, 0.3, true)
				return
			end

			local tRName = SkuNav:CreateWaypoint(aName, nil, nil, self.selectTarget.TMPSize or 1)
			if tRName then
				--PlaySound(835)
				SkuOptions.Voice:OutputString(L["Wegpunkt erstellt"], false, true, 0.2)
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Auswählen"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--dprint("OnAction Auswählen", self.name,aValue,  aName, SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC, SkuOptions.db.profile["SkuNav"].metapathFollowingStart)
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
				return
			end

			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuNav:EndFollowingWpOrRt()
			end

			if SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute then
				--close rt
				SkuOptions.db.profile["SkuNav"].metapathFollowing = false
				if SkuOptions.db.profile["SkuNav"].metapathFollowingStart then
					if SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths then
						if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
							SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, SkuOptions.db.profile["SkuNav"].metapathFollowingTarget, true)--
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[#SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths+1] = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget] = SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingTarget]
						table.insert(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget].pathWps, SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget)
						SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
						SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
						SkuOptions.db.profile["SkuNav"].metapathFollowing = true
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
						SkuOptions.Voice:OutputString(L["Metaroute folgen gestartet"], false, true, 0.2)
						SkuOptions:CloseMenu()
					end
				end
			else
				--just a wp
				if aName == L["Auswählen"] and SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC then
					local tUncleanValue = SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC
					local tCleanValue = SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC
					local tPos = string.find(tUncleanValue, "#")
					if tPos then
						tCleanValue = string.sub(tUncleanValue,  tPos + 1)
					end
					aName = tCleanValue
				end

				if (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Npc ~= "") and (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Zone ~= "") then
					aName = SkuOptions.tmpNpcWayPointNameBuilder_Npc..";"..SkuOptions.tmpNpcWayPointNameBuilder_Zone..";"..aName
					SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
				end

				if SkuNav:GetWaypointData2(aName) then
					SkuNav:SelectWP(aName)
					--dprint("auswahl", aName)
					--lastDirection = SkuNav:GetDirectionTo(worldx, worldy, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY)
					--PlaySound(835)
					SkuOptions:CloseMenu()
				else
					SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
					SkuOptions.Voice:OutputString(L["Wegpunkt nicht ausgewählt"], false, true, 0.3, true)
				end
			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
			--recent wps 
			if #SkuOptions.db.profile[MODULE_NAME].RecentWPs > 0 then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Recent"]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)
					for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].RecentWPs) do
						--dprint("recent: ", i, v)
					end
					if #SkuOptions.db.profile[MODULE_NAME].RecentWPs == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
					else
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, SkuOptions.db.profile[MODULE_NAME].RecentWPs, SkuGenericMenuItem)
					end
				end
			end

			--wps in current map sortet by range
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Aktuelle Karte Entfernung"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

				local tWaypointList = {}
				local tListWPs = SkuNav:ListWaypoints2(true, nil, tCurrentAreaId)
				if tListWPs then
					for i, v in SkuNav:ListWaypoints2(true, nil, tCurrentAreaId) do
						local tWayP = SkuNav:GetWaypointData2(v)
						if tWayP then
							if tSubAreaIds[tonumber(tWayP.areaId)] then
								if not sfind(v, L["auto"]..";") then
								--if not sfind(v, L["Quick waypoint"]) and not sfind(v, "auto;") then
									local tWpX, tWpY = tWayP.worldX, tWayP.worldY
									local tPlayX, tPlayY = UnitPosition("player")
									local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
									tWaypointList[v] = tDistance
								end
							end
						end
					end
				end
				for q = 1, 4 do
					local tWayP = SkuNav:GetWaypointData2(L["Quick waypoint"]..";"..q)
					if tWayP then
						if tSubAreaIds[tonumber(tWayP.areaId)] then
							local tWpX, tWpY = tWayP.worldX, tWayP.worldY
							local tPlayX, tPlayY = UnitPosition("player")
							local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							tWaypointList[L["Quick waypoint"]..";"..q] = tDistance
						end
					end
				end

				local tSortedWaypointList = {}
				for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
					table.insert(tSortedWaypointList, v..";"..L["Meter"].."#"..k)
				end
				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
				else
					--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, SkuGenericMenuItem)
					SkuNav_MenuBuilder_WaypointSelectionMenu(self, tSortedWaypointList)
				end
			end

			-- all wps
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Alle aktueller Kontinent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tWaypointList = SkuNav:ListWaypoints2(false, nil, nil, tPlayerContintentId, nil, true, true)
		
				if #tWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, SkuGenericMenuItem)
				end
			end

			--wps in current map sortet by range with auto wps
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Aktuelle Karte Entfernung mit Auto"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

				local tWaypointList = {}
				for i, v in SkuNav:ListWaypoints2(true, nil, tCurrentAreaId) do
					local tWayP = SkuNav:GetWaypointData2(v)
					if tWayP then
						if tSubAreaIds[tonumber(tWayP.areaId)] then
							if not sfind(v, L["Quick waypoint"]) then
								local tWpX, tWpY = tWayP.worldX, tWayP.worldY
								local tPlayX, tPlayY = UnitPosition("player")
								local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
								tWaypointList[v] = tDistance
							end
						end
					end
				end

				local tSortedWaypointList = {}
				for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
					table.insert(tSortedWaypointList, v..";"..L["Meter"].."#"..k)
				end
				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, SkuGenericMenuItem)
				end
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Abwählen"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--dprint("OnAction Aktuellen abwählen", self.name, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end

			if SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
					if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
						SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
					end
					SkuOptions.Voice:OutputString(L["Wegpunkt abgewählt"], false, true, 0.3, true)
					--SkuOptions.db.profile["SkuNav"].selectedWaypoint = ""
					SkuNav:SelectWP("", true)
				end
				--PlaySound(835)
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Verwalten"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			--
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Löschen"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
				--dprint("OnAction Löschen", self.name, aValue, aName, aChildName)
				if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
					SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
					SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
					return
				end
	
				if aName == L["Löschen"] then
					if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == aChildName then
						SkuNav:SelectWP("", true)
					end
					local wpObj = SkuNav:GetWaypointData2(aChildName)
					if wpObj then
						local tSuccess = SkuNav:DeleteWaypoint(aChildName)
						if tSuccess == true then
							SkuOptions.Voice:OutputString(L["Wegpunkt gelöscht"], false, true, 0.2)
						elseif tSuccess == false then
							SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
							SkuOptions.Voice:OutputString(L["Wird in route verwendet;Erst die Route löschen"], false, true, 0.3, true)
						else
							SkuOptions.Voice:OutputString(L["Unbekannter Fehler"], false, true, 0.3, true)
						end
					else
						SkuOptions.Voice:OutputString(L["Unbekannter Fehler"], false, true, 0.3, true)
					end
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints2(false, "custom", SkuNav:GetCurrentAreaId(), tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Löschen"]}, SkuGenericMenuItem)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Abbrechen"]}, SkuGenericMenuItem)
						end
					end
				end
			end

			--
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Umbenennen"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints2(false, "custom", SkuNav:GetCurrentAreaId(), tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							local tNewMenuEntry = SkuOptions:BuildMenuSegment_TitleBuilder(self, L["Umbenennen"])
							tNewMenuEntry.OnAction = function(self, aValue, aName)
								--dprint("Wegpunkt umbenennen OnAction", self.name, aName, self.TMPSize, self.selectTarget, self.selectTarget.name, "-", self.parent.name)
								--dprint(self.selectTarget.TMPSize)
								if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
									SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
									SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
									return
								end
								if aName == L["Nothing selected"] then
									return
								end
					
								if sfind(aName, L["Selected"]..";") > 0 then
									aName = string.sub(aName, string.len(L["Selected"]..";") + 1)
								end

								local tOldName = self.parent.name
								local tNewName = aName

								if SkuNav:GetWaypointData2(tNewName) then
									SkuOptions.Voice:OutputString(L["nicht umbenannt"], false, true, 0.3, true)
									SkuOptions.Voice:OutputString(L["name schon vorhanden"], false, true, 0.3, true)
									return
								end

								local tSuccess = SkuNav:RenameWaypoint(tOldName, tNewName) 
								if tSuccess == true then
									--C_Timer.NewTimer(0.1, function() SkuOptions:SlashFunc("short,SkuNav,Wegpunkt,Verwalten,Umbenennen") end)
									SkuOptions.Voice:OutputString(L["Wegpunkt umbenannt"], false, true, 0.2)
									SkuOptions:CloseMenu()
								else
									SkuOptions.Voice:OutputString(L["Error"], false, true, 0.2)
								end
							end
						end
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Kommentar zuweisen"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
				--dprint("OnAction Kommentar zuweisen", self, aValue, aName, aChildName)
				local tWpData = SkuNav:GetWaypointData2(aName)
				if tWpData then
					if tWpData.typeId ~= 1 then
						return
					end
					SkuOptions:EditBoxShow("test", function(a, b, c) 
						local tText = SkuOptionsEditBoxEditBox:GetText() 
						if tText ~= "" then
							if not tWpData.comments then
								tWpData.comments = {}
							end
							tWpData.comments[#tWpData.comments + 1] = tText
							SkuNav:SetWaypoint(aName, tWpData)
							SkuOptions.Voice:OutputString(L["Kommentar zugewiesen"], false, true, 0.3, true)
						else
							SkuOptions.Voice:OutputString(L["Kommentar leer"], false, true, 0.3, true)
						end
					end)
					SkuOptions.Voice:OutputString(L["Jetzt kommentar eingeben und mit ENTER abschließen oder mit ESC abbrechen"], false, true, 0.3, true)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints2(false, "custom", nil, tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
					end
				end
			end
		end
	end

	--rts
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Route folgen"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.isSelect = true
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		dprint("OnAction", self.name, aValue, aName)

		SkuNav:ClearWaypointsTemporary()

		if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
			SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
			SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
			return
		end

		--if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
			SkuNav:EndFollowingWpOrRt()
		end

		SkuOptions.db.profile[MODULE_NAME].metapathFollowing = false


		SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = SkuOptions.db.profile[MODULE_NAME].metapathFollowingStartTMP
		SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapathsTMP

		if SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypoint == true and SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData then
			if #SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData < 2 then
				return
			end

			if string.find(aName, ";") then
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName = string.sub(aName, 1, string.find(aName, ";") - 1)
			end
			
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = L["Einheiten;Route;"].."1"
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = L["Einheiten;Route;"]..#SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = {}
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[1] = SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget] = {
				pathWps = {},
				distance = 0,
			}
				
			--build metaroute table
			for x = 1, #SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData do
				--create tmp wps
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local isUiMap = SkuNav:GetUiMapIdFromAreaId(tCurrentAreaId)
				local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData[x][1] / 100, SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData[x][2] / 100))
				local tX, tY = worldPosition:GetXY()
				local tNameOfNewWp = SkuNav:CreateWaypoint(L["Einheiten;Route;"]..x, tX, tY, 1, true)
				if tNameOfNewWp then
					--add to mt rt
					SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary[#SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary + 1] = tNameOfNewWp
					table.insert(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps, tNameOfNewWp)
				end
			end

			local tDistance = 0
			local tDistanceToStartWp = 0
			for z = 2, #SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps do
				local tWpA = SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[z - 1])
				local tWpB = SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[z])
				tDistance = tDistance + SkuNav:Distance(tWpA.worldX, tWpA.worldY, tWpB.worldX, tWpB.worldY)
				if tDistanceToStartWp == 0 then
					tDistanceToStartWp = tDistance
				end
			end
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].distance = tDistance
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].distanceToStartWp = tDistanceToStartWp

			--start follow
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = 1
			SkuOptions.db.profile[MODULE_NAME].metapathFollowing = true

			SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, true)
			SkuOptions.Voice:OutputString(L["Einheiten Route folgen gestartet"], false, true, 0.2)
			SkuOptions:CloseMenu()
			return
		elseif SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart then
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths then
				if string.find(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, "#") then
					SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = string.sub(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, string.find(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, "#") + 1)
				end
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, aName)--
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = aName
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = 1
				SkuOptions.db.profile[MODULE_NAME].metapathFollowing = true

				SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, true)
				SkuOptions.Voice:OutputString(L["Metaroute folgen gestartet"], false, true, 0.2)

				SkuOptions:CloseMenu()
			end
		end
	end
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Ziele Entfernung"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			--SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
			--SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingStartTMP = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapathsTMP = nil
			local tPlayX, tPlayY = UnitPosition("player")
			local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(tPlayX, tPlayY, SkuNav.MaxMetaEntryRange)--SkuOptions.db.profile[MODULE_NAME].nearbyWpRange)

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

			for q = 2, #tSortedWaypointList do
				tSortedWaypointList[q] = nil
			end

			if #tSortedWaypointList == 0 then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
			else
				local tCount = 0
				for k, v in SkuSpairs(tSortedWaypointList) do
					if tCount < 10 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.filterable = true
						tNewMenuEntry.BuildChildren = function(self)
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingStartTMP = v
							local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(string.sub(v, string.find(v, "#") + 1), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs)--
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapathsTMP = tMetapaths

							local tData = {}
							for i, v in pairs(tMetapaths) do--
								tData[i] = tMetapaths[i].distance--
							end--

							local tSortedList = {}
							for k,v in SkuSpairs(tData, function(t,a,b) return t[b] > t[a] end) do
								table.insert(tSortedList, k)
							end

							if #tSortedList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedList) do
									local tDistText = tMetapaths[tV].distance..";"..L["Meter"]..""--
									if tMetapaths[tV].distance >= SkuNav.MaxMetaRange then
										tDistText = L["weit"]
									end
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistText.."#"..tV}, SkuGenericMenuItem)--
									tNewMenuEntry.OnEnter = function(self)
										SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypoint = nil
										SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData = nil
									end
			
								end
							end
						end
						tCount = tCount + 1
					end
				end
			end
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Einheiten Route"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypoint = nil
			--SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
			--SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingStartTMP = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapathsTMP = nil
	
			local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
			tUnitDbWaypointData = {}

			local tWaypointList = {}
			for i, v in pairs(SkuDB.NpcData.Names[Sku.Loc]) do
				if SkuDB.NpcData.Data[i] then
					local tSpawns = SkuDB.NpcData.Data[i][7]
					local tCreatureDbExtraWaypoints = SkuDB.NpcData.Data[i][8]
					if tSpawns and tCreatureDbExtraWaypoints then
						if tCreatureDbExtraWaypoints[tCurrentAreaId] then
							for is, vs in pairs(tSpawns) do
								if tCurrentAreaId == is then
									local tData = SkuDB.InternalAreaTable[is]
									if tData then
										local tNumberOfSpawns = #vs
										local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
										local tRolesString = ""
										if not tSubname then
											local tRoles = SkuNav:GetNpcRoles(v[1], i)
											if #tRoles > 0 then
												for i, v in pairs(tRoles) do
													tRolesString = tRolesString..";"..v
												end
												tRolesString = tRolesString..""
											end
										else
											tRolesString = tRolesString..";"..tSubname
										end
										for sp = 1, 1 do
											local tWayP = SkuNav:GetWaypointData2(v[1]..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])
											if tWayP then
												local tWpX, tWpY = tWayP.worldX, tWayP.worldY
												local tPlayX, tPlayY = UnitPosition("player")
												local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
												tWaypointList[v[1]..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]] = tDistance
												tUnitDbWaypointData[v[1]..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]] = tCreatureDbExtraWaypoints[tCurrentAreaId][1]
											end
										end
									end
								end
							end
						end
					end
				end
			end

			local tSortedWaypointList = {}
			for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
				table.insert(tSortedWaypointList, v..";"..L["Meter"].."#"..k)
			end
			if #tSortedWaypointList == 0 then
				local tNewMenuEntrySub = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
			else
				for i, v in pairs(tSortedWaypointList) do
					local tNewMenuEntrySub = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
					tNewMenuEntrySub.OnEnter = function(self)
						local tClearedName = self.name
						if sfind(tClearedName, "#") then
							tClearedName = string.sub(tClearedName, string.find(tClearedName, "#") + 1)
						end
						if tUnitDbWaypointData[tClearedName] then
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypoint = true
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingUnitDbWaypointData = tUnitDbWaypointData[tClearedName]
						end
					end
				end
			end
		end
	end

	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Daten"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Import"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			SkuOptions:ImportWpAndLinkData()
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Export"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			--SkuOptions:ExportWpAndRouteData()
			SkuOptions:ExportWpAndLinkData()
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Alle Routen und Wegpunkte löschen"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			SkuOptions.db.profile[MODULE_NAME].Routes = nil
			SkuOptions.db.profile["SkuNav"].RtAndWpVersion = 22

			SkuOptions.db.global[MODULE_NAME].Waypoints = {}
			SkuOptions.db.global[MODULE_NAME].Links = {}
			SkuNav:CreateWaypointCache()
			SkuOptions.Voice:OutputString(L["Alles gelöscht"], false, true, 0.3, true)
		end
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuNav.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
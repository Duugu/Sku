local MODULE_NAME = "SkuNav"
local L = Sku.L

SkuNav.ClickClackSoundsets = {
	["off"] = "Nichts",
	["click"] = "Klick",
	["beep"] = "Ping",
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
			name = L["reach intermediate waypoint at 3 meters"],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange
			end
		},
		clickClackEnabled = {
			order = 4,
			name = "Klick bei Beacons",
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
			name = "Winkel für Klick bei Beacons",
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
			name = "Ton für Klick bei Beacons" ,
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
	standardWpReachedRange = true,
	clickClackEnabled = true,
	clickClackRange = 5,
	clickClackSoundset = "click",
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
local SkuNav_MenuBuilder_PointX_OnAction = function(self, aValue, aName)
	--print("OnAction: SkuNav_MenuBuilder_PointX_OnAction --", self.name, aName, SkuOptions.tmpNpcWayPointNameBuilder_Npc, SkuOptions.tmpNpcWayPointNameBuilder_Zone, SkuOptions.tmpNpcWayPointNameBuilder_Coords)
	--print("SkuNav_MenuBuilder_PointX_OnAction", self.TMPSize, self.selectTarget, self.selectTarget.name, self.selectTarget.TMPSize)		
	self.parent.TMPSize = self.TMPSize

	if (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Npc ~= "") and (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Zone ~= "") then
		local tNpcWpName = SkuOptions.tmpNpcWayPointNameBuilder_Npc..";"..SkuOptions.tmpNpcWayPointNameBuilder_Zone..";"..aName
		self.parent:OnAction(self.parent, tNpcWpName, self.name)
		SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
	else
		SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
		if aName == L["Nothing selected"] then
			return
		end
		if sfind(aName, L["Selected"]..";") then
			aName = string.sub(aName, string.len(L["Selected"]..";") + 1)
		end
		self.parent:OnAction(self.parent, aName, self.name)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuNav_MenuBuilder_PointX_BuildChildren = function(self)
	if self.name == L["Point B"] and self.parent.name ~= L["Complete recording"] then
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Set on completion"]}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
	end
	local tNewMenuEntry = SkuOptions:BuildMenuSegment_TitleBuilder(self, L["New"])
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		--print("SkuNav_MenuBuilder_PointX_BuildChildren", self.selectTarget, self.selectTarget.name, self.selectTarget.TMPSize)		
		self.parent.TMPSize = self.selectTarget.TMPSize
		--print("OnAction Neu --", self.name, self, aValue, aName)
		if aName == L["Nothing selected"] then
			return
		end
		if sfind(aName, L["Selected"]..";") > 0 then
			aName = string.sub(aName, string.len(L["Selected"]..";") + 1)
		end
		--print(aName, SkuNav:GetWaypoint(aName))
		if SkuNav:GetWaypoint(aName) then
			SkuOptions.Voice:OutputString(L["not created"], false, true, 0.3, true)
			SkuOptions.Voice:OutputString(L["name already exists"], false, true, 0.3, true)
			return
		else
			self.parent:OnAction(self.parent, aName, self.name)
		end

	end

	--sub with recent wps 
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["History"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].RecentWPs) do
			--print("recent: ", i, v)
		end
		if #SkuOptions.db.profile[MODULE_NAME].RecentWPs == 0 then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, SkuOptions.db.profile[MODULE_NAME].RecentWPs, menuEntryTemplate_Menu)
		end
	end
	--sub with wps in current map
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Current map"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
		local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
		tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

		local excludeRoute
		if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
			excludeRoute = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute
		end

		local tWaypointList = {}
		for i, v in SkuNav:ListWaypoints(true, nil, tCurrentAreaId, nil, excludeRoute) do
			local tWaypoint = SkuNav:GetWaypoint(v)
			if tWaypoint then
				if tSubAreaIds[tWaypoint.areaId] then
					if not sfind(v, L["Quick waypoint"]) and not sfind(v, L["auto"]..";") then
						table.insert(tWaypointList, v)
					end
				end
			end
		end

		if #tWaypointList == 0 then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
	end
	--sub with wps in current map sortet by range
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Current map distance"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
		local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
		tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

		local excludeRoute
		if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
			excludeRoute = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute
		end

		local tWaypointList = {}
		for i, v in SkuNav:ListWaypoints(true, nil, tCurrentAreaId, nil, excludeRoute) do
			local tWayP = SkuNav:GetWaypoint(v)
			if tWayP then
				if tSubAreaIds[tWayP.areaId] then
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
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, menuEntryTemplate_Menu)
		end
	end
	-- all wps sortet by name
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
		local tWaypointList = SkuNav:ListWaypoints(false, nil, nil, tPlayerContintentId, nil, true, true)--aSort, aFilter, aAreaId, aContinentId, aExcludeRoute, aRetAsTable

		if #tWaypointList == 0 then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
	end
	-- SkuNav.DefaultWaypoints
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Default Waypoints"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		--.Zones
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Zones"]}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)--continents
			local tWaypointList = {}
			for q = 1, #SkuDB.DefaultWaypoints2.Zones do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[q]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)--continents
					for q = 1, #SkuDB.DefaultWaypoints2.Zones[self.name] do
						local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[self.name][q]}, menuEntryTemplate_Menu)
						tNewMenuEntry1.dynamic = true
						tNewMenuEntry1.filterable = true
						tNewMenuEntry1.BuildChildren = function(self)--maps
							for q = 1, #SkuDB.DefaultWaypoints2.Zones[self.parent.name][self.name] do
								local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
							end
						end
					end
				end
			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
		--[[
		-- .Innkeepers
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Gasthäuser"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)--h/a
			local tWaypointList = {}
			for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[q]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)--wp
					for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers[self.name] do
						local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[self.name][q]}, menuEntryTemplate_Menu)
						--tNewMenuEntry1.dynamic = true
--tNewMenuEntry1.filterable = true
						--tNewMenuEntry1.BuildChildren = function(self)--maps
							--for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers[self.parent.name][self.name] do
								--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
							--end
						--end
					end
				end
			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
		-- .Taxi
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Flugpunkte"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)--h/a
			local tWaypointList = {}
			for q = 1, #SkuDB.DefaultWaypoints2.Taxi do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[q]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)--wps
					for q = 1, #SkuDB.DefaultWaypoints2.Taxi[self.name] do
						local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[self.name][q]}, menuEntryTemplate_Menu)
						--tNewMenuEntry1.dynamic = true
						--tNewMenuEntry1.BuildChildren = function(self)--maps
							--for q = 1, #SkuDB.DefaultWaypoints2.Taxi[self.parent.name][self.name] do
								--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
							--end
						--end
					end
				end
			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
		]]
		-- .Postbox
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Mailboxes"]}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)--continents
			local tWaypointList = {}
			for q = 1, #SkuDB.DefaultWaypoints2.Postbox do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[q]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)--continents
					for q = 1, #SkuDB.DefaultWaypoints2.Postbox[self.name] do
						local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[self.name][q]}, menuEntryTemplate_Menu)
						--tNewMenuEntry1.dynamic = true
						--tNewMenuEntry1.BuildChildren = function(self)--maps
							--for q = 1, #SkuDB.DefaultWaypoints2.Postbox[self.parent.name][self.name] do
								--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
							--end
						--end
					end
				end
			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
		end
	end
	--all npcs
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All NPCs"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		--this is going to be a quite big menu, dedicated free memory & gc just in case the user selects it many times
		self.children = {}
		--collectgarbage("collect")
		local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
		local tWaypointList = {}
		for i, v in pairs(SkuDB.NpcData.NamesDE) do
			local tHasValidSpawns = false
			if not sfind((SkuDB.NpcData.Data[i][1]), "UNUSED") then
				local tSpawns = SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]
				if tSpawns then
					for is, vs in pairs(tSpawns) do
						if tHasValidSpawns == false then
							if SkuDB.InternalAreaTable[is] then
								local tCID = SkuDB.InternalAreaTable[is].ContinentID
								local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
								if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (#vs > 0 ) and (tPlayerContintentId == tCID) then
									tHasValidSpawns = true
								end
							end
						end
					end
				end
			end
			if tHasValidSpawns == true then
				local tSubname = SkuDB.NpcData.NamesDE[i][2]
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
				table.insert(tWaypointList, v[1]..tRolesString)
			end
		end

		if #tWaypointList > 0 then
			SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
			SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
			SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
			local tSortedWaypointList = {}
			for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
				table.insert(tSortedWaypointList, v)
			end
			if #tSortedWaypointList > 0 then
				for z = 1, #tSortedWaypointList do
					--print(z, tSortedWaypointList[z])
					local tMenuName = tSortedWaypointList[z]
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuName}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.filterable = true
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions.tmpNpcWayPointNameBuilder_Npc = self.name
						local tTMenuNameJustNpcName = string.split(";", tMenuName)
						for i1, v1 in pairs(SkuDB.NpcData.NamesDE) do
							if v1[1] == tTMenuNameJustNpcName then
								if SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]] then
									for is, vs in pairs(SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]]) do
										if SkuDB.InternalAreaTable[is] then
											local tCID = SkuDB.InternalAreaTable[is].ContinentID
											local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
											if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (tPlayerContintentId == tCID) then
												--is l1 zone and no instance
												local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.InternalAreaTable[is].AreaName_lang}, menuEntryTemplate_Menu)
												tNewMenuEntry.dynamic = true
												tNewMenuEntry.filterable = true
												tNewMenuEntry.BuildChildren = function(self)
													SkuOptions.tmpNpcWayPointNameBuilder_Zone = self.name
													for sp = 1, #vs do
														local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {sp..";"..vs[sp][1]..";"..vs[sp][2]}, menuEntryTemplate_Menu)
														SkuOptions.tmpNpcWayPointNameBuilder_Coords = self.name
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	--all npcs in zone
	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All NPCs in zone"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.BuildChildren = function(self)
		--this is going to be a quite big menu, dedicated free memory & gc just in case the user selects it many times
		self.children = {}
		--collectgarbage("collect")
		local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
		local tPlayerAreaId = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())
		local tWaypointList = {}
		for i, v in pairs(SkuDB.NpcData.NamesDE) do
			local tHasValidSpawns = false
			if not sfind((SkuDB.NpcData.Data[i][1]), "UNUSED") then
				local tSpawns = SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]
				if tSpawns then
					for is, vs in pairs(tSpawns) do
						if tHasValidSpawns == false then
							if SkuDB.InternalAreaTable[is] then
								local tCID = SkuDB.InternalAreaTable[is].ContinentID
								local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
								if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (#vs > 0 ) and (tPlayerContintentId == tCID) then
									if tPlayerAreaId == SkuNav:GetUiMapIdFromAreaId(is) then
										tHasValidSpawns = true
									end
								end
							end
						end
					end
				end
			end
			if tHasValidSpawns == true then
				local tSubname = SkuDB.NpcData.NamesDE[i][2]
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
				table.insert(tWaypointList, v[1]..tRolesString)
			end
		end

		if #tWaypointList > 0 then
			SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
			SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
			SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
			local tSortedWaypointList = {}
			for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
				table.insert(tSortedWaypointList, v)
			end
			if #tSortedWaypointList > 0 then
				for z = 1, #tSortedWaypointList do
					--print(z, tSortedWaypointList[z])
					local tMenuName = tSortedWaypointList[z]
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuName}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.filterable = true
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions.tmpNpcWayPointNameBuilder_Npc = self.name
						local tTMenuNameJustNpcName = string.split(";", tMenuName)
						for i1, v1 in pairs(SkuDB.NpcData.NamesDE) do
							if v1[1] == tTMenuNameJustNpcName then
								if SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]] then
									for is, vs in pairs(SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]]) do
										if SkuDB.InternalAreaTable[is] then
											local tCID = SkuDB.InternalAreaTable[is].ContinentID
											local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
											if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (tPlayerContintentId == tCID) then
												--is l1 zone and no instance
												if tPlayerAreaId == SkuNav:GetUiMapIdFromAreaId(is) then
													local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.InternalAreaTable[is].AreaName_lang}, menuEntryTemplate_Menu)
													tNewMenuEntry.dynamic = true
													tNewMenuEntry.filterable = true
													tNewMenuEntry.BuildChildren = function(self)
														SkuOptions.tmpNpcWayPointNameBuilder_Zone = self.name
														for sp = 1, #vs do
															local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {sp..";"..vs[sp][1]..";"..vs[sp][2]}, menuEntryTemplate_Menu)
															SkuOptions.tmpNpcWayPointNameBuilder_Coords = self.name
														end
													end
												end
											end
										end
									end
								end
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
	--print("SkuNav:MenuBuilder", aParentEntry)
	--wegpunkte
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Deselect all"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		--print("Route und Wegpunkt abwählen", self.name, aName)
		SkuNav:EndFollowingWpOrRt()
		PlaySound(835)
	end

	--wps
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Waypoint"]}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)

		local tNewMenuEntry = SkuOptions:BuildMenuSegment_TitleBuilder(self, L["New"])
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("Wegpunkt neu OnAction", self.name, aName, self.TMPSize, self.selectTarget, self.selectTarget.name, self.selectTarget.TMPSize)
			--print(self.selectTarget.TMPSize)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing  == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
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
			if SkuNav:GetWaypoint(aName) then
				SkuOptions.Voice:OutputString("nicht erstellt", false, true, 0.3, true)
				SkuOptions.Voice:OutputString("name schon vorhanden", false, true, 0.3, true)
				return
			end

			local tRName = SkuNav:CreateWaypoint(aName, nil, nil, self.selectTarget.TMPSize or 1)
			if tRName then
				--PlaySound(835)
				SkuOptions.Voice:OutputString("Wegpunkt erstellt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Auswählen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction Auswählen", self.name,aValue,  aName, SkuOptions.tmpNpcWayPointNameBuilder_Npc)
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
				return
			end

			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuNav:EndFollowingWpOrRt()
			end

			if (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Npc ~= "") and (SkuOptions.tmpNpcWayPointNameBuilder_Npc and SkuOptions.tmpNpcWayPointNameBuilder_Zone ~= "") then
				aName = SkuOptions.tmpNpcWayPointNameBuilder_Npc..";"..SkuOptions.tmpNpcWayPointNameBuilder_Zone..";"..aName
				SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
				SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
				SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
			end

			if SkuNav:GetWaypoint(aName) then
				SkuNav:SelectWP(aName)
				--print("auswahl", aName)
				--lastDirection = SkuNav:GetDirectionTo(worldx, worldy, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY)
				--PlaySound(835)
				if _G["OnSkuOptionsMain"]:IsVisible() == true then
					_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
				end
			else
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("Wegpunkt nicht ausgewählt", false, true, 0.3, true)
			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			--sub with recent wps 
			if #SkuOptions.db.profile[MODULE_NAME].RecentWPs > 0 then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Letzte"}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)
					for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].RecentWPs) do
						--print("recent: ", i, v)
					end
					if #SkuOptions.db.profile[MODULE_NAME].RecentWPs == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
					else
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, SkuOptions.db.profile[MODULE_NAME].RecentWPs, menuEntryTemplate_Menu)
					end
				end
			end

			--sub with wps in current map
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Aktuelle Karte"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

				local tWaypointList = {}
				for i, v in SkuNav:ListWaypoints(true, nil, tCurrentAreaId) do
					local tWaypoint = SkuNav:GetWaypoint(v)
					if tWaypoint then
						if tSubAreaIds[tWaypoint.areaId] then
							if not sfind(v, L["Quick waypoint"]) and not sfind(v, "auto;") then
								table.insert(tWaypointList, v)
							end
						end
					end
				end

				if #tWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
				end
			end
			--sub with wps in current map sortet by range
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Aktuelle Karte Entfernung"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

				local tWaypointList = {}
				for i, v in SkuNav:ListWaypoints(true, nil, tCurrentAreaId) do
					local tWayP = SkuNav:GetWaypoint(v)
					if tWayP then
						if tSubAreaIds[tonumber(tWayP.areaId)] then
							if not sfind(v, L["Quick waypoint"]) and not sfind(v, "auto;") then
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
					table.insert(tSortedWaypointList, v..";Meter#"..k)
				end
				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, menuEntryTemplate_Menu)
				end
			end

			-- all wps sortet by name
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tWaypointList = SkuNav:ListWaypoints(false, nil, nil, tPlayerContintentId, nil, true, true)--aSort, aFilter, aAreaId, aContinentId, aExcludeRoute, aRetAsTable
		
				if #tWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
				end
			end

			--all npcs
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All NPCs"]}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				--this is going to be a quite big menu, dedicated free memory & gc just in case the user selects it many times
				self.children = {}
				--collectgarbage("collect")
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tWaypointList = {}
				for i, v in pairs(SkuDB.NpcData.NamesDE) do
					local tHasValidSpawns = false
					if SkuDB.NpcData.Data[i] then
						if not sfind((SkuDB.NpcData.Data[i][1]), "UNUSED") then
							local tSpawns = SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]
							if tSpawns then
								for is, vs in pairs(tSpawns) do
									if tHasValidSpawns == false then
										if SkuDB.InternalAreaTable[is] then
											local tCID = SkuDB.InternalAreaTable[is].ContinentID
											local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
											if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (#vs > 0 ) and (tPlayerContintentId == tCID) then
												tHasValidSpawns = true
											end
										end
									end
								end
							end
						end
						if tHasValidSpawns == true then
							local tSubname = SkuDB.NpcData.NamesDE[i][2]
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
							table.insert(tWaypointList, v[1]..tRolesString)
						end
					end
				end

				if #tWaypointList > 0 then
					SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
					local tSortedWaypointList = {}
					for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
						table.insert(tSortedWaypointList, v)
					end
					if #tSortedWaypointList > 0 then
						for z = 1, #tSortedWaypointList do
							--print(z, tSortedWaypointList[z])
							local tMenuName = tSortedWaypointList[z]
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuName}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								--SkuOptions.tmpNpcWayPointNameBuilder_Npc = self.name
								local tTMenuNameJustNpcName = string.split(";", tMenuName)
								for i1, v1 in pairs(SkuDB.NpcData.NamesDE) do
									if v1[1] == tTMenuNameJustNpcName then
										if SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]] then
											for is, vs in pairs(SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]]) do
												if SkuDB.InternalAreaTable[is] then
													local tCID = SkuDB.InternalAreaTable[is].ContinentID
													local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
													if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (tPlayerContintentId == tCID) then
														--is l1 zone and no instance
														local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.InternalAreaTable[is].AreaName_lang}, menuEntryTemplate_Menu)
														tNewMenuEntry.dynamic = true
														tNewMenuEntry.filterable = true
														tNewMenuEntry.BuildChildren = function(self)
															SkuOptions.tmpNpcWayPointNameBuilder_Zone = self.name

															local tWaypointList = {}
															for sp = 1, #vs do
																local tWpName = self.parent.name..";"..SkuOptions.tmpNpcWayPointNameBuilder_Zone..";"..sp..";"..vs[sp][1]..";"..vs[sp][2], tWayP
																local tWayP = SkuNav:GetWaypoint(tWpName)
																--print(tWpName, tWayP)
																if tWayP then
																	if not sfind(tWpName, L["Quick waypoint"]) then
																		local tWpX, tWpY = tWayP.worldX, tWayP.worldY
																		local tPlayX, tPlayY = UnitPosition("player")
																		local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
																		tWaypointList[tWpName] = tDistance
																	end
																end
															end
															local tSortedWaypointList = {}
															for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
																table.insert(tSortedWaypointList, v..";Meter#"..k)
															end
															if #tSortedWaypointList == 0 then
																local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
															else
																local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, menuEntryTemplate_Menu)
															end
															--for sp = 1, #vs do
--																print(sp..";"..vs[sp][1]..";"..vs[sp][2])
																--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {sp..";"..vs[sp][1]..";"..vs[sp][2]}, menuEntryTemplate_Menu)
																--SkuOptions.tmpNpcWayPointNameBuilder_Coords = self.name
															--end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			--all npcs in zone
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle NPCs in Zone"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				--this is going to be a quite big menu, dedicated free memory & gc just in case the user selects it many times
				self.children = {}
				--collectgarbage("collect")
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tPlayerAreaId = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())
				local tWaypointList = {}
				for i, v in pairs(SkuDB.NpcData.NamesDE) do
					local tHasValidSpawns = false
					if SkuDB.NpcData.Data[i] then
						if not sfind((SkuDB.NpcData.Data[i][1]), "UNUSED") then
							local tSpawns = SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]
							if tSpawns then
								for is, vs in pairs(tSpawns) do
									if tHasValidSpawns == false then
										if SkuDB.InternalAreaTable[is] then
											local tCID = SkuDB.InternalAreaTable[is].ContinentID
											local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
											if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (#vs > 0 ) and (tPlayerContintentId == tCID) then
												if tPlayerAreaId == SkuNav:GetUiMapIdFromAreaId(is) then
													tHasValidSpawns = true
												end
											end
										end
									end
								end
							end
						end
						if tHasValidSpawns == true then
							local tSubname = SkuDB.NpcData.NamesDE[i][2]
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
							table.insert(tWaypointList, v[1]..tRolesString)
						end
					end
				end

				if #tWaypointList > 0 then
					SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
					SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""
					local tSortedWaypointList = {}
					for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
						table.insert(tSortedWaypointList, v)
					end
					if #tSortedWaypointList > 0 then
						for z = 1, #tSortedWaypointList do
							--print(z, tSortedWaypointList[z])
							local tMenuName = tSortedWaypointList[z]
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuName}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								SkuOptions.tmpNpcWayPointNameBuilder_Npc = self.name
								local tTMenuNameJustNpcName = string.split(";", tMenuName)
								for i1, v1 in pairs(SkuDB.NpcData.NamesDE) do
									if v1[1] == tTMenuNameJustNpcName then
										if SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]] then
											for is, vs in pairs(SkuDB.NpcData.Data[i1][SkuDB.NpcData.Keys["spawns"]]) do
												if SkuDB.InternalAreaTable[is] then
													local tCID = SkuDB.InternalAreaTable[is].ContinentID
													local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
													if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (tPlayerContintentId == tCID) then
														--is l1 zone and no instance
														if tPlayerAreaId == SkuNav:GetUiMapIdFromAreaId(is) then
															local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.InternalAreaTable[is].AreaName_lang}, menuEntryTemplate_Menu)
															tNewMenuEntry.dynamic = true
															tNewMenuEntry.filterable = true
															tNewMenuEntry.BuildChildren = function(self)
																SkuOptions.tmpNpcWayPointNameBuilder_Zone = self.name
																for sp = 1, #vs do
																	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {sp..";"..vs[sp][1]..";"..vs[sp][2]}, menuEntryTemplate_Menu)
																	SkuOptions.tmpNpcWayPointNameBuilder_Coords = self.name
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			-- SkuNav.DefaultWaypoints
			--if SkuOptions.db.profile[MODULE_NAME].includeDefaultMapWaypoints == true  or SkuOptions.db.profile[MODULE_NAME].includeDefaultInkeeperWaypoints == true or SkuOptions.db.profile[MODULE_NAME].includeDefaultTaxiWaypoints == true or SkuOptions.db.profile[MODULE_NAME].includeDefaultPostboxWaypoints == true then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Default Waypoints"]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					--.Zones
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Zones"]}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)--continents
						local tWaypointList = {}
						for q = 1, #SkuDB.DefaultWaypoints2.Zones do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[q]}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.BuildChildren = function(self)--continents
								for q = 1, #SkuDB.DefaultWaypoints2.Zones[self.name] do
									local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[self.name][q]}, menuEntryTemplate_Menu)
									tNewMenuEntry1.dynamic = true
									tNewMenuEntry1.filterable = true
									tNewMenuEntry1.BuildChildren = function(self)--maps
										for q = 1, #SkuDB.DefaultWaypoints2.Zones[self.parent.name][self.name] do
											local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Zones[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
										end
									end
								end
							end
						end
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
					end
					--[[
					-- .Innkeepers
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Gasthäuser"}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)--h/a
						local tWaypointList = {}
						for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[q]}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)--wp
								for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers[self.name] do
									local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[self.name][q]}, menuEntryTemplate_Menu)
									--tNewMenuEntry1.dynamic = true
									--tNewMenuEntry1.filterable = true
									--tNewMenuEntry1.BuildChildren = function(self)--maps
										--for q = 1, #SkuDB.DefaultWaypoints2.Innkeepers[self.parent.name][self.name] do
											--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Innkeepers[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
										--end
									--end
								end
							end
						end
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
					end
					-- .Taxi
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Flugpunkte"}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)--h/a
						local tWaypointList = {}
						for q = 1, #SkuDB.DefaultWaypoints2.Taxi do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[q]}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)--wps
								for q = 1, #SkuDB.DefaultWaypoints2.Taxi[self.name] do
									local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[self.name][q]}, menuEntryTemplate_Menu)
									--tNewMenuEntry1.dynamic = true
									--tNewMenuEntry1.BuildChildren = function(self)--maps
										--for q = 1, #SkuDB.DefaultWaypoints2.Taxi[self.parent.name][self.name] do
											--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Taxi[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
										--end
									--end
								end
							end
						end
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
					end
					]]
					-- .Postbox
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Briefkästen"}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)--continents
						local tWaypointList = {}
						for q = 1, #SkuDB.DefaultWaypoints2.Postbox do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[q]}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)--continents
								for q = 1, #SkuDB.DefaultWaypoints2.Postbox[self.name] do
									local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[self.name][q]}, menuEntryTemplate_Menu)
									--tNewMenuEntry1.dynamic = true
									--tNewMenuEntry1.BuildChildren = function(self)--maps
										--for q = 1, #SkuDB.DefaultWaypoints2.Postbox[self.parent.name][self.name] do
											--local tNewMenuEntry2 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints2.Postbox[self.parent.name][self.name][q]}, menuEntryTemplate_Menu)--areas
										--end
									--end
								end
							end
						end
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tWaypointList, menuEntryTemplate_Menu)
					end
				end
			--end

			--sub with wps in current map sortet by range
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Aktuelle Karte Entfernung mit Auto"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId

				local tWaypointList = {}
				for i, v in SkuNav:ListWaypoints(true, nil, tCurrentAreaId) do
					local tWayP = SkuNav:GetWaypoint(v)
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
					table.insert(tSortedWaypointList, v..";Meter#"..k)
				end
				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedWaypointList, menuEntryTemplate_Menu)
				end
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abwählen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction Aktuellen abwählen", self.name, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end

			if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
					if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
						SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
					end
					SkuOptions.Voice:OutputString("Wegpunkt abgewählt", false, true, 0.3, true)
					--SkuOptions.db.profile["SkuNav"].selectedWaypoint = ""
					SkuNav:SelectWP("", true)
				end
				--PlaySound(835)
			end
		end



		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Verwalten"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			--
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
				--print("OnAction Löschen", self.name, aValue, aName, aChildName)
				if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
					SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
					SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
					return
				end
	
				if aName == "Löschen" then
					if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == aChildName then
						SkuNav:SelectWP("", true)
					end
					local wpObj = SkuNav:GetWaypoint(aChildName)
					if wpObj then
						local tSuccess = SkuNav:DeleteWaypoint(aChildName)
						if tSuccess == true then
							SkuOptions.Voice:OutputString("Wegpunkt gelöscht", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
							SkuNeighbCache = {}
							if tCacheNbWpsTimer then
								tCacheNbWpsTimer:Cancel()
							end
							CacheNbWps()		
						elseif tSuccess == false then
							SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
							SkuOptions.Voice:OutputString("Wir in route verwendet;Erst die Route löschen", false, true, 0.3, true)
						else
							SkuOptions.Voice:OutputString("Unbekannter Fehler", false, true, 0.3, true)
						end
					else
						SkuOptions.Voice:OutputString("Unbekannter Fehler", false, true, 0.3, true)
					end
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints(false, "custom", SkuNav:GetCurrentAreaId(), tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abbrechen"}, menuEntryTemplate_Menu)
						end
					end
				end
			end

			--
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Umbenennen"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints(false, "custom", SkuNav:GetCurrentAreaId(), tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							local tNewMenuEntry = SkuOptions:BuildMenuSegment_TitleBuilder(self, "Umbenennen")
							tNewMenuEntry.OnAction = function(self, aValue, aName)
								--print("Wegpunkt umbenennen OnAction", self.name, aName, self.TMPSize, self.selectTarget, self.selectTarget.name, "-", self.parent.name)
								--print(self.selectTarget.TMPSize)
								if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing  == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
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

								if SkuNav:GetWaypoint(tNewName) then
									SkuOptions.Voice:OutputString("nicht umbenannt", false, true, 0.3, true)
									SkuOptions.Voice:OutputString("name schon vorhanden", false, true, 0.3, true)
									return
								end

								local tSuccess = SkuNav:RenameWaypoint(tOldName, tNewName) 
								if tSuccess == true then
									--C_Timer.NewTimer(0.1, function() SkuOptions:SlashFunc("short,SkuNav,Wegpunkt,Verwalten,Umbenennen") end)
									SkuOptions.Voice:OutputString("Wegpunkt umbenannt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
									if _G["OnSkuOptionsMain"]:IsVisible() == true then
										_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
									end
									SkuNeighbCache = {}
									if tCacheNbWpsTimer then
										tCacheNbWpsTimer:Cancel()
									end
									CacheNbWps()		
								else
									SkuOptions.Voice:OutputString(L["Error"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
								end
							end
						end
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Kommentar zuweisen"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
				--print("OnAction Kommentar zuweisen", self, aValue, aName, aChildName)
				if SkuNav:GetWaypoint(aName) then
					SkuOptions:EditBoxShow("test", function(a, b, c) 
						local tText = SkuOptionsEditBoxEditBox:GetText() 
						if tText ~= "" then
							if not SkuOptions.db.profile["SkuNav"].Waypoints[aName].comments then
								SkuOptions.db.profile["SkuNav"].Waypoints[aName].comments = {}
							end
							SkuOptions.db.profile["SkuNav"].Waypoints[aName].comments[#SkuOptions.db.profile["SkuNav"].Waypoints[aName].comments + 1] = tText
							SkuOptions.Voice:OutputString("Kommentar zugewiesen", false, true, 0.3, true)
						else
							SkuOptions.Voice:OutputString("Kommentar leer", false, true, 0.3, true)
						end
					end)
					SkuOptions.Voice:OutputString("Jetzt kommentar eingeben und mit ENTER abschließen oder mit ESC abbrechen", false, true, 0.3, true)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tWaypointList = {}
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				for i, v in SkuNav:ListWaypoints(false, "custom", SkuNav:GetCurrentAreaId(), tPlayerContinentID) do --aSort, aFilter, aAreaId, aContinentId, aExcludeRoute
					if not sfind(v, L["Quick waypoint"]) then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
					end
				end
			end
		end
	end

	--rts
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {"Route"}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neue Route"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.tmpWPA = nil
		tNewMenuEntry.tmpWPB = nil
		tNewMenuEntry.tmpIntWP = nil
		tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
			--print("Neue Route OnAction", self.TMPSize)
			--print("OnAction: Neue Route AB --", self.name, aName, aChildName, self.tmpWPA, self.tmpWPB)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end

			if aChildName == "Punkt A" then
				self.tmpWPA = aName
				self.tmpWPASize = self.TMPSize or 1
			end
			if aChildName == L["Point B"] then
				self.tmpWPB = aName
				self.tmpWPBSize = self.TMPSize or 1
			end
			if aChildName == "Zwischenpunkte" then
				self.tmpIntWP = aName
			end

			if self.tmpWPA == nil then
				SkuOptions.Voice:OutputString("Punkt A fehlt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
			end
			if self.tmpWPB == nil then
				SkuOptions.Voice:OutputString("Punkt B fehlt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
			end

			self.TMPSize = nil

			--a/b setup complete
			if self.tmpWPA and self.tmpWPB then
				local tIntWPmethod = self.tmpIntWP or L["Manually"]
				local tWpNameA = self.tmpWPA
				local tWpNameB = self.tmpWPB

				tWpNameA = tWpNameA:gsub( ";;", ";")
				if tWpNameA:sub(1, 1) == ";" then tWpNameA = tWpNameA:sub(2) end
				tWpNameB = tWpNameB:gsub( ";;", ";")
				if tWpNameB:sub(1, 1) == ";" then tWpNameB = tWpNameB:sub(2) end

				--print(tWpNameA, tWpNameB)

				SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
				SkuOptions.db.profile[MODULE_NAME].routeRecordingSizeOfB = self.tmpWPBSize
				SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil

				--if a exists lead to a first
				if SkuNav:GetWaypoint(tWpNameA) then
					SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = tWpNameA
					SkuNav:SelectWP(tWpNameA, false)
				else
					--if not add it
					--tWpNameA = "R;"..tWpNameA
					SkuNav:CreateWaypoint(tWpNameA, nil, nil, self.tmpWPASize)
				end

				--if not lead to A req and B exists lead to B
				if SkuNav:GetWaypoint(tWpNameB) then
					SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = tWpNameB
					if not SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
						SkuNav:SelectWP(tWpNameB, false)
					end
				else
					--if not add it
					--tWpNameB = "R;"..tWpNameB
					--SkuNav:CreateWaypoint(tWpNameB)
					--print("B neu erstellt", tWpNameB)
				end

				local tRouteName = tWpNameA..";nach;"..tWpNameB
				--check if route name exists and increment if
				if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName] then
					local q = 1
					while SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName..q] do
						q = q + 1
					end
					tRouteName = tRouteName..q
				end

				--add new route
				local tPName = UnitName("player")

				SkuNav:InsertRoute(tRouteName)
				SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName] = {
					["WPs"] = {},
					["tStartWPName"] = tWpNameA,
					["tEndWPName"] = tWpNameB,
					["createdAt"] = "timedate",
					["createdBy"] = tPName,
				}
				SkuNav:UpdateRtContinentAndAreaIds(tRouteName)

				--add first wp to route
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs, tWpNameA)

				-- start recording
				SkuOptions.db.profile[MODULE_NAME].routeRecording = true
				SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = tRouteName
				SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = tIntWPmethod

				if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
					SkuOptions.Voice:OutputString("Aufzeichnung beginnt bei A", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
				elseif SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
					SkuOptions.Voice:OutputString("Aufzeichnung läuft bis B", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
				else
					SkuOptions.Voice:OutputString("Aufzeichnung läuft bis beenden", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
				end

				self.tmpWPA = nil
				self.tmpWPB = nil
				self.tmpIntWP = nil
				SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
				SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
				SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""

				if _G["OnSkuOptionsMain"]:IsVisible() == true then
					_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
				end

			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Punkt A"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = SkuNav_MenuBuilder_PointX_OnAction
			tNewMenuEntry.BuildChildren = SkuNav_MenuBuilder_PointX_BuildChildren

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Point B"]}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = SkuNav_MenuBuilder_PointX_OnAction
			tNewMenuEntry.BuildChildren = SkuNav_MenuBuilder_PointX_BuildChildren

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Zwischenpunkte"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print("OnAction: Zwischenpunkte", self.name, aName)
				self.parent:OnAction(self.parent, aName, self.name)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #SkuNav.routeRecordingIntWpMethods.names do 
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuNav.routeRecordingIntWpMethods.names[x]}, menuEntryTemplate_Menu)
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						--print("OnAction Manuell", self.name, aName)
						self.parent:OnAction(self.parent, aName, self.name)
					end
				end
			end

		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Complete recording"]}, menuEntryTemplate_Menu)
		if SkuOptions.db.profile[MODULE_NAME].routeRecording == true and sfind(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, L["Set on completion"]) then
			tNewMenuEntry.BuildChildren = function(self)
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Point B"]}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = SkuNav_MenuBuilder_PointX_OnAction
				tNewMenuEntry.BuildChildren = SkuNav_MenuBuilder_PointX_BuildChildren
			end
		end

		tNewMenuEntry.OnAction = function(self, aValue, aName, aChildName)
			--print("OnAction Aufzeichnung abschließen", self.name, "-", aName, "-", aChildName, "-", self.tmpWPA, "-", self.tmpWPB)
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == false then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("Es läuft keine Aufzeichnung", false, true, 0.3, true)
				return
			end

			--do we need to update the rt as b was set on completing the recording?
			if sfind(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, L["Set on completion"]) then
				--print("ist Bei Beenden festlegen")
				-- yes > update b wp name and update the route name
				-- aName is the new b name
				local updatedRtName = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute:gsub(L["Set on completion"], aName)
				--print("neue b name", updatedRtName)
				local updatedRtData = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute]
				updatedRtData.tEndWPName = aName
				
				--delete the current route data
				for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes do
					if SkuOptions.db.profile[MODULE_NAME].Routes[x] == SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute then
						SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]] = nil
						table.remove(SkuOptions.db.profile[MODULE_NAME].Routes, x)
						--print("old rt removed:", SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
					end
				end
				--add the new route data
				SkuNav:InsertRoute(updatedRtName)
				SkuOptions.db.profile[MODULE_NAME].Routes[updatedRtName] = updatedRtData
				--update the route we're recording for
				SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = updatedRtName
				--print("new rt:", SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
				SkuOptions.db.profile[MODULE_NAME].routeRecordingSizeOfB = self.TMPSize or 1
			end
			
			--proceede as usal
			if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].tEndWPName) == nil then
				SkuNav:CreateWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].tEndWPName, nil, nil, SkuOptions.db.profile[MODULE_NAME].routeRecordingSizeOfB or 1)
			end
			SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].tEndWPName)

			--check rt if all wps are valid
			if SkuNav:CheckRoute(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute) ~= true then
				SkuNav:DeleteRoute(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, true)
				SkuOptions.Voice:OutputString("failure", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
				SkuOptions.Voice:OutputString("aufzeichnung;beschädigt;route;gelöscht", false, true, 0.3, true)
			else
				SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
				SkuOptions.Voice:OutputString("Aufzeichnung beendet;route;erstellt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
			end

			if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			end

			--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
			SkuNav:SelectWP("", true)

			--complete
			SkuOptions.db.profile[MODULE_NAME].routeRecording = false
			SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = nil

			if _G["OnSkuOptionsMain"]:IsVisible() == true then
				_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Aufzeichnung abbrechen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction neu", self.name, aName)
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == false then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("Es läuft keine Aufzeichnung", false, true, 0.3, true)
				return
			end

			if SkuNav:DeleteRoute(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, true) == true then
				SkuOptions.Voice:OutputString("aufzeichnung;abgebrochen;route;gelöscht", false, true, 0.3, true)
			else
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
			end

			if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			end

			--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
			SkuNav:SelectWP("", true)

			--complete
			SkuOptions.db.profile[MODULE_NAME].routeRecording = false
			SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil
			SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = nil

			--if _G["OnSkuOptionsMain"]:IsVisible() == true then
				--_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
			--end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Route folgen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction", self.name, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
				return
			end

			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuNav:EndFollowingWpOrRt()
			end

			SkuOptions.db.profile[MODULE_NAME].metapathFollowing = false
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart then
				if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths then
					if sfind(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, L["Meter"].."#") then
						SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = string.sub(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, sfind(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, L["Meter"].."#") + string.len(L["Meter"].."#"))
					end

					SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = aName
					SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = 1
					SkuOptions.db.profile[MODULE_NAME].metapathFollowing = true

					SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, true)
					SkuOptions.Voice:OutputString("Metaroute folgen gestartet", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int

					if _G["OnSkuOptionsMain"]:IsVisible() == true then
						_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
					end
				end
			else
				if SkuNav:CheckRoute(SkuOptions.db.profile["SkuNav"].routeFollowingRoute) ~= true then
					--to implement!!!!!!!!!!!!
					print("FEHLER: check routeFollowingRoute) ~= true", SkuOptions.db.profile["SkuNav"].routeFollowingRoute)
					return
				end

				if aName == "Richtung A" or aName == "Start bei B" then
					SkuOptions.db.profile["SkuNav"].routeFollowingUpDown = -1
				elseif  aName == "Richtung B"  or aName == "Start bei A" then
					SkuOptions.db.profile["SkuNav"].routeFollowingUpDown = 1
				end

				if SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP == nil then
					if aName == "Start bei A" then
						SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = 1
					else
						SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = #SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs
					end
				end

				SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP
				SkuOptions.db.profile[MODULE_NAME].routeFollowing = true
				SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs[SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP], true)
				SkuOptions.Voice:OutputString("Route folgen gestartet", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int

				if _G["OnSkuOptionsMain"]:IsVisible() == true then
					_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
				end
			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Ziele Entfernung"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil

				local tPlayX, tPlayY = UnitPosition("player")
				--print(tPlayX, tPlayY)
				local tRoutesInRange = SkuNav:GetAllRoutesInRangeToCoords(tPlayX, tPlayY, 1000)--SkuOptions.db.profile[MODULE_NAME].nearbyWpRange)
				for i, v in pairs(tRoutesInRange) do
					--print("results", i, v, v.nearestWP, v.nearestWpRange)
				end

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

				for q = 2, #tSortedWaypointList do
					tSortedWaypointList[q] = nil
				end

				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tCount = 0
					for k, v in SkuSpairs(tSortedWaypointList) do
						if tCount < 10 then
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = v
								local tMetapaths = SkuNav:GetAllMetaTargetsFromWp2(v)
								SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = tMetapaths

								local tData = {}
								for i, v in ipairs(tMetapaths) do
									tData[v] = tMetapaths[v].distance
								end
								local tSortedList = {}
								for k,v in SkuSpairs(tData, function(t,a,b) return t[b] > t[a] end) do --nach wert
									table.insert(tSortedList, k)
								end

								if #tSortedList == 0 then
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
								else
									for tK, tV in ipairs(tSortedList) do
										local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMetapaths[tV].distance..";Meter#"..tV}, menuEntryTemplate_Menu)
									end
								end
							end
							tCount = tCount + 1
						end
					end
				end
			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle nach Entfernung"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Nur Endpunkte"}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)
					local tRoutesList = {}
					for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
						if SkuNav:CheckRoute(v) == true then
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldY
							local tPlayX, tPlayY = UnitPosition("player")
							local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldY
							local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							if tDistance1 < tDistance then
								tDistance = tDistance1
							end
							tRoutesList[v] = tDistance
						end
					end

					local tSortedWaypointList = {}
					for k,v in SkuSpairs(tRoutesList, function(t,a,b) return t[b] > t[a] end) do --nach wert
						table.insert(tSortedWaypointList, v..";Meter#"..k)
					end
					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
					else

						for i, v in ipairs(tSortedWaypointList) do
							--print(i, v)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								local tRouteName
								local tF = sfind(v, L["Meter"].."#")
								--print(self.name, tF)
								if tF then	
									tRouteName = string.sub(v, tF + string.len(L["Meter"].."#"))
								end
								SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = tRouteName
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldY
								local tPlayX, tPlayY = UnitPosition("player")
								local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldY
								local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance..";Meter#".."Start bei A"}, menuEntryTemplate_Menu)
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance1..";Meter#".."Start bei B"}, menuEntryTemplate_Menu)
							end
						end
					end
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle Punkte"}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				--tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)
					local tRoutesList = {}
					local tPlayX, tPlayY = UnitPosition("player")
					for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
						if SkuNav:CheckRoute(v) == true then
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldY
							local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							if #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs > 2 then
								for x = 2, #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs - 1 do
									local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldY
									local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
									if tDistanceX < tDistance then
										tDistance = tDistanceX
									end
								end
							end
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldY
							local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							if tDistance1 < tDistance then
								tDistance = tDistance1
							end
							tRoutesList[v] = tDistance
						end
					end

					local tSortedRoutesList = {}
					for k,v in SkuSpairs(tRoutesList, function(t,a,b) return t[b] > t[a] end) do --nach wert
						table.insert(tSortedRoutesList, v..";Meter#"..k)
					end
					if #tSortedRoutesList == 0 then
						table.insert(tSortedRoutesList, "keine")
					end

					if #tSortedRoutesList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
					else
						for i, v in ipairs(tSortedRoutesList) do
							--print(i, v)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								local tRouteName
								local tF = sfind(self.name, L["Meter"].."#")
								--print(self.name, tF)
								if tF then	
									tRouteName = string.sub(self.name, tF + string.len(L["Meter"].."#"))
								end
								SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = tRouteName

								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldY
								local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Start bei A#"..tDistanceX.." Meter"}, menuEntryTemplate_Menu)
								tNewMenuEntry.dynamic = true
								tNewMenuEntry.filterable = true
								tNewMenuEntry.BuildChildren = function(self)
									SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = 1
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Richtung B"}, menuEntryTemplate_Menu)
								end

								--print(self.name, tF, tRouteName)
								if #SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs > 2 then
									for x = 2, #SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs - 1 do
										local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[x]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[x]).worldY
										local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
										local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Start bei#"..x.."#"..tDistanceX.." "..L["Meter"]}, menuEntryTemplate_Menu)
										tNewMenuEntry.dynamic = true
										tNewMenuEntry.filterable = true
										tNewMenuEntry.BuildChildren = function(self)
											SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = x
											local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Richtung A"}, menuEntryTemplate_Menu)
											local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Richtung B"}, menuEntryTemplate_Menu)
										end
									end
								end

								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldY
								local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Start bei B#"..tDistanceX.." Meter"}, menuEntryTemplate_Menu)
								tNewMenuEntry.dynamic = true
								tNewMenuEntry.filterable = true
								tNewMenuEntry.BuildChildren = function(self)
									SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = #SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Richtung A"}, menuEntryTemplate_Menu)
								end
							end
						end
					end
				end


			end
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Endpunkt in Zone"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				--print("_Start in aktueller Karte_ buildchilds")
				local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
				local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
				tSubAreaIds[tCurrentAreaId] = tCurrentAreaId
				local tRoutesList = {}
				for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
					if SkuNav:CheckRoute(v) == true then
						--print(i, v)
						local tAID = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).areaId
						--print(1, tonumber(tAID), tSubAreaIds[tonumber(tAID)])
						if tSubAreaIds[tAID] then
							table.insert(tRoutesList, v)
						else
							local tAID = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).areaId
							--print(#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs, tonumber(tAID), tSubAreaIds[tonumber(tAID)])
							if tSubAreaIds[tAID] then
								table.insert(tRoutesList, v)
							end
						end
					else
						--print("UNGÜLTIGE ROUTE", i, v)
					end
				end
				if #tRoutesList == 0 then
					table.insert(tRoutesList, "keine")
				end
				if #tRoutesList > 0 then
					local tSortedWaypointList = {}
					for k,v in SkuSpairs(tRoutesList, function(t,a,b) return t[b] > t[a] end) do --nach wert
						if v ~= "keine" then
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldY
							local tPlayX, tPlayY = UnitPosition("player")
							local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldY
							local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							if tDistance1 < tDistance then
								tDistance = tDistance1
							end							
							table.insert(tSortedWaypointList, tDistance..";Meter#"..v)
						end
					end
					if #tSortedWaypointList == 0 then
						--table.insert(tSortedWaypointList, "keine")
					end

					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
					else
						for i, v in ipairs(tSortedWaypointList) do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.filterable = true
							tNewMenuEntry.BuildChildren = function(self)
								local tRouteName = v
								local tF = sfind(v, L["Meter"].."#")
								if tF then
									tRouteName = string.sub(v, tF + string.len(L["Meter"].."#"))
								end
								SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = tRouteName
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldY
								local tPlayX, tPlayY = UnitPosition("player")
								local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldY
								local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance..";Meter#".."Start bei A"}, menuEntryTemplate_Menu)
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance1..";Meter#".."Start bei B"}, menuEntryTemplate_Menu)
							end
						end
					end
				end
			end
			-- all wps sortet by name
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle alphabetisch"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				local tRoutesList = {}
				for i, v in ipairs(SkuOptions.db.profile["SkuNav"].Routes) do
					if SkuNav:CheckRoute(v) == true then
						tRoutesList[v] = v
					else
						--print("UNGÜLTIGE ROUTE", i, v)
					end
				end

				local tSortedWaypointList = {}
				for k,v in SkuSpairs(tRoutesList) do
					table.insert(tSortedWaypointList, k)
				end
				if #tSortedWaypointList == 0 then
					table.insert(tSortedWaypointList, "keine")
				end

				if #tSortedWaypointList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					for i, v in ipairs(tSortedWaypointList) do
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.filterable = true
						tNewMenuEntry.BuildChildren = function(self)
							local tRouteName = v
							local tF = sfind(v, L["Meter"].."#")
							if tF then
								tRouteName = string.sub(v, tF + string.len(L["Meter"].."#"))
							end
							SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = tRouteName
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[1]).worldY
							local tPlayX, tPlayY = UnitPosition("player")
							local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
							local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs]).worldY
							local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance..";Meter#".."Start bei A"}, menuEntryTemplate_Menu)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tDistance1..";Meter#".."Start bei B"}, menuEntryTemplate_Menu)
						end
					end
				end
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Route folgen beenden"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if (SkuOptions.db.profile[MODULE_NAME].metapathFollowing == false and SkuOptions.db.profile[MODULE_NAME].routeFollowing == false) or SkuOptions.db.profile[MODULE_NAME].routeRecording == true and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("Wegpunkt oder Route folgen läuft nicht oder Aufzeichnung läuft", false, true, 0.3, true)
				return
			end
			SkuOptions.db.profile[MODULE_NAME].routeFollowing = false
			SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = nil
			SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = nil
			SkuOptions.db.profile[MODULE_NAME].routeFollowingUpDown = nil
			SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = nil
			SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = nil
			--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
			SkuNav:SelectWP("", true)
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Verwalten"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction", self.name, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing  == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end

			--SkuNeighbCache = {}
		end
		tNewMenuEntry.BuildChildren = function(self)
			--
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.RtToDelete = ""
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print("Löschen OnAction", self.name, aValue, aName, SkuOptions.MenuRtToDelete)
				if aName == "Löschen" and SkuOptions.MenuRtToDelete then
					local tRtToDelete = SkuOptions.MenuRtToDelete
					SkuOptions.MenuRtToDelete = nil

					if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing  == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
						return
					end

					if tRtToDelete == "Alle" then
						local tRoutes = {}
						for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
							table.insert(tRoutes, v)
						end

						for _, tRouteName in ipairs(tRoutes) do
							SkuNav:DeleteRoute(tRouteName, true)
						end
						SkuOptions.Voice:OutputString("Alle Routen gelöscht", false, true, 0.3, true)

					elseif tRtToDelete == "Alle in Zone" then
						local tCurrentAreaId = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
						local tSubAreaIds = SkuNav:GetSubAreaIds(tCurrentAreaId)
						tSubAreaIds[tCurrentAreaId] = tCurrentAreaId
						local tRoutesList = {}
						for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
							if SkuNav:CheckRoute(v) == true then
								local tAID = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).areaId
								if tSubAreaIds[tAID] then
									table.insert(tRoutesList, v)
								else
									local tAID = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).areaId
									if tSubAreaIds[tAID] then
										table.insert(tRoutesList, v)
									end
								end
							else
								--print("UNGÜLTIGE ROUTE", i, v)
							end
						end
						if #tRoutesList > 0 then
							for x = 1, #tRoutesList do
								SkuNav:DeleteRoute(tRoutesList[x], true)
							end
							SkuOptions.Voice:OutputString("Alle Routen in aktueller Zone gelöscht", false, true, 0.3, true)
						end

					else
						if sfind(tRtToDelete, L["Meter"].."#") then
							tRtToDelete = string.sub(tRtToDelete, sfind(tRtToDelete, L["Meter"].."#") + string.len(L["Meter"].."#"))
						end

						--print("delete", tRtToDelete)

						--check all wps in rt to delete
						for i1, v1 in ipairs(SkuOptions.db.profile["SkuNav"].Routes[tRtToDelete].WPs) do
							local tFoundInOtherRts = false
							--check if wp is in other rt
							for i, v in ipairs(SkuOptions.db.profile["SkuNav"].Routes) do
								if v ~= tRtToDelete then
									for i1a, v1a in ipairs(SkuOptions.db.profile["SkuNav"].Routes[v].WPs) do
										if v1a == v1 then
											tFoundInOtherRts = true
										end
									end
								end
							end
							--print("wp", v1, tFoundInOtherRts)
							if tFoundInOtherRts == false then
								-- not in other rts > delete wp v1
								--print("remove wp", v1)
								SkuOptions.db.profile["SkuNav"].Waypoints[v1] = nil
								for iwp, vwp in ipairs(SkuOptions.db.profile["SkuNav"].Waypoints) do
									if vwp == v1 then
										table.remove(SkuOptions.db.profile["SkuNav"].Waypoints, iwp)
									end
								end
							end
						end
						--delete rt SkuOptions.db.profile["SkuNav"].Routes
						--print("remove rt", tRtToDelete)
						SkuOptions.db.profile["SkuNav"].Routes[tRtToDelete] = nil
						for irt, vrt in ipairs(SkuOptions.db.profile["SkuNav"].Routes) do
							if vrt == tRtToDelete then
								table.remove(SkuOptions.db.profile["SkuNav"].Routes, irt)
							end
						end

						SkuOptions.Voice:OutputString("Route gelöscht", false, true, 0.3, true)

						SkuNeighbCache = {}
						if tCacheNbWpsTimer then
							tCacheNbWpsTimer:Cancel()
						end
						CacheNbWps()							
					end

					SkuNeighbCache = {}
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tRoutesList = {}
				local tPlayX, tPlayY = UnitPosition("player")
				for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
					if SkuNav:CheckRoute(v) == true then
						local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldY
						local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
						if #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs > 2 then
							for x = 2, #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs - 1 do
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldY
								local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
								if tDistanceX < tDistance then
									tDistance = tDistanceX
								end
							end
						end
						local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldY
						local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
						if tDistance1 < tDistance then
							tDistance = tDistance1
						end
						tRoutesList[v] = tDistance
					end
				end

				local tSortedRoutesList = {}
				for k,v in SkuSpairs(tRoutesList, function(t,a,b) return t[b] > t[a] end) do --nach wert
					table.insert(tSortedRoutesList, v..";Meter#"..k)
				end

				if #tSortedRoutesList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle"}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions.MenuRtToDelete = "Alle"
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abbrechen"}, menuEntryTemplate_Menu)
					end
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle in Zone"}, menuEntryTemplate_Menu)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions.MenuRtToDelete = "Alle in Zone"
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abbrechen"}, menuEntryTemplate_Menu)
					end

					for i, v in ipairs(tSortedRoutesList) do
						--print(i, v)
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							SkuOptions.MenuRtToDelete = v
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abbrechen"}, menuEntryTemplate_Menu)
						end
	
					end
				end
			end

			--
			--[[
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Umbenennen"}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print("Umbenennen OnAction", self.name, aValue, aName, SkuOptions.MenuRtToDelete)
				SkuOptions.Voice:OutputString("Funktion noch nicht implementiert", false, true, 0.3, true)

				SkuNeighbCache = {}
			end
			tNewMenuEntry.BuildChildren = function(self)
				local tRoutesList = {}
				local tPlayX, tPlayY = UnitPosition("player")
				for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
					if SkuNav:CheckRoute(v) == true then
						local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]).worldY
						local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
						if #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs > 2 then
							for x = 2, #SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs - 1 do
								local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[x]).worldY
								local tDistanceX, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
								if tDistanceX < tDistance then
									tDistance = tDistanceX
								end
							end
						end
						local tWpX, tWpY = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]).worldY
						local tDistance1, _  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)
						if tDistance1 < tDistance then
							tDistance = tDistance1
						end
						tRoutesList[v] = tDistance
					end
				end

				local tSortedRoutesList = {}
				for k,v in SkuSpairs(tRoutesList, function(t,a,b) return t[b] > t[a] end) do --nach wert
					table.insert(tSortedRoutesList, v..";Meter#"..k)
				end

				if #tSortedRoutesList == 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, menuEntryTemplate_Menu)
				else
					for i, v in ipairs(tSortedRoutesList) do
						--print(i, v)
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							SkuOptions.MenuRtToDelete = v
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Umbenennen"}, menuEntryTemplate_Menu)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Abbrechen"}, menuEntryTemplate_Menu)
						end
	
					end
				end
			end




			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Bearbeiten"}, menuEntryTemplate_Menu)
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print("Umbenennen OnAction", self.name, aValue, aName, SkuOptions.MenuRtToDelete)
				SkuOptions.Voice:OutputString("Funktion noch nicht implementiert", false, true, 0.3, true)

				SkuNeighbCache = {}
			end		
			]]	
		end















	end

	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {"Daten"}, menuEntryTemplate_Menu)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Import"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end

			SkuOptions:ImportWpAndRouteData()
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Import aktuelle Karte"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			if SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId()) then
				SkuOptions:ImportWpAndRouteData(SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())))
			else
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("In dieser Karte nicht möglich", false, true, 0.3, true)
			end
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Export alle"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			SkuOptions:ExportWpAndRouteData()
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Export aktueller Kontinent"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			if tPlayerContintentId then
				SkuOptions:ExportWpAndRouteData(nil, tPlayerContintentId)
			else
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("Auf diesem Kontinent nicht möglich", false, true, 0.3, true)
			end
		end



		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Export aktuelle Karte"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
				return
			end
			if SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId()) then
				SkuOptions:ExportWpAndRouteData(SkuNav:GetAreaIdFromUiMapId(SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())))
			else
				SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
				SkuOptions.Voice:OutputString("In dieser Karte nicht möglich", false, true, 0.3, true)
			end
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle Routen und Wegpunkte löschen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			SkuOptions.db.profile[MODULE_NAME].Routes = {}
			SkuOptions.db.profile[MODULE_NAME].Waypoints = {}
			SkuOptions.Voice:OutputString("Alles gelöscht", false, true, 0.3, true)
		end
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuNav.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
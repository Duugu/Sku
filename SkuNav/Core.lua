---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local _G = _G
local L = Sku.L

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")

local lastDirection = -1
local lastDistance = 0
SkuDrawFlag = false
SkuCacheFlag = false

local slower = string.lower
local sfind = string.find
local ssplit = string.split

SkuNav.PrintMT = {
	__tostring = function(thisTable)
		local tStr = ""
		local function tf(ttable, tTab)
			for k, v in pairs(ttable) do
				if k ~= "parent" and v ~= "parent" and k ~= "prev" and v ~= "prev" and k ~= "next" and v ~= "next"  then
					if type(v) ~= "userdata" and k ~= "frame" and k ~= 0  then
						if type(v) == 'table' then
							dprint(tTab..k..":")
							tf(v, tTab.."  ")
						elseif type(v) == "function" then
							dprint(tTab..k..": function")
						elseif type(v) == "boolean" then
							dprint(tTab..k..": "..tostring(v))
						else
							dprint(tTab..k..": "..v)
						end
					end
				end
			end
		end
		tf(thisTable, "")
	end,
	}

------------------------------------------------------------------------------------------------------------------------
SkuNav.WpTypes = {
	[1] = "custom",
	[2] = "creature",
	[3] = "object",
	[4] = "standard",
}

SkuNav.MaxMetaRange = 4000
SkuNav.MaxMetaWPs = 200
SkuNav.BestRouteWeightedLengthModForMetaDistance = 37

local WaypointCache = {}
local WaypointCacheLookupAll = {}
local WaypointCacheLookupPerContintent = {}
function SkuNav:CreateWaypointCache()
	dprint("CreateWaypointCache")
	WaypointCache = {}
	WaypointCacheLookupAll = {}
	WaypointCacheLookupPerContintent = {}

	--add creatures
	for i, v in pairs(SkuDB.NpcData.NamesDE) do
		if SkuDB.NpcData.Data[i] then
			local tSpawns = SkuDB.NpcData.Data[i][7]
			if tSpawns then
				for is, vs in pairs(tSpawns) do
					local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
					--we don't care for stuff that isn't in the open world
					if isUiMap then
						local tData = SkuDB.InternalAreaTable[is]
						if tData then
							local tNumberOfSpawns = #vs
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
							for sp = 1, tNumberOfSpawns do
								local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(vs[sp][1] / 100, vs[sp][2] / 100))
								local tWorldX, tWorldY = worldPosition:GetXY()

								local tNewIndex = #WaypointCache + 1
								WaypointCacheLookupAll[v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]] = tNewIndex
								if not WaypointCacheLookupPerContintent[tData.ContinentID] then
									WaypointCacheLookupPerContintent[tData.ContinentID] = {}
								end
								WaypointCacheLookupPerContintent[tData.ContinentID][tNewIndex] = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
								WaypointCache[tNewIndex] = {
									name = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2],
									role = tRolesString,
									typeId = 2,
									dbIndex = i,
									contintentId = tData.ContinentID,
									areaId = is,
									uiMapId = isUiMap,
									worldX = tWorldX,
									worldY = tWorldY,
									createdAt = GetTime(),
									createdBy = "SkuNav",
									size = 1,
									spawnNr = sp,
									links = {
										byId = nil,
										byName = nil,
									},
								}
							end
						end
					end
				end
			end
		end
	end

	--add objects
	for i, v in pairs(SkuDB.objectLookup) do
		--we don't want stuff like ores, herbs, etc.
		if not SkuDB.objectResourceNames[v] then
			if SkuDB.objectDataTBC[i] then
				local tSpawns = SkuDB.objectDataTBC[i][4]
				if tSpawns then
					for is, vs in pairs(tSpawns) do
						local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
						--we don't care for stuff that isn't in the open world
						if isUiMap then
							local tData = SkuDB.InternalAreaTable[is]
							if tData then
								local tNumberOfSpawns = #vs
								for sp = 1, tNumberOfSpawns do
									local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(vs[sp][1] / 100, vs[sp][2] / 100))
									local tWorldX, tWorldY = worldPosition:GetXY()
	
									local tNewIndex = #WaypointCache + 1
									WaypointCacheLookupAll[L["OBJECT"]..";"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]] = tNewIndex
									if not WaypointCacheLookupPerContintent[tData.ContinentID] then
										WaypointCacheLookupPerContintent[tData.ContinentID] = {}
									end
									WaypointCacheLookupPerContintent[tData.ContinentID][tNewIndex] = L["OBJECT"]..";"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
									WaypointCache[tNewIndex] = {
										name = L["OBJECT"]..";"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2],
										role = "",
										typeId = 3,
										dbIndex = i,
										contintentId = tData.ContinentID,
										areaId = is,
										uiMapId = isUiMap,
										worldX = tWorldX,
										worldY = tWorldY,
										createdAt = GetTime(),
										createdBy = "SkuNav",
										size = 1,
										spawnNr = sp,
										links = {
											byId = nil,
											byName = nil,
										},
									}
								end
							end
						end
					end
				end
			end
		end
	end

	--add standard
	--zones
	for q = 1, #SkuDB.DefaultWaypoints2.Zones do
		local tZone = SkuDB.DefaultWaypoints2.Zones[q]
		for u = 1, #SkuDB.DefaultWaypoints2.Zones[tZone] do
			local tSubzone = SkuDB.DefaultWaypoints2.Zones[tZone][u]
			for z = 1, #SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone] do
				local tName = SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][z]
				local tWaypointData = SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][tName]
				local isUiMap = SkuNav:GetUiMapIdFromAreaId(tWaypointData.areaId)
				
				local tNewIndex = #WaypointCache + 1
				WaypointCacheLookupAll[tName] = tNewIndex									
				if not WaypointCacheLookupPerContintent[tWaypointData.contintentId] then
					WaypointCacheLookupPerContintent[tWaypointData.contintentId] = {}
				end
				WaypointCacheLookupPerContintent[tWaypointData.contintentId][tNewIndex] = tName
				WaypointCache[tNewIndex] = {
					name = tName,
					role = "",
					typeId = 4,
					dbIndex = nil,
					contintentId = tWaypointData.contintentId,
					areaId = tWaypointData.areaId,
					uiMapId = isUiMap,
					worldX = tWaypointData.worldX,
					worldY = tWaypointData.worldY,
					createdAt = GetTime(),
					createdBy = "SkuNav",
					size = 1,
					links = {
						byId = nil,
						byName = nil,
					},
				}
			end
		end
	end
	--postboxes
	for q = 1, #SkuDB.DefaultWaypoints2.Postbox do
		local tFaction = SkuDB.DefaultWaypoints2.Postbox[q]
		for q = 1, #SkuDB.DefaultWaypoints2.Postbox[tFaction] do
			local tName = SkuDB.DefaultWaypoints2.Postbox[tFaction][q]
			local tWaypointData = SkuDB.DefaultWaypoints2.Postbox[tFaction][tName]
			local isUiMap = SkuNav:GetUiMapIdFromAreaId(tWaypointData.areaId)
			
			local tNewIndex = #WaypointCache + 1
			WaypointCacheLookupAll[tName] = tNewIndex									
			if not WaypointCacheLookupPerContintent[tWaypointData.contintentId] then
				WaypointCacheLookupPerContintent[tWaypointData.contintentId] = {}
			end
			WaypointCacheLookupPerContintent[tWaypointData.contintentId][tNewIndex] = tName
			WaypointCache[tNewIndex] = {
				name = tName,
				role = "",
				typeId = 4,
				dbIndex = nil,
				contintentId = tWaypointData.contintentId,
				areaId = tWaypointData.areaId,
				uiMapId = isUiMap,
				worldX = tWaypointData.worldX,
				worldY = tWaypointData.worldY,
				createdAt = GetTime(),
				createdBy = "SkuNav",
				size = 1,
				links = {
					byId = nil,
					byName = nil,
				},
			}
		end
	end

	--add custom
	if SkuOptions.db.profile[MODULE_NAME].Waypoints then
		for tIndex, tName in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
			local tWaypointData = SkuOptions.db.profile[MODULE_NAME].Waypoints[tName]
			if tWaypointData then
				if tWaypointData.contintentId then
					local isUiMap = SkuNav:GetUiMapIdFromAreaId(tWaypointData.areaId)
					local tWpIndex = (#WaypointCache + 1)
					local tOldLinks = {
						byId = nil,
						byName = nil,
					}
					if WaypointCacheLookupAll[tName] then
						if WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[tName]].contintentId] then
							WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[tName]].contintentId][WaypointCacheLookupAll[tName]] = nil
						end
						tOldLinks = WaypointCache[WaypointCacheLookupAll[tName]].links
						tWpIndex = WaypointCacheLookupAll[tName]
					end

					WaypointCache[tWpIndex] = {
						name = tName,
						role = "",
						typeId = 1,
						dbIndex = nil,
						contintentId = tWaypointData.contintentId,
						areaId = tWaypointData.areaId,
						uiMapId = isUiMap,
						worldX = tWaypointData.worldX,
						worldY = tWaypointData.worldY,
						createdAt = tWaypointData.createdAt,
						createdBy = tWaypointData.createdBy,
						size = tWaypointData.size or 1,
						comments = tWaypointData.comments,
						spawnNr = nil,
						links = tOldLinks,
					}

					WaypointCacheLookupAll[tName] = tWpIndex

					if not WaypointCacheLookupPerContintent[tWaypointData.contintentId] then
						WaypointCacheLookupPerContintent[tWaypointData.contintentId] = {}
					end
					WaypointCacheLookupPerContintent[tWaypointData.contintentId][tWpIndex] = tName
				end
			end
		end
	end

	SkuNav:LoadLinkDataFromProfile()
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:LoadLinkDataFromProfile()
	dprint("LoadLinkDataFromProfile")
	if SkuOptions.db.profile[MODULE_NAME].Links then
		SkuNav:CheckAndUpdateProfileLinkData()
		for tSourceWpName, tSourceWpLinks in pairs(SkuOptions.db.profile[MODULE_NAME].Links) do
			if WaypointCacheLookupAll[tSourceWpName] then
				WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byName = {}
				WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byId = {}
				for tTargetWpName, tTargetWpDistance in pairs(tSourceWpLinks) do
					if WaypointCacheLookupAll[tTargetWpName] then
						WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byName[tTargetWpName] = tTargetWpDistance
						WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byId[WaypointCacheLookupAll[tTargetWpName]] = tTargetWpDistance
					end
				end
			end
		end
	end
	SkuNav:SaveLinkDataToProfile()
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:CheckAndUpdateProfileLinkData()
	dprint("CheckAndUpdateProfileLinkData")
	if SkuOptions.db.profile[MODULE_NAME].Links then
		for tSourceWpName, tSourceWpLinks in pairs(SkuOptions.db.profile[MODULE_NAME].Links) do
			if SkuNav:GetWaypointData2(tSourceWpName) then
				for tTargetWpName, tTargetWpDistance in pairs(tSourceWpLinks) do
					if tSourceWpName == tTargetWpName then
						SkuOptions.db.profile[MODULE_NAME].Links[tSourceWpName][tTargetWpName] = nil
						--print("+++UPDATED deleted", tTargetWpName, "from", tSourceWpName, "because source was linked with self")
					else
						if SkuNav:GetWaypointData2(tTargetWpName) then
							SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName] = SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName] or {}
							if not SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName][tSourceWpName] then
								--print("+++UPDATED added", tSourceWpName, "to", tTargetWpName)
								SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName][tSourceWpName] = tTargetWpDistance
							end
						else
							--print("+++UPDATED deleted", tTargetWpName, "from", tSourceWpName, "because target does not exist")
							SkuOptions.db.profile[MODULE_NAME].Links[tSourceWpName][tTargetWpName] = nil
							--print("  +++UPDATED deleted", tTargetWpName, "because target does not exist")
							SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName] = nil
						end
					end
				end
			else
				for tTargetWpName, tTargetWpDistance in pairs(tSourceWpLinks) do
					SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName] = SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName] or {}
					if not SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName][tSourceWpName] then
						--print("+++UPDATED deleted", tSourceWpName, "from", tTargetWpName, "because source does not exist")
						SkuOptions.db.profile[MODULE_NAME].Links[tTargetWpName][tSourceWpName] = nil
					end
				end
				--print("  +++UPDATED delted", tSourceWpName, "because source does not exist")
				SkuOptions.db.profile[MODULE_NAME].Links[tSourceWpName] = nil
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:SaveLinkDataToProfile(aWpName)
	dprint("SaveLinkDataToProfile", aWpName)
	if aWpName then
		SkuOptions.db.profile[MODULE_NAME].Links[aWpName] = WaypointCache[WaypointCacheLookupAll[aWpName]].links.byName
	else
		SkuOptions.db.profile[MODULE_NAME].Links = {}
		for tSourceWpIndex, tSourceWpData in pairs(WaypointCache) do
			if tSourceWpData.links then
				if tSourceWpData.links.byId then
					SkuOptions.db.profile[MODULE_NAME].Links[tSourceWpData.name] = tSourceWpData.links.byName
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetWaypointData2(aName, aIndex)
	if aName then
		return WaypointCache[WaypointCacheLookupAll[aName]]
	elseif aIndex then
		return WaypointCache[aIndex]
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetNearestWpToCoords2(aX, aY, aContintent)
	local tNearestDistance, tNearestWpName = 40000, nil

	for tIndex, tValue in pairs(WaypointCacheLookupPerContintent[aContintent]) do
		local tWpData = SkuNav:GetWaypointData2(nil, tIndex)
		local tThisDistance = SkuNav:Distance(aX, aY, tWpData.worldX, tWpData.worldY)
		if tThisDistance < tNearestDistance then
			tNearestDistance = tThisDistance
			tNearestWpName = tValue
		end
	end

	return tNearestWpName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetCleanWpName(aWpName)
	if string.find(aWpName, "#") then
		return string.sub(aWpName, string.find(aWpName, "#") + 1)
	end
	return aWpName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAllMetaTargetsFromWp4(aStartWpName, aMaxDistance, aMaxWPs, aReturnPathForWp, aIncludeAutoWps)
	dprint("SkuNav:GetAllMetaTargetsFromWp4", aStartWpName, aMaxDistance, aMaxWPs, aReturnPathForWp, aIncludeAutoWps)
	local beginTime = debugprofilestop()

	local rMetapathData = {}
	local tToCheckList = {}
	local tFoundNbList = {}
	local tStepList = {}
	local tCurrentNumber = 0

	tToCheckList[1] = WaypointCacheLookupAll[aStartWpName]

	local aStartWpNameData = WaypointCache[WaypointCacheLookupAll[aStartWpName]]
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	local tDistanceToStartWp = SkuNav:Distance(aStartWpNameData.worldX, aStartWpNameData.worldY, fPlayerPosX, fPlayerPosY)	

	while #tToCheckList > 0 do
		tCurrentNumber = tCurrentNumber + 1
		if not tStepList[tCurrentNumber] then
			tStepList[tCurrentNumber] = {}
		end
		local tLocalToCheckList = {}
		for x = 1, #tToCheckList do
			local tCurrentWP = WaypointCache[tToCheckList[x]]
			if tCurrentWP.links then
				if tCurrentWP.links.byId then
					for i, v in pairs(tCurrentWP.links.byId) do
						if not tFoundNbList[i] then
							tStepList[tCurrentNumber][i] = i
							tLocalToCheckList[#tLocalToCheckList + 1] = i
							tFoundNbList[i] = tCurrentNumber
						end
					end
				end
			end
		end
		tToCheckList = tLocalToCheckList
	end

	dprint("filled", debugprofilestop() - beginTime)
	beginTime = debugprofilestop()

	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tAuto = L["auto"]
	if aIncludeAutoWps then
		tAuto = ""
	end
	local tDistance = 0
	local tCurrentFrom = 0
	local tCurrentNumber = 0
	local tSteplistIndex = 0
	local tDistCalculatedFrom = {}

	local tTargetWps = WaypointCacheLookupPerContintent[tPlayerContinentID]
	if aReturnPathForWp then
		tTargetWps = {[WaypointCacheLookupAll[aReturnPathForWp]] = aReturnPathForWp}
	end

	for tIndex, tName in pairs(tTargetWps) do
		if tFoundNbList[tIndex] then
			if tAuto == "" or string.sub(tName, 1, 4) ~= tAuto then
				if aStartWpName ~= tName then
					rMetapathData[tName] = {
						distance = aMaxDistance,
						distanceToStartWp = tDistanceToStartWp,
					}
					if aReturnPathForWp then
						rMetapathData[tName].pathWps = {}
					end
					if (tFoundNbList[tIndex] < aMaxWPs) or (aReturnPathForWp) then
						tDistance = 0
						tCurrentFrom = tIndex
						tCurrentNumber = tFoundNbList[tIndex] - 1
						while tCurrentNumber ~= 0 do
							if tDistCalculatedFrom[tCurrentFrom] and not aReturnPathForWp then
								tDistance = tDistance + tDistCalculatedFrom[tCurrentFrom]
								tCurrentNumber = 0
							else
								local tList = tStepList[tCurrentNumber]
								for tWpIndex, tWpDistance in pairs(WaypointCache[tCurrentFrom].links.byId) do
									if tList[tWpIndex] then
										if aReturnPathForWp then
											table.insert(rMetapathData[tName].pathWps, 1, WaypointCache[tCurrentFrom].name)
										end
										tDistance = tDistance + tWpDistance
										tCurrentFrom = tWpIndex
										tCurrentNumber = tCurrentNumber - 1
										break
									end
								end
							end
							if tDistance > aMaxDistance and not aReturnPathForWp then
								tDistance = aMaxDistance
								tCurrentNumber = 0
							end
						end
						if aReturnPathForWp then
							table.insert(rMetapathData[tName].pathWps, 1, WaypointCache[tCurrentFrom].name)
							table.insert(rMetapathData[tName].pathWps, 1, aStartWpName)
						end
						if tDistance ~= aMaxDistance then
							if WaypointCache[tCurrentFrom].links.byId[WaypointCacheLookupAll[aStartWpName]] then
								tDistance = tDistance + WaypointCache[tCurrentFrom].links.byId[WaypointCacheLookupAll[aStartWpName]]
							end
						end
						tDistCalculatedFrom[tIndex] = tDistance
						if tDistance + tDistanceToStartWp > aMaxDistance and not aReturnPathForWp then
							rMetapathData[tName].distance = aMaxDistance
						else
							rMetapathData[tName].distance = tDistance + tDistanceToStartWp
						end
					end
				end
			end
		end
	end

	dprint("End", debugprofilestop() - beginTime)
	--beginTime = debugprofilestop()

	return rMetapathData
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetNearestWpsWithLinksToWp(aWpName, aNumberOfWpsToReturn, aMaxDistance)
	local tFoundWpList = {}
	local tMaxDistanceFound = 100000
	aMaxDistance = aMaxDistance or 100000

	local taWpNameX, taWpNameY = WaypointCache[WaypointCacheLookupAll[aWpName]].worldX, WaypointCache[WaypointCacheLookupAll[aWpName]].worldY
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tWpsToTest = WaypointCacheLookupPerContintent[tPlayerContinentID]
	for tWpIndex, tWpName in pairs(tWpsToTest) do
		if WaypointCache[tWpIndex].links.byId then
			local tDistance = SkuNav:Distance(WaypointCache[tWpIndex].worldX, WaypointCache[tWpIndex].worldY, taWpNameX, taWpNameY)
			if tDistance < tMaxDistanceFound and tDistance < aMaxDistance then
				if #tFoundWpList > 0 then
					for x = 1, #tFoundWpList do
						if tFoundWpList[x].distance > tDistance then
							table.insert(tFoundWpList, x, {wpIndex = tWpIndex, wpName = tWpName, distance = tDistance})
							break
						end
					end
				else
					table.insert(tFoundWpList, {wpIndex = tWpIndex, wpName = tWpName, distance = tDistance})
				end
			end
			if #tFoundWpList > aNumberOfWpsToReturn then
				table.remove(tFoundWpList, #tFoundWpList)
				tMaxDistanceFound = tFoundWpList[#tFoundWpList].distance
			end
		end
	end
	return tFoundWpList
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ListWaypoints2(aSort, aFilter, aAreaId, aContinentId, aExcludeRoute, aRetAsTable, aIgnoreAuto)
	aSort = aSort or false
	aFilter = aFilter or "custom;creature;object;standard"
	local tFilterTypes = {}
	if string.find(aFilter, "custom") then tFilterTypes[1] = 1 end
	if string.find(aFilter, "creature") then tFilterTypes[2] = 2 end
	if string.find(aFilter, "object") then tFilterTypes[3] = 3 end
	if string.find(aFilter, "standard") then tFilterTypes[4] = 4 end

	local UiMapId
	if aAreaId then
		UiMapId = SkuNav:GetUiMapIdFromAreaId(aAreaId)
	end

	aContinentId = aContinentId or select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
	if not aContinentId or not WaypointCacheLookupPerContintent[aContinentId] then
		return
	end



	local tWpList = {}
	for tIndex, tName in pairs(WaypointCacheLookupPerContintent[aContinentId]) do
		if tFilterTypes[WaypointCache[tIndex].typeId] then
			if not UiMapId or UiMapId == WaypointCache[tIndex].uiMapId then
				--tWpList[tIndex] = tName
				tWpList[#tWpList + 1] = tName
			end
		end
	end

	if aSort == true then
		local tSortedList = {}
		for k, v in SkuSpairs(tWpList, function(t,a,b) return t[b] > t[a] end) do --nach wert
			tSortedList[#tSortedList+1] = v
		end
		if aRetAsTable then
			return tSortedList
		else
			return pairs(tSortedList)
		end
	end

	if aRetAsTable then
		return tWpList
	else
		return pairs(tWpList)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteWpLink(aWpAName, aWpBName)
	local tWpAIndex = WaypointCacheLookupAll[aWpAName]
	local tWpBIndex = WaypointCacheLookupAll[aWpBName]
	local tWpAData = SkuNav:GetWaypointData2(nil, tWpAIndex)
	local tWpBData = SkuNav:GetWaypointData2(nil, tWpBIndex)

	if not tWpAData or not tWpBData then
		return false
	end

	if not tWpAData.links.byId or not tWpBData.links.byId then
		return
	end
	if not tWpAData.links.byId[tWpBIndex] or not tWpBData.links.byId[tWpAIndex] then
		return false
	end

	WaypointCache[tWpAIndex].links.byId[tWpBIndex] = nil
	WaypointCache[tWpBIndex].links.byId[tWpAIndex] = nil
	WaypointCache[tWpAIndex].links.byName[aWpBName] = nil
	WaypointCache[tWpBIndex].links.byName[aWpAName] = nil
	
	SkuNav:SaveLinkDataToProfile(aWpAName)
	SkuNav:SaveLinkDataToProfile(aWpBName)
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CreateWpLink(aWpAName, aWpBName)
	if aWpAName ~= aWpBName then
		local tWpAIndex = WaypointCacheLookupAll[aWpAName]
		local tWpBIndex = WaypointCacheLookupAll[aWpBName]
		local tWpAData = SkuNav:GetWaypointData2(nil, tWpAIndex)
		local tWpBData = SkuNav:GetWaypointData2(nil, tWpBIndex)

		local tDistance = SkuNav:Distance(tWpAData.worldX, tWpAData.worldY, tWpBData.worldX, tWpBData.worldY)

		WaypointCache[tWpAIndex].links.byId = WaypointCache[tWpAIndex].links.byId or {}
		WaypointCache[tWpAIndex].links.byName = WaypointCache[tWpAIndex].links.byName or {}
		WaypointCache[tWpAIndex].links.byId[tWpBIndex] = tDistance
		WaypointCache[tWpAIndex].links.byName[aWpBName] = tDistance

		WaypointCache[tWpBIndex].links.byId = WaypointCache[tWpBIndex].links.byId or {}
		WaypointCache[tWpBIndex].links.byName = WaypointCache[tWpBIndex].links.byName or {}
		WaypointCache[tWpBIndex].links.byId[tWpAIndex] = tDistance
		WaypointCache[tWpBIndex].links.byName[aWpAName] = tDistance

		SkuOptions.db.profile[MODULE_NAME].Links[aWpAName] = SkuOptions.db.profile[MODULE_NAME].Links[aWpAName] or {}
		SkuOptions.db.profile[MODULE_NAME].Links[aWpAName][aWpBName] = tDistance
		SkuOptions.db.profile[MODULE_NAME].Links[aWpBName] = SkuOptions.db.profile[MODULE_NAME].Links[aWpBName] or {}
		SkuOptions.db.profile[MODULE_NAME].Links[aWpBName][aWpAName] = tDistance
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateWpLinks(aWpAName)
	local tWpAIndex = WaypointCacheLookupAll[aWpAName]
	local tWpAData = SkuNav:GetWaypointData2(nil, tWpAIndex)

	if not WaypointCache[tWpAIndex].links.byId then
		return
	end

	for tWpBIndex, _ in pairs(tWpAData.links.byId) do
		local tDistance = SkuNav:Distance(tWpAData.worldX, tWpAData.worldY, WaypointCache[tWpBIndex].worldX, WaypointCache[tWpBIndex].worldY)
		WaypointCache[tWpAIndex].links.byId[tWpBIndex] = tDistance
		WaypointCache[tWpAIndex].links.byName[WaypointCache[tWpBIndex].name] = tDistance
		WaypointCache[tWpBIndex].links.byId[tWpAIndex] = tDistance
		WaypointCache[tWpBIndex].links.byName[aWpAName] = tDistance

		SkuOptions.db.profile[MODULE_NAME].Links[aWpAName] = SkuOptions.db.profile[MODULE_NAME].Links[aWpAName] or {}
		SkuOptions.db.profile[MODULE_NAME].Links[aWpAName][WaypointCache[tWpBIndex].name] = tDistance
		SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[tWpBIndex].name] = SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[tWpBIndex].name] or {}
		SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[tWpBIndex].name][aWpAName] = tDistance
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuNav.CurrentStandardWpReachedRange = 0
function SkuNav:UpdateStandardWpReachedRange(aDistanceToNextWp)
	--dprint("UpdateStandardWpReachedRange", aDistanceToNextWp)
	if SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 1 then
		SkuNav.CurrentStandardWpReachedRange = 0
	elseif SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 2 then
		SkuNav.CurrentStandardWpReachedRange = 3
	else
		if not aDistanceToNextWp then 
			if SkuNav.CurrentStandardWpReachedRange ~= 0 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 3 then
				SkuOptions.Voice:OutputString("nah", false, true, 0.3, true)
			end
			SkuNav.CurrentStandardWpReachedRange = 0
			return
		end
		if aDistanceToNextWp <= 9 then
			if SkuNav.CurrentStandardWpReachedRange ~= 0 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 3 then
				SkuOptions.Voice:OutputString("nah", false, true, 0.3, true)
			end
			SkuNav.CurrentStandardWpReachedRange = 0
		elseif aDistanceToNextWp > 14 then
			if SkuNav.CurrentStandardWpReachedRange ~= 3 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 3 then
				SkuOptions.Voice:OutputString("weit", false, true, 0.3, true)
			end
			SkuNav.CurrentStandardWpReachedRange = 3
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetBestMapForUnit(aUnitId)
	local tPlayerUIMap = C_Map.GetBestMapForUnit(aUnitId)

	if tPlayerUIMap == 1415 or tPlayerUIMap == 1414 then
		local tMMZoneText = GetMinimapZoneText()

		if tMMZoneText == L["Timbermaw Hold"] then
			--this is because there are two "timbermaw hold" zones with contintent as parent; we explicid need this one, as the other hasn't continent parent at all
			tPlayerUIMap = 1448
		elseif tMMZoneText == "Der Südstrom" then
			--this is because there are two "timbermaw hold" zones with contintent as parent; we explicid need this one, as the other hasn't continent parent at all
			tPlayerUIMap = 1413
		elseif tMMZoneText == "Die Höhlen des Wehklagens" or tMMZoneText == "Höhle der Nebel"  then
			--this is because there are two "timbermaw hold" zones with contintent as parent; we explicid need this one, as the other hasn't continent parent at all
			tPlayerUIMap = 1413
		else
			for i, v in pairs(SkuDB.InternalAreaTable) do
				if v.AreaName_lang == tMMZoneText then
					tPlayerUIMap = SkuNav:GetUiMapIdFromAreaId(v.ParentAreaID)
				end
			end
		end
	end
	return tPlayerUIMap
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PlayWpComments(aWpName)
	if not aWpName then
		return
	end
	local tWpData = SkuNav:GetWaypointData2(aWpName)
	if not tWpData then
		return
	end
	if tWpData.comments then
		if #tWpData.comments > 0 then
			for x = 1, #tWpData.comments do
				print(L["Waypoint information"]..": "..tWpData.comments[x])
				SkuOptions.Voice:OutputString(" ", true, true, 0.3)
				SkuOptions:VocalizeMultipartString(L["Waypoint information"]..": "..tWpData.comments[x], false, true, nil, nil, 3)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnInitialize()
	--dprint("SkuNav OnInitialize")
	SkuNav:RegisterEvent("PLAYER_LOGIN")
	SkuNav:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuNav:RegisterEvent("PLAYER_LEAVING_WORLD")
	SkuNav:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	SkuNav:RegisterEvent("ZONE_CHANGED")
	SkuNav:RegisterEvent("ZONE_CHANGED_INDOORS")
	SkuNav:RegisterEvent("PLAYER_DEAD")
	SkuNav:RegisterEvent("PLAYER_UNGHOST")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetDirectionTo(aP1x, aP1y, aP2x, aP2y)
	if aP1x == nil or aP1y == nil or aP2x == nil or aP2y == nil or GetPlayerFacing() == nil then
		return 0
	end
	if aP2x == 0 and aP2y == 0 then
		return 0
	end
		
	local ep2x = (aP2x - aP1x)
	local ep2y = (aP2y - aP1y)
	
	local Wa = math.acos(ep2x / math.sqrt(ep2x^2 + ep2y^2)) * (180 / math.pi)
	
	if ep2y > 0 then
		Wa = Wa * -1
	end
	local facing = (GetPlayerFacing() * (180 / math.pi))
	local facingfinal = facing
	if facing > 180 then
		facingfinal = (360 - facing) * -1
	end
	
	local afinal = Wa + facingfinal
	if afinal > 180 then
		afinal = afinal - 360
	elseif afinal < -180 then
		afinal = 360 + afinal
	end
	
	local uhrfloat = (afinal + 15) / 30
	local uhr = math.floor((afinal + 15) / 30)
	if uhr < 0 then
		uhr = 12 + uhr
	end
	if uhr == 0 then
		uhr = 12
	end

	return uhr, uhrfloat, afinal
end

---------------------------------------------------------------------------------------------------------------------------------------
local floor = math.floor
local sqrt = math.sqrt
function SkuNav:Distance(sx, sy, dx, dy)
	if sx and sy and dx and dy then
    	return floor(sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)), sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetContinentNameFromContinentId(aContinentId)
	if not SkuDB.ContinentIds[aContinentId] then
		return
	end
	return SkuDB.ContinentIds[aContinentId].Name_lang
end

---------------------------------------------------------------------------------------------------------------------------------------
local GetUiMapIdFromAreaIdCache = {}
function SkuNav:GetUiMapIdFromAreaId(aAreaId)
	if not SkuDB.InternalAreaTable[aAreaId] then
		return nil
	end
	if GetUiMapIdFromAreaIdCache[aAreaId] then
		return GetUiMapIdFromAreaIdCache[aAreaId]
	end

	local tCurrentId = aAreaId
	local tPrevId = aAreaId
	while tCurrentId > 0 do
		tPrevId = tCurrentId
		tCurrentId = SkuDB.InternalAreaTable[tCurrentId].ParentAreaID
	end

	for i, v in pairs(SkuDB.ExternalMapID) do
		if v.AreaId == tPrevId then
			GetUiMapIdFromAreaIdCache[aAreaId] = i
			return i
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAreaIdFromUiMapId(aUiMapId)
	--dprint("GetAreaIdFromUiMapId", aUiMapId)
	local rAreaId
	--[[
	local tName = SkuDB.ExternalMapID[aUiMapId].Name_lang
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if v.AreaName_lang == tName then
			rAreaId = i
		end
	end
	]]
	local tMinimapZoneText = GetMinimapZoneText()
 	if tMinimapZoneText == L["Deeprun Tram"] then --fix for strange DeeprunTram zone
		rAreaId = 2257
	else
		if SkuDB.ExternalMapID[aUiMapId] then
			rAreaId = SkuDB.ExternalMapID[aUiMapId].AreaId
		end
	end
	return rAreaId
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAreaIdFromAreaName(aAreaName)
	--dprint("GetAreaIdFromAreaName", aAreaName)
	local rAreaId
	local tPlayerUIMap = SkuNav:GetBestMapForUnit("player")
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if (v.AreaName_lang == aAreaName) and (SkuNav:GetUiMapIdFromAreaId(i) == tPlayerUIMap) then
			rAreaId = i
		end
	end
	--dprint("  ", tonumber(rAreaId))
	return rAreaId
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAreaData(aAreaId)
	--dprint("GetAreaData", aAreaId)
	if not SkuDB.InternalAreaTable[aAreaId] then 
		return
	end
	return SkuDB.InternalAreaTable[aAreaId].ZoneName, SkuDB.InternalAreaTable[aAreaId].AreaName_lang, SkuDB.InternalAreaTable[aAreaId].ContinentID, SkuDB.InternalAreaTable[aAreaId].ParentAreaID, SkuDB.InternalAreaTable[aAreaId].Faction, SkuDB.InternalAreaTable[aAreaId].Flags
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetSubAreaIds(aAreaId)
	--dprint("GetSubAreaIds", aAreaId)
	local tAreas = {}
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if v.ParentAreaID == tonumber(aAreaId) then
			tAreas[i] = i
			for i1, v1 in pairs(SkuDB.InternalAreaTable) do
				if v1.ParentAreaID == tonumber(i) then
					tAreas[i1] = i1
				end
			end
		end
	end
	--dprint("  ", tAreas)
	for i, v in pairs(tAreas) do
		--dprint("  ", i, v)
	end
	return tAreas
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetCurrentAreaId()
	--dprint("GetCurrentAreaId")
	local tMinimapZoneText = GetMinimapZoneText()
	--if tMinimapZoneText == "Die Tiefenbahn" then
		--return 2257
	--end
	local tAreaId
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if (v.AreaName_lang == tMinimapZoneText)  and (SkuNav:GetUiMapIdFromAreaId(i) == tPlayerUIMap) then
			tAreaId = i
			break
		end
	end
	if not tAreaId then
		local tExtMapId = SkuDB.ExternalMapID[SkuNav:GetBestMapForUnit("player")]
		if tExtMapId then
			for i, v in pairs(SkuDB.InternalAreaTable) do
				if v.AreaName_lang == tExtMapId.Name_lang then
					tAreaId = i
					break
				end
			end
		end
	end
	--dprint("  ", tAreaId)
	return tAreaId
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetDistanceToWp(aWpName)
	if not SkuNav:GetWaypointData2(aWpName) then
		return nil
	end
	local tEndx, tEndy = SkuNav:GetWaypointData2(aWpName).worldX, SkuNav:GetWaypointData2(aWpName).worldY
	local x, y = UnitPosition("player")
	if x and y then
		local ep2x = (tEndx - x)
		local ep2y = (tEndy - y)
		if ep2x and ep2y then
			return SkuNav:Distance(0, 0, ep2x, ep2y)
		else
			return nil
		end
	else
		return nil
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetDirectionToWp(aWpName)
	if not SkuNav:GetWaypointData2(aWpName) then
		return nil
	end
	local x, y = UnitPosition("player")
	return SkuNav:GetDirectionTo(x, y, SkuNav:GetWaypointData2(aWpName).worldX, SkuNav:GetWaypointData2(aWpName).worldY)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteRoute(aWpNameA, aWpNameB)
	local tWpAData = SkuNav:GetWaypointData2(aWpNameA)
	local tWpBData = SkuNav:GetWaypointData2(aWpNameB)

	if not aWpNameA or not aWpNameB then
		return false
	end
	
	if not tWpAData.links.byName[aWpNameB] or not tWpBData.links.byName[aWpNameA] then
		return false
	end

	WaypointCache[WaypointCacheLookupAll[aWpNameA]].links.byName[aWpNameB] = nil
	WaypointCache[WaypointCacheLookupAll[aWpNameA]].links.byId[WaypointCacheLookupAll[aWpNameB]] = nil
	WaypointCache[WaypointCacheLookupAll[aWpNameB]].links.byName[aWpNameA] = nil
	WaypointCache[WaypointCacheLookupAll[aWpNameB]].links.byId[WaypointCacheLookupAll[aWpNameA]] = nil
	
	SkuOptions.db.profile[MODULE_NAME].Links[aWpNameA][aWpNameB] = nil
	SkuOptions.db.profile[MODULE_NAME].Links[aWpNameB][aWpNameA] = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:StartRouteRecording(aWPAName, aDeleteFlag)
	print("StartRouteRecording", aWPAName, aDeleteFlag)
	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString("Route folgen läuft", false, true, 0.3, true)
		return
	end
	if SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString("Aufzeichnung läuft", false, true, 0.3, true)
		return
	end
	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString("", false, true, 0.3, true)
		SkuOptions.Voice:OutputString("Wegpunkt folgen läuft", false, true, 0.3, true)
		return
	end

	SkuOptions.db.profile[MODULE_NAME].routeRecording = true
	if aDeleteFlag then
		SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete = true
	end
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = aWPAName

	SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
	SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
	SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""

	SkuOptions:CloseMenu()

	SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)
	if not aDeleteFlag then
		SkuOptions:VocalizeMultipartString(L["recording;starts"], false, true, 0.3, true)
	else
		SkuOptions:VocalizeMultipartString("Löschen beginnt", false, true, 0.3, true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:EndRouteRecording(aWpName, aDeleteFlag)
	print("EndRouteRecording", aWpName, aDeleteFlag)
	if SkuOptions.db.profile[MODULE_NAME].routeRecording == false or 
		not SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp or 
		SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp == "" 
	then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Not recording"], false, true, 0.3, true)
		return
	end

	if not aDeleteFlag and SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete ~= true then
		if SkuNav:GetWaypointData2(aWpName) then
			--update links
			local tWpAName = aWpName
			local tWpBName = SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp
			if tWpAName ~= tWpBName then
				SkuNav:CreateWpLink(tWpAName, tWpBName)
			end
		end
	end

	if aDeleteFlag and SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete == true then
		SkuNav:DeleteWpLink(aWpName, SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp)
		SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete = nil
	end

	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = nil

	SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)
	if not aDeleteFlag then
		SkuOptions.Voice:OutputString("Aufzeichnung beendet", false, true, 0.2)
	else
		SkuOptions.Voice:OutputString("Löschen beendet", false, true, 0.2)
	end

	SkuOptions:CloseMenu()	
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CheckPolygons(x, y)
	local rPolyIndex = {}
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())

	for i = 1, #SkuDB.Polygons.data do
		if SkuDB.Polygons.data[i].continentId == tPlayerContinentID then
			local tInPolygon = 0
			for q = 1, #SkuDB.Polygons.data[i].nodes do
				local ax, ay, bx, by = SkuDB.Polygons.data[i].nodes[q].x, SkuDB.Polygons.data[i].nodes[q].y
				if q < #SkuDB.Polygons.data[i].nodes then 
					bx, by = SkuDB.Polygons.data[i].nodes[q+1].x, SkuDB.Polygons.data[i].nodes[q+1].y
				else
					bx, by = SkuDB.Polygons.data[i].nodes[1].x, SkuDB.Polygons.data[i].nodes[1].y
				end
				if SkuNav:IntersectionPoint(fPlayerPosX, fPlayerPosY, 50000, 50000, ax, ay, bx, by) then
					tInPolygon = tInPolygon + 1
				end
			end
			if tInPolygon == 1 or (floor(tInPolygon / 2) * 2 ~= tInPolygon) then
				rPolyIndex[#rPolyIndex + 1] = i
			end
		end
	end

	return rPolyIndex
end

---------------------------------------------------------------------------------------------------------------------------------------
local tOldPolyZones = {
   [1] = {[1] = 0,},
   [2] = {[1] = 0,},
   [3] = {[1] = 0, [2] = 0, [3] = 0, [4] = 0,},
   [4] = {[1] = 0,},
}
local tdiold, tdisold = 0,0
SkuNav.MoveToWp = 0
local tCurrentDragWpName

function SkuNav:ProcessPolyZones()
	local tPolyZones = CheckPolygons(UnitPosition("player"))
	local tNewPolyZones = {
		[1] = {[1] = 0,},
		[2] = {[1] = 0,},
		[3] = {[1] = 0, [2] = 0, [3] = 0, [4] = 0,},
		[4] = {[1] = 0,},
	}
	for p = 1, #tPolyZones do
		tNewPolyZones[SkuDB.Polygons.data[tPolyZones[p]].type][SkuDB.Polygons.data[tPolyZones[p]].subtype] = tNewPolyZones[SkuDB.Polygons.data[tPolyZones[p]].type][SkuDB.Polygons.data[tPolyZones[p]].subtype] + 1
	end
	--setmetatable(tNewPolyZones, SkuPrintMT)					
	--dprint(tNewPolyZones)
	--world
	if tOldPolyZones[1][1] ~= tNewPolyZones[1][1] then
		if tNewPolyZones[1][1] == 0 then
			--dprint("world left")
			SkuOptions.Voice:OutputString(L["World boundary left"], false, true, nil, true) --aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine
		elseif tOldPolyZones[1][1] == 0 then
			--dprint("world entered")
			SkuOptions.Voice:OutputString(L["World boundary entered"], false, true, nil, true)
		end
		tOldPolyZones[1][1] = tNewPolyZones[1][1] 
	end
	--fly
	if tOldPolyZones[2][1] ~= tNewPolyZones[2][1] then
		if tNewPolyZones[2][1] == 0 then
			--dprint("fly left")
			SkuOptions.Voice:OutputString(L["Flight zone left"], false, true, nil, true)
		elseif tOldPolyZones[2][1] == 0 then
			--dprint("fly entered")
			SkuOptions.Voice:OutputString(L["Flight zone entered"], false, true, nil, true)
		end
		tOldPolyZones[2][1] = tNewPolyZones[2][1] 
	end
	--faction
	if tOldPolyZones[3][1] ~= tNewPolyZones[3][1] then
		if tNewPolyZones[3][1] == 0 then
			--dprint("alliance left")
			SkuOptions.Voice:OutputString(L["Alliance zone left"], false, true, nil, true)
		elseif tOldPolyZones[3][1] == 0 then
			--dprint("alliance entered")
			SkuOptions.Voice:OutputString(L["Alliance zone entered"], false, true, nil, true)
		end
		tOldPolyZones[3][1] = tNewPolyZones[3][1] 
	end
	if tOldPolyZones[3][2] ~= tNewPolyZones[3][2] then
		if tNewPolyZones[3][2] == 0 then
			--dprint("horde left")
			SkuOptions.Voice:OutputString(L["Horde zone left"], false, true, nil, true)
		elseif tOldPolyZones[3][2] == 0 then
			--dprint("horde entered")
			SkuOptions.Voice:OutputString(L["Horde zone entered"], false, true, nil, true)
		end
		tOldPolyZones[3][2] = tNewPolyZones[3][2] 
	end
	if tOldPolyZones[3][3] ~= tNewPolyZones[3][3] then
		if tNewPolyZones[3][3] == 0 then
			--dprint("horde left")
			SkuOptions.Voice:OutputString(L["Aldor zone left"], false, true, nil, true)
		elseif tOldPolyZones[3][3] == 0 then
			--dprint("horde entered")
			SkuOptions.Voice:OutputString(L["Aldor zone entered"], false, true, nil, true)
		end
		tOldPolyZones[3][3] = tNewPolyZones[3][3] 
	end
	if tOldPolyZones[3][4] ~= tNewPolyZones[3][4] then
		if tNewPolyZones[3][4] == 0 then
			--dprint("horde left")
			SkuOptions.Voice:OutputString(L["Scyer zone left"], false, true, nil, true)
		elseif tOldPolyZones[3][4] == 0 then
			--dprint("horde entered")
			SkuOptions.Voice:OutputString(L["Scyer zone entered"], false, true, nil, true)
		end
		tOldPolyZones[3][4] = tNewPolyZones[3][4] 
	end

	--other
	if tOldPolyZones[4][1] ~= tNewPolyZones[4][1] then
		if tNewPolyZones[4][1] == 0 then
			--dprint("other left")
			SkuOptions.Voice:OutputString("Wer das hört ist doof verlassen", false, true, nil, true)
		elseif tOldPolyZones[4][1] == 0 then
			--dprint("other entered")
			SkuOptions.Voice:OutputString("Wer das hört ist doof betreten", false, true, nil, true)
		end
		tOldPolyZones[4][1] = tNewPolyZones[4][1] 
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ProcessPlayerDead()
	if not UnitIsGhost("player") then
		return
	end
	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		return
	end
	local tUiMap = SkuNav:GetBestMapForUnit("player")
	if not tUiMap then
		return
	end
	local tCorpse = C_DeathInfo.GetCorpseMapPosition(tUiMap)
	if not tCorpse then
		return
	end
	local cX, cY = tCorpse:GetXY()
	local tmapPos = CreateVector2D(cX, cY)
	local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetBestMapForUnit("player"), tmapPos)
	local tX, tY = worldPosition:GetXY()

	local tPlayerx, tPlayery = UnitPosition("player")
	local distance = SkuNav:Distance(tPlayerx, tPlayery, tX, tY)

	if distance > 10 then
		if SkuNav:GetWaypointData2(L["Quick waypoint"]..";4") then
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").worldX = tX
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").worldY = tY								
			local tAreaId = SkuNav:GetCurrentAreaId()
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").areaId = tAreaId
			SkuNav:SelectWP(L["Quick waypoint"]..";4", true)

			SkuOptions.Voice:OutputString(L["Quick waypoint 4 set to corpse"], false, true, 0.2)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ProcessGlobalDirection(ttimeDistanceOutput)
	local tText = UnitPosition("player")
	if not tText then
		return
	end
	if (IsShiftKeyDown() and IsAltKeyDown())then
		if GetServerTime() - ttimeDistanceOutput > 0.5 then
			local x, y = UnitPosition("player")
			ttimeDistanceOutput = GetServerTime()
			local tDirection = SkuNav:GetDirectionTo(x, y, 30000, y)
			tDirection = 12 - tDirection if tDirection == 0 then tDirection = 12 end
			--SkuOptions.Voice:Output("nod-"..string.format("%02d", tDirection)..".mp3", true, true, 0.3)

			local _, _, afinal = SkuNav:GetDirectionTo(x, y, 30000, y)
			local tDeg = {
				[1] = {deg = 181, file = "male-Süd"},
				[2] = {deg = 157.5, file = "male-Südwest"},
				[3] = {deg = 112.5, file = "male-West"},
				[4] = {deg = 67.5, file = "male-Nordwest"},
				[5] = {deg = 22.5, file = "male-Nord"},
				[6] = {deg = -22.5, file = "male-Nordost"},
				[7] = {deg = -67.5, file = "male-Ost"},
				[8] = {deg = -112.5, file = "male-Südost"},
				[9] = {deg = -157.5, file = "male-Süd"},
				[10] = {deg = -181, file = "male-Süd"},
			}
			for x = 1, #tDeg do
				if afinal < tDeg[x].deg and afinal > tDeg[x + 1].deg then
					SkuOptions.Voice:OutputString(tDeg[x].file, false, true, 0.2)
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ProcessDirAndDistWithWpSelected(ttimeDistanceOutput)
	--output direction and distance to wp if wp selected
	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		if SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			if distance then
				if IsControlKeyDown() and IsAltKeyDown() then
					if GetServerTime() - ttimeDistanceOutput > 0.2 then
						ttimeDistanceOutput = GetServerTime()
						local tDirection = SkuNav:GetDirectionToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						if SkuOptions.db.profile[MODULE_NAME].vocalizeFullDirectionDistance == true then
							SkuOptions.Voice:OutputString(string.format("%02d", tDirection)..";"..L["Clock"], true, true, 0.3)
							SkuOptions.Voice:OutputString(distance..";"..L["Meter"], false, true, 0.2)
						else
							SkuOptions.Voice:OutputString(string.format("%02d", tDirection), true, true, 0.3)
							SkuOptions.Voice:OutputString(distance, false, true, 0.2)
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:StartReverseRtFollow()
	--dprint("StartReverseRtFollow")
	if not SkuNav.ReverseRt.meta.metapathFollowingStart then
		return
	end

	if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Recording in progress"], false, true, 0.3, true)
		return
	end

	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		SkuNav:EndFollowingWpOrRt()
	end

	SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = SkuNav.ReverseRt.meta.metapathFollowingStart
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = SkuNav.ReverseRt.meta.metapathFollowingTarget
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = {}
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[#SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths+1] = SkuNav.ReverseRt.meta.metapathFollowingTarget
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuNav.ReverseRt.meta.metapathFollowingTarget] = SkuNav.ReverseRt.meta.metapathFollowingMetapaths
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = 1
	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = true

	SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart, true)
	SkuOptions.Voice:OutputString("Zurück Metaroute folgen gestartet", false, true, 0.2)

	SkuOptions:CloseMenu()
end

--------------------------------------------------------------------------------------------------------------------------------------
SkuNav.ReverseRt = {
	meta = {},
	single = {},
}
function SkuNav:UpdateReverseRtData()
	--dprint("UpdateReverseRtData")
	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing ~= true then
		return
	end
	SkuNav.ReverseRt.meta = {
		metapathFollowingStart = SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp],
		metapathFollowingTarget = SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart,
		metapathFollowingMetapaths = {
			pathWps = {},
			distance = 0,
		},
		metapathFollowingCurrentWp = 1,
	}

	for x = SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp, 1, -1 do
		table.insert(SkuNav.ReverseRt.meta.metapathFollowingMetapaths.pathWps, SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[x])
	end

	local tDistance = 0
	local tDistanceToStartWp = 0
	for z = 2, #SkuNav.ReverseRt.meta.metapathFollowingMetapaths.pathWps do
		local tWpA = SkuNav:GetWaypointData2(SkuNav.ReverseRt.meta.metapathFollowingMetapaths.pathWps[z - 1])
		local tWpB = SkuNav:GetWaypointData2(SkuNav.ReverseRt.meta.metapathFollowingMetapaths.pathWps[z])
		tDistance = tDistance + SkuNav:Distance(tWpA.worldX, tWpA.worldY, tWpB.worldX, tWpB.worldY)
		if tDistanceToStartWp == 0 then
			tDistanceToStartWp = tDistance
		end
	end
	SkuNav.ReverseRt.meta.metapathFollowingMetapaths.distance = tDistance
	SkuNav.ReverseRt.meta.metapathFollowingMetapaths.distanceToStartWp = tDistanceToStartWp
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ProcessCheckReachingWp()
	if SkuOptions.db.profile[MODULE_NAME].routeRecording ~= true and SkuOptions.db.profile[MODULE_NAME].metapathFollowing ~= true then
		--we're following a single wp
		if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
			local tWpObject = SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			if tWpObject then
				--not rt recording/following, just a single wp
				local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
				if distance then
					if distance < SkuNavWpSize[tWpObject.size] and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)
						SkuOptions:VocalizeMultipartString(L["Arrived;at;waypoint"], false, true, 0.3, true)
							
						if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
							SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						end
						SkuNav:SelectWP("", true)
					end
				end
			end
		end
	else
		--we're following a rt
		if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint and SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
			if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
				local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) or 0
				if distance then
					local tDistanceMod = SkuNav.CurrentStandardWpReachedRange --0
					if ((distance < SkuNavWpSize[SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size] + tDistanceMod) or SkuNav.MoveToWp ~= 0) and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						local tNextWPNr
						if SkuNav.MoveToWp ~= 0 then
							tNextWPNr = SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp + SkuNav.MoveToWp
							if tNextWPNr > #SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps then
								tNextWPNr = #SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps
							end
							if tNextWPNr < 1  then
								tNextWPNr = 1
							end
						else
							tNextWPNr = SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp + 1
						end
						if not SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget] then
							SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							SkuOptions:VocalizeMultipartString(L["Error in route;follow stopped"]..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
						end
						if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[tNextWPNr] then
							SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)
							SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
								SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							end
							SkuOptions.Voice:OutputString(L["still"]..";"..(#SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps - tNextWPNr + 1), true, true, 0, true)

							SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[tNextWPNr], true)
							SkuNav:UpdateReverseRtData()
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = tNextWPNr
						else
							SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)
							SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
								SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							end
							SkuOptions:VocalizeMultipartString(L["Arrived at target"]..";", false, true, 0.3, true)

							SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = nil
							SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = nil
							SkuNav:UpdateReverseRtData()
							SkuNav:SelectWP("", true)
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
local mouseMiddleDown = false
local mouseMiddleUp = false
local mouseLeftDown = false
local mouseLeftUp = false
local mouseRightDown = false
local mouseRightUp = false
local mouse4Down = false
local mouse4Up = false
local mouse5Down = false
local mouse5Up = false
function SkuNav:ProcessRecordingMousClickStuff()
	--rt recording per mouse click stuff
	if IsControlKeyDown() == true then
		_G["SkuNavWpDragClickTrap"]:Show()

		if mouse5Down == false then
			if IsMouseButtonDown("Button5") == true then
				mouse5Up = false
				mouse5Down = true
				SkuNav:OnMouse5Down()
			end
		elseif mouse5Down == true then
			SkuNav:OnMouse5Hold()
			if IsMouseButtonDown("Button5") ~= true then
				mouse5Down = false
				mouse5Up = true
				SkuNav:OnMouse5Up()
			end
		end

		if mouse4Down == false then
			if IsMouseButtonDown("Button4") == true then
				mouse4Up = false
				mouse4Down = true
				SkuNav:OnMouse4Down()
			end
		elseif mouse4Down == true then
			SkuNav:OnMouse4Hold()
			if IsMouseButtonDown("Button4") ~= true then
				mouse4Down = false
				mouse4Up = true
				SkuNav:OnMouse4Up()
			end
		end

		if mouseMiddleDown == false then
			if IsMouseButtonDown("MiddleButton") == true then
				mouseMiddleUp = false
				mouseMiddleDown = true
				SkuNav:OnMouseMiddleDown()
			end
		elseif mouseMiddleDown == true then
			SkuNav:OnMouseMiddleHold()
			if IsMouseButtonDown("MiddleButton") ~= true then
				mouseMiddleDown = false
				mouseMiddleUp = true
				SkuNav:OnMouseMiddleUp()
			end
		end

		if mouseLeftDown == false then
			if IsMouseButtonDown("LeftButton") == true then
				mouseLeftUp = false
				mouseLeftDown = true
				SkuNav:OnMouseLeftDown()
			end
		elseif mouseLeftDown == true then
			SkuNav:OnMouseLeftHold()
			if IsMouseButtonDown("LeftButton") ~= true then
				mouseLeftDown = false
				mouseLeftUp = true
				SkuNav:OnMouseLeftUp()
			end
		end

		if mouseRightDown == false then
			if IsMouseButtonDown("RightButton") == true then
				mouseRightUp = false
				mouseRightDown = true
				SkuNav:OnMouseRightDown()
			end
		elseif mouseRightDown == true then
			SkuNav:OnMouseRightHold()
			if IsMouseButtonDown("RightButton") ~= true then
				mouseRightDown = false
				mouseRightUp = true
				SkuNav:OnMouseRightUp()
			end

		end
	else
		mouseMiddleDown = false
		mouseMiddleUp = false
		mouseLeftDown = false
		mouseLeftUp = false
		mouseRightDown = false
		mouseRightUp = false
		_G["SkuNavWpDragClickTrap"]:Hide()
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
local metapathFollowingTargetNameAnnounced = false
function SkuNav:CreateSkuNavControl()
	local ttimeDegreesChangeInitial = nil
	local ttimeDistanceOutput = 0
	local ttime = GetServerTime()
	local ttimeDraw = GetServerTime()

	local f = _G["SkuNavControl"] or CreateFrame("Frame", "SkuNavControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
		if SkuOptions.db.profile[MODULE_NAME].enable == true then
 			ttime = ttime + time
			ttimeDraw = ttimeDraw + time

			--tmp drawing rts on UIParent for debugging
			if ttimeDraw > 0.2 then
				--SkuNav:DrawRoutes(_G["Minimap"])
				SkuNav:DrawAll(_G["Minimap"])
				--SkuNav:DrawRoutes(_G["WorldMapFrame"])
				--SkuNav:DrawRoutes(_G["SkuNavRoutesView"])
				ttimeDraw = 0
			end
			
			if SkuOptions.db.profile["SkuNav"].RtAndWpVersion then
				if SkuOptions.db.profile["SkuNav"].RtAndWpVersion >= 22 then
					SkuWaypointWidgetCurrent = nil
					for i, v in SkuWaypointWidgetRepo:EnumerateActive() do
						if i:IsVisible() == true then
							if i:IsMouseOver() then
								if i.aText ~= SkuWaypointWidgetCurrent then
									SkuWaypointWidgetCurrent = i.aText

									GameTooltip.SkuWaypointWidgetCurrent = i.aText
									GameTooltip:ClearLines()
									GameTooltip:SetOwner(i, "ANCHOR_RIGHT")
									GameTooltip:AddLine(i.aText, 1, 1, 1)
									GameTooltip:Show()
									i:SetSize(3, 3)
									local r, g, b, t = i:GetVertexColor()
									i.oldColor = {r = r, g = g, b = b, t = t}
									i:SetColorTexture(0, 1, 1)
								else
									i:SetSize(2, 2)
									if i.oldColor then
										i:SetColorTexture(i.oldColor.r, i.oldColor.g, i.oldColor.b, i.oldColor.a)
										--i:SetColorTexture(i.oldColor)
									end
								end
							end
						end
					end
					
					if SkuWaypointWidgetRepoMM then
						if _G["SkuNavMMMainFrame"]:IsShown() then
							SkuWaypointWidgetCurrent = nil
							for i, v in SkuWaypointWidgetRepoMM:EnumerateActive() do
								if i:IsVisible() == true then
									if i.aText ~= "line" then
										if i:IsMouseOver() then
											local _, _, _, x, y = i:GetPoint(1)
											local MMx, MMy = _G["SkuNavMMMainFrame"]:GetSize()
											MMx, MMy = MMx / 2, MMy / 2
											if x > -MMx and x < MMx and y > -MMy and y < MMy then
												if i.aText ~= SkuWaypointWidgetCurrent then
													SkuWaypointWidgetCurrent = i.aText

													GameTooltip.SkuWaypointWidgetCurrent = i.aText
													GameTooltip:ClearLines()
													GameTooltip:SetOwner(i, "ANCHOR_RIGHT")
													GameTooltip:AddLine(i.aText, 1, 1, 1)
													if i.aComments then
														for x = 1, #i.aComments do
															GameTooltip:AddLine(i.aComments[x], 1, 1, 0)
														end
													end
													GameTooltip:Show()
													local r, g, b, a = i:GetVertexColor()
													i.oldColor = {r = r, g = g, b = b, a = a}
													--i.oldColor = i:GetVertexColor()
													i:SetColorTexture(0, 1, 1)
												else
													--i:SetSize(2, 2)
													if i.oldColor then
														i:SetColorTexture(i.oldColor.r, i.oldColor.g, i.oldColor.b, i.oldColor.a)
													end
												end
											end
										end
									end
								end
							end
						end
					end

					if GameTooltip:IsShown() and not SkuWaypointWidgetCurrent and GameTooltip.SkuWaypointWidgetCurrent then
						GameTooltip.SkuWaypointWidgetCurrent = nil
						GameTooltip:Hide()
					end

					SkuNav:ProcessRecordingMousClickStuff()
				end
			end

			if ttime > 0.1 then
				SkuNav:ProcessPolyZones()
				SkuNav:ProcessPlayerDead()
				SkuNav:ProcessGlobalDirection(ttimeDistanceOutput)
				SkuNav:ProcessDirAndDistWithWpSelected(ttimeDistanceOutput)
				SkuNav:ProcessCheckReachingWp()

				if SkuOptions.db.profile[MODULE_NAME].metapathFollowing ~= true then
					SkuNav:ClearWaypointsTemporary()
				end

				if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" or SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
					if SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName then
						if SkuCore:IsNamePlateVisible(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName) == true then
							if metapathFollowingTargetNameAnnounced == false then
								SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName, true, true, 0.3, true)
								SkuOptions.Voice:OutputString("sichtbar", false, true, 0.3, true)

								metapathFollowingTargetNameAnnounced = true
							end
						else
							if metapathFollowingTargetNameAnnounced == true then
								SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName, true, true, 0.3, true)
								SkuOptions.Voice:OutputString("nicht sichtbar", false, true, 0.3, true)
								metapathFollowingTargetNameAnnounced = false
							end
						end
					end
				end

				SkuNav.MoveToWp = 0
				ttime = 0
			end
		end
	end)
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CreateSkuNavMain()
	local tFrame = _G["OnSkuNavMain"] or CreateFrame("Button", "OnSkuNavMain", UIParent, "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("OnSkuNavMain")
	tFrame:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
	tFrame:SetPoint("CENTER")

	tFrame:SetScript("OnClick", function(self, a, b)
		if not SkuOptions.db.profile["SkuNav"].RtAndWpVersion or SkuOptions.db.profile["SkuNav"].RtAndWpVersion < 22 then
			print("Funktion erst nach Abschluss von Routen Umwandlung verfügbar")
			SkuOptions.Voice:OutputString("Funktion erst nach Abschluss von Routen Umwandlung verfügbar", true, true, 0.3, true)
			return
		end

		if a == "CTRL-SHIFT-R" then
			SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap = SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true
		end
		if a == "CTRL-SHIFT-F" then
			SkuOptions.db.profile[MODULE_NAME].showSkuMM = SkuOptions.db.profile[MODULE_NAME].showSkuMM == false
			SkuNav:SkuNavMMOpen()
		end

		if a == "CTRL-SHIFT-Q" then
			SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange + 1
			if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange > #SkuNav.StandardWpReachedRanges then
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = 1
			end
			SkuNav:UpdateStandardWpReachedRange(0)
			SkuOptions:VocalizeMultipartString(SkuNav.StandardWpReachedRanges[SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange], true, true, 0.3, true)
		end


		if a == "CTRL-SHIFT-Z" then
			SkuNav:StartReverseRtFollow()
		end
		
		--move to prev/next wp on following a rt
		if a == "CTRL-SHIFT-W" then
			SkuNav.MoveToWp = 1
		end
		if a == "CTRL-SHIFT-S" then
			SkuNav.MoveToWp = -1
		end

		--add manual int wp and link if recording
		if a == "CTRL-SHIFT-P" or a == "CTRL-SHIFT-O" then
			if SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete ~= true then
				local tWpSize = 1
				if a == "CTRL-SHIFT-O" then
					tWpSize = 5
				end
			
				local tNewWpName = SkuNav:CreateWaypoint(nil, nil, nil, tWpSize)
				
				if SkuOptions.db.profile[MODULE_NAME].routeRecording == true and 
					SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp and
					SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete ~= true
				then
					SkuNav:CreateWpLink(tNewWpName, SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp)
					SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = tNewWpName
					SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
				end
			end
		end

		if a == "SHIFT-M" then
			SkuNav.MinimapFull = SkuNav.MinimapFull == false
			if SkuNav.MinimapFull == true then
				MinimapCluster:SetScale(3.5)
			else
				MinimapCluster:SetScale(1)
			end
		end

		if a == "SHIFT-F5" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";1")
		end
		if a == "CTRL-SHIFT-F5" then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";1")
		end
		if a == "SHIFT-F6" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";2")
		end
		if a == "CTRL-SHIFT-F6" then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";2")
		end		
		if a == "SHIFT-F7" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";3")
		end
		if a == "CTRL-SHIFT-F7" then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";3")
		end		
		if a == "SHIFT-F8" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";4")
		end
		if a == "CTRL-SHIFT-F8" then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";4")
		end		
		
	end)
	tFrame:Hide()
	
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-Z", tFrame:GetName(), "CTRL-SHIFT-Z")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F", tFrame:GetName(), "CTRL-SHIFT-F")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-Q", tFrame:GetName(), "CTRL-SHIFT-Q")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-W", tFrame:GetName(), "CTRL-SHIFT-W")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-S", tFrame:GetName(), "CTRL-SHIFT-S")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-O", tFrame:GetName(), "CTRL-SHIFT-O")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-P", tFrame:GetName(), "CTRL-SHIFT-P")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-R", tFrame:GetName(), "CTRL-SHIFT-R")
	SetOverrideBindingClick(tFrame, true, "SHIFT-M", tFrame:GetName(), "SHIFT-M")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F5", tFrame:GetName(), "SHIFT-F5")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F5", tFrame:GetName(), "CTRL-SHIFT-F5")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F6", tFrame:GetName(), "SHIFT-F6")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F6", tFrame:GetName(), "CTRL-SHIFT-F6")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F7", tFrame:GetName(), "SHIFT-F7")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F7", tFrame:GetName(), "CTRL-SHIFT-F7")
	SetOverrideBindingClick(tFrame, true, "SHIFT-F8", tFrame:GetName(), "SHIFT-F8")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F8", tFrame:GetName(), "CTRL-SHIFT-F8")
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnEnable()
	--dprint("SkuNav OnEnable")
	if not SkuOptions.db.profile[MODULE_NAME].Waypoints then
		SkuOptions.db.profile[MODULE_NAME].Waypoints = {}
		for x = 1, 4 do
			local tWaypointName = L["Quick waypoint"]..";"..x
			SkuNav:UpdateQuickWP(tWaypointName)
		end		
	end

	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete = nil

	SkuNav:SelectWP("", true)

	if not SkuOptions.db.profile[MODULE_NAME].RecentWPs then
		SkuOptions.db.profile[MODULE_NAME].RecentWPs = {}
	end

	SkuNav:SkuNavMMOpen()
	SkuNav:CreateSkuNavControl()

	if SkuCore.inCombat == false then
		SkuNav:CreateSkuNavMain()		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
do
	local f = _G["SkuNavWpDragClickTrap"] or CreateFrame("Frame", "SkuNavWpDragClickTrap", _G["SkuNavMMMainFrameScrollFrame"], BackdropTemplateMixin and "BackdropTemplate" or nil)
	--f:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 32, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
	--f:SetBackdropColor(0, 0, 1, 1)
	f:SetFrameStrata("DIALOG")
	f:RegisterForDrag()
	f:SetWidth(1)
	f:SetHeight(1)
	f:SetAllPoints()
	f:EnableMouse(true)
	f:Hide()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseLeftDown()
	--dprint("L down")
	local tWpName = SkuWaypointWidgetCurrent--GetMouseFocus().aText or GetMouseFocus().WpName
	if tWpName then
		local wpObj = SkuNav:GetWaypointData2(tWpName)
		if wpObj then
			if tWpName.typeId == 1 then
				tCurrentDragWpName = tWpName
			else
				if IsShiftKeyDown() then
					--standard wp
					tCurrentDragWpName = tWpName
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseLeftHold()
	if tCurrentDragWpName then
		local tWpData = SkuNav:GetWaypointData2(tCurrentDragWpName)
		if tWpData then
			local tDragY, tDragX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
			if tDragX and tDragY then
				SkuNav:SetWaypoint(tCurrentDragWpName, {
					worldX = tDragX,
					worldY = tDragY,
				})
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseLeftUp()
	--dprint("L up")
	if tCurrentDragWpName then
		local tWpData = SkuNav:GetWaypointData2(tCurrentDragWpName)
		if tWpData then
			local tDragY, tDragX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
			if tDragX and tDragY then
				SkuNav:SetWaypoint(tCurrentDragWpName, {
					worldX = tDragX,
					worldY = tDragY,
				})
			end
		end
	end
	_G["SkuNavWpDragClickTrap"]:Hide()
	SkuWaypointWidgetCurrent = nil
	SkuWaypointWidgetCurrentMMX = nil
	SkuWaypointWidgetCurrentMMY = nil
	tCurrentDragWpName = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseRightDown()
	--dprint("R up")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseRightHold()
	--dprint("R hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseRightUp()
	--dprint("R up")
	if SkuNavRecordingPoly > 0 and SkuNavRecordingPolyFor then
		local tWorldY, tWorldX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
		SkuDB.Polygons.data[SkuNavRecordingPolyFor].nodes[#SkuDB.Polygons.data[SkuNavRecordingPolyFor].nodes + 1] = {x = tWorldX, y = tWorldY,}
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Down()
	--dprint("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Hold()
	--dprint("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Up(aUseTarget)
	if SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete == true then
		return
	end

	local tWy, tWx = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
	local tWpSize = 1
	if IsShiftKeyDown() then
		tWpSize = 5
	end
	local tNewWpName = SkuNav:CreateWaypoint(nil, tWx, tWy, tWpSize)

	if SkuOptions.db.profile[MODULE_NAME].routeRecording == true and SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp then
		SkuNav:CreateWpLink(tNewWpName, SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp)
		SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = tNewWpName
	end
	
	SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleDown()
	--dprint("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleHold()
	--dprint("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleUp()
	--dprint("M up", aUseTarget)

	local tWpName = SkuWaypointWidgetCurrent--GetMouseFocus().aText or GetMouseFocus().WpName
	if not tWpName then
		return
	end

	local wpObj = SkuNav:GetWaypointData2(tWpName)
	if not wpObj then
		return
	end

	if IsAltKeyDown() then
		local wpObj = SkuNav:GetWaypointData2(tWpName)
		if wpObj then
			WaypointCache[WaypointCacheLookupAll[tWpName]].comments = nil
			if SkuOptions.db.profile[MODULE_NAME].Waypoints[tWpName] then
				SkuOptions.db.profile[MODULE_NAME].Waypoints[tWpName].comments = nil
			end
		end
		return
	elseif IsShiftKeyDown() then
		if SkuOptions.db.profile[MODULE_NAME].routeRecording ~= true then
			SkuNav:StartRouteRecording(tWpName, true)
			print("Start:", tWpName)
		else
			if SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete == true then
				print("End:", tWpName)	
				SkuNav:EndRouteRecording(tWpName, true)
			end
		end
	else
		if SkuOptions.db.profile[MODULE_NAME].routeRecording ~= true then
			SkuNav:StartRouteRecording(tWpName)
			print("Start:", tWpName)
		else
			if SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete ~= true then
				print("End:", tWpName)
				SkuNav:EndRouteRecording(tWpName)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Down()
	--dprint("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Hold()
	--dprint("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Up()
	--dprint("OnMouse5Up")
	if SkuWaypointWidgetCurrent then
		local wpObj = SkuNav:GetWaypointData2(SkuWaypointWidgetCurrent)
		if wpObj then
			SkuNav:DeleteWaypoint(SkuWaypointWidgetCurrent)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:IntersectionPoint(x1, y1, x2, y2, x3, y3, x4, y4)
	if x1 and y1 and x2 and y2 and x3 and y3 and x4 and y4 then
		 local d 
		 local Ua 
		 local Ub 
		 --Pre calc the denominator, if zero then both lines are parallel and there is no intersection
		 d = ((y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1))
		 if d ~= 0 then
			  --Solve for the simultaneous equations
			  Ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / d
			  Ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / d
		 end 
		 if Ua and Ub then
			  --Could the lines intersect?
			  if Ua >= -0.0 and Ua <= 1.0 and Ub >= -0.0 and Ub <= 1.0 then
					--Calculate the intersection point
					local x = x1 + Ua * (x2 - x1)
					local y = y1 + Ua * (y2 - y1)
					--Yes, they do
					return x, y, Ua
			  end
		 end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aX number
---@param aY number
---@param aRange number
function SkuNav:GetAllLinkedWPsInRangeToCoords(aX, aY, aRange)
	--dprint("GetAllLinkedWPsInRangeToCoords", aX, aY, aRange)
	aRange = aRange or 100
	local tCount = 0
	local tFoundWps = {}
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tPlayerUIMapId = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId()) or SkuNav:GetCurrentAreaId()

	for tIndex, tName in pairs(WaypointCacheLookupPerContintent[tPlayerContinentID]) do
		local tWpData = WaypointCache[tIndex]
		if tWpData.links.byId then
			local tDistance  = SkuNav:Distance(aX, aY, tWpData.worldX, tWpData.worldY)
			if tDistance < aRange then
				tFoundWps[tName] = {["nearestWP"] = tName, ["nearestWpRange"] = tDistance}
				tCount = tCount + 1
			end
		end
	end

	return tFoundWps
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:EndFollowingWpOrRt()
	if SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
		if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
			if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			end
			SkuNav:SelectWP("", true)
			SkuOptions.Voice:OutputString(L["following stopped"], false, true, 0.3, true)
		end
	end
	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
	SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName = nil
	SkuNav:SelectWP("", true)
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aWpName number
---@param aNoVoice bool if the selection should be vocalized
function SkuNav:SelectWP(aWpName, aNoVoice)
	--dprint("SkuNav:SelectWP(aWpName, aNoVoice", aWpName, aNoVoice)
	if not aWpName then
		return
	end

	if aWpName == "" then
		for i, v in SkuOptions.BeaconLib:GetBeacons("SkuOptions") do
			SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", v)
		end
		SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
		return
	end


	if not SkuNav:GetWaypointData2(aWpName) then
		return
	end

	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint then
		if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
		end
	end

	local tDistanceToNewWp = SkuNav:GetDistanceToWp(aWpName)
	SkuNav:UpdateStandardWpReachedRange(tDistanceToNewWp)


	SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = aWpName

	local tBeaconType = "probe_deep_1"
	if SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size == 5 then
		tBeaconType = "probe_mid_1"
		--tBeaconType = "probe_deep_1_b"
	end

	if SkuOptions.db.profile[MODULE_NAME].clickClackEnabled == true then
		if SkuOptions.db.profile[MODULE_NAME].clickClackSoundset and SkuOptions.db.profile[MODULE_NAME].clickClackSoundset ~= "off" then
			tBeaconType = tBeaconType..SkuOptions.db.profile[MODULE_NAME].clickClackSoundset
		end
	end
	SkuOptions.BeaconLib:CreateBeacon("SkuOptions", aWpName, tBeaconType, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume, SkuOptions.db.profile[MODULE_NAME].clickClackRange)
	SkuOptions.BeaconLib:StartBeacon("SkuOptions", aWpName)

	if not string.find(aWpName, L["auto"]..";") then
		for x = 1, #SkuOptions.db.profile[MODULE_NAME].RecentWPs do
			if SkuOptions.db.profile[MODULE_NAME].RecentWPs[x] == aWpName then
				table.remove(SkuOptions.db.profile[MODULE_NAME].RecentWPs, x)
			end
		end
		table.insert(SkuOptions.db.profile[MODULE_NAME].RecentWPs, 1, aWpName)
		if #SkuOptions.db.profile[MODULE_NAME].RecentWPs > 10 then
			table.remove(SkuOptions.db.profile[MODULE_NAME].RecentWPs, #SkuOptions.db.profile[MODULE_NAME].RecentWPs)
		end
	end

	local worldx, worldy = UnitPosition("player")

	lastDirection = SkuNav:GetDirectionTo(worldx, worldy, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY)

	if not aNoVoice then
		--PlaySound(835)
		SkuOptions:VocalizeMultipartString(aWpName..";"..L["selected"], true, true, 0.2)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateQuickWP(aWpName)
	if not aWpName then
		return
	end

	if not SkuNav:GetWaypointData2(aWpName) then
		return
	end

	local tAreaId = SkuNav:GetCurrentAreaId()

	if tAreaId == 0 then
		SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
		return
	end

	local worldx, worldy = UnitPosition("player")
	local tPName = UnitName("player")
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())) or -1
	local tTime = GetTime()
	SkuNav:SetWaypoint(aWpName, {
		["contintentId"] = tPlayerContintentId,
		["areaId"] = tAreaId,
		["worldX"] = worldx,
		["worldY"] = worldy,
		["createdAt"] = tTime, 
		["createdBy"] = tPName,
		["size"] = 1,
	})
	SkuOptions:VocalizeMultipartString(aWpName..";"..L["updated"], true, true, 0.2)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnDisable()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_LEAVING_WORLD(...)
	SkuNav:ClearWaypointsTemporary()
	SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = {}
	
	if SkuOptions.currentBackgroundSoundHandle then
		StopSound(SkuOptions.currentBackgroundSoundHandle, 0)
	end
	if SkuCore.currentBackgroundSoundHandle then
		StopSound(SkuCore.currentBackgroundSoundHandle, 0)
	end
	SkuOptions.BeaconLib:DestroyBeacon("SkuOptions")
	SkuOptions.Voice:StopAllOutputs()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_UNGHOST(...)
	if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
		SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
	end
	SkuNav:SelectWP("", true)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_LOGIN(...)
	--dprint("PLAYER_LOGIN", ...)
	SkuNav.MinimapFull = false

	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = nil
		
	-- quick wps F5-7
	for x = 1, 4 do
		local tWaypointName = L["Quick waypoint"]..";"..x
		SkuNav:UpdateQuickWP(tWaypointName)
	end

	--tomtom integration for adding beacons to the arrow
	if TomTom then
		SkuOptions.tomtomBeaconName = "SkuTomTomBeacon"
		C_Timer.NewTimer(5, function() 
			hooksecurefunc(TomTom, "AddWaypoint", function(self, map, x, y, options)
				if SkuOptions.db.profile[MODULE_NAME].tomtomWp == true then
					local bx, by = SkuOptions.HBD:GetWorldCoordinatesFromZone(x, y, map)
					SkuOptions.BeaconLib:CreateBeacon("SkuOptions", SkuOptions.tomtomBeaconName, "probe_mid_1", by, bx, -3, 1, SkuOptions.db.profile["SkuNav"].beaconVolume)
					SkuOptions.BeaconLib:StartBeacon("SkuOptions", SkuOptions.tomtomBeaconName)
				end
			end)
			hooksecurefunc(TomTom, "RemoveWaypoint", function(self, uid)
				if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.tomtomBeaconName) then
					SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.tomtomBeaconName)
				end
			end)
			hooksecurefunc(TomTom, "AddWaypointToCurrentZone", function(self, x, y, desc)
				--dprint("AddWaypointToCurrentZone", x, y, desc)
			end)
			hooksecurefunc(TomTom, "HideWaypoint", function(self, uid, minimap, worldmap)
				--dprint("HideWaypoint", uid, minimap, worldmap)
			end)
			hooksecurefunc(TomTom, "ShowWaypoint", function(self, uid)
				--dprint("ShowWaypoint", uid)
			end)
		end)
	end

	SkuNav:SkuNavMMOpen()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_ENTERING_WORLD(...)
	dprint("PLAYER_ENTERING_WORLD", ...)
	SkuNav:UpdateStandardWpReachedRange()

	C_Timer.NewTimer(15, function() SkuDrawFlag = true end)
	--C_Timer.NewTimer(15, function() SkuCacheFlag = true end)
	SkuCacheFlag = true

	
	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = false
	SkuOptions.db.profile[MODULE_NAME].routeRecording = false

	--this is to update pre 21.8 profiles, where standardWpReachedRange was a boolean
	if type(SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange) == "boolean" then
		SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = 3
	end

	--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
	SkuNav:SelectWP("", true)

	SkuNav:ClearWaypointsTemporary(true)

	
	if not SkuOptions.db.profile["SkuNav"].RtAndWpVersion or SkuOptions.db.profile["SkuNav"].RtAndWpVersion < 22 then
		SkuOptions.db.profile[MODULE_NAME].Routes = nil
		SkuOptions.db.profile[MODULE_NAME].Waypoints = {}
		SkuOptions.Voice:OutputString("Achtung", true, true, 0.2)
		SkuOptions.Voice:OutputString("Erste Verwendung von Profil ab Sku 22", false, true, 0.2)
		SkuOptions.Voice:OutputString("Alle vorhandenen Routen und Wegpunkte wurden gelöscht", false, true, 0.2)
		--if SkuOptions.db.profile[MODULE_NAME].Routes then
			--SkuNav:CacheNbWps()
		--else
		local tVersion = GetAddOnMetadata("Sku", "Version") 
		if tVersion then tVersion = tonumber(tVersion) end
		SkuOptions.db.profile["SkuNav"].RtAndWpVersion = tVersion
		--end
	end

	SkuNav:CreateWaypointCache()

	if _G["SkuNavMMMainFrameZoneSelect"] then
		C_Timer.NewTimer(1, function()
			_G["SkuNavMMMainFrameZoneSelect"].value = SkuNav:GetCurrentAreaId()
			_G["SkuNavMMMainFrameZoneSelect"]:SetText(SkuDB.InternalAreaTable[SkuNav:GetCurrentAreaId()].AreaName_lang)	
		end)
	end
end

local old_ZONE_CHANGED_X = ""
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ZONE_CHANGED_NEW_AREA(...)
	if old_ZONE_CHANGED_X ~= GetMinimapZoneText() then
		old_ZONE_CHANGED_X = GetMinimapZoneText()
		if SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames == true then
			SkuOptions.Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ZONE_CHANGED(...)
	if old_ZONE_CHANGED_X ~= GetMinimapZoneText() then
		old_ZONE_CHANGED_X = GetMinimapZoneText()
		if SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames == true then
			SkuOptions.Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ZONE_CHANGED_INDOORS(...)
	if old_ZONE_CHANGED_X ~= GetMinimapZoneText() then
		old_ZONE_CHANGED_X = GetMinimapZoneText()
		if SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames == true then
			SkuOptions.Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_DEAD(...)
	--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
	SkuNav:SelectWP("", true)
end

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
function SkuNav:RenameWaypoint(aOldName, aNewName) 
	--new name exists
	if WaypointCacheLookupAll[aName] then
		return false
	end
		
	local tOldWpData = SkuNav:GetWaypointData2(aOldName)
	--unk old wp
	if not tOldWpData then
		return false
	end
	--old not custom
	if tOldWpData.typeId ~= 1 then
		return false
	end

	--remove old from cache
	local tOldWpIndex = WaypointCacheLookupAll[aOldName]
	WaypointCache[tOldWpIndex] = nil
	WaypointCacheLookupAll[aOldName] = nil
	WaypointCacheLookupPerContintent[tOldWpData.contintentId][tOldWpIndex] = nil
	--and from option links
	SkuOptions.db.profile[MODULE_NAME].Links[aOldName] = nil

	--add new to cache
	local tNewWpData = tOldWpData
	local tNewWpIndex = #WaypointCache + 1
	tNewWpData.name = aNewName
	WaypointCache[tNewWpIndex] = tNewWpData
	WaypointCacheLookupAll[aNewName] = tNewWpIndex
	WaypointCacheLookupPerContintent[tNewWpData.contintentId][tNewWpIndex] = aNewName
	--and to options links
	SkuOptions.db.profile[MODULE_NAME].Links[aNewName] = {}
	for name, distance in pairs(tNewWpData.links.byName) do
		SkuOptions.db.profile[MODULE_NAME].Links[aNewName][name] = distance
	end

	--update links in linked wps in cache
	if tNewWpData.links.byId then
		for index, distance in pairs(tNewWpData.links.byId) do
			WaypointCache[index].links.byId[tOldWpIndex] = nil
			WaypointCache[index].links.byId[tNewWpIndex] = distance
			--and in options links
			SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[index].name][aOldName] = nil
			SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[index].name][aNewName] = distance
		end
		for name, distance in pairs(tNewWpData.links.byName) do
			WaypointCache[WaypointCacheLookupAll[name]].links.byName[aOldName] = nil
			WaypointCache[WaypointCacheLookupAll[name]].links.byName[aNewName] = distance
		end
	end

	--update wp in options
	local tWpData
	for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
		if v == aOldName then
			tWpData = SkuOptions.db.profile[MODULE_NAME].Waypoints[v]
			SkuOptions.db.profile[MODULE_NAME].Waypoints[SkuOptions.db.profile[MODULE_NAME].Waypoints[v]] = nil
			SkuOptions.db.profile[MODULE_NAME].Waypoints[v] = nil
			table.remove(SkuOptions.db.profile[MODULE_NAME].Waypoints, i)
			break
		end
	end
	if not SkuOptions.db.profile[MODULE_NAME].Waypoints[aNewName] then
		table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, aNewName)
	end
	SkuOptions.db.profile[MODULE_NAME].Waypoints[aNewName] = tWpData

	return true
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CreateWaypoint(aName, aX, aY, aSize, aForcename)
	--dprint("CreateWaypoint", aName, aX, aY, aSize)
	aSize = aSize or 1
	local tPName = UnitName("player")

	if aName == nil then
		-- this generates (almost) unique auto wp numbers, to avoid duplicates and renaming on import/export of WPs and Rts later on
		-- numbers > 1000000 are not vocalized by SkuVoice; thus they are silent, even if they are part of the auto WP names
		local tNumber = tostring(GetServerTime()..GetTimePreciseSec())
		local tAutoIndex = tNumber:gsub("%.", "")
		if SkuNav:GetWaypointData2(L["auto"]..";"..tAutoIndex) ~= nil then
			while SkuNav:GetWaypointData2(L["auto"]..";"..tAutoIndex)  ~= nil do
				tAutoIndex = tAutoIndex + 1
			end
		end
		aName = L["auto"]..";"..tAutoIndex
		tPName = "SkuNav"
	end

	local tAreaId = SkuNav:GetCurrentAreaId()
	local tZoneName, tAreaName_lang, tContinentID, tParentAreaID, tFaction, tFlags = SkuNav:GetAreaData(tAreaId)

	--add number if name already exists
	if tZoneName then
		if SkuNav:GetWaypointData2(aName) and not aForcename then
			local q = 1
			while SkuNav:GetWaypointData2(aName..q) do
				q = q + 1
			end
			aName = aName..q
		end

		local worldx, worldy = UnitPosition("player")
		if aX and aY then
			worldx, worldy = aX, aY
		end
		local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))

		SkuNav:SetWaypoint(aName,  {
			["contintentId"] = tPlayerContintentId,
			["areaId"] = tAreaId,
			["worldX"] = worldx,
			["worldY"] = worldy,
			["createdAt"] = GetTime(),
			["createdBy"] = tPName,
			["size"] = aSize,
		})
	else
		aName = nil
	end

	return aName
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aName string
---@param aData table contintentId, areaId, worldX, worldY, createdAt, createdBy
function SkuNav:SetWaypoint(aName, aData)
	--dprint("SkuNav:SetWaypoint", aName)
	--if aData then setmetatable(aData, SkuPrintMTWo) dprint(aData) end

	local tWpIndex = #WaypointCache + 1

	if WaypointCacheLookupAll[aName] then
		if WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[aName]].contintentId] then
			WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[aName]].contintentId][WaypointCacheLookupAll[aName]] = nil
		end
		tWpIndex = WaypointCacheLookupAll[aName]
	else
		WaypointCache[tWpIndex] = {
			name = aName,
			typeId = 1,
		}
	end
	
	if (not aData.contintentId and not WaypointCache[tWpIndex].contintentId) == true or (not aData.contintentId and not WaypointCache[tWpIndex].contintentId) == true then
		print("ERROR - THIS SHOULD NOT HAPPEN:")
		print("SetWaypoint", aData)
		print("no areaid, nocontinentid")
		return
	end

	WaypointCache[tWpIndex].name = aName
	WaypointCache[tWpIndex].role = aData.role or WaypointCache[tWpIndex].role or ""
	WaypointCache[tWpIndex].typeId = 1
	WaypointCache[tWpIndex].dbIndex = nil
	WaypointCache[tWpIndex].contintentId = aData.contintentId or WaypointCache[tWpIndex].contintentId
	WaypointCache[tWpIndex].areaId = aData.areaId or WaypointCache[tWpIndex].areaId
	WaypointCache[tWpIndex].uiMapId = SkuNav:GetUiMapIdFromAreaId(aData.areaId) or WaypointCache[tWpIndex].uiMapId
	WaypointCache[tWpIndex].worldX = aData.worldX or WaypointCache[tWpIndex].worldX
	WaypointCache[tWpIndex].worldY = aData.worldY or WaypointCache[tWpIndex].worldY
	WaypointCache[tWpIndex].createdAt = aData.createdAt or WaypointCache[tWpIndex].createdAt or 0
	WaypointCache[tWpIndex].createdBy = aData.createdBy or WaypointCache[tWpIndex].createdBy or "SkuNav"
	WaypointCache[tWpIndex].size = aData.size or WaypointCache[tWpIndex].size or 1
	WaypointCache[tWpIndex].comments = aData.comments or WaypointCache[tWpIndex].comments or nil
	WaypointCache[tWpIndex].links = aData.links or WaypointCache[tWpIndex].links or {byId = nil, byName = nil,}

	WaypointCacheLookupAll[aName] = tWpIndex
	if not WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId] then
		WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId] = {}
	end
	WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId][tWpIndex] = aName
	
	if WaypointCache[tWpIndex].typeId == 1 then
		if not SkuOptions.db.profile[MODULE_NAME].Waypoints[aName] then
			table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, aName)
		end
		SkuOptions.db.profile[MODULE_NAME].Waypoints[aName] = {
			["contintentId"] = WaypointCache[tWpIndex].contintentId,
			["areaId"] = WaypointCache[tWpIndex].areaId,
			["worldX"] = WaypointCache[tWpIndex].worldX,
			["worldY"] = WaypointCache[tWpIndex].worldY,
			["createdAt"] = WaypointCache[tWpIndex].createdAt,
			["createdBy"] = WaypointCache[tWpIndex].createdBy,
			["size"] = WaypointCache[tWpIndex].size,
			["comments"] = WaypointCache[tWpIndex].comments,
		}
	end

	SkuNav:UpdateWpLinks(aName)
end

---------------------------------------------------------------------------------------------------------------------------------------
local GetNpcRolesCache = {}
function SkuNav:GetNpcRoles(aNpcName, aNpcId)
	if not aNpcId then
		for i, v in pairs(SkuDB.NpcData.NamesDE) do
			if v[1] == aNpcName then
				aNpcId = i
				break
			end
		end
	end

	if GetNpcRolesCache[aNpcId] then
		return GetNpcRolesCache[aNpcId]
	end

	local rRoles = {}
	for i, v in pairs(SkuNav.NPCRolesToRecognize) do
		if bit.band(i, SkuDB.NpcData.Data[aNpcId][SkuDB.NpcData.Keys["npcFlags"]]) > 0 then
			--dprint(aNpcName, aNpcId, i, v)
			rRoles[#rRoles+1] = v
		end
	end

	GetNpcRolesCache[aNpcId] = rRoles
	return rRoles
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:ClearWaypointsTemporary(aFull)
	--dprint("ClearWaypointsTemporary")
	if not SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary then
		SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary = {}
	end

	if SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary then
		if #SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary > 0 then
			for x = 1, #SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary do
				if SkuNav:DeleteWaypoint(SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary[x]) ~= true then
					dprint("THIS SHOULD NOT HAPPEN: tmp WP could not be deleted on clear:", SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary[x])
				end
			end
			SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary = {}
		end
	end

	if aFull then
		local tIndex = 1
		while SkuNav:GetWaypointData2("Einheiten;Route;"..tIndex) do
			if SkuNav:DeleteWaypoint("Einheiten;Route;"..tIndex) ~= true then
				dprint("THIS SHOULD NOT HAPPEN: tmp WP could not be deleted on clear:", "Einheiten;Route;"..tIndex)
			end
			tIndex = tIndex + 1
		end
		SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary = {}
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteWaypoint(aWpName)
	local tWpData = SkuNav:GetWaypointData2(aWpName)

	if not tWpData then
		return false
	end

	if tWpData.typeId ~= 1 then
		print(L["Only custom waypoints can be deleted"])
		return false
	end

	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
		if v == aWpName then
			local tCacheIndex = WaypointCacheLookupAll[aWpName] 

			--remove links in linked wps in cache
			if tWpData.links.byId then
				for index, distance in pairs(tWpData.links.byId) do
					WaypointCache[index].links.byId[tCacheIndex] = nil
					WaypointCache[index].links.byName[aWpName] = nil
					--and in options links
					SkuOptions.db.profile[MODULE_NAME].Links[WaypointCache[index].name][aWpName] = nil
				end
			end
			if tWpData.links.byName then
				for name, distance in pairs(tWpData.links.byName) do
					WaypointCache[WaypointCacheLookupAll[name]].links.byId[tCacheIndex] = nil
					WaypointCache[WaypointCacheLookupAll[name]].links.byName[aWpName] = nil
					SkuOptions.db.profile[MODULE_NAME].Links[name][aWpName] = nil
				end
			end

			WaypointCacheLookupPerContintent[tWpData.contintentId][tCacheIndex] = nil
			WaypointCacheLookupAll[aWpName] = nil
			WaypointCache[tCacheIndex] = nil

			table.remove(SkuOptions.db.profile[MODULE_NAME].Waypoints, i)
			SkuOptions.db.profile[MODULE_NAME].Waypoints[v] = nil
			
			SkuNav:SaveLinkDataToProfile()

			return true
		end
	end

	return false
end









------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--temp helper to remove unintended wp dupes
------------------------------------------------------------------------------------------------------------------------
function SkuNav:CleanupWaypoints(aJustReportFlag)
	for i, v in pairs(WaypointCache) do
		if v.typeId == 1 then
			local tWpToTestName = v.name
			local tWpToTestLast2 = string.sub(tWpToTestName, string.len(tWpToTestName) - 1)
			local tWpToTestUpToLast2 = string.sub(tWpToTestName, 1, string.len(tWpToTestName) - 2)
			if tWpToTestLast2 == ";1" or tWpToTestLast2 == ";2" or tWpToTestLast2 == ";3" then
				if WaypointCacheLookupAll[tWpToTestUpToLast2] then
					local tWpToTestData = v
					local tWpToTesUpToLast2Data = WaypointCache[WaypointCacheLookupAll[tWpToTestUpToLast2]]

					if tWpToTestData.worldX == tWpToTesUpToLast2Data.worldX and
						tWpToTestData.worldY == tWpToTesUpToLast2Data.worldY and
						tWpToTestData.areaId == tWpToTesUpToLast2Data.areaId and
						tWpToTestData.contintentId == tWpToTesUpToLast2Data.contintentId and
						tWpToTestData.comments == tWpToTesUpToLast2Data.comments
					then
						if not aJustReportFlag then
							dprint("Wp-Doublette gelöscht:", tWpToTestName, SkuNav:DeleteWaypoint(tWpToTestName))
						else
							dprint("Wp-Doublette löschen:", tWpToTestName)
						end
					end
				end
			end
		end
	end
	--SkuNav:SaveLinkDataToProfile()

end
------------------------------------------------------------------------------------------------------------------------
--everything below is just to convert pre-22 data to new format
------------------------------------------------------------------------------------------------------------------------
local tCacheNbWpsTimerCounter = 0
local tCacheNbWpsTimerCounterProgress = 0
local tCacheNbWpsTimerCounterProgressShow = true
local tCacheNbWpsTimerRate = 2
local tCacheNbWpsTimer = nil
local SkuNeighbCache = {}
local tFoundThisRound = false
------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateWaypointCacheLinks(aChangedWpNames)
	for tNameSource, tData in pairs(SkuNeighbCache) do
		for tIndex, tNameTarget in pairs(tData) do
			local tSourceWpId = WaypointCacheLookupAll[tNameSource]
			local tTargetWpId = WaypointCacheLookupAll[tNameTarget]
			local tSourceWpData = WaypointCache[tSourceWpId]
			local tTargetWpData = WaypointCache[tTargetWpId]

			if not tSourceWpData or not tTargetWpData then
				dprint("MISSING", tSourceWpData, tTargetWpData)
			else
				local tDistance = SkuNav:Distance(WaypointCache[tSourceWpId].worldX, WaypointCache[tSourceWpId].worldY, WaypointCache[tTargetWpId].worldX, WaypointCache[tTargetWpId].worldY)
				if not WaypointCache[tSourceWpId].links.byId then
					WaypointCache[tSourceWpId].links.byId ={}
				end
				WaypointCache[tSourceWpId].links.byId[tTargetWpId] = tDistance
				if not WaypointCache[tSourceWpId].links.byName then
					WaypointCache[tSourceWpId].links.byName ={}
				end
				WaypointCache[tSourceWpId].links.byName[tNameTarget] = tDistance

				if not WaypointCache[tTargetWpId].links.byId then
					WaypointCache[tTargetWpId].links.byId ={}
				end
				WaypointCache[tTargetWpId].links.byId[tSourceWpId] = tDistance
				if not WaypointCache[tTargetWpId].links.byName then
					WaypointCache[tTargetWpId].links.byName ={}
				end
				WaypointCache[tTargetWpId].links.byName[tNameSource] = tDistance
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CacheNbWps(aRate, aListOfRouteNamesToReCache, aListOfWpNamesToReCache)
	tCacheNbWpsTimerRate = 20--aRate or 10
	dprint("CacheNbWps")

	local tCacheNbWpsTimerWpList = {}
	if tCacheNbWpsTimerCounterProgressShow == true then
		--dprint("SkuNav: WPs and RTs cache req")
		SkuOptions.Voice:OutputString("Routen Umwandlung auf neue Version gestartet", false, true, 0.3, true)
		print("Routen Umwandlung auf neue Version gestartet")

	end
	for i, tRouteName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName] then
			if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs then
				for x, tWpName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs) do
					tCacheNbWpsTimerWpList[#tCacheNbWpsTimerWpList + 1] = tWpName
				end
			end
		end
	end
	if tCacheNbWpsTimerCounterProgressShow == true then
		dprint("SkuNav: "..#tCacheNbWpsTimerWpList.." WPs to cache")
	end

	if #tCacheNbWpsTimerWpList > 0 then
		if tCacheNbWpsTimer then
			tCacheNbWpsTimer:Cancel()
			tCacheNbWpsTimer = nil
			if tCacheNbWpsTimerCounterProgressShow == true then
				dprint("SkuNav: Caching restarted...")
			end
		else
			if tCacheNbWpsTimerCounterProgressShow == true then
				dprint("SkuNav: Caching started...")
				tFoundThisRound = false
			end
		end

		tCacheNbWpsTimerCounter = 0
		tCacheNbWpsTimerCounterProgress = 0
		tCacheNbWpsTimer = C_Timer.NewTicker(0, function()
			local tOldFps = 0
			local tFps = 0
			--print("new ticker", tCacheNbWpsTimer)
			local tFoundCount = 0
			for x = 1, tCacheNbWpsTimerRate do
				tCacheNbWpsTimerCounter = tCacheNbWpsTimerCounter + 1
				if tCacheNbWpsTimerCounter >= #tCacheNbWpsTimerWpList == true then
					if tCacheNbWpsTimer then
						tCacheNbWpsTimer:Cancel()
						tCacheNbWpsTimer = nil
						if tCacheNbWpsTimerCounterProgressShow == true then
							--dprint("SkuNav: Caching completed")
							--if tFoundThisRound == true then
								--SkuOptions.Voice:OutputString("Routen Konvertierung abgeschlossen", false, true, 0.3, true)
							--end
							tFoundThisRound = false

							SkuOptions.Voice:OutputString("Routen Umwandlung abgeschlossen", false, true, 0.3, true)
							print("Routen Umwandlung abgeschlossen")
							SkuNav:UpdateWaypointCacheLinks()
							SkuNav:SaveLinkDataToProfile()
							SkuOptions.db.profile[MODULE_NAME].Routes = nil
							SkuOptions.db.profile["SkuNav"].RtAndWpVersion = 22
						end
					end
				end
				if tCacheNbWpsTimerWpList[tCacheNbWpsTimerCounter] then
					local tWaste, tFound = GetNeighbToWp(tCacheNbWpsTimerWpList[tCacheNbWpsTimerCounter], true)
					if tFound == true then
						tFoundThisRound = tFound
						tFoundCount = tFoundCount + 1
					end
				end
			end
			if tCacheNbWpsTimerCounterProgressShow == true then
				if math.floor(tCacheNbWpsTimerCounterProgress / 1000) ~= math.floor(tCacheNbWpsTimerCounter / 1000) then
					tCacheNbWpsTimerCounterProgress = tCacheNbWpsTimerCounter
					SkuOptions.Voice:OutputString("Routen Umwandlung "..math.floor(tCacheNbWpsTimerCounterProgress / 1000).."/"..math.floor(#tCacheNbWpsTimerWpList / 1000), false, true, 0.3, true)
					print("Routen Umwandlung "..math.floor(tCacheNbWpsTimerCounterProgress / 1000).."/"..math.floor(#tCacheNbWpsTimerWpList / 1000))
					--dprint("SkuNav: Caching progress "..math.floor(tCacheNbWpsTimerCounterProgress / 1000).."/"..math.floor(#tCacheNbWpsTimerWpList / 1000))
				end
			end
			if tFoundCount > 0 then
				tFps = GetFramerate()
				if tFps < 10 then
					tCacheNbWpsTimerRate = tCacheNbWpsTimerRate - 0.01
					if tCacheNbWpsTimerRate < 1 then
						tCacheNbWpsTimerRate = 1
					end
				elseif tFps > 10 then
					tCacheNbWpsTimerRate = tCacheNbWpsTimerRate + 0.01
				end
				tOldFps = tFps
			end
		end)
	else
		SkuOptions.Voice:OutputString("Routen Umwandlung abgeschlossen", false, true, 0.3, true)
		SkuOptions.db.profile[MODULE_NAME].Routes = nil
		SkuOptions.db.profile["SkuNav"].RtAndWpVersion = 22		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function GetNeighbToWp(aWpName, aTicker)
	if not aTicker then
		if tCacheNbWpsTimer then
			if tCacheNbWpsTimerCounterProgressShow == true then
				dprint("SkuNav: Caching stopped")
			end
			tCacheNbWpsTimer:Cancel()
			tCacheNbWpsTimer = nil
		end
	end

	if SkuNeighbCache[aWpName] then
		return SkuNeighbCache[aWpName]
	end
	--local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	--local tUIMap = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())

	local tFoundNeighb = {}
	if not SkuOptions.db.profile[MODULE_NAME].Routes then
		return
	end
	for _, tRouteName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
			for x, tWpName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs) do
				if aWpName == tWpName then
					if x > 1 then
						tFoundNeighb[#tFoundNeighb+1] = SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[x-1]
					end
					if x < #SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs then
						tFoundNeighb[#tFoundNeighb+1] = SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs[x+1]
					end
				end
			end
	end
	SkuNeighbCache[aWpName] = tFoundNeighb

	return tFoundNeighb, true
end

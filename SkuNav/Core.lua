---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local _G = _G
local L = Sku.L

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")

local lastDirection = -1
local lastDistance = 0
SkuDrawFlag = false

local slower = string.lower
local sfind = string.find
local ssplit = string.split
local ssub = string.sub
local tinsert = table.insert

SkuNav.BeaconSoundSetNames  = {}

SkuMetapathFollowingMetapathsTMP = {}

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
SkuNav.MaxMetaEntryRange = 300
SkuNav.BestRouteWeightedLengthModForMetaDistance = 37 -- this is a modifier for close routes

local WaypointCache = {}
local WaypointCacheLookupAll = {}
local WaypointCacheLookupIdForCacheIndex = {}
local WaypointCacheLookupCacheNameForId = {}

local WaypointCacheLookupPerContintent = {}
function SkuNav:CreateWaypointCache(aAddLocalizedNames)
	--print("CreateWaypointCache")
	
	local C_MapGetWorldPosFromMapPos = C_Map.GetWorldPosFromMapPos
	WaypointCache = {}
	WaypointCacheLookupAll = {}
	WaypointCacheLookupIdForCacheIndex = {}
	WaypointCacheLookupCacheNameForId = {}
	WaypointCacheLookupPerContintent = {}
	for i, v in pairs(SkuDB.ContinentIds) do
		WaypointCacheLookupPerContintent[i] = {}
	end

	--add creatures
	for i, v in pairs(SkuDB.NpcData.Names[Sku.Loc]) do		
		if SkuDB.NpcData.Data[i] then
			local tRoles
			local tName
			local tSubname
			if SkuDB.NpcData.Names[Sku.Loc][i] then
				tName = SkuDB.NpcData.Names[Sku.Loc][i][1]
				tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
				tRoles = SkuNav:GetNpcRoles(v[1], i)
			else
				tName = SkuDB.NpcData.Data[i][1]
				tSubname = SkuDB.NpcData.Data[i][14]
				tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.Data[i][1], i)
			end			
			local tSpawns = SkuDB.NpcData.Data[i][7]
			if tSpawns then
				if not sfind(slower(tName), "trigger") then
					for is, vs in pairs(tSpawns) do
						local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
						--we don't care for stuff that isn't in the open world
						if isUiMap then
							local tData = SkuDB.InternalAreaTable[is]
							if tData then
								local tNumberOfSpawns = #vs
								--local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
								local tRolesString = ""
								if not tSubname then
									--local tRoles = SkuNav:GetNpcRoles(v[1], i)
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
									local _, worldPosition = C_MapGetWorldPosFromMapPos(isUiMap, CreateVector2D(vs[sp][1] / 100, vs[sp][2] / 100))
									if worldPosition then
										local tWorldX, tWorldY = worldPosition:GetXY()
										local tNewIndex = #WaypointCache + 1
										local tFinalName = tName..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
										local tWpId = SkuNav:BuildWpIdFromData(2, i, sp, is)
										if not WaypointCacheLookupPerContintent[tData.ContinentID] then
											WaypointCacheLookupPerContintent[tData.ContinentID] = {}
										end
										WaypointCacheLookupPerContintent[tData.ContinentID][tNewIndex] = tFinalName
										WaypointCacheLookupAll[tFinalName] = tNewIndex
										WaypointCacheLookupIdForCacheIndex[tWpId] =  tNewIndex
										WaypointCacheLookupCacheNameForId[tFinalName] = tWpId
										WaypointCache[tNewIndex] = {
											name = tFinalName,
											role = tRolesString,
											typeId = 2,
											dbIndex = i,
											spawn = sp,
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
	end


	C_Timer.After(1, function() --this is to avoid script timeouts as the full cache building could take to long
		--add objects
		for i, v in pairs(SkuDB.objectLookup[Sku.Loc]) do
			--we don't want stuff like ores, herbs, etc. as default
			if not SkuDB.objectResourceNames[Sku.Loc][v] or SkuOptions.db.profile[MODULE_NAME].showGatherWaypoints == true then
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
										if worldPosition then
											local tWorldX, tWorldY = worldPosition:GetXY()
			
											local tNewIndex = #WaypointCache + 1

											local tRessourceType = ""
											if SkuDB.objectResourceNames[Sku.Loc][v] == 1 then
												tRessourceType = ";"..L["herbalism"]
											elseif SkuDB.objectResourceNames[Sku.Loc][v] == 2 then
												tRessourceType = ";"..L["mining"]
											end

											local tFinalName = L["OBJECT"]..";"..i..";"..v..tRessourceType..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
											local tWpId = SkuNav:BuildWpIdFromData(3, i, sp, is)
											if not WaypointCacheLookupPerContintent[tData.ContinentID] then
												WaypointCacheLookupPerContintent[tData.ContinentID] = {}
											end
											WaypointCacheLookupPerContintent[tData.ContinentID][tNewIndex] = tFinalName
											WaypointCacheLookupAll[tFinalName] = tNewIndex
											WaypointCacheLookupIdForCacheIndex[tWpId] =  tNewIndex
											WaypointCacheLookupCacheNameForId[tFinalName] = tWpId										
											WaypointCache[tNewIndex] = {
												name = tFinalName,
												role = "",
												typeId = 3,
												dbIndex = i,
												spawn = sp,
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
		end

		C_Timer.After(1, function() --this is to avoid script timeouts
			--add custom
			if SkuOptions.db.global[MODULE_NAME].Waypoints then
				for tIndex, tData in ipairs(SkuOptions.db.global[MODULE_NAME].Waypoints) do
					--check if that wp was deleted
					if tData[1] ~= false then
						local tName = tData.names[Sku.Loc]

						local tWaypointData = tData
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
									dbIndex = tIndex,
									spawn = 1,
									contintentId = tWaypointData.contintentId,
									areaId = tWaypointData.areaId,
									uiMapId = isUiMap,
									worldX = tWaypointData.worldX,
									worldY = tWaypointData.worldY,
									createdAt = tWaypointData.createdAt,
									createdBy = tWaypointData.createdBy,
									size = tWaypointData.size or 1,
									comments = tWaypointData.lComments or {["deDE"] = {},["enUS"] = {},},
									spawnNr = nil,
									links = tOldLinks,
								}

								WaypointCacheLookupAll[tName] = tWpIndex
								local tWpId = SkuNav:BuildWpIdFromData(1, tIndex, 1, tWaypointData.areaId)
								WaypointCacheLookupIdForCacheIndex[tWpId] =  tWpIndex
								WaypointCacheLookupCacheNameForId[tName] = tWpId										
		
								if not WaypointCacheLookupPerContintent[tWaypointData.contintentId] then
									WaypointCacheLookupPerContintent[tWaypointData.contintentId] = {}
								end
								WaypointCacheLookupPerContintent[tWaypointData.contintentId][tWpIndex] = tName
							end
						end
					else
						dprint("tried caching deleted custom wp", tIndex, tData)
					end
				end
			end

			SkuNav:LoadLinkDataFromProfile()
		end)
	end)
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:LoadLinkDataFromProfile()
	if SkuOptions.db.global[MODULE_NAME].Links then
		SkuNav:CheckAndUpdateProfileLinkData()
		for tSourceWpID, tSourceWpLinks in pairs(SkuOptions.db.global[MODULE_NAME].Links) do
			if not WaypointCacheLookupIdForCacheIndex[tSourceWpID] then
				dprint("this shouldn't happen NO WaypointCacheLookupIdForCacheIndex[tSourceWpID]", tSourceWpID, tSourceWpLinks)
			end
			local tSourceWpName = WaypointCache[WaypointCacheLookupIdForCacheIndex[tSourceWpID]].name
			WaypointCacheLookupCacheNameForId[tSourceWpName] = tSourceWpID

			if WaypointCacheLookupAll[tSourceWpName] then
				WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byName = {}
				WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byId = {}
				for tTargetWpID, tTargetWpDistance in pairs(tSourceWpLinks) do
					local tTargetWpName = WaypointCache[WaypointCacheLookupIdForCacheIndex[tTargetWpID]].name
					WaypointCacheLookupCacheNameForId[tTargetWpName] = tTargetWpID
					if WaypointCacheLookupAll[tTargetWpName] then
						WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byName[tTargetWpName] = tTargetWpDistance
						WaypointCache[WaypointCacheLookupAll[tSourceWpName]].links.byId[WaypointCacheLookupAll[tTargetWpName]] = tTargetWpDistance
					end
				end
			end
		end
	end
	SkuNav:SaveLinkDataToProfile()
	SkuNav:CleanupWaypoints()
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:CleanupWaypoints()
	for i, v in pairs(WaypointCache) do
		if v.typeId == 1 then
			local tHasLinks = false
			if WaypointCache[i].links.byId ~= nil then
				for id, dist in pairs(WaypointCache[i].links.byId) do
					tHasLinks = true
					break
				end
			end
			if tHasLinks ~= true and not string.find(v.name, L["Quick waypoint"]) then
				--print("disconnected custom wp:", v.name)
				WaypointCacheLookupAll[v.name] = nil
				WaypointCacheLookupCacheNameForId[v.name] = nil
				local tWpId = SkuNav:BuildWpIdFromData(1, v.dbIndex, 1, v.areaId)
				WaypointCacheLookupIdForCacheIndex[tWpId] = nil
				WaypointCacheLookupPerContintent[v.contintentId][i] = nil
				WaypointCache[i] = nil
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:CheckAndUpdateProfileLinkData()
	local tDeletedCounter = 0

	if SkuOptions.db.global[MODULE_NAME].Links then
		for tSourceWpID, tSourceWpLinks in pairs(SkuOptions.db.global[MODULE_NAME].Links) do
			if not WaypointCacheLookupIdForCacheIndex[tSourceWpID] then
				local typeId, dbIndex, spawn, areaId = SkuNav:GetWpDataFromId(tSourceWpID)
				dprint("this shouldn't happen UPDATED source deleted, not in db", tSourceWpID, typeId, dbIndex, spawn, areaId)
				SkuOptions.db.global[MODULE_NAME].Links[tSourceWpID] = nil
				tDeletedCounter = tDeletedCounter + 1
			else
				local tSourceWpName = WaypointCache[WaypointCacheLookupIdForCacheIndex[tSourceWpID]].name
				if SkuNav:GetWaypointData2(tSourceWpName) then
					for tTargetWpID, tTargetWpDistance in pairs(tSourceWpLinks) do
						if not WaypointCacheLookupIdForCacheIndex[tTargetWpID] then
							dprint("this shouldn't happen UPDATED Target deleted, not in db", tSourceWpID, tSourceWpLinks, tSourceWpName, "-", tTargetWpID, tTargetWpDistance, WaypointCacheLookupIdForCacheIndex[tTargetWpID])
							SkuOptions.db.global[MODULE_NAME].Links[tSourceWpID][tTargetWpID] = nil
							tDeletedCounter = tDeletedCounter + 1
						else
							local tTargetWpName = WaypointCache[WaypointCacheLookupIdForCacheIndex[tTargetWpID]].name					
							if tSourceWpName == tTargetWpName then
								SkuOptions.db.global[MODULE_NAME].Links[tSourceWpID][tTargetWpID] = nil
								--print("+++UPDATED deleted", tTargetWpName, "from", tSourceWpName, "because source was linked with self")
							else
								if SkuNav:GetWaypointData2(tTargetWpName) then
									SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID] = SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID] or {}
									if not SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID][tSourceWpID] then
										--print("+++UPDATED added", tSourceWpName, "to", tTargetWpName)
										SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID][tSourceWpID] = tTargetWpDistance
									end
								else
									--print("+++UPDATED deleted", tTargetWpName, "from", tSourceWpName, "because target does not exist")
									SkuOptions.db.global[MODULE_NAME].Links[tSourceWpID][tTargetWpID] = nil
									--print("  +++UPDATED deleted", tTargetWpName, "because target does not exist")
									SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID] = nil
								end
							end
						end
					end
				else
					for tTargetWpID, tTargetWpDistance in pairs(tSourceWpLinks) do
						local tTargetWpName = WaypointCache[WaypointCacheLookupIdForCacheIndex[tTargetWpID]].name										
						SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID] = SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID] or {}
						if not SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID][tSourceWpID] then
							--print("+++UPDATED deleted", tSourceWpName, "from", tTargetWpName, "because source does not exist")
							SkuOptions.db.global[MODULE_NAME].Links[tTargetWpID][tSourceWpID] = nil
						end
					end
					--print("  +++UPDATED delted", tSourceWpName, "because source does not exist")
					SkuOptions.db.global[MODULE_NAME].Links[tSourceWpID] = nil
				end
			end
		end
	end

	--print("tDeletedCounter", tDeletedCounter)
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:SaveLinkDataToProfile(aWpName)
	if aWpName then
		--SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[aWpName]] = WaypointCache[WaypointCacheLookupAll[aWpName]].links.byName
		SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[aWpName]] = {}
		for twname, twdist in pairs(WaypointCache[WaypointCacheLookupAll[aWpName]].links.byName) do
			SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[aWpName]][WaypointCacheLookupCacheNameForId[twname]] = twdist
		end		
		
	else
		SkuOptions.db.profile[MODULE_NAME].Links = nil
		SkuOptions.db.global[MODULE_NAME].Links = {}
		for tSourceWpIndex, tSourceWpData in pairs(WaypointCache) do
			if tSourceWpData.links then
				if tSourceWpData.links.byId then
					SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[tSourceWpData.name]] = {}
					for twname, twdist in pairs(tSourceWpData.links.byName) do
						SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[tSourceWpData.name]][WaypointCacheLookupCacheNameForId[twname]] = twdist
					end
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
	if sfind(aWpName, "#") then
		return ssub(aWpName, sfind(aWpName, "#") + 1)
	end
	return aWpName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAllMetaTargetsFromWp4(aStartWpName, aMaxDistance, aMaxWPs, aReturnPathForWp, aIncludeAutoWps)
	dprint("SkuNav:GetAllMetaTargetsFromWp4", aStartWpName, aMaxDistance, aMaxWPs, aReturnPathForWp, aIncludeAutoWps)
	--local beginTime = debugprofilestop()

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

	--dprint("filled", debugprofilestop() - beginTime)
	--beginTime = debugprofilestop()

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
			if tAuto == "" or ssub(tName, 1, 4) ~= tAuto then
				--if aStartWpName ~= tName then
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
											tinsert(rMetapathData[tName].pathWps, 1, WaypointCache[tCurrentFrom].name)
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
							tinsert(rMetapathData[tName].pathWps, 1, WaypointCache[tCurrentFrom].name)
							tinsert(rMetapathData[tName].pathWps, 1, aStartWpName)
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
				--end
			end
		end
	end

	--dprint("End", debugprofilestop() - beginTime)
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
							tinsert(tFoundWpList, x, {wpIndex = tWpIndex, wpName = tWpName, distance = tDistance})
							break
						end
					end
				else
					tinsert(tFoundWpList, {wpIndex = tWpIndex, wpName = tWpName, distance = tDistance})
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
				if not string.find(tName, "%[DND%]") and not string.find(tName, "%(DND%)") then
					tWpList[#tWpList + 1] = tName
				end
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
	
	local tWpAId = WaypointCacheLookupCacheNameForId[aWpAName]
	local tWpBId = WaypointCacheLookupCacheNameForId[aWpBName]

	SkuOptions.db.global[MODULE_NAME].Links[tWpAId][tWpBId] = nil
	SkuOptions.db.global[MODULE_NAME].Links[tWpBId][tWpAId] = nil


	--WaypointCacheLookupAll[aWpName]].links.byName
	SkuNav:SaveLinkDataToProfile(aWpAName)
	SkuNav:SaveLinkDataToProfile(aWpBName)

	SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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


		local tWpAId = WaypointCacheLookupCacheNameForId[aWpAName]
		local tWpBId = WaypointCacheLookupCacheNameForId[aWpBName]

		SkuOptions.db.global[MODULE_NAME].Links[tWpAId] = SkuOptions.db.global[MODULE_NAME].Links[tWpAId] or {}
		SkuOptions.db.global[MODULE_NAME].Links[tWpAId][tWpBId] = tDistance
		SkuOptions.db.global[MODULE_NAME].Links[tWpBId] = SkuOptions.db.global[MODULE_NAME].Links[tWpBId] or {}
		SkuOptions.db.global[MODULE_NAME].Links[tWpBId][tWpAId] = tDistance

		SkuOptions.db.global["SkuNav"].hasCustomMapData = true

		SkuNav:SaveLinkDataToProfile(aWpAName)
		SkuNav:SaveLinkDataToProfile(aWpBName)
			
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateWpLinks(aWpAName)
	local tWpAIndex = WaypointCacheLookupAll[aWpAName]
	local tWpAData = SkuNav:GetWaypointData2(nil, tWpAIndex)

	if tWpAData.isTempWaypoint == true then
		return
	end

	if not WaypointCache[tWpAIndex].links.byId then
		return
	end

	for tWpBIndex, _ in pairs(tWpAData.links.byId) do
		local tDistance = SkuNav:Distance(tWpAData.worldX, tWpAData.worldY, WaypointCache[tWpBIndex].worldX, WaypointCache[tWpBIndex].worldY)
		WaypointCache[tWpAIndex].links.byId[tWpBIndex] = tDistance
		WaypointCache[tWpAIndex].links.byName[WaypointCache[tWpBIndex].name] = tDistance
		WaypointCache[tWpBIndex].links.byId[tWpAIndex] = tDistance
		WaypointCache[tWpBIndex].links.byName[aWpAName] = tDistance

		local tWpAId = WaypointCacheLookupCacheNameForId[aWpAName]
		local tWpBId = WaypointCacheLookupCacheNameForId[aWpBName]

		SkuOptions.db.global[MODULE_NAME].Links[tWpAId] = SkuOptions.db.global[MODULE_NAME].Links[tWpAId] or {}
		SkuOptions.db.global[MODULE_NAME].Links[tWpAId][WaypointCacheLookupCacheNameForId[WaypointCache[tWpBIndex].name]] = tDistance
		SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[WaypointCache[tWpBIndex].name]] = SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[WaypointCache[tWpBIndex].name]] or {}
		SkuOptions.db.global[MODULE_NAME].Links[WaypointCacheLookupCacheNameForId[WaypointCache[tWpBIndex].name]][tWpAId] = tDistance
	end

	SkuOptions.db.global["SkuNav"].hasCustomMapData = true
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuNav.CurrentStandardWpReachedRange = 0
function SkuNav:UpdateStandardWpReachedRange(aDistanceToNextWp)
	dprint("UpdateStandardWpReachedRange", aDistanceToNextWp, SkuOptions.db.profile["SkuNav"].standardWpReachedRange, SkuNav.CurrentStandardWpReachedRange)
	if SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 1 then
		SkuNav.CurrentStandardWpReachedRange = 0
	elseif SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 2 then
		SkuNav.CurrentStandardWpReachedRange = 2
	elseif SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 3 then
		SkuNav.CurrentStandardWpReachedRange = 3
	else
		if not aDistanceToNextWp then 
			if SkuNav.CurrentStandardWpReachedRange ~= 0 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 4 then
				SkuOptions.Voice:OutputString(L["nah"], false, true, 0.3, true)
			end
			SkuNav.CurrentStandardWpReachedRange = 0
			return
		end
		if aDistanceToNextWp <= 9 then
			if SkuNav.CurrentStandardWpReachedRange ~= 0 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 4 then
				SkuOptions.Voice:OutputString(L["nah"], false, true, 0.3, true)
			end
			SkuNav.CurrentStandardWpReachedRange = 0
		elseif aDistanceToNextWp > 14 then
			if SkuNav.CurrentStandardWpReachedRange ~= 3 and SkuOptions.db.profile["SkuNav"].standardWpReachedRange == 4 then
				SkuOptions.Voice:OutputString(L["weit"], false, true, 0.3, true)
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

		--this is because of strange areas where C_Map.GetBestMapForUnit is returning continent IDs
		if tMMZoneText == L["Timbermaw Hold"] then
			tPlayerUIMap = 1448
		elseif tMMZoneText == L["Der Südstrom"] then
			tPlayerUIMap = 1413
		elseif tMMZoneText == L["Die Höhlen des Wehklagens"] or tMMZoneText == L["Höhle der Nebel"]  then
			tPlayerUIMap = 1413
		elseif tMMZoneText == L["Schmiedevaters Grabmal"] or tMMZoneText == L["Schwarzfelsspitze"] then
			tPlayerUIMap = 1428
		else
			for i, v in pairs(SkuDB.InternalAreaTable) do
				if v.AreaName_lang[Sku.Loc] == tMMZoneText then
					tPlayerUIMap = SkuNav:GetUiMapIdFromAreaId(v.ParentAreaID)
				end
			end
		end
	end

	if tPlayerUIMap == nil then
		local tMMZoneText = GetMinimapZoneText()
		if tMMZoneText == L["Deeprun Tram"] then
			tPlayerUIMap = 2257
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

	if tWpData.comments and tWpData.comments[Sku.Loc] then
		if #tWpData.comments[Sku.Loc] > 0 then
			for x = 1, #tWpData.comments[Sku.Loc] do
				local comment = tWpData.comments[Sku.Loc][x] -- the comment to read out
				if comment ~= nil and comment ~= "" then -- check comment of waypoint is a empty string
					print(L["Waypoint information"]..": "..comment)
					C_Timer.After(0.1, function()
						SkuOptions.Voice:OutputString(" ", true, true, 0.3)
						SkuOptions:VocalizeMultipartString(L["Waypoint information"]..": "..comment, false, true, nil, nil, 2)
					end)
				end
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
	return SkuDB.ContinentIds[aContinentId].Name_lang[Sku.Loc]
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
	dprint("GetAreaIdFromUiMapId", aUiMapId)
	local rAreaId
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
		if (v.AreaName_lang[Sku.Loc] == aAreaName) and (SkuNav:GetUiMapIdFromAreaId(i) == tPlayerUIMap) then
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
	return SkuDB.InternalAreaTable[aAreaId].ZoneName, SkuDB.InternalAreaTable[aAreaId].AreaName_lang[Sku.Loc], SkuDB.InternalAreaTable[aAreaId].ContinentID, SkuDB.InternalAreaTable[aAreaId].ParentAreaID, SkuDB.InternalAreaTable[aAreaId].Faction, SkuDB.InternalAreaTable[aAreaId].Flags
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
	return tAreas
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetCurrentAreaId(aUnitId)
	--dprint("GetCurrentAreaId")
	local tMinimapZoneText = GetMinimapZoneText()
	local tAreaId
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if (v.AreaName_lang[Sku.Loc] == tMinimapZoneText) and (SkuNav:GetUiMapIdFromAreaId(i) == tPlayerUIMap) then
			tAreaId = i
			break
		end
	end
	if not tAreaId then
		local tExtMapId
		if aUnitId then
			tExtMapId = SkuDB.ExternalMapID[SkuNav:GetBestMapForUnit(aUnitId)]
		else
			tExtMapId = SkuDB.ExternalMapID[SkuNav:GetBestMapForUnit("player")]
		end
		if tExtMapId then
			for i, v in pairs(SkuDB.InternalAreaTable) do
				if v.AreaName_lang[Sku.Loc] == tExtMapId.Name_lang[Sku.Loc] then
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

	--this is just a flag for the tutorial
	tSkuTutorialGlobalTmpVar1 = true

	return SkuNav:GetDirectionTo(x, y, SkuNav:GetWaypointData2(aWpName).worldX, SkuNav:GetWaypointData2(aWpName).worldY)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:StartRouteRecording(aWPAName, aDeleteFlag)
	print("StartRouteRecording", aWPAName, aDeleteFlag)
	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Route folgen läuft"], false, true, 0.3, true)
		return
	end
	if SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Aufzeichnung läuft"], false, true, 0.3, true)
		return
	end
	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString("", false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Wegpunkt folgen läuft"], false, true, 0.3, true)
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
		SkuOptions:VocalizeMultipartString(L["Löschen beginnt"], false, true, 0.3, true)
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
		SkuOptions.Voice:OutputString(L["Aufzeichnung beendet"], false, true, 0.2)
	else
		SkuOptions.Voice:OutputString(L["Löschen beendet"], false, true, 0.2)
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
			SkuOptions.Voice:OutputString(L["Wer das hört ist doof verlassen"], false, true, nil, true)
		elseif tOldPolyZones[4][1] == 0 then
			--dprint("other entered")
			SkuOptions.Voice:OutputString(L["Wer das hört ist doof betreten"], false, true, nil, true)
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

	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		SkuNav:EndFollowingWpOrRt()
	end

	if distance > 10 then
		if SkuNav:GetWaypointData2(L["Quick waypoint"]..";4") then
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").worldX = tX
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").worldY = tY								
			local tAreaId = SkuNav:GetCurrentAreaId()
			SkuNav:GetWaypointData2(L["Quick waypoint"]..";4").areaId = tAreaId
			--SkuNav:SelectWP(L["Quick waypoint"]..";4", true)

			local tPlayX, tPlayY = UnitPosition("player")
			local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(tPlayX, tPlayY, SkuNav.MaxMetaEntryRange)--SkuOptions.db.profile["SkuNav"].nearbyWpRange)
			SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC = L["Quick waypoint"]..";4"
			
			local wpTable = {SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC}
			local tCoveredWps = {}
			local tMaxAllowedDistanceToTargetWp = 500
			local tSortedWaypointList = {}
			for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
				local tFnd = false
				for tK, tV in pairs(tSortedWaypointList) do
					if tV == v.nearestWpRange..L[";Meter"].."#"..v.nearestWP then
						tFnd = true
					end
				end
				if tFnd == false then
					table.insert(tSortedWaypointList, v.nearestWpRange..L[";Meter"].."#"..v.nearestWP)
				end
			end
			if #tSortedWaypointList == 0 then
				SkuNav:SelectWP(L["Quick waypoint"]..";4", true)
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

				local tSortedList = {}
				for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].weightedDistance > t[a].weightedDistance end) do
					table.insert(tSortedList, k)
				end
				if #tSortedList == 0 then
					SkuNav:SelectWP(L["Quick waypoint"]..";4", true)
				else
					for tK, tV in ipairs(tSortedList) do
						if string.find(tResults[tV].targetWpName, L["Quick waypoint"]..";4") and tV then
							SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
							SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
							SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = true
							break
						end
					end
				end
				if SkuOptions.db.profile["SkuNav"].metapathFollowingTarget and (SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_NPC ~= SkuOptions.db.profile["SkuNav"].metapathFollowingTarget) then
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
						end
					end
				else
					SkuNav:SelectWP(L["Quick waypoint"]..";4", true)
				end
			end

			SkuOptions.Voice:OutputString(L["Quick waypoint 4 set to corpse"], false, true, 0.2)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
local tDeg = {
	[1] = {a = -202.5, f = L["south-east"],},
	[2] = {a = -180, f = L["south"],},
	[3] = {a = -157.5, f = L["south-west"],},
	[4] = {a = -112.5, f = L["west"],},
	[5] = {a = -67.5, f = L["north-west"],},
	[6] = {a = -22.5, f = L["north"],},
	[7] = {a = 22.5, f = L["north-east"],},
	[8] = {a = 67.5, f = L["east"],},
	[9] = {a = 112.5, f = L["south-east"],},
	[10] = {a = 157.5, f = L["south"],},
	[11] = {a = 180, f = L["south-west"],},
}
function SkuNav:GetDirectionToAsString(tx, ty)
	local xa, ya = UnitPosition("player")
	if not xa or not ya or not tx or not ty then
		return 0
	end
	
	aP1x, aP1y, aP2x, aP2y = xa, ya, tx, ty
	
	if aP2x == 0 and aP2y == 0 then
		return 0
	end
		
	local ep2x = (aP2x - aP1x)
	local ep2y = (aP2y - aP1y)
	local Wa = math.acos(ep2x / math.sqrt(ep2x^2 + ep2y^2)) * (180 / math.pi)
	
	if ep2y > 0 then
		Wa = Wa * -1
	end

	local tResult 
	for x = 1, #tDeg do
		if (Wa) > tDeg[x].a then
			tResult = tDeg[x].f
		end
	end

	return tResult
end

--------------------------------------------------------------------------------------------------------------------------------------
local ttimeDistanceOutput = 0
local tPrevGlobalDeg
local tCurrentGlobalDirectionSoundHandle
function SkuNav:ProcessGlobalDirection()
	local tText = UnitPosition("player")
	if not tText then
		return
	end
	if SkuOptions.TTS.MainFrame:IsVisible() == true or SkuOptions:IsMenuOpen() == true then
		return
	end
	if (IsShiftKeyDown() and IsAltKeyDown()) or SkuOptions.db.profile[MODULE_NAME].autoGlobalDirection == true then
		if GetServerTime() - ttimeDistanceOutput > 0.5 or SkuOptions.db.profile[MODULE_NAME].autoGlobalDirection == true then
			local x, y = UnitPosition("player")
			local tDirection = SkuNav:GetDirectionTo(x, y, 30000, y)
			tDirection = 12 - tDirection if tDirection == 0 then tDirection = 12 end

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
					if ((IsShiftKeyDown() and IsAltKeyDown()) and (GetServerTime() - ttimeDistanceOutput > 0.5)) or ( tPrevGlobalDeg ~= x and (tPrevGlobalDeg ~= x and ((tPrevGlobalDeg == 9 and x == 1) or (tPrevGlobalDeg == 1 and x == 9)) == false)) then
						tPrevGlobalDeg = x
						ttimeDistanceOutput = GetServerTime()
						SkuOptions.Voice:OutputString(tDeg[x].file, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ProcessDirAndDistWithWpSelected()
	--output direction and distance to wp if wp selected
	if SkuOptions.TTS.MainFrame:IsVisible() == true or SkuOptions:IsMenuOpen() == true then
		return
	end	
	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		if SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			if distance then
				if IsControlKeyDown() and IsAltKeyDown() then
					if GetServerTime() - ttimeDistanceOutput > 0.5 then
						ttimeDistanceOutput = GetServerTime()
						local tDirection = SkuNav:GetDirectionToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						if SkuOptions.db.profile[MODULE_NAME].vocalizeFullDirectionDistance == true then
							SkuOptions.Voice:OutputString(string.format("%02d", tDirection)..";"..L["Clock"], true, true, 0.3)
							SkuOptions.Voice:OutputString(distance..L[";Meter"], false, true, 0.2)
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
	SkuOptions.Voice:OutputString(L["Zurück Metaroute folgen gestartet"], false, true, 0.2)

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
					if distance < SkuNavWpSize[tWpObject.size] + SkuNav.CurrentStandardWpReachedRange and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)
						SkuOptions:VocalizeMultipartString(L["Arrived;at;waypoint"], false, true, 0.3, true)
							
						if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
							SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						end
						SkuNav:setWaypointVisited(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
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
						if SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget then
							if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget] then
								if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps then
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
								end
							end
						end
						if not SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget] or not tNextWPNr then
							SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							SkuOptions:VocalizeMultipartString(L["Route folgen beendet"], false, true, 0.3, true)
							SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = nil
							SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
						end
						if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint or SkuOptions.db.profile[MODULE_NAME].metapathFollowing then
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

								local selectedWaypoint = SkuOptions.db.profile[MODULE_NAME].selectedWaypoint
								SkuNav:setWaypointVisited(selectedWaypoint)

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
SkuNavMmDrawTimer = 0.2
function SkuNav:CreateSkuNavControl()
	local ttimeDegreesChangeInitial = nil
	local ttime = GetServerTime()
	local ttimeDraw = GetServerTime()

	local f = _G["SkuNavControl"] or CreateFrame("Frame", "SkuNavControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
		ttime = ttime + time
		ttimeDraw = ttimeDraw + time

		--tmp drawing rts on UIParent for debugging
		if ttimeDraw > (SkuNavMmDrawTimer or 0.2) then
			--SkuNav:DrawRoutes(_G["Minimap"])
			SkuNav:DrawAll(_G["Minimap"])
			--SkuNav:DrawRoutes(_G["WorldMapFrame"])
			--SkuNav:DrawRoutes(_G["SkuNavRoutesView"])
			ttimeDraw = 0
		end
		
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

		if ttime > 0.1 then
			SkuNav:ProcessPolyZones()
			SkuNav:ProcessPlayerDead()
			SkuNav:ProcessGlobalDirection()
			SkuNav:ProcessDirAndDistWithWpSelected()
			SkuNav:ProcessCheckReachingWp()

			if SkuOptions.db.profile[MODULE_NAME].metapathFollowing ~= true then
				SkuNav:ClearWaypointsTemporary()
			end

			if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" or SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
				if SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName then
					if SkuCore:IsNamePlateVisible(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName) == true then
						if metapathFollowingTargetNameAnnounced == false then
							SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName, true, true, 0.3, true)
							SkuOptions.Voice:OutputString(L["sichtbar"], false, true, 0.3, true)

							metapathFollowingTargetNameAnnounced = true
						end
					else
						if metapathFollowingTargetNameAnnounced == true then
							SkuOptions.Voice:OutputString(SkuOptions.db.profile[MODULE_NAME].metapathFollowingTargetName, true, true, 0.3, true)
							SkuOptions.Voice:OutputString(L["nicht sichtbar"], false, true, 0.3, true)
							metapathFollowingTargetNameAnnounced = false
						end
					end
				end
			end

			SkuNav.MoveToWp = 0
			ttime = 0
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

		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TURNTOBEACON"].key then
			SkuCore:GameWorldObjectsTurnToWp()
		end


		--[[
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKURTMMDISPLAY"].key then
			if Sku.testMode == true then
				-- NAMEPLATE TEST -->
				SkuCore:PingNameplates()
				-- <-- NAMEPLATE TEST
			else
				SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap = SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true
			end

		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKUMMOPEN"].key then
			SkuOptions.db.profile[MODULE_NAME].showSkuMM = SkuOptions.db.profile[MODULE_NAME].showSkuMM == false
			SkuNav:SkuNavMMOpen()
		end
		]]

		if SkuOptions.db.profile["SkuNav"].showSkuMM == true or SkuOptions.db.profile["SkuNav"].showRoutesOnMinimap == true then
			SkuOptions:StartStopBackgroundSound(false, nil, "map")
			SkuOptions:StartStopBackgroundSound(true, "catpurrwaterdrop.mp3", "map")
		else
			SkuOptions:StartStopBackgroundSound(false, nil, "map")
		end		

		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEREACHRANGE"].key then
			SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange + 1
			if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange > #SkuNav.StandardWpReachedRanges then
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = 1
			end
			SkuNav:UpdateStandardWpReachedRange(0)
			SkuOptions:VocalizeMultipartString(SkuNav.StandardWpReachedRanges[SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange], true, true, 0.3, true)
		end


		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STARTRRFOLLOW"].key then
			SkuNav:StartReverseRtFollow()
		end
		
		--move to prev/next wp on following a rt
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETONEXTWP"].key then
			SkuNav.MoveToWp = 1
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETOPREVWP"].key then
			SkuNav.MoveToWp = -1
		end

		--add manual int wp and link if recording
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDSMALLWP"].key or a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDLARGEWP"].key then
			if SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete ~= true then
				local tWpSize = 1
				if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDLARGEWP"].key then
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

		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEMMSIZE"].key then
			SkuNav.MinimapFull = SkuNav.MinimapFull == false
			if SkuNav.MinimapFull == true then
				MinimapCluster:SetScale(3.5)
			else
				MinimapCluster:SetScale(1)
			end
		end

		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STOPROUTEORWAYPOINT"].key then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:ClearWaypointsTemporary()
			PlaySound(835)
		end

		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1"].key then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";1")
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1SET"].key then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";1")
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2"].key then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";2")
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2SET"].key then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";2")
		end		
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3"].key then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";3")
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3SET"].key then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";3")
		end		
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4"].key then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";4")
		end
		if a == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4SET"].key then
			SkuNav:UpdateQuickWP(L["Quick waypoint"]..";4")
		end		
		
	end)
	tFrame:Hide()
	
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TURNTOBEACON"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TURNTOBEACON"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STARTRRFOLLOW"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STARTRRFOLLOW"].key)
	--SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKUMMOPEN"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKUMMOPEN"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEREACHRANGE"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEREACHRANGE"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETONEXTWP"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETONEXTWP"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETOPREVWP"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_MOVETOPREVWP"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDLARGEWP"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDLARGEWP"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDSMALLWP"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_ADDSMALLWP"].key)
	--SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKURTMMDISPLAY"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_SKURTMMDISPLAY"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEMMSIZE"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TOGGLEMMSIZE"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1SET"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP1SET"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2SET"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP2SET"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3SET"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP3SET"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4SET"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_QUICKWP4SET"].key)
	SetOverrideBindingClick(tFrame, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STOPROUTEORWAYPOINT"].key, tFrame:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_STOPROUTEORWAYPOINT"].key)
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnEnable()
	--dprint("SkuNav OnEnable")
	if not SkuOptions.db.global[MODULE_NAME] then
		SkuOptions.db.global[MODULE_NAME] = {}
	end
	if not SkuOptions.db.global[MODULE_NAME].Waypoints then
		SkuOptions.db.profile[MODULE_NAME].Waypoints = nil
		SkuOptions.db.global[MODULE_NAME].Waypoints = {}
	end

	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingDelete = nil

	SkuNav:SelectWP("", true)

	if not SkuOptions.db.profile[MODULE_NAME].RecentWPs then
		SkuOptions.db.profile[MODULE_NAME].RecentWPs = {}
	end

	--SkuNav:SkuNavMMOpen()
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
			SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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
				SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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
				SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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
	
	SkuOptions.db.global["SkuNav"].hasCustomMapData = true

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
			WaypointCache[WaypointCacheLookupAll[tWpName]].comments = {
				["deDE"] = {},
				["enUS"] = {},
			}
			if SkuOptions.db.global[MODULE_NAME].Waypoints[WaypointCacheLookupCacheNameForId[tWpName]] then
				SkuOptions.db.global[MODULE_NAME].Waypoints[WaypointCacheLookupCacheNameForId[tWpName]].comments = nil
				SkuOptions.db.global[MODULE_NAME].Waypoints[WaypointCacheLookupCacheNameForId[tWpName]].lComments = {
					["deDE"] = {},
					["enUS"] = {},
				}
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

	SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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
			SkuOptions.db.global["SkuNav"].hasCustomMapData = true
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

	if not tPlayerContinentID then
		return tFoundWps
	end

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

	local tBeaconType = SkuNav:GetBeaconSoundSetName(SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size)
	local tCCType = SkuOptions.db.profile[MODULE_NAME].clickClackSoundset
	if SkuOptions.db.profile[MODULE_NAME].clickClackEnabled ~= true then
		tCCType = nil
	end
	if not SkuOptions.BeaconLib:CreateBeacon("SkuOptions", aWpName, tBeaconType, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume, SkuOptions.db.profile[MODULE_NAME].clickClackRange, nil, nil, nil, nil, tCCType) then
		return
	end
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
function SkuNav:UpdateQuickWP(aWpName, aSilent, x, y)
	dprint("UpdateQuickWP", aWpName)
	if not aWpName then
		return
	end

	if not SkuNav:GetWaypointData2(aWpName) then
		--return
	end

	local tAreaId = SkuNav:GetCurrentAreaId()

	if tAreaId == 0 then
		SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
		return
	end

	local worldx, worldy = UnitPosition("player")
	if x and y then
		worldx, worldy = x, y
	end
	local tPName = UnitName("player")
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())) or -1
	local tInitialPlayerContintentId = tPlayerContintentId

	if IsAltKeyDown() == true then
		worldx, worldy = UnitPosition("target")

		if not worldx then 
			SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
			return
		end

		tPName = UnitName("target")
		if not SkuNav:GetBestMapForUnit("target") then
			SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
			return
		end
		tAreaId = SkuNav:GetCurrentAreaId("target")
		if not tAreaId then
			SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
			return
		end

		tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId("target"))) or -1
		if not tPlayerContintentId then
			SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
			return
		end

		if not tInitialPlayerContintentId or (tInitialPlayerContintentId ~= tPlayerContintentId) then
			SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
			return
		end			
	end

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
	if not aSilent then
		SkuOptions:VocalizeMultipartString(aWpName..";"..L["updated"], true, true, 0.2)
	end

	if IsAltKeyDown() == true then
		C_Timer.After(0.1, function()
			SkuNav:EndFollowingWpOrRt()
			C_Timer.After(0.1, function()
				SkuOptions.db.profile["SkuNav"].metapathFollowing = false
				local worldx, worldy = UnitPosition("player")
				local tPName = UnitName("player")
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())) or -1			
				SkuOptions.db.profile[MODULE_NAME].metapathFollowingStartTMP = nil
				SkuMetapathFollowingMetapathsTMP = nil
				local tPlayX, tPlayY = UnitPosition("player")
				local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(worldx, worldy, SkuNav.MaxMetaEntryRange)--SkuOptions.db.profile[MODULE_NAME].nearbyWpRange)

				local tSortedWaypointList = {}
				for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
					local tFnd = false
					for tK, tV in pairs(tSortedWaypointList) do
						if tV == v.nearestWP then
							tFnd = true
						end
					end
					if tFnd == false then
						table.insert(tSortedWaypointList, v.nearestWP)
						break
					end
				end

				if #tSortedWaypointList > 0 then
					local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), 10000, 1000, nil, true)
					local tResults = {}
					local tNearWps = SkuNav:GetNearestWpsWithLinksToWp(aWpName, 10, 100000)
					local tBestRouteWeightedLength = 100000
					for x = 1, #tNearWps do
						if tMetapaths[tNearWps[x].wpName] then
							local EndMetapathWpObj = SkuNav:GetWaypointData2(tNearWps[x].wpName)
							local tEndTargetWpObj = SkuNav:GetWaypointData2(aWpName)
							local tDistToEndTargetWp = SkuNav:Distance(EndMetapathWpObj.worldX, EndMetapathWpObj.worldY, tEndTargetWpObj.worldX, tEndTargetWpObj.worldY)

							-- add direction to wp
							local tDirectionTargetWp = ""
							if SkuOptions.db.profile["SkuNav"].showGlobalDirectionInWaypointLists == true then
								local tDirectionString = SkuNav:GetDirectionToAsString(tEndTargetWpObj.worldX, tEndTargetWpObj.worldY)
								if tDirectionString then
									tDirectionTargetWp = ";"..tDirectionString
								end
							end	
															
							if (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp < tBestRouteWeightedLength then
								tBestRouteWeightedLength = (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp
								tResults[aWpName] = {
									metarouteIndex = tNearWps[x].wpName, 
									metapathLength = tMetapaths[tNearWps[x].wpName].distance, 
									distanceTargetWp = tNearWps[x].distance,
									targetWpName = aWpName,
									weightedDistance = tBestRouteWeightedLength,
									direction = tDirectionTargetWp,
								}
							end
						end
					end
					
					local tSortedList = {}
					for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].weightedDistance > t[a].weightedDistance end) do
						table.insert(tSortedList, k)
					end
					if #tSortedList > 0 then
						SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tSortedList[1]].metarouteIndex
						SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tSortedList[1]].targetWpName
						SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = true
						--tCoveredWps[tSortedList[1]] = true
					end

					SkuOptions.db.profile["SkuNav"].metapathFollowingStart = tSortedWaypointList[1]

					SkuOptions.db.profile["SkuNav"].metapathFollowing = false
					if SkuOptions.db.profile["SkuNav"].metapathFollowingStart then
						if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
							SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, 10000, 1000, SkuOptions.db.profile["SkuNav"].metapathFollowingTarget, true)--
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[#SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths+1] = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget] = SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingTarget]
						table.insert(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget].pathWps, SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget)
						SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
						SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
						SkuOptions.db.profile["SkuNav"].metapathFollowing = true
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
						SkuOptions.Voice:OutputStringBTtts(L["Metaroute folgen gestartet"], false, true, 0.2)
					end

				end
			end)
		end)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnDisable()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_LEAVING_WORLD(...)
	SkuNav:ClearWaypointsTemporary()
	SkuOptions.db.profile["SkuNav"].metapathFollowingMetapathsTMP = {}
	SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = {}

	if SkuOptions.db.global["SkuNav"].hasCustomMapData ~= true then
		SkuOptions.db.global["SkuNav"].Waypoints = {}
		SkuOptions.db.global["SkuNav"].Links = {}
	end
	
	if SkuOptions.currentBackgroundSoundHandle then
		for i, v in pairs(SkuOptions.currentBackgroundSoundHandle) do
			StopSound(v, 0)
		end
	end
	if SkuCore.currentBackgroundSoundHandle then
		StopSound(SkuCore.currentBackgroundSoundHandle, 0)
	end
	SkuOptions.BeaconLib:DestroyBeacon("SkuOptions")
	SkuOptions.Voice:StopOutputEmptyQueue(true, true)
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
	--print("PLAYER_LOGIN", ...)
	SkuNav.MinimapFull = false

	SkuOptions.db.global["SkuNav"] = SkuOptions.db.global["SkuNav"] or {}

	--load default data if there isn't custom data
	SkuNav:LoadDefaultMapData()

	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingLastWp = nil
		
	--tomtom integration for adding beacons to the arrow
	if TomTom then
		SkuOptions.tomtomBeaconName = "SkuTomTomBeacon"
		C_Timer.NewTimer(5, function() 
			hooksecurefunc(TomTom, "AddWaypoint", function(self, map, x, y, options)
				if SkuOptions.db.profile[MODULE_NAME].tomtomWp == true then
					local bx, by = SkuOptions.HBD:GetWorldCoordinatesFromZone(x, y, map)
					local tBeaconType = SkuNav:GetBeaconSoundSetName(SkuNav:GetWaypointData2(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size)
					local tCCType = SkuOptions.db.profile[MODULE_NAME].clickClackSoundset
					SkuOptions.BeaconLib:CreateBeacon("SkuOptions", SkuOptions.tomtomBeaconName, tBeaconType, by, bx, -3, 1, SkuOptions.db.profile["SkuNav"].beaconVolume)
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

	--SkuNav:SkuNavMMOpen()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:LoadDefaultMapData(aForce)
	dprint("LoadDefaultMapData", aForce, SkuOptions.db.global["SkuNav"].hasCustomMapData)
	--if SkuOptions.db.global["SkuNav"].hasCustomMapData ~= true or aForce then
		local t = SkuDB.routedata["global"]["Waypoints"]
		SkuOptions.db.global["SkuNav"].Waypoints = t
		local tl = SkuDB.routedata["global"]["Links"]
		SkuOptions.db.global["SkuNav"].Links = tl
	--end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_ENTERING_WORLD(aEvent, aIsInitialLogin, aIsReloadingUi)
	--print("PLAYER_ENTERING_WORLD", aEvent, aIsInitialLogin, aIsReloadingUi)
	SkuOptions.db.profile["SkuNav"].metapathFollowingMetapathsTMP = {}
	SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = {}

	SkuNav:UpdateStandardWpReachedRange()

	--load default data if there isn't custom data
	if aIsInitialLogin ~= true then
		SkuNav:LoadDefaultMapData(true)
	end

	C_Timer.NewTimer(15, function() SkuDrawFlag = true end)

	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = false
	SkuOptions.db.profile[MODULE_NAME].routeRecording = false

	SkuNav:SelectWP("", true)

	SkuNav:ClearWaypointsTemporary(true)

	--routedata reset to default on first login with wrath client
	if SkuOptions.db.profile[MODULE_NAME].wotlkMapReset ~= true then
		SkuOptions.db.profile[MODULE_NAME].wotlkMapReset = true
		local t = SkuDB.routedata["global"]["Waypoints"]
		SkuOptions.db.global["SkuNav"].Waypoints = t
		local tl = SkuDB.routedata["global"]["Links"]
		SkuOptions.db.global["SkuNav"].Links = tl
	end

	if aIsInitialLogin == true or aIsReloadingUi == true then
		SkuNav:CreateWaypointCache()
	end

	if _G["SkuNavMMMainFrameZoneSelect"] then
		C_Timer.NewTimer(1, function()
			if SkuNav:GetCurrentAreaId() then
				_G["SkuNavMMMainFrameZoneSelect"].value = SkuNav:GetCurrentAreaId()
				_G["SkuNavMMMainFrameZoneSelect"]:SetText(SkuDB.InternalAreaTable[SkuNav:GetCurrentAreaId()].AreaName_lang[Sku.Loc])	
			end
		end)
	end

	-- populate sound set names
	C_Timer.After(0.01, function()
		SkuNav.BeaconSoundSetNames = {}
		for key, value in ipairs(SkuOptions.BeaconLib:GetSoundSets()) do
			SkuNav.BeaconSoundSetNames[value] = value
		end

		SkuNav.options.args.beaconSoundSetNarrow.values = SkuNav.BeaconSoundSetNames
		SkuNav.options.args.beaconSoundSetWide.values = SkuNav.BeaconSoundSetNames
	end)

	-- populate clickclack sound set names
	SkuNav.ClickClackSoundsets = {}
	SkuNav.ClickClackSoundsets["off"] = L["Nichts"]
	for key, value in pairs(SkuOptions.BeaconLib:GetClickClackSoundSets()) do
		SkuNav.ClickClackSoundsets[key] = value.friendlyName
	end
	SkuNav.options.args.clickClackSoundset.values = SkuNav.ClickClackSoundsets

	SetCVar("cameraYawSmoothSpeed", 270)

	if SkuOptions.db.profile["SkuNav"].showSkuMM == true or SkuOptions.db.profile["SkuNav"].showRoutesOnMinimap == true then
		SkuOptions:StartStopBackgroundSound(false, nil, "map")
		SkuOptions:StartStopBackgroundSound(true, "catpurrwaterdrop.mp3", "map")
	else
		SkuOptions:StartStopBackgroundSound(false, nil, "map")
	end			

	for x = 1, 4 do
		local tWaypointName = L["Quick waypoint"]..";"..x
		SkuNav:UpdateQuickWP(tWaypointName, true)
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
function SkuNav:CreateWaypoint(aName, aX, aY, aSize, aForcename, aIsTempWaypoint)
	dprint("CreateWaypoint", aName, aX, aY, aSize, aForcename, aIsTempWaypoint)
	aSize = aSize or 1
	local tPName = UnitName("player")

	if aName == nil then
		-- this generates (almost) unique auto wp numbers, to avoid duplicates and renaming on import/export of WPs and Rts later on
		-- numbers > 1000000 are not vocalized by SkuVoice; thus they are silent, even if they are part of the auto WP names
		local tNumber = string.gsub(tostring(GetServerTime()..format("%.2f", GetTimePreciseSec())), "%.", "") --tostring(GetServerTime()..GetTimePreciseSec())
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
		}, aIsTempWaypoint)
	else
		aName = nil
	end

	if aName and not aIsTempWaypoint then
		if not string.find(aName, L["Einheiten;Route;"]) then
			SkuOptions.db.global["SkuNav"].hasCustomMapData = true
		end
	end

	return aName
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aName string
---@param aData table contintentId, areaId, worldX, worldY, createdAt, createdBy
function SkuNav:SetWaypoint(aName, aData, aIsTempWaypoint)
	dprint("SkuNav:SetWaypoint", aName, aData, aIsTempWaypoint)
	--if aData then setmetatable(aData, SkuPrintMTWo) dprint(aData) end

	local tWpIndex

	local tIsNew
	if WaypointCacheLookupAll[aName] then
		if WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[aName]].contintentId] then
			WaypointCacheLookupPerContintent[WaypointCache[WaypointCacheLookupAll[aName]].contintentId][WaypointCacheLookupAll[aName]] = nil
		end
		tWpIndex = WaypointCacheLookupAll[aName]
	else
		tWpIndex = #WaypointCache + 1
		WaypointCache[tWpIndex] = {
			name = aName,
			typeId = 1,
		}
		tIsNew = true
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
	WaypointCache[tWpIndex].spawn = 1
	WaypointCache[tWpIndex].contintentId = aData.contintentId or WaypointCache[tWpIndex].contintentId
	WaypointCache[tWpIndex].areaId = aData.areaId or WaypointCache[tWpIndex].areaId
	WaypointCache[tWpIndex].uiMapId = SkuNav:GetUiMapIdFromAreaId(aData.areaId) or WaypointCache[tWpIndex].uiMapId
	WaypointCache[tWpIndex].worldX = aData.worldX or WaypointCache[tWpIndex].worldX
	WaypointCache[tWpIndex].worldY = aData.worldY or WaypointCache[tWpIndex].worldY
	WaypointCache[tWpIndex].createdAt = aData.createdAt or WaypointCache[tWpIndex].createdAt or 0
	WaypointCache[tWpIndex].createdBy = aData.createdBy or WaypointCache[tWpIndex].createdBy or "SkuNav"
	WaypointCache[tWpIndex].size = aData.size or WaypointCache[tWpIndex].size or 1
	WaypointCache[tWpIndex].comments = aData.comments or WaypointCache[tWpIndex].comments or {
		["deDE"] = {},
		["enUS"] = {},
	}
	WaypointCache[tWpIndex].links = aData.links or WaypointCache[tWpIndex].links or {byId = nil, byName = nil,}
	WaypointCache[tWpIndex].isTempWaypoint = aIsTempWaypoint

	WaypointCacheLookupAll[aName] = tWpIndex

	if not WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId] then
		WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId] = {}
	end
	WaypointCacheLookupPerContintent[WaypointCache[tWpIndex].contintentId][tWpIndex] = aName

	if tIsNew then
		if WaypointCache[tWpIndex].isTempWaypoint ~= true then
			table.insert(SkuOptions.db.global[MODULE_NAME].Waypoints, {
				["names"] = {
					[Sku.Loc] = WaypointCache[tWpIndex].name,
				},
				["contintentId"] = WaypointCache[tWpIndex].contintentId,
				["areaId"] = WaypointCache[tWpIndex].areaId,
				["worldX"] = WaypointCache[tWpIndex].worldX,
				["worldY"] = WaypointCache[tWpIndex].worldY,
				["createdAt"] = WaypointCache[tWpIndex].createdAt,
				["createdBy"] = WaypointCache[tWpIndex].createdBy,
				["size"] = WaypointCache[tWpIndex].size,
				["comments"] = WaypointCache[tWpIndex].comments,
				["lComments"] = {
					["deDE"] = {},
					["enUS"] = {},
				},
			})

			WaypointCache[tWpIndex].dbIndex = #SkuOptions.db.global[MODULE_NAME].Waypoints

			WaypointCacheLookupCacheNameForId[aName] = SkuNav:BuildWpIdFromData(1, WaypointCache[tWpIndex].dbIndex, 1, WaypointCache[tWpIndex].areaId)

			for i, v in pairs(Sku.Locs) do
				if not SkuOptions.db.global[MODULE_NAME].Waypoints[WaypointCache[tWpIndex].dbIndex].names[v] then
					SkuOptions.db.global[MODULE_NAME].Waypoints[WaypointCache[tWpIndex].dbIndex].names[v] = ""
				end
			end
		else
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints = SkuOptions.db.global[MODULE_NAME].TmpWaypoints or {}
			table.insert(SkuOptions.db.global[MODULE_NAME].TmpWaypoints, {
				["names"] = {
					[Sku.Loc] = WaypointCache[tWpIndex].name,
				},
				["contintentId"] = WaypointCache[tWpIndex].contintentId,
				["areaId"] = WaypointCache[tWpIndex].areaId,
				["worldX"] = WaypointCache[tWpIndex].worldX,
				["worldY"] = WaypointCache[tWpIndex].worldY,
				["createdAt"] = WaypointCache[tWpIndex].createdAt,
				["createdBy"] = WaypointCache[tWpIndex].createdBy,
				["size"] = WaypointCache[tWpIndex].size,
				["comments"] = WaypointCache[tWpIndex].comments,
				["lComments"] = {
					["deDE"] = {},
					["enUS"] = {},
				},
			})

			WaypointCache[tWpIndex].dbIndex = #SkuOptions.db.global[MODULE_NAME].TmpWaypoints

			--WaypointCacheLookupCacheNameForId[aName] = SkuNav:BuildWpIdFromData(1, WaypointCache[tWpIndex].dbIndex, 1, WaypointCache[tWpIndex].areaId)

			for i, v in pairs(Sku.Locs) do
				if not SkuOptions.db.global[MODULE_NAME].TmpWaypoints[WaypointCache[tWpIndex].dbIndex].names[v] then
					SkuOptions.db.global[MODULE_NAME].TmpWaypoints[WaypointCache[tWpIndex].dbIndex].names[v] = aName
				end
			end
		end
	else
		local tWpId = WaypointCache[tWpIndex].dbIndex
		if WaypointCache[tWpIndex].isTempWaypoint ~= true then
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["names"][Sku.Loc] = WaypointCache[tWpIndex].name
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["contintentId"] = WaypointCache[tWpIndex].contintentId 
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["areaId"] = WaypointCache[tWpIndex].areaId
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["worldX"] = WaypointCache[tWpIndex].worldX
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["worldY"] = WaypointCache[tWpIndex].worldY
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["createdAt"] = WaypointCache[tWpIndex].createdAt
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["createdBy"] = WaypointCache[tWpIndex].createdBy
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["size"] = WaypointCache[tWpIndex].size
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpId]["lComments"] = WaypointCache[tWpIndex].comments
		else
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["names"][Sku.Loc] = WaypointCache[tWpIndex].name
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["contintentId"] = WaypointCache[tWpIndex].contintentId 
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["areaId"] = WaypointCache[tWpIndex].areaId
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["worldX"] = WaypointCache[tWpIndex].worldX
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["worldY"] = WaypointCache[tWpIndex].worldY
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["createdAt"] = WaypointCache[tWpIndex].createdAt
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["createdBy"] = WaypointCache[tWpIndex].createdBy
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["size"] = WaypointCache[tWpIndex].size
			SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpId]["lComments"] = WaypointCache[tWpIndex].comments
		end
	end	

	SkuNav:UpdateWpLinks(aName)
end

---------------------------------------------------------------------------------------------------------------------------------------
local GetNpcRolesCache = {}
function SkuNav:GetNpcRoles(aNpcName, aNpcId, aLocale)
	aLocale = aLocale or Sku.Loc
	if not aNpcId then
		for i, v in pairs(SkuDB.NpcData.Names[aLocale]) do
			if v[1] == aNpcName then
				aNpcId = i
				break
			end
		end
	end

	local tHasNoLocalizedData
	if not aNpcId then
		tHasNoLocalizedData = true
		for i, v in pairs(SkuDB.NpcData.Data) do
			if v[1] == aNpcName then
				aNpcId = i
				break
			end
		end
	end	

	if not GetNpcRolesCache[aLocale] then
		GetNpcRolesCache[aLocale] = {}
	end

	if GetNpcRolesCache[aLocale][aNpcId] then
		return GetNpcRolesCache[aLocale][aNpcId]
	end

	local rRoles = {}
	local tTempLocale = aLocale
	if tHasNoLocalizedData then
		tTempLocale = "enUS"
	end

	for i, v in pairs(SkuNav.NPCRolesToRecognize[tTempLocale]) do
		if SkuDB.NpcData.Data[aNpcId] then
			if bit.band(i, SkuDB.NpcData.Data[aNpcId][SkuDB.NpcData.Keys["npcFlags"]]) > 0 then
				--dprint(aNpcName, aNpcId, i, v)
				rRoles[#rRoles+1] = v
				break
			end
		end
	end

	GetNpcRolesCache[aLocale][aNpcId] = rRoles
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
				if SkuNav:DeleteWaypoint(SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary[x], true) ~= true then
					dprint("THIS SHOULD NOT HAPPEN: tmp WP could not be deleted on clear:", SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary[x])
				end
			end
			SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary = {}
		end
	end

	if aFull then
		local tIndex = 1
		while SkuNav:GetWaypointData2(L["Einheiten;Route;"]..tIndex) do
			if SkuNav:DeleteWaypoint(L["Einheiten;Route;"]..tIndex, true) ~= true then
				dprint("THIS SHOULD NOT HAPPEN: tmp WP could not be deleted on clear:", "Einheiten;Route;"..tIndex)
			end
			tIndex = tIndex + 1
		end
		SkuOptions.db.profile[MODULE_NAME].WaypointsTemporary = {}
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteWaypoint(aWpName, aIsTempWaypoint)
	dprint("SkuNav:DeleteWaypoint", aWpName, aIsTempWaypoint)
	local tWpData = SkuNav:GetWaypointData2(aWpName)
	local tWpId = WaypointCacheLookupCacheNameForId[aWpName]
	
	if not tWpData then
		return false
	end

	if tWpData.typeId ~= 1 then
		print(L["Only custom waypoints can be deleted"])
		return false
	end


	if aIsTempWaypoint == true or tWpData.isTempWaypoint == true then
		--delete from TmpWaypoints db
		SkuOptions.db.global[MODULE_NAME].TmpWaypoints[tWpData.dbIndex] = nil
		local tCacheIndex = WaypointCacheLookupAll[aWpName] 
		WaypointCacheLookupPerContintent[tWpData.contintentId][tCacheIndex] = nil
		WaypointCacheLookupAll[aWpName] = nil
		WaypointCache[tCacheIndex] = nil

	else
		local tCacheIndex = WaypointCacheLookupAll[aWpName] 
		if not SkuOptions.db.global[MODULE_NAME].Waypoints[tWpData.dbIndex] then
			dprint("ERROR waypoint nil in db")
		else
			--remove from links db

			--remove links in linked wps in cache
			if tWpData.links.byId then
				for index, distance in pairs(tWpData.links.byId) do
					WaypointCache[index].links.byId[tCacheIndex] = nil
					WaypointCache[index].links.byName[aWpName] = nil
					--and in options links
					local tCacheLinksId = SkuNav:BuildWpIdFromData(WaypointCache[index].typeId, WaypointCache[index].dbIndex, WaypointCache[index].spawn, WaypointCache[index].areaid)
					local tLinksId = SkuNav:BuildWpIdFromData(WaypointCache[tCacheIndex].typeId, WaypointCache[tCacheIndex].dbIndex, WaypointCache[tCacheIndex].spawn, WaypointCache[tCacheIndex].areaid)
					SkuOptions.db.global[MODULE_NAME].Links[tCacheLinksId][tLinksId] = nil
				end
			end
			if tWpData.links.byName then
				for name, distance in pairs(tWpData.links.byName) do
					WaypointCache[WaypointCacheLookupAll[aWpName]].links.byId[tCacheIndex] = nil
					WaypointCache[WaypointCacheLookupAll[aWpName]].links.byName[aWpName] = nil

					local tCacheLinksId = SkuNav:BuildWpIdFromData(WaypointCache[WaypointCacheLookupAll[aWpName]].typeId, WaypointCache[WaypointCacheLookupAll[aWpName]].dbIndex, WaypointCache[WaypointCacheLookupAll[aWpName]].spawn, WaypointCache[WaypointCacheLookupAll[aWpName]].areaid)
					local tLinksId = SkuNav:BuildWpIdFromData(WaypointCache[tCacheIndex].typeId, WaypointCache[tCacheIndex].dbIndex, WaypointCache[tCacheIndex].spawn, WaypointCache[tCacheIndex].areaid)
					SkuOptions.db.global[MODULE_NAME].Links[tCacheLinksId][tLinksId] = nil
				end
			end

			WaypointCacheLookupIdForCacheIndex[SkuNav:BuildWpIdFromData(WaypointCache[tCacheIndex].typeId, WaypointCache[tCacheIndex].dbIndex, WaypointCache[tCacheIndex].spawn, WaypointCache[tCacheIndex].areaid)] = nil
			WaypointCacheLookupCacheNameForId[aWpName] = nil
			WaypointCacheLookupPerContintent[tWpData.contintentId][tCacheIndex] = nil
			WaypointCacheLookupAll[aWpName] = nil
			WaypointCache[tCacheIndex] = nil
			

			--delete from waypoint db
			SkuOptions.db.global[MODULE_NAME].Waypoints[tWpData.dbIndex] = {false}
		end
		
		SkuNav:SaveLinkDataToProfile()

		return true
	end

	return false
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetBeaconSoundSetName(size)
	local beacontype = "narrow"
	if size == 5 then
		beacontype = "wide"
	end
	local name = ""
	if beacontype == "narrow" then
		name = SkuNav.BeaconSoundSetNames[SkuOptions.db.profile[MODULE_NAME].beaconSoundSetNarrow]
	else
		name = SkuNav.BeaconSoundSetNames[SkuOptions.db.profile[MODULE_NAME].beaconSoundSetWide]
	end
	if name == nil then
		if size == 5 then
			return "Beacon 4"
		end
		return "Beacon 2"
	end
	return name
end

------------------------------------------------------------------------------------------------------------------------
--id bitfield: int64, bits 1-48 used
local dbIndexBits = 20 -- 1-20, max 1,048,576 entries for all waypoints from base1-3
local areaIdBits	= 18 -- 21-38, max 262,144 entries
local spawnBits	= 10 -- 39, 48, max 1,024 entries
--dbIndexBits is splitted
local base1 		= 0			--custom waypoints 1-199,999
local base2 		= 200000		--creatures 200,000-499,999
local base3 		= 500000		--objects 500,000-999,999

------------------------------------------------------------------------------------------------------------------------
function SkuNav:BuildWpIdFromData(typeId, dbIndex, spawn, areaId)
	areaId = areaId or 1
	local tSourceId

	local tBase
	if typeId == 1 then
		tBase = base1
	elseif typeId == 2 then
		tBase = base2
	elseif typeId == 3 then
		tBase = base3
	end

	local vspawnShifted = SkuU64lshift(spawn, dbIndexBits + areaIdBits)
	local vareaIdShifted = SkuU64lshift(areaId, dbIndexBits)
	
	tSourceId = dbIndex + tBase + vareaIdShifted + vspawnShifted
	
	return tSourceId
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetWpDataFromId(id)
	local typeId, dbIndex, spawn, areaId

	spawn = SkuU64rshift(id, dbIndexBits + areaIdBits)
	areaId = SkuU64rshift(id - SkuU64lshift(spawn, dbIndexBits + areaIdBits), dbIndexBits)
	dbIndex = id - SkuU64lshift(areaId, dbIndexBits) - SkuU64lshift(spawn, dbIndexBits + areaIdBits)

	if dbIndex < base2 then
		typeId = 1
	elseif dbIndex < base3 then
		typeId = 2
		dbIndex = dbIndex - base2
	else
		typeId = 3
		dbIndex = dbIndex - base3
	end	

	return typeId, dbIndex, spawn, areaId
end
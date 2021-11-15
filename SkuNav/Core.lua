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
							print(tTab..k..":")
							tf(v, tTab.."  ")
						elseif type(v) == "function" then
							--print(tTab..k..": function")
						elseif type(v) == "boolean" then
							print(tTab..k..": "..tostring(v))
						else
							print(tTab..k..": "..v)
						end
					end
				end
			end
		end
		tf(thisTable, "")
	end,
	}

---------------------------------------------------------------------------------------------------------------------------------------
--this is a temp hack for the weird transit zone between badlands and Searing Gorge. due to unknown reasons SkuNav:GetBestMapForUnit returns 1415 (eastern kingdoms) there.
function SkuNav:GetBestMapForUnit(aUnitId)
	local tPlayerUIMap = C_Map.GetBestMapForUnit(aUnitId)
	if tPlayerUIMap == 1415 then
		tPlayerUIMap = 1418
		if GetMinimapZoneText() == L["Stonewrought-Pass"] then
			tPlayerUIMap = 1432
		end
	end
	return tPlayerUIMap
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PlayWpComments(aWpName)
	if not aWpName then
		return
	end
	if not SkuOptions.db.profile["SkuNav"].Waypoints[aWpName] then
		return
	end
	if SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments then
		if #SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments > 0 then
			for x = 1, #SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments do
				print(L["Waypoint information"]..": "..SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments[x])
				SkuOptions.Voice:OutputString(" ", true, true, 0.3)
				SkuOptions:VocalizeMultipartString(L["Waypoint information"]..": "..SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments[x], false, true, nil, nil, 3)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateRtContinentAndAreaIds(aRoutename)
	local tUiMapIds = {}
	if aRoutename and aRoutename ~= "" then
		if SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tStartWPName then
			local tTempWpObj = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tStartWPName)
			if tTempWpObj then
				SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tContinentId = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tStartWPName).contintentId
				for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].WPs) do
					--print("UpdateRtContinentAndAreaIds", aRoutename, i, v)
					local tWpObj = SkuNav:GetWaypoint(v)
					if tWpObj then
						if tWpObj.areaId then
							local tUiMapId = SkuNav:GetUiMapIdFromAreaId(tWpObj.areaId)
							if tUiMapId then
								--print("   ++++++++", tUiMapId)
								tUiMapIds[SkuNav:GetUiMapIdFromAreaId(tWpObj.areaId)] = true
							end
						end
					end
				end
				SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tUiMapIds = tUiMapIds
			else
				--print("FAIL", SkuOptions.db.profile[MODULE_NAME].Routes[aRoutename].tStartWPName)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tCacheNbWpsTimerCounter = 0
local tCacheNbWpsTimerCounterProgress = 0
local tCacheNbWpsTimerCounterProgressShow = false
local tCacheNbWpsTimerRate = 10
local tCacheNbWpsTimer = nil
local SkuNeighbCache = {}
function CacheNbWps(aRate, aListOfRouteNamesToReCache, aListOfWpNamesToReCache)
	tCacheNbWpsTimerRate = 10 --aRate or 10
	if _G["SkuNavMMMainFrame"] then
		if _G["SkuNavMMMainFrame"]:IsShown() == true then
			return
		end
	end

	if SkuCacheFlag == false then
		return
	end

	local tCacheNbWpsTimerWpList = {}
	if aListOfRouteNamesToReCache then
		for i, tRouteName in ipairs(aListOfRouteNamesToReCache) do
			if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName] then
				if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs then
					for x, tWpName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs) do
						tCacheNbWpsTimerWpList[#tCacheNbWpsTimerWpList + 1] = tWpName
					end
				end
			end
		end
	elseif aListOfWpNamesToReCache then
		for x, tWpName in ipairs(aListOfWpNamesToReCache) do
			tCacheNbWpsTimerWpList[#tCacheNbWpsTimerWpList + 1] = tWpName
		end
	else
		for i, tRouteName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
			if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName] then
				if SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs then
					for x, tWpName in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs) do
						tCacheNbWpsTimerWpList[#tCacheNbWpsTimerWpList + 1] = tWpName
					end
				end
			end
		end
	end

	if #tCacheNbWpsTimerWpList > 0 then
		if tCacheNbWpsTimer then
			tCacheNbWpsTimer:Cancel()
			tCacheNbWpsTimer = nil
			if tCacheNbWpsTimerCounterProgressShow == true then
				print("SkuNav: Caching restarted...")
			end
		else
			if tCacheNbWpsTimerCounterProgressShow == true then
				print("SkuNav: Caching started...")
			end
		end

		tCacheNbWpsTimerCounter = 0
		tCacheNbWpsTimerCounterProgress = 0
		tCacheNbWpsTimer = C_Timer.NewTicker(0, function()
			for x = 1, tCacheNbWpsTimerRate do
				tCacheNbWpsTimerCounter = tCacheNbWpsTimerCounter + 1
				if tCacheNbWpsTimerCounter >= #tCacheNbWpsTimerWpList == true then
					if tCacheNbWpsTimer then
						tCacheNbWpsTimer:Cancel()
						tCacheNbWpsTimer = nil
						if tCacheNbWpsTimerCounterProgressShow == true then
							print("SkuNav: Caching completed")
						end
					end
				end
				if tCacheNbWpsTimerWpList[tCacheNbWpsTimerCounter] then
					GetNeighbToWp(tCacheNbWpsTimerWpList[tCacheNbWpsTimerCounter], true)
				end
			end
			if tCacheNbWpsTimerCounterProgressShow == true then
				if math.floor(tCacheNbWpsTimerCounterProgress / 1000) ~= math.floor(tCacheNbWpsTimerCounter / 1000) then
					tCacheNbWpsTimerCounterProgress = tCacheNbWpsTimerCounter
					print("SkuNav: Caching progress "..math.floor(tCacheNbWpsTimerCounterProgress / 1000).."/"..math.floor(#tCacheNbWpsTimerWpList / 1000))
				end
			end
		end)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:InsertRoute(aRouteName)
	table.insert(SkuOptions.db.profile[MODULE_NAME].Routes, aRouteName)
	--SkuNeighbCache = {}
	if tCacheNbWpsTimer then
		tCacheNbWpsTimer:Cancel()
	end
	CacheNbWps(nil, {aRouteName})
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:InsertRouteWp(aWpTable, aWpName, aPos)
	if aPos then
		table.insert(aWpTable, aPos, aWpName)
	else
		table.insert(aWpTable, aWpName)
	end
	--SkuNeighbCache = {}
	if tCacheNbWpsTimer then
		tCacheNbWpsTimer:Cancel()
	end
	CacheNbWps(nil, nil, aWpTable)
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnInitialize()
	--print("SkuNav OnInitialize")
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
	--print("GetAreaIdFromUiMapId", aUiMapId)
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
	--print("GetAreaIdFromAreaName", aAreaName)
	local rAreaId
	local tPlayerUIMap = SkuNav:GetBestMapForUnit("player")
	for i, v in pairs(SkuDB.InternalAreaTable) do
		if (v.AreaName_lang == aAreaName) and (SkuNav:GetUiMapIdFromAreaId(i) == tPlayerUIMap) then
			rAreaId = i
		end
	end
	--print("  ", tonumber(rAreaId))
	return rAreaId
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAreaData(aAreaId)
	--print("GetAreaData", aAreaId)
	if not SkuDB.InternalAreaTable[aAreaId] then 
		return
	end
	return SkuDB.InternalAreaTable[aAreaId].ZoneName, SkuDB.InternalAreaTable[aAreaId].AreaName_lang, SkuDB.InternalAreaTable[aAreaId].ContinentID, SkuDB.InternalAreaTable[aAreaId].ParentAreaID, SkuDB.InternalAreaTable[aAreaId].Faction, SkuDB.InternalAreaTable[aAreaId].Flags
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetSubAreaIds(aAreaId)
	--print("GetSubAreaIds", aAreaId)
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
	--print("  ", tAreas)
	for i, v in pairs(tAreas) do
		--print("  ", i, v)
	end
	return tAreas
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetCurrentAreaId()
	--print("GetCurrentAreaId")
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
	--print("  ", tAreaId)
	return tAreaId
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetDistanceToWp(aWpName)
	if not SkuNav:GetWaypoint(aWpName) then
		return nil
	end
	local tEndx, tEndy = SkuNav:GetWaypoint(aWpName).worldX, SkuNav:GetWaypoint(aWpName).worldY
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
	if not SkuNav:GetWaypoint(aWpName) then
		return nil
	end
	local x, y = UnitPosition("player")
	return SkuNav:GetDirectionTo(x, y, SkuNav:GetWaypoint(aWpName).worldX, SkuNav:GetWaypoint(aWpName).worldY)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CheckRoute(aRouteName)
	--print("CheckRoute", aRouteName)
	if not SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName] then
		--print(aRouteName, "nicht vorhanden")
		return false
	end

	if sfind(aRouteName, L["quick waypoint"]) or sfind(aRouteName, L["Quick waypoint"]) then
		return false
	end

	if #SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs > 1 then
		for q = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs do
			if sfind(SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q], L["quick waypoint"]) or sfind(SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q], L["Quick waypoint"]) then
				return false
			end

			local tWP = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q])
			if not tWP then
				--print("Check FAIL:", aRouteName, "wegpunkt", SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q], "ist nil")
				return false
			else
				if not tWP.worldX or not tWP.worldY then
					return false
					--print("Check FAIL:", aRouteName, "x y fehlt", tWP.worldX, tWP.worldY, "bei", SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q])
				end
			end
		end
	else
		return false
		--print("Check FAIL:", aRouteName, "valid = false")
	end

	if SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].tEndWPName == SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].tStartWPName and #SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs == 2 then
		return false
	end

	return true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteRoute(aRouteName, aDeleteWPsTo)
	--print("SkuNav:DeleteRoute", aRouteName, SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName])
	if not SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName] then
		return nil
	end
	local tDeleted = false

	for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes do
		if SkuOptions.db.profile[MODULE_NAME].Routes[x] == aRouteName then
			if aDeleteWPsTo == true then
				--delete custom wps in route if they are not used in other routes
				for iWp, vWp in pairs(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]].WPs) do
					if SkuOptions.db.profile[MODULE_NAME].Waypoints[vWp] then
						--this is a custom wp
						local tInOtherRoutes = false
						for z = 1, #SkuOptions.db.profile[MODULE_NAME].Routes do
							if SkuOptions.db.profile[MODULE_NAME].Routes[z] ~= aRouteName then
								local tOtherRt = SkuOptions.db.profile[MODULE_NAME].Routes[z]
								for w = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tOtherRt].WPs do
									if SkuOptions.db.profile[MODULE_NAME].Routes[tOtherRt].WPs[w] == vWp then
										tInOtherRoutes = true
									end
								end
							end
						end

						if tInOtherRoutes == false then
							--this custom wp is not part of any other route > delete
							for q = 1, #SkuOptions.db.profile[MODULE_NAME].Waypoints do
								if SkuOptions.db.profile[MODULE_NAME].Waypoints[q] == vWp then
									SkuOptions.db.profile[MODULE_NAME].Waypoints[SkuOptions.db.profile[MODULE_NAME].Waypoints[q]] = nil
									--print("delete: wp", q, SkuOptions.db.profile[MODULE_NAME].Waypoints[q])
									table.remove(SkuOptions.db.profile[MODULE_NAME].Waypoints, q)
								end
							end
						end
					end
				end
			end
			--delete route
			SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]] = nil
			--print("delete rt: ", x, SkuOptions.db.profile[MODULE_NAME].Routes[x])
			table.remove(SkuOptions.db.profile[MODULE_NAME].Routes, x)
			SkuNeighbCache = {}
			tDeleted = true
		end
	end

	return tDeleted
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:StartRouteRecording(aWPAName, aWPBName, aIntWP, aSize)
	if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeFollowing == true or SkuOptions.db.profile[MODULE_NAME].routeRecording == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Active waypoint or route or recording"], false, true, 0.3, true)
		return
	end

	local tmpWPA = aWPAName
	local tmpWPASize = aSize
	local tmpWPB = aWPBName
	local tmpWPBSize = aSize
	local tmpIntWP = aIntWP

	if tmpWPA == nil then
		SkuOptions.Voice:OutputString(L["Waypoint A missing"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
	end
	if tmpWPB == nil then
		SkuOptions.Voice:OutputString(L["Waypoint B missing"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
	end

	--a/b setup complete
	if tmpWPA and tmpWPB then
		local tIntWPmethod = tmpIntWP or L["Manually"]
		local tWpNameA = tmpWPA
		local tWpNameB = tmpWPB

		tWpNameA = tWpNameA:gsub( ";;", ";")
		if tWpNameA:sub(1, 1) == ";" then tWpNameA = tWpNameA:sub(2) end
		tWpNameB = tWpNameB:gsub( ";;", ";")
		if tWpNameB:sub(1, 1) == ";" then tWpNameB = tWpNameB:sub(2) end

		SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
		SkuOptions.db.profile[MODULE_NAME].routeRecordingSizeOfB = tmpWPBSize
		SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil

		--if a exists lead to a first
		if SkuNav:GetWaypoint(tWpNameA) then
			SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = tWpNameA
			SkuNav:SelectWP(tWpNameA, false)
		else
			--if not add it
			--print("NEW A!!!!")
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
			--print("NEW B!!!!")
			--tWpNameB = "R;"..tWpNameB
			--SkuNav:CreateWaypoint(tWpNameB)
			--print("B neu erstellt", tWpNameB)
		end

		local tRouteName = tWpNameA..";"..L["to"]..";"..tWpNameB
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
		
		--add first wp to route
		SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs, tWpNameA)

		-- start recording
		SkuOptions.db.profile[MODULE_NAME].routeRecording = true
		SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = tRouteName
		SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = tIntWPmethod

		if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
			SkuOptions.Voice:OutputString(L["Recording starts at A"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		elseif SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
			SkuOptions.Voice:OutputString(L["Recording ends at B"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		else
			SkuOptions.Voice:OutputString(L["Recording ends until manually ended"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		end

		SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""

		if _G["OnSkuOptionsMain"]:IsVisible() == true then
			_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
		end

		-- set A to reached
		SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		SkuOptions:VocalizeMultipartString(L["Arrived at Point A"], false, true, 0.3, true)
		SkuOptions:VocalizeMultipartString(L["recording;starts"], false, true, 0.3, true)
		if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
		end
		--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
		SkuNav:SelectWP("", true)
		SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
		--way to b available?
		if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
			SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB, false)
		end

		SkuNav:UpdateRtContinentAndAreaIds(tRouteName)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:EndRouteRecording(aWpBName, aTMPSizeB)
	if SkuOptions.db.profile[MODULE_NAME].routeRecording == false then
		SkuOptions.Voice:OutputString(L["Error"], false, true, 0.3, true)
		SkuOptions.Voice:OutputString(L["Not recording"], false, true, 0.3, true)
		return
	end

	--do we need to update the rt as b was set on completing the recording?
	if string.find(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, L["Set on completion"]) then
		--print("ist Bei Beenden festlegen")
		-- yes > update b wp name and update the route name
		-- aName is the new b name
		local updatedRtName = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute:gsub(L["Set on completion"], aWpBName)
		--print("neue b name", updatedRtName)
		local updatedRtData = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute]
		updatedRtData.tEndWPName = aWpBName
		
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
		SkuOptions.db.profile[MODULE_NAME].routeRecordingSizeOfB = aTMPSizeB or 1
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
		SkuOptions.Voice:OutputString(L["record;corrupted;route;deleted"], false, true, 0.3, true)
	else
		SkuNav:UpdateRtContinentAndAreaIds(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)

		SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		SkuOptions.Voice:OutputString(L["recording;completed;route;created"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
	end

	if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
		SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
	end

	SkuNav:SelectWP("", true)

	local tReturnValue = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute
	--complete
	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = nil

	if _G["OnSkuOptionsMain"]:IsVisible() == true then
		_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
	end
	
	return tReturnValue
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CheckPolyZones(x, y)
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

--------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CreateSkuNavControl()
	local ttimeDegreesChangeInitial = nil
	local ttimeDistanceOutput = 0
	local ttime = GetServerTime()
	local ttimeDraw = GetServerTime()
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

	local f = _G["SkuNavControl"] or CreateFrame("Frame", "SkuNavControl", UIParent)
	f:SetScript("OnUpdate", function(self, time) 
		if SkuOptions.db.profile[MODULE_NAME].enable == true then
 			ttime = ttime + time
			ttimeDraw = ttimeDraw + time

			--rt recording per mouse click stuff
			--[[
			local tMouseOverWpWidget = nil
			for i, v in SkuWaypointWidgetRepo:EnumerateActive() do
				if i:IsMouseOver() then
					tMouseOverWpWidget = i
				end
			end
			]]
			if IsControlKeyDown() == true then
				_G["SkuNavWpDragClickTrap"]:Show()

				if mouse5Down == false then
					if IsMouseButtonDown("Button5") == true then
						mouse5Up = false
						mouse5Down = true
						SkuNav:OnMouse4Down()
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

			--tmp drawing rts on UIParent for debugging
			if ttimeDraw > 0.2 then
				--SkuNav:DrawRoutes(_G["Minimap"])
				SkuNav:DrawAll(_G["Minimap"])
				--SkuNav:DrawRoutes(_G["WorldMapFrame"])
				--SkuNav:DrawRoutes(_G["SkuNavRoutesView"])
				ttimeDraw = 0
			end
			
			SkuWaypointWidgetCurrent = nil
			for i, v in SkuWaypointWidgetRepo:EnumerateActive() do
				if i:IsMouseOver() then
					if i.aText ~= SkuWaypointWidgetCurrent then
						SkuWaypointWidgetCurrent = i.aText

						GameTooltip.SkuWaypointWidgetCurrent = i.aText
						GameTooltip:ClearLines()
						GameTooltip:SetOwner(i, "ANCHOR_RIGHT")
						GameTooltip:AddLine(i.aText, 1, 1, 1)
						GameTooltip:Show()
						i:SetSize(3, 3)
						i.oldColor = i:GetVertexColor()
						i:SetColorTexture(0, 1, 1)
					else
						i:SetSize(2, 2)
						if i.oldColor then
							i:SetColorTexture(i.oldColor)
						end
					end
				end
			end
			
			if SkuWaypointWidgetRepoMM then
				if _G["SkuNavMMMainFrame"]:IsShown() then
					SkuWaypointWidgetCurrent = nil
					for i, v in SkuWaypointWidgetRepoMM:EnumerateActive() do
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
										i.oldColor = i:GetVertexColor()
										i:SetColorTexture(0, 1, 1)
									else
										--i:SetSize(2, 2)
										if i.oldColor then
											i:SetColorTexture(i.oldColor)
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

			if ttime > 0.1 then

				local tPolyZones = CheckPolyZones(UnitPosition("player"))
				if #tPolyZones > 0 then
					local tNewPolyZones = {
						[1] = {[1] = 0,},
						[2] = {[1] = 0,},
						[3] = {[1] = 0, [2] = 0, [3] = 0, [4] = 0,},
						[4] = {[1] = 0,},
					}
					for p = 1, #tPolyZones do
						tNewPolyZones[SkuDB.Polygons.data[tPolyZones[p]].type][SkuDB.Polygons.data[tPolyZones[p]].subtype] = tNewPolyZones[SkuDB.Polygons.data[tPolyZones[p]].type][SkuDB.Polygons.data[tPolyZones[p]].subtype] + 1
					end

					--world
					if tOldPolyZones[1][1] ~= tNewPolyZones[1][1] then
						if tNewPolyZones[1][1] == 0 then
							--print("world left")
							SkuOptions.Voice:OutputString(L["World boundary left"], false, true, nil, true) --aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine
						elseif tOldPolyZones[1][1] == 0 then
							--print("world entered")
							SkuOptions.Voice:OutputString(L["World boundary entered"], false, true, nil, true)
						end
						tOldPolyZones[1][1] = tNewPolyZones[1][1] 
					end
					--fly
					if tOldPolyZones[2][1] ~= tNewPolyZones[2][1] then
						if tNewPolyZones[2][1] == 0 then
							--print("fly left")
							SkuOptions.Voice:OutputString(L["Flight zone left"], false, true, nil, true)
						elseif tOldPolyZones[2][1] == 0 then
							--print("fly entered")
							SkuOptions.Voice:OutputString(L["Flight zone entered"], false, true, nil, true)
						end
						tOldPolyZones[2][1] = tNewPolyZones[2][1] 
					end
					--faction
					if tOldPolyZones[3][1] ~= tNewPolyZones[3][1] then
						if tNewPolyZones[3][1] == 0 then
							--print("alliance left")
							SkuOptions.Voice:OutputString(L["Alliance zone left"], false, true, nil, true)
						elseif tOldPolyZones[3][1] == 0 then
							--print("alliance entered")
							SkuOptions.Voice:OutputString(L["Alliance zone entered"], false, true, nil, true)
						end
						tOldPolyZones[3][1] = tNewPolyZones[3][1] 
					end
					if tOldPolyZones[3][2] ~= tNewPolyZones[3][2] then
						if tNewPolyZones[3][2] == 0 then
							--print("horde left")
							SkuOptions.Voice:OutputString(L["Horde zone left"], false, true, nil, true)
						elseif tOldPolyZones[3][2] == 0 then
							--print("horde entered")
							SkuOptions.Voice:OutputString(L["Horde zone entered"], false, true, nil, true)
						end
						tOldPolyZones[3][2] = tNewPolyZones[3][2] 
					end
					if tOldPolyZones[3][3] ~= tNewPolyZones[3][3] then
						if tNewPolyZones[3][3] == 0 then
							--print("horde left")
							SkuOptions.Voice:OutputString(L["Aldor zone left"], false, true, nil, true)
						elseif tOldPolyZones[3][3] == 0 then
							--print("horde entered")
							SkuOptions.Voice:OutputString(L["Aldor zone entered"], false, true, nil, true)
						end
						tOldPolyZones[3][3] = tNewPolyZones[3][3] 
					end
					if tOldPolyZones[3][4] ~= tNewPolyZones[3][4] then
						if tNewPolyZones[3][4] == 0 then
							--print("horde left")
							SkuOptions.Voice:OutputString(L["Scyer zone left"], false, true, nil, true)
						elseif tOldPolyZones[3][4] == 0 then
							--print("horde entered")
							SkuOptions.Voice:OutputString(L["Scyer zone entered"], false, true, nil, true)
						end
						tOldPolyZones[3][4] = tNewPolyZones[3][4] 
					end

					--other
					if tOldPolyZones[4][1] ~= tNewPolyZones[4][1] then
						if tNewPolyZones[4][1] == 0 then
							--print("other left")
							SkuOptions.Voice:OutputString("Wer das hört ist doof verlassen", false, true, nil, true)
						elseif tOldPolyZones[4][1] == 0 then
							--print("other entered")
							SkuOptions.Voice:OutputString("Wer das hört ist doof betreten", false, true, nil, true)
						end
						tOldPolyZones[4][1] = tNewPolyZones[4][1] 
					end
				end

				--dead
				if UnitIsGhost("player") then
					if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == "" then
						local tUiMap = SkuNav:GetBestMapForUnit("player")
						if tUiMap then
							local tCorpse = C_DeathInfo.GetCorpseMapPosition(tUiMap)
							if tCorpse then
								local cX, cY = tCorpse:GetXY()
								local tmapPos = CreateVector2D(cX, cY)
								local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetBestMapForUnit("player"), tmapPos)
								local tX, tY = worldPosition:GetXY()

								local tPlayerx, tPlayery = UnitPosition("player")
								local distance = SkuNav:Distance(tPlayerx, tPlayery, tX, tY)

								if distance > 10 then
									if SkuNav:GetWaypoint(L["Quick waypoint"]..";4") then
										SkuNav:GetWaypoint(L["Quick waypoint"]..";4").worldX = tX
										SkuNav:GetWaypoint(L["Quick waypoint"]..";4").worldY = tY								
										local tAreaId = SkuNav:GetCurrentAreaId()
										SkuNav:GetWaypoint(L["Quick waypoint"]..";4").areaId = tAreaId
										SkuNav:SelectWP(L["Quick waypoint"]..";4", true)

										SkuOptions.Voice:OutputString(L["Quick waypoint 4 set to corpse"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
									end
								end
							end
						end
					end
				end

				--global direction
				local tText = UnitPosition("player")
				if tText then
					if IsShiftKeyDown() and IsAltKeyDown() then
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

				--output direction and distance to wp if wp selected
				if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
					if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
						local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						if distance then
							if IsControlKeyDown() and IsAltKeyDown() then
								if GetServerTime() - ttimeDistanceOutput > 0.2 then
									ttimeDistanceOutput = GetServerTime()
									local tDirection = SkuNav:GetDirectionToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
									if SkuOptions.db.profile[MODULE_NAME].vocalizeFullDirectionDistance == true then
										SkuOptions.Voice:OutputString(string.format("%02d", tDirection)..";"..L["Clock"], true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
										SkuOptions.Voice:OutputString(distance..";"..L["Meter"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
									else
										SkuOptions.Voice:OutputString(string.format("%02d", tDirection), true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
										SkuOptions.Voice:OutputString(distance, false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
									end
								end
							end
						end
					end
				end

				--check for reaching wps
				if SkuOptions.db.profile[MODULE_NAME].routeRecording ~= true and SkuOptions.db.profile[MODULE_NAME].routeFollowing ~= true  and SkuOptions.db.profile[MODULE_NAME].metapathFollowing ~= true then
					--we're not recording or following a rt; just a single wp
					if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						local tWpObject = SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
						if tWpObject then
							--not rt recording/following, just a single wp
							local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
							if distance then
								if distance < SkuNavWpSize[tWpObject.size] and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
									SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
									SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
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
					--we're recording or following a rt
					--if UnitIsGhost("player") == false then

						--we are recording a rt
						if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
							if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA or SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
								if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
									--we're on the way to a
									local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
									if distance then
										if distance < 2 then
											--a reached; start actual recording
											SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											SkuOptions:VocalizeMultipartString(L["Arrived at Point A"], false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString(L["recording;starts"], false, true, 0.3, true)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
											SkuNav:SelectWP("", true)
											SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
											--way to b available?
											if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
												SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB, false)
											end
										end
									end
								elseif SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
									--we're on the way to b
									local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
									if distance then
										if distance < 2 then
											--b reached; complete rt, clean-up, stop recording
											SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB)

											--check rt if valid
											if SkuNav:CheckRoute(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute) ~= true then
												SkuNav:DeleteRoute(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
												SkuOptions.Voice:OutputString(L["failure"], true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
												SkuOptions.Voice:OutputString(L["Arrived at Point B"], false, true, 0.3, true)
												SkuOptions.Voice:OutputString(L["record;corrupted;route;deleted"], false, true, 0.3, true)
											else
												SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
												SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
												if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
													SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
												end
												SkuOptions.Voice:OutputString(L["Arrived at Point B"], false, true, 0.3, true)
												SkuOptions.Voice:OutputString(L["recording;completed;route;created"], false, true, 0.3, true)
											end

											--complete
											SkuOptions.db.profile[MODULE_NAME].routeRecording = false
											SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = nil
											SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
											SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil
											SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = nil
											--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
											SkuNav:SelectWP("", true)

										end
									end
								end
							end
							if SkuOptions.db.profile[MODULE_NAME].routeRecording == true and not SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
								if SkuOptions.db.profile["SkuNav"].routeRecordingIntWPMethod ~= L["Manually"] then
									local tNearbyWpReplaceMinRange = SkuNav.routeRecordingIntWpMethods.values[SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod].dist / 3
									--check if wp of other routes nearby
									local tLastWP = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs]
									local tPrevWPx = SkuNav:GetWaypoint(tLastWP).worldX
									local tPrevWPy = SkuNav:GetWaypoint(tLastWP).worldY
									local x, y = UnitPosition("player")
									local tDist = SkuNav:Distance(tPrevWPx, tPrevWPy, x, y)

									local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToPlayer()
									local tIntersectWithRt, tIntersectWithRtWp1, tIntersectWithRtWp2, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY = SkuNav:GetCurrentRouteSectionIntersection(tPrevWPx, tPrevWPy, x, y)

									if (tReplacementWp and tReplacementWpRange <= tNearbyWpReplaceMinRange and tLastWP ~= tReplacementWp) and IsLeftAltKeyDown() == true then
										--print("wp nearby", tReplacementWp)
										-- wp is nearby > use nearby wp
										SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
										SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
									elseif (tIntersectWithRt and SkuNav:Distance(tPrevWPx, tPrevWPy, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY) > 2)  and IsLeftAltKeyDown() == true then
										-- there's an intersection > add new wp and update current and intersecting rt
										local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToCoords(tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
										if tReplacementWp and tReplacementWpRange and tReplacementWpRange < tNearbyWpReplaceMinRange then
											SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
										else
											--update for current route
											local tIntWP = SkuNav:CreateWaypoint(nil, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
											SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)

											--update other rt
											for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs do
												if SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs[x] == tIntersectWithRtWp1 then
													--print(" INSERT")
													SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, tIntWP, x+1)
													break
												end
											end
										end
										SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)

									else
										--nothing nearby, no intersection
										--check/create next auto int wp
										local tCurrentRouteName = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute
										local tMaxDiff = SkuNav.routeRecordingIntWpMethods.values[SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod].rot
										local tMinDist = SkuNav.routeRecordingIntWpMethods.values[SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod].dist

										local x, y = UnitPosition("player")
										local _, _, tDegreesFinal = SkuNav:GetDirectionTo(x, y, 30000, y)
										if not ttimeDegreesChangeInitial then
											ttimeDegreesChangeInitial = tDegreesFinal
										end
										local tDiff = ttimeDegreesChangeInitial - tDegreesFinal
										if tDiff < -180 then
											tDiff = 360 + tDiff
										elseif tDiff > 180 then
											tDiff = (360 - tDiff) * -1
										end
										local tLastWP = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs]
										local tPrevWPx = SkuNav:GetWaypoint(tLastWP).worldX
										local tPrevWPy = SkuNav:GetWaypoint(tLastWP).worldY
										local tDist = SkuNav:Distance(tPrevWPx, tPrevWPy, x, y)

										local tDynDist = 0
										if tDiff < 0 then
											tDynDist = ((tDiff * -1) + tDist) / 2
										else
											tDynDist = ((tDiff) + tDist) / 2
										end

										if tdiold ~= tDiff or tdisold ~= tDist then
											--print("°:", tDiff, "d:", tDist, "dd:", tDynDist)
											tdiold = tDiff
											tdisold = tDist
										end

										--if (tDiff > tMaxDiff or tDiff < (-tMaxDiff)) and (tDist > tMinDist) then
										if tDynDist > tMinDist and tDist > (tMinDist / 3) then
											--print("next auto")
											ttimeDegreesChangeInitial = tDegreesFinal
											local tIntWP = SkuNav:CreateWaypoint()
											SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
											SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
										end
									end
								end
							end

						--we are following a rt
						elseif SkuOptions.db.profile[MODULE_NAME].selectedWaypoint and SkuOptions.db.profile[MODULE_NAME].routeFollowing == true then
							--following a single rt
							if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
								local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) or 0
								if distance then
									local tDistanceMod = 0
									if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange == true then
										tDistanceMod = 3
									end
									if ((distance < SkuNavWpSize[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size] + tDistanceMod) or SkuNav.MoveToWp ~= 0)  and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
										local tNextWPNr
										if SkuNav.MoveToWp ~= 0 then
											tNextWPNr = SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP + SkuNav.MoveToWp
											if tNextWPNr > #SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs then
												tNextWPNr = #SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs
											end
											if tNextWPNr < 1  then
												tNextWPNr = 1
											end
										else
											tNextWPNr = SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP + SkuOptions.db.profile[MODULE_NAME].routeFollowingUpDown
										end
										if SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs[tNextWPNr] then
											SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											SkuOptions.Voice:OutputString(L["still"]";"..(#SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs - tNextWPNr + 1), true, true)

											SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs[tNextWPNr], true)
											SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = tNextWPNr
										else
											SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											--SkuOptions:VocalizeMultipartString("Ziel erreicht;"..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString(L["Arrived at target"]..";", false, true, 0.3, true)
											SkuOptions.db.profile[MODULE_NAME].routeFollowing = false
											SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = nil
											SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = nil
											SkuOptions.db.profile[MODULE_NAME].routeFollowingUpDown = nil
											SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = nil
											--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
											SkuNav:SelectWP("", true)
										end
									end
								end
							end

						--we're following a meta rt
						elseif SkuOptions.db.profile[MODULE_NAME].selectedWaypoint and SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true then
							if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
								local distance = SkuNav:GetDistanceToWp(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) or 0
								if distance then
									--print("size:", SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size)
									--print(SkuNavWpSize[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size])
									local tDistanceMod = 0
									if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange == true then
										tDistanceMod = 3
									end
									if ((distance < SkuNavWpSize[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size] + tDistanceMod) or SkuNav.MoveToWp ~= 0) and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
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
											SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											SkuOptions.Voice:OutputString(L["still"]..";"..(#SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps - tNextWPNr + 1), true, true)

											SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[tNextWPNr], true)
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = tNextWPNr
										else
											SkuOptions.Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											--SkuOptions:VocalizeMultipartString("Ziel erreicht;"..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString(L["Arrived at target"]..";", false, true, 0.3, true)

											SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = nil
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = nil
											--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
											SkuNav:SelectWP("", true)
										end
									end
								end
							end
						end
					--end
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
		if a == "CTRL-SHIFT-R" then
			SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap = SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true
		end
		if a == "CTRL-SHIFT-F" then
			SkuOptions.db.profile[MODULE_NAME].showSkuMM = SkuOptions.db.profile[MODULE_NAME].showSkuMM == false
			SkuNav:SkuNavMMOpen()
		end

		if a == "CTRL-SHIFT-Q" then
			if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange == false then
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = true
				SkuOptions:VocalizeMultipartString(L["Accuracy three meters"], true, true, 0.3, true)
			else
				SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = false
				SkuOptions:VocalizeMultipartString(L["Accuracy one meter"], true, true, 0.3, true)
			end
		end

		--move to prev/next wp on following a rt
		if a == "CTRL-SHIFT-W" then
			SkuNav.MoveToWp = 1
		end
		if a == "CTRL-SHIFT-S" then
			SkuNav.MoveToWp = -1
		end

		if a == "CTRL-SHIFT-U" then
			local tWpName
			local tTargetName = UnitName("target")
			if tTargetName then
				local tPlayerPosX, tPlayerPosY = UnitPosition("player")
				local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
				local tAreaId = SkuNav:GetCurrentAreaId()
				local tReplacementWp = nil
				local tReplacementWpX = nil
				local tReplacementWpY = nil
				local tReplacementWpRange = 100000
				local tNearbyWpReplaceMaxRange = 50

				for i, v in pairs(SkuDB.NpcData.NamesDE) do
					if SkuDB.NpcData.Data[i] then
						if tTargetName == v[1] then
							local tSpawns = SkuDB.NpcData.Data[i][7]
							if tSpawns then
								for is, vs in pairs(tSpawns) do
									local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
									--we don't care for stuff that isn't in the open world
									if isUiMap then
										local tData = SkuDB.InternalAreaTable[is]
										if tData then
											if tPlayerContinentID == tData.ContinentID then
												if SkuNav:GetUiMapIdFromAreaId(tAreaId) == isUiMap then
													local tNumberOfSpawns = #vs
													if tNumberOfSpawns > 0 then
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
															local tContintentId = select(3, SkuNav:GetAreaData(is))
															local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(vs[sp][1] / 100, vs[sp][2] / 100))
															local tX, tY = worldPosition:GetXY()
		
															local tDistance  = SkuNav:Distance(tPlayerPosX, tPlayerPosY, tX, tY)
															if tDistance < tReplacementWpRange and tDistance < tNearbyWpReplaceMaxRange then
																tReplacementWp = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
																tReplacementWpX = tX
																tReplacementWpY = tY
																tReplacementWpRange = tDistance
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

				if tReplacementWp then
					tWpName = tReplacementWp
				else
					print(tTargetName..": "..L["Error or too far away (maximum 50 meters)"])
					return
				end
			else
				tWpName = nil
				return
			end

			if tWpName then
				local tOldWpObj = SkuNav:GetWaypoint(tWpName)
				if not tOldWpObj then
					local tNewWpName = SkuNav:CreateWaypoint(tWpName, tReplacementWpX, tReplacementWpY, nil, true)
					print(tWpName.." "..L["added"])
				else
					print(tWpName.." "..L["already exists"])
				end
			end
		end

		if a == "CTRL-SHIFT-I" then
			if mouseMiddleDown == false then
				mouseMiddleUp = false
				mouseMiddleDown = true
				SkuNav:OnMouseMiddleDown()
				SkuNav:OnMouseMiddleHold()
				mouseMiddleDown = false
				mouseMiddleUp = true
				SkuNav:OnMouseMiddleUp(true)
			end
		end

		--add manual int wp on rt recording
		if a == "CTRL-SHIFT-P" or a == "CTRL-SHIFT-O" then
			if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
				if not SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
					local tWpSize = 1
					if a == "CTRL-SHIFT-O" then
						tWpSize = 5
					end
					--print("inser intWP")
					local tNearbyWpReplaceMinRange = 3
					--check if wp of other routes nearby
					local tLastWP = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs]
					local tPrevWPx = SkuNav:GetWaypoint(tLastWP).worldX
					local tPrevWPy = SkuNav:GetWaypoint(tLastWP).worldY
					local x, y = UnitPosition("player")
					local tDist = SkuNav:Distance(tPrevWPx, tPrevWPy, x, y)

					local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToPlayer()
					local tIntersectWithRt, tIntersectWithRtWp1, tIntersectWithRtWp2, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY = SkuNav:GetCurrentRouteSectionIntersection(tPrevWPx, tPrevWPy, x, y)

					if (tReplacementWp and tReplacementWpRange <= tNearbyWpReplaceMinRange and tLastWP ~= tReplacementWp) and IsLeftAltKeyDown() == true then
						--print("wp nearby", tReplacementWp)
						SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
						SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
					elseif (tIntersectWithRt and SkuNav:Distance(tPrevWPx, tPrevWPy, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY) > 2) and IsLeftAltKeyDown() == true then
						--print("IS", tIntersectWithRt, tIntersectWithRtWp1, tIntersectWithRtWp2, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
						local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToCoords(tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
						if tReplacementWp and tReplacementWpRange and tReplacementWpRange < tNearbyWpReplaceMinRange then
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
						else
							--update for current route
							local tIntWP = SkuNav:CreateWaypoint(nil, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)

							--update other rt
							for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs do
								if SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs[x] == tIntersectWithRtWp1 then
									SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, tIntWP, x+1)
									break
								end
							end
						end
						local tIntWP = SkuNav:CreateWaypoint(nil, nil, nil, tWpSize)
						SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
						SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
					else
						--print("nothing")
						local tIntWP = SkuNav:CreateWaypoint(nil, nil, nil, tWpSize)
						SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
						SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
					end

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
			SkuNav:UpdateWP(L["Quick waypoint"]..";1")
		end
		if a == "SHIFT-F6" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";2")
		end
		if a == "CTRL-SHIFT-F6" then
			SkuNav:UpdateWP(L["Quick waypoint"]..";2")
		end		
		if a == "SHIFT-F7" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";3")
		end
		if a == "CTRL-SHIFT-F7" then
			SkuNav:UpdateWP(L["Quick waypoint"]..";3")
		end		
		if a == "SHIFT-F8" then
			SkuNav:EndFollowingWpOrRt()
			SkuNav:SelectWP(L["Quick waypoint"]..";4")
		end
		if a == "CTRL-SHIFT-F8" then
			SkuNav:UpdateWP(L["Quick waypoint"]..";4")
		end		
		
	end)
	tFrame:Hide()
	
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-F", tFrame:GetName(), "CTRL-SHIFT-F")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-U", tFrame:GetName(), "CTRL-SHIFT-U")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-I", tFrame:GetName(), "CTRL-SHIFT-I")
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
	--print("SkuNav OnEnable")
	if not SkuOptions.db.profile[MODULE_NAME].Waypoints then
		SkuOptions.db.profile[MODULE_NAME].Waypoints = {}
		for x = 1, 4 do
			local tWaypointName = L["Quick waypoint"]..";"..x
			if not SkuNav:GetWaypoint(tWaypointName) then
				--insert
				local tAreaId =SkuNav:GetCurrentAreaId()
	
				local worldx, worldy = UnitPosition("player")
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, tWaypointName)
				SkuNav:SetWaypoint(tWaypointName, {
					["contintentId"] = tPlayerContintentId,
					["areaId"] = tAreaId,
					["worldX"] = worldx,
					["worldY"] = worldy,
					["createdAt"] = GetTime(), 
					["createdBy"] = "SkuNav",
					["size"] = 1,
				})
			else
				--reset
				local worldx, worldy = UnitPosition("player")
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				--table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, tWaypointName)
				SkuNav:SetWaypoint(tWaypointName, {
					["contintentId"] = tPlayerContintentId,
					["areaId"] = nil,
					["worldX"] = worldx,
					["worldY"] = worldy,
					["createdAt"] = GetTime(), 
					["createdBy"] = "SkuNav",
					["size"] = 1,
				})
			end
		end		
	end
	if not SkuOptions.db.profile[MODULE_NAME].Routes then
		SkuOptions.db.profile[MODULE_NAME].Routes = {}
	end
	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB = nil
	SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = nil

	--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
	SkuNav:SelectWP("", true)
	if not SkuOptions.db.profile[MODULE_NAME].RecentWPs then
		SkuOptions.db.profile[MODULE_NAME].RecentWPs = {}
	end

	--check and update all rts for continent id and areaids
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		SkuNav:UpdateRtContinentAndAreaIds(v)
	end

	SkuNav:SkuNavMMOpen()

	SkuNav:CreateSkuNavControl()

	if SkuCore.inCombat == false then
		SkuNav:CreateSkuNavMain()		
	end

	--cache meta rt stuff
	SkuNeighbCache = {}
	if tCacheNbWpsTimer then
		tCacheNbWpsTimer:Cancel()
	end
	C_Timer.After(60, function()
		CacheNbWps(20)
	end)
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
function SkuNav:OnMouseLeftDown()
	--print("L down")
	local tWpName = SkuWaypointWidgetCurrent--GetMouseFocus().aText or GetMouseFocus().WpName
	if tWpName then
		local wpObj = SkuNav:GetWaypoint(tWpName)
		if wpObj then
			if SkuOptions.db.profile[MODULE_NAME].Waypoints[tWpName] then
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
		local wpObj = SkuNav:GetWaypoint(tCurrentDragWpName)
		if wpObj then
			wpObj.tDragY, wpObj.tDragX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
			if wpObj.tDragX then
				if SkuOptions.db.profile[MODULE_NAME].Waypoints[tCurrentDragWpName] then
					wpObj.worldX, wpObj.worldY = wpObj.tDragX, wpObj.tDragY
				else
					--standard wp
					--create new custom wp
					tCurrentDragWpName = SkuNav:CreateWaypoint(tCurrentDragWpName, wpObj.tDragX, wpObj.tDragY, nil, true)
					wpObj = SkuNav:GetWaypoint(tCurrentDragWpName)
					wpObj.worldX, wpObj.worldY = wpObj.tDragX, wpObj.tDragY
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseLeftUp()
	--print("L up")
	if tCurrentDragWpName then
		local wpObj = SkuNav:GetWaypoint(tCurrentDragWpName)
		if wpObj then
			if wpObj.tDragX then
				if SkuOptions.db.profile[MODULE_NAME].Waypoints[tCurrentDragWpName] then
					wpObj.worldX, wpObj.worldY = wpObj.tDragX, wpObj.tDragY

					--SkuNeighbCache = {}
					if tCacheNbWpsTimer then
						tCacheNbWpsTimer:Cancel()
					end
					CacheNbWps(nil, nil, {tCurrentDragWpName})					
				end
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
	--print("R up")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseRightHold()
	--print("R hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseRightUp()
	--print("R up")
	if SkuNavRecordingPoly > 0 and SkuNavRecordingPolyFor then
		local tWorldY, tWorldX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
		SkuDB.Polygons.data[SkuNavRecordingPolyFor].nodes[#SkuDB.Polygons.data[SkuNavRecordingPolyFor].nodes + 1] = {x = tWorldX, y = tWorldY,}
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Down()
	--print("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Hold()
	--print("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse4Up(aUseTarget)
	local tWy, tWx = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
	
	if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
		if not SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
			local tWpSize = 1
			if IsShiftKeyDown() then
				tWpSize = 5
			end
			local tNearbyWpReplaceMinRange = 3
			local tLastWP = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs]
			local tPrevWPx = SkuNav:GetWaypoint(tLastWP).worldX
			local tPrevWPy = SkuNav:GetWaypoint(tLastWP).worldY

			local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToPlayer()
			local tIntersectWithRt, tIntersectWithRtWp1, tIntersectWithRtWp2, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY = SkuNav:GetCurrentRouteSectionIntersection(tPrevWPx, tPrevWPy,tWy, tWx)

			if (tReplacementWp and tReplacementWpRange <= tNearbyWpReplaceMinRange and tLastWP ~= tReplacementWp) and IsLeftAltKeyDown() == true then
				--print("wp nearby", tReplacementWp)
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
				SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
			elseif (tIntersectWithRt and SkuNav:Distance(tPrevWPx, tPrevWPy, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY) > 2) and IsLeftAltKeyDown() == true then
				--print("IS", tIntersectWithRt, tIntersectWithRtWp1, tIntersectWithRtWp2, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
				local tReplacementWp, tReplacementWpRange = SkuNav:GetNearestWpToCoords(tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
				if tReplacementWp and tReplacementWpRange and tReplacementWpRange < tNearbyWpReplaceMinRange then
					SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tReplacementWp)
				else
					--update for current route
					local tIntWP = SkuNav:CreateWaypoint(nil, tIntersectWithRtIntersectionX, tIntersectWithRtIntersectionY)
					SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)

					--update other rt
					for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs do
						if SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs[x] == tIntersectWithRtWp1 then
							--print(" INSERT")
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, tIntWP, x+1)
							break
						end
					end
				end
				local tIntWP = SkuNav:CreateWaypoint(nil, tWx, tWy, tWpSize)
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
				SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
			else
				--print("nothing")
				local tIntWP = SkuNav:CreateWaypoint(nil, tWx, tWy, tWpSize)
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
				SkuOptions:VocalizeMultipartString(L["WP created"], false, true, 0.3, true)
			end

		end
	end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleDown()
	--print("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleHold()
	--print("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouseMiddleUp(aUseTarget)
	--print("M up", aUseTarget)

	if IsShiftKeyDown() then
		local tWpName = SkuWaypointWidgetCurrent
		if tWpName then
			local wpObj = SkuNav:GetWaypoint(tWpName)
			if wpObj then
				if SkuOptions.db.profile[MODULE_NAME].Waypoints[tWpName] then
					SkuOptions.db.profile[MODULE_NAME].Waypoints[tWpName].comments = nil
				end
			end
		end
		return
	end

	local tWpName = SkuWaypointWidgetCurrent--GetMouseFocus().aText or GetMouseFocus().WpName
	if aUseTarget then
		local tTargetName = UnitName("target")
		if tTargetName then
			local tPlayerPosX, tPlayerPosY = UnitPosition("player")
			local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
			local tAreaId = SkuNav:GetCurrentAreaId()
			local tReplacementWp = nil
			local tReplacementWpX = nil
			local tReplacementWpY = nil
			local tReplacementWpRange = 100000
			local tNearbyWpReplaceMaxRange = 50

			for i, v in pairs(SkuDB.NpcData.NamesDE) do
				if SkuDB.NpcData.Data[i] then
					if tTargetName == v[1] then
						local tSpawns = SkuDB.NpcData.Data[i][7]
						if tSpawns then
							for is, vs in pairs(tSpawns) do
								local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
								--we don't care for stuff that isn't in the open world
								if isUiMap then
									local tData = SkuDB.InternalAreaTable[is]
									if tData then
										if tPlayerContinentID == tData.ContinentID then
											if SkuNav:GetUiMapIdFromAreaId(tAreaId) == isUiMap then
												local tNumberOfSpawns = #vs
												if tNumberOfSpawns > 0 then
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
														local tContintentId = select(3, SkuNav:GetAreaData(is))
														local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(vs[sp][1] / 100, vs[sp][2] / 100))
														local tX, tY = worldPosition:GetXY()
	
														local tDistance  = SkuNav:Distance(tPlayerPosX, tPlayerPosY, tX, tY)
														if tDistance < tReplacementWpRange and tDistance < tNearbyWpReplaceMaxRange then
															tReplacementWp = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
															tReplacementWpX = tX
															tReplacementWpY = tY
															tReplacementWpRange = tDistance
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

			if tReplacementWp then
				tWpName = tReplacementWp
			else
				print(tTargetName..": "..L["Error or too far away (maximum 50 meters)"])
				return
			end
		else
			tWpName = nil
			return
		end
	end
	if tWpName then
		local wpObj = SkuNav:GetWaypoint(tWpName)
		if wpObj then
			--wp selected on mm -> use that one
			if SkuOptions.db.profile[MODULE_NAME].routeRecording ~= true then
				SkuNav:StartRouteRecording(tWpName, L["Set on completion"], L["Manually"], 1)
				print("Start:", SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
			else
				print("End:", SkuNav:EndRouteRecording(tWpName, 1))
			end
		end
	else
		--no selected wp -> use the nearest one
		local x, y = UnitPosition("player")
		local tNearbyWpReplaceMinRange = 10

		if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
			local tWpsInCurrentRoute = {}
			for i1, v1 in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs) do
				tWpsInCurrentRoute[v1] = v1
			end

			local tAreaId = SkuNav:GetCurrentAreaId()
			local tReplacementWp = nil
			local tReplacementWpRange = 100000
			for i, v in SkuNav:ListWaypoints(false, nil, tAreaId, nil, nil) do
				if not tWpsInCurrentRoute[v] then
					local tWpToCheck = SkuNav:GetWaypoint(v)
					if tWpToCheck then
						local tWpX, tWpY = tWpToCheck.worldX, tWpToCheck.worldY
						local tDistance  = SkuNav:Distance(x, y, tWpX, tWpY)
						if tDistance < tReplacementWpRange and tDistance < tNearbyWpReplaceMinRange then
							tReplacementWp = v
							tReplacementWpRange = tDistance
						end
					else
						return
					end
				end
			end
			if tReplacementWp then
				print(L["End"]..":", SkuNav:EndRouteRecording(tReplacementWp, 1))
			end
		else
			local tAreaId = SkuNav:GetCurrentAreaId()
			local tReplacementWp = nil
			local tReplacementWpRange = 100000
			for i, v in SkuNav:ListWaypoints(false, nil, tAreaId, nil, nil) do
				local tWpToCheck = SkuNav:GetWaypoint(v)
				if tWpToCheck then
					local tWpX, tWpY = tWpToCheck.worldX, tWpToCheck.worldY
					local tDistance  = SkuNav:Distance(x, y, tWpX, tWpY)
					if tDistance < tReplacementWpRange and tDistance < tNearbyWpReplaceMinRange then
						tReplacementWp = v
						tReplacementWpRange = tDistance
					end
				else
					return
				end
			end
			if tReplacementWp then
				SkuNav:StartRouteRecording(tReplacementWp, L["Set on completion"], L["Manually"], 1)
				print(L["Start"]..":", SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Down()
	--print("M down")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Hold()
	--print("M hold")

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:OnMouse5Up()
	--print("R up")
	if SkuWaypointWidgetCurrent then
		local wpObj = SkuNav:GetWaypoint(SkuWaypointWidgetCurrent)
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
function SkuNav:GetCurrentRouteSectionIntersection(aPrevWPx, aPrevWPy, aX, aY)
	local rIntersectWithRt = nil
	local rIntersectWithRtWp1 = nil
	local rIntersectWithRtWp2 = nil
	local rIntersectWithRtIntersectionX = nil
	local rIntersectWithRtIntersectionY = nil

	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		--ignore current rt that we're currently recording for
		if v ~= SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute then
			if SkuNav:CheckRoute(v) == true then
				local i1Old, v1Old
				for i1, v1 in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs) do
					if i1Old and v1Old then
						local tWpToCheckA = SkuNav:GetWaypoint(v1Old)
						local tWpAX, tWpAY = tWpToCheckA.worldX, tWpToCheckA.worldY
						local tWpToCheckB = SkuNav:GetWaypoint(v1)
						local tWpBX, tWpBY = tWpToCheckB.worldX, tWpToCheckB.worldY

						local tIntersectionX, tIntersectionY, tUa = SkuNav:IntersectionPoint(aPrevWPx, aPrevWPy, aX, aY, tWpAX, tWpAY, tWpBX, tWpBY)
						if tIntersectionX then
							rIntersectWithRt = v
							rIntersectWithRtWp1 = v1Old
							rIntersectWithRtWp2 = v1
							rIntersectWithRtIntersectionX = tIntersectionX
							rIntersectWithRtIntersectionY = tIntersectionY
						end
					end
					i1Old, v1Old = i1, v1
				end
			end
		end
	end

	return rIntersectWithRt, rIntersectWithRtWp1, rIntersectWithRtWp2, rIntersectWithRtIntersectionX, rIntersectWithRtIntersectionY
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetNearestWpToCoords(aX, aY)
	local tNearbyWpReplaceMinRange = 2
	local tReplacementWp = nil
	local tReplacementWpRange = 100000
	--check if wp of other routes nearby
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		--ignore current rt that we're currently recording for
		if v ~= SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute then
			if SkuNav:CheckRoute(v) == true then
				for i1, v1 in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs) do
					local tWpToCheck = SkuNav:GetWaypoint(v1)
					local tWpX, tWpY = tWpToCheck.worldX, tWpToCheck.worldY
					local tPlayX, tPlayY = aX, aY
					local tDistance  = SkuNav:Distance(tPlayX, tPlayY, tWpX, tWpY)

					if tDistance < tReplacementWpRange then
							tReplacementWp = v1
							tReplacementWpRange = tDistance
					end
				end
			end
		end
	end
	return tReplacementWp, tReplacementWpRange
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetNearestWpToPlayer()
	local tPlayX, tPlayY = UnitPosition("player")
	return SkuNav:GetNearestWpToCoords(tPlayX, tPlayY)
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aX number
---@param aY number
---@param aRange number
function SkuNav:GetAllRoutesInRangeToCoords(aX, aY, aRange)
	--print("GetAllRoutesInRangeToCoords")

	local tNearbyWpReplaceMinRange = 2
	local tFoundWps = {}

	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tPlayerUIMapId = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId()) or SkuNav:GetCurrentAreaId()

	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		if SkuOptions.db.profile[MODULE_NAME].Routes[v].tContinentId == tPlayerContinentID then
			if SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds[tPlayerUIMapId] then			
				--ignore current rt that we're currently recording for
				local tNearestWp = nil
				local tNearestWpRange = 100000
				if SkuNav:CheckRoute(v) == true then
					for i1, v1 in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs) do
						if not sfind(v1, L["Quick waypoint"]) then
							local tWpToCheck = SkuNav:GetWaypoint(v1)
							if tWpToCheck.contintentId == tPlayerContinentID then
								local tWpX, tWpY = tWpToCheck.worldX, tWpToCheck.worldY
								local tDistance  = SkuNav:Distance(aX, aY, tWpX, tWpY)

								if tDistance and tNearestWpRange and aRange then
									if tDistance < tNearestWpRange and tDistance < aRange then
										tNearestWp = v1
										tNearestWpRange = tDistance
									end
								end
							end
						end
					end
					if tNearestWpRange < 100000 then
						if not tFoundWps[v] then
							tFoundWps[v] = {["nearestWP"] = tNearestWp, ["nearestWpRange"] = tNearestWpRange}
						end
					end
				end
			end
		end
	end

	return tFoundWps
end

---------------------------------------------------------------------------------------------------------------------------------------
function GetNeighbToWp(aWpName, aTicker)
	if not aTicker then
		if tCacheNbWpsTimer then
			tCacheNbWpsTimer:Cancel()
			tCacheNbWpsTimer = nil
			--print("SkuNav: Caching stopped")
		end
	end

	if SkuNeighbCache[aWpName] then
		return SkuNeighbCache[aWpName]
	end
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tUIMap = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())

	local tFoundNeighb = {}

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

	return tFoundNeighb
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAllMetaTargetsFromWp2(aWpName)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tPlayerUIMapId = SkuNav:GetUiMapIdFromAreaId(SkuNav:GetCurrentAreaId())


	local tF = sfind(aWpName, L["Meter"].."#")
	if tF then	
		aWpName = string.sub(aWpName, tF + string.len(L["Meter"].."#"))
	end

	local rMetapathData = {}

	local tCurrentNumber = 1
	local tFoundNbList = {}

	tFoundNbList[aWpName] = {from = "", number = tCurrentNumber,}

	local tToCheckList = {}
	tToCheckList[#tToCheckList + 1] = aWpName


	while #tToCheckList > 0 do
		tCurrentNumber = tCurrentNumber + 1
		local tLocalToCheckList = {}
		for x = 1, #tToCheckList do
			local tNeib = GetNeighbToWp(tToCheckList[x])
			for i, v in pairs(tNeib) do
				if not tFoundNbList[v] then
					tLocalToCheckList[#tLocalToCheckList + 1] = v
					tFoundNbList[v] = {from = tToCheckList[x], number = tCurrentNumber,}
				end
			end
		end
		tToCheckList = tLocalToCheckList
	end

	--collect all valid end wps to test
	local tEndWps = {}
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		if SkuOptions.db.profile[MODULE_NAME].Routes[v].tContinentId == tPlayerContinentID then
			if SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds[tPlayerUIMapId] then
				if aWpName ~= SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1] then
					if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1], L["auto"]) then
						tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]
					end
				end
				if aWpName ~= SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs] then
					if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs], L["auto"]) then
						tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]
					end
				end
			end
		end
	end

	for x = 1, #tEndWps do
		if tFoundNbList[tEndWps[x]] then
			rMetapathData[#rMetapathData+1] = tEndWps[x]
			rMetapathData[tEndWps[x]] = {
				pathWps = {},
				distance = 0,
			}

			local tOut = false
			local tCurrentWp = tEndWps[x]
			while tOut == false do
				table.insert(rMetapathData[tEndWps[x]].pathWps, 1, tCurrentWp)
				tCurrentWp = tFoundNbList[tCurrentWp].from
				if tCurrentWp == "" then
					tOut = true
				end
			end

			local tDistance = 0
			local tDistanceToStartWp = 0
			for z = 2, #rMetapathData[tEndWps[x]].pathWps do
				local tWpA = SkuNav:GetWaypoint(rMetapathData[tEndWps[x]].pathWps[z - 1])
				local tWpB = SkuNav:GetWaypoint(rMetapathData[tEndWps[x]].pathWps[z])
				tDistance = tDistance + SkuNav:Distance(tWpA.worldX, tWpA.worldY, tWpB.worldX, tWpB.worldY)
				if tDistanceToStartWp == 0 then
					tDistanceToStartWp = tDistance
				end
			end
			rMetapathData[tEndWps[x]].distance = tDistance
			rMetapathData[tEndWps[x]].distanceToStartWp = tDistanceToStartWp
		end
	end

	return rMetapathData
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:EndFollowingWpOrRt()
	if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
		if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
			if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
				SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
			end
			--SkuOptions.db.profile["SkuNav"].selectedWaypoint = ""
			SkuNav:SelectWP("", true)
			SkuOptions.Voice:OutputString(L["following stopped"], false, true, 0.3, true)
		end
	end
	SkuOptions.db.profile[MODULE_NAME].routeFollowing = false
	--SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = nil
	--SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = nil
	--SkuOptions.db.profile[MODULE_NAME].routeFollowingUpDown = nil
	--SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = nil
	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = nil
	--SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths = nil
	--SkuOptions.db.profile[MODULE_NAME].metapathFollowingStart = nil
	--SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = nil
	--SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget = nil
	--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
	SkuNav:SelectWP("", true)
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param aWpName number
---@param aNoVoice bool if the selection should be vocalized
function SkuNav:SelectWP(aWpName, aNoVoice)
	--print("SkuNav:SelectWP(aWpName, aNoVoice", aWpName, aNoVoice)
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


	if not SkuNav:GetWaypoint(aWpName) then
		return
	end

	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint then
		if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
		end
	end

	SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = aWpName

	local tBeaconType = "probe_deep_1"
	if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size == 5 then
		tBeaconType = "probe_mid_1"
		--tBeaconType = "probe_deep_1_b"
	end
	SkuOptions.BeaconLib:CreateBeacon("SkuOptions", aWpName, tBeaconType, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume)
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

	lastDirection = SkuNav:GetDirectionTo(worldx, worldy, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY)

	if not aNoVoice then
		--PlaySound(835)
		SkuOptions:VocalizeMultipartString(aWpName..";"..L["selected"], true, true, 0.2)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:UpdateWP(aWpName)
	if not aWpName then
		return
	end

	if not SkuNav:GetWaypoint(aWpName) then
		return
	end

	local tAreaId = SkuNav:GetCurrentAreaId()

	if tAreaId == 0 then
		SkuOptions.Voice:OutputString(L["Error"], true, true, 0.2)
		return
	end

	local worldx, worldy = UnitPosition("player")
	local tPName = UnitName("player")
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
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
	SkuNav.MinimapFull = false

	-- quick wps F5-7
	for x = 1, 4 do
		local tWaypointName = L["Quick waypoint"]..";"..x
		if not SkuNav:GetWaypoint(tWaypointName) then
			--insert
			local tAreaId =SkuNav:GetCurrentAreaId()

			local worldx, worldy = UnitPosition("player")
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			if SkuOptions.db.profile[MODULE_NAME].Waypoints then
				table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, tWaypointName)
				SkuNav:SetWaypoint(tWaypointName, {
					["contintentId"] = tPlayerContintentId,
					["areaId"] = tAreaId,
					["worldX"] = worldx,
					["worldY"] = worldy,
					["createdAt"] = GetTime(), 
					["createdBy"] = "SkuNav",
					["size"] = 1,
				})
			end
		else
			--reset
			local worldx, worldy = UnitPosition("player")
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			--table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, tWaypointName)
			SkuNav:SetWaypoint(tWaypointName, {
				["contintentId"] = tPlayerContintentId,
				["areaId"] = nil,
				["worldX"] = worldx,
				["worldY"] = worldy,
				["createdAt"] = GetTime(), 
				["createdBy"] = "SkuNav",
				["size"] = 1,
			})
		end
	end

	--check all rts; remove invalid rts and their unused wps
	--cleanup broken rts
	local tRtsToDelete = {}
	for x = 1, #SkuOptions.db.profile["SkuNav"].Routes do
		if SkuNav:CheckRoute(SkuOptions.db.profile["SkuNav"].Routes[x]) == false then
			tRtsToDelete[#tRtsToDelete + 1] = SkuOptions.db.profile["SkuNav"].Routes[x]
		end
	end
	if #tRtsToDelete > 0 then
		for x = 1, #tRtsToDelete do
			SkuNav:DeleteRoute(tRtsToDelete[x], true)
			--print(tRtsToDelete[x])
		end
		print(L["Warning"]..": "..#tRtsToDelete.." "..L["invalid routes including their waypoints were deleted"])
		SkuOptions.Voice:OutputString(L["Warning"]..": "..#tRtsToDelete.." "..L["invalid routes including their waypoints were deleted"], true, true, 0.2)
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
				--print("AddWaypointToCurrentZone", x, y, desc)
			end)
			hooksecurefunc(TomTom, "HideWaypoint", function(self, uid, minimap, worldmap)
				--print("HideWaypoint", uid, minimap, worldmap)
			end)
			hooksecurefunc(TomTom, "ShowWaypoint", function(self, uid)
				--print("ShowWaypoint", uid)
			end)
		end)
	end

	SkuNav:SkuNavMMOpen()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:PLAYER_ENTERING_WORLD(...)
	C_Timer.NewTimer(25, function() SkuDrawFlag = true end)
	C_Timer.NewTimer(45, function() SkuCacheFlag = true end)
	SkuOptions.db.profile[MODULE_NAME].routeFollowing = false
	SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute = nil
	SkuOptions.db.profile[MODULE_NAME].routeFollowingStartWP = nil
	SkuOptions.db.profile[MODULE_NAME].routeFollowingUpDown = nil --down -1 ; up 1
	SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = nil

	SkuOptions.db.profile[MODULE_NAME].metapathFollowing = false
	SkuOptions.db.profile[MODULE_NAME].routeFollowing = false
	SkuOptions.db.profile[MODULE_NAME].routeRecording = false
	--SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = ""
	SkuNav:SelectWP("", true)
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
	local rValue

	if SkuNav:GetWaypoint(aOldName) then
		local tWpData
		for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
			if v == aOldName then
				tWpData = SkuOptions.db.profile[MODULE_NAME].Waypoints[v]
				SkuOptions.db.profile[MODULE_NAME].Waypoints[SkuOptions.db.profile[MODULE_NAME].Waypoints[v]] = nil
				SkuOptions.db.profile[MODULE_NAME].Waypoints[v] = nil
				table.remove(SkuOptions.db.profile[MODULE_NAME].Waypoints, i)
				rValue = true
			end
		end
		table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, aNewName)
		SkuNav:SetWaypoint(aNewName,  tWpData)
		if not SkuNav:GetWaypoint(aNewName) then
			rValue = false
		end
	end
	
	if rValue == true then
		for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes do
			local tRtData = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]]
			for y = 1, #tRtData.WPs do
				if tRtData.WPs[y] == aOldName then
					tRtData.WPs[y] = aNewName
				end
			end
			if tRtData.tStartWPName == aOldName then
				tRtData.tStartWPName = aNewName
			end
			if tRtData.tEndWPName == aOldName then
				tRtData.tEndWPName = aNewName
			end

			SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]] = tRtData
		end
	end

	return rValue
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:CreateWaypoint(aName, aX, aY, aSize, aForcename)
	--print("CreateWaypoint", aName, aX, aY, aSize)
	aSize = aSize or 1
	local tPName = UnitName("player")

	if aName == nil then
		-- this generates (almost) unique auto wp numbers, to avoid duplicates and renaming on import/export of WPs and Rts later on
		-- numbers > 1000000 are not vocalized by SkuVoice; thus they are silent, even if they are part of the auto WP names
		local tNumber = tostring(GetServerTime()..GetTimePreciseSec())
		local tAutoIndex = tNumber:gsub("%.", "")
		if SkuNav:GetWaypoint(L["auto"]..";"..tAutoIndex) ~= nil then
			while SkuNav:GetWaypoint(L["auto"]..";"..tAutoIndex)  ~= nil do
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
		if SkuNav:GetWaypoint(aName) and not aForcename then
			local q = 1
			while SkuNav:GetWaypoint(aName..q) do
				q = q + 1
			end
			aName = aName..q
		end

		local worldx, worldy = UnitPosition("player")
		if aX and aY then
			worldx, worldy = aX, aY
		end
		local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))

		table.insert(SkuOptions.db.profile[MODULE_NAME].Waypoints, aName)
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
		SkuOptions.db.profile["SkuNav"].Waypoints[aName] = aData
end
---------------------------------------------------------------------------------------------------------------------------------------
local SkuNavNpcWaypointCache = {}
local SkuNavObjWaypointCache = {}

---@param aName string
---@return table tReturnValue contintentId, areaId, worldX, worldY, createdAt, createdBy
function SkuNav:GetWaypoint(aName)
	--print("GetWaypoint", aName, SkuOptions.db.profile["SkuNav"].Waypoints[aName])
	if not SkuOptions.db.profile["SkuNav"].Waypoints then
		return
	end
	if not aName or aName == "" then
		return
	end

	local tReturnValue = nil


	--custom
	if SkuOptions.db.profile["SkuNav"].Waypoints[aName] then
		if not SkuOptions.db.profile["SkuNav"].Waypoints[aName].size then
			SkuOptions.db.profile["SkuNav"].Waypoints[aName].size = 1
		end
		return SkuOptions.db.profile["SkuNav"].Waypoints[aName]
	end

	if SkuNavNpcWaypointCache[aName] then
		return SkuNavNpcWaypointCache[aName]
	end
	if SkuNavObjWaypointCache[aName] then
		return SkuNavObjWaypointCache[aName]
	end

	-- standard wps
	--Postbox wps
	for q = 1, #SkuDB.DefaultWaypoints2.Postbox do
		local tFaction = SkuDB.DefaultWaypoints2.Postbox[q]
		for q = 1, #SkuDB.DefaultWaypoints2.Postbox[tFaction] do
			local tWaypointName = SkuDB.DefaultWaypoints2.Postbox[tFaction][q]
			if aName == tWaypointName then
				SkuDB.DefaultWaypoints2.Postbox[tFaction][tWaypointName].size = 1
				return SkuDB.DefaultWaypoints2.Postbox[tFaction][tWaypointName]
			end
		end
	end
	-- zone/map wps
	for q = 1, #SkuDB.DefaultWaypoints2.Zones do
		local tZone = SkuDB.DefaultWaypoints2.Zones[q]
		for q = 1, #SkuDB.DefaultWaypoints2.Zones[tZone] do
			local tSubzone = SkuDB.DefaultWaypoints2.Zones[tZone][q]
			for q = 1, #SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone] do
				local tWaypointName = SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][q]
				if aName == tWaypointName then
					SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][tWaypointName].size = 1
					return SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][tWaypointName]
				end
			end
		end
	end

	local tWpParts = {ssplit(";", aName)}
	for q = 1, #tWpParts do
		if tonumber(tWpParts[q]) then
			tWpParts[q] = tonumber(tWpParts[q])
		end
	end

	if tWpParts[1] and tWpParts[2] and tWpParts[3] and tWpParts[4] and tWpParts[5] then
		if SkuNavNpcWaypointCache[aName] then
			return SkuNavNpcWaypointCache[aName]
		else
			local i = SkuDB.NpcData.NamesDERev[slower(tWpParts[1])]
			if i then
				if SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]] then
					for is, vs in pairs(SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]) do
						local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
						--we don't care for stuff that isn't in the open world
						if isUiMap then
							if SkuDB.InternalAreaTable[is] then
								if slower(tWpParts[#tWpParts-3]) == slower(SkuDB.InternalAreaTable[is].AreaName_lang) then
									local tMaxSp = #vs
									--if tMaxSp > 3 then tMaxSp = 3 end
									for sp = 1, tMaxSp do
										if tWpParts[#tWpParts-2] == sp then
											if vs[sp][1]..";"..vs[sp][2] == tWpParts[#tWpParts-1]..";"..tWpParts[#tWpParts] then
												local tContintentId = select(3, SkuNav:GetAreaData(is))
												local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(tWpParts[#tWpParts-1] / 100, tWpParts[#tWpParts] / 100))
												local tX, tY = worldPosition:GetXY()

												SkuNavNpcWaypointCache[#SkuNavNpcWaypointCache+1] = aName
												SkuNavNpcWaypointCache[aName] = {
													["contintentId"] = tContintentId,
													["areaId"] = is,
													["worldX"] = tX,
													["worldY"] = tY,
													["createdAt"] = "",
													["createdBy"] = "SkuNav",
													["size"] = 1,
													["spawnNr"] = sp,
												}

												--print(aName, "from db")
												return {
													["contintentId"] = tContintentId,
													["areaId"] = is,
													["worldX"] = tX,
													["worldY"] = tY,
													["createdAt"] = "",
													["createdBy"] = "SkuNav",
													["size"] = 1,
													["spawnNr"] = sp,
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
		end
	end

	if tWpParts[1] and tWpParts[2] and tWpParts[3] and tWpParts[4] and tWpParts[5] and tWpParts[6] and tWpParts[7] then
		if tWpParts[1] == L["OBJECT"] then
			if SkuNavObjWaypointCache[aName] then
				--print("GET OBJEKT C", aName)
				return SkuNavObjWaypointCache[aName]
			else
				local i = tWpParts[2]
				--print("OBJEKT QUERY", " - ", i, " - ", aName, " - ", tWpParts[1] , " - ", tWpParts[2] , " - ", tWpParts[3] , " - ", tWpParts[4] , " - ", tWpParts[5], " - ", tWpParts[6], " - ", tWpParts[7])
				if i then
					if SkuDB.objectDataTBC[i][SkuDB.objectKeys["spawns"]] then
						for is, vs in pairs(SkuDB.objectDataTBC[i][SkuDB.objectKeys["spawns"]]) do
							local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
							--we don't care for stuff that isn't in the open world
							if isUiMap then
								if SkuDB.InternalAreaTable[is] then
									if slower(tWpParts[#tWpParts-3]) == slower(SkuDB.InternalAreaTable[is].AreaName_lang) then
										for sp = 1, #vs do
											if tWpParts[#tWpParts-2] == sp then
												if vs[sp][1]..";"..vs[sp][2] == tWpParts[#tWpParts-1]..";"..tWpParts[#tWpParts] then
													--print("GET OBJEKT", aName)
													local tContintentId = select(3, SkuNav:GetAreaData(is))
													local _, worldPosition = C_Map.GetWorldPosFromMapPos(isUiMap, CreateVector2D(tWpParts[#tWpParts-1] / 100, tWpParts[#tWpParts] / 100))
													local tX, tY = worldPosition:GetXY()

													SkuNavObjWaypointCache[#SkuNavObjWaypointCache+1] = aName
													SkuNavObjWaypointCache[aName] = {
														["contintentId"] = tContintentId,
														["areaId"] = is,
														["worldX"] = tX,
														["worldY"] = tY,
														["createdAt"] = "",
														["createdBy"] = "SkuNav",
														["size"] = 1,
													}

													--print(aName, "from db")
													return {
														["contintentId"] = tContintentId,
														["areaId"] = is,
														["worldX"] = tX,
														["worldY"] = tY,
														["createdAt"] = "",
														["createdBy"] = "SkuNav",
														["size"] = 1,
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
			end
		end
	end
	return tReturnValue
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
			--print(aNpcName, aNpcId, i, v)
			rRoles[#rRoles+1] = v
		end
	end

	GetNpcRolesCache[aNpcId] = rRoles
	return rRoles
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:InsertWpNamesFromCreatureIds(aCreatureIds, aTargetTable)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())

	for i, tNpcID in pairs(aCreatureIds) do
		--print("CreateRtWpSubmenu", i, tNpcID)		
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
								if tNumberOfSpawns > 3 then
									--tNumberOfSpawns = 3
								end
								local tSubname = SkuDB.NpcData.NamesDE[i][2]
								local tRolesString = ""
								if not tSubname then
									local tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.NamesDE[i], i)
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
									aTargetTable[#aTargetTable + 1] = SkuDB.NpcData.NamesDE[i][1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
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
---@param aSort bool
---@param aFilter string values sep by semicolon: custom;zonemap;inkeeper;taxi;postbox;npc
---@param aAreaId number just from this area if provided
---@param aContinentId number
---@param aExcludeRoute string this route will be ignored for auto WPs
---@return table tWpList Returns an iterator function for the wp list

local ListWaypointsNpcCache = {}
local ListWaypointsObjectCache = {}

function SkuNav:ListWaypoints(aSort, aFilter, aAreaId, aContinentId, aExcludeRoute, aRetAsTable, aIgnoreAuto)
	--print("ListWaypoints-----------------", aSort, aFilter, aAreaId, aContinentId, aExcludeRoute)
	aSort = aSort or false
	aFilter = aFilter or "custom;zonemap;inkeeper;taxi;postbox;npc;object"--resource

	if aAreaId then
		aAreaId = SkuNav:GetUiMapIdFromAreaId(aAreaId)
		if not aContinentId then
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			aContinentId = tPlayerContintentId
		end
	end

	local tWpList = {}
	local tWpListLookup = {}
	if string.find(aFilter, "npc") then
		if aContinentId then
			local tAId = aAreaId or -1
			if not ListWaypointsNpcCache[aContinentId] then
				ListWaypointsNpcCache[aContinentId] = {}
			end
			if ListWaypointsNpcCache[aContinentId][tAId] then
				--tWpList = ListWaypointsNpcCache[aContinentId][tAId]
				for x = 1, #ListWaypointsNpcCache[aContinentId][tAId] do
					tWpList[x] = ListWaypointsNpcCache[aContinentId][tAId][x]
					tWpListLookup[ListWaypointsNpcCache[aContinentId][tAId][x]] = x
				end
			end
		end
	end
	if string.find(aFilter, "object") then
		if aContinentId then
			local tAId = aAreaId or -1
			if not ListWaypointsObjectCache[aContinentId] then
				ListWaypointsObjectCache[aContinentId] = {}
			end
			if ListWaypointsObjectCache[aContinentId][tAId] then
				for x = 1, #ListWaypointsObjectCache[aContinentId][tAId] do
					tWpList[#tWpList+1] = ListWaypointsObjectCache[aContinentId][tAId][x]
					tWpListLookup[ListWaypointsObjectCache[aContinentId][tAId][x]] = #tWpList
				end
			end
		end
	end

	if string.find(aFilter, "custom") then
		for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
			if not string.find(v, L["Quick waypoint"]) then
				if not (aIgnoreAuto and string.find(v, L["auto"])) then
					if (not aContinentId) or (aContinentId == SkuOptions.db.profile[MODULE_NAME].Waypoints[v].contintentId) then
						if (not aAreaId) or aAreaId == SkuNav:GetUiMapIdFromAreaId(SkuOptions.db.profile[MODULE_NAME].Waypoints[v].areaId) then
							if aExcludeRoute then
								local tFound = false
								for wpcounter = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[aExcludeRoute].WPs do
									if SkuOptions.db.profile[MODULE_NAME].Routes[aExcludeRoute].WPs[wpcounter] == v then
										tFound = true
									end
								end
								if tFound == false then
									--check if there is a custom wp that updates a standard wp
									if tWpListLookup[v] then
										tWpList[tWpListLookup[v]] = v
									else
										tWpList[#tWpList+1] = v
									end
								end
							else
								--check if there is a custom wp that updates a standard wp
								if tWpListLookup[v] then
									tWpList[tWpListLookup[v]] = v
								else
									tWpList[#tWpList+1] = v
								end
							end
						end
					end
				end
			end
		end
	end

	if string.find(aFilter, "zonemap") then
		for q = 1, #SkuDB.DefaultWaypoints2.Zones do
			local tZone = SkuDB.DefaultWaypoints2.Zones[q]
			for u = 1, #SkuDB.DefaultWaypoints2.Zones[tZone] do
				local tSubzone = SkuDB.DefaultWaypoints2.Zones[tZone][u]
				for z = 1, #SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone] do
					if (not aContinentId) or (aContinentId == SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][z]].contintentId) then
						if (not aAreaId) or aAreaId == SkuNav:GetUiMapIdFromAreaId(SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][z]].areaId) then
							tWpList[#tWpList+1] = SkuDB.DefaultWaypoints2.Zones[tZone][tSubzone][z]
						end
					end
				end
			end
		end
	end
	if string.find(aFilter, "postbox") then
		for q = 1, #SkuDB.DefaultWaypoints2.Postbox do
			local tFaction = SkuDB.DefaultWaypoints2.Postbox[q]
			for q = 1, #SkuDB.DefaultWaypoints2.Postbox[tFaction] do
				if (not aContinentId) or (aContinentId == SkuDB.DefaultWaypoints2.Postbox[tFaction][SkuDB.DefaultWaypoints2.Postbox[tFaction][q]].contintentId) then
					if (not aAreaId) or aAreaId == SkuNav:GetUiMapIdFromAreaId(SkuDB.DefaultWaypoints2.Postbox[tFaction][SkuDB.DefaultWaypoints2.Postbox[tFaction][q]].areaId) then
						tWpList[#tWpList+1] = SkuDB.DefaultWaypoints2.Postbox[tFaction][q]
					end
				end
			end
		end
	end

	if string.find(aFilter, "npc") then
		local tInFlag = false
		if not ListWaypointsNpcCache[aContinentId] then
			tInFlag = true
		else
			if not ListWaypointsNpcCache[aContinentId][aAreaId or -1] then
				tInFlag = true
			end
		end
		if tInFlag == true then
			--print("db")
			local tNpcTmpTable = {}
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
									if (not aContinentId) or (aContinentId == tData.ContinentID) then
										if (not aAreaId) or aAreaId == isUiMap then
											local tNumberOfSpawns = #vs
											if tNumberOfSpawns > 3 then
												--tNumberOfSpawns = 3
												--print(v[1], tNumberOfSpawns)
											end
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
												tWpList[#tWpList+1] = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
												tNpcTmpTable[#tNpcTmpTable+1] = v[1]..tRolesString..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
											end
										end
									end
								end
							end
						end
					end
				end
			end
			if ListWaypointsNpcCache[aContinentId] then
				ListWaypointsNpcCache[aContinentId] = ListWaypointsNpcCache[aContinentId] or {}
				ListWaypointsNpcCache[aContinentId][aAreaId or -1] = tNpcTmpTable
			end
		end
	end

	if string.find(aFilter, "object") or string.find(aFilter, "resource") then
		local tInFlag = false
		if not ListWaypointsObjectCache[aContinentId] then
			tInFlag = true
		else
			if not ListWaypointsObjectCache[aContinentId][aAreaId or -1] then
				tInFlag = true
			end
		end
		if tInFlag == true then
			--print("from db")
			local tObjectTmpTable = {}
			for i, v in pairs(SkuDB.objectLookup) do
				if (not SkuDB.objectResourceNames[v]) or (string.find(aFilter, "resource")) then
					if SkuDB.objectDataTBC[i] then
						local tSpawns = SkuDB.objectDataTBC[i][4]
						if tSpawns then
							for is, vs in pairs(tSpawns) do
								local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
								--we don't care for stuff that isn't in the open world
								if isUiMap then
									local tData = SkuDB.InternalAreaTable[is]
									if tData then
										if (not aContinentId) or (aContinentId == tData.ContinentID) then
											if (not aAreaId) or aAreaId == isUiMap then
												local tNumberOfSpawns = #vs
												--if tNumberOfSpawns > 3 then
													--tNumberOfSpawns = 3
												--end
												for sp = 1, tNumberOfSpawns do
													tWpList[#tWpList+1] = L["OBJECT"]..";"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
													tObjectTmpTable[#tObjectTmpTable+1] = L["OBJECT"]..";"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
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
			if ListWaypointsObjectCache[aContinentId] then
				ListWaypointsObjectCache[aContinentId] = ListWaypointsObjectCache[aContinentId] or {}
				ListWaypointsObjectCache[aContinentId][aAreaId or -1] = tObjectTmpTable
			end
		end
	end

	if aSort == true then
		local tSortedList = {}
		for k,v in SkuSpairs(tWpList, function(t,a,b) return t[b] > t[a] end) do --nach wert
			tSortedList[#tSortedList+1] = v
		end
		if aRetAsTable then
			return tSortedList
		else
			return ipairs(tSortedList)
		end
	end

	if aRetAsTable then
		return tWpList
	else
		return ipairs(tWpList)
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:DeleteWaypoint(aWpName, aDeleteRtsWith2WpsRemaining)
	local rValue
	local tRtsToDelete = {}

	local tKeep = false
	if SkuOptions.db.profile[MODULE_NAME].Waypoints[aWpName] then
		for x = 1, #SkuOptions.db.profile[MODULE_NAME].Routes do
			local tWps = SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]].WPs
			for y = 1, #tWps do
				if tWps[y] == aWpName then
					if y == 1 then
						if #tWps > 2 then
							SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]].tStartWPName = tWps[1]
							table.remove(tWps, 1)
							SkuNav:UpdateRtContinentAndAreaIds(SkuOptions.db.profile[MODULE_NAME].Routes[x])
						else
							tKeep = true
							if aDeleteRtsWith2WpsRemaining == true then
								tRtsToDelete[#tRtsToDelete + 1] = SkuOptions.db.profile[MODULE_NAME].Routes[x]
							end
						end
					elseif y == #tWps then
						if #tWps > 2 then
							SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].Routes[x]]. tEndWPName = tWps[#tWps-1]
							table.remove(tWps, #tWps)
							SkuNav:UpdateRtContinentAndAreaIds(SkuOptions.db.profile[MODULE_NAME].Routes[x])
						else
							tKeep = true
							if aDeleteRtsWith2WpsRemaining == true then
								tRtsToDelete[#tRtsToDelete + 1] = SkuOptions.db.profile[MODULE_NAME].Routes[x]
							end
						end
					else
						table.remove(tWps, y)
					end
				end
			end
		end

		if tKeep == false then
			if SkuNav:GetWaypoint(aWpName) then
				for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
					if v == aWpName then
						v = nil
						table.remove(SkuOptions.db.profile[MODULE_NAME].Waypoints, i)
						rValue = true
					end
				end
			end
		else
			rValue = false
		end

		if aDeleteRtsWith2WpsRemaining == true then
			for x = 1, #tRtsToDelete do
				--print("route wird gelöscht wegen 2wp", tRtsToDelete[x])
				SkuNav:DeleteRoute(tRtsToDelete[x], true)
			end
		end

	else
		print(L["Only custom waypoints can be deleted"])
	end
	return rValue
end
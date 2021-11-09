---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local ADDON_NAME = ...
local _G = _G

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SkuNav", false)

local lastDirection = -1
local lastDistance = 0

local EN_WPSIZE = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 8,
}

local minimap_size = {
	indoor = {
		 [0] = 300, -- scale
		 [1] = 240, -- 1.25
		 [2] = 180, -- 5/3
		 [3] = 120, -- 2.5
		 [4] = 80,  -- 3.75
		 [5] = 50,  -- 6
	},
	outdoor = {
		 [0] = 466 + 2/3, -- scale
		 [1] = 400,       -- 7/6
		 [2] = 333 + 1/3, -- 1.4
		 [3] = 266 + 2/6, -- 1.75
		 [4] = 200,       -- 7/3
		 [5] = 133 + 1/3, -- 3.5
	},
}

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

local slower = string.lower
local sfind = string.find

local SkuLineRepo
local SkuWaypointWidgetRepo
local SkuWaypointWidgetRepoMM
local SkuWaypointLineRepoMM
local SkuWaypointWidgetCurrent

local tSkuNavMMContent = {}
local tSkuNavMMZoom = 1
local tSkuNavMMPosX = 0
local tSkuNavMMPosY = 0
local tTileSize = 533.33
local tYardsPerTile = 533.33

local tRecordingPoly = 0
local tRecordingPolySub = 0
local tRecordingPolyFor = 0

function SkuNavMMGetCursorPositionContent2()
	local x, y = GetCursorPosition()
	--print(x, UIParent:GetScale(), _G["SkuNavMMMainFrameScrollFrameMapMain"]:GetLeft(),_G["SkuNavMMMainFrame"]:GetScale() )
	local txPos = ((x / UIParent:GetScale()) - ( _G["SkuNavMMMainFrameScrollFrameContent"]:GetLeft()   * _G["SkuNavMMMainFrame"]:GetScale() ) - ((_G["SkuNavMMMainFrameScrollFrameContent"]:GetWidth()  / 2) * _G["SkuNavMMMainFrame"]:GetScale()) ) * (1 / _G["SkuNavMMMainFrame"]:GetScale())
	local tyPos = ((y / UIParent:GetScale()) - ( _G["SkuNavMMMainFrameScrollFrameContent"]:GetBottom() * _G["SkuNavMMMainFrame"]:GetScale() ) - ((_G["SkuNavMMMainFrameScrollFrameContent"]:GetHeight() / 2) * _G["SkuNavMMMainFrame"]:GetScale()) ) * (1 / _G["SkuNavMMMainFrame"]:GetScale())
	return txPos, tyPos
end

function SkuNavMMContentToWorld(aPosX, aPosY)
	local tModTileSize = tYardsPerTile * tSkuNavMMZoom
	local tTilesX, tTilesY = (aPosX - (tSkuNavMMPosX * tSkuNavMMZoom)) / tModTileSize - 1, (aPosY - (tSkuNavMMPosY * tSkuNavMMZoom)) / tModTileSize - 2
	return -(tTilesX * tYardsPerTile), tTilesY * tYardsPerTile
end

function SkuNavMMWorldToContent(aPosY, aPosX)
	aPosX, aPosY = (aPosX - tYardsPerTile) * tSkuNavMMZoom, (aPosY + tYardsPerTile + tYardsPerTile) * tSkuNavMMZoom
	aPosX, aPosY = (aPosX + (tSkuNavMMPosX * tSkuNavMMZoom)) - ((tSkuNavMMPosX * tSkuNavMMZoom) * 2), aPosY + (tSkuNavMMPosY * tSkuNavMMZoom)
	return -(aPosX), aPosY
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
				print("Wegpunktinfo: "..SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments[x])
				Voice:OutputString(" ", true, true, 0.3)
				SkuOptions:VocalizeMultipartString("Wegpunktinfo: "..SkuOptions.db.profile["SkuNav"].Waypoints[aWpName].comments[x], false, true, nil, nil, 3)
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
tCacheNbWpsTimerCounter = 0
tCacheNbWpsTimerCounterProgress = 0
tCacheNbWpsTimerCounterProgressShow = false
tCacheNbWpsTimerRate = 10
local tCacheNbWpsTimer = nil
local SkuNeighbCache = {}
function CacheNbWps(aRate, aListOfRouteNamesToReCache, aListOfWpNamesToReCache)
	tCacheNbWpsTimerRate = 10 --aRate or 10
	if _G["SkuNavMMMainFrame"] then
		if _G["SkuNavMMMainFrame"]:IsShown() == true then
			return
		end
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
function SkuNav:InsertRouteWp(aWpTable, aWpName)
	table.insert(aWpTable, aWpName)
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
 	if tMinimapZoneText == "Die Tiefenbahn" then --fix for strange DeeprunTram zone
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
	local tPlayerUIMap = C_Map.GetBestMapForUnit("player")
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
		local tExtMapId = SkuDB.ExternalMapID[C_Map.GetBestMapForUnit("player")]
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

	if sfind(aRouteName, "schnellwegpunkt") or sfind(aRouteName, "Schnellwegpunkt") then
		return false
	end

	if #SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs > 1 then
		for q = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs do
			if sfind(SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q], "schnellwegpunkt") or sfind(SkuOptions.db.profile[MODULE_NAME].Routes[aRouteName].WPs[q], "Schnellwegpunkt") then
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
		Voice:OutputString("Fehler", false, true, 0.3, true)
		Voice:OutputString("Wegpunkt oder Route folgen läuft oder Aufzeichnung läuft", false, true, 0.3, true)
		return
	end

	local tmpWPA = aWPAName
	local tmpWPASize = aSize
	local tmpWPB = aWPBName
	local tmpWPBSize = aSize
	local tmpIntWP = aIntWP

	if tmpWPA == nil then
		Voice:OutputString("Punkt A fehlt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
	end
	if tmpWPB == nil then
		Voice:OutputString("Punkt B fehlt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
	end

	--a/b setup complete
	if tmpWPA and tmpWPB then
		local tIntWPmethod = tmpIntWP or "Manuell"
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
		
		--add first wp to route
		SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tRouteName].WPs, tWpNameA)

		-- start recording
		SkuOptions.db.profile[MODULE_NAME].routeRecording = true
		SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute = tRouteName
		SkuOptions.db.profile[MODULE_NAME].routeRecordingIntWPMethod = tIntWPmethod

		if SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToA then
			Voice:OutputString("Aufzeichnung beginnt bei A", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		elseif SkuOptions.db.profile[MODULE_NAME].routeRecordingNavToB then
			Voice:OutputString("Aufzeichnung läuft bis B", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		else
			Voice:OutputString("Aufzeichnung läuft bis beenden", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
		end

		SkuOptions.tmpNpcWayPointNameBuilder_Npc = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Zone = ""
		SkuOptions.tmpNpcWayPointNameBuilder_Coords = ""

		if _G["OnSkuOptionsMain"]:IsVisible() == true then
			_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
		end

		-- set A to reached
		Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		SkuOptions:VocalizeMultipartString("Punkt A erreicht", false, true, 0.3, true)
		SkuOptions:VocalizeMultipartString("aufzeichnung;beginnt", false, true, 0.3, true)
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
		Voice:OutputString("Fehler", false, true, 0.3, true)
		Voice:OutputString("Es läuft keine Aufzeichnung", false, true, 0.3, true)
		return
	end

	--do we need to update the rt as b was set on completing the recording?
	if string.find(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute, "Bei Beenden festlegen") then
		--print("ist Bei Beenden festlegen")
		-- yes > update b wp name and update the route name
		-- aName is the new b name
		local updatedRtName = SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute:gsub("Bei Beenden festlegen", aWpBName)
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
		Voice:OutputString("failure", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		Voice:OutputString("aufzeichnung;beschädigt;route;gelöscht", false, true, 0.3, true)
	else
		SkuNav:UpdateRtContinentAndAreaIds(SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)

		Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
		Voice:OutputString("Aufzeichnung beendet;route;erstellt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
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

-----------------------------------------------------------------------------------------------------------------------
local function MinimapPointToWorldPoint(aMinimapmY, aMinimapX)
	local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local mapRadius = minimap_size[indoors][Minimap:GetZoom()] / 2
	local diffX, diffY = -aMinimapX / (Minimap:GetWidth() / 2), aMinimapmY / (Minimap:GetHeight() / 2)
	local distx, disty = diffX * mapRadius, diffY * mapRadius
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	return -(distx - fPlayerPosX), -(disty - fPlayerPosY)
end

-----------------------------------------------------------------------------------------------------------------------
local function WorldPointToMinimapPoint(aWorldX, aWorldY)
	local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local mapRadius = minimap_size[indoors][Minimap:GetZoom()] / 2
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	local xDist, yDist = fPlayerPosX - aWorldX, fPlayerPosY - aWorldY
	local diffX = xDist / mapRadius
	local diffY = yDist / mapRadius
	return diffY * (Minimap:GetHeight() / 2), -(diffX * (Minimap:GetWidth() / 2))
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
function SkuNav:OnEnable()
	--print("SkuNav OnEnable")
	if not SkuOptions.db.profile[MODULE_NAME].Waypoints then
		SkuOptions.db.profile[MODULE_NAME].Waypoints = {}
		for x = 1, 4 do
			local tWaypointName = "Schnellwegpunkt;"..x
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

	SkuNavMMOpen()

	--local lastXY, lastYY
	local tWpFrames =  {}
	local tWpObjects =  {}
	local sfind = string.find
	local tOldMMZoom
	local tOldMMScale

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
									--i:SetSize(3, 3)
									--l:SetSize(6 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (2 - tSkuNavMMZoom), 6 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (2 - tSkuNavMMZoom))
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
							Voice:OutputString("Welt Begrenzung verlassen", false, true, nil, true) --aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine
						elseif tOldPolyZones[1][1] == 0 then
							--print("world entered")
							Voice:OutputString("Welt Begrenzung betreten", false, true, nil, true)
						end
						tOldPolyZones[1][1] = tNewPolyZones[1][1] 
					end
					--fly
					if tOldPolyZones[2][1] ~= tNewPolyZones[2][1] then
						if tNewPolyZones[2][1] == 0 then
							--print("fly left")
							Voice:OutputString("Flug Zone verlassen", false, true, nil, true)
						elseif tOldPolyZones[2][1] == 0 then
							--print("fly entered")
							Voice:OutputString("Flug Zone betreten", false, true, nil, true)
						end
						tOldPolyZones[2][1] = tNewPolyZones[2][1] 
					end
					--faction
					if tOldPolyZones[3][1] ~= tNewPolyZones[3][1] then
						if tNewPolyZones[3][1] == 0 then
							--print("alliance left")
							Voice:OutputString("Allianz Zone verlassen", false, true, nil, true)
						elseif tOldPolyZones[3][1] == 0 then
							--print("alliance entered")
							Voice:OutputString("Allianz Zone betreten", false, true, nil, true)
						end
						tOldPolyZones[3][1] = tNewPolyZones[3][1] 
					end
					if tOldPolyZones[3][2] ~= tNewPolyZones[3][2] then
						if tNewPolyZones[3][2] == 0 then
							--print("horde left")
							Voice:OutputString("Horde Zone verlassen", false, true, nil, true)
						elseif tOldPolyZones[3][2] == 0 then
							--print("horde entered")
							Voice:OutputString("Horde Zone betreten", false, true, nil, true)
						end
						tOldPolyZones[3][2] = tNewPolyZones[3][2] 
					end
					if tOldPolyZones[3][3] ~= tNewPolyZones[3][3] then
						if tNewPolyZones[3][3] == 0 then
							--print("horde left")
							Voice:OutputString("Aldor Zone verlassen", false, true, nil, true)
						elseif tOldPolyZones[3][3] == 0 then
							--print("horde entered")
							Voice:OutputString("Aldor Zone betreten", false, true, nil, true)
						end
						tOldPolyZones[3][3] = tNewPolyZones[3][3] 
					end
					if tOldPolyZones[3][4] ~= tNewPolyZones[3][4] then
						if tNewPolyZones[3][4] == 0 then
							--print("horde left")
							Voice:OutputString("Seher Zone verlassen", false, true, nil, true)
						elseif tOldPolyZones[3][4] == 0 then
							--print("horde entered")
							Voice:OutputString("Seher Zone betreten", false, true, nil, true)
						end
						tOldPolyZones[3][4] = tNewPolyZones[3][4] 
					end

					--other
					if tOldPolyZones[4][1] ~= tNewPolyZones[4][1] then
						if tNewPolyZones[4][1] == 0 then
							--print("other left")
							Voice:OutputString("Wer das hört ist doof verlassen", false, true, nil, true)
						elseif tOldPolyZones[4][1] == 0 then
							--print("other entered")
							Voice:OutputString("Wer das hört ist doof betreten", false, true, nil, true)
						end
						tOldPolyZones[4][1] = tNewPolyZones[4][1] 
					end
				end

				--dead
				if UnitIsGhost("player") then
					if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == "" then
						local tUiMap = C_Map.GetBestMapForUnit("player")
						if tUiMap then
							local tCorpse = C_DeathInfo.GetCorpseMapPosition(tUiMap)
							if tCorpse then
								local cX, cY = tCorpse:GetXY()
								local tmapPos = CreateVector2D(cX, cY)
								local _, worldPosition = C_Map.GetWorldPosFromMapPos(C_Map.GetBestMapForUnit("player"), tmapPos)
								local tX, tY = worldPosition:GetXY()

								local tPlayerx, tPlayery = UnitPosition("player")
								local distance = SkuNav:Distance(tPlayerx, tPlayery, tX, tY)

								if distance > 10 then
									if SkuNav:GetWaypoint("Schnellwegpunkt;4") then
										SkuNav:GetWaypoint("Schnellwegpunkt;4").worldX = tX
										SkuNav:GetWaypoint("Schnellwegpunkt;4").worldY = tY								
										local tAreaId = SkuNav:GetCurrentAreaId()
										SkuNav:GetWaypoint("Schnellwegpunkt;4").areaId = tAreaId
										SkuNav:SelectWP("Schnellwegpunkt;4", true)

										Voice:OutputString("Schnellwegpunkt 4 auf Leiche gesetzt", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
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
							--Voice:Output("nod-"..string.format("%02d", tDirection)..".mp3", true, true, 0.3)

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
									Voice:OutputString(tDeg[x].file, false, true, 0.2)
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
										Voice:OutputString(string.format("%02d", tDirection)..";Uhr", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
										Voice:OutputString(distance..";Meter", false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
									else
										Voice:OutputString(string.format("%02d", tDirection), true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
										Voice:OutputString(distance, false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
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
								if distance < EN_WPSIZE[tWpObject.size] and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
									SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
									Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
									SkuOptions:VocalizeMultipartString("Wegpunkt;erreicht", false, true, 0.3, true)
										
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
											Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											SkuOptions:VocalizeMultipartString("Punkt A erreicht", false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString("aufzeichnung;beginnt", false, true, 0.3, true)
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
												Voice:OutputString("failure", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
												Voice:OutputString("Punkt B erreicht", false, true, 0.3, true)
												Voice:OutputString("aufzeichnung;beschädigt;route;gelöscht", false, true, 0.3, true)
											else
												SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
												Voice:OutputString("sound-success2", true, true, 0.3)-- file: string, reset: bool, wait: bool, length: int
												if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
													SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
												end
												Voice:OutputString("Punkt B erreicht", false, true, 0.3, true)
												Voice:OutputString("aufzeichnung;beendet;route;erstellt", false, true, 0.3, true)
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
								if SkuOptions.db.profile["SkuNav"].routeRecordingIntWPMethod ~= "Manuell" then
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
										SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
													SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, x+1, tIntWP)
													break
												end
											end
										end
										SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)

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
											SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
									if ((distance < EN_WPSIZE[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size] + tDistanceMod) or SkuNav.MoveToWp ~= 0)  and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
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
											Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											Voice:OutputString("noch;"..(#SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs - tNextWPNr + 1), true, true)

											SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute].WPs[tNextWPNr], true)
											SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP = tNextWPNr
										else
											Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											--SkuOptions:VocalizeMultipartString("Ziel erreicht;"..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString("Ziel erreicht;", false, true, 0.3, true)
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
									--print(EN_WPSIZE[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size])
									local tDistanceMod = 0
									if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange == true then
										tDistanceMod = 3
									end
									if ((distance < EN_WPSIZE[SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size] + tDistanceMod) or SkuNav.MoveToWp ~= 0) and SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
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
											SkuOptions:VocalizeMultipartString("Fehler in Route;folgen abgebrochen"..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
										end
										if SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[tNextWPNr] then
											Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											Voice:OutputString("noch;"..(#SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps - tNextWPNr + 1), true, true)

											SkuNav:SelectWP(SkuOptions.db.profile[MODULE_NAME].metapathFollowingMetapaths[SkuOptions.db.profile[MODULE_NAME].metapathFollowingTarget].pathWps[tNextWPNr], true)
											SkuOptions.db.profile[MODULE_NAME].metapathFollowingCurrentWp = tNextWPNr
										else
											Voice:OutputString("sound-success2", true, true, 0.3, true)-- file: string, reset: bool, wait: bool, length: int
											SkuNav:PlayWpComments(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
												SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
											end
											--SkuOptions:VocalizeMultipartString("Ziel erreicht;"..SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, false, true, 0.3, true)
											SkuOptions:VocalizeMultipartString("Ziel erreicht;", false, true, 0.3, true)

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

	if SkuCore.inCombat == false then
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
				SkuNavMMOpen()
			end

			if a == "CTRL-SHIFT-Q" then
				if SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange == false then
					SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = true
					SkuOptions:VocalizeMultipartString("Genauigkeit drei Meter", true, true, 0.3, true)
				else
					SkuOptions.db.profile[MODULE_NAME].standardWpReachedRange = false
					SkuOptions:VocalizeMultipartString("Genauigkeit ein Meter", true, true, 0.3, true)
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
						print(tTargetName..": Fehler oder zu weit entfernt (maximal 50 Meter)")
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
						print(tWpName.." hinzugefügt")
					else
						print(tWpName.." schon vorhanden")
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
							SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
										SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, x+1, tIntWP)
										break
									end
								end
							end
							local tIntWP = SkuNav:CreateWaypoint(nil, nil, nil, tWpSize)
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
							SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
						else
							--print("nothing")
							local tIntWP = SkuNav:CreateWaypoint(nil, nil, nil, tWpSize)
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
							SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
				SkuNav:SelectWP("Schnellwegpunkt;1")
			end
			if a == "CTRL-SHIFT-F5" then
				SkuNav:UpdateWP("Schnellwegpunkt;1")
			end
			if a == "SHIFT-F6" then
				SkuNav:EndFollowingWpOrRt()
				SkuNav:SelectWP("Schnellwegpunkt;2")
			end
			if a == "CTRL-SHIFT-F6" then
				SkuNav:UpdateWP("Schnellwegpunkt;2")
			end		
			if a == "SHIFT-F7" then
				SkuNav:EndFollowingWpOrRt()
				SkuNav:SelectWP("Schnellwegpunkt;3")
			end
			if a == "CTRL-SHIFT-F7" then
				SkuNav:UpdateWP("Schnellwegpunkt;3")
			end		
			if a == "SHIFT-F8" then
				SkuNav:EndFollowingWpOrRt()
				SkuNav:SelectWP("Schnellwegpunkt;4")
			end
			if a == "CTRL-SHIFT-F8" then
				SkuNav:UpdateWP("Schnellwegpunkt;4")
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
	if SkuWaypointWidgetCurrent then
		local wpObj = SkuNav:GetWaypoint(SkuWaypointWidgetCurrent)
		if wpObj then
			SkuNav:DeleteWaypoint(SkuWaypointWidgetCurrent)
		end
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
				SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
							SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[tIntersectWithRt].WPs, x+1, tIntWP)
							break
						end
					end
				end
				local tIntWP = SkuNav:CreateWaypoint(nil, tWx, tWy, tWpSize)
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
				SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
			else
				--print("nothing")
				local tIntWP = SkuNav:CreateWaypoint(nil, tWx, tWy, tWpSize)
				SkuNav:InsertRouteWp(SkuOptions.db.profile[MODULE_NAME].Routes[SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute].WPs, tIntWP)
				SkuOptions:VocalizeMultipartString("WP gesetzt", false, true, 0.3, true)
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
				print(tTargetName..": Fehler oder zu weit entfernt (maximal 50 Meter)")
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
				SkuNav:StartRouteRecording(tWpName, "Bei Beenden festlegen", "Manuell", 1)
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
				print("End:", SkuNav:EndRouteRecording(tReplacementWp, 1))
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
				SkuNav:StartRouteRecording(tReplacementWp, "Bei Beenden festlegen", "Manuell", 1)
				print("Start:", SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute)
			end
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
						--print("IntersectionPoint", v1Old, v1)
						--print("  ", aPrevWPx, aPrevWPy, aX, aY, tWpAX, tWpAY, tWpBX, tWpBY)
						--print("    ", tIntersectionX, tIntersectionY)
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
	--print("tPlayerContinentID, tPlayerUIMapId", tPlayerContinentID, tPlayerUIMapId)
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		if SkuOptions.db.profile[MODULE_NAME].Routes[v].tContinentId == tPlayerContinentID then
			if SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds[tPlayerUIMapId] then			
				--print("SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds", tPlayerUIMapId, #SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds, SkuOptions.db.profile[MODULE_NAME].Routes[v].tUiMapIds[tPlayerUIMapId])
				--ignore current rt that we're currently recording for
				local tNearestWp = nil
				local tNearestWpRange = 100000
				if SkuNav:CheckRoute(v) == true then
--print(2)					
					for i1, v1 in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs) do
						if not sfind(v1, "Schnellwegpunkt") then
							local tWpToCheck = SkuNav:GetWaypoint(v1)
							if tWpToCheck.contintentId == tPlayerContinentID then
								--print("GetAllRoutesInRangeToCoords", i,v, i1, v1)
								local tWpX, tWpY = tWpToCheck.worldX, tWpToCheck.worldY
								local tDistance  = SkuNav:Distance(aX, aY, tWpX, tWpY)
--print("tDistance", tDistance)					

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
						--tFoundWps = {}
						--tFoundWps[v] = {["nearestWP"] = tNearestWp, ["nearestWpRange"] = tNearestWpRange}
						--break
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


	local tF = sfind(aWpName, "Meter#")
	if tF then	
		aWpName = string.sub(aWpName, tF + 6)
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
					--print("add", v)
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
					if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1], "auto") then
						tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]
					end
				end
				if aWpName ~= SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs] then
					if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs], "auto") then
						tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]
					end
				end
			end
		end
	end

	for x = 1, #tEndWps do
		if tFoundNbList[tEndWps[x]] then
			--print("for end wp:", tEndWps[x])
			rMetapathData[#rMetapathData+1] = tEndWps[x]
			rMetapathData[tEndWps[x]] = {
				pathWps = {},
				distance = 0,
			}

			local tOut = false
			local tCurrentWp = tEndWps[x]
			while tOut == false do
				--print("  pathwps:", tCurrentWp)
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
	--print("====================")
	--setmetatable(rMetapathData, SkuNav.PrintMT)
	--print(rMetapathData)

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
			Voice:OutputString("aktuelles folgen beendet", false, true, 0.3, true)
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

	--print("SelectWP", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint, SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint))

	if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint then
		if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) then
			SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", SkuOptions.db.profile[MODULE_NAME].selectedWaypoint)
		end
	end

	SkuOptions.db.profile[MODULE_NAME].selectedWaypoint = aWpName

--print(SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY)

	local tBeaconType = "probe_deep_1"
	if SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).size == 5 then
		tBeaconType = "probe_mid_1"
		--tBeaconType = "probe_deep_1_b"
	end
	SkuOptions.BeaconLib:CreateBeacon("SkuOptions", aWpName, tBeaconType, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldX, SkuNav:GetWaypoint(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint).worldY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume)
	SkuOptions.BeaconLib:StartBeacon("SkuOptions", aWpName)

	if not string.find(aWpName, "auto;") then
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
		SkuOptions:VocalizeMultipartString(aWpName..";Ausgewählt", true, true, 0.2)
	end
	--print(aWpName.."; ausgew�hlt")
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
		Voice:OutputString("Fehler", true, true, 0.2)
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
	SkuOptions:VocalizeMultipartString(aWpName..";aktualisiert", true, true, 0.2)
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
	Voice:StopAllOutputs()
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

	--[[
	--add continent ids to all existing wps without - for old wps before the continent id change (pre v14) 
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
		if not SkuOptions.db.profile[MODULE_NAME].Waypoints[v] then
			local tAreaId =SkuNav:GetCurrentAreaId()
			local worldx, worldy = UnitPosition("player")
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			SkuNav:SetWaypoint(v, {
				["contintentId"] = tPlayerContintentId,
				["areaId"] = tAreaId,
				["worldX"] = worldx,
				["worldY"] = worldy,
				["createdAt"] = GetTime(), 
				["createdBy"] = "SkuNav",
				["size"] = 1,
			})
		end
		if not SkuOptions.db.profile[MODULE_NAME].Waypoints[v].contintentId then
			local tContintentId = select(3, SkuNav:GetAreaData(SkuOptions.db.profile[MODULE_NAME].Waypoints[v].areaId))
			SkuOptions.db.profile[MODULE_NAME].Waypoints[v].contintentId = tContintentId
		end
	end

	--remove all standard wps from custom wp list - for old wps before v12
	local tUpdatedWPs = {}
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Waypoints) do
		if strsub(v, 1, 2) ~= "s;" and strsub(v, 1, 16) ~= "Schnellwegpunkt;" then
			table.insert(tUpdatedWPs, v)
			tUpdatedWPs[v] = SkuOptions.db.profile[MODULE_NAME].Waypoints[v]
		end
	end
	SkuOptions.db.profile[MODULE_NAME].Waypoints = tUpdatedWPs
	]]

	-- quick wps F5-7
	for x = 1, 4 do
		local tWaypointName = "Schnellwegpunkt;"..x
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
		print("Achtung: "..#tRtsToDelete.." ungültige Routen inklusive ihrer Wegpunkte wurden gelöscht")
		Voice:OutputString("Achtung: "..#tRtsToDelete.." ungültige Routen inklusive ihrer Wegpunkte wurden gelöscht", true, true, 0.2)
	end

	--tomtom integration for adding beacons to the arrow
	if TomTom then
		SkuOptions.tomtomBeaconName = "SkuTomTomBeacon"
		C_Timer.NewTimer(5, function() 
			hooksecurefunc(TomTom, "AddWaypoint", function(self, map, x, y, options)
				if SkuOptions.db.profile[MODULE_NAME].tomtomWp == true then
					local bx, by = HBD:GetWorldCoordinatesFromZone(x, y, map)
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

	SkuNavMMOpen()
end
---------------------------------------------------------------------------------------------------------------------------------------
local SkuDrawFlag = false
function SkuNav:PLAYER_ENTERING_WORLD(...)
	C_Timer.NewTimer(5, function() SkuDrawFlag = true end)
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
			Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ZONE_CHANGED(...)
	if old_ZONE_CHANGED_X ~= GetMinimapZoneText() then
		old_ZONE_CHANGED_X = GetMinimapZoneText()
		if SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames == true then
			Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:ZONE_CHANGED_INDOORS(...)
	if old_ZONE_CHANGED_X ~= GetMinimapZoneText() then
		old_ZONE_CHANGED_X = GetMinimapZoneText()
		if SkuOptions.db.profile[MODULE_NAME].vocalizeZoneNames == true then
			Voice:OutputString(old_ZONE_CHANGED_X, true, true, 0.2)
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
		if SkuNav:GetWaypoint("auto;"..tAutoIndex) ~= nil then
			while SkuNav:GetWaypoint("auto;"..tAutoIndex)  ~= nil do
				tAutoIndex = tAutoIndex + 1
			end
		end
		aName = "auto;"..tAutoIndex
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
local ssplit = string.split
---------------------------------------------------------------------------------------------------------------------------------------
local SkuNavNpcWaypointCache = {}
local SkuNavObjWaypointCache = {}

---@param aName string
---@return table tReturnValue contintentId, areaId, worldX, worldY, createdAt, createdBy
function SkuNav:GetWaypoint(aName)
	--print("GetWaypoint", aName, SkuOptions.db.profile["SkuNav"].Waypoints[aName])
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
		if tWpParts[1] == "OBJEKT" then
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
			if not string.find(v, "Schnellwegpunkt") then
				if not (aIgnoreAuto and string.find(v, "auto")) then
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
													tWpList[#tWpList+1] = "OBJEKT;"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
													tObjectTmpTable[#tObjectTmpTable+1] = "OBJEKT;"..i..";"..v..";"..tData.AreaName_lang..";"..sp..";"..vs[sp][1]..";"..vs[sp][2]
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
--[[
do
	local f = _G["SkuNavRoutesView"] or CreateFrame("Frame", "SkuNavRoutesView", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
	f:SetScale(3)
	f:SetFrameStrata("TOOLTIP")
	f:SetWidth(170)
	f:SetHeight(170)
	f:SetScript("OnDragStart", function()
	_G["SkuNavRoutesView"]:StartMoving()
	end)
	f:SetScript("OnDragStop", function()
	_G["SkuNavRoutesView"]:StopMovingOrSizing()
	end)
	f:SetPoint("CENTER", 0, 0)
	--f:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
	--f:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT")
	f:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "",
	tile = false,
	tileSize = 0,
	edgeSize = 32,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f:SetMovable(true)
	f:EnableMouse(true)
	f:SetClampedToScreen(true)
	f:RegisterForDrag("LeftButton")
	f:Show()
end
]]
------------------------------------------------------------------------------------------------------------------------

function SkuNav:DrawTerrainData(aFrame)
	--SkuNav:ClearLines(aFrame)
	if SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true or not SkuCoreDB.TerrainData then
		return
	end
	local tExtMap = C_Map.GetBestMapForUnit("player")
	if not SkuCoreDB.TerrainData[tExtMap] then
		return
	end

	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	local fPlayerInstanceId = select(8, GetInstanceInfo())


	local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
	for ix, vx in pairs(SkuCoreDB.TerrainData[tExtMap]) do
		for iy, vy in pairs(vx) do
			if vy == true then
				local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
				local zoom = Minimap:GetZoom()
				local mapRadius = minimap_size[indoors][zoom]

				local x, y = -(fPlayerPosX - ix), (fPlayerPosY - iy) 
				x, y = x * ((mapRadius)/(minimap_size[indoors][5])), y  * ((mapRadius)/(minimap_size[indoors][5]))

				DrawLine(y, x, y + 1, x + 1, 0.8, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame)
			end

		end
	end
end

------------------------------------------------------------------------------------------------------------------------
local function ClearWaypoints()
	SkuLineRepo:ReleaseAll()
	SkuWaypointWidgetRepo:ReleaseAll()
end
local function DrawWaypointWidget(sx, sy, ex, ey, lineW, lineAlpha, r, g, b, aframe, aText, aWpColorR, aWpColorG, aWpColorB)
	local l = SkuWaypointWidgetRepo:Acquire()
	l:SetColorTexture(aWpColorR, aWpColorG, aWpColorB)
	l:SetSize(2, 2)
	l:SetDrawLayer("OVERLAY")
	l.aText = aText
	l.MMx = sx
	l.MMy = sy
	--l:SetParent(aframe)
	l:SetPoint("CENTER", aframe, "CENTER", sx, sy)
	l:Show()
	return l
end
local function DrawLine(sx, sy, ex, ey, lineW, lineAlpha, r, g, b, aframe, aForceAnchor)
	local frame = SkuLineRepo:Acquire()
	if not frame.line or aForceAnchor then
		frame:SetPoint("CENTER", aframe, "CENTER")
		frame:SetWidth(1)
		frame:SetHeight(1)
		frame:SetFrameStrata("TOOLTIP")
	end
	frame:Show()
	if not frame.line then
		frame.line = frame:CreateLine()
	end
	frame.line:SetThickness(lineW)
	frame.line:SetColorTexture(r, g, b, lineAlpha)
	frame.line:SetStartPoint("CENTER", sx, sy)
	frame.line:SetEndPoint("CENTER", ex, ey)
	--	frame.line:Show()
	return frame.line
end

-----------------------------------------------------------------------------------------------------------------------
local function DrawWaypoints(aFrame)
	if SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true then
		return
	end
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	if not fPlayerPosX or not fPlayerPosY then
		return
	end
	local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
	local tAreaId = SkuNav:GetCurrentAreaId()
	local indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	local zoom = Minimap:GetZoom()
	--local mapRadius = minimap_size[indoors][zoom]
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))

	local tForce
	if tOldMMZoom ~= zoom then
		tForce = true
	end
	tOldMMZoom = zoom
	if tOldMMScale ~= MinimapCluster:GetScale() then
		tForce = true
	end
	tOldMMScale = MinimapCluster:GetScale()

	tWpFrames =  {}
	tWpObjects =  {}
	--lastXY, lastYY = UnitPosition("player")

	local mapRadius = minimap_size[indoors][zoom] / 2
	local minimapWidth = Minimap:GetWidth() / 2
	local minimapHeight = Minimap:GetHeight() / 2

	for i, v in SkuNav:ListWaypoints(false, nil, tAreaId, tPlayerContintentId, nil) do
		local tWP = SkuNav:GetWaypoint(v)
		if tWP then
			local tFinalX, tFinalY = WorldPointToMinimapPoint(tWP.worldX, tWP.worldY)

			if not sfind(v, "OBJEKT") or SkuOptions.db.profile[MODULE_NAME].Waypoints[v] then
				if SkuOptions.db.profile[MODULE_NAME].Waypoints[v] then
					tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 0.8, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0, 0)
				else
					if tWP.spawnNr then
						if tWP.spawnNr > 3 then
							tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0.3, 0.7, 0.7)
						else
							tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7)
						end
					else
						tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7)
					end
				end
			else
				tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY,  1,   1, 0.8, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0, 0.7, 0)
			end
			tWpObjects[v] = tWP
		end
	end

	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		local tCurrentRouteName = v

		local tIsCurrentContinent = false

		local tWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[1]
		local tWP = tWpObjects[tWpName]
		if tWP then
			if tWP.contintentId == tPlayerContintentId then
				tIsCurrentContinent = true
			end
		end

		local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
		if SkuOptions.db.profile[MODULE_NAME].routeFollowing == true and SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute == v then
			tRouteColor = {r = 1, g = 1, b = 0, a = 1}
		end
		if (SkuOptions.db.profile[MODULE_NAME].routeRecording == true and SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute == tCurrentRouteName) then
			tRouteColor = {r = 1, g = 0, b = 1, a = 1}
		end

		if tIsCurrentContinent == true then
			local tPrevWpObj
			for q = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs do
				local tWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[q]
				local tWP = tWpObjects[tWpName]
				if tWP then
					local tWpPosx, tWpPosy = tWP.worldX, tWP.worldY
					local tWidgetTexture, tInUse = tWpFrames[tWpName], true
					if
						(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) == tWpName or 
						(SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP] == tWpName and SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute == tCurrentRouteName)
					then
						tWidgetTexture:SetSize(3, 3)
						--tWidgetTexture:SetColorTexture(0, 1, 0)

					else
						tWidgetTexture:SetSize(2, 2)
						--tWidgetTexture:SetColorTexture(1, 0, 0)
					end

					local point, relativeTo, relativePoint, xOfs, yOfs = tWidgetTexture:GetPoint(1)
					if relativeTo then
						--print(v, q, point, relativeTo:GetName(), relativePoint, xOfs, yOfs)
						local tPrevWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[q-1]
						if tPrevWpName  then
							local tPrevPinFrame, tPrevInUse = tWpFrames[tPrevWpName], true
							if tPrevInUse == true and tPrevPinFrame then
								local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tPrevPinFrame:GetPoint(1)

								if PrevrelativeTo then
									DrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 0.8, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, tForce)
								end
							end
						end
					end
					tPrevWpObj = tWP
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:DrawAll(aFrame)
	if not SkuWaypointWidgetRepo then
		SkuWaypointWidgetRepo = CreateTexturePool(aFrame, "OVERLAY")
	end
	if not SkuLineRepo then
		SkuLineRepo = CreateFramePool("Frame", aFrame)
	end

	if SkuDrawFlag == true then
		ClearWaypoints()
		--SkuNav:DrawTerrainData(aFrame)
		DrawWaypoints(aFrame)
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
		print("Nur Custom-Wegpunkte könnten gelöscht werden.")
	end
	return rValue
end



------------------------------------------------------------------------------------------------------------------------
-- new mm
------------------------------------------------------------------------------------------------------------------------
local function RotateTexture(TA, TB, TC, TD, TE, TF, x, y, size, obj)
	local ULx = ( TB*TF - TC*TE )             / (TA*TE - TB*TD) / size;
  local ULy = ( -(TA*TF) + TC*TD )          / (TA*TE - TB*TD)  / size;
  local LLx = ( -TB + TB*TF - TC*TE )       / size / (TA*TE - TB*TD);
  local LLy = ( TA - TA*TF + TC*TD )        / (TA*TE - TB*TD) / size;
  local URx = ( TE + TB*TF - TC*TE )        / size / (TA*TE - TB*TD);
  local URy = ( -TD - TA*TF + TC*TD )       / (TA*TE - TB*TD) / size;
  local LRx = ( TE - TB + TB*TF - TC*TE )   / size / (TA*TE - TB*TD);
  local LRy = ( -TD + TA -(TA*TF) + TC*TD ) / (TA*TE - TB*TD) / size;
  obj:SetTexCoord(ULx + x, ULy + y, LLx  + x, LLy  + y , URx + x , URy  + y, LRx + x , LRy + y );
end

local PreCalc = {["sin"] = {}, ["cos"] = {}} 
do 
	for x = -720, 720 do 
		PreCalc.sin[x] = sin(x) 
		PreCalc.cos[x] = cos(x) 
	end 
end

local oldtSkuNavMMZoom
function SkuNavDrawLine(sx, sy, ex, ey, lineW, lineAlpha, r, g, b, prt, lineframe, pA, pB) 
	if not sx or not sy or not ex or not ey then return nil end

	lineframe = SkuWaypointLineRepoMM:Acquire()
	if tSkuNavMMZoom < 1.75 then
		if lineframe:GetTexture() ~= "Interface\\AddOns\\Sku\\SkuNav\\assets\\line64" then lineframe:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\line64") end
	else
		if lineframe:GetTexture() ~= "Interface\\AddOns\\Sku\\SkuNav\\assets\\line" then lineframe:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\line") end
	end
	--lineframe.aText = "line"

	if sx == ex and sy == ey then 
		return nil 
	end
	local dx, dy = ex - sx, ey - sy
	local w, h = abs(dx), abs(dy)
	local d

	if w>h then 
		d = w
	else 
		d = h 
	end

	local tx = (sx + ex - d) / 2.0
	local ty = (sy + ey - d) / 2.0
	local a = atan2(dy, dx)
	local s = lineW * 16 / d	
	local ca = PreCalc.cos[floor(a)] / s 
	local sa = PreCalc.sin[floor(a)] / s

	lineframe:SetPoint("BOTTOMLEFT", pA ,"CENTER", tx, ty)
	lineframe:SetPoint("TOPRIGHT", pB, "CENTER", tx + d, ty + d)
	local C1, C2 = (1 + sa - ca) / 2.0, (1 - sa - ca) / 2.0
	lineframe:SetTexCoord(C1, C2, -sa+C1, ca+C2, ca+C1, sa+C2, ca-sa+C1, ca+sa+C2)
	lineframe:SetVertexColor(r, g, b, lineAlpha)
	lineframe:Show()

	--return lineframe
end

local tContintentIdDataSubstrings = {
	[0] = "azeroth",
	[1] = "kalimdor",
	[369] = "",
	[530] = "expansion01",
}
local currentContinentId
local function SkuNavMMUpdateContent()
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	if currentContinentId ~= tPlayerContinentID then
		currentContinentId = tPlayerContinentID
		if tContintentIdDataSubstrings[currentContinentId] then
			for tx = 1, 63, 1 do
				local tPrevFrame
				for ty = 1, 63, 1 do
					_G["SkuMapTile_"..tx.."_"..ty].mapTile:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\MinimapData\\"..tContintentIdDataSubstrings[currentContinentId].."\\map"..(tx - 1).."_"..(64 - (ty - 1))..".blp")
				end
			end
		end
	end

	local tContentFrame = _G["SkuNavMMMainFrameScrollFrameMapMain"]
	for x = 1, #tSkuNavMMContent do
		if tSkuNavMMContent[x].obj.tRender == true then
			local mX, mY = 0, 0
			local tX = tSkuNavMMContent[x].x + tSkuNavMMPosX - (mX * tSkuNavMMZoom)
			local tY = tSkuNavMMContent[x].y + tSkuNavMMPosY - (mY * tSkuNavMMZoom)
			tX = tX * tSkuNavMMZoom
			tY = tY * tSkuNavMMZoom
			tX = tX + (mX * tSkuNavMMZoom)
			tY = tY + (mY * tSkuNavMMZoom)
			tSkuNavMMContent[x].obj:SetPoint("CENTER", tContentFrame, "CENTER", tX, tY)
		end
		tSkuNavMMContent[x].obj:SetSize(tSkuNavMMContent[x].w * tSkuNavMMZoom, tSkuNavMMContent[x].h * tSkuNavMMZoom)
	end
	if UnitPosition("player") then
		_G["playerArrow"]:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameMapMainDraw1"], "CENTER", SkuNavMMWorldToContent(UnitPosition("player")))
	end

	--[[
	for tx = 1, 63, 1 do
		for ty = 1, 63, 1 do
			_G["SkuMapTile_"..tx.."_"..ty].tileindext:SetTextHeight(18 * tSkuNavMMZoom)	
			if tSkuNavMMZoom < 0.04 then
				_G["SkuMapTile_"..tx.."_"..ty].borderTex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border64.tga")
			elseif tSkuNavMMZoom < 0.07 then
				_G["SkuMapTile_"..tx.."_"..ty].borderTex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border128.tga")
			elseif tSkuNavMMZoom < 0.3 then
				_G["SkuMapTile_"..tx.."_"..ty].borderTex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border256.tga")
			elseif tSkuNavMMZoom < 0.5 then
				_G["SkuMapTile_"..tx.."_"..ty].borderTex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border512.tga")
			else
				_G["SkuMapTile_"..tx.."_"..ty].borderTex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border1024.tga")
			end
		end
	end
	]]
end

------------------------------------------------------------------------------------------------------------------------
local function ClearWaypointsMM()
	SkuWaypointWidgetRepoMM:ReleaseAll()
	SkuWaypointLineRepoMM:ReleaseAll()
end
function SkuNavDrawWaypointWidgetMM(sx, sy, ex, ey, lineW, lineAlpha, r, g, b, aframe, aText, aWpColorR, aWpColorG, aWpColorB, aWpColorA, aComments)
	aWpColorA = aWpColorA or 1
	local l = SkuWaypointWidgetRepoMM:Acquire()
	l:SetParent(_G["SkuNavMMMainFrameScrollFrameMapMainDraw1"])
	l:SetColorTexture(aWpColorR, aWpColorG, aWpColorB, aWpColorA)
	l:SetSize(lineW * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (2 - tSkuNavMMZoom), lineW * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (2 - tSkuNavMMZoom))
	l:SetDrawLayer("ARTWORK")
	l.aText = aText
	l.aComments = aComments
	l.MMx = sx
	l.MMy = sy
	l:SetPoint("CENTER", aframe, "CENTER", sx, sy)
	l:Show()
	return l
end
-----------------------------------------------------------------------------------------------------------------------
local function DrawPolyZonesMM(aFrame)
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
	for x = 1, #SkuDB.Polygons.data do
		if SkuDB.Polygons.data[x].continentId == tPlayerContintentId then		
			if #SkuDB.Polygons.data[x].nodes > 2 then
				local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
				for line = 2, #SkuDB.Polygons.data[x].nodes do
					local tRouteColor = SkuDB.Polygons.eTypes[SkuDB.Polygons.data[x].type][2][SkuDB.Polygons.data[x].subtype][2]
					local x1, y1 = SkuNavMMWorldToContent(SkuDB.Polygons.data[x].nodes[line].x, SkuDB.Polygons.data[x].nodes[line].y)
					local tP1Obj = SkuNavDrawWaypointWidgetMM(x1, y1, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 0)
					local point, relativeTo, relativePoint, xOfs, yOfs = tP1Obj:GetPoint(1)

					local x2, y2 = SkuNavMMWorldToContent(SkuDB.Polygons.data[x].nodes[line-1].x, SkuDB.Polygons.data[x].nodes[line-1].y)
					local tP2Obj = SkuNavDrawWaypointWidgetMM(x2, y2, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 0)
					local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tP2Obj:GetPoint(1)

					if PrevrelativeTo then
						SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, aFrame, nil, relativeTo, PrevrelativeTo) 
					end
					if line == #SkuDB.Polygons.data[x].nodes then
						local x2, y2 = SkuNavMMWorldToContent(SkuDB.Polygons.data[x].nodes[1].x, SkuDB.Polygons.data[x].nodes[1].y)
						local tP2Obj = SkuNavDrawWaypointWidgetMM(x2, y2, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 0)
						local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tP2Obj:GetPoint(1)
						if PrevrelativeTo then
							SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, aFrame, nil, relativeTo, PrevrelativeTo) 
						end
					end
				end
			else
				--print("error - broken polygon:", x)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------
function SkuNavDrawWaypointsMM(aFrame)
	if SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true then
		--return
	end
	local fPlayerPosX, fPlayerPosY = UnitPosition("player")
	if not fPlayerPosX or not fPlayerPosY then
		return
	end
	local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
	local tAreaId = SkuNav:GetCurrentAreaId()
	--local mapRadius = minimap_size[indoors][zoom]
	local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))

	tWpFrames = {}
	tWpObjects = {}

--local tCounted = 0
--custom;
	for i, v in SkuNav:ListWaypoints(false, nil, tAreaId, tPlayerContintentId, nil) do
		local tWP = SkuNav:GetWaypoint(v)
		if tWP then
			if tWP.worldX and tWP.worldY then
				local tFinalX, tFinalY = SkuNavMMWorldToContent(tWP.worldX, tWP.worldY)
				if tFinalX > -(tTileSize * 1.5) and tFinalX < (tTileSize * 1.5) and tFinalY > -(tTileSize * 1.5) and tFinalY < (tTileSize * 1.5) then
--tCounted	= tCounted + 1
					if not sfind(v, "OBJEKT") or SkuOptions.db.profile[MODULE_NAME].Waypoints[v] then
						if SkuOptions.db.profile[MODULE_NAME].Waypoints[v] then
							tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0, 0, 1, tWP.comments)
						else
							if tWP.spawnNr then
								if tWP.spawnNr > 3 then
									tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0.3, 0.7, 0.7, 1, tWP.comments)
								else
									tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7, 1, tWP.comments)
								end
							else
								tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7, 1, tWP.comments)
							end
						end
					else
						tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY,  1,   1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0, 0.7, 0, 1, tWP.comments)
					end
				end
				tWpObjects[v] = tWP
			end
		end
	end
--print(tCounted)
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		local tCurrentRouteName = v

		local tIsCurrentContinent = false

		local tWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[1]
		local tWP = tWpObjects[tWpName]
		if tWP then
			if tWP.contintentId == tPlayerContintentId then
				tIsCurrentContinent = true
			end
		end

		local tRouteColor = {r = 1, g = 1, b = 1, a = 1}
		if SkuOptions.db.profile[MODULE_NAME].routeFollowing == true and SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute == v then
			tRouteColor = {r = 1, g = 1, b = 0, a = 1}
		end
		if (SkuOptions.db.profile[MODULE_NAME].routeRecording == true and SkuOptions.db.profile[MODULE_NAME].routeRecordingForRoute == tCurrentRouteName) then
			tRouteColor = {r = 1, g = 0, b = 1, a = 1}
		end

		if tIsCurrentContinent == true then
			local tPrevWpObj
			for q = 1, #SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs do
				local tWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[q]
				local tWP = tWpObjects[tWpName]
				if tWP then
					local tWpPosx, tWpPosy = tWP.worldX, tWP.worldY
					local tWidgetTexture, tInUse = tWpFrames[tWpName], true
					if tWidgetTexture then
						if tWidgetTexture:IsVisible() then
							if
								(SkuOptions.db.profile[MODULE_NAME].selectedWaypoint) == tWpName or 
								(SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[SkuOptions.db.profile[MODULE_NAME].routeFollowingCurrentWP] == tWpName and SkuOptions.db.profile[MODULE_NAME].routeFollowingRoute == tCurrentRouteName)
							then
								tWidgetTexture:SetSize(5 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom), 5 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2  + (3 - tSkuNavMMZoom))
								--tWidgetTexture:SetColorTexture(0, 1, 0)

							else
								tWidgetTexture:SetSize(4 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom), 4 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom))
								--tWidgetTexture:SetColorTexture(1, 0, 0)
							end

							local point, relativeTo, relativePoint, xOfs, yOfs = tWidgetTexture:GetPoint(1)
							if relativeTo then
								--print(v, q, point, relativeTo:GetName(), relativePoint, xOfs, yOfs)
								local tPrevWpName = SkuOptions.db.profile[MODULE_NAME].Routes[tCurrentRouteName].WPs[q-1]
								if tPrevWpName  then
									local tPrevPinFrame, tPrevInUse = tWpFrames[tPrevWpName], true
									if tPrevInUse == true and tPrevPinFrame then
										local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tPrevPinFrame:GetPoint(1)
										if PrevrelativeTo then
											SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, aFrame, nil, relativeTo, PrevrelativeTo) 
										end
									end
								end
							end
							tPrevWpObj = tWP
						end
					end
				end
			end
		end
	end
end


local function CreateButtonFrameTemplate(aName, aParent, aText, aWidth, aHeight, aPoint, aRelativeTo, aAnchor, aOffX, aOffY)
	local tWidget = CreateFrame("Frame",aName, aParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
	tWidget:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
	tWidget:SetBackdropColor(0.3, 0.3, 0.3, 1)
	tWidget:SetWidth(aWidth)  
	tWidget:SetHeight(aHeight) 
	tWidget:SetPoint(aPoint, aRelativeTo,aAnchor, aOffX, aOffY)
	tWidget:SetMouseClickEnabled(true)
	tWidget:SetScript("OnEnter", function(self) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 1, right = 1, top = 1, bottom = 1 }})
		self:SetBackdropColor(0.5, 0.5, 0.5, 1)
	end)
	tWidget:SetScript("OnLeave", function(self) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
		self:SetBackdropColor(0.3, 0.3, 0.3, 1)
	end)
	tWidget:SetScript("OnMouseUp", function(self, button) 
		--print(button)
	end)
	fs = tWidget:CreateFontString(aName.."Text", "OVERLAY", "GameTooltipText")
	fs:SetTextHeight(12)
	fs:SetPoint("CENTER", tWidget, "CENTER")
	fs:Show()
	tWidget.Text = fs
	tWidget.SetText = function(self, aText)
		self.Text:SetText(aText)
	end
	tWidget:SetText(aText)
	tWidget:Show()
	return tWidget
end

local function StartPolyRecording(aType, aSubtype)
	if tRecordingPoly == 0 then
		tRecordingPoly = aType
		tRecordingPolySub = aSubtype
		local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
		SkuDB.Polygons.data[#SkuDB.Polygons.data + 1] = {
			continentId = tPlayerContinentID,
			nodes = {},
			type = tRecordingPoly,
			subtype = tRecordingPolySub,
		}
		tRecordingPolyFor = #SkuDB.Polygons.data
		print("recording started", SkuDB.Polygons.eTypes[tRecordingPoly][2][tRecordingPolySub][1], "ds:", tRecordingPolyFor)
	else
		print("recording in process: ", SkuDB.Polygons.eTypes[tRecordingPoly][2][tRecordingPolySub][1])
	end
end

function SkuNavMMOpen()
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed or true
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth or 200
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight or 200
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX or UIParent:GetWidth() / 2
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY or UIParent:GetHeight() / 2

	if SkuOptions.db.profile[MODULE_NAME].showSkuMM == true then
		tCacheNbWpsTimerRate = 10
		if tCacheNbWpsTimer then
			tCacheNbWpsTimer:Cancel()
			tCacheNbWpsTimer = nil
			--print("SkuNav: Caching stopped")
		end

		if not _G["SkuNavMMMainFrame"] then
			local MainFrameObj = CreateFrame("Frame", "SkuNavMMMainFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
			--MainFrameObj:SetFrameStrata("HIGH")
			MainFrameObj.ScrollValue = 0
			MainFrameObj:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			MainFrameObj:SetHeight(500) --275
			MainFrameObj:SetWidth(800)
			MainFrameObj:EnableMouse(true)
			MainFrameObj:SetScript("OnDragStart", function(self) self:StartMoving() end)
			MainFrameObj:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing()
				SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX = _G["SkuNavMMMainFrame"]:GetLeft()
				SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY = _G["SkuNavMMMainFrame"]:GetBottom()
				_G["SkuNavMMMainFrame"]:ClearAllPoints()
				_G["SkuNavMMMainFrame"]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX, SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY)

			end)
			MainFrameObj:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
			MainFrameObj:SetBackdropColor(1, 1, 1, 1)
			MainFrameObj:SetMovable(true)
			MainFrameObj:SetClampedToScreen(true)
			MainFrameObj:RegisterForDrag("LeftButton")
			MainFrameObj:Show()

			-- Resizable
			MainFrameObj:SetResizable(true)
			MainFrameObj:SetMinResize(200, 200)
			local rb = CreateFrame("Button", "SkuNavMMMainFrameResizeButton", _G["SkuNavMMMainFrame"])
			rb:SetPoint("BOTTOMRIGHT", 0, 0)
			rb:SetSize(16, 16)
			rb:SetNormalTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\resize.tga")
			rb:SetHighlightTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\resize_hightlighted.tga")
			rb:SetPushedTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\resize_hightlighted.tga")
			local tRbIsDrag = false
			rb:SetScript("OnUpdate", function(self, button)
				if SkuOptions.db.profile[MODULE_NAME].showSkuMM == true then
					if tRbIsDrag == true then
						self:GetHighlightTexture():Show()
						if self:GetParent():GetWidth() < 200 +  _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() then self:GetParent():SetWidth(200  + _G["SkuNavMMMainFrameOptionsParent"]:GetWidth()) end
						if self:GetParent():GetHeight() < 200 then self:GetParent():SetHeight(200) end
						_G["SkuNavMMMainFrameScrollFrame"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
						_G["SkuNavMMMainFrameScrollFrame"]:SetHeight(self:GetParent():GetHeight() - 10)
						_G["SkuNavMMMainFrameScrollFrame1"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
						_G["SkuNavMMMainFrameScrollFrame1"]:SetHeight(self:GetParent():GetHeight() - 10)

						_G["SkuNavMMMainFrameScrollFrameContent"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
						_G["SkuNavMMMainFrameScrollFrameContent"]:SetHeight(self:GetParent():GetHeight() - 10)
						_G["SkuNavMMMainFrameScrollFrameContent1"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
						_G["SkuNavMMMainFrameScrollFrameContent1"]:SetHeight(self:GetParent():GetHeight() - 10)

						--SkuOptions.db.profile["SkuNav"].SkuNavMMMainWidth = self:GetParent():GetWidth()
						--SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight = self:GetParent():GetHeight()
					end
				end
			end)
			rb:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					_G["SkuNavMMMainEditBoxEditBox"]:ClearFocus()
					self:GetParent():StartSizing("BOTTOMRIGHT")
					self:GetHighlightTexture():Hide() -- more noticeable
					tRbIsDrag = true
				end
			end)
			rb:SetScript("OnMouseUp", function(self, button)
				self:GetParent():StopMovingOrSizing()
				self:GetHighlightTexture():Show()
				_G["SkuNavMMMainFrameScrollFrame"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
				_G["SkuNavMMMainFrameScrollFrame"]:SetHeight(self:GetParent():GetHeight() - 10)
				_G["SkuNavMMMainFrameScrollFrame1"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
				_G["SkuNavMMMainFrameScrollFrame1"]:SetHeight(self:GetParent():GetHeight() - 10)

				_G["SkuNavMMMainFrameScrollFrameContent"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
				_G["SkuNavMMMainFrameScrollFrameContent"]:SetHeight(self:GetParent():GetHeight() - 10)
				_G["SkuNavMMMainFrameScrollFrameContent1"]:SetWidth(self:GetParent():GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
				_G["SkuNavMMMainFrameScrollFrameContent1"]:SetHeight(self:GetParent():GetHeight() - 10)
		
				SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth = self:GetParent():GetWidth()
				SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight = self:GetParent():GetHeight()

				tRbIsDrag = false
			end)

			--collapse
			local rb = CreateFrame("Button", "SkuNavMMMainCollapseButton", _G["SkuNavMMMainFrame"])
			rb:SetPoint("LEFT")
			rb:SetSize(16, 16)
			rb:SetNormalTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\expand1.tga")
			rb:SetHighlightTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\expand_hightlighted1.tga")
			rb:SetPushedTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\expand_hightlighted1.tga")
			rb:SetScript("OnMouseUp", function(self, button)
				self:GetHighlightTexture():Show()
				if _G["SkuNavMMMainFrameOptionsParent"]:IsShown() then
					_G["SkuNavMMMainFrameOptionsParent"]:SetWidth(0)
					_G["SkuNavMMMainFrameOptionsParent"]:Hide()
					_G["SkuNavMMMainFrame"]:ClearAllPoints()
					_G["SkuNavMMMainFrame"]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (_G["SkuNavMMMainFrame"]:GetLeft() + 300 ), (_G["SkuNavMMMainFrame"]:GetBottom()))
					_G["SkuNavMMMainFrame"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() - 300)

					_G["SkuNavMMMainFrameScrollFrame"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
					_G["SkuNavMMMainFrameScrollFrame1"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
					SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed = true
		
				else
					_G["SkuNavMMMainFrameOptionsParent"]:Show()
					_G["SkuNavMMMainFrameOptionsParent"]:SetWidth(300)
					_G["SkuNavMMMainFrame"]:ClearAllPoints()
					_G["SkuNavMMMainFrame"]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (_G["SkuNavMMMainFrame"]:GetLeft() - 300 ), (_G["SkuNavMMMainFrame"]:GetBottom()))
					_G["SkuNavMMMainFrame"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() + 300)
					_G["SkuNavMMMainFrameScrollFrame"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
					_G["SkuNavMMMainFrameScrollFrame1"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
					SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed = false
				end
			end)

			----------------------------menu
			--buttons
			local tFocusOnPlayer = true

			local tMain = _G["SkuNavMMMainFrame"]
			--map texture parent frame
			local f1 = CreateFrame("Frame", "SkuNavMMMainFrameOptionsParent", tMain, BackdropTemplateMixin and "BackdropTemplate" or nil)
			f1:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 32, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
			f1:SetBackdropColor(1, 1, 1, 1)
			f1:SetWidth(300)  
			f1:SetHeight(200) 
			f1:SetPoint("TOPLEFT", tMain, "TOPLEFT", 0, 0)
			f1:EnableMouse(false)
			f1:Show()

			local tOptionsParent = _G["SkuNavMMMainFrameOptionsParent"]
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFollow", tOptionsParent, "Follow", 100, 20, "TOPLEFT", tOptionsParent, "TOPLEFT", 3, -3)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				tFocusOnPlayer = true
			end)

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameWorldStart", tOptionsParent, "World Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFollow"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(1, 1)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFlyStart", tOptionsParent, "Fly Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameWorldStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(2, 1)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFactionAStart", tOptionsParent, "Ally Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFlyStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(3, 1)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFactionHStart", tOptionsParent, "Horde Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFactionAStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(3, 2)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFactionAldorStart", tOptionsParent, "Aldor Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFactionHStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(3, 3)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFactionScryerStart", tOptionsParent, "Scryer Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFactionAldorStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(3, 4)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameOthertart", tOptionsParent, "Other Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFactionScryerStart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				StartPolyRecording(4, 1)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameEnd", tOptionsParent, "End", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameOthertart"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				if tRecordingPoly > 0 then
					if #SkuDB.Polygons.data[tRecordingPolyFor].nodes > 0 then
						print("recording completed > saved", SkuDB.Polygons.eTypes[tRecordingPoly][2][tRecordingPolySub][1], "ds:", tRecordingPolyFor)
					else
						print("recording completed, but no nodes > wasted", SkuDB.Polygons.eTypes[tRecordingPoly][2][tRecordingPolySub][1], "ds:", tRecordingPolyFor)
					end
					tRecordingPoly = 0
					tRecordingPolySub = 0
					tRecordingPolyFor = nil
				else
					print("no recording in process: ")--, SkuDB.Polygons.eTypes[tRecordingPoly][2][tRecordingPolySub][1])
				end
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameWrite", tOptionsParent, "Write", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameFollow"], "TOPLEFT", 100, 0)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				local tStr = tostring(SkuDB.Polygons.data)
				_G["SkuNavMMMainEditBoxEditBox"]:SetText(tStr)
			end)
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameRead", tOptionsParent, "Read", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameWrite"], "TOPLEFT", 95, 0)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				local tStr = tostring(SkuDB.Polygons.data)
				local f = assert(loadstring("return {".._G["SkuNavMMMainEditBoxEditBox"]:GetText().."}"), "invalid")
				SkuDB.Polygons.data = f()
				setmetatable(SkuDB.Polygons.data, SkuPrintMT)
				_G["SkuNavMMMainEditBoxEditBox"]:ClearFocus()
			end)

			-- EditBox
			local f = CreateFrame("Frame", "SkuNavMMMainFrameEditBox", tOptionsParent, BackdropTemplateMixin and "BackdropTemplate" or nil)--, "DialogBoxFrame")
			f:SetPoint("TOPLEFT", _G["SkuNavMMMainFrameWrite"], "TOPLEFT", 2, -20)
			f:SetSize(170,170)
			f:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",edgeFile = "", Size = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 },})
			f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue
			f:Show()
			local sf = CreateFrame("ScrollFrame", "SkuNavMMMainEditBoxScrollFrame", _G["SkuNavMMMainFrameEditBox"], "UIPanelScrollFrameTemplate")
			sf:SetPoint("TOPLEFT", _G["SkuNavMMMainFrameEditBox"], "TOPLEFT", 0, 0)
			sf:SetSize(f:GetSize())
			sf:SetWidth(f:GetWidth() - 5)

			local eb = CreateFrame("EditBox", "SkuNavMMMainEditBoxEditBox", _G["SkuNavMMMainEditBoxScrollFrame"])
			eb:SetSize(f:GetSize())
			eb:SetMultiLine(true)
			eb:SetAutoFocus(false)
			eb:SetFontObject("ChatFontSmall")
			eb:SetScript("OnEscapePressed", function(self) 
				_G["SkuNavMMMainEditBoxEditBox"]:ClearFocus()
				PlaySound(89)
			end)
			eb:SetScript("OnTextSet", function(self)
				_G["SkuNavMMMainEditBoxEditBox"]:ClearFocus()
			end)
			sf:SetScrollChild(eb)

			----------------------------map
			--map frame main container
			local scrollFrameObj = CreateFrame("ScrollFrame", "SkuNavMMMainFrameScrollFrame", _G["SkuNavMMMainFrame"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			scrollFrameObj:SetFrameStrata("HIGH")
			scrollFrameObj.ScrollValue = 0
			scrollFrameObj:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
			scrollFrameObj:SetHeight(490)
			scrollFrameObj:SetWidth(490)

			-- scrollframe container object
			local contentObj = CreateFrame("Frame", "SkuNavMMMainFrameScrollFrameContent", scrollFrameObj)
			scrollFrameObj.Content = contentObj
			contentObj:SetHeight(490)
			contentObj:SetWidth(490)
			contentObj:SetPoint("TOPLEFT", scrollFrameObj, "TOPLEFT")
			contentObj:SetPoint("BOTTOMRIGHT", scrollFrameObj, "BOTTOMRIGHT")
			scrollFrameObj:SetScrollChild(contentObj)
			contentObj:Show()
			local SkuNavMMMainFrameScrollFrameContenttTime = 0
			local SkuNavMMMainFrameScrollFrameContentDraging = false
			contentObj:SetScript("OnUpdate", function(self, time)
				SkuNavMMMainFrameScrollFrameContenttTime = SkuNavMMMainFrameScrollFrameContenttTime + time
				if SkuNavMMMainFrameScrollFrameContenttTime > 0.1 then
					if SkuNavMMMainFrameScrollFrameContentDraging == true then
						local tEndX, tEndY = SkuNavMMGetCursorPositionContent2()
						tSkuNavMMPosX = tSkuNavMMPosX + ((tEndX - self.tStartMoveX) / tSkuNavMMZoom)
						tSkuNavMMPosY = tSkuNavMMPosY + ((tEndY - self.tStartMoveY) / tSkuNavMMZoom)
						SkuNavMMUpdateContent()
						self.tStartMoveX, self.tStartMoveY = SkuNavMMGetCursorPositionContent2()
					end
					SkuNavMMUpdateContent()			
					SkuNavMMMainFrameScrollFrameContenttTime = 0
				end
				--[[
				local x, y = UnitPosition("player")
				print("player", x, y)
				local tEndX, tEndY = SkuNavMMGetCursorPositionContent2()
				print("cursor", tEndX, tEndY)
				local twy, twx = SkuNavMMContentToWorld(tEndX, tEndY)
				print("world", twx, twy)
				local tmx, tmy = SkuNavMMWorldToContent(twx, twy)
				print("map", tmx, tmy)
				]]
			end)
			contentObj:SetScript("OnMouseWheel", function(self, dir)
				tSkuNavMMZoom = tSkuNavMMZoom + ((dir / 10) * tSkuNavMMZoom)
				if tSkuNavMMZoom < 0.01 then
					tSkuNavMMZoom = 0.01
				end
				if tSkuNavMMZoom > 150 then
					tSkuNavMMZoom = 150
				end
				SkuNavMMUpdateContent()
			end)
			contentObj:SetScript("OnMouseDown", function(self, button)
				--print(button)
				if button == "LeftButton" then
					self.tStartMoveX, self.tStartMoveY = SkuNavMMGetCursorPositionContent2()
					SkuNavMMMainFrameScrollFrameContentDraging = true
					tFocusOnPlayer = false
				end
				if button == "RightButton" then

				end
			end)
			contentObj:SetScript("OnMouseUp", function(self, button)
				--print(button)
				if button == "LeftButton" then
					local tEndX, tEndY = SkuNavMMGetCursorPositionContent2()
					tSkuNavMMPosX = tSkuNavMMPosX + ((tEndX - self.tStartMoveX) / tSkuNavMMZoom)
					tSkuNavMMPosY = tSkuNavMMPosY + ((tEndY - self.tStartMoveY) / tSkuNavMMZoom)
					SkuNavMMUpdateContent()
					self.tStartMoveX = nil
					self.tStartMoveY = nil
					SkuNavMMMainFrameScrollFrameContentDraging = false
				end
				if button == "RightButton" then

				end
			end)

			--map texture parent frame
			local f1 = CreateFrame("Frame", "SkuNavMMMainFrameScrollFrameMapMain", _G["SkuNavMMMainFrameScrollFrameContent"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			f1:SetWidth(490)  
			f1:SetHeight(490) 
			f1:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 32, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
			f1:SetBackdropColor(1, 1, 1, 1)
			f1:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameContent"], "CENTER", 0, 0)
			f1:EnableMouse(false)
			f1:Show()

			--tiles
			for tx = 1, 63, 1 do
				local tPrevFrame
				for ty = 1, 63, 1 do
					local f1 = CreateFrame("Frame", "SkuMapTile_"..tx.."_"..ty, _G["SkuNavMMMainFrameScrollFrameMapMain"])
					f1:SetWidth(tTileSize)
					f1:SetHeight(tTileSize)
					if ty == 1 then
						f1:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameMapMain"], "CENTER", tTileSize * (tx - 32) +  (tTileSize/2), tTileSize * (ty - 32) +  (tTileSize/2))
						f1.tRender = true
					else
						f1:SetPoint("BOTTOM", tPrevFrame, "TOP", 0, 0)
					end
					tPrevFrame = f1
					local tex = f1:CreateTexture(nil, "BACKGROUND")
					tex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\MinimapData\\expansion01\\map"..(tx - 1).."_"..(64 - (ty - 1))..".blp")
					tex:SetAllPoints()
					f1.mapTile = tex
					--[[
					local tex = f1:CreateTexture(nil, "BORDER")
					tex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\tile_border1024.tga")
					tex:SetAllPoints()
					f1.borderTex = tex
					--tex:SetColorTexture(1, 1, 1, 1)
					fs = f1:CreateFontString(f1, "OVERLAY", "GameTooltipText")
					f1.tileindext = fs
					fs:SetTextHeight(14 / tSkuNavMMZoom)
					fs:SetText((tx - 1).."_"..(64 - (ty - 1)))
					fs:SetPoint("TOPLEFT", 15, -15)
					]]
					f1:Show()
					local _, _, _, x, y = f1:GetPoint(1)
					tSkuNavMMContent[#tSkuNavMMContent + 1] = {
						obj = f1,
						x = x,
						y = y,
						w = f1:GetWidth(),
						h = f1:GetHeight(),
					}
				end
			end

			local f1 = CreateFrame("Frame","SkuNavMMMainFrameScrollFrameMapMainDraw", _G["SkuNavMMMainFrameScrollFrameMapMain"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			--f1:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 32, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
			--f1:SetBackdropColor(0, 0, 1, 1)
			f1:SetWidth(490)  
			f1:SetHeight(490) 
			f1:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameMapMain"], "CENTER", 0, 0)
			f1:SetFrameStrata("HIGH")
			f1:Show()

			----------------------------rts/wps
			--map frame main container
			local scrollFrameObj = CreateFrame("ScrollFrame", "SkuNavMMMainFrameScrollFrame1", _G["SkuNavMMMainFrame"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			scrollFrameObj:SetFrameStrata("FULLSCREEN_DIALOG")
			scrollFrameObj.ScrollValue = 0
			--scrollFrameObj:SetPoint("RIGHT", _G["SkuNavMMMainFrame"], "RIGHT", -5, 0)
			scrollFrameObj:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
			scrollFrameObj:SetHeight(490)
			scrollFrameObj:SetWidth(490)

			-- scrollframe container object
			local contentObj = CreateFrame("Frame", "SkuNavMMMainFrameScrollFrameContent1", scrollFrameObj)
			scrollFrameObj.Content = contentObj
			contentObj:SetHeight(490)
			contentObj:SetWidth(490)
			contentObj:SetPoint("TOPLEFT", scrollFrameObj, "TOPLEFT")
			contentObj:SetPoint("BOTTOMRIGHT", scrollFrameObj, "BOTTOMRIGHT")
			scrollFrameObj:SetScrollChild(contentObj)
			contentObj:Show()
			local SkuNavMMMainFrameScrollFrameContenttTime1 = 0
			contentObj:SetScript("OnUpdate", function(self, time)
				if SkuOptions.db.profile[MODULE_NAME].showSkuMM == true then
					SkuNavMMMainFrameScrollFrameContenttTime1 = SkuNavMMMainFrameScrollFrameContenttTime1 + time
					if SkuNavMMMainFrameScrollFrameContentDraging == true then
						ClearWaypointsMM()
						SkuNavDrawWaypointsMM(_G["SkuNavMMMainFrameScrollFrameContent1"])
						DrawPolyZonesMM(_G["SkuNavMMMainFrameScrollFrameContent1"])
					else
						if SkuNavMMMainFrameScrollFrameContenttTime1 > 0.1 then
							if tFocusOnPlayer == true then
								local tPx, tPy = UnitPosition("player")
								if tPx then
									tSkuNavMMPosX = tPy - tYardsPerTile
									tSkuNavMMPosY = -tPx - (tYardsPerTile * 2)
								end
							end
							ClearWaypointsMM()
							SkuNavDrawWaypointsMM(_G["SkuNavMMMainFrameScrollFrameContent1"])
							DrawPolyZonesMM(_G["SkuNavMMMainFrameScrollFrameContent1"])
							local facing = GetPlayerFacing()
							if facing then
								RotateTexture(math.cos(-facing), -math.sin(-facing),0.5,math.sin(-facing), math.cos(-facing),0.5, 0.5, 0.5, 1, _G["playerArrow"])
							end

							SkuNavMMMainFrameScrollFrameContenttTime1 = 0
						end
					end
				end
			end)

			--map texture parent frame
			local f1 = CreateFrame("Frame", "SkuNavMMMainFrameScrollFrameMapMain1", _G["SkuNavMMMainFrameScrollFrameContent1"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			f1:SetWidth(490)  
			f1:SetHeight(490) 
			f1:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameContent1"], "CENTER", 0, 0)
			f1:EnableMouse(false)
			f1:Show()

			local f1 = CreateFrame("Frame","SkuNavMMMainFrameScrollFrameMapMainDraw1", _G["SkuNavMMMainFrameScrollFrameMapMain1"], BackdropTemplateMixin and "BackdropTemplate" or nil)
			f1:SetWidth(490)  
			f1:SetHeight(490) 
			f1:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameMapMain1"], "CENTER", 0, 0)
			f1:SetFrameStrata("TOOLTIP")
			f1:Show()

			local tex = f1:CreateTexture("playerArrow", "BACKGROUND")
			tex:SetTexture("Interface\\AddOns\\Sku\\SkuNav\\assets\\player_arrow.tga")
			tex:SetSize(30,30)
			tex:SetPoint("CENTER", _G["SkuNavMMMainFrameScrollFrameMapMainDraw1"], "CENTER", 0, 0)--_G["playerArrow"]

		end
		_G["SkuNavMMMainFrame"]:Show()

		if not SkuWaypointWidgetRepoMM then
			SkuWaypointWidgetRepoMM = CreateTexturePool(_G["SkuNavMMMainFrameScrollFrameMapMainDraw1"], "ARTWORK")
		end
		if not SkuWaypointLineRepoMM then
			SkuWaypointLineRepoMM = CreateTexturePool(_G["SkuNavMMMainFrameScrollFrameMapMainDraw1"], "ARTWORK")
		end

		--restore mm visual from saved vars
		if SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed == true then
			_G["SkuNavMMMainFrameOptionsParent"]:SetWidth(0)
			_G["SkuNavMMMainFrameOptionsParent"]:Hide()
			_G["SkuNavMMMainFrameScrollFrame"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
			_G["SkuNavMMMainFrameScrollFrame1"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)

		else
			_G["SkuNavMMMainFrameOptionsParent"]:SetWidth(300)
			_G["SkuNavMMMainFrameOptionsParent"]:Show()
			_G["SkuNavMMMainFrameScrollFrame"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
			_G["SkuNavMMMainFrameScrollFrame1"]:SetPoint("TOPLEFT", _G["SkuNavMMMainFrame"], "TOPLEFT", _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() + 5, -5)
		end

		_G["SkuNavMMMainFrame"]:ClearAllPoints()
		_G["SkuNavMMMainFrame"]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth(), SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY)
		_G["SkuNavMMMainFrame"]:SetWidth(SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth + _G["SkuNavMMMainFrameOptionsParent"]:GetWidth())
		_G["SkuNavMMMainFrame"]:SetHeight(SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight)

		_G["SkuNavMMMainFrameScrollFrame"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
		_G["SkuNavMMMainFrameScrollFrame"]:SetHeight(_G["SkuNavMMMainFrame"]:GetHeight() - 10)
		_G["SkuNavMMMainFrameScrollFrame1"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
		_G["SkuNavMMMainFrameScrollFrame1"]:SetHeight(_G["SkuNavMMMainFrame"]:GetHeight() - 10)

		_G["SkuNavMMMainFrameScrollFrameContent"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
		_G["SkuNavMMMainFrameScrollFrameContent"]:SetHeight(_G["SkuNavMMMainFrame"]:GetHeight() - 10)
		_G["SkuNavMMMainFrameScrollFrameContent1"]:SetWidth(_G["SkuNavMMMainFrame"]:GetWidth() - _G["SkuNavMMMainFrameOptionsParent"]:GetWidth() - 10)
		_G["SkuNavMMMainFrameScrollFrameContent1"]:SetHeight(_G["SkuNavMMMainFrame"]:GetHeight() - 10)

	else
		if _G["SkuNavMMMainFrame"] then
			_G["SkuNavMMMainFrame"]:Hide()
			SkuNeighbCache = {}
			if tCacheNbWpsTimer then
				tCacheNbWpsTimer:Cancel()
			end
			CacheNbWps()			
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
	if tRecordingPoly > 0 and tRecordingPolyFor then
		local tWorldY, tWorldX = SkuNavMMContentToWorld(SkuNavMMGetCursorPositionContent2())
		SkuDB.Polygons.data[tRecordingPolyFor].nodes[#SkuDB.Polygons.data[tRecordingPolyFor].nodes + 1] = {x = tWorldX, y = tWorldY,}
		--print(tRecordingPoly, #SkuDB.Polygons.data[tRecordingPolyFor].nodes)
	end
end





















---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:GetAllMetaTargetsFromWpDEPRCEATED(aWpName)
	local tF = sfind(aWpName, "Meter#")
	if tF then	
		aWpName = string.sub(aWpName, tF + 6)
	end

	local rMetapathData = {}
	--setmetatable(rMetapathData, SkuNav.PrintMT)

	--create tree with range numbers from wps
	local tPathTree = {}
	local tSeen = {}

	tPathTree[#tPathTree+1] = aWpName
	tPathTree[aWpName] = {name = aWpName, nr = 1, from = "", subs = {}}

	local tCurrentNumber = 1
	local function FindNextPathItems(aPatTab)
		local tAdded = false
		for x = 1, #aPatTab do
			local tPtx = aPatTab[x]
			if aPatTab[tPtx].nr == tCurrentNumber then
				local tNeib = GetNeighbToWp(tPtx)
				for i, v in pairs(tNeib) do
					if not tSeen[v] then
						tSeen[v] = true
						aPatTab[tPtx].subs[#aPatTab[tPtx].subs+1] = v
						aPatTab[tPtx].subs[v] = {name = v, nr = aPatTab[tPtx].nr + 1, from = aPatTab[tPtx], subs = {}}
						tAdded = true
					end
				end
			end
			local tItResult = FindNextPathItems(aPatTab[tPtx].subs)
			if tItResult == true or tAdded == true then
				tAdded = true
			end
		end

		return tAdded
	end

	while FindNextPathItems(tPathTree) == true do
		tCurrentNumber = tCurrentNumber + 1
	end

	--collect all valid end wps to test
	local tEndWps = {}
	for i, v in ipairs(SkuOptions.db.profile[MODULE_NAME].Routes) do
		if aWpName ~= SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1] then
			if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1], "auto") then
				local tFound = false
				for x = 1, #tEndWps do
					if tEndWps[x] == SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1] then
						tFound = true
					end
				end
				if tFound == false then
					tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[1]
				end
			end
		end
		if aWpName ~= SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs] then
			if not sfind(SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs], "auto") then
				local tFound = false
				for x = 1, #tEndWps do
					if tEndWps[x] == SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs] then
						tFound = true
					end
				end
				if tFound == false then
					tEndWps[#tEndWps+1] = SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs[#SkuOptions.db.profile[MODULE_NAME].Routes[v].WPs]
				end
			end
		end
	end

---------------------------------------------
	--build metaroute from tPathTree for each valid end wp
	local tFind = nil
	local tFindNumber = 1000000
	local tFoundEntry = nil
	local function IterateWpTable(aWpTable)--, pad)
		for x = 1, #aWpTable do
			local tWpX = aWpTable[x]
			if tFind == aWpTable[tWpX].name and tFindNumber > aWpTable[tWpX].nr then
				tFoundEntry = aWpTable[tWpX]
				tFindNumber = aWpTable[tWpX].nr
			end
			IterateWpTable(aWpTable[tWpX].subs)--, pad.."  ")
		end
	end

	for tTCound = 1, #tEndWps do
		tFind = tEndWps[tTCound]
		tFindNumber = 1000000
		tFoundEntry = nil

		IterateWpTable(tPathTree[tPathTree[1]].subs)--, "")

		local tMetaRoute = {}
		local tMetaRouteT = {}
		if tFindNumber < 1000000 and tFoundEntry then
			local tFound = tFoundEntry.name
			local tCount = 1
			while tFound ~= aWpName do
				tMetaRouteT[tCount] = tFound
				tFoundEntry = tFoundEntry.from
				tFound = tFoundEntry.name
				tCount = tCount + 1
			end
			tMetaRouteT[tCount] = tFound
		end
		if #tMetaRouteT > 0 then
			local tCount = 1
			for w = #tMetaRouteT, 1, -1 do
				tMetaRoute[tCount] = tMetaRouteT[w]
				tCount = tCount + 1
			end
		end
		if #tMetaRoute > 0 then
			if not rMetapathData[tEndWps[tTCound]] then
				rMetapathData[#rMetapathData+1] = tEndWps[tTCound]
				rMetapathData[tEndWps[tTCound]] = {
					pathWps = tMetaRoute,
					distance = 0,
				}
				local tDistance = 0
				for z = 2, #rMetapathData[tEndWps[tTCound]].pathWps do
					local tWpA = SkuNav:GetWaypoint(rMetapathData[tEndWps[tTCound]].pathWps[z - 1])
					local tWpB = SkuNav:GetWaypoint(rMetapathData[tEndWps[tTCound]].pathWps[z])
					tDistance = tDistance + SkuNav:Distance(tWpA.worldX, tWpA.worldY, tWpB.worldX, tWpB.worldY)
				end
				rMetapathData[tEndWps[tTCound]].distance = tDistance
			end
		end
	end

	--setmetatable(rMetapathData, SkuNav.PrintMT)
	--print(rMetapathData)
	return rMetapathData
end

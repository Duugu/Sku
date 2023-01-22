---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local L = Sku.L
local _G = _G

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")

local SkuLineRepo
local SkuWaypointLineRepoMM
SkuWaypointWidgetRepo = nil
SkuWaypointWidgetRepoMM = nil
SkuWaypointWidgetCurrent = nil

local tSkuNavMMContent = {}
local tSkuNavMMZoom = 1
local tSkuNavMMPosX = 0
local tSkuNavMMPosY = 0
local tTileSize = 533.33
local tYardsPerTile = 533.33

SkuNavRecordingPoly = 0
SkuNavRecordingPolySub = 0
SkuNavRecordingPolyFor = 0

local slower = string.lower
local sfind = string.find
local ssplit = string.split

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

------------------------------------------------------------------------------------------------------------------------
function SkuNavMMGetCursorPositionContent2()
	local x, y = GetCursorPosition()
	--dprint(x, UIParent:GetScale(), _G["SkuNavMMMainFrameScrollFrameMapMain"]:GetLeft(),_G["SkuNavMMMainFrame"]:GetScale() )
	local txPos = ((x / UIParent:GetScale()) - ( _G["SkuNavMMMainFrameScrollFrameContent"]:GetLeft()   * _G["SkuNavMMMainFrame"]:GetScale() ) - ((_G["SkuNavMMMainFrameScrollFrameContent"]:GetWidth()  / 2) * _G["SkuNavMMMainFrame"]:GetScale()) ) * (1 / _G["SkuNavMMMainFrame"]:GetScale())
	local tyPos = ((y / UIParent:GetScale()) - ( _G["SkuNavMMMainFrameScrollFrameContent"]:GetBottom() * _G["SkuNavMMMainFrame"]:GetScale() ) - ((_G["SkuNavMMMainFrameScrollFrameContent"]:GetHeight() / 2) * _G["SkuNavMMMainFrame"]:GetScale()) ) * (1 / _G["SkuNavMMMainFrame"]:GetScale())
	return txPos, tyPos
end

------------------------------------------------------------------------------------------------------------------------
function SkuNavMMContentToWorld(aPosX, aPosY)
	local tModTileSize = tYardsPerTile * tSkuNavMMZoom
	local tTilesX, tTilesY = (aPosX - (tSkuNavMMPosX * tSkuNavMMZoom)) / tModTileSize - 1, (aPosY - (tSkuNavMMPosY * tSkuNavMMZoom)) / tModTileSize - 2
	return -(tTilesX * tYardsPerTile), tTilesY * tYardsPerTile
end

------------------------------------------------------------------------------------------------------------------------
function SkuNavMMWorldToContent(aPosY, aPosX)
	aPosX, aPosY = (aPosX - tYardsPerTile) * tSkuNavMMZoom, (aPosY + tYardsPerTile + tYardsPerTile) * tSkuNavMMZoom
	aPosX, aPosY = (aPosX + (tSkuNavMMPosX * tSkuNavMMZoom)) - ((tSkuNavMMPosX * tSkuNavMMZoom) * 2), aPosY + (tSkuNavMMPosY * tSkuNavMMZoom)
	return -(aPosX), aPosY
end

------------------------------------------------------------------------------------------------------------------------
function SkuNav:DrawTerrainData(aFrame)
	--SkuNav:ClearLines(aFrame)
	if SkuOptions.db.profile[MODULE_NAME].showRoutesOnMinimap ~= true or not SkuCoreDB.TerrainData then
		return
	end
	local tExtMap = SkuNav:GetBestMapForUnit("player")

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
	--dprint("DrawWaypoints")
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

	local tWpFrames =  {}
	local tWpObjects =  {}
	--lastXY, lastYY = UnitPosition("player")

	local mapRadius = minimap_size[indoors][zoom] / 2
	local minimapWidth = Minimap:GetWidth() / 2
	local minimapHeight = Minimap:GetHeight() / 2

	for i, v in SkuNav:ListWaypoints2(false, nil, tAreaId, tPlayerContintentId, nil) do
		--print(i, v)
		tWP = SkuNav:GetWaypointData2(v)
		if tWP then
			if tWP.worldX and tWP.worldY then
				tWP.comments = tWP.comments or {["deDE"] = {},["enUS"] = {},}
				local tFinalX, tFinalY = WorldPointToMinimapPoint(tWP.worldX, tWP.worldY)
				if tWP.typeId == 1 or tWP.typeId == 4 then
					--red
					tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0, 0, 1, tWP.comments[Sku.Loc])
					tWpFrames[v].hasLine = false
				elseif tWP.typeId == 2 then
					if tWP.spawnNr > 3 then
						tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0.3, 0.7, 0.7, 1, tWP.comments[Sku.Loc])
						tWpFrames[v].hasLine = false
					else
						tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY, 1,  1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7, 1, tWP.comments[Sku.Loc])
						tWpFrames[v].hasLine = false
					end
				elseif tWP.typeId == 3 then
					--green
					tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY,  1,   1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0, 0.7, 0, 1, tWP.comments[Sku.Loc])
					tWpFrames[v].hasLine = false
				else
					--white
					tWpFrames[v] = DrawWaypointWidget(tFinalX, tFinalY,  1,   1, 4, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 1, 1, 1, tWP.comments[Sku.Loc])
					tWpFrames[v].hasLine = false
				end

				if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == v then
					tWpFrames[v]:SetSize(6, 6)
					--tWidgetTexture:SetColorTexture(0, 1, 0)
				else
					tWpFrames[v]:SetSize(3, 3)
					--tWidgetTexture:SetColorTexture(1, 0, 0)
				end

				if (SkuNavMMShowCustomWo == true or SkuNavMMShowDefaultWo == true) == false then
					if tWP.links.byName then
						for tName, tDistance in pairs(tWP.links.byName) do
							if tWpFrames[tName] then
								local _, relativeTo, _, xOfs, yOfs = tWpFrames[v]:GetPoint(1)
								local _, PrevrelativeTo, _, PrevxOfs, PrevyOfs = tWpFrames[tName]:GetPoint(1)
								DrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 1, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, aFrame, tForce) 
							end
						end
					end
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
	[571] = "northrend",
	[609] = "azeroth",
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
				--dprint("error - broken polygon:", x)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------
local SkuNavMMShowCustomWo = false
local SkuNavMMShowDefaultWo = false
local tWpFrames = {}
function SkuNavDrawWaypointsMM(aFrame)
	--dprint("SkuNavDrawWaypointsMM")
	--local beginTime = debugprofilestop()

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
	if not tPlayerContintentId then
		return
	end
	if not tAreaId then
		return
	end

	tWpFrames = {}

	local tSelectedZone = _G["SkuNavMMMainFrameZoneSelect"].value
	if tSelectedZone then
		if tSelectedZone == -2 then
			tAreaId = nil
		elseif tSelectedZone ~= -2 and tSelectedZone ~= -1 then
			tAreaId = tSelectedZone 
		end
	end

	--wp draw
	local tWP = nil

	local tCountDrawnWPs = 0
	for i, v in SkuNav:ListWaypoints2(false, nil, tAreaId, tPlayerContintentId, nil) do
		--print(i, v)
		tWP = SkuNav:GetWaypointData2(v)
		if tWP then
			tWP.comments = tWP.comments or {["deDE"] = {},["enUS"] = {},}
			local tShow = false
			if _G["SkuNavMMMainFrameShowFilter"].selected == true then
				if SkuQuest.QuestWpCache[v] or tWP.typeId == 1 then
					tShow = true
				end
			else
				tShow = true
			end
			if tWP.links.byId then
				tShow = true
			end
			if tShow == true then
				if tWP.worldX and tWP.worldY then
					local tFinalX, tFinalY = SkuNavMMWorldToContent(tWP.worldX, tWP.worldY)
					if tFinalX > -(tTileSize * 0.6) and tFinalX < (tTileSize * 0.6) and tFinalY > -(tTileSize * 0.6) and tFinalY < (tTileSize * 0.6) then
						tCountDrawnWPs = tCountDrawnWPs + 1

						local tSize = 4
						
						if tWP.typeId == 1 or tWP.typeId == 4 then
							--red
							tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, tSize, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0, 0, 1, tWP.comments[Sku.Loc])
							tWpFrames[v].hasLine = false
						elseif tWP.typeId == 2 then
							if tWP.spawnNr > 3 then
								tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, tSize, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0.3, 0.7, 0.7, 1, tWP.comments[Sku.Loc])
								tWpFrames[v].hasLine = false
							else
								tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY, 1,  1, tSize, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 0.3, 0.7, 1, tWP.comments[Sku.Loc])
								tWpFrames[v].hasLine = false
							end
						elseif tWP.typeId == 3 then
							--green
							tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY,  1,   1, tSize, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 0, 0.7, 0, 1, tWP.comments[Sku.Loc])
							tWpFrames[v].hasLine = false
						else
							--white
							tWpFrames[v] = SkuNavDrawWaypointWidgetMM(tFinalX, tFinalY,  1,   1, tSize, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, aFrame, v, 1, 1, 1, 1, tWP.comments[Sku.Loc])
							tWpFrames[v].hasLine = false
						end

						local tFinalSize = tSize
						if tSkuNavMMZoom <= 1 then
							tFinalSize = tSize * (tSkuNavMMZoom)
							if tFinalSize < 2 then
								tFinalSize = 2
							end
						else
							tFinalSize = 4 + (tSkuNavMMZoom / 12)
							if tFinalSize > 10 then
								tFinalSize = 10
							end
						end

						if SkuOptions.db.profile[MODULE_NAME].selectedWaypoint == v then
							tWpFrames[v]:SetSize(tFinalSize * 1.5, tFinalSize * 1.5)--5 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom), (tSize + 2) * (tSkuNavMMZoom) - tSkuNavMMZoom * 2  + (3 - tSkuNavMMZoom))
							--tWidgetTexture:SetColorTexture(0, 1, 0)
						else
							tWpFrames[v]:SetSize(tFinalSize, tFinalSize)--4 * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom), tSize * (tSkuNavMMZoom) - tSkuNavMMZoom * 2 + (3 - tSkuNavMMZoom))
							--tWidgetTexture:SetColorTexture(1, 0, 0)
						end

						if (SkuNavMMShowCustomWo == true or SkuNavMMShowDefaultWo == true) == false then
							if tWP.links.byName then
								for tName, tDistance in pairs(tWP.links.byName) do
									if tWpFrames[tName] then
										tCountDrawnWPs = tCountDrawnWPs + 1
										local _, relativeTo, _, xOfs, yOfs = tWpFrames[v]:GetPoint(1)
										local _, PrevrelativeTo, _, PrevxOfs, PrevyOfs = tWpFrames[tName]:GetPoint(1)
										SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, aFrame, nil, relativeTo, PrevrelativeTo) 
									end
								end
							end
						end
					end
				end
			end
		end
	end

	SkuNavMmDrawTimer = tCountDrawnWPs / 5000
	if SkuNavMmDrawTimer < 0.1 then SkuNavMmDrawTimer = 0.1 end
	--if SkuNavMmDrawTimer > 1 then SkuNavMmDrawTimer = 1 end

	--dprint("End SkuNavDrawWaypointsMM", debugprofilestop() - beginTime)
end


local function CreateButtonFrameTemplate(aName, aParent, aText, aWidth, aHeight, aPoint, aRelativeTo, aAnchor, aOffX, aOffY)
	local tWidget = CreateFrame("Frame",aName, aParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
	tWidget:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
	tWidget:SetBackdropColor(0.3, 0.3, 0.3, 1)
	tWidget:SetWidth(aWidth)  
	tWidget:SetHeight(aHeight) 
	tWidget:SetPoint(aPoint, aRelativeTo,aAnchor, aOffX, aOffY)
	tWidget:SetMouseClickEnabled(true)
	tWidget.selectedDefault = false
	tWidget.selected = false
	tWidget:SetScript("OnEnter", function(self) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 1, right = 1, top = 1, bottom = 1 }})
		self:SetBackdropColor(0.5, 0.5, 0.5, 1)
	end)
	tWidget:SetScript("OnLeave", function(self) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
		self:SetBackdropColor(0.3, 0.3, 0.3, 1)
		if self.selected == true then
			self:SetBackdropColor(0.5, 0.5, 0.5, 1)
		end
	end)
	tWidget:SetScript("OnShow", function(self) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
		self:SetBackdropColor(0.3, 0.3, 0.3, 1)
		if self.selected == true then
			self:SetBackdropColor(0.5, 0.5, 0.5, 1)
		end
	end)
	tWidget:SetScript("OnMouseUp", function(self, button) 
		self:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 2, right = 2, top = 2, bottom = 2 }})
		self:SetBackdropColor(0.3, 0.3, 0.3, 1)
		if self.selected == true then
			self:SetBackdropColor(0.5, 0.5, 0.5, 1)
		end
	end)
	fs = tWidget:CreateFontString(aName.."Text", "OVERLAY", "GameTooltipText")
	fs:SetTextHeight(12)
	fs:SetPoint("TOPLEFT", tWidget, "TOPLEFT", 3, 0)
	fs:SetPoint("BOTTOMRIGHT", tWidget, "BOTTOMRIGHT", -3, 0)
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
	if SkuNavRecordingPoly == 0 then
		SkuNavRecordingPoly = aType
		SkuNavRecordingPolySub = aSubtype
		local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
		SkuDB.Polygons.data[#SkuDB.Polygons.data + 1] = {
			continentId = tPlayerContinentID,
			nodes = {},
			type = SkuNavRecordingPoly,
			subtype = SkuNavRecordingPolySub,
		}
		SkuNavRecordingPolyFor = #SkuDB.Polygons.data
		print("recording started", SkuDB.Polygons.eTypes[SkuNavRecordingPoly][2][SkuNavRecordingPolySub][1], "ds:", SkuNavRecordingPolyFor)
	else
		print("recording in process: ", SkuDB.Polygons.eTypes[SkuNavRecordingPoly][2][SkuNavRecordingPolySub][1])
	end
end

function SkuNav:SkuNavMMOpen()
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainIsCollapsed or true
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainWidth or 200
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainHeight or 200
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosX or UIParent:GetWidth() / 2
	SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY = SkuOptions.db.profile[MODULE_NAME].SkuNavMMMainPosY or UIParent:GetHeight() / 2

	if SkuOptions.db.profile[MODULE_NAME].showSkuMM == true then
		SkuNavMMShowCustomWo = false
		SkuNavMMShowDefaultWo = false

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
			MainFrameObj:SetScript("OnShow", function(self)
				local children = {_G["SkuNavMMMainFrameOptionsParent"]:GetChildren()}
				for i, child in ipairs(children) do
					child.selected = child.selectedDefault
				end
				SkuQuest.QuestWpCache = {}
				if not SkuQuest.QuestZoneCache then
					SkuQuest:BuildQuestZoneCache()
				end
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end					
			end)			
			MainFrameObj:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
			MainFrameObj:SetBackdropColor(1, 1, 1, 1)
			MainFrameObj:SetMovable(true)
			MainFrameObj:SetClampedToScreen(true)
			MainFrameObj:RegisterForDrag("LeftButton")
			MainFrameObj:Show()

			-- Resizable
			MainFrameObj:SetResizable(true)
			local tW, tH = _G["UIParent"]:GetSize()
			MainFrameObj:SetResizeBounds(200, 200 , tW - 100, tH - 100)
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
			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameFactionAStart", tOptionsParent, "Alli Start", 100, 20, "TOPLEFT", _G["SkuNavMMMainFrameFlyStart"], "TOPLEFT", 0, -20)
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
				if SkuNavRecordingPoly > 0 then
					if #SkuDB.Polygons.data[SkuNavRecordingPolyFor].nodes > 0 then
						print("recording completed > saved", SkuDB.Polygons.eTypes[SkuNavRecordingPoly][2][SkuNavRecordingPolySub][1], "ds:", SkuNavRecordingPolyFor)
					else
						print("recording completed, but no nodes > wasted", SkuDB.Polygons.eTypes[SkuNavRecordingPoly][2][SkuNavRecordingPolySub][1], "ds:", SkuNavRecordingPolyFor)
					end
					SkuNavRecordingPoly = 0
					SkuNavRecordingPolySub = 0
					SkuNavRecordingPolyFor = nil
				else
					print("no recording in process: ")--, SkuDB.Polygons.eTypes[SkuNavRecordingPoly][2][SkuNavRecordingPolySub][1])
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

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameShowFilter", tOptionsParent, "Filter", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameFollow"], "TOPLEFT", 100, -40)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				SkuQuest.QuestWpCache = {}
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end
			end)
			_G["SkuNavMMMainFrameShowFilter"].selectedDefault = false

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameShowQuestStartWps", tOptionsParent, "Starts", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameFollow"], "TOPLEFT", 100, -60)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				SkuQuest.QuestWpCache = {}
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end
			end)
			_G["SkuNavMMMainFrameShowQuestStartWps"].selectedDefault = true

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameShowQuestObjectiveWps", tOptionsParent, "Objectives", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameShowQuestStartWps"], "TOPLEFT", 95, 0)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				SkuQuest.QuestWpCache = {}
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end				
			end)
			_G["SkuNavMMMainFrameShowQuestObjectiveWps"].selectedDefault = true

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameShowQuestFinishWps", tOptionsParent, "Finish", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameShowQuestStartWps"], "TOPLEFT", 0, -20)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				SkuQuest.QuestWpCache = {}
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end				
			end)
			_G["SkuNavMMMainFrameShowQuestFinishWps"].selectedDefault = true

			local tButtonObj = CreateButtonFrameTemplate("SkuNavMMMainFrameShowLimitWps", tOptionsParent, "Limit", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameShowQuestFinishWps"], "TOPLEFT", 95, 0)
			tButtonObj:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				SkuQuest.QuestWpCache = {}
				local tPlayerAreaId = SkuNav:GetCurrentAreaId()
				for i, _ in pairs(SkuDB.questDataTBC) do
					if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
						SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
					end
				end				
			end)
			_G["SkuNavMMMainFrameShowLimitWps"].selectedDefault = false

			local tDropdownFrame = CreateButtonFrameTemplate("SkuNavMMMainFrameZoneSelect", tOptionsParent, "Zone", 95, 20, "TOPLEFT", _G["SkuNavMMMainFrameFollow"], "TOPLEFT", 195, -40)
			tDropdownFrame.MenuButtonsObjects = {}
			tDropdownFrame.value = -1
			tDropdownFrame:SetText("Current Zone") 
			tDropdownFrame:SetScript("OnEnter", function(self)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:AddLine(self.Text:GetText(), 1, 1, 1)
				GameTooltip:AddLine("zone id: "..(self.value or ""), 1, 1, 1)
				GameTooltip:Show()
			end)
			tDropdownFrame:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
			tDropdownFrame.maxVisibleItems = 11
			tDropdownFrame.maxCurrentItems = 0
			tDropdownFrame.firstVisibleItem = 1
			tDropdownFrame.UpdateList = function(self, a, b)
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tMenuItems = {}
				for i, v in pairs(SkuDB.InternalAreaTable) do
					if v.ContinentID == tPlayerContintentId and v.ParentAreaID == 0 then
						tMenuItems[#tMenuItems + 1] = {zoneId = i, buttonText = v.AreaName_lang[Sku.Loc],}
					end
				end
				tMenuItems[#tMenuItems + 1] = {zoneId = -1, buttonText = "Current Zone",}
				tMenuItems[#tMenuItems + 1] = {zoneId = -2, buttonText = "Current Contintent",}
				
				self.maxCurrentItems = #tMenuItems
				for x = 1, self.maxVisibleItems do
					self.MenuButtonsObjects[x]:SetText(tMenuItems[x + self.firstVisibleItem].buttonText)
					self.MenuButtonsObjects[x].value = tMenuItems[x + self.firstVisibleItem].zoneId
				end
			end

			tDropdownFrame:SetScript("OnMouseUp", function(self, button)
				self.selected  = self.selected  ~= true
				local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
				local tMenuItems = {}
				local tMenuItemsMaxLen = 0
				for i, v in pairs(SkuDB.InternalAreaTable) do
					if v.ContinentID == tPlayerContintentId and v.ParentAreaID == 0 then
						tMenuItems[#tMenuItems + 1] = {zoneId = i, buttonText = v.AreaName_lang[Sku.Loc],}
						if string.len(tMenuItems[#tMenuItems].buttonText) > tMenuItemsMaxLen then
							tMenuItemsMaxLen = string.len(tMenuItems[#tMenuItems].buttonText)
						end
					end
				end
				tMenuItems[#tMenuItems + 1] = {zoneId = -1, buttonText = "Current Zone",}
				if string.len(tMenuItems[#tMenuItems].buttonText) > tMenuItemsMaxLen then
					tMenuItemsMaxLen = string.len(tMenuItems[#tMenuItems].buttonText)
				end
				tMenuItems[#tMenuItems + 1] = {zoneId = -2, buttonText = "Current Contintent",}
				if string.len(tMenuItems[#tMenuItems].buttonText) > tMenuItemsMaxLen then
					tMenuItemsMaxLen = string.len(tMenuItems[#tMenuItems].buttonText)
				end
				
				--for x = 1, #tMenuItems do
				self.maxCurrentItems = #tMenuItems
				for x = 1, self.maxVisibleItems do
					self.MenuButtonsObjects[x] = _G["SkuNavMMMainFrameZoneSelectEntry"..x] or CreateButtonFrameTemplate("SkuNavMMMainFrameZoneSelectEntry"..x, self, "button"..x, 95, 20, "TOPLEFT", self, "TOPLEFT", 25, -(x * 16))
					self.MenuButtonsObjects[x]:SetScript("OnMouseDown", function(self, button)
						self:GetParent().value = self.value
						self:GetParent():SetText(tMenuItems[x + _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem].buttonText) 
						for z = 1, #self:GetParent().MenuButtonsObjects do
							self:GetParent().MenuButtonsObjects[z]:Hide()
						end
					end)
					self.MenuButtonsObjects[x]:SetFrameStrata("FULLSCREEN_DIALOG")						
					self.MenuButtonsObjects[x]:SetWidth(tMenuItemsMaxLen * 8)						
					self.MenuButtonsObjects[x]:SetText(tMenuItems[x + _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem].buttonText)
					self.MenuButtonsObjects[x].value = tMenuItems[x + _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem].zoneId
					if self.selected == true then
						self.MenuButtonsObjects[x]:Show()
					else
						self.MenuButtonsObjects[x]:Hide()
					end
				end
				for x = self.maxVisibleItems + 1, #self.MenuButtonsObjects do
					self.MenuButtonsObjects[x]:Hide()
				end
				self.ItemsBackdropFrame = self.ItemsBackdropFrame or CreateFrame("Frame",nil, tOptionsParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
				self.ItemsBackdropFrame:SetFrameStrata("TOOLTIP")						
				self.ItemsBackdropFrame:SetWidth(tMenuItemsMaxLen * 8 + 10)
				--self.ItemsBackdropFrame:SetHeight(500)--20 * #tMenuItems + 10)
				self.ItemsBackdropFrame:SetHeight(20 * self.maxVisibleItems + 10)
				self.ItemsBackdropFrame:SetPoint("TOPLEFT", self.MenuButtonsObjects[1], "TOPLEFT", 0, 0)
				--self.ItemsBackdropFrame:SetPoint("BOTTOMRIGHT", self.MenuButtonsObjects[#tMenuItems], "BOTTOMRIGHT", 0, 0)
				self.ItemsBackdropFrame:SetPoint("BOTTOMRIGHT", self.MenuButtonsObjects[self.maxVisibleItems], "BOTTOMRIGHT", 0, 0)
				self.ItemsBackdropFrame:EnableMouse(false)
				self.ItemsBackdropFrame:SetScript("OnMouseWheel", function(self, aDelta)
					if aDelta > 0 then
						if _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem > 1 then
							_G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem = _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem - 1
						end
					else
						if _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem < _G["SkuNavMMMainFrameZoneSelect"].maxCurrentItems - _G["SkuNavMMMainFrameZoneSelect"].maxVisibleItems then
							_G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem = _G["SkuNavMMMainFrameZoneSelect"].firstVisibleItem + 1
						end
					end
					_G["SkuNavMMMainFrameZoneSelect"]:UpdateList()
				end)
				self.ItemsBackdropFrame:SetScript("OnLeave", function(self)
					if self:IsVisible() == true then
						_G["SkuNavMMMainFrameZoneSelect"]:GetScript("OnMouseUp")(_G["SkuNavMMMainFrameZoneSelect"], "LeftButton")
					end
				end)
				self.ItemsBackdropFrame:SetMouseClickEnabled(false)
					if self.selected == true then
					self.ItemsBackdropFrame:Show()
				else
					self.ItemsBackdropFrame:Hide()
				end
			end)
			_G["SkuNavMMMainFrameZoneSelect"].selectedDefault = false

	
			--init
			_G["SkuNavMMMainFrameShowFilter"].selected = _G["SkuNavMMMainFrameShowFilter"].selectedDefault
			_G["SkuNavMMMainFrameShowQuestStartWps"].selected = _G["SkuNavMMMainFrameShowQuestStartWps"].selectedDefault
			_G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected = _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selectedDefault
			_G["SkuNavMMMainFrameShowQuestFinishWps"].selected = _G["SkuNavMMMainFrameShowQuestFinishWps"].selectedDefault
			_G["SkuNavMMMainFrameShowLimitWps"].selected = _G["SkuNavMMMainFrameShowLimitWps"].selectedDefault
			if not SkuQuest.QuestZoneCache then
				SkuQuest:BuildQuestZoneCache()
			end
			SkuQuest.QuestWpCache = {}
			local tPlayerAreaId = SkuNav:GetCurrentAreaId()
			for i, _ in pairs(SkuDB.questDataTBC) do
				if SkuQuest.QuestZoneCache[i][tPlayerAreaId] then
					SkuQuest:GetAllQuestWps(i, _G["SkuNavMMMainFrameShowQuestStartWps"].selected, _G["SkuNavMMMainFrameShowQuestObjectiveWps"].selected, _G["SkuNavMMMainFrameShowQuestFinishWps"].selected, _G["SkuNavMMMainFrameShowLimitWps"].selected)
				end
			end			

			-- EditBox
			local f = CreateFrame("Frame", "SkuNavMMMainFrameEditBox", tOptionsParent, BackdropTemplateMixin and "BackdropTemplate" or nil)--, "DialogBoxFrame")
			f:SetPoint("TOPLEFT", _G["SkuNavMMMainFrameWrite"], "TOPLEFT", 2, -100)
			f:SetSize(170,80)
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
				--dprint("player", x, y)
				local tEndX, tEndY = SkuNavMMGetCursorPositionContent2()
				--dprint("cursor", tEndX, tEndY)
				local twy, twx = SkuNavMMContentToWorld(tEndX, tEndY)
				--dprint("world", twx, twy)
				local tmx, tmy = SkuNavMMWorldToContent(twx, twy)
				--dprint("map", tmx, tmy)
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
				--dprint(button)
				if button == "LeftButton" then
					self.tStartMoveX, self.tStartMoveY = SkuNavMMGetCursorPositionContent2()
					SkuNavMMMainFrameScrollFrameContentDraging = true
					tFocusOnPlayer = false
				end
				if button == "RightButton" then

				end
			end)
			contentObj:SetScript("OnMouseUp", function(self, button)
				--dprint(button)
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
						if SkuNavMMMainFrameScrollFrameContenttTime1 > (SkuNavMmDrawTimer or 0.1) then
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

		if not _G["SkuNavMMMainFrame"]:IsShown() then
			_G["SkuNavMMMainFrame"]:Show()
		end

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
		end
	end
end
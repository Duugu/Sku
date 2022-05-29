---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "minimapScanner"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

function SkuCore:MinimapScan(aRange)
   print("MinimapScan", aRange)


end

---------------------------------------------------------------------------------------------------------------------------------------
local function PrepareMinimap()
   MinimapCluster:SetFrameLevel(9002)
   MinimapCluster:SetFrameStrata("HIGH")
   Minimap:GetZoom(5)
   Minimap:SetMouseClickEnabled(false)
   MinimapCluster:SetMouseClickEnabled(false)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SetMinimapLoc(xOffset, yOffset)
   PrepareMinimap()
   local xOffset = xOffset or 0
   local yOffset = yOffset or 0
   local x, y = GetCursorPosition()
   local uiScale = Minimap:GetEffectiveScale()
   Minimap:ClearAllPoints()
   Minimap:SetPoint('CENTER', nil, 'BOTTOMLEFT', xOffset + x/uiScale, yOffset + y/uiScale)
   GameTooltip:SetScale(300)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function isMatch()
   for i = 1, GameTooltip:NumLines() do
      local line = string.lower(_G['GameTooltipTextLeft'..i]:GetText())
      if line then
         for w in string.gmatch(nodeName, ".+") do
            if string.find(line, string.lower(w), 1, true) and not string.find(line, string.lower(w..'|'), 1, true) then
               return true               
            end
         end 
      end
   end
   return false
end

---------------------------------------------------------------------------------------------------------------------------------------
--/script SkuCore:StoreMinimap() tScan = true SkuCore:MinimapScanTest() 
-- 20-25 yards

local nodeName = "Silverleaf"

local cx, cy = -10, -10
local tFound = false
local tScan = false
local fx, fy = 0,0
local m = {}

function SkuCore:MinimapScanTest()
	if tScan == false then
		SkuCore:RestoreMinimap()
		return
	end

	cx = cx + 4
	if cx > 10 then
		cx = -10
		cy = cy + 4
	end
	if cy > 10 then
		cx, cy = -10, -10
		tFound = false
		tScan = false
	end
	
	SetMinimapLoc(cx, cy)

	C_Timer.After(0, function()
		if isMatch() == true then
			tFound = true
			print(tFound, fx, fy)
			tScan = false
			fx, fy = cx, cy
		end
		SkuCore:MinimapScan()
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:StoreMinimap()
	m.point, m.relativeTo, m.relativePoint, m.x, m.y = Minimap:GetPoint()
	m.parent = Minimap:GetParent()
	m.scale = Minimap:GetScale()
	m.GameTooltipScale = GameTooltip:GetScale()
	m.frameLevel = MinimapCluster:GetFrameLevel()
	m.frameStrata = MinimapCluster:GetFrameStrata()

	minimapChildren = {Minimap:GetChildren()}
	for k,v in pairs(minimapChildren) do
			v.MMA_VISIBLE = v:IsVisible()
			v.MMA_FRAME_LEVEL = v:GetFrameLevel()
			v.MMA_FRAME_STRATA = v:GetFrameStrata()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RestoreMinimap()
   Minimap:SetScale(m.scale)
   Minimap:ClearAllPoints()
   Minimap:SetPoint(m.point, m.relativeTo, m.relativePoint, m.x, m.y)
   MinimapCluster:SetFrameLevel(m.frameLevel)
   MinimapCluster:SetFrameStrata(m.frameStrata)
   GameTooltip:SetScale(m.GameTooltipScale)

   for k,v in pairs(minimapChildren) do
      if v.MMA_VISIBLE then 
         v:Show() 
      end
      v:SetFrameStrata(v.MMA_FRAME_STRATA)
      v:SetFrameLevel(v.MMA_FRAME_LEVEL)
   end
end



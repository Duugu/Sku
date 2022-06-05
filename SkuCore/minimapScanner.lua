---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "minimapScanner"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.RessourceTypes = {
   chests = {	
      [1] = {deDE = "Beschädigte Truhe", enUS = "Damaged Chest",},
      [2] = {deDE = "Verbeulte Truhe", enUS = "Dented Chest",},
      [3] = {deDE = "Große ramponierte Truhe", enUS = "Large Battered Chest",},
      [4] = {deDE = "Große eisenbeschlagene Truhe", enUS = "Large Iron Bound Chest",},
      [5] = {deDE = "Große mithrilbeschlagene Truhe", enUS = "Large Mithril Bound Chest",},
      [6] = {deDE = "Große robuste Truhe", enUS = "Large Solid Chest",},
      [7] = {deDE = "Verschlossene Truhe", enUS = "Locked Chest",},
      [8] = {deDE = "Primitive Truhe", enUS = "Primitive Chest",},
      [9] = {deDE = "Rostige Truhe", enUS = "Rusty Chest",},
      [10] = {deDE = "Robuste Truhe", enUS = "Solid Chest",},
      [11] = {deDE = "Versunkene Truhe", enUS = "Sunken Chest",},
      [12] = {deDE = "Ramponierte Truhe", enUS = "Tattered Chest",},
      [13] = {deDE = "Abgenutzte Truhe", enUS = "Worn Chest",},
      [14] = {deDE = "Adamantitbeschlagene Truhe", enUS = "Adamantite Bound Chest",},
      [15] = {deDE = "Teufelseisentruhe", enUS = "Fel Iron Chest",},
   },	
   mining = {	
      [1] = {deDE = "Kupfervorkommen", enUS = "Copper Vein",},
      [2] = {deDE = "Zinnvorkommen", enUS = "Tin Vein",},
      [3] = {deDE = "Silbervorkommen", enUS = "Silver Vein",},
      [4] = {deDE = "Brühschlammbedecktes Silbervorkommen", enUS = "Ooze Covered Silver Vein",},
      [5] = {deDE = "Eisenvorkommen", enUS = "Iron Deposit",},
      [6] = {deDE = "Goldvorkommen", enUS = "Gold Vein",},
      [7] = {deDE = "Brühschlammbedecktes Goldvorkommen", enUS = "Ooze Covered Gold Vein",},
      [8] = {deDE = "Mithrilablagerung", enUS = "Mithril Deposit",},
      [9] = {deDE = "Brühschlammbedeckte Mithrilablagerung", enUS = "Ooze Covered Mithril Deposit",},
      [10] = {deDE = "Echtsilberablagerung", enUS = "Truesilver Deposit",},
      [11] = {deDE = "Brühschlammbedeckte Echtsilberablagerung", enUS = "Ooze Covered Truesilver Deposit",},
      [12] = {deDE = "Kleines Thoriumvorkommen", enUS = "Small Thorium Vein",},
      [13] = {deDE = "Brühschlammbedecktes Thoriumvorkommen", enUS = "Ooze Covered Thorium Vein",},
      [14] = {deDE = "Reiches Thoriumvorkommen", enUS = "Rich Thorium Vein",},
      [15] = {deDE = "Brühschlammbedecktes reiches Thoriumvorkommen", enUS = "Ooze Covered Rich Thorium Vein",},
      [16] = {deDE = "Dunkeleisenablagerung", enUS = "Dark Iron Deposit",},
      [17] = {deDE = "Teufelseisenvorkommen", enUS = "Fel Iron Deposit",},
      [18] = {deDE = "Adamantitablagerung", enUS = "Adamantite Deposit",},
      [19] = {deDE = "Reiche Adamantitablagerung", enUS = "Rich Adamantite Deposit",},
      [20] = {deDE = "Khoriumvorkommen", enUS = "Khorium Vein",},
   },	
   herbs = {	
      [1] = {deDE = "Friedensblume", enUS = "Peacebloom",},
      [2] = {deDE = "Silberblatt", enUS = "Silverleaf",},
      [3] = {deDE = "Erdwurzel", enUS = "Earthroot",},
      [4] = {deDE = "Maguskönigskraut", enUS = "Mageroyal",},
      [5] = {deDE = "Wilddornrose", enUS = "Briarthorn",},
      [6] = {deDE = "Würgetang", enUS = "Stranglekelp",},
      [7] = {deDE = "Beulengras", enUS = "Bruiseweed",},
      [8] = {deDE = "Wildstahlblume", enUS = "Wild Steelbloom",},
      [9] = {deDE = "Grabmoos", enUS = "Grave Moss",},
      [10] = {deDE = "Königsblut", enUS = "Kingsblood",},
      [11] = {deDE = "Lebenswurz", enUS = "Liferoot",},
      [12] = {deDE = "Blassblatt", enUS = "Fadeleaf",},
      [13] = {deDE = "Golddorn", enUS = "Goldthorn",},
      [14] = {deDE = "Khadgars Schnurrbart", enUS = "Khadgar's Whisker",},
      [15] = {deDE = "Winterbiss", enUS = "Wintersbite",},
      [16] = {deDE = "Feuerblüte", enUS = "Firebloom",},
      [17] = {deDE = "Lila Lotus", enUS = "Purple Lotus",},
      [18] = {deDE = "Arthas' Tränen", enUS = "Arthas' Tears",},
      [19] = {deDE = "Sonnengras", enUS = "Sungrass",},
      [20] = {deDE = "Blindkraut", enUS = "Blindweed",},
      [21] = {deDE = "Geisterpilz", enUS = "Ghost Mushroom",},
      [22] = {deDE = "Gromsblut", enUS = "Gromsblood",},
      [23] = {deDE = "Goldener Sansam", enUS = "Golden Sansam",},
      [24] = {deDE = "Traumblatt", enUS = "Dreamfoil",},
      [25] = {deDE = "Bergsilbersalbei", enUS = "Mountain Silversage",},
      [26] = {deDE = "Pestblüte", enUS = "Plaguebloom",},
      [27] = {deDE = "Eiskappe", enUS = "Icecap",},
      [28] = {deDE = "Schwarzer Lotus", enUS = "Black Lotus",},
      [29] = {deDE = "Teufelsgras", enUS = "Felweed",},
      [30] = {deDE = "Traumwinde", enUS = "Dreaming Glory",},
      [31] = {deDE = "Terozapfen", enUS = "Terocone",},
      [32] = {deDE = "Zottelkappe", enUS = "Ragveil",},
      [33] = {deDE = "Urflechte", enUS = "Ancient Lichen",},
      [34] = {deDE = "Netherblüte", enUS = "Netherbloom",},
      [35] = {deDE = "Alptraumranke", enUS = "Nightmare Vine",},
      [36] = {deDE = "Manadistel", enUS = "Mana Thistle",},
      [37] = {deDE = "Teufelslotus", enUS = "Fel Lotus",},
   },
}










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



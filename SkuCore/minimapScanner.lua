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

SkuCore.IsScanning = false

local tMinimapYardsMod = 3.125
local tScanResults = {}
local tMinimapStore = {}
local tRange = 15
local tCurrentMMPosX, tCurrentMMPosY = -(tRange / 2), -(tRange / 2)
local fx, fy = 0, 0

---------------------------------------------------------------------------------------------------------------------------------------
local function PrepareMinimap()
   MinimapCluster:SetFrameLevel(9002)
   MinimapCluster:SetFrameStrata("HIGH")
   Minimap:GetZoom(5)
   Minimap:SetMouseClickEnabled(false)
   MinimapCluster:SetMouseClickEnabled(false)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SetMinimapPosition(xOffset, yOffset)
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
local tFoundPositions = {}
function SkuCore:MinimapScanFindActiveRessource(aX, aY)
   for i = 1, GameTooltip:NumLines() do
      local line = string.lower(_G['GameTooltipTextLeft'..i]:GetText())
      if line then
         for x = 1, #SkuCore.RessourceTypes.mining do
            if SkuOptions.db.profile[MODULE_NAME].ressourceScanning.miningNodes[x] == true then
               for w in string.gmatch(SkuCore.RessourceTypes.mining[x][Sku.L["locale"]], ".+") do
                  if string.find(line, string.lower(w), 1, true) and not string.find(line, string.lower(w..'|'), 1, true) then
                     return SkuCore.RessourceTypes.mining[x][Sku.L["locale"]]               
                  end
               end 
            end
         end

         for x = 1, #SkuCore.RessourceTypes.herbs do
            if SkuOptions.db.profile[MODULE_NAME].ressourceScanning.herbs[x] == true then
               for w in string.gmatch(SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]], ".+") do
                  if string.find(line, string.lower(w), 1, true) and not string.find(line, string.lower(w..'|'), 1, true) then
                     if not tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] then
                        tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] = {}
                     end
                     if #tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] == 0 then
                        tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][1] = {
                           xMin = aX - 1,
                           xMax = aX + 1,
                           yMin = aY - 1,
                           yMax = aY + 1,
                        }
                     else
                        local tFoundIndex
                        for q = 1, #tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] do
                           dprint("q", q, #tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]], tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][q])
                           local xmax = tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][q].xMax - aX
                           local ymax = tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][q].yMax - aY
                           local xmin = tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][q].xMin - aX
                           local ymin = tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][q].yMin - aY
                           if xmax < 0 then xmax = xmax * -1 end
                           if ymax < 0 then ymax = ymax * -1 end
                           if xmin < 0 then xmin = xmin * -1 end
                           if ymin < 0 then ymin = ymin * -1 end

                           dprint("  ", xmax, ymax, xmin, ymin)
                           local tRangeNew = 20
                           if xmax < tRangeNew and ymax < tRangeNew and xmin < tRangeNew and ymin < tRangeNew then
                              tFoundIndex = q
                           end
                        end
                        if tFoundIndex then
                           dprint("found", tFoundIndex)
                           if tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].xMin > aX then
                              tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].xMin = aX
                           end
                           if tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].xMax < aX then
                              tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].xMax = aX
                           end
                           if tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].yMin > aY then
                              tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].yMin = aY
                           end
                           if tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].yMax < aY then
                              tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][tFoundIndex].yMax = aY
                           end
                        else
                           dprint("new", SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]], #tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] + 1)
                           tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]][#tFoundPositions[SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]] + 1] = {
                              xMin = aX - 1,
                              xMax = aX + 1,
                              yMin = aY - 1,
                              yMax = aY + 1,
                           }
                        end
                     end

                     return SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]]               
                  end
               end 
            end
         end
      end
   end

   return
end

---------------------------------------------------------------------------------------------------------------------------------------
local tNotificationTicker
local function MinimapScanStep()
	if SkuCore.IsMMScanning == false and SkuCore.inCombat ~= true then
		SkuCore:RestoreMinimap()
      C_Timer.After(1.1, function()
         SkuCore.noMouseOverNotification = nil
      end)      
		return
	end

	tCurrentMMPosX = tCurrentMMPosX + SkuOptions.db.profile[MODULE_NAME].ressourceScanning.scanAccuracyS
	if tCurrentMMPosX > (tRange / 2) then
		tCurrentMMPosX = -(tRange / 2)
		tCurrentMMPosY = tCurrentMMPosY + SkuOptions.db.profile[MODULE_NAME].ressourceScanning.scanAccuracyS
	end

	if tCurrentMMPosY > (tRange / 2) then
		tCurrentMMPosX, tCurrentMMPosY = -(tRange / 2), -(tRange / 2)
		SkuCore.IsMMScanning = false
      C_Timer.After(1, function()
         SkuCore.noMouseOverNotification = true
      end)
      SkuCore:MinimapScanProcessResults()
	end
	
	SetMinimapPosition(tCurrentMMPosX, tCurrentMMPosY)

	C_Timer.After(0, function()
      local tResultString = SkuCore:MinimapScanFindActiveRessource(tCurrentMMPosX, tCurrentMMPosY)
		if tResultString then
			--fx, fy = tCurrentMMPosX, tCurrentMMPosY
			--print(tResultString, fx, fy)
         if not tScanResults[tResultString] then
            tScanResults[tResultString] = 0
         end
         tScanResults[tResultString] = tScanResults[tResultString] + 1
		end
      if SkuCore.inCombat ~= true then
		   MinimapScanStep()
      end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:StoreMinimap()
	tMinimapStore.point, tMinimapStore.relativeTo, tMinimapStore.relativePoint, tMinimapStore.x, tMinimapStore.y = Minimap:GetPoint()
	tMinimapStore.parent = Minimap:GetParent()
	tMinimapStore.scale = Minimap:GetScale()
	tMinimapStore.GameTooltipScale = GameTooltip:GetScale()
	tMinimapStore.frameLevel = MinimapCluster:GetFrameLevel()
	tMinimapStore.frameStrata = MinimapCluster:GetFrameStrata()

	SkuCore.minimapChildren = {Minimap:GetChildren()}
	for k, v in pairs(SkuCore.minimapChildren) do
			v.MMA_VISIBLE = v:IsVisible()
			v.MMA_FRAME_LEVEL = v:GetFrameLevel()
			v.MMA_FRAME_STRATA = v:GetFrameStrata()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RestoreMinimap()
   Minimap:SetScale(tMinimapStore.scale)
   Minimap:ClearAllPoints()
   Minimap:SetPoint(tMinimapStore.point, tMinimapStore.relativeTo, tMinimapStore.relativePoint, tMinimapStore.x, tMinimapStore.y)
   MinimapCluster:SetFrameLevel(tMinimapStore.frameLevel)
   MinimapCluster:SetFrameStrata(tMinimapStore.frameStrata)
   GameTooltip:SetScale(tMinimapStore.GameTooltipScale)

   for k, v in pairs(SkuCore.minimapChildren) do
      if v.MMA_VISIBLE then 
         v:Show() 
      end
      v:SetFrameStrata(v.MMA_FRAME_STRATA)
      v:SetFrameLevel(v.MMA_FRAME_LEVEL)
   end
   SkuCore.noMouseOverNotification = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapStopScan()
   SkuOptions:StartStopBackgroundSound(false)
   SkuCore:RestoreMinimap()
   SkuCore.IsMMScanning = false
   SkuCore:RestoreMinimap()
   if tNotificationTicker then
      tNotificationTicker:Cancel()
   end
   SkuCore.noMouseOverNotification = nil
   SkuOptions.Voice:StopOutputEmptyQueue()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapScan(aRange)
   dprint("MinimapScan", aRange)
   if Questie then
      Questie.db.global.enableMiniMapIcons = false
   end

   SkuCore:GameWorldObjectsCenterMouseCursor(0.5)
   Minimap:SetZoom(0)
   if GetCVar("rotateMinimap") == "1" then
      ToggleMiniMapRotation() 
   end
   SetCVar("minimapAltitudeHintMode", 0)
   
   --diable all tracking options except spells
   local tCount = GetNumTrackingTypes()
   for i = 1, tCount do 
      local name, texture, active, category = GetTrackingInfo(i)
      if category ~= "spell" then
         SetTracking(i, false)
      end
   end

   SkuOptions:StartStopBackgroundSound(true, SkuOptions.db.profile["SkuCore"].scanBackgroundSound)

   aRange = aRange or 20
   tScanResults = {}
   tRange = aRange
   SkuCore.noMouseOverNotification = true

   SkuCore:StoreMinimap() 
   tCurrentMMPosX, tCurrentMMPosY = (aRange / 2) * -1, (aRange / 2) * -1
   tFoundPositions = {}
   SkuCore.IsMMScanning = true 

   MinimapScanStep()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapScanProcessResults()
   if tNotificationTicker then
      tNotificationTicker:Cancel()
   end

   SkuOptions.Voice:StopOutputEmptyQueue()
   SkuOptions:StartStopBackgroundSound(false)

   local tQuickWpNumber = 1
   for i, v in pairs(tScanResults) do
      local xCenter, yCenter
      if tFoundPositions[i] then
         for q = 1, #tFoundPositions[i] do
            local tempX = (tFoundPositions[i][q].xMax + 1000) - (tFoundPositions[i][q].xMin + 1000)
            if tempX < 0 then
               tempX = tempX * -1
            end
            local tempY = (tFoundPositions[i][q].yMax + 1000) - (tFoundPositions[i][q].yMin + 1000)
            if tempY < 0 then
               tempY = tempY * -1
            end
            xCenter = tFoundPositions[i][q].xMin + (tempX / 2) + 2.5
            yCenter = tFoundPositions[i][q].yMin + (tempY / 2) + 0.5
            local xa, ya = UnitPosition("player") 
            if xa then
               xa = xa + (yCenter * -1)
               ya = ya + xCenter
               local tDistance = SkuNav:Distance(0, 0, xCenter, yCenter)
               
               print((tQuickWpNumber or "").." "..i.." "..SkuNav:GetDirectionToAsString(xa, ya).." "..math.floor(tDistance * tMinimapYardsMod).." "..L["Meter"])
               SkuOptions.Voice:OutputStringBTtts((tQuickWpNumber or "").." "..i.." "..SkuNav:GetDirectionToAsString(xa, ya).." "..math.floor(tDistance * tMinimapYardsMod).." "..L["Meter"], false, true, 0.2)

               if tQuickWpNumber then
                  local tAreaId = SkuNav:GetCurrentAreaId()
                  local worldx, worldy = UnitPosition("player")
                  local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())) or -1
                  local tTime = GetTime()
                  SkuNav:SetWaypoint(L["Quick waypoint"]..";"..tQuickWpNumber, {
                     ["contintentId"] = tPlayerContintentId,
                     ["areaId"] = tAreaId,
                     ["worldX"] = worldx + ((yCenter * tMinimapYardsMod)) * -1,
                     ["worldY"] = worldy + ((xCenter * tMinimapYardsMod)),
                     ["createdAt"] = tTime, 
                     ["createdBy"] = "SkuCore",
                     ["size"] = 1,
                  })            
               end

               tQuickWpNumber = tQuickWpNumber + 1
               if tQuickWpNumber > 4 then
                  tQuickWpNumber = nil
               end
            else
               print(i)
               SkuOptions.Voice:OutputStringBTtts(i, false, true, 0.2)

            end
         end
      end
   end
end


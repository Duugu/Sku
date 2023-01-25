---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "minimapScanner"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.RessourceTypes = {
   chests = {
      [1] = { deDE = "Beschädigte Truhe", enUS = "Damaged Chest", zhCN = "破损的箱子", ruRU = "Повреждённый сундук",},
      [2] = { deDE = "Verbeulte Truhe", enUS = "Dented Chest", zhCN = "凹陷的箱子", ruRU = "Проломленный ящик",},
      [3] = { deDE = "Große ramponierte Truhe", enUS = "Large Battered Chest", zhCN = "破碎的大箱子", ruRU = "Большой побитый сундук",},
      [4] = { deDE = "Große eisenbeschlagene Truhe", enUS = "Large Iron Bound Chest", zhCN = "大型铁箍储物箱", ruRU = "Окованный железом большой сундук",},
      [5] = { deDE = "Große mithrilbeschlagene Truhe", enUS = "Large Mithril Bound Chest", zhCN = "大型秘银储物箱", ruRU = "Окованный мифрилом большой сундук",},
      [6] = { deDE = "Große robuste Truhe", enUS = "Large Solid Chest", zhCN = "兼顾的大宝箱", ruRU = "Большой добротный сундук",},
      [7] = { deDE = "Verschlossene Truhe", enUS = "Locked Chest", zhCN = "锁定的宝箱", ruRU = "Запертый сундук",},
      [8] = { deDE = "Primitive Truhe", enUS = "Primitive Chest", zhCN = "粗糙的箱子", ruRU = "Примитивный сундук",},
      [9] = { deDE = "Rostige Truhe", enUS = "Rusty Chest", zhCN = "生锈的箱子", ruRU = "Ржавый сундук",},
      [10] = { deDE = "Robuste Truhe", enUS = "Solid Chest", zhCN = "兼顾的宝箱", ruRU = "Добротный сундук",},
      [11] = { deDE = "Versunkene Truhe", enUS = "Sunken Chest", zhCN = "沉默的宝箱", ruRU = "Затонувший сундук",},
      [12] = { deDE = "Ramponierte Truhe", enUS = "Tattered Chest", zhCN = "破损的箱子", ruRU = "Побитый сундук",},
      [13] = { deDE = "Abgenutzte Truhe", enUS = "Worn Chest", zhCN = "旧箱子", ruRU = "Подержанный сундук",},
      [14] = { deDE = "Adamantitbeschlagene Truhe", enUS = "Adamantite Bound Chest", zhCN = "加固的精金宝箱", ruRU = "Окованный адамантитом сундук",},
      [15] = { deDE = "Teufelseisentruhe", enUS = "Fel Iron Chest", zhCN = "魔铁宝箱", ruRU = "Окованный оскверненным железом сундук",},
   },
   mining = {
      [1] = { deDE = "Kupfervorkommen", enUS = "Copper Vein", zhCN = "铜矿脉", ruRU = "Медная жила",},
      [2] = { deDE = "Zinnvorkommen", enUS = "Tin Vein", zhCN = "锡矿脉", ruRU = "Оловянная жила",},
      [3] = { deDE = "Silbervorkommen", enUS = "Silver Vein", zhCN = "银矿脉", ruRU = "Серебряная жила",},
      [4] = { deDE = "Brühschlammbedecktes Silbervorkommen", enUS = "Ooze Covered Silver Vein", zhCN = "软泥覆盖的银矿脉", ruRU = "Покрытая слизью серебряная жила",},
      [5] = { deDE = "Eisenvorkommen", enUS = "Iron Deposit", zhCN = "铁矿床", ruRU = "Залежи железа",},
      [6] = { deDE = "Goldvorkommen", enUS = "Gold Vein", zhCN = "金矿脉", ruRU = "Золотая жила",},
      [7] = { deDE = "Brühschlammbedecktes Goldvorkommen", enUS = "Ooze Covered Gold Vein", zhCN = "软泥覆盖的金矿脉", ruRU = "Покрытая слизью золотая жила",},
      [8] = { deDE = "Mithrilablagerung", enUS = "Mithril Deposit", zhCN = "秘银矿床", ruRU = "Мифриловые залежи",},
      [9] = { deDE = "Brühschlammbedeckte Mithrilablagerung", enUS = "Ooze Covered Mithril Deposit", zhCN = "软泥覆盖的秘银矿床", ruRU = "Покрытые слизью мифриловые залежи",},
      [10] = { deDE = "Echtsilberablagerung", enUS = "Truesilver Deposit", zhCN = "真银矿床", ruRU = "Залежи истинного серебра",},
      [11] = { deDE = "Brühschlammbedeckte Echtsilberablagerung", enUS = "Ooze Covered Truesilver Deposit", zhCN = "软泥覆盖的真银矿床", ruRU = "Покрытые слизью залежи истинного серебра",},
      [12] = { deDE = "Kleines Thoriumvorkommen", enUS = "Small Thorium Vein", zhCN = "瑟银矿脉", ruRU = "Малая ториевая жила",},
      [13] = { deDE = "Brühschlammbedecktes Thoriumvorkommen", enUS = "Ooze Covered Thorium Vein", zhCN = "软泥覆盖的瑟银矿脉", ruRU = "Покрытая слизью ториевая жила",},
      [14] = { deDE = "Reiches Thoriumvorkommen", enUS = "Rich Thorium Vein", zhCN = "富瑟银矿脉", ruRU = "Богатая ториевая жила",},
      [15] = { deDE = "Brühschlammbedecktes reiches Thoriumvorkommen", enUS = "Ooze Covered Rich Thorium Vein", zhCN = "软泥覆盖的瑟银矿脉", ruRU = "Покрытая слизью богатая ториевая жила",},
      [16] = { deDE = "Dunkeleisenablagerung", enUS = "Dark Iron Deposit", zhCN = "黑铁矿床", ruRU = "Залежи черного железа",},
      [17] = { deDE = "Teufelseisenvorkommen", enUS = "Fel Iron Deposit", zhCN = "魔铁矿床", ruRU = "Залежи оскверненного железа",},
      [18] = { deDE = "Adamantitablagerung", enUS = "Adamantite Deposit", zhCN = "精金矿床", ruRU = "Залежи адамантита",},
      [19] = { deDE = "Reiche Adamantitablagerung", enUS = "Rich Adamantite Deposit", zhCN = "富精金矿床", ruRU = "Богатые залежи адамантита",},
      [20] = { deDE = "Khoriumvorkommen", enUS = "Khorium Vein", zhCN = "氪金矿脉", ruRU = "Кориевая жила",},
      [21] = { deDE = "Kobaltablagerung", enUS = "Cobalt Deposit", zhCN = "钴矿床", ruRU = "Залежи кобальта",},
      [22] = { deDE = "Reiche Kobaltablagerung", enUS = "Rich Cobalt Deposit", zhCN = "富钴矿床", ruRU = "Богатые залежи кобальта",},
      [23] = { deDE = "Saronitablagerung", enUS = "Saronite Deposit", zhCN = "萨隆邪铁矿床", ruRU = "Залежи саронита",},
      [24] = { deDE = "Reiche Saronitablagerung", enUS = "Rich Saronite Deposit", zhCN = "富萨隆邪铁矿床", ruRU = "Богатые залежи саронита",},
      [25] = { deDE = "Reine Saronitablagerung", enUS = "Pure Saronite Deposit", zhCN = "纯萨隆邪铁矿床", ruRU = "Месторождение чистого саронита",},
      [26] = { deDE = "Titanvorkommen", enUS = "Titanium Vein", zhCN = "钛矿脉", ruRU = "Залежи титана",},
      [27] = { deDE = "Reine Adamantitablagerung", enUS = "Pure Adamantite Deposit", zhCN = "纯钛矿床", ruRU = "missing",},
   },
   gasCollector = {
      [1] = { deDE = "Arkanvortex", enUS = "Arcane Vortex", zhCN = "奥数漩涡", ruRU = "Волшебное завихрение",},
      [2] = { deDE = "Teufelsnebel", enUS = "Felmist", zhCN = "魔物", ruRU = "Туман скверны",},
      [3] = { deDE = "Sumpfgas", enUS = "Swamp Gas", zhCN = "沼泽气体", ruRU = "Болотный газ",},
      [4] = { deDE = "Windige Wolke", enUS = "Windy Cloud", zhCN = "气体云雾", ruRU = "Грозовое облако",},
      [5] = { deDE = "Dampfwolke", enUS = "Steam Cloud", zhCN = "蒸汽云雾", ruRU = "Паровое облако",},
      [6] = { deDE = "Aschewolke", enUS = "Cinder Cloud", zhCN = "灰烬云雾", ruRU = "Облако золы",},
      [7] = { deDE = "Arktische Wolke", enUS = "Arctic Cloud", zhCN = "北极云雾", ruRU = "Снежный шар",},
   },
   herbs = {
      [1] = { deDE = "Friedensblume", enUS = "Peacebloom", zhCN = "宁神花", ruRU = "Мироцвет",},
      [2] = { deDE = "Silberblatt", enUS = "Silverleaf", zhCN = "银叶草", ruRU = "Сребролист",},
      [3] = { deDE = "Erdwurzel", enUS = "Earthroot", zhCN = "地根草", ruRU = "Земляной корень",},
      [4] = { deDE = "Maguskönigskraut", enUS = "Mageroyal", zhCN = "魔皇草", ruRU = "Магороза",},
      [5] = { deDE = "Wilddornrose", enUS = "Briarthorn", zhCN = "石南草", ruRU = "Остротерн",},
      [6] = { deDE = "Würgetang", enUS = "Stranglekelp", zhCN = "荆棘藻", ruRU = "Удавник",},
      [7] = { deDE = "Beulengras", enUS = "Bruiseweed", zhCN = "跌打草", ruRU = "Синячник",},
      [8] = { deDE = "Wildstahlblume", enUS = "Wild Steelbloom", zhCN = "野钢花", ruRU = "Дикий сталецвет",},
      [9] = { deDE = "Grabmoos", enUS = "Grave Moss", zhCN = "墓地苔", ruRU = "Могильный мох",},
      [10] = { deDE = "Königsblut", enUS = "Kingsblood", zhCN = "皇血草", ruRU = "Королевская кровь",},
      [11] = { deDE = "Lebenswurz", enUS = "Liferoot", zhCN = "活根草", ruRU = "Корень жизни",},
      [12] = { deDE = "Blassblatt", enUS = "Fadeleaf", zhCN = "枯叶草", ruRU = "Бледнолист",},
      [13] = { deDE = "Golddorn", enUS = "Goldthorn", zhCN = "荆棘草", ruRU = "Златошип",},
      [14] = { deDE = "Khadgars Schnurrbart", enUS = "Khadgar's Whisker", zhCN = "卡德加的胡须", ruRU = "Кадгаров ус",},
      [15] = { deDE = "Winterbiss", enUS = "Wintersbite", zhCN = "冬刺草", ruRU = "Морозник",},
      [16] = { deDE = "Feuerblüte", enUS = "Firebloom", zhCN = "火焰花", ruRU = "Огнецвет",},
      [17] = { deDE = "Lila Lotus", enUS = "Purple Lotus", zhCN = "紫莲花", ruRU = "Лиловый лотос",},
      [18] = { deDE = "Arthas' Tränen", enUS = "Arthas' Tears", zhCN = "阿尔萨斯之泪", ruRU = "Слезы Артаса",},
      [19] = { deDE = "Sonnengras", enUS = "Sungrass", zhCN = "太阳草", ruRU = "Солнечник",},
      [20] = { deDE = "Blindkraut", enUS = "Blindweed", zhCN = "盲目草", ruRU = "Пастушья сумка",},
      [21] = { deDE = "Geisterpilz", enUS = "Ghost Mushroom", zhCN = "幽灵菇", ruRU = "Призрачный гриб",},
      [22] = { deDE = "Gromsblut", enUS = "Gromsblood", zhCN = "格罗姆之血", ruRU = "Кровь грома",},
      [23] = { deDE = "Goldener Sansam", enUS = "Golden Sansam", zhCN = "黄金参", ruRU = "Золотой сансам",},
      [24] = { deDE = "Traumblatt", enUS = "Dreamfoil", zhCN = "梦叶草", ruRU = "Снолист",},
      [25] = { deDE = "Bergsilbersalbei", enUS = "Mountain Silversage", zhCN = "山鼠草", ruRU = "Горный серебряный шалфей",},
      [26] = { deDE = "Pestblüte", enUS = "Plaguebloom", zhCN = "瘟疫花", ruRU = "Чумоцвет",},
      [27] = { deDE = "Eiskappe", enUS = "Icecap", zhCN = "冰盖草", ruRU = "Ледяной зев",},
      [28] = { deDE = "Schwarzer Lotus", enUS = "Black Lotus", zhCN = "黑莲花", ruRU = "Черный лотос",},
      [29] = { deDE = "Teufelsgras", enUS = "Felweed", zhCN = "魔化藻", ruRU = "Сквернопля",},
      [30] = { deDE = "Traumwinde", enUS = "Dreaming Glory", zhCN = "梦露花", ruRU = "Сияние грез",},
      [31] = { deDE = "Terozapfen", enUS = "Terocone", zhCN = "泰罗果", ruRU = "Терошишка",},
      [32] = { deDE = "Zottelkappe", enUS = "Ragveil", zhCN = "邪雾草", ruRU = "Кисейница",},
      [33] = { deDE = "Urflechte", enUS = "Ancient Lichen", zhCN = "远古苔", ruRU = "Древний лишайник",},
      [34] = { deDE = "Netherblüte", enUS = "Netherbloom", zhCN = "虚空花", ruRU = "Пустоцвет",},
      [35] = { deDE = "Alptraumranke", enUS = "Nightmare Vine", zhCN = "噩梦藤", ruRU = "Ползучий кошмарник",},
      [36] = { deDE = "Manadistel", enUS = "Mana Thistle", zhCN = "法力蓟", ruRU = "Манаполох",},
      [37] = { deDE = "Teufelslotus", enUS = "Fel Lotus", zhCN = "魔莲花", ruRU = "Лотос Скверны",},
      [38] = { deDE = "Goldklee", enUS = "Goldclover", zhCN = "金苜蓿", ruRU = "Золотой клевер",},
      [39] = { deDE = "Tigerlilie", enUS = "Tiger Lily", zhCN = "卷丹", ruRU = "Тигровая лилия",},
      [40] = { deDE = "Schlangenzunge", enUS = "Adder's Tongue", zhCN = "蛇信草", ruRU = "Язык аспида",},
      [41] = { deDE = "Talandras Rose", enUS = "Talandra's Rose", zhCN = "塔兰德拉的玫瑰", ruRU = "Роза Таландры",},
      [42] = { deDE = "Lichblüte", enUS = "Lichbloom", zhCN = "巫妖花", ruRU = "Личецвет",},
      [43] = { deDE = "Eisdorn", enUS = "Icethor", zhCN = "冰极草", ruRU = "Ледошип",},
      [44] = { deDE = "Frostlotus", enUS = "Frost Lotus", zhCN = "雪莲花", ruRU = "Северный лотос",},
      [44] = { deDE = "Blutdistel", enUS = "Bloodthistle", zhCN = "血蓟", ruRU = "Кровопийка",},
   },
}


SkuCore.IsScanning = false

local tMinimapYardsMod = 3.125
local tScanResults = {}
local tMinimapStore = {}
local tMinimapDefaults = {}
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
   Minimap:SetPoint('CENTER', nil, 'BOTTOMLEFT', xOffset + x / uiScale, yOffset + y / uiScale)
   GameTooltip:SetScale(300)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tFoundPositions = {}
toptionTypes = {
   "miningNodes",
   "herbs",
   "gasCollector",
}

function SkuCore:MinimapScanFindActiveRessource(aX, aY)
    tRessourceTypes = {
      SkuCore.RessourceTypes.mining,
      SkuCore.RessourceTypes.herbs,
      SkuCore.RessourceTypes.gasCollector,
   }

   for i = 1, GameTooltip:NumLines() do
      local line = string.lower(_G['GameTooltipTextLeft' .. i]:GetText())
      if line then
         for r = 1, #tRessourceTypes do
            for x = 1, #tRessourceTypes[r] do
               if SkuOptions.db.profile[MODULE_NAME].ressourceScanning[toptionTypes[r]][x] == true then
                  for w in string.gmatch(tRessourceTypes[r][x][Sku.LocP], ".+") do
                     if string.find(line, string.lower(w), 1, true) and not string.find(line, string.lower(w .. '|'), 1, true) then
                        if not tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] then
                           tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] = {}
                        end
                        if #tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] == 0 then
                           tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][1] = {
                              xMin = aX - 1,
                              xMax = aX + 1,
                              yMin = aY - 1,
                              yMax = aY + 1,
                           }
                        else
                           local tFoundIndex
                           for q = 1, #tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] do
                              dprint("q", q, #tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ],
                                 tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][q])
                              local xmax = tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][q].xMax - aX
                              local ymax = tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][q].yMax - aY
                              local xmin = tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][q].xMin - aX
                              local ymin = tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][q].yMin - aY
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
                              if tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].xMin > aX then
                                 tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].xMin = aX
                              end
                              if tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].xMax < aX then
                                 tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].xMax = aX
                              end
                              if tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].yMin > aY then
                                 tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].yMin = aY
                              end
                              if tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].yMax < aY then
                                 tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][tFoundIndex].yMax = aY
                              end
                           else
                              dprint("new", tRessourceTypes[r][x][Sku.LocP],
                                 #tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] + 1)
                              tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ][
                                  #tFoundPositions[ tRessourceTypes[r][x][Sku.LocP] ] + 1] = {
                                 xMin = aX - 1,
                                 xMax = aX + 1,
                                 yMin = aY - 1,
                                 yMax = aY + 1,
                              }
                           end
                        end

                        return tRessourceTypes[r][x][Sku.LocP]
                     end
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
      SkuCore.noMouseOverNotification = nil
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

   SkuCore.minimapChildren = { Minimap:GetChildren() }
   for k, v in pairs(SkuCore.minimapChildren) do
      v.MMA_VISIBLE = v:IsVisible()
      v.MMA_FRAME_LEVEL = v:GetFrameLevel()
      v.MMA_FRAME_STRATA = v:GetFrameStrata()
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RestoreMinimap()
   if InCombatLockdown() == true then
      return
   end
   if tMinimapStore.point == nil or tMinimapStore.relativeTo == nil then
      --print(tMinimapStore.point, tMinimapStore.relativeTo, tMinimapStore.relativePoint, tMinimapStore.x, tMinimapStore.y)
      --print("d", tMinimapDefaults.point, tMinimapDefaults.relativeTo, tMinimapDefaults.relativePoint, tMinimapDefaults.x, tMinimapDefaults.y)

      Minimap:SetParent(tMinimapDefaults.parent)
      Minimap:SetScale(tMinimapDefaults.scale or 1)
      Minimap:ClearAllPoints()
      Minimap:SetPoint(tMinimapDefaults.point, tMinimapDefaults.relativeTo, tMinimapDefaults.relativePoint, tMinimapDefaults.x, tMinimapDefaults.y)
      MinimapCluster:SetFrameLevel(tMinimapDefaults.frameLevel)
      MinimapCluster:SetFrameStrata(tMinimapDefaults.frameStrata)
      GameTooltip:SetScale(tMinimapDefaults.GameTooltipScale)

      for k, v in pairs(SkuCore.minimapChildren) do
         if v.MMA_VISIBLE then
            v:Show()
         end
         v:SetFrameStrata(v.MMA_FRAME_STRATA)
         v:SetFrameLevel(v.MMA_FRAME_LEVEL)
      end
   else
      Minimap:SetParent(tMinimapStore.parent)
      Minimap:SetScale(tMinimapStore.scale or 1)
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
   end
   --SkuCore.noMouseOverNotification = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapStopScan()
   SkuOptions:StartStopBackgroundSound(false)
   SkuCore:RestoreMinimap()
   SkuCore.noMouseOverNotification = nil
   SkuCore.IsMMScanning = false
   SkuCore:RestoreMinimap()
   SkuCore.noMouseOverNotification = nil
   if tNotificationTicker then
      tNotificationTicker:Cancel()
   end
   SkuCore.noMouseOverNotification = nil
   SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
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

   SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
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
               if i == "Kobaltablagerung" then
                  i = "Kobaltvorkommen"
               end
               if i == "Reiche Kobaltablagerung" then
                  i = "Reiches Kobaltvorkommen"
               end
               print((tQuickWpNumber or "").." "..i.." "..SkuNav:GetDirectionToAsString(xa, ya).." "..math.floor(tDistance * tMinimapYardsMod) .. " " .. L["Meter"])
               SkuOptions.Voice:OutputStringBTtts((tQuickWpNumber or "").." "..i.." "..SkuNav:GetDirectionToAsString(xa, ya).." "..math.floor(tDistance * tMinimapYardsMod).." ".. L["Meter"], false, true, 0.2)

               if tQuickWpNumber then
                  local tAreaId = SkuNav:GetCurrentAreaId()
                  local worldx, worldy = UnitPosition("player")
                  local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())) or -1
                  local tTime = GetTime()
                  SkuNav:SetWaypoint(L["Quick waypoint"] .. ";" .. tQuickWpNumber, {
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

---------------------------------------------------------------------------------------------------------------------------------------
local tRessourceTypes = {
   SkuCore.RessourceTypes.mining,
   SkuCore.RessourceTypes.herbs,
   SkuCore.RessourceTypes.gasCollector,
}
local tInitialCenterMouse
local tPrevResult = ""
local mmx, mmy
function SkuCore:MinimapScanFast()
   --print("MinimapScanFast")
   if Questie then
      Questie.db.global.enableMiniMapIcons = false
   end

   if not tInitialCenterMouse then
      tInitialCenterMouse = true
      SkuCore:GameWorldObjectsCenterMouseCursor(0.5)
   end

   Minimap:SetAlpha(0)
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

   SkuCore.noMouseOverNotification = true

   SkuCore.MinimapScanFastRunning = true

   SkuCore:StoreMinimap()
   mmx, mmy = Minimap:GetSize()
   Minimap:SetSize(15, 15)
   --Minimap:SetParent(UIParent)
   Minimap:ClearAllPoints()
   local x, y = GetCursorPosition()
   Minimap:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / UIParent:GetScale(), y / UIParent:GetScale())
      
   C_Timer.After(0.1, function()
      GameTooltip:SetAlpha(0)
      for i = 1, GameTooltip:NumLines() do
         local line = _G['GameTooltipTextLeft' .. i]:GetText()
         if line then
            for r = 1, #tRessourceTypes do
               for x = 1, #tRessourceTypes[r] do
                  if SkuOptions.db.profile[MODULE_NAME].ressourceScanning[toptionTypes[r]][x] == true then
                     for w in string.gmatch(tRessourceTypes[r][x][Sku.LocP], ".+") do
                        if string.find(line, w, 1, true) and not string.find(line, w .. '|', 1, true) then
                           if line == "Kobaltablagerung" then
                              line = "Kobaltvorkommen"
                           end
                           if line == "Reiche Kobaltablagerung" then
                              line = "Reiches Kobaltvorkommen"
                           end

                           SkuCore:MinimapScanFastStop(line)
                           return
                        end
                     end
                  end
               end
            end
         end
      end
   
      SkuCore:MinimapScanFastStop()
   end)   
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapScanFastStop(aResult)
   Minimap:SetSize(mmx, mmy)
   SkuCore:RestoreMinimap()
   Minimap:SetAlpha(1)
   if aResult then
      if tPrevResult ~= aResult then
         aResult = string.gsub(aResult, "\\", " slash")
         aResult = string.gsub(aResult, "|", " slash")
         --print(L["found"].." "..aResult)
         SkuOptions.Voice:OutputStringBTtts(aResult, false, true, 0.2)
         tPrevResult = aResult
      end
   else
      tPrevResult = ""
   end
   C_Timer.After(0.1, function()
      GameTooltip:SetAlpha(1)
      SkuCore.noMouseOverNotification = nil
      SkuCore.IsMMScanning = false
      SkuCore.MinimapScanFastRunning = false
   end)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MinimapScannerOnLogin()
   tMinimapDefaults.point, tMinimapDefaults.relativeTo, tMinimapDefaults.relativePoint, tMinimapDefaults.x, tMinimapDefaults.y = Minimap:GetPoint()
   tMinimapDefaults.parent = Minimap:GetParent()
   tMinimapDefaults.scale = Minimap:GetScale()
   tMinimapDefaults.GameTooltipScale = GameTooltip:GetScale()
   tMinimapDefaults.frameLevel = MinimapCluster:GetFrameLevel()
   tMinimapDefaults.frameStrata = MinimapCluster:GetFrameStrata()

   SkuCore.minimapChildren = { Minimap:GetChildren() }
   for k, v in pairs(SkuCore.minimapChildren) do
      v.MMA_VISIBLE = v:IsVisible()
      v.MMA_FRAME_LEVEL = v:GetFrameLevel()
      v.MMA_FRAME_STRATA = v:GetFrameStrata()
   end


   local a = _G["OnMinimapScanner"] or CreateFrame("Button", "OnMinimapScanner", UIParent, "SecureActionButtonTemplate")
   a.timeCounter = 0
   a:SetScript("OnUpdate", function(self, atime)
      if SkuOptions.db.profile[MODULE_NAME].ressourceScanning.notifyOnRessources ~= true then
         return
      end
      if SkuCore.inCombat == true then
         return
      end
      if SkuCore:IsPlayerMoving() ~= true then
         return
      end      
      self.timeCounter = self.timeCounter + atime
      if self.timeCounter > 0.5 then
         if SkuCore.IsMMScanning ~= true then
            SkuCore.IsMMScanning = true
            SkuCore:MinimapScanFast()
            self.timeCounter = 0
         end
      end
   end)
end

function SkuCore:MinimapScannerCURSOR_CHANGED(aEvent, isDefault, newCursorType, oldCursorType, oldCursorVirtualID)
   --print("CURSOR_CHANGED", aEvent, isDefault, newCursorType, oldCursorType, oldCursorVirtualID)

end
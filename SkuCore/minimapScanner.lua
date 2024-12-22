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
      [1] = {enUS = "Cobalt Deposit", deDE = "Kobaltvorkommen", frFR = "Gisement de cobalt", esES = "Depósito de cobalto", ruRU = "Залежи кобальта", ptBR = "Depósito de Cobalto", koKO = "코발트 광맥", zhCN = "钴矿脉", itIT = "Deposito di Cobalto", },
      [2] = {enUS = "Iron Deposit", deDE = "Eisenvorkommen", frFR = "Gisement de fer", esES = "Depósito de hierro", ruRU = "Залежи железа", ptBR = "Depósito de Ferro", koKO = "철 광맥", zhCN = "铁矿石", itIT = "Deposito di Ferro", },
      [3] = {enUS = "Mithril Deposit", deDE = "Mithrilvorkommen", frFR = "Gisement de mithril", esES = "Depósito de mitril", ruRU = "Мифриловые залежи", ptBR = "Depósito de Mithril", koKO = "미스릴 광맥", zhCN = "秘银矿脉", itIT = "Deposito di Mithril", },
      [4] = {enUS = "Fel Iron Deposit", deDE = "Teufelseisenvorkommen", frFR = "Gisement de gangrefer", esES = "Depósito de hierro vil", ruRU = "Залежи оскверненного железа", ptBR = "Depósito de Ferrovil", koKO = "지옥무쇠 광맥", zhCN = "魔铁矿脉", itIT = "Deposito di Vilferro", },
      [5] = {enUS = "Adamantite Deposit", deDE = "Adamantitvorkommen", frFR = "Gisement d’adamantite", esES = "Depósito de adamantita", ruRU = "Залежи адамантита", ptBR = "Depósito de Adamantita", koKO = "아다만타이트 광맥", zhCN = "精金矿脉", itIT = "Deposito di Adamantite", },
      [6] = {enUS = "Obsidium Deposit", deDE = "Obsidiumvorkommen", frFR = "Gisement d’obsidium", esES = "Depósito de obsidium", ruRU = "Залежи обсидиана", ptBR = "Depósito de Obsídio", koKO = "흑요암 광맥", zhCN = "黑曜石碎块", itIT = "Deposito d'Obsidio", },
      [7] = {enUS = "Tin Vein", deDE = "Zinnader", frFR = "Filon d'étain", esES = "Filón de estaño", ruRU = "Оловянная жила", ptBR = "Veio de Estanho", koKO = "주석 광맥", zhCN = "锡矿", itIT = "Vena di Stagno", },
      [8] = {enUS = "Saronite Deposit", deDE = "Saronitvorkommen", frFR = "Gisement de saronite", esES = "Depósito de saronita", ruRU = "Залежи саронита", ptBR = "Depósito de Saronita", koKO = "사로나이트 광맥", zhCN = "萨隆邪铁矿脉", itIT = "Deposito di Saronite", },
      [9] = {enUS = "Rich Thorium Vein", deDE = "Reiche Thoriumader", frFR = "Riche filon de thorium", esES = "Filón de torio enriquecido", ruRU = "Богатая ториевая жила", ptBR = "Veio de Tório Abundante", koKO = "풍부한 토륨 광맥", zhCN = "富瑟银矿", itIT = "Vena Ricca di Torio", },
      [10] = {enUS = "Silver Vein", deDE = "Silberader", frFR = "Filon d’argent", esES = "Filón de plata", ruRU = "Серебряная жила", ptBR = "Veio de Prata", koKO = "은 광맥", zhCN = "银矿", itIT = "Vena d'Argento", },
      [11] = {enUS = "Small Thorium Vein", deDE = "Kleine Thoriumader", frFR = "Petit filon de thorium", esES = "Filón pequeño de torio", ruRU = "Малая ториевая жила", ptBR = "Veio de Tório Escasso", koKO = "작은 토륨 광맥", zhCN = "瑟银矿脉", itIT = "Vena Piccola di Torio", },
      [12] = {enUS = "Truesilver Deposit", deDE = "Echtsilbervorkommen", frFR = "Gisement de vrai-argent", esES = "Depósito de veraplata", ruRU = "Залежи истинного серебра", ptBR = "Depósito de Veraprata", koKO = "진은 광맥", zhCN = "真银矿石", itIT = "Deposito di Verargento", },
      [13] = {enUS = "Elementium Vein", deDE = "Elementiumader", frFR = "Filon d’élémentium", esES = "Filón de elementium", ruRU = "Элементиевая жила", ptBR = "Veio de Elemêntio", koKO = "엘레멘티움 광맥", zhCN = "源质矿", itIT = "Vena d'Elementio", },
      [14] = {enUS = "Titanium Vein", deDE = "Titanader", frFR = "Veine de titane", esES = "Filón de titanio", ruRU = "Залежи титана", ptBR = "Veio de Titânio", koKO = "티타늄 광맥", zhCN = "泰坦神铁矿脉", itIT = "Vena di Titanio", },
      [15] = {enUS = "Rich Saronite Deposit", deDE = "Reiches Saronitvorkommen", frFR = "Riche gisement de saronite", esES = "Depósito rico en saronita", ruRU = "Богатые залежи саронита", ptBR = "Depósito de Saronita Abundante", koKO = "풍부한 사로나이트 광맥", zhCN = "富萨隆邪铁矿脉", itIT = "Deposito Ricco di Saronite", },
      [16] = {enUS = "Khorium Vein", deDE = "Khoriumader", frFR = "Filon de khorium", esES = "Filón de korio", ruRU = "Кориевая жила", ptBR = "Veio de Kório", koKO = "코륨 광맥", zhCN = "氪金矿脉", itIT = "Vena di Korio", },
      [17] = {enUS = "Copper Vein", deDE = "Kupferader", frFR = "Filon de cuivre", esES = "Filón de cobre", ruRU = "Медная жила", ptBR = "Veio de Cobre", koKO = "구리 광맥", zhCN = "铜矿", itIT = "Vena di Rame", },
      [18] = {enUS = "Gold Vein", deDE = "Goldader", frFR = "Filon d’or", esES = "Filón de oro", ruRU = "Золотая жила", ptBR = "Veio de Ouro", koKO = "금 광맥", zhCN = "金矿石", itIT = "Vena d'Oro", },
      [19] = {enUS = "Pyrite Deposit", deDE = "Pyritvorkommen", frFR = "Gisement de pyrite", esES = "Depósito de pirita", ruRU = "Залежи колчедана", ptBR = "Depósito de Pirita", koKO = "황철석 광맥", zhCN = "燃铁矿脉", itIT = "Deposito di Pirite", },
      [20] = {enUS = "Rich Cobalt Deposit", deDE = "Reiches Kobaltvorkommen", frFR = "Riche gisement de cobalt", esES = "Depósito rico en cobalto", ruRU = "Богатые залежи кобальта", ptBR = "Depósito de Cobalto Abundante", koKO = "풍부한 코발트 광맥", zhCN = "富钴矿脉", itIT = "Deposito Ricco di Cobalto", },
      [21] = {enUS = "Copper Vein", deDE = "Kupferader", frFR = "Filon de cuivre", esES = "Filón de cobre", ruRU = "Медная жила", ptBR = "Veio de Cobre", koKO = "구리 광맥", zhCN = "铜矿脉", itIT = "Vena di Rame", },
      [22] = {enUS = "Rich Elementium Vein", deDE = "Reiche Elementiumader", frFR = "Riche filon d’élémentium", esES = "Filón rico en elementium", ruRU = "Богатая элементиевая жила", ptBR = "Veio de Elemêntio Abundante", koKO = "풍부한 엘레멘티움 광맥", zhCN = "富源质矿", itIT = "Vena Ricca d'Elementio", },
      [23] = {enUS = "Copper Vein", deDE = "Kupfervorkommen", frFR = "Filon de cuivre", esES = "Filón de cobre", ruRU = "Медная жила", ptBR = "Copper Vein", koKO = "Copper Vein", zhCN = "Copper Vein", itIT = "Copper Vein", },
      [24] = {enUS = "Dark Iron Deposit", deDE = "Dunkeleisenvorkommen", frFR = "Gisement de sombrefer", esES = "Depósito de hierro negro", ruRU = "Залежи черного железа", ptBR = "Depósito de Ferro Negro", koKO = "검은무쇠 광맥", zhCN = "黑铁矿脉", itIT = "Deposito di Ferroscuro", },
      [25] = {enUS = "Rich Adamantite Deposit", deDE = "Reiches Adamantitvorkommen", frFR = "Riche gisement d’adamantite", esES = "Depósito rico en adamantita", ruRU = "Богатые залежи адамантита", ptBR = "Depósito de Adamantita Abundante", koKO = "풍부한 아다만타이트 광맥", zhCN = "富精金矿脉", itIT = "Deposito Ricco di Adamantite", },
      [26] = {enUS = "Ancient Gem Vein", deDE = "Uralte Edelsteinader", frFR = "Ancien filon de gemmes", esES = "Filón de gemas antiguo", ruRU = "Древняя самоцветная жила", ptBR = "Veio de Gemas Antigo", koKO = "고대 보석 광맥", zhCN = "上古宝石矿脉", itIT = "Antica Vena di Gemme", },
      [27] = {enUS = "Ooze Covered Thorium Vein", deDE = "Schlammbedeckte Thoriumader", frFR = "Filon de thorium couvert de limon", esES = "Filón de torio cubierto de moco", ruRU = "Покрытая слизью ториевая жила", ptBR = "Veio de Tório Coberto de Gosma", koKO = "진흙으로 덮인 토륨 광맥", zhCN = "软泥覆盖的瑟银矿脉", itIT = "Vena di Torio Coperta di Melma", },
      [28] = {enUS = "Small Thorium Vein", deDE = "Kleine Thoriumader", frFR = "Petit filon de thorium", esES = "Filón pequeño de torio", ruRU = "Малая ториевая жила", ptBR = "Veio de Tório Escasso", koKO = "작은 토륨 광맥", zhCN = "瑟银矿脉", itIT = "Vena Piccola di Torio", },
      [29] = {enUS = "Rich Pyrite Deposit", deDE = "Reiches Pyritvorkommen", frFR = "Riche gisement de pyrite", esES = "Depósito rico en pirita", ruRU = "Богатые залежи колчедана", ptBR = "Depósito de Pirita Abundante", koKO = "풍부한 황철석 광맥", zhCN = "富燃铁矿脉", itIT = "Deposito Ricco di Pirite", },
      [30] = {enUS = "Tin Vein", deDE = "Zinnader", frFR = "Filon d'étain", esES = "Filón de estaño", ruRU = "Оловянная жила", ptBR = "Veio de Estanho", koKO = "주석 광맥", zhCN = "锡矿脉", itIT = "Vena di Stagno", },
      [31] = {enUS = "Rich Adamantite Deposit", deDE = "Reiches Adamantitvorkommen", frFR = "Riche gisement d’adamantite", esES = "Depósito rico en adamantita", ruRU = "Богатые залежи адамантита", ptBR = "Depósito de Adamantita Abundante", koKO = "풍부한 아다만타이트 광맥", zhCN = "富精金矿脉", itIT = "Deposito Ricco di Adamantite", },
      [32] = {enUS = "Mithril Deposit", deDE = "Mithrilablagerung", frFR = "Gisement de mithril", esES = "Depósito de mitril", ruRU = "Мифриловые залежи", ptBR = "Mithril Deposit", koKO = "미스릴 광맥", zhCN = "Mithril Deposit", itIT = "Mithril Deposit", },
      [33] = {enUS = "Copper Vein", deDE = "Kupfervorkommen", frFR = "Filon de cuivre", esES = "Filón de cobre", ruRU = "Медная жила", ptBR = "Copper Vein", koKO = "구리 광맥", zhCN = "Copper Vein", itIT = "Copper Vein", },
      [34] = {enUS = "Tin Vein", deDE = "Zinnvorkommen", frFR = "Filon d'étain", esES = "Filón de estaño", ruRU = "Оловянная жила", ptBR = "Tin Vein", koKO = "주석 광맥", zhCN = "Tin Vein", itIT = "Tin Vein", },
      [35] = {enUS = "Gold Vein", deDE = "Goldvorkommen", frFR = "Filon d'or", esES = "Filón de oro", ruRU = "Золотая жила", ptBR = "Gold Vein", koKO = "Gold Vein", zhCN = "Gold Vein", itIT = "Gold Vein", },
      [36] = {enUS = "Small Obsidian Chunk", deDE = "Kleiner Obsidianbrocken", frFR = "Petit morceau d'obsidienne", esES = "Trozo de obsidiana pequeño", ruRU = "Маленький кусочек обсидиана", ptBR = "Pequeno Estilhaço de Obsidiana", koKO = "작은 흑요석 덩어리", zhCN = "小型黑曜石碎块", itIT = "Frammento Piccolo d'Ossidiana", },
      [37] = {enUS = "Tin Vein", deDE = "Zinnvorkommen", frFR = "Filon d'étain", esES = "Filón de estaño", ruRU = "Оловянная жила", ptBR = "Tin Vein", koKO = "Tin Vein", zhCN = "Tin Vein", itIT = "Tin Vein", },
      [38] = {enUS = "Truesilver Deposit", deDE = "Echtsilberablagerung", frFR = "Gisement de vrai-argent", esES = "Depósito de veraplata", ruRU = "Залежи истинного серебра", ptBR = "Truesilver Deposit", koKO = "진은 광맥", zhCN = "Truesilver Deposit", itIT = "Truesilver Deposit", },
      [39] = {enUS = "Gold Vein", deDE = "Goldvorkommen", frFR = "Filon d'or", esES = "Filón de oro", ruRU = "Золотая жила", ptBR = "Gold Vein", koKO = "Gold Vein", zhCN = "Gold Vein", itIT = "Gold Vein", },
      [40] = {enUS = "Truesilver Deposit", deDE = "Echtsilbervorkommen", frFR = "Gisement de vrai-argent", esES = "Depósito de veraplata", ruRU = "Залежи истинного серебра", ptBR = "Depósito de Veraprata", koKO = "진은 광맥", zhCN = "真银矿石", itIT = "Deposito di Verargento", },
      [41] = {enUS = "Nethercite Deposit", deDE = "Netheritvorkommen", frFR = "Gisement de néanticite", esES = "Depósito de abisalita", ruRU = "Залежи хаотита", ptBR = "Depósito de Etercita", koKO = "황천연 광맥", zhCN = "虚空矿脉", itIT = "Deposito di Faturcite", },
      [42] = {enUS = "Chunk of Saronite", deDE = "Saronitbrocken", frFR = "Morceau de saronite", esES = "Trozo de saronita", ruRU = "Кусок саронита", ptBR = "Pedaço de Saronita", koKO = "사로나이트 덩어리", zhCN = "大块的萨隆邪铁", itIT = "Pezzo di Saronite", },
      [43] = {enUS = "Copper Vein", deDE = "Kupfervorkommen", frFR = "Filon de cuivre", esES = "Filón de cobre", ruRU = "Медная жила", ptBR = "Copper Vein", koKO = "구리 광맥", zhCN = "Copper Vein", itIT = "Copper Vein", },
      [44] = {enUS = "Draenethyst Mine Crystal", deDE = "Kristall der Draenethystmine", frFR = "Cristal de mine de draenéthyste", esES = "Cristal de Mina Draenetista", ruRU = "Кристалл дренетиста", ptBR = "Cristal da Mina de Draenetista", koKO = "드레니시스트 광산 수정", zhCN = "德拉诺晶体", itIT = "Cristallo della Miniera di Draenetista", },
      [45] = {enUS = "Nethervine Crystal", deDE = "Netherrankenkristall", frFR = "Cristal vignéant", esES = "Cristal de vid abisal", ruRU = "Кристалл Лозы Пустоты", ptBR = "Cristal Etervinha", koKO = "황천덩굴 수정", zhCN = "灵藤水晶", itIT = "Cristallo di Cespofatuo", },
      [46] = {enUS = "Pure Saronite Deposit", deDE = "Reine Saronitablagerung", frFR = "Gisement de saronite pure", esES = "Depósito de saronita pura", ruRU = "Месторождение чистого саронита", ptBR = "Pure Saronite Deposit", koKO = "Pure Saronite Deposit", zhCN = "Pure Saronite Deposit", itIT = "Pure Saronite Deposit", },
      [47] = {enUS = "Rich Obsidium Deposit", deDE = "Reiches Obsidiumvorkommen", frFR = "Riche gisement d’obsidium", esES = "Depósito rico en obsidium", ruRU = "Громадный кусок обсидиана", ptBR = "Depósito de Obsídio Abundante", koKO = "풍부한 흑요암 광맥", zhCN = "巨型黑曜石石板", itIT = "Deposito Ricco d'Obsidio", },
      [48] = {enUS = "Sapphire of Aku'Mai", deDE = "Saphir von Aku'mai", frFR = "Saphir d’Aku’Mai", esES = "Zafiro de Aku'Mai", ruRU = "Сапфир Аку'мая", ptBR = "Safira de Aku'Mai", koKO = "아쿠마이의 사파이어", zhCN = "Sapphire of Aku'Mai", itIT = "Zaffiro di Aku'mai", },
      [49] = {enUS = "The Light of Souls", deDE = "Das Licht der Seelen", frFR = "La Lumière des âmes", esES = "La Luz de las almas", ruRU = "Свет души", ptBR = "A Luz das Almas", koKO = "영혼의 빛", zhCN = "灵魂之光", itIT = "Luce delle Anime", },
      [50] = {enUS = "Tin Vein", deDE = "Zinnader", frFR = "Filon d'étain", esES = "Filón de estaño", ruRU = "Оловянная жила", ptBR = "Tin Vein", koKO = "주석 광맥", zhCN = "Tin Vein", itIT = "Tin Vein", },
      [51] = {enUS = "Ooze Covered Silver Vein", deDE = "Schlammbedecktes Silbervorkommen", frFR = "Filon d'argent couvert de limon", esES = "Filón de plata cubierto de moco", ruRU = "Покрытая слизью серебряная жила", ptBR = "Ooze Covered Silver Vein", koKO = "Ooze Covered Silver Vein", zhCN = "Ooze Covered Silver Vein", itIT = "Ooze Covered Silver Vein", },
      [52] = {enUS = "Mithril Deposit", deDE = "Mithrilablagerung", frFR = "Gisement de mithril", esES = "Depósito de mitril", ruRU = "Мифриловые залежи", ptBR = "Mithril Deposit", koKO = "Mithril Deposit", zhCN = "Mithril Deposit", itIT = "Mithril Deposit", },
      [53] = {enUS = "Ooze Covered Rich Thorium Vein", deDE = "Schlammbedecktes reiches Thoriumvorkommen", frFR = "Riche filon de thorium couvert de limon", esES = "Filón de torio enriquecido cubierto de moco", ruRU = "Покрытая слизью богатая ториевая жила", ptBR = "Ooze Covered Rich Thorium Vein", koKO = "Ooze Covered Rich Thorium Vein", zhCN = "Ooze Covered Rich Thorium Vein", itIT = "Ooze Covered Rich Thorium Vein", },
      [54] = {enUS = "Sapphire of Aku'Mai", deDE = "Saphir von Aku'mai", frFR = "Saphir d’Aku’Mai", esES = "Zafiro de Aku'Mai", ruRU = "Сапфир Аку'мая", ptBR = "Safira de Aku'Mai", koKO = "아쿠마이의 사파이어", zhCN = "Sapphire of Aku'Mai", itIT = "Zaffiro di Aku'mai", },
      [55] = {enUS = "Incendicite Mineral Vein", deDE = "Pyrophormineralvorkommen", frFR = "Filon d'incendicite", esES = "Filón de incendicita", ruRU = "Ароматитовая жила", ptBR = "Incendicite Mineral Vein", koKO = "Incendicite Mineral Vein", zhCN = "Incendicite Mineral Vein", itIT = "Incendicite Mineral Vein", },
      [56] = {enUS = "Incendicite Mineral Vein", deDE = "Pyrophormineralvorkommen", frFR = "Filon d'incendicite", esES = "Filón de incendicita", ruRU = "Ароматитовая жила", ptBR = "Incendicite Mineral Vein", koKO = "Incendicite Mineral Vein", zhCN = "Incendicite Mineral Vein", itIT = "Incendicite Mineral Vein", },
      [57] = {enUS = "Ooze Covered Truesilver Deposit", deDE = "Schlammbedecktes Echtsilbervorkommen", frFR = "Gisement de vrai-argent couvert de vase", esES = "Depósito de veraplata cubierta de moco", ruRU = "Покрытые слизью залежи истинного серебра", ptBR = "Depósito de Veraprata Coberto de Gosma", koKO = "Ooze Covered Truesilver Deposit", zhCN = "Ooze Covered Truesilver Deposit", itIT = "Deposito di Verargento Coperto di Melma", },
      [58] = {enUS = "Black Blood of Yogg-Saron", deDE = "Schwarzes Blut von Yogg-Saron", frFR = "Sang noir de Yogg-Saron", esES = "Sangre negra de Yogg-Saron", ruRU = "Черная кровь Йогг-Сарона", ptBR = "Sangue Negro de Yogg-Saron", koKO = "요그사론의 검은피", zhCN = "尤格-萨隆的黑血", itIT = "Sangue Nero di Yogg-Saron", },
      [59] = {enUS = "Enchanted Earth", deDE = "Verzauberte Erde", frFR = "Terre enchantée", esES = "Tierra encantada", ruRU = "Зачарованная земля", ptBR = "Terra Encantada", koKO = "마력 깃든 흙", zhCN = "魔化土壤", itIT = "Terra Incantata", },
      [60] = {enUS = "Needles Iron Pyrite", deDE = "Eisenpyrit von Tausen Nadeln", frFR = "Pyrite de fer des Mille pointes", esES = "Pirita de hierro de las Mil Agujas", ruRU = "Железный колчедан Тысячи Игл", ptBR = "Pirita de Ferro de Mil Agulhas", koKO = "봉우리 철 황철석", zhCN = "千针石林燃铁矿", itIT = "Pirite Ferrea di Millepicchi", },
      [61] = {enUS = "Sapphire of Aku'Mai", deDE = "Saphir von Aku'mai", frFR = "Saphir d’Aku’Mai", esES = "Zafiro de Aku'Mai", ruRU = "Сапфир Аку'мая", ptBR = "Safira de Aku'Mai", koKO = "아쿠마이의 사파이어", zhCN = "Sapphire of Aku'Mai", itIT = "Zaffiro di Aku'mai", },
      [62] = {enUS = "Lesser Bloodstone Deposit", deDE = "Geringes Blutsteinvorkommen", frFR = "Gisement de pierre de sang inférieure", esES = "Depósito de sangrita inferior", ruRU = "Малое месторождение кровавого камня", ptBR = "Lesser Bloodstone Deposit", koKO = "Lesser Bloodstone Deposit", zhCN = "Lesser Bloodstone Deposit", itIT = "Lesser Bloodstone Deposit", },
      [63] = {enUS = "Silver Vein", deDE = "Silbervorkommen", frFR = "Filon d'argent", esES = "Filón de plata", ruRU = "Серебряная жила", ptBR = "Silver Vein", koKO = "Silver Vein", zhCN = "Silver Vein", itIT = "Silver Vein", },
      [64] = {enUS = "Ooze Covered Gold Vein", deDE = "Schlammbedecktes Goldvorkommen", frFR = "Filon d'or couvert de limon", esES = "Filón de oro cubierto de moco", ruRU = "Покрытая слизью золотая жила", ptBR = "Ooze Covered Gold Vein", koKO = "Ooze Covered Gold Vein", zhCN = "Ooze Covered Gold Vein", itIT = "Ooze Covered Gold Vein", },
      [65] = {enUS = "Indurium Mineral Vein", deDE = "Induriummineralvorkommen", frFR = "Filon d'indurium", esES = "Filón de indurio", ruRU = "Индарилиевая жила", ptBR = "Indurium Mineral Vein", koKO = "Indurium Mineral Vein", zhCN = "Indurium Mineral Vein", itIT = "Indurium Mineral Vein", },
      [66] = {enUS = "Ooze Covered Mithril Deposit", deDE = "Schlammbedeckte Mithrilablagerung", frFR = "Gisement de mithril couvert de vase", esES = "Depósito de mitril cubierto de moco", ruRU = "Покрытые слизью мифриловые залежи", ptBR = "Ooze Covered Mithril Deposit", koKO = "Ooze Covered Mithril Deposit", zhCN = "Ooze Covered Mithril Deposit", itIT = "Ooze Covered Mithril Deposit", },
      [67] = {enUS = "Small Thorium Vein", deDE = "Kleines Thoriumvorkommen", frFR = "Petit filon de thorium", esES = "Filón pequeño de torio", ruRU = "Малая ториевая жила", ptBR = "Small Thorium Vein", koKO = "작은 토륨 광맥", zhCN = "Small Thorium Vein", itIT = "Small Thorium Vein", },
      [68] = {enUS = "Hakkari Thorium Vein", deDE = "", frFR = "Filon de thorium hakkari", esES = "Filón de torio de Hakkari", ruRU = "", ptBR = "Hakkari Thorium Vein", koKO = "Hakkari Thorium Vein", zhCN = "Hakkari Thorium Vein", itIT = "Hakkari Thorium Vein", },
      [69] = {enUS = "Alterac Granite", deDE = "Alteracgranit", frFR = "Granit d'Alterac", esES = "Granito de Alterac", ruRU = "Альтеракский гранит", ptBR = "Alterac Granite", koKO = "Alterac Granite", zhCN = "Alterac Granite", itIT = "Alterac Granite", },
      [70] = {enUS = "Enchanted Earth", deDE = "Verzauberte Erde", frFR = "Terre enchantée", esES = "Tierra encantada", ruRU = "Зачарованная земля", ptBR = "", koKO = "마력 깃든 흙", zhCN = "魔化土壤", itIT = "Terra Incantata", },
      [71] = {enUS = "Shiny Stones", deDE = "Glänzende Steine", frFR = "Pierres rutilantes", esES = "Piedras lustrosas", ruRU = "Блестящие камешки", ptBR = "Pedras Brilhantes", koKO = "반짝이는 돌", zhCN = "闪光石子", itIT = "Pietre Lucenti", },
      [72] = {enUS = "Strange Ore", deDE = "Seltsames Erz", frFR = "Minerai étrange", esES = "Mena extraña", ruRU = "Странная руда", ptBR = "Minério Estranho", koKO = "괴상한 광석", zhCN = "奇怪的矿石", itIT = "Minerale Strano", },
      [73] = {enUS = "Large Obsidian Chunk", deDE = "Großer Obsidianbrocken", frFR = "Grand morceau d'obsidienne", esES = "Trozo de obsidiana grande", ruRU = "Большая обсидиановая глыба", ptBR = "Grande Estilhaço de Obsidiana", koKO = "", zhCN = "大型黑曜石碎块", itIT = "Frammento Grande d'Ossidiana", },
      
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
      [1] = {enUS = "Goldthorn", deDE = "Golddorn", frFR = "Dorépine", esES = "Espina de oro", ruRU = "Златошип", ptBR = "Espinheira-dourada", koKO = "황금가시", zhCN = "金棘草", itIT = "Orospino", },
      [2] = {enUS = "Blindweed", deDE = "Blindkraut", frFR = "Aveuglette", esES = "Carolina", ruRU = "Пастушья сумка", ptBR = "Ervacega", koKO = "실명초", zhCN = "盲目草", itIT = "Erbacieca", },
      [3] = {enUS = "Purple Lotus", deDE = "Lila Lotus", frFR = "Lotus pourpre", esES = "Loto cárdeno", ruRU = "Лиловый лотос", ptBR = "Lótus Roxo", koKO = "보라 연꽃", zhCN = "紫莲花", itIT = "Loto Purpureo", },
      [4] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Ervassol", koKO = "태양풀", zhCN = "太阳草", itIT = "Erbasole", },
      [5] = {enUS = "Azshara's Veil", deDE = "Azsharas Schleier", frFR = "Voile d'Azshara", esES = "Velo de Azshara", ruRU = "Вуаль Азшары", ptBR = "Véu-de-azshara", koKO = "아즈샤라의 신비", zhCN = "艾萨拉雾菇", itIT = "Velo di Azshara", },
      [6] = {enUS = "Stranglekelp", deDE = "Würgetang", frFR = "Etouffante", esES = "Alga estranguladora", ruRU = "Удавник", ptBR = "Estrangulalga", koKO = "갈래물풀", zhCN = "荆棘藻", itIT = "Algatorta", },
      [7] = {enUS = "Wild Steelbloom", deDE = "Wildstahlblume", frFR = "Aciérite sauvage", esES = "Acérita salvaje", ruRU = "Дикий сталецвет", ptBR = "Ácera-agreste", koKO = "야생 철쭉", zhCN = "野钢花", itIT = "Fiordiferro Selvatico", },
      [8] = {enUS = "Briarthorn", deDE = "Wilddornrose", frFR = "Eglantine", esES = "Brezospina", ruRU = "Остротерн", ptBR = "Cravespinho", koKO = "찔레가시", zhCN = "石南草", itIT = "Grandespina", },
      [9] = {enUS = "Whiptail", deDE = "Gertenrohr", frFR = "Fouettine", esES = "Colátigo", ruRU = "Хлыстохвост", ptBR = "Azorrague", koKO = "채찍꼬리", zhCN = "鞭尾草", itIT = "Frustaliana", },
      [10] = {enUS = "Goldclover", deDE = "Goldklee", frFR = "Trèfle doré", esES = "Trébol de oro", ruRU = "Золотой клевер", ptBR = "Trevo Dourado", koKO = "황금토끼풀", zhCN = "金苜蓿", itIT = "Trifoglio d'Oro", },
      [11] = {enUS = "Bruiseweed", deDE = "Beulengras", frFR = "Doulourante", esES = "Hierba cardenal", ruRU = "Синячник", ptBR = "Ervamossa", koKO = "생채기풀", zhCN = "跌打草", itIT = "Erbalivida", },
      [12] = {enUS = "Gromsblood", deDE = "Gromsblut", frFR = "Gromsang", esES = "Gromsanguina", ruRU = "Кровь Грома", ptBR = "Sangue-de-grom", koKO = "그롬의 피", zhCN = "格罗姆之血", itIT = "Sangue di Grommash", },
      [13] = {enUS = "Kingsblood", deDE = "Königsblut", frFR = "Sang-royal", esES = "Sangrerregia", ruRU = "Королевская кровь", ptBR = "Sangue-real", koKO = "왕꽃잎풀", zhCN = "皇血草", itIT = "Sanguesacro", },
      [14] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "Folha-de-sonho", koKO = "꿈풀", zhCN = "梦叶草", itIT = "Foglia Onirica", },
      [15] = {enUS = "Adder's Tongue", deDE = "Schlangenzunge", frFR = "Langue de serpent", esES = "Lengua de víboris", ruRU = "Язык аспида", ptBR = "Língua-de-áspide", koKO = "얼레지 꽃", zhCN = "蛇信草", itIT = "Lingua di Vipera", },
      [16] = {enUS = "Cinderbloom", deDE = "Aschenblüte", frFR = "Cendrelle", esES = "Flor de ceniza", ruRU = "Пепельник", ptBR = "Cinzanilha", koKO = "재투성이꽃", zhCN = "燃烬草", itIT = "Sbocciacenere", },
      [17] = {enUS = "Twilight Jasmine", deDE = "Schattenjasmin", frFR = "Jasmin crépusculaire", esES = "Jazmín Crepuscular", ruRU = "Сумеречный жасмин", ptBR = "Jasmim-do-crepúsculo", koKO = "황혼의 말리꽃", zhCN = "暮光茉莉", itIT = "Gelsomino del Crepuscolo", },
      [18] = {enUS = "Dragon's Teeth", deDE = "Drachenzahn", frFR = "Dents de dragon", esES = "Dientes de dragón", ruRU = "Драконьи зубы", ptBR = "Dentes de dragão", koKO = "용 송곳니", zhCN = "龙齿草", itIT = "Dente di Drago", },
      [19] = {enUS = "Fadeleaf", deDE = "Blassblatt", frFR = "Pâlerette", esES = "Pálida", ruRU = "Бледнолист", ptBR = "Some-folha", koKO = "미명초잎", zhCN = "枯叶草", itIT = "Foglia Eterea", },
      [20] = {enUS = "Liferoot", deDE = "Lebenswurz", frFR = "Vietérule", esES = "Vidarraíz", ruRU = "Корень жизни", ptBR = "Raiz-da-vida", koKO = "생명의 뿌리", zhCN = "活根草", itIT = "Bulbovivo", },
      [21] = {enUS = "Sorrowmoss", deDE = "Trauermoos", frFR = "Chagrinelle", esES = "Musgopena", ruRU = "Печаль-трава", ptBR = "Limágoa", koKO = "슬픔이끼", zhCN = "哀伤苔", itIT = "Muschiocupo", },
      [22] = {enUS = "Ragveil", deDE = "Zottelkappe", frFR = "Voile-misère", esES = "Velada", ruRU = "Кисейница", ptBR = "Trapovéu", koKO = "가림막이버섯", zhCN = "邪雾草", itIT = "Velorotto", },
      [23] = {enUS = "Heartblossom", deDE = "Herzblüte", frFR = "Pétale de cœur", esES = "Flor de corazón", ruRU = "Цветущее сердце", ptBR = "Coronália", koKO = "심장꽃", zhCN = "心灵之花", itIT = "Cuorfiorito", },
      [24] = {enUS = "Netherbloom", deDE = "Netherblüte", frFR = "Néantine", esES = "Flor abisal", ruRU = "Пустоцвет", ptBR = "Floretérea", koKO = "황천꽃", zhCN = "虚空花", itIT = "Sbocciafatuo", },
      [25] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Sonsona-dourada", koKO = "황금 산삼", zhCN = "黄金参", itIT = "Sansam Dorato", },
      [26] = {enUS = "Terocone", deDE = "Terozapfen", frFR = "Terocône", esES = "Teropiña", ruRU = "Терошишка", ptBR = "Teropinha", koKO = "테로열매", zhCN = "泰罗果", itIT = "Terocone", },
      [27] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "Salviargenta de montaña", ruRU = "Горный серебряный шалфей", ptBR = "Sálvia-prata-da-montanha", koKO = "은초롱이", zhCN = "山鼠草", itIT = "Ramargento Montano", },
      [28] = {enUS = "Icethorn", deDE = "Eisdorn", frFR = "Glacépine", esES = "Espina de hielo", ruRU = "Ледошип", ptBR = "Gelocardo", koKO = "얼음가시", zhCN = "冰棘草", itIT = "Gelaspina", },
      [29] = {enUS = "Khadgar's Whisker", deDE = "Khadgars Schnurrbart", frFR = "Moustache de Khadgar", esES = "Mostacho de Khadgar", ruRU = "Кадгаров ус", ptBR = "Bigode-de-hadgar", koKO = "카드가의 수염", zhCN = "卡德加的胡须", itIT = "Ciuffo di Khadgar", },
      [30] = {enUS = "Talandra's Rose", deDE = "Talandras Rose", frFR = "Rose de Talandra", esES = "Rosa de Talandra", ruRU = "Роза Таландры", ptBR = "Rosa-de-talandra", koKO = "탈란드라의 장미", zhCN = "塔兰德拉的玫瑰", itIT = "Rosa di Talandra", },
      [31] = {enUS = "Stormvine", deDE = "Sturmwinde", frFR = "Vignétincelle", esES = "Viñaviento", ruRU = "Ливневая лоза", ptBR = "Tempesvina", koKO = "폭풍덩굴", zhCN = "风暴藤", itIT = "Vite Tempestosa", },
      [32] = {enUS = "Nightmare Vine", deDE = "Alptraumranke", frFR = "Cauchemardelle", esES = "Vid pesadilla", ruRU = "Ползучий кошмарник", ptBR = "Vinha-do-pesadelo", koKO = "악몽의 덩굴", zhCN = "噩梦藤", itIT = "Vite dell'Incubo", },
      [33] = {enUS = "Felweed", deDE = "Teufelsgras", frFR = "Gangrelette", esES = "Hierba vil", ruRU = "Сквернопля", ptBR = "Vilerva", koKO = "지옥풀", zhCN = "魔草", itIT = "Erbavile", },
      [34] = {enUS = "Grave Moss", deDE = "Grabmoos", frFR = "Tombeline", esES = "Musgo de tumba", ruRU = "Могильный мох", ptBR = "Musgo-de-tumba", koKO = "무덤이끼", zhCN = "墓地苔", itIT = "Muschio di Tomba", },
      [35] = {enUS = "Icecap", deDE = "Eiskappe", frFR = "Chapeglace", esES = "Setelo", ruRU = "Ледяной зев", ptBR = "Chapéu-de-gelo", koKO = "얼음송이", zhCN = "冰盖草", itIT = "Corolla Invernale", },
      [36] = {enUS = "Tiger Lily", deDE = "Tigerlilie", frFR = "Lys tigré", esES = "Lirio atigrado", ruRU = "Тигровая лилия", ptBR = "Lírio-tigre", koKO = "참나리", zhCN = "卷丹", itIT = "Giglio Tigrato", },
      [37] = {enUS = "Firebloom", deDE = "Feuerblüte", frFR = "Fleur de feu", esES = "Flor de fuego", ruRU = "Огнецвет", ptBR = "Ignídea", koKO = "화염초", zhCN = "火焰花", itIT = "Sbocciafuoco", },
      [38] = {enUS = "Ghost Mushroom", deDE = "Geisterpilz", frFR = "Champignon fantôme", esES = "Champiñón fantasma", ruRU = "Призрачная поганка", ptBR = "Cogumelo-fantasma", koKO = "유령버섯", zhCN = "幽灵菇", itIT = "Fungo Fantasma", },
      [39] = {enUS = "Crystalsong Carrot", deDE = "Kristallsangkarotte", frFR = "Carotte du Chant de cristal", esES = "Zanahoria Canto de Cristal", ruRU = "Морковь из леса Хрустальной Песни", ptBR = "Cenoura do Canto Cristalino", koKO = "수정노래 당근", zhCN = "晶歌胡萝卜", itIT = "Carota della Foresta di Cristallo", },
      [40] = {enUS = "Lichbloom", deDE = "Lichblüte", frFR = "Fleur-de-liche", esES = "Flor exánime", ruRU = "Личецвет", ptBR = "Flor-de-lich", koKO = "시체꽃", zhCN = "巫妖花", itIT = "Fiore del Lich", },
      [41] = {enUS = "Earthroot", deDE = "Erdwurzel", frFR = "Terrestrine", esES = "Raíz de tierra", ruRU = "Земляной корень", ptBR = "Raiz-telúrica", koKO = "뱀뿌리", zhCN = "地根草", itIT = "Bulboterro", },
      [42] = {enUS = "Mana Thistle", deDE = "Manadistel", frFR = "Chardon de mana", esES = "Cardo de maná", ruRU = "Манаполох", ptBR = "Manacardo", koKO = "마나 엉겅퀴", zhCN = "法力蓟", itIT = "Cardomana", },
      [43] = {enUS = "Blood Mushroom", deDE = "Blutpilz", frFR = "Champignon de sang", esES = "Champiñón sanguino", ruRU = "Кровавый гриб", ptBR = "Cogumelo de Sangue", koKO = "피버섯", zhCN = "血蘑菇", itIT = "Fungo Sanguinello", },
      [44] = {enUS = "Silverleaf", deDE = "Silberblatt", frFR = "Feuillargent", esES = "Hojaplata", ruRU = "Сребролист", ptBR = "Folha-prata", koKO = "은엽수 덤불", zhCN = "银叶草", itIT = "Fogliargenta", },
      [45] = {enUS = "Firethorn", deDE = "Feuerdorn", frFR = "Epine de feu", esES = "Espino de fuego", ruRU = "Огница", ptBR = "Espinho de Fogo", koKO = "화염가시풀", zhCN = "火棘花", itIT = "Ardispina", },
      [46] = {enUS = "Ancient Lichen", deDE = "Urflechte", frFR = "Lichen ancien", esES = "Liquen antiguo", ruRU = "Древний лишайник", ptBR = "Líquen-antigo", koKO = "고대 이끼", zhCN = "远古苔", itIT = "Lichene Antico", },
      [47] = {enUS = "Frost Lotus", deDE = "Frostlotus", frFR = "Lotus givré", esES = "Loto de escarcha", ruRU = "Северный лотос", ptBR = "Lótus Gélido", koKO = "서리 연꽃", zhCN = "雪莲花", itIT = "Loto Gelido", },
      [48] = {enUS = "Mageroyal", deDE = "Maguskönigskraut", frFR = "Mage royal", esES = "Marregal", ruRU = "Магороза", ptBR = "Magi-real", koKO = "마법초", zhCN = "魔皇草", itIT = "Magareale", },
      [49] = {enUS = "Briarthorn", deDE = "Wilddornrose", frFR = "Eglantine", esES = "Brezospina", ruRU = "Остротерн", ptBR = "Cravespinho", koKO = "찔레가시", zhCN = "石南草", itIT = "Grandespina", },
      [50] = {enUS = "Dreaming Glory", deDE = "Traumwinde", frFR = "Glaurier", esES = "Gloria de ensueño", ruRU = "Сияние грез", ptBR = "Glória-sonhadora", koKO = "꿈초롱이", zhCN = "梦露花", itIT = "Gloria d'Oro", },
      [51] = {enUS = "Felweed", deDE = "Teufelsgras", frFR = "Gangrelette", esES = "Hierba vil", ruRU = "Сквернопля", ptBR = "Vilerva", koKO = "지옥풀", zhCN = "魔草", itIT = "Erbavile", },
      [52] = {enUS = "Winter Hyacinth", deDE = "Winterhyazinthe", frFR = "Jacinthe d'hiver", esES = "Jacinto de invierno", ruRU = "Зимний гиацинт", ptBR = "Jacinto do Gelo", koKO = "겨울 히아신스", zhCN = "冬水仙", itIT = "Giacinto Invernale", },
      [53] = {enUS = "Mageroyal", deDE = "Maguskönigskraut", frFR = "Mage royal", esES = "Marregal", ruRU = "Магороза", ptBR = "Magi-real", koKO = "마법초", zhCN = "魔皇草", itIT = "Magareale", },
      [54] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "Salviargenta de montaña", ruRU = "Горный серебряный шалфей", ptBR = "Mountain Silversage", koKO = "은초롱이", zhCN = "Mountain Silversage", itIT = "Mountain Silversage", },
      [55] = {enUS = "Black Lotus", deDE = "Schwarzer Lotus", frFR = "Lotus noir", esES = "Loto negro", ruRU = "Черный лотос", ptBR = "Lótus Preto", koKO = "검은 연꽃", zhCN = "黑莲花", itIT = "Loto Nero", },
      [56] = {enUS = "Peacebloom", deDE = "Friedensblume", frFR = "Pacifique", esES = "Flor de paz", ruRU = "Мироцвет", ptBR = "Botão-da-paz", koKO = "평온초", zhCN = "宁神花", itIT = "Sbocciapace", },
      [57] = {enUS = "Stillwater Lily", deDE = "Stillwasserlilie", frFR = "Lys d’eau", esES = "Lirio de Aguaserena", ruRU = "Болотная лилия", ptBR = "Lírio das Águas Paradas", koKO = "청정 백합", zhCN = "静水池睡莲", itIT = "Giglio di Acquaferma", },
      [58] = {enUS = "Purple Lotus", deDE = "Lila Lotus", frFR = "Lotus pourpre", esES = "Loto cárdeno", ruRU = "Лиловый лотос", ptBR = "Purple Lotus", koKO = "Purple Lotus", zhCN = "Purple Lotus", itIT = "Purple Lotus", },
      [59] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Golden Sansam", koKO = "Golden Sansam", zhCN = "Golden Sansam", itIT = "Golden Sansam", },
      [60] = {enUS = "Ragveil", deDE = "Zottelkappe", frFR = "Voile-misère", esES = "Velada", ruRU = "Кисейница", ptBR = "Trapovéu", koKO = "가림막이버섯", zhCN = "邪雾草", itIT = "Velorotto", },
      [61] = {enUS = "Netherdust Bush", deDE = "Netherstaubbusch", frFR = "Buisson de pruinéante", esES = "Arbusto de polvo abisal", ruRU = "Куст пустопраха", ptBR = "Arbusto de Poeira Etérea", koKO = "황천티끌 덤불", zhCN = "灵尘灌木丛", itIT = "Cespuglio di Nubefatua", },
      [62] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [63] = {enUS = "Incendia Agave", deDE = "Brandpulveragave", frFR = "Agave d'incendia", esES = "Pita incendiaria", ruRU = "Огненная агава", ptBR = "Incendia Agave", koKO = "Incendia Agave", zhCN = "Incendia Agave", itIT = "Incendia Agave", },
      [64] = {enUS = "Bruiseweed", deDE = "Beulengras", frFR = "Doulourante", esES = "Hierba cardenal", ruRU = "Синячник", ptBR = "Ervamossa", koKO = "생채기풀", zhCN = "跌打草", itIT = "Erbalivida", },
      [65] = {enUS = "Bloodthistle", deDE = "Blutdistel", frFR = "Chardon sanglant", esES = "Cardo de sangre", ruRU = "Кровопийка", ptBR = "Cardossangue", koKO = "피엉겅퀴", zhCN = "血蓟", itIT = "Cardosangue", },
      [66] = {enUS = "Darkblossom", deDE = "Dunkelblüte", frFR = "Pétales-de-nuit", esES = "Flor de sombras", ruRU = "Темноцвет", ptBR = "Negraflora", koKO = "어둠꽃", zhCN = "暗色花", itIT = "Fiorescuro", },
      [67] = {enUS = "Magmolia", deDE = "Magmolie", frFR = "Magmolia", esES = "Magmolia", ruRU = "Магмолия", ptBR = "Magmólia", koKO = "용암목련", zhCN = "熔岩花", itIT = "Magmolia", },
      [68] = {enUS = "Sorrowmoss", deDE = "Pestblüte", frFR = "Fleur de peste", esES = "Flor de peste", ruRU = "Чумоцвет", ptBR = "Sorrowmoss", koKO = "역병초", zhCN = "Sorrowmoss", itIT = "Sorrowmoss", },
      [69] = {enUS = "Musquash Root", deDE = "Bisamwurzel", frFR = "Racine de Musquash", esES = "Zibética", ruRU = "Мускусный корень", ptBR = "Raiz Almiscarada", koKO = "사향쥐 뿌리", zhCN = "麝鼠根", itIT = "Radice Muschiata", },
      [70] = {enUS = "Sanguine Hibiscus", deDE = "Bluthibiskus", frFR = "Hibiscus sanguin", esES = "Hibisco sanguino", ruRU = "Кровавый гибискус", ptBR = "Hibisco Sanguíneo", koKO = "핏빛 불상화", zhCN = "红色木槿", itIT = "Ibisco Vermiglio", },
      [71] = {enUS = "Arthas' Tears", deDE = "Arthas' Tränen", frFR = "Larmes d'Arthas", esES = "Lágrimas de Arthas", ruRU = "Слезы Артаса", ptBR = "Arthas' Tears", koKO = "아서스의 눈물", zhCN = "Arthas' Tears", itIT = "Arthas' Tears", },
      [72] = {enUS = "Blindweed", deDE = "Blindkraut", frFR = "Aveuglette", esES = "Carolina", ruRU = "Пастушья сумка", ptBR = "Ervacega", koKO = "실명초", zhCN = "盲目草", itIT = "Erbacieca", },
      [73] = {enUS = "Juniper Berries", deDE = "Wacholderbeeren", frFR = "Baies de genévrier", esES = "Bayas de enebro", ruRU = "Можжевеловые ягоды", ptBR = "Frutinhas de Junípero", koKO = "노간주 열매", zhCN = "杜松子", itIT = "Bacche di Ginepro", },
      [74] = {enUS = "Peacebloom", deDE = "Friedensblume", frFR = "Pacifique", esES = "Flor de paz", ruRU = "Мироцвет", ptBR = "Botão-da-paz", koKO = "평온초", zhCN = "宁神花", itIT = "Sbocciapace", },
      [75] = {enUS = "Flame Cap", deDE = "Flammenkappe", frFR = "Chapeflamme", esES = "Copo de llamas", ruRU = "Огненный зев", ptBR = "Chapéu-de-fogo", koKO = "불꽃송이", zhCN = "烈焰菇", itIT = "Corolla Infernale", },
      [76] = {enUS = "Bitterblossom", deDE = "Bitterblüte", frFR = "Amertine", esES = "Agriflor", ruRU = "Горькоцвет", ptBR = "Amargura-em-flor", koKO = "씀바귀", zhCN = "苦寒之花", itIT = "Sbocciamara", },
      [77] = {enUS = "Reagent Pouch", deDE = "Reagenzienbeutel", frFR = "Bourse de réactifs", esES = "Faltriquera de componentes", ruRU = "Мешочек с реагентами", ptBR = "Bornal de Reagentes", koKO = "시약 주머니", zhCN = "材料包", itIT = "Borsa dei Reagenti", },
      [78] = {enUS = "Tear of Tilloa", deDE = "Tilloaträne", frFR = "Larme de Tilloa", esES = "Lágrima de Tilloa", ruRU = "Слеза Тиллоа", ptBR = "Lágrima de Tirsa", koKO = "틸로아의 눈물", zhCN = "蒂罗亚之泪", itIT = "Lacrima di Tilloa", },
      [79] = {enUS = "Budding Flower", deDE = "Knospende Blüte", frFR = "Fleur en bourgeon", esES = "Flor en ciernes", ruRU = "Бутон цветка", ptBR = "Flor Brotada", koKO = "피어나는 꽃송이", zhCN = "初生的花朵", itIT = "Fiori Germoglianti", },
      [80] = {enUS = "Infused Mushroom", deDE = "Energieerfüllter Pilz", frFR = "Champignon infusé", esES = "Champiñón imbuido", ruRU = "Странный гриб", ptBR = "Cogumelo Infuso", koKO = "마력 깃든 버섯", zhCN = "魔法蘑菇", itIT = "Fungo Umido", },
      [81] = {enUS = "Juicy Apple", deDE = "Saftiger Apfel", frFR = "Pomme juteuse", esES = "Manzana jugosa", ruRU = "Сочное яблоко", ptBR = "Maçã Suculenta", koKO = "과즙이 풍부한 사과", zhCN = "多汁的苹果", itIT = "Mela Succosa", },
      [82] = {enUS = "Laden Mushroom", deDE = "Potenter Pilz", frFR = "Champignon chargé", esES = "Champiñón cargado", ruRU = "Спелый гриб", ptBR = "Cogumelo Carregado", koKO = "숙성한 버섯", zhCN = "丰满的蘑菇", itIT = "Fungo Carico di Spore", },
      [83] = {enUS = "Mudsnout Blossom", deDE = "Morastschnauzenkappe", frFR = "Fleur de fangemufle", esES = "Flor Morrobarro", ruRU = "Гриб Грязного Рыла", ptBR = "Cogumelo Fuçalama", koKO = "진흙주둥이꽃", zhCN = "泥头花", itIT = "Fungo di Grugnobrago", },
      [84] = {enUS = "Plague Tangle", deDE = "Pesttentakel", frFR = "Enchevêtrement de peste", esES = "Enredo de peste", ruRU = "Чумная поросль", ptBR = "Emaranhado de Peste", koKO = "역병 덩굴", zhCN = "疫病之团", itIT = "Ciuffo d'Erba Infetto", },
      [85] = {enUS = "Ruinous Polyspore", deDE = "Ruinöser Birkensporling", frFR = "Polypore des ruines", esES = "Poliespora ruinosa", ruRU = "Губительная полиспора", ptBR = "Polísporo Ruinoso", koKO = "파멸의 버섯", zhCN = "致命孢子簇", itIT = "Russola Velenosa", },
      [86] = {enUS = "Silverleaf", deDE = "Silberblatt", frFR = "Feuillargent", esES = "Hojaplata", ruRU = "Сребролист", ptBR = "Folha-prata", koKO = "은엽수 덤불", zhCN = "银叶草", itIT = "Fogliargenta", },
      [87] = {enUS = "Skeletal Sea Turtle", deDE = "Skelettierte Meeresschildkröte", frFR = "Squelette de tortue de mer", esES = "Tortuga marina esquelética", ruRU = "Скелет морской черепахи", ptBR = "Tartaruga Marinha Descarnada", koKO = "Skeletal Sea Turtle", zhCN = "Skeletal Sea Turtle", itIT = "Scheletro di Tartaruga Marina", },
      [88] = {enUS = "Water Bucket", deDE = "Wassereimer", frFR = "Seau d'eau", esES = "Cubo de agua", ruRU = "Ведро для воды", ptBR = "Balde d'Água", koKO = "물동이", zhCN = "水桶", itIT = "Secchio d'Acqua", },
      [89] = {enUS = "Wolfsbane", deDE = "Wolfsbann", frFR = "Aconit", esES = "Aterralobos", ruRU = "Аконит", ptBR = "Acônito", koKO = "늑대잡이", zhCN = "Wolfsbane", itIT = "Strozzalupo", },
      [90] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [91] = {enUS = "Bathran's Hair", deDE = "Bathranshaar", frFR = "Cheveux de Bathran", esES = "Cabello de Bathran", ruRU = "Батранов волос", ptBR = "Cabelo-de-bathran", koKO = "배스랜모초", zhCN = "草药", itIT = "Capelli di Bathran", },
      [92] = {enUS = "Burstcap Mushroom", deDE = "Berstkappe", frFR = "Champignon Tête-tonnante", esES = "Champiñón fulminante", ruRU = "Гриб-пороховик", ptBR = "Cogumelo Surpresa", koKO = "펑갓 버섯", zhCN = "爆顶蘑菇", itIT = "Fungo Scoppiaspora", },
      [93] = {enUS = "Dragonspine", deDE = "Drachenwirbel", frFR = "Epine-de-dragon", esES = "Espinazo de dragón", ruRU = "Драконий шип", ptBR = "Espinodrago", koKO = "용가리통풀", zhCN = "龙脊草", itIT = "Spina di Drago", },
      [94] = {enUS = "Fel Cone Fungus", deDE = "Teufelszapfenfungus", frFR = "Collybie gangrenée", esES = "Hongo de bellota vil", ruRU = "Поганка конусовидная", ptBR = "Fungo Conífero Vil", koKO = "지옥방울버섯", zhCN = "邪锥蘑菇", itIT = "Fungo di Vilpigna", },
      [95] = {enUS = "Ferocious Doomweed", deDE = "Wildes Verdammniskraut", frFR = "Sinistrine féroce", esES = "Apocalípsea feroz", ruRU = "Свирепый погибельник", ptBR = "Ruinerva Feroz", koKO = "가혹한 죽음풀", zhCN = "狂野末日草", itIT = "Rovinerba Feroce", },
      [96] = {enUS = "Fulgor Spore", deDE = "Fulgorspore", frFR = "Spore de fulgor", esES = "Espora refulgente", ruRU = "Спора гриба-блескуна", ptBR = "Esporo de Fulgor", koKO = "펄고르 버섯", zhCN = "灿烂的孢子", itIT = "Spora Fulgida", },
      [97] = {enUS = "Hellfire Spineleaf", deDE = "Höllenwirbelkraut", frFR = "Atric des Flammes infernales", esES = "Espinela de Fuego Infernal", ruRU = "Пламенный шиполист", ptBR = "Folhespinho do Fogo do Inferno", koKO = "지옥불 가시돌기", zhCN = "地狱火刺叶", itIT = "Fogliaspina del Fuoco Infernale", },
      [98] = {enUS = "Lucifern", deDE = "Luzifarn", frFR = "Lucifleur", esES = "Helechinferno", ruRU = "Чертопоротник", ptBR = "Luciferna", koKO = "악마초", zhCN = "炼狱花", itIT = "Felce Infernale", },
      [99] = {enUS = "Lunar Fungal Bloom", deDE = "Lunarfungusblüte", frFR = "Floraison fongique lunaire", esES = "Flor de hongo lunar", ruRU = "Лунный Плеснецвет", ptBR = "Lunar Fungal Bloom", koKO = "달버섯", zhCN = "Lunar Fungal Bloom", itIT = "Lunar Fungal Bloom", },
      [100] = {enUS = "Magenta Cap Clusters", deDE = "Magenta Kappengruppen", frFR = "Champignons magenta", esES = "Setas magenta", ruRU = "Семейка грибов-малиновиков", ptBR = "Colônia de Campânulas Magenta", koKO = "자홍버섯", zhCN = "紫色蘑菇", itIT = "Funghi Magenta", },
      [101] = {enUS = "Marshberry", deDE = "Marschenbeere", frFR = "Canneberge", esES = "Baya de la marisma", ruRU = "Клюква", ptBR = "Fruta-do-pântano", koKO = "늪딸기", zhCN = "沼泽莓", itIT = "Baccalorda", },
      [102] = {enUS = "Scaber Stalk", deDE = "Schorfstängling", frFR = "Pédoncule d'amanite", esES = "Boleto rudo", ruRU = "Ножка струпника", ptBR = "Scaber Stalk", koKO = "Scaber Stalk", zhCN = "Scaber Stalk", itIT = "Scaber Stalk", },
      [103] = {enUS = "Shadowmoon Tuber", deDE = "Schattenmondknolle", frFR = "Tubercule d'Ombrelune", esES = "Tubérculo de Sombraluna", ruRU = "Клубни долины Призрачной Луны", ptBR = "Tubérculo Lua Negra", koKO = "어둠달 덩이줄기", zhCN = "影月块茎", itIT = "Tubero di Torvaluna", },
      [104] = {enUS = "Shimmering Snowcaps", deDE = "Schimmernde Schneekappen", frFR = "Chapeneiges chatoyants", esES = "Funguinieves fulgurantes", ruRU = "Мерцающие снежные грибы", ptBR = "Campaneves Cintilantes", koKO = "희미하게 빛나는 눈꽃버섯", zhCN = "幽光雪菇", itIT = "Scintillacorone di Neve", },
      [105] = {enUS = "Stabthistle Seed", deDE = "Dolchdistelsamen", frFR = "Graine de pique-chardon", esES = "Semilla de cardopuñal", ruRU = "Семечко колкополоха", ptBR = "Semente de Espetocardo", koKO = "따끔엉겅퀴 씨앗", zhCN = "刺蓟之种", itIT = "Cardo Perforante", },
      [106] = {enUS = "Tarblossom", deDE = "Teerblüte", frFR = "Goudronelle", esES = "Miera", ruRU = "Смолоцвет", ptBR = "Flor de Piche", koKO = "타르꽃", zhCN = "焦油之花", itIT = "Fior di Pece", },
      [107] = {enUS = "Telaari Frond", deDE = "Telaarifarn", frFR = "Palme telaari", esES = "Fronda de Telaari", ruRU = "Телаарский папоротник", ptBR = "Fronde de Telaari", koKO = "텔라아리 잎사귀", zhCN = "塔拉蕨", itIT = "Foglia di Telaar", },
      [108] = {enUS = "Worm Mound", deDE = "Wurmhaufen", frFR = "Tas de vers", esES = "Túmulo de gusano", ruRU = "Куча червей", ptBR = "Monte de Verme", koKO = "벌레 더미", zhCN = "虫堆", itIT = "Tumulo del Verme", },
      [109] = {enUS = "\"Magic\" Mushroom", deDE = "\"Magischer\" Pilz", frFR = "Champignon « magique »", esES = "Champiñón \"mágico\"", ruRU = "\"Волшебный\" грибочек", ptBR = "Cogumelo \"Mágico\"", koKO = "\"마법\" 버섯", zhCN = "“魔法”蘑菇", itIT = "Fungo \"Magico\"", },
      [110] = {enUS = "Azure Snapdragon", deDE = "Azurlöwenmäulchen", frFR = "Gueule-de-loup azurée", esES = "Boca de dragón azur", ruRU = "Лазурный львиный зев", ptBR = "Boca-de-leão Lazúli", koKO = "하늘금어초", zhCN = "碧蓝金鱼草", itIT = "Dragolosa Azzurra", },
      [111] = {enUS = "Balnir Snapdragons", deDE = "Balnirlöwenmäulchen", frFR = "Gueules-de-loup de Balnir", esES = "Bocas de dragón de Balnir", ruRU = "Львиный зев Бальнира", ptBR = "Boca-de-leão de Balnir", koKO = "발니르 금어초", zhCN = "巴尼尔金鱼草", itIT = "Dragolose di Balnir", },
      [112] = {enUS = "Barrel of Canal Fish", deDE = "Fass mit Kanalfischen", frFR = "Tonneau de poissons des canaux", esES = "Barril de pez de canal", ruRU = "Бочка с рыбой из канала", ptBR = "Barril de Peixes do Canal", koKO = "운하 물고기 통", zhCN = "一桶运河鱼", itIT = "Barile di Pesce dei Canali", },
      [113] = {enUS = "Beached Sea Creature", deDE = "Gestrandete Meereskreatur", frFR = "Créature marine échouée", esES = "Criatura marina varada", ruRU = "Выброшенная на берег морская тварь", ptBR = "Criatura Marinha Encalhada", koKO = "떠밀려 온 바다 생물", zhCN = "搁浅的海洋生物", itIT = "Creatura Marina Arenata", },
      [114] = {enUS = "Blood Nettle", deDE = "Blutnessel", frFR = "Ortie de sang", esES = "Ortiga sanguina", ruRU = "Кровавая крапива", ptBR = "Urtiga de Sangue", koKO = "핏방울 쐐기풀", zhCN = "血荨麻", itIT = "Sanguortica", },
      [115] = {enUS = "Bloodberry Bush", deDE = "Blutbeerenbusch", frFR = "Buisson de sangrelle", esES = "Arbusto de bayas de sangre", ruRU = "Куст Кровяники", ptBR = "Arbusto de Fruta-sangue", koKO = "선홍딸기 덤불", zhCN = "血莓灌木", itIT = "Cespuglio di Baccasangue", },
      [116] = {enUS = "Bloodspore Carpel", deDE = "Blutsporenfruchtblatt", frFR = "Carpelle spore-sang", esES = "Carpelo de sanguiespora", ruRU = "Кровоспоровый плодолистик", ptBR = "Carpelo de Sanguesporo", koKO = "핏빛포자 암술잎", zhCN = "血孢心皮", itIT = "Fogliame di Sporasangue", },
      [117] = {enUS = "Bogblossom", deDE = "Sumpfblüte", frFR = "Fleur des tourbières", esES = "Cardo de Mantar", ruRU = "Топлянник", ptBR = "Flor do Pântano", koKO = "수렁꽃", zhCN = "沼泽花", itIT = "Fiordipalude", },
      [118] = {enUS = "Cactus Apple", deDE = "Kaktusapfel", frFR = "Pomme de cactus", esES = "Manzana de cactus", ruRU = "Плод кактуса", ptBR = "Sabra", koKO = "선인장 사과", zhCN = "仙人掌果", itIT = "Cactus", },
      [119] = {enUS = "Corrupted Flower", deDE = "Verderbte Blume", frFR = "Fleur corrompue", esES = "Flor corrupta", ruRU = "Оскверненный цветок", ptBR = "Flor Corrompida", koKO = "오염된 꽃", zhCN = "被污染的花朵", itIT = "Fiore Corrotto", },
      [120] = {enUS = "Death Cap", deDE = "Todeskappe", frFR = "Amanite phalloïde", esES = "Oronja verde", ruRU = "Мертвянка", ptBR = "Death Cap", koKO = "Death Cap", zhCN = "Death Cap", itIT = "Death Cap", },
      [121] = {enUS = "Doom Weed", deDE = "Verdammniskraut", frFR = "Herbe maléfique", esES = "Apocalíseas", ruRU = "Погибельник", ptBR = "Erva-do-demo", koKO = "죽음풀", zhCN = "末日草", itIT = "Erba del Fato", },
      [122] = {enUS = "Drycap Mushroom", deDE = "Trockenkappe", frFR = "Champignon tête-sèche", esES = "Champiñón capuseca", ruRU = "Гриб-сухошляпка", ptBR = "Cogumelo Secampânulo", koKO = "마른고깔버섯", zhCN = "枯顶蘑菇", itIT = "Fungo Testasecca", },
      [123] = {enUS = "Emerald Shimmercap", deDE = "Smaragdgrüne Schimmerkappe", frFR = "Chapeneige émeraude", esES = "Champiñón brillante esmeralda", ruRU = "Изумрудный мерцающий гриб", ptBR = "Brilhacampa Esmeralda", koKO = "에메랄드 눈꽃버섯", zhCN = "翡翠伞菇", itIT = "Scintillacorona di Smeraldo", },
      [124] = {enUS = "Flame Blossom", deDE = "Flammenblüte", frFR = "Fleur-de-flammes", esES = "Flor de llamas", ruRU = "Огненный цветок", ptBR = "Florescência de Chama", koKO = "화염꽃", zhCN = "烈焰花丛", itIT = "Sbocciafiamma", },
      [125] = {enUS = "Gloom Weed", deDE = "Düsterkraut", frFR = "Herbe des ténèbres", esES = "Hierba luminiscente", ruRU = "Мракоцвет", ptBR = "Erva-do-emo", koKO = "어둠풀", zhCN = "阴暗草", itIT = "Erba Tenebrosa", },
      [126] = {enUS = "Hyacinth Mushroom", deDE = "Hyazinthpilz", frFR = "Champignon jacinthe", esES = "Champiñón jacinto", ruRU = "Гиацинтовый гриб", ptBR = "Hyacinth Mushroom", koKO = "히아신스 버섯", zhCN = "Hyacinth Mushroom", itIT = "Hyacinth Mushroom", },
      [127] = {enUS = "Ivory Bell", deDE = "Elfenbeinglocke", frFR = "Clochette d'ivoire", esES = "Campana de marfil", ruRU = "Кремовый колокольчик", ptBR = "Sino de Marfim", koKO = "상아 종꽃", zhCN = "象牙铃笼草", itIT = "Campanule d'Avorio", },
      [128] = {enUS = "Magenta Cap Clusters", deDE = "Magenta Kappengruppen", frFR = "Champignons magenta", esES = "Setas magenta", ruRU = "Семейка грибов-малиновиков", ptBR = "Colônia de Campânulas Magenta", koKO = "자홍버섯", zhCN = "紫色蘑菇", itIT = "Funghi Magenta", },
      [129] = {enUS = "Mana Berry Bush", deDE = "Manabeerenbusch", frFR = "Buisson à baies de mana", esES = "Arbusto de frutos de maná", ruRU = "Манаягодник", ptBR = "Arbusto de Manamora", koKO = "마나딸기 덤불", zhCN = "魔法草莓", itIT = "Cespuglio di Manabacca", },
      [130] = {enUS = "Mulgore Pine Cone", deDE = "Kienapfel von Mulgore", frFR = "Pomme de pin de Mulgore", esES = "Piña de Mulgore", ruRU = "Мулгорская кедровая шишка", ptBR = "Pinha de Mulgore", koKO = "멀고어 솔방울", zhCN = "莫高雷松果", itIT = "Pigna di Mulgore", },
      [131] = {enUS = "Murkweed", deDE = "Düstergras", frFR = "Tourbeline", esES = "Hierba tiniebla", ruRU = "Темноплевел", ptBR = "Herassombra", koKO = "암흑풀", zhCN = "黑暗草", itIT = "Erbanotte", },
      [132] = {enUS = "Olemba Root", deDE = "Olembawurzel", frFR = "Racine d'olemba", esES = "Raíz de olemba", ruRU = "Корень олембы", ptBR = "Raiz de Olemba", koKO = "올렘바 뿌리", zhCN = "奥雷巴根须", itIT = "Radice di Olemba", },
      [133] = {enUS = "Serpentbloom", deDE = "Schlangenflaum", frFR = "Fleur de serpent", esES = "Reptilia", ruRU = "Змеецвет", ptBR = "Ofídea", koKO = "불뱀꽃", zhCN = "毒蛇花", itIT = "Bocciolo di Serpente", },
      [134] = {enUS = "Sewer Cap", deDE = "Abflusskappe", frFR = "Champignon des égouts", esES = "Hongo de cloaca", ruRU = "Канализационный гриб", ptBR = "Cogumelo do Esgoto", koKO = "하수구 버섯", zhCN = "下水道伞菇", itIT = "Fungo di Fogna", },
      [135] = {enUS = "Thorny Stankroot", deDE = "Dorniger Stinkwurz", frFR = "Racine de fétidelle épineuse", esES = "Pesterraíz espinosa", ruRU = "Шипастый смердокорень", ptBR = "Raiz Espinhaca", koKO = "가시 악취뿌리", zhCN = "带刺的臭根", itIT = "Ramomarcio Spinoso", },
      [136] = {enUS = "Violet Tragan", deDE = "Violetter Tragan", frFR = "Tragan pourpre", esES = "Tragano violeta", ruRU = "Фиалковый траган", ptBR = "Tragão Violeta", koKO = "제비수염버섯", zhCN = "紫色水生菇", itIT = "Amanita Viola", },
      [137] = {enUS = "Wild Mustard", deDE = "Wilder Senf", frFR = "Moutarde sauvage", esES = "Mostaza silvestre", ruRU = "Полевая горчица", ptBR = "Mostarda Selvagem", koKO = "야생 겨자", zhCN = "野芥菜", itIT = "Senape Selvatica", },
      [138] = {enUS = "Witchbane", deDE = "Hexenfluch", frFR = "Sorbier", esES = "Ruinabruja", ruRU = "Ведьмина погибель", ptBR = "Espanta-bruxa", koKO = "마녀독풀", zhCN = "除巫草", itIT = "Sfatastrega", },
      [139] = {enUS = "Wyrmtail", deDE = "Drachenwinde", frFR = "Queue de wyrm", esES = "Cola de vermis", ruRU = "Змейкин хвост", ptBR = "Rabo-de-serpe", koKO = "용꼬리", zhCN = "龙尾草", itIT = "Codragone", },
      [140] = {enUS = "Ysera's Tear", deDE = "Yseras Träne", frFR = "Larme d'Ysera", esES = "Lágrima de Ysera", ruRU = "Слеза Изеры", ptBR = "Lágrima de Ysera", koKO = "이세라의 눈물", zhCN = "Ysera's Tear", itIT = "Lacrima di Ysera", },
      [141] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Sungrass", koKO = "태양풀", zhCN = "Sungrass", itIT = "Sungrass", },
      [142] = {enUS = "Gromsblood", deDE = "Gromsblut", frFR = "Gromsang", esES = "Gromsanguina", ruRU = "Кровь Грома", ptBR = "Gromsblood", koKO = "그롬의 피", zhCN = "Gromsblood", itIT = "Gromsblood", },
      [143] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Golden Sansam", koKO = "황금 산삼", zhCN = "Golden Sansam", itIT = "Golden Sansam", },
      [144] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "Dreamfoil", koKO = "꿈풀", zhCN = "Dreamfoil", itIT = "Dreamfoil", },
      [145] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "Dreamfoil", koKO = "Dreamfoil", zhCN = "Dreamfoil", itIT = "Dreamfoil", },
      [146] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "Salviargenta de montaña", ruRU = "Горный серебряный шалфей", ptBR = "Mountain Silversage", koKO = "Mountain Silversage", zhCN = "Mountain Silversage", itIT = "Mountain Silversage", },
      [147] = {enUS = "Dreaming Glory", deDE = "Traumwinde", frFR = "Glaurier", esES = "Gloria de ensueño", ruRU = "Сияние грез", ptBR = "Glória-sonhadora", koKO = "꿈초롱이", zhCN = "梦露花", itIT = "Gloria d'Oro", },
      [148] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [149] = {enUS = "Aquatic Stinkhorn", deDE = "Wasserstinkmorchel", frFR = "Satyre puant aquatique", esES = "Cuernohediondo acuático", ruRU = "Водянистый смрадорог", ptBR = "Cornofétido Aquático", koKO = "고린뿔물버섯", zhCN = "水生臭角菇", itIT = "Sporalercia Acquatico", },
      [150] = {enUS = "Banshee's Bells", deDE = "Bansheeglocken", frFR = "Clochettes de banshee", esES = "Corolas de alma en pena", ruRU = "Колокольчики банши", ptBR = "Sinos da Banshee", koKO = "귀곡령 종꽃", zhCN = "女妖之铃", itIT = "Campanelle delle Banshee", },
      [151] = {enUS = "Bear's Paw", deDE = "Bärenklau", frFR = "Patte d'ours", esES = "Pata de oso", ruRU = "Медвежья лапка", ptBR = "Pata de Urso", koKO = "곰발풀", zhCN = "熊爪", itIT = "Zampa d'Orso", },
      [152] = {enUS = "Blueroot Vine", deDE = "Blauknollenwinde", frFR = "Vrillebleue", esES = "Parra raízañil", ruRU = "Лазоревый корень", ptBR = "Vinha Raizul", koKO = "푸른뿌리 덩굴", zhCN = "蓝根藤", itIT = "Radice di Bluetta", },
      [153] = {enUS = "Budding Flower", deDE = "Knospende Blüte", frFR = "Fleur en bourgeon", esES = "Flor en ciernes", ruRU = "Бутон цветка", ptBR = "Flor Brotada", koKO = "피어나는 꽃송이", zhCN = "初生的花朵", itIT = "Fiori Germoglianti", },
      [154] = {enUS = "Cave Mushroom", deDE = "Höhlenpilz", frFR = "Champignon de la caverne", esES = "Champiñón de cueva", ruRU = "Пещерный гриб", ptBR = "Cogumelo da Caverna", koKO = "동굴 버섯", zhCN = "洞穴蘑菇", itIT = "Fungo di Caverna", },
      [155] = {enUS = "Corpse Worm Mound", deDE = "Leichenwurmhügel", frFR = "Tas de vers de cadavre", esES = "Túmulo de gusano de cadáver", ruRU = "Яма с трупными червями", ptBR = "Monte de Terra de Vermes Carniceiros", koKO = "시체 벌레 흙더미", zhCN = "尸虫土堆", itIT = "Cumulo di Cagnotti", },
      [156] = {enUS = "Crying Violet", deDE = "Klageveilchen", frFR = "Violette pleureuse", esES = "Violeta sollozante", ruRU = "Плачущая фиалка", ptBR = "Violeta Chorosa", koKO = "흐느끼는 제비꽃", zhCN = "悲泣的紫罗兰", itIT = "Viola Lacrimosa", },
      [157] = {enUS = "Eternal Lunar Pear", deDE = "Ewige Mondbirne", frFR = "Poire lunaire éternelle", esES = "Pera lunar eterna", ruRU = "Вечная лунная груша", ptBR = "Pera Lunar Eterna", koKO = "영원한 달의 배", zhCN = "永恒月梨", itIT = "Pera Lunare Eterna", },
      [158] = {enUS = "Eternal Sunfruit", deDE = "Ewige Sonnenfrucht", frFR = "Fruit solaire éternel", esES = "Fruta del sol eterna", ruRU = "Вечный солнцеплод", ptBR = "Frutassol Eterna", koKO = "영원한 해과일", zhCN = "永恒太阳果", itIT = "Solarancia Eterna", },
      [159] = {enUS = "Frostberry Bush", deDE = "Frostbeerenbusch", frFR = "Buisson de givrelles", esES = "Arbusto de gelifructus", ruRU = "Куст снежевики", ptBR = "Moita de Frutagelo", koKO = "서리딸기 덤불", zhCN = "冰莓灌木丛", itIT = "Cespuglio di Gelobacca", },
      [160] = {enUS = "Magmolia", deDE = "Magmolie", frFR = "Magmolia", esES = "Magmolia", ruRU = "Магмолия", ptBR = "Magmólia", koKO = "용암목련", zhCN = "熔岩花", itIT = "Magmolia", },
      [161] = {enUS = "Marrowpetal Stalk", deDE = "Markblattstängel", frFR = "Tige de myéloflée", esES = "Tallo de medupétalo", ruRU = "Стебель кабачкового цвета", ptBR = "Metaleira", koKO = "골수화 줄기", zhCN = "骨髓花茎", itIT = "Gambo di Fiorzucco", },
      [162] = {enUS = "Moonleaf", deDE = "Mondblatt", frFR = "Feuillelune", esES = "Hojaluna", ruRU = "Лунный лист", ptBR = "Folha-da-lua", koKO = "달잎", zhCN = "月叶", itIT = "Foglialuna", },
      [163] = {enUS = "Moonpetal Lily", deDE = "Mondblütenlilie", frFR = "Lys pétale de lune", esES = "Lirio alunado", ruRU = "Лунная лилия", ptBR = "Moonpetal Lily", koKO = "Moonpetal Lily", zhCN = "Moonpetal Lily", itIT = "Moonpetal Lily", },
      [164] = {enUS = "Moonpetal Lily", deDE = "Mondblütenlilie", frFR = "Lys pétale de lune", esES = "Lirio alunado", ruRU = "Лунная лилия", ptBR = "Lírio Lunapétala", koKO = "달봉오리 백합", zhCN = "月牙百合花", itIT = "Giglio di Lunafoglia", },
      [165] = {enUS = "Muddlecap Fungus", deDE = "Krauskappenfungus", frFR = "Champignon chapebrouille", esES = "Hongo fungilodo", ruRU = "Гриб-дурман", ptBR = "Fungo do Pileque", koKO = "어리버섯", zhCN = "混乱毒菇", itIT = "Fungo Capofango", },
      [166] = {enUS = "Okra", deDE = "Okra", frFR = "Okra", esES = "Okra", ruRU = "Окра", ptBR = "Quiabo", koKO = "오크라", zhCN = "秋葵", itIT = "Okra", },
      [167] = {enUS = "Prayerbloom", deDE = "Gebetsblume", frFR = "Chapelette", esES = "Flor de plegaria", ruRU = "Молельник", ptBR = "Pé de Florrogo", koKO = "기원의 꽃", zhCN = "祝祷之花", itIT = "Stelo di Fiordevoto", },
      [168] = {enUS = "Prickly Pear Fruit", deDE = "Kaktusfeige", frFR = "Figue de Barbarie", esES = "Fruto pera espinosa", ruRU = "Колючая груша", ptBR = "Pera Espinhosa", koKO = "가시투성이 배", zhCN = "仙人掌果", itIT = "Fico Spinoso", },
      [169] = {enUS = "Rotberry Bush", deDE = "Faulbeerbusch", frFR = "Buisson de pourrielle", esES = "Arbusto de bayas podridas", ruRU = "Куст гниленики", ptBR = "Moita de Frutapodre", koKO = "썩은딸기 덤불", zhCN = "腐莓灌木", itIT = "Cespuglio di Baccamarcia", },
      [170] = {enUS = "Ruby Lilac", deDE = "Rubinfarbener Flieder", frFR = "Lilas rubis", esES = "Lilas de color rubí", ruRU = "Рубиновая сирень", ptBR = "Lilás-rubi", koKO = "루비 라일락", zhCN = "红玉丁香", itIT = "Lillà di Rubino", },
      [171] = {enUS = "Serpentbloom", deDE = "Schlangenflaum", frFR = "Fleur de serpent", esES = "Reptilia", ruRU = "Змеецвет", ptBR = "Ofídea", koKO = "불뱀꽃", zhCN = "毒蛇花", itIT = "Bocciolo di Serpente", },
      [172] = {enUS = "Stonebloom", deDE = "Steinblüte", frFR = "Pierrelette", esES = "Cetraria", ruRU = "Камнецвет", ptBR = "Flor-pétrea", koKO = "바위꽃", zhCN = "石花", itIT = "Sbocciapietra", },
      [173] = {enUS = "Twilight's Hammer Crate", deDE = "Kiste des Schattenhammers", frFR = "Caisse du Marteau du crépuscule", esES = "Cajón del Martillo Crepuscular", ruRU = "Ящик Сумеречного Молота", ptBR = "Caixote do Martelo do Crepúsculo", koKO = "황혼의 망치단 상자", zhCN = "暮光之锤板条箱", itIT = "Cassa del Martello del Crepuscolo", },
      [174] = {enUS = "Xavren's Thorn", deDE = "Xavrens Dorn", frFR = "Epine de Xavren", esES = "Espina de Xavren", ruRU = "Ксавренов терн", ptBR = "Espinho-de-xavren", koKO = "자브렌의 가시", zhCN = "萨维伦之棘", itIT = "Spina di Xavren", },
      [175] = {enUS = "Earthroot", deDE = "Erdwurzel", frFR = "Terrestrine", esES = "Raíz de tierra", ruRU = "Земляной корень", ptBR = "Raiz-telúrica", koKO = "뱀뿌리", zhCN = "地根草", itIT = "Bulboterro", },
      [176] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [177] = {enUS = "Arthas' Tears", deDE = "Arthas' Tränen", frFR = "Larmes d'Arthas", esES = "Lágrimas de Arthas", ruRU = "Слезы Артаса", ptBR = "Arthas' Tears", koKO = "아서스의 눈물", zhCN = "Arthas' Tears", itIT = "Arthas' Tears", },
      [178] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Sungrass", koKO = "Sungrass", zhCN = "Sungrass", itIT = "Sungrass", },
      [179] = {enUS = "Goldthorn", deDE = "Golddorn", frFR = "Dorépine", esES = "Espina de oro", ruRU = "Златошип", ptBR = "Espinheira-dourada", koKO = "황금가시", zhCN = "金棘草", itIT = "Orospino", },
      [180] = {enUS = "Blindweed", deDE = "Blindkraut", frFR = "Aveuglette", esES = "Carolina", ruRU = "Пастушья сумка", ptBR = "Ervacega", koKO = "실명초", zhCN = "盲目草", itIT = "Erbacieca", },
      [181] = {enUS = "Purple Lotus", deDE = "Lila Lotus", frFR = "Lotus pourpre", esES = "Loto cárdeno", ruRU = "Лиловый лотос", ptBR = "Lótus Roxo", koKO = "보라 연꽃", zhCN = "紫莲花", itIT = "Loto Purpureo", },
      [182] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Ervassol", koKO = "태양풀", zhCN = "太阳草", itIT = "Erbasole", },
      [183] = {enUS = "Azshara's Veil", deDE = "Azsharas Schleier", frFR = "Voile d'Azshara", esES = "Velo de Azshara", ruRU = "Вуаль Азшары", ptBR = "Véu-de-azshara", koKO = "아즈샤라의 신비", zhCN = "艾萨拉雾菇", itIT = "Velo di Azshara", },
      [184] = {enUS = "Stranglekelp", deDE = "Würgetang", frFR = "Etouffante", esES = "Alga estranguladora", ruRU = "Удавник", ptBR = "Estrangulalga", koKO = "갈래물풀", zhCN = "荆棘藻", itIT = "Algatorta", },
      [185] = {enUS = "Wild Steelbloom", deDE = "Wildstahlblume", frFR = "Aciérite sauvage", esES = "Acérita salvaje", ruRU = "Дикий сталецвет", ptBR = "Ácera-agreste", koKO = "야생 철쭉", zhCN = "野钢花", itIT = "Fiordiferro Selvatico", },
      [186] = {enUS = "Briarthorn", deDE = "Wilddornrose", frFR = "Eglantine", esES = "Brezospina", ruRU = "Остротерн", ptBR = "Cravespinho", koKO = "찔레가시", zhCN = "石南草", itIT = "Grandespina", },
      [187] = {enUS = "Whiptail", deDE = "Gertenrohr", frFR = "", esES = "Colátigo", ruRU = "Хлыстохвост", ptBR = "Azorrague", koKO = "채찍꼬리", zhCN = "鞭尾草", itIT = "Frustaliana", },
      [188] = {enUS = "Goldclover", deDE = "Goldklee", frFR = "Trèfle doré", esES = "Trébol de oro", ruRU = "Золотой клевер", ptBR = "Trevo Dourado", koKO = "황금토끼풀", zhCN = "金苜蓿", itIT = "Trifoglio d'Oro", },
      [189] = {enUS = "", deDE = "Beulengras", frFR = "Doulourante", esES = "Hierba cardenal", ruRU = "", ptBR = "Ervamossa", koKO = "생채기풀", zhCN = "跌打草", itIT = "Erbalivida", },
      [190] = {enUS = "Gromsblood", deDE = "Gromsblut", frFR = "Gromsang", esES = "Gromsanguina", ruRU = "Кровь Грома", ptBR = "Sangue-de-grom", koKO = "그롬의 피", zhCN = "格罗姆之血", itIT = "Sangue di Grommash", },
      [191] = {enUS = "Kingsblood", deDE = "Königsblut", frFR = "Sang-royal", esES = "Sangrerregia", ruRU = "Королевская кровь", ptBR = "Sangue-real", koKO = "왕꽃잎풀", zhCN = "皇血草", itIT = "Sanguesacro", },
      [192] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "", koKO = "꿈풀", zhCN = "梦叶草", itIT = "", },
      [193] = {enUS = "Adder's Tongue", deDE = "Schlangenzunge", frFR = "Langue de serpent", esES = "Lengua de víboris", ruRU = "Язык аспида", ptBR = "Língua-de-áspide", koKO = "얼레지 꽃", zhCN = "蛇信草", itIT = "Lingua di Vipera", },
      [194] = {enUS = "Cinderbloom", deDE = "Aschenblüte", frFR = "Cendrelle", esES = "Flor de ceniza", ruRU = "Пепельник", ptBR = "Cinzanilha", koKO = "재투성이꽃", zhCN = "燃烬草", itIT = "Sbocciacenere", },
      [195] = {enUS = "Twilight Jasmine", deDE = "Schattenjasmin", frFR = "Jasmin crépusculaire", esES = "Jazmín Crepuscular", ruRU = "Сумеречный жасмин", ptBR = "Jasmim-do-crepúsculo", koKO = "황혼의 말리꽃", zhCN = "暮光茉莉", itIT = "Gelsomino del Crepuscolo", },
      [196] = {enUS = "Dragon's Teeth", deDE = "Drachenzahn", frFR = "Dents de dragon", esES = "Dientes de dragón", ruRU = "Драконьи зубы", ptBR = "Dentes de dragão", koKO = "용 송곳니", zhCN = "龙齿草", itIT = "Dente di Drago", },
      [197] = {enUS = "Fadeleaf", deDE = "Blassblatt", frFR = "Pâlerette", esES = "Pálida", ruRU = "Бледнолист", ptBR = "Some-folha", koKO = "미명초잎", zhCN = "枯叶草", itIT = "Foglia Eterea", },
      [198] = {enUS = "Liferoot", deDE = "Lebenswurz", frFR = "Vietérule", esES = "Vidarraíz", ruRU = "Корень жизни", ptBR = "Raiz-da-vida", koKO = "생명의 뿌리", zhCN = "活根草", itIT = "Bulbovivo", },
      [199] = {enUS = "Sorrowmoss", deDE = "Trauermoos", frFR = "Chagrinelle", esES = "Musgopena", ruRU = "Печаль-трава", ptBR = "Limágoa", koKO = "슬픔이끼", zhCN = "哀伤苔", itIT = "Muschiocupo", },
      [200] = {enUS = "Ragveil", deDE = "Zottelkappe", frFR = "Voile-misère", esES = "Velada", ruRU = "Кисейница", ptBR = "Trapovéu", koKO = "가림막이버섯", zhCN = "邪雾草", itIT = "Velorotto", },
      [201] = {enUS = "Heartblossom", deDE = "Herzblüte", frFR = "Pétale de cœur", esES = "Flor de corazón", ruRU = "Цветущее сердце", ptBR = "Coronália", koKO = "심장꽃", zhCN = "心灵之花", itIT = "Cuorfiorito", },
      [202] = {enUS = "Netherbloom", deDE = "Netherblüte", frFR = "Néantine", esES = "Flor abisal", ruRU = "Пустоцвет", ptBR = "Floretérea", koKO = "황천꽃", zhCN = "虚空花", itIT = "Sbocciafatuo", },
      [203] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Sonsona-dourada", koKO = "황금 산삼", zhCN = "黄金参", itIT = "Sansam Dorato", },
      [204] = {enUS = "Terocone", deDE = "Terozapfen", frFR = "Terocône", esES = "Teropiña", ruRU = "Терошишка", ptBR = "Teropinha", koKO = "테로열매", zhCN = "泰罗果", itIT = "Terocone", },
      [205] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "Salviargenta de montaña", ruRU = "Горный серебряный шалфей", ptBR = "Sálvia-prata-da-montanha", koKO = "은초롱이", zhCN = "山鼠草", itIT = "Ramargento Montano", },
      [206] = {enUS = "Icethorn", deDE = "Eisdorn", frFR = "Glacépine", esES = "Espina de hielo", ruRU = "Ледошип", ptBR = "Gelocardo", koKO = "얼음가시", zhCN = "冰棘草", itIT = "Gelaspina", },
      [207] = {enUS = "Khadgar's Whisker", deDE = "Khadgars Schnurrbart", frFR = "Moustache de Khadgar", esES = "Mostacho de Khadgar", ruRU = "Кадгаров ус", ptBR = "Bigode-de-hadgar", koKO = "카드가의 수염", zhCN = "卡德加的胡须", itIT = "Ciuffo di Khadgar", },
      [208] = {enUS = "Talandra's Rose", deDE = "Talandras Rose", frFR = "Rose de Talandra", esES = "Rosa de Talandra", ruRU = "Роза Таландры", ptBR = "Rosa-de-talandra", koKO = "탈란드라의 장미", zhCN = "塔兰德拉的玫瑰", itIT = "Rosa di Talandra", },
      [209] = {enUS = "Stormvine", deDE = "Sturmwinde", frFR = "Vignétincelle", esES = "Viñaviento", ruRU = "Ливневая лоза", ptBR = "Tempesvina", koKO = "폭풍덩굴", zhCN = "风暴藤", itIT = "Vite Tempestosa", },
      [210] = {enUS = "Nightmare Vine", deDE = "Alptraumranke", frFR = "Cauchemardelle", esES = "Vid pesadilla", ruRU = "Ползучий кошмарник", ptBR = "Vinha-do-pesadelo", koKO = "악몽의 덩굴", zhCN = "噩梦藤", itIT = "Vite dell'Incubo", },
      [211] = {enUS = "Felweed", deDE = "Teufelsgras", frFR = "Gangrelette", esES = "Hierba vil", ruRU = "Сквернопля", ptBR = "Vilerva", koKO = "지옥풀", zhCN = "魔草", itIT = "Erbavile", },
      [212] = {enUS = "Grave Moss", deDE = "Grabmoos", frFR = "Tombeline", esES = "Musgo de tumba", ruRU = "Могильный мох", ptBR = "Musgo-de-tumba", koKO = "무덤이끼", zhCN = "墓地苔", itIT = "Muschio di Tomba", },
      [213] = {enUS = "Icecap", deDE = "Eiskappe", frFR = "Chapeglace", esES = "Setelo", ruRU = "Ледяной зев", ptBR = "Chapéu-de-gelo", koKO = "얼음송이", zhCN = "冰盖草", itIT = "Corolla Invernale", },
      [214] = {enUS = "Tiger Lily", deDE = "Tigerlilie", frFR = "Lys tigré", esES = "Lirio atigrado", ruRU = "Тигровая лилия", ptBR = "Lírio-tigre", koKO = "참나리", zhCN = "卷丹", itIT = "Giglio Tigrato", },
      [215] = {enUS = "Firebloom", deDE = "Feuerblüte", frFR = "Fleur de feu", esES = "Flor de fuego", ruRU = "Огнецвет", ptBR = "Ignídea", koKO = "화염초", zhCN = "火焰花", itIT = "Sbocciafuoco", },
      [216] = {enUS = "Ghost Mushroom", deDE = "Geisterpilz", frFR = "Champignon fantôme", esES = "Champiñón fantasma", ruRU = "Призрачная поганка", ptBR = "Cogumelo-fantasma", koKO = "유령버섯", zhCN = "幽灵菇", itIT = "Fungo Fantasma", },
      [217] = {enUS = "Crystalsong Carrot", deDE = "Kristallsangkarotte", frFR = "Carotte du Chant de cristal", esES = "Zanahoria Canto de Cristal", ruRU = "Морковь из леса Хрустальной Песни", ptBR = "Cenoura do Canto Cristalino", koKO = "수정노래 당근", zhCN = "晶歌胡萝卜", itIT = "Carota della Foresta di Cristallo", },
      [218] = {enUS = "Lichbloom", deDE = "Lichblüte", frFR = "Fleur-de-liche", esES = "Flor exánime", ruRU = "Личецвет", ptBR = "Flor-de-lich", koKO = "시체꽃", zhCN = "巫妖花", itIT = "Fiore del Lich", },
      [219] = {enUS = "Earthroot", deDE = "Erdwurzel", frFR = "Terrestrine", esES = "Raíz de tierra", ruRU = "Земляной корень", ptBR = "Raiz-telúrica", koKO = "뱀뿌리", zhCN = "地根草", itIT = "Bulboterro", },
      [220] = {enUS = "Mana Thistle", deDE = "Manadistel", frFR = "Chardon de mana", esES = "Cardo de maná", ruRU = "Манаполох", ptBR = "Manacardo", koKO = "마나 엉겅퀴", zhCN = "法力蓟", itIT = "Cardomana", },
      [221] = {enUS = "Blood Mushroom", deDE = "Blutpilz", frFR = "Champignon de sang", esES = "Champiñón sanguino", ruRU = "Кровавый гриб", ptBR = "Cogumelo de Sangue", koKO = "피버섯", zhCN = "", itIT = "Fungo Sanguinello", },
      [222] = {enUS = "Silverleaf", deDE = "Silberblatt", frFR = "Feuillargent", esES = "Hojaplata", ruRU = "Сребролист", ptBR = "Folha-prata", koKO = "은엽수 덤불", zhCN = "银叶草", itIT = "Fogliargenta", },
      [223] = {enUS = "Firethorn", deDE = "Feuerdorn", frFR = "Epine de feu", esES = "Espino de fuego", ruRU = "Огница", ptBR = "Espinho de Fogo", koKO = "화염가시풀", zhCN = "火棘花", itIT = "Ardispina", },
      [224] = {enUS = "Ancient Lichen", deDE = "Urflechte", frFR = "Lichen ancien", esES = "Liquen antiguo", ruRU = "Древний лишайник", ptBR = "Líquen-antigo", koKO = "고대 이끼", zhCN = "远古苔", itIT = "Lichene Antico", },
      [225] = {enUS = "Frost Lotus", deDE = "Frostlotus", frFR = "Lotus givré", esES = "Loto de escarcha", ruRU = "Северный лотос", ptBR = "Lótus Gélido", koKO = "서리 연꽃", zhCN = "雪莲花", itIT = "Loto Gelido", },
      [226] = {enUS = "Mageroyal", deDE = "Maguskönigskraut", frFR = "Mage royal", esES = "Marregal", ruRU = "Магороза", ptBR = "Magi-real", koKO = "마법초", zhCN = "魔皇草", itIT = "Magareale", },
      [227] = {enUS = "Briarthorn", deDE = "", frFR = "Eglantine", esES = "Brezospina", ruRU = "Остротерн", ptBR = "Cravespinho", koKO = "찔레가시", zhCN = "石南草", itIT = "Grandespina", },
      [228] = {enUS = "Dreaming Glory", deDE = "Traumwinde", frFR = "Glaurier", esES = "Gloria de ensueño", ruRU = "Сияние грез", ptBR = "Glória-sonhadora", koKO = "꿈초롱이", zhCN = "梦露花", itIT = "Gloria d'Oro", },
      [229] = {enUS = "Felweed", deDE = "Teufelsgras", frFR = "Gangrelette", esES = "Hierba vil", ruRU = "Сквернопля", ptBR = "Vilerva", koKO = "지옥풀", zhCN = "魔草", itIT = "Erbavile", },
      [230] = {enUS = "Winter Hyacinth", deDE = "Winterhyazinthe", frFR = "Jacinthe d'hiver", esES = "Jacinto de invierno", ruRU = "Зимний гиацинт", ptBR = "Jacinto do Gelo", koKO = "겨울 히아신스", zhCN = "冬水仙", itIT = "Giacinto Invernale", },
      [231] = {enUS = "Mageroyal", deDE = "Maguskönigskraut", frFR = "Mage royal", esES = "Marregal", ruRU = "Магороза", ptBR = "Magi-real", koKO = "마법초", zhCN = "魔皇草", itIT = "Magareale", },
      [232] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "Salviargenta de montaña", ruRU = "Горный серебряный шалфей", ptBR = "Mountain Silversage", koKO = "은초롱이", zhCN = "Mountain Silversage", itIT = "Mountain Silversage", },
      [233] = {enUS = "Black Lotus", deDE = "Schwarzer Lotus", frFR = "Lotus noir", esES = "Loto negro", ruRU = "Черный лотос", ptBR = "Lótus Preto", koKO = "검은 연꽃", zhCN = "黑莲花", itIT = "Loto Nero", },
      [234] = {enUS = "Peacebloom", deDE = "Friedensblume", frFR = "Pacifique", esES = "Flor de paz", ruRU = "Мироцвет", ptBR = "Botão-da-paz", koKO = "평온초", zhCN = "宁神花", itIT = "Sbocciapace", },
      [235] = {enUS = "Stillwater Lily", deDE = "Stillwasserlilie", frFR = "Lys d’eau", esES = "Lirio de Aguaserena", ruRU = "Болотная лилия", ptBR = "Lírio das Águas Paradas", koKO = "청정 백합", zhCN = "静水池睡莲", itIT = "Giglio di Acquaferma", },
      [236] = {enUS = "Purple Lotus", deDE = "Lila Lotus", frFR = "Lotus pourpre", esES = "Loto cárdeno", ruRU = "Лиловый лотос", ptBR = "Purple Lotus", koKO = "Purple Lotus", zhCN = "Purple Lotus", itIT = "Purple Lotus", },
      [237] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Golden Sansam", koKO = "Golden Sansam", zhCN = "Golden Sansam", itIT = "Golden Sansam", },
      [238] = {enUS = "Ragveil", deDE = "Zottelkappe", frFR = "Voile-misère", esES = "Velada", ruRU = "Кисейница", ptBR = "Trapovéu", koKO = "가림막이버섯", zhCN = "邪雾草", itIT = "Velorotto", },
      [239] = {enUS = "Netherdust Bush", deDE = "Netherstaubbusch", frFR = "Buisson de pruinéante", esES = "Arbusto de polvo abisal", ruRU = "Куст пустопраха", ptBR = "Arbusto de Poeira Etérea", koKO = "황천티끌 덤불", zhCN = "灵尘灌木丛", itIT = "Cespuglio di Nubefatua", },
      [240] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [241] = {enUS = "Incendia Agave", deDE = "Brandpulveragave", frFR = "Agave d'incendia", esES = "Pita incendiaria", ruRU = "Огненная агава", ptBR = "Incendia Agave", koKO = "Incendia Agave", zhCN = "Incendia Agave", itIT = "Incendia Agave", },
      [242] = {enUS = "Bruiseweed", deDE = "Beulengras", frFR = "Doulourante", esES = "Hierba cardenal", ruRU = "Синячник", ptBR = "Ervamossa", koKO = "생채기풀", zhCN = "跌打草", itIT = "Erbalivida", },
      [243] = {enUS = "Bloodthistle", deDE = "Blutdistel", frFR = "Chardon sanglant", esES = "Cardo de sangre", ruRU = "Кровопийка", ptBR = "Cardossangue", koKO = "피엉겅퀴", zhCN = "血蓟", itIT = "Cardosangue", },
      [244] = {enUS = "Darkblossom", deDE = "Dunkelblüte", frFR = "Pétales-de-nuit", esES = "Flor de sombras", ruRU = "Темноцвет", ptBR = "Negraflora", koKO = "어둠꽃", zhCN = "暗色花", itIT = "Fiorescuro", },
      [245] = {enUS = "Magmolia", deDE = "Magmolie", frFR = "Magmolia", esES = "Magmolia", ruRU = "Магмолия", ptBR = "Magmólia", koKO = "용암목련", zhCN = "熔岩花", itIT = "Magmolia", },
      [246] = {enUS = "Sorrowmoss", deDE = "Pestblüte", frFR = "Fleur de peste", esES = "Flor de peste", ruRU = "Чумоцвет", ptBR = "Sorrowmoss", koKO = "역병초", zhCN = "Sorrowmoss", itIT = "Sorrowmoss", },
      [247] = {enUS = "Musquash Root", deDE = "Bisamwurzel", frFR = "Racine de Musquash", esES = "Zibética", ruRU = "Мускусный корень", ptBR = "Raiz Almiscarada", koKO = "사향쥐 뿌리", zhCN = "麝鼠根", itIT = "Radice Muschiata", },
      [248] = {enUS = "Sanguine Hibiscus", deDE = "Bluthibiskus", frFR = "Hibiscus sanguin", esES = "Hibisco sanguino", ruRU = "Кровавый гибискус", ptBR = "Hibisco Sanguíneo", koKO = "핏빛 불상화", zhCN = "红色木槿", itIT = "Ibisco Vermiglio", },
      [249] = {enUS = "Arthas' Tears", deDE = "Arthas' Tränen", frFR = "Larmes d'Arthas", esES = "Lágrimas de Arthas", ruRU = "Слезы Артаса", ptBR = "Arthas' Tears", koKO = "아서스의 눈물", zhCN = "Arthas' Tears", itIT = "Arthas' Tears", },
      [250] = {enUS = "Blindweed", deDE = "Blindkraut", frFR = "Aveuglette", esES = "Carolina", ruRU = "Пастушья сумка", ptBR = "Ervacega", koKO = "실명초", zhCN = "盲目草", itIT = "Erbacieca", },
      [251] = {enUS = "Juniper Berries", deDE = "Wacholderbeeren", frFR = "Baies de genévrier", esES = "Bayas de enebro", ruRU = "Можжевеловые ягоды", ptBR = "Frutinhas de Junípero", koKO = "노간주 열매", zhCN = "杜松子", itIT = "Bacche di Ginepro", },
      [252] = {enUS = "Peacebloom", deDE = "Friedensblume", frFR = "Pacifique", esES = "Flor de paz", ruRU = "Мироцвет", ptBR = "Botão-da-paz", koKO = "평온초", zhCN = "宁神花", itIT = "Sbocciapace", },
      [253] = {enUS = "Flame Cap", deDE = "Flammenkappe", frFR = "Chapeflamme", esES = "Copo de llamas", ruRU = "Огненный зев", ptBR = "Chapéu-de-fogo", koKO = "불꽃송이", zhCN = "烈焰菇", itIT = "Corolla Infernale", },
      [254] = {enUS = "Bitterblossom", deDE = "Bitterblüte", frFR = "Amertine", esES = "Agriflor", ruRU = "Горькоцвет", ptBR = "Amargura-em-flor", koKO = "씀바귀", zhCN = "苦寒之花", itIT = "Sbocciamara", },
      [255] = {enUS = "Reagent Pouch", deDE = "Reagenzienbeutel", frFR = "Bourse de réactifs", esES = "Faltriquera de componentes", ruRU = "Мешочек с реагентами", ptBR = "Bornal de Reagentes", koKO = "시약 주머니", zhCN = "材料包", itIT = "Borsa dei Reagenti", },
      [256] = {enUS = "Tear of Tilloa", deDE = "Tilloaträne", frFR = "Larme de Tilloa", esES = "Lágrima de Tilloa", ruRU = "Слеза Тиллоа", ptBR = "Lágrima de Tirsa", koKO = "틸로아의 눈물", zhCN = "蒂罗亚之泪", itIT = "Lacrima di Tilloa", },
      [257] = {enUS = "Budding Flower", deDE = "Knospende Blüte", frFR = "Fleur en bourgeon", esES = "Flor en ciernes", ruRU = "Бутон цветка", ptBR = "Flor Brotada", koKO = "피어나는 꽃송이", zhCN = "初生的花朵", itIT = "Fiori Germoglianti", },
      [258] = {enUS = "Infused Mushroom", deDE = "Energieerfüllter Pilz", frFR = "Champignon infusé", esES = "Champiñón imbuido", ruRU = "Странный гриб", ptBR = "Cogumelo Infuso", koKO = "마력 깃든 버섯", zhCN = "魔法蘑菇", itIT = "Fungo Umido", },
      [259] = {enUS = "Juicy Apple", deDE = "Saftiger Apfel", frFR = "Pomme juteuse", esES = "Manzana jugosa", ruRU = "Сочное яблоко", ptBR = "Maçã Suculenta", koKO = "과즙이 풍부한 사과", zhCN = "多汁的苹果", itIT = "Mela Succosa", },
      [260] = {enUS = "Laden Mushroom", deDE = "Potenter Pilz", frFR = "Champignon chargé", esES = "Champiñón cargado", ruRU = "Спелый гриб", ptBR = "Cogumelo Carregado", koKO = "숙성한 버섯", zhCN = "丰满的蘑菇", itIT = "Fungo Carico di Spore", },
      [261] = {enUS = "Mudsnout Blossom", deDE = "Morastschnauzenkappe", frFR = "Fleur de fangemufle", esES = "Flor Morrobarro", ruRU = "Гриб Грязного Рыла", ptBR = "Cogumelo Fuçalama", koKO = "진흙주둥이꽃", zhCN = "泥头花", itIT = "Fungo di Grugnobrago", },
      [262] = {enUS = "Plague Tangle", deDE = "Pesttentakel", frFR = "Enchevêtrement de peste", esES = "Enredo de peste", ruRU = "Чумная поросль", ptBR = "Emaranhado de Peste", koKO = "역병 덩굴", zhCN = "疫病之团", itIT = "Ciuffo d'Erba Infetto", },
      [263] = {enUS = "Ruinous Polyspore", deDE = "Ruinöser Birkensporling", frFR = "Polypore des ruines", esES = "Poliespora ruinosa", ruRU = "Губительная полиспора", ptBR = "Polísporo Ruinoso", koKO = "파멸의 버섯", zhCN = "致命孢子簇", itIT = "Russola Velenosa", },
      [264] = {enUS = "Silverleaf", deDE = "Silberblatt", frFR = "Feuillargent", esES = "Hojaplata", ruRU = "Сребролист", ptBR = "Folha-prata", koKO = "은엽수 덤불", zhCN = "银叶草", itIT = "Fogliargenta", },
      [265] = {enUS = "Skeletal Sea Turtle", deDE = "Skelettierte Meeresschildkröte", frFR = "Squelette de tortue de mer", esES = "Tortuga marina esquelética", ruRU = "Скелет морской черепахи", ptBR = "Tartaruga Marinha Descarnada", koKO = "Skeletal Sea Turtle", zhCN = "Skeletal Sea Turtle", itIT = "Scheletro di Tartaruga Marina", },
      [266] = {enUS = "Water Bucket", deDE = "Wassereimer", frFR = "Seau d'eau", esES = "Cubo de agua", ruRU = "Ведро для воды", ptBR = "Balde d'Água", koKO = "물동이", zhCN = "水桶", itIT = "Secchio d'Acqua", },
      [267] = {enUS = "Wolfsbane", deDE = "Wolfsbann", frFR = "Aconit", esES = "Aterralobos", ruRU = "Аконит", ptBR = "Acônito", koKO = "늑대잡이", zhCN = "Wolfsbane", itIT = "Strozzalupo", },
      [268] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [269] = {enUS = "Bathran's Hair", deDE = "Bathranshaar", frFR = "", esES = "Cabello de Bathran", ruRU = "Батранов волос", ptBR = "Cabelo-de-bathran", koKO = "배스랜모초", zhCN = "草药", itIT = "Capelli di Bathran", },
      [270] = {enUS = "Burstcap Mushroom", deDE = "Berstkappe", frFR = "Champignon Tête-tonnante", esES = "Champiñón fulminante", ruRU = "Гриб-пороховик", ptBR = "Cogumelo Surpresa", koKO = "펑갓 버섯", zhCN = "爆顶蘑菇", itIT = "Fungo Scoppiaspora", },
      [271] = {enUS = "Dragonspine", deDE = "Drachenwirbel", frFR = "Epine-de-dragon", esES = "Espinazo de dragón", ruRU = "Драконий шип", ptBR = "Espinodrago", koKO = "", zhCN = "龙脊草", itIT = "Spina di Drago", },
      [272] = {enUS = "Fel Cone Fungus", deDE = "Teufelszapfenfungus", frFR = "Collybie gangrenée", esES = "Hongo de bellota vil", ruRU = "Поганка конусовидная", ptBR = "Fungo Conífero Vil", koKO = "지옥방울버섯", zhCN = "邪锥蘑菇", itIT = "Fungo di Vilpigna", },
      [273] = {enUS = "Ferocious Doomweed", deDE = "Wildes Verdammniskraut", frFR = "Sinistrine féroce", esES = "Apocalípsea feroz", ruRU = "Свирепый погибельник", ptBR = "Ruinerva Feroz", koKO = "가혹한 죽음풀", zhCN = "狂野末日草", itIT = "Rovinerba Feroce", },
      [274] = {enUS = "Fulgor Spore", deDE = "Fulgorspore", frFR = "Spore de fulgor", esES = "Espora refulgente", ruRU = "Спора гриба-блескуна", ptBR = "Esporo de Fulgor", koKO = "펄고르 버섯", zhCN = "灿烂的孢子", itIT = "Spora Fulgida", },
      [275] = {enUS = "Hellfire Spineleaf", deDE = "Höllenwirbelkraut", frFR = "Atric des Flammes infernales", esES = "Espinela de Fuego Infernal", ruRU = "Пламенный шиполист", ptBR = "Folhespinho do Fogo do Inferno", koKO = "지옥불 가시돌기", zhCN = "地狱火刺叶", itIT = "Fogliaspina del Fuoco Infernale", },
      [276] = {enUS = "Lucifern", deDE = "Luzifarn", frFR = "Lucifleur", esES = "Helechinferno", ruRU = "Чертопоротник", ptBR = "Luciferna", koKO = "악마초", zhCN = "炼狱花", itIT = "Felce Infernale", },
      [277] = {enUS = "Lunar Fungal Bloom", deDE = "Lunarfungusblüte", frFR = "Floraison fongique lunaire", esES = "Flor de hongo lunar", ruRU = "Лунный Плеснецвет", ptBR = "Lunar Fungal Bloom", koKO = "달버섯", zhCN = "Lunar Fungal Bloom", itIT = "Lunar Fungal Bloom", },
      [278] = {enUS = "Magenta Cap Clusters", deDE = "Magenta Kappengruppen", frFR = "Champignons magenta", esES = "Setas magenta", ruRU = "Семейка грибов-малиновиков", ptBR = "Colônia de Campânulas Magenta", koKO = "자홍버섯", zhCN = "紫色蘑菇", itIT = "Funghi Magenta", },
      [279] = {enUS = "Marshberry", deDE = "Marschenbeere", frFR = "Canneberge", esES = "Baya de la marisma", ruRU = "Клюква", ptBR = "Fruta-do-pântano", koKO = "늪딸기", zhCN = "沼泽莓", itIT = "Baccalorda", },
      [280] = {enUS = "Scaber Stalk", deDE = "Schorfstängling", frFR = "Pédoncule d'amanite", esES = "Boleto rudo", ruRU = "Ножка струпника", ptBR = "Scaber Stalk", koKO = "Scaber Stalk", zhCN = "Scaber Stalk", itIT = "Scaber Stalk", },
      [281] = {enUS = "Shadowmoon Tuber", deDE = "Schattenmondknolle", frFR = "Tubercule d'Ombrelune", esES = "Tubérculo de Sombraluna", ruRU = "Клубни долины Призрачной Луны", ptBR = "Tubérculo Lua Negra", koKO = "어둠달 덩이줄기", zhCN = "影月块茎", itIT = "Tubero di Torvaluna", },
      [282] = {enUS = "Shimmering Snowcaps", deDE = "Schimmernde Schneekappen", frFR = "Chapeneiges chatoyants", esES = "Funguinieves fulgurantes", ruRU = "Мерцающие снежные грибы", ptBR = "Campaneves Cintilantes", koKO = "희미하게 빛나는 눈꽃버섯", zhCN = "幽光雪菇", itIT = "Scintillacorone di Neve", },
      [283] = {enUS = "Stabthistle Seed", deDE = "Dolchdistelsamen", frFR = "Graine de pique-chardon", esES = "Semilla de cardopuñal", ruRU = "Семечко колкополоха", ptBR = "Semente de Espetocardo", koKO = "따끔엉겅퀴 씨앗", zhCN = "刺蓟之种", itIT = "Cardo Perforante", },
      [284] = {enUS = "Tarblossom", deDE = "Teerblüte", frFR = "Goudronelle", esES = "Miera", ruRU = "Смолоцвет", ptBR = "Flor de Piche", koKO = "타르꽃", zhCN = "焦油之花", itIT = "Fior di Pece", },
      [285] = {enUS = "Telaari Frond", deDE = "Telaarifarn", frFR = "Palme telaari", esES = "Fronda de Telaari", ruRU = "Телаарский папоротник", ptBR = "Fronde de Telaari", koKO = "텔라아리 잎사귀", zhCN = "塔拉蕨", itIT = "Foglia di Telaar", },
      [286] = {enUS = "Worm Mound", deDE = "Wurmhaufen", frFR = "Tas de vers", esES = "Túmulo de gusano", ruRU = "Куча червей", ptBR = "Monte de Verme", koKO = "벌레 더미", zhCN = "虫堆", itIT = "Tumulo del Verme", },
      [287] = {enUS = "\"Magic\" Mushroom", deDE = "\"Magischer\" Pilz", frFR = "Champignon « magique »", esES = "Champiñón \"mágico\"", ruRU = "\"Волшебный\" грибочек", ptBR = "Cogumelo \"Mágico\"", koKO = "\"마법\" 버섯", zhCN = "“魔法”蘑菇", itIT = "Fungo \"Magico\"", },
      [288] = {enUS = "Azure Snapdragon", deDE = "Azurlöwenmäulchen", frFR = "Gueule-de-loup azurée", esES = "Boca de dragón azur", ruRU = "Лазурный львиный зев", ptBR = "Boca-de-leão Lazúli", koKO = "하늘금어초", zhCN = "碧蓝金鱼草", itIT = "Dragolosa Azzurra", },
      [289] = {enUS = "Balnir Snapdragons", deDE = "Balnirlöwenmäulchen", frFR = "Gueules-de-loup de Balnir", esES = "Bocas de dragón de Balnir", ruRU = "Львиный зев Бальнира", ptBR = "Boca-de-leão de Balnir", koKO = "발니르 금어초", zhCN = "巴尼尔金鱼草", itIT = "Dragolose di Balnir", },
      [290] = {enUS = "Barrel of Canal Fish", deDE = "Fass mit Kanalfischen", frFR = "Tonneau de poissons des canaux", esES = "Barril de pez de canal", ruRU = "Бочка с рыбой из канала", ptBR = "Barril de Peixes do Canal", koKO = "운하 물고기 통", zhCN = "一桶运河鱼", itIT = "Barile di Pesce dei Canali", },
      [291] = {enUS = "Beached Sea Creature", deDE = "Gestrandete Meereskreatur", frFR = "Créature marine échouée", esES = "Criatura marina varada", ruRU = "Выброшенная на берег морская тварь", ptBR = "Criatura Marinha Encalhada", koKO = "떠밀려 온 바다 생물", zhCN = "搁浅的海洋生物", itIT = "Creatura Marina Arenata", },
      [292] = {enUS = "Blood Nettle", deDE = "Blutnessel", frFR = "Ortie de sang", esES = "Ortiga sanguina", ruRU = "Кровавая крапива", ptBR = "Urtiga de Sangue", koKO = "핏방울 쐐기풀", zhCN = "血荨麻", itIT = "Sanguortica", },
      [293] = {enUS = "Bloodberry Bush", deDE = "Blutbeerenbusch", frFR = "Buisson de sangrelle", esES = "Arbusto de bayas de sangre", ruRU = "Куст Кровяники", ptBR = "Arbusto de Fruta-sangue", koKO = "선홍딸기 덤불", zhCN = "血莓灌木", itIT = "Cespuglio di Baccasangue", },
      [294] = {enUS = "Bloodspore Carpel", deDE = "Blutsporenfruchtblatt", frFR = "Carpelle spore-sang", esES = "Carpelo de sanguiespora", ruRU = "Кровоспоровый плодолистик", ptBR = "Carpelo de Sanguesporo", koKO = "핏빛포자 암술잎", zhCN = "血孢心皮", itIT = "Fogliame di Sporasangue", },
      [295] = {enUS = "Bogblossom", deDE = "Sumpfblüte", frFR = "Fleur des tourbières", esES = "Cardo de Mantar", ruRU = "Топлянник", ptBR = "Flor do Pântano", koKO = "수렁꽃", zhCN = "沼泽花", itIT = "Fiordipalude", },
      [296] = {enUS = "Cactus Apple", deDE = "Kaktusapfel", frFR = "Pomme de cactus", esES = "Manzana de cactus", ruRU = "Плод кактуса", ptBR = "Sabra", koKO = "선인장 사과", zhCN = "仙人掌果", itIT = "Cactus", },
      [297] = {enUS = "Corrupted Flower", deDE = "Verderbte Blume", frFR = "Fleur corrompue", esES = "Flor corrupta", ruRU = "Оскверненный цветок", ptBR = "Flor Corrompida", koKO = "오염된 꽃", zhCN = "被污染的花朵", itIT = "Fiore Corrotto", },
      [298] = {enUS = "Death Cap", deDE = "Todeskappe", frFR = "Amanite phalloïde", esES = "Oronja verde", ruRU = "Мертвянка", ptBR = "Death Cap", koKO = "Death Cap", zhCN = "", itIT = "Death Cap", },
      [299] = {enUS = "Doom Weed", deDE = "Verdammniskraut", frFR = "Herbe maléfique", esES = "Apocalíseas", ruRU = "Погибельник", ptBR = "Erva-do-demo", koKO = "죽음풀", zhCN = "末日草", itIT = "Erba del Fato", },
      [300] = {enUS = "Drycap Mushroom", deDE = "Trockenkappe", frFR = "Champignon tête-sèche", esES = "Champiñón capuseca", ruRU = "Гриб-сухошляпка", ptBR = "Cogumelo Secampânulo", koKO = "", zhCN = "枯顶蘑菇", itIT = "Fungo Testasecca", },
      [300] = {enUS = "Drycap Mushroom", deDE = "Trockenkappe", frFR = "Champignon tête-sèche", esES = "Champiñón capuseca", ruRU = "Гриб-сухошляпка", ptBR = "Cogumelo Secampânulo", koKO = "마른고깔버섯", zhCN = "枯顶蘑菇", itIT = "Fungo Testasecca", },
      [301] = {enUS = "Emerald Shimmercap", deDE = "Smaragdgrüne Schimmerkappe", frFR = "Chapeneige émeraude", esES = "Champiñón brillante esmeralda", ruRU = "Изумрудный мерцающий гриб", ptBR = "Brilhacampa Esmeralda", koKO = "에메랄드 눈꽃버섯", zhCN = "翡翠伞菇", itIT = "Scintillacorona di Smeraldo", },
      [302] = {enUS = "Flame Blossom", deDE = "Flammenblüte", frFR = "Fleur-de-flammes", esES = "Flor de llamas", ruRU = "Огненный цветок", ptBR = "Florescência de Chama", koKO = "화염꽃", zhCN = "烈焰花丛", itIT = "Sbocciafiamma", },
      [303] = {enUS = "Gloom Weed", deDE = "Düsterkraut", frFR = "Herbe des ténèbres", esES = "Hierba luminiscente", ruRU = "Мракоцвет", ptBR = "Erva-do-emo", koKO = "어둠풀", zhCN = "阴暗草", itIT = "Erba Tenebrosa", },
      [304] = {enUS = "Hyacinth Mushroom", deDE = "Hyazinthpilz", frFR = "Champignon jacinthe", esES = "Champiñón jacinto", ruRU = "Гиацинтовый гриб", ptBR = "Hyacinth Mushroom", koKO = "히아신스 버섯", zhCN = "Hyacinth Mushroom", itIT = "Hyacinth Mushroom", },
      [305] = {enUS = "Ivory Bell", deDE = "Elfenbeinglocke", frFR = "Clochette d'ivoire", esES = "Campana de marfil", ruRU = "Кремовый колокольчик", ptBR = "Sino de Marfim", koKO = "상아 종꽃", zhCN = "象牙铃笼草", itIT = "Campanule d'Avorio", },
      [306] = {enUS = "Magenta Cap Clusters", deDE = "Magenta Kappengruppen", frFR = "Champignons magenta", esES = "Setas magenta", ruRU = "Семейка грибов-малиновиков", ptBR = "Colônia de Campânulas Magenta", koKO = "자홍버섯", zhCN = "紫色蘑菇", itIT = "Funghi Magenta", },
      [307] = {enUS = "Mana Berry Bush", deDE = "Manabeerenbusch", frFR = "Buisson à baies de mana", esES = "Arbusto de frutos de maná", ruRU = "Манаягодник", ptBR = "Arbusto de Manamora", koKO = "마나딸기 덤불", zhCN = "魔法草莓", itIT = "Cespuglio di Manabacca", },
      [308] = {enUS = "Mulgore Pine Cone", deDE = "Kienapfel von Mulgore", frFR = "Pomme de pin de Mulgore", esES = "Piña de Mulgore", ruRU = "Мулгорская кедровая шишка", ptBR = "Pinha de Mulgore", koKO = "멀고어 솔방울", zhCN = "莫高雷松果", itIT = "Pigna di Mulgore", },
      [309] = {enUS = "Murkweed", deDE = "Düstergras", frFR = "Tourbeline", esES = "Hierba tiniebla", ruRU = "Темноплевел", ptBR = "Herassombra", koKO = "암흑풀", zhCN = "黑暗草", itIT = "Erbanotte", },
      [310] = {enUS = "Olemba Root", deDE = "Olembawurzel", frFR = "Racine d'olemba", esES = "Raíz de olemba", ruRU = "Корень олембы", ptBR = "Raiz de Olemba", koKO = "올렘바 뿌리", zhCN = "奥雷巴根须", itIT = "Radice di Olemba", },
      [311] = {enUS = "Serpentbloom", deDE = "Schlangenflaum", frFR = "Fleur de serpent", esES = "Reptilia", ruRU = "Змеецвет", ptBR = "Ofídea", koKO = "불뱀꽃", zhCN = "毒蛇花", itIT = "Bocciolo di Serpente", },
      [312] = {enUS = "Sewer Cap", deDE = "Abflusskappe", frFR = "Champignon des égouts", esES = "Hongo de cloaca", ruRU = "Канализационный гриб", ptBR = "Cogumelo do Esgoto", koKO = "하수구 버섯", zhCN = "下水道伞菇", itIT = "Fungo di Fogna", },
      [313] = {enUS = "Thorny Stankroot", deDE = "Dorniger Stinkwurz", frFR = "Racine de fétidelle épineuse", esES = "Pesterraíz espinosa", ruRU = "Шипастый смердокорень", ptBR = "Raiz Espinhaca", koKO = "가시 악취뿌리", zhCN = "带刺的臭根", itIT = "Ramomarcio Spinoso", },
      [314] = {enUS = "Violet Tragan", deDE = "Violetter Tragan", frFR = "Tragan pourpre", esES = "Tragano violeta", ruRU = "Фиалковый траган", ptBR = "Tragão Violeta", koKO = "제비수염버섯", zhCN = "紫色水生菇", itIT = "Amanita Viola", },
      [315] = {enUS = "Wild Mustard", deDE = "Wilder Senf", frFR = "Moutarde sauvage", esES = "Mostaza silvestre", ruRU = "Полевая горчица", ptBR = "Mostarda Selvagem", koKO = "야생 겨자", zhCN = "野芥菜", itIT = "Senape Selvatica", },
      [316] = {enUS = "Witchbane", deDE = "Hexenfluch", frFR = "Sorbier", esES = "Ruinabruja", ruRU = "Ведьмина погибель", ptBR = "Espanta-bruxa", koKO = "마녀독풀", zhCN = "除巫草", itIT = "Sfatastrega", },
      [317] = {enUS = "Wyrmtail", deDE = "Drachenwinde", frFR = "Queue de wyrm", esES = "Cola de vermis", ruRU = "Змейкин хвост", ptBR = "Rabo-de-serpe", koKO = "용꼬리", zhCN = "龙尾草", itIT = "Codragone", },
      [318] = {enUS = "Ysera's Tear", deDE = "Yseras Träne", frFR = "Larme d'Ysera", esES = "Lágrima de Ysera", ruRU = "Слеза Изеры", ptBR = "Lágrima de Ysera", koKO = "이세라의 눈물", zhCN = "Ysera's Tear", itIT = "Lacrima di Ysera", },
      [319] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Sungrass", koKO = "태양풀", zhCN = "Sungrass", itIT = "Sungrass", },
      [320] = {enUS = "Gromsblood", deDE = "Gromsblut", frFR = "Gromsang", esES = "Gromsanguina", ruRU = "Кровь Грома", ptBR = "Gromsblood", koKO = "그롬의 피", zhCN = "Gromsblood", itIT = "Gromsblood", },
      [321] = {enUS = "Golden Sansam", deDE = "Goldener Sansam", frFR = "Sansam doré", esES = "Sansam dorado", ruRU = "Золотой сансам", ptBR = "Golden Sansam", koKO = "황금 산삼", zhCN = "Golden Sansam", itIT = "Golden Sansam", },
      [322] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "Dreamfoil", koKO = "꿈풀", zhCN = "Dreamfoil", itIT = "Dreamfoil", },
      [323] = {enUS = "Dreamfoil", deDE = "Traumblatt", frFR = "Feuillerêve", esES = "Hojasueño", ruRU = "Снолист", ptBR = "", koKO = "", zhCN = "Dreamfoil", itIT = "Dreamfoil", },
      [324] = {enUS = "Mountain Silversage", deDE = "Bergsilbersalbei", frFR = "Sauge-argent des montagnes", esES = "", ruRU = "", ptBR = "Mountain Silversage", koKO = "", zhCN = "Mountain Silversage", itIT = "Mountain Silversage", },
      [325] = {enUS = "Dreaming Glory", deDE = "Traumwinde", frFR = "Glaurier", esES = "Gloria de ensueño", ruRU = "Сияние грез", ptBR = "Glória-sonhadora", koKO = "꿈초롱이", zhCN = "", itIT = "Gloria d'Oro", },
      [326] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [327] = {enUS = "Aquatic Stinkhorn", deDE = "Wasserstinkmorchel", frFR = "Satyre puant aquatique", esES = "Cuernohediondo acuático", ruRU = "Водянистый смрадорог", ptBR = "Cornofétido Aquático", koKO = "고린뿔물버섯", zhCN = "水生臭角菇", itIT = "Sporalercia Acquatico", },
      [328] = {enUS = "Banshee's Bells", deDE = "Bansheeglocken", frFR = "Clochettes de banshee", esES = "Corolas de alma en pena", ruRU = "Колокольчики банши", ptBR = "", koKO = "귀곡령 종꽃", zhCN = "女妖之铃", itIT = "Campanelle delle Banshee", },
      [329] = {enUS = "Bear's Paw", deDE = "Bärenklau", frFR = "Patte d'ours", esES = "Pata de oso", ruRU = "Медвежья лапка", ptBR = "Pata de Urso", koKO = "곰발풀", zhCN = "熊爪", itIT = "Zampa d'Orso", },
      [330] = {enUS = "Blueroot Vine", deDE = "Blauknollenwinde", frFR = "Vrillebleue", esES = "Parra raízañil", ruRU = "Лазоревый корень", ptBR = "Vinha Raizul", koKO = "푸른뿌리 덩굴", zhCN = "蓝根藤", itIT = "Radice di Bluetta", },
      [331] = {enUS = "Budding Flower", deDE = "Knospende Blüte", frFR = "Fleur en bourgeon", esES = "Flor en ciernes", ruRU = "", ptBR = "Flor Brotada", koKO = "피어나는 꽃송이", zhCN = "初生的花朵", itIT = "Fiori Germoglianti", },
      [332] = {enUS = "Cave Mushroom", deDE = "Höhlenpilz", frFR = "Champignon de la caverne", esES = "Champiñón de cueva", ruRU = "Пещерный гриб", ptBR = "Cogumelo da Caverna", koKO = "동굴 버섯", zhCN = "洞穴蘑菇", itIT = "Fungo di Caverna", },
      [333] = {enUS = "Corpse Worm Mound", deDE = "Leichenwurmhügel", frFR = "Tas de vers de cadavre", esES = "Túmulo de gusano de cadáver", ruRU = "Яма с трупными червями", ptBR = "Monte de Terra de Vermes Carniceiros", koKO = "", zhCN = "尸虫土堆", itIT = "Cumulo di Cagnotti", },
      [334] = {enUS = "Crying Violet", deDE = "", frFR = "Violette pleureuse", esES = "Violeta sollozante", ruRU = "Плачущая фиалка", ptBR = "Violeta Chorosa", koKO = "흐느끼는 제비꽃", zhCN = "悲泣的紫罗兰", itIT = "Viola Lacrimosa", },
      [335] = {enUS = "Eternal Lunar Pear", deDE = "Ewige Mondbirne", frFR = "", esES = "Pera lunar eterna", ruRU = "Вечная лунная груша", ptBR = "Pera Lunar Eterna", koKO = "영원한 달의 배", zhCN = "永恒月梨", itIT = "Pera Lunare Eterna", },
      [336] = {enUS = "Eternal Sunfruit", deDE = "Ewige Sonnenfrucht", frFR = "Fruit solaire éternel", esES = "Fruta del sol eterna", ruRU = "Вечный солнцеплод", ptBR = "Frutassol Eterna", koKO = "영원한 해과일", zhCN = "永恒太阳果", itIT = "Solarancia Eterna", },
      [337] = {enUS = "Frostberry Bush", deDE = "Frostbeerenbusch", frFR = "Buisson de givrelles", esES = "Arbusto de gelifructus", ruRU = "Куст снежевики", ptBR = "Moita de Frutagelo", koKO = "서리딸기 덤불", zhCN = "冰莓灌木丛", itIT = "Cespuglio di Gelobacca", },
      [338] = {enUS = "Magmolia", deDE = "Magmolie", frFR = "Magmolia", esES = "Magmolia", ruRU = "Магмолия", ptBR = "Magmólia", koKO = "용암목련", zhCN = "熔岩花", itIT = "Magmolia", },
      [339] = {enUS = "Marrowpetal Stalk", deDE = "Markblattstängel", frFR = "Tige de myéloflée", esES = "Tallo de medupétalo", ruRU = "Стебель кабачкового цвета", ptBR = "Metaleira", koKO = "골수화 줄기", zhCN = "骨髓花茎", itIT = "Gambo di Fiorzucco", },
      [340] = {enUS = "Moonleaf", deDE = "Mondblatt", frFR = "Feuillelune", esES = "Hojaluna", ruRU = "Лунный лист", ptBR = "Folha-da-lua", koKO = "달잎", zhCN = "月叶", itIT = "Foglialuna", },
      [341] = {enUS = "", deDE = "Mondblütenlilie", frFR = "", esES = "Lirio alunado", ruRU = "Лунная лилия", ptBR = "Moonpetal Lily", koKO = "Moonpetal Lily", zhCN = "Moonpetal Lily", itIT = "Moonpetal Lily", },
      [342] = {enUS = "Moonpetal Lily", deDE = "Mondblütenlilie", frFR = "", esES = "Lirio alunado", ruRU = "Лунная лилия", ptBR = "Lírio Lunapétala", koKO = "", zhCN = "", itIT = "", },
      [343] = {enUS = "Muddlecap Fungus", deDE = "Krauskappenfungus", frFR = "Champignon chapebrouille", esES = "Hongo fungilodo", ruRU = "Гриб-дурман", ptBR = "Fungo do Pileque", koKO = "어리버섯", zhCN = "混乱毒菇", itIT = "Fungo Capofango", },
      [344] = {enUS = "Okra", deDE = "Okra", frFR = "Okra", esES = "Okra", ruRU = "Окра", ptBR = "Quiabo", koKO = "오크라", zhCN = "秋葵", itIT = "Okra", },
      [345] = {enUS = "Prayerbloom", deDE = "Gebetsblume", frFR = "Chapelette", esES = "Flor de plegaria", ruRU = "Молельник", ptBR = "Pé de Florrogo", koKO = "기원의 꽃", zhCN = "祝祷之花", itIT = "Stelo di Fiordevoto", },
      [346] = {enUS = "Prickly Pear Fruit", deDE = "Kaktusfeige", frFR = "Figue de Barbarie", esES = "Fruto pera espinosa", ruRU = "Колючая груша", ptBR = "Pera Espinhosa", koKO = "가시투성이 배", zhCN = "仙人掌果", itIT = "Fico Spinoso", },
      [347] = {enUS = "Rotberry Bush", deDE = "Faulbeerbusch", frFR = "Buisson de pourrielle", esES = "Arbusto de bayas podridas", ruRU = "Куст гниленики", ptBR = "Moita de Frutapodre", koKO = "썩은딸기 덤불", zhCN = "腐莓灌木", itIT = "Cespuglio di Baccamarcia", },
      [348] = {enUS = "Ruby Lilac", deDE = "Rubinfarbener Flieder", frFR = "Lilas rubis", esES = "Lilas de color rubí", ruRU = "Рубиновая сирень", ptBR = "Lilás-rubi", koKO = "루비 라일락", zhCN = "红玉丁香", itIT = "Lillà di Rubino", },
      [349] = {enUS = "Serpentbloom", deDE = "Schlangenflaum", frFR = "Fleur de serpent", esES = "Reptilia", ruRU = "Змеецвет", ptBR = "Ofídea", koKO = "불뱀꽃", zhCN = "毒蛇花", itIT = "", },
      [350] = {enUS = "Stonebloom", deDE = "Steinblüte", frFR = "Pierrelette", esES = "", ruRU = "", ptBR = "", koKO = "", zhCN = "石花", itIT = "Sbocciapietra", },
      [351] = {enUS = "Twilight's Hammer Crate", deDE = "Kiste des Schattenhammers", frFR = "Caisse du Marteau du crépuscule", esES = "Cajón del Martillo Crepuscular", ruRU = "Ящик Сумеречного Молота", ptBR = "Caixote do Martelo do Crepúsculo", koKO = "황혼의 망치단 상자", zhCN = "暮光之锤板条箱", itIT = "Cassa del Martello del Crepuscolo", },
      [352] = {enUS = "Xavren's Thorn", deDE = "Xavrens Dorn", frFR = "Epine de Xavren", esES = "Espina de Xavren", ruRU = "Ксавренов терн", ptBR = "Espinho-de-xavren", koKO = "자브렌의 가시", zhCN = "萨维伦之棘", itIT = "Spina di Xavren", },
      [353] = {enUS = "Earthroot", deDE = "Erdwurzel", frFR = "Terrestrine", esES = "Raíz de tierra", ruRU = "Земляной корень", ptBR = "Raiz-telúrica", koKO = "뱀뿌리", zhCN = "地根草", itIT = "Bulboterro", },
      [354] = {enUS = "Frozen Herb", deDE = "Gefrorenes Kraut", frFR = "Herbe gelée", esES = "Hierba congelada", ruRU = "Мерзлая трава", ptBR = "Planta Congelada", koKO = "얼어붙은 약초", zhCN = "冰冷的草药", itIT = "Erba Congelata", },
      [355] = {enUS = "Arthas' Tears", deDE = "Arthas' Tränen", frFR = "", esES = "", ruRU = "Слезы Артаса", ptBR = "Arthas' Tears", koKO = "아서스의 눈물", zhCN = "", itIT = "Arthas' Tears", },
      [356] = {enUS = "Sungrass", deDE = "Sonnengras", frFR = "Soleillette", esES = "Solea", ruRU = "Солнечник", ptBR = "Sungrass", koKO = "Sungrass", zhCN = "Sungrass", itIT = "Sungrass", },
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
local toptionTypes = {
   "miningNodes",
   "herbs",
   "gasCollector",
}

function SkuCore:MinimapScanFindActiveRessource(aX, aY)
   local tRessourceTypes = {
      SkuCore.RessourceTypes.mining,
      SkuCore.RessourceTypes.herbs,
      SkuCore.RessourceTypes.gasCollector,
   }

   for i = 1, GameTooltip:NumLines() do
      local line = string.lower(_G['GameTooltipTextLeft' .. i]:GetText())
      if line then
         line = SkuChat:Unescape(line)
         for r = 1, #tRessourceTypes do
            for x = 1, #tRessourceTypes[r] do
               if SkuOptions.db.profile[MODULE_NAME].ressourceScanning[toptionTypes[r]][x] == true then
                  for w in string.gmatch(tRessourceTypes[r][x][Sku.LocP], ".+") do
                     if string.find(line, string.lower(w), 1, true) and not string.find(line, string.lower(w .. '|'), 1, true) then
                        if not tFoundPositions[tRessourceTypes[r][x][Sku.LocP]] then
                           tFoundPositions[tRessourceTypes[r][x][Sku.LocP]] = {}
                        end
                        if #tFoundPositions[tRessourceTypes[r][x][Sku.LocP]] == 0 then
                           tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][1] = {
                              xMin = aX - 1,
                              xMax = aX + 1,
                              yMin = aY - 1,
                              yMax = aY + 1,
                           }
                        else
                           local tFoundIndex
                           for q = 1, #tFoundPositions[tRessourceTypes[r][x][Sku.LocP]] do
                              local xmax = tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][q].xMax - aX
                              local ymax = tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][q].yMax - aY
                              local xmin = tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][q].xMin - aX
                              local ymin = tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][q].yMin - aY
                              if xmax < 0 then xmax = xmax * -1 end
                              if ymax < 0 then ymax = ymax * -1 end
                              if xmin < 0 then xmin = xmin * -1 end
                              if ymin < 0 then ymin = ymin * -1 end

                              local tRangeNew = 20
                              if xmax < tRangeNew and ymax < tRangeNew and xmin < tRangeNew and ymin < tRangeNew then
                                 tFoundIndex = q
                              end
                           end
                           if tFoundIndex then
                              if tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].xMin > aX then
                                 tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].xMin = aX
                              end
                              if tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].xMax < aX then
                                 tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].xMax = aX
                              end
                              if tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].yMin > aY then
                                 tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].yMin = aY
                              end
                              if tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].yMax < aY then
                                 tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][tFoundIndex].yMax = aY
                              end
                           else
                              tFoundPositions[tRessourceTypes[r][x][Sku.LocP]][#tFoundPositions[tRessourceTypes[r][x][Sku.LocP]] + 1] = {
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
   local tCount = C_Minimap.GetNumTrackingTypes()
   for i = 1, tCount do
      local tReturnTable, texture, active, category = C_Minimap.GetTrackingInfo(i)
      if tReturnTable.type ~= "spell" then
         SetTracking(i, false)
      end
   end

   SkuCore.noMouseOverNotification = true

   SkuCore.MinimapScanFastRunning = true

   SkuCore:StoreMinimap()
   mmx, mmy = Minimap:GetSize()
   Minimap:SetSize(15, 15)
   Minimap:ClearAllPoints()
   local x, y = GetCursorPosition()
   Minimap:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / UIParent:GetScale(), y / UIParent:GetScale())
      
   C_Timer.After(0.1, function()
      GameTooltip:SetAlpha(0)

      local tTooltipLines = {}
      for i = 1, GameTooltip:NumLines() do
         local line = _G['GameTooltipTextLeft' .. i]:GetText()
         if line then
            line = SkuChat:Unescape(line)
            if string.find(line.."\n", "", 1, true) then
               line = line.."\n"
               for w in string.gmatch(line, ".+\n") do
                  tTooltipLines[w] = w
               end
            else
               tTooltipLines[tTooltipLines] = tTooltipLines
            end
         end
      end

      for i, v in pairs(tTooltipLines) do
         for r = 1, #tRessourceTypes do
            for x = 1, #tRessourceTypes[r] do
               if SkuOptions.db.profile[MODULE_NAME].ressourceScanning[toptionTypes[r]][x] == true then
                  if tRessourceTypes[r][x][Sku.LocP] then
                     for w in string.gmatch(tRessourceTypes[r][x][Sku.LocP], ".+") do
                        if string.sub(v, 1, string.len(v) - 1) == w and not string.find(v, w.."|", 1, true) then
                           if v == "Kobaltablagerung" then
                              v = "Kobaltvorkommen"
                           end
                           if v == "Reiche Kobaltablagerung" then
                              v = "Reiches Kobaltvorkommen"
                           end

                           SkuCore:MinimapScanFastStop(v)
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
         SkuOptions.Voice:OutputStringBTtts(aResult, false, true, 0.2, nil, nil, nil, 2) 
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
      if SkuCore:IsPlayerMoving(true) ~= true then
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
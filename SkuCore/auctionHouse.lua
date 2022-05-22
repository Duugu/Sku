---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "AuctionHouse"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local mfloor = math.floor

local tHistoryDataMaxiumAmount = 50
local tDelayFactorForAddingAuctionsToHistory = 100000

SkuCore.OwnedDB = {}
SkuCore.BidDB = {}
SkuCore.CurrentDB = {}
SkuCore.ScanQueue = {}
SkuCore.AuctionHouseOpen = false
SkuCore.AuctionIsScanning = false
SkuCore.AuctionIsFullScanning = false

SkuCore.SortByValues = {
   [1] = L["Kaufpreis für 1 Gegenstand aufsteigend"],
   [2] = L["Kaufpreis für Auktionsmenge aufsteigend"],
   [3] = L["Gebotspreis für 1 Gegenstand aufsteigend"],
   [4] = L["Gebotspreis für Auktionsmenge aufsteigend"],
   [5] = L["Level absteigend"],
   [6] = L["Level aufsteigend"],
}

local AUCTION_ITEM_LIST_UPDATE_timerHandle
local AUCTION_BIDDER_LIST_UPDATE_timerHandle
local AUCTION_OWNED_LIST_UPDATE_timerHandle

--QualityItemIndex
local tQAIindex = {
   ["text"] = 1, 
   ["minLevel"] = 2, 
   ["maxLevel"] = 3, 
   ["page"] = 4, 
   ["usable"] = 5, 
   ["rarity"] = 6, 
   ["getAll"] = 7, 
   ["exactMatch"] = 8, 
   ["filterData"] = 9,
}

--AuctionItemDataIndex
local tAIDIndex = {
   ["name"] = 1, --string
   ["texture"] = 2, --number
   ["count"] = 3, --number
   ["quality"] = 4, --number; Enum.ItemQuality
   ["canUse"] = 5, --bool
   ["level"] = 6, --number
   ["levelColHeader"] = 7, -- string
                           --"REQ_LEVEL_ABBR" - level represents the required character level
                           --"SKILL_ABBR" - level represents the required skill level (for recipes)
                           --"ITEM_LEVEL_ABBR" - level represents the item level
                           --"SLOT_ABBR" - level represents the number of slots (for containers)
   ["minBid"] = 8,  --number
   ["minIncrement"] = 9,  --number
   ["buyoutPrice"] = 10,  --number
   ["bidAmount"] = 11,  --number
   ["highBidder"] = 12, --bool
   ["bidderFullName"] = 13, --string or nil
   ["owner"] = 14, --string
   ["ownerFullName"] = 15, --string or nil
   ["saleStatus"] = 16, --number; 1 for sold 0 for unsold
   ["itemId"] = 17, --number
   ["hasAllInfo"] = 18, --bool
}

local tPage = 0

---------------------------------------------------------------------------------------------------------------------------------------
local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}

local function unescape(str)
	for k, v in pairs(escapes) do
		str = string.gsub(str, k, v)
	end
	return str
end

local maxItemNameLength = 40
local function ItemName_helper(aText)
	aText = unescape(aText)
	local tShort, tLong = aText, ""

	local tStart, tEnd = string.find(tShort, "\r\n")
	local taTextWoLb = aText
	if tStart then
		taTextWoLb = string.sub(tShort, 1, tStart - 1)
		tLong = aText
	end

	if string.len(taTextWoLb) > maxItemNameLength then
		local tBlankPos = 1
		while (string.find(taTextWoLb, " ", tBlankPos + 1) and tBlankPos < maxItemNameLength) do
			tBlankPos = string.find(taTextWoLb, " ", tBlankPos + 1)
		end
		if tBlankPos > 1 then
			tShort = string.sub(taTextWoLb, 1, tBlankPos).."..."
		else
			tShort = string.sub(taTextWoLb, 1, maxItemNameLength).."..."
		end		
		tLong = aText
	else
		tShort = taTextWoLb
	end

	return string.gsub(tShort, "\r\n", " "), tLong
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.AuctionChatMessageFailFlag = false
function SkuCore:AuctionChatAddMessageHook(aMessage, aR, aG, aB, aA, aMessageType)
   --SkuCore:Debug("AuctionChatAddMessageHook "..(aMessage or "nil").." aR "..(aR or "nil"), true)
   if not aMessage then
      return
   end

   if aMessage == L["Gebot akzeptiert."] then
      SkuOptions.Voice:OutputStringBTtts(L["Gebot akzeptiert"], true, true, 1, false)
   elseif string.find(aMessage, L["Ihr habt eine Auktion gewonnen für: "]) then
      local tItemName = string.sub(aMessage, select(2, string.find(aMessage, L["Ihr habt eine Auktion gewonnen für: "])))
      SkuOptions.Voice:OutputStringBTtts(L["Auktion gewonnen: "]..(tItemName or ""), false, true, 1, false)
   elseif string.find(aMessage, L["Ihr habt nicht genug Geld."]) then
      SkuCore.AuctionChatMessageFailFlag = true
      SkuOptions.Voice:OutputStringBTtts(L["Nicht genug Geld"], true, true, 1, false)
   elseif string.find(aMessage, L["Es liegt bereits ein höheres Gebot für diesen Gegenstand vor."]) then
      SkuCore.AuctionChatMessageFailFlag = true
      SkuOptions.Voice:OutputStringBTtts(L["Bereits höheres Gebot vorhanden"], true, true, 1, false)
   elseif string.find(aMessage, L["Der Gegenstand wurde nicht gefunden."]) then
      SkuCore.AuctionChatMessageFailFlag = true
      SkuOptions.Voice:OutputStringBTtts(L["Aktion nicht mehr vorhanden"], true, true, 1, false)
   elseif string.find(aMessage, L["Ihr wurdet bei "]) then
      --"Ihr wurdet bei Leinenstoff überboten.""
      
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionBuildItemTooltip(aItemData, aIndex, aAddCurrentPriceData, aAddHistoryPriceData)
   --print("AuctionBuildItemTooltip",aItemData, aIndex, aAddCurrentPriceData, aAddHistoryPriceData)   
   local tTextFirstLine, tTextFull = "", ""
   _G["SkuScanningTooltip"]:ClearLines()
   local hsd, rc = _G["SkuScanningTooltip"]:SetItemByID(aItemData[17])
   if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
      if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
         local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
         tTextFirstLine, tTextFull = ItemName_helper(tText)
      end
   end

   local tPriceHistoryData, tBestBuyoutPriceCopper = SkuCore:AuctionPriceHistoryData(aItemData[17], aAddCurrentPriceData, aAddHistoryPriceData)

   table.insert(tPriceHistoryData, 1, tTextFull)

   return tTextFirstLine, tPriceHistoryData
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuGetCoinText(aCopper, aShort, aVeryShort)
   local tResultString = GetCoinText(aCopper)
   if aVeryShort == true then
      if aCopper < 100 then
         tResultString = mfloor(aCopper).." "..L["Copper"]
      elseif aCopper < 10000 then
         local tRemaining = aCopper - (mfloor(aCopper / 100) * 100)
         if tRemaining == 0 then 
            tRemaining = "" 
         else
            tRemaining = mfloor(tRemaining)
         end
         tResultString = mfloor(aCopper / 100).." "..L["Silver"].." "..tRemaining
      elseif aCopper >= 10000 then
         local tRemaining = mfloor((aCopper - (mfloor(aCopper / 10000) * 10000)) / 100)
         if tRemaining == 0 then tRemaining = "" end
         tResultString = mfloor(aCopper / 10000).." "..L["Gold"].." "..tRemaining
      end
   end

   if aShort == true then
      --tResultString = string.gsub(tResultString, L["Gold"], L["G"])
      --tResultString = string.gsub(tResultString, L["Silver"], L["S"])
      --tResultString = string.gsub(tResultString, L["Copper"], L["C"])
   end

   return tResultString
end

---------------------------------------------------------------------------------------------------------------------------------------
local function EpochValueHelper(aValue)
   aValue = GetServerTime() - aValue

   if aValue < 60 then
      return mfloor(aValue)..L[" Sekunden"]
   elseif aValue < 3600 then
      return mfloor(aValue / 60)..L[" Minuten"]
   elseif aValue < 86400 then
      return mfloor(aValue / 3600)..L[" Stunden"]
   else
      return mfloor(aValue / 86400)..L[" Tage"]
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionItemNameFormat(aItemData, aIndex, aAddLevel)
   if not aItemData then
      return
   end

   local rName = ""

   if aIndex then
      rName = aIndex.." "
   end

   if not aItemData[tAIDIndex["name"]] then
      rName = rName..L["kein name"]
   else
      rName = rName..aItemData[tAIDIndex["name"]]
   end

   if aAddLevel and aItemData[20] then
      rName = rName..L[" Level "]..aItemData[20]
   end

   rName = rName.." "..aItemData[tAIDIndex["count"]]..L[" stück"]

   if aItemData[tAIDIndex["minBid"]] == aItemData[tAIDIndex["buyoutPrice"]] then
      rName = rName.." §01 §01"..L[" Nur Kauf "]..SkuGetCoinText(aItemData[tAIDIndex["buyoutPrice"]], true, true)..""
   elseif aItemData[tAIDIndex["buyoutPrice"]] > 0 then
      rName = rName.." §01 §01"..L["Kauf "]..SkuGetCoinText(aItemData[tAIDIndex["buyoutPrice"]], true, true).." §01 §01"..L["Gebot "]..SkuGetCoinText(aItemData[tAIDIndex["minBid"]], true, true)..""  
   elseif aItemData[tAIDIndex["buyoutPrice"]] == 0 then
      rName = rName.." §01 §01"..L["Nur Gebot "]..SkuGetCoinText(aItemData[tAIDIndex["minBid"]], true, true)..""
   end

   if aItemData[12] == true then
      rName = rName..L[" Du bist Höchstbieter"]
   end

   return rName
end

---------------------------------------------------------------------------------------------------------------------------------------
local function Median(t)
   if not t then
      return 0
   end

   if #t == 0 then
      return 0
   end

   local temp={}
 
   -- deep copy table so that when we sort it, the original is unchanged
   -- also weed out any non numbers
   for k,v in pairs(t) do
      if type(v) == "number" then
         table.insert( temp, v )
      end
   end
 
   table.sort(temp)
 
   -- If we have an even number of table elements or odd.
   if math.fmod(#temp,2) == 0 then
      -- return mean value of middle two elements
      return (temp[#temp/2] + temp[(#temp/2)+1]) / 2
   else
      -- return middle element
      return temp[math.ceil(#temp/2)]
   end
 end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionPriceHistoryData(aItemID, aAddCurrentPriceData, aAddHistoryPriceData)

   --SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB
   --SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory
   --SkuCore.CurrentDB

   if not aItemID then
      return
   end

   local tFullTextSections = {}
   local tSuggestedSellPrice

   local function Calculate(tSource)
      local tSeenAmount
      local tLastSeen
      local tLow
      local tHigh
      local tAverage
      local tCopperSum

      local tMedian = {}
      for tCopper, tSeenData in pairs(tSource) do
         table.insert(tMedian, tCopper)
      end
      tAverage = Median(tMedian)--tCopperSum / tSeenAmount


      for tCopper, tSeenData in pairs(tSource) do
         for tServerTime, tAmountSeen in pairs(tSeenData) do
            if not tLastSeen then
               tLastSeen = tServerTime
            else
               if tServerTime > tLastSeen then
                  tLastSeen = tLastSeen
               end
            end

            tSeenAmount = (tSeenAmount or 0) + tAmountSeen
            tCopperSum = (tCopperSum or 0) + (tCopper * tAmountSeen)
         end

         if not tLow then
            tLow = tCopper
         else
            if tCopper < tLow then
               tLow = tCopper
            end
         end
         
         if tCopper < tAverage * 10 then
            if not tHigh then
               tHigh = tCopper
            else
               if tCopper > tHigh then
                  tHigh = tCopper
               end
            end
         else
            --print("ignored", aItemID, SkuGetCoinText(tAverage, true), SkuGetCoinText(tCopper, true))
         end
      end

      if not tSeenAmount then
         return nil
      end

      return tSeenAmount, tLastSeen, tLow, tHigh, tAverage
   end

   --vendor price
   local void, void, Rarity, void, void, void, void, void, void, void, copperItemPrice = GetItemInfo(aItemID)
   local tText = L["Nicht verkaufbar"]
   if copperItemPrice then
      if copperItemPrice > 0 then
         tText = L["Händlerpreis"]..": "..SkuGetCoinText(copperItemPrice, true, nil)..L[" (for 1 item)"]
      end
   end
   table.insert(tFullTextSections, tText)

   --current data
   if aAddCurrentPriceData == true then
      local tTempCurrentHistoryDB = {}
      SkuCore:AuctionUpdateAuctionDBHistory(aFromAuctionDB, true, tTempCurrentHistoryDB, aItemID)

      local tText = ""
      if not tTempCurrentHistoryDB[aItemID] then
         tText = L["Keine aktuellen Preisdaten vorhanden"]
      else
         tText = L["Aktuelle Preisdaten (für ein Stück)"]

         local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(tTempCurrentHistoryDB[aItemID].buyouts)
         if not tBidSeenAmount then
            tText = tText..L["\r\nKeine Sofortkaufdaten vorhanden"]
         else         
            tText = tText..L["\r\nSofortkaufdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nZuletzt vor "]..EpochValueHelper(tBidLastSeen)..L["\r\nNiedrigster "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchster "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
            tSuggestedSellPrice = tBidLow
         end

         local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(tTempCurrentHistoryDB[aItemID].bids)
         if not tBidSeenAmount then
            tText = tText..L["\r\nKeine Gebotsdaten vorhanden"]
         else         
            tText = tText..L["\r\nGebotsdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nZuletzt vor "]..EpochValueHelper(tBidLastSeen)..L["\r\nNiedrigstes "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchstes "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
         end
      end
      table.insert(tFullTextSections, tText)
   end

   --history data
   if aAddHistoryPriceData == true then
      local tText = ""
      if not SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory[aItemID] then
         tText = L["Keine historischen Preisdaten vorhanden"]
      else
         tText = L["Historische Preisdaten (für ein Stück)"]

         local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory[aItemID].buyouts)
         if not tBidSeenAmount then
            tText = tText..L["\r\nKeine Sofortkaufdaten vorhanden"]
         else         
            tText = tText..L["\r\nSofortkaufdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nZuletzt vor "]..EpochValueHelper(tBidLastSeen)..L["\r\nNiedrigster "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchster "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
            if not tSuggestedSellPrice then
               tSuggestedSellPrice = tBidLow
            end
         end

         local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory[aItemID].bids)
         if not tBidSeenAmount then
            tText = tText..L["\r\nKeine Gebotsdaten vorhanden"]
         else         
            tText = tText..L["\r\nGebotsdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nZuletzt vor "]..EpochValueHelper(tBidLastSeen)..L["\r\nNiedrigstes "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchstes "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
         end
      end
      table.insert(tFullTextSections, tText)
   end

   return tFullTextSections, tSuggestedSellPrice
end


---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionScanQueueReset()
   if SkuCore.AuctionIsFullScanning == true then
      return
   end
   
   if AUCTION_ITEM_LIST_UPDATE_timerHandle then
      AUCTION_ITEM_LIST_UPDATE_timerHandle:Cancel()
   end
   if AUCTION_BIDDER_LIST_UPDATE_timerHandle then
      AUCTION_BIDDER_LIST_UPDATE_timerHandle:Cancel()
   end
   if AUCTION_OWNED_LIST_UPDATE_timerHandle then
      AUCTION_OWNED_LIST_UPDATE_timerHandle:Cancel()
   end
   tCurrentQuery = nil
   SkuCore.IsBid = nil
   SkuCore.ScanQueue = {}
   SkuCore.AuctionIsScanning = false
   SkuCore.AuctionIsFullScanning = false
   tPage = 0
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionScanQueueRemove()
   tremove(SkuCore.ScanQueue, 1)
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionScanQueueAdd(aScanData, aResetQueue)
   dprint("AuctionScanQueueAdd", aScanData, aResetQueue)
   if aResetQueue then
      if SkuCore.AuctionIsFullScanning == true then
         return
      end

      SkuCore.CurrentDB = {}
      if AUCTION_ITEM_LIST_UPDATE_timerHandle then
         AUCTION_ITEM_LIST_UPDATE_timerHandle:Cancel()
      end
      if AUCTION_BIDDER_LIST_UPDATE_timerHandle then
         AUCTION_BIDDER_LIST_UPDATE_timerHandle:Cancel()
      end
      if AUCTION_OWNED_LIST_UPDATE_timerHandle then
         AUCTION_OWNED_LIST_UPDATE_timerHandle:Cancel()
      end
      SkuCore.AuctionIsScanning = false
      SkuCore.AuctionIsFullScanning = false
      SkuCore.ScanQueue = {}
      tCurrentQuery = nil
      tPage = 0
      tinsert(SkuCore.ScanQueue, aScanData)
      dprint("scan added to queue")
   else
      local tExists = false
      if #SkuCore.ScanQueue > 0 then
         for x = 1, #SkuCore.ScanQueue do
            local tDifferentValue = false
            for i, v in pairs(tQAIindex) do
               --print(x, "tQAIindex", i, v)
               --print(aScanData[i], SkuCore.ScanQueue[x][i])
               if aScanData[i] ~= SkuCore.ScanQueue[x][i] then
                  tDifferentValue = true
               end
            end
            if tDifferentValue == false then
               tExists = true
            end
         end
      end
      if tExists == false then
         tinsert(SkuCore.ScanQueue, aScanData)
         dprint("scan added to queue")
      else
         dprint("scan already exists in queue")
      end
   end
end
---------------------------------------------------------------------------------------------------------------------------------------
local tCurrentQuery = nil
function SkuCore:AuctionScanQueueTicker()
   if SkuCore.AuctionIsScanning == true then
      return
   end

   if SkuCore.ScanQueue[1] then
      dprint("AuctionScanQueueTicker, new scan")
      SkuCore.AuctionIsScanning = true
      if SkuCore.ScanQueue[1].getAll == true then
         SkuCore.AuctionIsFullScanning = true
      end
      tCurrentQuery = SkuCore.ScanQueue[1]

      QueryAuctionItems(SkuCore.ScanQueue[1].text, SkuCore.ScanQueue[1].minLevel, SkuCore.ScanQueue[1].maxLevel, SkuCore.ScanQueue[1].page, SkuCore.ScanQueue[1].usable, SkuCore.ScanQueue[1].rarity, SkuCore.ScanQueue[1].getAll, SkuCore.ScanQueue[1].exactMatch, SkuCore.ScanQueue[1].filterData)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
do
   local tTime = 0
   local tFrame = CreateFrame("Button", "SkuCoreSecureTabButtonAuctions", _G["UIParent"], "SecureActionButtonTemplate")
   tFrame:SetSize(1, 1)
   tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
   tFrame:Show()
   tFrame:SetScript("OnUpdate", function(self, time)
      tTime = tTime + time
      if tTime < 0.8 then return end
      if SkuCore.AuctionScanQueueTicker then
         SkuCore:AuctionScanQueueTicker()
      end
      tTime = 0
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseBuildItemSellMenuSub(aSelf, aGossipItemTable)
   aSelf.GetCurrentValue = function(self, aValue, aName)
      local tItemId
      if _G[aGossipItemTable.containerFrameName] then
         if _G[aGossipItemTable.containerFrameName].info then
            tItemId = _G[aGossipItemTable.containerFrameName].info.id
         end
      end
      if not tItemId then
         tItemId = aGossipItemTable.itemId
      end

      if not tItemId then
         return
      end

      local tBestBuyoutCopper = select(2, SkuCore:AuctionPriceHistoryData(tItemId, true, true))

      if not tBestBuyoutCopper then
         return L["Sofortkauf Preis pro Stack"]
      end

      if tBestBuyoutCopper < 100 then
         return "1#"..L["Silber"]
      end

      if tBestBuyoutCopper < 10000 then
         return mfloor(tBestBuyoutCopper).."#"..L["Silber"]
      end

      if tBestBuyoutCopper < 10000000 then
         return mfloor(tBestBuyoutCopper / 10000).."#"..L["Gold"]
      end

      return L["Sofortkauf Preis pro Stack"]
   end   

   aSelf.BuildChildren = function(self)
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Sofortkauf Preis pro Stack"]}, SkuGenericMenuItem)

      local x = 100
      while x <= 10000000 do
         if x < 10000 then
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {(x / 100).."#"..L["Silber"]}, SkuGenericMenuItem)
            tNewMenuEntry.copperValue = x
            x = x + 100
         else
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {(x / 10000).."#"..L["Gold"]}, SkuGenericMenuItem)
            tNewMenuEntry.copperValue = x
            x = x + 10000
         end
         tNewMenuEntry.filterable = true
         tNewMenuEntry.dynamic = true
         tNewMenuEntry.OnEnter = function(self, aValue, aName)
            self.selectTarget.price = self.copperValue
         end
         tNewMenuEntry.BuildChildren = function(self)
            local tNewMenuEntryAuctions = SkuOptions:InjectMenuItems(self, {L["Anzahl Auktionen"]}, SkuGenericMenuItem)
            self.selectTarget.amount = self.selectTarget.amount or 1
            local tNumActionsMax = mfloor(self.selectTarget.amountMax / self.selectTarget.amount)
            local tNewMenuEntryAuctions = SkuOptions:InjectMenuItems(self, {L["Alle ("]..tNumActionsMax..L[" mal "]..self.selectTarget.amount..L[")"]}, SkuGenericMenuItem)
            tNewMenuEntryAuctions.dynamic = true
            tNewMenuEntryAuctions.numAuctions = tNumActionsMax
            tNewMenuEntryAuctions.OnEnter = function(self, aValue, aName)
               self.selectTarget.numAuctions = self.numAuctions
            end
            tNewMenuEntryAuctions.BuildChildren = function(self)
               local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 12 Stunden"]}, SkuGenericMenuItem)
               local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 24 Stunden"]}, SkuGenericMenuItem)
               local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 48 Stunden"]}, SkuGenericMenuItem)
            end

            for tNumActions = 1, tNumActionsMax do
               local tNewMenuEntryAuctions = SkuOptions:InjectMenuItems(self, {tNumActions..L[" mal "]..self.selectTarget.amount}, SkuGenericMenuItem)
               tNewMenuEntryAuctions.dynamic = true
               tNewMenuEntryAuctions.numAuctions = tNumActions
               tNewMenuEntryAuctions.OnEnter = function(self, aValue, aName)
                  self.selectTarget.numAuctions = self.numAuctions
               end
               tNewMenuEntryAuctions.BuildChildren = function(self)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 12 Stunden"]}, SkuGenericMenuItem)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 24 Stunden"]}, SkuGenericMenuItem)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Erstellen: 48 Stunden"]}, SkuGenericMenuItem)
               end
            end
         end         
      end
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseBuildItemSellMenu(aParent, aGossipItemTable)
   dprint("AuctionHouseBuildItemSellMenu", aGossipItemTable, aGossipItemTable.containerFrameName, aGossipItemTable.itemId)
   --we need to stop all running scans, as PostAuction will fail otherwise
   SkuCore:AuctionScanQueueReset()

   if SkuCore.AuctionHouseOpen ~= true then
      return
   end

   if aGossipItemTable.textFull == "" then
      return
   end

   if not aGossipItemTable.itemId then
      return
   end

   for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
      for slot = 1, GetContainerNumSlots(bag) do
         local icon, itemCount, locked, quality, readable, _, _, _, noValue, itemID, isBound = GetContainerItemInfo(bag, slot)
         if itemID then
            isBound = C_Item.IsBound(ItemLocation:CreateFromBagAndSlot(bag, slot))
         end
         if itemID == aGossipItemTable.itemId then
            if isBound == true then
               return
            end
         end
      end
   end

   local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParent, {L["Verkaufen"]}, SkuGenericMenuItem)
   tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.dynamic = true
   tNewMenuParentEntry.isSelect = true
   tNewMenuParentEntry.itemId = aGossipItemTable.itemId
   tNewMenuParentEntry.amountMax = 0

   for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
      for slot = 1, GetContainerNumSlots(bag) do
         local _, itemCount, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(bag, slot)
         if itemID == tNewMenuParentEntry.itemId then
            tNewMenuParentEntry.amountMax = tNewMenuParentEntry.amountMax + itemCount
         end
      end
   end

   tNewMenuParentEntry.OnAction = function(self, aValue, aName)
      dprint("sell OnAction", self, aValue, aName, self.selectTarget.name, self.selectTarget.price, self.price)
      local tAmount = tonumber(self.selectTarget.amount)
      local tNumAuctions = tonumber(self.selectTarget.numAuctions)
      local tCopperBuyout = tonumber(self.selectTarget.price)
      local tCopperStartBid = mfloor(tCopperBuyout / 2)
      local tDuration
      if aName == L["Erstellen: 12 Stunden"] then
         tDuration = 720
      elseif aName == L["Erstellen: 24 Stunden"] then
         tDuration = 1440
      elseif aName == L["Erstellen: 48 Stunden"] then
         tDuration = 2880
      end

      if not tDuration or not tCopperBuyout or not tAmount or not tNumAuctions then
         return
      end

      --post it
      ClearCursor()
      _G["AuctionFrameTab3"]:GetScript("OnClick")(_G["AuctionFrameTab3"], "LeftButton") 
      _G["AuctionsItemButton"]:GetScript("OnDragStart")(_G["AuctionsItemButton"], "LeftButton") 
      ClearCursor()
      _G[aGossipItemTable.containerFrameName]:GetScript("OnDragStart")(_G[aGossipItemTable.containerFrameName], "LeftButton") 
      ClickAuctionSellItemButton()

      PostAuction(tCopperStartBid, tCopperBuyout, tDuration, tAmount, tNumAuctions)

      if tNumAuctions == 1 then
         SkuOptions.Voice:OutputStringBTtts(L["Auktion erstellt"], false, true, 1, true)
      else
         SkuOptions.Voice:OutputStringBTtts(tNumAuctions..L[" Auktionen erstellt"], false, true, 1, true)
      end

      GetOwnerAuctionItems()

      C_Timer.After(0.01, function()
         SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)      
      end)
      C_Timer.After(0.01, function()
         SkuCore:CheckFrames()
      end)
   end

	tNewMenuParentEntry.BuildChildren = function(self)
      local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {L["Stack Größe"]}, SkuGenericMenuItem)
      local _, _, _, _, _, _, _, itemStackMaxCount = GetItemInfo(self.itemId) 

      local tCount = self.amountMax or 1
      if itemStackMaxCount < tCount then
         tCount = itemStackMaxCount
      end

      for z = 1, tonumber(tCount) do
         local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {z..L[" ("]..self.amountMax..L[")"]}, SkuGenericMenuItem)
         tStackMenuEntry.filterable = true
         tStackMenuEntry.dynamic = true
         tStackMenuEntry.OnEnter = function(self, aValue, aName)
            self.selectTarget.amount = z
         end
         SkuCore:AuctionHouseBuildItemSellMenuSub(tStackMenuEntry, aGossipItemTable)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionStartQuery(aCategoryIndex, aSubCategoryIndex, aSubSubCategoryIndex, aResetQueue, aMaxPage)
   local text = ""
   local minLevel = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin
   local maxLevel = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax
   local categoryIndex = aCategoryIndex
   local subCategoryIndex = aSubCategoryIndex
   local subSubCategoryIndex = aSubSubCategoryIndex
   local page = 0
   local usable = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable
   local rarity = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality
   local exactMatch = nil
   local filterData = nil

   if categoryIndex and subCategoryIndex and subSubCategoryIndex then
      filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters
   elseif categoryIndex and subCategoryIndex then
      filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters
   elseif categoryIndex then
      filterData = AuctionCategories[categoryIndex].filters
   end

   SkuCore:AuctionScanQueueAdd({
      ["text"] = text, 
      ["minLevel"] = minLevel, 
      ["maxLevel"] = maxLevel, 
      ["page"] = page, 
      ["usable"] = usable, 
      ["rarity"] = rarity, 
      ["getAll"] = getAll, 
      ["exactMatch"] = exactMatch, 
      ["filterData"] = filterData,
   }, aResetQueue)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CheckForDuplicateAndAddIf(aParentChilds, aNewMenuEntryName, aNewItemData)
   local tNewNameWoIndex = aNewMenuEntryName
   for x = 1, #aParentChilds do
      if aParentChilds[x].name == tNewNameWoIndex then
         aParentChilds[x].dupesList[#aParentChilds[x].dupesList + 1] = aNewItemData
         return true
      end
   end

   return false
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuSpairs(t, order)
	local tSFunction = function(a,b) 
      return order(t, a, b) 
   end
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, tSFunction)
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
function SkuCore:AuctionGetPricePerItem(aData)
   local tPPIBid, tPPIBuy = aData[8] / aData[3], aData[10] / aData[3]
   return {bid = tPPIBid, buy = tPPIBuy,}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseMenuBuilderItemList(aParent)
   tCurrentDBClean = {}

   for tIndex, tData in pairs(SkuCore.CurrentDB) do
      if tData then
         if tData[1] then
            local tName = SkuCore:AuctionItemNameFormat(tData)
            local tFound = false
            for x = 1, #tCurrentDBClean do
               if tCurrentDBClean[x].name == tName then
                  tCurrentDBClean[x].dupes[#tCurrentDBClean[x].dupes + 1] = tData
                  tFound = true
               end
            end
            if tFound == false then
               tCurrentDBClean[#tCurrentDBClean + 1] = {}
               tCurrentDBClean[#tCurrentDBClean].name = tName
               tCurrentDBClean[#tCurrentDBClean].level = select(4, GetItemInfo(tData[17])) or 0
               tCurrentDBClean[#tCurrentDBClean].pricePerItem = SkuCore:AuctionGetPricePerItem(tData)
               tCurrentDBClean[#tCurrentDBClean].pricePerAuction = {bid = tData[8], buy = tData[10],}
               tCurrentDBClean[#tCurrentDBClean].dupes = {}
               tCurrentDBClean[#tCurrentDBClean].dupes[#tCurrentDBClean[#tCurrentDBClean].dupes + 1] = tData
            end
         end
      end
   end
   
   tCurrentDBCleanSorted = {}

   if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 1 or not SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].pricePerItem.buy > t[a].pricePerItem.buy
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level,})
      end
   elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 2 then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].pricePerAuction.buy > t[a].pricePerAuction.buy
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level,})
      end
   elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 3 then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].pricePerItem.bid > t[a].pricePerItem.bid
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level,})
      end      
   elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 4 then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].pricePerAuction.bid > t[a].pricePerAuction.bid
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level,})
      end

   elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 5 then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].level < t[a].level
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level,})
      end
   elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 6 then
      for k, v in SkuSpairs(tCurrentDBClean, 
         function(t,a,b) 
            --return t[b].name > t[a].name 
            return t[b].level > t[a].level
         end) 
      do 
         table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level,})
      end


   end

   dprint("SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy", SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy, SkuCore.SortByValues[SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy])


   for tIndex, tDataTmp in pairs(tCurrentDBCleanSorted) do
      tData = tDataTmp.dupes[1]
      tData[19] = tDataTmp.dupes
      tData[20] = tDataTmp.level
      if tData then
         if tData[1] then
            local tNewMenuItemName = ""
            if #tData[19] > 1 then
               tNewMenuItemName = #tData[19]..L[" mal "]
            end
            local tWithLevel = nil
            if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 5 or SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 6 or SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin or SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax then
               tWithLevel = true
            end

            tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(aParent, {tNewMenuItemName..SkuCore:AuctionItemNameFormat(tData, nil, tWithLevel)}, SkuGenericMenuItem)
            tNewMenuEntryCategorySubSubItem.dynamic = false
            tNewMenuEntryCategorySubSubItem.data = tData
            tNewMenuEntryCategorySubSubItem.tIndex = tIndex
            tNewMenuEntryCategorySubSubItem.textFull = function() 
               return select(2, SkuCore:AuctionBuildItemTooltip(SkuOptions.currentMenuPosition.data, SkuOptions.currentMenuPosition.tIndex, true, true))
            end

            if tData[12] ~= true then
               tNewMenuEntryCategorySubSubItem.dynamic = true
               if tData[tAIDIndex["highBidder"]] ~= true or tData[tAIDIndex["buyoutPrice"]] > 0 then
                  tNewMenuEntryCategorySubSubItem.BuildChildren = function(self)
                     if tData[tAIDIndex["highBidder"]] ~= true then
                        tNewMenuEntryCOption = SkuOptions:InjectMenuItems(self, {L["Bieten"]}, SkuGenericMenuItem)
                        tNewMenuEntryCOption.dynamic = false
                        tNewMenuEntryCOption.data = self.parent.tData
                        tNewMenuEntryCOption.BuildChildren = function(self)
                           self.children = {}
                           for x = 1, #self.parent.data[19] do
                              tNewMenuEntryCOptionNo = SkuOptions:InjectMenuItems(self, {""..x..L[" Auktionen"]}, SkuGenericMenuItem)
                              tNewMenuEntryCOptionNo.data = self.parent.data
                              tNewMenuEntryCOptionNo.OnAction = function(self, aValue, aName)
                                 local tData = self.data

                                 SkuCore.AuctionIsScanning = false
                                 SkuCore.IsBid = tData
                                 SkuCore.IsBid.page = 0
                                 SkuCore.IsBid.currentBids = 1
                                 SkuCore.IsBid.NumberOfBidPlacements = x
                                 SkuCore:AuctionScanQueueAdd({
                                    ["text"] = tData[1], 
                                    ["minLevel"] = tData.query.minLevel, 
                                    ["maxLevel"] = tData.query.maxLevel, 
                                    ["page"] = 0, 
                                    ["usable"] = tData.query.usable, 
                                    ["rarity"] = tData.query.rarity, 
                                    ["getAll"] = tData.query.getAll, 
                                    ["exactMatch"] = tData.query.exactMatch, 
                                    ["filterData"] = tData.query.filterData,
                                 }, true)
                                 C_Timer.After(0.01, function() SkuOptions.Voice:OutputStringBTtts("sound-silence0.1", true, false) end)
                              end
                           end
                        end
                     end
            
                     if tData[tAIDIndex["buyoutPrice"]] > 0 then
                        tNewMenuEntryCOption = SkuOptions:InjectMenuItems(self, {L["Kaufen"]}, SkuGenericMenuItem)
                        tNewMenuEntryCOption.dynamic = false
                        tNewMenuEntryCOption.data = self.parent.tData
                        tNewMenuEntryCOption.BuildChildren = function(self)
                           self.children = {}
                           for x = 1, #self.parent.data[19] do
                              tNewMenuEntryCOptionNo = SkuOptions:InjectMenuItems(self, {""..x..L[" Auktionen"]}, SkuGenericMenuItem)
                              tNewMenuEntryCOptionNo.data = self.parent.data
                              tNewMenuEntryCOptionNo.OnAction = function(self, aValue, aName)
                                 local tData = self.data

                                 SkuCore.AuctionIsScanning = false
                                 SkuCore.IsBid = tData
                                 SkuCore.IsBid.page = 0
                                 SkuCore.IsBid.currentBids = 1
                                 SkuCore.IsBid.IsBuyout = true
                                 SkuCore.IsBid.NumberOfBidPlacements = x
                                 SkuCore:AuctionScanQueueAdd({
                                    ["text"] = tData[1], 
                                    ["minLevel"] = tData.query.minLevel, 
                                    ["maxLevel"] = tData.query.maxLevel, 
                                    ["page"] = 0, 
                                    ["usable"] = tData.query.usable, 
                                    ["rarity"] = tData.query.rarity, 
                                    ["getAll"] = tData.query.getAll, 
                                    ["exactMatch"] = tData.query.exactMatch, 
                                    ["filterData"] = tData.query.filterData,
                                 }, true)
                                 C_Timer.After(0.01, function() SkuOptions.Voice:OutputStringBTtts("sound-silence0.1", true, false) end)
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


---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionListItemMenuBuilder(aParent)

   if #SkuCore.ScanQueue > 0 or SkuCore.AuctionIsScanning == true  or tPage > 0 then
      tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(aParent, {L["Warten"]}, SkuGenericMenuItem)
      tNewMenuEntryCategorySubItem.dynamic = false
      local tTable = SkuOptions.currentMenuPosition
      tBread = SkuOptions.currentMenuPosition.name
      while tTable.parent.name do
         tTable = tTable.parent
         tBread = tTable.name..","..tBread
      end
      tNewMenuEntryCategorySubSubItemWaitTickerHandle = C_Timer.NewTicker(0, function(self)
         if #SkuCore.ScanQueue == 0 and SkuCore.AuctionIsScanning == false then
            self:Cancel()
            if SkuOptions.currentMenuPosition.name == L["Warten"] then
               SkuOptions:SlashFunc("short,"..tBread)
            end
         end
      end)
      tNewMenuEntryCategorySubItem.OnLeave = function(self, value, aValue)
         if tNewMenuEntryCategorySubSubItemWaitTickerHandle then
            tNewMenuEntryCategorySubSubItemWaitTickerHandle:Cancel()
         end
      end
   else
      if #SkuCore.CurrentDB > 0 and SkuCore.AuctionIsScanning == false then
         SkuCore:AuctionHouseMenuBuilderItemList(aParent)
      else
         tNewMenuEntryCategorySubItem  = SkuOptions:InjectMenuItems(aParent, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntryCategorySubItem.dynamic = false
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseMenuBuilder()
   if AuctionCategories and SkuCore.AuctionHouseOpen == true then
      --auctions
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Auktionen"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      --tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)

         tNewMenuEntryFaS = SkuOptions:InjectMenuItems(self, {L["Filter und Sortierung"]}, SkuGenericMenuItem)
         tNewMenuEntryFaS.dynamic = true
         --tNewMenuEntry.filterable = true
         tNewMenuEntryFaS.BuildChildren = function(self)

            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {L["Alles zurücksetzen"]}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = false
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               dprint("reset all OnAction", self, aValue, aName)
               SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter = {
                  ["LevelMin"] = nil,
                  ["LevelMax"] = nil,
                  ["MinQuality"] = nil,
                  ["Usable"] = nil,
                  ["SortBy"] = 1,
               }
            end
         
            tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {L["Filter"]}, SkuGenericMenuItem)
            tNewMenuEntryCategorySub.dynamic = true
            tNewMenuEntryCategorySub.BuildChildren = function(self)
               tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {L["Level Minimum"]}, SkuGenericMenuItem)
               tNewMenuEntryFilterOption.dynamic = true
               tNewMenuEntryFilterOption.filterable = true
               tNewMenuEntryFilterOption.isSelect = true
               tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
                  return SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin or 1
               end
               tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
                  dprint("Level Min OnAction", self, aValue, aName)
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin = tonumber(aName)
               end
               tNewMenuEntryFilterOption.BuildChildren = function(self)
                  for x = 1, 70 do
                     SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
                  end
               end

               tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {L["Level Max"]}, SkuGenericMenuItem)
               tNewMenuEntryFilterOption.dynamic = true
               tNewMenuEntryFilterOption.filterable = true
               tNewMenuEntryFilterOption.isSelect = true
               tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
                  return SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax or 70
               end
               tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
                  dprint("Level Max OnAction", self, aValue, aName)
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax = tonumber(aName)
               end
               tNewMenuEntryFilterOption.BuildChildren = function(self)
                  for x = 1, 70 do
                     SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
                  end
               end

               tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {L["Qualität"]}, SkuGenericMenuItem)
               tNewMenuEntryFilterOption.dynamic = true
               tNewMenuEntryFilterOption.filterable = true
               tNewMenuEntryFilterOption.isSelect = true
               tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
                  if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality then
                     return _G["ITEM_QUALITY"..SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality.."_DESC"]
                  else
                     return _G["ITEM_QUALITY0_DESC"]
                  end
               end
               tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
                  dprint("quality OnAction", self, aValue, aName)
                  for i=0, getn(ITEM_QUALITY_COLORS)-4  do
                     if _G["ITEM_QUALITY"..i.."_DESC"] == aName then
                        SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality = i
                     end
                  end   
               end
               tNewMenuEntryFilterOption.BuildChildren = function(self)
                  for i=0, getn(ITEM_QUALITY_COLORS)-4  do
                     SkuOptions:InjectMenuItems(self, {_G["ITEM_QUALITY"..i.."_DESC"]}, SkuGenericMenuItem)
                  end   
               end

               tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {L["Nur benutzbare"]}, SkuGenericMenuItem)
               tNewMenuEntryFilterOption.dynamic = true
               tNewMenuEntryFilterOption.filterable = true
               tNewMenuEntryFilterOption.isSelect = true
               tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
                  if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable == true then
                     return L["Ein"]
                  else
                     return L["Aus"]
                  end
               end
               tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
                  dprint("Ein OnAction", self, aValue, aName)
                  if aName == L["Ein"] then 
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable = true
                  else
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable = false
                  end
               end
               tNewMenuEntryFilterOption.BuildChildren = function(self)
                  SkuOptions:InjectMenuItems(self, {L["Ein"]}, SkuGenericMenuItem)
                  SkuOptions:InjectMenuItems(self, {L["Aus"]}, SkuGenericMenuItem)
               end
            end    

            tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {L["Sortierung"]}, SkuGenericMenuItem)
            tNewMenuEntryCategorySub.dynamic = true
            tNewMenuEntryCategorySub.filterable = true
            tNewMenuEntryCategorySub.isSelect = true
            tNewMenuEntryCategorySub.GetCurrentValue = function(self, aValue, aName)
               if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy then
                  return SkuCore.SortByValues[SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy]
               else
                  return SkuCore.SortByValues[1]
               end
            end
            tNewMenuEntryCategorySub.OnAction = function(self, aValue, aName)
               dprint("quality OnAction", self, aValue, aName)
               for i = 1, #SkuCore.SortByValues  do
                  if SkuCore.SortByValues[i] == aName then
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy = i
                  end
               end   
            end
            tNewMenuEntryCategorySub.BuildChildren = function(self)
               for i = 1, #SkuCore.SortByValues  do
                  SkuOptions:InjectMenuItems(self, {SkuCore.SortByValues[i]}, SkuGenericMenuItem)
               end   
            end

         end

         --categories
         for categoryIndex, categoryInfo in ipairs(AuctionCategories) do
            if categoryInfo.name ~= L["Quest Items"] and categoryInfo.name ~= L["WoW Token (China Only)"] then
               tNewMenuEntryCategory = SkuOptions:InjectMenuItems(self, {categoryInfo.name}, SkuGenericMenuItem)
               tNewMenuEntryCategory.dynamic = true
               tNewMenuEntryCategory.filterable = true
               tNewMenuEntryCategory.OnEnter = function(self, aValue, aName, aEnterFlag)
                  if not aValue then
                     SkuCore:AuctionStartQuery(categoryIndex, nil, nil, true)
                  end
               end
               tNewMenuEntryCategory.BuildChildren = function(self)
                  if categoryInfo.subCategories then
                     for subCategoryIndex, subCategoryInfo in ipairs(categoryInfo.subCategories) do
                        tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {subCategoryInfo.name}, SkuGenericMenuItem)
                        tNewMenuEntryCategorySub.dynamic = true
                        tNewMenuEntryCategorySub.filterable = true
                        tNewMenuEntryCategorySub.OnEnter = function(self, aValue, aName, aEnterFlag)
                           if not aValue then
                              SkuCore:AuctionStartQuery(categoryIndex, subCategoryIndex, nil, true)
                           end
                        end
                        tNewMenuEntryCategorySub.BuildChildren = function(self)
                           if subCategoryInfo.subCategories then
                              for subSubCategoryIndex, subSubCategoryInfo in ipairs(subCategoryInfo.subCategories) do
                                 tNewMenuEntryCategorySubSub = SkuOptions:InjectMenuItems(self, {subSubCategoryInfo.name}, SkuGenericMenuItem)
                                 tNewMenuEntryCategorySubSub.dynamic = true
                                 tNewMenuEntryCategorySubSub.filterable = true
                                 tNewMenuEntryCategorySubSub.OnEnter = function(self, aValue, aName, aEnterFlag)
                                    if not aValue then
                                       SkuCore:AuctionStartQuery(categoryIndex, subCategoryIndex, subSubCategoryIndex, true)
                                    end
                                 end
                                 tNewMenuEntryCategorySubSub.BuildChildren = function(self)
                                    -- query categoryIndex subCategoryIndex
                                    SkuCore:AuctionListItemMenuBuilder(self)
                                 end
                              end
                           else
                              -- query categoryIndex subCategoryIndex
                              SkuCore:AuctionListItemMenuBuilder(self)
                           end
                        end
                     end
                  else
                     --query categoryIndex
                     SkuCore:AuctionListItemMenuBuilder(self)
                  end
               end
            end
         end
      end
   end

   --bids
   tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {L["Gebote"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      if #SkuCore.BidDB > 0 then
         for tIndex, tData in pairs(SkuCore.BidDB) do
            if tData then
               tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuCore:AuctionItemNameFormat(tData, tIndex)}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
               tNewMenuEntry.textFull = select(2, SkuCore:AuctionBuildItemTooltip(tData, tIndex, true, true))
            end
         end
      else
         tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end

   --sells
   tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {L["Verkäufe"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true

   tNewMenuEntry.BuildChildren = function(self)
      if SkuCore.AuctionIsFullScanning == true then
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Nicht möglich, volle Abfrage läuft"]}, SkuGenericMenuItem)
         return
      end

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Neue Auktion"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.BuildChildren = function(self)
         --we need this query to stop all running scans, as PostAuction will fail otherwise
         SkuCore:AuctionScanQueueReset()
        
         local tCountItems = {}
         for tbag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
            for tslot = 1, GetContainerNumSlots(tbag) do
               local _, titemCount, _, _, _, _, _, _, _, titemID = GetContainerItemInfo(tbag, tslot)
               if titemID then
                  if tCountItems[titemID] then
                     tCountItems[titemID] = tCountItems[titemID] + titemCount
                  else
                     tCountItems[titemID] = titemCount
                  end
               end
            end
         end

         local tHasEntries = false
         local tFoundItems = {}
         for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
            for slot = 1, GetContainerNumSlots(bag) do
               --local itemLink = GetContainerItemLink(bag, slot)
               local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bag, slot)
               if icon then
                  isBound = C_Item.IsBound(ItemLocation:CreateFromBagAndSlot(bag, slot))
                  if isBound == false then
                     local tName = C_Item.GetItemName(ItemLocation:CreateFromBagAndSlot(bag, slot))
                     if not tFoundItems[itemID] then
                        tFoundItems[itemID] = true
                        local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {tName.." ("..tCountItems[itemID]..")"}, SkuGenericMenuItem)
                        tNewMenuSubSubEntry.dynamic = true
                        tNewMenuSubSubEntry.filterable = true
                        tNewMenuSubSubEntry.isSelect = true
                        tNewMenuSubSubEntry.itemId = itemID
                        tNewMenuSubSubEntry.amountMax = tCountItems[itemID]

                        local aGossipItemTable = {
                           textFull = select(2, SkuCore:AuctionBuildItemTooltip({[17] = itemID}, nil, true, true)),
                           itemId = itemID,
                           containerFrameName = "ContainerFrame"..bag.."Item"..slot,
                        }
                        tNewMenuSubSubEntry.textFull = aGossipItemTable.textFull
                        if _G["BagnonInventoryFrame1"] then
                           aGossipItemTable.containerFrameName = _G["BagnonInventoryFrame1"].itemGroup.buttons[bag][slot]:GetName()
                        end
                     
                        tNewMenuSubSubEntry.OnAction = function(self, aValue, aName)
                           dprint("sell OnAction", self, aValue, aName, self.selectTarget.name, self.selectTarget.price, self.price)
                           local tAmount = tonumber(self.selectTarget.amount)
                           local tNumAuctions = tonumber(self.selectTarget.numAuctions)
                           local tCopperBuyout = tonumber(self.selectTarget.price)
                           local tCopperStartBid = mfloor(tCopperBuyout / 2)
                           local tDuration
                           if aName == L["Erstellen: 12 Stunden"] then
                              tDuration = 720
                           elseif aName == L["Erstellen: 24 Stunden"] then
                              tDuration = 1440
                           elseif aName == L["Erstellen: 48 Stunden"] then
                              tDuration = 2880
                           end
                     
                           if not tDuration or not tCopperBuyout or not tAmount or not tNumAuctions then
                              return
                           end
                     
                           --post it
                           ClearCursor()
                           _G["AuctionFrameTab3"]:GetScript("OnClick")(_G["AuctionFrameTab3"], "LeftButton") 
                           _G["AuctionsItemButton"]:GetScript("OnDragStart")(_G["AuctionsItemButton"], "LeftButton") 
                           ClearCursor()
                           _G[aGossipItemTable.containerFrameName]:GetScript("OnDragStart")(_G[aGossipItemTable.containerFrameName], "LeftButton") 
                           ClickAuctionSellItemButton() 
                     
                           PostAuction(tCopperStartBid, tCopperBuyout, tDuration, tAmount, tNumAuctions)
                     
                           if tNumAuctions == 1 then
                              SkuOptions.Voice:OutputStringBTtts(L["Auktion erstellt"], false, true, 1, true)
                           else
                              SkuOptions.Voice:OutputStringBTtts(tNumAuctions..L[" Auktionen erstellt"], false, true, 1, true)
                           end

                           GetOwnerAuctionItems()
                     
                           C_Timer.After(0.01, function()
                              SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)      
                           end)
                           C_Timer.After(0.01, function()
                              SkuCore:CheckFrames()
                           end)
                           
                        end
                     
                        tNewMenuSubSubEntry.BuildChildren = function(self)
                           local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {L["Stack Größe"]}, SkuGenericMenuItem)
                           local _, _, _, _, _, _, _, itemStackMaxCount = GetItemInfo(self.itemId) 
                     
                           local tCount = self.amountMax or 1
                           if itemStackMaxCount < tCount then
                              tCount = itemStackMaxCount
                           end
                     
                           for z = 1, tonumber(tCount) do
                              local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {z..L[" ("]..self.amountMax..L[")"]}, SkuGenericMenuItem)
                              tStackMenuEntry.filterable = true
                              tStackMenuEntry.dynamic = true
                              tStackMenuEntry.OnEnter = function(self, aValue, aName)
                                 self.selectTarget.amount = z
                              end
                              SkuCore:AuctionHouseBuildItemSellMenuSub(tStackMenuEntry, aGossipItemTable)
                           end
                        end
                        tHasEntries = true
                     end
                  end
               end
            end
         end
   
         if tHasEntries == false then
            SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, SkuGenericMenuItem)
         end
 
      end

      if #SkuCore.OwnedDB > 0 then
         for tIndex, tData in pairs(SkuCore.OwnedDB) do
            if tData then
               tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuCore:AuctionItemNameFormat(tData, tIndex)}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
               tNewMenuEntry.textFull = select(2, SkuCore:AuctionBuildItemTooltip(tData, tIndex, true, true))
               tNewMenuEntry.ownerID = tIndex
               tNewMenuEntry.BuildChildren = function(self)
                  local tNewSubMenuEntry = SkuOptions:InjectMenuItems(self, {L["Abbrechen"]}, SkuGenericMenuItem)
                  tNewSubMenuEntry.OnAction = function(self, aValue, aName)
                     CancelAuction(self.parent.ownerID)
                     C_Timer.After(0.65, function()
                        SkuOptions.currentMenuPosition.parent:OnSelect()
                        SkuOptions:VocalizeCurrentMenuName()
                     end)
                  end                  
               end

            end
         end
      else
         tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end

   --full auction db
   tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {L["Offline Datenbank"]}, SkuGenericMenuItem)
   tNewMenuEntryCategorySub.dynamic = true
   tNewMenuEntryCategorySub.filterable = true
   tNewMenuEntryCategorySub.BuildChildren = function(self)
      if #SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB > 0 then
         for tIndex, tData in pairs(SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB) do
            if tData then
               tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuCore:AuctionItemNameFormat(tData, tIndex)}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
               tNewMenuEntry.tIndex = tIndex
               tNewMenuEntry.data = tData
               tNewMenuEntry.textFull = function() 
                  return select(2, SkuCore:AuctionBuildItemTooltip(SkuOptions.currentMenuPosition.data, SkuOptions.currentMenuPosition.tIndex, true, true))                  
               end
            end
         end
      else
         tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end
   if SkuCore.AuctionHouseOpen == true then
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Offline Datenbank aktualisieren"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         dprint("Offline Datenbank aktualisieren OnAction", self, aValue, aName, CanSendAuctionQuery())
         local canQuery, canQueryAll = CanSendAuctionQuery()
         if canQueryAll == true then
            SkuCore:AuctionScanQueueAdd({
               ["text"] = "", 
               ["minLevel"] = nil, 
               ["maxLevel"] = nil, 
               ["page"] = nil, 
               ["usable"] = nil, 
               ["rarity"] = nil, 
               ["getAll"] = true, 
               ["exactMatch"] = false, 
               ["filterData"] = nil,
            })
         else  
            print(L["Scan noch nicht möglich"])
            SkuOptions.Voice:OutputStringBTtts(L["Scan noch nicht möglich"], true, true, 1, true)
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionTooltipHook()
   --[[
   print("AuctionTooltipHook", self:GetName())
   self:AddLine("test 1")
   self:AddLine("test 2")
   self:AddLine("test 3")
   ]]
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseOnLogin()
   hooksecurefunc(DEFAULT_CHAT_FRAME, "AddMessage", SkuCore.AuctionChatAddMessageHook)
   hooksecurefunc(UIErrorsFrame, "AddMessage", SkuCore.AuctionChatAddMessageHook)

   GameTooltip:HookScript("OnShow", SkuCore.AuctionTooltipHook)
   _G["SkuScanningTooltip"]:HookScript("OnShow", SkuCore.AuctionTooltipHook)

   SkuOptions.db.factionrealm[MODULE_NAME] = SkuOptions.db.factionrealm[MODULE_NAME] or {}

   SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB = {}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseOnInitialize()
   SkuCore:RegisterEvent("AUCTION_HOUSE_SHOW")
   SkuCore:RegisterEvent("AUCTION_HOUSE_CLOSED")
   SkuCore:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
   SkuCore:RegisterEvent("AUCTION_BIDDER_LIST_UPDATE")
   SkuCore:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
end

---------------------------------------------------------------------------------------------------------------------------------------
local tOldAuctionFrameBrowse_Update
function SkuCore:AUCTION_HOUSE_CLOSED()
   --AuctionFrameBrowse_Update = tOldAuctionFrameBrowse_Update   
   --AuctionFrame:SetScale(1)
--[[
   SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter = {
      ["LevelMin"] = nil,
      ["LevelMax"] = nil,
      ["MinQuality"] = nil,
      ["Usable"] = nil,
      ["SortBy"] = 1,
   }
   ]]
   SkuCore.AuctionHouseOpen = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_HOUSE_SHOW()
   --tOldAuctionFrameBrowse_Update = AuctionFrameBrowse_Update
   --AuctionFrameBrowse_Update = function() end
   --AuctionFrame:SetScale(0.02)

   SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter = {
      ["LevelMin"] = nil,
      ["LevelMax"] = nil,
      ["MinQuality"] = nil,
      ["Usable"] = nil,
      ["SortBy"] = 1,
   }   
   SkuCore.AuctionHouseOpen = true
   SkuOptions:SlashFunc(L["short"]..L[",SkuCore,Auktionshaus"])

   local canQuery, canQueryAll = CanSendAuctionQuery()
   if canQueryAll == true then
      SkuCore:AuctionScanQueueAdd({
         ["text"] = "", 
         ["minLevel"] = nil, 
         ["maxLevel"] = nil, 
         ["page"] = nil, 
         ["usable"] = nil, 
         ["rarity"] = nil, 
         ["getAll"] = true, 
         ["exactMatch"] = false, 
         ["filterData"] = nil,
      })
   end   
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuAuctionConfirmOkScript(...)
end
local function SkuAuctionConfirmEscScript(...)
end

function SkuCore:ConfirmButtonShow(aText, aOkScript, aEscScript)
	if not SkuAuctionConfirm then
		local f = CreateFrame("Frame", "SkuAuctionConfirm", UIParent, "DialogBoxFrame")
		f:SetPoint("CENTER")
		f:SetSize(50, 50)

		f:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
			edgeSize = 16,
			insets = { left = 8, right = 6, top = 8, bottom = 8 },
		})
		f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue

		-- Movable
		f:SetMovable(true)
		f:SetClampedToScreen(true)
		f:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				self:StartMoving()
			end
		end)
		f:SetScript("OnMouseUp", f.StopMovingOrSizing)

		-- ScrollFrame
		local sf = CreateFrame("ScrollFrame", "SkuAuctionConfirmScrollFrame", SkuAuctionConfirm, "UIPanelScrollFrameTemplate")
		sf:SetPoint("LEFT", 16, 0)
		sf:SetPoint("RIGHT", -32, 0)
		sf:SetPoint("TOP", 0, -16)
		sf:SetPoint("BOTTOM", SkuAuctionConfirmButton, "TOP", 0, 0)

		-- EditBox
		local eb = CreateFrame("EditBox", "SkuAuctionConfirmEditBox", SkuAuctionConfirmScrollFrame)
		eb:SetSize(sf:GetSize())
		--eb:SetMultiLine(true)
		eb:SetAutoFocus(false) -- dont automatically focus
		eb:SetFontObject("ChatFontNormal")
		eb:SetScript("OnEscapePressed", function() 
			PlaySound(89)
			f:Hide()
		end)
		eb:SetScript("OnTextSet", function(self)
			self:HighlightText()
		end)

		sf:SetScrollChild(eb)

		-- Resizable
		f:SetResizable(true)
		f:SetMinResize(150, 100)

		local rb = CreateFrame("Button", "SkuAuctionConfirmResizeButton", SkuAuctionConfirm)
		rb:SetPoint("BOTTOMRIGHT", -6, 7)
		rb:SetSize(16, 16)

		rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
		rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
		rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

		rb:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				f:StartSizing("BOTTOMRIGHT")
				self:GetHighlightTexture():Hide() -- more noticeable
			end
		end)
		rb:SetScript("OnMouseUp", function(self, button)
			f:StopMovingOrSizing()
			self:GetHighlightTexture():Show()
			eb:SetWidth(sf:GetWidth())
		end)

		SkuAuctionConfirmEditBox:HookScript("OnEnterPressed", function(...) SkuAuctionConfirmOkScript(...) SkuAuctionConfirm:Hide() end)
		SkuAuctionConfirmEditBox:HookScript("OnEscapePressed", function(...) SkuAuctionConfirmEscScript(...) SkuAuctionConfirm:Hide() end)
		SkuAuctionConfirmButton:HookScript("OnClick", SkuAuctionConfirmOkScript)

		f:Show()
	end

	SkuAuctionConfirmEditBox:Hide()
	SkuAuctionConfirmEditBox:SetText("")
	if aText then
		SkuAuctionConfirmEditBox:SetText(aText)
		SkuAuctionConfirmEditBox:HighlightText()
	end
	SkuAuctionConfirmEditBox:Show()
	if aOkScript then
		SkuAuctionConfirmOkScript = aOkScript
	end
	if aEscScript then
		SkuAuctionConfirmEscScript = aEscScript
	end

	SkuAuctionConfirm:Show()

	SkuAuctionConfirmEditBox:SetFocus()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionUpdateAuctionDBHistory(aFromAuctionDB, aFromCurrentDB, aCustomTargetTable, aItemID)
   --print("AuctionUpdateAuctionDBHistory", aFromAuctionDB, aFromCurrentDB, aCustomTargetTable)
   if not aFromAuctionDB and not aFromCurrentDB then
      return
   end

   local tTargetTable = aCustomTargetTable or SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory

   local tSaveTime = mfloor(GetServerTime() / tDelayFactorForAddingAuctionsToHistory)
   local tServerTime = GetServerTime()

   local tSourceData
   if aFromAuctionDB then
      tSourceData = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB
   elseif aFromCurrentDB then
      if not SkuOptions.db.factionrealm[MODULE_NAME] then
         return
      end
      tSourceData = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB--SkuCore.CurrentDB
   else
      return
   end

   if not tSourceData then
      return
   end

   for tIndex, tData in pairs(tSourceData) do
      if tData then
         local tItemId = tData[tAIDIndex["itemId"]]
         if (aItemID and aItemID == tItemId) or not aItemID then
            --we need the numbers for one item; min 1 copper
            local tMinBid = 0
            if tData[tAIDIndex["minBid"]] > 0 then
               tMinBid = mfloor(tData[tAIDIndex["minBid"]] / tData[tAIDIndex["count"]])
               if tMinBid == 0 then tMinBid = 1 end
            end
            local tBuyoutPrice = 0
            if tData[tAIDIndex["buyoutPrice"]] > 0 then
               tBuyoutPrice = mfloor(tData[tAIDIndex["buyoutPrice"]] / tData[tAIDIndex["count"]])
               if tBuyoutPrice == 0 then tBuyoutPrice = 1 end
            end

            if not tTargetTable[tItemId] then
               tTargetTable[tItemId] = {
                  bids = {},
                  buyouts = {},
               }
            end

            --minbid
            if tBuyoutPrice == 0 or tMinBid < tBuyoutPrice then
               if not tTargetTable[tItemId].bids[tMinBid] then
                  tTargetTable[tItemId].bids[tMinBid] = {}
               end
               if tTargetTable[tItemId].bids[tMinBid][tServerTime] then
                  tTargetTable[tItemId].bids[tMinBid][tServerTime] = tTargetTable[tItemId].bids[tMinBid][tServerTime] + 1
               else
                  local tNew = true
                  for i, v in pairs(tTargetTable[tItemId].bids[tMinBid]) do
                     if tSaveTime == mfloor(i / tDelayFactorForAddingAuctionsToHistory) then
                        tNew = false
                     end
                  end
                  if tNew == true then
                     tTargetTable[tItemId].bids[tMinBid][tServerTime] = 1
                     --[[
                     if #tTargetTable[tItemId].bids[tMinBid] > tHistoryDataMaxiumAmount then
                        local tRemoveAmount = tHistoryDataMaxiumAmount - #tTargetTable[tItemId].bids[tMinBid]
                        for z = 1, tRemoveAmount do
                           table.remove(tTargetTable[tItemId].bids[tMinBid], 1)
                        end
                     end
                     ]]
                  end

               end
            end
            --buyout
            if tBuyoutPrice > 0 then
               if not tTargetTable[tItemId].buyouts[tBuyoutPrice] then
                  tTargetTable[tItemId].buyouts[tBuyoutPrice] = {}
               end

               if tTargetTable[tItemId].buyouts[tBuyoutPrice][tServerTime] then
                  tTargetTable[tItemId].buyouts[tBuyoutPrice][tServerTime] = tTargetTable[tItemId].buyouts[tBuyoutPrice][tServerTime] + 1
               else
                  local tNew = true
                  for i, v in pairs(tTargetTable[tItemId].buyouts[tBuyoutPrice]) do
                     if tSaveTime == mfloor(i / tDelayFactorForAddingAuctionsToHistory) then
                        tNew = false
                     end
                  end
                  if tNew == true then
                     tTargetTable[tItemId].buyouts[tBuyoutPrice][tServerTime] = 1
                     --[[
                     if #tTargetTable[tItemId].buyouts[tBuyoutPrice] > tHistoryDataMaxiumAmount then
                        local tRemoveAmount = tHistoryDataMaxiumAmount - #tTargetTable[tItemId].buyouts[tBuyoutPrice]
                        for z = 1, tRemoveAmount do
                           table.remove(tTargetTable[tItemId].buyouts[tBuyoutPrice], 1)
                        end
                     end
                     ]]
                  end
               end
            end
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_ITEM_LIST_UPDATE(aEventName, aRet, c)
   dprint("AUCTION_ITEM_LIST_UPDATE", aRet, c)
   dprint("SkuCore.AuctionIsScanning", SkuCore.AuctionIsScanning)
   dprint("aRet", aRet)
   if SkuCore.AuctionIsScanning == false then
      return
   end

   if _G["SkuAuctionConfirm"] then
      if _G["SkuAuctionConfirm"]:IsShown() == true then
         return
      end
   end

   if SkuCore.AuctionIsFullScanning == true then
      --this is a full query
      if not aRet then
         print(L["Full scan started"])
         SkuOptions.Voice:OutputStringBTtts(L["Full scan started"], false, true, 0.2)

         SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB = {}
         local tBatch, tCount = GetNumAuctionItems("list")
         dprint("AuctionIsFullScanning tBatch, tCount", tBatch, tCount)
         if tCount > 0 then
            for x = 1, tCount do
               if SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x] == nil then
                  SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x] = {GetAuctionItemInfo("list", x)}
               end
            end   
         end
      end
  
      SkuCore:AuctionScanQueueRemove()

      AUCTION_ITEM_LIST_UPDATE_timerHandle = C_Timer.NewTimer(0.4, function()
         local tNew
         local tBatch, tCount = GetNumAuctionItems("list")
         dprint("AuctionIsFullScanning timer tBatch, tCount", tBatch, tCount)
         if tCount > 0 then
            for x = 1, tCount do
               SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x] = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x] or {}
               if (SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x][1] or "") == "" then
                  SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB[x] = {GetAuctionItemInfo("list", x)}
                  tNew = true
               end
            end   
         end
   
         if tNew then
            SkuCore:AUCTION_ITEM_LIST_UPDATE("AUCTION_ITEM_LIST_UPDATE", true)
         else
            --SkuOptions.Voice:OutputStringBTtts("Scan abgeschlossen", false, true, 1, true)
            SkuCore.AuctionIsScanning = false
            SkuCore.AuctionIsFullScanning = false
            SkuCore:AuctionScanQueueRemove()
            print(L["Full scan completed"])
            SkuOptions.Voice:OutputStringBTtts(L["Full scan completed"], false, true, 0.2)
            SkuCore:AuctionUpdateAuctionDBHistory(true, nil)
         end
      end)         
   else
      -- this is a bid request
      local tIsConfVis = false
      if _G["SkuAuctionConfirm"] then
         tIsConfVis = _G["SkuAuctionConfirm"]:IsShown()
      end

      if SkuCore.IsBid and tIsConfVis ~= true then

         local tBatch, tCount = GetNumAuctionItems("list")
         local tFound = false
         if tBatch > 0 then
            SkuOptions.Voice:OutputStringBTtts("sound-notification6", false, true)--24

            for x = 1, tBatch do
               local tItem = {GetAuctionItemInfo("list", x)}
               local tEqual = true
               for z = 1, 11 do
                  if tItem[z] ~= SkuCore.IsBid[z] then
                     tEqual = false
                  end
               end
               for z = 16, 18 do
                  if tItem[z] ~= SkuCore.IsBid[z] then
                     tEqual = false
                  end
               end

               if tEqual == true then
                  tFound = true

                  --bid or buy
                  if not SkuCore.IsBid.IsBuyout then
                     --bid
                     local tBidAmount = tonumber(SkuCore.IsBid[8]) + tonumber(SkuCore.IsBid[9])
                     local tItemIndex = x
                     local tItemName = SkuCore.IsBid[1]
                     local tItemCount = SkuCore.IsBid[3]
                     
                     SkuCore:ConfirmButtonShow(L["Gebot "]..(SkuCore.IsBid.currentBids)..L[" von "]..SkuCore.IsBid.NumberOfBidPlacements..": "..tItemName.." "..tItemCount..L[" stück wirklich "]..SkuGetCoinText(tBidAmount, false, true)..L[" bieten? Eingabe Ja, Escape Nein"], 
                        function(self)
                           PlaySound(89)
                           PlaceAuctionBid("list", tItemIndex, tBidAmount)

                           if SkuCore.IsBid.currentBids < SkuCore.IsBid.NumberOfBidPlacements then
                              SkuCore.IsBid.currentBids = SkuCore.IsBid.currentBids + 1
                              SkuCore.AuctionIsScanning = false
                              if SkuCore.IsBid then
                                 SkuCore.IsBid.page = 0
                                 SkuCore:AuctionScanQueueAdd({
                                    ["text"] = SkuCore.IsBid.query.text, 
                                    ["minLevel"] = SkuCore.IsBid.query.minLevel, 
                                    ["maxLevel"] = SkuCore.IsBid.query.maxLevel, 
                                    ["page"] = 0, 
                                    ["usable"] = SkuCore.IsBid.query.usable, 
                                    ["rarity"] = SkuCore.IsBid.query.rarity, 
                                    ["getAll"] = SkuCore.IsBid.query.getAll, 
                                    ["exactMatch"] = SkuCore.IsBid.query.exactMatch, 
                                    ["filterData"] = SkuCore.IsBid.query.filterData,
                                 }, true)
                              else
                                 SkuCore.IsBid = nil
                                 SkuOptions.Voice:OutputStringBTtts(L["Keine weiteren passenden Auktionen verfügbar"], true, true, 0.2, false)
                                 --SkuOptions:VocalizeCurrentMenuName()
                              end
                           else
                              SkuOptions.Voice:OutputStringBTtts(L["Fertig. Alle geboten"], true, true, 0.2, true)
                              SkuCore.IsBid = nil
                              SkuOptions:ClearFilter()
                              --SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                              SkuOptions:VocalizeCurrentMenuName()
                           end
                           C_Timer.After(0.2, function()
                              if SkuCore.AuctionChatMessageFailFlag == true then
                                 SkuCore.AuctionChatMessageFailFlag = false
                                 dprint("fehler Nicht geboten", tItemIndex, tBidAmount)
                                 SkuOptions.Voice:OutputStringBTtts(L["fehler Nicht geboten"], true, true, 0.2, false)
                              end
                              SkuOptions:ClearFilter()
                              SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                              --SkuOptions:VocalizeCurrentMenuName()
                           end)
                        end,
                        function()
                           dprint("abgebrochen Nicht geboten", tItemIndex, tBidAmount)
                           SkuOptions.Voice:OutputStringBTtts(L["abgebrochen Nicht geboten"], true, true, 0.2, false)
                           SkuCore.IsBid = nil
                           SkuOptions:ClearFilter()
                           SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                           --SkuOptions:VocalizeCurrentMenuName()
                        end
                     )
                     PlaySound(88)
                     SkuOptions.Voice:OutputStringBTtts("Gebot "..(SkuCore.IsBid.currentBids)..L[" von "]..SkuCore.IsBid.NumberOfBidPlacements..": "..tItemName.." "..tItemCount.." stück wirklich "..SkuGetCoinText(tBidAmount, false, true).." bieten? Eingabe Ja, Escape Nein", false, true, 0.2, false)
                     return
                  else
                     --buyout
                     --bid
                     local tBidAmount = tonumber(SkuCore.IsBid[10])
                     local tItemIndex = x
                     local tItemName = SkuCore.IsBid[1]
                     local tItemCount = SkuCore.IsBid[3]
                     
                     SkuCore:ConfirmButtonShow(L["Kauf "]..(SkuCore.IsBid.currentBids)..L[" von "]..SkuCore.IsBid.NumberOfBidPlacements..": "..tItemName.." "..tItemCount..L[" stück wirklich für "]..SkuGetCoinText(tBidAmount, false, true)..L[" kaufen? Eingabe Ja, Escape Nein."], 
                        function(self)
                           PlaySound(89)
                           PlaceAuctionBid("list", tItemIndex, tBidAmount)
                           
                           if SkuCore.IsBid.currentBids < SkuCore.IsBid.NumberOfBidPlacements then
                              SkuCore.IsBid.currentBids = SkuCore.IsBid.currentBids + 1
                              SkuCore.AuctionIsScanning = false
                              if SkuCore.IsBid then
                                 SkuCore.IsBid.page = 0
                                 SkuCore:AuctionScanQueueAdd({
                                    ["text"] = SkuCore.IsBid.query.text, 
                                    ["minLevel"] = SkuCore.IsBid.query.minLevel, 
                                    ["maxLevel"] = SkuCore.IsBid.query.maxLevel, 
                                    ["page"] = 0, 
                                    ["usable"] = SkuCore.IsBid.query.usable, 
                                    ["rarity"] = SkuCore.IsBid.query.rarity, 
                                    ["getAll"] = SkuCore.IsBid.query.getAll, 
                                    ["exactMatch"] = SkuCore.IsBid.query.exactMatch, 
                                    ["filterData"] = SkuCore.IsBid.query.filterData,
                                 }, true)
                              else
                                 SkuCore.IsBid = nil
                                 dprint("Keine weiteren passenden Auktionen verfügbar")
                                 SkuOptions.Voice:OutputStringBTtts(L["Keine weiteren passenden Auktionen verfügbar"], true, true, 0.2, true)
                                 --SkuOptions:VocalizeCurrentMenuName()
                              end
                           else
                              SkuOptions.Voice:OutputStringBTtts(L["Fertig. Alle gekauft"], true, true, 0.2, true)
                              SkuOptions:ClearFilter()
                              --SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                              SkuOptions:VocalizeCurrentMenuName()
                              SkuCore.IsBid = nil
                           end

                           C_Timer.After(0.2, function()
                              if SkuCore.AuctionChatMessageFailFlag == true then
                                 SkuCore.AuctionChatMessageFailFlag = false
                                 dprint("fehler Nicht geboten", tItemIndex, tBidAmount)
                                 SkuOptions.Voice:OutputStringBTtts(L["fehler Nicht geboten"], true, true, 0.2, true)
                              end
                              SkuOptions:ClearFilter()
                              SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                              --SkuOptions:VocalizeCurrentMenuName()
                           end)
                        end,
                        function()
                           dprint("abgebrochen Nicht geboten", tItemIndex, tBidAmount)
                           SkuOptions.Voice:OutputStringBTtts(L["abgebrochen Nicht geboten"], true, true, 0.2, true)
                           SkuCore.IsBid = nil
                           SkuOptions:ClearFilter()
                           SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                           --SkuOptions:VocalizeCurrentMenuName()
                        end
                     )
                     PlaySound(88)
                     SkuOptions.Voice:OutputStringBTtts(L["Kauf "]..(SkuCore.IsBid.currentBids)..L[" von "]..SkuCore.IsBid.NumberOfBidPlacements..": "..tItemName.." "..tItemCount..L[" stück wirklich für "]..SkuGetCoinText(tBidAmount, false, true)..L[" kaufen? Eingabe Ja, Escape Nein."], false, true, 0.2, false)
                     return
                  end
               end
            end

            if tFound == false then
               SkuCore.IsBid.page = SkuCore.IsBid.page + 1
               SkuCore.AuctionIsScanning = false
               if SkuCore.IsBid then
                  SkuCore:AuctionScanQueueAdd({
                     ["text"] = tData.query.text, 
                     ["minLevel"] = tData.query.minLevel, 
                     ["maxLevel"] = tData.query.maxLevel, 
                     ["page"] = SkuCore.IsBid.page, 
                     ["usable"] = tData.query.usable, 
                     ["rarity"] = tData.query.rarity, 
                     ["getAll"] = tData.query.getAll, 
                     ["exactMatch"] = tData.query.exactMatch, 
                     ["filterData"] = tData.query.filterData,
                  }, true)               
               end
            end
         else
            SkuCore.IsBid = nil
            dprint("Keine passenden Auktionen verfügbar", true, true, 1, true)
            SkuOptions.Voice:OutputStringBTtts(L["Keine passenden Auktionen verfügbar"], true, true, 0.2, true)
            SkuOptions:ClearFilter()
            SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
            SkuOptions:VocalizeCurrentMenuName()            
         end







      else
         --this is just a usual query
         if SkuOptions.currentMenuPosition.name == L["Warten"] then
            SkuOptions.Voice:OutputStringBTtts("sound-notification6", false, false)--24
         end

         local tBatch, tCount = GetNumAuctionItems("list")
         if tPage == 0 then
            SkuCore.CurrentDB = {}
         end

         if tCount > 0 then
            for x = 1, tBatch do
               if SkuCore.CurrentDB[x + (tPage * 50)] == nil then
                  SkuCore.CurrentDB[x + (tPage * 50)] = {GetAuctionItemInfo("list", x)}
                  SkuCore.CurrentDB[x + (tPage * 50)].page = tPage
                  SkuCore.CurrentDB[x + (tPage * 50)].query = tCurrentQuery
               end
            end   
         end

         if (tPage * 50 + tBatch < tCount) and tCurrentQuery then
            --AUCTION_ITEM_LIST_UPDATE_timerHandle = C_Timer.After(0.1, function()
               -- if (tPage * 50 + tBatch < tCount) and tCurrentQuery then
                  SkuCore:AuctionScanQueueRemove()
                  tPage = tPage + 1
                  SkuCore:AuctionScanQueueAdd({
                     ["text"] = tCurrentQuery.text, 
                     ["minLevel"] = tCurrentQuery.minLevel, 
                     ["maxLevel"] = tCurrentQuery.maxLevel, 
                     ["page"] = tPage, 
                     ["usable"] = tCurrentQuery.usable, 
                     ["rarity"] = tCurrentQuery.rarity, 
                     ["getAll"] = tCurrentQuery.getAll, 
                     ["exactMatch"] = tCurrentQuery.exactMatch, 
                     ["filterData"] = tCurrentQuery.filterData,
                  })
                  SkuCore.AuctionIsScanning = false
               --end
            --end)
         else
            SkuCore.AuctionIsScanning = false
            SkuCore:AuctionScanQueueRemove()
            tCurrentQuery = nil
            tPage = 0
            dprint("limited Auktionen scan abgeschlossen", false, true, 1, true)
            SkuCore:AuctionUpdateAuctionDBHistory(false, true)
         end
      end
   end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_BIDDER_LIST_UPDATE(aEventName, aRed)
   dprint("AUCTION_BIDDER_LIST_UPDATE")

   if not aRed then
      SkuCore.BidDB= {}
   end

   local _, tCount = GetNumAuctionItems("bidder");
   for x = 1, tCount do
      if SkuCore.BidDB[x] == nil then
         SkuCore.BidDB[x] = {GetAuctionItemInfo("bidder", x)}
      end
   end

   AUCTION_BIDDER_LIST_UPDATE_timerHandle = C_Timer.NewTimer(0.4, function()
      local tNew
      local _, tCount = GetNumAuctionItems("bidder")
      dprint("tCount", tCount)
      if tCount > 0 then
         for x = 1, tCount do
            SkuCore.BidDB[x] = SkuCore.BidDB[x] or {}
            if (SkuCore.BidDB[x][1] or "") == "" then
               dprint(x, "empty")
               SkuCore.BidDB[x] = {GetAuctionItemInfo("bidder", x)}
               tNew = true
            end
         end   
      end

      if tNew then
         SkuCore:AUCTION_BIDDER_LIST_UPDATE("AUCTION_BIDDER_LIST_UPDATE", true)
      else
         --SkuOptions.Voice:OutputStringBTtts("Gebote Scan abgeschlossen", false, true, 1, true)
         dprint("Gebote Scan abgeschlossen")
      end
   end)

end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_OWNED_LIST_UPDATE(aEventName, aRed)
   dprint("AUCTION_OWNED_LIST_UPDATE")

   if not aRed then
      SkuCore.OwnedDB= {}
   end

   local _, tCount = GetNumAuctionItems("owner");
   for x = 1, tCount do
      if SkuCore.OwnedDB[x] == nil then
         SkuCore.OwnedDB[x] = {GetAuctionItemInfo("owner", x)}
      end
   end

   AUCTION_OWNED_LIST_UPDATE_timerHandle = C_Timer.NewTimer(0.4, function()
      local tNew
      local _, tCount = GetNumAuctionItems("owner")
      dprint("tCount", tCount)
      if tCount > 0 then
         for x = 1, tCount do
            SkuCore.OwnedDB[x] = SkuCore.OwnedDB[x] or {}
            if (SkuCore.OwnedDB[x][1] or "") == "" then
               dprint(x, "empty")
               SkuCore.OwnedDB[x] = {GetAuctionItemInfo("owner", x)}
               tNew = true
            end
         end   
      end

      if tNew then
         SkuCore:AUCTION_OWNED_LIST_UPDATE("AUCTION_OWNED_LIST_UPDATE", true)
      else
         --SkuOptions.Voice:OutputStringBTtts("Eigene Scan abgeschlossen", false, true, 1, true)
         dprint("Eigene Scan abgeschlossen")
      end
   end)
end


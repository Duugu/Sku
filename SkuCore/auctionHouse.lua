---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "AuctionHouse"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.OwnedDB = {}
SkuCore.BidDB = {}
SkuCore.CurrentDB = {}
SkuCore.ScanQueue = {}
SkuCore.AuctionHouseOpen = false
SkuCore.AuctionIsScanning = false
SkuCore.AuctionIsFullScanning = false
SkuCore.AuctionCurrentFilter = {
   ["LevelMin"] = nil,
   ["LevelMax"] = nil,
   ["MinQuality"] = nil,
   ["Usable"] = nil,
}

local AUCTION_ITEM_LIST_UPDATE_timerHandle
local AUCTION_BIDDER_LIST_UPDATE_timerHandle
local AUCTION_OWNED_LIST_UPDATE_timerHandle

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

local function TooltipLines_helper(...)
	local rText = ""
   for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				rText = rText..text.."\r\n"
			end
		end
	end
	return rText
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionItemHelper(aItemData)


end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseGetBestBuyoutPriceCopper(aItemID)


   return 1300
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
   print("AuctionScanQueueAdd", aScanData, aResetQueue)
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
      print("scan added to queue")
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
         print("scan added to queue")
      else
         print("scan already exists in queue")
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
      print("AuctionScanQueueTicker, new scan")
      if SkuCore.ScanQueue[1].getAll == true then
         SkuCore.AuctionIsFullScanning = true
      end
      SkuCore.AuctionIsScanning = true
      --[[
      print("-------------start scan from queue") 
      print("text", SkuCore.ScanQueue[1].text) 
      print("minLevel", SkuCore.ScanQueue[1].minLevel) 
      print("maxLevel", SkuCore.ScanQueue[1].maxLevel)
      print("page", SkuCore.ScanQueue[1].page) 
      print("usable", SkuCore.ScanQueue[1].usable) 
      print("rarity", SkuCore.ScanQueue[1].rarity) 
      print("getAll", SkuCore.ScanQueue[1].getAll)
      print("exactMatch", SkuCore.ScanQueue[1].exactMatch)
      print("filterData", SkuCore.ScanQueue[1].filterData)
      ]]
      tCurrentQuery = SkuCore.ScanQueue[1]

      QueryAuctionItems(SkuCore.ScanQueue[1].text, SkuCore.ScanQueue[1].minLevel, SkuCore.ScanQueue[1].maxLevel, SkuCore.ScanQueue[1].page, SkuCore.ScanQueue[1].usable, SkuCore.ScanQueue[1].rarity, SkuCore.ScanQueue[1].getAll, SkuCore.ScanQueue[1].exactMatch, SkuCore.ScanQueue[1].filterData)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
do
   local tTime = 0
   local tFrame = CreateFrame("Button", "SkuCoreSecureTabButton", _G["UIParent"], "SecureActionButtonTemplate")
   tFrame:SetSize(1, 1)
   tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
   tFrame:Show()
   tFrame:SetScript("OnUpdate", function(self, time)
      tTime = tTime + time
      if tTime < 0.5 then return end
      if SkuCore.AuctionScanQueueTicker then
         SkuCore:AuctionScanQueueTicker()
      end
      tTime = 0
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseBuildItemSellMenu(aParent, aGossipItemTable)
   --print("aGossipItemTable.containerFrameName", aGossipItemTable.containerFrameName, "--"..aGossipItemTable.textFull.."-")

   if SkuCore.AuctionHouseOpen ~= true then
      return
   end

   if aGossipItemTable.textFull == "" then
      return
   end

   local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParent, {"Verkaufen"}, SkuGenericMenuItem)
   tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.dynamic = true
   tNewMenuParentEntry.isSelect = true
   tNewMenuParentEntry.GetCurrentValue = function(self, aValue, aName)
      local tBestBuyoutCopper = SkuCore:AuctionHouseGetBestBuyoutPriceCopper(tItemID)



      --print(math.floor(tBestBuyoutCopper).."#Silber")
      --return math.floor(tBestBuyoutCopper / 100).."#Silber"
      return "Sofortkauf Preis"
   end

   tNewMenuParentEntry.OnAction = function(self, aValue, aName)
      print("Verkaufen OnAction", self, aValue, aName, self.selectTarget.name, self.selectTarget.price)
      local tAmount = tonumber(self.selectTarget.amount)
      local tCopperBuyout = tonumber(self.selectTarget.price)
      local tCopperStartBid = math.floor(tCopperBuyout / 2)
      local tDuration
      if aName == "Erstellen: 12 Stunden" then
         tDuration = 720
      elseif aName == "Erstellen: 24 Stunden" then
         tDuration = 1440
      elseif aName == "Erstellen: 48 Stunden" then
         tDuration = 2880
      end
               
      if not tDuration or not tCopperBuyout or not tAmount then
         return
      end

      _G["AuctionFrameTab3"]:GetScript("OnClick")(_G["AuctionFrameTab3"], "LeftButton") 
      _G["AuctionsItemButton"]:GetScript("OnDragStart")(_G["AuctionsItemButton"], "LeftButton") 
      ClearCursor()
      _G[aGossipItemTable.containerFrameName]:GetScript("OnDragStart")(_G[aGossipItemTable.containerFrameName], "LeftButton") 
      ClickAuctionSellItemButton()

      PostAuction(tCopperStartBid, tCopperBuyout, tDuration, tAmount)

      SkuOptions.Voice:OutputString("Auktion erstellt", false, true, 1, true)

      SkuCore:CheckFrames()
   end

	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Sofortkauf Preis"}, SkuGenericMenuItem)

      for x = 1, 99 do
		   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {x.."#Silber"}, SkuGenericMenuItem)
         tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
            return (tonumber(aGossipItemTable.stackSize) or 1).." von "..(tonumber(aGossipItemTable.stackSize) or 1)
         end         
         tNewMenuEntry.dynamic = true
         tNewMenuEntry.OnEnter = function(self, aValue, aName)
            self.selectTarget.price = x * 100
         end
         tNewMenuEntry.BuildChildren = function(self)
            local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {"Anzahl"}, SkuGenericMenuItem)
            for z = 1, tonumber(aGossipItemTable.stackSize or 1) do
               local tStackMenuEntry = SkuOptions:InjectMenuItems(self, {z.." von "..(aGossipItemTable.stackSize or 1)}, SkuGenericMenuItem)
               tStackMenuEntry.dynamic = true
               tStackMenuEntry.OnEnter = function(self, aValue, aName)
                  self.selectTarget.amount = z
               end
               tStackMenuEntry.BuildChildren = function(self)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {"Erstellen: 12 Stunden"}, SkuGenericMenuItem)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {"Erstellen: 24 Stunden"}, SkuGenericMenuItem)
                  local tSubMenuEntry = SkuOptions:InjectMenuItems(self, {"Erstellen: 48 Stunden"}, SkuGenericMenuItem)
               end
            end
         end
      end
      for x = 1, 250 do
		   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {x.."#Gold"}, SkuGenericMenuItem)
      end
      for x = 300, 650, 50 do
		   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {x.."#Gold"}, SkuGenericMenuItem)
      end
      for x = 700, 1400, 100 do
		   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {x.."#Gold"}, SkuGenericMenuItem)
      end
      for x = 1500, 5000, 500 do
		   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {x.."#Gold"}, SkuGenericMenuItem)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionStartQuery(aCategoryIndex, aSubCategoryIndex, aSubSubCategoryIndex, aResetQueue, aMaxPage)
   local text = ""
   local minLevel = SkuCore.AuctionCurrentFilter.LevelMin
   local maxLevel = SkuCore.AuctionCurrentFilter.LevelMax
   local categoryIndex = aCategoryIndex
   local subCategoryIndex = aSubCategoryIndex
   local subSubCategoryIndex = aSubSubCategoryIndex
   local page = 0
   local usable = SkuCore.AuctionCurrentFilter.Usable
   local rarity = SkuCore.AuctionCurrentFilter.MinQuality
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
function SkuCore:AuctionHouseMenuBuilderItem(aParent)
   for tIndex, tData in pairs(SkuCore.CurrentDB) do
      --print("BUILD CHILD", tIndex, tData, tData[1])
      if tData then
         if tData[1] then
            --print(tIndex, "tData.query.page", tData.query.page, "tData.page", tData.page)


            local tTextFirstLine, tTextFull = "", ""
            _G["SkuScanningTooltip"]:ClearLines()
            local hsd, rc = _G["SkuScanningTooltip"]:SetItemByID(tData[17])
            if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
               if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
                  local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
                  tTextFirstLine, tTextFull = ItemName_helper(tText)
               end
            end

            if tData[12] == true then
               tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(aParent, {tIndex.." "..tData[1].." m "..tData[8].." mi "..tData[9].." b "..tData[10].." ba "..tData[11].." hb "..tostring(tData[12]).." höchstbieter"}, SkuGenericMenuItem)
               tNewMenuEntryCategorySubSubItem.dynamic = true
               tNewMenuEntryCategorySubSubItem.textFull = tTextFull

            else
               tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(aParent, {tIndex.." "..tData[1].." m "..tData[8].." mi "..tData[9].." b "..tData[10].." ba "..tData[11].." hb "..tostring(tData[12])}, SkuGenericMenuItem)
               tNewMenuEntryCategorySubSubItem.dynamic = true
               tNewMenuEntryCategorySubSubItem.textFull = tTextFull

               tNewMenuEntryCategorySubSubItem.BuildChildren = function(self)
                  tNewMenuEntryCOption = SkuOptions:InjectMenuItems(self, {"Bieten"}, SkuGenericMenuItem)
                  tNewMenuEntryCOption.OnAction = function(self, aValue, aName)
                     print("Bieten OnAction", self, aValue, aName)

                     print("tIndex", tIndex)
                     print("itemname", tData[1])
                     print("item page", tData.page)
                     print("query.page", tData.query.page)
                     print("tData+++")
                     setmetatable(tData, SkuPrintMTWo)
                     print(tData)
                     print("tData---")

                     SkuCore.AuctionIsScanning = false
                     SkuCore.IsBid = tData
                     SkuCore:AuctionScanQueueAdd({
                        ["text"] = tData.query.text, 
                        ["minLevel"] = tData.query.minLevel, 
                        ["maxLevel"] = tData.query.maxLevel, 
                        ["page"] = tData.page, 
                        ["usable"] = tData.query.usable, 
                        ["rarity"] = tData.query.rarity, 
                        ["getAll"] = tData.query.getAll, 
                        ["exactMatch"] = tData.query.exactMatch, 
                        ["filterData"] = tData.query.filterData,
                     }, true)

                  end
         
                  tNewMenuEntryCOption = SkuOptions:InjectMenuItems(self, {"Kaufen"}, SkuGenericMenuItem)
                  tNewMenuEntryCOption.OnAction = function(self, aValue, aName)
                     print("Kaufen OnAction", self, aValue, aName)

                     print("tIndex", tIndex)
                     print("itemname", tData[1])
                     print("item page", tData.page)
                     print("query.page", tData.query.page)
                     print("tData+++")
                     setmetatable(tData, SkuPrintMTWo)
                     print(tData)
                     print("tData---")

                     SkuCore.AuctionIsScanning = false
                     SkuCore.IsBid = tData
                     SkuCore.IsBid.IsBuyout = true
                     SkuCore:AuctionScanQueueAdd({
                        ["text"] = tData.query.text, 
                        ["minLevel"] = tData.query.minLevel, 
                        ["maxLevel"] = tData.query.maxLevel, 
                        ["page"] = tData.page, 
                        ["usable"] = tData.query.usable, 
                        ["rarity"] = tData.query.rarity, 
                        ["getAll"] = tData.query.getAll, 
                        ["exactMatch"] = tData.query.exactMatch, 
                        ["filterData"] = tData.query.filterData,
                     }, true)

                  end
               end
            end



         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseMenuBuilder()
   if AuctionCategories and SkuCore.AuctionHouseOpen == true then
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Auktionen"}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)
         tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {"Filter"}, SkuGenericMenuItem)
         tNewMenuEntryCategorySub.dynamic = true
         tNewMenuEntryCategorySub.BuildChildren = function(self)
            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {"Alle zurücksetzen"}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = false
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               print("Level Min OnAction", self, aValue, aName)
               SkuCore.AuctionCurrentFilter = {
                  ["LevelMin"] = nil,
                  ["LevelMax"] = nil,
                  ["MinQuality"] = nil,
                  ["Usable"] = nil,
               }
            end

            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {"Level Minimum"}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = true
            tNewMenuEntryFilterOption.filterable = true
            tNewMenuEntryFilterOption.isSelect = true
            tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
               return SkuCore.AuctionCurrentFilter.LevelMin or 1
            end
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               print("Level Min OnAction", self, aValue, aName)
               SkuCore.AuctionCurrentFilter.LevelMin = tonumber(aName)
            end
            tNewMenuEntryFilterOption.BuildChildren = function(self)
               for x = 1, 70 do
                  SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
               end
            end

            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {"Level Max"}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = true
            tNewMenuEntryFilterOption.filterable = true
            tNewMenuEntryFilterOption.isSelect = true
            tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
               return SkuCore.AuctionCurrentFilter.LevelMax or 70
            end
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               print("Level Max OnAction", self, aValue, aName)
               SkuCore.AuctionCurrentFilter.LevelMax = tonumber(aName)
            end
            tNewMenuEntryFilterOption.BuildChildren = function(self)
               for x = 1, 70 do
                  SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
               end
            end

            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {"Qualität"}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = true
            tNewMenuEntryFilterOption.filterable = true
            tNewMenuEntryFilterOption.isSelect = true
            tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
               if SkuCore.AuctionCurrentFilter.MinQuality then
                  return _G["ITEM_QUALITY"..SkuCore.AuctionCurrentFilter.MinQuality.."_DESC"]
               else
                  return _G["ITEM_QUALITY0_DESC"]
               end
            end
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               print("Qualität OnAction", self, aValue, aName)
               for i=0, getn(ITEM_QUALITY_COLORS)-4  do
                  if _G["ITEM_QUALITY"..i.."_DESC"] == aName then
                     SkuCore.AuctionCurrentFilter.MinQuality = i
                  end
               end   
            end
            tNewMenuEntryFilterOption.BuildChildren = function(self)
               for i=0, getn(ITEM_QUALITY_COLORS)-4  do
                  SkuOptions:InjectMenuItems(self, {_G["ITEM_QUALITY"..i.."_DESC"]}, SkuGenericMenuItem)
               end   
            end

            tNewMenuEntryFilterOption = SkuOptions:InjectMenuItems(self, {"Nur benutzbare"}, SkuGenericMenuItem)
            tNewMenuEntryFilterOption.dynamic = true
            tNewMenuEntryFilterOption.filterable = true
            tNewMenuEntryFilterOption.isSelect = true
            tNewMenuEntryFilterOption.GetCurrentValue = function(self, aValue, aName)
               if SkuCore.AuctionCurrentFilter.Usable == true then
                  return "Ein"
               else
                  return "Aus"
               end
            end
            tNewMenuEntryFilterOption.OnAction = function(self, aValue, aName)
               print("Ein OnAction", self, aValue, aName)
               if aName == "Ein" then 
                  SkuCore.AuctionCurrentFilter.Usable = true
               else
                  SkuCore.AuctionCurrentFilter.Usable = false
               end
            end
            tNewMenuEntryFilterOption.BuildChildren = function(self)
               SkuOptions:InjectMenuItems(self, {"Ein"}, SkuGenericMenuItem)
               SkuOptions:InjectMenuItems(self, {"Aus"}, SkuGenericMenuItem)
            end
         end    

         --categories
         for categoryIndex, categoryInfo in ipairs(AuctionCategories) do
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
                                 if #SkuCore.ScanQueue > 0 or SkuCore.AuctionIsScanning == true or tPage > 0 then
                                    tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(self, {"Warten auf Abfrage"}, SkuGenericMenuItem)
                                    tNewMenuEntryCategorySubSubItem.dynamic = false
                                    local tTable = SkuOptions.currentMenuPosition
                                    tBread = SkuOptions.currentMenuPosition.name
                                    while tTable.parent.name do
                                       tTable = tTable.parent
                                       tBread = tTable.name..","..tBread
                                    end
                                    tNewMenuEntryCategorySubSubItemWaitTickerHandle = C_Timer.NewTicker(0, function(self)
                                       if #SkuCore.ScanQueue == 0 and SkuCore.AuctionIsScanning == false then
                                          self:Cancel()
                                          if SkuOptions.currentMenuPosition.name == "Warten auf Abfrage" then
                                             SkuOptions:SlashFunc("short,"..tBread)
                                          end
                                       end
                                    end)
                                    tNewMenuEntryCategorySubSubItem.OnLeave = function(self, value, aValue)
                                       if tNewMenuEntryCategorySubSubItemWaitTickerHandle then
                                          tNewMenuEntryCategorySubSubItemWaitTickerHandle:Cancel()
                                       end
                                    end
                                 else
                                    if #SkuCore.CurrentDB > 0 and SkuCore.AuctionIsScanning == false then
                                       SkuCore:AuctionHouseMenuBuilderItem(self)
                                    else
                                       tNewMenuEntryCategorySubSubItem  = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
                                       tNewMenuEntryCategorySubSubItem.dynamic = false
                                    end
                                 end
                              end
                           end
                        else
                           -- query categoryIndex subCategoryIndex
                           if #SkuCore.ScanQueue > 0 or SkuCore.AuctionIsScanning == true  or tPage > 0 then
                              tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(self, {"Warten auf Abfrage"}, SkuGenericMenuItem)
                              tNewMenuEntryCategorySubItem.dynamic = false
                              local tTable = SkuOptions.currentMenuPosition
                              tBread = SkuOptions.currentMenuPosition.name
                              while tTable.parent.name do
                                 tTable = tTable.parent
                                 tBread = tTable.name..","..tBread
                              end
                              ttNewMenuEntryCategorySubItemWaitTickerHandle = C_Timer.NewTicker(0, function(self)
                                 if #SkuCore.ScanQueue == 0 and SkuCore.AuctionIsScanning == false then
                                    self:Cancel()
                                    if SkuOptions.currentMenuPosition.name == "Warten auf Abfrage" then
                                       SkuOptions:SlashFunc("short,"..tBread)
                                    end
                                 end
                              end)
                              tNewMenuEntryCategorySubItem.OnLeave = function(self, value, aValue)
                                 if ttNewMenuEntryCategorySubItemWaitTickerHandle then
                                    ttNewMenuEntryCategorySubItemWaitTickerHandle:Cancel()
                                 end
                              end
                           else
                              if #SkuCore.CurrentDB > 0 and SkuCore.AuctionIsScanning == false then
                                 SkuCore:AuctionHouseMenuBuilderItem(self)
                              else
                                 tNewMenuEntryCategorySubItem  = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
                                 tNewMenuEntryCategorySubItem.dynamic = false
                              end
                           end

                        end
                     end
                  end
               else
                  --query categoryIndex
                  if #SkuCore.ScanQueue > 0 or SkuCore.AuctionIsScanning == true  or tPage > 0 then
                     tNewMenuEntryCategoryItem = SkuOptions:InjectMenuItems(self, {"Warten auf Abfrage"}, SkuGenericMenuItem)
                     tNewMenuEntryCategoryItem.dynamic = false
                     local tTable = SkuOptions.currentMenuPosition
                     tBread = SkuOptions.currentMenuPosition.name
                     while tTable.parent.name do
                        tTable = tTable.parent
                        tBread = tTable.name..","..tBread
                     end
                     tNewMenuEntryCategoryItemWaitTickerHandle = C_Timer.NewTicker(0, function(self)
                        if #SkuCore.ScanQueue == 0 and SkuCore.AuctionIsScanning == false then
                           self:Cancel()
                           if SkuOptions.currentMenuPosition.name == "Warten auf Abfrage" then
                              SkuOptions:SlashFunc("short,"..tBread)
                           end
                        end
                     end)
                     tNewMenuEntryCategoryItem.OnLeave = function(self, value, aValue)
                        if tNewMenuEntryCategoryItemWaitTickerHandle then
                           tNewMenuEntryCategoryItemWaitTickerHandle:Cancel()
                        end
                        SkuCore:AuctionScanQueueReset()       
                     end
                  else
                     if #SkuCore.CurrentDB > 0 and SkuCore.AuctionIsScanning == false then
                        SkuCore:AuctionHouseMenuBuilderItem(self)
                     else
                        tNewMenuEntryCategoryItem  = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
                        tNewMenuEntryCategoryItem.dynamic = false
                     end
                  end
               end
            end
         end
      end
   end

   --bids
   tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {"Gebote"}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      if #SkuCore.BidDB > 0 then
         for tIndex, tData in pairs(SkuCore.BidDB) do
            if tData then
               tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {tIndex.." "..tData[1]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
            end
         end
      else
         tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end

   --sells
   tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {"Verkäufe"}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      if #SkuCore.OwnedDB > 0 then
         for tIndex, tData in pairs(SkuCore.OwnedDB) do
            if tData then
               tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {tIndex.." "..tData[1]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
            end
         end
      else
         tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end

   --full auction db
   tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {"Offline Datenbank"}, SkuGenericMenuItem)
   tNewMenuEntryCategorySub.dynamic = true
   tNewMenuEntryCategorySub.filterable = true
   tNewMenuEntryCategorySub.BuildChildren = function(self)
      if #SkuOptions.db.char[MODULE_NAME].AuctionDB > 0 then
         for tIndex, tData in pairs(SkuOptions.db.char[MODULE_NAME].AuctionDB) do
            if tData then
               tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tIndex.." "..tData[1]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = false
               tNewMenuEntry.filterable = true
            end
         end
      else
         tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = false
      end
   end  
   if SkuCore.AuctionHouseOpen == true then
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Offline Datenbank aktualisieren"}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         print("Offline Datenbank aktualisieren OnAction", self, aValue, aName, CanSendAuctionQuery())
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
            print("Scan noch nicht möglich")
         end
      end
   end


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
   AuctionFrameBrowse_Update = tOldAuctionFrameBrowse_Update   
   AuctionFrame:SetScale(1)
   SkuCore.AuctionCurrentFilter = {
      ["LevelMin"] = nil,
      ["LevelMax"] = nil,
      ["MinQuality"] = nil,
      ["Usable"] = nil,
   }   
   SkuCore.AuctionHouseOpen = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_HOUSE_SHOW()
   dprint("((((((((((((((((((((((((AUCTION_HOUSE_SHOW))))))))))))))))))))))")
   tOldAuctionFrameBrowse_Update = AuctionFrameBrowse_Update
   AuctionFrameBrowse_Update = function() end
   AuctionFrame:SetScale(0.02)
   SkuCore.AuctionCurrentFilter = {
      ["LevelMin"] = nil,
      ["LevelMax"] = nil,
      ["MinQuality"] = nil,
      ["Usable"] = nil,
   }   
   SkuCore.AuctionHouseOpen = true
   SkuOptions:SlashFunc(L["short"]..",SkuCore,Auktionshaus")

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
function SkuCore:ConfirmButtonShow(aText, aOkScript)
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
		SkuAuctionConfirmEditBox:HookScript("OnEscapePressed", function(...) SkuAuctionConfirm:Hide() end)
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

	SkuAuctionConfirm:Show()

	SkuAuctionConfirmEditBox:SetFocus()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_ITEM_LIST_UPDATE(aEventName, aRet, c)
   --dprint("((((((((((((((((((((((((AUCTION_ITEM_LIST_UPDATE))))))))))))))))))))))", aEventName, aRet, c)
   --dprint("SkuCore.AuctionIsScanning", SkuCore.AuctionIsScanning)
   --dprint("aRet", aRet)
   if SkuCore.AuctionIsScanning == false then
      return
   end

   if SkuCore.AuctionIsFullScanning == true then
      --this is a full query
      if not aRet then
         SkuOptions.db.char[MODULE_NAME].AuctionDB = {}
         local tBatch, tCount = GetNumAuctionItems("list")
         dprint("AuctionIsFullScanning tBatch, tCount", tBatch, tCount)
         if tCount > 0 then
            for x = 1, tCount do
               if SkuOptions.db.char[MODULE_NAME].AuctionDB[x] == nil then
                  SkuOptions.db.char[MODULE_NAME].AuctionDB[x] = {GetAuctionItemInfo("list", x)}
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
               SkuOptions.db.char[MODULE_NAME].AuctionDB[x] = SkuOptions.db.char[MODULE_NAME].AuctionDB[x] or {}
               if (SkuOptions.db.char[MODULE_NAME].AuctionDB[x][1] or "") == "" then
                  --dprint(x, "empty")
                  SkuOptions.db.char[MODULE_NAME].AuctionDB[x] = {GetAuctionItemInfo("list", x)}
                  tNew = true
               end
            end   
         end
   
         if tNew then
            SkuCore:AUCTION_ITEM_LIST_UPDATE("AUCTION_ITEM_LIST_UPDATE", true)
         else
            --SkuOptions.Voice:OutputString("Scan abgeschlossen", false, true, 1, true)
            SkuCore.AuctionIsScanning = false
            SkuCore.AuctionIsFullScanning = false
            SkuCore:AuctionScanQueueRemove()
            dprint("full scan completed")
            --SkuOptions:SlashFunc(L["short"]..",SkuCore,Auktionshaus")
         end
      end)         
   else
      if SkuCore.IsBid then
         -- this is a bid request; do query for page again to check an place bid
         local tBatch, tCount = GetNumAuctionItems("list")
         if tPage == 0 then
            SkuCore.CurrentDB = {}
         end
         if tCount > 0 then
            for x = 1, tBatch do
               if SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)] == nil then
                  SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)] = {GetAuctionItemInfo("list", x)}

                  local tEqual = true
                  for z = 1, 18 do
                     if SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][z] ~= SkuCore.IsBid[z] then
                        tEqual = false
                     end
                  end

                  if tEqual == true then
                     --print("bid successfull", true, true, 1, true)
                     --SkuOptions.Voice:OutputString("Gebot erfolgreich", true, true, 1, true)
                     print(x, x + (SkuCore.IsBid.page * 50), SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][1], SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][1])
                     print("bid am", tonumber(SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][8]))

                     if not SkuCore.IsBid.IsBuyout then
                        --bid
                        local tBidAmount = tonumber(SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][8]) + tonumber(SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][9])
                        local tItemIndex = x
                        local tItemName = SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][1]
                        SkuCore:ConfirmButtonShow("Für "..tItemName.." wirklich "..tBidAmount.." bieten? Ja Eingabe, nein Escape.", function(self)
                           PlaySound(89)
                           PlaceAuctionBid("list", tItemIndex, tBidAmount)
                           print("geboten", tItemIndex, tBidAmount)
                           SkuOptions.Voice:OutputString("Geboten", false, true, 0.2)
                           SkuCore.IsBid = nil
                           SkuOptions:ClearFilter()
                           SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                           SkuOptions:VocalizeCurrentMenuName()
                        end)
                        PlaySound(88)
                        SkuOptions.Voice:OutputString("Für "..tItemName.." wirklich "..tBidAmount.." bieten? Ja Eingabe, nein Escape.", false, true, 0.2)
                        return
                     else
                        --bid
                        local tBidAmount = tonumber(SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][10])
                        local tItemIndex = x
                        local tItemName = SkuCore.CurrentDB[x + (SkuCore.IsBid.page * 50)][1]
                        SkuCore:ConfirmButtonShow(""..tItemName.." wirklich für "..tBidAmount.." kaufen? Ja Eingabe, nein Escape.", function(self)
                           PlaySound(89)
                           PlaceAuctionBid("list", tItemIndex, tBidAmount)
                           print("Gekauft", tItemIndex, tBidAmount)
                           SkuOptions.Voice:OutputString("Gekauft", false, true, 0.2)
                           SkuCore.IsBid = nil
                           SkuOptions:ClearFilter()
                           SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
                           SkuOptions:VocalizeCurrentMenuName()
                        end)
                        PlaySound(88)
                        SkuOptions.Voice:OutputString(""..tItemName.." wirklich für "..tBidAmount.." kaufen? Ja Eingabe, nein Escape", false, true, 0.2)
                        return

                     end
                  end

               end
            end   
         end
         SkuCore.IsBid = nil
         print("not found", true, true, 1, true)
         SkuOptions.Voice:OutputString("nicht gefunden", true, true, 1, true)
         SkuOptions:ClearFilter()
         SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
         SkuOptions:VocalizeCurrentMenuName()                     

      else
         --this is just a usual query
         if SkuOptions.currentMenuPosition.name == "Warten auf Abfrage" then
            SkuOptions.Voice:OutputString("sound-notification3", true, false, 1, false)
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
            AUCTION_ITEM_LIST_UPDATE_timerHandle = C_Timer.NewTimer(0.4, function()
               print("AUCTION_ITEM_LIST_UPDATE_timerHandle TICK", tPage)--, tCurrentQuery.page)

               SkuCore:AuctionScanQueueRemove()
               SkuCore.AuctionIsScanning = false
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
            end)
         else
            SkuCore.AuctionIsScanning = false
            SkuCore:AuctionScanQueueRemove()
            tCurrentQuery = nil
            tPage = 0
            print("limited Auktionen scan abgeschlossen", false, true, 1, true)
         end
      end
   end

end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_BIDDER_LIST_UPDATE(aEventName, aRed)
   dprint("((((((((((((((((((((((((AUCTION_BIDDER_LIST_UPDATE))))))))))))))))))))))")

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
         --SkuOptions.Voice:OutputString("Gebote Scan abgeschlossen", false, true, 1, true)
         print("Gebote Scan abgeschlossen")
      end
   end)

end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_OWNED_LIST_UPDATE(aEventName, aRed)
   dprint("((((((((((((((((((((((((AUCTION_OWNED_LIST_UPDATE))))))))))))))))))))))")

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
         --SkuOptions.Voice:OutputString("Eigene Scan abgeschlossen", false, true, 1, true)
         print("Eigene Scan abgeschlossen")
      end
   end)
end


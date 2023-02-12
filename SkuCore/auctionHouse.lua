---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "AuctionHouse"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local mfloor = math.floor

local tFilterInventoryTypeToGetItemInventoryTypeByID = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5,
	[6] = 6,
	[7] = 7,
	[8] = 8,
	[9] = 9,
	[10] = 10,
	[11] = 11,
	[12] = 12,
	[14] = 23,
	[16] = 16,
	[19] = 19,
	[20] = 5,
	[21] = 16,
	[22] = 16,
	[23] = 23,
}

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

local tAIDIndex = {
   ["name"] = 1, --string
   ["texture"] = 2, --number
   ["count"] = 3, --number
   ["quality"] = 4, --number; Enum.ItemQuality
   ["canUse"] = 5, --bool
   ["level"] = 6, --number
   ["levelColHeader"] = 7, -- string --"REQ_LEVEL_ABBR" - level represents the required character level --"SKILL_ABBR" - level represents the required skill level (for recipes) --"ITEM_LEVEL_ABBR" - level represents the item level --"SLOT_ABBR" - level represents the number of slots (for containers)
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
   ["query"] = 19, --bool
}

local tSortByValues = {
   [1] = L["Kaufpreis für 1 Gegenstand aufsteigend"],
   [2] = L["Kaufpreis für Auktionsmenge aufsteigend"],
   [3] = L["Gebotspreis für 1 Gegenstand aufsteigend"],
   [4] = L["Gebotspreis für Auktionsmenge aufsteigend"],
   [5] = L["Level absteigend"],
   [6] = L["Level aufsteigend"],
}

SkuCore.AuctionTickerWait = 0.03
SkuCore.AuctionTickerWaitFull = 1.00
SkuCore.QueryCurrentType = ""
SkuCore.QueryCurrentPage = nil
SkuCore.QueryMaxPage = nil
SkuCore.QueryData = {}
SkuCore.QueryRunning = false
SkuCore.QueryCallback = nil
SkuCore.QueryBuyData = nil
SkuCore.QueryBuyType = nil
SkuCore.QueryBuyAmount = nil
SkuCore.QueryBuyBought = nil

 QueryResultsDB = {}
 FullScanResultsDB = {}
 FullScanResultsDBHistory = {}
local BidDB = {}
local OwnDB = {}
 AuctionDBHistory = {}

local HistoryMaxValues = 500

local OnEnterAllFlag = nil

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseOnInitialize()
   SkuCore:RegisterEvent("AUCTION_HOUSE_SHOW")
   SkuCore:RegisterEvent("AUCTION_HOUSE_CLOSED")
   SkuCore:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
   SkuCore:RegisterEvent("AUCTION_BIDDER_LIST_UPDATE")
   SkuCore:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")

   local tTime = 0
   local tFrame = CreateFrame("Button", "SkuCoreSecureTabButtonAuctions", _G["UIParent"], "SecureActionButtonTemplate")
   tFrame:SetSize(1, 1)
   tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
   tFrame:Show()
   tFrame:SetScript("OnUpdate", function(self, time)
      if SkuCore.AuctionHouseOpen == false then
         return
      end
      tTime = tTime + time
      if SkuCore.QueryRunning == true or SkuCore.QuerySerializeRunning == true then
         if SkuCore.QueryData[tQAIindex.getAll] == true or SkuCore.QuerySerializeRunning == true then
            if tTime < SkuCore.AuctionTickerWaitFull then return end

            SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, true)--24
            tTime = 0
         else
            if tTime < SkuCore.AuctionTickerWait then return end

            local t = CanSendAuctionQuery()
            if t == true then
               SkuCore:AuctionHouseStartQuery(true)
               if SkuOptions.currentMenuPosition.name == L["Warten"] then
                  SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, true)--24
               end
            end
            tTime = 0
         end
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseOnPLAYER_LEAVING_WORLD()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseOnLogin()
   SkuOptions.db.factionrealm[MODULE_NAME] = SkuOptions.db.factionrealm[MODULE_NAME] or {}
   if (SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory and type(SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory) == "string") and SkuOptions.db.factionrealm[MODULE_NAME].First31_13Load == true then
      SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory or ""--{}
   else
      SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory = ""
   end
   AuctionDBHistory = SkuStringToTable(SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory) or {}

   SkuOptions.db.factionrealm[MODULE_NAME].First31_13Load = true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_HOUSE_CLOSED()
   SkuCore:AuctionHouseResetQuery()
   SkuCore.AuctionHouseOpen = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_HOUSE_SHOW()
   SkuOptions.db.char[MODULE_NAME].AuctionLastFullScanTime = SkuOptions.db.char[MODULE_NAME].AuctionLastFullScanTime or 0
   SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter = {
      ["LevelMin"] = nil,
      ["LevelMax"] = nil,
      ["MinQuality"] = nil,
      ["Usable"] = nil,
      ["SortBy"] = 1,
   }   

   SkuCore.AuctionHouseOpen = true
   SkuOptions:SlashFunc(L["short"]..L[",SkuCore,Auktionshaus"])
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuAuctionConfirmOkScript(...) end
local function SkuAuctionConfirmEscScript(...) end
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
      f:SetResizeBounds(150, 100)

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
function SkuCore:AuctionBuildItemTooltip(aItemData, aIndex, aAddCurrentPriceData, aAddHistoryPriceData)
   --print("AuctionBuildItemTooltip",aItemData, aIndex, aAddCurrentPriceData, aAddHistoryPriceData)   
   local tTextFirstLine, tTextFull = "", ""
   _G["SkuScanningTooltip"]:ClearLines()
   local hsd, rc
   if aItemData[21] then
      hsd, rc = _G["SkuScanningTooltip"]:SetHyperlink(aItemData[21])
   else
      hsd, rc = _G["SkuScanningTooltip"]:SetItemByID(aItemData[17])
   end
   
   if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
      if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
         local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
         tTextFirstLine, tTextFull = SkuCore:ItemName_helper(tText)
      end
   end

   local tPriceHistoryData, tBestBuyoutPriceCopper = SkuCore:AuctionHouseGetAuctionPriceHistoryData(aItemData[17])

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
function SkuEpochValueHelper(aValue)
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

   local tNextBid = aItemData[tAIDIndex["bidAmount"]] + aItemData[tAIDIndex["minIncrement"]]
   if tNextBid == 0 then
      tNextBid = aItemData[tAIDIndex["minBid"]]
   end

   if aItemData[tAIDIndex["minBid"]] == aItemData[tAIDIndex["buyoutPrice"]] then
      rName = rName.." §01 §01"..L[" Nur Kauf "]..SkuGetCoinText(aItemData[tAIDIndex["buyoutPrice"]], true, true)..""
   else
      if aItemData[tAIDIndex["buyoutPrice"]] > 0 then
         rName = rName.." §01 §01"..L["Kauf "]..SkuGetCoinText(aItemData[tAIDIndex["buyoutPrice"]], true, true).." §01 §01"..L["Gebot "]..SkuGetCoinText(tNextBid, true, true)..""  
      else 
         rName = rName.." §01 §01"..L["Nur Gebot "]..SkuGetCoinText(tNextBid, true, true).."" 
      end
   end

   if aItemData[12] == true then
      rName = rName..L[" Du bist Höchstbieter"]
   end

   return rName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionGetPricePerItem(aData)
   local tPPIBid, tPPIBuy = aData[8] / aData[3], aData[10] / aData[3]
   return {bid = tPPIBid, buy = tPPIBuy,}
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseMenuBuilder()
   --auctions
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Auktionen"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)

      --filter and sort
      tNewMenuEntryFaS = SkuOptions:InjectMenuItems(self, {L["Filter und Sortierung"]}, SkuGenericMenuItem)
      tNewMenuEntryFaS.dynamic = true
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
               for x = 1, 80 do
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
               for x = 1, 80 do
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
               return tSortByValues[SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy]
            else
               return tSortByValues[1]
            end
         end
         tNewMenuEntryCategorySub.OnAction = function(self, aValue, aName)
            dprint("quality OnAction", self, aValue, aName)
            for i = 1, #tSortByValues  do
               if tSortByValues[i] == aName then
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy = i
               end
            end   
         end
         tNewMenuEntryCategorySub.BuildChildren = function(self)
            for i = 1, #tSortByValues  do
               SkuOptions:InjectMenuItems(self, {tSortByValues[i]}, SkuGenericMenuItem)
            end   
         end

      end
      
      --auctions by item 
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["auctions by item"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      --tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)
         --categories
         SkuCore:AuctionHouseResetQuery()
         for categoryIndex, categoryInfo in ipairs(AuctionCategories) do
            if categoryInfo.name ~= L["WoW Token (China Only)"] then
               tNewMenuEntryCategory = SkuOptions:InjectMenuItems(self, {categoryInfo.name}, SkuGenericMenuItem)
               tNewMenuEntryCategory.dynamic = true
               tNewMenuEntryCategory.filterable = true
               tNewMenuEntryCategory.OnEnter = function(self, aValue, aName, aEnterFlag)
                  if not aValue then
                     --SkuCore:AuctionStartQuery(categoryIndex, nil, nil, true)
                  end
               end
               tNewMenuEntryCategory.BuildChildren = function(self)
                  OnEnterAllFlag = nil
                  SkuCore:AuctionHouseResetQuery()
                  if categoryInfo.subCategories then
                     for subCategoryIndex, subCategoryInfo in ipairs(categoryInfo.subCategories) do
                        tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {subCategoryInfo.name}, SkuGenericMenuItem)
                        tNewMenuEntryCategorySub.dynamic = true
                        tNewMenuEntryCategorySub.filterable = true
                        tNewMenuEntryCategorySub.BuildChildren = function(self)
                           OnEnterAllFlag = nil
                           SkuCore:AuctionHouseResetQuery()
                           if subCategoryInfo.subCategories then
                              for subSubCategoryIndex, subSubCategoryInfo in ipairs(subCategoryInfo.subCategories) do
                                 tNewMenuEntryCategorySubSub = SkuOptions:InjectMenuItems(self, {subSubCategoryInfo.name}, SkuGenericMenuItem)
                                 tNewMenuEntryCategorySubSub.dynamic = true
                                 tNewMenuEntryCategorySubSub.filterable = true
                                 tNewMenuEntryCategorySubSub.BuildChildren = function(self)
                                    OnEnterAllFlag = nil
                                    -- query categoryIndex subCategoryIndex
                                    SkuCore:AuctionHouseBuildItemDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)                                         
                                 end
                              end
                           else
                              -- query categoryIndex subCategoryIndex
                              SkuCore:AuctionHouseBuildItemDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)
                           end
                        end
                     end
                  else
                     --query categoryIndex
                     SkuCore:AuctionHouseBuildItemDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)
                  end
               end
            end
         end
      end

      --auctions by search string 
      tNewMenuEntrysearch = SkuOptions:InjectMenuItems(self, {L["auctions by seach string"]}, SkuGenericMenuItem)
      tNewMenuEntrysearch.dynamic = true
      tNewMenuEntrysearch.isSelect = true
      tNewMenuEntrysearch.OnAction = function(self, aValue, aName)
         SkuOptions:EditBoxShow(
            "",
            function(self)
               local tText = SkuOptionsEditBoxEditBox:GetText()
               print(L["searching for "]..(tText or ""))

               SkuCore:AuctionHouseStartQuery(
                  nil, 
                  "AUCTION_ITEM_LIST_UPDATE", 
                  tText, 
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                  0, 
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                  SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                  false, 
                  false, 
                  nil,
                  function()
                     SkuCore:AuctionHouseResetQuery()
                     C_Timer.After(0.01, function()
                        if SkuOptions.currentMenuPosition.name == L["Warten"] or SkuOptions.currentMenuPosition.name == L["enter search string"] then
                           SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                        else
                           SkuOptions.currentMenuPosition:BuildChildren(SkuOptions.currentMenuPosition)
                        end
                     end)
                  end            
               )
            end,
            nil
         )
         C_Timer.After(0.1, function()
            SkuOptions.Voice:OutputStringBTtts(L["enter search string now"], true, true, 0.1, nil, nil, nil, 1)
         end)
      end
      tNewMenuEntrysearch.BuildChildren = function(self)
         if SkuCore.QueryRunning == true then
            local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntrysearch, {L["Warten"]}, SkuGenericMenuItem)
            tNewMenuEntry1.dynamic = false
         else
            local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntrysearch, {L["enter search string"]}, SkuGenericMenuItem)
            tNewMenuEntry1.dynamic = false
            SkuCore:AuctionHouseResultsMenuBuilder(tNewMenuEntrysearch)
         end
      end

      --auctions from full scan 
      tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["auctions from full scan"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.isSelect = true

      tNewMenuEntry.BuildChildren = function(self)
         --categories
         SkuCore:AuctionHouseResetQuery()
         if #FullScanResultsDB == 0 then
            tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
            tNewMenuEntryCategorySubItem.dynamic = false
         else

            for categoryIndex, categoryInfo in ipairs(AuctionCategories) do
               if categoryInfo.name ~= L["WoW Token (China Only)"] then
                  tNewMenuEntryCategory = SkuOptions:InjectMenuItems(self, {categoryInfo.name}, SkuGenericMenuItem)
                  tNewMenuEntryCategory.dynamic = true
                  tNewMenuEntryCategory.filterable = true
                  tNewMenuEntryCategory.OnEnter = function(self, aValue, aName, aEnterFlag)
                     if not aValue then
                     end
                  end
                  tNewMenuEntryCategory.BuildChildren = function(self)
                     SkuCore:AuctionHouseResetQuery()
                     if categoryInfo.subCategories then
                        for subCategoryIndex, subCategoryInfo in ipairs(categoryInfo.subCategories) do
                           tNewMenuEntryCategorySub = SkuOptions:InjectMenuItems(self, {subCategoryInfo.name}, SkuGenericMenuItem)
                           tNewMenuEntryCategorySub.dynamic = true
                           tNewMenuEntryCategorySub.filterable = true
                           tNewMenuEntryCategorySub.BuildChildren = function(self)
                              SkuCore:AuctionHouseResetQuery()
                              if subCategoryInfo.subCategories then
                                 for subSubCategoryIndex, subSubCategoryInfo in ipairs(subCategoryInfo.subCategories) do
                                    tNewMenuEntryCategorySubSub = SkuOptions:InjectMenuItems(self, {subSubCategoryInfo.name}, SkuGenericMenuItem)
                                    tNewMenuEntryCategorySubSub.dynamic = true
                                    tNewMenuEntryCategorySubSub.filterable = true
                                    tNewMenuEntryCategorySubSub.BuildChildren = function(self)
                                       -- query categoryIndex subCategoryIndex
                                       SkuCore:AuctionHouseBuildItemFullScanDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)                                         
                                    end
                                 end
                              else
                                 -- query categoryIndex subCategoryIndex
                                 SkuCore:AuctionHouseBuildItemFullScanDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)
                              end
                           end
                        end
                     else
                        --query categoryIndex
                        SkuCore:AuctionHouseBuildItemFullScanDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)
                     end
                  end
               end
            end
         end
      end
      
      tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {L["start full scan"]}, SkuGenericMenuItem)
      tNewMenuEntry1.dynamic = false
      tNewMenuEntry1.isSelect = true
      tNewMenuEntry1.OnEnter = function(self, aValue, aName, aEnterFlag)
         local _, t = CanSendAuctionQuery()
         if t == false then
            local tRemainingTimeString = (16 - mfloor((GetServerTime() - SkuOptions.db.char[MODULE_NAME].AuctionLastFullScanTime) / 60))..L[" Minuten"]
            SkuOptions.currentMenuPosition.name = L["full scan"].." "..L["Ready in"].." "..tRemainingTimeString
         else
            SkuOptions.currentMenuPosition.name = L["start full scan"]
         end
      end
      tNewMenuEntry1.OnAction = function(self, aValue, aName)
         local canQuery, canQueryAll = CanSendAuctionQuery()
         if canQueryAll == true then
            SkuCore:AuctionHouseStartQuery(
               nil, 
               "AUCTION_ITEM_LIST_UPDATE", 
               "", 
               nil, 
               nil, 
               nil, 
               nil, 
               nil, 
               true, 
               false, 
               nil,
               function()
                  --[[
                  C_Timer.After(0.01, function()
                     
                  end)
                  ]]
               end            
            )
            SkuOptions.db.char[MODULE_NAME].AuctionLastFullScanTime = GetServerTime()
         else
            print(L["full scan not ready yet"])
         end
      end
   end

   --bids
   tNewMenuEntry  = SkuOptions:InjectMenuItems(self, {L["Gebote"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      if #BidDB > 0 then
         for tIndex, tData in pairs(BidDB) do
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
      if SkuCore.QueryRunning == true then
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["not possible, scan in progess"]}, SkuGenericMenuItem)
         return
      end

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Neue Auktion"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.BuildChildren = function(self)
         --we need this query to stop all running scans, as PostAuction will fail otherwise
         SkuCore:AuctionHouseResetQuery()
        
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
               if icon and itemID then
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
                           containerFrameName = "ContainerFrame"..(bag + 1).."Item"..(GetContainerNumSlots(bag) - slot + 1),
                        }
                        
                        tNewMenuSubSubEntry.textFull = aGossipItemTable.textFull
                     
                        tNewMenuSubSubEntry.OnAction = function(self, aValue, aName)
                           local tAmount = tonumber(self.selectTarget.amount)
                           local tNumAuctions = tonumber(self.selectTarget.numAuctions)
                           local tCopperBuyout = tonumber(self.selectTarget.price)
                           local tCopperStartBid = mfloor(tCopperBuyout * 0.9)
                           local tDuration
                           if aName == L["Erstellen: 12 Stunden"] then
                              tDuration = 1
                           elseif aName == L["Erstellen: 24 Stunden"] then
                              tDuration = 2
                           elseif aName == L["Erstellen: 48 Stunden"] then
                              tDuration = 3
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
                              SkuOptions.Voice:OutputStringBTtts(L["Auktion erstellt"], false, true, 0.1, nil, nil, nil, 1)
                           else
                              SkuOptions.Voice:OutputStringBTtts(tNumAuctions..L[" Auktionen erstellt"], false, true, 0.1, nil, nil, nil, 1)
                           end

                           GetOwnerAuctionItems()
                     
                           C_Timer.After(0.01, function()
                              SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)      
                           end)
                           C_Timer.After(0.01, function()
                              SkuCore:CheckFrames(nil, true)
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

      if #OwnDB > 0 then
         for tIndex, tData in pairs(OwnDB) do
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

      local tBestBuyoutCopper = select(2, SkuCore:AuctionHouseGetAuctionPriceHistoryData(tItemId))

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
      while x <= 100000000 do
         if x < 10000 then
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {(x / 100).."#"..L["Silber"]}, SkuGenericMenuItem)
            tNewMenuEntry.copperValue = x
            x = x + 100
         elseif x < 10000000 then
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {(x / 10000).."#"..L["Gold"]}, SkuGenericMenuItem)
            tNewMenuEntry.copperValue = x
            x = x + 10000
         else
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {(x / 10000).."#"..L["Gold"]}, SkuGenericMenuItem)
            tNewMenuEntry.copperValue = x
            x = x + 1000000
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
local tQualityDb = {}
function SkuCore:AuctionHouseBuildItemFullScanDBMenu(aParent, categoryIndex, subCategoryIndex, subSubCategoryIndex)
   --print("AuctionHouseBuildItemFullScanDBMenu", categoryIndex, subCategoryIndex, subSubCategoryIndex)
   local classID, subClassID, inventoryType
   if categoryIndex and subCategoryIndex and subSubCategoryIndex then
      classID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].classID
      subClassID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].subClassID
      inventoryType = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].inventoryType
   elseif categoryIndex and subCategoryIndex then
      classID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].classID
      subClassID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].subClassID
      inventoryType = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].inventoryType
   end

   local filterData
   if categoryIndex and subCategoryIndex and subSubCategoryIndex then
      filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters
   elseif categoryIndex and subCategoryIndex then
      filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters
   elseif categoryIndex then
      filterData = AuctionCategories[categoryIndex].filters
   end

   local tHasEntries = false
   if #FullScanResultsDB == 0 then
      tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(aParent, {L["leer"]}, SkuGenericMenuItem)
      tNewMenuEntryCategorySubItem.dynamic = false
   else
      tCurrentDBClean = {}
      local lmin, lmax, isuse, qmin = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin or 1, SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax or 1000, SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable or false, SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality or 1

      for tIndex, tRecord in pairs(FullScanResultsDB) do
         if tRecord then
            if tRecord[1] then
               if SkuDB.itemDataTBC[tRecord[17]] and
                  (
                     SkuDB.itemDataTBC[tRecord[17]][SkuDB.itemKeys.class] == classID and
                     SkuDB.itemDataTBC[tRecord[17]][SkuDB.itemKeys.subClass] == subClassID and
                     (
                        not inventoryType or (C_Item.GetItemInventoryTypeByID(tRecord[17]) == tFilterInventoryTypeToGetItemInventoryTypeByID[inventoryType])
                     )
                  )
               then
                  if tRecord[4] == -1 or tRecord[4] == nil then
                     if tQualityDb[tRecord[17]] then
                        tRecord[4] = tQualityDb[tRecord[17]]
                     else
                        tRecord[4] = C_Item.GetItemQualityByID(tonumber(tRecord[17]))
                        tQualityDb[tRecord[17]] = tRecord[4]
                     end
                     if tRecord[4] == nil then
                        --print("      still miss ", tRecord[4], C_Item.GetItemQualityByID(tonumber(tRecord[17])))
                     end
                  end

                  if tRecord[6] >= lmin and tRecord[6] <= lmax
                     and (isuse == false or (isuse == true and tRecord[5] == true))
                     and tRecord[4] >= qmin
                  then
                     tHasEntries = true
                     local tName = SkuCore:AuctionItemNameFormat(tRecord)
                     local tFound = false
                     for x = 1, #tCurrentDBClean do
                        if tCurrentDBClean[x].name == tName then
                           tCurrentDBClean[x].dupes[#tCurrentDBClean[x].dupes + 1] = tRecord
                           tFound = true
                        end
                     end
                     if tFound == false then
                        tCurrentDBClean[#tCurrentDBClean + 1] = {}
                        tCurrentDBClean[#tCurrentDBClean].name = tName
                        tCurrentDBClean[#tCurrentDBClean].level = select(4, GetItemInfo(tRecord[17])) or 0
                        tCurrentDBClean[#tCurrentDBClean].pricePerItem = SkuCore:AuctionGetPricePerItem(tRecord)
                        tCurrentDBClean[#tCurrentDBClean].pricePerAuction = {bid = tRecord[8], buy = tRecord[10],}
                        tCurrentDBClean[#tCurrentDBClean].dupes = {}
                        tCurrentDBClean[#tCurrentDBClean].dupes[#tCurrentDBClean[#tCurrentDBClean].dupes + 1] = tRecord
                        tCurrentDBClean[#tCurrentDBClean].query = tRecord.query
                     end
                  end
               end
            end
         end
      end
      
      local tHasEntries = false
      if tHasEntries == false then
         tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(aParent, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntryCategorySubItem.dynamic = false
         return
      end
   
      tCurrentDBCleanSorted = {}
   
      if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 1 or not SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].pricePerItem.buy > t[a].pricePerItem.buy
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level, query = v.query,})
         end
      elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 2 then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].pricePerAuction.buy > t[a].pricePerAuction.buy
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
         end
      elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 3 then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].pricePerItem.bid > t[a].pricePerItem.bid
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level, query = v.query,})
         end      
      elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 4 then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].pricePerAuction.bid > t[a].pricePerAuction.bid
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
         end
   
      elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 5 then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].level < t[a].level
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
         end
      elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 6 then
         for k, v in SkuSpairs(tCurrentDBClean, 
            function(t,a,b) 
               return t[b].level > t[a].level
            end) 
         do 
            table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
         end
      end
   
      for tIndex, tDataTmp in pairs(tCurrentDBCleanSorted) do
         local tData = tDataTmp.dupes[1]
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

                                    SkuCore.QueryBuyData = tData
                                    SkuCore.QueryBuyAmount = x
                                    SkuCore.QueryBuyBought = 0
                                    SkuCore.QueryBuyType = 1

                                    SkuCore:AuctionHouseStartQuery(
                                       nil, 
                                       "AUCTION_ITEM_LIST_UPDATE", 
                                       tData[1], 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                                       0, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                                       false, 
                                       true, 
                                       tData.query.filterData,
                                       function()

                                       end            
                                    )

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
                                    tData.query = self.data
                                    SkuCore.QueryBuyData = tData
                                    SkuCore.QueryBuyAmount = x
                                    SkuCore.QueryBuyBought = 0
                                    SkuCore.QueryBuyType = 2

                                    SkuCore:AuctionHouseStartQuery(
                                       nil, 
                                       "AUCTION_ITEM_LIST_UPDATE", 
                                       tData[1], 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                                       0, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                                       SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                                       false, 
                                       true, 
                                       nil,--tData.query.filterData,
                                       function()

                                       end            
                                    )
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

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseBuildItemDBMenu(self, categoryIndex, subCategoryIndex, subSubCategoryIndex)
   dprint("AuctionHouseBuildItemDBMenu", categoryIndex, subCategoryIndex, subSubCategoryIndex)
   local classID, subClassID, inventoryType
   if categoryIndex and subCategoryIndex and subSubCategoryIndex then
      classID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].classID
      subClassID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].subClassID
      inventoryType = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters[1].inventoryType
   elseif categoryIndex and subCategoryIndex then
      classID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].classID
      subClassID = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].subClassID
      inventoryType = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters[1].inventoryType
   end

   tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(self, {L["All"]}, SkuGenericMenuItem)
   tNewMenuEntryCategorySubSubItem.dynamic = true
   tNewMenuEntryCategorySubSubItem.filterable = true
   tNewMenuEntryCategorySubSubItem.OnEnter = function(self, aValue, aName, aEnterFlag)
      if OnEnterAllFlag == true then
         OnEnterAllFlag = nil
         return
      end
      if not aValue then
         if categoryIndex and subCategoryIndex and subSubCategoryIndex then
            filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters
         elseif categoryIndex and subCategoryIndex then
            filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters
         elseif categoryIndex then
            filterData = AuctionCategories[categoryIndex].filters
         end

         SkuCore:AuctionHouseStartQuery(nil, "AUCTION_ITEM_LIST_UPDATE", 
            "", 
            SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
            SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
            0, 
            SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
            SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
            false, 
            false, 
            filterData,
            function()
               self.BuildChildren(self)
               C_Timer.After(0.01, function()
                  if SkuOptions.currentMenuPosition.name == L["Warten"] then
                     SkuOptions.currentMenuPosition:OnUpdate(self)
                  else
                     SkuOptions.currentMenuPosition:BuildChildren(self)
                  end
               end)
            end            
         )
      end
   end
   tNewMenuEntryCategorySubSubItem.BuildChildren = function(self)
      -- query categoryIndex subCategoryIndex
      SkuCore:AuctionHouseResultsMenuBuilder(self)
   end


   for i, v in pairs(SkuDB.itemDataTBC) do
      if 
         v[SkuDB.itemKeys.class] == classID
         and
         v[SkuDB.itemKeys.subClass] == subClassID
      then
         if not inventoryType or (inventoryType and C_Item.GetItemInventoryTypeByID(i) == tFilterInventoryTypeToGetItemInventoryTypeByID[inventoryType]) then
            local tLocName = v[SkuDB.itemKeys.name]
            if SkuDB.itemLookup[Sku.Loc][i] then
               tLocName = SkuDB.itemLookup[Sku.Loc][i]
            end

            tNewMenuEntryCategorySubSubItem = SkuOptions:InjectMenuItems(self, {tLocName}, SkuGenericMenuItem)
            tNewMenuEntryCategorySubSubItem.dynamic = true
            tNewMenuEntryCategorySubSubItem.filterable = true
            tNewMenuEntryCategorySubSubItem.OnEnter = function(self, aValue, aName, aEnterFlag)
               OnEnterAllFlag = true
               if not aValue then
                  if categoryIndex and subCategoryIndex and subSubCategoryIndex then
                     filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex].filters
                  elseif categoryIndex and subCategoryIndex then
                     filterData = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters
                  elseif categoryIndex then
                     filterData = AuctionCategories[categoryIndex].filters
                  end

                  SkuCore:AuctionHouseStartQuery(nil, "AUCTION_ITEM_LIST_UPDATE", 
                     tLocName, 
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                     0, 
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                     SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                     false, 
                     true, 
                     filterData,
                     function()
                        self.BuildChildren(self)
                        C_Timer.After(0.01, function()
                           if SkuOptions.currentMenuPosition.name == L["Warten"] then
                              SkuOptions.currentMenuPosition:OnUpdate(self)
                           else
                              SkuOptions.currentMenuPosition:BuildChildren(self)
                           end
                        end)
                     end
                  )
               end
            end
            tNewMenuEntryCategorySubSubItem.BuildChildren = function(self)
               -- query categoryIndex subCategoryIndex
               SkuCore:AuctionHouseResultsMenuBuilder(self)
            end
         end
      end
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseResultsMenuBuilder(aParent)
   dprint("AuctionHouseResultsMenuBuilder", aParent.name)
   if SkuCore.QueryRunning == true then
      tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(aParent, {L["Warten"]}, SkuGenericMenuItem)
      tNewMenuEntryCategorySubItem.dynamic = false
      --OnEnterAllFlag = nil
   else
      if #QueryResultsDB == 0 then
         tNewMenuEntryCategorySubItem = SkuOptions:InjectMenuItems(aParent, {L["leer"]}, SkuGenericMenuItem)
         tNewMenuEntryCategorySubItem.dynamic = false
      else
         local tCurrentDBClean = {}
         for tIndex, tRecord in pairs(QueryResultsDB) do
            if tRecord then
               if tRecord[1] then
                  local tName = SkuCore:AuctionItemNameFormat(tRecord)
                  local tFound = false
                  for x = 1, #tCurrentDBClean do
                     if tCurrentDBClean[x].name == tName then
                        tCurrentDBClean[x].dupes[#tCurrentDBClean[x].dupes + 1] = tRecord
                        tFound = true
                     end
                  end
                  if tFound == false then
                     tCurrentDBClean[#tCurrentDBClean + 1] = {}
                     tCurrentDBClean[#tCurrentDBClean].name = tName
                     tCurrentDBClean[#tCurrentDBClean].level = select(4, GetItemInfo(tRecord[17])) or 0
                     tCurrentDBClean[#tCurrentDBClean].pricePerItem = SkuCore:AuctionGetPricePerItem(tRecord)
                     tCurrentDBClean[#tCurrentDBClean].pricePerAuction = {bid = tRecord[8], buy = tRecord[10],}
                     tCurrentDBClean[#tCurrentDBClean].dupes = {}
                     tCurrentDBClean[#tCurrentDBClean].dupes[#tCurrentDBClean[#tCurrentDBClean].dupes + 1] = tRecord
                     tCurrentDBClean[#tCurrentDBClean].query = tRecord.query
                  end
               end
            end
         end
         
         tCurrentDBCleanSorted = {}
      
         if SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 1 or not SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].pricePerItem.buy > t[a].pricePerItem.buy
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level, query = v.query,})
            end
         elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 2 then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].pricePerAuction.buy > t[a].pricePerAuction.buy
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
            end
         elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 3 then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].pricePerItem.bid > t[a].pricePerItem.bid
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerItem = v.pricePerItem, level = v.level, query = v.query,})
            end      
         elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 4 then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].pricePerAuction.bid > t[a].pricePerAuction.bid
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
            end
      
         elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 5 then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].level < t[a].level
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
            end
         elseif SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.SortBy == 6 then
            for k, v in SkuSpairs(tCurrentDBClean, 
               function(t,a,b) 
                  return t[b].level > t[a].level
               end) 
            do 
               table.insert(tCurrentDBCleanSorted, {name = v.name, dupes = v.dupes, pricePerAuction = v.pricePerAuction, level = v.level, query = v.query,})
            end
         end
      
         for tIndex, tDataTmp in pairs(tCurrentDBCleanSorted) do
            local tData = tDataTmp.dupes[1]
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

                                       SkuCore.QueryBuyData = tData
                                       SkuCore.QueryBuyAmount = x
                                       SkuCore.QueryBuyBought = 0
                                       SkuCore.QueryBuyType = 1

                                       SkuCore:AuctionHouseStartQuery(
                                          nil, 
                                          "AUCTION_ITEM_LIST_UPDATE", 
                                          tData[1], 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                                          0, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                                          false, 
                                          true, 
                                          tData.query.filterData,
                                          function()

                                          end            
                                       )
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

                                       SkuCore.QueryBuyData = tData
                                       SkuCore.QueryBuyAmount = x
                                       SkuCore.QueryBuyBought = 0
                                       SkuCore.QueryBuyType = 2

                                       SkuCore:AuctionHouseStartQuery(
                                          nil, 
                                          "AUCTION_ITEM_LIST_UPDATE", 
                                          tData[1], 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                                          0, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                                          SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                                          false, 
                                          true, 
                                          tData.query.filterData,
                                          function()

                                          end            
                                       )
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
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseResetQuery(aForce)
   dprint("AuctionHouseResetQuery")
   if SkuCore.QueryRunning == true and SkuCore.QueryData[7] == true and aForce ~= true then
      return
   end

   SkuCore.QueryRunning = false
   SkuCore.QueryCurrentType = ""
   SkuCore.QueryCurrentPage = nil
   SkuCore.QueryMaxPage = nil
   SkuCore.QueryData = {}
   SkuCore.QueryCallback = nil
   --[[
   SkuCore.QueryBuyData = nil
   SkuCore.QueryBuyType = nil
   SkuCore.QueryBuyAmount = nil
   SkuCore.QueryBuyBought = nil   
   ]]
   --QueryResultsDB = {}

   return true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseStartQuery(aContinue, aType, aFilterText, aFilterMinLevel, aFilterMaxLevel, aFilterPage, aFilterUsable, aFilterRarity, aFilterGetAll, aFilterExactMatch, aFilterFilterData, aCallback)
   if SkuCore.QueryRunning == true and SkuCore.QueryData[7] == true then
      return
   end

   dprint("AuctionHouseStartQuery(aContinue", aContinue)
   
   if CanSendAuctionQuery() ~= true then
      --print("  can't query")
      --SkuCore:AuctionHouseResetQuery()
      --return
   end

   if aContinue ~= true then
      if SkuCore.QueryRunning == true then
         SkuCore:AuctionHouseResetQuery()
      end

      QueryResultsDB = {}

      SkuCore.QueryCurrentType = aType
      SkuCore.QueryCurrentPage = 0
      SkuCore.QueryData = {
         [tQAIindex.text] = aFilterText, 
         [tQAIindex.minLevel] = aFilterMinLevel, 
         [tQAIindex.maxLevel] = aFilterMaxLevel, 
         [tQAIindex.page] = SkuCore.QueryCurrentPage, 
         [tQAIindex.usable] = aFilterUsable, 
         [tQAIindex.rarity] = aFilterRarity, 
         [tQAIindex.getAll] = aFilterGetAll, 
         [tQAIindex.exactMatch] = aFilterExactMatch, 
         [tQAIindex.filterData] = aFilterFilterData,
      }
      SkuCore.QueryCallback = aCallback
   end

   dprint(" QueryAuctionItems", SkuCore.QueryData[tQAIindex.text])
   QueryAuctionItems(
      SkuCore.QueryData[tQAIindex.text], 
      SkuCore.QueryData[tQAIindex.minLevel], 
      SkuCore.QueryData[tQAIindex.maxLevel], 
      SkuCore.QueryData[tQAIindex.page], 
      SkuCore.QueryData[tQAIindex.usable], 
      SkuCore.QueryData[tQAIindex.rarity], 
      SkuCore.QueryData[tQAIindex.getAll], 
      SkuCore.QueryData[tQAIindex.exactMatch], 
      SkuCore.QueryData[tQAIindex.filterData]
   )

   SkuCore.QueryRunning = true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_OWNED_LIST_UPDATE(aEventName)
   dprint("AUCTION_OWNED_LIST_UPDATE", aEventName)
   local tBatch, tCount = GetNumAuctionItems("owner")
   dprint(" tBatch, tCount", tBatch, tCount)

   OwnDB= {}

   local _, tCount = GetNumAuctionItems("owner");
   for x = 1, tCount do
      if OwnDB[x] == nil then
         OwnDB[x] = {GetAuctionItemInfo("owner", x)}
         OwnDB[x][21] = GetAuctionItemLink("owner", x)
      end
   end

   if tCount > 0 then
      for x = 1, tCount do
         OwnDB[x] = OwnDB[x] or {}
         if (OwnDB[x][1] or "") == "" then
            dprint(x, "empty")
            OwnDB[x] = {GetAuctionItemInfo("owner", x)}
            OwnDB[x][21] = GetAuctionItemLink("owner", x)
         end
      end   
   end

   dprint("owned Scan completed")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_BIDDER_LIST_UPDATE(aEventName)
   dprint("AUCTION_BIDDER_LIST_UPDATE", aEventName)
   local tBatch, tCount = GetNumAuctionItems("bidder")
   dprint(" tBatch, tCount", tBatch, tCount)

   BidDB= {}

   local _, tCount = GetNumAuctionItems("bidder");
   for x = 1, tCount do
      if BidDB[x] == nil then
         BidDB[x] = {GetAuctionItemInfo("bidder", x)}
         BidDB[x][21] = GetAuctionItemLink("bidder", x)
      end
   end

   if tCount > 0 then
      for x = 1, tCount do
         BidDB[x] = BidDB[x] or {}
         if (BidDB[x][1] or "") == "" then
            dprint(x, "empty")
            BidDB[x] = {GetAuctionItemInfo("bidder", x)}
            BidDB[x][21] = GetAuctionItemLink("bidder", x)
         end
      end   
   end

   dprint("bidder Scan completed")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_ITEM_LIST_UPDATE(aEventName)
   if SkuCore.QueryRunning == true and SkuCore.QueryCurrentType == "AUCTION_ITEM_LIST_UPDATE" then
      dprint("AUCTION_ITEM_LIST_UPDATE", SkuCore.QueryBuyData)

      if SkuCore.QueryBuyData == nil then
         SkuCore:AUCTION_ITEM_LIST_UPDATE_LIST()
      else
         SkuCore:AUCTION_ITEM_LIST_UPDATE_BUY()
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_ITEM_LIST_UPDATE_LIST()
   local tBatch, tCount = GetNumAuctionItems("list")
   dprint(" tBatch, tCount", tBatch, tCount, SkuCore.QueryData[tQAIindex.getAll])

   if SkuCore.QueryCurrentPage ~= nil then
      if SkuCore.QueryData[tQAIindex.getAll] == true then
         for x = 1, tCount do
            local tNextEntry = #FullScanResultsDB + 1
            FullScanResultsDB[tNextEntry] = {GetAuctionItemInfo("list", x)}
            FullScanResultsDB[tNextEntry][21] = GetAuctionItemLink("list", x)
            if FullScanResultsDB[tNextEntry][6] == nil or FullScanResultsDB[tNextEntry][6] > 10000 then
               if SkuDB.itemDataTBC[FullScanResultsDB[tNextEntry][17]] then
                  FullScanResultsDB[tNextEntry][6]  = SkuDB.itemDataTBC[FullScanResultsDB[tNextEntry][17]][SkuDB.WotLK.itemKeys.requiredLevel]
               end
               if FullScanResultsDB[tNextEntry][6] == nil then
                  FullScanResultsDB[tNextEntry][6] = SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin
               end
            end

            if FullScanResultsDB[tNextEntry][1] == "" then
               if SkuDB.itemLookup[Sku.Loc][FullScanResultsDB[tNextEntry][17]] then
                  FullScanResultsDB[tNextEntry][1] = SkuDB.itemLookup[Sku.Loc][FullScanResultsDB[tNextEntry][17]]
               end
            end
         end
         FullScanResultsDBHistory = {}
         SkuCore:AuctionUpdateAuctionDBHistory(FullScanResultsDB, FullScanResultsDBHistory)
         SkuCore:AuctionUpdateAuctionDBHistory(FullScanResultsDB, AuctionDBHistory)
         SkuCore.QuerySerializeRunning = true
         SkuTableToString(AuctionDBHistory, function(aString)
            SkuCore.QuerySerializeRunning = false
            SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory = aString
            SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, true)--24
            C_Timer.After(1, function()
               for q, w in pairs(FullScanResultsDB) do
                  if w[1] ~= "" and w[4] == -1 then
                     w[4] = C_Item.GetItemQualityByID(w[17])
                  end
               end
               SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, true)--24
               C_Timer.After(1, function()
                  for q, w in pairs(FullScanResultsDB) do
                     if w[1] ~= "" and w[4] == -1 then
                        w[4] = C_Item.GetItemQualityByID(w[17])
                     end
                  end
                  dprint("full query completed", SkuCore.QueryCallback)
                  SkuOptions.Voice:OutputStringBTtts("sound-notification16", false, true)--24
               end)
            end)
         end)

         SkuCore.QueryCallback()
         SkuCore:AuctionHouseResetQuery(true)
      else
         if SkuCore.QueryMaxPage == nil then
            SkuCore.QueryMaxPage = math.floor(tCount / 50)
            if tCount - ((SkuCore.QueryMaxPage + 1) * 50) > 0 then
               SkuCore.QueryMaxPage = SkuCore.QueryMaxPage + 1
            end
            SkuOptions.Voice:OutputStringBTtts(tCount, false, true, 0.2, nil, nil, nil, 2)
         end
   
         --save data
         for x = 1, tBatch do
            local tResult = {GetAuctionItemInfo("list", x)}
            tResult[21] = GetAuctionItemLink("list", x)
            if tResult[14] == nil then
               dprint("incomplete page data")
               return
            end
         end

         for x = 1, tBatch do
            local tNextEntry = #QueryResultsDB + 1
            QueryResultsDB[tNextEntry] = {GetAuctionItemInfo("list", x)}
            QueryResultsDB[tNextEntry][21] = GetAuctionItemLink("list", x)
            QueryResultsDB[tNextEntry].query = SkuCore.QueryData
         end

         dprint(" SkuCore.QueryCurrentPage", SkuCore.QueryCurrentPage)
         dprint(" SkuCore.QueryMaxPage", SkuCore.QueryMaxPage)
         if SkuCore.QueryCurrentPage < SkuCore.QueryMaxPage then
            SkuCore.QueryCurrentPage = SkuCore.QueryCurrentPage + 1
            SkuCore.QueryData[tQAIindex.page] = SkuCore.QueryCurrentPage
            dprint("continue with next page")
         else
            dprint("query completed", SkuCore.QueryCallback)
            if SkuOptions.currentMenuPosition.name == L["Warten"] then
               SkuOptions.Voice:OutputStringBTtts("sound-notification16", false, true)--24
            end
            SkuCore.QueryCallback()
            SkuCore:AuctionHouseResetQuery()
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AUCTION_ITEM_LIST_UPDATE_BUY()
   dprint("AUCTION_ITEM_LIST_UPDATE_BUY")
   local tBatch, tCount = GetNumAuctionItems("list")
   dprint(" tBatch, tCount", tBatch, tCount)

   if SkuCore.QueryMaxPage == nil then
      SkuCore.QueryMaxPage = math.floor(tCount / 50)
      if tCount - ((SkuCore.QueryMaxPage + 1) * 50) > 0 then
         SkuCore.QueryMaxPage = SkuCore.QueryMaxPage + 1
      end
   end

   for x = 1, tBatch do
      local tResult = {GetAuctionItemInfo("list", x)}
      tResult[21] = GetAuctionItemLink("list", x)
      if tResult[14] == nil then
         dprint("tResult[14] == nil return")
         return
      end
   end

   for x = 1, tBatch do
      --check if same item
      local tCurrentResult = {GetAuctionItemInfo("list", x)}
      tCurrentResult[21] = GetAuctionItemLink("list", x)
      local tFound = true
      for y = 1, 17 do
         dprint("COMPARE", x, y, tCurrentResult[y], SkuCore.QueryBuyData[y])
         if tCurrentResult[y] ~= SkuCore.QueryBuyData[y] and y ~= 14 then
            tFound = false
         end
      end
      if tCurrentResult[12] == true then
         tFound = false
      end

      -- found, buy
      if tFound == true then
         dprint("bid for", SkuCore.QueryCurrentPage, x, tCurrentResult[8], tCurrentResult[9])
         SkuCore.QueryRunning = false

         if SkuCore.QueryBuyType == 1 then
            local tItemName = tCurrentResult[1]
            local tItemCount = tCurrentResult[3]
            local tBidAmount = tCurrentResult[8] + tCurrentResult[9]
            C_Timer.After(1, function()
               SkuCore:ConfirmButtonShow(L["Gebot "]..(SkuCore.QueryBuyBought + 1)..L[" von "]..SkuCore.QueryBuyAmount..": "..tItemName.." "..tItemCount..L[" stück wirklich "]..SkuGetCoinText(tBidAmount, false, true)..L[" bieten? Eingabe Ja, Escape Nein"], 
                  function(self)
                     PlaySound(89)
                     PlaceAuctionBid("list", x, tBidAmount)
                     dprint('PlaceAuctionBid("list"', x, tBidAmount)
                     C_Timer.After(1, function()
                        SkuCore.QueryBuyBought = SkuCore.QueryBuyBought + 1
                        if SkuCore.QueryBuyBought < SkuCore.QueryBuyAmount then
                           --bid next
                           local tData = SkuCore.QueryBuyData

                           SkuCore:AuctionHouseStartQuery(
                              nil, 
                              "AUCTION_ITEM_LIST_UPDATE", 
                              SkuCore.QueryBuyData.query[1], 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                              0, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                              false, 
                              true, 
                              SkuCore.QueryBuyData.query[9],
                              function()

                              end            
                           )
                        else
                           --all done
                           SkuCore.QueryBuyData = nil
                           SkuCore.QueryBuyType = nil
                           SkuCore.QueryBuyAmount = nil
                           SkuCore.QueryBuyBought = nil
                           SkuCore:AuctionHouseResetQuery()
                           SkuOptions.currentMenuPosition.parent.parent.parent.parent:OnSelect()
                           C_Timer.After(0.65, function()
                              SkuOptions:VocalizeCurrentMenuName()
                              SkuOptions.Voice:OutputStringBTtts(L["Fertig. Alle gekauft"], false, true, 0.1, nil, nil, nil, 1)
                           end)
      
                        end
                     end)
                  end,
                  function()
                     dprint("abgebrochen Nicht geboten", tItemIndex, tBidAmount)
                     SkuOptions.Voice:OutputStringBTtts(L["abgebrochen Nicht geboten"], true, true, 0.1, nil, nil, nil, 1)
                  end
               )
               PlaySound(88)
               SkuOptions.Voice:OutputStringBTtts(L["Gebot "]..(SkuCore.QueryBuyBought + 1)..L[" von "]..SkuCore.QueryBuyAmount..": "..tItemName.." "..tItemCount..L[" stück wirklich "]..SkuGetCoinText(tBidAmount, false, true)..L[" bieten? Eingabe Ja, Escape Nein"], true, true, 0.1, nil, nil, nil, 1)
            end)
         elseif SkuCore.QueryBuyType == 2 then
            local tItemName = tCurrentResult[1]
            local tItemCount = tCurrentResult[3]
            local tBidAmount = tCurrentResult[10]
            C_Timer.After(1, function()
               SkuCore:ConfirmButtonShow(L["Kauf "]..(SkuCore.QueryBuyBought + 1)..L[" von "]..SkuCore.QueryBuyAmount..": "..tItemName.." "..tItemCount..L[" stück wirklich für "]..SkuGetCoinText(tBidAmount, false, true)..L[" kaufen? Eingabe Ja, Escape Nein."], 
                  function(self)
                     PlaySound(89)
                     PlaceAuctionBid("list", x, tBidAmount)
                     dprint('PlaceAuctionBid("list"', x, tBidAmount)
                     C_Timer.After(1, function()

                        SkuCore.QueryBuyBought = SkuCore.QueryBuyBought + 1
                        if SkuCore.QueryBuyBought < SkuCore.QueryBuyAmount then
                           --buy next
                           local tData = SkuCore.QueryBuyData

                           SkuCore:AuctionHouseStartQuery(
                              nil, 
                              "AUCTION_ITEM_LIST_UPDATE", 
                              SkuCore.QueryBuyData.query[1], 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMin, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.LevelMax, 
                              0, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.Usable, 
                              SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter.MinQuality, 
                              false, 
                              true, 
                              SkuCore.QueryBuyData.query[9],
                              function()

                              end            
                           )
                        else
                           --all bought
                           SkuCore.QueryBuyData = nil
                           SkuCore.QueryBuyType = nil
                           SkuCore.QueryBuyAmount = nil
                           SkuCore.QueryBuyBought = nil
                           SkuCore:AuctionHouseResetQuery()
                           SkuOptions.currentMenuPosition.parent.parent.parent.parent:OnSelect()
                           C_Timer.After(0.65, function()
                              SkuOptions:VocalizeCurrentMenuName()
                              SkuOptions.Voice:OutputStringBTtts(L["Fertig. Alle gekauft"], false, true, 0.1, nil, nil, nil, 1)
                           end)

                        end
                     end)
                  end,
                  function()
                     dprint("abgebrochen Nicht geboten", tItemIndex, tBidAmount)
                     SkuOptions.Voice:OutputStringBTtts(L["abgebrochen Nicht geboten"], true, true, 0.1, nil, nil, nil, 1)
                  end
               )
               PlaySound(88)
               SkuOptions.Voice:OutputStringBTtts(L["Kauf "]..(SkuCore.QueryBuyBought + 1)..L[" von "]..SkuCore.QueryBuyAmount..": "..tItemName.." "..tItemCount..L[" stück wirklich für "]..SkuGetCoinText(tBidAmount, false, true)..L[" kaufen? Eingabe Ja, Escape Nein."], true, true, 0.1, nil, nil, nil, 1)
            end)
         end

         return
      end
   end

   if SkuCore.QueryCurrentPage < SkuCore.QueryMaxPage then
      SkuCore.QueryCurrentPage = SkuCore.QueryCurrentPage + 1
      SkuCore.QueryData[tQAIindex.page] = SkuCore.QueryCurrentPage
      dprint("continue with next page")
   else
      dprint("query completed", SkuCore.QueryCallback)
      if SkuOptions.currentMenuPosition.name == L["Warten"] then
         SkuOptions.Voice:OutputStringBTtts("sound-notification16", false, true)--24
      end
      SkuCore.QueryCallback()
      SkuCore:AuctionHouseResetQuery()
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionUpdateAuctionDBHistory(aSourceDB, aTargetTable)
   --dprint("AuctionUpdateAuctionDBHistory", aSourceDB, aTargetTable)
   if not aSourceDB then
      return
   end

   if not aTargetTable then
      return
   end

   local tPriceData = {}

   for tIndex, tData in pairs(aSourceDB) do
      if tData then
         local tItemId = tData[tAIDIndex["itemId"]]
         if tItemId then
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

            if not tPriceData[tItemId] then
               tPriceData[tItemId] = {
                  [1] = {},
                  [2] = {},
               }
            end

            tPriceData[tItemId][1][#tPriceData[tItemId][1] + 1] = tMinBid
            tPriceData[tItemId][2][#tPriceData[tItemId][2] + 1] = tBuyoutPrice
         end
      end
   end

   for tItemId, tData in pairs(tPriceData) do
      local tBidOldLow, tBidOldMedian, tBidOldHigh, tBidOldPoints
      local tBuyOldLow, tBuyOldMedian, tBuyOldHigh, tBuyOldPoints

      if aTargetTable[tItemId] then
         if aTargetTable[tItemId][1] then
            if aTargetTable[tItemId][1][1] then
               tBidOldLow, tBidOldMedian, tBidOldHigh, tBidOldPoints = aTargetTable[tItemId][1][1], aTargetTable[tItemId][1][2], aTargetTable[tItemId][1][3], aTargetTable[tItemId][1][4]
            end
         else
            aTargetTable[tItemId][1] = {}
         end
         if aTargetTable[tItemId][2] then
            if aTargetTable[tItemId][2][1] then
               tBuyOldLow, tBuyOldMedian, tBuyOldHigh, tBuyOldPoints = aTargetTable[tItemId][2][1], aTargetTable[tItemId][2][2], aTargetTable[tItemId][2][3], aTargetTable[tItemId][2][4]
            end
         else
            aTargetTable[tItemId][2] = {}
         end
      else
         aTargetTable[tItemId] = {
            [1] = {},
            [2] = {},
         }
      end

      local tBidNewLow, tBidNewMedian, tBidNewHigh, tBidNewPoints
      local tBuyNewLow, tBuyNewMedian, tBuyNewHigh, tBuyNewPoints

      if tData[1][1] then
         if tBidOldMedian then
            tBidNewMedian = (Median(tData[1]) + tBidOldMedian) / 2
            tBidNewPoints = #tData[1] + tBidOldPoints
         else
            tBidNewMedian = Median(tData[1])
            tBidNewPoints = #tData[1]
         end
         for _, tPrice in pairs(tData[1]) do
            if tPrice < tBidNewMedian * 10 then
               if not tBidNewLow or (tPrice > 0 and tPrice < tBidNewLow) then
                  tBidNewLow = tPrice
               end
               if not tBidNewHigh or tPrice > tBidNewHigh then
                  tBidNewHigh = tPrice
               end
            end
         end
      end
      if tData[2][1] then
         if tBuyOldMedian then
            tBuyNewMedian = (Median(tData[2]) + tBuyOldMedian) / 2
            tBuyNewPoints = #tData[2] + tBuyOldPoints
         else
            tBuyNewMedian = Median(tData[2])
            tBuyNewPoints = #tData[2]
         end
         for _, tPrice in pairs(tData[2]) do
            if tPrice < tBuyNewMedian * 10 then
               if not tBuyNewLow or (tPrice > 0 and tPrice < tBuyNewLow) then
                  tBuyNewLow = tPrice
               end
               if not tBuyNewHigh or tPrice > tBuyNewHigh then
                  tBuyNewHigh = tPrice
               end
            end
         end
      end
      
      if tBidNewLow or tBuyNewLow then
         aTargetTable[tItemId] = {
            [1] = {},
            [2] = {},
         }
         if tBidNewLow then
            aTargetTable[tItemId][1] = {tBidNewLow, tBidNewMedian, tBidNewHigh, tBidNewPoints}
         end
         if tBuyNewLow then
            aTargetTable[tItemId][2] = {tBuyNewLow, tBuyNewMedian, tBuyNewHigh, tBuyNewPoints}
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AuctionHouseGetAuctionPriceHistoryData(aItemID, aCurrentPriceDataDB, aHistoryPriceDataDB)
   --dprint("AuctionPriceHistoryData")
   if not aItemID then
      return
   end

   aCurrentPriceDataDB = aCurrentPriceDataDB or FullScanResultsDBHistory
   aHistoryPriceDataDB = aHistoryPriceDataDB or AuctionDBHistory

   local tFullTextSections = {}
   local tSuggestedSellPrice
   --[[
   local function Calculate(tSource)


      local tSeenAmount = #tSource
      local tLastSeen
      local tLow
      local tHigh
      local tAverage
      local tCopperSum

      local tMedian = {}
      for _, tCopper in ipairs(tSource) do
         table.insert(tMedian, tCopper)
      end
      tAverage = Median(tMedian)


      for _, tCopper in ipairs(tSource) do
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

      return tSeenAmount, tLastSeen, tLow, tHigh, tAverage
   end
   ]]

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
   local tText = ""
   if not aCurrentPriceDataDB[aItemID] then
      tText = L["Keine aktuellen Preisdaten vorhanden"]
   else
      tText = L["Aktuelle Preisdaten (für ein Stück)"]

      --local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(aCurrentPriceDataDB[aItemID][2])
      local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = aCurrentPriceDataDB[aItemID][2][4], nil, aCurrentPriceDataDB[aItemID][2][1], aCurrentPriceDataDB[aItemID][2][3], aCurrentPriceDataDB[aItemID][2][2]

      if not tBidSeenAmount or not tBidLow then
         tText = tText..L["\r\nKeine Sofortkaufdaten vorhanden"]
      else         
         tText = tText..L["\r\nSofortkaufdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nNiedrigster "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchster "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
         tSuggestedSellPrice = tBidLow
      end

      --local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(aCurrentPriceDataDB[aItemID][1])
      local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = aCurrentPriceDataDB[aItemID][1][4], nil, aCurrentPriceDataDB[aItemID][1][1], aCurrentPriceDataDB[aItemID][1][3], aCurrentPriceDataDB[aItemID][1][2]
      if not tBidSeenAmount or not tBidLow then
         tText = tText..L["\r\nKeine Gebotsdaten vorhanden"]
      else         
         tText = tText..L["\r\nGebotsdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nNiedrigstes "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchstes "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
      end
   end
   table.insert(tFullTextSections, tText)

   --history data
   local tText = ""
   if not aHistoryPriceDataDB[aItemID] then
      tText = L["Keine historischen Preisdaten vorhanden"]
   else
      tText = L["Historische Preisdaten (für ein Stück)"]

      --local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(aHistoryPriceDataDB[aItemID][2])
      local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = aHistoryPriceDataDB[aItemID][2][4], nil, aHistoryPriceDataDB[aItemID][2][1], aHistoryPriceDataDB[aItemID][2][3], aHistoryPriceDataDB[aItemID][2][2]

      if not tBidSeenAmount or not tBidLow then
         tText = tText..L["\r\nKeine Sofortkaufdaten vorhanden"]
      else         
         tText = tText..L["\r\nSofortkaufdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nNiedrigster "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchster "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
         if not tSuggestedSellPrice then
            tSuggestedSellPrice = tBidLow
         end
      end

      --local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = Calculate(aHistoryPriceDataDB[aItemID][1])
      local tBidSeenAmount, tBidLastSeen, tBidLow, tBidHigh, tBidAverage = aHistoryPriceDataDB[aItemID][1][4], nil, aHistoryPriceDataDB[aItemID][1][1], aHistoryPriceDataDB[aItemID][1][3], aHistoryPriceDataDB[aItemID][1][2]
      if not tBidSeenAmount or not tBidLow then
         tText = tText..L["\r\nKeine Gebotsdaten vorhanden"]
      else         
         tText = tText..L["\r\nGebotsdaten: \r\nDatenpunkte "]..(tBidSeenAmount)..L["\r\nNiedrigstes "]..SkuGetCoinText(tBidLow, true, true)..L["\r\nHöchstes "]..SkuGetCoinText(tBidHigh, true, true)..L["\r\nDurchschnitt "]..SkuGetCoinText(tBidAverage, true, true)
      end
   end
   table.insert(tFullTextSections, tText)

   return tFullTextSections, tSuggestedSellPrice
end
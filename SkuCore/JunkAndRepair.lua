local MODULE_NAME, MODULE_PART = "SkuCore", "JunkAndRepair"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local SellJunkFrame

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:JunkAndRepairInitialize()

   if not SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter then
      SkuOptions.db.char[MODULE_NAME].SellJunkCustomItemIds = {}
   end

   -- Declarations
   local IterationCount, totalPrice = 500, 0
   local SellJunkTicker, mBagID, mBagSlot

   -- Create configuration panel
   SellJunkFrame = CreateFrame("Frame", "SkuSellJunkFrame", _G["UIParent"])
   SellJunkFrame:SetSize(1, 1)
   SellJunkFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
   SellJunkFrame:Show()

   -- Function to stop selling
   local function StopSelling()
      if SellJunkTicker then SellJunkTicker:Cancel() end
      SellJunkFrame:UnregisterEvent("ITEM_LOCKED")
      SellJunkFrame:UnregisterEvent("ITEM_UNLOCKED")
   end

   -- Vendor function
   local function SellJunkFunc()
      SkuOptions.db.char["SkuCore"].SellJunkCustomItemIds = SkuOptions.db.char["SkuCore"].SellJunkCustomItemIds or {}
      -- Variables
      local SoldCount, Rarity, ItemPrice = 0, 0, 0
      local CurrentItemLink, void

      local tSouldSomething = false
      -- Traverse bags and sell grey items
      for BagID = 0, 4 do
         for BagSlot = 1, GetContainerNumSlots(BagID) do
            CurrentItemLink = GetContainerItemLink(BagID, BagSlot)
            if CurrentItemLink then
               void, void, Rarity, void, void, void, void, void, void, void, ItemPrice = GetItemInfo(CurrentItemLink)
               local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(BagID, BagSlot)
               if itemID and (Rarity == 0 or SkuOptions.db.char["SkuCore"].SellJunkCustomItemIds[itemID]) and ItemPrice ~= 0 then
                  SoldCount = SoldCount + 1
                  if MerchantFrame:IsShown() then
                     -- If merchant frame is open, vendor the item
                     UseContainerItem(BagID, BagSlot)
                     tSouldSomething = true
                     -- Perform actions on first iteration
                     if SellJunkTicker._remainingIterations == IterationCount then
                        -- Calculate total price
                        totalPrice = totalPrice + (ItemPrice * itemCount)
                        -- Store first sold bag slot for analysis
                        if SoldCount == 1 then
                           mBagID, mBagSlot = BagID, BagSlot
                        end
                     end
                  else
                     -- If merchant frame is not open, stop selling
                     StopSelling()
                     return
                  end
               end
            end
         end
      end

      -- Stop selling if no items were sold for this iteration or iteration limit was reached
      if SoldCount == 0 or SellJunkTicker and SellJunkTicker._remainingIterations == 1 then 
         StopSelling() 
         if totalPrice > 0 then 
            dprint("Sold junk for" .. " " .. GetCoinText(totalPrice) .. ".")
         end
      end

   end

   -- Event handler
   SellJunkFrame:SetScript("OnEvent", function(self, event)
      if event == "MERCHANT_SHOW" then
         -- repair
         if CanMerchantRepair() then -- If merchant is capable of repair 
            local RepairCost, CanRepair = GetRepairAllCost()
            if CanRepair then -- If merchant is offering repair
               if SkuOptions.db.profile[MODULE_NAME].itemSettings.autoRepair == true then
                  if RepairCost > GetMoney() then
                     SkuOptions.Voice:OutputString(L["Nicht genug Gold zum Reparieren"], false, true, 1, true)
                  else
                     RepairAllItems()
                     SkuOptions.Voice:OutputString(L["Alles repariert"], false, true, 1, true)
                  end
               end
            end
         end

         if SkuOptions.db.profile[MODULE_NAME].itemSettings.autoSellJunk == true then
            -- Reset variables
            totalPrice, mBagID, mBagSlot = 0, -1, -1
            -- Cancel existing ticker if present
            if SellJunkTicker then SellJunkTicker:Cancel() end
            -- Sell grey items using ticker (ends when all grey items are sold or iteration count reached)
            SkuOptions.Voice:OutputString(L["Schrott verkauft"], false, true, 1, true)
            SellJunkTicker = C_Timer.NewTicker(0.2, SellJunkFunc, IterationCount)
            SellJunkFrame:RegisterEvent("ITEM_LOCKED")
            SellJunkFrame:RegisterEvent("ITEM_UNLOCKED")
         end
      elseif event == "ITEM_LOCKED" then
         if SkuOptions.db.profile[MODULE_NAME].itemSettings.autoSellJunk == true then
            SellJunkFrame:UnregisterEvent("ITEM_LOCKED")
         end
      elseif event == "ITEM_UNLOCKED" then
         if SkuOptions.db.profile[MODULE_NAME].itemSettings.autoSellJunk == true then
            SellJunkFrame:UnregisterEvent("ITEM_UNLOCKED")
            -- Check whether vendor refuses to buy items
            if mBagID and mBagSlot and mBagID ~= -1 and mBagSlot ~= -1 then
               local texture, count, locked = GetContainerItemInfo(mBagID, mBagSlot)
               if count and not locked then
                  -- Item has been unlocked but still not sold so stop selling
                  StopSelling()
               end
            end
         end
      elseif event == "MERCHANT_CLOSED" then
         -- If merchant frame is closed, stop selling
         StopSelling()
      end
   end)

   SellJunkFrame:RegisterEvent("MERCHANT_SHOW")
   SellJunkFrame:RegisterEvent("MERCHANT_CLOSED")

end
--[[
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:JunkAndRepairEnable()
   local tAutoSellJunk = "On"
   if tAutoSellJunk == "On" then
      SellJunkFrame:RegisterEvent("MERCHANT_SHOW")
      SellJunkFrame:RegisterEvent("MERCHANT_CLOSED")
   else
      SellJunkFrame:UnregisterEvent("MERCHANT_SHOW")
      SellJunkFrame:UnregisterEvent("MERCHANT_CLOSED")
   end
end
]]
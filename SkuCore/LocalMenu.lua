---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "LocalMenu"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local tRolenamesLookup = {
	[1] = "DAMAGER",
	[2] = "TANK",
	[3] = "HEALER",
	["DAMAGER"] = 1,
	["TANK"] = 2,
	["HEALER"] = 3,
}

local tBagSlotListSorted = {
	[1] = 0,
	[2] = 1,
	[3] = 2,
	[4] = 3,
	[5] = 4,
	[6] = -1,
	[7] = 5,
	[8] = 6,
	[9] = 7,
	[10] = 8,
	[11] = 9,
	[12] = 10,
	[13] = 11,
	--[14] = -2,
	[14] = -3,
}


---------------------------------------------------------------------------------------------------------------------------------------
-- helpers
---------------------------------------------------------------------------------------------------------------------------------------
local function GetButtonTooltipLines(aButtonObj, aTooltipObject)

	local tTooltipObj = aTooltipObject or GameTooltip

	if not aTooltipObject then
		GameTooltip:ClearLines()
		if aButtonObj.type then
			if aButtonObj.type ~= "" then
				if aButtonObj:GetScript("OnEnter") then
					aButtonObj:GetScript("OnEnter")(aButtonObj)
				end
			end
		end
	end

	local tQualityString = nil
	local itemName, ItemLink = tTooltipObj:GetItem()
	local tEffectiveILvl

	if not itemName then
		itemName, ItemLink = tTooltipObj:GetSpell()
	end

	if ItemLink then
		for x = 0, #ITEM_QUALITY_COLORS do
			local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
			if tItemCol == "ffa334ee" then
				tItemCol = "ffa335ee"
			end
			if string.find(ItemLink, tItemCol) then
				if _G["ITEM_QUALITY"..x.."_DESC"] then
					tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
				end
			end
		end
		tEffectiveILvl = GetDetailedItemLevelInfo(ItemLink)
	end

	local tTooltipText = ""
	local tLineCounter = 1
	for i = 1, select("#", tTooltipObj:GetRegions()) do
		local region = select(i, tTooltipObj:GetRegions())
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				if tLineCounter == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
					tTooltipText = tTooltipText..text.." ("..tQualityString..")\r\n"
				elseif tLineCounter == 2 and tEffectiveILvl then
					tTooltipText = tTooltipText..L["Item Level"]..": "..tEffectiveILvl.."\r\n"
					tTooltipText = tTooltipText..text.."\r\n"
				else
					tTooltipText = tTooltipText..text.."\r\n"
				end
				tLineCounter = tLineCounter + 1
			end
		end
	end

	if not aTooltipObject then
		tTooltipObj:SetOwner(UIParent, "Center")
		tTooltipObj:Hide()
		if aButtonObj:GetScript("OnLeave") then
			aButtonObj:GetScript("OnLeave")(aButtonObj)
		end
	end

	if tTooltipText ~= "asd" then
		if tTooltipText ~= "" then
			tTooltipText = SkuChat:Unescape(tTooltipText)
			if tTooltipText then
				local tText, tTextf = SkuCore:ItemName_helper(tTooltipText)
				return tText, tTextf, ItemLink
			end
		end
	end

	return "", ""
end

---------------------------------------------------------------------------------------------------------------------------------------
-- menu items
---------------------------------------------------------------------------------------------------------------------------------------

---@alias EquipLoc string See https://wowpedia.fandom.com/wiki/Enum.InventoryType
---@alias InvSlot integer See https://wowpedia.fandom.com/wiki/InventorySlotId

---Sets tooltip item and returns its cleaned up text.
---(Meant for defining other functions, not meant for direct use)
---@param tooltipSetter fun(tooltip: GameTooltip): void Define how the item tooltip should be set.
---@return string | nil Tooltip text
local function getItemTooltipTextHelper(tooltipSetter)
	local tooltip = _G["SkuScanningTooltip"]
	tooltip:ClearLines()
	tooltipSetter(tooltip)
	local getEscapedText = function() return TooltipLines_helper(tooltip:GetRegions()) end
	if getEscapedText() ~= "asd" and getEscapedText() ~= "" then
		return SkuChat:Unescape(getEscapedText())
	end
end

local function getItemTooltipTextFromBagItem(bag, slot, itemId, button)
	if button then
		if button:GetScript("OnEnter") then
			button:GetScript("OnEnter")(button)

			local tQualityString = nil
			local itemName, ItemLink = GameTooltip:GetItem()
			local tEffectiveILvl

			if ItemLink then
				for x = 0, #ITEM_QUALITY_COLORS do
					local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
					if tItemCol == "ffa334ee" then
						tItemCol = "ffa335ee"
					end
					if string.find(ItemLink, tItemCol) then
						if _G["ITEM_QUALITY"..x.."_DESC"] then
							tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
						end
					end
				end
				tEffectiveILvl = GetDetailedItemLevelInfo(ItemLink)
			end

			local tTooltipText = ""
			local tLineCounter = 1
			for i = 1, select("#", GameTooltip:GetRegions()) do
				local region = select(i, GameTooltip:GetRegions())
				if region and region:GetObjectType() == "FontString" then
					local text = region:GetText() -- string or nil
					if text then
						if tLineCounter == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
							tTooltipText = tTooltipText..text.." ("..tQualityString..")\r\n"
						elseif tLineCounter == 2 and tEffectiveILvl then
							tTooltipText = tTooltipText..L["Item Level"]..": "..tEffectiveILvl.."\r\n"
							tTooltipText = tTooltipText..text.."\r\n"
						else
							tTooltipText = tTooltipText..text.."\r\n"
						end
						tLineCounter = tLineCounter + 1
					end
				end
			end
			getItemTooltipTextHelper(function(tooltip)
				if itemId then
					tooltip:SetItemByID(itemId)
				else
					tooltip:SetBagItem(bag, slot)
				end
			end)
			return SkuChat:Unescape(tTooltipText)
		end
	else

		return getItemTooltipTextHelper(function(tooltip)
			if itemId then
				tooltip:SetItemByID(itemId)
			else
				tooltip:SetBagItem(bag, slot)
			end
		end)
	end
end

---Checks if item is soulbound
---@param bag number bag id
---@param slot number slot id
---@return boolean Whether item is soulbound
function SkuCore:IsItemSoulbound(bag, slot)
	local tooltip = getItemTooltipTextFromBagItem(bag, slot)
	local result = tooltip and  string.find(tooltip, L["Soulbound"])
	-- convert to boolean
	return result and true or false
end

---Gets tooltip text for given equipped item
---@param invSlot InvSlot
---@return string|nil
local function getEquippedItemTooltipText(invSlot)
	return getItemTooltipTextHelper(function(tooltip)
		tooltip:SetInventoryItem("player", invSlot)
	end)
end

-- to reduce repetition
local BOTH_HANDS = {INVSLOT_MAINHAND, INVSLOT_OFFHAND}
local JUST_MAINHAND = {INVSLOT_MAINHAND}
local JUST_OFFHAND = {INVSLOT_OFFHAND}
local RANGED = {INVSLOT_RANGED}

---See https://wowpedia.fandom.com/wiki/Enum.InventoryType
---@type table<EquipLoc, InvSlot[]> Maps what inventory slots (equipped items) correspond to an equip location.
local comparableInvSlotsforInvType = {
	INVTYPE_HEAD = {INVSLOT_HEAD},
	INVTYPE_NECK = {INVSLOT_NECK},
	INVTYPE_SHOULDER = {INVSLOT_SHOULDER},
	INVTYPE_BODY = {INVSLOT_BODY},
	INVTYPE_CHEST = {INVSLOT_CHEST},
	INVTYPE_WAIST = {INVSLOT_WAIST},
	INVTYPE_LEGS = {INVSLOT_LEGS},
	INVTYPE_FEET = {INVSLOT_FEET},
	INVTYPE_WRIST = {INVSLOT_WRIST},
	INVTYPE_HAND = {INVSLOT_HAND},
	INVTYPE_FINGER = {INVSLOT_FINGER1, INVSLOT_FINGER2},
	INVTYPE_TRINKET = {INVSLOT_TRINKET1, INVSLOT_TRINKET2},
	INVTYPE_WEAPON = CanDualWield() and BOTH_HANDS or JUST_MAINHAND,
	INVTYPE_SHIELD = JUST_OFFHAND,
	INVTYPE_RANGED = RANGED,
	INVTYPE_RANGEDRIGHT = RANGED,
	INVTYPE_RELIC = RANGED,
	INVTYPE_AMMO = {INVSLOT_AMMO},
	INVTYPE_2HWEAPON = BOTH_HANDS,
	INVTYPE_CLOAK = {INVSLOT_BACK},
	INVTYPE_TABARD = {INVSLOT_TABARD},
	INVTYPE_ROBE = {INVSLOT_CHEST},
	INVTYPE_THROWN = RANGED,
	INVTYPE_WEAPONMAINHAND = JUST_MAINHAND,
	INVTYPE_WEAPONOFFHAND = JUST_OFFHAND,
	INVTYPE_HOLDABLE = JUST_OFFHAND,
}

---For a given item, Returns item tooltip texts for comparable equipped items.
---@param itemId number Item ID for item for which comparisns will be returned.
---@param cache table|nil Optional lookup table for saving tooltip texts between calls to this function
---@return string[]|nil List of tooltip texts or nil if no slots to compare found
function SkuCore:getItemComparisnSections(itemId, cache)
	local invType = select(4, GetItemInfoInstant(itemId))
	local invSlotsToCompare = comparableInvSlotsforInvType[invType]
	--if offhand slot and equipped a 2H weapon, compare both hands instead
	if invSlotsToCompare == JUST_OFFHAND then
		local mainHandItemId = GetInventoryItemID("player", JUST_MAINHAND[1])
		if mainHandItemId and select(4, GetItemInfoInstant(mainHandItemId)) == "INVTYPE_2HWEAPON" then
			invSlotsToCompare = BOTH_HANDS
		end
	end

	if not invSlotsToCompare then
		return
	end

	local comparisnSections = {}
	for _, slot in pairs(invSlotsToCompare) do
		--local cacheEntry = cache and cache[slot]
		local text = getEquippedItemTooltipText(slot)
		if text then
			table.insert(comparisnSections, text)
			--if cache and not cacheEntry then cache[slot] = text end
		end
	end
	return comparisnSections
end

---Inserts comparisn sections if equipable item.
---@param itemId number Item ID for item for which comparisns will be returned.
---@param textFull string[] List of strings intwo which comparisn sections will be inserted
---@param cache table|nil Optional lookup table for saving tooltip texts between calls to this function
function SkuCore:InsertComparisnSections(itemId, textFull, cache)
	if itemId and IsEquippableItem(itemId) then
		local comparisnSections = SkuCore:getItemComparisnSections(itemId, cache)
		if comparisnSections then
			for i, section in ipairs(comparisnSections) do
				local sectionHeader = #comparisnSections > 1 and L["currently equipped"].." "..i.."\r\n" or L["currently equipped"].."\r\n"
				table.insert(textFull, i + 1, sectionHeader .. section)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tBagSlotList = {
	[0] = L["Bag"].." 1",
	[1] = L["Bag"].." 2",
	[2] = L["Bag"].." 3",
	[3] = L["Bag"].." 4",
	[4] = L["Bag"].." 5",
	[-1] = L["Bank"],
	[5] = L["Bank"].." "..L["Bag"].." 1",
	[6] = L["Bank"].." "..L["Bag"].." 2",
	[7] = L["Bank"].." "..L["Bag"].." 3",
	[8] = L["Bank"].." "..L["Bag"].." 4",
	[9] = L["Bank"].." "..L["Bag"].." 5",
	[10] = L["Bank"].." "..L["Bag"].." 6",
	[11] = L["Bank"].." "..L["Bag"].." 7",
	[-2] = L["keyring"],
	[-3] = L["Reagent bank"],
}
local function OpenAllBagsHelper()
	for i, v in pairs(tBagSlotList) do
		if i ~= -1 and GetContainerNumSlots(i) > 0 then
			if not IsBagOpen(i) then
				--print("----", i, v, OpenBag(i))
				OpenBag(i)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_GuildBankFrame(aParentChilds)

	OpenAllBagsHelper()

	local tSelectedBankTab = 1
	local inventoryTooltipTextCache = {}
	local tgbf = _G["GuildBankFrame"]

	local friendlyName = "Bankfächer"
	table.insert(aParentChilds, friendlyName)
	aParentChilds[friendlyName] = {
		frameName = "",
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = friendlyName,
		textFull = "",
		--noMenuNumbers = true,
		childs = {},
	}

		for x = 1, 20 do
			if _G["GuildBankTab"..x] and _G["GuildBankTab"..x].Button.tooltip and _G["GuildBankTab"..x]:IsVisible() == true then
				local tSelected = ""
				if _G["GuildBankTab"..x].Button:GetChecked() == true then
					tSelected = " ("..L["selected"]..")"
					tSelectedBankTab = x
				end
				local tTabName = _G["GuildBankTab"..x].Button.tooltip..tSelected
				local containerFrameName = "GuildBankTab"..x..".Button"
				table.insert(aParentChilds[friendlyName].childs, tTabName)
				aParentChilds[friendlyName].childs[tTabName] = {
					frameName = containerFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G["GuildBankTab"..x].Button,
					textFirstLine = tTabName,
					textFull = "",
					noMenuNumbers = true,
					childs = {},
					click = true,
					func = _G["GuildBankTab"..x].Button:GetScript("OnClick"),
				}
			end
		end


	local friendlyName = L["current Bank box"] --.." "..SkuChat:Unescape(tgbf.TabTitle:GetText())
	table.insert(aParentChilds, friendlyName)
	aParentChilds[friendlyName] = {
		frameName = "",
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = friendlyName,
		textFull = friendlyName.."\r\n"..(_G["GuildBankLimitLabel"]:GetText() or ""),
		--noMenuNumbers = true,
		childs = {},
	}



	local bankVisible = _G["GuildBankFrame"].Column1.Button1:IsVisible()
	if bankVisible == true then

		for col = 1, 7 do
			for slot = 1, 14 do
				local slotIndex = (((col - 1) * 14) + slot)
				local tSlotName = slotIndex.." "..L["Empty"]
				local tText, tFullText = tSlotName, ""
				local containerFrame = tgbf["Column"..col]["Button"..slot]
				table.insert(aParentChilds[friendlyName].childs, tSlotName)
				aParentChilds[friendlyName].childs[tSlotName] = {
					frameName = "Column"..col..".Button"..slot,
					RoC = "Child",
					type = "Button",
					obj = tgbf["Column"..col]["Button"..slot],
					textFirstLine = tSlotName,
					textFull = "",
					noMenuNumbers = true,
					childs = {},
					click = true,
					func = tgbf["Column"..col]["Button"..slot]:GetScript("OnClick"),
				}

				--update blizzard container object
				aParentChilds[friendlyName].childs[tSlotName].obj.info = aParentChilds[friendlyName].childs[tSlotName].obj.info or {}
				local tLink = GetGuildBankItemLink(tSelectedBankTab, slotIndex)
				if tLink then
					aParentChilds[friendlyName].childs[tSlotName].obj.info.id = Item:CreateFromItemLink(tLink):GetItemID()
					local _, itemCount, locked = GetGuildBankItemInfo(tSelectedBankTab, slotIndex)
					aParentChilds[friendlyName].childs[tSlotName].obj.info.count = itemCount
					aParentChilds[friendlyName].childs[tSlotName].obj.info.gbanktab = tSelectedBankTab
					aParentChilds[friendlyName].childs[tSlotName].obj.info.gbankslot = slotIndex
				end

				local bagItemButton = aParentChilds[friendlyName].childs[tSlotName]
				--get the onclick func if there is one
				if bagItemButton.obj:IsMouseClickEnabled() == true then
					if bagItemButton.obj:GetObjectType() == "Button" then
						bagItemButton.func = bagItemButton.obj:GetScript("OnClick")
					end
					bagItemButton.onActionFunc = function(self, aTable, aChildName)
					end
					if bagItemButton.func then
						bagItemButton.click = true
					end
				end

				_G["SkuScanningTooltip"]:ClearLines()
				if GetCurrentGuildBankTab() and bagItemButton.obj.info.gbankslot then
					_G["SkuScanningTooltip"]:SetGuildBankItem(GetCurrentGuildBankTab(), bagItemButton.obj.info.gbankslot)
				end
				local itemName, tItemLink = _G["SkuScanningTooltip"]:GetItem()
				local tItemId = SkuGetItemIdFromItemLink(tItemLink)
				if tItemId ~= nil then
					GameTooltip:ClearLines()
					GameTooltip:SetGuildBankItem(GetCurrentGuildBankTab(), bagItemButton.obj.info.gbankslot)

					local _, maybeText = GetButtonTooltipLines(nil, GameTooltip)
					if maybeText then
						local tText = maybeText
						local isEmpty = false
						if bagItemButton.obj.info then
							if tItemId then
								bagItemButton.itemId = tItemId
								bagItemButton.textFirstLine = SkuCore:ItemName_helper(tText)
								bagItemButton.textFull = SkuCore:AuctionHouseGetAuctionPriceHistoryData(tItemId)
							end
						end

						if not bagItemButton.textFull then
							bagItemButton.textFull = {}
						end

						local tFirst, tFull = SkuCore:ItemName_helper(tText)
						bagItemButton.textFirstLine = slotIndex.. " "..tFirst
						if type(bagItemButton.textFull) ~= "table" then
							bagItemButton.textFull = { (bagItemButton.textFull or bagItemButton.textFirstLine or ""), }
						end
						table.insert(bagItemButton.textFull, 1, tFull)

						SkuCore:InsertComparisnSections(bagItemButton.itemId, bagItemButton.textFull, inventoryTooltipTextCache)
					end

					if bagItemButton.textFirstLine == "" and bagItemButton.textFull == "" and bagItemButton.obj.ShowTooltip then
						GameTooltip:ClearLines()
						bagItemButton.obj:ShowTooltip()
						if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
							if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
								local tText = SkuChat:Unescape(TooltipLines_helper(GameTooltip:GetRegions()))
								bagItemButton.textFirstLine, bagItemButton.textFull = SkuCore:ItemName_helper(tText)
								isEmpty = false
							end
						end
					end

					if containerFrame.info then
						bagItemButton.itemId = tItemId
						if not containerFrame.info.count then
							bagItemButton.textFirstLine = bagItemButton.textFirstLine
						else
							if not isEmpty and containerFrame.info.count > 1 then
								bagItemButton.textFirstLine = bagItemButton.textFirstLine .. " " .. containerFrame.info.count
							end
						end
					end
				else
					bagItemButton.textFirstLine = slotIndex.." "..L["Empty"]
					bagItemButton.textFull = slotIndex.." "..L["Empty"]
					bagItemButton.itemId = nil

				end
			end
		end
	else
		local tSlotName = L["anzeigen"]
		table.insert(aParentChilds[friendlyName].childs, "GuildBankFrameTab1")
		aParentChilds[friendlyName].childs["GuildBankFrameTab1"] = {
			frameName = "GuildBankFrameTab1",
			RoC = "Child",
			type = "Button",
			obj = _G["GuildBankFrameTab1"],
			textFirstLine = tSlotName,
			textFull = "",
			noMenuNumbers = true,
			childs = {},
			click = true,
			func = _G["GuildBankFrameTab1"]:GetScript("OnClick"),
		}
	end
--gold
	--available
	--witdraw
	--deposit



	--log
	local tName = _G["GuildBankFrameTab2"]:GetText()
	table.insert(aParentChilds, tName)
	aParentChilds[tName] = {
		frameName = "",
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = tName,
		textFull = "",
		--noMenuNumbers = true,
		childs = {},
	}

	if _G["GuildBankMessageFrame"].FontStringContainer:IsVisible() == true and _G["GuildBankLimitLabel"]:IsVisible() == true then
		local tMessageFull = ""

		local tMaxMsg = GetNumGuildBankTransactions(tSelectedBankTab)
		if tMaxMsg > 100 then tMaxMsg = 100 end
		for q = tMaxMsg, 1, -1 do
			local ttype, name, itemLink, count = GetGuildBankTransaction(tSelectedBankTab, q)
			tMessageFull = tMessageFull..ttype.." "..(name or L["no data"]).." "..(SkuChat:Unescape(itemLink) or "").." "..count.."\r\n"
		end

		local tFrameName = "GuildBankMessageFrame"
		local tFriendlyName = SkuChat:Unescape(tgbf.TabTitle:GetText()).." ..."
		table.insert(aParentChilds[tName].childs, "GuildBankMessageFrame")
		aParentChilds[tName].childs["GuildBankMessageFrame"] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G["GuildBankMessageFrame"].FontStringContainer,
			textFirstLine = tFriendlyName,
			textFull = tMessageFull,
			childs = {},
		}
	else
		local tSlotName = L["anzeigen"]
		table.insert(aParentChilds[tName].childs, "GuildBankFrameTab2")
		aParentChilds[tName].childs["GuildBankFrameTab2"] = {
			frameName = "GuildBankFrameTab2",
			RoC = "Child",
			type = "Button",
			obj = _G["GuildBankFrameTab2"],
			textFirstLine = tSlotName,
			textFull = "",
			noMenuNumbers = true,
			childs = {},
			click = true,
			func = _G["GuildBankFrameTab2"]:GetScript("OnClick"),
		}
	end

	--money log
	local tName = _G["GuildBankFrameTab3"]:GetText()
	table.insert(aParentChilds, tName)
	aParentChilds[tName] = {
		frameName = "",
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = tName,
		textFull = "",
		--noMenuNumbers = true,
		childs = {},
	}

	if _G["GuildBankMessageFrame"].FontStringContainer:IsVisible() == true and _G["GuildBankFrame"].TabTitle:GetText() == _G["GuildBankFrameTab3"]:GetText() then
		local tMessageFull = ""

		local tMaxMsg = GetNumGuildBankMoneyTransactions()
		if tMaxMsg > 100 then tMaxMsg = 100 end
		for q = tMaxMsg, 1, -1 do
			local ttype, name, amount = GetGuildBankMoneyTransaction(q)
			tMessageFull = tMessageFull..ttype.." "..(name or "").." "..(SkuGetCoinText(amount) or "").."\r\n"
		end

		local tFrameName = "GuildBankMessageFrame"
		local tFriendlyName = SkuChat:Unescape(tgbf.TabTitle:GetText()).." ..."
		table.insert(aParentChilds[tName].childs, "GuildBankMessageFrame")
		aParentChilds[tName].childs["GuildBankMessageFrame"] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G["GuildBankMessageFrame"].FontStringContainer,
			textFirstLine = tFriendlyName,
			textFull = tMessageFull,
			childs = {},
		}
	else
		local tSlotName = L["anzeigen"]
		table.insert(aParentChilds[tName].childs, "GuildBankFrameTab3")
		aParentChilds[tName].childs["GuildBankFrameTab3"] = {
			frameName = "GuildBankFrameTab3",
			RoC = "Child",
			type = "Button",
			obj = _G["GuildBankFrameTab3"],
			textFirstLine = tSlotName,
			textFull = "",
			noMenuNumbers = true,
			childs = {},
			click = true,
			func = _G["GuildBankFrameTab3"]:GetScript("OnClick"),
		}
	end

--[[
	--info
	local tName = _G["GuildBankFrameTab4"]:GetText()
	table.insert(aParentChilds, tName)
	aParentChilds[tName] = {
		frameName = "",
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = tName,
		textFull = "",
		--noMenuNumbers = true,
		childs = {},
	}

	if _G["GuildBankInfoScrollFrame"]:IsVisible() == true and _G["GuildBankInfoSaveButton"]:IsVisible() == true then


	else
		local tSlotName = L["anzeigen"]
		table.insert(aParentChilds[tName].childs, "GuildBankFrameTab4")
		aParentChilds[tName].childs["GuildBankFrameTab4"] = {
			frameName = "GuildBankFrameTab4",
			RoC = "Child",
			type = "Button",
			obj = _G["GuildBankFrameTab4"],
			textFirstLine = tSlotName,
			textFull = "",
			noMenuNumbers = true,
			childs = {},
			click = true,
			func = _G["GuildBankFrameTab4"]:GetScript("OnClick"),
		}
	end
]]
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_BankFrame(aParentChilds)
	OpenAllBagsHelper()
end

---------------------------------------------------------------------------------------------------------------------------------------
local tIsProcessing = 0
local tIsProcessingHandle
local function SortProcessingSoundHelper()
	if tIsProcessingHandle == nil then
		tIsProcessingHandle = C_Timer.NewTicker(0.5, function(self)
			if tIsProcessing > 0 then
				--SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, true)
			else
				self:Cancel()
				tIsProcessingHandle = nil
				C_Timer.After(0.1, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate()
					SkuOptions.Voice:OutputStringBTtts("sound-notification16", false, true)--24
				end)
			end

		end)
	end
end

local function BagSortMenuHelper(aParentChilds, aBagId)
	local function tGetContainerFrameHelper(tCurrentContainerFrameNumber, tNumSlots, slotId)
		local containerFrameName = ""
		if tCurrentContainerFrameNumber then
			containerFrameName = "ContainerFrame"..(tCurrentContainerFrameNumber).."Item"..(tNumSlots - slotId + 1)
		end
		if i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true then
			tCurrentContainerFrameNumber = -1
			containerFrameName = "BankFrameItem"..slotId
		end
		return _G[containerFrameName]
	end


	--collapse
	local tFriendlyName = L["Remove empty bag slots (collapse)"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = function()
			SkuCore.CursorSilent = true
			SkuOptions.Voice.TutorialPlaying = 1
			for i, v in pairs(tBagSlotList) do
				if i == aBagId or aBagId == nil then
					local tCurrentContainerFrameNumber = IsBagOpen(i)
					local tNumSlots = GetContainerNumSlots(i)
					if tNumSlots > 0 and (tCurrentContainerFrameNumber or (i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true)) then
						local tCompleted = true
						local co = coroutine.create(function ()
							while tCompleted == true do
								local tLastEmptySlotFrame = nil
								tCompleted = false
								for slotId = 1, tNumSlots do
									local containerFrameName = ""
									if tCurrentContainerFrameNumber then
										containerFrameName = "ContainerFrame"..(tCurrentContainerFrameNumber).."Item"..(tNumSlots - slotId + 1)
									end
									if i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true then
										tCurrentContainerFrameNumber = -1
										containerFrameName = "BankFrameItem"..slotId
									end

									local containerFrame = _G[containerFrameName]
									local maybeText = getItemTooltipTextFromBagItem(nil, nil, nil, containerFrame)
									local tFirst, tFull
									if maybeText then
										tFirst, tFull = SkuCore:ItemName_helper(maybeText)
										if tFirst == "" then tFirst = nil end
									end

									if tFirst and tLastEmptySlotFrame ~= nil then
										containerFrame:GetScript("OnClick")(containerFrame, "LeftButton")
										tLastEmptySlotFrame:GetScript("OnClick")(tLastEmptySlotFrame, "LeftButton")
										tLastEmptySlotFrame = containerFrame
										tCompleted = true
										coroutine.yield()
										break
									elseif not tFirst and tLastEmptySlotFrame == nil then
										tLastEmptySlotFrame = containerFrame
										if slotId == tNumSlots then
											tCompleted = false
										end
									elseif slotId == tNumSlots and tLastEmptySlotFrame == nil then
										tCompleted = false
									end
								end
							end
						end)

						tIsProcessing = tIsProcessing + 1
						SortProcessingSoundHelper()
						cbObject = C_Timer.NewTicker(0.5, function(self)
							if coroutine.status(co) == "suspended" then
								SortProcessingSoundHelper()
								coroutine.resume(co)
							else
								tIsProcessing = tIsProcessing - 1
								self:Cancel()
								SkuCore.CursorSilent = false
								SkuOptions.Voice.TutorialPlaying = 0
								SkuOptions.Voice:StopOutputEmptyQueue()
								SortProcessingSoundHelper()
							end
						end)
					end
				end
			end
		end,
	}



	--sort by quality
	local function SortByQualityHelper(tCurrentContainerFrameNumber, tNumSlots, i, aEvaluateFunc)
		SkuCore.CursorSilent = true
		SkuOptions.Voice.TutorialPlaying = 1
		local co = coroutine.create(function ()
			local tProcess = true
			while tProcess do
				tProcess = nil
				for count = 1, tNumSlots - 1 do
					local tPickContainerFrame = tGetContainerFrameHelper(tCurrentContainerFrameNumber, tNumSlots, count)
					local tPlaceContainerFrame = tGetContainerFrameHelper(tCurrentContainerFrameNumber, tNumSlots, count + 1)
					local tPickQuali, tPlaceQuali
					if i == -1 then
						local invSlot = BankButtonIDToInvSlotID(count)
						local pickItemLink = GetInventoryItemLink("player", invSlot)
						if not pickItemLink then
							tPickQuali = "zzzzzzzzzz"
						else
							tPickQuali = C_Item.GetItemQualityByID(pickItemLink)
						end

						local invSlot = BankButtonIDToInvSlotID(count + 1)
						local placeItemlink = GetInventoryItemLink("player", invSlot)
						if not placeItemlink then
							tPlaceQuali = "zzzzzzzzzz"
						else
							tPlaceQuali = C_Item.GetItemQualityByID(placeItemlink)
						end
					else
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetBagItem(i, count)
						local itemName, pickItemLink = _G["SkuScanningTooltip"]:GetItem()
						tPickQuali = 99999
						if pickItemLink then
							tPickQuali = C_Item.GetItemQualityByID(pickItemLink)
						end
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetBagItem(i, count + 1)
						local itemName, placeItemLink = _G["SkuScanningTooltip"]:GetItem()
						tPlaceQuali = 99999
						if placeItemLink then
							tPlaceQuali = C_Item.GetItemQualityByID(placeItemLink)
						end
					end

					if aEvaluateFunc(tPickQuali, tPlaceQuali) == true then
						if pickItemLink then
							tPickContainerFrame:GetScript("OnClick")(tPickContainerFrame, "LeftButton")
							tPlaceContainerFrame:GetScript("OnClick")(tPlaceContainerFrame, "LeftButton")
						else
							tPlaceContainerFrame:GetScript("OnClick")(tPlaceContainerFrame, "LeftButton")
							tPickContainerFrame:GetScript("OnClick")(tPickContainerFrame, "LeftButton")
						end
						tProcess = true
						break
					end
				end
				coroutine.yield()
			end
		end)

		tIsProcessing = tIsProcessing + 1
		SortProcessingSoundHelper()
		cbObject = C_Timer.NewTicker(0.01, function(self)
			if coroutine.status(co) == "suspended" then
				SortProcessingSoundHelper()
				local tret = coroutine.resume(co)
			else
				tIsProcessing = tIsProcessing - 1
				self:Cancel()
				SkuCore.CursorSilent = false
				SkuOptions.Voice.TutorialPlaying = 0
				SkuOptions.Voice:StopOutputEmptyQueue()
				SortProcessingSoundHelper()
			end
		end)
	end

	local tFriendlyName = L["Sort items by quality"].." "..L["ascending"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = function()
			--print("func Sort by quality ascending", aBagId)
			for i, v in pairs(tBagSlotList) do
				if i == aBagId or aBagId == nil then
					local tCurrentContainerFrameNumber = IsBagOpen(i)
					local tNumSlots = GetContainerNumSlots(i)
					if tNumSlots > 0 and (tCurrentContainerFrameNumber or (i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true)) then
						SortByQualityHelper(tCurrentContainerFrameNumber, tNumSlots, i, function(a, b)
						 	return a > b
						end)
					end
				end
			end
		end,
	}
	local tFriendlyName = L["Sort items by quality"].." "..L["descending"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = function()
			--print("func Sort by quality descending", aBagId)
			for i, v in pairs(tBagSlotList) do
				if i == aBagId or aBagId == nil then
					local tCurrentContainerFrameNumber = IsBagOpen(i)
					local tNumSlots = GetContainerNumSlots(i)
					if tNumSlots > 0 and (tCurrentContainerFrameNumber or (i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true)) then
						SortByQualityHelper(tCurrentContainerFrameNumber, tNumSlots, i, function(a, b)
						 	return a < b
						end)
					end
				end
			end
		end,
	}





	--sort by name
	local function SortByNameHelper(tCurrentContainerFrameNumber, tNumSlots, i, aEvaluateFunc)
		SkuCore.CursorSilent = true
		SkuOptions.Voice.TutorialPlaying = 1
		local co = coroutine.create(function ()
			local tProcess = true
			while tProcess do
				tProcess = nil
				for count = 1, tNumSlots - 1 do
					local tPickContainerFrame = tGetContainerFrameHelper(tCurrentContainerFrameNumber, tNumSlots, count)
					local tPlaceContainerFrame = tGetContainerFrameHelper(tCurrentContainerFrameNumber, tNumSlots, count + 1)
					local pickitemName, placeitemName
					if i == -1 then
						local invSlot = BankButtonIDToInvSlotID(count)
						local pickItemLink = GetInventoryItemLink("player", invSlot)
						if not pickItemLink then
							pickitemName = "zzzzzzzzzz"
						else
							pickitemName = C_Item.GetItemNameByID(pickItemLink)
						end

						local invSlot = BankButtonIDToInvSlotID(count + 1)
						local placeItemlink = GetInventoryItemLink("player", invSlot)
						if not placeItemlink then
							placeitemName = "zzzzzzzzzz"
						else
							placeitemName = C_Item.GetItemNameByID(placeItemlink)
						end
					else
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetBagItem(i, count)
						pickitemName, pickItemLink = _G["SkuScanningTooltip"]:GetItem()
						if not pickitemName then
							pickitemName = "zzzzzzzzzz"
						end
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetBagItem(i, count + 1)
						placeitemName = _G["SkuScanningTooltip"]:GetItem()
						if not placeitemName then
							placeitemName = "zzzzzzzzzz"
						end
					end
					if aEvaluateFunc(pickitemName, placeitemName) == true then
						if pickItemLink then
							tPickContainerFrame:GetScript("OnClick")(tPickContainerFrame, "LeftButton")
							tPlaceContainerFrame:GetScript("OnClick")(tPlaceContainerFrame, "LeftButton")
						else
							tPlaceContainerFrame:GetScript("OnClick")(tPlaceContainerFrame, "LeftButton")
							tPickContainerFrame:GetScript("OnClick")(tPickContainerFrame, "LeftButton")
						end
						tProcess = true
						break
					end
				end
				coroutine.yield()
			end
		end)

		tIsProcessing = tIsProcessing + 1
		SortProcessingSoundHelper()
		cbObject = C_Timer.NewTicker(0.01, function(self)
			if coroutine.status(co) == "suspended" then
				SortProcessingSoundHelper()
				local tret = coroutine.resume(co)
			else
				tIsProcessing = tIsProcessing - 1
				self:Cancel()
				SkuCore.CursorSilent = false
				SkuOptions.Voice.TutorialPlaying = 0
				SkuOptions.Voice:StopOutputEmptyQueue()
				SortProcessingSoundHelper()
			end
		end)
	end

	--sort by name
	local tFriendlyName = L["Sort items by name"].." "..L["ascending"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = function()
			for i, v in pairs(tBagSlotList) do
				if i == aBagId or aBagId == nil then
					local tCurrentContainerFrameNumber = IsBagOpen(i)
					local tNumSlots = GetContainerNumSlots(i)
					if tNumSlots > 0 and (tCurrentContainerFrameNumber or (i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true)) then
						SortByNameHelper(tCurrentContainerFrameNumber, tNumSlots, i, function(a, b)
						 	return a > b
						end)
					end
				end
			end
		end,
	}
	local tFriendlyName = L["Sort items by name"].." "..L["descending"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = function()
			for i, v in pairs(tBagSlotList) do
				if i == aBagId or aBagId == nil then
					local tCurrentContainerFrameNumber = IsBagOpen(i)
					local tNumSlots = GetContainerNumSlots(i)
					if tNumSlots > 0 and (tCurrentContainerFrameNumber or (i == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true)) then
						SortByNameHelper(tCurrentContainerFrameNumber, tNumSlots, i, function(a, b)
						 	return a < b
						end)
					end
				end
			end
		end,
	}






end


---------------------------------------------------------------------------------------------------------------------------------------
local ContainerFrame1Hook
function SkuCore:Build_BagsFrame(aParentChilds)
	if not ContainerFrame1Hook then
		hooksecurefunc(_G["ContainerFrame1"], "Hide", function()
			for x = 2, 15 do
				if _G["ContainerFrame"..x] then
					_G["ContainerFrame"..x]:Hide()
				end
			end
		end)
		ContainerFrame1Hook = true
	end

	local tEmptyCounter = 1
	local tCurrentParentContainer = nil
	local allBagResults = {}
	 tBagResultsByBag = {}
	local inventoryTooltipTextCache = {}

	OpenAllBagsHelper()

	for q = 1, #tBagSlotListSorted do
		local bagId = tBagSlotListSorted[q]
		local tCurrentContainerFrameNumber = IsBagOpen(bagId)
		local tNumSlots = GetContainerNumSlots(bagId)
		for slotId = 1, tNumSlots do
			local containerFrameName = ""
			if tCurrentContainerFrameNumber then
				containerFrameName = "ContainerFrame"..(tCurrentContainerFrameNumber).."Item"..(tNumSlots - slotId + 1)
			end
			if bagId == -1 and _G["BankFrame"] and _G["BankFrame"]:IsVisible() == true then
				tCurrentContainerFrameNumber = -1
				containerFrameName = "BankFrameItem"..slotId
			end

			local containerFrame = _G[containerFrameName]
			if containerFrame then
				if not tBagResultsByBag[tCurrentContainerFrameNumber] then
					local bagName = tBagSlotList[bagId] --L["Bag"] .. " " .. (tCurrentContainerFrameNumber)
					table.insert(aParentChilds, bagName)
					aParentChilds[bagName] = {
						frameName = containerFrameName,
						RoC = "Child",
						type = "Button",
						obj = containerFrame,
						textFirstLine = bagName,
						textFull = "",
						noMenuNumbers = true,
						childs = {},
					}

					tBagResultsByBag[(tCurrentContainerFrameNumber)] = { obj = aParentChilds[bagName], childs = {} }
				end

				local tFriendlyName = L["Bag"] .. (tCurrentContainerFrameNumber) .. "-" .. slotId
				local tText = L["Empty"]
				local isEmpty = true
				local bagItemButton

				--update blizzard container object
				containerFrame.GetBag = function()
					return bagId
				end
				containerFrame.info = containerFrame.info or {}
				containerFrame.info.id = GetContainerItemID(bagId, slotId)
				local _, itemCount = GetContainerItemInfo(bagId, slotId)
				containerFrame.info.count = itemCount

				if containerFrame:IsEnabled() == true then
					aParentChilds[tFriendlyName] = {
						frameName = containerFrameName,
						RoC = "Child",
						type = "Button",
						obj = containerFrame,
						textFirstLine = tText,
						textFull = "",
						noMenuNumbers = true,
						childs = {},
						isNewItem = C_NewItems.IsNewItem(bagId, slotId),
					}
					bagItemButton = aParentChilds[tFriendlyName]
					--get the onclick func if there is one
					if bagItemButton.obj:IsMouseClickEnabled() == true then
						if bagItemButton.obj:GetObjectType() == "Button" then
							bagItemButton.func = bagItemButton.obj:GetScript("OnClick")
						end
						bagItemButton.containerFrameName = containerFrameName
						bagItemButton.onActionFunc = function(self, aTable, aChildName)

						end
						if bagItemButton.func then
							bagItemButton.click = true
						end
					end

					local maybeText = getItemTooltipTextFromBagItem(bagItemButton.obj:GetParent():GetID(), bagItemButton.obj:GetID(), bagItemButton.obj.info.id)
					if maybeText then
						local tText = maybeText
						isEmpty = false
						if bagItemButton.obj.info then
							if bagItemButton.obj.info.id then
								bagItemButton.itemId = bagItemButton.obj.info.id
								bagItemButton.textFirstLine = SkuCore:ItemName_helper(tText)
								bagItemButton.textFull = SkuCore:AuctionHouseGetAuctionPriceHistoryData(bagItemButton.obj.info.id)
							end
						end
						if not bagItemButton.textFull then
							bagItemButton.textFull = {}
						end
						local tFirst, tFull = SkuCore:ItemName_helper(tText)

						local tFull = getItemTooltipTextFromBagItem(bagItemButton.obj:GetParent():GetID(), bagItemButton.obj:GetID(), bagItemButton.obj.info.id, bagItemButton.obj)

						bagItemButton.textFirstLine = tFirst
						if type(bagItemButton.textFull) ~= "table" then
							bagItemButton.textFull = { (bagItemButton.textFull or bagItemButton.textFirstLine or ""), }
						end
						table.insert(bagItemButton.textFull, 1, tFull)
						SkuCore:InsertComparisnSections(bagItemButton.itemId, bagItemButton.textFull, inventoryTooltipTextCache)
					end

					if bagItemButton.textFirstLine == "" and bagItemButton.textFull == "" and bagItemButton.obj.ShowTooltip then
						GameTooltip:ClearLines()
						bagItemButton.obj:ShowTooltip()
						if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
							if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
								local tText = SkuChat:Unescape(TooltipLines_helper(GameTooltip:GetRegions()))
								bagItemButton.textFirstLine, bagItemButton.textFull = SkuCore:ItemName_helper(tText)
								isEmpty = false
							end
						end
					end

					if _G[containerFrameName .. "Count"] and not containerFrame.info then
						if bagItemButton and _G[containerFrameName .. "Count"]:GetText() then
							if not isEmpty then
								bagItemButton.textFirstLine = bagItemButton.textFirstLine .. " " .. _G[containerFrameName .. "Count"]:GetText()
							end
						end
					end
					if bagItemButton and (string.find(containerFrameName, "ContainerFrame") or string.find(containerFrameName, "BankFrameItem") )then
						if bagItemButton.textFirstLine then
							bagItemButton.textFirstLine = (#tBagResultsByBag[(tCurrentContainerFrameNumber)].childs + 1) .. " " .. bagItemButton.textFirstLine
							tEmptyCounter = tEmptyCounter + 1
						end
					end
					if _G[containerFrameName .. "Count"] and bagItemButton then
						bagItemButton.stackSize = _G[containerFrameName .. "Count"]:GetText()
					end
					if containerFrame.info then
						bagItemButton.itemId = containerFrame.info.id
						if not containerFrame.info.count then
							bagItemButton.textFirstLine = bagItemButton.textFirstLine
						else
							if not isEmpty and containerFrame.info.count > 1 then
								bagItemButton.textFirstLine = bagItemButton.textFirstLine .. " " .. containerFrame.info.count
							end
						end
					end
				end

				tBagResultsByBag[(tCurrentContainerFrameNumber)].childs[#tBagResultsByBag[(tCurrentContainerFrameNumber)].childs + 1] = bagItemButton
				-- if the item slot isn't empty and is in one of the bags, add it to allBagResults
				if not isEmpty and bagId >= 0 and bagId <= 4 then
					-- create a copy that doesn't have the numbering in textFirstLine
					copy = {}
					for k, v in pairs(bagItemButton) do
						copy[k] = v
					end
					copy.textFirstLine = string.sub(copy.textFirstLine, string.find(copy.textFirstLine, " ") + 1)
					table.insert(allBagResults, copy)
					allBagResults[copy] = copy
				end

			end
		end
	end

	for q = -3, 40 do
		local i, v = q, tBagResultsByBag[q]
		if v then
			for ic, vc in pairs(v.childs) do
				table.insert(v.obj.childs, vc)
				v.obj.childs[vc] = vc
			end

			--sort button
			local tFriendlyName = L["Sorting and cleanup"]
			table.insert(v.obj.childs, tFriendlyName)
			v.obj.childs[tFriendlyName] = {
				frameName = nil,
				RoC = "Child",
				type = "Button",
				obj = nil,
				textFirstLine = tFriendlyName,
				textFull = "",
				noMenuNumbers = true,
				childs = {},
				func = nil,
				click = true,
			}
			BagSortMenuHelper(v.obj.childs[tFriendlyName].childs, v.obj.obj:GetBag(), v)
		end
	end

	-- sort all items alphabetically, putting newly acquired on top
	table.sort(allBagResults, function(item1, item2)
		if item1.isNewItem and not item2.isNewItem then
			return true
		elseif item2.isNewItem and not item1.isNewItem then
			return false
		end
		return item1.textFirstLine < item2.textFirstLine
	end)

	-- prepend "new" to all new items
	for _, itemButton in pairs(allBagResults) do
		if itemButton.isNewItem then
			if not string.find(itemButton.textFirstLine, "^"..L["New"]) then
				itemButton.textFirstLine = L["New"] .. " " .. itemButton.textFirstLine
			end
		end
	end
	-- all items menu item
	do
		local allItemsMenuItemName = L["all items"]
		table.insert(aParentChilds, allItemsMenuItemName)
		aParentChilds[allItemsMenuItemName] = {
			RoC = "Child",
			type = "Button",
			textFirstLine = allItemsMenuItemName,
			noMenuNumbers = true,
			childs = allBagResults,
		}
	end

	local tFriendlyName = L["Bags"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = nil,
		click = true,
	}

	tCurrentParentContainer = aParentChilds[tFriendlyName]

	local tBarBagSlots = {
		[1] = _G["MainMenuBarBackpackButton"],
		[2] = _G["CharacterBag0Slot"],
		[3] = _G["CharacterBag1Slot"],
		[4] = _G["CharacterBag2Slot"],
		[5] = _G["CharacterBag3Slot"],
	}

	for x = 1, #tBarBagSlots do
		local containerFrameName = "CharacterBag".. x.."Slot"
		if tBarBagSlots[x] then
			local tFriendlyName = L["Bag-slot"] .. " " .. (x)
			if tBarBagSlots[x]:IsEnabled() == true then
				aParentChilds[tFriendlyName] = {
					frameName = tBarBagSlots[x]:GetName(),--L["Bag-slot"]..(x),
					RoC = "Child",
					type = "Button",
					obj = tBarBagSlots[x],
					textFirstLine = tFriendlyName,
					textFull = "",
					noMenuNumbers = true,
					childs = {},
					func = tBarBagSlots[x]:GetScript("OnClick"),
					click = true,
					isBag = true,
				}
				if x == 1 or x == 6 then
					aParentChilds[tFriendlyName].childs = {}
					aParentChilds[tFriendlyName].type = "Text"
					aParentChilds[tFriendlyName].func = nil
				end

				GameTooltip:ClearLines()
				aParentChilds[tFriendlyName].obj:GetScript("OnEnter")(aParentChilds[tFriendlyName].obj)
				if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
					if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
						local tText = SkuChat:Unescape(TooltipLines_helper(GameTooltip:GetRegions()))
						--[[
						if string.find(tText, "Equip Container") then
							tText = L["Empty"]
						end
						]]
						tText = x.." "..tText
						aParentChilds[tFriendlyName].textFirstLine, aParentChilds[tFriendlyName].textFull = SkuCore:ItemName_helper(tText)
					end
				end
			end

			table.insert(tCurrentParentContainer.childs, aParentChilds[tFriendlyName])
			tCurrentParentContainer.childs[aParentChilds[tFriendlyName] ] = aParentChilds[tFriendlyName]
		end
	end

	if _G["BankSlotsFrame"] and _G["BankSlotsFrame"].Bag1:IsVisible() == true then
		local numPurBankSlots, fullBankSlots = GetNumBankSlots()
		local costForNextPur = GetBankSlotCost(numPurBankSlots)

		for x = 1, numPurBankSlots do
			local containerFrameName = "Bag"..x
			local tFriendlyName = ""--"Bank Bag slot".." "..(x)
			if _G["BankSlotsFrame"]["Bag"..x]:IsEnabled() == true then
				aParentChilds[tFriendlyName] = {
					frameName = "BankSlotsFrame.Bag"..x,
					RoC = "Child",
					type = "Button",
					obj = _G["BankSlotsFrame"]["Bag"..x],
					textFirstLine = tFriendlyName,
					textFull = "",
					noMenuNumbers = true,
					childs = {},
					func = _G["BankSlotsFrame"]["Bag"..x]:GetScript("OnClick"),
					click = true,
					isBag = true,
				}

				GameTooltip:ClearLines()
				aParentChilds[tFriendlyName].obj:GetScript("OnEnter")(aParentChilds[tFriendlyName].obj)
				if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
					if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
						local tText = SkuChat:Unescape(TooltipLines_helper(GameTooltip:GetRegions()))
						tText = x.." "..tText
						aParentChilds[tFriendlyName].textFirstLine, aParentChilds[tFriendlyName].textFull = SkuCore:ItemName_helper(tText)
						aParentChilds[tFriendlyName].textFirstLine = L["Bank"].. " "..aParentChilds[tFriendlyName].textFirstLine
					end
				end
			end

			table.insert(tCurrentParentContainer.childs, aParentChilds[tFriendlyName])
			tCurrentParentContainer.childs[aParentChilds[tFriendlyName] ] = aParentChilds[tFriendlyName]
		end

		if fullBankSlots ~= true then
			local cost = SkuGetCoinText(GetBankSlotCost(numPurBankSlots))
			local x = numPurBankSlots + 1
			local containerFrameName = "Bag"..x
			local tFriendlyName = L["Bank"].." "..x.." ".._G["BankSlotsFrame"]["Bag"..x].tooltipText.." "..cost
			if _G["BankSlotsFrame"]["Bag"..x]:IsEnabled() == true then
				aParentChilds[tFriendlyName] = {
					frameName = "BankSlotsFrame.Bag"..x,
					RoC = "Child",
					type = "Button",
					obj = _G["BankSlotsFrame"]["Bag"..x],
					textFirstLine = tFriendlyName,
					textFull = "",
					noMenuNumbers = true,
					childs = {},
					func = PurchaseSlot,
					click = true,
					isBag = true,
					isPurchasable = true,
				}
			end

			table.insert(tCurrentParentContainer.childs, aParentChilds[tFriendlyName])
			tCurrentParentContainer.childs[aParentChilds[tFriendlyName] ] = aParentChilds[tFriendlyName]
		end
	end

	--sort all button
	local tFriendlyName = L["Sorting and cleanup all bags"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = nil,
		RoC = "Child",
		type = "Button",
		obj = nil,
		textFirstLine = tFriendlyName,
		textFull = "",
		noMenuNumbers = true,
		childs = {},
		func = nil,
		click = true,
	}

	BagSortMenuHelper(aParentChilds[tFriendlyName].childs, nil)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function round(num)
	local mult = 10^(2 or 0)
	return math.floor(num * mult + 0.5) / mult
end

---------------------------------------------------------------------------------------------------------------------------------------
--addons









---------------------------------------------------------------------------------------------------------------------------------------
local function GetTooltipLines(aObj, aTooltipObject)
	local tTooltipObj = aTooltipObject or GameTooltip
	tTooltipObj:ClearLines()
	if aObj.GetScript and aObj:GetScript("OnEnter") then
		aObj:GetScript("OnEnter")(aObj)
	end

	local tFirstText
	local tSecondText
	local tTooltipText = ""
	for i = 1, select("#", tTooltipObj:GetRegions()) do
		local region = select(i, tTooltipObj:GetRegions())
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				if not tFirstText then
					tFirstText = text
				else
					if not tSecondText then
						tSecondText = text
					end
				end
				if i == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
					tTooltipText = tTooltipText..text.." ("..tQualityString..")\r\n"
				else
					tTooltipText = tTooltipText..text.."\r\n"
				end

			end
		end
	end

	return tFirstText, tTooltipText, tSecondText
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_TALENT_UPDATE()
	--print("PLAYER_TALENT_UPDATE")
	if _G["PlayerTalentFrame"] and _G["PlayerTalentFrame"]:IsVisible() then
		if SkuOptions:IsMenuOpen() == true then
			C_Timer.After(0.3, function()
				SkuOptions.currentMenuPosition:OnUpdate()
			end)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ACTIVE_TALENT_GROUP_CHANGED(aEvent, aCurr, aPrev)
	if _G["PlayerTalentFrame"] and _G["PlayerTalentFrame"]:IsVisible() then
		if SkuOptions:IsMenuOpen() == true then
			C_Timer.After(0.3, function()
				SkuOptions:SlashFunc(L["short"]..","..L["Local"])
			end)
		end
	end

	SkuCore:UpdateCurrentTalentSet()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GLYPH_ADDED()
	if SkuOptions:IsMenuOpen() == true then
		C_Timer.After(0.1, function()
			SkuOptions.currentMenuPosition.parent:OnUpdate()
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GLYPH_REMOVED()
	SkuCore:GLYPH_ADDED()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GLYPH_UPDATED()
	SkuCore:GLYPH_ADDED()
end

---------------------------------------------------------------------------------------------------------------------------------------
local function Build_BonusFrame(aParentChilds, bonusFrame)
	local ttFirst, ttFull = GetTooltipLines(bonusFrame)
	local tFrameName = bonusFrame:GetName()
	local tFriendlyName = bonusFrame.Label:GetText()
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Text",
		obj = bonusFrame,
		textFirstLine = tFriendlyName,
		textFull = ttFull,
		childs = {},
		click = false,
	}
end

local function Build_TalentSummaryOrSpecChoice(aParentChilds, specPanel)
	local summary = specPanel.Summary
	if not summary then
		return
	end

	--Spec description
	local description = summary.Description
	local tFrameName = description:GetName()
	local descriptionText = "Text: "..description.ScrollChild.Text:GetText()
	table.insert(aParentChilds, descriptionText)
	aParentChilds[descriptionText] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Text",
		obj = description,
		textFirstLine = descriptionText,
		childs = {},
		click = false,
			}

			--Major/active spec bonuses
			--This is a bit hacky for now, the number in the while loop is arbitrary
			local index = 1
			while index <= 100 do
			local bonusFrame = _G[summary:GetName().."ActiveBonus"..index]
			if bonusFrame and bonusFrame:IsShown() then
			Build_BonusFrame(aParentChilds, bonusFrame)
			else --all frames after this are hidden or nil too, so just break
				break
			end
			index = index + 1
		end

		--Small/passive bonuses (Note: includes mastery as the last minor bonus)
		--Again a bit hacky, see above
		local index = 1
		while index < 100 do
			local bonusFrame = _G[summary:GetName().."Bonus"..index]
			if bonusFrame and bonusFrame:IsShown() then
				Build_BonusFrame(aParentChilds, bonusFrame)
			else
				break
			end
			index = index + 1
		end

		--Choose spec button
		--Unfortunately this is just labeled with the name of the spec (since you just click on the header visually)
		--As a result we will need to add some localizable text.
		local chooseSpecButton = _G[specPanel:GetName().."SelectTreeButton"]
		if chooseSpecButton and chooseSpecButton:IsShown() then
			--localize later
			local tFrameName = chooseSpecButton:GetName()
			local tFriendlyName = "Select Specialization"
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				textFirstLine = tFriendlyName,
				obj = chooseSpecButton,
				func = chooseSpecButton:GetScript("OnClick"),
				childs = {},
				click = true,
			}
		end
end

local function Build_SpecTalentTree(aParentChilds, specPanel)
	--There is a maximum of 28 talent buttons (4 to a row)
	--Not all are visible at any one time
	--first add them to a table to be sorted properly
	talentOrder = {}
	for x=1,28 do
		local tFrameName = specPanel:GetName() .. "Talent" .. x
		local talentButton = _G[tFrameName]
		if talentButton and talentButton:IsVisible() then
		table.insert(talentOrder, talentButton)
		end
	end

	--Now sort the table (this sorts in-place)
	table.sort(talentOrder, function(a, b)
	local _, _, _, x1, y1 = a:GetPoint(1)
	local _, _, _, x2, y2 = b:GetPoint(1)
		if y2 < y1 then
			return true
		elseif y1 == y2 and x1 < x2 then
			return true
		end
		return false
	end)

	for index=1,#talentOrder do
		local talentButton = talentOrder[index]
		if talentButton and talentButton:IsVisible() then
			--There seems to be a bug with the Blizzard tooltips
			--Single rank talents don't update rank in their tooltip when a point is invested
			local ttFirst, ttFull = GetTooltipLines(talentButton)
			local tFriendlyName = ttFirst .. "(" .. talentButton.Rank:GetText() or "nil" .. ")"
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = talentButton:GetName(),
				RoC = "Child",
				type = "Button",
				textFirstLine = tFriendlyName,
				textFull = ttFull,
				obj = talentButton,
				childs = {},
			func = talentButton:GetScript("OnClick"),
				click = true,
			}
		end
	end
end

local function Build_SpecPanel(aParentChilds, panelIndex)
	local tFrameName ="PlayerTalentFramePanel" .. panelIndex
	local specPanel = _G[tFrameName]
	if not specPanel or not specPanel:IsVisible() then
		return
	end

	local tFriendlyName = specPanel.Name:GetText()
	if specPanel.HeaderIcon.LockIcon:IsVisible() then
		--Localize later
		tFriendlyName = tFriendlyName .. " (Locked)"
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type="Button",
		obj = specPanel,
		textFirstLine = tFriendlyName,
		childs = {},
		click = false,
	}

	local tParentChilds = aParentChilds[tFriendlyName].childs
	if specPanel.Summary:IsVisible() then
		Build_TalentSummaryOrSpecChoice(tParentChilds, specPanel)
	else
		Build_SpecTalentTree(tParentChilds, specPanel)
	end
end

local function Build_TalentFramePlayerTalentsTab(aParentChilds)
	--The three panels for the specializations
	--Each panel can be in two states: summary or talent tree view
	--All panels have to be in the same state
	for index=1,3 do
		Build_SpecPanel(aParentChilds, index)
	end
end

local function Build_PetInfo(aParentChilds)
	--Pet info is just a few text fields

	--pet name
	local tFrameName = "PlayerTalentFramePetNameText"
	local petName = _G[tFrameName]
	if petName and petName:IsVisible() then
		local nameText = petName:GetText()
		if nameText ~= "" then
			tFriendlyName = "Text: " .. nameText
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Text",
				obj = petLevel,
				textFirstLine = tFriendlyName,
				childs = {},
			}
		end
	end

	--Pet level
	local tFrameName = "PlayerTalentFramePetLevelText"
	local petLevel = _G[tFrameName]
	if petLevel and petLevel:IsVisible() then
		local levelText = petLevel:GetText()
		if levelText ~= "" then
			tFriendlyName = "Text: " .. levelText
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Text",
				obj = petLevel,
				textFirstLine = tFriendlyName,
				childs = {},
			}
		end
	end

	--Pet Type
	local tFrameName = "PlayerTalentFramePetTypeText"
	local petType = _G[tFrameName]
	if petType and petType:IsShown() then
		local typeText = petType:GetText()
		if typeText ~= "" then
			local tFriendlyName = "Text: " .. typeText
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Text",
				obj = petType,
				textFirstLine = tFriendlyName,
				childs = {},
			}
	end
end

	--Pet diet
	local tFrameName = "PlayerTalentFramePetDiet"
	local petDiet = _G[tFrameName]
	if petDiet and petDiet:IsVisible() then
		local ttFirst, ttFull = GetTooltipLines(petDiet)
		--Only ttFirst has text
		local tFriendlyName = "Text: " .. ttFirst
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Text",
			obj = petDiet,
			textFirstLine = tFriendlyName,
			childs = {},
					}
	end
end

local function Build_PetTalents(aParentChilds)
		--Pets only have one spec

	local tFrameName = "PlayerTalentFramePetPanel"
	local specPanel = _G[tFrameName]
	if specPanel and specPanel:IsVisible() then
		local tFriendlyName = specPanel.Name:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFriendlyName,
			RoC = "Child",
			type = "Button",
			obj = specPanel,
			textFirstLine = tFriendlyName,
			childs = {},
			click = true,
		}
		local tParentChilds = aParentChilds[tFriendlyName].childs

		--Pet talent buttons
		local talentOrder = {}
		for x=1,24 do
			local tFrameName = "PlayerTalentFramePetPanelTalent" .. x
			local talentButton = _G[tFrameName]
			if talentButton and talentButton:IsVisible() then
				table.insert(talentOrder, talentButton)
			end
		end

		table.sort(talentOrder, function(a, b)
			local _, _, _, x1, y1 = a:GetPoint(1)
			local _, _, _, x2, y2 = b:GetPoint(1)
				if y2 < y1 then
					return true
				elseif y1 == y2 and x1 < x2 then
					return true
				end
				return false
		end)

		for index=1,#talentOrder do
			local talentButton = talentOrder[index]
				local ttFirst, ttFull = GetTooltipLines(talentButton)
				local tFriendlyName = ttFirst .. "(" .. talentButton.Rank:GetText() .. ")"
			table.insert(tParentChilds, tFriendlyName)
			tParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = talentButton,
				textFirstLine = tFriendlyName,
				textFull = ttFull,
				childs = {},
				func = talentButton:GetScript("OnClick"),
				click = true,
			}
		end
	end
end

local function Build_TalentFramePlayerPetsTab(aParentChilds)
	Build_PetInfo(aParentChilds)
	Build_PetTalents(aParentChilds)
end

local function Build_GlyphSlot(aParentChilds, index)
	local tFrameName = "GlyphFrameGlyph" .. index
	local glyphSlotButton = _G[tFrameName]
	if not glyphSlotButton or not glyphSlotButton:IsVisible() then
		return
	end
	local ttFirst, ttFull, ttSecond = GetTooltipLines(glyphSlotButton)
	ttSecond = ttSecond or ""
	local tFriendlyName = "" .. index .. ": " .. ttSecond.."; "..ttFirst
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = glyphSlotButton,
		textFirstLine = tFriendlyName,
		textFull = ttFull,
		childs = {},
		func = glyphSlotButton:GetScript("OnClick"),
		containerFrameName = tFrameName,
		doSecure = true,
		click = true,
	}
end

local function Build_GlyphSlots(aParentChilds)
	local tFrameName = "GlyphFrame" --not an actual in-game name but the sku object needs a frame name
	local tFriendlyName = "Glyph Slots" --localize later
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = GlyphFrame,
		textFirstLine = tFriendlyName,
		childs = {},
		click = false,
	}
	local tParentChilds = aParentChilds[tFriendlyName].childs
	for i=1,NUM_GLYPH_SLOTS do
		Build_GlyphSlot(tParentChilds, i)
	end
end

function Build_KnownGlyphs(aParentChilds)
	local tFrameName = "GlyphFrame"
	local tFriendlyName = "Known Glyphs" --Localize later
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = GlyphFrame,
		textFirstLine = tFriendlyName,
		childs = {},
		click = false,
	}
	local tParentChilds = aParentChilds[tFriendlyName].childs

	if _G["GlyphFrameScrollFrameScrollBarScrollUpButton"]:IsEnabled() == true then
		local button = _G["GlyphFrameScrollFrameScrollBarScrollUpButton"]
		local tFrameName = button:GetName()
		local ttFirst, ttFull = GetTooltipLines(button)
		local tFriendlyName = "Scroll Up"
		table.insert(tParentChilds, tFriendlyName)
		tParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = button,
			textFirstLine = tFriendlyName,
			textFull = ttFull,
			childs = {},
			func = function()
				HybridScrollFrame_OnMouseWheel(GlyphFrame.scrollFrame, 1)
			end,
			doSecure = true,
			click = true,
		}
	end


	local buttons = GlyphFrame.scrollFrame.buttons
	local headerNum = 1
	for i=1,#buttons do
		local button = buttons[i]
		--Note that a button can either be a header or a glyph itself (header = {minor, major, prime})
			-- for simplicity just check using the glyph info using similar code to the Blizzard UI
			if i <= GetNumGlyphs() then
			local name, glyphType, isKnown, icon, glyphID = GetGlyphInfo(i)
			if name == "header" then
				local tFrameName = "GlyphFrameHeader"..headerNum
				local headerButton = _G[tFrameName]
				if headerButton and headerButton:IsShown() then
					local tFriendlyName = headerButton.name:GetText()
					table.insert(tParentChilds, tFriendlyName)
					tParentChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "Button",
						obj = headerButton,
						textFirstLine = tFriendlyName,
						childs = {},
						--func = headerButton:GetScript("OnClick"),
						--click = true,
					}
				end
				headerNum = headerNum + 1
			else
				local tFrameName = button:GetName()
				local ttFirst, ttFull = GetTooltipLines(button)
				local tFriendlyName = ttFirst
				if isKnown then
					tFriendlyName = tFriendlyName .. " (Known)" --Localize later
				end
				table.insert(tParentChilds, tFriendlyName)
				tParentChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = button,
					textFirstLine = tFriendlyName,
					textFull = ttFull,
					childs = {},
					containerFrameName = tFrameName,
					func =button:GetScript("OnClick"),
					doSecure = true,
					click = true,
				}
			end
		end
	end

	if _G["GlyphFrameScrollFrameScrollBarScrollDownButton"]:IsEnabled() == true then
		local button = _G["GlyphFrameScrollFrameScrollBarScrollDownButton"]
		local tFrameName = button:GetName()
		local ttFirst, ttFull = GetTooltipLines(button)
		local tFriendlyName = "Scroll Down"
		table.insert(tParentChilds, tFriendlyName)
		tParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = button,
			textFirstLine = tFriendlyName,
			textFull = ttFull,
			childs = {},
			--containerFrameName = tFrameName,
			func = function()
				HybridScrollFrame_OnMouseWheel(GlyphFrame.scrollFrame, -1)
			end,
			doSecure = true,
			click = true,
		}
	end

end

local function Build_TalentFramePlayerGlyphsTab(aParentChilds)
	if IsGlyphFlagSet(GLYPH_FILTER_KNOWN) == false then
		ToggleGlyphFilter(GLYPH_FILTER_KNOWN)
		--GlyphFrame_UpdateGlyphList()
	end
	
	if IsGlyphFlagSet(GLYPH_FILTER_UNKNOWN) == true then
		ToggleGlyphFilter(GLYPH_FILTER_UNKNOWN)
		--GlyphFrame_UpdateGlyphList()
	end
	
	GlyphFrame.scrollFrame.stepSize = 250

	Build_GlyphSlots(aParentChilds)
	Build_KnownGlyphs(aParentChilds)
end

function SkuCore:Build_TalentFrame(aParentChilds)
	--Primary and secondary talent sets
	--These buttons are always available (when unlocked.)
	local tFrameName = ""
	local tFriendlyName = L["Talent Sets"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		click = true,
	}

	local tParent = aParentChilds[tFriendlyName].childs
	for x=1,2 do
		local tFrameName = "PlayerSpecTab"..x
		local specFrame = _G[tFrameName]
		if specFrame and specFrame:IsVisible() then
			local ttFirst, ttFull = GetTooltipLines(specFrame)
			local tFriendlyName = ttFirst
			table.insert(tParent, tFriendlyName)
			local tTextFirstLine = ""
			if specFrame:GetChecked() then
				tTextFirstLine = ttFirst .. " (".. L["selected"] .. ")"
			else
				tTextFirstLine = ttFirst
			end
			tParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = specFrame,
				textFirstLine = tTextFirstLine,
				textFull = ttFull,
				childs = {},
				func = specFrame:GetScript("OnClick"),
				click = not specFrame:GetChecked(), --only show a click option if it isn't the current talent set
			}
		end
	end

	--Activate button when changing active talents
	-- Only visible when necessary
	local tFrameName = "PlayerTalentFrameActivateButton"
	local activateButton = _G[tFrameName]
	if activateButton and activateButton:IsVisible() then
		local tFriendlyName = activateButton:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = activateButton,
			textFirstLine = tFriendlyName,
			childs = {},
			func = activateButton:GetScript("OnClick"),
			click = true,
		}
	end

	--The currently selected tab
	local selectedTab = PanelTemplates_GetSelectedTab(PlayerTalentFrame)

	--The three tabs (player talents, pet talents, and glyphs)
	for x = 1,3 do
		local tFrameName = "PlayerTalentFrameTab" .. x
		local frameTab = _G[tFrameName]
		if frameTab and frameTab:IsVisible() then
			local tFriendlyName = frameTab:GetText()
			if selectedTab == x then
				tFriendlyName = tFriendlyName .. " (" .. L["selected"] .. ")"
			end
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFriendlyName,
				RoC = "Child",
				type = "Button",
				obj = frameTab,
				textFirstLine = tFriendlyName,
				func = frameTab:GetScript("OnClick"),
				containerFrameName = tFrameName,
				doSecure = true,
				childs = {},
				click = frameTab:IsEnabled(),
			}
		end
	end

	--Talent frame header text
	--Includes elements such as unspent talent points and level to next talent
	--Only visible on the player talents and pet talents tabs and only when talents aren't maxed out
	local tFrameName = "PlayerTalentFrameHeaderText"
	local headerTextFrame = _G[tFrameName]
	if headerTextFrame and headerTextFrame:IsVisible() then
		local tFriendlyName = "Text: " .. SkuChat:Unescape(headerTextFrame:GetText())
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			friendlyName = tFriendlyName,
			RoC = "Child",
			type = "Text",
			obj = headerTextFrame,
			textFirstLine = tFriendlyName,
			childs = {},
			click = false,
		}
	end

	if selectedTab == TALENTS_TAB then
		Build_TalentFramePlayerTalentsTab(aParentChilds)
	elseif selectedTab == PET_TALENTS_TAB then
		Build_TalentFramePlayerPetsTab(aParentChilds)
	elseif selectedTab == GLYPH_TALENT_TAB then
		Build_TalentFramePlayerGlyphsTab(aParentChilds)
	end

	--Learn talents button
	-- This learns all talents selected in the preview (if preview is enabled)
	local learnButton = _G["PlayerTalentFrameLearnButton"]
	if learnButton and learnButton:IsEnabled() and learnButton:IsVisible() then
		local tFrameName = learnButton:GetName()
		local tFriendlyName = learnButton:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = learnButton,
			textFirstLine = tFriendlyName,
			childs = {},
			func = learnButton:GetScript("OnClick"),
			click = true,
		}
	end

	--The reset button
	--Note that this only clears the talent preview (if enabled)
	local resetButton = _G["PlayerTalentFrameResetButton"]
	if resetButton and resetButton:IsEnabled() and resetButton:IsVisible() then
		local tFrameName = resetButton:GetName()
		local tFriendlyName = resetButton:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			textFirstLine = tFriendlyName,
			obj = resetButton,
			childs = {},
			func = resetButton:GetScript("OnClick"),
			click = true,
		}
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function Build_ReforgingStat(aParentChilds, stat)
	if stat:IsShown() then
		local tFrameName = stat:GetName()
		local tFriendlyName = SkuChat:Unescape(stat.text:GetText())
		if stat:GetChecked() then
			tFriendlyName = tFriendlyName .. "(" .. L["selected"] .. ")"
		end
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = stat,
			textFirstLine = tFriendlyName,
			childs = {},
			func = function(self, downbutton) stat:Click() end, --Usual OnClick doesn't work correctly for some reason
			click = true,
		}
	end
end

function SkuCore:Build_ReforgingFrame(aParentChilds)
--Note: this mostly works, but the frame does not dynamically update correctly and has the wrong name in the local menu at runtime (blizzard frame name and no friendly localized name)

	--item button
	local tFrameName = "ReforgingFrameItemButton"
	local itemButton = _G[tFrameName]

	if itemButton:IsVisible() then
		local tFriendlyName, tDescription = "", ""
		if itemButton.missingText:IsVisible() then
			tFriendlyName = itemButton.missingText:GetText()
			tDescription = ReforgingFrame.missingDescription:GetText()
	else
		tFriendlyName = itemButton.name:GetText()
		tDescription = itemButton.boundStatus:GetText()
	end
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = ReforgingFrame,
			textFirstLine = tFriendlyName,
			textFull = tDescription,
			childs = {},
			func = itemButton:GetScript("OnClick"),
			click = true,
		}
	end

	--Left and right stat panels
--left = current stats, right = reforge stats
	local tLeftFrameName = "ReforgingFrameTitleTextLeft"
	local tRightFrameName = "ReforgingFrameTitleTextRight"
	local tLeftFriendlyName = "left stat"
	local tRightFriendlyName = "right stats"
	local tLeftChilds, tRightChilds = nil, nil
	if ReforgingFrameTitleTextLeft:IsVisible() then
		tLeftFriendlyName = ReforgingFrameTitleTextLeft:GetText() .. " stats"
		table.insert(aParentChilds, tLeftFriendlyName)
		aParentChilds[tLeftFriendlyName] = {
			frameName = tLeftFrameName,
			RoC = "Child",
			type = "Button",
			obj = ReforgingFrameTitleTextLeft,
			textFirstLine = tLeftFriendlyName,
			childs = {},
			click = false,
		}
		tLeftChilds = aParentChilds[tLeftFriendlyName].childs
	end
	if ReforgingFrameTitleTextRight:IsVisible() then
		tRightFriendlyName = ReforgingFrameTitleTextRight:GetText() .. " stats"
		table.insert(aParentChilds, tRightFriendlyName)
		aParentChilds[tRightFriendlyName] = {
			frameName = tRightFrameName,
			RoC = "Child",
			type = "Button",
			obj = ReforgingFrameTitleTextRight,
			textFirstLine = tRightFriendlyName,
			childs = {},
			click = false,
		}
		tRightChilds = aParentChilds[tRightFriendlyName].childs
	end

	for i=1,REFORGE_MAX_STATS_SHOWN do
		local leftStat = _G["ReforgingFrameLeftStat" .. i]
		local rightStat = _G["ReforgingFrameRightStat" .. i]
		if tLeftChilds and leftStat then Build_ReforgingStat(tLeftChilds, leftStat) end
		if tRightChilds and rightStat then Build_ReforgingStat(tRightChilds, rightStat) end
	end

	--Restore message
	local  tFrameName = "ReforgingFrameRestoreMessage"
	local restoreMessage = _G[tFrameName]
	if restoreMessage:IsVisible() then
		local tFriendlyName = "Text: " .. restoreMessage:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Text",
			obj = restoreMessage,
			textFirstLine = tFriendlyName,
			childs = {},
		}
	end

	--Money frame
		local tFrameName = "ReforgingFrameMoneyFrame"
	local moneyFrame = _G[tFrameName]
		if moneyFrame and moneyFrame:IsVisible() then
			local tFriendlyName = "text: " .. SkuGetCoinText(moneyFrame.staticMoney)
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Text",
				obj = moneyFrame,
				textFirstLine = tFriendlyName,
				childs = {},
			}
	end

	--Reforge button
	local tFrameName = "ReforgingFrameReforgeButton"
	local reforgeButton = _G[tFrameName]
	if reforgeButton:IsVisible() then
		local tFriendlyName = reforgeButton:GetText()
		if not reforgeButton:IsEnabled() then
			tFriendlyName = tFriendlyName .. "(" .. L["disabled"] .. ")"
		end
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = reforgeButton,
			textFirstLine = tFriendlyName,
			childs = {},
			func = function(self, downbutton)
				self:Click()
				C_Timer.After(0.1, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate()
				end)
			end,
			click = true,
		}
	end

	--Restore button
	local tFrameName = "ReforgingFrameRestoreButton"
	local restoreButton = _G[tFrameName]
	if restoreButton:IsVisible() then
		local tFriendlyName = restoreButton:GetText()
		if not restoreButton:IsEnabled() then
			tFriendlyName = tFriendlyName .. "(" .. L["disabled"] .. ")"
		end
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = restoreButton,
			textFirstLine = tFriendlyName,
			childs = {},
			func = restoreButton:GetScript("OnClick"),
			click = true,
		}
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function BarberShopOutputHelper(aTable, aName)
	SkuCore.BarberShopLastBannerCaption = _G["BarberShopBannerFrameCaption"]:GetText()
	aTable.obj:GetScript("OnClick")(aTable.obj)
	C_Timer.After(1, function()
		if SkuCore.BarberShopLastBannerCaption ~= _G["BarberShopBannerFrameCaption"]:GetText() and _G["BarberShopBannerFrameCaption"]:GetText() ~= L["Barber Shop"] then
			--print(aName..": ".._G["BarberShopBannerFrameCaption"]:GetText())
			SkuOptions.Voice:OutputStringBTtts(aName..": ".._G["BarberShopBannerFrameCaption"]:GetText(), false, true, 0.8, true, nil, nil, 1, nil, nil, true)
			SkuCore.BarberShopLastBannerCaption = _G["BarberShopBannerFrameCaption"]:GetText()
		else
			--print(aName..": "..L["no description available"])
			SkuOptions.Voice:OutputStringBTtts(aName..": "..L["no description available"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
		end
		SkuCore.BarberShopLastBannerCaption = _G["BarberShopBannerFrameCaption"]:GetText()
	end)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_BarberShopFrame(aParentChilds)
	--gender
	local tFrameName = "GenderSubmenu"
	local tFriendlyName = L["Gender"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		--click = true,
	}
	local tParent = aParentChilds[tFriendlyName].childs

	local tFrameName = "BarberShopFrameMaleButton"
	local tFriendlyName = L["Male"]
	table.insert(tParent, tFriendlyName)
	tParent[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = _G[tFrameName]:GetScript("OnClick"),
		click = true,
	}
	local tFrameName = "BarberShopFrameFemaleButton"
	local tFriendlyName = L["Female"]
	if _G[tFrameName]:IsEnabled() == true then
		table.insert(tParent, tFriendlyName)
		tParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end

	--other
	local tSelectors = {
		[1] = "FaceSelector",
		[2] = "HairStyleSelector",
		[3] = "HairColorSelector",
		[4] = "FacialHairSelector",
		[5] = "SkinColorSelector",
	}
	for x = 1, #tSelectors do
		local tFrameName = tSelectors[x].."Submenu"
		local tFriendlyName = BarberShopFrame[tSelectors[x]].Category:GetText()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			--click = true,
		}
		local tParent = aParentChilds[tFriendlyName]

		local tFrameName = "BarberShopFrame."..tSelectors[x]..".Next"
		local tFriendlyName = L["Next_generic"]
		local tObj = _G["BarberShopFrame"][tSelectors[x]].Next
		table.insert(tParent.childs, tFriendlyName)
		tParent.childs[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = tObj,
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				BarberShopOutputHelper(tParent.childs[tFriendlyName], tParent.textFirstLine)
			end,
			click = true,
		}

		local tFrameName = "BarberShopFrame."..tSelectors[x]..".Prev"
		local tFriendlyName = L["previous_generic"]
		local tObj = _G["BarberShopFrame"][tSelectors[x]].Prev
		table.insert(tParent.childs, tFriendlyName)
		tParent.childs[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = tObj,
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				BarberShopOutputHelper(tParent.childs[tFriendlyName], tParent.textFirstLine)
			end,
			click = true,
		}
	end

	local tFrameName = "BarberShopFrameOkayButton"
	local tFriendlyName = L["Apply settings"]
	local tClick = true
	if _G[tFrameName]:IsEnabled() ~= true then
		tFriendlyName = tFriendlyName.." ("..L["disabled"]..")"
		tClick = nil
	else
		tFriendlyName = tFriendlyName.." ("..SkuGetCoinText(_G["BarberShopFrameMoneyFrame"].staticMoney, true, true)..")"
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = _G[tFrameName]:GetScript("OnClick"),
		click = tClick,
	}

	local tFrameName = "BarberShopFrameResetButton"
	local tFriendlyName = _G[tFrameName]:GetText()
	local tClick = true
	if _G[tFrameName]:IsEnabled() ~= true then
		tFriendlyName = tFriendlyName.." ("..L["disabled"]..")"
		tClick = nil
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = _G[tFrameName]:GetScript("OnClick"),
		click = tClick,
	}

	local tFrameName = "BarberShopFrameCancelButton"
	local tFriendlyName = L["Close"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = C_BarberShop.Cancel,--()_G[tFrameName]:GetScript("OnClick"),
		click = true,
	}
end

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- build lfg helpers
local function SkuLFGBrowse_DoSearch(categoryID, activityIDs)
	--print("SkuLFGBrowse_DoSearch")
	activityIDs = activityIDs or {}
	if (categoryID > 0) then
		--print("  categoryID", categoryID)
		if (#activityIDs == 0) then -- If we have no activities selected in the filter, search for everything in this category.
			--print("   we have no activities selected in the filter, search for everything in this category.")
			activityIDs = C_LFGList.GetAvailableActivities(categoryID);
		end
		for i, v in pairs(activityIDs) do
			--print("     activityIDs", i, v)
		end

		C_LFGList.Search(categoryID, activityIDs);
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:LFG_LIST_SEARCH_RESULT_UPDATED(aEvent)
	--SkuCore:UpdateResults(aEvent)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:LFG_LIST_SEARCH_RESULTS_RECEIVED(aEvent)
	SkuCore:UpdateResults(aEvent)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tBrowseResultsParent
local tBrowseResultsParentResults = nil
local tBrowseResultsUpdate

local tBrowseCatSelected = 0
local tBrowseActsSelected = {}

local tEnlistRolesSelected = nil
local tEnlistCatSelected = 0
local tEnlistActsSelected = {}
local tEnlistCurrentCommentText = ""

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UpdateResults(aEvent)
	--print("UpdateResults", aEvent)

	if tBrowseResultsParent then
		if tBrowseResultsUpdate == true then
			tBrowseResultsUpdate = nil
			tBrowseResultsParentResults = {}

			local totalResults, results = C_LFGList.GetFilteredSearchResults()
			LFGBrowseUtil_SortSearchResults(results);
			--refresh
			local tFriendlyName = L["Refresh list"]
			table.insert(tBrowseResultsParentResults, tFriendlyName)
			tBrowseResultsParentResults[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGBrowseFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function()
					tBrowseResultsUpdate = true
					local tidtable = {}
					for i, v in pairs(tBrowseActsSelected) do
						if v == true then
							table.insert(tidtable, i)
						end
					end

					SkuLFGBrowse_DoSearch(tBrowseCatSelected, tidtable)
				end,
				click = true,
			}

			for x = 1, totalResults do
				if results[x] then
					local tSearchResultData = C_LFGList.GetSearchResultInfo(results[x])

					--print(SkuLFGBrowseSearchEntryHost.Level:GetText(), SkuLFGBrowseSearchEntryHost:GetScript("OnEnter"))
					--https://github.com/Gethe/wow-ui-source/blob/2c60503f93354eb51acc6cf8063e0314f6b03344/Interface/AddOns/Blizzard_LookingForGroupUI/Blizzard_LFGBrowse.lua#L395
					--/dump C_LFGList.GetSearchResultInfo(192)
						--https://wowpedia.fandom.com/wiki/API_C_LFGList.GetSearchResultInfo
					local tFirst, tFull = "", ""

					if tSearchResultData.numMembers == 1 then
						local name, role, classFile, className, level = C_LFGList.GetSearchResultMemberInfo(results[x], 1);
						tFull =
						L["solo"].."\r\n"..
						L["name"]..": "..(SkuChat:Unescape(tSearchResultData.leaderName) or L["unknown"]).."\r\n"..
						L["klasse"]..": "..(SkuChat:Unescape(className) or L["unknown"]).."\r\n"..
						L["Level"]..": "..(SkuChat:Unescape(level) or L["unknown"]).."\r\n"..
						L["comment"]..": "..(SkuChat:Unescape(tSearchResultData.comment) or L["unknown"])
						if tSearchResultData.newPlayerFriendly == true then
							tFull = tFull.."\r\n"..L["new Player Friendly"]
						end
						if tSearchResultData.requiredItemLevel > 0 then
							tFull = tFull.."\r\n"..L["required Item Level"]..": "..tSearchResultData.requiredItemLevel
						end
						if tSearchResultData.requiredHonorLevel > 0 then
							tFull = tFull.."\r\n"..L["required Honor Level"]..": "..tSearchResultData.requiredHonorLevel
						end
						if tSearchResultData.isDelisted == true then
							tFull = tFull.."\r\n"..L["is Delisted"]
						end
					else
						tFull =
						L["Party"].."\r\n"..
						L["leader"]..": "..(SkuChat:Unescape(tSearchResultData.leaderName) or L["unknown"]).."\r\n"..
						L["comment"]..": "..(SkuChat:Unescape(tSearchResultData.comment) or L["unknown"]).."\r\n"..
						L["Members"]..": "..(SkuChat:Unescape(tSearchResultData.numMembers) or L["unknown"])
						--"hasSelf: "..(tostring(tSearchResultData.hasSelf) or "nil")
						if tSearchResultData.newPlayerFriendly == true then
							tFull = tFull.."\r\n"..L["new Player Friendly"]
						end
						if tSearchResultData.requiredItemLevel > 0 then
							tFull = tFull.."\r\n"..L["required Item Level"]..": "..tSearchResultData.requiredItemLevel
						end
						if tSearchResultData.requiredHonorLevel > 0 then
							tFull = tFull.."\r\n"..L["required Honor Level"]..": "..tSearchResultData.requiredHonorLevel
						end
						if tSearchResultData.isDelisted == true then
							tFull = tFull.."\r\n"..L["is Delisted"]
						end

						if tSearchResultData.numMembers > 1 then
							tFull = tFull.."\r\n"..L["Members"]..":"

							local resultID = results[x]
							for i=1, tSearchResultData.numMembers do
								local name, role, classFileName, className, level, isLeader = C_LFGList.GetSearchResultMemberInfo(resultID, i);
								tFull = tFull.."\r\n"..(SkuChat:Unescape(name) or L["unknown"])..", "..(level or L["unknown"])..", "..(_G[role] or L["unknown"])..", "..(SkuChat:Unescape(className) or L["unknown"])
							end
						end
					end

					-- full Activities
					local fullActivityText = "";
					local lastActivityString = nil
					local numActivities = #tSearchResultData.activityIDs;
					local activeEntryInfo = C_LFGList.GetActiveEntryInfo();

					if (numActivities > 0) then
						tFull = tFull.."\r\n"..L["Activities"]..":"

						local organizedActivities = LFGUtil_OrganizeActivitiesByActivityGroup(tSearchResultData.activityIDs);
						local activityGroupIDs = GetKeysArray(organizedActivities);
						numActivityGroups = #activityGroupIDs;
						LFGUtil_SortActivityGroupIDs(activityGroupIDs);

						for i, activityGroupID in ipairs(activityGroupIDs) do
							local activityIDs = organizedActivities[activityGroupID];
							if (activityGroupID == 0) then -- Free-floating activities (no group)
								for _, activityID in ipairs(activityIDs) do
									local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
									if (activityInfo and activityInfo.fullName ~= "") then
										fullActivityText = fullActivityText..activityInfo.fullName.."\r\n"
									end
								end
							else -- Grouped activities
								local activityGroupName = C_LFGList.GetActivityGroupInfo(activityGroupID);
								for _, activityID in ipairs(activityIDs) do
									local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
									if (activityInfo and activityInfo.fullName ~= "") then
										fullActivityText = fullActivityText..activityInfo.fullName.." ("..activityGroupName..")".."\r\n"
									end
								end
							end
						end
					end

					tFull = tFull.."\r\n"..fullActivityText

					--short activitie for title
					local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
					local matchingActivities = {};
					local hasMatchingActivity = false;
					if (activeEntryInfo) then
						for _, activityID in ipairs(activeEntryInfo.activityIDs) do
							if (tContains(tSearchResultData.activityIDs, activityID)) then
								hasMatchingActivity = true;
								tinsert(matchingActivities, activityID);
							end
						end
					end
					local activitiesToDisplay = hasMatchingActivity and matchingActivities or tSearchResultData.activityIDs;

					local activityText = "";
					if ( tSearchResultData.hasSelf ) then
						activityText = LFG_SELF_LISTING;
					elseif ( #activitiesToDisplay == 1 ) then
						local activityInfo = C_LFGList.GetActivityInfoTable(activitiesToDisplay[1]);
						activityText = activityInfo.fullName;
					else
						local activityString = hasMatchingActivity and LFGBROWSE_ACTIVITY_MATCHING_COUNT or LFGBROWSE_ACTIVITY_COUNT;
						--activityText = string.format(activityString, #activitiesToDisplay);
						activityText = #activitiesToDisplay.." "..L["Activities"]
					end

					--build title string
					local tTypeText = ""
					if tSearchResultData.numMembers == 1 then
						tTypeText = ", "..L["solo"]..", "
						local resultID = results[x]
						local name, role, classFileName, className, level, isLeader = C_LFGList.GetSearchResultMemberInfo(resultID, 1);
						tTypeText = tTypeText.." "..(level or "")..", "..(_G[role] or "")..", "..(className or "")..", "
					else
						tTypeText = ", "..L["Party"].." ("..tSearchResultData.numMembers..", "
						local resultID = results[x]
						for i=1, tSearchResultData.numMembers do
							local name, role, classFileName, className, level, isLeader = C_LFGList.GetSearchResultMemberInfo(resultID, i);
							tTypeText = tTypeText.." "..(_G[role] or "")..", "
						end
						tTypeText = tTypeText.."), "
					end

					--add entry
					local tFriendlyName = (tSearchResultData.leaderName or L["unknown name"])..tTypeText..", "..activityText
					table.insert(tBrowseResultsParentResults, tFriendlyName)
					tBrowseResultsParentResults[tFriendlyName] = {
						frameName = "",
						RoC = "Child",
						type = "Button",
						obj = _G["LFGBrowseFrame"],
						textFirstLine = SkuChat:Unescape(tFriendlyName),
						textFull = SkuChat:Unescape(tFull),
						childs = {},
						func = function()
							local tSearchResultData = C_LFGList.GetSearchResultInfo(results[x])
							if tSearchResultData.isDelisted == true then
								C_Timer.After(0.4, function()
									print(L["Not longer available. Refresh list."])
									SkuOptions.Voice:OutputStringBTtts(L["Not longer available. Refresh list."], true, true, 0.8, true, nil, nil, 1, nil, nil, true)
								end)
							else
								EasyMenu(LFGBrowseFrame:GetSearchEntryMenu(results[x]), LFGBrowseFrame.SearchEntryDropDown, "cursor", nil, nil, "MENU");
								C_Timer.After(0.1, function()
									SkuOptions:SlashFunc(L["short"]..","..L["Local"]..","..L["Dropdown List 1"])
									C_Timer.After(2.1, function()
										SkuOptions.currentMenuPosition:OnSelect()
									end)
								end)
							end
						end,
						click = true,
					}
				else
					print("this should not happen; missing data")
				end
			end
			SkuCore:CheckFrames()
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_LfgFrame(aParentChilds)

	--bad hack to fully close the lfg pane
	local ttime = 0
	local f = _G["Build_LfgFrameControl"] or CreateFrame("Frame", "Build_LfgFrameControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		ttime = ttime + time
		if ttime > 5 then
			if _G["LFGParentFrame"] and _G["LFGListingFrame"] and _G["LFGBrowseFrame"] then
				if (_G["LFGListingFrame"]:IsVisible() == false and _G["LFGBrowseFrame"]:IsVisible() == false) and _G["LFGParentFrame"]:IsVisible() == true then
					_G["LFGParentFrame"]:Hide()
				end
			end
			ttime = 0
		end
	end)

	--prep roles table
	if not tEnlistRolesSelected then
		tEnlistRolesSelected = {
			[1] = {name = _G["DAMAGER"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonDPS"},
			[2] = {name = _G["TANK"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonTank"},
			[3] = {name = _G["HEALER"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonHealer"},
			[4] = {name = L["new Player Friendly"], selected = false, buttonName = "LFGListingFrameNewPlayerFriendlyButton"},
		}
		tEnlistRolesSelected[tRolenamesLookup[GetTalentGroupRole(GetActiveTalentGroup())]].selected = true
		UnitSetRole("player", GetTalentGroupRole(GetActiveTalentGroup()))

		C_LFGList.SetRoles({
			tank   = tEnlistRolesSelected[2].selected,
			healer = tEnlistRolesSelected[3].selected,
			dps    = tEnlistRolesSelected[1].selected,
		})
	end

	--ENLIST
	local tFrameName = ""
	local tFriendlyName = L["Enlist"]
	if _G["MiniMapLFGFrame"] and _G["MiniMapLFGFrame"]:IsVisible() == true then
		tFriendlyName = tFriendlyName.." ("..L["Enlisted"]..")"
	end

	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G["LFGListingFrame"],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}
	local tEnlistParent = aParentChilds[tFriendlyName].childs

	if (IsInGroup("player") == true or IsInRaid("player") == true) then
		if (UnitIsGroupLeader("player") == true) then
			--role check button
			if _G["LFGListingFrameGroupRoleButtonsInitiateRolePoll"] and _G["LFGListingFrameGroupRoleButtonsInitiateRolePoll"]:IsEnabled() == true then
				local tFriendlyName = _G["LFGListingFrameGroupRoleButtonsInitiateRolePoll"]:GetText()
				table.insert(tEnlistParent, tFriendlyName)
				tEnlistParent[tFriendlyName] = {
					frameName = "",
					RoC = "Child",
					type = "Button",
					obj = _G["LFGListingFrame"],
					textFirstLine = SkuChat:Unescape(tFriendlyName),
					textFull = "",
					childs = {},
					func = function()
						InitiateRolePoll()
						C_Timer.After(0.3, function()
							SkuOptions.currentMenuPosition.parent:OnUpdate()
						end)
					end,
					click = true,
				}
			end

			--npf
			local tFriendlyName = tEnlistRolesSelected[4].name
			if tEnlistRolesSelected[4].selected == true then
				tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
			end
			table.insert(tEnlistParent, tFriendlyName)
			tEnlistParent[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function(self)
					tEnlistRolesSelected[4].selected = tEnlistRolesSelected[4].selected == false
					C_Timer.After(0.3, function()
						SkuOptions.currentMenuPosition:OnUpdate()
					end)
				end,
				click = true,
			}

			--to implement: update post



		else
			if _G["LFGParentFrameTab1"] then
				_G["LFGParentFrameTab1"]:Click(_G["LFGParentFrameTab1"])
			end
			if _G["LFGListingFrameLockedViewErrorText"]:IsVisible() == true then
				local tFriendlyName = _G["LFGListingFrameLockedViewErrorText"]:GetText().." ".._G["LFGListingFrameLockedViewActivityText"]:GetText()
				local tFull = ""

				for i, v in LFGListingFrameLockedView.framePool:EnumerateActive() do
					tFull = i.Text:GetText().."\r\n"..tFull
				end
				tFull = _G["LFGListingFrameLockedViewErrorText"]:GetText().."\r\n".._G["LFGListingFrameLockedViewActivityText"]:GetText().."\r\n"..tFull

				table.insert(tEnlistParent, tFriendlyName)
				tEnlistParent[tFriendlyName] = {
					frameName = "",
					RoC = "Child",
					type = "Button",
					obj = _G["LFGListingFrame"],
					textFirstLine = SkuChat:Unescape(tFriendlyName),
					textFull = SkuChat:Unescape(tFull),
					childs = {},
					click = false,
				}
			end
		end

		-- rolle dd
		local tFrameName = ""
		local tFriendlyName = L["your role"]
		table.insert(tEnlistParent, tFriendlyName)
		tEnlistParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
		local tEnlistRolestParent = tEnlistParent[tFriendlyName].childs

		for x = 1, 3 do
			local tFriendlyName = tEnlistRolesSelected[x].name
			if tEnlistRolesSelected[x].selected == true then
				tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
			end
			table.insert(tEnlistRolestParent, tFriendlyName)
			tEnlistRolestParent[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function()
					for x = 1, 3 do
						tEnlistRolesSelected[x].selected = false
					end

					tEnlistRolesSelected[x].selected = true
					UnitSetRole("player", tRolenamesLookup[x])

					C_Timer.After(0.3, function()
						SkuOptions.currentMenuPosition:OnUpdate()
					end)
				end,
				click = true,
			}
		end

	else
		--no group
		--role selection on solo
		local tFrameName = ""
		local tFriendlyName = L["roles"]
		table.insert(tEnlistParent, tFriendlyName)
		tEnlistParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
		local tEnlistRolestParent = tEnlistParent[tFriendlyName].childs

		if tEnlistRolesSelected == nil then
			tEnlistRolesSelected = {
				[1] = {name = _G["DAMAGER"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonDPS"},
				[2] = {name = _G["TANK"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonTank"},
				[3] = {name = _G["HEALER"], selected = false, buttonName = "LFGListingFrameSoloRoleButtonsRoleButtonHealer"},
				[4] = {name = L["new Player Friendly"], selected = false, buttonName = "LFGListingFrameNewPlayerFriendlyButton"},
			}

			for x = 1, #tEnlistRolesSelected do
				if _G[tEnlistRolesSelected[x].buttonName] then
					_G[tEnlistRolesSelected[x].buttonName].CheckButton:SetChecked(false)
				end
			end

			for i=1,GetNumTalentGroups() do
				tEnlistRolesSelected[tRolenamesLookup[GetTalentGroupRole(i)]].selected = true
				if _G[tEnlistRolesSelected[tRolenamesLookup[GetTalentGroupRole(i)]].buttonName] then
					_G[tEnlistRolesSelected[tRolenamesLookup[GetTalentGroupRole(i)]].buttonName].CheckButton:SetChecked(true)
				end
			end
		end

		for x = 1, #tEnlistRolesSelected do
			local tFriendlyName = tEnlistRolesSelected[x].name
			if tEnlistRolesSelected[x].selected == true then
				tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
			end
			table.insert(tEnlistRolestParent, tFriendlyName)
			tEnlistRolestParent[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function()
					tEnlistRolesSelected[x].selected = tEnlistRolesSelected[x].selected == false
					if _G[tEnlistRolesSelected[x].buttonName] then
						_G[tEnlistRolesSelected[x].buttonName].CheckButton:SetChecked(tEnlistRolesSelected[x].selected)
					end
					C_LFGList.SetRoles({
						tank   = tEnlistRolesSelected[2].selected,
						healer = tEnlistRolesSelected[3].selected,
						dps    = tEnlistRolesSelected[1].selected,
					})
					C_Timer.After(0.3, function()
						SkuOptions.currentMenuPosition:OnUpdate()
					end)
				end,
				click = true,
			}
		end
	end

	if ((IsInGroup("player") == true or IsInRaid("player") == true) and (UnitIsGroupLeader("player") == true)) or
	(IsInGroup("player") == false and IsInRaid("player") == false) then

		local tFrameName = ""
		local tFriendlyName = L["category"]
		table.insert(tEnlistParent, tFriendlyName)
		tEnlistParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
		local tEnlistCatParent = tEnlistParent[tFriendlyName].childs

		--categories
		local info = UIDropDownMenu_CreateInfo();
		local categories = C_LFGList.GetAvailableCategories();
		if (#categories == 0) then
			-- None button
			local tFriendlyName = LFG_TYPE_NONE
			table.insert(tEnlistCatParent, tFriendlyName)
			tEnlistCatParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = SkuChat:Unescape(tCurrentGemTooltip),
				childs = {},
				click = false,
			}
		else
			local currentSelectedValue = UIDropDownMenu_GetSelectedValue(self) or 0;
			local foundChecked = false;
			for i=1, #categories do
				local name = C_LFGList.GetCategoryInfo(categories[i]);

				info.text = name;
				info.value = categories[i];

				local tEnlistCategories = {
					[1] = 2,
					[2] = 114,
					[3] = 116,
					[4] = 118,
					[5] = 120,
				}

				tEnlistCategories = categories

				local tFriendlyName = name
				if info.checked then
					tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
				end
				table.insert(tEnlistCatParent, tFriendlyName)
				tEnlistCatParent[tFriendlyName] = {
					frameName = "",
					RoC = "Child",
					type = "Button",
					obj = _G["LFGListingFrame"],
					textFirstLine = SkuChat:Unescape(tFriendlyName),
					textFull = "",
					childs = {},
					func = function()
						tEnlistCatSelected = tEnlistCategories[i]
						C_Timer.After(0.3, function()
							SkuOptions.currentMenuPosition:OnUpdate()
						end)
						--SkuLFGEnlist_DoSearch(tEnlistCategories[i])
					end,
					click = true,
				}
			end
		end

		--activities
		local tFrameName = ""
		local tFriendlyName = L["Activity"]
		table.insert(tEnlistParent, tFriendlyName)
		tEnlistParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
		local tEnlistActParent = tEnlistParent[tFriendlyName].childs

		--build list of available activities
		local tActivityList = {}
		local activities = C_LFGList.GetAvailableActivities(tEnlistCatSelected)
		if (#activities > 0) then
			local organizedActivities = LFGUtil_OrganizeActivitiesByActivityGroup(activities);
			local activityGroupIDs = GetKeysArray(organizedActivities);
			LFGUtil_SortActivityGroupIDs(activityGroupIDs);

			for _, activityGroupID in ipairs(activityGroupIDs) do
				local activityIDs = organizedActivities[activityGroupID];
				if (activityGroupID == 0) then
					local buttonInfo = {}
					for _, activityID in pairs(activityIDs) do
						local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
						tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName, "  ", " "), "", id = activityID}
					end
				else
					-- Grouped activities.
					local groupButtonInfo = {}
					--tActivityList[#tActivityList + 1] = {title = string.gsub(C_LFGList.GetActivityGroupInfo(activityGroupID), "  ", " "), id = activityGroupID}

					if (#activityGroupIDs == 1) then -- If we only have one activityGroup, do everything in one menu.
						for _, activityID in pairs(activityIDs) do
							local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
							tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName, "  ", " "), id = activityID}
						end
					else -- If we have more than one group, do submenus.
						for _, activityID in pairs(activityIDs) do
							local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
							tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName.." ("..string.gsub(C_LFGList.GetActivityGroupInfo(activityGroupID), "  ", " ")..")", "  ", " "), id = activityID}
						end
					end
				end
			end
		end

		--deselect all
		local tFriendlyName = L["Deselect all"]
		table.insert(tEnlistActParent, tFriendlyName)
		tEnlistActParent[tFriendlyName] = {
			frameName = "",
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				tEnlistActsSelected = {}
				C_Timer.After(0.3, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate()
				end)
				--tEnlistResultsUpdate = true
				--SkuLFGEnlist_DoSearch(tEnlistCatSelected)
			end,
			click = true,
		}

		--add activities
		for x = 1, #tActivityList do
			local tFriendlyName = tActivityList[x].title
			if tEnlistActsSelected[tActivityList[x].id] == true then
				tFriendlyName = L["selected"].." "..tFriendlyName
			end

			table.insert(tEnlistActParent, tFriendlyName)
			tEnlistActParent[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrame"],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function()
					if tEnlistActsSelected[tActivityList[x].id] == true then
						tEnlistActsSelected[tActivityList[x].id] = nil
					else
						tEnlistActsSelected[tActivityList[x].id] = true
					end
					--tEnlistResultsUpdate = true
					local tidtable = {}
					for i, v in pairs(tEnlistActsSelected) do
						if v == true then
							table.insert(tidtable, i)
						end
					end
					C_Timer.After(0.3, function()
						SkuOptions.currentMenuPosition:OnUpdate()
					end)

					--SkuLFGEnlist_DoSearch(tEnlistCatSelected, tidtable)
				end,
				click = true,
			}
		end

		local tFrameName = ""
		local tFriendlyName = L["add/edit comment"]
		table.insert(tEnlistParent, tFriendlyName)
		tEnlistParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGListingComment"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				C_Timer.After(0.8, function()
					SkuOptions.Voice:OutputStringBTtts(L["input comment text and complete with escape"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
				end)
				if _G["LFGListingComment"] and LFGListingFrameCategoryView and LFGListingFrameCategoryView.CategoryButtons[1] then
					LFGListingFrameCategoryView.CategoryButtons[1]:Click()
					LFGListingComment.EditBox:SetFocus()
					LFGListingComment.EditBox:HookScript("OnEditFocusLost", function(self)
						C_Timer.After(0.1, function()
							PlaySound(89)
							tEnlistCurrentCommentText = _G["LFGListingComment"].EditBox:GetText() or ""
							SkuOptions.currentMenuPosition:OnUpdate()
						end)

					end)

				end
			end,
			click = true,
		}

		if LFGListingFrameBackButton:IsEnabled() == true and LFGListingFramePostButton:IsEnabled() == false and (LFGListingFramePostButton:GetText() == L["Update"]) then
			local tFrameName = ""
			local tFriendlyName = L["Delist"]
			table.insert(tEnlistParent, tFriendlyName)
			tEnlistParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFrameBackButton"],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				childs = {},
				click = true,
				--func = _G["LFGListingFramePostButton"]:GetScript("OnClick"),
				func = function()
					local tResult = C_LFGList.RemoveListing()
				end,
			}
		else
			local tFrameName = ""
			local tFriendlyName = _G["LFGListingFramePostButton"]:GetText()
			table.insert(tEnlistParent, tFriendlyName)
			tEnlistParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G["LFGListingFramePostButton"],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				click = true,
				--func = _G["LFGListingFramePostButton"]:GetScript("OnClick"),
				func = function()
					local tidtable = {}
					local hasSelectedActivity = false
					local x = 1
					local selectedActivityIDs = {}
					for i, v in pairs(tEnlistActsSelected) do
						if v == true then
							hasSelectedActivity = true
							selectedActivityIDs[x] = i
							x = x + 1
						end
					end

					if (tEnlistCatSelected == 0) then
						print(L["fail. no category selected"])
						C_Timer.After(0.4, function()
							SkuOptions.Voice:OutputStringBTtts(L["fail. no category selected"], true, true, 0.1, true, nil, nil, 1, nil, nil, true)
						end)
						return
					end
					if (hasSelectedActivity == false) then
						print(L["fail. no activity selected"])
						C_Timer.After(0.4, function()
							SkuOptions.Voice:OutputStringBTtts(L["fail. no activity selected"], true, true, 0.1, true, nil, nil, 1, nil, nil, true)
						end)
						return
					end
					if (tEnlistCatSelected == 120) and (tEnlistCurrentCommentText == "") then
						print(L["fail. no comment for category custom entered"])
						C_Timer.After(0.4, function()
							SkuOptions.Voice:OutputStringBTtts(L["fail. no comment for category custom entered"], true, true, 0.1, true, nil, nil, 1, nil, nil, true)
						end)
						return
					end

					local newPlayerFriendlyEnabled = tEnlistRolesSelected[4].selected or false
					local tResult = C_LFGList.CreateListing(selectedActivityIDs, newPlayerFriendlyEnabled);
					--print("listed", tResult)

				end,
			}
		end
	end


	--BROWSE
	local tFrameName = ""
	local tFriendlyName = L["Browse"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G["LFGBrowseFrame"],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}
	local tBrowseParent = aParentChilds[tFriendlyName].childs

		local tFrameName = ""
		local tFriendlyName = L["category"]
		table.insert(tBrowseParent, tFriendlyName)
		tBrowseParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G["LFGBrowseFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
		local tBrowseCatParent = tBrowseParent[tFriendlyName].childs

			--categories
			local info = UIDropDownMenu_CreateInfo();
			local categories = C_LFGList.GetAvailableCategories();
			if (#categories == 0) then
				-- None button
				local tFriendlyName = LFG_TYPE_NONE
				table.insert(tBrowseCatParent, tFriendlyName)
				tBrowseCatParent[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G["LFGBrowseFrame"],
					textFirstLine = SkuChat:Unescape(tFriendlyName),
					textFull = SkuChat:Unescape(tCurrentGemTooltip),
					childs = {},
					click = false,
				}
			else
				local currentSelectedValue = UIDropDownMenu_GetSelectedValue(self) or 0;
				local foundChecked = false;
				for i=1, #categories do
					local name = C_LFGList.GetCategoryInfo(categories[i]);

					info.text = name;
					info.value = categories[i];
					info.func = LFGBrowseCategoryButton_OnClick;
					info.owner = self;
					info.checked = currentSelectedValue == info.value;
					info.classicChecks = true;
					if (info.checked) then
						UIDropDownMenu_SetSelectedValue(self, info.value);
						foundChecked = true;
					end

					--[[
					local tBrowseCategories = {
						[1] = 2,
						[2] = 114,
						[3] = 116,
						[4] = 118,
						[5] = 120,
					}
					]]

					tBrowseCategories = categories

					local tFriendlyName = name
					if info.checked then
						tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
					end
					table.insert(tBrowseCatParent, tFriendlyName)
					tBrowseCatParent[tFriendlyName] = {
						frameName = "",
						RoC = "Child",
						type = "Button",
						obj = _G["LFGBrowseFrame"],
						textFirstLine = SkuChat:Unescape(tFriendlyName),
						textFull = "",
						childs = {},
						func = function()
							tBrowseResultsUpdate = true
							tBrowseCatSelected = tBrowseCategories[i]
							SkuLFGBrowse_DoSearch(tBrowseCategories[i])
						end,
						click = true,
					}
				end
			end

			--activities
			local tFrameName = ""
			local tFriendlyName = L["Activity"]
			table.insert(tBrowseParent, tFriendlyName)
			tBrowseParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G["LFGBrowseFrame"],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
			}
			local tBrowseActParent = tBrowseParent[tFriendlyName].childs

			--build list of available activities
			local tActivityList = {}
			local activities = C_LFGList.GetAvailableActivities(tBrowseCatSelected)
			if (#activities > 0) then
				local organizedActivities = LFGUtil_OrganizeActivitiesByActivityGroup(activities);
				local activityGroupIDs = GetKeysArray(organizedActivities);
				LFGUtil_SortActivityGroupIDs(activityGroupIDs);

				for _, activityGroupID in ipairs(activityGroupIDs) do
					local activityIDs = organizedActivities[activityGroupID];
					if (activityGroupID == 0) then
						local buttonInfo = {}
						for _, activityID in pairs(activityIDs) do
							local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
							tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName, "  ", " "), "", id = activityID}
						end
					else
						-- Grouped activities.
						local groupButtonInfo = {}
						tActivityList[#tActivityList + 1] = {title = string.gsub(C_LFGList.GetActivityGroupInfo(activityGroupID), "  ", " "), id = activityGroupID}

						if (#activityGroupIDs == 1) then -- If we only have one activityGroup, do everything in one menu.
							for _, activityID in pairs(activityIDs) do
								local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
								tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName, "  ", " "), id = activityID}
							end
						else -- If we have more than one group, do submenus.
							for _, activityID in pairs(activityIDs) do
								local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
								tActivityList[#tActivityList + 1] = {title = string.gsub(activityInfo.fullName.." ("..string.gsub(C_LFGList.GetActivityGroupInfo(activityGroupID), "  ", " ")..")", "  ", " "), id = activityID}
							end
						end
					end
				end
			end

			--deselect all
			local tFriendlyName = L["Deselect all"]
			table.insert(tBrowseActParent, tFriendlyName)
			tBrowseActParent[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = _G["LFGBrowseFrame"],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function()
					tBrowseActsSelected = {}
					tBrowseActsSelected = {}
					tBrowseResultsUpdate = true
					SkuLFGBrowse_DoSearch(tBrowseCatSelected)
				end,
				click = true,
			}

			--add activities
			for x = 1, #tActivityList do
				local tFriendlyName = tActivityList[x].title
				if tBrowseActsSelected[tActivityList[x].id] == true then
					tFriendlyName = L["selected"].." "..tFriendlyName
				end

				table.insert(tBrowseActParent, tFriendlyName)
				tBrowseActParent[tFriendlyName] = {
					frameName = "",
					RoC = "Child",
					type = "Button",
					obj = _G["LFGBrowseFrame"],
					textFirstLine = SkuChat:Unescape(tFriendlyName),
					textFull = "",
					childs = {},
					func = function()
						if tBrowseActsSelected[tActivityList[x].id] == true then
							tBrowseActsSelected[tActivityList[x].id] = nil
						else
							tBrowseActsSelected[tActivityList[x].id] = true
						end
						tBrowseResultsUpdate = true
						local tidtable = {}
						for i, v in pairs(tBrowseActsSelected) do
							if v == true then
								table.insert(tidtable, i)
							end
						end

						SkuLFGBrowse_DoSearch(tBrowseCatSelected, tidtable)
					end,
					click = true,
				}
			end

			--results
			local tFrameName = ""
			local tFriendlyName = L["Results"]
			table.insert(tBrowseParent, tFriendlyName)
			tBrowseParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G["LFGBrowseFrame"],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
			}
			tBrowseResultsParent = tBrowseParent[tFriendlyName].childs
			if tBrowseResultsParentResults then
				tBrowseParent[tFriendlyName].childs = tBrowseResultsParentResults
			end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_RolePollPopup(aParentChilds)


	local tButtons = {
		[1] = _G["RolePollPopupRoleButtonTank"],
		[2] = _G["RolePollPopupRoleButtonHealer"],
		[3] = _G["RolePollPopupRoleButtonDPS"],
	}

	for x = 1, #tButtons do
		if tButtons[x].checkButton:IsVisible() == true then
			local tFriendlyName = _G[tButtons[x].role]

			if tButtons[x].checkButton:GetChecked() == true then
				tFriendlyName = tFriendlyName.." ("..L["selected"]..")"
			end

			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = "",
				RoC = "Child",
				type = "Button",
				obj = tButtons[x],
				textFirstLine = SkuChat:Unescape(tFriendlyName),
				textFull = "",
				childs = {},
				func = function()
					tButtons[x]:Click("LeftMouse")
					C_Timer.After(0.3, function()
						SkuOptions.currentMenuPosition:OnUpdate()
					end)
				end,
				click = true,
			}
		end
	end


	if _G["RolePollPopupAcceptButton"]:IsEnabled() == true then
		local tFriendlyName = _G["RolePollPopupAcceptButton"]:GetText()

		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = "",
			RoC = "Child",
			type = "Button",
			obj = _G["RolePollPopupAcceptButton"],
			textFirstLine = SkuChat:Unescape(tFriendlyName),
			textFull = "",
			childs = {},
			func = function()
				_G["RolePollPopupAcceptButton"]:Click("LeftMouse")
			end,
			click = true,
		}
	end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_CharacterFrame(aParentChilds)
	if _G["GearManagerToggleButton"] then
		_G["GearManagerToggleButton"]:Click("LeftMouse")
	end

	local tFrameName = "CharacterLevelText"
	local tFriendlyName = _G["CharacterLevelText"]:GetText()
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "FontString",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}

	--items
	local tFrameName = ""
	local tFriendlyName = L["Equipment"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		--click = true,
	}
	local tParentEquipment = aParentChilds[tFriendlyName].childs

		--items submenu
		local tFrameName = "PaperDollItemsFrame"
		local tFriendlyName = L["Items"]
		table.insert(tParentEquipment, tFriendlyName)
		tParentEquipment[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			--click = true,
		}
		tParentEquipment[tFriendlyName].childs = SkuCore:IterateChildren(tParentEquipment[tFriendlyName].obj, 2)

		--print(tParentEquipment[tFriendlyName].childs["GearManagerToggleButton"])
		for x = 1, #tParentEquipment[tFriendlyName].childs do
			--print(x)
			if tParentEquipment[tFriendlyName].childs[x] == "GearManagerToggleButton" then
				--print("GearManagerToggleButton")
				tParentEquipment[tFriendlyName].childs[x] = nil
				tParentEquipment[tFriendlyName].childs["GearManagerToggleButton"] = nil
			end
		end

	--stats
	local tFrameName = ""
	local tFriendlyName = L["Stats"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		--click = true,
	}
	local tParentStats = aParentChilds[tFriendlyName].childs

	--Make sure to iterate over the default order
	--Should probably be fixed in future on the off-chance someone changes their tab order
		for i, k in ipairs(PAPERDOLL_STATCATEGORY_DEFAULTORDER) do
			local v = PAPERDOLL_STATCATEGORIES[k]
			local categoryFrame = _G["CharacterStatsPaneCategory" .. v.id]

			--only add stats if category frame is present (can be changed with a cvar)
			if categoryFrame:IsShown() then
			local tFrameName = k
			local tFriendlyName = categoryFrame.NameText:GetText()
			table.insert(tParentStats, tFriendlyName)
			tParentStats[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = v,
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				--click = true,
			}
			local tParentStatsValues = tParentStats[tFriendlyName].childs
			PaperDollFrame_UpdateStatCategory(categoryFrame)
			for x = 1,#v.stats do
				--A bit hacky, character frames aren't created for irrelevant stats and are sometimes reused on stat changes
				--Iterate over frames matching all possible stats; the data on the frames should make up the difference
				local statFrame = _G[categoryFrame:GetName() .. "Stat" ..x]
				if statFrame ~= nil and statFrame:IsShown() then
				local label = statFrame.Label:GetText()
				local value = statFrame.Value:GetText()
				statFrame.type = "stat"
				local tName, tFullText = GetButtonTooltipLines(statFrame)
				local tFrameName = ""
				local tFriendlyName = SkuChat:Unescape(label.." "..value)
				table.insert(tParentStatsValues, tFriendlyName)
				tParentStatsValues[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = tFullText,
					childs = {},
					--click = true,
				}
			end
		end
			end
		end

	--Currency
	local tFrameName = ""
	local tFriendlyName = L["Currency"]
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		--click = true,
	}
	local tParentCurrency = aParentChilds[tFriendlyName].childs

		for i = 1, 100 do
			local name, isHeader, isExpanded, isUnused, isWatched, count, icon, maxQuantity, maxEarnable, quantityEarned, isTradeable, itemID = GetCurrencyListInfo(i)
			--print(name, isHeader, isExpanded, isUnused, isWatched, count, icon, maxQuantity, maxEarnable, quantityEarned, isTradeable, itemID)
			if name and isHeader ~= true then
				--print(, itemID)
				if isUnused ~= true then
				local tFrameName = ""
				local tFriendlyName = SkuChat:Unescape(name.." "..count)
				table.insert(tParentCurrency, tFriendlyName)
				tParentCurrency[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = "",
					childs = {},
					--click = true,
				}
			end
			end
		end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_ItemSocketingFrame(aParentChilds)

	local tFriendlyName, tFullText = GetButtonTooltipLines(nil, _G["ItemSocketingDescription"])
	local tFrameName = "ItemSocketingFrame"
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "FontString",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName.." ...",
		textFull = tFullText,
		childs = {},
	}
	local tSocketCount = GetNumSockets()
	for i = 1, tSocketCount do
		local tFrameName = "ItemSocketingSocket"..i

		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tCurrentGemName, tCurrentGemId = GetExistingSocketInfo(i)
			if GetNewSocketInfo(i) then
				tCurrentGemName, tCurrentGemId = GetNewSocketInfo(i)
			end
			local tCurrentGemTooltip = ""
			_G[tFrameName].type = "Button"
			if tCurrentGemName then
				tCurrentGemName, tCurrentGemTooltip = GetButtonTooltipLines(_G[tFrameName])
				tCurrentGemName = tCurrentGemName.." ..."
			else
				tCurrentGemName = L["Empty"]
			end

			local tFriendlyName = i.." "..GetSocketTypes(i).." "..L["socket"]..", "..L["current gem:"].." "..tCurrentGemName
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = tCurrentGemTooltip,
				childs = {},
				func = function(self, aButton)
					self:Click()
				end,
				click = true,
			}
		end

	end

	local tFriendlyName = _G["ItemSocketingSocketButton"]:GetText()
	local tFrameName = "ItemSocketingSocketButton"
	local tFunc = function(self, aButton)
		self:GetScript("OnClick")(self, aButton)
		self:GetScript("OnClick")(self, aButton)
	end
	if _G[tFrameName]:IsEnabled() ~= true then
		tFriendlyName = tFriendlyName.." ("..L["disabled"]..")"
		tFunc = nil
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = tFunc,
		click = true,
	}


	local tFriendlyName = L["Close"]
	local tFrameName = "ItemSocketingCloseButton"
	local tFunc = function(self, aButton)
		self:GetScript("OnClick")(self, aButton)
		self:GetScript("OnClick")(self, aButton)
	end
	if _G[tFrameName]:IsEnabled() ~= true then
		tFriendlyName = tFriendlyName.." ("..L["disabled"]..")"
		tFunc = nil
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
		func = tFunc,
		click = true,
	}
end

---------------------------------------------------------------------------------------------------------------------------------------
local tTradeSkillTypeColor = {
	--[L["optimal"]] = { r = 1, g = 0.50, b = 0.25},
	--[L["medium"]] = { r = 1, g = 1, b = 0},
	[L["New"]] = { r = 0, g = 1, b = 0},
	[L["bekannt"]] = { r = 0.50, g = 0.50, b = 0.50},
	["header"] = { r = 1, g = 0.82, b = 0},
	["subheader"] = { r = 1, g = 0.82, b = 0},
	[L["nodifficulty"]] = { r = 0.96, g = 0.96, b = 0.96},
	[L["selected"]] = { r = 1, g = 1, b = 1},
}
function SkuCore:Build_ClassTrainerFrame(aParentChilds)

	local tFrameName = "ClassTrainerFrame"
	local tFriendlyName = _G["ClassTrainerNameText"]:GetText()
	if _G["ClassTrainerGreetingText"] and _G["ClassTrainerGreetingText"].GetText and _G["ClassTrainerGreetingText"]:GetText() then
		tFriendlyName = _G["ClassTrainerGreetingText"]:GetText()
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "FontString",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}

	local tFrameName = "ClassTrainerListScrollFrameScrollBarScrollUpButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Hoch blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end

	local tHasOfSkills
	for x = 1, 10 do
		local tFrameName = "ClassTrainerSkill"..x
		if _G[tFrameName] and _G[tFrameName].text and _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then
			if _G[tFrameName].text:GetText() then
				local tDifficulty = ""
				local r, g, b, a = _G[tFrameName].text:GetTextColor()
				r, g, b, a = round(r), round(g), round(b), round(a)
				if r == 1 and g == 1 and  b == 1 then
					if _G["ClassTrainerHighlightFrame"] and _G["ClassTrainerHighlightFrame"]:GetRegions() then
						r, g, b, a = _G["ClassTrainerHighlightFrame"]:GetRegions():GetVertexColor()
						if r then
							r, g, b, a = round(r), round(g), round(b), round(a)
						end
					end
				end
				for i, v in pairs(tTradeSkillTypeColor) do
					if v.r == r and v.g == g and  v.b == b then
						tDifficulty = i
					end
				end

				local tFriendlyName = SkuChat:Unescape(_G[tFrameName].text:GetText())
				local tText, tFullText = "", ""
				if _G[tFrameName]:IsEnabled() == true then
					table.insert(aParentChilds, tFriendlyName)
					aParentChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "Button",
						obj = _G[tFrameName],
						textFirstLine = tFriendlyName,
						textFull = "",
						childs = {},
						func = _G[tFrameName]:GetScript("OnClick"),
						click = true,
					}
				end

				if tDifficulty == "subheader" or tDifficulty == "header" then
					aParentChilds[tFriendlyName].click = false
					aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ("..L["category"]..")"
				else
					aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ("..(tDifficulty or "")..")"
				end

				tHasOfSkills = true
			end
		end
	end

	local tFrameName = "ClassTrainerListScrollFrameScrollBarScrollDownButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Runter blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end



	local tName = ""
	if _G["ClassTrainerSkillName"] and _G["ClassTrainerSkillName"]:IsVisible() == true then
		tName = SkuChat:Unescape(_G["ClassTrainerSkillName"]:GetText()) or ""
	end
	local tRequirements = ""
	if _G["ClassTrainerSkillRequirements"] and _G["ClassTrainerSkillRequirements"]:IsVisible() and _G["ClassTrainerSkillRequirements"]:GetText() then
		for i, v in string.gmatch(_G["ClassTrainerSkillRequirements"]:GetText(), "([^,]+)") do
			if string.sub(i, 1, 1) == " " then
				i = string.sub(i, 2)
			end
			local tReqStr = SkuChat:Unescape(i) or ""
			if string.find(i, "ff2020") then
				tReqStr = tReqStr.." ("..L["missing"]..")"
			end
			tRequirements = tRequirements..tReqStr.."\r\n"
		end
	end
	local tCost = ""
	if _G["ClassTrainerDetailMoneyFrame"] and _G["ClassTrainerDetailMoneyFrame"].staticMoney then
		tCost = SkuGetCoinText(_G["ClassTrainerDetailMoneyFrame"].staticMoney, true)
	end

	if tHasOfSkills and _G["ClassTrainerSkillIcon"] then
		_G["ClassTrainerSkillIcon"].type = "sku"
		local tSkillText, tSkillFullText = GetButtonTooltipLines(_G["ClassTrainerSkillIcon"])
		local tFrameName = "ClassTrainerDetailScrollFrame"
		if tName and tName ~= "" then
			local tFriendlyName = L["Ausgewählt: "]..tName
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "FontString",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName.."...",
				textFull = tName..(("\r\n"..tCost) or "")..(("\r\n"..tRequirements) or "").."\r\n"..tSkillFullText,
				childs = {},
			}
		end
	end

	local tFrameName = "ClassTrainerTrainButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			if _G[tFrameName]:GetText() then
				local tFriendlyName = SkuChat:Unescape(_G[tFrameName]:GetText())
				table.insert(aParentChilds, tFriendlyName)
				aParentChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = "",
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
					--containerFrameName = "ClassTrainerTrain",
					onActionFunc = function(self, aTable, aChildName) end,
				}
			end
		end
	end


	local tFrameName = "ClassTrainerCancelButton"
	local tFriendlyName = L["Close"]
	if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end


end

---------------------------------------------------------------------------------------------------------------------------------------
local tTradeSkillTypeColor = {
	[L["optimal"]] = { r = 1.00, g = 0.50, b = 0.25},
	[L["medium"]] = { r = 1.00, g = 1.00, b = 0.00},
	[L["easy"]] = { r = 0.25, g = 0.75, b = 0.25},
	[L["trivial"]] = { r = 0.50, g = 0.50, b = 0.50},
	["header"] = { r = 1.00, g = 0.82, b = 0},
	["subheader"] = { r = 1.00, g = 0.82, b = 0},
	[L["nodifficulty"]] = { r = 0.96, g = 0.96, b = 0.96},
}
function SkuCore:Build_TradeSkillFrame(aParentChilds)

	local tFrameName = "TradeSkillFrame"
	local tFriendlyName = _G["TradeSkillFrameTitleText"]:GetText()
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "FontString",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}

	local tFrameName = ""
	local tSearchText = TradeSkillFrameEditBox:GetText() or ""
	local tFriendlyName = L["Filter"]
	local tLabel = tFriendlyName
	if tSearchText ~= "" and tSearchText ~= L["Search"] then
		tLabel = tLabel.." = "..tSearchText
	end
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "Button",
		obj = _G["TradeSkillFrameEditBox"],
		textFirstLine = tLabel,
		textFull = "",
		childs = {},
		func = function()
			C_Timer.After(0.8, function()
				SkuOptions.Voice:OutputStringBTtts(L["Enter search term and complete with enter or press escape to clear the search term"], true, true, 0.8, true, nil, nil, 1, nil, nil, true)
			end)
			if _G["TradeSkillFrameEditBox"] then
				TradeSkillFrameEditBox:SetFocus()
				TradeSkillFrameEditBox:HookScript("OnEscapePressed", function(self)
					C_Timer.After(0.1, function()
						PlaySound(89)
						TradeSkillFrameEditBox:SetText("")
						SkuOptions.currentMenuPosition:OnUpdate()
					end)

				end)
				TradeSkillFrameEditBox:HookScript("OnEnterPressed", function(self)
					C_Timer.After(0.1, function()
						PlaySound(89)
						SkuOptions.currentMenuPosition:OnUpdate()
					end)

				end)

			end
		end,
		click = true,
	}

	local tFrameName = "TradeSkillFrameAvailableFilterCheckButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tChecked = L["not checked"]
			if _G[tFrameName]:GetChecked() == true then
				tChecked = L["checked"]
			end
			local tFriendlyName = L["Have materials"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName.." ("..tChecked..")",
				textFull = "",
				childs = {},
				func = function(self, aButton)
					if self:GetChecked() == true then
						self:SetChecked(false)
					else
						self:SetChecked(true)
					end

					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end

	local tFrameName = "TradeSkillListScrollFrameScrollBarScrollUpButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Hoch blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end




	for x = 1, 8 do
		local tFrameName = "TradeSkillSkill"..x
		if _G[tFrameName] and _G[tFrameName].text and _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then
			if _G[tFrameName].text:GetText() then
				local tDifficulty = ""
				local r, g, b, a = _G[tFrameName].text:GetTextColor()
				r, g, b, a = round(r), round(g), round(b), round(a)
				if r == 1 and g == 1 and  b == 1 then
					if _G["TradeSkillHighlightFrame"] and _G["TradeSkillHighlightFrame"]:GetRegions() then
						r, g, b, a = _G["TradeSkillHighlightFrame"]:GetRegions():GetVertexColor()
						if r then
							r, g, b, a = round(r), round(g), round(b), round(a)
						end
					end
				end

				for i, v in pairs(tTradeSkillTypeColor) do
					if v.r == r and v.g == g and  v.b == b then
						tDifficulty = i
					end
				end

				local tCountText = _G[tFrameName.."Count"]:GetText()
				local tFriendlyName = SkuChat:Unescape(_G[tFrameName].text:GetText())
				if tCountText then
					tFriendlyName = tFriendlyName.." "..tCountText
				end

				if tDifficulty == "subheader" or tDifficulty == "header" then
					tFriendlyName = tFriendlyName.." ("..L["category"]..")"
				end

				local tText, tFullText = "", ""
				if _G[tFrameName]:IsEnabled() == true then
					table.insert(aParentChilds, tFriendlyName)
					aParentChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "Button",
						obj = _G[tFrameName],
						textFirstLine = tFriendlyName,
						textFull = "",
						childs = {},
						func = _G[tFrameName]:GetScript("OnClick"),
						click = true,
					}
				end

				if tDifficulty ~= "subheader" and tDifficulty ~= "header" then
					aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ("..(tDifficulty or "")..")"
				end
			end
		end
	end

	local tFrameName = "TradeSkillListScrollFrameScrollBarScrollDownButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Runter blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end

	local tName = ""
	if _G["TradeSkillSkillName"] then
		tName = SkuChat:Unescape(_G["TradeSkillSkillName"]:GetText()) or ""
	end
	local tRequirements = ""
	if _G["TradeSkillRequirementText"] and _G["TradeSkillRequirementText"]:IsVisible() and _G["TradeSkillRequirementText"]:GetText() then
		for i, v in string.gmatch(_G["TradeSkillRequirementText"]:GetText(), "([^,]+)") do
			if string.sub(i, 1, 1) == " " then
				i = string.sub(i, 2)
			end
			local tReqStr = SkuChat:Unescape(i) or ""
			if string.find(i, "ff2020") then
				tReqStr = tReqStr.." ("..L["missing"]..")"
			end
			tRequirements = tRequirements..tReqStr.."\r\n"
		end
	end
	--[[
	local tCost = ""
	if _G["CraftCost"] and _G["CraftCost"]:GetText() then
		tCost = SkuChat:Unescape(_G["CraftCost"]:GetText()) or ""
	end
]]
	local tDescription = ""
	if _G["TradeSkillDescription"] and _G["TradeSkillDescription"]:GetText() then
		tDescription = SkuChat:Unescape(_G["TradeSkillDescription"]:GetText()) or ""
	end


	local tReagents = ""
	if _G["TradeSkillReagentLabel"] and _G["TradeSkillReagentLabel"]:IsVisible() == true then
		tReagents = _G["TradeSkillReagentLabel"]:GetText()
	end
	for x = 1, 15 do
		if _G["TradeSkillReagent"..x] then
			if _G["TradeSkillReagent"..x]:IsVisible() == true then
				tReagents = tReagents.."\r\n"..SkuChat:Unescape(_G["TradeSkillReagent"..x.."Name"]:GetText())
				tReagents = tReagents.." "..SkuChat:Unescape(_G["TradeSkillReagent"..x.."Count"]:GetText())
			end
		end
	end

	_G["TradeSkillSkillIcon"].type = "sku"
	local tSkillText, tSkillFullText = GetButtonTooltipLines(_G["TradeSkillSkillIcon"])

	local tFrameName = "TradeSkillDetailScrollChildFrame"
	if tName and tName ~= "" then
		local tFriendlyName = L["Ausgewählt: "]..tName
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName.."...",
			textFull = tName..(("\r\n"..tRequirements) or "")..(("\r\n"..tReagents) or "")..(("\r\n"..L["gegenstand"]..":\r\n"..tSkillFullText) or "")..(("\r\n"..L["description"]..": "..tDescription) or ""),
			childs = {},
		}
	end

	local tFrameName = "TradeSkillCreateButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			if _G[tFrameName]:GetText() then
				local tFriendlyName = SkuChat:Unescape(_G[tFrameName]:GetText())
				table.insert(aParentChilds, tFriendlyName)
				aParentChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = "",
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
					--containerFrameName = "TradeSkillCreateButton",
					onActionFunc = function(self, aTable, aChildName) end,
				}
			end
		end
	end
	local tFrameName = "TradeSkillCreateAllButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			if _G[tFrameName]:GetText() then
				local tFriendlyName = SkuChat:Unescape(_G[tFrameName]:GetText())
				table.insert(aParentChilds, tFriendlyName)
				aParentChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = "",
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
					--containerFrameName = "TradeSkillCreateAllButton",
					onActionFunc = function(self, aTable, aChildName) end,
				}
			end
		end
	end


	local tFrameName = "TradeSkillFrameCloseButton"
	local tFriendlyName = L["Schließen"]
	if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_CraftFrame(aParentChilds)

	local tFrameName = "CraftFrame"
	local tFriendlyName = _G["CraftFrameTitleText"]:GetText()
	table.insert(aParentChilds, tFriendlyName)
	aParentChilds[tFriendlyName] = {
		frameName = tFrameName,
		RoC = "Child",
		type = "FontString",
		obj = _G[tFrameName],
		textFirstLine = tFriendlyName,
		textFull = "",
		childs = {},
	}

	if _G["CraftFramePointsText"] and _G["CraftFramePointsText"]:IsVisible() == true then
		local tFrameName = "CraftFramePointsText"
		local tFriendlyName = L["Verfügbare punkte: "]
		tFriendlyName = tFriendlyName..(_G["CraftFramePointsText"]:GetText() or "")
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
		}
	end

	local tFrameName = "CraftListScrollFrameScrollBarScrollUpButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Hoch blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end

	for x = 1, 8 do
		local tFrameName = "Craft"..x
		if _G[tFrameName] then
			if _G[tFrameName.."Text"]:GetText() then
				local tKnown = ""
				local tDifficulty = ""
				local r, g, b, a = _G[tFrameName].text:GetTextColor()
				r, g, b, a = round(r), round(g), round(b), round(a)
				if r == 1 and g == 1 and  b == 1 then
					if _G["CraftHighlightFrame"] and _G["CraftHighlightFrame"]:GetRegions() then
						r, g, b, a = _G["CraftHighlightFrame"]:GetRegions():GetVertexColor()
						if r then
							r, g, b, a = round(r), round(g), round(b), round(a)
						end
					end
				end

				for i, v in pairs(tTradeSkillTypeColor) do
					if v.r == r and v.g == g and  v.b == b then
						tDifficulty = i
					end
				end

				local tFriendlyName = SkuChat:Unescape(_G[tFrameName.."Text"]:GetText()).." ".. (SkuChat:Unescape(_G[tFrameName.."SubText"]:GetText()) or "").." ".. (SkuChat:Unescape(_G[tFrameName.."Cost"]:GetText()) or "").." "..tKnown
				local tText, tFullText = "", ""
				if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
					table.insert(aParentChilds, tFriendlyName)
					aParentChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "Button",
						obj = _G[tFrameName],
						textFirstLine = tFriendlyName,
						textFull = "",
						childs = {},
						func = _G[tFrameName]:GetScript("OnClick"),
						click = true,
					}
				end

				if tDifficulty == "subheader" or tDifficulty == "header" then
					aParentChilds[tFriendlyName].click = false
					aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ("..L["category"]..")"
				else
					aParentChilds[tFriendlyName].textFirstLine = aParentChilds[tFriendlyName].textFirstLine.." ("..(tDifficulty or "")..")"
				end
			end
		end
	end

	local tFrameName = "CraftListScrollFrameScrollBarScrollDownButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			local tFriendlyName = L["Runter blättern"]
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFriendlyName,
				textFull = "",
				childs = {},
				func = function(self, aButton)
					self:GetScript("OnClick")(self, aButton)
					self:GetScript("OnClick")(self, aButton)
				end,
				click = true,
			}
		end
	end

	local tName = ""
	if _G["CraftName"] then
		tName = SkuChat:Unescape(_G["CraftName"]:GetText()) or ""
	end
	local tRequirements = ""
	if _G["CraftRequirements"] and _G["CraftRequirements"]:IsVisible() and _G["CraftRequirements"]:GetText() then
		tRequirements = SkuChat:Unescape(_G["CraftRequirements"]:GetText()) or ""
		if string.find(_G["CraftRequirements"]:GetText(), "ff2020") then
			tRequirements = tRequirements.." ("..L["missing"]..")"
		end
	end
	local tCost = ""
	if _G["CraftCost"] and _G["CraftCost"]:GetText() then
		tCost = SkuChat:Unescape(_G["CraftCost"]:GetText()) or ""
	end
	local tDescription = ""
	if _G["CraftDescription"] and _G["CraftDescription"]:GetText() then
		tDescription = SkuChat:Unescape(_G["CraftDescription"]:GetText()) or ""
	end

	local tReagents = ""
	if _G["CraftReagentLabel"] and _G["CraftReagentLabel"]:IsVisible() == true then
		tReagents = _G["CraftReagentLabel"]:GetText()
	end
	for x = 1, 15 do
		if _G["CraftReagent"..x] then
			if _G["CraftReagent"..x]:IsVisible() == true then
				tReagents = tReagents.."\r\n"..SkuChat:Unescape(_G["CraftReagent"..x.."Name"]:GetText())
				tReagents = tReagents.." "..SkuChat:Unescape(_G["CraftReagent"..x.."Count"]:GetText())
			end
		end
	end

	_G["CraftIcon"].type = "sku"
	local tSkillText, tSkillFullText = GetButtonTooltipLines(_G["CraftIcon"])


	local tFrameName = "CraftDetailScrollChildFrame"
	if tName and tName ~= "" then
		local tFriendlyName = L["Ausgewählt: "]..tName
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName.."...",
			textFull = tName..(("\r\n"..tRequirements) or "")..(("\r\n"..tCost) or "")..(("\r\n"..tDescription) or "")..(("\r\n"..tReagents) or "")..(("\r\n"..L["gegenstand"]..":\r\n"..tSkillFullText) or ""),
			childs = {},
		}
	end

	local tFrameName = "CraftCreateButton"
	if _G[tFrameName] then
		if _G[tFrameName]:IsVisible() == true and _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
			if _G[tFrameName]:GetText() then
				local tFriendlyName = SkuChat:Unescape(_G[tFrameName]:GetText())
				table.insert(aParentChilds, tFriendlyName)
				aParentChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFriendlyName,
					textFull = "",
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
					--containerFrameName = "CraftCreateButton",
					onActionFunc = function(self, aTable, aChildName) end,
				}
			end
		end
	end

	local tFrameName = "CraftFrameCloseButton"
	local tFriendlyName = L["Schließen"]
	if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Build_PetStableFrame(aParentChilds)

	local tId, tName, tLevel, _, tType = GetStablePetInfo(0)
	local tFrame = _G["PetStableCurrentPet"]
	local tText, tFullText = GetButtonTooltipLines(tFrame)
	if tId then
		tText, tFullText = tName, tName.."\r\n"..tLevel.."\r\n"..tType
	else
		tText, tFullText = L["Empty"], ""
	end

	table.insert(aParentChilds, L["Derzeitiger Begleiter"])
	aParentChilds[L["Derzeitiger Begleiter"]] = {
		frameName = "PetStableCurrentPet",
		RoC = "Child",
		type = "Button",
		obj = tFrame,
		textFirstLine = L["Derzeitiger Begleiter"].." "..tText,
		textFull = L["Derzeitiger Begleiter"].." "..tFullText,
		childs = {},
		func = function(...)
			local tCursorInfo = GetCursorInfo()
			if tCursorInfo then
				tFrame:GetScript("OnReceiveDrag")(...)
			else
				tFrame:GetScript("OnDragStart")(...)
			end
		end,
		click = true,
	}

	for x = 1, 4 do
		local tId, tName, tLevel, _, tType = GetStablePetInfo(x)
		if _G["PetStableStabledPet"..x]:IsEnabled() == true then
			local tFrame = _G["PetStableStabledPet"..x]
			local tText, tFullText = GetButtonTooltipLines(tFrame)
			if tId then
				tText, tFullText = tName, tName.."\r\n"..tLevel.."\r\n"..tType
			else
				tText, tFullText = L["Empty"], ""
			end
			table.insert(aParentChilds, L["Stall "..x])
			aParentChilds[L["Stall "..x]] = {
				frameName = "PetStableStabledPet"..x,
				RoC = "Child",
				type = "Button",
				obj = tFrame,
				textFirstLine = L["Stall "..x].." "..tText,
				textFull = L["Stall "..x].." "..tFullText,
				childs = {},
				func = function(...)
					local tCursorInfo = GetCursorInfo()
					if tCursorInfo then
						tFrame:GetScript("OnReceiveDrag")(...)
					else
						tFrame:GetScript("OnDragStart")(...)
					end
				end,
				click = true,
			}
		end
	end

	local tFrame = _G["PetStablePurchaseButton"]
	if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
		if tFrame:IsShown() == true then --IsMouseClickEnabled()
			table.insert(aParentChilds, L["Weiteren Platz kaufen"])
			aParentChilds[L["Weiteren Platz kaufen"]] = {
				frameName = "PetStablePurchaseButton",
				RoC = "Child",
				type = "Button",
				obj = tFrame,
				textFirstLine = L["Weiteren Platz kaufen"],
				textFull = "",
				childs = {},
				func = tFrame:GetScript("OnClick"),
				click = true,
			}
		end
	end

	local tFrame = _G["PetStableFrameCloseButton"]
	if tFrame:IsEnabled() == true then --IsMouseClickEnabled()
		table.insert(aParentChilds, L["Schließen"])
		aParentChilds[L["Schließen"]] = {
			frameName = "PetStableFrameCloseButton",
			RoC = "Child",
			type = "Button",
			obj = tFrame,
			textFirstLine = L["Schließen"],
			textFull = "",
			childs = {},
			func = tFrame:GetScript("OnClick"),
			click = true,
		}
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ItemTextFrame(aParent)
	local tFrameName = "ItemTextTitleText"
	if _G[tFrameName]:IsShown() == true  then
		local tText = _G[tFrameName]:GetText()
		local tFrst, tFll = SkuCore:ItemName_helper(tText)
		local tFriendlyName = tFrst
		table.insert(aParent, tFriendlyName)
		aParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G[tFrameName],
			textFirstLine = tFrst,
			textFull = tFll,
			childs = {},
		}
	end

	local tFrameName = "ItemTextPageText"
	if _G[tFrameName]:IsShown() == true  then
		local tHtmlTable = _G[tFrameName]:GetTextData()

		local tText = ""
		for i, v in pairs(tHtmlTable) do
			if v.text then
				tText = SkuChat:Unescape(v.text).."\r\n"
			end
		end

		local tFrst, tFll = SkuCore:ItemName_helper(tText)
		local tFriendlyName = tFrst
		table.insert(aParent, tFriendlyName)
		aParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "FontString",
			obj = _G[tFrameName],
			textFirstLine = tFrst,
			textFull = tFll,
			childs = {},
		}
	end

	local tFrameName = "ItemTextPrevPageButton"
	if _G[tFrameName]:IsShown() == true  then
		local tFriendlyName = L["Previous"]
		local tFrst, tFll = tFriendlyName, ""
		table.insert(aParent, tFriendlyName)
		aParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFrst,
			textFull = tFll,
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end

	local tFrameName = "ItemTextNextPageButton"
	if _G[tFrameName]:IsShown() == true  then
		local tFriendlyName = L["Next"]
		local tFrst, tFll = tFriendlyName, ""
		table.insert(aParent, tFriendlyName)
		aParent[tFriendlyName] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "Button",
			obj = _G[tFrameName],
			textFirstLine = tFrst,
			textFull = tFll,
			childs = {},
			func = _G[tFrameName]:GetScript("OnClick"),
			click = true,
		}
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GossipFrame(aParentChilds)

	local dtc

	local tIconStrings = {
		[132048] = L["Accepted Quest"],
		[132049] = L["Available Quest"],
	}


	local gossipText = C_GossipInfo.GetText()
	if gossipText and gossipText ~= "" then
		table.insert(aParentChilds, gossipText)
		aParentChilds[gossipText] = {
			frameName = tFrameName,
			RoC = "Child",
			type = "string",
			--obj = nil,
			textFirstLine = gossipText,
			textFull = gossipText,
			childs = {},
		}
	end

	local info = C_GossipInfo.GetOptions()
	for i, v in pairs(info) do
		local tFriendlyName = (tIconStrings[v.icon] or "").." "..v.name
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = _G["GossipFrame"],
			RoC = "Child",
			type = "Button",
			obj = _G["GossipFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				C_GossipInfo.SelectOption(v.gossipOptionID)
			end,
			click = true,
		}
	end

	local info = C_GossipInfo.GetAvailableQuests()
	for i, v in pairs(info) do
		local tBl = ""
		if SkuDB.questDataTBC[v.questID] ~= nil and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData] ~= nil and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData][1] and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData][1][1] == true then
			tBl = L["Blacklisted"]
		end

		local tFriendlyName = L["Available Quest"].." "..v.title.." "..tBl
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = _G["GossipFrame"],
			RoC = "Child",
			type = "Button",
			obj = _G["GossipFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				C_GossipInfo.SelectAvailableQuest(v.questID)
			end,
			click = true,
		}
	end

	local info = C_GossipInfo.GetActiveQuests()
	for i, v in pairs(info) do
		local tBl = ""
		if SkuDB.questDataTBC[v.questID] ~= nil and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData] ~= nil and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData][1] and SkuDB.questDataTBC[v.questID][SkuDB.questKeys.skuData][1][1] == true then
			tBl = L["Blacklisted"]
		end

		local tFriendlyName = L["Accepted Quest"].." "..v.title.." "..tBl
		table.insert(aParentChilds, tFriendlyName)
		aParentChilds[tFriendlyName] = {
			frameName = _G["GossipFrame"],
			RoC = "Child",
			type = "Button",
			obj = _G["GossipFrame"],
			textFirstLine = tFriendlyName,
			textFull = "",
			childs = {},
			func = function()
				C_GossipInfo.SelectActiveQuest(v.questID)
			end,
			click = true,
		}
	end

end


-----------------------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrame(aParentChilds)


	local function QuestInfoRewardsFrameHelper(aParent, aInfoOnly)
		if QuestInfoRewardsFrame.ItemChooseText:IsVisible() == true or QuestInfoRewardsFrame.ItemReceiveText:IsVisible() == true or (QuestInfoMoneyFrame:IsVisible() == true and QuestInfoMoneyFrame:IsVisible() == true and QuestInfoMoneyFrame.staticMoney) then
			local tFrameName = "QuestInfoRewardsFrame"
			local tFriendlyName = L["Rewards"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(aParent, tFriendlyName)
			aParent[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
			}

			local tTaken = {}
			local tQuestInfoRewardsFrameChilds = aParent[tFriendlyName].childs

			local tc = 1
			if QuestInfoRewardsFrame.spellHeaderPool then
				if QuestInfoRewardsFrame.spellHeaderPool.numActiveObjects ~= nil and QuestInfoRewardsFrame.spellHeaderPool.numActiveObjects > 0 then
					for i, v in QuestInfoRewardsFrame.spellHeaderPool:EnumerateActive() do
						local tButton = i
						if tButton then
							if tButton:IsVisible() == true then
								if tButton.GetText then
									local tText = tButton:GetText()
									if tText then
										local tFriendlyName = SkuChat:Unescape(tText)
										table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
										tQuestInfoRewardsFrameChilds[tFriendlyName] = {
											frameName = "",
											RoC = "Child",
											type = "FontString",
											obj = tButton,
											textFirstLine = tText,
											textFull = "",
											childs = {},
										}
										tc = tc + 1
									end
								end
							end
						end
					end

				end
			end

			local tc = 1
			if QuestInfoRewardsFrame.spellRewardPool then
				if QuestInfoRewardsFrame.spellRewardPool.numActiveObjects ~= nil and QuestInfoRewardsFrame.spellRewardPool.numActiveObjects > 0 then
					for i, v in QuestInfoRewardsFrame.spellRewardPool:EnumerateActive() do
						local tButton = i
						if tButton then
							if tButton:IsVisible() == true then
								tButton.type = "spell"
								local tText, tFullText = GetButtonTooltipLines(tButton)
								if tText then
									tText = tText.." "..(tButton.count or "")
									local tFriendlyName = SkuChat:Unescape(tText)
									table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
									tQuestInfoRewardsFrameChilds[tFriendlyName] = {
										frameName = tFrameName,
										RoC = "Child",
										type = "Button",
										obj = tButton,
										textFirstLine = tText,
										textFull = tFullText,
										childs = {},
									}
									tc = tc + 1
								end
							end
						end
					end

				end
			end

			local compCache = {}
			if QuestInfoRewardsFrame.ItemChooseText then
				if QuestInfoRewardsFrame.ItemChooseText:IsVisible() == true then
					local tText = QuestInfoRewardsFrame.ItemChooseText:GetText()
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					local tFriendlyName = tFrst
					table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
					tQuestInfoRewardsFrameChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}

					for x = 1, 10 do
						local tFrameName = "QuestInfoRewardsFrameQuestInfoItem"..x
						if _G[tFrameName] then
							if _G[tFrameName]:IsVisible() == true  and _G[tFrameName.."Name"]:GetText() then
								local tText, tFullText, itemLink = GetButtonTooltipLines(_G[tFrameName])
								if tText then
									tFullText = {tFullText}
									if itemLink then
										SkuCore:InsertComparisnSections(select(1, GetItemInfoInstant(itemLink)), tFullText, compCache)
									end
									tTaken[x] = true
									tText = tText.." "..(_G[tFrameName].count or "")
									local tFriendlyName = SkuChat:Unescape(tText)
									if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
										table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
										tQuestInfoRewardsFrameChilds[tFriendlyName] = {
											frameName = tFrameName,
											RoC = "Child",
											type = "Button",
											obj = _G[tFrameName],
											textFirstLine = tText,
											textFull = tFullText,
											childs = {},
											func = _G[tFrameName]:GetScript("OnClick"),
											click = true,
										}
										if aInfoOnly then
											tQuestInfoRewardsFrameChilds[tFriendlyName].func = nil
											tQuestInfoRewardsFrameChilds[tFriendlyName].click = nil
										end
									end
								end
							end
						end
					end
				end
			end


			local tQuestInfoRewardsFrameChilds = aParent[tFriendlyName].childs
			if QuestInfoRewardsFrame.ItemReceiveText then
				if QuestInfoRewardsFrame.ItemReceiveText:IsVisible() == true then
					local tText = QuestInfoRewardsFrame.ItemReceiveText:GetText()
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					local tFriendlyName = tFrst
					table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
					tQuestInfoRewardsFrameChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
					for x = 1, 10 do
						if not tTaken[x] then
							local tFrameName = "QuestInfoRewardsFrameQuestInfoItem"..x
							if _G[tFrameName] then
								if _G[tFrameName]:IsVisible() == true and _G[tFrameName.."Name"]:GetText() then
									local tText, tFullText, itemLink = GetButtonTooltipLines(_G[tFrameName])
									if tText then
										tFullText = {tFullText}
										if itemLink then
											SkuCore:InsertComparisnSections(select(1, GetItemInfoInstant(itemLink)), tFullText, compCache)
										end
										tTaken[x] = true
										tText = tText.." "..(_G[tFrameName].count or "")
										local tFriendlyName = SkuChat:Unescape(tText)
										if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
											table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
											tQuestInfoRewardsFrameChilds[tFriendlyName] = {
												frameName = tFrameName,
												RoC = "Child",
												type = "Button",
												obj = _G[tFrameName],
												textFirstLine = tText,
												textFull = tFullText,
												childs = {},
												func = _G[tFrameName]:GetScript("OnClick"),
												click = true,
											}
											if aInfoOnly then
												tQuestInfoRewardsFrameChilds[tFriendlyName].func = nil
												tQuestInfoRewardsFrameChilds[tFriendlyName].click = nil
											end
										end
									end
								end
							end
						end
					end

				end
			end

			if _G["QuestInfoMoneyFrame"] then
				if _G["QuestInfoMoneyFrame"]:IsVisible() == true then
					if _G["QuestInfoMoneyFrame"].staticMoney then
						local tFrst, tFll = SkuGetCoinText(_G["QuestInfoMoneyFrame"].staticMoney, true), ""
						local tFriendlyName = tFrst
						table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
						tQuestInfoRewardsFrameChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = tFll,
							childs = {},
						}
					end
				end
			end


			if _G["QuestInfoTalentFrame"] then
				if _G["QuestInfoTalentFrame"]:IsVisible() == true then
					if _G["QuestInfoTalentFrame"].ReceiveText then
						local tFrst = _G["QuestInfoTalentFrame"].ReceiveText:GetText().." ".._G["QuestInfoTalentFrame"].ValueText:GetText()
						local tFriendlyName = tFrst
						table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
						tQuestInfoRewardsFrameChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = "",
							childs = {},
						}
					end
				end
			end



			if _G["QuestInfoXPFrame"] then
				if _G["QuestInfoXPFrame"]:IsVisible() == true then
					if _G["QuestInfoXPFrame"].ReceiveText then
						local tFrst = _G["QuestInfoXPFrame"].ReceiveText:GetText().." ".._G["QuestInfoXPFrame"].ValueText:GetText()
						local tFriendlyName = tFrst
						table.insert(tQuestInfoRewardsFrameChilds, tFriendlyName)
						tQuestInfoRewardsFrameChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = "",
							childs = {},
						}
					end
				end
			end





			--QuestInfoXPFrame.ReceiveText
			--.ValueText










		end

	end


	--QuestFrameGreetingPanel
	if _G["QuestFrameGreetingPanel"] then
		if _G["QuestFrameGreetingPanel"]:IsVisible() == true then

			local tFrameName = "QuestFrameGreetingPanel"
			local tFriendlyName = L["Greeting"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
			}

			local tGreetingChilds = aParentChilds[tFriendlyName].childs
			local dtc = { _G["QuestGreetingScrollChildFrame"]:GetRegions() }
			for x = 1, 1 do --#dtc do
				if dtc[x].GetText then
					local tText = dtc[x]:GetText()
					if tText then
						local tFrameName = "GreetingText"
						local tFriendlyName = tText
						local tFrst, tFll = SkuCore:ItemName_helper(tText)
						table.insert(tGreetingChilds, tFriendlyName)
						tGreetingChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = tFll,
							childs = {},
						}
					end
				end
			end

			local tIconStrings = {
				[132048] = L["Accepted Quest"],
				[-47609] = L["Accepted Quest"],
				[132049] = L["Available Quest"],
				[-57593] = L["Available Quest"],
				[-47593] = L["Available Quest"],
				[-47596] = L["Available Quest"],
			}

			for x = 1, 10 do
				local tFrameName = "QuestTitleButton"..x
				if _G[tFrameName] then
					if _G[tFrameName]:IsVisible() == true then
						if _G[tFrameName]:GetText() then
							local tFriendlyName = SkuChat:Unescape(_G[tFrameName]:GetText())
							if _G["QuestTitleButton"..x.."QuestIcon"]:IsVisible() == true  then
								tFriendlyName = (tIconStrings[_G["QuestTitleButton"..x.."QuestIcon"]:GetTexture()] or "").." "..SkuChat:Unescape(_G[tFrameName]:GetText())
							end
							local tText, tFullText = "", ""
							if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
								table.insert(tGreetingChilds, tFriendlyName)
								tGreetingChilds[tFriendlyName] = {
									frameName = tFrameName,
									RoC = "Child",
									type = "Button",
									obj = _G[tFrameName],
									textFirstLine = tFriendlyName,
									textFull = "",
									childs = {},
									func = _G[tFrameName]:GetScript("OnClick"),
									click = true,
								}
							end
						end
					end
				end
			end
		end
	end

	--QuestFrameProgressPanel
	if _G["QuestFrameProgressPanel"] then
		if _G["QuestFrameProgressPanel"]:IsVisible() == true then
			local tFrameName = "QuestFrameProgressPanel"
			local tFriendlyName = L["Progress"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
			}

			local tProgressChilds = aParentChilds[tFriendlyName].childs
			local dtc = { _G["QuestProgressScrollChildFrame"]:GetRegions() }
			for x = 1, 2 do
				if dtc[x].GetText then
					local tText = dtc[x]:GetText()
					if tText then
						local tFrameName = "QuestInfo"
						local tFriendlyName = tText
						local tFrst, tFll = SkuCore:ItemName_helper(tText)
						table.insert(tProgressChilds, tFriendlyName)
						tProgressChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = tFll,
							childs = {},
						}
					end
				end
			end
			if dtc[3]:IsVisible() == true then
				if dtc[3].GetText then
					local tText = dtc[3]:GetText()
					if tText then
						local tFrameName = "QuestInfo"
						local tFriendlyName = tText
						local tFrst, tFll = SkuCore:ItemName_helper(tText)
						table.insert(tProgressChilds, tFriendlyName)
						tProgressChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = tFll,
							childs = {},
						}
					end
				end

				for x = 1, 10 do
					local tFrameName = "QuestProgressItem"..x
					if _G[tFrameName] then
						if _G[tFrameName]:IsVisible() == true then
							local tText, tFullText = GetButtonTooltipLines(_G[tFrameName])
							if tText then
								tText = tText.." "..(_G[tFrameName].count or "")
								local tFriendlyName = SkuChat:Unescape(tText)
								--if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
									table.insert(tProgressChilds, tFriendlyName)
									tProgressChilds[tFriendlyName] = {
										frameName = tFrameName,
										RoC = "Child",
										type = "Button",
										obj = _G[tFrameName],
										textFirstLine = tText,
										textFull = tFullText,
										childs = {},
										--func = _G[tFrameName]:GetScript("OnClick"),
										--click = true,
									}
								--end
							end
						end
					end
				end
			end

			if dtc[4]:IsVisible() == true then
				if dtc[4].GetText then
					local tText = dtc[4]:GetText()
					if tText then
						local tFrameName = "QuestInfo"
						local tFriendlyName = tText
						local tFrst, tFll = SkuCore:ItemName_helper(tText)
						table.insert(tProgressChilds, tFriendlyName)
						tProgressChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "FontString",
							obj = _G[tFrameName],
							textFirstLine = tFrst,
							textFull = tFll,
							childs = {},
						}
					end
				end
			end

			local tFrameName = "QuestFrameCompleteButton"
			if _G[tFrameName] then
				if _G[tFrameName]:IsVisible() == true then
					if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
						local tFriendlyName = _G[tFrameName]:GetText()
						table.insert(tProgressChilds, tFriendlyName)
						tProgressChilds[tFriendlyName] = {
							frameName = tFrameName,
							RoC = "Child",
							type = "Button",
							obj = _G[tFrameName],
							textFirstLine = tFriendlyName,
							textFull = "",
							childs = {},
							func = _G[tFrameName]:GetScript("OnClick"),
							click = true,
						}
					end
				end
			end
		end
	end

	--QuestFrameDetailPanel
	if _G["QuestFrameDetailPanel"] then
		if _G["QuestFrameDetailPanel"]:IsVisible() == true then
			local tFrameName = "QuestFrameDetailPanel"
			local tFriendlyName = L["Detail"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
			}


			local tDetailChilds = aParentChilds[tFriendlyName].childs
			local dtc = { _G["QuestDetailScrollChildFrame"]:GetRegions() }
			local tFrameName = "QuestInfoTitleHeader"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then

					for i, v in pairs(SkuDB.questLookup[Sku.Loc]) do
						if v[1] == tText then
							if SkuDB.questDataTBC[i][SkuDB.questKeys.skuData] then
								if SkuDB.questDataTBC[i][SkuDB.questKeys.skuData][1] and SkuDB.questDataTBC[i][SkuDB.questKeys.skuData][1][1] == true then
									tText = tText.." "..L["Blacklisted"]
									break
								end
							end
						end
					end

					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end
			local tFrameName = "QuestInfoDescriptionText"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then
					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end

			local tFrameName = "QuestInfoObjectivesHeader"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then
					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end
			local tFrameName = "QuestInfoObjectivesText"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then
					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end

			--rewards
			if _G["QuestInfoRewardsFrame"] then
				QuestInfoRewardsFrameHelper(tDetailChilds, true)
			end

			local tFrameName = "QuestFrameAcceptButton"
			local tFriendlyName = L["Accept"]
			local tFrst, tFll = tFriendlyName, ""
			if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
				table.insert(tDetailChilds, tFriendlyName)
				tDetailChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFrst,
					textFull = tFll,
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
				}
			end
			local tFrameName = "QuestFrameDeclineButton"
			local tFriendlyName = L["Ablehnen"]
			local tFrst, tFll = tFriendlyName, ""
			if _G[tFrameName]:IsEnabled() == true then --IsMouseClickEnabled()
				table.insert(tDetailChilds, tFriendlyName)
				tDetailChilds[tFriendlyName] = {
					frameName = tFrameName,
					RoC = "Child",
					type = "Button",
					obj = _G[tFrameName],
					textFirstLine = tFrst,
					textFull = tFll,
					childs = {},
					func = _G[tFrameName]:GetScript("OnClick"),
					click = true,
				}
			end
		end
	end


	--QuestFrameRewardPanel
	if _G["QuestFrameRewardPanel"] then
		if _G["QuestFrameRewardPanel"]:IsVisible() == true then
			local tFrameName = "QuestFrameRewardPanel"
			local tFriendlyName = L["Abgabe"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(aParentChilds, tFriendlyName)
			aParentChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
			}

			local tDetailChilds = aParentChilds[tFriendlyName].childs

			local tFrameName = "QuestInfoTitleHeader"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then
					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end
			local tFrameName = "QuestInfoRewardText"
			if _G[tFrameName] then
				local tText = _G[tFrameName]:GetText()
				if tText then
					local tFriendlyName = tText
					local tFrst, tFll = SkuCore:ItemName_helper(tText)
					table.insert(tDetailChilds, tFriendlyName)
					tDetailChilds[tFriendlyName] = {
						frameName = tFrameName,
						RoC = "Child",
						type = "FontString",
						obj = _G[tFrameName],
						textFirstLine = tFrst,
						textFull = tFll,
						childs = {},
					}
				end
			end

			if QuestInfoRewardsFrame.ItemChooseText:IsVisible() == true or QuestInfoRewardsFrame.ItemReceiveText:IsVisible() == true or (QuestInfoMoneyFrame:IsVisible() == true and QuestInfoMoneyFrame:IsVisible() == true and QuestInfoMoneyFrame.staticMoney) then
				QuestInfoRewardsFrameHelper(tDetailChilds)
			end

			local tFrameName = "QuestFrameCompleteQuestButton"
			local tFriendlyName = L["Complete"]
			local tFrst, tFll = tFriendlyName, ""
			table.insert(tDetailChilds, tFriendlyName)
			tDetailChilds[tFriendlyName] = {
				frameName = tFrameName,
				RoC = "Child",
				type = "Button",
				obj = _G[tFrameName],
				textFirstLine = tFrst,
				textFull = tFll,
				childs = {},
				func = _G[tFrameName]:GetScript("OnClick"),
				click = true,
			}

		end
	end
end
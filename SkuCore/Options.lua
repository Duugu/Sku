local MODULE_NAME = "SkuCore"
local L = Sku.L

SkuCore.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
			name = L["Module enabled"],
			desc = "",
			type = "toggle",
			set = function(info, val)
				SkuOptions.db.profile[MODULE_NAME].enable = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].enable
			end
		},
		autoFollow = {
			name = L["Auto follow"],
			desc = "",
			type = "toggle",
			set = function(info, val)
				SkuOptions.db.profile[MODULE_NAME].autoFollow = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].autoFollow
			end
		},
		classes={
			name = L["Classes"],
			type = "group",
			order = 1,
			args= {
				hunter={
					name = L["Hunter"],
					type = "group",
					order = 1,
					args= {
						petHappyness = {
							order = 2,
							name = L["Notice on pet starving"],
							desc = "",
							type = "toggle",
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].classes.hunter.petHappyness = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].classes.hunter.petHappyness
							end
						},
					},
				},
			},
		},
		UIErrors={
			name = L["Error feedback"],
			type = "group",
			order = 1,
			args= {
				ErrorSoundChannel={
					name = L["sound channel"],
					order = 1,
					desc = "",
					type = "select",
					values = SKU_CONSTANTS.SOUNDCHANNELS,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.ErrorSoundChannel = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.ErrorSoundChannel
					end
				},
				OutOfRange={
					name = L["out of range"],
					order = 2,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRange
					end
				},
				Moving={
					name = L["Moving"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.Moving
					end
				},
				NoLoS={
					name = L["No LoS"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.NoLoS
					end
				},
				BadTarget={
					name = L["Bad Target"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.BadTarget
					end
				},
				InCombat={
					name = L["In Combat"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.InCombat
					end
				},
				NoMana={
					name = L["No ressource"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.NoMana
					end
				},
				ObjectBusy={
					name = L["Object Busy"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.ObjectBusy
					end
				},
				NotFacing={
					name = L["Not Facing"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.NotFacing
					end
				},
				CrowdControlled={
					name = L["Crowd Controlled"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.CrowdControlled
					end
				},
				Interrupted={
					name = L["Interrupted"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.Interrupted = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.Interrupted
					end
				},
			},
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.defaults = {
	enable = true,
	autoFollow = false,
	classes = {
		hunter = {
			petHappyness = true,
		},
	},
	UIErrors = {
		ErrorSoundChannel = "Talking Head",
		OutOfRange = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		Moving = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		NoLoS = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		BadTarget = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		InCombat = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		NoMana = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		ObjectBusy = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		NotFacing = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		CrowdControlled = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		Interrupted = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
	},
}
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
local tActionBarData = {
	MultiBarLeft = {friendlyName = L["Left Multi Bar"], buttonName = "MultiBarLeftButton", command = "MULTIACTIONBAR4BUTTON",},
	MultiBarRight = {friendlyName = L["Right Multi Bar"], buttonName = "MultiBarRightButton", command = "MULTIACTIONBAR3BUTTON"},
	MultiBarBottomLeft = {friendlyName = L["Bottom Multi Bar Left"], buttonName = "MultiBarBottomLeftButton", command = "MULTIACTIONBAR1BUTTON",},
	MultiBarBottomRight = {friendlyName = L["Bottom Multi Bar Right"], buttonName = "MultiBarBottomRightButton", command = "MULTIACTIONBAR2BUTTON",},
	MainMenuBar = {friendlyName = L["Main Action Bar"], buttonName = "ActionButton", command = "ACTIONBUTTON",},
	PetBar = {friendlyName = L["Pet Action Bar"], buttonName = "", command = "BONUSACTIONBUTTON",},
	ShapeshiftBar = {friendlyName = L["Stance Action Bar"], buttonName = "", command = "SHAPESHIFTBUTTON",},
}

---------------------------------------------------------------------------------------------------------------------------------------
local function MacrosMenuBuilder(aParentEntry)
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Macros"]}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.filterable = true
	tNewMenuSubEntry.OnEnter = function(self, aValue, aName)
		self.selectTarget.itemID = nil
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tHasEntries = false
		local tGlobalOffset = 121
		local global, perChar = GetNumMacros()

		if global > 0 then
			for x = 1, global do
				local name, icon, body, isLocal = GetMacroInfo(x)
				if name then
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {name}, menuEntryTemplate_Menu)
					tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.macroID = x
						SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = name, body
					end
					tHasEntries = true
				end
			end
		end
		if perChar > 0 then
			for x = tGlobalOffset, tGlobalOffset + perChar do
				local name, icon, body, isLocal = GetMacroInfo(x)
				if name then
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {name}, menuEntryTemplate_Menu)
					tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.macroID = x
						SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = name, body
					end
					tHasEntries = true
				end
			end
		end

		if tHasEntries == false then
			SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, menuEntryTemplate_Menu)
		end
	end
end


---------------------------------------------------------------------------------------------------------------------------------------
local function ItemsMenuBuilder(aParentEntry)
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Items"]}, menuEntryTemplate_Menu)
	tNewMenuSubEntry.dynamic = true
	tNewMenuSubEntry.filterable = true
	tNewMenuSubEntry.OnEnter = function(self, aValue, aName)
		self.selectTarget.itemID = nil
	end
	tNewMenuSubEntry.BuildChildren = function(self)
		local tHasEntries = false
		for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				local itemLink = GetContainerItemLink(bag, slot)
				local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bag, slot)
				if itemLink then
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, menuEntryTemplate_Menu)
					tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.itemID = itemID
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetItemByID(itemID)
						if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
							if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
								local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
								SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = ItemName_helper(tText)
							end
						end
					end
					tHasEntries = true
				end
			end
		end

		if tHasEntries == false then
			SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, menuEntryTemplate_Menu)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SpellBookMenuBuilder(aParentEntry, aBooktype)
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Assign nothing"]}, menuEntryTemplate_Menu)
	for x = 1, GetNumSpellTabs() do
		local name, texture, offset, numEntries, isGuild, offspecID = GetSpellTabInfo(x)
		local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {name}, menuEntryTemplate_Menu)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		tNewMenuSubEntry.OnEnter = function(self, aValue, aName)
			self.selectTarget.spellID = nil
		end
		tNewMenuSubEntry.BuildChildren = function(self)
			local tHasEntries = false
			if numEntries > 0 then
				for y = offset + 1, offset + numEntries do
					local spellName, spellSubName, spellID = GetSpellBookItemName(y, aBooktype) --BOOKTYPE_PET

					local tIsPassive = IsPassiveSpell(spellID)
					local isKnown = IsSpellKnown(spellID, false)
					if not tIsPassive and isKnown then
						local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {spellName..";"..spellSubName}, menuEntryTemplate_Menu)
						tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
							self.selectTarget.spellID = spellID
							_G["SkuScanningTooltip"]:ClearLines()
							_G["SkuScanningTooltip"]:SetSpellByID(spellID)
							if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
								if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
									local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
									SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = ItemName_helper(tText)
								end
							end
						end
						tHasEntries = true
					end
				end
			end
			if tHasEntries == false then
				local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, menuEntryTemplate_Menu)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function ButtonContentNameHelper(aActionType, aId, aSubType, aActionBarName, aButtonId)
	--print(aActionType, aId, aSubType, aActionBarName, aButtonId)
	local rName = L["Empty"]

	if aActionType then
		if aActionType == "spell" then
			local name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo(aId)
			rName = name
			if GetSpellSubtext(aId) and GetSpellSubtext(aId) ~= "" then
				rName = rName..";"..GetSpellSubtext(aId)
			end
		elseif aActionType == "item" then
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(aId)
			rName = itemName
		elseif aActionType == "macro" then
			local name, icon, body, isLocal = GetMacroInfo(aId)
			rName = L["Macro"]..";"..name
		--[[
		elseif aActionType == "mount" then
		elseif aActionType == "companion" then
		elseif aActionType == "equipmentset" then
		elseif aActionType == "flyout" then
		]]
		end
	end

	local tKeysString, key1, key2 = "", GetBindingKey(tActionBarData[aActionBarName].command..aButtonId)
	if key1 then
		tKeysString = ";"..L["Key"]..";"..GetBindingText(key1)
	end
	if key2 and tKeysString == "" then
		tKeysString = ";"..L["Key"]..";"..GetBindingText(key2)
	elseif key2 then
		tKeysString = tKeysString..";"..L["Key"]..";"..GetBindingText(key2)
	end
	if tKeysString == "" then
		tKeysString = ";"..L["Key;not;assigned"]
	end

	return rName..tKeysString
end

---------------------------------------------------------------------------------------------------------------------------------------
local function ActionBarMenuBuilder(aParentEntry, aActionBarName, aBooktype)
	if not aParentEntry or not aActionBarName then return end

	for x = 1, 12 do
		local tButtonObj = _G[tActionBarData[aActionBarName].buttonName..x]
		if tButtonObj then
			local actionType, id, subType = GetActionInfo(tButtonObj.action)
			local tButtonName = ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Button"].." "..x..";"..tButtonName}, menuEntryTemplate_Menu)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.buttonObj = _G[tActionBarData[aActionBarName].buttonName..x]
			tNewMenuEntry.OnEnter = function(self, aValue, aName)
				self.spellID = nil
				self.itemID = nil
				self.macroID = nil
				if self.buttonObj.action then
					_G["SkuScanningTooltip"]:ClearLines()
					_G["SkuScanningTooltip"]:SetAction(self.buttonObj.action)
					if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
						if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
							local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
							SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = ItemName_helper(tText)
						end
					end
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print("OnAction", "aValue", aValue, "aName", aName)
				if aName == L["Assign nothing"] then
					PickupAction(self.buttonObj.action)
					ClearCursor()
				elseif self.spellID then
					ClearCursor()
					PickupAction(self.buttonObj.action)
					ClearCursor()
					if self.spellID then
						PickupSpell(self.spellID)
						if CursorHasSpell() then
							PlaceAction(self.buttonObj.action)
							ClearCursor()
						end
					end
				elseif self.itemID then
					ClearCursor()
					PickupItem(self.itemID)
					PlaceAction(self.buttonObj.action)
					ClearCursor()
				elseif self.macroID then
					ClearCursor()
					PickupMacro(self.macroID)
					PlaceAction(self.buttonObj.action)
					ClearCursor()
				elseif aName == L["Bind key"] then
					SkuOptions.Voice:OutputString(L["Press new key or Escape to cancel"], true, true, 0.2)-- file: string, reset: bool, wait: bool, length: int						
					local f = _G["SkuCoreBindTest"] or CreateFrame("Button", "SkuCoreBindTest", UIParent, "UIPanelButtonTemplate")
					f.menuTarget = self
					f:SetSize(80, 22)
					f:SetText("SkuCoreBindTest")
					f:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
					f:SetPoint("CENTER")
					f:SetScript("OnClick", function(self, aKey, aB)
						--print(aKey, aB)
						local tBlockedKeys = {
							["RIGHT"] = true,
							["LEFT"] = true,
							["DOWN"] = true,
							["UP"] = true,
							["a"] = true,
							["w"] = true,
							["d"] = true,
							["s"] = true,
						}
						local tBlockedKeysParts = {
							"CTRL%-SHIFT%-F",
							"SHIFT%-F",
						}

						if tBlockedKeys[aKey] or tBlockedKeys[string.lower(aKey)] then  return end
						for z = 1, #tBlockedKeysParts do
							if string.find(aKey, tBlockedKeysParts[z]) or string.find(string.lower(aKey), string.lower(tBlockedKeysParts[z])) then return end
						end

						if aKey ~= "ESCAPE" then
							ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)
							SetBinding(aKey)
							local key1, key2 = GetBindingKey(tActionBarData[aActionBarName].command..x)
							if key1 then SetBinding(key1) end
							if key2 then SetBinding(key2) end
							local ok = SetBinding(aKey , tActionBarData[aActionBarName].command..x)
							SaveBindings(GetCurrentBindingSet())
							local actionType, id, subType = GetActionInfo(self.menuTarget.buttonObj.action)
							self.menuTarget.name = L["Button"].." "..x..";"..ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)
							_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
							_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
							SkuOptions.Voice:OutputString(L["New key"]..";"..aKey, true, true, 0.2)-- file: string, reset: bool, wait: bool, length: int						
						else
							SkuOptions.Voice:OutputString(L["Binding canceled"], true, true, 0.2)-- file: string, reset: bool, wait: bool, length: int						
						end
						ClearOverrideBindings(self)
					end)
					SetOverrideBindingClick(f, true, "ESCAPE", "SkuCoreBindTest", "ESCAPE")

					local tModifierKeys = {
						"",
						"CTRL-",
						"SHIFT-",
						"ALT-",
						"CTRL-SHIFT-",
						"CTRL-ALT-",
						"SHIFT-ALT-",
						"SHIFT-SHIFT-ALT-",
					}

					for i, v in pairs(_G) do 
						if string.find(i, "KEY_") == 1 then 
							if not string.find(i, "ESC") then
								--print(i, v, string.find(i, "KEY_"), string.sub(i, 5))
								for x = 1, #tModifierKeys do
									SetOverrideBindingClick(f, true, tModifierKeys[x]..string.sub(i, 5), "SkuCoreBindTest", tModifierKeys[x]..string.sub(i, 5))
								end
							end
						end 
					end

					local tStandardChars = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "ü", "ä", "ß", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Ä", "Ö", "Ü", ",", ".", "-", "#", "+", "ß", "´", "<"}
					local tStandardNumbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",}
					for x = 1, #tStandardChars do
						for y = 1, #tModifierKeys do
							SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardChars[x], "SkuCoreBindTest", tModifierKeys[y]..tStandardChars[x])
						end
					end
					for x = 1, #tStandardNumbers do
						for y = 1, #tModifierKeys do
							SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardNumbers[x], "SkuCoreBindTest", tModifierKeys[y]..tStandardNumbers[x])
						end
					end
				end

				local actionType, id, subType = GetActionInfo(self.buttonObj.action)
				self.name = L["Button"].." "..x..";"..ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)

				self.spellID = nil
				self.itemID = nil
				self.macroID = nil
			end
			tNewMenuEntry.BuildChildren = function(self)
				--[[
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {"Tastenbelegung"}, menuEntryTemplate_Menu)
				tNewMenuSubEntry.dynamic = true
				tNewMenuSubEntry.OnAction = function(self, aValue, aName)
					print(self, aValue, aName)
					print(self.parent.name)
					print(self.parent.buttonObj)
					print(self.parent.buttonObj:GetName())
				end
				]]
				SpellBookMenuBuilder(self, aBooktype)
				ItemsMenuBuilder(self)
				MacrosMenuBuilder(self)
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {L["Bind key"]}, menuEntryTemplate_Menu)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MenuBuilder(aParentEntry)
	--print("SkuCore:MenuBuilder", aParentEntry)
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Mail"]}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New letter"]}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		--tNewMenuEntry.ttsEngine = 2
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print(aName)
			--open the specific edit box for aname and write result to current mi.tmpx
			if aName == L["Recepient"] then
				SkuCore:MailEditor("TmpTo")
			elseif aName == L["Topic"] then
				SkuCore:MailEditor("TmpSubject")
			elseif aName == L["Text"] then
				SkuCore:MailEditor("TmpBody")
			elseif aName == L["Send"] then
				if self.TmpTo and self.TmpSubject then --and tNewMenuEntry.TmpBody then
					--versenden
					SendMail(self.TmpTo, self.TmpSubject, self.TmpBody or " ")
					self.TmpTo = nil
					self.TmpSubject = nil
					self.TmpBody = nil
					self.TmpMoney = nil
					self.TmpItems = nil
					self.TmpItemsLock = nil
				else
					if not self.TmpTo then
						SkuOptions.Voice:OutputString(L["No Recipient"], false, true, 0.2)
					end
					if not self.TmpSubject then
						SkuOptions.Voice:OutputString(L["No topic"], false, true, 0.2)
					end
				end
			elseif tonumber(aName) then
				SetSendMailMoney(tonumber(aName) * 10000)
			else
				local tBagSlot, tItem = string.split(":", aName)
				local tBag, tSlot = string.split(" ", tBagSlot)
				if not self.TmpItemsLock then self.TmpItemsLock = {} end
				self.TmpItemsLock[tBag.."-"..tSlot] = true
				PickupContainerItem(tBag,tSlot)
				SendMailAttachmentButton_OnDropAny()
			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Recepient"]}, menuEntryTemplate_Menu)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Topic"]}, menuEntryTemplate_Menu)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Text"]}, menuEntryTemplate_Menu)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Gold"]}, menuEntryTemplate_Menu)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			tNewMenuParentEntrySubSub.dynamic = true
			tNewMenuParentEntrySubSub.BuildChildren = function(self)
				for x = 1, 25 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x}, menuEntryTemplate_Menu)
				end
				for x = 1, 15 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*5 + 25}, menuEntryTemplate_Menu)
				end
				for x = 1, 20 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*10 + 100}, menuEntryTemplate_Menu)
				end
				for x = 1, 20 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*20 + 300}, menuEntryTemplate_Menu)
				end
				for x = 1, 23 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*50 + 700}, menuEntryTemplate_Menu)
				end
			end
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Items"]}, menuEntryTemplate_Menu)
			tNewMenuParentEntrySubSub.filterable = true
			tNewMenuParentEntrySubSub.dynamic = true
			tNewMenuParentEntrySubSub.BuildChildren = function(self)
				for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
					for slot = 1, GetContainerNumSlots(bag) do
						local tLocked = self.parent.TmpItemsLock
						if self.parent.TmpItemsLock then
							tLocked = self.parent.TmpItemsLock[bag.."-"..slot]
						end
						if not tLocked then
							local itemLink = GetContainerItemLink(bag, slot)
							local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bag, slot)
							if itemLink then
								--print(bag, slot, itemLink)
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, menuEntryTemplate_Menu)
							end
						end
					end
				end
			end
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Send"]}, menuEntryTemplate_Menu)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Open all"]}, menuEntryTemplate_Menu)
		--tNewMenuEntry.ttsEngine = 2
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			local numItems, totalItems = GetInboxNumItems()
			local tToOpen = totalItems
			local tOpened = 0
			if totalItems > 0 then
				local function bootlegRepeatingTimer()
					TakeInboxMoney(1)
					AutoLootMailItem(1)
					DeleteInboxItem(1)
					tOpened = tOpened + 1
					local numItems, totalItems = GetInboxNumItems()
					if totalItems > 0 then
						C_Timer.After(1, bootlegRepeatingTimer)
					else
						SkuOptions.Voice:OutputString(L["All opened"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int						
					end
				end
				bootlegRepeatingTimer()
			end
		end

		local numItems, totalItems = GetInboxNumItems()
		for x = 1, totalItems do
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(x)
			if sender then
				local tSubject = ""
				if CODAmount > 0 then
					tSubject = x.." "..sender.." - "..L["Caution: Cash on delivery"].."! - "..(subject or L["No topic"])
				else
					tSubject = x.." "..sender.." - "..(subject or L["No topic"])
				end
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tSubject}, menuEntryTemplate_Menu)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.ttsEngine = 2
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					--print("onaction mailitem", self, aValue, aName)
					--print(aName, self.TmpMailItemIndex, self.TmpMailItemIndexAttachmentIndex)
					if aName == L["Reply"] then
						--print(self.name, "beantworten")

					elseif aName == L["Take gold"] then
						if self.TmpMailItemIndex then
							TakeInboxMoney(self.TmpMailItemIndex)
						end
					elseif aName == L["Take all"] then
						if self.TmpMailItemIndex then
							AutoLootMailItem(self.TmpMailItemIndex)
						end

					elseif aName == L["Delete"] then
						if self.TmpMailItemIndex then
							DeleteInboxItem(self.TmpMailItemIndex)
						end
					elseif aName ~= "" then
						if self.TmpMailItemIndex and self.TmpMailItemIndexAttachmentIndex then
							local itemLink = GetInboxItemLink(self.TmpMailItemIndex, self.TmpMailItemIndexAttachmentIndex)
							TakeInboxItem(self.TmpMailItemIndex, self.TmpMailItemIndexAttachmentIndex)
						end
					end
				end
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					self.TmpMailItemIndex = x
					self.TmpMailItemIndexAttachmentIndex = nil
					local bodyText, stationaryMiddle, stationaryEdge, isTakeable, isInvoice = GetInboxText(x)
					local tSubject = ""
					local tGoldDir = ""
					if CODAmount > 0 then
						tSubject = L["Caution: Cash on delivery"].."! - "..(subject or L["No topic"])
						tGoldDir = L["CASH ON DELIVERY"].."! "
						money = CODAmount
					else
						tGoldDir = L["Attached"]..": "
						tSubject = (subject or L["No topic"])
					end

					local tGold, tSilver, tCopper = 0, 0, 0
					if money then
						tCopper = money
						tGold = math.floor(tCopper / 10000)
						tSilver = math.floor((tCopper - (tGold * 10000)) / 100)
						tCopper = tCopper - (tGold * 10000) - (tSilver * 100)
					end

					SkuOptions.currentMenuPosition.textFull = L["Sender"]..": "..sender.."\r\n"..L["Topic"]..": "..tSubject.."\r\n"..tGoldDir..tGold.." "..L["Gold"].." "..tSilver.." "..L["Silver"].." "..tCopper.." "..L["Copper"].."\r\n"..L["Attached"]..": "..(hasItem or "0").." "..L["Items"].."\r\n"..L["Text"]..": "..(bodyText or L["Empty"])
				end

				tNewMenuEntry.BuildChildren = function(self)
					local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Reply"]}, menuEntryTemplate_Menu)
					tNewMenuParentEntrySub.dynamic = true
					tNewMenuParentEntrySub.isSelect = true
					--tNewMenuParentEntrySub.ttsEngine = 2
					tNewMenuParentEntrySub.OnAction = function(self, aValue, aName)
						--print(aName)
						--open the specific edit box for aname and write result to current mi.tmpx
						if aName ==L["Recepient"] then
							SkuCore:MailEditor("TmpTo")
						elseif aName == L["Topic"] then
							SkuCore:MailEditor("TmpSubject")
						elseif aName == L["Text"] then
							SkuCore:MailEditor("TmpBody")
						elseif aName == L["Send"] then
							if self.TmpTo and self.TmpSubject then --and tNewMenuEntry.TmpBody then
								--versenden
								SendMail(self.TmpTo, self.TmpSubject, self.TmpBody or " ")
								self.TmpTo = nil
								self.TmpSubject = nil
								self.TmpBody = nil
								self.TmpMoney = nil
								self.TmpItems = nil
							end
						elseif tonumber(aName) then
							SetSendMailMoney(tonumber(aName) * 10000)
						else
							local tBagSlot, tItem = string.split(":", aName)
							local tBag, tSlot = string.split(" ", tBagSlot)
							if not self.TmpItemsLock then self.TmpItemsLock = {} end
							self.TmpItemsLock[tBag.."-"..tSlot] = true
							PickupContainerItem(tBag,tSlot)
							SendMailAttachmentButton_OnDropAny()
						end
					end
					tNewMenuParentEntrySub.BuildChildren = function(self)
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Recepient"]}, menuEntryTemplate_Menu)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Topic"]}, menuEntryTemplate_Menu)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Text"]}, menuEntryTemplate_Menu)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Gold"]}, menuEntryTemplate_Menu)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						tNewMenuParentEntrySubSub.dynamic = true
						tNewMenuParentEntrySubSub.BuildChildren = function(self)
							for x = 1, 25 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x}, menuEntryTemplate_Menu)
							end
							for x = 1, 15 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*5 + 25}, menuEntryTemplate_Menu)
							end
							for x = 1, 20 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*10 + 100}, menuEntryTemplate_Menu)
							end
							for x = 1, 20 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*20 + 300}, menuEntryTemplate_Menu)
							end
							for x = 1, 23 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*50 + 700}, menuEntryTemplate_Menu)
							end
						end
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Items"]}, menuEntryTemplate_Menu)
						tNewMenuParentEntrySubSub.dynamic = true
						tNewMenuParentEntrySubSub.BuildChildren = function(self)
							for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
								for slot = 1, GetContainerNumSlots(bag) do
									local tLocked = self.parent.TmpItemsLock
									if self.parent.TmpItemsLock then
										tLocked = self.parent.TmpItemsLock[bag.."-"..slot]
									end
									if not tLocked then
										local itemLink = GetContainerItemLink(bag, slot)
										local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bag, slot)
										if itemLink then
											--print(bag, slot, itemLink)
											local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, menuEntryTemplate_Menu)
										end
									end
								end
							end
						end
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Send"]}, menuEntryTemplate_Menu)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
					end

					if hasItem or (money and money > 0) then
						local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Attachments"]}, menuEntryTemplate_Menu)
						tNewMenuParentEntrySub.dynamic = true
						--tNewMenuParentEntrySub.ttsEngine = 2
						tNewMenuParentEntrySub.BuildChildren = function(self)
							if (money and money > 0 and CODAmount == 0) then
								local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Take gold"]}, menuEntryTemplate_Menu)
								--tNewMenuParentEntrySubSub.dynamic = true
								--tNewMenuParentEntrySubSub.ttsEngine = 2
							end

							if hasItem then
								local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Take all"]}, menuEntryTemplate_Menu)
								--tNewMenuParentEntrySubSub.dynamic = true
								--tNewMenuParentEntrySubSub.ttsEngine = 2
								for y = 1, ATTACHMENTS_MAX_RECEIVE do
									local itemLink = GetInboxItemLink(x, y)
									--itemLink = itemLink or L["Empty"]
									if itemLink then
										local name = GetInboxItem(x, y)
										name = name or L["Empty"]
										local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {y.." "..name}, menuEntryTemplate_Menu)
										--tNewMenuParentEntrySubSub.dynamic = true
										--tNewMenuParentEntrySubSub.ttsEngine = 2
										tNewMenuParentEntrySubSub.OnEnter = function(self, aValue, aName)
											if itemLink ~= L["Empty"] then
												local name, itemID, texture, count, quality, canUse  = GetInboxItem(x, y)
												if itemID then
													_G["SkuScanningTooltip"]:ClearLines()
													_G["SkuScanningTooltip"]:SetItemByID(itemID)
													if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
														if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
															local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
															SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = ItemName_helper(tText)
														end
													end
												end
												self.selectTarget.TmpMailItemIndexAttachmentIndex = y
											end
										end
									end
								end
							end
						end
					end

					local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Delete"]}, menuEntryTemplate_Menu)
					--tNewMenuParentEntrySub.dynamic = true
					--tNewMenuParentEntrySub.ttsEngine = 2
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Action bars"]}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MainMenuBar"].friendlyName}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MainMenuBar", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarBottomLeft"].friendlyName}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarBottomLeft", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarBottomRight"].friendlyName}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarBottomRight", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarRight"].friendlyName}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarRight", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarLeft"].friendlyName}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarLeft", BOOKTYPE_SPELL)
		end

		--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Einstellungen"}, menuEntryTemplate_Menu)
		--tNewMenuEntry.dynamic = true
		--tNewMenuEntry.BuildChildren = function(self)
		--end
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuCore.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end






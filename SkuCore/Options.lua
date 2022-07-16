local MODULE_NAME = "SkuCore"
local L = Sku.L

local tBlockedKeysParts = {
	"TAB",
	"BACKSPACE",
	"ENTER",
	"ESCAPE",
	"BUTTON1",
	"BUTTON2",
	"BUTTON3",
	"BUTTON4",
	"BUTTON5",
	"DOWN",
	"UP",
	"LEFT",
	"RIGHT",
	"PAGEDOWN",
	"PAGEDUP",
}
local tBlockedKeysBinds = {
	"I",
}

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

local tStandardChars = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "ü", "ö", "ß", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Ä", "Ö", "Ü", ",", ".", "-", "#", "+", "ß", "´", "<"}
local tStandardNumbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",}

local tActionBarData = {
	MultiBarLeft = {friendlyName = L["Left Multi Bar"], buttonName = "MultiBarLeftButton", command = "MULTIACTIONBAR4BUTTON",},
	MultiBarRight = {friendlyName = L["Right Multi Bar"], buttonName = "MultiBarRightButton", command = "MULTIACTIONBAR3BUTTON"},
	MultiBarBottomLeft = {friendlyName = L["Bottom Multi Bar Left"], buttonName = "MultiBarBottomLeftButton", command = "MULTIACTIONBAR1BUTTON",},
	MultiBarBottomRight = {friendlyName = L["Bottom Multi Bar Right"], buttonName = "MultiBarBottomRightButton", command = "MULTIACTIONBAR2BUTTON",},
	MainMenuBar = {friendlyName = L["Main Action Bar"], buttonName = "ActionButton", command = "ACTIONBUTTON",},
	PetBar = {friendlyName = L["Pet Action Bar"], buttonName = "PetActionButton", command = "BONUSACTIONBUTTON",},
	ShapeshiftBar = {friendlyName = L["Stance Action Bar"], buttonName = "", command = "SHAPESHIFTBUTTON",},
}

local scanAccuracyValues = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5,
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		--[[
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
		]]
		scanBackgroundSound = {
			order = 1,
			name = L["scanning background sound"],
			desc = "",
			type = "select",
			values = SkuCore.BackgroundSoundFiles,
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].scanBackgroundSound = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].scanBackgroundSound
			end
		},		
		ressourceScanning={
			name = L["Ressource Scanning"],
			type = "group",
			order = 1,
			args= {
				miningNodes={
					name = L["mining nodes"],
					type = "group",
					order = 1,
					args= {},
				},
				herbs={
					name = L["Herbs"],
					type = "group",
					order = 2,
					args= {},
				},
				scanAccuracyS = {
					order = 1,
					name = L["scan accuracy"],
					desc = "",
					type = "select",
					values = scanAccuracyValues,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].ressourceScanning.scanAccuracyS = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].ressourceScanning.scanAccuracyS
					end
				},		
			},
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
		endFollowOnCast = {
			name = L["Folgen beim Zaubern temporär beenden"],
			desc = "",
			type = "toggle",
			set = function(info, val)
				SkuOptions.db.profile[MODULE_NAME].endFollowOnCast = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].endFollowOnCast
			end
		},
		interactMove = {
			name = L["Bei Interagieren zum Ziel laufen"],
			desc = "",
			type = "toggle",
			set = function(info, val)
				SkuOptions.db.profile[MODULE_NAME].interactMove = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].interactMove
			end
		},
		playNPCGreetings = {
			name = L["Play NPC greetings"],
			desc = "",
			type = "toggle",
			set = function(info, val)
				SkuOptions.db.profile[MODULE_NAME].playNPCGreetings = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].playNPCGreetings
			end
		},
		classes={
			name = L["Classes"],
			type = "group",
			order = 2,
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
		itemSettings={
			name = L["item settings"],
			type = "group",
			order = 3,
			args= {
				ShowItemQality = {
					name = L["show item quality"],
					order = 1,
					desc = "",
					type = "toggle",
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].itemSettings.ShowItemQality = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].itemSettings.ShowItemQality
					end
				},
				autoSellJunk = {
					name = L["Auto sell junk at vendors"],
					order = 2,
					desc = "",
					type = "toggle",
					set = function(info, val)
						SkuOptions.db.profile[MODULE_NAME].itemSettings.autoSellJunk = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].itemSettings.autoSellJunk
					end
				},
				autoRepair = {
					name = L["Auto repair at vendors"],
					order = 3,
					desc = "",
					type = "toggle",
					set = function(info, val)
						SkuOptions.db.profile[MODULE_NAME].itemSettings.autoRepair = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].itemSettings.autoRepair
					end
				},
	
			},
		},

		UIErrors={
			name = L["Error feedback"],
			type = "group",
			order = 4,
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
				OutOfRangeMelee={
					name = L["out of range melee"],
					order = 2,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeMelee = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeMelee
					end
				},
				OutOfRangeCast={
					name = L["out of range cast"],
					order = 2,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeCast = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.OutOfRangeCast
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
				Other={
					name = L["other"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.Other = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.Other
					end
				},
				Cooldown={
					name = L["cooldown"],
					order = 3,
					desc = "",
					type = "select",
					values = SkuCore.Errors.Sounds,
					set = function(info,val)
						SkuOptions.db.profile[MODULE_NAME].UIErrors.Cooldown = val
					end,
					get = function(info)
						return SkuOptions.db.profile[MODULE_NAME].UIErrors.Cooldown
					end
				},				
				
			},
		},
	},
}

do
	for x = 1, #SkuCore.RessourceTypes.mining do
		SkuCore.options.args.ressourceScanning.args.miningNodes.args[x] = {
			order = x,
			name = SkuCore.RessourceTypes.mining[x][Sku.L["locale"]],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].ressourceScanning.miningNodes[x] = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].ressourceScanning.miningNodes[x]
			end
		}
	end
end

do
	for x = 1, #SkuCore.RessourceTypes.herbs do
		SkuCore.options.args.ressourceScanning.args.herbs.args[x] = {
			order = x,
			name = SkuCore.RessourceTypes.herbs[x][Sku.L["locale"]],
			desc = "",
			type = "toggle",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].ressourceScanning.herbs[x] = val
			end,
			get = function(info)
				return SkuOptions.db.profile[MODULE_NAME].ressourceScanning.herbs[x]
			end
		}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.defaults = {
	enable = true,
	autoFollow = false,
	endFollowOnCast = false,
	interactMove = true,
	playNPCGreetings = false,
	scanBackgroundSound = "tools-ratchet.mp3",
	ressourceScanning = {
		miningNodes = {},
		herbs = {},
		scanAccuracyS = 3,
	},
	classes = {
		hunter = {
			petHappyness = true,
		},
	},
	itemSettings = {
		ShowItemQality = true,
		autoSellJunk = true,
		autoRepair = true,
	},
	UIErrors = {
		ErrorSoundChannel = "Talking Head",
		OutOfRangeMelee = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		OutOfRangeCast = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		Moving = "voice",
		NoLoS = "voice",
		BadTarget = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		InCombat = "voice",
		NoMana = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
		ObjectBusy = "voice",
		NotFacing = "voice",
		CrowdControlled = "voice",
		Interrupted = "voice",
		Other = "voice",
		Cooldown  = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3",
	},
}

do
	for x = 1, #SkuCore.RessourceTypes.mining do
		SkuCore.defaults.ressourceScanning.miningNodes[x] = true
	end
end
do
	for x = 1, #SkuCore.RessourceTypes.herbs do
		SkuCore.defaults.ressourceScanning.herbs[x] = true
	end
end


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

---------------------------------------------------------------------------------------------------------------------------------------
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
local function ButtonContentNameHelper(aActionType, aId, aSubType, aActionBarName, aButtonId)
	--dprint(aActionType, aId, aSubType, aActionBarName, aButtonId)
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
		elseif aActionType == "pet" then
			local name, texture, isToken, isActive, autoCastAllowed, autoCastEnabled, spellID = GetPetActionInfo(aId);
			if name then
				rName = _G[name] or name
			end
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
local function BindingHelper(aCurrentMenuEntry, aType, aButtonId, aParentEntry, aActionBarName, aBooktypeOrObjId)
	SkuOptions.Voice:OutputStringBTtts(L["Press new key or Escape to cancel"], true, true, 0.2)						
	local f = _G["SkuCoreBindControlFrame"] or CreateFrame("Button", "SkuCoreBindControlFrame", UIParent, "UIPanelButtonTemplate")
	f.menuTarget = aCurrentMenuEntry
	f:SetSize(80, 22)
	f:SetText("SkuCoreBindControlFrame")
	f:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
	f:SetPoint("CENTER")
	f:SetScript("OnClick", function(self, aKey, aB)
		--dprint(aKey, aB)
		SkuOptions.bindingMode = nil

		for z = 1, #tBlockedKeysParts do
			if string.find(aKey, tBlockedKeysParts[z]) or string.find(string.lower(aKey), string.lower(tBlockedKeysParts[z])) then 
				SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
				return
			end
		end

		for z = 1, #tBlockedKeysBinds do
			if aKey == tBlockedKeysBinds[z] or string.lower(aKey) == string.lower(tBlockedKeysBinds[z]) then 
				SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
				return
			end
		end

		if aKey ~= "ESCAPE" then
			SetBinding(aKey)
			local key1, key2 = GetBindingKey(tActionBarData[aActionBarName].command..aButtonId)
			if key1 then SetBinding(key1) end
			if key2 then SetBinding(key2) end
			local ok = SetBinding(aKey , tActionBarData[aActionBarName].command..aButtonId)
			SaveBindings(GetCurrentBindingSet())

			if aType == "player" then
				local actionType, id, subType = GetActionInfo(self.menuTarget.buttonObj.action)
				self.menuTarget.name = L["Button"].." "..aButtonId..";"..ButtonContentNameHelper(actionType, id, subType, aActionBarName, aButtonId)
			elseif aType == "pet" then
				self.menuTarget.name = L["Button"].." "..aButtonId..";"..ButtonContentNameHelper("pet", aBooktypeOrObjId, subType, aActionBarName, aBooktypeOrObjId)
			end

			_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
			_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
			SkuOptions.Voice:OutputStringBTtts(L["New key"]..";"..aKey, true, true, 0.2)						
		else
			SkuOptions.Voice:OutputStringBTtts(L["Binding canceled"], true, true, 0.2)						
		end
		ClearOverrideBindings(self)
	end)
	SetOverrideBindingClick(f, true, "ESCAPE", "SkuCoreBindControlFrame", "ESCAPE")

	for i, v in pairs(_G) do 
		if string.find(i, "KEY_") == 1 then 
			if not string.find(i, "ESC") then
				--dprint(i, v, string.find(i, "KEY_"), string.sub(i, 5))
				for x = 1, #tModifierKeys do
					SetOverrideBindingClick(f, true, tModifierKeys[x]..string.sub(i, 5), "SkuCoreBindControlFrame", tModifierKeys[x]..string.sub(i, 5))
				end
			end
		end 
	end

	for x = 1, #tStandardChars do
		for y = 1, #tModifierKeys do
			SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardChars[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardChars[x])
		end
	end
	for x = 1, #tStandardNumbers do
		for y = 1, #tModifierKeys do
			SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardNumbers[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardNumbers[x])
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function MacrosMenuBuilder(aParentEntry)
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Macros"]}, SkuGenericMenuItem)
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
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {name}, SkuGenericMenuItem)
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
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {name}, SkuGenericMenuItem)
					tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.macroID = x
						SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = name, body
					end
					tHasEntries = true
				end
			end
		end

		if tHasEntries == false then
			SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, SkuGenericMenuItem)
		end
	end
end


---------------------------------------------------------------------------------------------------------------------------------------
local function ItemsMenuBuilder(aParentEntry)
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Items"]}, SkuGenericMenuItem)
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
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, SkuGenericMenuItem)
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
			SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, SkuGenericMenuItem)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SpellBookMenuBuilder(aParentEntry, aBooktype, aIsPet, aButtonsWithCurrentPetControlAction)
	aIsPet = aIsPet or false
	local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Assign nothing"]}, SkuGenericMenuItem)

	local tNumSpellTabs = 1
	if aIsPet == false then
		tNumSpellTabs = GetNumSpellTabs()
	end

	for x = 1, tNumSpellTabs do
		local name, texture, offset, numEntries, isGuild, offspecID = GetSpellTabInfo(x)
		local tNumEntries, token = HasPetSpells()
		if aIsPet == true then
			numEntries = tNumEntries or 0
		end
		
		local tNewMenuSubEntry
		if aIsPet == true then
			tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {_G["PET_TYPE_"..token]}, SkuGenericMenuItem)
		else
			tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParentEntry, {name}, SkuGenericMenuItem)
		end

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
					if spellName then
						local tIsPassive = IsPassiveSpell(spellID)
						local isKnown = IsSpellKnown(spellID, aIsPet)
						if not tIsPassive and isKnown then
							local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {spellName..";"..spellSubName}, SkuGenericMenuItem)
							tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
								self.selectTarget.petDefaultControlId = nil
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
			end
			if aIsPet == true then
				for i, v in pairs(aButtonsWithCurrentPetControlAction) do
					dprint("aButtonsWithCurrentPetControlAction", i, v, _G[i])
					local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {_G[i]}, SkuGenericMenuItem)
					tNewMenuSubSubEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.spellID = nil
						self.selectTarget.petDefaultControlId = v
						_G["SkuScanningTooltip"]:ClearLines()
						_G["SkuScanningTooltip"]:SetPetAction(v)
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

			if tHasEntries == false then
				local tNewMenuSubSubEntry = SkuOptions:InjectMenuItems(self, {L["Menu empty"]}, SkuGenericMenuItem)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function ActionBarMenuBuilder(aParentEntry, aActionBarName, aBooktype)
	if not aParentEntry or not aActionBarName then return end

	for x = 1, 12 do
		local tButtonObj = _G[tActionBarData[aActionBarName].buttonName..x]
		if tButtonObj then
			local actionType, id, subType = GetActionInfo(tButtonObj.action)
			local tButtonName = ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Button"].." "..x..";"..tButtonName}, SkuGenericMenuItem)
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
				--dprint("OnAction", "aValue", aValue, "aName", aName)
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
					SkuOptions.bindingMode = true
					SkuOptions.Voice:StopAllOutputs()
					C_Timer.After(0.001, function()
						BindingHelper(self, "player", x, aParentEntry, aActionBarName, aBooktype)
					end)
				end

				local actionType, id, subType = GetActionInfo(self.buttonObj.action)
				self.name = L["Button"].." "..x..";"..ButtonContentNameHelper(actionType, id, subType, aActionBarName, x)

				self.spellID = nil
				self.itemID = nil
				self.macroID = nil
			end
			tNewMenuEntry.BuildChildren = function(self)
				--[[
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {"Tastenbelegung"}, SkuGenericMenuItem)
				tNewMenuSubEntry.dynamic = true
				tNewMenuSubEntry.OnAction = function(self, aValue, aName)
					--dprint(self, aValue, aName)
					--dprint(self.parent.name)
					--dprint(self.parent.buttonObj)
					--dprint(self.parent.buttonObj:GetName())
				end
				]]
				SpellBookMenuBuilder(self, aBooktype)
				ItemsMenuBuilder(self)
				MacrosMenuBuilder(self)
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {L["Bind key"]}, SkuGenericMenuItem)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function PetActionBarMenuBuilder(aParentEntry, aActionBarName, aBooktype)
	if not aParentEntry or not aActionBarName then return end

	local tButtonsWithCurrentPetControlAction = {
		PET_MODE_AGGRESSIVE = -1,
		PET_MODE_PASSIVE = -1,
		PET_MODE_DEFENSIVE = -1,
		PET_ACTION_ATTACK = -1,
		PET_ACTION_WAIT = -1,
		PET_ACTION_FOLLOW = -1,
	}

	for x = 1, NUM_PET_ACTION_SLOTS do
		local tButtonObj = _G[tActionBarData[aActionBarName].buttonName..x]
		if tButtonObj then
			local name = GetPetActionInfo(x)
			if name and tButtonsWithCurrentPetControlAction[name] then
				tButtonsWithCurrentPetControlAction[name] = x
			end
		end
	end

	for x = 1, NUM_PET_ACTION_SLOTS do
		local tButtonObj = _G[tActionBarData[aActionBarName].buttonName..x]
		if tButtonObj then
			local name, texture, isToken, isActive, autoCastAllowed, autoCastEnabled, spellID = GetPetActionInfo(x);
			local tButtonName = ButtonContentNameHelper("pet", x, subType, aActionBarName, x) --_G[name] or name or L["empty"] 
			local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Button"].." "..x..";"..tButtonName}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.buttonObj = _G[tActionBarData[aActionBarName].buttonName..x]
			tNewMenuEntry.id = x
			tNewMenuEntry.OnEnter = function(self, aValue, aName)
				self.spellID = nil
				self.itemID = nil
				self.macroID = nil
				if self.buttonObj:GetID() and name then
					_G["SkuScanningTooltip"]:ClearLines()
					_G["SkuScanningTooltip"]:SetPetAction(x)
					if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
						if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
							local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
							SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = ItemName_helper(tText)
						end
					end
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				dprint("OnAction", "aValue", aValue, "aName", aName, "petDefaultControlId", self.spellID)
				local tButtonObjId = self.buttonObj:GetID()
				if aName == L["Assign nothing"] then
					PickupPetAction(self.buttonObj:GetID())
					ClearCursor()
				elseif self.spellID and not self.petDefaultControlId then
					ClearCursor()
					if self.spellID then
						PickupPetSpell(self.spellID)
						PickupPetAction(self.buttonObj:GetID())
						ClearCursor()
					end					
				elseif self.petDefaultControlId then
					PickupPetAction(self.petDefaultControlId)
					PickupPetAction(self.buttonObj:GetID())
					ClearCursor()
				elseif aName == L["Bind key"] then
					SkuOptions.bindingMode = true
					SkuOptions.Voice:StopAllOutputs()
					C_Timer.After(0.001, function()				
						BindingHelper(self, "pet", x, aParentEntry, aActionBarName, tButtonObjId)
					end)
				end

				self.name = L["Button"].." "..x..";"..ButtonContentNameHelper("pet", self.id, subType, aActionBarName, self.id)
				self.spellID = nil
			end
			tNewMenuEntry.BuildChildren = function(self)
				SpellBookMenuBuilder(self, aBooktype, true, tButtonsWithCurrentPetControlAction)
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(self, {L["Bind key"]}, SkuGenericMenuItem)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function RangecheckMenuBuilder(aParent, aType)
	local tEntriesFound = false
	for i = 1, 100 do 
		if SkuCore.RangeCheckValues.Ranges[aType][i] then 
			local tIsConfiguredWith = ";"..L["silent"]
			if SkuOptions.db.char[MODULE_NAME].RangeChecks[aType][i] then
				if SkuOptions.db.char[MODULE_NAME].RangeChecks[aType][i].sound == L["vocalized"] then
					tIsConfiguredWith = ";"..L["vocalized"]
				else
					tIsConfiguredWith = ";"..SkuCore.RangeCheckSounds[SkuOptions.db.char[MODULE_NAME].RangeChecks[aType][i].sound]
				end
			end
			local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {i..tIsConfiguredWith}, SkuGenericMenuItem)
			tEntriesFound = true
			tNewSubMenuEntry.dynamic = true
			tNewSubMenuEntry.isSelect = true
			tNewSubMenuEntry.OnAction = function(self, aValue, aName, aParentMenuName)
				local tRange = string.split(";", aParentMenuName)
				if aName == L["vocalized"] then
					SkuOptions.db.char[MODULE_NAME].RangeChecks[aType][tonumber(tRange)] = {sound = L["vocalized"],}
				else
					for qi, qv in pairs(SkuCore.RangeCheckSounds) do
						if string.find(qv, aName) then
							SkuOptions.db.char[MODULE_NAME].RangeChecks[aType][tonumber(tRange)] = {sound = qi,}
						end
					end
				end
				self.name = tRange..";"..aName
			end
			tNewSubMenuEntry.BuildChildren = function(self)
				local tNewSubSoundMenuEntry = SkuOptions:InjectMenuItems(self, {L["vocalized"]}, SkuGenericMenuItem)
				for x, v in pairs(SkuCore.RangeCheckSounds) do
					local tNewSubSoundMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
					tNewSubSoundMenuEntry.dynamic = true
				end
			end
		end
	end
	if tEntriesFound == false then
		local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["leer"]}, SkuGenericMenuItem)
	end

end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MenuBuilder(aParentEntry)
	--dprint("SkuCore:MenuBuilder", aParentEntry)
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Mail"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New letter"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		--tNewMenuEntry.ttsEngine = 2
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--dprint(aName)
			--open the specific edit box for aname and write result to current mi.tmpx
			
			
			if string.find(aName, L["KommaNumbers"]) and tonumber(string.sub(aName, 0, 1)) == 0 then
				local tFormatted = string.gsub(aName, ";"..L["KommaNumbers"]..";", ".")
				tFormatted = string.gsub(tFormatted, ";", "")
				if tonumber(tFormatted) then
					aName = tonumber(tFormatted)
				end
			end

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
						SkuOptions.Voice:OutputStringBTtts(L["No Recipient"], false, true, 0.2)
					end
					if not self.TmpSubject then
						SkuOptions.Voice:OutputStringBTtts(L["No topic"], false, true, 0.2)
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
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Recepient"]}, SkuGenericMenuItem)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Topic"]}, SkuGenericMenuItem)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Gold"]}, SkuGenericMenuItem)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			tNewMenuParentEntrySubSub.dynamic = true
			tNewMenuParentEntrySubSub.BuildChildren = function(self)
				for x = 1, 9 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {"0;"..L["KommaNumbers"]..";0;"..(x * 1)}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 9 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {"0;"..L["KommaNumbers"]..";"..(x * 1)}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 25 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 15 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*5 + 25}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 20 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*10 + 100}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 20 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*20 + 300}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
				for x = 1, 23 do
					local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*50 + 700}, SkuGenericMenuItem)
					tNewMenuParentEntrySubSubItem.noMenuNumbers = true
				end
			end
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Items"]}, SkuGenericMenuItem)
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
								--dprint(bag, slot, itemLink)
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, SkuGenericMenuItem)
							end
						end
					end
				end
			end
			--tNewMenuParentEntrySubSub.ttsEngine = 2
			local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Send"]}, SkuGenericMenuItem)
			--tNewMenuParentEntrySubSub.ttsEngine = 2
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Open all"]}, SkuGenericMenuItem)
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
						SkuOptions.Voice:OutputStringBTtts(L["All opened"], false, true, 0.2)						
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
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tSubject}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.ttsEngine = 2
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					--dprint("onaction mailitem", self, aValue, aName)
					--dprint(aName, self.TmpMailItemIndex, self.TmpMailItemIndexAttachmentIndex)
					if aName == L["Reply"] then
						--dprint(self.name, "beantworten")

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
					local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Reply"]}, SkuGenericMenuItem)
					tNewMenuParentEntrySub.dynamic = true
					tNewMenuParentEntrySub.isSelect = true
					--tNewMenuParentEntrySub.ttsEngine = 2
					tNewMenuParentEntrySub.OnAction = function(self, aValue, aName)
						--dprint(aName)
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
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Recepient"]}, SkuGenericMenuItem)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Topic"]}, SkuGenericMenuItem)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Text"]}, SkuGenericMenuItem)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Gold"]}, SkuGenericMenuItem)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						tNewMenuParentEntrySubSub.dynamic = true
						tNewMenuParentEntrySubSub.BuildChildren = function(self)
							for x = 1, 25 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
							end
							for x = 1, 15 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*5 + 25}, SkuGenericMenuItem)
							end
							for x = 1, 20 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*10 + 100}, SkuGenericMenuItem)
							end
							for x = 1, 20 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*20 + 300}, SkuGenericMenuItem)
							end
							for x = 1, 23 do
								local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {x*50 + 700}, SkuGenericMenuItem)
							end
						end
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Items"]}, SkuGenericMenuItem)
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
											--dprint(bag, slot, itemLink)
											local tNewMenuParentEntrySubSubItem = SkuOptions:InjectMenuItems(self, {bag.." "..slot..": "..C_Item.GetItemNameByID(itemLink).." ("..itemCount..")"}, SkuGenericMenuItem)
										end
									end
								end
							end
						end
						--tNewMenuParentEntrySubSub.ttsEngine = 2
						local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Send"]}, SkuGenericMenuItem)
						--tNewMenuParentEntrySubSub.ttsEngine = 2
					end

					if hasItem or (money and money > 0) then
						local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Attachments"]}, SkuGenericMenuItem)
						tNewMenuParentEntrySub.dynamic = true
						--tNewMenuParentEntrySub.ttsEngine = 2
						tNewMenuParentEntrySub.BuildChildren = function(self)
							if (money and money > 0 and CODAmount == 0) then
								local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Take gold"]}, SkuGenericMenuItem)
								--tNewMenuParentEntrySubSub.dynamic = true
								--tNewMenuParentEntrySubSub.ttsEngine = 2
							end

							if hasItem then
								local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {L["Take all"]}, SkuGenericMenuItem)
								--tNewMenuParentEntrySubSub.dynamic = true
								--tNewMenuParentEntrySubSub.ttsEngine = 2
								for y = 1, ATTACHMENTS_MAX_RECEIVE do
									local itemLink = GetInboxItemLink(x, y)
									--itemLink = itemLink or L["Empty"]
									if itemLink then
										local name = GetInboxItem(x, y)
										name = name or L["Empty"]
										local tNewMenuParentEntrySubSub = SkuOptions:InjectMenuItems(self, {y.." "..name}, SkuGenericMenuItem)
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

					local tNewMenuParentEntrySub = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
					--tNewMenuParentEntrySub.dynamic = true
					--tNewMenuParentEntrySub.ttsEngine = 2
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Action bars"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MainMenuBar"].friendlyName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MainMenuBar", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarBottomLeft"].friendlyName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarBottomLeft", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarBottomRight"].friendlyName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarBottomRight", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarRight"].friendlyName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarRight", BOOKTYPE_SPELL)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["MultiBarLeft"].friendlyName}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			ActionBarMenuBuilder(self, "MultiBarLeft", BOOKTYPE_SPELL)
		end

		--if HasPetSpells() then
		if _G["PetActionBarFrame"] and _G["PetActionBarFrame"]:IsShown() == true then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tActionBarData["PetBar"].friendlyName}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.BuildChildren = function(self)
				PetActionBarMenuBuilder(self, "PetBar", BOOKTYPE_PET)
			end
		end

		--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Einstellungen"}, SkuGenericMenuItem)
		--tNewMenuEntry.dynamic = true
		--tNewMenuEntry.BuildChildren = function(self)
		--end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Entfernung"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Freundlich"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			RangecheckMenuBuilder(self, "Friendly")
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Feindlich"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			RangecheckMenuBuilder(self, "Hostile")
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Unbekannt"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			RangecheckMenuBuilder(self, "Misc")
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Spiel Tastenbelegung"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Alles zurücksetzen"]}, SkuGenericMenuItem)
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {L["Wirklich zurücksetzen? (keine weitere Warnung)"]}, SkuGenericMenuItem)
			tNewMenuEntry1.OnAction = function(self, aValue, aName)
				SkuCore:ResetBindings()
				SkuOptions.Voice:OutputStringBTtts(L["Alle Tasten Belegungen wurden auf die Standardeinstellungen zurückgesetzt."], true, true, 0.2)						
			end
			local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {L["Oh nein hilfe! Ich bin ein Trottel und will doch nicht zurücksetzen"]}, SkuGenericMenuItem)
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Taste zuweisen"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			--dprint("Taste zuweisen 2 BuildChildren")
			local tBindings = {}

			local aBindingSet = GetCurrentBindingSet()
			local tNumKeyBindings = GetNumBindings()
			local tCurrentCategory = ""
		
			for x = 1, tNumKeyBindings do
				local tCommand, tCategory, tKey1, tKey2 = GetBinding(x, aBindingSet)
				if tCategory ~= tCurrentCategory then
					tCurrentCategory = tCategory
					if not tCurrentCategory then 
						tCurrentCategory = "ADDONS" 
					end
					tBindings[tCurrentCategory] = {}
				end
				tBindings[tCurrentCategory][tCommand] = {key1 = tKey1, key2 = tKey2, index = x}
			end			

			SkuOptions.db.profile[MODULE_NAME].tBindings = tBindings

			for categoryConst, v in pairs(tBindings) do
				local tNewMenuEntryCat 
				if _G[categoryConst] then
					tNewMenuEntryCat = SkuOptions:InjectMenuItems(self, {_G[categoryConst]}, SkuGenericMenuItem)
				else
					tNewMenuEntryCat = SkuOptions:InjectMenuItems(self, {categoryConst}, SkuGenericMenuItem)
				end
				tNewMenuEntryCat.dynamic = true
				tNewMenuEntryCat.filterable = true

				tNewMenuEntryCat.BuildChildren = function(self)
					--dprint("categoryConst BuildChildren")
					local tBindings = {}

					local aBindingSet = GetCurrentBindingSet()
					local tNumKeyBindings = GetNumBindings()
					local tCurrentCategory = ""
				
					for x = 1, tNumKeyBindings do
						local tCommand, tCategory, tKey1, tKey2 = GetBinding(x, aBindingSet)
						if tCategory ~= tCurrentCategory then
							tCurrentCategory = tCategory
							if not tCurrentCategory then 
								tCurrentCategory = "ADDONS" 
							end	
							tBindings[tCurrentCategory] = tBindings[tCurrentCategory] or {}
						end
						tBindings[tCurrentCategory][tCommand] = {key1 = tKey1, key2 = tKey2, index = x}
					end	

					for categoryConst2, v in pairs(tBindings) do
						for commandConst2, v1 in pairs(v) do
							if categoryConst2 == categoryConst then
								if _G["BINDING_NAME_" .. commandConst2] then
									--local tLocKey = gsub(v1.key1, "CTRL", "STRG")
									local tFriendlyKey1, tFriendlyKey2 = v1.key1 or L["nichts"], v1.key2 or L["nichts"]
									for kLocKey, vLocKey in pairs(SkuCore.Keys.LocNames) do
										tFriendlyKey1 = gsub(tFriendlyKey1, kLocKey, vLocKey)
										tFriendlyKey2 = gsub(tFriendlyKey2, kLocKey, vLocKey)
									end
									if tFriendlyKey1 == "-" then
										tFriendlyKey1 = L["Minus"]
									else
										tFriendlyKey1 = gsub(tFriendlyKey1, "%-%-", "-"..L["Minus"])
									end
									if tFriendlyKey2 == "-" then
										tFriendlyKey2 = L["Minus"]
									else
										tFriendlyKey2 = gsub(tFriendlyKey2, "%-%-", "-"..L["Minus"])
									end

									local tNewMenuEntryKey = SkuOptions:InjectMenuItems(self, {_G["BINDING_NAME_" .. commandConst2]..L[" Taste 1: "]..(tFriendlyKey1 or L["nichts"])}, SkuGenericMenuItem)
									tNewMenuEntryKey.isSelect = true
									tNewMenuEntryKey.dynamic = true
									tNewMenuEntryKey.OnAction = function(self, aValue, aName)
										--dprint("cat OnAction 2", aValue, aName, self.name)
										if aName == L["Neu belegen"] then
											SkuOptions.bindingMode = true

											C_Timer.After(0.001, function()
												SkuOptions.Voice:OutputStringBTtts(L["Press new key or Escape to cancel"], true, true, 0.2, true, nil, nil, 2)

												local f = _G["SkuCoreBindControlFrame"] or CreateFrame("Button", "SkuCoreBindControlFrame", UIParent, "UIPanelButtonTemplate")
												f.menuTarget = self
												f.command = self.command
												f.category = self.category
												f.index = self.index
												f.prevKey = nil
							
												f:SetSize(80, 22)
												f:SetText("SkuCoreBindControlFrame")
												f:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
												f:SetPoint("CENTER")
												f:SetScript("OnClick", function(self, aKey, aB)
													--dprint(aKey, aB)
													if aKey ~= "ESCAPE" then
														if not self.command or not self.category or not self.menuTarget or not self.index then return end
														for z = 1, #tBlockedKeysParts do
															if string.find(aKey, tBlockedKeysParts[z]) or string.find(string.lower(aKey), string.lower(tBlockedKeysParts[z])) then 
																SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
																self.prevKey = nil

																return 
															end
														end

														for z = 1, #tBlockedKeysBinds do
															if aKey == tBlockedKeysBinds[z] or string.lower(aKey) == string.lower(tBlockedKeysBinds[z]) then 
																SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
																return
															end
														end

														local tCommand = SkuCore:CheckBound(aKey)
														local bindingConst = SkuOptions:SkuKeyBindsCheckBound(aKey)
														if tCommand or bindingConst then
															if not self.prevKey or self.prevKey ~= aKey then
																self.prevKey = aKey
																if bindingConst then
																	SkuOptions.Voice:OutputStringBTtts(L["Warning! That key is already bound to"].." "..L[bindingConst]..L[". Press the key again to confirm new binding. The current bound action will be unbound!"], true, true, 0.2, true, nil, nil, 2)
																elseif tCommand then
																	SkuOptions.Voice:OutputStringBTtts(L["Warning! That key is already bound to"].." ".._G["BINDING_NAME_"..tCommand]..L[". Press the key again to confirm new binding. The current bound action will be unbound!"], true, true, 0.2, true, nil, nil, 2)
																end
																return 
															end
														end
					
														if tCommand or bindingConst and self.prevKey == aKey then
															if bindingConst then
																SkuOptions:SkuKeyBindsDeleteBinding(bindingConst)
															elseif tCommand then
																SkuCore:DeleteBinding(tCommand)
															end
														end
														
														SkuCore:SetBinding(aKey, self.command)
														
														local tCommand, tCategory, tKey1, tKey2 = GetBinding(self.index, GetCurrentBindingSet())
														local tFriendlyKey1, tFriendlyKey2 = tKey1 or L["nichts"], tKey2 or L["nichts"]
														for kLocKey, vLocKey in pairs(SkuCore.Keys.LocNames) do
															tFriendlyKey1 = gsub(tFriendlyKey1, kLocKey, vLocKey)
															tFriendlyKey2 = gsub(tFriendlyKey2, kLocKey, vLocKey)
														end				
														if tCommand or bindingConst then
															_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
														else
															self.menuTarget.name = _G["BINDING_NAME_" .. tCommand]..L[" Taste 1: "]..(tFriendlyKey1)..L[" Taste 2: "]..(tFriendlyKey2)
															_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
															_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
														end
														SkuOptions.Voice:OutputStringBTtts(L["New key"]..";"..tFriendlyKey1, true, true, 0.2, true, nil, nil, 2)
													elseif aKey == "ESCAPE" then
														SkuOptions.Voice:OutputStringBTtts(L["Binding canceled"], true, true, 0.2, true, nil, nil, 2)
													end
													ClearOverrideBindings(self)
													SkuOptions.bindingMode = nil
												end)
												SetOverrideBindingClick(f, true, "ESCAPE", "SkuCoreBindControlFrame", "ESCAPE")
							
												for i, v in pairs(_G) do 
													if string.find(i, "KEY_") == 1 then 
														if not string.find(i, "ESC") then
															for x = 1, #tModifierKeys do
																SetOverrideBindingClick(f, true, tModifierKeys[x]..string.sub(i, 5), "SkuCoreBindControlFrame", tModifierKeys[x]..string.sub(i, 5))
															end
														end
													end 
												end
							
												for x = 1, #tStandardChars do
													for y = 1, #tModifierKeys do
														SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardChars[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardChars[x])
													end
												end
												for x = 1, #tStandardNumbers do
													for y = 1, #tModifierKeys do
														SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardNumbers[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardNumbers[x])
													end
												end
											end)											
										elseif aName == L["Belegung löschen"] then
											if not self.command or not self.category or not self.index then return end
											SkuCore:DeleteBinding(self.command)
											local tCommand, tCategory, tKey1, tKey2 = GetBinding(self.index, GetCurrentBindingSet())
											local tFriendlyKey1, tFriendlyKey2
											self.name = _G["BINDING_NAME_" .. tCommand]..L[" Taste 1: "]..(tFriendlyKey1 or L["nichts"])..L[" Taste 2: "]..(tFriendlyKey2 or L["nichts"])
											_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
											_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
											SkuOptions.Voice:OutputStringBTtts(L["Belegung gelöscht"], true, true, 0.2)						
										end					
									end
									tNewMenuEntryKey.command = commandConst2
									tNewMenuEntryKey.category = categoryConst2
									tNewMenuEntryKey.index = v1.index
									
									tNewMenuEntryKey.BuildChildren = function(self)
										local tNewMenuEntryKeyAction = SkuOptions:InjectMenuItems(self, {L["Neu belegen"]}, SkuGenericMenuItem)
										local tNewMenuEntryKeyAction = SkuOptions:InjectMenuItems(self, {L["Belegung löschen"]}, SkuGenericMenuItem)
									end

								end
							end
						end
					end
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Sku Tastenbelegung"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Alles zurücksetzen"]}, SkuGenericMenuItem)
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {L["Wirklich zurücksetzen? (keine weitere Warnung)"]}, SkuGenericMenuItem)
			tNewMenuEntry1.OnAction = function(self, aValue, aName)
				SkuOptions:SkuKeyBindsResetBindings()
				SkuOptions.Voice:OutputStringBTtts(L["Alle Tasten Belegungen wurden auf die Standardeinstellungen zurückgesetzt."], true, true, 0.2)						
			end
			local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {L["Oh nein hilfe! Ich bin ein Trottel und will doch nicht zurücksetzen"]}, SkuGenericMenuItem)
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Taste zuweisen"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			--dprint("Taste zuweisen 2 BuildChildren")
			for tBindingConst, v in pairs(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds) do
				local tFriendlyKey1
				if v.key == "" then
					tFriendlyKey1 = L["nichts"]
				else
					tFriendlyKey1 = v.key or L["nichts"]
				end
				for kLocKey, vLocKey in pairs(SkuCore.Keys.LocNames) do
					tFriendlyKey1 = gsub(tFriendlyKey1, kLocKey, vLocKey)
				end
				if tFriendlyKey1 == "-" then
					tFriendlyKey1 = L["Minus"]
				else
					tFriendlyKey1 = gsub(tFriendlyKey1, "%-%-", "-"..L["Minus"])
				end

				local tFix = ""
				if tBindingConst == "SKU_KEY_TURNTOBEACON" then
					tFix = L["fixed"]
				end
				local tNewMenuEntryKey = SkuOptions:InjectMenuItems(self, {L[tBindingConst].." "..L["Taste"]..":"..(tFriendlyKey1 or L["nichts"]).." "..tFix}, SkuGenericMenuItem)
				tNewMenuEntryKey.isSelect = true
				tNewMenuEntryKey.dynamic = true
				tNewMenuEntryKey.OnAction = function(self, aValue, aName)
					dprint("Taste zuweisen OnAction", aValue, aName, self.name)
					if aName == L["fixed"] then
						return
					end
					if aName == L["Neu belegen"] then
						SkuOptions.bindingMode = true

						C_Timer.After(0.001, function()
							SkuOptions.Voice:OutputStringBTtts(L["Press new key or Escape to cancel"], true, true, 0.2, true, nil, nil, 2)

							local f = _G["SkuCoreBindControlFrame"] or CreateFrame("Button", "SkuCoreBindControlFrame", UIParent, "UIPanelButtonTemplate")
							f.menuTarget = self
							f.bindingConst = self.bindingConst
							f.prevKey = nil
		
							f:SetSize(80, 22)
							f:SetText("SkuCoreBindControlFrame")
							f:SetPoint("LEFT", UIParent, "RIGHT", 1500, 0)
							f:SetPoint("CENTER")
							f:SetScript("OnClick", function(self, aKey, aB)
								dprint("SkuCoreBindControlFrame OnClick", aKey, aB)
								if aKey ~= "ESCAPE" then
									if not self.bindingConst or not self.menuTarget then return end
									for z = 1, #tBlockedKeysParts do
										if string.find(aKey, tBlockedKeysParts[z]) or string.find(string.lower(aKey), string.lower(tBlockedKeysParts[z])) then 
											SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
											self.prevKey = nil
											return 
										end
									end
									for z = 1, #tBlockedKeysBinds do
										if aKey == tBlockedKeysBinds[z] or string.lower(aKey) == string.lower(tBlockedKeysBinds[z]) then 
											SkuOptions.Voice:OutputStringBTtts(L["Ungültig. Andere Taste drücken."], true, true, 0.2, true, nil, nil, 2)
											return
										end
									end
							

									dprint(self.bindingConst, self.menuTarget, self.menuTarget.name, self.prevKey)

									local tCommand = SkuCore:CheckBound(aKey)
									local bindingConst = SkuOptions:SkuKeyBindsCheckBound(aKey)
									if tCommand or bindingConst then
										if not self.prevKey or self.prevKey ~= aKey then
											self.prevKey = aKey
											if bindingConst then
												SkuOptions.Voice:OutputStringBTtts(L["Warning! That key is already bound to"].." "..L[bindingConst]..L[". Press the key again to confirm new binding. The current bound action will be unbound!"], true, true, 0.2, true, nil, nil, 2)
											elseif tCommand then
												SkuOptions.Voice:OutputStringBTtts(L["Warning! That key is already bound to"].." ".._G["BINDING_NAME_"..tCommand]..L[". Press the key again to confirm new binding. The current bound action will be unbound!"], true, true, 0.2, true, nil, nil, 2)
											end
											return 
										end
									end

									if tCommand or bindingConst and self.prevKey == aKey then
										if bindingConst then
											SkuOptions:SkuKeyBindsDeleteBinding(bindingConst)
										elseif tCommand then
											SkuCore:DeleteBinding(tCommand)
										end
									end

									SkuOptions:SkuKeyBindsSetBinding(self.bindingConst, aKey)
									
									local tKey1 = SkuOptions:SkuKeyBindsGetBinding(self.bindingConst)
									local tFriendlyKey1 = tKey1 or L["nichts"]
									for kLocKey, vLocKey in pairs(SkuCore.Keys.LocNames) do
										tFriendlyKey1 = gsub(tFriendlyKey1, kLocKey, vLocKey)
									end							
									if tCommand or bindingConst then
										_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
									else
										self.menuTarget.name = L[self.bindingConst].." "..L["Taste"]..":"..(tFriendlyKey1 or L["nichts"]) --_G["BINDING_NAME_" .. tCommand]..L[" Taste 1: "]..(tFriendlyKey1)..L[" Taste 2: "]..(tFriendlyKey2)
										_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
										_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
									end
									SkuOptions.Voice:OutputStringBTtts(L["New key"]..";"..tFriendlyKey1, true, true, 0.2, true, nil, nil, 2)
								elseif aKey == "ESCAPE" then
									self.prevKey = nil
									SkuOptions.Voice:OutputStringBTtts(L["Binding canceled"], true, true, 0.2, true, nil, nil, 2)
								end
								ClearOverrideBindings(self)
								SkuOptions.bindingMode = nil
							end)
							SetOverrideBindingClick(f, true, "ESCAPE", "SkuCoreBindControlFrame", "ESCAPE")
		
							for i, v in pairs(_G) do 
								if string.find(i, "KEY_") == 1 then 
									if not string.find(i, "ESC") then
										for x = 1, #tModifierKeys do
											SetOverrideBindingClick(f, true, tModifierKeys[x]..string.sub(i, 5), "SkuCoreBindControlFrame", tModifierKeys[x]..string.sub(i, 5))
										end
									end
								end 
							end
		
							for x = 1, #tStandardChars do
								for y = 1, #tModifierKeys do
									SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardChars[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardChars[x])
								end
							end
							for x = 1, #tStandardNumbers do
								for y = 1, #tModifierKeys do
									SetOverrideBindingClick(f, true, tModifierKeys[y]..tStandardNumbers[x], "SkuCoreBindControlFrame", tModifierKeys[y]..tStandardNumbers[x])
								end
							end
						end)											
					elseif aName == L["Belegung löschen"] then
						if not self.bindingConst then return end
						SkuOptions:SkuKeyBindsDeleteBinding(self.bindingConst)
						local tKey1 = SkuOptions:SkuKeyBindsGetBinding(self.bindingConst)
						local tFriendlyKey1
						self.name = L[self.bindingConst].." "..L["Taste"]..":"..(tFriendlyKey1 or L["nichts"]) 
						_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "RIGHT")
						_G["OnSkuOptionsMainOption1"]:GetScript("OnClick")(_G["OnSkuOptionsMainOption1"], "LEFT")
						SkuOptions.Voice:OutputStringBTtts(L["Belegung gelöscht"], true, true, 0.2)						
					end					
				end
				tNewMenuEntryKey.bindingConst = tBindingConst
				--tNewMenuEntryKey.category = categoryConst2
				--tNewMenuEntryKey.index = v1.index
				
				tNewMenuEntryKey.BuildChildren = function(self)
					if tBindingConst ~= "SKU_KEY_TURNTOBEACON" then
						local tNewMenuEntryKeyAction = SkuOptions:InjectMenuItems(self, {L["Neu belegen"]}, SkuGenericMenuItem)
						local tNewMenuEntryKeyAction = SkuOptions:InjectMenuItems(self, {L["Belegung löschen"]}, SkuGenericMenuItem)
					else
						local tNewMenuEntryKeyAction = SkuOptions:InjectMenuItems(self, {L["fixed"]}, SkuGenericMenuItem)
					end
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Scan settings"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.BuildChildren = function(self)
		for x = 1, 8 do
			local tText = SkuCore.ScanTypes[SkuOptions.db.char["SkuCore"].scanConfigs[x].type].name
			for iDb, vDb in pairs(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects) do
				tText = tText..", "..L[SkuCore.ScanObjects[vDb]]
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["SKU_KEY_SCAN"..x].." "..tText}, SkuGenericMenuItem)
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.scanNumber = nil
			tNewMenuEntry.tAction = nil
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				--print(L["SKU_KEY_SCAN"..x].." OnAction", aValue, aName, self.name, self.tAction)
				if aName == L["Empty"] then
					return
				end
				if self.tAction == "type" then
					for i, v in pairs(SkuCore.ScanTypes) do
						if v.name == aName then
							SkuOptions.db.char["SkuCore"].scanConfigs[x].type = i
							C_Timer.After(0.01, function()
								self:OnUpdate()
							end)
							return
						end
					end
				elseif self.tAction == "add" then
					for i, v in pairs(SkuCore.ScanObjects) do
						if aName == L[v] then
							local tFound = false
							for iDb, vDb in pairs(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects) do
								if i == vDb then
									tFound = true
								end
							end
							if tFound == false then
								table.insert(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects, i)
								C_Timer.After(0.01, function()
									self:OnUpdate()
								end)
								return
							end
						end
					end

				elseif self.tAction == "remove" then
					for i, v in pairs(SkuCore.ScanObjects) do
						if aName == L[v] then
							for iDb, vDb in pairs(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects) do
								if i == vDb then
									table.remove(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects, iDb)
									C_Timer.After(0.01, function()
										self:OnUpdate()
									end)
									return
								end
							end
						end
					end

				end
			end
			tNewMenuEntry.OnEnter = function(self, aValue, aName)
				self.tAction = nil
			end

			tNewMenuEntry.BuildChildren = function(self)
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["type"]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					for y = 1, #SkuCore.ScanTypes  do
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuCore.ScanTypes[y].name}, SkuGenericMenuItem)
						tNewMenuEntry.OnEnter = function(self, aValue, aName)
							SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = SkuCore.ScanTypes[y].name, SkuCore.ScanTypes[y].desc
							self.selectTarget.tAction = "type"
							self.selectTarget.scanNumber = y
						end
					end
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["add object"]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					local tEmpty = true
					for i, v in pairs(SkuCore.ScanObjects) do
						local tFound = false
						for iDb, vDb in pairs(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects) do
							if i == vDb then
								tFound = true
							end
						end
						if tFound == false then
							tEmpty = false
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[v]}, SkuGenericMenuItem)
							tNewMenuEntry.OnEnter = function(self, aValue, aName)
								SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = "", ""
								self.selectTarget.tAction = "add"
							end
						end
					end
					if tEmpty == true then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
					end
				end
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["remove object"]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					local tEmpty = true
					for i, v in pairs(SkuCore.ScanObjects) do
						local tFound = false
						for iDb, vDb in pairs(SkuOptions.db.char["SkuCore"].scanConfigs[x].objects) do
							if i == vDb then
								tFound = true
							end
						end
						if tFound == true then
							tEmpty = false
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[v]}, SkuGenericMenuItem)
							tNewMenuEntry.OnEnter = function(self, aValue, aName)
								SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = "", ""
								self.selectTarget.tAction = "remove"
							end
						end
					end
					if tEmpty == true then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
					end

				end
			end
		end

	end


	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Auktionshaus"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.BuildChildren = SkuCore.AuctionHouseMenuBuilder

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuCore.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end






---@diagnostic disable: undefined-doc-name
local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L

SkuAuras = LibStub("AceAddon-3.0"):NewAddon("SkuAuras", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
local CleuBase = {
	timestamp = 1,
	subevent = 2,
	hideCaster =3 ,
	sourceGUID = 4,
	sourceName = 5,
	sourceFlags = 6,
	sourceRaidFlags = 7,
	destGUID = 8,
	destName = 9,
	destFlags = 10,
	destRaidFlags = 11,
	spellId = 12,
	spellName = 13,
	spellSchool = 14,
	unitHealthPlayer = 35,
	unitPowerPlayer = 36,
	buffListTarget = 37,
	dbuffListTarget = 38,
	itemID = 40,
	missType = 41,
--key = 50
--combo = 51
}

SkuAuras.ItemCDRepo = {}
SkuAuras.SpellCDRepo = {}
SkuAuras.UnitRepo = {}
SkuAuras.thingsNamesOnCd = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnInitialize()
	SkuAuras:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuAuras:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	SkuAuras:RegisterEvent("BAG_UPDATE_COOLDOWN")
	SkuAuras:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnEnable()
	--dprint("SkuAuras OnEnable")

	--frame to trigger custom "keypress" event
	local f = _G["SkuAurasKeypressTrigger"] or CreateFrame("Frame", "SkuAurasKeypressTrigger", UIParent)
	f:EnableKeyboard(true)
	f:SetPropagateKeyboardInput(true)
	f:SetPoint("TOP", _G["SkuAurasControl"], "BOTTOM", 0, 0)
	f:SetScript("OnKeyDown", function(self, aKey)
		--print(aKey)
		local aEventData =  {
			GetTime(),
			"KEY_PRESS",
			nil,
			nil,
			UnitName("player"),
			nil,
			nil,
			nil,
			UnitName("playertarget"),
			nil,
			nil,
			nil,
			nil,
			nil,
		}
		aEventData[50] = aKey

		SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
	end)

	local ttime = 0
	local f = _G["SkuAurasControl"] or CreateFrame("Frame", "SkuAurasControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		ttime = ttime + time
		--if ttime < 0.05 then return end

		SkuAuras:COOLDOWN_TICKER()
		SkuAuras:UNIT_TICKER("player")
		--SkuAuras:UNIT_TICKER("playertarget")
		SkuAuras:UNIT_TICKER("focus")
		--SkuAuras:UNIT_TICKER("focustarget")
		SkuAuras:UNIT_TICKER("target")
		--SkuAuras:UNIT_TICKER("targettarget")
		SkuAuras:UNIT_TICKER("pet")
		--SkuAuras:UNIT_TICKER("pettarget")
		for x = 1, 4 do
			SkuAuras:UNIT_TICKER("party"..x)
			--SkuAuras:UNIT_TICKER("party"..x.."target")
		end
		for x = 1, 40 do
			SkuAuras:UNIT_TICKER("raid"..x)
		end

		ttime = 0
	end)
	f:Show()

	local tFrame = _G["SkuAurasControlOption1"] or  CreateFrame("Button", "SkuAurasControlOption1", _G["UIParent"], "UIPanelButtonTemplate")
	tFrame:SetSize(1, 1)
	tFrame:SetText("SkuAurasControlOption1")
	tFrame:SetPoint("TOP", _G["SkuAurasControl"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		--if aKey == "CTRL-SHIFT-G" then
			--dprint(aKey)
		--end
	end)
	tFrame:SetScript("OnShow", function(self) 
		--SetOverrideBindingClick(self, true, "CTRL-SHIFT-G", "SkuAurasControlOption1", "CTRL-SHIFT-G")
	end)
	tFrame:SetScript("OnHide", function(self) 
		ClearOverrideBindings(self)
	end)
	tFrame:Show()
	--SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-G", "SkuAurasControlOption1", "CTRL-SHIFT-G")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnDisable()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:GetBestUnitId(aUnitGUID)

	if not aUnitGUID then
		return {}
	end
	if aUnitGUID == "" then
		return {}
	end

	local tUnitIds = {}

	local function checkUnit(unit)
		if aUnitGUID == UnitGUID(unit) then
			tUnitIds[#tUnitIds + 1] = unit
		end
	end

	if IsInRaid() then
		for x = 1, 40 do
			checkUnit("raid" .. x)
		end
	end
	if IsInGroup() then
		checkUnit("party0")
		for x = 1, 4 do
			checkUnit("party" .. x)
			checkUnit("party" .. x .. "target")
		end
	end
	checkUnit("target")
	checkUnit("player")
	checkUnit("pet")
	checkUnit("focus")
	checkUnit("focustarget")
	checkUnit("targettarget")

	return tUnitIds
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetItemCooldownLeft(start, duration)
	-- Before restarting the GetTime() will always be greater than [start]
	-- After the restart, [start] is technically always bigger because of the 2^32 offset thing
	if start < GetTime() then
		 local cdEndTime = start + duration
		 local cdLeftDuration = cdEndTime - GetTime()
		 
		 return cdLeftDuration
	end

	local time = time()
	local startupTime = time - GetTime()
	-- just a simplification of: ((2^32) - (start * 1000)) / 1000
	local cdTime = (2 ^ 32) / 1000 - start
	local cdStartTime = startupTime - cdTime
	local cdEndTime = cdStartTime + duration
	local cdLeftDuration = cdEndTime - time
	
	return cdLeftDuration
end

---------------------------------------------------------------------------------------------------------------------------------------
local function TableCopy(t, deep, seen)
	seen = seen or {}
	if t == nil then return nil end
	if seen[t] then return seen[t] end
	local nt = {}
	for k, v in pairs(t) do
		if type(v) ~= "userdata" and k ~= "frame" and k ~= 0  then
			if deep and type(v) == 'table' then
				nt[k] = TableCopy(v, deep, seen)
			else
				nt[k] = v
			end
		end
	end
	--setmetatable(nt, getmetatable(t), deep, seen))
	seen[t] = nt
	return nt
end

---------------------------------------------------------------------------------------------------------------------------------------
local tItemHook
function SkuAuras:PLAYER_ENTERING_WORLD(aEvent, aIsInitialLogin, aIsReloadingUi)
	dprint("PLAYER_ENTERING_WORLD", aEvent, aIsInitialLogin, aIsReloadingUi)
	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	SkuOptions.db.char[MODULE_NAME].Auras = SkuOptions.db.char[MODULE_NAME].Auras or {}

	--if not SkuOptions.db.char[MODULE_NAME].AurasPost22_7 then
		--SkuOptions.db.char[MODULE_NAME].AurasPost22_7 = true
		--SkuOptions.db.char[MODULE_NAME].Auras = {}
	--end

	--SkuAuras.values = SkuAuras.valuesDefault
	local seen = {}
	SkuAuras.values = TableCopy(SkuAuras.valuesDefault, true, seen)

	SkuAuras.attributes.itemId.values = {}
	SkuAuras.attributes.itemName.values = {}
	for itemId, itemName in pairs(SkuDB.itemLookup[Sku.Loc]) do
		SkuAuras.attributes.itemId.values[#SkuAuras.attributes.itemId.values + 1] = "item:"..tostring(itemId)
		SkuAuras.values["item:"..tostring(itemId)] = {friendlyName = itemId.." ("..itemName..")",}

		if not SkuAuras.values["item:"..tostring(itemName)] then
			SkuAuras.attributes.itemName.values[#SkuAuras.attributes.itemName.values + 1] = "item:"..tostring(itemName)
			SkuAuras.values["item:"..tostring(itemName)] = {friendlyName = itemName,}
		end
	end
	
	SkuAuras.attributes.spellId.values = {}
	SkuAuras.attributes.spellNameOnCd.values = {}
	SkuAuras.attributes.spellName.values = {}
	SkuAuras.attributes.buffListTarget.values = {}
	SkuAuras.attributes.debuffListTarget.values = {}
	for spellId, spellData in pairs(SkuDB.SpellDataTBC) do
		local spellName = spellData[Sku.Loc][SkuDB.spellKeys["name_lang"]]
		SkuAuras.attributes.spellId.values[#SkuAuras.attributes.spellId.values + 1] = "spell:"..tostring(spellId)
		SkuAuras.values["spell:"..tostring(spellId)] = {friendlyName = spellId.." ("..spellName..")",}
		if not SkuAuras.values["spell:"..tostring(spellName)] then
			SkuAuras.attributes.spellNameOnCd.values[#SkuAuras.attributes.spellName.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.attributes.spellName.values[#SkuAuras.attributes.spellName.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.attributes.buffListTarget.values[#SkuAuras.attributes.buffListTarget.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.attributes.debuffListTarget.values[#SkuAuras.attributes.debuffListTarget.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.values["spell:"..tostring(spellName)] = {friendlyName = spellName,}
		end
	end
	SkuAuras.attributes.buffListPlayer.values = SkuAuras.attributes.buffListTarget.values
	SkuAuras.attributes.debuffListPlayer.values = SkuAuras.attributes.debuffListTarget.values
	
	if not tItemHook then
		hooksecurefunc("UseContainerItem", function(aBagID, aSlot, aTarget, aReagentBankAccessible) 
			dprint("UseContainerItem", aBagID, aSlot, aTarget, aReagentBankAccessible) 
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(aBagID, aSlot)
			if itemID then	
				local aEventData =  {
					GetTime(),
					"ITEM_USE",
					nil,
					nil,
					UnitName("player"),
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				aEventData[40] = itemID
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
			end
		end)
		hooksecurefunc("UseAction", function(aSlot, aCheckCursor, aOnSelf) 
			local actionType, id, subType = GetActionInfo(aSlot)
			--dprint("to implement UseAction", aSlot, aCheckCursor, aOnSelf, actionType, id, subType) 
			if actionType == "item" then
				local aEventData =  {
					GetTime(),
					"ITEM_USE",
					nil,
					nil,
					UnitName("player"),
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				aEventData[40] = id
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
			end
		end)
		hooksecurefunc("RunMacro", function(aMacroIdOrName) 
			--dprint("to implement RunMacro", aMacroIdOrName) 





		end)
		hooksecurefunc("RunMacroText", function(aMacroText) 
			--dprint("to implement RunMacroText", aMacroText) 




		end)
		
		tItemHook = true
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:SPELL_COOLDOWN_START(aEventData)
	if aEventData[CleuBase.sourceName] == UnitName("player") then
		if aEventData[CleuBase.subevent] == "SPELL_CAST_SUCCESS" then
			if aEventData[CleuBase.spellId] then
				local start, duration, enabled, modRate = GetSpellCooldown(aEventData[CleuBase.spellId])
				if not start or start == 0 then
					return
				end

				for x = 15, 100 do
					aEventData[x] = nil
				end

				if SkuAuras.SpellCDRepo[aEventData[CleuBase.spellId]] then
					--dprint("STILL OLD THERE, TRIUGGER BEFORE NEW!!!!!!!!!!!!!!")
					SkuAuras:SPELL_COOLDOWN_END(SkuAuras.SpellCDRepo[aEventData[CleuBase.spellId]].eventData)
				end

				aEventData[CleuBase.subevent] = "SPELL_COOLDOWN_START"
				SkuAuras.SpellCDRepo[aEventData[CleuBase.spellId]] = {
					sourceName = aEventData[CleuBase.sourceName], 
					spellId = aEventData[CleuBase.spellId], 
					spellname = aEventData[CleuBase.spellName], 
					start = start, 
					duration = duration, 
					enabled = enabled, 
					modRate = modRate,
					eventData = aEventData,
				}

				--dprint("SPELL_COOLDOWN_START", aEventData[CleuBase.spellName])
				if aEventData[CleuBase.spellName] then
					SkuAuras.thingsNamesOnCd["spell:"..aEventData[CleuBase.spellName]] = "spell:"..aEventData[CleuBase.spellName]
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:UNIT_TICKER(aUnitId)
	local tUnitId = aUnitId

	if tUnitId and UnitHealthMax(tUnitId) > 0 then
		local tHealth
		if UnitHealthMax(tUnitId) and UnitHealthMax(tUnitId) > 0 then
			tHealth = math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100))
		end
		local tPower
		if UnitPowerMax(tUnitId) and UnitPowerMax(tUnitId) > 0 then
			tPower = math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100))
		end

		if not SkuAuras.UnitRepo[tUnitId] then
			SkuAuras.UnitRepo[tUnitId] = {unitPower = 0, unitHealth = 0, unitTargetName = nil}
			SkuAuras.UnitRepo[tUnitId].unitHealth = tHealth
			SkuAuras.UnitRepo[tUnitId].unitPower = tPower
		end

		local unitTargetGUID = UnitGUID(tUnitId.."target")
		if SkuAuras.UnitRepo[tUnitId].unitTargetName ~= unitTargetGUID then
			SkuAuras.UnitRepo[tUnitId].unitTargetName = unitTargetGUID

			--dprint("ooooooooooooooo target change for ", tUnitId)
			--dprint("changed to", UnitName(tUnitId.."target"))
			if UnitName(tUnitId.."target") then
				local tEventData = {
					GetTime(),
					"UNIT_TARGETCHANGE",
					nil,
					UnitGUID(tUnitId),
					UnitName(tUnitId),
					nil,
					nil,
					unitTargetGUID,
					UnitName(tUnitId.."target"),
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)
			end
		end



		if SkuAuras.UnitRepo[tUnitId].unitHealth ~= tHealth then
			SkuAuras.UnitRepo[tUnitId].unitHealth = tHealth
			local tEventData = {
				GetTime(),
				"UNIT_HEALTH",
				nil,
				UnitGUID(tUnitId),
				UnitName(tUnitId),
				nil,
				nil,
				UnitGUID(tUnitId),
				UnitName(tUnitId),
				nil,
				nil,
				nil,
				nil,
				nil,
			}
			tEventData[35] = SkuAuras.UnitRepo[tUnitId].unitHealth
			SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)
		end
		if UnitPowerMax(tUnitId) > 0 then
			if SkuAuras.UnitRepo[tUnitId].unitPower ~= tPower then
				SkuAuras.UnitRepo[tUnitId].unitPower = tPower
				local tEventData = {
					GetTime(),
					"UNIT_POWER",
					nil,
					UnitGUID(tUnitId),
					UnitName(tUnitId),
					nil,
					nil,
					UnitGUID(tUnitId),
					UnitName(tUnitId),
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				tEventData[36] = SkuAuras.UnitRepo[tUnitId].unitPower
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)		
			end
		end

		if tUnitId == "player" then
			if SkuAuras.UnitRepo[tUnitId].unitCombo ~= GetComboPoints("player", "target") then
				SkuAuras.UnitRepo[tUnitId].unitCombo = GetComboPoints("player", "target") or 0
				local tEventData = {
					GetTime(),
					"UNIT_POWER",
					nil,
					UnitGUID(tUnitId),
					UnitName(tUnitId),
					nil,
					nil,
					UnitGUID(tUnitId),
					UnitName(tUnitId),
					nil,
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				tEventData[51] = SkuAuras.UnitRepo[tUnitId].unitCombo
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)		
			end
		end			
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:COOLDOWN_TICKER()
	for spellId, cooldownData in pairs(SkuAuras.SpellCDRepo) do
		--dprint("COOLDOWN_TICKER", cooldownData.spellname, GetTime() - cooldownData.start, cooldownData.duration)
		if (GetTime() - cooldownData.start) >= cooldownData.duration then
			cooldownData.subevent = "SPELL_COOLDOWN_END"
			SkuAuras:SPELL_COOLDOWN_END(cooldownData.eventData)
			SkuAuras.SpellCDRepo[spellId] = nil
		end
	end

	for itemId, cooldownData in pairs(SkuAuras.ItemCDRepo) do
		if GetItemCooldownLeft(cooldownData.start, cooldownData.duration) <= 0 then
			cooldownData.subevent = "ITEM_COOLDOWN_END"
			SkuAuras:ITEM_COOLDOWN_END(cooldownData.eventData)
			SkuAuras.ItemCDRepo[itemId] = nil
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:SPELL_COOLDOWN_END(aEventData)
	aEventData[CleuBase.subevent] = "SPELL_COOLDOWN_END"
	aEventData[CleuBase.timestamp] = GetTime()
	SkuAuras.thingsNamesOnCd["spell:"..aEventData[13]] = nil
	--dprint("SPELL_COOLDOWN_END", aEventData[CleuBase.subevent], aEventData[13])
	SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tAddFunc = function(itemID, startTime, duration, isEnabled, event)
	local tCdTimeLeft = GetItemCooldownLeft(startTime, duration)
	if tCdTimeLeft > 1.5 then
		SkuAuras.ItemCDRepo[itemID] = {
			subevent = "ITEM_COOLDOWN_START",
			sourceName = UnitName("player"), 
			itemId = itemID, 
			start = startTime, 
			duration = duration, 
			enabled = isEnabled, 
			eventData =  {
				GetTime(),
				event,
				nil,
				nil,
				UnitName("player"),
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
			},
		}
		SkuAuras.ItemCDRepo[itemID].eventData[40] = itemID
	end
end

function SkuAuras:BAG_UPDATE_COOLDOWN(aEventName, a, b, c, d)
	for bagId = 0, 4 do
		local tNumberOfSlots = GetContainerNumSlots(bagId)
		for slotId = 1, tNumberOfSlots do
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagId, slotId)
			if itemID then
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagId, slotId)
				tAddFunc(itemID, startTime, duration, isEnabled, "ITEM_COOLDOWN_START")
			end
		end
	end

	for _, slotId in pairs(Enum.InventoryType) do
		local itemID = GetInventoryItemID("player", slotId)
		if itemID then
			local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotId)
			tAddFunc(itemID, startTime, duration, isEnabled, "ITEM_COOLDOWN_START")
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:UNIT_INVENTORY_CHANGED(aEventName, a, b, c, d)
	--dprint("UNIT_INVENTORY_CHANGED", aEventName, a, b, c, d)
	for bagId = 0, 4 do
		local tNumberOfSlots = GetContainerNumSlots(bagId)
		for slotId = 1, tNumberOfSlots do
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagId, slotId)
			if itemID then
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagId, slotId)
				if not SkuAuras.ItemCDRepo[itemId] then
					tAddFunc(itemID, startTime, duration, isEnabled, "ITEM_COOLDOWN_START")
				end
			end
		end
	end

	for _, slotId in pairs(Enum.InventoryType) do
		local itemID = GetInventoryItemID("player", slotId)
		if itemID then
			local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotId)
			if not SkuAuras.ItemCDRepo[itemId] then
				tAddFunc(itemID, startTime, duration, isEnabled, "ITEM_COOLDOWN_START")
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ITEM_COOLDOWN_END(aEventData)
	--dprint("ITEM_COOLDOWN_END")
	aEventData[CleuBase.subevent] = "ITEM_COOLDOWN_END"
	aEventData[CleuBase.timestamp] = GetTime()
	SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:COMBAT_LOG_EVENT_UNFILTERED(aEventName, aCustomEventData)
	local tEventData = aCustomEventData or {CombatLogGetCurrentEventInfo()}
	if aCustomEventData then
		--dprint("CLEU", aCustomEventData[2])
	else
		--dprint("---------- CLEU", tEventData[2])
	end

	if tEventData[CleuBase.subevent] == "SPELL_CAST_SUCCESS" then
		C_Timer.After(0.1, function()
			SkuAuras:SPELL_COOLDOWN_START(tEventData)
			SkuAuras:EvaluateAllAuras(tEventData)
		end)
	else
		SkuAuras:EvaluateAllAuras(tEventData)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ProcessEvaluate(aValueA, aOperator, aValueB)
	return SkuAuras.Operators[aOperator].func(aValueA, aValueB)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:EvaluateAllAuras(tEventData)
	if not SkuOptions.db.char[MODULE_NAME].Auras then
		SkuOptions.db.char[MODULE_NAME].Auras = {}
	end
	--build non event related data to evaluate
	local tSourceUnitID = SkuAuras:GetBestUnitId(tEventData[CleuBase.sourceGUID])
	local tDestinationUnitID = SkuAuras:GetBestUnitId(tEventData[CleuBase.destGUID])
	if tDestinationUnitID and tDestinationUnitID[1] then
		if tDestinationUnitID ~= "party0" then
			tDestinationUnitIDCannAttack = UnitCanAttack("player", tDestinationUnitID[1])
		end
	end

	local tTargetTargetUnitId = {}
	if UnitName("playertargettarget") then
		tTargetTargetUnitId = SkuAuras:GetBestUnitId(UnitGUID("playertargettarget"))
	end

	if tSourceUnitID and tSourceUnitID[1] then
		if tSourceUnitID ~= "party0" then
			tSourceUnitIDCannAttack = UnitCanAttack("player", tSourceUnitID[1])
		end
	end

	local unitHealthOrPowerUpdate = tEventData[35] or tEventData[36]
	tEventData[35] = math.floor(UnitHealth("player") / (UnitHealthMax("player") / 100))
	tEventData[36] = math.floor(UnitPower("player") / (UnitPowerMax("player") / 100))

	local function getAuraList(unit, filter)
		local tBuffList = {}
		for x = 1, 40  do
			local name = UnitAura(unit, x, filter)
			if name then
				tBuffList[name] = name
			end
		end

		--add weapon enchants
		if unit == "player" and filter == "HELPFUL" then
			local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()
			if hasMainHandEnchant == true then
				if mainHandEnchantID and mainHandEnchantID > 0 and SkuDB.WotLK.enchantIDs[mainHandEnchantID] then
					local tName
					if Sku.Loc == "enUS" then
						tName = SkuDB.WotLK.enchantIDs[mainHandEnchantID][1]
					elseif Sku.Loc == "deDE" then
						tName = SkuDB.WotLK.enchantIDs[mainHandEnchantID][2]
					end
					if tName and SkuDB.WotLK.enchantIDs[mainHandEnchantID][3] ~= nil then
						if SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[mainHandEnchantID][3]] then
							tName = SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[mainHandEnchantID][3]][Sku.Loc][1]
						end
					elseif tName and SkuDB.WotLK.enchantIDs[mainHandEnchantID][4] ~= nil then
						if SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[mainHandEnchantID][4]] then
							tName = SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[mainHandEnchantID][4]][Sku.Loc][1]
						end
					end

					if tName then
						tBuffList[tName] = tName
					end
				end
			end
			if hasOffHandEnchant == true then
				if hasOffHandEnchantID and hasOffHandEnchantID > 0 and SkuDB.WotLK.enchantIDs[hasOffHandEnchantID] then
					local tName
					if Sku.Loc == "enUS" then
						tName = SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][1]
					elseif Sku.Loc == "deDE" then
						tName = SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][2]
					end
					if tName and SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][3] ~= nil then
						if SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][3]] then
							tName = SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][3]][Sku.Loc][1]
						end
					elseif tName and SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][4] ~= nil then
						if SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][4]] then
							tName = SkuDB.SpellDataTBC[SkuDB.WotLK.enchantIDs[hasOffHandEnchantID][4]][Sku.Loc][1]
						end
					end
		
					if tName then
						tBuffList[tName] = tName
					end
				end
			end
		end

		return tBuffList
	end

	local tUnitID = "target"
	tEventData[37] = getAuraList(tUnitID, "HELPFUL")
	tEventData[38] = getAuraList(tUnitID, "HARMFUL")

	if tEventData[2] ~= "KEY_PRESS" then
	--[[
		dprint("---------------------------------------------------------------------")
		dprint("--NEW EVENT:", tEventData[2] )
		dprint("---------------------------------------------------------------------")
		dprint("timestamp", tEventData[1])
		dprint("subevent", tEventData[2])
		dprint("sourceName", tEventData[5])
		dprint("destName", tEventData[9])
		dprint("spellId", tEventData[12])
		dprint("spellName", tEventData[13])
		dprint(" 14", tEventData[14])
		dprint("auraType", tEventData[15])
		dprint("auraAmount", tEventData[16])
		dprint(" 17", tEventData[17])
		dprint(" 18", tEventData[18])
		dprint(" 19", tEventData[19])
		dprint(" 20", tEventData[20])
		dprint(" 21", tEventData[21])
		dprint(" 22", tEventData[22])
		dprint(" 23", tEventData[23])
		dprint(" 24", tEventData[24])	
		dprint("unitHealthPlayer", tEventData[35])
		dprint("unitPowerPlayer", tEventData[36])
		setmetatable(tEventData[37], SkuPrintMTWo)
		dprint("buffListTarget", tEventData[37])
		setmetatable(tEventData[38], SkuPrintMTWo)
		dprint("dbuffListTarget", tEventData[38])
		dprint("itemID", tEventData[40])
		dprint("missType", tEventData[12])
		setmetatable(tSourceUnitID, SkuPrintMTWo)
		dprint("tSourceUnitID", tSourceUnitID)
		setmetatable(tDestinationUnitID, SkuPrintMTWo)
		dprint("tDestinationUnitID", tDestinationUnitID)
		setmetatable(tTargetTargetUnitId, SkuPrintMTWo)
		dprint("tTargetTargetUnitId", tTargetTargetUnitId)
		dprint("tSourceUnitIDCannAttack", tSourceUnitIDCannAttack)
		dprint("tDestinationUnitIDCannAttack", tDestinationUnitIDCannAttack)
		dprint("50 aKey", tEventData[50])
		dprint("SpellNamesOnCd")
		setmetatable(SkuAuras.thingsNamesOnCd, SkuPrintMTWo)
		dprint(SkuAuras.thingsNamesOnCd)
		]]
	end

	--evaluate all auras
	local tFirst = true
	for tAuraName, tAuraData in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do
		--dprint(tEventData[2], "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+")
		--dprint("  ",tAuraName, tAuraData, tEventData[36])

		if tAuraData.enabled == true then

			local tOverallResult = true
			local tHasApplicableAttributes = false

			--build event related data to evaluate
			local tEvaluateData = {
				sourceUnitId = tSourceUnitID,
				sourceName = tEventData[CleuBase.sourceName],
				destUnitId = tDestinationUnitID,
				targetTargetUnitId = tTargetTargetUnitId,
				destName = tEventData[CleuBase.destName],
				event = tEventData[CleuBase.subevent],
				spellId = tEventData[CleuBase.spellId],
				spellName = tEventData[CleuBase.spellName],
				unitHealthPlayer = tEventData[35],
				unitPowerPlayer = tEventData[36],
				unitComboPlayer = tEventData[51],
				unitHealthTarget = UnitName("target") and math.floor(UnitHealth("target") / (UnitHealthMax("target") / 100)),
				unitPowerTarget = UnitName("target") and math.floor(UnitPower("target") / (UnitPowerMax("target") / 100)),
				unitHealthOrPowerUpdate = unitHealthOrPowerUpdate,
				buffListTarget = tEventData[37],
				debuffListTarget = tEventData[38],
				buffListPlayer = getAuraList("player", "HELPFUL"),
				debuffListPlayer = getAuraList("player", "HARMFUL"),
				tSourceUnitIDCannAttack = tSourceUnitIDCannAttack,
				tDestinationUnitIDCannAttack = tDestinationUnitIDCannAttack,
				targetCanAttack = UnitCanAttack("player", "target"),
				tInCombat = SkuCore.inCombat,
				pressedKey = tEventData[50],
				spellsNamesOnCd = SkuAuras.thingsNamesOnCd,
			}		
			tEvaluateData.spellId = tEventData[CleuBase.spellId]
			tEvaluateData.spellName = tEventData[CleuBase.spellName]

			--[[						15					16						17					18					19					20						21					22						23					24
			_DAMAGE					amount			overkill				school			resisted			blocked			absorbed				critical			glancing				crushing			isOffHand
			_MISSED					missType			isOffHand			amountMissed	critical
			_HEAL						amount			overhealing			absorbed			critical
			_HEAL_ABSORBED			extraGUID		extraName			extraFlags		extraRaidFlags	extraSpellID	extraSpellName		extraSchool		absorbedAmount		#totalAmount
			_ENERGIZE				amount			overEnergize		powerType		#maxPower
			_DRAIN					amount			powerType			extraAmount		#maxPower
			_LEECH					amount			powerType			extraAmount
			_INTERRUPT				extraSpellId	extraSpellName		extraSchool
			_DISPEL					extraSpellId	extraSpellName		extraSchool		auraType
			_DISPEL_FAILED			extraSpellId	extraSpellName		extraSchool
			_STOLEN					extraSpellId	extraSpellName		extraSchool		auraType
			_EXTRA_ATTACKS			amount
			_CAST_FAILED			failedType
			]]

			if string.find(tEventData[CleuBase.subevent], "_AURA_") then
				tEvaluateData.auraType = tEventData[15]
				tEvaluateData.auraAmount = tEventData[16]
			end

			if string.find(tEventData[CleuBase.subevent], "_MISSED") then
				--dprint("  ","----------- _MISSED -----------", tEventData[12])
				tEvaluateData.missType = tEventData[12]
			end



			tEvaluateData.itemId = tEventData[40]
			if tEventData[40] then
				tEvaluateData.itemName = SkuDB.itemLookup[Sku.Loc][tEventData[40]]
				for bagId = 0, 4 do
					local tNumberOfSlots = GetContainerNumSlots(bagId)
					for slotId = 1, tNumberOfSlots do
						local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagId, slotId)
						if itemCount then
							if itemID == tEvaluateData.itemId then
								if not tEvaluateData.itemCount then
									tEvaluateData.itemCount = itemCount - 1
								else
									tEvaluateData.itemCount = tEvaluateData.itemCount + itemCount
								end
							end
						end
					end
				end					
			end

			if tEventData[CleuBase.subevent] == "UNIT_DESTROYED" then
				tEvaluateData.spellName = tEventData[9]
			end

			tEvaluateData.class = nil

			--evaluate attributes
			local tSingleBuffListTargetValue
			local tSingleDebuffListTargetValue

			local tHasCountCondition_NumConditions = 0
			local tHasCountCondition_NumCountConditions = 0
			local tHasCountCondition_NumCountConditionsTrue = 0
			local tHasCountCondition_NumConditionsWoCountIsTrue = 0

			for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
				--dprint("tAttributeName, tAttributeValue", tAttributeName, tAttributeValue[1][1], tAttributeValue[1][2])
				if tAttributeValue[1][1] == "bigger" or tAttributeValue[1][1] == "smaller" then
					tHasCountCondition_NumCountConditions = tHasCountCondition_NumCountConditions + 1
				end
				tHasCountCondition_NumConditions = tHasCountCondition_NumConditions + 1

				tHasApplicableAttributes = true
				if #tAttributeValue > 1 then
					local tLocalResult = false
					for tInd, tLocalValue in pairs(tAttributeValue) do
						local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tLocalValue[1], tLocalValue[2])
						--dprint("  ","RESULT:", tEvaluateData, tLocalValue[1], tLocalValue[2], tResult)
						if tResult == true then
							tLocalResult = true
							if tAttributeValue[1][1] == "bigger" or tAttributeValue[1][1] == "smaller" then
								tHasCountCondition_NumCountConditionsTrue = tHasCountCondition_NumCountConditionsTrue + 1
							else
								tHasCountCondition_NumConditionsWoCountIsTrue = tHasCountCondition_NumConditionsWoCountIsTrue + 1
							end							
						end
					end
					if tLocalResult ~= true then
						tOverallResult = false
					end
				else
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					for tInd, tLocalValue in pairs(tAttributeValue) do
						local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tLocalValue[1], tLocalValue[2])
						--dprint("  ","RESULT:", tEvaluateData, tLocalValue[1], tLocalValue[2], tResult)
						if tResult == true then
							tLocalResult = true
							if tAttributeValue[1][1] == "bigger" or tAttributeValue[1][1] == "smaller" then
								tHasCountCondition_NumCountConditionsTrue = tHasCountCondition_NumCountConditionsTrue + 1
							else
								tHasCountCondition_NumConditionsWoCountIsTrue = tHasCountCondition_NumConditionsWoCountIsTrue + 1
							end							
						end
					end

					if tResult ~= true then
						tOverallResult = false
					end
				end

				if tAttributeName == "buffListTarget" then
					tSingleBuffListTargetValue = string.gsub(tAttributeValue[1][2], "spell:", "")
				end
				if tAttributeName == "debuffListTarget" then
					tSingleDebuffListTargetValue = string.gsub(tAttributeValue[1][2], "spell:", "")
				end
				if tAttributeName == "spellNameOnCd" then
					tSpellNameOnCdValue = string.gsub(tAttributeValue[1][2], "spell:", "")
				end
			end				

			--add data for outputs
			tEvaluateData.buffListTarget = tSingleBuffListTargetValue
			tEvaluateData.debuffListTarget = tSingleDebuffListTargetValue
			tEvaluateData.spellNameOnCd = tSpellNameOnCdValue

			--overall result
			--dprint("  ","OVERALL RESULT:", tOverallResult, "tHasApplicableAttributes", tHasApplicableAttributes)
			--dprint("  ","used", tAuraData.used)
			--dprint("  ","single", SkuAuras.actions[tAuraData.actions[1]].single)
			--dprint("  ","instant", SkuAuras.actions[tAuraData.actions[1]].instant)

			if tAuraData.type == "if" then
				if tOverallResult == true and tHasApplicableAttributes == true then
					if ((tAuraData.used ~= true and SkuAuras.actions[tAuraData.actions[1]].single == true) or SkuAuras.actions[tAuraData.actions[1]].single ~= true) then
						--dprint(" x x x x x  ","== trigger:", #tAuraData.actions, tAuraData.actions[1])
						
						--set aura to used
						--dprint("   USED = true")
						tAuraData.used = true

						for i, v in pairs(tAuraData.outputs) do
							if SkuAuras.outputs[string.gsub(v, "output:", "")] then
								--dprint("  ",tAuraData.actions[1])
								--dprint("  ","output", i, v)

								local tAction = tAuraData.actions[1]
								if tAction ~= "notifyAudioAndChatSingle" then
									if tAction == "notifyAudioSingle" or tAction == "notifyAudioSingleInstant" then
										tAction = "notifyAudio"
									end
									if tAction == "notifyChatSingle" then
										tAction = "notifyChat"
									end

									SkuAuras.outputs[string.gsub(v, "output:", "")].functs[tAction](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
								else
									SkuAuras.outputs[string.gsub(v, "output:", "")].functs["notifyAudio"](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
									SkuAuras.outputs[string.gsub(v, "output:", "")].functs["notifyChat"](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
								end

								tFirst = false
							end
						end
					end
				else
					--set aura to unused

					--dprint("NumConditions", tHasCountCondition_NumConditions, "NumCountConditions", tHasCountCondition_NumCountConditions, "NumCountConditionsTrue", tHasCountCondition_NumCountConditionsTrue, "NumConditionsWoCountIsTrue", tHasCountCondition_NumConditionsWoCountIsTrue)
					if tHasCountCondition_NumCountConditions > 0 then --es großer oder kleiner hat 
						if (tHasCountCondition_NumConditionsWoCountIsTrue - tHasCountCondition_NumCountConditionsTrue == tHasCountCondition_NumConditions - tHasCountCondition_NumCountConditions) and ( tHasCountCondition_NumCountConditionsTrue < tHasCountCondition_NumCountConditions) then--alles außer größer oder kleiner = true und größer kleiner = false
							--dprint("   USED 1 = false")
							tAuraData.used = false
						end
					else
						--dprint("   USED 2 = false")
						tAuraData.used = false
					end

				end		
			else
				if tOverallResult == false and tHasApplicableAttributes == true then
					if ((tAuraData.used ~= true and SkuAuras.actions[tAuraData.actions[1]].single == true) or SkuAuras.actions[tAuraData.actions[1]].single ~= true) then					
						--dprint("  ","~= trigger:", #tAuraData.actions, tAuraData.actions[1])
						--set aura to used
						tAuraData.used = true

						for i, v in pairs(tAuraData.outputs) do
							if SkuAuras.outputs[string.gsub(v, "output:", "")] then
								--dprint("  ",tAuraData.actions[1])
								--dprint("  ","  output", i, v)

								local tAction = tAuraData.actions[1]
								if tAction ~= "notifyAudioAndChatSingle" then
									if tAction == "notifyAudioSingle" then
										tAction = "notifyAudio"
									end
									if tAction == "notifyChatSingle" then
										tAction = "notifyChat"
									end							
									SkuAuras.outputs[string.gsub(v, "output:", "")].functs[tAction](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
								else
									SkuAuras.outputs[string.gsub(v, "output:", "")].functs["notifyAudio"](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
									SkuAuras.outputs[string.gsub(v, "output:", "")].functs["notifyChat"](tAuraName, tEvaluateData, tFirst, SkuAuras.actions[tAuraData.actions[1]].instant)
								end
								
								tFirst = false
							end
						end
					end
				else
					--set aura to unused
					tAuraData.used = false




				end	
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:CreateAura(aType, aAttributes)
	if not aType or not aAttributes then
		return false
	end

	local tAttributes = {}
	local tActions = {}
	local tOutputs = {}
	for x = 1, #aAttributes do
		if aAttributes[x][2] then
			if aAttributes[x][1] ~= "action" then
				if not tAttributes[aAttributes[x][1]] then
					tAttributes[aAttributes[x][1]] = {}
				end
				tAttributes[aAttributes[x][1]][#tAttributes[aAttributes[x][1]] + 1] = {
					aAttributes[x][3],
					aAttributes[x][2]
				}
			else
				tActions[#tActions + 1] = aAttributes[x][2]
			end
		else
			tOutputs[#tOutputs + 1] = aAttributes[x][1]
		end
	end
	
	--build the name
	local tAuraName = SkuAuras.Types[aType].friendlyName..";"
	local tOuterCount = 0
	for tAttributeName, tAttributeValue in pairs(tAttributes) do
		if tOuterCount > 0 then
			tAuraName = tAuraName..L["und;"]
		end
		if #tAttributeValue > 1 then
			local tCount = 0
			for tInd, tLocalValue in pairs(tAttributeValue) do
				if tCount > 0 then
					tAuraName = tAuraName..L["oder;"]..SkuAuras.attributes[tAttributeName].friendlyName..";"..SkuAuras.Operators[tLocalValue[1]].friendlyName..";"..SkuAuras.values[tLocalValue[2]].friendlyName..";"
				else
					tAuraName = tAuraName..SkuAuras.attributes[tAttributeName].friendlyName..";"..SkuAuras.Operators[tLocalValue[1]].friendlyName..";"..SkuAuras.values[tLocalValue[2]].friendlyName..";"
				end
				tCount = tCount + 1
			end
		else
			tAuraName = tAuraName..SkuAuras.attributes[tAttributeName].friendlyName..";"..SkuAuras.Operators[tAttributeValue[1][1]].friendlyName..";"..SkuAuras.values[tAttributeValue[1][2]].friendlyName..";"
		end
		tOuterCount = tOuterCount + 1
	end				

	tAuraName = tAuraName..L["dann;"]..SkuAuras.actions[tActions[1]].friendlyName..";"

	for tOutputIndex, tOutputName in pairs(tOutputs) do
		tAuraName = tAuraName..L[";und;"]..SkuAuras.outputs[string.gsub(tOutputName, "output:", "")].friendlyName..";"
		tAuraName = string.gsub(tAuraName, "aura;sound#", "sound;")
	end

	--add aura
	SkuOptions.db.char[MODULE_NAME].Auras[tAuraName] = {
		type = aType,
		enabled = true,
		attributes = tAttributes,
		actions = tActions,
		outputs = tOutputs,
	}

	return true
end
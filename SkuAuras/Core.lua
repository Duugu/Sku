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
}

SkuAuras.ItemCDRepo = {}
SkuAuras.SpellCDRepo = {}
SkuAuras.UnitRepo = {}

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
	local ttime = 0
	local f = _G["SkuAurasControl"] or CreateFrame("Frame", "SkuAurasControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		ttime = ttime + time
		if ttime < 0.1 then return end
		SkuAuras:COOLDOWN_TICKER()
		SkuAuras:UNIT_TICKER()
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
local tItemHook
function SkuAuras:PLAYER_ENTERING_WORLD(aEvent, aIsInitialLogin, aIsReloadingUi)
	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	SkuOptions.db.char[MODULE_NAME].Auras = SkuOptions.db.char[MODULE_NAME].Auras or SkuAuras.DefaultAuras
	SkuAuras.values = SkuAuras.valuesDefault

	SkuAuras.attributes.itemId.values = {}
	SkuAuras.attributes.itemName.values = {}
	for itemId, itemName in pairs(SkuDB.itemLookup) do
		SkuAuras.attributes.itemId.values[#SkuAuras.attributes.itemId.values + 1] = "item:"..tostring(itemId)
		SkuAuras.values["item:"..tostring(itemId)] = {friendlyName = itemId.." ("..itemName..")",}

		if not SkuAuras.values["item:"..tostring(itemName)] then
			SkuAuras.attributes.itemName.values[#SkuAuras.attributes.itemName.values + 1] = "item:"..tostring(itemName)
			SkuAuras.values["item:"..tostring(itemName)] = {friendlyName = itemName,}
		end
	end
	
	SkuAuras.attributes.spellId.values = {}
	SkuAuras.attributes.spellName.values = {}
	for spellId, spellData in pairs(SkuDB.SpellDataTBC_DE) do
		local spellName = spellData[SkuDB.spellKeys["name_lang"]]

		SkuAuras.attributes.spellId.values[#SkuAuras.attributes.spellId.values + 1] = "spell:"..tostring(spellId)
		SkuAuras.values["spell:"..tostring(spellId)] = {friendlyName = spellId.." ("..spellName..")",}

		if not SkuAuras.values["spell:"..tostring(spellName)] then
			SkuAuras.attributes.spellName.values[#SkuAuras.attributes.spellName.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.values["spell:"..tostring(spellName)] = {friendlyName = spellName,}
		end
	end
	
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
					itemID,
				}
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
			end
		end)
		--[[
		hooksecurefunc("UseAction", function(aSlot, aCheckCursor, aOnSelf) 
			dprint("to implement UseAction", aSlot, aCheckCursor, aOnSelf) 




		end)
		hooksecurefunc("RunMacro", function(aMacroIdOrName) 
			dprint("to implement RunMacro", aMacroIdOrName) 





		end)
		hooksecurefunc("RunMacroText", function(aMacroText) 
			dprint("to implement RunMacroText", aMacroText) 




		end)
		]]
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
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:UNIT_TICKER()

	local tUnitId = "player"

	if not SkuAuras.UnitRepo[tUnitId] then
		SkuAuras.UnitRepo[tUnitId] = {unitPower = 0, unitHealth = 0}
		SkuAuras.UnitRepo[tUnitId].unitHealth = math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100))
		SkuAuras.UnitRepo[tUnitId].unitPower = math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100))
	end

	if SkuAuras.UnitRepo[tUnitId].unitHealth ~= math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100)) then
		SkuAuras.UnitRepo[tUnitId].unitHealth = math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100))
		local tEventData = {
			GetTime(),
			"UNIT_HEALTH",
			nil,
			"player",
			UnitName("player"),
			nil,
			nil,
			"player",
			UnitName("player"),
			nil,
			nil,
			nil,
			nil,
			nil,
			SkuAuras.UnitRepo[tUnitId].unitHealth,
		}
			SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)
	end

	if SkuAuras.UnitRepo[tUnitId].unitPower ~= math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100)) then
		SkuAuras.UnitRepo[tUnitId].unitPower = math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100)) 
		local tEventData = {
			GetTime(),
			"UNIT_POWER",
			nil,
			"player",
			UnitName("player"),
			nil,
			nil,
			"player",
			UnitName("player"),
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			SkuAuras.UnitRepo[tUnitId].unitPower,
		}
		SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:COOLDOWN_TICKER()
	for spellId, cooldownData in pairs(SkuAuras.SpellCDRepo) do
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
				itemID,
			},
		}
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
	dprint("UNIT_INVENTORY_CHANGED", aEventName, a, b, c, d)
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
	dprint("ITEM_COOLDOWN_END")
	aEventData[CleuBase.subevent] = "ITEM_COOLDOWN_END"
	aEventData[CleuBase.timestamp] = GetTime()
	SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:COMBAT_LOG_EVENT_UNFILTERED(aEventName, aCustomEventData)
	dprint("COMBAT_LOG_EVENT_UNFILTERED", aEventName, aCustomEventData)
	local tEventData = aCustomEventData or {CombatLogGetCurrentEventInfo()}
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
	dprint("EvaluateAllAuras")
	dprint(" 1", tEventData[1])
	dprint(" 2", tEventData[2])
	dprint(" 3", tEventData[3])
	dprint(" 4", tEventData[4])
	dprint(" 5", tEventData[5])
	dprint(" 6", tEventData[6])
	dprint(" 7", tEventData[7])
	dprint(" 8", tEventData[8])
	dprint(" 9", tEventData[9])
	dprint(" 10", tEventData[10])
	dprint(" 11", tEventData[11])
	dprint(" 12", tEventData[12])
	dprint(" 13", tEventData[13])
	dprint(" 14", tEventData[14])
	dprint(" 15", tEventData[15])
	dprint(" 16", tEventData[16])
	dprint(" 17", tEventData[17])
	dprint(" 18", tEventData[18])
	dprint(" 19", tEventData[19])
	dprint(" 20", tEventData[20])
	dprint(" 21", tEventData[21])
	dprint(" 22", tEventData[22])
	dprint(" 23", tEventData[23])
	dprint(" 24", tEventData[24])

	local tDestinationUnitID
	if tEventData[CleuBase.destName] == UnitName("player") then
		tDestinationUnitID = "player"
	elseif tEventData[CleuBase.destName] == UnitName("target") then
		tDestinationUnitID = "target"
	else
		for x = 1, 4 do 
			if tEventData[CleuBase.destName] == UnitName("party"..x) then
				tDestinationUnitID = "party"..x
			end
		end
		for x = 1, 40 do 
			if tEventData[CleuBase.destName] == UnitName("raid"..x) then
				tDestinationUnitID = "raid"..x
			end
		end
	end
	local tSourceUnitID
	if tEventData[CleuBase.destName] == UnitName("player") then
		tSourceUnitID = "player"
	elseif tEventData[CleuBase.destName] == UnitName("target") then
		tSourceUnitID = "target"
	else
		for x = 1, 4 do 
			if tEventData[CleuBase.destName] == UnitName("party"..x) then
				tSourceUnitID = "party"..x
			end
		end
		for x = 1, 40 do 
			if tEventData[CleuBase.destName] == UnitName("raid"..x) then
				tSourceUnitID = "raid"..x
			end
		end
	end	

	local tFirst = true
	for tAuraName, tAuraData in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do
		dprint("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+")
		dprint(tAuraName, tAuraData)

		if tAuraData.enabled == true then

			local tOverallResult = true
			local tHasApplicableAttributes = false

			local tEvaluateData = {
				sourceUnitId = tSourceUnitID,
				sourceName = tEventData[CleuBase.sourceName],
				destUnitId = tDestinationUnitID,
				destName = tEventData[CleuBase.destName],
				event = tEventData[CleuBase.subevent],
				spellId = tEventData[CleuBase.spellId],
				spellName = tEventData[CleuBase.spellName],
			}		

			if tAuraData.type == "unit" then
				tEvaluateData.class = nil
				tEvaluateData.unitHealth = tEventData[15]
				tEvaluateData.unitPower = tEventData[16]
				
				for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
					tHasApplicableAttributes = true
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					if tResult ~= true then
						tOverallResult = false
					end
				end				
			end

			if tAuraData.type == "spell" then
				tEvaluateData.spellId = tEventData[CleuBase.spellId]
				tEvaluateData.spellName = tEventData[CleuBase.spellName]
				
				if tEventData[CleuBase.subevent] == "UNIT_DESTROYED" then
					tEvaluateData.spellName = tEventData[9]
				end

				for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
					tHasApplicableAttributes = true
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					if tResult ~= true then
						tOverallResult = false
					end
				end
			end

			if tAuraData.type == "aura" then
				tEvaluateData.spellId = tEventData[CleuBase.spellId]
				tEvaluateData.spellName = tEventData[CleuBase.spellName]
				tEvaluateData.auraType = tEventData[15]
				tEvaluateData.auraAmount = tEventData[16]

				for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
					tHasApplicableAttributes = true
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					if tResult ~= true then
						tOverallResult = false
					end
				end
			end

			if tAuraData.type == "item" then
				tEvaluateData.itemId = tEventData[15]
				tEvaluateData.itemName = SkuDB.itemLookup[tEventData[15]]

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
				
				for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
					tHasApplicableAttributes = true
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					if tResult ~= true then
						tOverallResult = false
					end
				end
			end

			dprint("OVERALL RESULT:", tOverallResult, "tHasApplicableAttributes", tHasApplicableAttributes)
			if tOverallResult == true and tHasApplicableAttributes == true then
				dprint("== trigger:", #tAuraData.actions, tAuraData.actions[1])
				for i, v in pairs(tAuraData.outputs) do
					if SkuAuras.outputs[string.gsub(v, "output:", "")] then
						dprint(tAuraData.actions[1])
						dprint("output", i, v)
						SkuAuras.outputs[string.gsub(v, "output:", "")].functs[tAuraData.actions[1]](tAuraName, tEvaluateData, tFirst, v)
						tFirst = false
					end
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

	local tAuraName = L["type"]..";=;"..SkuAuras.Types[aType].friendlyName..";"..L["if"]..";"
	local tAttributes = {}
	local tActions = {}
	local tOutputs = {}
	for x = 1, #aAttributes do
		if aAttributes[x][2] then
			
			local tAttributeFn = SkuAuras.attributes[aAttributes[x][1]].friendlyName
			if aAttributes[x][1] == "action" then
				tAttributeFn = ""
			end
			local tValueFn = ""
			if SkuAuras.actions[aAttributes[x][2]] then
				tValueFn = SkuAuras.actions[aAttributes[x][2]].friendlyName
			else
				tValueFn = SkuAuras.values[aAttributes[x][2]].friendlyName
			end
			local tOperatorFn = SkuAuras.Operators[aAttributes[x][3]].friendlyName

			if tAttributeFn == "" or x == 1 then
				tAuraName = tAuraName..tAttributeFn..";"..tOperatorFn..";"..tValueFn..";"
			elseif string.find(tAttributeFn, "output:") then
				tAuraName = tAuraName..";"..tAttributeFn..";"
			else
				tAuraName = tAuraName.."und;"..tAttributeFn..";"..tOperatorFn..";"..tValueFn..";"
			end

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
			tAuraName = tAuraName..";"..SkuAuras.outputs[string.gsub(aAttributes[x][1], "output:", "")].friendlyName..";"
		end
	end
	
	SkuOptions.db.char[MODULE_NAME].Auras[tAuraName] = {
		type = aType,
		enabled = true,
		attributes = tAttributes,
		actions = tActions,
		outputs = tOutputs,
	}

	return true
end
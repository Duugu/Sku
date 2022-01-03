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
function SkuAuras:PLAYER_ENTERING_WORLD(aEvent, aIsInitialLogin, aIsReloadingUi)
	SkuOptions.db.profile[MODULE_NAME].Auras = SkuOptions.db.profile[MODULE_NAME].Auras or SkuAuras.DefaultAuras
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
	

	hooksecurefunc("UseContainerItem", function(aBagID, aSlot, aTarget, aReagentBankAccessible) 
		dprint("UseContainerItem", aBagID, aSlot, aTarget, aReagentBankAccessible) 
		local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(aBagID, aSlot)
		dprint(icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID)
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
			dprint(aEventData[1], aEventData[2], aEventData[51])
			SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
		end
	end)
	hooksecurefunc("UseAction", function(aSlot, aCheckCursor, aOnSelf) 
		dprint("UseAction", aSlot, aCheckCursor, aOnSelf) 
	end)
	hooksecurefunc("RunMacro", function(aMacroIdOrName) 
		dprint("RunMacro", aMacroIdOrName) 
	end)
	hooksecurefunc("RunMacroText", function(aMacroText) 
		dprint("RunMacroText", aMacroText) 
	end)

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
				dprint("SPELL_COOLDOWN_START", aEventData[CleuBase.spellId], aEventData[CleuBase.spellName])
				dprint(" start, duration, enabled, modRate", start, duration, enabled, modRate)
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
function SkuAuras:COOLDOWN_TICKER()
	for spellId, cooldownData in pairs(SkuAuras.SpellCDRepo) do
		--dprint("ticker: spellId", spellId)
		--dprint(cooldownData.start, GetTime(), GetTime() - cooldownData.start)
		if (GetTime() - cooldownData.start) >= cooldownData.duration then
			SkuAuras:SPELL_COOLDOWN_END(cooldownData.eventData)
			SkuAuras.SpellCDRepo[spellId] = nil
		end
	end

	for itemId, cooldownData in pairs(SkuAuras.ItemCDRepo) do
		--dprint("ticker: itemId", itemId)
		--dprint(cooldownData.start, GetTime(), GetTime() - cooldownData.start)
		if GetItemCooldownLeft(cooldownData.start, cooldownData.duration) <= 0 then
			SkuAuras:ITEM_COOLDOWN_END(cooldownData.eventData)
			SkuAuras.ItemCDRepo[itemId] = nil
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:SPELL_COOLDOWN_END(aEventData)
	dprint("SPELL_COOLDOWN_END")
	aEventData[CleuBase.subevent] = "SPELL_COOLDOWN_END"
	aEventData[CleuBase.timestamp] = GetTime()
	SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", aEventData)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BAG_UPDATE_COOLDOWN(aEventName, a, b, c, d)
	dprint("BAG_UPDATE_COOLDOWN", aEventName, a, b, c, d)

	local tAddFunc = function(itemID, startTime, duration, isEnabled)
		local tCdTimeLeft = GetItemCooldownLeft(startTime, duration)
		if tCdTimeLeft > 1.5 then
			dprint("ITEM_COOLDOWN_START", itemID)
			dprint(bagId, slotId, GetItemCooldownLeft(startTime, duration), isEnabled)
			SkuAuras.ItemCDRepo[itemID] = {
				subevent = "ITEM_COOLDOWN_START",
				sourceName = UnitName("player"), 
				itemId = itemID, 
				start = startTime, 
				duration = duration, 
				enabled = isEnabled, 
				eventData =  {
					GetTime(),
					"ITEM_COOLDOWN_START",
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

	for bagId = 0, 4 do
		local tNumberOfSlots = GetContainerNumSlots(bagId)
		for slotId = 1, tNumberOfSlots do
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagId, slotId)
			if itemID then
				local startTime, duration, isEnabled = GetContainerItemCooldown(bagId, slotId)
				tAddFunc(itemID, startTime, duration, isEnabled)
			end
		end
	end

	for _, slotId in pairs(Enum.InventoryType) do
		local itemID = GetInventoryItemID("player", slotId)
		if itemID then
			local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotId)
			tAddFunc(itemID, startTime, duration, isEnabled)
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
			end
		end
	end

	for _, slotId in pairs(Enum.InventoryType) do
		local itemID = GetInventoryItemID("player", slotId)
		if itemID then
			local startTime, duration, isEnabled = GetInventoryItemCooldown("player", slotId)
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
	dprint("                          ProcessEvaluate", aValueA, aOperator, aValueB)
	local tResult = SkuAuras.Operators[aOperator].func(aValueA, aValueB)
	dprint("                           tResult", tResult)
	return tResult
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

	for tAuraName, tAuraData in pairs(SkuOptions.db.profile[MODULE_NAME].Auras) do
		dprint("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+")
		dprint(tAuraName, tAuraData)

		local tOverallResult = true
		local tHasApplicableAttributes = false

		local tEvaluateData = {
			sourceGUID = tSourceUnitID,
			sourceName = tEventData[CleuBase.sourceName],
			destUnitId = tDestinationUnitID,
			destName = tEventData[CleuBase.destName],
			event = tEventData[CleuBase.subevent],
			spellId = tEventData[CleuBase.spellId],
			spellName = tEventData[CleuBase.spellName],
			class = nil,
		}		
		
		if tAuraData.type == "spell" then
			dprint(" spell + + + + ", tEventData[9])
			tEvaluateData.spellId = tEventData[CleuBase.spellId]
			tEvaluateData.spellName = tEventData[CleuBase.spellName]
			
			if tEventData[CleuBase.subevent] == "UNIT_DESTROYED" then
				tEvaluateData.spellName = tEventData[9]
			end

			for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
				dprint("  ", tAttributeName, tAttributeValue)
				dprint("     ", tAttributeValue[1][1])
				dprint("     ", tAttributeValue[1][2])
				tHasApplicableAttributes = true
				local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
				dprint("       tResult", tResult)
				if tResult ~= true then
					tOverallResult = false
				end
			end
		end

		if tAuraData.type == "aura" then
			dprint(" aura")
			tEvaluateData.spellId = tEventData[CleuBase.spellId]
			tEvaluateData.spellName = tEventData[CleuBase.spellName]
			tEvaluateData.auraType = tEventData[15]
			tEvaluateData.auraAmount = tEventData[16]

			for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
				dprint("  ", tAttributeName, tAttributeValue)
				dprint("     ", tAttributeValue[1][1])
				dprint("     ", tAttributeValue[1][2])
				tHasApplicableAttributes = true
				local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
				dprint("       tResult", tResult)
				if tResult ~= true then
					tOverallResult = false
				end
			end
		end

		if tAuraData.type == "item" then
			dprint(" item")
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
				dprint("  ", tAttributeName, tAttributeValue)
				dprint("     ", tAttributeValue[1][1])
				dprint("     ", tAttributeValue[1][2])
				tHasApplicableAttributes = true
				local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
				dprint("       tResult", tResult)
				if tResult ~= true then
					tOverallResult = false
				end
			end
		end

		dprint("OVERALL RESULT:", tOverallResult, "tHasApplicableAttributes", tHasApplicableAttributes)
		if tOverallResult == true and tHasApplicableAttributes == true then
			dprint("====================")
			dprint("== trigger:", #tAuraData.actions, tAuraData.actions[1])
			dprint("====================")
			SkuAuras.actions[tAuraData.actions[1]].func(tAuraName, tEvaluateData)
			for i, v in pairs(tAuraData.outputs) do
				dprint("output", i, v)
				dprint(SkuAuras.outputs[string.gsub(v, "output:", "")].friendlyName)
				SkuAuras.outputs[string.gsub(v, "output:", "")].func(tAuraName, tEvaluateData)
			end
		end		
		setmetatable(tAuraData, SkuPrintMTWo)
		dprint("++++tAuraData++++")
		if tAuraData.outputs then
			for i, v in pairs(tAuraData.outputs) do
				dprint("output", i, v)
			end
		end
		dprint("--------------")
		dprint(tAuraData)
		dprint("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-")
	end



end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:CreateAura(aType, aAttributes)
	if not aType or not aAttributes then
		return false
	end
	setmetatable(aAttributes, SkuPrintMTWo)
	dprint("aType:")
	dprint(aType)
	dprint("aAttributes:")
	dprint(aAttributes)
	setmetatable(aAttributes, SkuPrintMTWo)
	dprint(aAttributes)
	dprint("????????????????????????????????????")

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

			dprint(x, aAttributes[x][1], aAttributes[x][2], aAttributes[x][3])
			dprint("tAttributeFn", tAttributeFn)
			dprint("tOperatorFn", tOperatorFn)
			dprint("tValueFn", tValueFn)

			--tAuraName = tAuraName..aAttributes[x][1]..";=;"..aAttributes[x][2]..";"
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
	dprint("tAuraName:")
	dprint(tAuraName)
	
	SkuOptions.db.profile[MODULE_NAME].Auras[tAuraName] = {
		type = aType,
		enabled = true,
		attributes = tAttributes,
		actions = tActions,
		outputs = tOutputs,
	}

	dprint("New aura with:")
	setmetatable(SkuOptions.db.profile[MODULE_NAME].Auras[tAuraName], SkuPrintMTWo)
	dprint(SkuOptions.db.profile[MODULE_NAME].Auras[tAuraName])

	return true
end


















---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
--elevator timer test
function GetElTime()
	local guid    = UnitGUID("target")
	--local guid    = "Creature-0-4468-530-15-18922-0004A6D8E1"

	if not guid then
		return
  end

	local prefix  = string.match(guid, "^([CVP][^l][^-]+)")

	if not prefix then
		 return
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff)
		 --local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3)
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23)
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1)
		 end

		 --local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime)
		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 dprint("noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667))
		 
	end
end

function GTT_CreatureInspect(self)
	local _, unit = self:GetUnit();
	local guid    = UnitGUID(unit or "none");
	local prefix  = string.match(guid, "^([CVP][^l][^-]+)");

	if not guid or not prefix then
		 return;
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff);
		 local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3);
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23);
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset;

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1);
		 end

		 local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Date/Time", guidSpawnDate, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Time Data", string.format("%.6X", guidSpawnTime), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index Data", string.format("%.5X", guidSpawnIndex), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnOffset", guidSpawnOffset, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "serverSpawnEpoch", serverSpawnEpoch, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnTime", guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, GetServerTime(), (GetServerTime() % 2^23), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "curr time", GetServerTime() - guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);

		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 GameTooltip_AddColoredDoubleLine(self, "noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667) - 10, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 

		 
		 
	elseif prefix == "Pet" then
		 local guidPetUID     = string.sub(guid, -8);
		 local guidSpawnIndex = tonumber(string.sub(guid, -10, -9), 16);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Pet UID", guidPetUID, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index", guidSpawnIndex, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
	end
end

if not GTT_CreatureInspectHooked then
	GTT_CreatureInspectHooked = true;
	--GameTooltip:HookScript("OnTooltipSetUnit", function(...) return GTT_CreatureInspect(...); end);
end
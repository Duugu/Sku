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
		SkuAuras:UNIT_TICKER("player")
		SkuAuras:UNIT_TICKER("pet")
		SkuAuras:UNIT_TICKER("target")
		SkuAuras:UNIT_TICKER("playertarget")
		SkuAuras:UNIT_TICKER("pettarget")
		SkuAuras:UNIT_TICKER("targettarget")
		for x = 1, 4 do
			SkuAuras:UNIT_TICKER("party"..x)
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
function SkuAuras:GetBestUnitId(aUnitName, aReturnAll)

	if not aUnitName then
		if aReturnAll then return {} else return end
	end
	if aUnitName == "" then
		if aReturnAll then return {} else return end
	end

	local tUnitIds = {}

		for x = 1, 40 do 
			if aUnitName == UnitName("raid"..x) then
				if not aReturnAll then
					return "raid"..x
				else
					tUnitIds[#tUnitIds + 1] = "raid"..x
				end
			end
		end
		for x = 1, 4 do 
			if aUnitName == UnitName("party"..x) then
				if not aReturnAll then
					return "party"..x
				else
					tUnitIds[#tUnitIds + 1] = "party"..x
				end
			end
		end
		if aUnitName == UnitName("player") and (UnitName("party1") or UnitName("raid1")) then
			if not aReturnAll then
				return "party0"
			else
				tUnitIds[#tUnitIds + 1] = "party0"
			end
		end
		if aUnitName== UnitName("target") then
			if not aReturnAll then
				return "target"
			else
				tUnitIds[#tUnitIds + 1] = "target"
			end
		end
		if aUnitName == UnitName("player") then
			if not aReturnAll then
				return "player"
			else
				tUnitIds[#tUnitIds + 1] = "player"
			end
		end

	if aReturnAll then
		return tUnitIds
	end
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
	SkuOptions.db.char[MODULE_NAME].Auras = SkuOptions.db.char[MODULE_NAME].Auras or {}

	if not SkuOptions.db.char[MODULE_NAME].AurasPost22_7 then
		SkuOptions.db.char[MODULE_NAME].AurasPost22_7 = true
		SkuOptions.db.char[MODULE_NAME].Auras = {}
	end

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
	SkuAuras.attributes.buffListTarget.values = {}
	SkuAuras.attributes.debuffListTarget.values = {}
	for spellId, spellData in pairs(SkuDB.SpellDataTBC_DE) do
		local spellName = spellData[SkuDB.spellKeys["name_lang"]]

		SkuAuras.attributes.spellId.values[#SkuAuras.attributes.spellId.values + 1] = "spell:"..tostring(spellId)
		SkuAuras.values["spell:"..tostring(spellId)] = {friendlyName = spellId.." ("..spellName..")",}

		if not SkuAuras.values["spell:"..tostring(spellName)] then
			SkuAuras.attributes.spellName.values[#SkuAuras.attributes.spellName.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.attributes.buffListTarget.values[#SkuAuras.attributes.buffListTarget.values + 1] = "spell:"..tostring(spellName)
			SkuAuras.attributes.debuffListTarget.values[#SkuAuras.attributes.debuffListTarget.values + 1] = "spell:"..tostring(spellName)
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
				}
				aEventData[40] = itemID
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
function SkuAuras:UNIT_TICKER(aUnitId)
	local tUnitId = aUnitId

	if not SkuAuras.UnitRepo[tUnitId] then
		SkuAuras.UnitRepo[tUnitId] = {unitPower = 0, unitHealth = 0, unitTargetName = nil}
		SkuAuras.UnitRepo[tUnitId].unitHealth = math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100))
		SkuAuras.UnitRepo[tUnitId].unitPower = math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100))
	end

	if tUnitId == "player" or string.find(tUnitId, "party") or string.find(tUnitId, "raid") then
		if SkuAuras.UnitRepo[tUnitId].unitTargetName ~= UnitGUID(tUnitId.."target") then
			SkuAuras.UnitRepo[tUnitId].unitTargetName = UnitGUID(tUnitId.."target")

			print("ooooooooooooooo target change for ", tUnitId)
			print("changed to", UnitName(tUnitId.."target"))
			if UnitName(tUnitId.."target") then
				local tNewTargetUnitId = SkuAuras:GetBestUnitId(UnitName(tUnitId.."target"))
				local tEventData = {
					GetTime(),
					"UNIT_TARGETCHANGE",
					nil,
					tUnitId,
					UnitName(tUnitId),
					nil,
					nil,
					tNewTargetUnitId,
					UnitName(tUnitId.."target"),
					nil,
					nil,
					nil,
					nil,
					nil,
				}
				tEventData[35] = SkuAuras.UnitRepo[tUnitId].unitHealth,		
				SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)
			end
		end

	end


	if SkuAuras.UnitRepo[tUnitId].unitHealth ~= math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100)) then
		SkuAuras.UnitRepo[tUnitId].unitHealth = math.floor(UnitHealth(tUnitId) / (UnitHealthMax(tUnitId) / 100))
		local tEventData = {
			GetTime(),
			"UNIT_HEALTH",
			nil,
			tUnitId,
			UnitName(tUnitId),
			nil,
			nil,
			tUnitId,
			UnitName(tUnitId),
			nil,
			nil,
			nil,
			nil,
			nil,
		}
		tEventData[35] = SkuAuras.UnitRepo[tUnitId].unitHealth,		
		SkuAuras:COMBAT_LOG_EVENT_UNFILTERED("customCLEU", tEventData)
	end

	if SkuAuras.UnitRepo[tUnitId].unitPower ~= math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100)) then
		SkuAuras.UnitRepo[tUnitId].unitPower = math.floor(UnitPower(tUnitId) / (UnitPowerMax(tUnitId) / 100)) 
		local tEventData = {
			GetTime(),
			"UNIT_POWER",
			nil,
			tUnitId,
			UnitName(tUnitId),
			nil,
			nil,
			tUnitId,
			UnitName(tUnitId),
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
		}
		tEventData[36] = SkuAuras.UnitRepo[tUnitId].unitPower,		
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
	--dprint("COMBAT_LOG_EVENT_UNFILTERED", aEventName, aCustomEventData)
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
	--build non event related data to evaluate
	local tSourceUnitID = SkuAuras:GetBestUnitId(tEventData[CleuBase.sourceName], true)
	local tDestinationUnitID = SkuAuras:GetBestUnitId(tEventData[CleuBase.destName], true)

	if tDestinationUnitID and tDestinationUnitID[1] then
		if tDestinationUnitID ~= "party0" then
			tDestinationUnitIDCannAttack = UnitCanAttack("player", tDestinationUnitID[1])
		end
	end
	if tSourceUnitID and tSourceUnitID[1] then
		if tSourceUnitID ~= "party0" then
			tSourceUnitIDCannAttack = UnitCanAttack("player", tSourceUnitID[1])
		end
	end

	local tUnitID = "player"
	if SkuAuras.UnitRepo[tUnitID] then
		if not tEventData[35] then
			tEventData[35] = SkuAuras.UnitRepo[tUnitID].unitHealth
		end
		if not tEventData[36] then
			tEventData[36] = SkuAuras.UnitRepo[tUnitID].unitPower
		end
	end

	local tUnitID = "target"
	local tBuffList = {}
	for x = 1, 40  do
		local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff(tUnitID, x)
		if name then
			tBuffList[name] = true
		end
	end
	tEventData[37] = tBuffList
	local tdebuffList = {}
	for x = 1, 40  do
		local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitDebuff(tUnitID, x)
		if name then
			tdebuffList[name] = true
		end
	end
	tEventData[38] = tdebuffList

--[[

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
	dprint("buffListTarget", tEventData[37])
	dprint("dbuffListTarget", tEventData[38])
	dprint("itemID", tEventData[40])
	dprint("missType", tEventData[12])
	dprint("tSourceUnitID", tSourceUnitID)
	setmetatable(tSourceUnitID, SkuPrintMTWo)
	print(tSourceUnitID)
	dprint("tDestinationUnitID", tDestinationUnitID)
	setmetatable(tDestinationUnitID, SkuPrintMTWo)
	print(tDestinationUnitID)
	dprint("tSourceUnitIDCannAttack", tSourceUnitIDCannAttack)
	dprint("tDestinationUnitIDCannAttack", tDestinationUnitIDCannAttack)
]]
	--evaluate all auras
	local tFirst = true
	for tAuraName, tAuraData in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do
		dprint("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+")
		dprint(tAuraName, tAuraData)

		if tAuraData.enabled == true then

			local tOverallResult = true
			local tHasApplicableAttributes = false

			--build event related data to evaluate
			local tEvaluateData = {
				sourceUnitId = tSourceUnitID,
				sourceName = tEventData[CleuBase.sourceName],
				destUnitId = tDestinationUnitID,
				destName = tEventData[CleuBase.destName],
				event = tEventData[CleuBase.subevent],
				spellId = tEventData[CleuBase.spellId],
				spellName = tEventData[CleuBase.spellName],
				unitHealthPlayer = tEventData[35],
				unitPowerPlayer = tEventData[36],
				buffListTarget = tEventData[37],
				debuffListTarget = tEventData[38],
				tSourceUnitIDCannAttack = tSourceUnitIDCannAttack,
				tDestinationUnitIDCannAttack = tDestinationUnitIDCannAttack,
				tInCombat = SkuCore.inCombat,
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
				dprint("----------- _MISSED -----------", tEventData[12])
				tEvaluateData.missType = tEventData[12]
			end



			tEvaluateData.itemId = tEventData[40]
			if tEventData[40] then
				tEvaluateData.itemName = SkuDB.itemLookup[tEventData[40]]
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

			for tAttributeName, tAttributeValue in pairs(tAuraData.attributes) do
				tHasApplicableAttributes = true
				if #tAttributeValue > 1 then
					local tLocalResult = false
					for tInd, tLocalValue in pairs(tAttributeValue) do
						local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tLocalValue[1], tLocalValue[2])
						dprint("RESULT:", tResult)
						if tResult == true then
							tLocalResult = true
						end
					end
					if tLocalResult ~= true then
						tOverallResult = false
					end
				else
					local tResult = SkuAuras.attributes[tAttributeName]:evaluate(tEvaluateData, tAttributeValue[1][1], tAttributeValue[1][2])
					dprint("RESULT:", tResult)
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
			end				

			--add data for outputs
			tEvaluateData.buffListTarget = tSingleBuffListTargetValue
			tEvaluateData.debuffListTarget = tSingleDebuffListTargetValue

			--overall result
			dprint("OVERALL RESULT:", tOverallResult, "tHasApplicableAttributes", tHasApplicableAttributes)
			if tAuraData.type == "if" then
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
			else
				if tOverallResult == false and tHasApplicableAttributes == true then
					dprint("~= trigger:", #tAuraData.actions, tAuraData.actions[1])
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
			tAuraName = tAuraName.."und;"
		end
		if #tAttributeValue > 1 then
			local tCount = 0
			for tInd, tLocalValue in pairs(tAttributeValue) do
				if tCount > 0 then
					tAuraName = tAuraName.."oder;"..SkuAuras.attributes[tAttributeName].friendlyName..";"..SkuAuras.Operators[tLocalValue[1]].friendlyName..";"..SkuAuras.values[tLocalValue[2]].friendlyName..";"
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

	tAuraName = tAuraName.."dann;"..SkuAuras.actions[tActions[1]].friendlyName..";"

	for tOutputIndex, tOutputName in pairs(tOutputs) do
		tAuraName = tAuraName..SkuAuras.outputs[string.gsub(tOutputName, "output:", "")].friendlyName..";"
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
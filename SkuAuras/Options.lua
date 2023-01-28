local MODULE_NAME = "SkuAuras"
local L = Sku.L

SkuAuras.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuAuras.defaults = {
	enable = true,
}

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

------------------------------------------------------------------------------------------------------------------
local function NoIndexTableGetn(aTable)
	local tCount = 0
	for _, _ in pairs(aTable) do
		tCount = tCount + 1
	end
	return tCount
end

------------------------------------------------------------------------------------------------------------------
local function RemoveTagFromValue(aValue)
   if not aValue then
      return
   end
   local tCleanValue = string.gsub(aValue, "item:", "")
   tCleanValue = string.gsub(tCleanValue, "spell:", "")
   tCleanValue = string.gsub(tCleanValue, "output:", "")
   return tCleanValue
end

---------------------------------------------------------------------------------------------------------------------------------------
local function TableSortByIndex(aTable)
	local tSortedList = {}
	for k, v in SkuSpairs(aTable, 
		function(t, a, b) 
			return string.lower(t[b].friendlyName) > string.lower(t[a].friendlyName)
		end) 
	do
		tSortedList[#tSortedList+1] = k
	end
	return tSortedList
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildAuraTooltip(aCurrentMenuItem, aAuraName)
															
	local tMenuItem = aCurrentMenuItem
	local tSections = {}

	local tType = ""
	local tConditions = {}
	local tAction = ""
	local tOutputs = {}
	local tCurrent = {elementType = tMenuItem.elementType, name = tMenuItem.name, internalName = tMenuItem.internalName}

	local tItemsRev = {}

	while tMenuItem.internalName do
		table.insert(tItemsRev, 1, {internalName = tMenuItem.internalName, elementType = tMenuItem.elementType, name = tMenuItem.name})
		tMenuItem = tMenuItem.parent
	end

	local x = 1
	while tItemsRev[x] do
		if tItemsRev[x].elementType == "type" then
			tType = tItemsRev[x].name
			x = x + 1
		elseif tItemsRev[x].elementType == "attribute" and tItemsRev[x].internalName ~= "action" then
			local tCondNo = #tConditions + 1
			tConditions[tCondNo] = {attribute = tItemsRev[x].name}
			x = x + 1
			if not tItemsRev[x] then break end
			tConditions[tCondNo].operator = tItemsRev[x].name
			x = x + 1
			if not tItemsRev[x] then break end
			tConditions[tCondNo].value = tItemsRev[x].name
			x = x + 1
		elseif tItemsRev[x].elementType == "attribute" and tItemsRev[x].internalName == "action" then
			x = x + 2
			if not tItemsRev[x] then tAction = L["nicht festgelegt"] break end
			tAction = tItemsRev[x].name
			x = x + 1
		elseif tItemsRev[x].elementType == "output" then
			tOutputs[#tOutputs + 1] = tItemsRev[x].name
			x = x + 1
		else
			x = x + 1
		end
	end

	if #tOutputs == 0 then
		tOutputs[#tOutputs + 1] = L["nicht festgelegt"]
	end
	if #tConditions == 0 then
		tConditions[#tConditions + 1] = {attribute = L["nicht festgelegt"]}
	end
	if tType == "" then
		tType = L["nicht festgelegt"]
	end
	if tAction == "" then
		tAction = L["nicht festgelegt"]
	end

	if tCurrent.elementType then
		local tText = L["Aktuelles Element: "]..SkuAuras.itemTypes[tCurrent.elementType].friendlyName..L["\r\nAuswählter Wert: "]..tCurrent.name.." "
		if tCurrent.elementType == "type" then
			if SkuAuras.Types[tCurrent.internalName].tooltip then
				tText = tText.."("..SkuAuras.Types[tCurrent.internalName].tooltip..")"
			end
		elseif tCurrent.elementType == "attribute" then
			if SkuAuras.attributes[tCurrent.internalName].tooltip then
				tText = tText.."("..SkuAuras.attributes[tCurrent.internalName].tooltip..")"
			end
		elseif tCurrent.elementType == "operator" then
			if SkuAuras.Operators[tCurrent.internalName].tooltip then
				tText = tText.."("..SkuAuras.Operators[tCurrent.internalName].tooltip..")"
			end
		elseif tCurrent.elementType == "value" then
			if SkuAuras.values[tCurrent.internalName] then
				if SkuAuras.values[tCurrent.internalName].tooltip then
					tText = tText.."("..SkuAuras.values[tCurrent.internalName].tooltip..")"
				end
			end
		elseif tCurrent.elementType == "action" then
			if SkuAuras.actions[tCurrent.internalName].tooltip then
				tText = tText.."("..SkuAuras.actions[tCurrent.internalName].tooltip..")"
			end
		elseif tCurrent.elementType == "output" then
			if SkuAuras.outputs[RemoveTagFromValue(tCurrent.internalName)].tooltip then
				tText = tText.."("..SkuAuras.outputs[RemoveTagFromValue(tCurrent.internalName)].tooltip..")"
			end
		end
		table.insert(tSections, tText)
	end


	if aAuraName then
		if SkuOptions.db.char[MODULE_NAME].Auras[aAuraName].type then
			tType = SkuAuras.Types[SkuOptions.db.char[MODULE_NAME].Auras[aAuraName].type].friendlyName
		end
		tConditions = {}
		for tName, tData in pairs(SkuOptions.db.char[MODULE_NAME].Auras[aAuraName].attributes) do
			for tDataIndex, tDataData in pairs(tData) do
				tConditions[#tConditions + 1] = {attribute = SkuAuras.attributes[tName].friendlyName, operator = SkuAuras.Operators[tDataData[1]].friendlyName, value = SkuAuras.values[tDataData[2]].friendlyName}
			end
		end
		tAction = SkuAuras.actions[SkuOptions.db.char[MODULE_NAME].Auras[aAuraName].actions[1]].friendlyName
		tOutputs = {}
		for tIndex, tData in pairs(SkuOptions.db.char[MODULE_NAME].Auras[aAuraName].outputs) do
			local tString = string.gsub(SkuAuras.outputs[RemoveTagFromValue(tData)].friendlyName, L["sound"].."#", ";")
			tOutputs[#tOutputs + 1] = tString
		end
		table.insert(tSections, L["Aura Elemente\r\n"])
	else
		table.insert(tSections, L["Bisherige Aura Elemente\r\n"])
	end

	table.insert(tSections, L["Aura Typ: "]..(tType or ""))
	
	local tString = L["Aura Bedingungen:\r\n"]
	for x = 1, #tConditions do
		tString = tString..x..": "..tConditions[x].attribute.." "..(tConditions[x].operator or "").." "..(tConditions[x].value or "").."\r\n"
	end
	table.insert(tSections, tString)

	table.insert(tSections, L["Aura Aktion: "]..(tAction or ""))

	tString = L["Aura Ausgaben:\r\n"]
	for x = 1, #tOutputs do
		tString = tString..x..": "..(tOutputs[x] or "").."\r\n"
	end
	table.insert(tSections, tString)

	SkuOptions.currentMenuPosition.textFull = tSections
end

---------------------------------------------------------------------------------------------------------------------------------------
local function RebuildUsedOutputsHelper(aCurrentMenuItem)
	local tUsed = {}
	local tCurrentItem = aCurrentMenuItem.parent

	tUsed[RemoveTagFromValue(aCurrentMenuItem.internalName)] = true

	while tCurrentItem.parent.parent.internalName ~= "action" do
		tUsed[RemoveTagFromValue(tCurrentItem.internalName)] = true
		tCurrentItem = tCurrentItem.parent
	end

	tUsed[RemoveTagFromValue(tCurrentItem.parent.internalName)] = true

	return tUsed
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraAttributeBuilder(self)
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty no tSelectTarget"}, SkuGenericMenuItem)
			return
		end

		if self.parent.parent.internalName == "action" and not tSelectTarget.newOrChanged then
			local tSortedList = TableSortByIndex(SkuAuras.outputs)
			for x = 1, #tSortedList do
				local i, v = tSortedList[x], SkuAuras.outputs[tSortedList[x]]
				if not tSelectTarget.usedOutputs[i] then
					tItemCount = true
					local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, SkuGenericMenuItem)
					tAttributeEntry.internalName = "output:"..i
					tAttributeEntry.dynamic = true
					tAttributeEntry.filterable = true
					tAttributeEntry.actionOnEnter = true
					tAttributeEntry.elementType = "output"
					tAttributeEntry.OnEnter = function(self, aValue, aName)
						tSelectTarget.collectValuesFrom = self
						tSelectTarget.usedOutputs = RebuildUsedOutputsHelper(self)
						self.BuildChildren = SkuAuras:NewAuraOutputBuilder(self)		
						SkuAuras:BuildAuraTooltip(self)
						SkuGenericMenuItem.OnEnter(self, aValue, aName)
					end
					tAttributeEntry.BuildChildren = function(self)
						--dprint("build content of", self.name)
						--dprint("self.internalName", self.internalName)
					end
				end
			end
		
		else
			local tItemCount
			if SkuAuras.Types[tSelectTarget.internalName] then
				local tSortedList = TableSortByIndex(SkuAuras.attributes)
				for x = 1, #tSortedList do
					local i, v = tSortedList[x], tSortedList[x]
					
					tItemCount = true

					local tAttributeEntry = SkuOptions:InjectMenuItems(self, {SkuAuras.attributes[v].friendlyName}, SkuGenericMenuItem)
					tAttributeEntry.internalName = v
					tAttributeEntry.dynamic = true
					tAttributeEntry.filterable = true
					tAttributeEntry.vocalizeAsIs = true
					tAttributeEntry.elementType = "attribute"
					tAttributeEntry.OnEnter = function(self, aValue, aName)
						self.BuildChildren = SkuAuras:NewAuraOperatorBuilder(self)		
						SkuAuras:BuildAuraTooltip(self)
					end
					tAttributeEntry.BuildChildren = function(self)
						--dprint("build content of", self.name)
						--dprint("self.internalName", self.internalName)
					end
				end

				if not tItemCount then
					self.dynamic = false
				end
			else
				local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"this should not happen - empty not SkuAuras.Types[tSelectTarget.name.internalName]"}, SkuGenericMenuItem)
			end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraOutputBuilder(self)
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end

	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"this should not happen - empty no tSelectTarget"}, SkuGenericMenuItem)
			return
		end

		tItemCount = 0

		local tSortedList = TableSortByIndex(SkuAuras.outputs)
		for x = 1, #tSortedList do
			local i, v = tSortedList[x], SkuAuras.outputs[tSortedList[x]]
			if not tSelectTarget.usedOutputs[i] then
				tItemCount = tItemCount + 1
				local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, SkuGenericMenuItem)
				tAttributeEntry.internalName = "output:"..i
				tAttributeEntry.dynamic = true
				tAttributeEntry.filterable = true
				tAttributeEntry.actionOnEnter = true
				tAttributeEntry.vocalizeAsIs = true
				tAttributeEntry.elementType = "output"
				tAttributeEntry.OnEnter = function(self, aValue, aName)
					tSelectTarget.collectValuesFrom = self
					tSelectTarget.usedOutputs = RebuildUsedOutputsHelper(self)
					if tItemCount > 0 then
						self.BuildChildren = SkuAuras:NewAuraOutputBuilder(self)		
					end
					if tItemCount == 1 then
						self.dynamic = false
					end
					SkuAuras:BuildAuraTooltip(self)
					SkuGenericMenuItem.OnEnter(self, aValue, aName)
				end
				tAttributeEntry.BuildChildren = function(self)
					--dprint("build content of", self.name)
					--dprint("self.internalName", self.internalName)
				end
			end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraOperatorBuilder(self)
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty"}, SkuGenericMenuItem)
			return
		end

		if self.internalName == "action" then
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {L["then"]}, SkuGenericMenuItem)
			tAttributeEntry.internalName = "then"
			tAttributeEntry.dynamic = true
			tAttributeEntry.filterable = true
			tAttributeEntry.elementType = "then"
			tAttributeEntry.OnEnter = function(self, aValue, aName)
				self.BuildChildren = SkuAuras:NewAuraValueBuilder(self)
				SkuAuras:BuildAuraTooltip(self)
			end
			tAttributeEntry.BuildChildren = function(self)
				--dprint("build content of", self.name)
			end
		else
			local attrType = SkuAuras.attributes[self.internalName].type or "CATEGORY"
			local operators = SkuAuras.operatorsForAttributeType[attrType]
			local tSortedList = TableSortByIndex(operators)
			for x = 1, #tSortedList do
				local i, v = tSortedList[x], SkuAuras.Operators[tSortedList[x]]
				if i ~= "then" then
					local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, SkuGenericMenuItem)
					tAttributeEntry.internalName = i
					tAttributeEntry.dynamic = true
					tAttributeEntry.filterable = true
					tAttributeEntry.vocalizeAsIs = true
					tAttributeEntry.elementType = "operator"
					tAttributeEntry.OnEnter = function(self, aValue, aName)
						self.BuildChildren = SkuAuras:NewAuraValueBuilder(self)
						SkuAuras:BuildAuraTooltip(self)
					end
					tAttributeEntry.BuildChildren = function(self)
						--dprint("build content of", self.name)
					end
				end
			end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
local slower = string.lower
function SkuAuras:NewAuraValueBuilder(self)
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.parent.selectTarget then
		tSelectTarget = self.parent.parent.selectTarget
	elseif self.parent.parent.isSelect then
		tSelectTarget = self.parent.parent
	end
	
	tSelectTarget.usedOutputs = {}

	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {L["empty"]}, SkuGenericMenuItem)
			return
		end

		if SkuAuras.Types[tSelectTarget.internalName] then
			local tSortedList = {}
			for k, v in SkuSpairs(SkuAuras.attributes[self.parent.internalName].values, 
				function(t, a, b) 
					if SkuAuras.actions[SkuAuras.attributes[self.parent.internalName].values[b]] then
						return slower(SkuAuras.actions[SkuAuras.attributes[self.parent.internalName].values[b]].friendlyName) > slower(SkuAuras.actions[SkuAuras.attributes[self.parent.internalName].values[a]].friendlyName)
					else
						return slower(SkuAuras.values[SkuAuras.attributes[self.parent.internalName].values[b]].friendlyName) > slower(SkuAuras.values[SkuAuras.attributes[self.parent.internalName].values[a]].friendlyName)
					end
				end) 
			do
				tSortedList[#tSortedList+1] = v
			end

			--for i, v in pairs(SkuAuras.attributes[self.parent.internalName].values) do
			for x = 1, #tSortedList do
				local i, v = tSortedList[x], tSortedList[x]
				local tAttributeValueEntryName = ""
				if self.internalName == "then" then
					tAttributeValueEntryName = SkuAuras.actions[v].friendlyName
				else
					tAttributeValueEntryName = SkuAuras.values[v].friendlyName
				end
				local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {tAttributeValueEntryName}, SkuGenericMenuItem)
				tAttributeValueEntry.internalName = v
				if not tSelectTarget.single then
					tAttributeValueEntry.dynamic = true
				end
				tAttributeValueEntry.filterable = true
				--tAttributeValueEntry.actionOnEnter = true
				tAttributeValueEntry.vocalizeAsIs = true
				tAttributeValueEntry.elementType = "value"
				tAttributeValueEntry.OnEnter = function(self, aValue, aName)
					tSelectTarget.collectValuesFrom = self
					tSelectTarget.usedAttributes[self.parent.parent.internalName] = true
					if not tSelectTarget.single then
						self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)
					end
					SkuAuras:BuildAuraTooltip(self)
				end
				if not tSelectTarget.single then
					tAttributeValueEntry.BuildChildren = function(self)
						--dprint("build content of", self.name)
					end
				end
			end
		else
			local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {L["empty"]}, SkuGenericMenuItem)
		end
	end

	return tBuildChildrenFunc
end


---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildAuraName(aNewType, aNewAttributes, aNewActions, aNewOutputs)
	local tAuraName = SkuAuras.Types[aNewType].friendlyName..";"
	local tOuterCount = 0
	for tAttributeName, tAttributeValue in pairs(aNewAttributes) do
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

	tAuraName = tAuraName..L["dann;"]..SkuAuras.actions[aNewActions[1]].friendlyName..";"

	for tOutputIndex, tOutputName in pairs(aNewOutputs) do
		tAuraName = tAuraName..L[";und;"]..SkuAuras.outputs[string.gsub(tOutputName, "output:", "")].friendlyName..";"
		tAuraName = string.gsub(tAuraName, "aura;sound#", L["sound;"])
	end

	return tAuraName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:UpdateAura(aAuraNameToUpdate, aNewType, aEnabled, aNewAttributes, aNewActions, aNewOutputs)
	--dprint("UpdateAura", aAuraNameToUpdate)
	--build the new name
	local tAuraName = SkuAuras:BuildAuraName(aNewType, aNewAttributes, aNewActions, aNewOutputs)
	if SkuOptions.db.char[MODULE_NAME].Auras[aAuraNameToUpdate].customName == true then
		tAuraName = aAuraNameToUpdate
	end

	--update aura
	local tBackTo = SkuOptions.currentMenuPosition.selectTarget.backTo
	C_Timer.After(0.01, function()
		--remove old aura
		local tIsCustomName = SkuOptions.db.char[MODULE_NAME].Auras[aAuraNameToUpdate].customName
		SkuOptions.db.char[MODULE_NAME].Auras[aAuraNameToUpdate] = nil

		--add new aura
		SkuOptions.db.char[MODULE_NAME].Auras[tAuraName] = {
			type = aNewType,
			enabled = aEnabled,
			attributes = aNewAttributes,
			actions = aNewActions,
			outputs = aNewOutputs,
			customName = tIsCustomName,
		}

		SkuOptions.Voice:OutputStringBTtts(L["Aktualisiert"], true, true, 0.3, true)		

		C_Timer.After(0.01, function()
			SkuOptions:SlashFunc(L["short"]..L[",SkuAuras,Auren,Auren verwalten,"]..SkuOptions.currentMenuPosition.parent.parent.parent.name..","..tAuraName)
			SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
			SkuOptions:VocalizeCurrentMenuName()
		end)
	end)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildManageSubMenu(aParentEntry, aNewEntry)
	local tTypeItem = SkuOptions:InjectMenuItems(aParentEntry, aNewEntry, SkuGenericMenuItem)
	tTypeItem.dynamic = true
	tTypeItem.internalName = "action"
	tTypeItem.OnEnter = function(self)
		self.selectTarget.targetAuraName = self.name
		SkuAuras:BuildAuraTooltip(self, self.name)
	end
	tTypeItem.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Umbenennen"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnEnter = function(self)
			self.selectTarget.targetAuraName = self.parent.name
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Set name to auto generated"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnEnter = function(self)
			self.selectTarget.targetAuraName = self.parent.name
		end

		if self.parent.name == L["Aktivierte"] then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Deaktivieren"]}, SkuGenericMenuItem)
			tNewMenuEntry.OnEnter = function(self)
				self.selectTarget.targetAuraName = self.parent.name
			end
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Aktivieren"]}, SkuGenericMenuItem)
			tNewMenuEntry.OnEnter = function(self)
				self.selectTarget.targetAuraName = self.parent.name
			end			
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Bearbeiten"]}, SkuGenericMenuItem)
		tNewMenuEntry.OnEnter = function(self)
			self.selectTarget.targetAuraName = self.parent.name
		end		
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.internalName = "action"
		tNewMenuEntry.BuildChildren = function(self)
			--[[
			local tNewMenuEntryType = SkuOptions:InjectMenuItems(self, {"Typ"}, SkuGenericMenuItem)
			tNewMenuEntryType.dynamic = true
			tNewMenuEntryType.isSelect = true
			tNewMenuEntryType.OnAction = function(self, aValue, aName)
				print("OnAction Typ ")
			end
			tNewMenuEntryType.BuildChildren = function(self)
				local tNewMenuEntryTypeVal = SkuOptions:InjectMenuItems(self, {"Wenn"}, SkuGenericMenuItem)
				local tNewMenuEntryTypeVal = SkuOptions:InjectMenuItems(self, {"Wenn nicht"}, SkuGenericMenuItem)
			end
			]]
			local tNewMenuEntryCond = SkuOptions:InjectMenuItems(self, {L["Bedingungen"]}, SkuGenericMenuItem)
			tNewMenuEntryCond.dynamic = true
			tNewMenuEntryCond.isSelect = true
			tNewMenuEntryCond.auraName = self.parent.name
			tNewMenuEntryCond.backTo = self.parent.parent
			tNewMenuEntryCond.usedAttributes = {}
			tNewMenuEntryCond.single = true
			tNewMenuEntryCond.internalName = SkuOptions.db.char[MODULE_NAME].Auras[self.parent.name].type
			tNewMenuEntryCond.OnAction = function(self, aValue, aName)
				local tType = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].type
				local tEnabled = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].enabled
				local tAttributes = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].attributes
				local tActions = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].actions
				local tOutputs = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].outputs

				local function tAddConditionHelper(aParent)
					if not tAttributes[aParent.collectValuesFrom.parent.parent.internalName] then
						tAttributes[aParent.collectValuesFrom.parent.parent.internalName] = {}
					end
					table.insert(tAttributes[aParent.collectValuesFrom.parent.parent.internalName], {
						[1] = aParent.collectValuesFrom.parent.internalName,
						[2] = aParent.collectValuesFrom.internalName,
					})
				end
				
				local function tDeleteConditionHelper(aParent)
					local tDeleteAttribute
					for i, v in pairs(tAttributes) do
						if i == aParent.selectedCond[1] then
							local tFoundX
							if #v > 1 then
								for x = 1, #v do
									if v[x][1] == aParent.selectedCond[2] and v[x][2] == aParent.selectedCond[3] then
										tFoundX = x
									end
								end
								if tFoundX then
									table.remove(v, tFoundX)
								end
							else
								if v[1][1] == aParent.selectedCond[2] and v[1][2] == aParent.selectedCond[3] then
									table.remove(v, tFoundX)
								end
							end
							if #v == 0 then
								tDeleteAttribute = i
							end
						end
					end
					if tDeleteAttribute then
						tAttributes[tDeleteAttribute] = nil
					end
				end

				if aName == L["Löschen"] then
					tDeleteConditionHelper(self)

				elseif self.newOrChanged == "new" then
					tAddConditionHelper(self)

				elseif self.newOrChanged == "changed" then
					tDeleteConditionHelper(self)
					tAddConditionHelper(self)
				end

				SkuAuras:UpdateAura(self.auraName, tType, tEnabled, tAttributes, tActions, tOutputs)
			end

			tNewMenuEntryCond.BuildChildren = function(self)
				local tNewMenuEntryCondVal = SkuOptions:InjectMenuItems(self, {L["Bedingung hinzufügen"]}, SkuGenericMenuItem)
				tNewMenuEntryCondVal.dynamic = true
				tNewMenuEntryCondVal.OnEnter = function(self, aValue, aName)
					self.selectTarget.newOrChanged = "new"
				end
				tNewMenuEntryCondVal.BuildChildren = SkuAuras:NewAuraAttributeBuilder(tNewMenuEntryCondVal)
				for i, v in pairs(SkuOptions.db.char[MODULE_NAME].Auras[self.parent.parent.name].attributes) do
					for x = 1, #v do
						local tNewMenuEntryCondValCon = SkuOptions:InjectMenuItems(self, {SkuAuras.attributes[i].friendlyName..";"..SkuAuras.Operators[v[x][1]].friendlyName ..";"..SkuAuras.values[v[x][2]].friendlyName}, SkuGenericMenuItem)
						tNewMenuEntryCondValCon.dynamic = true
						tNewMenuEntryCondValCon.OnEnter = function(self, aValue, aName)
							self.selectTarget.selectedCond = {[1] = i, [2] = v[x][1], [3] = v[x][2]}
						end
						tNewMenuEntryCondValCon.BuildChildren = function(self)
							local tNewMenuEntryCondValOptions = SkuOptions:InjectMenuItems(self, {L["Ändern"]}, SkuGenericMenuItem)
							tNewMenuEntryCondValOptions.dynamic = true
							tNewMenuEntryCondValOptions.OnEnter = function(self, aValue, aName)
								self.selectTarget.newOrChanged = "changed"
							end
							tNewMenuEntryCondValOptions.BuildChildren = SkuAuras:NewAuraAttributeBuilder(tNewMenuEntryCondValOptions)

							if NoIndexTableGetn(SkuOptions.db.char[MODULE_NAME].Auras[self.parent.parent.parent.name].attributes) > 1 then
								local tNewMenuEntryCondValOptions = SkuOptions:InjectMenuItems(self, {L["Löschen"]}, SkuGenericMenuItem)
								tNewMenuEntryCondValOptions.actionOnEnter = true
							end
						end
					end
				end
			end

			local tNewMenuEntryOutp = SkuOptions:InjectMenuItems(self, {L["Ausgaben"]}, SkuGenericMenuItem)
			tNewMenuEntryOutp.dynamic = true
			tNewMenuEntryOutp.isSelect = true
			tNewMenuEntryOutp.auraName = self.parent.name
			tNewMenuEntryOutp.usedOutputs = {}
			tNewMenuEntryOutp.backTo = self.parent.parent
			tNewMenuEntryOutp.single = true
			tNewMenuEntryOutp.internalName = "action"
			tNewMenuEntryOutp.OnAction = function(self, aValue, aName)
				--dprint("---- OnAction Ausgaben ", aValue, aName)
				--dprint("     self.auraName", self.auraName)
				--dprint("     self.collectValuesFrom.name", self.collectValuesFrom.name)

				local tType = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].type
				local tEnabled = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].enabled
				local tAttributes = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].attributes
				local tActions = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].actions
				local tOutputs = SkuOptions.db.char[MODULE_NAME].Auras[self.auraName].outputs

				local tTmpOutputs = {}
				local tCurrent = self.collectValuesFrom
				while tCurrent.name ~= L["Ausgaben"] do
					tTmpOutputs[#tTmpOutputs + 1] = tCurrent.internalName
					tCurrent = tCurrent.parent
				end
				
				local tNewOutputs = {}
				for x = #tTmpOutputs, 1, -1 do
					tNewOutputs[#tNewOutputs + 1] = tTmpOutputs[x]
				end

				SkuAuras:UpdateAura(self.auraName, tType, tEnabled, tAttributes, tActions, tNewOutputs)
			end
			tNewMenuEntryOutp.BuildChildren = SkuAuras:NewAuraAttributeBuilder(tNewMenuEntryOutp)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Duplizieren"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--dprint("OnAction Duplizieren")
			local tCopyCounter = 1
			local tTestNewName = L["Kopie;"]..tCopyCounter..";"..self.parent.name
			while SkuOptions.db.char[MODULE_NAME].Auras[tTestNewName] do
				tCopyCounter = tCopyCounter + 1
				tTestNewName = L["Kopie;"]..tCopyCounter..";"..self.parent.name
			end
			SkuOptions.db.char[MODULE_NAME].Auras[tTestNewName] = TableCopy(SkuOptions.db.char[MODULE_NAME].Auras[self.parent.name], true)
			SkuOptions.Voice:OutputStringBTtts(L["Dupliziert"], true, true, 0.3, true)		

			C_Timer.After(0.01, function()
				SkuOptions:SlashFunc(L["short"]..L[",SkuAuras,Auren,Auren verwalten,"]..self.parent.parent.name..","..tTestNewName)
				SkuOptions.currentMenuPosition:OnBack(SkuOptions.currentMenuPosition)
				SkuOptions:VocalizeCurrentMenuName()
			end)
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Wirklich duplizieren?"]}, SkuGenericMenuItem)
		end


		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Löschen"]}, SkuGenericMenuItem)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Exportieren"]}, SkuGenericMenuItem)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ExportAuraData(aAuraNamesTable)
	if not aAuraNamesTable then
		return
	end

	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
		auraData = {},
	}

	for i, v in pairs(aAuraNamesTable) do
		if SkuOptions.db.char[MODULE_NAME].Auras[v] then
			tExportDataTable.auraData[v] = SkuOptions.db.char[MODULE_NAME].Auras[v]
		end
	end

	PlaySound(88)
	print(L["Aura exportiert"])
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], false, true, 0.3)		
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable.version, tExportDataTable.auraData), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ImportAuraData()
	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], false, true, 0.2)

	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))

		if tSerializedData ~= "" then
			local tSuccess, version, auraName, auraData = SkuOptions:Deserialize(tSerializedData)
			if type(auraName) == "string" then
				if auraName and auraData and version then
					if version < 22.8 then
						SkuOptions.Voice:OutputStringBTtts(L["Aura version zu alt"], false, true, 0.3)		
						return
					end
					auraData.enabled = true
					SkuOptions.db.char[MODULE_NAME].Auras[auraName] = auraData
					print(L["Aura importiert:"])
					print(auraName)
					SkuOptions.Voice:OutputStringBTtts(L["Aura importiert"], false, true, 0.3)		
				else
					SkuOptions.Voice:OutputStringBTtts(L["Aura daten defekt"], false, true, 0.3)		
					return
				end

			elseif type(auraName) == "table" then
				auraData = auraName
				for i, v in pairs(auraData) do
					print(i)
					v.enabled = true
					SkuOptions.db.char[MODULE_NAME].Auras[i] = v
				end
				SkuOptions.Voice:OutputStringBTtts(L["Aura importiert"], false, true, 0.3)		
			end
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:MenuBuilder(aParentEntry)
	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Auren"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Neue aura"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			for i, v in pairs(SkuAuras.Types) do 
				local tTypeItem = SkuOptions:InjectMenuItems(self, {v.friendlyName}, SkuGenericMenuItem)
				tTypeItem.internalName = i
				tTypeItem.dynamic = true
				tTypeItem.filterable = true
				tTypeItem.isSelect = true
				tTypeItem.collectValuesFrom = self
				tTypeItem.usedAttributes = {}
				tTypeItem.elementType = "type"
				tTypeItem.OnAction = function(self, aValue, aName)
					local tMenuItem = self.collectValuesFrom
					local tFinalAttributes = {}
					while tMenuItem.internalName ~= self.internalName do
						if string.find(tMenuItem.internalName, "output:") then
							table.insert(tFinalAttributes, 1, {tMenuItem.internalName,})
							tMenuItem = tMenuItem.parent
						else
							table.insert(tFinalAttributes, 1, {tMenuItem.parent.parent.internalName, tMenuItem.internalName, tMenuItem.parent.internalName, })
							tMenuItem = tMenuItem.parent.parent.parent
						end
					end

					if SkuAuras:CreateAura(self.internalName, tFinalAttributes) == true then
						SkuOptions.Voice:OutputStringBTtts(L["Aura erstellt"], false, true, 0.1, true)
					else
						SkuOptions.Voice:OutputStringBTtts(L["Aura nicht erstellt"], false, true, 0.1, true)
					end
										
				end
				tTypeItem.OnEnter = function(self, aValue, aName)
					self.collectValuesFrom = self
					self.usedAttributes = {}
					self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)
					SkuAuras:BuildAuraTooltip(self)
				end
				tTypeItem.BuildChildren = function(self)
					--dprint("generic build content of", self.name, "this should not happen")
				end

			end		
		end
		--[[
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neu aus Vorlage"}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
		end
		]]
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Auren verwalten"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			--print("OnAction Auren verwalten", aValue, aName, self.targetAuraName)
			if not self.targetAuraName then return end
			if not SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName] then return end
			if aName == L["Deaktivieren"] or aName == L["Aktivieren"] then
				if SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled == true then
					SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled = false
					SkuOptions.Voice:OutputStringBTtts(L["deaktiviert"], false, true, 0.1, true)
				else
					SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled = true
					SkuOptions.Voice:OutputStringBTtts(L["aktiviert"], false, true, 0.1, true)
				end			
			elseif aName == L["Löschen"] then
				SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName] = nil
				SkuOptions.Voice:OutputStringBTtts(L["gelöscht"], false, true, 0.1, true)
			elseif aName == L["Exportieren"] then				
				SkuAuras:ExportAuraData({self.targetAuraName})

			elseif aName == L["Set name to auto generated"] then		
				local tData = SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName]
				local tAutoName = SkuAuras:BuildAuraName(tData.type, tData.attributes, tData.actions, tData.outputs)
				SkuOptions.db.char[MODULE_NAME].Auras[tAutoName] = TableCopy(SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName], true)
				SkuOptions.db.char[MODULE_NAME].Auras[tAutoName].customName = nil
				SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName] = nil

			elseif aName == L["Umbenennen"] then				
				local tCurrentName = self.targetAuraName
				SkuOptions:EditBoxShow(
					"",
					function(self)
						local tNewName = SkuOptionsEditBoxEditBox:GetText()
						if tNewName and tNewName ~= "" then
							if SkuOptions.db.char[MODULE_NAME].Auras[tNewName] then
								SkuOptions.Voice:OutputStringBTtts(L["name already exists"], false, false, 0.2, true, nil, nil, 2)
								SkuOptions.Voice:OutputStringBTtts(L["Auren verwalten"], false, false, 0.2, true, nil, nil, 2)
								PlaySound(88)
								return
							end

							SkuOptions.db.char[MODULE_NAME].Auras[tNewName] = TableCopy(SkuOptions.db.char[MODULE_NAME].Auras[tCurrentName], true)
							SkuOptions.db.char[MODULE_NAME].Auras[tNewName].customName = true
							SkuOptions.db.char[MODULE_NAME].Auras[tCurrentName] = nil
							PlaySound(88)
							C_Timer.After(0.01, function()
								SkuOptions.Voice:OutputStringBTtts(L["Renamed"], false, false, 0.2, true, nil, nil, 2)
								SkuOptions.Voice:OutputStringBTtts(L["Auren verwalten"], false, false, 0.2, true, nil, nil, 2)
							end)
						end
					end,
					nil
				)
				PlaySound(89)
				C_Timer.After(0.1, function()
					SkuOptions.Voice:OutputStringBTtts(L["Enter name and press ENTER key"], true, true, 1, true)
				end)
		
	

			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tTypeItem = SkuOptions:InjectMenuItems(self, {L["Aktivierte"]}, SkuGenericMenuItem)
			tTypeItem.dynamic = true
			tTypeItem.filterable = true
			tTypeItem.BuildChildren = function(self)
				local tHasEntries = false
				for i, v in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do 
					if v.enabled == true then
						tHasEntries = true
						SkuAuras:BuildManageSubMenu(self, {i})
					end
				end
				if tHasEntries == false then
					local tEmpty = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
				end
			end
			local tTypeItem = SkuOptions:InjectMenuItems(self, {L["Deaktivierte"]}, SkuGenericMenuItem)
			tTypeItem.dynamic = true
			tTypeItem.filterable = true
			tTypeItem.BuildChildren = function(self)
				local tHasEntries = false
				for i, v in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do 
					if v.enabled ~= true then
						tHasEntries = true
						SkuAuras:BuildManageSubMenu(self, {i})
					end
				end
				if tHasEntries == false then
					local tEmpty = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
				end
			end
			local tTypeItem = SkuOptions:InjectMenuItems(self, {L["Alle"]}, SkuGenericMenuItem)
			tTypeItem.dynamic = true
			tTypeItem.filterable = true
			tTypeItem.BuildChildren = function(self)
				local tHasEntries = false
				for i, v in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do 
					tHasEntries = true
					SkuAuras:BuildManageSubMenu(self, {i})
				end
				if tHasEntries == false then
					local tEmpty = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
				end
			end
		end

		local tdel = SkuOptions:InjectMenuItems(self, {L["Aura importieren"]}, SkuGenericMenuItem)
		tdel.dynamic = false
		tdel.isSelect = true
		tdel.OnAction = function(self, aValue, aName)
			SkuAuras:ImportAuraData()
		end		

		local tdel = SkuOptions:InjectMenuItems(self, {L["Alle Auren löschen"]}, SkuGenericMenuItem)
		tdel.dynamic = false
		tdel.isSelect = true
		tdel.OnAction = function(self, aValue, aName)
			SkuOptions.db.char[MODULE_NAME].Auras = {}
			SkuOptions.Voice:OutputStringBTtts(L["Alle auren gelöscht"], true, true, 0.1, true)
		end

		local tdel = SkuOptions:InjectMenuItems(self, {L["Alle Auren exportieren"]}, SkuGenericMenuItem)
		tdel.dynamic = false
		tdel.isSelect = true
		tdel.OnAction = function(self, aValue, aName)
			local aAuraNamesTable = {}
			for i, v in pairs(SkuOptions.db.char["SkuAuras"].Auras) do 
				table.insert(aAuraNamesTable, i)
			end 
			SkuAuras:ExportAuraData(aAuraNamesTable)
		end


		local tTypeItem = SkuOptions:InjectMenuItems(self, {L["Aura Sets verwalten"]}, SkuGenericMenuItem)
		tTypeItem.dynamic = true
		tTypeItem.isSelect = true
		tTypeItem.OnAction = function(self, aValue, aName)
			--dprint("OnAction Sets verwalten", self, aValue, aName)
			--dprint(self.selectedSetInternalName)
			if aName == L["Übernehmen überschreiben"] then
				SkuOptions.db.char[MODULE_NAME].Auras = {}
				tSetData = SkuAuras.AuraSets[self.selectedSetInternalName]
				for tAuraName, tAuraData in pairs(tSetData.auras) do
					SkuOptions.db.char[MODULE_NAME].Auras[tAuraData.friendlyNameShort] = tAuraData
				end
				SkuOptions.Voice:OutputStringBTtts(L["Set angewendet"], false, true, 0.3, true)	
			elseif aName == L["Übernehmen hinzufügen"] then
				tSetData = SkuAuras.AuraSets[self.selectedSetInternalName]
				for tAuraName, tAuraData in pairs(tSetData.auras) do
					SkuOptions.db.char[MODULE_NAME].Auras[tAuraData.friendlyNameShort] = tAuraData
				end
				SkuOptions.Voice:OutputStringBTtts(L["Set hinzugefügt"], false, true, 0.3, true)	
			elseif aName == L["Bearbeiten"] then
				SkuOptions.Voice:OutputStringBTtts(L["noch nicht implementiert"], false, true, 0.1, true)

			elseif aName == L["Exportieren"] then
				SkuOptions.Voice:OutputStringBTtts(L["noch nicht implementiert"], false, true, 0.1, true)

			elseif aName == L["Löschen"] then
				SkuAuras.AuraSets[self.selectedSetInternalName] = nil

			end
		end
		tTypeItem.BuildChildren = function(self)
			local tHasEntries = false
			for tIntName, tData in pairs(SkuAuras.AuraSets) do 
				--dprint(tIntName, tData, tData.friendlyName)
				tHasEntries = true
				local tSet = SkuOptions:InjectMenuItems(self, {tData.friendlyName}, SkuGenericMenuItem)
				tSet.dynamic = true
				tSet.internalName = tIntName
				tSet.OnEnter = function(self, aValue, aName)
					--dprint(self, aValue, aName)
					self.parent.selectedSetInternalName = self.internalName
					self.textFull = SkuAuras.AuraSets[self.internalName].tooltip
				end
				tSet.BuildChildren = function(self)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Übernehmen überschreiben"]}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Übernehmen hinzufügen"]}, SkuGenericMenuItem)
					--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Bearbeiten"]}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Exportieren"]}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Löschen"]}, SkuGenericMenuItem)
				end
			end
			if tHasEntries == false then
				local tEmpty = SkuOptions:InjectMenuItems(self, {L["leer"]}, SkuGenericMenuItem)
			end
		end
		local tTypeItem = SkuOptions:InjectMenuItems(self, {L["Aura Set importieren"]}, SkuGenericMenuItem)
		tTypeItem.dynamic = false
		tTypeItem.isSelect = true
		tTypeItem.OnAction = function(self, aValue, aName)
			--dprint("OnAction Set importieren")
			SkuOptions.Voice:OutputStringBTtts(L["noch nicht implementiert"], false, true, 0.1, true)
		end
		
	end
	--[[
	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Zauberdatenbank"}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)

	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Eigene"}, SkuGenericMenuItem)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Spieler"}, SkuGenericMenuItem)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle"}, SkuGenericMenuItem)
	end

	]]

	---
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	SkuOptions:IterateOptionsArgs(SkuAuras.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
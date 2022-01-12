local MODULE_NAME = "SkuAuras"
local L = Sku.L

SkuAuras.options = {
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
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuAuras.defaults = {
	enable = true,
}

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
			--print(t, a, b, t[a].friendlyName, t[b].friendlyName) 
			--if t[a].friendlyName and t[b].friendlyName then
				return t[b].friendlyName > t[a].friendlyName 
			--end
		end) 
	do
		tSortedList[#tSortedList+1] = k
	end
	return tSortedList
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildAuraTooltip(aCurrentMenuItem)
															
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
			if not tItemsRev[x] then tAction = "nicht festgelegt" break end
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
		tOutputs[#tOutputs + 1] = "nicht festgelegt"
	end
	if #tConditions == 0 then
		tConditions[#tConditions + 1] = {attribute = "nicht festgelegt"}
	end
	if tType == "" then
		tType = "nicht festgelegt"
	end
	if tAction == "" then
		tAction = "nicht festgelegt"
	end

	local tText = "Aktuelles Element: "..SkuAuras.itemTypes[tCurrent.elementType].friendlyName.."\r\nAuswählter Wert: "..tCurrent.name.." "
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
		dprint("tCurrent.internalName", tCurrent.internalName)
		if SkuAuras.outputs[RemoveTagFromValue(tCurrent.internalName)].tooltip then
			tText = tText.."("..SkuAuras.outputs[RemoveTagFromValue(tCurrent.internalName)].tooltip..")"
		end
	end
	table.insert(tSections, tText)

	table.insert(tSections, "Bisherige Aura Elemente\r\n")
	table.insert(tSections, "Aura Typ: "..(tType or ""))
	
	local tString = "Aura Bedingungen:\r\n"
	for x = 1, #tConditions do
		tString = tString..x..": "..tConditions[x].attribute.." "..(tConditions[x].operator or "").." "..(tConditions[x].value or "").."\r\n"
	end
	table.insert(tSections, tString)

	table.insert(tSections, "Aura Aktion: "..(tAction or ""))

	tString = "Aura Ausgaben:\r\n"
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

		if self.parent.parent.internalName == "action" then
			local tSortedList = TableSortByIndex(SkuAuras.outputs)
			for x = 1, #tSortedList do
				local i, v = tSortedList[x], SkuAuras.outputs[tSortedList[x]]
				if not tSelectTarget.usedOutputs[i] then
					tItemCount = true
					--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
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
						dprint("build content of", self.name)
						dprint("self.internalName", self.internalName)
					end
				end
			end
		
		else
			local tItemCount
			if SkuAuras.Types[tSelectTarget.internalName] then
				local tSortedList = TableSortByIndex(SkuAuras.attributes)
				for x = 1, #tSortedList do
					local i, v = tSortedList[x], tSortedList[x]--, SkuAuras.attributes[tSortedList[x]]
				--for i, v in pairs(SkuAuras.Types[tSelectTarget.internalName].attributes) do
					--if not tSelectTarget.usedAttributes[v] then
						tItemCount = true
						--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
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
							dprint("build content of", self.name)
							dprint("self.internalName", self.internalName)
						end
					--end
				end
				if not tItemCount then
					self.dynamic = false
				end
			else
				local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty not SkuAuras.Types[tSelectTarget.name.internalName]"}, SkuGenericMenuItem)
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
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty no tSelectTarget"}, SkuGenericMenuItem)
			return
		end

		tItemCount = 0


		local tSortedList = TableSortByIndex(SkuAuras.outputs)
		for x = 1, #tSortedList do
			local i, v = tSortedList[x], SkuAuras.outputs[tSortedList[x]]
		--for i, v in pairs(SkuAuras.outputs) do
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
					dprint("build content of", self.name)
					dprint("self.internalName", self.internalName)
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
				dprint("build content of", self.name)
			end
		else
			local tSortedList = TableSortByIndex(SkuAuras.Operators)
			for x = 1, #tSortedList do
				local i, v = tSortedList[x], SkuAuras.Operators[tSortedList[x]]
			--for i, v in pairs(SkuAuras.Operators) do
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
						dprint("build content of", self.name)
					end
				end
			end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
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
			for i, v in pairs(SkuAuras.attributes[self.parent.internalName].values) do
				local tAttributeValueEntryName = ""
				if self.internalName == "then" then
					tAttributeValueEntryName = SkuAuras.actions[v].friendlyName
				else
					tAttributeValueEntryName = SkuAuras.values[v].friendlyName
				end
				local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {tAttributeValueEntryName}, SkuGenericMenuItem)
				tAttributeValueEntry.internalName = v
				tAttributeValueEntry.dynamic = true
				tAttributeValueEntry.filterable = true
				--tAttributeValueEntry.actionOnEnter = true
				tAttributeValueEntry.vocalizeAsIs = true
				tAttributeValueEntry.elementType = "value"
				tAttributeValueEntry.OnEnter = function(self, aValue, aName)
					tSelectTarget.collectValuesFrom = self
					tSelectTarget.usedAttributes[self.parent.parent.internalName] = true
					self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)
					SkuAuras:BuildAuraTooltip(self)
				end
				tAttributeValueEntry.BuildChildren = function(self)
					dprint("build content of", self.name)
				end
	
			end
		else
			local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {L["empty"]}, SkuGenericMenuItem)
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildManageSubMenu(aParentEntry, aNewEntry)
	local tTypeItem = SkuOptions:InjectMenuItems(aParentEntry, aNewEntry, SkuGenericMenuItem)
	tTypeItem.dynamic = true
	tTypeItem.filterable = true
	tTypeItem.OnEnter = function(self)
		self.selectTarget.targetAuraName = self.name
	end
	tTypeItem.BuildChildren = function(self)
		if SkuOptions.db.char[MODULE_NAME].Auras[self.name].enabled == true then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Deaktivieren"}, SkuGenericMenuItem)
		else
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Aktivieren"}, SkuGenericMenuItem)
		end
		--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Bearbeiten"}, SkuGenericMenuItem)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, SkuGenericMenuItem)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Exportieren"}, SkuGenericMenuItem)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ExportAuraData(aAuraName)
	if not SkuOptions.db.char[MODULE_NAME].Auras[aAuraName] then return end

	local tExportDataTable = {
		version = 22.5,
		auraName = aAuraName,
		auraData = nil,
	}
	tExportDataTable.auraData = SkuOptions.db.char[MODULE_NAME].Auras[aAuraName]
	
	PlaySound(88)
	print("Aura exportiert")
	SkuOptions.Voice:OutputString("Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken", false, true, 0.3)		
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable.version, tExportDataTable.auraName, tExportDataTable.auraData), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:ImportAuraData()
	PlaySound(88)
	SkuOptions.Voice:OutputString(L["Paste data to import now"], false, true, 0.2)

	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))

		if tSerializedData ~= "" then
			local tSuccess, version, auraName, auraData = SkuOptions:Deserialize(tSerializedData)
			if auraName and auraData and version then
				if version < 22.5 then
					SkuOptions.Voice:OutputString("Aura version zu alt", false, true, 0.3)		
					return
				end
				auraData.enabled = true
				SkuOptions.db.char[MODULE_NAME].Auras[auraName] = auraData
				print("Aura importiert:")
				print(auraName)
				SkuOptions.Voice:OutputString("Aura importiert", false, true, 0.3)		
			else
				SkuOptions.Voice:OutputString("Aura daten defekt", false, true, 0.3)		
				return
			end
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:MenuBuilder(aParentEntry)
	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Auren"}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neue aura"}, SkuGenericMenuItem)
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
						SkuOptions.Voice:OutputString("Aura erstellt", false, true, 0.1, true)
					else
						SkuOptions.Voice:OutputString("Aura nicht erstellt", false, true, 0.1, true)
					end
										
				end
				tTypeItem.OnEnter = function(self, aValue, aName)
					self.collectValuesFrom = self
					self.usedAttributes = {}
					self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)
					SkuAuras:BuildAuraTooltip(self)
				end
				tTypeItem.BuildChildren = function(self)
					dprint("generic build content of", self.name, "this should not happen")
				end

			end		
		end
		--[[
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neu aus Vorlage"}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
		end
		]]
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Auren verwalten"}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			if not self.targetAuraName then return end
			if not SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName] then return end
			if aName == "Deaktivieren" or aName == "Aktivieren" then
				if SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled == true then
					SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled = false
					SkuOptions.Voice:OutputString("deaktiviert", false, true, 0.1, true)
				else
					SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName].enabled = true
					SkuOptions.Voice:OutputString("aktiviert", false, true, 0.1, true)
				end			
			elseif aName == "Bearbeiten" then
				SkuOptions.Voice:OutputString("noch nicht implementiert", false, true, 0.1, true)
			elseif aName == "Löschen" then
				SkuOptions.db.char[MODULE_NAME].Auras[self.targetAuraName] = nil
				SkuOptions.Voice:OutputString("gelöscht", false, true, 0.1, true)
			elseif aName == "Exportieren" then				
				SkuAuras:ExportAuraData(self.targetAuraName)
			end
		end
		tNewMenuEntry.BuildChildren = function(self)
			local tTypeItem = SkuOptions:InjectMenuItems(self, {"Aktivierte"}, SkuGenericMenuItem)
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
					local tEmpty = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
				end
			end
			local tTypeItem = SkuOptions:InjectMenuItems(self, {"Deaktivierte"}, SkuGenericMenuItem)
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
					local tEmpty = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
				end
			end
			local tTypeItem = SkuOptions:InjectMenuItems(self, {"Alle"}, SkuGenericMenuItem)
			tTypeItem.dynamic = true
			tTypeItem.filterable = true
			tTypeItem.BuildChildren = function(self)
				local tHasEntries = false
				for i, v in pairs(SkuOptions.db.char[MODULE_NAME].Auras) do 
					tHasEntries = true
					SkuAuras:BuildManageSubMenu(self, {i})
				end
				if tHasEntries == false then
					local tEmpty = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
				end
			end
		end

		local tdel = SkuOptions:InjectMenuItems(self, {"Aura importieren"}, SkuGenericMenuItem)
		tdel.dynamic = false
		tdel.isSelect = true
		tdel.OnAction = function(self, aValue, aName)
			SkuAuras:ImportAuraData()
		end		

		local tdel = SkuOptions:InjectMenuItems(self, {"Alle Auren löschen"}, SkuGenericMenuItem)
		tdel.dynamic = false
		tdel.isSelect = true
		tdel.OnAction = function(self, aValue, aName)
			SkuOptions.db.char[MODULE_NAME].Auras = {}
			SkuOptions.Voice:OutputString("Alle auren gelöscht", true, true, 0.1, true)
		end

		local tTypeItem = SkuOptions:InjectMenuItems(self, {"Aura Sets verwalten"}, SkuGenericMenuItem)
		tTypeItem.dynamic = true
		tTypeItem.isSelect = true
		tTypeItem.OnAction = function(self, aValue, aName)
			dprint("OnAction Sets verwalten", self, aValue, aName)
			dprint(self.selectedSetInternalName)
			if aName == "Übernehmen überschreiben" then
				SkuOptions.db.char[MODULE_NAME].Auras = {}
				tSetData = SkuAuras.AuraSets[self.selectedSetInternalName]
				for tAuraName, tAuraData in pairs(tSetData.auras) do
					SkuOptions.db.char[MODULE_NAME].Auras[tAuraData.friendlyNameShort] = tAuraData
				end
				SkuOptions.Voice:OutputString("Set angewendet", false, true, 0.3, true)	
			elseif aName == "Übernehmen hinzufügen" then
				tSetData = SkuAuras.AuraSets[self.selectedSetInternalName]
				for tAuraName, tAuraData in pairs(tSetData.auras) do
					SkuOptions.db.char[MODULE_NAME].Auras[tAuraData.friendlyNameShort] = tAuraData
				end
				SkuOptions.Voice:OutputString("Set hinzugefügt", false, true, 0.3, true)	
			elseif aName == "Bearbeiten" then
				SkuOptions.Voice:OutputString("noch nicht implementiert", false, true, 0.1, true)

			elseif aName == "Exportieren" then
				SkuOptions.Voice:OutputString("noch nicht implementiert", false, true, 0.1, true)

			elseif aName == "Löschen" then
				SkuAuras.AuraSets[self.selectedSetInternalName] = nil

			end
		end
		tTypeItem.BuildChildren = function(self)
			local tHasEntries = false
			for tIntName, tData in pairs(SkuAuras.AuraSets) do 
				dprint(tIntName, tData, tData.friendlyName)
				tHasEntries = true
				local tSet = SkuOptions:InjectMenuItems(self, {tData.friendlyName}, SkuGenericMenuItem)
				tSet.dynamic = true
				tSet.internalName = tIntName
				tSet.OnEnter = function(self, aValue, aName)
					dprint(self, aValue, aName)
					self.parent.selectedSetInternalName = self.internalName
					self.textFull = SkuAuras.AuraSets[self.internalName].tooltip
				end
				tSet.BuildChildren = function(self)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Übernehmen überschreiben"}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Übernehmen hinzufügen"}, SkuGenericMenuItem)
					--local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Bearbeiten"}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Exportieren"}, SkuGenericMenuItem)
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, SkuGenericMenuItem)
				end
			end
			if tHasEntries == false then
				local tEmpty = SkuOptions:InjectMenuItems(self, {"leer"}, SkuGenericMenuItem)
			end
		end
		local tTypeItem = SkuOptions:InjectMenuItems(self, {"Aura Set importieren"}, SkuGenericMenuItem)
		tTypeItem.dynamic = false
		tTypeItem.isSelect = true
		tTypeItem.OnAction = function(self, aValue, aName)
			dprint("OnAction Set importieren")
			SkuOptions.Voice:OutputString("noch nicht implementiert", false, true, 0.1, true)
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
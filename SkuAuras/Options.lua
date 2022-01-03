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

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraAttributeBuilder(self)
	dprint("NewAuraAttributeBuilder")
	dprint("self.internalName", self.internalName)
	dprint(" self.parent.parent.name", self.parent.parent.name)
	dprint(" self.name", self.name)
	dprint(" self.selectTarget", self.selectTarget)
	if self.selectTarget then
		dprint(" self.selectTarget.name", self.selectTarget.name)
	end
	dprint(" self.module", self.module)
	dprint(" self.isSelect", self.isSelect)
	dprint(" self.parent.isSelect", self.parent.isSelect)
	
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end
	
	dprint(" self.selectTarget new", tSelectTarget.name)
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			dprint("    empty")
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty no tSelectTarget"}, menuEntryTemplate_Menu)
			return
		end

		if self.parent.parent.internalName == "action" then
			dprint("    parent is action; we're done; now outputs")
			--self.dynamic = false
			for i, v in pairs(SkuAuras.outputs) do
				dprint("    outputs i, v", i , v)
				--if not tSelectTarget.usedAttributes[v] then
					tItemCount = true
					--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
					local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, menuEntryTemplate_Menu)
					tAttributeEntry.internalName = "output:"..i
					tAttributeEntry.dynamic = true
					tAttributeEntry.filterable = true
					tAttributeEntry.actionOnEnter = true
					tAttributeEntry.OnEnter = function(self, aValue, aName)
						dprint("onEnter", self.name)
						dprint("self.internalName", self.internalName)
						tSelectTarget.collectValuesFrom = self
						--tSelectTarget.usedAttributes[self.name] = true
						self.BuildChildren = SkuAuras:NewAuraOutputBuilder(self)		
					end
					tAttributeEntry.BuildChildren = function(self)
						dprint("build content of", self.name)
						dprint("self.internalName", self.internalName)
					end
				--end
			end
		
		else
			local tItemCount
			if SkuAuras.Types[tSelectTarget.internalName] then
				for i, v in pairs(SkuAuras.Types[tSelectTarget.internalName].attributes) do
					dprint("    i, v", i , v)
					--if not tSelectTarget.usedAttributes[v] then
						tItemCount = true
						--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
						local tAttributeEntry = SkuOptions:InjectMenuItems(self, {SkuAuras.attributes[v].friendlyName}, menuEntryTemplate_Menu)
						tAttributeEntry.internalName = v
						tAttributeEntry.dynamic = true
						tAttributeEntry.filterable = true
						tAttributeEntry.vocalizeAsIs = true
						tAttributeEntry.OnEnter = function(self, aValue, aName)
							dprint("onEnter", self.name)
							dprint("self.internalName", self.internalName)
							--tSelectTarget.collectValuesFrom = self
							--tSelectTarget.usedAttributes[self.name] = true
							self.BuildChildren = SkuAuras:NewAuraOperatorBuilder(self)		
						end
						tAttributeEntry.BuildChildren = function(self)
							dprint("build content of", self.name)
							dprint("self.internalName", self.internalName)
						end
					--end
				end
				if not tItemCount then
					dprint("    no unused attributes remaining")
					self.dynamic = false
					--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty"}, menuEntryTemplate_Menu)
				end
			else
				dprint("    empty")
				local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty not SkuAuras.Types[tSelectTarget.name.internalName]"}, menuEntryTemplate_Menu)
			end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraOutputBuilder(self)
	dprint("NewAuraOutputBuilder")
	dprint("self.internalName", self.internalName)
	dprint(" self.parent.parent.name", self.parent.parent.name)
	dprint(" self.name", self.name)
	dprint(" self.selectTarget", self.selectTarget)
	if self.selectTarget then
		dprint(" self.selectTarget.name", self.selectTarget.name)
	end
	dprint(" self.module", self.module)
	dprint(" self.isSelect", self.isSelect)
	dprint(" self.parent.isSelect", self.parent.isSelect)
	
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end
	
	dprint(" self.selectTarget new", tSelectTarget.name)
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			dprint("    empty")
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty no tSelectTarget"}, menuEntryTemplate_Menu)
			return
		end

		dprint("    another output")
		--self.dynamic = false
		for i, v in pairs(SkuAuras.outputs) do
			dprint("    outputs i, v", i , v)
			--if not tSelectTarget.usedAttributes[v] then
				tItemCount = true
				--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
				local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, menuEntryTemplate_Menu)
				tAttributeEntry.internalName = "output:"..i
				tAttributeEntry.dynamic = true
				tAttributeEntry.filterable = true
				tAttributeEntry.actionOnEnter = true
				tAttributeEntry.vocalizeAsIs = true
				tAttributeEntry.OnEnter = function(self, aValue, aName)
					dprint("onEnter", self.name)
					dprint("self.internalName", self.internalName)
					tSelectTarget.collectValuesFrom = self
					--tSelectTarget.usedAttributes[self.name] = true
					self.BuildChildren = SkuAuras:NewAuraOutputBuilder(self)		
				end
				tAttributeEntry.BuildChildren = function(self)
					dprint("build content of", self.name)
					dprint("self.internalName", self.internalName)
				end
			--end
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:NewAuraOperatorBuilder(self)
	dprint("NewAuraOperatorBuilder")
	dprint(" self.name", self.name)
	dprint(" self.internalName", self.internalName)
	
	dprint(" self.selectTarget", self.selectTarget)
	if self.selectTarget then
		dprint(" self.selectTarget.name", self.selectTarget.name)
	end
	dprint(" self.module", self.module)
	dprint(" self.isSelect", self.isSelect)
	dprint(" self.parent.isSelect", self.parent.isSelect)
	
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.selectTarget then
		tSelectTarget = self.parent.selectTarget
	elseif self.parent.isSelect then
		tSelectTarget = self.parent
	end
	
	dprint(" self.selectTarget new", tSelectTarget.name)
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			dprint("    empty")
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"empty"}, menuEntryTemplate_Menu)
			return
		end

		if self.internalName == "action" then
			--local tAttributeEntry = SkuOptions:InjectMenuItems(self, {"then"}, menuEntryTemplate_Menu)
			local tAttributeEntry = SkuOptions:InjectMenuItems(self, {L["then"]}, menuEntryTemplate_Menu)
			tAttributeEntry.internalName = "then"
			tAttributeEntry.dynamic = true
			tAttributeEntry.filterable = true
			tAttributeEntry.OnEnter = function(self, aValue, aName)
				dprint("onEnter", self.name)
				--tSelectTarget.collectValuesFrom = self
				--tSelectTarget.usedAttributes[self.name] = true
				self.BuildChildren = SkuAuras:NewAuraValueBuilder(self)		
			end
			tAttributeEntry.BuildChildren = function(self)
				dprint("build content of", self.name)
			end
		else
			for i, v in pairs(SkuAuras.Operators) do
				if i ~= "then" then
					dprint("    i, v", i , v)
					local tAttributeEntry = SkuOptions:InjectMenuItems(self, {v.friendlyName}, menuEntryTemplate_Menu)
					tAttributeEntry.internalName = i
					tAttributeEntry.dynamic = true
					tAttributeEntry.filterable = true
					tAttributeEntry.vocalizeAsIs = true
					tAttributeEntry.OnEnter = function(self, aValue, aName)
						dprint("onEnter", self.name)
						--tSelectTarget.collectValuesFrom = self
						--tSelectTarget.usedAttributes[self.name] = true
						self.BuildChildren = SkuAuras:NewAuraValueBuilder(self)		
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
	dprint("NewAuraValueBuilder")
	dprint(" self.name", self.name)
	dprint(" self.internalName", self.internalName)

	dprint(" self.selectTarget", self.selectTarget)
	if self.selectTarget then dprint(" self.selectTarget.name", self.selectTarget.name) end
	dprint(" self.module", self.module)
	dprint(" self.isSelect", self.isSelect)
	dprint(" self.parent.isSelect", self.parent.isSelect)
	
	local tSelectTarget = nil
	if self.isSelect then
		tSelectTarget = self
	elseif self.parent.parent.selectTarget then
		tSelectTarget = self.parent.parent.selectTarget
	elseif self.parent.parent.isSelect then
		tSelectTarget = self.parent.parent
	end
	
	dprint(" self.selectTarget new", tSelectTarget.name)
	
	local tBuildChildrenFunc = function(self)
		if not tSelectTarget then
			dprint("    empty")
			local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {L["empty"]}, menuEntryTemplate_Menu)
			return
		end

		if SkuAuras.Types[tSelectTarget.internalName] then
			for i, v in pairs(SkuAuras.attributes[self.parent.internalName].values) do
				dprint("--------    i, v", i , v)
				--local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {v}, menuEntryTemplate_Menu)
				local tAttributeValueEntryName = ""
				if self.internalName == "then" then
					tAttributeValueEntryName = SkuAuras.actions[v].friendlyName
				else
					tAttributeValueEntryName = SkuAuras.values[v].friendlyName
				end
				local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {tAttributeValueEntryName}, menuEntryTemplate_Menu)
				tAttributeValueEntry.internalName = v
				tAttributeValueEntry.dynamic = true
				tAttributeValueEntry.filterable = true
				tAttributeValueEntry.actionOnEnter = true
				tAttributeValueEntry.vocalizeAsIs = true
				tAttributeValueEntry.OnEnter = function(self, aValue, aName)
					dprint("onEnter", self.name)
					tSelectTarget.collectValuesFrom = self
					tSelectTarget.usedAttributes[self.parent.parent.internalName] = true
					self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)		
				end
				tAttributeValueEntry.BuildChildren = function(self)
					dprint("build content of", self.name)
				end
	
			end
		else
			dprint("    empty")
			local tAttributeValueEntry = SkuOptions:InjectMenuItems(self, {L["empty"]}, menuEntryTemplate_Menu)
		end
	end

	return tBuildChildrenFunc
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:BuildManageSubMenu(aParentEntry, aNewEntry)
	local tTypeItem = SkuOptions:InjectMenuItems(aParentEntry, aNewEntry, menuEntryTemplate_Menu)
	tTypeItem.dynamic = true
	tTypeItem.filterable = true
	tTypeItem.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Ein / aus"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Bearbeiten"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
		end
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
		tNewMenuEntry.OnAction = function(self, aValue, aName)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:MenuBuilder(aParentEntry)
	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Auren"}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neu"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			dprint("build content of", self.name)
			for i, v in pairs(SkuAuras.Types) do 
				dprint(" i, v", i, v) 
				local tTypeItem = SkuOptions:InjectMenuItems(self, {v.friendlyName}, menuEntryTemplate_Menu)
				tTypeItem.internalName = i
				tTypeItem.dynamic = true
				tTypeItem.filterable = true
				tTypeItem.isSelect = true
				tTypeItem.collectValuesFrom = self
				tTypeItem.usedAttributes = {}
				setmetatable(tTypeItem.usedAttributes, SkuPrintMTWo)
				tTypeItem.OnAction = function(self, aValue, aName)
					dprint("new OnAction")
					dprint(" ", self, aValue, aName)
					dprint(" ", self.collectValuesFrom)
					if self.collectValuesFrom then
						dprint(" ", self.collectValuesFrom.name)
					end

					local tMenuItem = self.collectValuesFrom
					local tFinalAttributes = {}

					while tMenuItem.internalName ~= self.internalName do
						dprint("---")
						dprint(" self.name", self.name)
						dprint(" tMenuItem.name", tMenuItem.name)
						dprint(" tMenuItem.internalName", tMenuItem.internalName)
						dprint(" tMenuItem.parent.name", tMenuItem.parent.name)
						dprint(" tMenuItem.parent.internalName", tMenuItem.parent.internalName)
						dprint(" tMenuItem.parent.parent.name", tMenuItem.parent.parent.name)
						dprint(" tMenuItem.parent.parent.internalName", tMenuItem.parent.parent.internalName)
						if string.find(tMenuItem.internalName, "output:") then
							table.insert(tFinalAttributes, 1, {tMenuItem.internalName,})
							tMenuItem = tMenuItem.parent
						else
							table.insert(tFinalAttributes, 1, {tMenuItem.parent.parent.internalName, tMenuItem.internalName, tMenuItem.parent.internalName, })
							--tFinalAttributes[#tFinalAttributes + 1] = {tMenuItem.parent.name, tMenuItem.name, }
							tMenuItem = tMenuItem.parent.parent.parent
						end
					end

					SkuAuras:CreateAura(self.internalName, tFinalAttributes)
				end
				tTypeItem.OnEnter = function(self, aValue, aName)
					dprint("onEnter", self.name)
					self.collectValuesFrom = self
					self.usedAttributes = {}
					self.BuildChildren = SkuAuras:NewAuraAttributeBuilder(self)		
				end
				tTypeItem.BuildChildren = function(self)
					dprint("generic build content of", self.name, "this should not happen")
				end

			end		
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neu aus Vorlage"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Verwalten"}, menuEntryTemplate_Menu)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.isSelect = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.OnAction = function(self, aValue, aName)
			dprint("Vewalten OnAction", self, aValue, aName)

		end
		tNewMenuEntry.BuildChildren = function(self)
			for i, v in pairs(SkuOptions.db.profile[MODULE_NAME].Auras) do 
				dprint(" i, v", i, v) 
				local tTypeItem = SkuOptions:InjectMenuItems(self, {"Aktiviert"}, menuEntryTemplate_Menu)
				tTypeItem.dynamic = true
				tTypeItem.filterable = true
				tTypeItem.BuildChildren = function(self)
					if v.enabled == true then
						SkuAuras:BuildManageSubMenu(self, {i})
					end
				end
				local tTypeItem = SkuOptions:InjectMenuItems(self, {"Deaktiviert"}, menuEntryTemplate_Menu)
				tTypeItem.dynamic = true
				tTypeItem.filterable = true
				tTypeItem.BuildChildren = function(self)
					if v.enabled ~= true then
						SkuAuras:BuildManageSubMenu(self, {i})
					end
				end
				local tTypeItem = SkuOptions:InjectMenuItems(self, {"Alle"}, menuEntryTemplate_Menu)
				tTypeItem.dynamic = true
				tTypeItem.filterable = true
				tTypeItem.BuildChildren = function(self)
					SkuAuras:BuildManageSubMenu(self, {i})
				end
			end
		end
	end

	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Zauberdatenbank"}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Eigene"}, menuEntryTemplate_Menu)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Spieler"}, menuEntryTemplate_Menu)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Alle"}, menuEntryTemplate_Menu)
	end

	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Verwalten"}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Import"}, menuEntryTemplate_Menu)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Export"}, menuEntryTemplate_Menu)
	end

	---
	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuAuras.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
	
end
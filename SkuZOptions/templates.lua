local _G = _G

SkuOptions = SkuOptions or LibStub("AceAddon-3.0"):NewAddon("SkuOptions", "AceConsole-3.0", "AceEvent-3.0")
local L = Sku.L

local MENU_MENU = 1
local MENU_DROPDOWN = 2
local MENU_DROPDOWN_MULTI = 3

SkuOptions.MenuMT = {
	__add = function(thisTable, newTable)

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
		local seen = {}
		local tTable = TableCopy(newTable, true, seen)
		table.insert(thisTable, tTable)
		return thisTable
	end,
	__tostring = function(thisTable)
		local tStr = ""
		local function tf(ttable, tTab)
			for k, v in pairs(ttable) do
				if k ~= "parent" and v ~= "parent" and k ~= "prev" and v ~= "prev" and k ~= "next" and v ~= "next"  then
					if type(v) ~= "userdata" and k ~= "frame" and k ~= 0  then
						if type(v) == 'table' then
							print(tTab..k..": tab")
							tf(v, tTab.."  ")
						elseif type(v) == "function" then
							--dprint(tTab..k..": function")
						elseif type(v) == "boolean" then
							print(tTab..k..": "..tostring(v))
						else
							print(tTab..k..": "..v)
						end
					end
				end
			end
		end
		tf(thisTable, "")
	end,
	}

local tPrevErrorUtterance
local tCurrentErrorUtteranceTimerHandle
SkuGenericMenuItem = {
	name = "SkuGenericMenuItem name",
	type = MENU_MENU,
	parent = nil,
	children = {},
	prev = nil,
	next = nil,
	isSelect = false,
	isMultiselect = false,
	selectTarget = nil,
	dynamic = false,
	filterable = false,
	OnUpdate = function(self, aKey)
		C_Timer.After(0.01, function()

			dprint("++ OnUpdate generic")
			local tCurrentItemNumber
			local tCurrentItemName = self.name
			local tParent = self.parent

			if not self.parent then
				return
			end
			if not self.parent.children then
				return
			end

			local tMenuItems = self.parent.children
			for x = 1, #tMenuItems do
				if tMenuItems[x].name == tCurrentItemName then
					tCurrentItemNumber = x
				end
			end

			tCurrentItemNumber = tCurrentItemNumber or 1
			
			self.parent.children = {}
			SkuCore:CheckFrames(nil, true)						
			tParent:BuildChildren(self.parent)

			tParent:OnSelect()
			if self.parent.children[tCurrentItemNumber] then
				SkuOptions.currentMenuPosition = self.parent.children[tCurrentItemNumber]
			elseif self.parent.children[tCurrentItemNumber - 1] then
				SkuOptions.currentMenuPosition = self.parent.children[tCurrentItemNumber - 1]
			else
				SkuOptions.currentMenuPosition = self.parent.children[1]
			end

			SkuOptions.currentMenuPosition:OnEnter()

			if SkuOptions.TTS.MainFrame:IsVisible() ~= true then
				SkuOptions:VocalizeCurrentMenuName()
			end
		end)
	end,
	OnKey = function(self, aKey)
		if SkuOptions.bindingMode == true then
			return
		end
		dprint("OnKey", aKey, SkuOptions.bindingMode)
		SkuOptions.currentMenuPosition:OnLeave(self, value, aValue)

		local tNewMenuItem = nil
		local tMenuItems = nil
		if self.parent.name then
			tMenuItems = self.parent.children
		else
			tMenuItems = self.parent
		end
		
		if SkuOptions.MenuAccessKeysChars[aKey] then
			for x= 1, #tMenuItems do
				if not tNewMenuItem then
					if string.lower(string.sub(tMenuItems[x].name, 1, 1)) == string.lower(aKey) then
						tNewMenuItem = tMenuItems[x]
					end
				end
			end
		elseif SkuOptions.MenuAccessKeysNumbers[aKey] then
			if not tNewMenuItem then
				aKey = tonumber(aKey)
				if tMenuItems[aKey] then
					tNewMenuItem = tMenuItems[aKey]
				end
			end
		end
		if tNewMenuItem then
			SkuOptions.currentMenuPosition = tNewMenuItem
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	BuildChildren = function(self)
		--dprint("BuildChildren generic", self.name)
	end,
	OnPrev = function(self)
		--dprint("OnPrev generic", self.name)
		SkuOptions.currentMenuPosition:OnLeave(self, value, aValue)

		if self.prev then
			SkuOptions.currentMenuPosition = self.prev
		else
			PlaySound(681)
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnNext = function(self)
		--dprint("OnNext generic", self.name)
		SkuOptions.currentMenuPosition:OnLeave(self, value, aValue)

		if self.next then
			SkuOptions.currentMenuPosition = self.next
		else
			PlaySound(681)
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnFirst = function(self)
		--dprint("OnFirst generic", self.name)
		SkuOptions.currentMenuPosition:OnLeave(self, value, aValue)

		if self.parent then
			if self.parent.children then
				SkuOptions.currentMenuPosition = self.parent.children[1]
			else 
				SkuOptions.currentMenuPosition = self.parent[1]
			end
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnBack = function(self)
		--dprint("OnBack generic", self.name, self.parent.name)
		SkuOptions.currentMenuPosition:OnLeave(self, value, aValue)

		if self.parent.name then
			SkuOptions.currentMenuPosition = self.parent
		else
			--dprint("main level > leave nav")
			_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"])
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnAction = function(self, value, aValue)
		--print("OnAction generic", self.name, value.name, value, aValue)
	end,
	OnLeave = function(self, value, aValue)
		--print("OnLeave generic", self.name, value, aValue)
		if tCurrentErrorUtteranceTimerHandle then
			tCurrentErrorUtteranceTimerHandle:Cancel()
		end
	end,
	OnEnter = function(self, value, aValue)
		--print("OnEnter generic", self.name, value, aValue)
		if string.find(self.name, L["error;sound"].."#") then
			for i, v in pairs(SkuCore.Errors.Sounds) do
				if self.name == v then
					C_Timer.After(1.5, function()
						if tPrevErrorUtterance then
							StopSound(tPrevErrorUtterance)
						end
						local willPlay, soundHandle = PlaySoundFile(i, SkuOptions.db.profile.SkuCore.UIErrors.ErrorSoundChannel or "Talking Head")
						if willPlay then
							tPrevErrorUtterance = soundHandle
						end
					end)
				end
			end
		elseif string.find(self.name, L["aura;sound"].."#") then
			for i, v in pairs(SkuAuras.outputs) do
				if self.name == v.friendlyName then
					SkuOptions.Voice:OutputStringBTtts(v.outputString, false, false, 0.3, true)
				end
			end
		elseif string.find(self.name, L["sound"].."#") then
			for i, v in pairs(SkuCore.RangeCheckSounds) do
				if self.name == v then
					C_Timer.After(1.5, function()
						if tPrevErrorUtterance then
							StopSound(tPrevErrorUtterance)
						end
						local willPlay, soundHandle = PlaySoundFile(i, "Talking Head")
						if willPlay then
							tPrevErrorUtterance = soundHandle
						end
					end)
				end
			end
		end

		if SkuCore.inCombat ~= true then
			if self.macrotext then
				--dprint("macrotext", self.macrotext)
				if _G["SecureOnSkuOptionsMainOption1"] then
					_G["SecureOnSkuOptionsMainOption1"]:SetAttribute("type","macro")
					_G["SecureOnSkuOptionsMainOption1"]:SetAttribute("macrotext", self.macrotext)
				end
			else
				if _G["SecureOnSkuOptionsMainOption1"] then
					_G["SecureOnSkuOptionsMainOption1"]:SetAttribute("type","")
					_G["SecureOnSkuOptionsMainOption1"]:SetAttribute("macrotext","")
				end
			end
		end
	end,
	OnSelect = function(self, aEnterFlag)
		--print("OnSelect generic", self.name, aEnterFlag, self.isSelect, self.isMultiselect, self.dynamic)
		local spellID
		local itemID
		local macroID

		local tCollectValuesFrom

		if self.selectTarget then
			spellID = self.selectTarget.spellID
			itemID = self.selectTarget.itemID
			macroID = self.selectTarget.macroID

			tCollectValuesFrom = self.selectTarget.collectValuesFrom
		end

		SkuOptions.Filterstring = ""
		SkuOptions:ApplyFilter(SkuOptions.Filterstring)

		if tCollectValuesFrom then
			self.selectTarget.collectValuesFrom = tCollectValuesFrom
		end


		if self.selectTarget then
			--dprint("   ", self.selectTarget.name)
			self.selectTarget.spellID = spellID
			self.selectTarget.itemID = itemID
			self.selectTarget.macroID = macroID
	
		end

		if string.find(self.name, L["Filter"]..";") then
			return
		end

		if self.name == L["Empty;list"] then
			return
		end

		self:OnPostSelect(aEnterFlag)
	end,
	OnPostSelect = function(self, aEnterFlag)
		--print("++ OnPostSelect generic", self.name, self.actionOnEnter, aEnterFlag, self.isSelect, self.isMultiselect, self.dynamic)
		if self.dynamic == true then
			self.children = {}
			if self.isMultiselect == true then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Nothing selected"]}, SkuGenericMenuItem)
				self.selectTarget = tNewMenuEntry
			end
			if self.isSelect == true then
				self.selectTarget = self
			end

			-- we need to free up the memory of the old children before we're re-building; otherwise we'll leak memory on next BuildChildren
			-- we can't do that for multi select menu items now, as we do need to collect the result from the selected sub items first
			if self.isMultiselect ~= true then
				self.children = {}
				--collectgarbage("collect")
			end

			self:BuildChildren(self)
			if self.selectTarget then
				for x = 1, #self.children do
					self.children[x].selectTarget = self.selectTarget
				end
			end		
		end
		if #self.children > 0 and (self.actionOnEnter ~= true or aEnterFlag ~= true) then
			SkuOptions.currentMenuPosition = self.children[1]
			if self.GetCurrentValue then
				local tGetCurrentValue = self:GetCurrentValue()
				for i, v in pairs(self.children) do
					if v.name == tGetCurrentValue then
						SkuOptions.currentMenuPosition = self.children[i]
					end
				end
			end			
		else
			if self.selectTarget and self.selectTarget ~= self then
				if self.selectTarget.parent.isMultiselect == true then
					if self.selectTarget.name == L["Nothing selected"] and (self.name ~= L["Small"] and self.name ~= L["Large"]) then
						self.selectTarget.name = L["Selected"]..";"..self.name
					else
						if self.name ~= L["Small"] and self.name ~= L["Large"] then
							self.selectTarget.name = self.selectTarget.name..";"..self.name
						end
					end
					SkuOptions.currentMenuPosition = self.selectTarget
				end
				if self.selectTarget.isSelect == true then
					if not string.find(self.name, L["Filter"]..";") then
						local rValue = self.name
						if string.sub(rValue, 1, string.len(L["Selected"]..";")) == L["Selected"]..";" then
							rValue = string.sub(rValue,  string.len(L["Selected"]..";") + 1)
						end

						local tUncleanValue = self.name
						local tCleanValue = self.name
						local tPos = string.find(tUncleanValue, "#")
						local tErrorSoundFound = string.find(tUncleanValue, L["error;sound"].."#")
						if tPos and not tErrorSoundFound then
							tCleanValue = string.sub(tUncleanValue,  tPos + 1)
						end

						self.selectTarget:OnAction(self, tCleanValue, self.parent.name)----------------
						-- we need to free up the memory of the old children before we're re-building on next acces of menu item
						-- now it's safe to do that, as multi select menu items are handled with the above OnAction
						self.children = {}
						--collectgarbage("collect")

						SkuOptions.currentMenuPosition = self.selectTarget
					else
						if SkuOptions.TTS.MainFrame:IsVisible() ~= true then
							SkuOptions:VocalizeCurrentMenuName()
						end
				
					end					
				end
			else
				local rValue = self.name
				local tUncleanValue = self.name
				local tCleanValue = self.name
				local tPos = string.find(tUncleanValue, "#")
				if tPos then
					tCleanValue = string.sub(tUncleanValue,  tPos + 1)
				end
				
				if string.sub(rValue, 1, string.len(L["Selected"]..";")) == L["Selected"]..";" then
					rValue = string.sub(rValue,  string.len(L["Selected"]..";") + 1)
				end
				if #self.children > 0 or self.selectTarget == self then
					self.parent:OnAction(self, tCleanValue, self.parent.name)
				else
					self:OnAction(self, tCleanValue, self.parent.name)------------
				end
				-- we need to free up the memory of the old children before we're re-building on next acces of menu item
				-- now it's safe to do that, as multi select menu items are handled with the above OnAction
				self.children = {}
				--collectgarbage("collect")
				SkuOptions.currentMenuPosition = self.parent
			end			
		end

		if SkuOptions.currentMenuPosition.OnEnter then
			SkuOptions.currentMenuPosition:OnEnter(aEnterFlag)
		end
		--if self.removeFilter then
			--SkuOptions.Filterstring = ""
			--SkuOptions:ApplyFilter(SkuOptions.Filterstring)
		--end
	end,
	}
setmetatable(SkuGenericMenuItem, SkuOptions.MenuMT)

---------------------------------------------------------------------------------------------------------------------------------------
function SkuOptions:BuildMenuSegment_TitleBuilder(aParent, aEntryName)
	local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {aEntryName}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.isMultiselect = true
	tNewMenuEntry.filterable = true

	tNewMenuEntry.BuildChildren = function(self)
		self.parent.oldWpName = SkuOptions.db.profile.SkuNav.selectedWaypoint
		if GetSubZoneText() ~= "" then
			SkuOptions:InjectMenuItems(self, {GetSubZoneText()}, SkuGenericMenuItem)
		end
		if GetSubZoneText() ~= GetZoneText() then
			SkuOptions:InjectMenuItems(self, {GetZoneText()}, SkuGenericMenuItem)
		end
		if UnitName("target") then
			local name, realm = UnitName("target")
			SkuOptions:InjectMenuItems(self, {name}, SkuGenericMenuItem)
		end
		--[[
		if UnitPosition("player") then
			local x, y = UnitPosition("player")
			SkuOptions:InjectMenuItems(self, {string.format("%d", x)..";"..string.format("%d", y)}, SkuGenericMenuItem)
		end
		]]

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Size"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Small"]}, SkuGenericMenuItem)
			tNewMenuEntry.OnEnter = function(self, aValue, aName)
				--dprint("OnEnter Klein", self.name, value, aValue, self.selectTarget.name)
				self.selectTarget.TMPSize = 1
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Large"]}, SkuGenericMenuItem)
			tNewMenuEntry.OnEnter = function(self, aValue, aName)
				--dprint("OnEnter Groß", self.name, value, aValue, self.selectTarget.name)
				self.selectTarget.TMPSize = 5
			end
		end

		if SkuQuest then
			if SkuQuest:GetQuestTitlesList()  then
				if #SkuQuest:GetQuestTitlesList() > 0 then
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Quests"]}, SkuGenericMenuItem)
						tNewMenuEntry.dynamic = true
						tNewMenuEntry.BuildChildren = function(self)
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, SkuQuest:GetQuestTitlesList(), SkuGenericMenuItem)
						end
				end
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["NPC names"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			self.children = {}
			--collectgarbage("collect")
			local tPlayerContintentId = select(3, SkuNav:GetAreaData(SkuNav:GetCurrentAreaId()))
			local tWaypointList = {}
			for i, v in pairs(SkuDB.NpcData.Names[Sku.Loc]) do
				local tHasValidSpawns = false
				if SkuDB.NpcData.Data[i] then
					if not string.find((SkuDB.NpcData.Data[i][1]), "UNUSED") then				
						if SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]] then
							for is, vs in pairs(SkuDB.NpcData.Data[i][SkuDB.NpcData.Keys["spawns"]]) do
								if tHasValidSpawns == false then
									if SkuDB.InternalAreaTable[is] then
										local tCID = SkuDB.InternalAreaTable[is].ContinentID
										local tPID = SkuDB.InternalAreaTable[is].ParentAreaID
										if (tCID == 0 or tCID == 1 or tCID == 530) and (tPID == 0 or tPID == 1 or tPID == 530) and (#vs > 0 ) and (tPlayerContintentId == tCID) then
											tHasValidSpawns = true
										end
									end
								end
							end
						end
					end
				end
				if tHasValidSpawns == true then
					local tRoles = SkuNav:GetNpcRoles(v[1], i)
					local tRolesString = ""
					if #tRoles > 0 then
						for i, v in pairs(tRoles) do
							tRolesString = tRolesString..";"..v
						end
						tRolesString = tRolesString..""
					end
					table.insert(tWaypointList, v[1]..tRolesString)
				end
			end

			if #tWaypointList > 0 then
				local tSortedWaypointList = {}
				for k,v in SkuSpairs(tWaypointList, function(t,a,b) return t[b] > t[a] end) do --nach wert
					table.insert(tSortedWaypointList, v)
				end
				if #tSortedWaypointList > 0 then
					for z = 1, #tSortedWaypointList do
						--dprint(z, tSortedWaypointList[z])
						local tMenuName = tSortedWaypointList[z]
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuName}, SkuGenericMenuItem)
					end
				end
			end
		end

		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Zonen names"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			local tWaypointList = {}
			for q = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]}, SkuGenericMenuItem)
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.filterable = true
				tNewMenuEntry.BuildChildren = function(self)--continents
					for q = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones[self.name] do
						local tNewMenuEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.DefaultWaypoints[Sku.Loc].Zones[self.name][q]}, SkuGenericMenuItem)
					end
				end
			end
		end

		--npc namen, quests von oben noch hinzufügen
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All alphabetically"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.filterable = true
		tNewMenuEntry.BuildChildren = function(self)
			local tFullGlossary = {}
			local tIndex = 1
			for i, v in pairs(SkuOptions.Glossary1[Sku.Loc]) do
				for i1, v1 in pairs(v) do
					tFullGlossary[string.lower(v1)] = string.lower(v1)
					tIndex = tIndex + 1
				end
			end
			for q = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones do
				for w = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]] do
					tFullGlossary[string.lower(SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]][w])] = string.lower(SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]][w])
					tIndex = tIndex + 1
				end
			end

			local tSortedGlossary = {}
			for k,v in SkuSpairs(tFullGlossary) do
				table.insert(tSortedGlossary, k)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, tSortedGlossary, SkuGenericMenuItem)
		end

		for i, v in pairs(SkuOptions.Glossary1[Sku.Loc]) do
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {i}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = function(self)
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, v, SkuGenericMenuItem)
			end
		end

		--SkuOptions:InjectMenuItems(self, {"Ab hier komplette Wortliste"}, SkuGenericMenuItem)
		local tFullGlossary = {}
		local tIndex = 1
		for i, v in pairs(SkuOptions.Glossary1[Sku.Loc]) do
			for i1, v1 in pairs(v) do
				tFullGlossary[string.lower(v1)] = string.lower(v1)
				tIndex = tIndex + 1
			end
		end
		for q = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones do
			for w = 1, #SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]] do
				tFullGlossary[string.lower(SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]][w])] = string.lower(SkuDB.DefaultWaypoints[Sku.Loc].Zones[SkuDB.DefaultWaypoints[Sku.Loc].Zones[q]][w])
				tIndex = tIndex + 1
			end
		end

		local tSortedGlossary = {}
		for k,v in SkuSpairs(tFullGlossary) do
			table.insert(tSortedGlossary, k)
		end	
		local tSubMenu = SkuOptions:InjectMenuItems(self, tSortedGlossary, SkuGenericMenuItem)
		tSubMenu.removeFilter = true
		
	end

	
	return tNewMenuEntry
end

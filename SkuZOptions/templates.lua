local ADDON_NAME = ...
local _G = _G

SkuOptions = SkuOptions or LibStub("AceAddon-3.0"):NewAddon("SkuOptions", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("SkuOptions", false)

local MENU_MENU = 1
local MENU_DROPDOWN = 2
local MENU_DROPDOWN_MULTI = 3

SkuOptions.BindTypeStrings = {
	[0] = "ungebunden",
	[1] = "BOP",
	[2] = "BOE",
	[3] = "BOU",
	[4] = "BOQ",

}

SkuOptions.Glossary1 = {
	["Routen Wörter"] = {
		"Zentralpunkt",
		"Kreuzungspunkt",
		"Startgebiet",
		"Zielgebiet",
		"Questgeber",
		"Questziel",
	},
	["Orte"] = {
		"Anleger",
		"Auktionshaus",
		"Berg",
		"Brunnen",
		"Bank",
		"Gildenbank",
		"Briefkasten",
		"Brücke",
		"Bündelpunkt",
		"Ein- und Ausgang",
		"Fahrstuhl",
		"Farmgebiet",
		"Flugpunkt",
		"Flusslauf",
		"Friedhof",
		"Gabelung",
		"Gasthaus",
		"Gasse",
		"Gebäude",
		"Gegnergebiet",
		"Gewässer",
		"Gruft",
		"Haus",
		"Höhle",
		"Instanzeingang",
		"Kirche",
		"Kreuzung",
		"Klassenlehrer",
		"Lager",
		"Meer",
		"Passage",
		"Pfad",
		"Portal",
		"Questgeber",
		"Questgebiet",
		"Rampe",
		"Reiseroute",
		"Reparieren",
		"Route",
		"Ruhepunkt",
		"Schlucht",
		"Schiff",
		"Schmiede",
		"See",
		"Spawnpunkt",
		"Spot",
		"Stadttor",
		"Stall",
		"Stallmeister",
		"Stammesgebiet",
		"Steg",
		"Strand",
		"Straße",
		"Tal",
		"Tal",
		"Tiertrainer",
		"Tiefenbahn",
		"Trainer",
		"Treffpunkt",
		"Treppe",
		"Treppenhaus",
		"Tunnel",
		"Turm",
		"Tür/Tor",
		"Übergang",
		"Überquerung",
		"Verkaufen",
		"Versammlungsstein",
		"Weg",
		"Wegpunkt",
		"Zelt",
		"Zentralerpunkt",
		"Zeppelin",
		"Scherbenwelt",
		"Nethersturm",
		"Schergrat",
		"Zangarmarschen",
		"Höllenfeuerhalbinsel",
		"Nagrand",
		"Wälder von Terokkar",
		"Schattemondtal",
		"Shattrath",
		"Azurmythosinsel",
		"Blutmythosinsel",
		"Immersangwald",
		"Geisterlande",
	},
	["Bindewörter"] = {
		"auf",
		"bei",
		"bis",
		"da",
		"das",
		"der",
		"die",
		"direkt",
		"dort",
		"durch",
		"ein",
		"einem",
		"hier",
		"hinter",
		"im",
		"im Umkreis",
		"in",
		"in Umgebung",
		"mit",
		"nach",
		"neben",
		"über",
		"umliegend",
		"unter",
		"von",
		"vom",
		"vor",
		"zum",
		"zu",
		"zur",
		"zwischen",
	},
	 ["Orientierung"] = {
		"Richtung",
		"Links",
		"Rechts",
		"Oben",
		"Unten",
		"nördlich",
		"nordöstlich",
		"östlich",
		"südöstlich",
		"südlich",
		"südwestlich",
		"westlich",
		"nordwestlich",
		"drinnen",
		"draußen",
	},
	 ["Klassen"] = {
		"Krieger",
		"Schurke",
		"Druide",
		"Paladin",
		"Schamane",
		"Priester",
		"Hexenmeister",
		"Magier",
		"Jäger",
		"Aldor",
		"Seher",
	},
	 ["Gegnertypen"] = {
		"Boss",
		"Dämonen",
		"Drachkin",
		"Elementar",
		"Elite",
		"Entartung",
		"Humanoid",
		"Mechanisch",
		"Questgegner",
		"Riese",
		"Tier",
		"Untot",
		"Wildtier",
	},
	 ["Berufe"] = {
		"Alchemie",
		"Angeln",
		"Bergbau",
		"Erste Hilfe",
		"Ingeneur",
		"Kochen",
		"Kräuterkunde",
		"Kürschnerei",
		"Lederverarbeitung",
		"Schmied",
		"Schneiderei",
		"Spezialisierung",
		"Verzauberkunst",
	},
	 ["Tätigkeiten"] = {
		"Farmen",
		"Grinden",
		"Questen",
		"Reisen",
	},
	["Spezial"] = {
		"achtung",
		"Allianz",
		"Bel",
		"geheim",
		"gut zugänglich",
		"Horde",
		"Klassenquest",
		"Level",
		"privat",
		"PVE",
		"PVP",
		"Quest",
		"schlecht zugänglich",
		"Sku",
		"Stufe",
		"Versuch",
		"vorsichtig",
		"Wichtig",
	},
	["Maßeinheiten"] = {
		"Meter",
		"Einheiten",
	},
	["Farben"] = {
		"Blau",
		"Braun",
		"Gelb",
		"Grau",
		"Grün",
		"Orange",
		"Rot",
		"Schwarz",
	},
	["Zahlen"] = {
		"Eins",
		"Zwei",
		"Drei",
		"Vier",
		"Fünf",
		"Sechs",
		"Sieben",
		"Acht",
		"Neun",
		"Zehn",
	},
}


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
							--print(tTab..k..": function")
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

menuEntryTemplate_Menu = {
	name = "menuEntryTemplate_Menu name",
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
	OnKey = function(self, aKey)
		--print("OnKey", aKey)
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
		--print("BuildChildren generic", self.name)
	end,
	OnPrev = function(self)
		--print("OnPrev generic", self.name)
		if self.prev then
			SkuOptions.currentMenuPosition = self.prev
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnNext = function(self)
		--print("OnNext generic", self.name)
		if self.next then
			SkuOptions.currentMenuPosition = self.next
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnFirst = function(self)
		--print("OnFirst generic", self.name)
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
		--print("OnBack generic", self.name, self.parent.name)
		if self.parent.name then
			SkuOptions.currentMenuPosition = self.parent
		else
			--print("main level > leave nav")
			_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"])
		end
		SkuOptions.currentMenuPosition:OnEnter()
	end,
	OnAction = function(self, value, aValue)
		--print("OnAction generic", self.name, value.name, value, aValue)
	end,
	OnLeave = function(self, value, aValue)

	end,
	OnEnter = function(self, value, aValue)
		--print("OnEnter generic", self.name, value, aValue)
		if self.macrotext then
			--print("macrotext", self.macrotext)
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
	end,
	OnSelect = function(self)
		--print("OnSelect generic", self.name, self.isSelect, self.isMultiselect, self.dynamic)
		local spellID
		local itemID
		local macroID
		if self.selectTarget then
			spellID = self.selectTarget.spellID
			itemID = self.selectTarget.itemID
			macroID = self.selectTarget.macroID
		end

		SkuOptions.Filterstring = ""
		SkuOptions:ApplyFilter(SkuOptions.Filterstring)

	if self.selectTarget then
			--print("   ", self.selectTarget.name)
			self.selectTarget.spellID = spellID
			self.selectTarget.itemID = itemID
			self.selectTarget.macroID = macroID
	
		end
		if string.find(self.name, "Filter;") then
			return
		end

		if self.name == "liste;leer" then
			return
		end

		self:OnPostSelect(self)
	end,
	OnPostSelect = function(self)
		--print("OnPostSelect generic", self.name, self.isSelect, self.isMultiselect, self.dynamic)
		if self.dynamic == true then
			self.children = {}
			if self.isMultiselect == true then
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Keine Auswahl"}, menuEntryTemplate_Menu)
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
		if #self.children > 0 then
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
					if self.selectTarget.name == "Keine Auswahl" and (self.name ~= "Klein" and self.name ~= "Groß") then
						self.selectTarget.name = "Auswahl;"..self.name
					else
						if self.name ~= "Klein" and self.name ~= "Groß" then
							self.selectTarget.name = self.selectTarget.name..";"..self.name
						end
					end
					SkuOptions.currentMenuPosition = self.selectTarget
				end
				if self.selectTarget.isSelect == true then
					if not string.find(self.name, "Filter;") then
						local rValue = self.name
						if string.sub(rValue, 1, string.len("Auswahl;")) == "Auswahl;" then
							rValue = string.sub(rValue,  string.len("Auswahl;") + 1)
						end

						local tUncleanValue = self.name
						local tCleanValue = self.name
						local tPos = string.find(tUncleanValue, "#")
						if tPos then
							tCleanValue = string.sub(tUncleanValue,  tPos + 1)
						end

						self.selectTarget:OnAction(self, tCleanValue, self.parent.name)----------------
						-- we need to free up the memory of the old children before we're re-building on next acces of menu item
						-- now it's safe to do that, as multi select menu items are handled with the above OnAction
						self.children = {}
						--collectgarbage("collect")

						SkuOptions.currentMenuPosition = self.selectTarget
					else
						SkuOptions:VocalizeCurrentMenuName()
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
				
				if string.sub(rValue, 1, string.len("Auswahl;")) == "Auswahl;" then
					rValue = string.sub(rValue,  string.len("Auswahl;") + 1)
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

		SkuOptions.currentMenuPosition:OnEnter()
		--if self.removeFilter then
			--SkuOptions.Filterstring = ""
			--SkuOptions:ApplyFilter(SkuOptions.Filterstring)
		--end
end,
}
setmetatable(menuEntryTemplate_Menu, SkuOptions.MenuMT)

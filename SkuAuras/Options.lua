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
function SkuAuras:MenuBuilder(aParentEntry)

	---
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Auren"}, menuEntryTemplate_Menu)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.filterable = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Neu"}, menuEntryTemplate_Menu)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Bearbeiten"}, menuEntryTemplate_Menu)
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {"Löschen"}, menuEntryTemplate_Menu)
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
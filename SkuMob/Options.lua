local MODULE_NAME = "SkuMob"
local L = Sku.L

SkuMob.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		vocalizeRaidTargetOnly = {
			name = L["Only raid icon for targets with icon"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].vocalizeRaidTargetOnly = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].vocalizeRaidTargetOnly
			end
		},
		vocalizePlayerNamePlaceholders  = {
			name = L["Announce friendly and hostile players"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholders  = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholders 
			end
		},		
		vocalizePlayerNamePlaceholdersSkuTts = {
			name = L["Announce player controled units with generic descriptions"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].vocalizePlayerNamePlaceholdersSkuTts
			end
		},
		repeatRaidTargetMarkers = {
			name = L["Repeat raid target markers on units"],
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].repeatRaidTargetMarkers = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].repeatRaidTargetMarkers
			end
		},

	}
}
---------------------------------------------------------------------------------------------------------------------------------------
SkuMob.defaults = {
	enable = true,
	vocalizeRaidTargetOnly = false,
	vocalizePlayerNamePlaceholders = true,
	vocalizePlayerNamePlaceholdersSkuTts = false,
	repeatRaidTargetMarkers = false,
}
---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:MenuBuilder(aParentEntry)
	--dprint("SkuMob:MenuBuilder", aParentEntry)
	local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Target menu"]}, SkuGenericMenuItem)
	if _G["TargetFrame"] then
		tNewSubMenuEntry.macrotext = "/click TargetFrame RightButton\r\n/script SkuCore:CheckFrames() C_Timer.After(0.8, function() _G[\"DropDownList1\"]:GetScript(\"OnEnter\")(_G[\"DropDownList1\"]) end)"
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuMob.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
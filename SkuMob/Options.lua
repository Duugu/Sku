local MODULE_NAME = "SkuMob"
SkuMob.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		enable = {
			name = "Modul aktiviert" ,
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].enable = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].enable
			end
		},
		vocalizeRaidTargetOnly = {
			name = "Bei markierten Zielen nur Markierung ansagen" ,
			desc = "",
			type = "toggle",
			set = function(info, val) 
				SkuOptions.db.profile[MODULE_NAME].vocalizeRaidTargetOnly = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].vocalizeRaidTargetOnly
			end
		},
	}
}
---------------------------------------------------------------------------------------------------------------------------------------
SkuMob.defaults = {
	enable = true,
	vocalizeRaidTargetOnly = false,
}
---------------------------------------------------------------------------------------------------------------------------------------
function SkuMob:MenuBuilder(aParentEntry)
	--print("SkuMob:MenuBuilder", aParentEntry)
	local tNewSubMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {"Ziel Menü"}, menuEntryTemplate_Menu)
	if _G["TargetFrame"] then
		tNewSubMenuEntry.macrotext = "/click TargetFrame RightButton\r\n/script SkuCore:CheckFrames() C_Timer.After(0.8, function() _G[\"DropDownList1\"]:GetScript(\"OnEnter\")(_G[\"DropDownList1\"]) end)"
	end

	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {"Optionen"}, menuEntryTemplate_Menu)
	SkuOptions:IterateOptionsArgs(SkuMob.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end
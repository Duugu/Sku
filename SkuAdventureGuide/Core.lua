local MODULE_NAME = "SkuAdventureGuide"
local _G = _G
local L = Sku.L

SkuAdventureGuide = LibStub("AceAddon-3.0"):NewAddon("SkuAdventureGuide", "AceConsole-3.0", "AceEvent-3.0")

local slower = string.lower

SkuAdventureGuide.linkHistory = {}

SkuAdventureGuide.tooltipLinksIndicatorValues = {
   ["sound"] = L["sound"],
   ["word"] = L["word"],
}

SkuAdventureGuide.HistoryNotifySounds = {
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["sound"].."#"..L["brang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["sound"].."#"..L["bring"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["sound"].."#"..L["dang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["sound"].."#"..L["drmm"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["sound"].."#"..L["shhhup"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["sound"].."#"..L["spoing"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["sound"].."#"..L["swoosh"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["sound"].."#"..L["tsching"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["sound"].."#"..L["silent"],
	["sound-brass1"] = L["aura;sound"].."#"..L["brass 1"],
   ["sound-brass2"] = L["aura;sound"].."#"..L["brass 2"],
   ["sound-brass3"] = L["aura;sound"].."#"..L["brass 3"],
   ["sound-brass4"] = L["aura;sound"].."#"..L["brass 4"],
   ["sound-brass5"] = L["aura;sound"].."#"..L["brass 5"],
   ["sound-error_brang"] = L["aura;sound"].."#"..L["brang"],
   ["sound-error_bring"] = L["aura;sound"].."#"..L["bring"],
   ["sound-error_dang"] = L["aura;sound"].."#"..L["dang"],
   ["sound-error_drmm"] = L["aura;sound"].."#"..L["drmm"],
   ["sound-error_shhhup"] = L["aura;sound"].."#"..L["shhhup"],
   ["sound-error_spoing"] = L["aura;sound"].."#"..L["spoing"],
   ["sound-error_swoosh"] = L["aura;sound"].."#"..L["swoosh"],
   ["sound-error_tsching"] = L["aura;sound"].."#"..L["tsching"],
   ["sound-glass1"] = L["aura;sound"].."#"..L["glass 1"],
   ["sound-glass2"] = L["aura;sound"].."#"..L["glass 2"],
   ["sound-glass3"] = L["aura;sound"].."#"..L["glass 3"],
   ["sound-glass4"] = L["aura;sound"].."#"..L["glass 4"],
   ["sound-glass5"] = L["aura;sound"].."#"..L["glass 5"],
   ["sound-waterdrop1"] = L["aura;sound"].."#"..L["waterdrop 1"],
   ["sound-waterdrop2"] = L["aura;sound"].."#"..L["waterdrop 2"],
   ["sound-waterdrop3"] = L["aura;sound"].."#"..L["waterdrop 3"],
   ["sound-waterdrop4"] = L["aura;sound"].."#"..L["waterdrop 4"],
   ["sound-waterdrop5"] = L["aura;sound"].."#"..L["waterdrop 5"],
   ["sound-notification1"] = L["aura;sound"].."#"..L["notification"].." 1",
   ["sound-notification2"] = L["aura;sound"].."#"..L["notification"].." 2",
   ["sound-notification3"] = L["aura;sound"].."#"..L["notification"].." 3",
   ["sound-notification4"] = L["aura;sound"].."#"..L["notification"].." 4",
   ["sound-notification5"] = L["aura;sound"].."#"..L["notification"].." 5",
   ["sound-notification6"] = L["aura;sound"].."#"..L["notification"].." 6",
   ["sound-notification7"] = L["aura;sound"].."#"..L["notification"].." 7",
   ["sound-notification8"] = L["aura;sound"].."#"..L["notification"].." 8",
   ["sound-notification9"] = L["aura;sound"].."#"..L["notification"].." 9",
   ["sound-notification10"] = L["aura;sound"].."#"..L["notification"].." 10",
   ["sound-notification11"] = L["aura;sound"].."#"..L["notification"].." 11",
   ["sound-notification12"] = L["aura;sound"].."#"..L["notification"].." 12",
   ["sound-notification13"] = L["aura;sound"].."#"..L["notification"].." 13",
   ["sound-notification14"] = L["aura;sound"].."#"..L["notification"].." 14",
   ["sound-notification15"] = L["aura;sound"].."#"..L["notification"].." 15",
   ["sound-notification16"] = L["aura;sound"].."#"..L["notification"].." 16",
   ["sound-notification17"] = L["aura;sound"].."#"..L["notification"].." 17",
   ["sound-notification18"] = L["aura;sound"].."#"..L["notification"].." 18",
   ["sound-notification19"] = L["aura;sound"].."#"..L["notification"].." 19",
   ["sound-notification20"] = L["aura;sound"].."#"..L["notification"].." 20",
   ["sound-notification21"] = L["aura;sound"].."#"..L["notification"].." 21",
   ["sound-notification22"] = L["aura;sound"].."#"..L["notification"].." 22",
   ["sound-notification23"] = L["aura;sound"].."#"..L["notification"].." 23",
   ["sound-notification24"] = L["aura;sound"].."#"..L["notification"].." 24",
   ["sound-notification25"] = L["aura;sound"].."#"..L["notification"].." 25",
   ["sound-notification26"] = L["aura;sound"].."#"..L["notification"].." 26",
   ["sound-notification27"] = L["aura;sound"].."#"..L["notification"].." 27",	

}
---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:OnInitialize()
	SkuAdventureGuide:RegisterEvent("PLAYER_LOGIN")
	SkuAdventureGuide:RegisterEvent("PLAYER_ENTERING_WORLD")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:OnEnable()

end	

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:OnDisable()
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:PLAYER_LOGIN(...)
	SkuOptions.db.global[MODULE_NAME] = SkuOptions.db.global[MODULE_NAME] or {}
	SkuOptions.db.global[MODULE_NAME].seenLinksHistory = SkuOptions.db.global[MODULE_NAME].seenLinksHistory or {}

	--we're building an additional lookup table that is sorted by link lenght; we will need that for efficient free text search
	local tSortedLookup = {}
	local tLenMax = 0
	for i, v in pairs(SkuDB.Wiki[Sku.Loc].lookup) do
		if string.len(i) > 0 then
			if not tSortedLookup[string.len(i)] then
				tSortedLookup[string.len(i)] = {}
			end
			tSortedLookup[string.len(i)][i] = v
			if string.len(i) > tLenMax then
				tLenMax = string.len(i)
			end
		end
	end

	SkuDB.Wiki[Sku.Loc].lookupLen = {}
	for x = tLenMax, 1, -1 do
		if tSortedLookup[x] then
			for i, v in pairs(tSortedLookup[x]) do
				SkuDB.Wiki[Sku.Loc].lookupLen[#SkuDB.Wiki[Sku.Loc].lookupLen + 1] = i
			end
		end
	end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...

end

---------------------------------------------------------------------------------------------------------------------------------------
local tSkuAdventureGuideOutputBlocker = false
function SkuAdventureGuide:AddLinkToHistory(aLinkName)
	--don't do this for the adv. menus
	if SkuOptions.currentMenuPosition then
		if SkuOptions.currentMenuPosition.parent then
			if (SkuOptions.currentMenuPosition.parent.name == L["History"] or SkuOptions.currentMenuPosition.parent.name == L["All entries"]) and SkuOptions.TTS:IsVisible() ~= true then
				return
			end
		end
	end

	local tLinkNameLower = slower(aLinkName)
	--remove existing
	for x = 1, #SkuAdventureGuide.linkHistory do
		if slower(SkuAdventureGuide.linkHistory[x]) == tLinkNameLower then
			table.remove(SkuAdventureGuide.linkHistory, x)
			break
		end
	end

	table.insert(SkuAdventureGuide.linkHistory, aLinkName)

	--remove oldest if more than 100 in list
	if #SkuAdventureGuide.linkHistory - 100 > 0 then
		table.remove(SkuAdventureGuide.linkHistory, 1)
	end

	--play link notification if this account hasn't seen this link
	if not SkuOptions.db.global[MODULE_NAME].seenLinksHistory[tLinkNameLower] or SkuOptions.db.profile["SkuAdventureGuide"].history.ignoreSeenLinks == false then
		SkuOptions.db.global[MODULE_NAME].seenLinksHistory[tLinkNameLower] = true
		if SkuOptions.TTS:IsVisible() ~= true then
			if tSkuAdventureGuideOutputBlocker == false then
				tSkuAdventureGuideOutputBlocker = true
				SkuAdventureGuide:PlaySound(SkuAdventureGuide.HistoryNotifySounds[SkuOptions.db.profile["SkuAdventureGuide"].history.soundOnNewLinkInHistory])
				C_Timer.After(0.1, function() 
					tSkuAdventureGuideOutputBlocker = false 
				end)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:PlaySound(aSoundName)
	for i, v in pairs(SkuAdventureGuide.HistoryNotifySounds) do
		if aSoundName == v then
			if string.find(aSoundName, L["aura;sound"].."#") then
				SkuOptions.Voice:OutputStringBTtts(i, false, false, 0.3, true, nil, nil, nil, nil, nil, nil, nil, true)
			else
				PlaySoundFile(i, "Talking Head")
			end
		end
	end
end
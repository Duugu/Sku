---@diagnostic disable: undefined-field, undefined-doc-name, undefined-doc-param

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "Sku"
local ADDON_NAME = ...

Sku = {}
Sku.L = LibStub("AceLocale-3.0"):GetLocale("Sku", false)
Sku.Loc = Sku.L["locale"]
Sku.Locs = {"enUS", "deDE",}

Sku.LocsPartly = {["deDE"] = true, ["enUS"] = true, ["zhCN"] = true, ["ruRU"] = true,}
Sku.LocP = GetLocale()
if not Sku.LocsPartly[GetLocale()] then
	Sku.LocP = "enUS"
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.AudiodataPath = ""
if Sku.Loc == "deDE" then
	Sku.AudiodataPath = "SkuAudioData"
elseif Sku.Loc == "enUS" or Sku.Loc == "enGB" or Sku.Loc == "enAU" then
	Sku.AudiodataPath = "SkuAudioData_en"
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.testMode = false

---------------------------------------------------------------------------------------------------------------------------------------
-- tmp fixes for 30401 ptr
Sku.toc = select(4, GetBuildInfo())
if Sku.toc >= 30401 then
	PickupContainerItem = C_Container.PickupContainerItem
	GetContainerNumSlots = C_Container.GetContainerNumSlots
	GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
	UseContainerItem = C_Container.UseContainerItem
	GetContainerItemID = C_Container.GetContainerItemID
	GetItemCooldown = C_Container.GetItemCooldown
	GetContainerItemQuestInfo = function(bag, slot)
		local t = C_Container.GetContainerItemQuestInfo(bag, slot)
		return t.isQuestItem
	end
	GetContainerItemInfo = function(bag, slot)
		slot = slot or 0
		local t = C_Container.GetContainerItemInfo(bag, slot)
		if not t then
			return
		end		
		return t.iconFileID, t.stackCount, t.isLocked, t.quality, t.isReadable, t.hasLoot, t.hyperlink, t.isFiltered, t.hasNoValue, t.itemID, t.isBound
	end
	SocketContainerItem = C_Container.SocketContainerItem
	SplitContainerItem = C_Container.SplitContainerItem
	GetContainerItemLink = C_Container.GetContainerItemLink
	GetContainerItemCooldown = C_Container.GetContainerItemCooldown

	SetTracking = C_Minimap.SetTracking
	GetTrackingInfo = C_Minimap.GetTrackingInfo
	GetNumTrackingTypes = C_Minimap.GetNumTrackingTypes
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.metric = {}
debugprofilestart()
function Sku:MetricPoint(aText)
	Sku.metric[#Sku.metric + 1] = {aText, debugprofilestop()/1000}
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.debug = false
function dprint(...)
	if Sku.debug == true then
		print(...)
	end
end
---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local _G = _G
local L = Sku.L

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")

--todo: move import/export stuff from skuoptions to this file











-------------------------------------------------------------------------
-- tmp helpers, to delete after migration
-------------------------------------------------------------------------
function tConvert()
	SkuOptions.db.global[MODULE_NAME].LinksNew = {}
	for tSourceWpName, tSourceWpLinks in pairs(tSkuLinks) do
		local tSourceIndex = WaypointCacheLookupAll[tSourceWpName]
		
		local tSourceId

		if tSourceIndex then
			tSourceId = SkuNav:BuildWpIdFromData(WaypointCache[tSourceIndex].typeId, WaypointCache[tSourceIndex].dbIndex, WaypointCache[tSourceIndex].spawn, WaypointCache[tSourceIndex].areaId)
		end

		--print(tSourceIndex, tSourceWpName, tSourceWpLinks)

		SkuOptions.db.global[MODULE_NAME].LinksNew[tSourceId] = {}

		for tTargetWpName, tTargetWpDistance in pairs(tSourceWpLinks) do
			local tTaregtIndex = WaypointCacheLookupAll[tTargetWpName]

			local tTargetId
			if tTaregtIndex then		
				tTargetId = SkuNav:BuildWpIdFromData(WaypointCache[tTaregtIndex].typeId, WaypointCache[tTaregtIndex].dbIndex, WaypointCache[tTaregtIndex].spawn, WaypointCache[tTaregtIndex].areaId)	
				--print("  ", tTargetId, tTaregtIndex, tTargetWpName, tTargetWpDistance)
				SkuOptions.db.global[MODULE_NAME].LinksNew[tSourceId][tTargetId] = tTargetWpDistance
			end
		end


	end

end

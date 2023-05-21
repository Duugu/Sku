local MODULE_NAME = "SkuNav"
local L = Sku.L

---------------------------------------------------------------------------------------------------------------------------------------
-- Dictionary mapping waypoint ids to last time they were visited or nil if unvisited
local waypointVisitedDict = {}
-- string -> nil
function SkuNav:setWaypointVisited(wpName)
	if not SkuOptions.db.profile[MODULE_NAME].trackVisited then return end
	local wp = SkuNav:GetWaypointData2(wpName)
	if wp then
		--[[
		Duugu: removed the full check for waypoints the player could be "interested" in for farming, 
		because there are mobs in Northend who have subtexts, etc. The check wasn't working reliable anymore. 
		Visited is now active for all waypoints. Imho doesn't hurt to have "visited" before npc waypoints like the flight master.
		]]
		waypointVisitedDict[wpName] = GetServerTime()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
-- string -> boolean
function SkuNav:waypointWasVisited(wpName)
	if not SkuOptions.db.profile[MODULE_NAME].trackVisited then return false end
	local lastVisited = waypointVisitedDict[wpName]
	if lastVisited == nil then return false end
	local timeToExpire = (SkuOptions.db.profile[MODULE_NAME].timeForVisitedToExpire - 1) * 60
	-- 0 = refresh disabled
	if timeToExpire == 0 then return true end
	if GetServerTime() - lastVisited > timeToExpire then
		-- visited status has expired
		waypointVisitedDict[wpName] = nil
		return false
	else return true end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuNav:clearVisitedWaypoints()
	waypointVisitedDict = {}
end

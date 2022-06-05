local MODULE_NAME = "SkuNav"
local L = Sku.L

---------------------------------------------------------------------------------------------------------------------------------------
-- Dictionary mapping waypoint ids to last time they were visited or nil if unvisited
local waypointVisitedDict = {}
-- string -> nil
function SkuNav:setWaypointVisited(wpName)
	if not SkuOptions.db.profile[MODULE_NAME].trackVisited then return end
	-- only track visited for things players would be interested in farming, like hostile NPCs and objects
	-- assuming if NPC has no role, then hostile, but some friendly NPCs also don't have a role, like guards
	-- could identify hostile creatures accurately if had access to "friendlyMask", but in SkuDB.NpcData only have access to "hostileMask" (as "factionID")
	-- reference: https://github.com/cmangos/issues/wiki/FactionTemplate.dbc
	-- Duugu: That reference is from a p-server implementation and isn't reliable. We shouldn't use any data from there.
	local wp = SkuNav:GetWaypointData2(wpName)
	if wp and (
		-- is object
		wp.typeId == 3
			-- is hostile NPC
			-- assume custom(1) is NPC, since false negatives are bigger problem than false positives
			or ((wp.typeId == 2 or wp.typeId == 1) and wp.role == "")
		) then
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

-- ======================================================================
-- Copyright (c) 2012 RapidFire Studio Limited 
-- All Rights Reserved. 
-- http://www.rapidfirestudio.com

-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:

-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-- ======================================================================

----------------------------------------------------------------
-- local variables
----------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local _G = _G
local L = Sku.L

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")


local INF = 1/0
local cachedPaths = nil

local mpow = math.pow
local msqrt = math.sqrt

----------------------------------------------------------------
-- local functions
----------------------------------------------------------------
local function dist(x1, y1, x2, y2)
	return (msqrt(mpow(x2 - x1, 2) + mpow(y2 - y1, 2)))
end

----------------------------------------------------------------
local function dist_between(nodeA, nodeB)
	return dist(nodeA.worldX, nodeA.worldY, nodeB.worldX, nodeB.worldY)
end

----------------------------------------------------------------
local function heuristic_cost_estimate(nodeA, nodeB)
	return dist(nodeA.worldX, nodeA.worldY, nodeB.worldX, nodeB.worldY)
end

----------------------------------------------------------------
local function is_valid_node(node, neighbor)
	return true
end

----------------------------------------------------------------
local function lowest_f_score(set, f_score)
	local lowest, bestNode = INF, nil
	for _, node in pairs(set) do
		local score = f_score[node]
		if score < lowest then
			lowest, bestNode = score, node
		end
	end
	return bestNode
end

----------------------------------------------------------------
local function neighbor_nodes(theNode, nodes)
	local neighbors = {}
   for i, v in pairs(theNode.links.byId) do
      --print("    i,v",i,v, tCnodes[i])
      table.insert(neighbors, nodes[i])
   end
	return neighbors
end

----------------------------------------------------------------
local function not_in(set, theNode)
	for _, node in pairs(set) do
		if node == theNode then return false end
	end
	return true
end

----------------------------------------------------------------
local function remove_node(set, theNode)
	for i, node in pairs(set) do
		if node == theNode then 
			set[i] = set[#set]
			set[#set] = nil
			break
		end
	end	
end

----------------------------------------------------------------
local function unwind_path(flat_path, map, current_node)
	if map[current_node] then
		table.insert(flat_path, 1, map[current_node]) 
		return unwind_path(flat_path, map, map[current_node])
	else
		return flat_path
	end
end

----------------------------------------------------------------
-- pathfinding functions
----------------------------------------------------------------
local function a_star(start, goal, nodes, valid_node_func)
	local closedset = {}
	local openset = {start}
	local came_from = {}

	if valid_node_func then is_valid_node = valid_node_func end

	local g_score, f_score = {}, {}
	g_score[start] = 0
	f_score[start] = g_score[start] + heuristic_cost_estimate(start, goal)

	while #openset > 0 do
		local current = lowest_f_score(openset, f_score)
		if current == goal then
			local path = unwind_path({}, came_from, goal)
			table.insert(path, goal)
			return path
		end
		remove_node(openset, current)		
		table.insert(closedset, current)
		local neighbors = neighbor_nodes(current, nodes)
		for _, neighbor in pairs(neighbors) do 
			if not_in(closedset, neighbor) then
				local tentative_g_score = g_score[current] + dist_between(current, neighbor)
				if not_in(openset, neighbor) or tentative_g_score < g_score[neighbor] then 
					came_from[ neighbor] = current
					g_score[ neighbor] = tentative_g_score
					f_score[ neighbor] = g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)
					if not_in(openset, neighbor) then
						table.insert(openset, neighbor)
					end
				end
			end
		end
	end
	return nil -- no valid path
end

----------------------------------------------------------------
-- exposed functions
----------------------------------------------------------------
function SkuNav:clear_cached_paths()
	cachedPaths = nil
end

----------------------------------------------------------------
function SkuNav:distance(x1, y1, x2, y2)
	return dist(x1, y1, x2, y2)
end

----------------------------------------------------------------
function SkuNav:path(start, goal, nodes, ignore_cache, valid_node_func)
	if not cachedPaths then cachedPaths = {} end
	if not cachedPaths[start] then
		cachedPaths[start] = {}
	elseif cachedPaths[start][goal] and not ignore_cache then
		return cachedPaths[start][goal]
	end

   local resPath = a_star(start, goal, nodes, valid_node_func)
   if not cachedPaths[start][goal] and not ignore_cache then
      cachedPaths[start][goal] = resPath
   end

	return resPath
end



--[[
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
test
/script SkuNav:astartest("auto;1639764098346369120642", "Zwerggezeitenkriecher;Dunkelküste;1;37.42;40.32")
/script SkuNav:astartest("auto;163976408434623700608", "Zwerggezeitenkriecher;Dunkelküste;1;37.42;40.32")

/script SkuNav:astartest("auto;1639764098346369120642", "Dran Droffers;Droffers und Sohn Bergungen;Orgrimmar;1;59.49;36.57")
/script SkuNav:astartest("auto;1639764098346369120642", "Koma;Bankier;Orgrimmar;1;50;68.58")

holy crap, astar is slow as shit :(
results are more than disappointing

]]
local tcount = 0
------------------------------------------------------------------------------------------------------------------------
-- this function determines which neighbors are valid (e.g., within range)
local valid_node_func = function (node, neighbor) 
	tcount = tcount+ 1
	if node.links.byId[WaypointCacheLookupAll[neighbor.name]] then
		--print("true", neighbor.name)
		return true
	end
	return false
end

--/script SkuNav:astartest("auto;1639764098346369120642", "Zwerggezeitenkriecher;Dunkelküste;1;37.42;40.32")
--/dump WaypointCache[WaypointCacheLookupAll["auto;1639764098346369120642"]]
function SkuNav:astartest(aStartWpName, aEndWpName)
	local startWaypointCacheId = WaypointCacheLookupAll[aStartWpName]
	local startWpNameData = WaypointCache[startWaypointCacheId]
	print("from ", startWpNameData.contintentId, startWaypointCacheId)
	local endWaypointCacheId = WaypointCacheLookupAll[aEndWpName]
	local endWpNameData = WaypointCache[endWaypointCacheId]
	print("to ", endWaypointCacheId)

	local tCnodes = {}
	for i, v in pairs(WaypointCacheLookupPerContintent[startWpNameData.contintentId]) do
		tCnodes[i] = WaypointCache[i]
	end

	local ignore --= true -- ignore cached paths
	ttpath = SkuNav:path(startWpNameData, endWpNameData, tCnodes, ignore, valid_node_func)
	
	if ttpath then
		print("found path")
		for i,v in pairs(ttpath) do
			print(i,v,v.name)
		end
	end
	print(tcount)
	
end






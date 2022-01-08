local MODULE_NAME = "SkuOptions"
local L = Sku.L
local _G = _G

---------------------------------------------------------------------------------------------------------------------------------------
function SkuSpairs(t, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, function(a,b) return order(t, a, b) end)
	else
		table.sort(keys)
	end
	local i = 0
	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param tbl table
---@param indent string
local function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		local formatting = string.rep("  ", indent)..k..": "
		if k == 'obj' then
			if v ~= nil then
				print(formatting.."<obj>")
			else
				print(formatting.."nil")
			end
		elseif k == 'func' then
			if v ~= nil then
				print(formatting.."<func>")
			else
				print(formatting.."nil")
			end
		elseif k == 'onActionFunc' then
			if v ~= nil then
				print(formatting.."<onActionFunc>")
			else
				print(formatting.."nil")
			end
		else
			if type(v) == "table" then
				print(formatting)
				tprint(v, indent+1)
			elseif type(v) == 'boolean' then
				print(formatting..tostring(v))      
			elseif type(v) == 'string' then
				print(formatting..string.gsub(v, "\r\n", " "))
			else
				print(formatting..v)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
--elevator timer test
function GetElTime()
	local guid    = UnitGUID("target")
	--local guid    = "Creature-0-4468-530-15-18922-0004A6D8E1"

	if not guid then
		return
  end

	local prefix  = string.match(guid, "^([CVP][^l][^-]+)")

	if not prefix then
		 return
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff)
		 --local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3)
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23)
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1)
		 end

		 --local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime)
		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 dprint("noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667))
		 
	end
end

function GTT_CreatureInspect(self)
	local _, unit = self:GetUnit();
	local guid    = UnitGUID(unit or "none");
	local prefix  = string.match(guid, "^([CVP][^l][^-]+)");

	if not guid or not prefix then
		 return;
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff);
		 local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3);
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23);
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset;

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1);
		 end

		 local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Date/Time", guidSpawnDate, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Time Data", string.format("%.6X", guidSpawnTime), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index Data", string.format("%.5X", guidSpawnIndex), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnOffset", guidSpawnOffset, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "serverSpawnEpoch", serverSpawnEpoch, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnTime", guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, GetServerTime(), (GetServerTime() % 2^23), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "curr time", GetServerTime() - guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);

		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 GameTooltip_AddColoredDoubleLine(self, "noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667) - 10, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 

		 
		 
	elseif prefix == "Pet" then
		 local guidPetUID     = string.sub(guid, -8);
		 local guidSpawnIndex = tonumber(string.sub(guid, -10, -9), 16);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Pet UID", guidPetUID, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index", guidSpawnIndex, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
	end
end

if not GTT_CreatureInspectHooked then
	GTT_CreatureInspectHooked = true;
	--GameTooltip:HookScript("OnTooltipSetUnit", function(...) return GTT_CreatureInspect(...); end);
end
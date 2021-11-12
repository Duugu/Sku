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
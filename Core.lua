---@diagnostic disable: undefined-field, undefined-doc-name, undefined-doc-param

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "Sku"
local ADDON_NAME = ...

Sku = {}
Sku.L = LibStub("AceLocale-3.0"):GetLocale("Sku", false)

---------------------------------------------------------------------------------------------------------------------------------------
Sku.debug = false
function dprint(...)
	if Sku.debug == true then
		print(...)
	end
end

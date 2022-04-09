---@diagnostic disable: undefined-field, undefined-doc-name, undefined-doc-param

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "Sku"
local ADDON_NAME = ...

Sku = {}
Sku.L = LibStub("AceLocale-3.0"):GetLocale("Sku", false)
Sku.Loc = Sku.L["locale"]

Sku.AudiodataPath = ""
if Sku.Loc == "deDE" then
	Sku.AudiodataPath = "SkuAudioData"
elseif Sku.Loc == "enUS" or Sku.Loc == "enGB" or Sku.Loc == "enAU" then
	Sku.AudiodataPath = "SkuAudioData_en"
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.testMode = false

---------------------------------------------------------------------------------------------------------------------------------------
Sku.debug = false
function dprint(...)
	if Sku.debug == true then
		print(...)
		--print(Sku.Loc)
	end
end
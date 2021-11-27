local MODULE_NAME = "SkuCore"
local _G = _G
local L = Sku.L

SkuCore.Errors = SkuCore.Errors or {}
SkuCore.Errors.Sounds = {
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["error;sound"].."#"..L["brang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["error;sound"].."#"..L["bring"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["error;sound"].."#"..L["dang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["error;sound"].."#"..L["drmm"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["error;sound"].."#"..L["shhhup"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["error;sound"].."#"..L["spoing"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["error;sound"].."#"..L["swoosh"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["error;sound"].."#"..L["tsching"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["error;sound"].."#"..L["silent"],

   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Range.mp3"] = L["error;sound"].."#"..L["Range"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Move.mp3"] = L["error;sound"].."#"..L["Move"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_LOS.mp3"] = L["error;sound"].."#"..L["LOS"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Target.mp3"] = L["error;sound"].."#"..L["Target"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_IC.mp3"] = L["error;sound"].."#"..L["IC"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Res.mp3"] = L["error;sound"].."#"..L["Res"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Busy.mp3"] = L["error;sound"].."#"..L["Busy"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Dir.mp3"] = L["error;sound"].."#"..L["Dir"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Stun.mp3"] = L["error;sound"].."#"..L["Stun"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Inter.mp3"] = L["error;sound"].."#"..L["Inter"],

   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Range.mp3"] = L["error;sound"].."#Hans;"..L["Range"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Move.mp3"] = L["error;sound"].."#Hans;"..L["Move"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_LOS.mp3"] = L["error;sound"].."#Hans;"..L["LOS"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Target.mp3"] = L["error;sound"].."#Hans;"..L["Target"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_IC.mp3"] = L["error;sound"].."#Hans;"..L["IC"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Res.mp3"] = L["error;sound"].."#Hans;"..L["Res"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Busy.mp3"] = L["error;sound"].."#Hans;"..L["Busy"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Dir.mp3"] = L["error;sound"].."#Hans;"..L["Dir"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Stun.mp3"] = L["error;sound"].."#Hans;"..L["Stun"],
	["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Inter.mp3"] = L["error;sound"].."#Hans;"..L["Inter"],
}

SkuCore.RangeCheckSounds = {
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["sound"].."#"..L["brang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["sound"].."#"..L["bring"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["sound"].."#"..L["dang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["sound"].."#"..L["drmm"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["sound"].."#"..L["shhhup"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["sound"].."#"..L["spoing"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["sound"].."#"..L["swoosh"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["sound"].."#"..L["tsching"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["sound"].."#"..L["silent"],
}

SKU_CONSTANTS = {
	["SOUNDCHANNELS"] = {
		["Master"] = "Gesamt",
		["SFX"] = "Soundeffekte",
		["Music"] = "Musik",
		["Ambience"] = "Umgebung",
		["Dialog"] = "Dialog",
		["Talking Head"] = "Sku",
	},
}
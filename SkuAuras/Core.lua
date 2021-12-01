---@diagnostic disable: undefined-doc-name

local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L

SkuAurasDB = {}
SkuAuras = LibStub("AceAddon-3.0"):NewAddon("SkuAuras", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnInitialize()
	SkuAuras:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuAuras:RegisterEvent("PLAYER_LOGIN")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnEnable()
	--print("SkuAuras OnEnable")
	local ttime = 0
	local f = _G["SkuAurasControl"] or CreateFrame("Frame", "SkuAurasControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		ttime = ttime + time
		if ttime > 0.15 then

			ttime = 0
		end
	end)
	f:Show()

	local tFrame = _G["SkuAurasControlOption1"] or  CreateFrame("Button", "SkuAurasControlOption1", _G["UIParent"], "UIPanelButtonTemplate")
	tFrame:SetSize(1, 1)
	tFrame:SetText("SkuAurasControlOption1")
	tFrame:SetPoint("TOP", _G["SkuAurasControl"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		if aKey == "CTRL-SHIFT-G" then
			print(aKey)
		end
	end)
	tFrame:SetScript("OnShow", function(self) 
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-G", "SkuAurasControlOption1", "CTRL-SHIFT-G")
	end)
	tFrame:SetScript("OnHide", function(self) 
		ClearOverrideBindings(self)
	end)
	tFrame:Show()
	--SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-G", "SkuAurasControlOption1", "CTRL-SHIFT-G")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:OnDisable()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:PLAYER_LOGIN(...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAuras:PLAYER_ENTERING_WORLD(aEvent, aIsInitialLogin, aIsReloadingUi)
end
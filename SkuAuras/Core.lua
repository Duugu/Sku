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
	--dprint("SkuAuras OnEnable")
	local ttime = 0
	local f = _G["SkuAurasControl"] or CreateFrame("Frame", "SkuAurasControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		ttime = ttime + time
		if ttime < 0.15 then return end

		--GetElTime()
		ttime = 0
	end)
	f:Show()

	local tFrame = _G["SkuAurasControlOption1"] or  CreateFrame("Button", "SkuAurasControlOption1", _G["UIParent"], "UIPanelButtonTemplate")
	tFrame:SetSize(1, 1)
	tFrame:SetText("SkuAurasControlOption1")
	tFrame:SetPoint("TOP", _G["SkuAurasControl"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		if aKey == "CTRL-SHIFT-G" then
			--dprint(aKey)
		end
	end)
	tFrame:SetScript("OnShow", function(self) 
		--SetOverrideBindingClick(self, true, "CTRL-SHIFT-G", "SkuAurasControlOption1", "CTRL-SHIFT-G")
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

		 print("noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667))
		 
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
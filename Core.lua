---@diagnostic disable: undefined-field, undefined-doc-name, undefined-doc-param

---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "Sku"
local ADDON_NAME = ...

Sku = {}
Sku.L = LibStub("AceLocale-3.0"):GetLocale("Sku", false)
Sku.Loc = Sku.L["locale"]
Sku.Locs = {"enUS", "deDE",}

Sku.LocsPartly = {["deDE"] = true, ["enUS"] = true, ["zhCN"] = true, ["ruRU"] = true,}
Sku.LocP = GetLocale()
if not Sku.LocsPartly[GetLocale()] then
	Sku.LocP = "enUS"
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.AudiodataPath = ""
if Sku.Loc == "deDE" then
	Sku.AudiodataPath = "SkuAudioData"
elseif Sku.Loc == "enUS" or Sku.Loc == "enGB" or Sku.Loc == "enAU" then
	Sku.AudiodataPath = "SkuAudioData_en"
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.testMode = false

---------------------------------------------------------------------------------------------------------------------------------------
-- tmp fixes for 30401; still need to replace all calls everywhere at some point
Sku.toc = select(4, GetBuildInfo())
if Sku.toc >= 30401 then
	PickupContainerItem = C_Container.PickupContainerItem
	GetContainerNumSlots = C_Container.GetContainerNumSlots
	GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
	UseContainerItem = C_Container.UseContainerItem
	GetContainerItemID = C_Container.GetContainerItemID
	GetItemCooldown = C_Container.GetItemCooldown
	GetContainerItemQuestInfo = function(bag, slot)
		local t = C_Container.GetContainerItemQuestInfo(bag, slot)
		return t.isQuestItem
	end
	GetContainerItemInfo = function(bag, slot)
		slot = slot or 0
		local t = C_Container.GetContainerItemInfo(bag, slot)
		if not t then
			return
		end		
		return t.iconFileID, t.stackCount, t.isLocked, t.quality, t.isReadable, t.hasLoot, t.hyperlink, t.isFiltered, t.hasNoValue, t.itemID, t.isBound
	end
	SocketContainerItem = C_Container.SocketContainerItem
	SplitContainerItem = C_Container.SplitContainerItem
	GetContainerItemLink = C_Container.GetContainerItemLink
	GetContainerItemCooldown = C_Container.GetContainerItemCooldown

	SetTracking = C_Minimap.SetTracking
	GetTrackingInfo = C_Minimap.GetTrackingInfo
	GetNumTrackingTypes = C_Minimap.GetNumTrackingTypes
end
if Sku.toc >= 30403 then
	Sku.IsWrathICC = true
end


---------------------------------------------------------------------------------------------------------------------------------------
Sku.metric = {}
debugprofilestart()
function Sku:MetricPoint(aText)
	Sku.metric[#Sku.metric + 1] = {aText, debugprofilestop()/1000}
end

---------------------------------------------------------------------------------------------------------------------------------------
Sku.debug = false
function dprint(...)
	if Sku.debug == true then
		print("Debug:", ...)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
-- Performance monitoring
Sku.PerformanceStart = false
Sku.PerformanceData = {}
function Sku:Performance()
	if not _G["SkuPerformance"] then
		local f = _G["SkuPerformance"] or CreateFrame("Frame", "SkuPerformance", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		local ttime = 0
		f:SetMovable(true)
		f:EnableMouse(true)
		f:SetClampedToScreen(true)
		f:RegisterForDrag("LeftButton")
		f:SetFrameStrata("DIALOG")
		f:SetFrameLevel(129)
		f:SetSize(450, 170)
		f:SetPoint("TOP", UIParent, "TOP")
		f:SetBackdrop({bgFile = [[Interface\ChatFrame\ChatFrameBackground]], edgeFile = "", tile = false, tileSize = 0, edgeSize = 32, insets = {left = 0, right = 0, top = 0, bottom = 0}})
		f:SetBackdropColor(0, 0, 0, 1)
		f:SetScript("OnDragStart", function(self) self:StartMoving() end)
		f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
		f:SetResizable(true)
      --f:SetResizeBounds(500, 500)

		local rb = CreateFrame("Button", "SkuPerformanceResizeButton", f)
		rb:SetPoint("BOTTOMRIGHT", -6, 7)
		rb:SetSize(16, 16)

		rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
		rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
		rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

		rb:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				f:StartSizing("BOTTOMRIGHT")
				self:GetHighlightTexture():Hide() -- more noticeable
			end
		end)
		rb:SetScript("OnMouseUp", function(self, button)
			f:StopMovingOrSizing()
			self:GetHighlightTexture():Show()
			f:SetWidth(f:GetWidth())

			for x = 1, 10 do
				local fs = _G["SkuPerformanceFSl"..x]
				fs:SetSize(f:GetWidth() / 2, 200)
				local fs = _G["SkuPerformanceFSr"..x]
				fs:SetPoint("TOPLEFT", f, "TOPLEFT", f:GetWidth() / 2, -((x-1) * 15))
				fs:SetSize(f:GetWidth() / 2, 200)
			end			
		end)

		local SkuPerformanceOnUpdateTime = 0
		f:SetScript('OnUpdate', function(self, time)
			if Sku.PerformanceStart ~= true then
				return
			end
			SkuPerformanceOnUpdateTime = SkuPerformanceOnUpdateTime + time
			if SkuPerformanceOnUpdateTime > 0.1 then
				local xs = 1
				for i, v in pairs(Sku.PerformanceData) do
					_G["SkuPerformanceFSl"..xs]:SetText(i)
					_G["SkuPerformanceFSr"..xs]:SetText(tostring(v))
					xs = xs + 1
				end

				SkuPerformanceOnUpdateTime = 0
			end
		end)

		for x = 1, 10 do
			local fs = f:CreateFontString("SkuPerformanceFSl"..x)
			fs:SetFontObject(SystemFont_Small)
			fs:SetTextColor(1, 1, 1, 1)
			fs:SetJustifyH("LEFT")
			fs:SetJustifyV("TOP")
			
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -((x-1) * 15))
			fs:SetText("")
			fs:SetSize(f:GetWidth() / 2, 200)
			local fs = f:CreateFontString("SkuPerformanceFSr"..x)
			fs:SetFontObject(SystemFont_Small)
			fs:SetTextColor(1, 1, 1, 1)
			fs:SetJustifyH("LEFT")
			fs:SetJustifyV("TOP")
			fs:SetPoint("TOPLEFT", f, "TOPLEFT", f:GetWidth() / 2, -((x-1) * 15))
			fs:SetText("")
			fs:SetSize(f:GetWidth() / 2, 200)
		end

		_G["SkuPerformance"]:Show()
		Sku.PerformanceStart = true
		return
	end

	if _G["SkuPerformance"]:IsShown() == true then
		_G["SkuPerformance"]:Hide()
		Sku.PerformanceStart = false
	else
		_G["SkuPerformance"]:Show()
		Sku.PerformanceStart = true
	end
end
---@diagnostic disable: undefined-doc-name

---------------------------------------------------------------------------------------------------------------------------------------
--/script skudebuglevel = 0
skudebuglevel = 1

local MODULE_NAME = "SkuCore"
local _G = _G
local L = Sku.L

local tStartDebugTimestamp = GetTime() or 0

SkuCoreDB = {}
SkuCore = LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
CLASS_IDS = {
	["WARRIOR"] = 1,
	["PALADIN"] = 2,
	["HUNTER"] = 3,
	["ROGUE"] = 4,
	["PRIEST"] = 5,
	["DEATHKNIGHT"] = 6,
	["SHAMAN"] = 7,
	["MAGE"] = 8,
	["WARLOCK"] = 9,
	["MONK"] = 10,
	["DRUID"] = 11,
	["DEMONHUNTER_ID"] = 12,
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.inCombat = false
SkuCore.openMenuAfterCombat = false
SkuCore.isMoving = false
SkuCore.openMenuAfterMoving = false
SkuCore.openMenuAfterPath = ""

local EnumItemQuality = {
	[0] = ITEM_QUALITY0_DESC,
	[1] = ITEM_QUALITY1_DESC,
	[2] = ITEM_QUALITY2_DESC,
	[3] = ITEM_QUALITY3_DESC,
	[4] = ITEM_QUALITY4_DESC,
	[5] = ITEM_QUALITY5_DESC,
	[6] = ITEM_QUALITY6_DESC,
	[7] = ITEM_QUALITY7_DESC,
	[8] = ITEM_QUALITY8_DESC,
	}
	
SkuCoreMovement = {
		["Flags"] = {
			["MoveForward"] = false,
			["MoveBackward"] = false,
			["StrafeLeft"] = false,
			["StrafeRight"] = false,
			["FollowUnit"] = false,
			["IsTurningOrAutorunningOrStrafing"] = false,
			},
		["LastPosition"] = {
			["x"] = 0,
			["y"] = 0,
			},
		["counter"] = 0,
	}

SkuStatus = {
	["indoor"] = 0,
	["outdoor"] = 0,
	["swimming"] = 0,
	["submerged"] = 0,
	["ghost"] = 0,
	["dead"] = 0,
	["running"] = 100000000,
	["walking"] = 0,
	["vehicle"] = 0,
	["follow"] = 0,
	["riding"] = 0,
	["stealth"] = 0,
	["flying"] = 0,
	["falling"] = 0,
	["rest"] = 0,
	["drink"] = 0,
	["afk"] = 0,
	["interacting"] = 0,
	["looting"] = 0,
	["casting"] = 0,
}

SkuCore.interactFramesListHooked = {}
SkuCore.interactFramesListManual = {
	["CraftFrame"] = function(...) SkuCore:Build_CraftFrame(...) end,
	["PetStableFrame"] = function(...) SkuCore:Build_PetStableFrame(...) end,
}

SkuCore.interactFramesList = {
	"QuestFrame",--o
	"TaxiFrame",--o
	"GossipFrame",--o
	"MerchantFrame",--o
	"StaticPopup1",
	"StaticPopup2",
	"StaticPopup3",
	"PetStableFrame",
	"ContainerFrame1",
	"ContainerFrame2",
	"ContainerFrame3",
	"ContainerFrame4",
	"ContainerFrame5",
	"ContainerFrame6",
	"DropDownList1",
	"TalentFrame",
	--"AuctionFrame",
	"ClassTrainerFrame",
	"CharacterFrame",
	"ReputationFrame",
	"SkillFrame",
	"HonorFrame",
	"PlayerTalentFrame",
	"InspectFrame",
	"BagnonInventoryFrame1",
	"BagnonBankFrame1",
	"GuildBankFrame",
	"BankFrame",
	"CraftFrame",
	--"GroupLootContainer",
	"TradeFrame",
	"TradeSkillFrame",
	--"DropDownList2",
	--"FriendsFrame",
	--"GameMenuFrame",
	--"SpellBookFrame",
	--"MultiBarLeft",
	--"MultiBarRight",
	--"MultiBarBottomLeft",
	--"MultiBarBottomRight",
	"BagnonGuildFrame1",
	--"MainMenuBar",
}

local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}
local function unescape(str)
	for k, v in pairs(escapes) do
		str = string.gsub(str, k, v)
	end
	return str
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:OnInitialize()
	--dprint("SkuCore OnInitialize")

	SkuCore:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuCore:RegisterEvent("PLAYER_LOGIN")
	SkuCore:RegisterEvent("VARIABLES_LOADED")
	SkuCore:RegisterEvent("PLAYER_REGEN_DISABLED")
	SkuCore:RegisterEvent("PLAYER_REGEN_ENABLED")
	SkuCore:RegisterEvent("QUEST_LOG_UPDATE")
	SkuCore:RegisterEvent("PLAYER_CONTROL_LOST")
	SkuCore:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	SkuCore:RegisterEvent("PLAYER_CONTROL_GAINED")
	SkuCore:RegisterEvent("PLAYER_DEAD")
	SkuCore:RegisterEvent("AUTOFOLLOW_BEGIN")
	SkuCore:RegisterEvent("AUTOFOLLOW_END")
	SkuCore:RegisterEvent("PLAYER_UPDATE_RESTING")
	SkuCore:RegisterEvent("UPDATE_STEALTH")
	SkuCore:RegisterEvent("ITEM_UNLOCKED")
	SkuCore:RegisterEvent("ITEM_LOCK_CHANGED")
	SkuCore:RegisterEvent("BAG_UPDATE")
	SkuCore:RegisterEvent("UNIT_POWER_UPDATE")
	SkuCore:RegisterEvent("UNIT_HAPPINESS")

	SkuCore:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

	SkuCore:RegisterEvent("UNIT_SPELLCAST_START")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_FAILED")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_STOP")
	SkuCore:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	SkuCore:RegisterEvent("NAME_PLATE_CREATED")
	SkuCore:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	SkuCore:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
	--SkuCore:RegisterEvent("CURSOR_CHANGED")
	--SkuCore:RegisterEvent("PET_STABLE_SHOW")
	--SkuCore:RegisterEvent("PET_STABLE_CLOSED")

	SkuCore:MailOnInitialize()
	SkuCore:UIErrorsOnInitialize()
	SkuCore:RangeCheckOnInitialize()
	SkuCore:AuctionHouseOnInitialize()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PanicModeStartStopBackgroundSound(aStartStop)
	if 1 == 1 then return end
	if aStartStop == true then
		if SkuCore.currentBackgroundSoundHandle == nil then
			local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\background\\benny_hill.mp3", "Talking Head")
			if soundHandle then
				SkuCore.currentBackgroundSoundHandle = soundHandle
				if SkuCore.currentBackgroundSoundTimerHandle then
					SkuCore.currentBackgroundSoundTimerHandle:Cancel()
					SkuCore.currentBackgroundSoundTimerHandle = nil
				end
				if SkuCore.currentBackgroundSoundTimerHandle == nil then
					SkuCore.currentBackgroundSoundTimerHandle = C_Timer.NewTimer(238,8, function()
						--StopSound(SkuOptions.currentBackgroundSoundHandle, 0)
						SkuCore.currentBackgroundSoundTimerHandle = nil
						SkuCore.currentBackgroundSoundHandle = nil
						SkuCore:StartStopBackgroundSound(true)
					end)
				else
					if SkuCore.currentBackgroundSoundTimerHandle then
						SkuCore.currentBackgroundSoundTimerHandle:Cancel()
						SkuCore.currentBackgroundSoundTimerHandle = nil
					end
					SkuCore.currentBackgroundSoundTimerHandle = nil
					SkuCore.currentBackgroundSoundTimerHandle = C_Timer.NewTimer(238,8, function()
						SkuCore.currentBackgroundSoundTimerHandle = nil
						SkuCore.currentBackgroundSoundHandle = nil
						SkuCore:StartStopBackgroundSound(true)
					end)
				end
			end
		else
			StopSound(SkuCore.currentBackgroundSoundHandle, 0)
			SkuCore.currentBackgroundSoundHandle = nil
		end
		
		return
	end
	
	if aStartStop == false then
		if SkuCore.currentBackgroundSoundHandle ~= nil then
			StopSound(SkuCore.currentBackgroundSoundHandle, 0)
			SkuCore.currentBackgroundSoundHandle = nil
		end
		if SkuCore.currentBackgroundSoundTimerHandle then
			SkuCore.currentBackgroundSoundTimerHandle:Cancel()
			SkuCore.currentBackgroundSoundTimerHandle = nil
		end

		return
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tPanicData = {}
local ttimeDegreesChangeInitial = nil
local tLastPanicPos = {x = 0, y = 0}
local tPanicMaxRecDistance = 500
local tPanicModeOn = false
local tPanicBeaconName = "SkuPanicBeacon"
local SkuCorePanicControl
local SkuCorePanicBeaconDistance = 20
local SkuCorePanicCurrentPoint = 1
local SkuCorePanicBeaconType = "probe_mid_1"
function SkuCore:PanicModeCollectData()
	if tPanicModeOn == false then
		local tMaxDiff = 20--SkuNav.routeRecordingIntWpMethods.values["20 Grad 20 Meter"].rot
		local tMinDist = 20--SkuNav.routeRecordingIntWpMethods.values["20 Grad 20 Meter"].dist
		local x, y = UnitPosition("player")

		if not x then
			return
		end
		
		local _, _, tDegreesFinal = SkuNav:GetDirectionTo(x, y, 30000, y)
		if not tDegreesFinal then
			return
		end
		if not ttimeDegreesChangeInitial then
			ttimeDegreesChangeInitial = tDegreesFinal
		end
		local tDiff = ttimeDegreesChangeInitial - tDegreesFinal
		if tDiff < -180 then
			tDiff = 360 + tDiff
		elseif tDiff > 180 then
			tDiff = (360 - tDiff) * -1
		end
		local tPrevWPx = tLastPanicPos.x
		local tPrevWPy = tLastPanicPos.y
		local tDist = SkuNav:Distance(tPrevWPx, tPrevWPy, x, y)

		local tDynDist = 0
		if tDiff < 0 then
			tDynDist = ((tDiff * -1) + tDist) / 2
		else
			tDynDist = ((tDiff) + tDist) / 2
		end

		if tdiold ~= tDiff or tdisold ~= tDist then
			tdiold = tDiff
			tdisold = tDist
		end

		--if (tDiff > tMaxDiff or tDiff < (-tMaxDiff)) and (tDist > tMinDist) then
		if tDynDist > tMinDist and tDist > (tMinDist / 3) then
			ttimeDegreesChangeInitial = tDegreesFinal
			tLastPanicPos.x = x
			tLastPanicPos.y = y
			table.insert(tPanicData, 1, {x = x, y = y})
			local tFullDistance = 0
			local tDelFrom = 999
			for x = 1, #tPanicData do
				if tPanicData[x] and tPanicData[x + 1] then
					tFullDistance = tFullDistance + SkuNav:Distance(tPanicData[x].x, tPanicData[x].y, tPanicData[x + 1].x, tPanicData[x + 1].y)
					if tFullDistance > tPanicMaxRecDistance then
						tDelFrom = x
					end
				end
			end

			for x = tDelFrom, #tPanicData do
				tPanicData[x] = nil
			end
		end
		
		-------------------- tmp draw path
		if skudebuglevel == 0 then
			if #tPanicData > 1 then
				local tP1Obj
				for line = 1, #tPanicData do
					local tRouteColor = {r = 1, g = 0, b = 0, a = 1,}
					local x1, y1 = SkuNavMMWorldToContent(tPanicData[line].x, tPanicData[line].y)
					local tP2Obj = SkuNavDrawWaypointWidgetMM(x1, y1, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, _G["SkuNavMMMainFrameScrollFrameContent1"], v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 1)
					if line > 1 then
						local point, relativeTo, relativePoint, xOfs, yOfs = tP2Obj:GetPoint(1)
						if relativeTo then
							local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tP1Obj:GetPoint(1)
							if PrevrelativeTo then
								SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, _G["SkuNavMMMainFrameScrollFrameContent1"], nil, relativeTo, PrevrelativeTo) 
							end
						end
					end
					tP1Obj = tP2Obj
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PanicModeStart()
	if SkuCore.inCombat == false then
		return
	end
	if tPanicModeOn == false then
		tPanicModeOn = true

		SkuCore:PanicModeStartStopBackgroundSound(true)
		SkuCorePanicControl = C_Timer.NewTicker(0.1, function()
			if SkuCore.inCombat == false then
				SkuCorePanicControl:Cancel()
				SkuCore:PanicModeStartStopBackgroundSound(false)
				SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", tPanicBeaconName)
				tPanicModeOn = false
				tPanicData = {}
				SkuCorePanicCurrentPoint = 1
				return
			end
			------------------------------------------------- draw path
			if skudebuglevel == 0 then
				if #tPanicData > 1 then
					local tP1Obj
					for line = 1, #tPanicData do
						local tRouteColor = {r = 1, g = 0, b = 0, a = 1,}
						local x1, y1 = SkuNavMMWorldToContent(tPanicData[line].x, tPanicData[line].y)
						local tP2Obj = SkuNavDrawWaypointWidgetMM(x1, y1, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, _G["SkuNavMMMainFrameScrollFrameContent1"], v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 1)
						if line > 1 then
							local point, relativeTo, relativePoint, xOfs, yOfs = tP2Obj:GetPoint(1)
							if relativeTo then
								local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tP1Obj:GetPoint(1)
								if PrevrelativeTo then
									SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, _G["SkuNavMMMainFrameScrollFrameContent1"], nil, relativeTo, PrevrelativeTo) 
								end
							end
						end
						tP1Obj = tP2Obj
					end
				end
			end
			------------------------------------------------- calculate final
			local tPlayerPosX, tPlayerPosY = UnitPosition("player")
			if SkuNav:Distance(tPlayerPosX, tPlayerPosY, tPanicData[SkuCorePanicCurrentPoint].x, tPanicData[SkuCorePanicCurrentPoint].y) < SkuCorePanicBeaconDistance then
				if SkuCorePanicCurrentPoint == #tPanicData then
					SkuCore:PanicModeStart()
				else
					for x = SkuCorePanicCurrentPoint, #tPanicData do
						if SkuNav:Distance(tPlayerPosX, tPlayerPosY, tPanicData[x].x, tPanicData[x].y) > SkuCorePanicBeaconDistance then
							SkuCorePanicCurrentPoint = x
							if not SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", tPanicBeaconName) then
								SkuOptions.BeaconLib:CreateBeacon("SkuOptions", tPanicBeaconName, SkuCorePanicBeaconType, tPanicData[SkuCorePanicCurrentPoint].x, tPanicData[SkuCorePanicCurrentPoint].y, -3, 0, 66)
								SkuOptions.BeaconLib:StartBeacon("SkuOptions", tPanicBeaconName)
							else
								SkuOptions.BeaconLib:UpdateBeacon("SkuOptions", tPanicBeaconName, SkuCorePanicBeaconType, tPanicData[SkuCorePanicCurrentPoint].x, tPanicData[SkuCorePanicCurrentPoint].y, -3, 0, 66, true)
							end
	
							break
						end
					end
				end
			end
			------------------------------------------------- draw lin to final
			if skudebuglevel == 0 then
				if SkuCorePanicCurrentPoint > 0 and #tPanicData > 0 then
					local tRouteColor = {r = 0, g = 1, b = 0, a = 1,}
					local x1, y1 = SkuNavMMWorldToContent(tPlayerPosX, tPlayerPosY)
					local tP1Obj = SkuNavDrawWaypointWidgetMM(x1, y1, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, _G["SkuNavMMMainFrameScrollFrameContent1"], v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 1)
					local x1, y1 = SkuNavMMWorldToContent(tPanicData[SkuCorePanicCurrentPoint].x, tPanicData[SkuCorePanicCurrentPoint].y)
					local tP2Obj = SkuNavDrawWaypointWidgetMM(x1, y1, 1,  1, 3, tRouteColor.r, tRouteColor.g, tRouteColor.b, tRouteColor.a, _G["SkuNavMMMainFrameScrollFrameContent1"], v, tRouteColor.r, tRouteColor.g, tRouteColor.b, 1)
					local point, relativeTo, relativePoint, xOfs, yOfs = tP2Obj:GetPoint(1)
					if relativeTo then
						local Prevpoint, PrevrelativeTo, PrevrelativePoint, PrevxOfs, PrevyOfs = tP1Obj:GetPoint(1)
						if PrevrelativeTo then
							SkuNavDrawLine(xOfs, yOfs, PrevxOfs, PrevyOfs, 3, tRouteColor.a, tRouteColor.r, tRouteColor.g, tRouteColor.b, _G["SkuNavMMMainFrameScrollFrameContent1"], nil, relativeTo, PrevrelativeTo) 
						end
					end
					if SkuOptions.BeaconLib:GetBeaconStatus("SkuOptions", tPanicBeaconName) then
						SkuOptions.BeaconLib:UpdateBeacon("SkuOptions", tPanicBeaconName, SkuCorePanicBeaconType, tPanicData[SkuCorePanicCurrentPoint].x, tPanicData[SkuCorePanicCurrentPoint].y, -3, 0, 66, true)
					end
				end
			end
		end)

	else
		SkuCorePanicControl:Cancel()
		SkuCore:PanicModeStartStopBackgroundSound(false)
		SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", tPanicBeaconName)
		tPanicModeOn = false
		tPanicData = {}
		SkuCorePanicCurrentPoint = 1
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Distance(sx, sy, dx, dy)
	--[[sx = sx or 0
	sy = sy or 0
	dx = dx or 0
	dy = dy or 0
	]]
    return floor(sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)), sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:IsPlayerMoving()
	local rValue = false
	if SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing == true or
		SkuCoreMovement.Flags.MoveForward == true or
		SkuCoreMovement.Flags.MoveBackward == true or
		SkuCoreMovement.Flags.StrafeLeft == true or
		SkuCoreMovement.Flags.StrafeRight == true
	then
		rValue = true
	end
    return rValue
end

---------------------------------------------------------------------------------------------------------------------------------------
local tSkuCoreNamePlateRepo = {}
function SkuCore:NAME_PLATE_CREATED(...)
	--dprint("NAME_PLATE_CREATED", ...)
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:NAME_PLATE_UNIT_ADDED(aEvent, aPlateName)
	--dprint("NAME_PLATE_UNIT_ADDED", aPlateName, UnitName(aPlateName))
	local tName = UnitName(aPlateName)
	if not tName then return end

	local tReaction = UnitReaction("player", aPlateName)
	if tReaction > 3 then --https://wowpedia.fandom.com/wiki/API_UnitReaction
		table.insert(tSkuCoreNamePlateRepo, {name = tName, plate = aPlateName})
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:NAME_PLATE_UNIT_REMOVED(aEvent, aPlateName)
	--dprint("NAME_PLATE_UNIT_REMOVED", aPlateName)
	tSkuCoreNamePlateRepo[aPlateName] = nil
	for x = 1, #tSkuCoreNamePlateRepo do
		if tSkuCoreNamePlateRepo[x].plate ==aPlateName then
			table.remove(tSkuCoreNamePlateRepo, x)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:IsNamePlateVisible(aCreatureName)
	for x = 1, #tSkuCoreNamePlateRepo do
		if tSkuCoreNamePlateRepo[x].name == aCreatureName then
			return true
		end
	end
	return false
end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuInteractMoveTmpFlag = false
function SkuCore:UpdateInteractMove(aForceFlag)
	if SkuInteractMoveTmpFlag == true then
		return
	end

	SkuOptions.db.profile[MODULE_NAME].interactMove = SkuOptions.db.profile[MODULE_NAME].interactMove or false
	local interactMoveVal = "0"
	if SkuOptions.db.profile[MODULE_NAME].interactMove == true then
		interactMoveVal = "1"
	end

	if C_CVar.GetCVar("AutoInteract") ~= interactMoveVal or aForceFlag then
		if C_CVar.GetCVar("AutoInteract") == "0" then
			C_CVar.SetCVar("AutoInteract", "1")

			WorldFrame:SetScript("OnMouseDown", function() 
				SkuInteractMoveTmpFlag = true
				C_CVar.SetCVar("AutoInteract", "0")
			end)
			WorldFrame:SetScript("OnMouseUp", function() 
				C_Timer.After(0.0, function()
					C_CVar.SetCVar("AutoInteract", "1")
					SkuInteractMoveTmpFlag = false
				end)
			end)
		else
			C_CVar.SetCVar("AutoInteract", "0")
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local oinfoType, oitemID, oitemLink = nil, nil, nil
local SkuCoreOldPetHappinessCounter = 0
local SkuCorePetHappinessString = {[1] = L["Unhappy"], [2] = L["Content "], [3] = L["Happy"]}
function SkuCore:OnEnable()
	--dprint("SkuCore OnEnable")
	SkuCore:RangeCheckOnEnable()

	--fake ctrl shift tab for untargetable units in starting areas	
	local tFrame = CreateFrame("Button", "SkuCoreSecureTabButton", _G["UIParent"], "SecureActionButtonTemplate")
	tFrame:SetSize(1, 1)
	tFrame:SetPoint("TOPLEFT", _G["UIParent"], "TOPLEFT", 0, 0)
	tFrame:Show()
	tFrame:SetAttribute("type1", "macro") 
	tFrame:SetAttribute("macrotext1", "")
	SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-TAB", "SkuCoreSecureTabButton")
	--tFrame:RegisterEvent("CURSOR_CHANGED")
	--tFrame:SetScript("OnUpdate", function(self, time)
	local tLastPlayerTargetNr = 0
	local tSkuCoreSecureTabButtonTime = 0
	tFrame:SetScript("OnUpdate", function(self, time)
		tSkuCoreSecureTabButtonTime = tSkuCoreSecureTabButtonTime + time
		if tSkuCoreSecureTabButtonTime < 0.1 then return end

		SkuCore:UpdateInteractMove()

		SkuCore:DoRangeCheck()

		if SkuCore.inCombat ~= true then
			if GetCVar("nameplateShowFriends") == "0" then
				SetCVar("nameplateShowFriends", "1")
			end

			if #tSkuCoreNamePlateRepo > 0 then
				if tLastPlayerTargetNr == 0 then
					tLastPlayerTargetNr = 1
				end
				local tName = UnitName("target")
				if tName then
					if not tSkuCoreNamePlateRepo[tLastPlayerTargetNr] then
						tLastPlayerTargetNr = 1
					end
					if tSkuCoreNamePlateRepo[tLastPlayerTargetNr] then
						if tName == tSkuCoreNamePlateRepo[tLastPlayerTargetNr].name then
							tLastPlayerTargetNr = tLastPlayerTargetNr + 1
							if tLastPlayerTargetNr > #tSkuCoreNamePlateRepo then
								tLastPlayerTargetNr = 1
							end
						end
					end
				end
				if tSkuCoreNamePlateRepo[tLastPlayerTargetNr] then
					_G["SkuCoreSecureTabButton"]:SetAttribute("macrotext1", "/tar "..tSkuCoreNamePlateRepo[tLastPlayerTargetNr].name)	
				end
			else
				_G["SkuCoreSecureTabButton"]:SetAttribute("macrotext1", "/cleartarget")	
			end
		end
		tSkuCoreSecureTabButtonTime = 0
	end)

	local ttime = 0
	local f = _G["SkuCoreControl"] or CreateFrame("Frame", "SkuCoreControl", UIParent)
	f:SetScript("OnUpdate", function(self, time)
		if SkuOptions.db.profile[MODULE_NAME].enable ~= true then return end
			
		--hunter pet happiness
		if select(2, UnitClassBase("player")) == CLASS_IDS["HUNTER"] then
			if SkuOptions.db.profile[MODULE_NAME].classes.hunter.petHappyness == true then
				SkuCoreOldPetHappinessCounter = SkuCoreOldPetHappinessCounter + time
				if SkuCoreOldPetHappinessCounter > 15 then
					local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
					if happiness and happiness ~= 3 then
						SkuOptions.Voice:OutputString(L["Pet"]..";"..SkuCorePetHappinessString[happiness], true, true, 0.2)
						SkuCoreOldPetHappinessCounter = 0
					end
				end
			end
		end

		ttime = ttime + time
		if ttime < 0.15 then return end

		SkuCore:PanicModeCollectData()

		for x = 1, #SkuCore.interactFramesList do
			if SkuCore.interactFramesList[x] and not SkuCore.interactFramesListHooked[SkuCore.interactFramesList[x]] then
				if _G[SkuCore.interactFramesList[x]] then
					hooksecurefunc(_G[SkuCore.interactFramesList[x]], "Show", SkuCore.GENERIC_OnOpen)
					hooksecurefunc(_G[SkuCore.interactFramesList[x]], "Hide", SkuCore.GENERIC_OnClose)
					SkuCore:GENERIC_OnOpen()
					SkuCore.interactFramesListHooked[SkuCore.interactFramesList[x]] = true
				end
			end
		end

		local infoType, itemID, itemLink = GetCursorInfo()
		local tResult
		if infoType ~= oinfoType or itemID~= oitemID or itemLink ~= oitemLink then
			if infoType then
				if infoType == "merchant" then
					tResult = _G["MerchantItem"..itemID.."Name"]:GetText()
				elseif infoType == "item" then
					tResult = string.sub(unescape(itemLink), 2, string.len(unescape(itemLink))-1)
				else
					tResult = infoType
				end
			else
				tResult = L["Empty"]
			end
			oinfoType = infoType
			oitemID = itemID
			oitemLink = itemLink
		end
		if tResult then
			SkuOptions.Voice:OutputString(L["Cursor"]..tResult, true, true, 0.2, true)
		end

		if SkuCore:IsPlayerMoving() == true or SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing == true then
			SkuCore.isMoving = true
		else
			SkuCore.isMoving = false
		end
		if SkuCore.openMenuAfterCombat == true or SkuCore.openMenuAfterMoving == true then
			if SkuCore.inCombat == false and SkuCore.isMoving == false then
				if SkuCore.openMenuAfterPath ~= "" then
					SkuOptions:SlashFunc(SkuCore.openMenuAfterPath)
					SkuCore.openMenuAfterPath = ""
				else
					if #SkuOptions.Menu == 0 or SkuOptions:IsMenuOpen() == false then
						_G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
					end
				end
			end
		end

		if IsFalling() == true then
			if SkuStatus.falling ~= -1 then
				if SkuStatus.falling > 0 then
					if GetTime() - SkuStatus.falling > 1.00 then
						SkuOptions.Voice:OutputString("male-Fallen", true, true, 0.2)
						SkuStatus.falling = -1
					end
				else
					SkuStatus.falling = GetTime()
				end
			end
		else
			SkuStatus.falling = 0
		end
		if UnitIsAFK("player") == true then
			if SkuStatus.afk == 0 then
				SkuStatus.afk = GetTime()
				SkuOptions.Voice:OutputString("male-Fallen", false, true, 0.2)
			end
		else
			SkuStatus.afk = 0
		end
		if UnitIsDead("player") == true then
			if SkuStatus.dead == 0 then
				SkuStatus.dead = GetTime()
				SkuOptions.Voice:OutputString("male-Tot", false, true, 0.2)
			end
		else
			SkuStatus.dead = 0
		end
		if IsResting() == true then
			if SkuStatus.rest == 0 then
				SkuStatus.rest = GetTime()
				SkuOptions.Voice:OutputString("male-Rasten", false, true, 0.2)
			end
		else
			SkuStatus.rest = 0
		end
		if UnitIsGhost("player") == true then
			if SkuStatus.ghost == 0 then
				SkuStatus.ghost = GetTime()
				SkuOptions.Voice:OutputString("male-Geist", false, true, 0.2)
			end
		else
			SkuStatus.ghost = 0
		end
		if IsOutdoors() == true then
			if SkuStatus.outdoor == 0 then
				SkuStatus.outdoor = GetTime()
				SkuOptions.Voice:OutputString("male-Draußen", false, true, 0.2)
			end
		else
			SkuStatus.outdoor = 0
		end
		if IsIndoors() == true then
			if SkuStatus.indoor == 0 then
				SkuStatus.indoor = GetTime()
				SkuOptions.Voice:OutputString("male-Drinnen", false, true, 0.2)
			end
		else
			SkuStatus.indoor = 0
		end
		if IsSubmerged() == true and _G["MirrorTimer1"]:IsVisible() == true then
			if SkuStatus.submerged == 0 then
				SkuStatus.submerged = GetTime()
				SkuStatus.swimming = 0
				SkuOptions.Voice:OutputString("male-Tauchen", false, true, 0.2)
			end
		else
			SkuStatus.submerged = 0
		end
		if IsSwimming() == true and SkuStatus.submerged == 0 then
			if SkuStatus.swimming == 0 then
				SkuStatus.swimming = GetTime()
				SkuOptions.Voice:OutputString("male-Schwimmen", false, true, 0.2)
			end
		else
			SkuStatus.swimming = 0
		end
		if IsMounted() == true then
			if SkuStatus.riding == 0 then
				SkuStatus.riding = GetTime()
				SkuOptions.Voice:OutputString("male-Reiten", false, true, 0.2)
			end
		else
			if SkuStatus.riding > 0 then
				SkuStatus.riding = 0
				SkuOptions.Voice:OutputString("male-Reiten beendet", false, true, 0.2)
			end
		end
		if IsFlying() == true then
			if SkuStatus.flying == 0 then
				SkuStatus.flying = GetTime()
				SkuOptions.Voice:OutputString("male-Fliegen", false, true, 0.2)
			end
		else
			if SkuStatus.flying > 0 then
				SkuStatus.flying = 0
				SkuOptions.Voice:OutputString("Fliegen beendet", false, true, 0.2)
			end
		end

		--close debug panel
		if _G["SkuDebug"] then
			if _G["SkuDebug"]:IsVisible() == true then
				if (GetTime() - tStartDebugTimestamp) > 5 then
					--_G["SkuDebug"]:Hide()
				end
			end
		end

		if SkuCoreMovement then
			if UnitOnTaxi("player") ~= true then

				local tTest = UnitPosition("player")
				if tTest and WorldMapFrame:GetMapID() ~= 947 then
					--due to unknown reasons with tbc WorldMapFrame:GetMapID does not return any value after taxi transfer before the world map was openend at least once
					if C_Map.GetPlayerMapPosition(WorldMapFrame:GetMapID(), "player") == nil then
						WorldMapFrame:Show()
						WorldMapFrame:Hide()
					end
					--dprint(WorldMapFrame:GetMapID())
					if C_Map.GetPlayerMapPosition(WorldMapFrame:GetMapID(), "player") then
						local _, worldPosition = C_Map.GetWorldPosFromMapPos(WorldMapFrame:GetMapID(), C_Map.GetPlayerMapPosition(WorldMapFrame:GetMapID(), "player"))
						local tNewX, tNewY = worldPosition:GetXY()

						if SkuCoreMovement.Flags.MoveForward == true or SkuCoreMovement.Flags.StrafeLeft == true or SkuCoreMovement.Flags.StrafeRight == true or SkuCoreMovement.Flags.MoveBackward == true then
							local _, tDistance = SkuCore:Distance(tNewX, tNewY, SkuCoreMovement.LastPosition.x, SkuCoreMovement.LastPosition.y)
							local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")
							local tMod = currentSpeed / 7

							if IsSwimming() then
								tMod = (currentSpeed / swimSpeed) / runSpeed
							end

							local tSound = 0
							if tDistance < 0.25 * tMod then
								tSound = 1
							elseif tDistance < 0.45 * tMod then
								tSound = 2
							elseif tDistance < 0.60 * tMod then
								tSound = 3
							elseif tDistance < 0.85 * tMod then
								tSound = 4
							elseif tDistance < 1.00 * tMod then
								tSound = 5
							end

							if tSound ~= 0 then
								SkuCoreMovement.counter = SkuCoreMovement.counter + 1
								if SkuCoreMovement.counter > 5 and tSound > 0 then
									SkuCoreMovement.counter = 0
									--dprint(tSound, t * 10000)
									SkuOptions.Voice:OutputString("sound-stuck"..tSound, false, false, 0.8)
								end
							end


							--collect terrain data test
							--[[
							local tExtMap = SkuNav:GetBestMapForUnit("player")
							if not SkuCoreDB.TerrainData then
								SkuCoreDB.TerrainData = {}
							end
							if not SkuCoreDB.TerrainData[tExtMap] then
								SkuCoreDB.TerrainData[tExtMap] = {}
							end
							local function round(val, decimal)
								if (decimal) then
									return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
								else
									return math.floor(val+0.5)
								end
							end
							local tIntX, tIntY = round(tNewX, 0), round(tNewY, 0)
							if not SkuCoreDB.TerrainData[tExtMap][tIntX] then
								SkuCoreDB.TerrainData[tExtMap][tIntX] = {}
							end
							if tSound ~= 0 then
								SkuCoreDB.TerrainData[tExtMap][tIntX][tIntY] = true
							else
								SkuCoreDB.TerrainData[tExtMap][tIntX][tIntY] = false
							end
							]]


						end
						SkuCoreMovement.LastPosition.x, SkuCoreMovement.LastPosition.y = tNewX, tNewY
					end
				end
			end
		end
		ttime = 0
	end)

	local tFrame = _G["SkuCoreControlOption1"] or  CreateFrame("Button", "SkuCoreControlOption1", _G["SkuCoreControl"], "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("SkuCoreControlOption1")
	tFrame:SetPoint("TOP", _G["SkuCoreControl"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnClick", function(self, aKey, aB)
		--dprint("SkuCoreControlOption1", self, aKey, aB)

		if aKey == "CTRL-SHIFT-Y" then
			SkuCore:PanicModeStart()
		end
		
		if SkuCore.inCombat == true then
			--SkuCore.openMenuAfterCombat = true
			return
		end
		if SkuCore.isMoving == true then
			--SkuCore.openMenuAfterMoving = true
			return
		end

		if aKey == "SHIFT-UP" then
			SkuOptions.TTS:PreviousLine()
		end
		if aKey == "SHIFT-DOWN" then
			SkuOptions.TTS:NextLine()
		end
		if aKey == "CTRL-SHIFT-UP" then
			SkuOptions.TTS:PreviousSection()
		end
		if aKey == "CTRL-SHIFT-DOWN" then
			SkuOptions.TTS:NextSection()
		end
	end)
	tFrame:SetScript("OnShow", function(self) 
		--dprint("SkuCoreControlOption1 OnShow")
		if SkuCore.inCombat == true then
			SkuCore.openMenuAfterCombat = true
			return
		end
		if SkuCore.isMoving == true then
			SkuCore.openMenuAfterMoving = true
			return
		end

		SetOverrideBindingClick(self, true, "CTRL-SHIFT-UP", "SkuCoreControlOption1", "CTRL-SHIFT-UP")
		SetOverrideBindingClick(self, true, "CTRL-SHIFT-DOWN", "SkuCoreControlOption1", "CTRL-SHIFT-DOWN")
		SetOverrideBindingClick(self, true, "SHIFT-UP", "SkuCoreControlOption1", "SHIFT-UP")
		SetOverrideBindingClick(self, true, "SHIFT-DOWN", "SkuCoreControlOption1", "SHIFT-DOWN")
	end)
	--SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-X", "SkuCoreControlOption1", "CTRL-SHIFT-X")
	tFrame:SetScript("OnHide", function(self) 
		--dprint("SkuCoreControlOption1 OnHide")
		if SkuCore.inCombat == true then
			return
		end
		ClearOverrideBindings(self)
		SetOverrideBindingClick(tFrame, true, "CTRL-SHIFT-Y", "SkuCoreControlOption1", "CTRL-SHIFT-Y")
	end)
	
	tFrame:Hide()

	--This is because the audio menu overrides most movement keys. 
	--If the player is turning/moving when the audio menu opens it would turn/move until the menu is closed.
	hooksecurefunc("StartAutoRun", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = true end)
	hooksecurefunc("StrafeLeftStart", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = true end)
	hooksecurefunc("StrafeRightStart", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = true end)
	hooksecurefunc("TurnLeftStart", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = true end)
	hooksecurefunc("TurnRightStart", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = true end)
	hooksecurefunc("StopAutoRun", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = false end)
	hooksecurefunc("StrafeLeftStop", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = false end)
	hooksecurefunc("StrafeRightStop", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = false end)
	hooksecurefunc("TurnLeftStop", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = false end)
	hooksecurefunc("TurnRightStop", function() SkuCoreMovement.Flags.IsTurningOrAutorunningOrStrafing = false end)

	--For checking the players state.
	hooksecurefunc("FollowUnit", function() SkuCoreMovement.Flags.FollowUnit = true end)
	hooksecurefunc("MoveForwardStart", function() SkuCoreMovement.Flags.MoveForward = true end)
	hooksecurefunc("MoveForwardStop", function() SkuCoreMovement.Flags.MoveForward = false end)
	hooksecurefunc("MoveBackwardStart", function() SkuCoreMovement.Flags.MoveBackward = true end)
	hooksecurefunc("MoveBackwardStop", function() SkuCoreMovement.Flags.MoveBackward = false end)
	hooksecurefunc("StrafeLeftStart", function() SkuCoreMovement.Flags.StrafeLeft = true end)
	hooksecurefunc("StrafeLeftStop", function() SkuCoreMovement.Flags.StrafeLeft = false end)
	hooksecurefunc("StrafeRightStart", function() SkuCoreMovement.Flags.StrafeRight = true end)
	hooksecurefunc("StrafeRightStop", function() SkuCoreMovement.Flags.StrafeRight = false end)
	--hooksecurefunc("TurnLeftStart", function() dprint("TurnLeftStartf") end)
	--hooksecurefunc("TurnLeftStop", function() dprint("TurnLeftStopf") end)
	--hooksecurefunc("TurnRightStart", function() dprint("TurnRightStartf") end)
	--hooksecurefunc("TurnRightStop", function() dprint("TurnRightStopf") end)
	hooksecurefunc("ToggleRun", function()
		--dprint("ToggleRun")
		if SkuStatus.running > 0 then
			SkuStatus.running = 0
			SkuStatus.walking = GetTime()
			SkuOptions.Voice:OutputString("male-Gehen", false, true, 0.2)
		elseif SkuStatus.walking > 0 then
			SkuStatus.running = GetTime()
			SkuStatus.walking = 0
			SkuOptions.Voice:OutputString("male-Laufen", false, true, 0.2)
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_DEAD(...)
	--dprint("PLAYER_DEAD", ...)
	--dprint("UnitIsDead", UnitIsDead("player"))
end
function SkuCore:AUTOFOLLOW_BEGIN(event, target, ...)
	--dprint("AUTOFOLLOW_BEGIN", event, target, ...)
	SkuStatus.followEndFlag = false
	SkuStatus.followUnitName = target or UnitName("TARGET")
	if SkuStatus.follow == 0 then
		SkuStatus.followUnitName = target or UnitName("TARGET")
		SkuStatus.follow = GetTime()
		if SkuOptions.db.profile[MODULE_NAME].autoFollow == true then
			SkuStatus.followUnitId = ""
			SkuStatus.followUnitName = ""
			local tTargetName = UnitName("TARGET")
			for x = 1, 40 do
				local tUnitName = UnitName("RAID"..x)
				if tUnitName == tTargetName then
					SkuStatus.followUnitId = "RAID"..x
				end
			end			
			for x = 1, 5 do
				local tUnitName = UnitName("PARTY"..x)
				if tUnitName == tTargetName then
					SkuStatus.followUnitId = "PARTY"..x
				end
			end
		end
		--C_Timer.After(0.1, function()
			--if SkuStatus.follow ~= 0 then
				--SkuOptions.Voice:OutputString("male-Folgen", false, true, 0.2)
			--end
		--end)
	end
	SkuOptions.Voice:OutputString("male-Folgen", false, true, 0.2)
	SkuOptions:SendTrackingStatusUpdates("F-1")
	if SkuStatus.followUnitName then
		SkuOptions:SendTrackingStatusUpdates("FN-"..SkuStatus.followUnitName)
	end
end
function SkuCore:AUTOFOLLOW_END(event, ...)
	--dprint("AUTOFOLLOW_END")
	SkuStatus.followEndFlag = true
	C_Timer.After(0.1, function()
		if SkuStatus.followEndFlag == true then
			if SkuStatus.follow ~= 0 then
				SkuStatus.follow = 0
				if SkuStatus.follow == 0 then
					SkuOptions.Voice:OutputString("male-Folgen beendet", false, true, 0.2)
					SkuStatus.followUnitName = ""
				end
				if SkuStatus.followUnitId then
					if SkuStatus.followUnitId ~= "" then
						if SkuCore.inCombat == false then
							--SkuStatus.followUnitId = ""
						end
					end
				end
				SkuOptions:SendTrackingStatusUpdates("F-4")
				SkuOptions:SendTrackingStatusUpdates("FN-")
			end
		end
	end)
end
function SkuCore:PLAYER_UPDATE_RESTING(...)
	--dprint("PLAYER_UPDATE_RESTING", ...)
end
function SkuCore:UPDATE_STEALTH(eventName, ...)--ok
	--dprint("UPDATE_STEALTH", eventName, ...)
	if IsStealthed() == true then
		SkuStatus.stealth = GetTime()
		SkuOptions.Voice:OutputString("male-Verstohlenheit", false, true, 0.2)
	else
		SkuStatus.stealth = 0
	end
end
--SkuOptions.Voice:OutputString("Verstohlenheit;beendet", true, true, nil, true)

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:BAG_UPDATE(...)
	--dprint("BAG_UPDATE", ...)
end
function SkuCore:ITEM_LOCK_CHANGED(...)
	--dprint("ITEM_LOCK_CHANGED", ...)
end
function SkuCore:ITEM_UNLOCKED(...)
	--dprint("ITEM_UNLOCKED", ...)
end
--function SkuCore:CURSOR_CHANGED(...)
	--print("CURSOR_CHANGED", ...)
--end

---------------------------------------------------------------------------------------------------------------------------------------
local PLAYER_CONTROL_LOST_flag = 0
local PLAYER_MOUNT_DISPLAY_CHANGED_flag = 0
local PLAYER_CONTROL_GAINED_flag = 0
function SkuCore:PLAYER_CONTROL_LOST(...)--taxi
	--dprint("PLAYER_CONTROL_LOST", ...)
	PLAYER_CONTROL_LOST_flag = 1
	PLAYER_CONTROL_GAINED_flag = 0
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_MOUNT_DISPLAY_CHANGED(...)--taxi
	--dprint("PLAYER_MOUNT_DISPLAY_CHANGED", ...)
	if PLAYER_CONTROL_LOST_flag == 1 then
		PLAYER_CONTROL_LOST_flag = 0
		SkuOptions.Voice:OutputString(L["taxi;started"], true, true, nil, true)
	end
	if PLAYER_CONTROL_GAINED_flag == 1 then
		PLAYER_CONTROL_GAINED_flag = 0
		SkuOptions.Voice:OutputString(L["taxi;ended"], true, true, nil, true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_CONTROL_GAINED(...)--taxi
	--dprint("PLAYER_CONTROL_GAINED", ...)
	PLAYER_CONTROL_GAINED_flag = 1
	PLAYER_CONTROL_LOST_flag = 0
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:OnDisable()
	-- Called when the addon is disabled

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:RefreshVisuals()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:VARIABLES_LOADED(...)
    -- process the event
	--dprint(...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TaxiFrame_OnShow(self)
	--dprint("SkuCore:TaxiFrame_OnShow", self)
	SkuCore:CheckFrames()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TaxiFrame_OnHide(self)
	--dprint("SkuCore:TaxiFrame_OnHide", self)
	SkuCore:CheckFrames()
end

---------------------------------------------------------------------------------------------------------------------------------------
local function splitString(aString)
	--dprint("split:", aString, SkuAudioFileIndex[aString])
	if SkuAudioFileIndex[aString] then
		return aString
	end
	if aString == nil then
		return ""
	end

	if aString == "" then
		return  aString
	end

	aString = string.gsub(aString, "%.", " ")
	aString = string.gsub(aString, "%(", " ")
	aString = string.gsub(aString, "%)", " ")
	aString = string.gsub(aString, ",", " ")
	aString = string.gsub(aString, "!", " ")
	aString = string.gsub(aString, ":", ";")
	aString = string.gsub(aString, "%-", ";")
	aString = string.gsub(aString, "\'", ";")
	aString = string.gsub(aString, "/", ";")
	aString = string.gsub(aString, "%\"", ";")
	aString = string.gsub(aString, "'", ";")
	aString = string.gsub(aString, "&", ";")
	aString = string.gsub(aString, " ", ";")
	aString = string.gsub(aString, ";;", ";")
	aString = string.gsub(aString, ";;", ";")
	aString = string.gsub(aString, ";;", ";")
	aString = string.gsub(aString, ";;", ";")
	if string.sub(aString, string.len(aString)) == ";" then
		aString = string.sub(aString, 1, string.len(aString)-1)
	end
	return aString
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:StaticPopup_Hide(which, text_arg1, text_arg2, data, insertedFrame)
	--dprint("StaticPopup_Hide", which, text_arg1, text_arg2, data, insertedFrame)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:StaticPopup_Show(which, text_arg1, text_arg2, data, insertedFrame)
	--dprint("StaticPopup_Show", which, text_arg1, text_arg2, data, insertedFrame)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameProgressPanel_OnShow(...)
	--dprint("QuestFrameProgressPanel_OnShow", ...)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameProgressPanel_OnHide(...)
	--dprint("QuestFrameProgressPanel_OnHide", ...)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameDetailPanel_OnShow(...)
	--dprint("QuestFrameDetailsPanel_OnShow", ...)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameDetailPanel_OnHide(...)
	--dprint("QuestFrameDetailsPanel_OnHide", ...)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_LOGIN(...)
	--dprint("PLAYER_LOGIN", ...)
	SkuCore.TalentTempFlag = true

	local f = CreateFrame("GameTooltip", "SkuScanningTooltip"); -- Tooltip name cannot be nil
	SkuScanningTooltip = f
	f:SetOwner(WorldFrame, "ANCHOR_NONE");
	f:AddFontStrings(f:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ), f:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ))

	--we need to do that to have all craftframe elementes available on first use; otherwise it won't be complete on first open, as the data from the server take a few ms
	UIParentLoadAddOn("Blizzard_CraftUI")
	CraftFrame:Show()
	CraftFrame:Hide()

end

---------------------------------------------------------------------------------------------------------------------------------------
local unfollowOnCastWasOnFollowUnitName = nil
function SkuCore:UnfollowOnCast()
	dprint("UnfollowOnCast", unfollowOnCastWasOnFollowUnitName)
	if SkuOptions.db.profile[MODULE_NAME].endFollowOnCast == true and SkuStatus.followUnitName ~= "" then
		unfollowOnCastWasOnFollowUnitName = SkuStatus.followUnitName
		FollowUnit("player")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:FollowOnCast()
	dprint("UnfollowOnCast", unfollowOnCastWasOnFollowUnitName)
	if SkuOptions.db.profile[MODULE_NAME].endFollowOnCast == true and unfollowOnCastWasOnFollowUnitName then
		if UnitName("TARGET") == unfollowOnCastWasOnFollowUnitName then
			FollowUnit("TARGET")
		end
		for x = 1, 40 do
			local tUnitName = UnitName("RAID"..x)
			if tUnitName == unfollowOnCastWasOnFollowUnitName then
				FollowUnit("RAID"..x)
			end
		end			
		for x = 1, 5 do
			local tUnitName = UnitName("PARTY"..x)
			if tUnitName == unfollowOnCastWasOnFollowUnitName then
				FollowUnit("PARTY"..x)
			end
		end
		unfollowOnCastWasOnFollowUnitName = nil
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_SPELLCAST_START(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent, aUnitTarget, aCastGUID, aSpellID)
	if aUnitTarget == "player" and SkuCore.inCombat == false then
		SkuOptions.Voice:OutputString(L["cast"], true, true, 0.2)
	end
	if aUnitTarget == "player" then
		SkuCore:UnfollowOnCast()
	end
end
function SkuCore:UNIT_SPELLCAST_CHANNEL_START(aEvent, unitTarget, castGUID, spellID)
	dprint(aEvent)
	if aUnitTarget == "player" then
		SkuCore:UnfollowOnCast()
	end
end
function SkuCore:UNIT_SPELLCAST_STOP(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent)
	if aUnitTarget == "player" then
		SkuCore:FollowOnCast()
	end
end
function SkuCore:UNIT_SPELLCAST_CHANNEL_STOP(aEvent, unitTarget, castGUID, spellID)
	dprint(aEvent)
	if aUnitTarget == "player" then
		SkuCore:FollowOnCast()
	end
end
function SkuCore:UNIT_SPELLCAST_CHANNEL_UPDATE(aEvent, unitTarget, castGUID, spellID)
	dprint(aEvent)
end
function SkuCore:UNIT_SPELLCAST_DELAYED(aEvent, unitTarget, castGUID, spellID)
	dprint(aEvent)
end
function SkuCore:UNIT_SPELLCAST_FAILED(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent)
end
function SkuCore:UNIT_SPELLCAST_FAILED_QUIET(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent)
end
function SkuCore:UNIT_SPELLCAST_INTERRUPTED(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent)
end
function SkuCore:UNIT_SPELLCAST_SUCCEEDED(aEvent, aUnitTarget, aCastGUID, aSpellID)
	dprint(aEvent)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CURRENT_SPELL_CAST_CHANGED(aCancelledCast)
	local nameCn, text, texture, startTime, endTime, isTradeSkill, spellID = ChannelInfo()
	local namec, text, texture, startTime, endTime, isTradeSkill, castID, spellID = CastingInfo() -- bcc
	if nameCn or namec then
		SkuStatus.casting = 1
		SkuOptions:SendTrackingStatusUpdates("C-1")
	else
		SkuStatus.casting = 0
		SkuOptions:SendTrackingStatusUpdates("C-4")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_POWER_UPDATE(eventName, unitType)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_HAPPINESS(unitTarget)

end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuDropdownlistGenericFlag = false
function SkuCore:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...
	dprint("PLAYER_ENTERING_WORLD", isInitialLogin, isReloadingUi)

	SkuOptions.db.global[MODULE_NAME] = SkuOptions.db.global[MODULE_NAME] or {}
	SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
	SkuOptions.db.char["SkuAuras"] = SkuOptions.db.char["SkuAuras"] or {}

	if SkuOptions.db.char["SkuAuras"].AurasPost22_7 == true then
		SkuOptions.db.char[MODULE_NAME].IsFirstCharLogin = false
		SkuOptions.db.global[MODULE_NAME].IsFirstAccountLogin = false
	end

	if SkuOptions.db.char[MODULE_NAME].IsFirstCharLogin ~= false then

		if SkuOptions.db.global[MODULE_NAME].IsFirstAccountLogin ~= false then
			--this is the first load of wow ever
			--set up account wide things
			C_CVar.SetCVar("autoLootDefault", "1")
			C_CVar.SetCVar("alwaysShowActionBars", "1")
			C_CVar.SetCVar("cameraSmoothStyle", "2")
			C_CVar.GetCVar("removeChatDelay", "1")

			LoadBindings(ACCOUNT_BINDINGS) 
			SaveBindings(1)
			SkuCore:ResetBindings()

			SkuOptions.db.global[MODULE_NAME].IsFirstAccountLogin = false
		end

		--first load with character
		--set up char specific things
		TRAINER_FILTER_AVAILABLE = 1 
		TRAINER_FILTER_UNAVAILABLE = 0 
		TRAINER_FILTER_USED = 0
		SetActionBarToggles(1,1,1,1,1) 
		SHOW_MULTI_ACTIONBAR_1 = 1 
		SHOW_MULTI_ACTIONBAR_2 = 1 
		SHOW_MULTI_ACTIONBAR_3 = 1 
		SHOW_MULTI_ACTIONBAR_4 = 1 
		MultiActionBar_Update() 
		UIParent_ManageFramePositions() 
		LoadBindings(ACCOUNT_BINDINGS) 
		SaveBindings(1)
		SkuOptions.db.char[MODULE_NAME].IsFirstCharLogin = false
		
	end

	if isInitialLogin == true or isReloadingUi == true then
		WorldMapFrame:Show()
		WorldMapFrame:Hide()

		hooksecurefunc(TaxiFrame, "Show", SkuCore.TaxiFrame_OnShow)
		hooksecurefunc(TaxiFrame, "Hide", SkuCore.TaxiFrame_OnHide)
		
		MainMenuBarBackpackButton:Click()
		MainMenuBarBackpackButton:Click()

		if SkuCore.TalentTempFlag == true then
			_G["TalentMicroButton"]:Click()
		end
		
		C_Timer.NewTimer(1, function()
			if SkuCore.TalentTempFlag == true then
				_G["TalentMicroButton"]:Click()
			end
			
			for x = 1, #SkuCore.interactFramesList do
				if _G[SkuCore.interactFramesList[x]] then
					hooksecurefunc(_G[SkuCore.interactFramesList[x]], "Show", function(self, a, b, c, d, e) 
						SkuDropdownlistGenericFlag = true 
						SkuCore.GENERIC_OnOpen(self, a, b, c, d, e) 
					end)
					hooksecurefunc(_G[SkuCore.interactFramesList[x]], "Hide", function(self, a, b, c, d, e) 
						if SkuDropdownlistGenericFlag == true then 
							SkuDropdownlistGenericFlag = false 
							SkuCore.GENERIC_OnClose(self, a, b, c, d, e) 
						end 
					end)
					SkuCore.interactFramesListHooked[SkuCore.interactFramesList[x]] = true
				end
			end
			SkuCore.TalentTempFlag = false
		end)


		for x = 1, 5 do
			if _G["StaticPopup"..x] then
				hooksecurefunc(_G["StaticPopup"..x], "Show", SkuCore.StaticPopup_Show)
				hooksecurefunc(_G["StaticPopup"..x], "Hide", SkuCore.StaticPopup_Hide)
			end
		end

		hooksecurefunc(QuestFrameProgressPanel, "Show", SkuCore.QuestFrameProgressPanel_OnShow)
		hooksecurefunc(QuestFrameProgressPanel, "Hide", SkuCore.QuestFrameProgressPanel_OnHide)
		hooksecurefunc(QuestFrameDetailPanel, "Show", SkuCore.QuestFrameDetailPanel_OnShow)
		hooksecurefunc(QuestFrameDetailPanel, "Hide", SkuCore.QuestFrameDetailPanel_OnHide)
		hooksecurefunc(QuestFrameGreetingPanel, "Show", SkuCore.QuestFrameGreetingPanel_OnShow)
		hooksecurefunc(QuestFrameGreetingPanel, "Hide", SkuCore.QuestFrameGreetingPanel_OnHide)

		for x = 1, 10 do
			if _G["GroupLootFrame"..x] then
				_G["GroupLootFrame"..x]:SetParent(_G["GroupLootContainer"])
			end
		end

		--SkuCore:ItemRatingOnLogin()

		SkuCore:AuctionHouseOnLogin()
		if not SkuOptions.db.char[MODULE_NAME] then
			SkuOptions.db.char[MODULE_NAME] = {}
		end
		if not SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter then
			SkuOptions.db.char[MODULE_NAME].AuctionCurrentFilter = {
				["LevelMin"] = nil,
				["LevelMax"] = nil,
				["MinQuality"] = nil,
				["Usable"] = nil,
				["SortBy"] = 1,
			}
		end

		SkuOptions.db.factionrealm[MODULE_NAME] = SkuOptions.db.factionrealm[MODULE_NAME] or {}
		SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDB or {}
		SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory = SkuOptions.db.factionrealm[MODULE_NAME].AuctionDBHistory or {}

		SkuCore:JunkAndRepairInitialize()

		SkuCore:UpdateInteractMove(true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_REGEN_DISABLED(...)
	SkuOptions:CloseMenu()
	_G["SkuCoreControlOption1"]:Hide()
	SkuCore.inCombat = true
	SkuOptions.Voice:OutputString(L["Combat start"], true, true, 0.2)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PLAYER_REGEN_ENABLED(...)
	SkuCore.inCombat = false
	SkuOptions.Voice:OutputString(L["Combat end"], true, true, 0.2)
	if SkuOptions.db.profile[MODULE_NAME].autoFollow == true then
		if SkuStatus.followUnitId then
			if SkuStatus.followUnitId ~= "" then
				FollowUnit(SkuStatus.followUnitId)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameGreetingPanel_OnShow(...)
	--dprint("QuestFrameGreetingPanel_OnShow", self, event, ...)
	SkuCore:CheckFrames()
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestFrameGreetingPanel_OnHide(...)
	--dprint("QuestFrameGreetingPanel_OnHide", self, event, ...)
	SkuCore:CheckFrames()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GOSSIP_SHOW(self, event, ...)
	--dprint("GOSSIP_SHOW", self, event, ...)
	SkuOptions:StopSounds(5)
	SkuCore:CheckFrames()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GossipFrameAvailableQuestsUpdate(...)
	local titleIndex = 1;

	for i=1, select("#", ...), 7 do
		local titleButton = _G["GossipTitleButton" .. SkuCore.GossipFramebuttonIndex];
		local titleText, level, isTrivial, frequency, isRepeatable, isLegendary, isIgnored = select(i, ...);
		SkuCore.tGossipList[SkuCore.GossipFramebuttonIndex] = L["Quest;available"]..";"..splitString(titleText)
		SkuCore.GossipFramebuttonIndex = SkuCore.GossipFramebuttonIndex + 1;
		titleIndex = titleIndex + 1;
	end

	if ( SkuCore.GossipFramebuttonIndex > 1 ) then
		SkuCore.GossipFramebuttonIndex = SkuCore.GossipFramebuttonIndex + 1;
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GossipFrameActiveQuestsUpdate(...)
	local titleButton;
	local titleIndex = 1;
	local titleButtonIcon;
	local numActiveQuestData = select("#", ...);
	GossipFrame.hasActiveQuests = (numActiveQuestData > 0);
	for i=1, numActiveQuestData, 6 do
		titleButton = _G["GossipTitleButton" .. SkuCore.GossipFramebuttonIndex];
		titleButton:SetFormattedText(NORMAL_QUEST_DISPLAY, select(i, ...));
		SkuCore.tGossipList[SkuCore.GossipFramebuttonIndex] = L["Quest;aktive"]..";"..splitString(select(i, ...))
		SkuCore.GossipFramebuttonIndex = SkuCore.GossipFramebuttonIndex + 1;
		titleIndex = titleIndex + 1;
	end

	if ( titleIndex > 1 ) then
		titleButton = _G["GossipTitleButton" .. GossipFrame.buttonIndex];
		SkuCore.GossipFramebuttonIndex = SkuCore.GossipFramebuttonIndex + 1;
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GossipFrameOptionsUpdate(...)
	local titleButton
	local titleIndex = 1
	local titleButtonIcon
	for i = 1, select("#", ...), 2 do
		titleButton = _G["GossipTitleButton" .. SkuCore.GossipFramebuttonIndex]
		SkuCore.tGossipList[SkuCore.GossipFramebuttonIndex] = L["Option"]..";"..splitString(select(i, ...))
		SkuCore.GossipFramebuttonIndex = SkuCore.GossipFramebuttonIndex + 1;
		titleIndex = titleIndex + 1
		titleButton:Show()
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GOSSIP_CLOSED(self, event, ...)
	--dprint("GOSSIP_CLOSED")
	SkuCore:CheckFrames()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QUEST_DETAIL(...)
	--dprint("QUEST_DETAIL")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QUEST_FINISHED(...)
	--dprint("QUEST_FINISHED")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MERCHANT_SHOW(...)
	--dprint("MERCHANT_SHOW")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MERCHANT_CLOSED(...)
	--dprint("MERCHANT_CLOSED")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PET_STABLE_SHOW(...)
	--dprint("PET_STABLE_SHOW")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:PET_STABLE_CLOSED(...)
	--dprint("PET_STABLE_CLOSED")
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QUEST_LOG_UPDATE(self, event, ...)
	--dprint("QUEST_LOG_UPDATE", self, event, ...)
end

---------------------------------------------------------------------------------------------------------------------------------------
local GENERIC_OnOpenFlag = false
function SkuCore:GENERIC_OnOpen(self)
	if GENERIC_OnOpenFlag ~= false then return end

	GENERIC_OnOpenFlag = true
	C_Timer.After(0.1, function() 
		SkuCore:CheckFrames()
		SkuOptions:StopSounds(5)
		SkuOptions:SendTrackingStatusUpdates()
		GENERIC_OnOpenFlag = false
	end)
end
--[[
function SkuCore:GENERIC_OnOpen(self)
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
	--SkuStatus.interacting = GetTime()
	SkuOptions:SendTrackingStatusUpdates()
end
]]
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:GENERIC_OnClose(self)
	SkuCore:CheckFrames()
	SkuOptions:SendTrackingStatusUpdates()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TALENTFRAME_OnOpen(self)
	--dprint("TALENTFRAME_OnOpen", self)
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TALENTFRAME_OnClose(self)
	SkuCore:CheckFrames()
	SkuOptions:StopSounds(5)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:Debug(text, clear)
	clear = true

	if skudebuglevel == 0 then
		return
	end

	if not text then
		return
	end
	if not _G["SkuDebug"] then
		local f = _G["SkuDebug"] or CreateFrame("Frame", "SkuDebug", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		local ttime = 0
		--f:SetMovable(true)
		--f:EnableMouse(true)
		f:SetClampedToScreen(true)
		--f:RegisterForDrag("LeftButton")
		f:SetFrameStrata("DIALOG")
		f:SetFrameLevel(129)
		f:SetSize(1000, 40)
		f:SetPoint("TOP", UIParent, "TOP")
		f:SetPoint("LEFT", UIParent, "LEFT")
		f:SetPoint("RIGHT", UIParent, "RIGHT", -300, 0)
		f:SetBackdrop({bgFile = [[Interface\ChatFrame\ChatFrameBackground]], edgeFile = "", tile = false, tileSize = 0, edgeSize = 32, insets = {left = 0, right = 0, top = 0, bottom = 0}})
		f:SetBackdropColor(0, 0, 0, 1)
		f:SetScript("OnDragStart", function(self) self:StartMoving() end)
		f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
		f:Show()
		local fs = f:CreateFontString("SkuDebugFS")
		fs:SetFontObject(SystemFont_Large)
		fs:SetTextColor(1, 1, 1, 1)
		fs:SetJustifyH("LEFT")
		fs:SetJustifyV("TOP")
		fs:SetAllPoints()
		fs:SetText("\r\n")
	end

	_G["SkuDebug"]:Show()

	if string.len(_G["SkuDebugFS"]:GetText()) > 500 then
		_G["SkuDebugFS"]:SetText("")
	end

	if not clear then
		_G["SkuDebugFS"]:SetText(text.."\r\n".._G["SkuDebugFS"]:GetText())
	else
		_G["SkuDebugFS"]:SetText(text)
	end

	tStartDebugTimestamp = GetTime()
end

---------------------------------------------------------------------------------------------------------------------------------------
local tButtonsWoFontstrings = {
	PrevPage = L["Previous"],
	NextPage = L["Next"],
	MoneyFrameCopper = L["Copper"],
	MoneyFrameSilver = L["Silver"],
	MoneyFrameGold = L["Gold"],
	FrameTab = L["Tab"],
	CollapseAll = L["Collapse all"],
	NextPageButton = L["Next"],
	PrevPageButton = L["Previous"],
	CloseButton = L["Close"],
	}

local validTypes = {
	Frame = true,
	Button = true,
	FontString = true,
	ScrollFrame = true,
}

local blockedWidgetStrings = {
	["Schlachtzugszielsymbol"] = true,
	["Fokus setzen"] = true,
	["Freund hinzufügen"] = true,
	["Fenster verschieben"] = true,
	["Spieler melden wegen:"] = true,
}

local friendlyFrameNames = {
	["CraftFrame"] = L["Crafting"],
	["GroupLootContainer"] = L["Loot roll"],
	["InspectFrame"] = L["Inspect"],
	["QuestFrame"] = L["Quest"],
	["TaxiFrame"] = L["Taxi"],
	["GossipFrame"] = L["Gossip"],
	["MerchantFrame"] = L["Merchant"],
	["StaticPopup1"] = L["Popup 1"],
	["StaticPopup2"] = L["Popup 2"],
	["StaticPopup3"] = L["Popup 3"],
	["PetStableFrame"] = L["Pet Stable"],
	["MailFrame"] = L["Mail"],
	["ContainerFrame1"] = L["Bag 1"],
	["ContainerFrame2"] = L["Bag 2"],
	["ContainerFrame3"] = L["Bag 3"],
	["ContainerFrame4"] = L["Bag 4"],
	["ContainerFrame5"] = L["Bag 5"],
	["ContainerFrame6"] = L["Bag 6"],
	["DropDownList2"] = L["Dropdown List 2"],
	["DropDownList1"] = L["Dropdown List 1"],
	["TalentFrame"] = L["Talents"],
	["SendMailFrame"] = L["Send Mail"],
	["AuctionFrame"] = L["Auction house"],
	["ClassTrainerFrame"] = L["Class Trainer"],
	["CharacterFrame"] = L["Character"],
	["ReputationFrame"] = L["Reputation"],
	["SkillFrame"] = L["Skills"],
	["HonorFrame"] = L["Honor"],
	["BagnonInventoryFrame1"] = L["Bagnon Taschen"],
	["SpellBookFrame"] = L["Spellbook"],
	["PlayerTalentFrame"] = L["Talents"],
	["FriendsFrame"] = L["Friends"],
	["TradeFrame"] = L["Trade"],
	--["GameMenuFrame"] = L["Game Menu"],
	--["MainMenuBar"] = "",
	--["MultiBarLeft"] = "",
	--["MultiBarRight"] = "",
	--["MultiBarBottomLeft"] = "",
	--["MultiBarBottomRight"] = "",
	["BagnonGuildFrame1"] = L["Bagnon Guild"],
	["BagnonBankFrame1"] = L["Bagnon Bank"],
	["BankFrame"] = L["Bank"],
	["GuildBankFrame"] = L["Guild Bank"],
	["TradeSkillFrame"] = L["Trade skill"],
	[""] = "",
}
local containerFrames = {
	["BagnonInventoryFrame1"] = "BagnonInventoryFrame1",
	["BagnonBankFrame1"] = "BagnonBankFrame1",
	["ContainerFrame1"] = "ContainerFrame1",
	["ContainerFrame2"] = "ContainerFrame2",
	["ContainerFrame3"] = "ContainerFrame3",
	["ContainerFrame4"] = "ContainerFrame4",
	["ContainerFrame5"] = "ContainerFrame5",

}
local friendlyFrameNamesParts = {
	["FrameGreetingPanel"] = L["Panel"],
	["GreetingScrollFrame"] = L["Sub panel"],
	["DetailPanel"] = L["Details"] ,
	["DetailScrollFrame"] = L["Details panel"],
	["ScrollFrame"] = L["Sub panel"],
	["RewardsFrame"] = L["Rewards"],
	["MoneyFrame"] = L["Money"],
	["PaperDollFrame"] = L["Equiment"] ,
	["CharacterAttributesFrame"] = L["Attributes"],
	["CharacterResistanceFrame"] = L["Resistance"],
	["PaperDollItemsFrame"] = L["Items"],
	["ProgressPanel"] = L["Progress"],
}

---------------------------------------------------------------------------------------------------------------------------------------
local function GetTableID(aTable)
	--dprint(aTable:GetName(), aTable.name, tostring(aTable):gsub("table: ", "", 1))
	return aTable:GetName() or aTable.name or tostring(aTable):gsub("table: ", "", 1)
end

---------------------------------------------------------------------------------------------------------------------------------------
local maxItemNameLength = 40
local function ItemName_helper(aText)
	aText = unescape(aText)
	local tShort, tLong = aText, ""

	local tStart, tEnd = string.find(tShort, "\r\n")
	local taTextWoLb = aText
	if tStart then
		taTextWoLb = string.sub(tShort, 1, tStart - 1)
		tLong = aText
	end

	if string.len(taTextWoLb) > maxItemNameLength then
		local tBlankPos = 1
		while (string.find(taTextWoLb, " ", tBlankPos + 1) and tBlankPos < maxItemNameLength) do
			tBlankPos = string.find(taTextWoLb, " ", tBlankPos + 1)
		end
		if tBlankPos > 1 then
			tShort = string.sub(taTextWoLb, 1, tBlankPos).."..."
		else
			tShort = string.sub(taTextWoLb, 1, maxItemNameLength).."..."
		end		
		tLong = aText
	else
		tShort = taTextWoLb
	end

	return string.gsub(tShort, "\r\n", " "), tLong
end

---------------------------------------------------------------------------------------------------------------------------------------
local function TooltipLines_helper(...)
	local rText = ""
   for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				rText = rText..text.."\r\n"
			end
		end
	end
	return rText
end

---------------------------------------------------------------------------------------------------------------------------------------
local function IterateChildren(t, tab)
	local tResults = {}

	--dprint(tab, "Regions of", GetTableID(t), t:GetName())
	if t.GetRegions then
		local dtc = { t:GetRegions() }
		for x = 1, #dtc do
			if validTypes[dtc[x]:GetObjectType()] then
				if dtc[x]:IsVisible() == true then
					local fName = GetTableID(dtc[x])
					--dprint(tab, fName, dtc[x]:GetObjectType())
					table.insert(tResults, fName)
					tResults[fName] = {
						frameName = fName,
						RoC = "Region",
						type = dtc[x]:GetObjectType(),
						childs = {},
						obj = dtc[x],
						textFirstLine = "",
						textFull = "",
					}
					if dtc[x].GetText then
						if dtc[x]:GetText() then
							local tText = unescape(dtc[x]:GetText())
							tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
							if tResults[fName].type == "Button" then
								tResults[fName].textFirstLine = tResults[fName].textFirstLine
							end
						end
					end

					local tChildsResult = IterateChildren(dtc[x], tab.."-")
					if #tChildsResult == 1 then
						tResults[fName].childs = tChildsResult[tChildsResult[1]].childs
					elseif #tChildsResult > 1 then
						tResults[fName].childs = tChildsResult
					end
					if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" then
						--[[for q = 1, #tButtonsWoFontstrings do
							if string.find(fName, tButtonsWoFontstrings[q]) then
								local tText = tButtonsWoFontstrings[q]
								tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
							end
						end
						]]
						if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" and #tResults[fName].childs == 0 then
							tResults[fName] = nil
							table.remove(tResults, #tResults)
						end
					end
				end
			end
		end
	end

	--dprint(tab, "Children of", GetTableID(t), t:GetName())
	if t.GetChildren then
		local dtc = { t:GetChildren() }

		if t:GetName() == "GroupLootFrame1" then
			--dprint(tab.."   ", t:GetName(), t.NeedButton, t.NeedButton:GetObjectType())
			dtc = { t.IconFrame, t.NeedButton, t.GreedButton, t.PassButton }
		end
		local tEmptyCounter = 1
		for x = 1, #dtc do
			--dprint(tab, x, dtc[x])
			if validTypes[dtc[x]:GetObjectType()] then
				if dtc[x]:IsVisible() == true then
					local tEnabled = true
					if dtc[x].IsEnabled then tEnabled = dtc[x]:IsEnabled() end
					if tEnabled == true then
						local fName = GetTableID(dtc[x])
						--dprint(tab.."   ", fName, dtc[x]:GetObjectType())
						table.insert(tResults, fName)
						tResults[fName] = {
							frameName = fName,
							RoC = "Child",
							type = dtc[x]:GetObjectType(),
							obj = dtc[x],
							textFirstLine = "",
							textFull = "",
							childs = {},
							}
						--get the onclick func if there is one
						if tResults[fName].obj:IsMouseClickEnabled() == true then
							if tResults[fName].obj:GetObjectType() == "Button" then
								tResults[fName].func = tResults[fName].obj:GetScript("OnClick")
							end
							tResults[fName].containerFrameName = fName
							tResults[fName].onActionFunc = function(self, aTable, aChildName)
								--empty
							end
							if tResults[fName].func then
								tResults[fName].click = true
							end
						end
						--text from fs available?
						if dtc[x].GetText then
							if dtc[x]:GetText() then
								local tText = unescape(dtc[x]:GetText())
								tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
							end
						end

						--text from tooltip available?
						if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" then
							if string.find(fName, "ContainerFrame") then
								_G["SkuScanningTooltip"]:ClearLines()
								local hsd, rc = _G["SkuScanningTooltip"]:SetBagItem(tResults[fName].obj:GetParent():GetID(), tResults[fName].obj:GetID())
								if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
									if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
										local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
										
										if tResults[fName].obj.info.id then
											tResults[fName].textFirstLine = ItemName_helper(tText)
											tResults[fName].textFull = SkuCore:AuctionPriceHistoryData(tResults[fName].obj.info.id, true, true)
										end
										if not tResults[fName].textFull then
											tResults[fName].textFull = {}
										end
										local tFirst, tFull = ItemName_helper(tText)
										tResults[fName].textFirstLine = tFirst
										table.insert(tResults[fName].textFull, 1, tFull)
									end
								end

								if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" and tResults[fName].obj.ShowTooltip then
									GameTooltip:ClearLines()
									tResults[fName].obj:ShowTooltip()
									if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
										if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
											local tText = unescape(TooltipLines_helper(GameTooltip:GetRegions()))
											tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
										end
									end
								end

							elseif string.find(fName, "ItemButton") and string.find(fName, "MerchantItem") then
								_G["SkuScanningTooltip"]:ClearLines()
								local hsd, rc = _G["SkuScanningTooltip"]:SetMerchantItem(tResults[fName].obj:GetID())
								if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
									if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
										local tText = unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
										tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
									end
								end
							else
								GameTooltip:ClearLines()
								if tResults[fName].obj:GetScript("OnEnter") then
									tResults[fName].obj:GetScript("OnEnter")(tResults[fName].obj)
								end
								if TooltipLines_helper(GameTooltip:GetRegions()) ~= "asd" then
									if TooltipLines_helper(GameTooltip:GetRegions()) ~= "" then
										local tText = unescape(TooltipLines_helper(GameTooltip:GetRegions()))
										tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
									end
								end
								GameTooltip:SetOwner(UIParent, "Center")
								GameTooltip:Hide()
								if tResults[fName].obj:GetScript("OnLeave") then
									tResults[fName].obj:GetScript("OnLeave")(tResults[fName].obj)
								end
							end
						end

						--iterate children if there are any
						if dtc[x] then
							if (dtc[x]:GetNumRegions() + dtc[x]:GetNumChildren()) > 0 then
								local tChildsResult = IterateChildren(dtc[x], tab.."-")
								--if there is only one child, set its content directly to this item; except it's a money frame, then there may just one item
								if #tChildsResult == 1 and not string.find(fName, "Money") then
									--dprint("+++++ #tChildsResult == 1")
									tResults[fName].childs = tChildsResult[tChildsResult[1]].childs
								--otherwise add them to childs
								elseif #tChildsResult > 1 or string.find(fName, "Money") then
									--dprint("+++++ #tChildsResult > 1")
									tResults[fName].childs = tChildsResult
								end
							end
						end

						--check if there are buttons w/o text and childs with string in first item
						--if: move string from child[1] to parent
						if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" and #tResults[fName].childs > 0 then
							if tResults[fName].childs[tResults[fName].childs[1]].type == "FontString" then
								local tFlag = true
								if string.len(tResults[fName].childs[tResults[fName].childs[1]].textFirstLine) > maxItemNameLength then
									tFlag = false
								end
								if #tResults[fName].childs > 1 then
									for q = 2, #tResults[fName].childs do
										if tResults[fName].childs[tResults[fName].childs[q]].type == "FontString" then
											--tFlag = false
										end
									end
								end
								if tFlag == true then
									--moveit
									local tString = tResults[fName].childs[tResults[fName].childs[1]].textFirstLine
									tResults[fName].textFirstLine = tString
									--tResults[fName].childs[tResults[fName].childs[1]] = nil
									--table.remove(tResults[fName].childs, 1)
								end
							end
						end

						--check for buttons without text, add text if they are known
						if tResults[fName] then
							if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" then
								for iq, vq in pairs(tButtonsWoFontstrings) do
									if string.find(fName, iq) then
										tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(vq)
									end
								end
								--if there are childs but no text > try to find the best/friendly name via the frame name
								if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" and #tResults[fName].childs > 0 then
									local tText = friendlyFrameNames[fName] or ""
									if tText == "" then
										for i, v in pairs(friendlyFrameNamesParts) do
											if string.find(fName, i) then
												tText = v
											end
										end
									end
									if tText ~= "" then
										tResults[fName].textFirstLine, tResults[fName].textFull = ItemName_helper(tText)
									else
										--no friendly name > name as Container x
										tResults[fName].textFirstLine = L["Container"].." "..x --fName
									end
								end
								--if there is no text/childs > remove
								if tResults[fName].textFirstLine == "" and tResults[fName].textFull == "" and #tResults[fName].childs == 0 then
									if string.find(fName, "ContainerFrame") then
										tResults[fName].textFirstLine = L["Empty"].." "
									else
										tResults[fName] = nil
										table.remove(tResults, #tResults)
									end
								end
							end
						end
						--if blocked widget strings
						if tResults[fName] then
							if tResults[fName].textFirstLine ~= "" then
								if blockedWidgetStrings[tResults[fName].textFirstLine] then
									tResults[fName] = nil
									table.remove(tResults, #tResults)
								end
							end
						end
						if string.find(fName, "ContainerFrame") or string.find(fName, "ItemButton") then
							if _G[fName.."Count"] then
								if tResults[fName] and _G[fName.."Count"]:GetText() then
									if not string.find(tResults[fName].textFirstLine, L["Empty"].." ") then
										tResults[fName].textFirstLine = tResults[fName].textFirstLine.." ".._G[fName.."Count"]:GetText()
									else
										tResults[fName].textFirstLine = tResults[fName].textFirstLine
									end
								end
							end
							if tResults[fName] and string.find(fName, "ContainerFrame") then
								if tResults[fName].textFirstLine then
									tResults[fName].textFirstLine = tEmptyCounter.." "..tResults[fName].textFirstLine
									tEmptyCounter = tEmptyCounter + 1
								end
							end
							if _G[fName.."Count"] and tResults[fName] then
								tResults[fName].stackSize = _G[fName.."Count"]:GetText()
							end
							if _G[fName].info then
								tResults[fName].itemId = _G[fName].info.id
							end							
						end
					end
				end
			end
		end
	end

	return tResults
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CleanUpGossipList(aTable)
	for x = 1, #aTable do
		local value = aTable[aTable[x]]

		local tGold, tSilver, tCopper = 0, 0, 0
		if value.textFirstLine == L["Money"] then
			--dprint("currency", #value.childs)
			for q = 1, #value.childs do
				--dprint("  q", q, value.childs[q])
				for w = 1, #value.childs do
					--dprint("    w", w, value.childs[w], value.childs[value.childs[w]].textFirstLine)
					if string.find(value.childs[w], "GoldButton") and value.childs[value.childs[w]].textFirstLine ~= "" then
						tGold = tonumber(value.childs[value.childs[w]].textFirstLine)
					end
					if string.find(value.childs[w], "SilverButton") and value.childs[value.childs[w]].textFirstLine ~= "" then
						tSilver = tonumber(value.childs[value.childs[w]].textFirstLine)
					end
					if string.find(value.childs[w], "CopperButton") and value.childs[value.childs[w]].textFirstLine ~= "" then
						tCopper = tonumber(value.childs[value.childs[w]].textFirstLine)
					end
				end				
			end

			if tGold ~= nil and tSilver ~= nil and  tCopper ~= nil then
				--dprint(tGold, tSilver, tCopper)
				value.textFirstLine = tGold.." "..L["Gold"].." "..tSilver.." "..L["Silver"].." "..tCopper.." "..L["Copper"]
				value.childs = {}
			end
		end

		if value.type == "FontString" then
			value.textFirstLine = L["Text"]..": "..value.textFirstLine
		end

		if value.type == "Button" and value.func then
			value.textFirstLine = value.textFirstLine
		end

		aTable[aTable[x]] = value

		if #value.childs > 0 then
			CleanUpGossipList(value.childs)
		end
	end

end

-------------------------------------------------------------------------------------------------
---@param aForceLocalRoot bool force the audio menu to return to the "Local" root element if there are new childs in Local
function SkuCore:CheckFrames(aForceLocalRoot)
	--print("!!!!!!!!!!!!!!!!!!!!!!CheckFrames", aForceLocalRoot)
	-- temp hack to avoid the CURSOR_UPDATE spam from questie
	if Questie then
		Questie:UnregisterEvent("CURSOR_UPDATE")
	end

	if SkuOptions.db.profile["SkuOptions"].localActive == false then
		return
	end
	
	if SkuCore.isMoving == true then
		C_Timer.After(0.5, function()
			SkuCore:CheckFrames()
		end)
		return
	end

	SkuCore.GossipList = {}
	C_Timer.After(0.65, function() --This is because the content of some frames is not instantly available on show. We do need to wait a few milliseconds on it.
		--dprint("CheckFrames", aForceLocalRoot)
		SkuCore.GossipList = {}
		local tOpenFrames = {}

		for i, v in pairs(SkuCore.interactFramesList) do
			if _G[v] then
				if _G[v]:IsVisible() == true then
					table.insert(tOpenFrames, v)
				end
			end
		end

		if #tOpenFrames > 0 then
			local tGossipList = {}

			for x = 1, #tOpenFrames do
				--dprint(x, tOpenFrames[x])
				table.insert(tGossipList, tOpenFrames[x])
				tGossipList[tOpenFrames[x]] = {
					frameName = tOpenFrames[x],
					RoC = "Child",
					type = "Frame",
					obj = _G[tOpenFrames[x]],
					textFirstLine = friendlyFrameNames[tOpenFrames[x]] or tOpenFrames[x],
					textFull = "",
					childs = {},
					}
				if not SkuCore.interactFramesListManual[tOpenFrames[x]] then
					tGossipList[tOpenFrames[x]].childs = IterateChildren(tGossipList[tOpenFrames[x]].obj, "")
				else
					SkuCore.interactFramesListManual[tOpenFrames[x]](tGossipList[tOpenFrames[x]].childs)
				end
			end

			CleanUpGossipList(tGossipList)
			SkuCore.GossipList = tGossipList
			--print("SkuOptions.currentMenuPosition", SkuOptions.currentMenuPosition)
			--print("SkuOptions.currentMenuPosition.name", SkuOptions.currentMenuPosition.name)
			local tIndex
			local tBread = nil
			local tFirstFrame = nil
			if SkuOptions.currentMenuPosition then
				local tTable = SkuOptions.currentMenuPosition.parent

				if tTable.children then
					for x = 1, #tTable.children do
						if tTable.children[x].name == SkuOptions.currentMenuPosition.name then
							tIndex = x
						end
					end
				end

				tBread = SkuOptions.currentMenuPosition.parent.name
				if tTable.parent then
					while tTable.parent.name do
						tFirstFrame = tTable.name
						tTable = tTable.parent
						if tBread then
							tBread = tTable.name..","..tBread
						else
							tBread = tTable.name
						end
					end
				end
				--dprint("tBread", tBread)
				--dprint("tFirstFrame", tFirstFrame)
			end
			--dprint("aForceLocalRoot", aForceLocalRoot)
			SkuOptions:SlashFunc(L["short"]..","..L["Local"])

			local tFlag = false
			if tBread and aForceLocalRoot ~= true and tFlag == false then
				for i, v in pairs(friendlyFrameNames) do
					if v == tFirstFrame then
						if _G[i] then
							if _G[i]:IsVisible() then
								SkuOptions:SlashFunc(L["short"]..","..tBread)
								if tIndex then
									for x = 1, tIndex - 1 do
										SkuOptions.currentMenuPosition:OnNext()
									end
									--SkuOptions.currentMenuPosition.parent.children[tIndex]:OnSelect()
									SkuOptions:VocalizeCurrentMenuName()
								end

								tFlag = true
							end
						end
					end
				end
			end
			
			if tFlag == false or  aForceLocalRoot == true then
				SkuOptions:SlashFunc(L["short"]..","..L["Local"])
			end
			
			for q = 1, #tOpenFrames do
				if tOpenFrames[q] == "StaticPopup1" and aForceLocalRoot ~= true then
					SkuOptions:SlashFunc(L["short"]..","..L["Local"]..","..L["Popup 1"])
				end
			end
			for q = 1, #tOpenFrames do
				if tOpenFrames[q] == "StaticPopup2" and aForceLocalRoot ~= true then
					SkuOptions:SlashFunc(L["short"]..","..L["Local"]..","..L["Popup 2"])
				end
			end
			for q = 1, #tOpenFrames do
				if tOpenFrames[q] == "StaticPopup3" and aForceLocalRoot ~= true then
					SkuOptions:SlashFunc(L["short"]..","..L["Local"]..","..L["Popup 3"])
				end
			end

		else
			SkuCore.openMenuAfterMoving = false
			SkuCore.openMenuAfterCombat = false
			if SkuOptions:IsMenuOpen() == true then
				SkuCore.GossipList = {}
				--SkuOptions:SlashFunc("short,lokal")
				SkuOptions:CloseMenu()
			end			
		end
	end)
end

--DEFAULT_BINDINGS (0)
--ACCOUNT_BINDINGS (1)
--CHARACTER_BINDINGS (2)
-------------------------------------------------------------------------------------------------
function SkuCore:SaveBindings()
	local aBindingSet = GetCurrentBindingSet()
	SaveBindings(aBindingSet) 
end

-------------------------------------------------------------------------------------------------
function SkuCore:GetBinding(aIndex)
	local aBindingSet = GetCurrentBindingSet()
	local tCommand, tCategory, tKey1, tKey2 = GetBinding(aIndex, aBindingSet)

	return tCommand, tCategory, tKey1, tKey2
end

-------------------------------------------------------------------------------------------------
function SkuCore:DeleteBinding(aCommand)
	local aBindingSet = GetCurrentBindingSet()

	local tNumKeyBindings = GetNumBindings()
	for x = 1, tNumKeyBindings do
		local tCommand, _, tKey1, tKey2, tKey3, tKey4 = GetBinding(x, aBindingSet)
		if tCommand == aCommand then
			if tKey4 then
				SetBinding(tKey4)
			end
			if tKey3 then
				SetBinding(tKey3)
			end
			if tKey2 then
				SetBinding(tKey2)
			end
			if tKey1 then
				SetBinding(tKey1)
			end
		end
	end

	SkuCore:SaveBindings()
end

-------------------------------------------------------------------------------------------------
function SkuCore:SetBinding(aKey, aCommand)
	local aBindingSet = GetCurrentBindingSet()
	local tCommand, _, tKey1, tKey2, tKey3, tKey4

	local tNumKeyBindings = GetNumBindings()
	for x = 1, tNumKeyBindings do
		tCommand, _, tKey1, tKey2, tKey3, tKey4 = GetBinding(x, aBindingSet)
		if tCommand == aCommand then
			break
		end
	end
	
	SkuCore:DeleteBinding(aCommand)

	local tOk = SetBinding(aKey, aCommand, 1)
	if tKey2 then
		local tOk = SetBinding(tKey2, aCommand, 1)
	end

	SkuCore:SaveBindings()
end

-------------------------------------------------------------------------------------------------
function SkuCore:LoadBindings()
	local aBindingSet = GetCurrentBindingSet()
	LoadBindings(aBindingSet) 
end

-------------------------------------------------------------------------------------------------
function SkuCore:ResetBindings(aToWowDefaults)
	LoadBindings(DEFAULT_BINDINGS)

	if not aToWowDefaults then
		for icat, vcat in pairs(SkuCore.Keys.SkuDefaultBindings) do
			for icom, vcom in pairs(vcat) do
				if vcom.key1 then
					SetBinding(vcom.key1, icom, 1)
				end
				if vcom.key2 then
					SetBinding(vcom.key2, icom, 1)
				end
			end
		end
	else
		print("ResetBindings with aToWowDefaults parameter - this should not happen")
	end
	
	SkuCore:SaveBindings()
end
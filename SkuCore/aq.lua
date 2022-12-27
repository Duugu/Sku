--[[
   Interface\AddOns\Sku\SkuCore\assets\audio\heal\numbers
	Interface\AddOns\Sku\SkuCore\assets\audio\heal\other
	/sku 
		aq		on/off
		dispel	on/off
		self	on/off
		all	on/off
		1-40	on/off
		pet	on/off
		focus	on/off
		tank1-5	on/off
		hp	<value>,<value>,...
		mana	<value>,<value>,...
		channel	name?
		min sp	<value>
		max sp	<value>
]]
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "aq"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.aq = {}
SkuCore.aq.mirrorBars = {}

local tVoices = {
	[1] = {name = "Justin", path = "jus"},
	[2] = {name = "Kimberly", path = "yve"},
}

local tPowerTypes = {
	["NOTHING"] = {name = L["nichts"], number = -1},
	["MANA"] = {name = L["MANA"], number = 0},
	["RAGE"] = {name = L["RAGE"], number = 1},
	["ENERGY"] = {name = L["ENERGY"], number = 3},
	["RUNIC_POWER"] = {name = L["RUNIC_POWER"], number = 6},
}
--[[
-------------------------- party test
tTestParty = {
	[1] = 100,
	[2] = 100,
	[3] = 70,
	[4] = 100,
	[5] = 30,
}
--------------------------
]]

---------------------------------------------------------------------------------------------------------------------------------------
local tHealthMonitorPause = false
local tPowerMonitorPause = false
local tPrevHpPer = 100
local tPrevHpDir = false
local tPrevPwrPer = 100
local tPrevPwrDir = false
local function AqCreateControlFrame()
	--[[
	-------------------------- party test
	local f = CreateFrame("Frame", "tTestPartyFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	f:SetFrameStrata("TOOLTIP")
	f:SetFrameLevel(129)
	f:SetPoint("CENTER", UIParent, "CENTER")
	f:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 32,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f:SetBackdropColor(0, 0, 0, 0.25)
	f:SetClampedToScreen(true)
	f:SetSize(150, 250)

	for x = 1, 5 do
		local MySlider = CreateFrame("Slider", "MySlider"..x, ParentFrame, "OptionsSliderTemplate")
		MySlider:SetPoint("LEFT", f, "LEFT", 20 * (x - 1), 0)
		MySlider:SetWidth(20)
		MySlider:SetHeight(200)
		MySlider:SetOrientation('VERTICAL')
		MySlider:Show()
		MySlider:SetMinMaxValues(0, 100)
		MySlider:SetStepsPerPage(4)
		MySlider:SetValueStep(1)
		MySlider:SetValue(tTestParty[x])
		MySlider:SetScript("OnValueChanged", function(self, value, userInput) 
			tTestParty[x] = math.floor(value)
		end)

	end
	--/script SkuOptions.db.char["SkuCore"].aq.party.health.continouslySpeed = 100
	--------------------------
	]]
   local f = _G["SkuCoreAqControl"] or CreateFrame("Frame", "SkuCoreAqControl", UIParent)
   local ttime = 0
   local ttimeMonHp = 0
   local ttimeMonPwr = 0
	local ttimeMonParty = 0
   f:SetScript("OnUpdate", function(self, time)
      ttime = ttime + time
      if ttime > 0.05 then
			--mirror bars
			for i, v in pairs(SkuCore.aq.mirrorBars) do
				v.value = GetMirrorTimerProgress(v.name)
				
				local tValue = v.value
				if tValue < 0 then
					tValue = 0
				end
				
				if math.floor(tValue / (v.maxValue / 100)) <= (v.prevStepPct - v.stepPct) then
					v.prevStepPct = math.floor(tValue / (v.maxValue / 100))
					SkuOptions.Voice:OutputStringBTtts(v.label.." "..math.floor(tValue / (v.maxValue / 100)), false, true, 0.2)
				end
			end
			ttime = 0
		end

		if SkuOptions.db.char[MODULE_NAME].aq then
			if SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == true then
				ttimeMonHp = ttimeMonHp + time
				if ttimeMonHp > (SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer) and tHealthMonitorPause == false then
					local health = UnitHealth("player")
					local healthMax = UnitHealthMax("player")
					local healthPer = math.floor((health / healthMax) * 100)
					if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt >= 0 and (math.floor(healthPer / 10) <= SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt) then
						local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.player.health.steps)
						local tNumberToUtterance = ((math.floor(healthPer / tsinglestep)) * tsinglestep) / 10
						tPrevHpDir = healthPer > tPrevHpPer
						if tPrevHpDir == false then
							tNumberToUtterance = tNumberToUtterance + 1
						end
		
						if SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 == false or (tNumberToUtterance < 10 and tNumberToUtterance > 0) then
							SkuCore:MonitorOutputPlayer(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path)
						end							
					end

					ttimeMonHp = 0

					if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer == SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer then
						ttimeMonPwr = 10000000
					end
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == true then
				ttimeMonPwr = ttimeMonPwr + time
				if ttimeMonPwr > (SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer) and tPowerMonitorPause == false then
					local power = UnitPower("player", tPowerTypes[SkuOptions.db.char[MODULE_NAME].aq.player.power.type].number)
					local powerMax = UnitPowerMax("player", tPowerTypes[SkuOptions.db.char[MODULE_NAME].aq.player.power.type].number)
					local pwrPer = math.floor((power / powerMax) * 100)
					if SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt >= 0 and (math.floor(pwrPer / 10) <= SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt) then
						local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.player.power.steps)
						local tNumberToUtterance = ((math.floor(pwrPer / tsinglestep)) * tsinglestep) / 10
						tPrevPwrDir = pwrPer > tPrevPwrPer
						if tPrevPwrDir == false then
							tNumberToUtterance = tNumberToUtterance + 1
						end

						if SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 == false or (tNumberToUtterance < 10 and tNumberToUtterance > 0) then
							C_Timer.After(0.25, function()
								SkuCore:MonitorOutputPlayer(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.power.voice].path)
							end)
						end							
					end
					ttimeMonPwr = 0
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled == true then
				ttimeMonParty = ttimeMonParty + time
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled == true then
					ttimeMonParty = ttimeMonParty + time
					if ttimeMonParty > (SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyTimer) then
						local tUtterances = {}

						local tLast = 0
						for x = 1, 4 do
							local health = UnitHealth("party"..x)
							local healthMax = UnitHealthMax("party"..x)
							local healthPer = math.floor((health / healthMax) * 100)
							if healthMax == 0 then
								healthPer = -1
							else
								tLast = x
							end
							tUtterances[x] = healthPer
						end
						if SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf == true then
							local health = UnitHealth("player")
							local healthMax = UnitHealthMax("player")
							local healthPer = math.floor((health / healthMax) * 100)
							tUtterances[tLast + 1] = healthPer
						else
							tUtterances[tLast + 1] = -1
						end						

						--[[
						-------------------------- party test
						tUtterances = tTestParty
						--------------------------
						]]

						local tAll100 = true
						for x = 1, #tUtterances do
							if tUtterances[x] < 100 and tUtterances[x] ~= -1 then
								tAll100 = false
							end
						end

						if SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 == false or tAll100 == false then
							SkuCore:MonitorOutputParty(tUtterances, SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly, SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed)
						end

						ttimeMonParty = 0
					end
				end
			end
		end
   end)
end

--mirror bars
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MIRROR_TIMER_START(eventName, timerName, value, maxValue, scale, paused, timerLabel)
	SkuCore.aq.mirrorBars[timerName] = {}
	SkuCore.aq.mirrorBars[timerName].name = timerName
	SkuCore.aq.mirrorBars[timerName].value = value
	SkuCore.aq.mirrorBars[timerName].maxValue = maxValue
	SkuCore.aq.mirrorBars[timerName].scale = scale
	SkuCore.aq.mirrorBars[timerName].paused = paused
	SkuCore.aq.mirrorBars[timerName].pausedDuration = 0
	SkuCore.aq.mirrorBars[timerName].label = timerLabel
	SkuCore.aq.mirrorBars[timerName].stepPct = 10
	SkuCore.aq.mirrorBars[timerName].prevStepPct = 100
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MIRROR_TIMER_STOP(eventName, timerName)
	SkuCore.aq.mirrorBars[timerName] = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MIRROR_TIMER_PAUSE(eventName, timerName, pause)
	SkuCore.aq.mirrorBars[timerName].paused = true
	SkuCore.aq.mirrorBars[timerName].pausedDuration = pause
end

--global
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnInitialize()
	AqCreateControlFrame()

	SkuCore:RegisterEvent("MIRROR_TIMER_START")
	SkuCore:RegisterEvent("MIRROR_TIMER_STOP")
	SkuCore:RegisterEvent("MIRROR_TIMER_PAUSE")
	SkuCore:RegisterEvent("UNIT_HEALTH")
	SkuCore:RegisterEvent("UNIT_POWER_FREQUENT")
	SkuCore:RegisterEvent("UNIT_POWER_UPDATE")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnLogin()
	SkuOptions.db.char[MODULE_NAME].aq = SkuOptions.db.char[MODULE_NAME].aq or {}

	SkuOptions.db.char[MODULE_NAME].aq.party = SkuOptions.db.char[MODULE_NAME].aq.party or {}

	SkuOptions.db.char[MODULE_NAME].aq.party.health = SkuOptions.db.char[MODULE_NAME].aq.party.health or {}
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyTimer = 4
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed = 50
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf = true
	end

	SkuOptions.db.char[MODULE_NAME].aq.player = SkuOptions.db.char[MODULE_NAME].aq.player or {}

	SkuOptions.db.char[MODULE_NAME].aq.player.health = SkuOptions.db.char[MODULE_NAME].aq.player.health or {}
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer = 3
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt = -1
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume = 50
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume = 80
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.steps == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.steps = 10
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.voice = 1
	end

	SkuOptions.db.char[MODULE_NAME].aq.player.power = SkuOptions.db.char[MODULE_NAME].aq.player.power or {}
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly == nil then
		local _, powerToken = UnitPowerType("player")
		if not powerToken or tPowerTypes[powerToken] == nil then
			powerToken = "NOTHING"
		end
		SkuOptions.db.char[MODULE_NAME].aq.player.power.type = powerToken
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer = 6
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt = -1
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume = 30
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume = 60
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.steps == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.steps = 5
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.voice = 2
	end	
end

--Monitor
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqSlashHandler(aFieldsTable)
	if aFieldsTable[2] == "health" then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == false		
	end
	if aFieldsTable[2] == "power" then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == false		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_HEALTH(eventName, aUnitID)
	if aUnitID == "player" then
		if SkuOptions.db.char[MODULE_NAME].aq then
			if SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == true then


				local health = UnitHealth("player")
				local healthMax = UnitHealthMax("player")
				local healthPer = math.floor((health / healthMax) * 100)

				local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.player.health.steps)
				local tNumberToUtterance = ((math.floor(healthPer / tsinglestep)) * tsinglestep) / 10
				tPrevHpDir = healthPer > tPrevHpPer
				if tPrevHpDir == false then
					tNumberToUtterance = tNumberToUtterance + 1
				end

				if tNumberToUtterance ~= tPrevHpPer then
					SkuCore:MonitorOutputPlayer(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume, SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path)
					tHealthMonitorPause = true
					tPowerMonitorPause = true
					C_Timer.After(SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer, function()
						tHealthMonitorPause = false
						tPowerMonitorPause = false
					end)
					tPrevHpPer = tNumberToUtterance
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:UNIT_POWER_FREQUENT(eventName, unitTarget, powerType)
	--SkuCore:UNIT_POWER_UPDATE("UNIT_POWER_FREQUENT", unitTarget, powerType)
end
function SkuCore:UNIT_POWER_UPDATE(eventName, unitTarget, powerType)
	if unitTarget == "player" then
		if SkuOptions.db.char[MODULE_NAME].aq then
			if SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == true then
				if powerType == SkuOptions.db.char[MODULE_NAME].aq.player.power.type then
					local power = UnitPower("player", tPowerTypes[powerType].number)
					local powerMax = UnitPowerMax("player", tPowerTypes[powerType].number)
					local pwrPer = math.floor((power / powerMax) * 100)

					local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.player.power.steps)
					local tNumberToUtterance = ((math.floor(pwrPer / tsinglestep)) * tsinglestep) / 10
					tPrevPwrDir = pwrPer > tPrevPwrPer
					if tPrevPwrDir == false then
						tNumberToUtterance = tNumberToUtterance + 1
					end

					if tNumberToUtterance ~= tPrevPwrPer then
						SkuCore:MonitorOutputPlayer(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume, SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.power.voice].path)
						tHealthMonitorPause = true
						tPowerMonitorPause = true
						C_Timer.After(SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer, function()
							tHealthMonitorPause = false
							tPowerMonitorPause = false
						end)
						tPrevPwrPer = tNumberToUtterance
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tSounds = {
	[0] = {min = 0, max = 0,},
	[1] = {min = 1, max = 17,},
	[2] = {min = 18, max = 33,},
	[3] = {min = 34, max = 50,},
	[4] = {min = 51, max = 67,},
	[5] = {min = 68, max = 83,},
	[6] = {min = 84, max = 99,},
	[7] = {min = 100, max = 100,},
}
function SkuCore:MonitorOutputParty(aHealthValues, aVolume, aInstancesOnly, aSpeed)
	local inInstance = IsInInstance() 
	if aInstancesOnly == true and inInstance ~= true then
		return
	end

	local tStartTime = 0 -- + 0.3
	local tSpeed = 0.6 * (aSpeed / 100)
	for x = 1, #aHealthValues do
		if aHealthValues[x] ~= -1 then
			C_Timer.After(tStartTime, function()
				local tFile
				for y = 0, #tSounds do
					if aHealthValues[x] >= tSounds[y].min and aHealthValues[x] <= tSounds[y].max then
						PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\health_"..y..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
					end
				end
			end)
		end
		tStartTime = tStartTime + tSpeed
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tPrevOutputHandle = {}
function SkuCore:MonitorOutputPlayer(aValuePercent, aVol, aInstancesOnly, aVoice)
	local inInstance = IsInInstance() 
	if aInstancesOnly == true and inInstance ~= true then
		return
	end

	if aValuePercent >= 10 then
		aValuePercent = "full"
	elseif aValuePercent < 0 then
		aValuePercent = 0
	end

	if tPrevOutputHandle[aVoice] then
		StopSound(tPrevOutputHandle[aVoice])
	end

	_, tPrevOutputHandle[aVoice] = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..aVoice.."\\"..aVoice.."-"..aValuePercent.."-"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
end

--menu
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MonitorMenuBuilder()
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["player"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		--health
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Health"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enable in dungeons/raids only"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output start at"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if aName == -1 then
					return L["Never"]
				else
					return SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Never"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt = -1
				else
					SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyStartAt = tonumber(aName)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
				for x = 0, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Silent on 100 and 0 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end
			

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 10, 100, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Event volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 10, 100, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end
			
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Event Steps"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.health.steps
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.health.steps = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {"10"}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {"5"}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {"2"}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Voice"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].name
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for x = 1, #tVoices do
					if aName == tVoices[x].name then
						SkuOptions.db.char[MODULE_NAME].aq.player.health.voice = x
					end
				end
				C_Timer.After(0.001, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
				end)				
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tVoices do
					SkuOptions:InjectMenuItems(self, {tVoices[x].name}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Buy "]..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].name..L[" ice cream"]}, SkuGenericMenuItem)
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				local willPlay, tPrevOutputHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."-yay-"..SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
			end			
		end
		--power
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Power"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Power Type"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				for i, v in pairs(tPowerTypes) do
					if SkuOptions.db.char[MODULE_NAME].aq.player.power.type == i then
						return v.name
					end
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for i, v in pairs(tPowerTypes) do
					if aName == v.name then
						SkuOptions.db.char[MODULE_NAME].aq.player.power.type = i
					end
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				for i, v in pairs(tPowerTypes) do
					SkuOptions:InjectMenuItems(self, {v.name}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enable in dungeons/raids only"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output start at"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if aName == -1 then
					return L["Never"]
				else
					return SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Never"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt = -1
				else
					SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyStartAt = tonumber(aName)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
				for x = 0, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Silent on 100 and 0 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.power.silentOn100and0 = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end
			

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 10, 100, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Event volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 10, 100, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end
			
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Event Steps"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.power.steps
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.power.steps = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {10}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {5}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {2}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Voice"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.power.voice].name
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for x = 1, #tVoices do
					if aName == tVoices[x].name then
						SkuOptions.db.char[MODULE_NAME].aq.player.power.voice = x
					end
				end
				C_Timer.After(0.001, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
				end)				
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tVoices do
					SkuOptions:InjectMenuItems(self, {tVoices[x].name}, SkuGenericMenuItem)
				end
			end
		end
	end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Party"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		--health
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Health"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enable in dungeons/raids only"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyEnabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Silent on all at 100 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.silentAtAll100 = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Speed"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 20, 100 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end





			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Include self"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health.includeSelf = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end			
		end
	end

end
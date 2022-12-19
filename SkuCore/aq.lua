---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "aq"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

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

local tVoices = {
	[1] = {name = "Justin", path = "jus"},
	[2] = {name = "Kimberly", path = "yve"},
}

SkuCore.aq = {}
SkuCore.aq.mirrorBars = {}

---------------------------------------------------------------------------------------------------------------------------------------
local tMonitorPause = false
local function AqCreateControlFrame()
   local f = _G["SkuCoreAqControl"] or CreateFrame("Frame", "SkuCoreAqControl", UIParent)
   local ttime = 0
   local ttimeMon = 0
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
				if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled == true then
					ttimeMon = ttimeMon + time
					if ttimeMon > (SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer) and tMonitorPause == false then
						local hp = math.floor(UnitHealth("player") / (UnitHealthMax("player") / 100))
						local hpPer = math.floor(((hp / 10)) + 1) * 10
						if hpPer > 100 then hpPer = 100 end
						if hpPer < 10 then hpPer = 0 end
						if hp == 0 then hpPer = 0 end
						if SkuOptions.db.char[MODULE_NAME].aq.player.health.silentOn100and0 == false or (hpPer < 100 and hpPer > 0) then
							SkuCore:MonitorOutput(hpPer, SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume)
						end
						ttimeMon = 0
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

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnLogin()
	SkuOptions.db.char[MODULE_NAME].aq = SkuOptions.db.char[MODULE_NAME].aq or {}
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
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer = 3
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume = 50
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume = 80
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.voice = 1
	end
end

--Monitor
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqSlashHandler(aFieldsTable)
	if aFieldsTable[2] == "health" then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == false		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tPrevHpPer = 100
function SkuCore:UNIT_HEALTH(eventName, aUnitID)
	if aUnitID == "player" then
		if SkuOptions.db.char[MODULE_NAME].aq then
			if SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == true then
				local hp = math.floor(UnitHealth("player") / (UnitHealthMax("player") / 100))
				local hpPer = math.floor(((hp / 10)) + 1) * 10
				if hpPer > 100 then hpPer = 100 end
				if hpPer < 10 then hpPer = 0 end
				if hp == 0 then hpPer = 0 end
				if hpPer ~= tPrevHpPer then
					SkuCore:MonitorOutput(hpPer, SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume)
					tMonitorPause = true
					C_Timer.After(SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer, function()
						tMonitorPause = false
					end)
					tPrevHpPer = hpPer
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------

local tPrevOutputHandle
function SkuCore:MonitorOutput(aHpPer, aVol)
	local inInstance = IsInInstance() 
	if SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly == true and inInstance ~= true then
		return
	end

	if aHpPer == 100 then
		aHpPer = "full"
	elseif aHpPer ~= 0 then
		aHpPer = aHpPer / 10
	end

	if tPrevOutputHandle then
		StopSound(tPrevOutputHandle)
	end
	local willPlay, tPrevOutputHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."-"..aHpPer.."-"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MonitorMenuBuilder()
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["player"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
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

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyEnabled = true
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
	end
end
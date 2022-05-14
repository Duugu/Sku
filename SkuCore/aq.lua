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

SkuCore.aq = {}
SkuCore.aq.mirrorBars = {}

---------------------------------------------------------------------------------------------------------------------------------------
local function AqCreateControlFrame()
   local f = _G["SkuCoreAqControl"] or CreateFrame("Frame", "SkuCoreAqControl", UIParent)
   local ttime = 0
   f:SetScript("OnUpdate", function(self, time)
      ttime = ttime + time
      if ttime < 0.05 then return end
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
   end)
end

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

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnInitialize()
	AqCreateControlFrame()

	SkuCore:RegisterEvent("MIRROR_TIMER_START")
	SkuCore:RegisterEvent("MIRROR_TIMER_STOP")
	SkuCore:RegisterEvent("MIRROR_TIMER_PAUSE")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqSlashHandler(aFieldsTable)
   for x = 2, #aFieldsTable do
      --print(x, aFieldsTable[x])
   end
end

---@diagnostic disable: undefined-field, undefined-doc-name
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuNav"
local _G = _G
local L = Sku.L

SkuNav = SkuNav or LibStub("AceAddon-3.0"):NewAddon("SkuNav", "AceConsole-3.0", "AceEvent-3.0")

--------------------------------------------------------------------------------------------------------------------------------------
-- special navigation tasks (if no coords)
--------------------------------------------------------------------------------------------------------------------------------------
local tCurrentTask = nil
local tCurrentStep = 0
local tCurrentMovementStartAt = 0
local tCurrentMovementLeft = -1
local tPitch
local tVHealth
local tVPower
--------------------------------------------------------------------------------------------------------------------------------------
--control frame to register all required events to trigger tasks
--register more events for start/end trigger strings if required, or send trigger strings on custom events
local f = _G["SkuNavNavigationModeWoCoordinatesControl"] or CreateFrame("Frame", "SkuNavNavigationModeWoCoordinatesControl", UIParent)
f:SetScript("OnEvent", function(self, aEvent, arg1, arg2) 
	if aEvent == "VEHICLE_ANGLE_UPDATE" then
		tPitch = arg1
		SkuOptions.Voice:OutputStringBTtts(tPitch, true, true, 0.2, nil, nil, nil, 2, nil, true)						
	elseif aEvent == "UNIT_POWER_FREQUENT" and arg1 == "vehicle" then
		local tCP = math.floor((UnitPower("vehicle") / UnitPowerMax("vehicle")) * 100)
		if tVPower then
			if tVPower - tCP > 10 or tVPower - tCP < -10 then
				tVPower = tCP
				SkuOptions.Voice:OutputStringBTtts(L["Vehicle Mana "]..tVPower, true, true, 0.2, nil, nil, nil, 2, nil, true)						
			end
		else
			tVPower = tCP
		end
	elseif aEvent == "UNIT_HEALTH_FREQUENT" and arg1 == "vehicle" then
		local tCP = math.floor((UnitHealth("vehicle") / UnitHealthMax("vehicle")) * 100)
		if tVHealth then
			if tVHealth - tCP > 5 or tVHealth - tCP < -5 then
				tVHealth = tCP
				SkuOptions.Voice:OutputStringBTtts(L["Vehicle HP "]..tVHealth, true, true, 0.2, nil, nil, nil, 2, nil, true)						
			end
		else
			tVHealth = tCP
		end
	end

	SkuNav:NavigationModeWoCoordinatesCheckTaskTrigger(aEvent, arg1, arg2)
end)
f:RegisterEvent("LOADING_SCREEN_ENABLED")
f:RegisterEvent("VEHICLE_ANGLE_UPDATE")
f:RegisterEvent("UNIT_POWER_FREQUENT")
f:RegisterEvent("UNIT_HEALTH_FREQUENT")
f:RegisterEvent("UNIT_EXITED_VEHICLE")

--------------------------------------------------------------------------------------------------------------------------------------
--helper to get the direction in degrees
function NavigationModeWoCoordinatesGetDirection()
	local x, y = UnitPosition("player")
	local a, b, afinal = SkuNav:GetDirectionTo(x, y, 30000, y)
	return afinal + 180
end

--------------------------------------------------------------------------------------------------------------------------------------
--checks if a task should start or stopp; can be called from anywhere with a string
function SkuNav:NavigationModeWoCoordinatesCheckTaskTrigger(aStringToCheck, arg1, arg2)
	--print("NavigationModeWoCoordinatesCheckTaskTrigger", aStringToCheck, arg1)
	local tTaskId

	aStringToCheck = SkuChat:Unescape(aStringToCheck)

	if tCurrentTask then
		for i, v in pairs(SkuDB.Tasks[tCurrentTask].endTriggers) do
			--if v == aStringToCheck then
			if string.find(aStringToCheck, v) then
				SkuNav:NavigationModeWoCoordinatesNextStep(nil, nil, true)
				SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
				SkuOptions.Voice:OutputStringBTtts(L["spezialaufgabe abgebrochen"], true, true, 0.2, nil, nil, nil, 2, nil, true)						
				print(L["spezialaufgabe abgebrochen"])
			end
		end
	end

	for i, v in pairs(SkuDB.Tasks) do
		if string.find(aStringToCheck, i) then
			tTaskId = i
			break
		end
	end

	if tTaskId then
		SkuNav:NavigationModeWoCoordinatesNextStep(nil, nil, true)
		SkuNav:NavigationModeWoCoordinatesNextStep(tTaskId, true)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
--gets to next step of current task or starts/stopps a task
function SkuNav:NavigationModeWoCoordinatesNextStep(aTaskId, aStart, aStop)
	if aStop then
		tPitch = nil
		tVHealth = nil
		tVPower = nil
		
		tCurrentStep = 0
		tCurrentMovementStartAt = 0
		tCurrentMovementLeft = -1
		tCurrentTask = nil
		return
	end

	if tCurrentStep == 0 and not aStart then
		return
	end

	if aStart then	
		tCurrentTask = aTaskId
		tPitch = nil
		tVHealth = nil
		tVPower = nil

		tCurrentMovementStartAt = 0
		tCurrentMovementLeft = -1
		tCurrentStep = 1		
	else
		tCurrentStep = tCurrentStep + 1
	end
	
	local tPrefix = ""
	if tCurrentStep == 1 then
		tPrefix = L["Achtung: Start einer spezialaufgabe. Halte dich exakt an die Anweisungen! "]
	end

	if tCurrentStep <= #SkuDB.Tasks[tCurrentTask] then
		local tComment = SkuDB.Tasks[tCurrentTask][tCurrentStep].comment or ""
		if SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "turn" then
			SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
			SkuOptions.Voice:OutputStringBTtts(tPrefix..L["schritt "]..tCurrentStep..L[": drehen auf "]..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..". "..tComment, true, true, 0.2, nil, nil, nil, 2, nil, true)
			print(tPrefix..L["schritt "]..tCurrentStep..L[": drehen auf "]..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..". "..tComment)

		elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "forward" then
			SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
			SkuOptions.Voice:OutputStringBTtts(tPrefix..L["schritt "]..tCurrentStep..L[": vorwärts von "]..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..L[" bis 0"]..". "..tComment, true, true, 0.2, nil, nil, nil, 2, nil, true)						
			print(tPrefix..L["schritt "]..tCurrentStep..L[": vorwärts von "]..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..L[" bis 0"]..". "..tComment)
			tCurrentMovementLeft = SkuDB.Tasks[tCurrentTask][tCurrentStep].value

		elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "up" then
			SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
			SkuOptions.Voice:OutputStringBTtts(tPrefix..L["schritt "]..tCurrentStep..": hoch von "..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..L[" bis 0"]..". "..tComment, true, true, 0.2, nil, nil, nil, 2, nil, true)						
			print(tPrefix..L["schritt "]..tCurrentStep..": hoch von "..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..L[" bis 0"]..". "..tComment)
			tCurrentMovementLeft = SkuDB.Tasks[tCurrentTask][tCurrentStep].value

		elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "pitch" then
			SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)

			SkuOptions.Voice:OutputStringBTtts(tPrefix..L["schritt "]..tCurrentStep..": neigen auf "..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..". "..tComment, true, true, 0.2, nil, nil, nil, 2, nil, true)
			print(tPrefix..L["schritt "]..tCurrentStep..": neigen auf "..SkuDB.Tasks[tCurrentTask][tCurrentStep].value..". "..tComment)

		elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "pitchEndless" then
			SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)

			SkuOptions.Voice:OutputStringBTtts(tComment, true, true, 0.2, nil, nil, nil, 2, nil, true)
			print(tComment)
						
		end
	else
		tPitch = nil
		tVHealth = nil
		tVPower = nil

		tCurrentTask = nil
		tCurrentStep = 0
		tCurrentMovementStartAt = 0
		tCurrentMovementLeft = -1
		SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
		SkuOptions.Voice:OutputStringBTtts(L["spezialaufgabe abgeschlossen"], true, true, 0.2, nil, nil, nil, 2, nil, true)						
		print(L["spezialaufgabe abgeschlossen"])
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
--[[
evaluates all valid movement actions for the current task
	possible values for aTriggerName:
	TurnLeftStart
	TurnLeftStop
	TurnRightStart
	TurnRightStop
	MoveForwardStart
	MoveForwardStop
	MoveBackwardStart
	MoveBackwardStop
]]
function SkuNav:NavigationModeWoCoordinates_ON_MOVEMENT(aTriggerName)
	SkuNav:NavigationModeWoCoordinatesRecordForward(aTriggerName)
	SkuNav:NavigationModeWoCoordinatesRecordUp(aTriggerName)

	if tCurrentTask then
		if SkuDB.Tasks[tCurrentTask][tCurrentStep] then
			for i, v in pairs(SkuDB.Tasks[tCurrentTask][tCurrentStep].triggers) do
				if v == aTriggerName then
					if SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "turn" then
						local tDegree = math.floor(NavigationModeWoCoordinatesGetDirection())
						SkuOptions.Voice:OutputStringBTtts(tDegree, true, true, 0.2, nil, nil, nil, 2, nil, true)						
						if tDegree >= SkuDB.Tasks[tCurrentTask][tCurrentStep].value - 2 and tDegree <= SkuDB.Tasks[tCurrentTask][tCurrentStep].value + 2  then
							SkuNav:NavigationModeWoCoordinatesNextStep()
						end

					elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "pitchEndless" then
						if tPitch then
							local tDegree = tPitch
							SkuOptions.Voice:OutputStringBTtts(string.format("%.2f", tDegree), true, true, 0.2, nil, nil, nil, 2, nil, true)						
							if tDegree >= SkuDB.Tasks[tCurrentTask][tCurrentStep].value - 0.02 and tDegree <= SkuDB.Tasks[tCurrentTask][tCurrentStep].value + 0.02  then
								SkuNav:NavigationModeWoCoordinatesNextStep()
							end
						end				

					elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "pitch" then
						if tPitch then
							local tDegree = tPitch
							SkuOptions.Voice:OutputStringBTtts(string.format("%.2f", tDegree), true, true, 0.2, nil, nil, nil, 2, nil, true)						
							if tDegree >= SkuDB.Tasks[tCurrentTask][tCurrentStep].value - 0.02 and tDegree <= SkuDB.Tasks[tCurrentTask][tCurrentStep].value + 0.02  then
								SkuNav:NavigationModeWoCoordinatesNextStep()
							end
						end
	
					elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "forward" then
						if aTriggerName == "MoveForwardStart" then
							tCurrentMovementStartAt = GetTimePreciseSec()
						elseif aTriggerName == "MoveForwardStop" then
							tCurrentMovementLeft = tCurrentMovementLeft - (GetTimePreciseSec() - tCurrentMovementStartAt)
							SkuOptions.Voice:OutputStringBTtts(string.format("%.1f", tCurrentMovementLeft), true, true, 0.2, nil, nil, nil, 2, nil, true)						
							if tCurrentMovementLeft <= 0.04 then
								SkuNav:NavigationModeWoCoordinatesNextStep()
							end
						end

					elseif SkuDB.Tasks[tCurrentTask][tCurrentStep].action == "up" then
						if aTriggerName == "JumpOrAscendStart" then
							tCurrentMovementStartAt = GetTimePreciseSec()
						elseif aTriggerName == "AscendStop" then
							tCurrentMovementLeft = tCurrentMovementLeft - (GetTimePreciseSec() - tCurrentMovementStartAt)
							SkuOptions.Voice:OutputStringBTtts(string.format("%.1f", tCurrentMovementLeft), true, true, 0.2, nil, nil, nil, 2, nil, true)						
							if tCurrentMovementLeft <= 0.04 then
								SkuNav:NavigationModeWoCoordinatesNextStep()
							end
						end

					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- interal helpers for recording
local tCurrentMovementStartAtRec = -1
local tCurrentMovementDone = 0
function SkuNav:NavigationModeWoCoordinatesRecordForwardStart()
	tCurrentMovementStartAtRec = 0
	tCurrentMovementDone = 0
end
function SkuNav:NavigationModeWoCoordinatesRecordForwardStop()
	tCurrentMovementStartAtRec = -1
	tCurrentMovementDone = 0
end

function SkuNav:NavigationModeWoCoordinatesRecordForward(aTriggerName)
	if tCurrentMovementStartAtRec > -1 then
		if aTriggerName == "MoveForwardStart" then
			tCurrentMovementStartAtRec = GetTimePreciseSec()
		elseif aTriggerName == "MoveForwardStop" then
			tCurrentMovementDone = tCurrentMovementDone + (GetTimePreciseSec() - tCurrentMovementStartAtRec)
			--print(tCurrentMovementDone)
		end
	end
end

function SkuNav:NavigationModeWoCoordinatesRecordUp(aTriggerName)
	if tCurrentMovementStartAtRec > -1 then
		if aTriggerName == "JumpOrAscendStart" then
			tCurrentMovementStartAtRec = GetTimePreciseSec()
		elseif aTriggerName == "AscendStop" then
			tCurrentMovementDone = tCurrentMovementDone + (GetTimePreciseSec() - tCurrentMovementStartAtRec)
			--print(tCurrentMovementDone)
		end
	end
end

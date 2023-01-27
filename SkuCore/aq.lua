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
	[2] = {name = "Kimberly", path = "kim"},
	[3] = {name = "Kevin", path = "kev"},
}

local tOutputStyles = {
	[1] = L["long"],
	[2] = L["short"],
}

local tPowerTypes = {
	["NOTHING"] = {name = L["nichts"], number = -1},
	["MANA"] = {name = L["MANA"], number = 0},
	["RAGE"] = {name = L["RAGE"], number = 1},
	["ENERGY"] = {name = L["ENERGY"], number = 3},
	["RUNIC_POWER"] = {name = L["RUNIC_POWER"], number = 6},
}

local tDebuffTypes = {
	["magic"] = L["magic"],
	["curse"] = L["curse"],
	["poison"] = L["poison"],
	["disease"] = L["disease"],
}
local tDebuffTypesShort = {
	["magic"] = L["magic_short"],
	["curse"] = L["curse_short"],
	["poison"] = L["poison_short"],
	["disease"] = L["disease_short"],
}
local tRoles = {
	[1] = L["Tanks"],
	[2] = L["Healers"],
	[3] = L["Damagers"],
	[4] = L["No role"],
}

local tUnitNumbers = {
	["player"] = 1,
	["party1"] = 2,
	["party2"] = 3,
	["party3"] = 4,
	["party4"] = 5,
}
local tUnitNumbersIndexed = {
	[1] = "player",
	[2] = "party1",
	[3] = "party2",
	[4] = "party3",
	[5] = "party4",
}
local tEventOutputFilters = {
	minAbsoluteSincePrevEvent = {name = L["minimum percent difference since previous event"], values = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,22,25,30}, defaults = {5, 5, 0, 0}, id = 1, },
	minStepsSincePrevEvent = {name = L["minimum steps difference since previous event"], values = {0,1,2,3,4,5,6,7,}, defaults = {0, 0, 1, 1}, id = 2, },
}

local tAuraRepo = {}
local ttimeMonParty2Queue = {}
local ttimeMonParty2QueueCurrentTime = 0
local ttimeMonParty2QueueDefaultOutputLength = 0.2

---------------------------------------------------------------------------------------------------------------------------------------
local function ttimeMonParty2QueueAdd(aUnitNumber, aVolume, aPitch, aLength, aRole, aHealthAbsoluteValue, aIgnorePrio)
	aLength = aLength or ttimeMonParty2QueueDefaultOutputLength

	if #ttimeMonParty2Queue > 0 then
		if SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput[aRole] == true and aIgnorePrio ~= true then
			local tFound
			local tFoundVol
			for x = 1, #ttimeMonParty2Queue do
				if ttimeMonParty2Queue[x].tUnitNumber == aUnitNumber then
					tFound = x
					tFoundVol = ttimeMonParty2Queue[x].tVolume
				end
			end
			if tFound then
				table.remove(ttimeMonParty2Queue, tFound)
			end
			if tFoundVol and tFoundVol > aVolume then
				aVolume = tFoundVol
			end
			if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent == true and aHealthAbsoluteValue == 0 then
				table.insert(ttimeMonParty2Queue, 1, {tUnitNumber = "dead", tVolume = aVolume, tPitch = 0, lenght = 0.5,})
			elseif SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent == true and aHealthAbsoluteValue == 100 then
				table.insert(ttimeMonParty2Queue, 1, {tUnitNumber = "full", tVolume = aVolume, tPitch = 0, lenght = 0.15,})
			end
			table.insert(ttimeMonParty2Queue, 1, {tUnitNumber = aUnitNumber, tVolume = aVolume, tPitch = aPitch, lenght = aLength,})
			return
		else
			for x = 1, #ttimeMonParty2Queue do
				if ttimeMonParty2Queue[x].tUnitNumber == aUnitNumber then
					ttimeMonParty2Queue[x].tPitch = aPitch	
					if ttimeMonParty2Queue[x].tVolume < aVolume	then
						ttimeMonParty2Queue[x].tVolume = aVolume
					end
					ttimeMonParty2Queue[x].lenght = aLength
					if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent == true and aHealthAbsoluteValue == 0 then
						table.insert(ttimeMonParty2Queue, x + 1, {tUnitNumber = "dead", tVolume = aVolume, tPitch = 0, lenght = 0.5,})
					elseif SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent == true and aHealthAbsoluteValue == 100 then
						table.insert(ttimeMonParty2Queue, x + 1, {tUnitNumber = "full", tVolume = aVolume, tPitch = 0, lenght = 0.15,})
					end
		
					return
				end
			end
		end
	end

	ttimeMonParty2Queue[#ttimeMonParty2Queue + 1] = {tUnitNumber = aUnitNumber, tVolume = aVolume, tPitch = aPitch, lenght = aLength,}
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent == true and aHealthAbsoluteValue == 0 then
		ttimeMonParty2Queue[#ttimeMonParty2Queue + 1] = {tUnitNumber = "dead", tVolume = aVolume, tPitch = 0, lenght = 0.5,}
	elseif SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent == true and aHealthAbsoluteValue == 100 then
		ttimeMonParty2Queue[#ttimeMonParty2Queue + 1] = {tUnitNumber = "full", tVolume = aVolume, tPitch = 0, lenght = 0.15,}
	end	
end


---------------------------------------------------------------------------------------------------------------------------------------
local function monitorPartyHealth2ContiOutput(aForce)
	if aForce == true then
		ttimeMonParty2Queue = {}
		ttimeMonParty2QueueCurrentTime = 0
	end

	for x = 1, #tUnitNumbersIndexed do
		local tIndex, tUnitID = x, tUnitNumbersIndexed[x]
		local tUnitGUID = UnitGUID(tUnitID)
		if tUnitGUID then
			local tRoleID = SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[tUnitNumbers[tUnitID]]
			if tRoleID == 0 then
				tRoleID = SkuAuras:RoleCheckerGetUnitRole(tUnitGUID)
			end
			local tHealthAbsoluteValue = math.floor((UnitHealth(tUnitID) / UnitHealthMax(tUnitID)) * 100)
			local tHealthStepsValue = math.floor(tHealthAbsoluteValue / (100 / 15))
			if tHealthStepsValue > 14 then
				tHealthStepsValue = 14
			end
		
			if tRoleID and ((SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 == false or (SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 == true and tHealthAbsoluteValue ~= 0 and tHealthAbsoluteValue ~= 100)) or aForce== true) then
				if tHealthAbsoluteValue <= SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt[tRoleID] or aForce== true then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth = SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth or {
						["player"] = {absolute = 100, steps = 14, lastOutput = 0, },
						["party1"] = {absolute = 100, steps = 14, lastOutput = 0, },
						["party2"] = {absolute = 100, steps = 14, lastOutput = 0, },
						["party3"] = {absolute = 100, steps = 14, lastOutput = 0, },
						["party4"] = {absolute = 100, steps = 14, lastOutput = 0, },
					}

					local tUnitNumber, tVolume, tPitch = tUnitNumbers[tUnitID], SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyVolume, (((tHealthStepsValue * 5) - 35) * -1)
					if tPitch == 0 then tPitch = 0 end --dnd, we need this in case of -0
					local tAddlSpeedMod = 1
					if aForce then
						tAddlSpeedMod = 0.5
					end
					ttimeMonParty2QueueAdd(tUnitNumber, tVolume, tPitch, (ttimeMonParty2QueueDefaultOutputLength * (SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay / 100)) * tAddlSpeedMod, tRoleID, tHealthAbsoluteValue, true)
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MonitorPartyHealth2Conti()
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == true then
		monitorPartyHealth2ContiOutput(true)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tHealthMonitorPause = false
local tDebuffMonitorPause = false
local tPowerMonitorPause = false
local tPlayerDebuffsMonitorPause = false
local tPartyDebuffsMonitorPause = false
local tPrevHpPer = 100
local tPrevHpDir = false
local tPrevPwrPer = 100
local tPrevPwrDir = false
local tPrevHpPetPer = 100
local tPrevHpPetDir = false

local function AqCreateControlFrame()
   local f = _G["SkuCoreAqControl"] or CreateFrame("Frame", "SkuCoreAqControl", UIParent)
   local ttime = 0
   local ttimeMonHp = 0
   local ttimeMonHpPet = 0
   local ttimeMonPwr = 0
	local ttimeMonParty = 0
	local ttimeMonParty2 = 0
	local ttimeMonPlayerDebuff = 0
	local ttimeMonPartyDebuff = 0

   f:SetScript("OnUpdate", function(self, time)
		--party health 2 queue manager
		if #ttimeMonParty2Queue > 0 then
			if ttimeMonParty2QueueCurrentTime <= 0 then
				local tUnitNumber, tVolume, tPitch, tLength = ttimeMonParty2Queue[1].tUnitNumber , ttimeMonParty2Queue[1].tVolume , ttimeMonParty2Queue[1].tPitch , ttimeMonParty2Queue[1].lenght
				ttimeMonParty2QueueCurrentTime = tLength
				SkuCore:MonitorOutputPartyPercent2(tUnitNumber, tVolume, tPitch)
				table.remove(ttimeMonParty2Queue, 1)
			else
				ttimeMonParty2QueueCurrentTime = ttimeMonParty2QueueCurrentTime - time
			end
		end

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
							SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path)
						end							
					end

					ttimeMonHp = 0

					if SkuOptions.db.char[MODULE_NAME].aq.player.health.continouslyTimer == SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyTimer then
						ttimeMonPwr = 10000000
					end
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled == true and UnitName("pet") then
				ttimeMonHpPet = ttimeMonHpPet + time
				if ttimeMonHpPet > (SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer) and tHealthMonitorPause == false then
					local health = UnitHealth("pet")
					local healthMax = UnitHealthMax("pet")
					local healthPer = math.floor((health / healthMax) * 100)
					if SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt >= 0 and (math.floor(healthPer / 10) <= SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt) then
						local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps)
						local tNumberToUtterance = ((math.floor(healthPer / tsinglestep)) * tsinglestep) / 10
						tPrevHpPetDir = healthPer > tPrevHpPetPer
						if tPrevHpPetDir == false then
							tNumberToUtterance = tNumberToUtterance + 1
						end
		
						if SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 == false or (tNumberToUtterance < 10 and tNumberToUtterance > 0) then
							SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice].path, "pet")
						end							
					end

					ttimeMonHpPet = 0
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
								SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.power.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.power.voice].path)
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
							SkuCore:MonitorOutputPartyPercent(tUtterances, SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.party.health.instancesOnly, SkuOptions.db.char[MODULE_NAME].aq.party.health.continouslySpeed)
						end

						ttimeMonParty = 0
					end
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled == true then
				ttimeMonPlayerDebuff = ttimeMonPlayerDebuff + time
				if ttimeMonPlayerDebuff > SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyTimer and tPlayerDebuffsMonitorPause == false then
					if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter > -1 then
						local tUnitGUID = UnitGUID("player")
						if tAuraRepo["player"] and tAuraRepo["player"][tUnitGUID] then
							local tPause = 0
							for i, v in pairs(tDebuffTypes) do
								if tAuraRepo["player"][tUnitGUID][i].start > 0 and tAuraRepo["player"][tUnitGUID][i].count > 0 and (GetTime() - tAuraRepo["player"][tUnitGUID][i].start > SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter) then
									if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types[i] == true then									
										C_Timer.After(tPause, function()
											SkuCore:MonitorOutputPlayerStatus({[1] = i}, SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.voice].path)
										end)
										tPause = tPause + 0.3
									end
								end
							end
						end
					end
					ttimeMonPlayerDebuff = 0
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled == true then
				ttimeMonPartyDebuff = ttimeMonPartyDebuff + time
				if ttimeMonPartyDebuff > SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyTimer and tPartyDebuffsMonitorPause == false then
					if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter > -1 then
						local tUnitIdList = SkuCore:UnitIsInUnitGroup("party", "player")
						if tUnitIdList then
							local tPause = 0
							for _, tUnitID in pairs(tUnitIdList) do
								local tUnitGUID = UnitGUID(tUnitID)
								if tAuraRepo["party"] and tAuraRepo["party"][tUnitGUID] then
									for i, v in pairs(tDebuffTypes) do
										if tAuraRepo["party"][tUnitGUID][i].start > 0 and tAuraRepo["party"][tUnitGUID][i].count > 0 and (GetTime() - tAuraRepo["party"][tUnitGUID][i].start > SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter) then
											if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types[i] == true then		
												local tNumber
												if string.sub(tUnitID, 1, 6) == "player" then
													tNumber = 1
												elseif string.sub(tUnitID, 1, 5) == "party" then
													tNumber = tonumber(string.sub(tUnitID, 6))
													if tNumber then
														tNumber = tNumber + 1
													end
												elseif string.sub(tUnitID, 1, 4) == "raid" then
													tNumber = tonumber(string.sub(tUnitID, 5))
													if tNumber then
														tNumber = tNumber + 1
													end
												end
												if tNumber then
													local tTypeString = tDebuffTypesShort[i]
													if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle == 1 then
														tTypeString = i
													end
													C_Timer.After(tPause, function()
														SkuCore:MonitorOutputPlayerStatus({[1] = tTypeString, [2] = tNumber}, SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyVolume, SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.voice].path)
													end)
													tPause = tPause + ((string.len(tTypeString) + string.len(tNumber)) * 0.4)
												end
											end
										end
									end
								end
							end
						end
					end
					ttimeMonPartyDebuff = 0
				end
			end

			if SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == true then
				ttimeMonParty2 = ttimeMonParty2 + time
				if ttimeMonParty2 > SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyTimer then
					monitorPartyHealth2ContiOutput()
					ttimeMonParty2 = 0
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

	SkuCore:RegisterEvent("UNIT_AURA")
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqOnLogin()
	SkuOptions.db.char[MODULE_NAME].aq = SkuOptions.db.char[MODULE_NAME].aq or {}
	SkuOptions.db.char[MODULE_NAME].aq.player = SkuOptions.db.char[MODULE_NAME].aq.player or {}
	SkuOptions.db.char[MODULE_NAME].aq.pet = SkuOptions.db.char[MODULE_NAME].aq.pet or {}
	SkuOptions.db.char[MODULE_NAME].aq.party = SkuOptions.db.char[MODULE_NAME].aq.party or {}

	--party health
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

	--party health 2
	SkuOptions.db.char[MODULE_NAME].aq.party.health2 = SkuOptions.db.char[MODULE_NAME].aq.party.health2 or {}
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, }
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt = {}
		for x = 1, #tRoles do
			SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt[x] = 0
		end
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters = {}
		for x = 1, #tRoles do
			SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[x] = {}
			for i, v in pairs(tEventOutputFilters) do
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[x][v.id] = v.defaults[x]
			end
		end
	end	
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent = true
	end

	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyTimer = 3
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyVolume = 50
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventVolume = 100
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay = 100
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput = {[1] = false, [2] = false, [3] = false, [4] = false, }
	end

	--player health
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

	--pet health
	SkuOptions.db.char[MODULE_NAME].aq.pet.health = SkuOptions.db.char[MODULE_NAME].aq.pet.health or {}
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 = true
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer = 3
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt = -1
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyVolume = 50
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.eventVolume = 80
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps = 10
	end
	if SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice = 1
	end

	--player power
	SkuOptions.db.char[MODULE_NAME].aq.player.power = SkuOptions.db.char[MODULE_NAME].aq.player.power or {}
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.power.type == nil then
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

	--player debuffs
	SkuOptions.db.char[MODULE_NAME].aq.player.debuffs = SkuOptions.db.char[MODULE_NAME].aq.player.debuffs or {}
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types = {["magic"] = false, ["curse"] = false, ["poison"] = false, ["disease"] = false, }
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.ignored == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.ignored = {}
	end

	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter = -1
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyTimer = 6
	end

	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyVolume = 30
	end	
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.eventVolume = 60
	end
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.voice = 2
	end

	--party debuffs
	SkuOptions.db.char[MODULE_NAME].aq.party.debuffs = SkuOptions.db.char[MODULE_NAME].aq.party.debuffs or {}
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types = {["magic"] = false, ["curse"] = false, ["poison"] = false, ["disease"] = false, }
	end

	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.ignored == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.ignored = {}
	end

	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly = false
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter = -1
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle = 2
	end

	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyTimer == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyTimer = 6
	end

	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyVolume = 30
	end	
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.eventVolume == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.eventVolume = 60
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.voice == nil then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.voice = 3
	end
end

--Monitor
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:AqSlashHandler(aFieldsTable)
	if aFieldsTable[2] == "player" and aFieldsTable[3] == "health" then
		SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.health.enabled == false		
	elseif aFieldsTable[2] == "player" and aFieldsTable[3] == "power" then
		SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.power.enabled == false		
	elseif aFieldsTable[2] == "player" and aFieldsTable[3] == "debuffs" then
		SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled = SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled == false		
	elseif aFieldsTable[2] == "pet" and aFieldsTable[3] == "health" then
		SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled = SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled == false		
	elseif aFieldsTable[2] == "party" and aFieldsTable[3] == "debuffs" then
		SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled = SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled == false		
	elseif aFieldsTable[2] == "party" and aFieldsTable[3] == "health" then
		SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled = SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == false		
	elseif aFieldsTable[2] == "party" and aFieldsTable[3] == "roles" and aFieldsTable[4] == "reset" then
		SkuAuras:RoleCheckerResetData()
	elseif aFieldsTable[2] == "party" and aFieldsTable[3] == "roles" and aFieldsTable[4] == "print" then
		for x = 1, #tUnitNumbersIndexed do
			local tUnitGUID = UnitGUID(tUnitNumbersIndexed[x])
			if tUnitGUID then
				local tRoleID = SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[tUnitNumbers[aUnitID]]
				if tRoleID == 0 or tRoleID == nil then
					tRoleID = SkuAuras:RoleCheckerGetUnitRole(tUnitGUID)
				end
				print(x, UnitName(tUnitNumbersIndexed[x]), tRoles[tRoleID] or L["Unknown"])
			end
		end
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
					SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume, SkuOptions.db.char[MODULE_NAME].aq.player.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path)
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
	elseif aUnitID == "playerpet" or aUnitID == "pet" then
		if SkuOptions.db.char[MODULE_NAME].aq then
			if SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled == true and UnitName("pet") then
				local health = UnitHealth("pet")
				local healthMax = UnitHealthMax("pet")
				local healthPer = math.floor((health / healthMax) * 100)
				local tsinglestep = math.floor(100 / SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps)
				local tNumberToUtterance = ((math.floor(healthPer / tsinglestep)) * tsinglestep) / 10
				tPrevHpPetDir = healthPer > tPrevHpPetPer
				if tPrevHpPetDir == false then
					tNumberToUtterance = tNumberToUtterance + 1
				end

				if tNumberToUtterance ~= tPrevHpPetPer then
					SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.pet.health.eventVolume, SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice].path, "pet")
					tHealthMonitorPause = true
					tPowerMonitorPause = true
					C_Timer.After(SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer, function()
						tHealthMonitorPause = false
						tPowerMonitorPause = false
					end)
					tPrevHpPetPer = tNumberToUtterance
				end
			end
		end
	end

	--party health 2
	if SkuOptions.db.char[MODULE_NAME].aq then
		if SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == true then
			if aUnitID == "player" or aUnitID == "party1" or aUnitID == "party2" or aUnitID == "party3" or aUnitID == "party4" then
				local tUnitGUID = UnitGUID(aUnitID)
				local tRoleID = SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[tUnitNumbers[aUnitID]]
				if tRoleID == 0 then
					tRoleID = SkuAuras:RoleCheckerGetUnitRole(tUnitGUID)
				end
				
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth = SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth or {
					["player"] = {absolute = 100, steps = 14, lastOutput = 0, },
					["party1"] = {absolute = 100, steps = 14, lastOutput = 0, },
					["party2"] = {absolute = 100, steps = 14, lastOutput = 0, },
					["party3"] = {absolute = 100, steps = 14, lastOutput = 0, },
					["party4"] = {absolute = 100, steps = 14, lastOutput = 0, },
				}

				local tHealthAbsoluteValue = math.floor((UnitHealth(aUnitID) / UnitHealthMax(aUnitID)) * 100)
				--if SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 == true and (tHealthAbsoluteValue < 1 or tHealthAbsoluteValue > 99) then
					--return
				--end

				local tHealthStepsValue = math.floor(tHealthAbsoluteValue / (100 / 15))
				if tHealthStepsValue > 14 then
					tHealthStepsValue = 14
				end

				local tminAbsoluteSincePrevEventValue = SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[tRoleID][tEventOutputFilters["minAbsoluteSincePrevEvent"].id]
				local tminStepsSincePrevEventValue = SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[tRoleID][tEventOutputFilters["minStepsSincePrevEvent"].id]

				if (
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].absolute - tHealthAbsoluteValue >= tminAbsoluteSincePrevEventValue 
						or 
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].absolute - tHealthAbsoluteValue <= -tminAbsoluteSincePrevEventValue 
					)
					and
					(
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].steps - tHealthStepsValue >= tminStepsSincePrevEventValue 
						or 
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].steps - tHealthStepsValue <= -tminStepsSincePrevEventValue 
					)
				then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].absolute = tHealthAbsoluteValue
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].steps = tHealthStepsValue
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.prevHealth[aUnitID].lastOutput = GetTime()

					local tUnitNumber, tVolume, tPitch = tUnitNumbers[aUnitID], SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventVolume, (((tHealthStepsValue * 5) - 35) * -1)
					if tPitch == 0 then tPitch = 0 end --dnd, we need this in case of -0

					ttimeMonParty2QueueAdd(tUnitNumber, tVolume, tPitch, (ttimeMonParty2QueueDefaultOutputLength * (SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay / 100)), tRoleID, tHealthAbsoluteValue)
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
						SkuCore:MonitorOutputPlayerPercent(tNumberToUtterance, SkuOptions.db.char[MODULE_NAME].aq.player.power.eventVolume, SkuOptions.db.char[MODULE_NAME].aq.player.power.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.power.voice].path)
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
---@param aFilter string "player"
---@param aFilter string "playerpet"
---@param aFilter string "party"
---@param aFilter string "partyandpets"
---@param aFilter string "raid"
---@param aFilter string "raidandpets"
---@param aUnitID string
function SkuCore:UnitIsInUnitGroup(aFilter, aUnitID)
	if not aUnitID then
		return
	end

	if not string.find(aUnitID, "player") and not string.find(aUnitID, "party") and not string.find(aUnitID, "raid") then
		return
	end

	if aFilter == "player" then
		local tUnit = UnitGUID(aUnitID)
		local tPlayer = UnitGUID("player")
		if tUnit == tPlayer then
			return {"player",}
		end
	elseif aFilter == "playerpet" then
		local tUnit = UnitGUID(aUnitID)
		local tPet = UnitGUID("playerpet")
		if tUnit == tPet then
			return {"playerpet",}
		end	
	elseif aFilter == "party" then
		if UnitPlayerOrPetInParty(aUnitID) and UnitIsPlayer(aUnitID) then
			return {"player", "party1", "party2", "party3", "party4"}
		end
	elseif aFilter == "partyandpets" then
		if UnitPlayerOrPetInParty(aUnitID) then
			return {"player", "party1", "party2", "party3", "party4", "playerpet", "party1pet", "party2pet", "party3pet", "party4pet"}
		end
	elseif aFilter == "raid" then
		if UnitPlayerOrPetInRaid(aUnitID) and UnitIsPlayer(aUnitID) then
			local tTable = {}
			for x = 1, 25 do
				tTable[x] = "raid"..x
			end
			return tTable
		end
	elseif aFilter == "raidandpets" then
		if UnitPlayerOrPetInRaid(aUnitID) then
			local tTable = {}
			for x = 1, 25 do
				tTable[x] = "raid"..x
			end
			for x = 26, 50 do
				tTable[x] = "raid"..x.."pet"
			end
			return tTable
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
--[[
local function UnitDebuffTest(x)
	if x == 1 then
		return "TestMagie1 2", "icon", 2, "Magic"
	elseif x == 2 then
		return "TestMagie2 1", "icon", 1, "Magic"
	elseif x == 3 then
		return "TestCurse2 1", "icon", 1, "Curse"
	end
end
]]
function SkuCore:UNIT_AURA(aEventName, aUnitID)
	local tSubR
	local tUnitIdList = {}
	if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled == true and SkuCore:UnitIsInUnitGroup("player", aUnitID) then
		tSubR = "player"
	end
	if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled == true and SkuCore:UnitIsInUnitGroup("party", aUnitID) then
		tSubR = "party"
	end

	if tSubR == nil then
		return
	end

	local tUnitGUID = UnitGUID(aUnitID)
	local tUnitName = UnitName(aUnitID) 
	local tDebuff = UnitDebuff(aUnitID, 1)
	
	tAuraRepo[tSubR] = tAuraRepo[tSubR] or {}

	if tDebuff == nil then
		tAuraRepo[tSubR][tUnitGUID] = nil
	else
		local tPause = 0

		local tCurrentDebuffType = {
			["magic"] = 0,
			["curse"] = 0,
			["poison"] = 0,
			["disease"] = 0,
		}
		local tFound
		for x = 1, 100 do
			local name, icon, count, dispelType, duration, expirationTime,	source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer = UnitDebuff(aUnitID, x) --UnitDebuffTest(x)
			if name then
				if dispelType then
					if not SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.ignored[name] then
						if count == 0 then count = 1 end
						tCurrentDebuffType[string.lower(dispelType)] = tCurrentDebuffType[string.lower(dispelType)] + count
						tFound = true
					end
				end
			end
		end
		if tFound then
			tAuraRepo[tSubR][tUnitGUID] = tAuraRepo[tSubR][tUnitGUID] or {
				["magic"] = {count = 0, start = 0,},
				["curse"] = {count = 0, start = 0,},
				["poison"] = {count = 0, start = 0,},
				["disease"] = {count = 0, start = 0,},
			}
			for i, v in pairs(tDebuffTypes) do
				if tCurrentDebuffType[i] > 0 and tCurrentDebuffType[i] ~= tAuraRepo[tSubR][tUnitGUID][i].count then
					tAuraRepo[tSubR][tUnitGUID][i].count = tCurrentDebuffType[i]
					tAuraRepo[tSubR][tUnitGUID][i].start = GetTime()
					if SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.types[i] == true then
						C_Timer.After(tPause, function()
							if tSubR == "player" then
								SkuCore:MonitorOutputPlayerStatus({[1] = i,}, SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.eventVolume, SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.voice].path)
							elseif tSubR == "party" then
								local tNumber
								if string.sub(aUnitID, 1, 6) == "player" then
									tNumber = 1
								elseif string.sub(aUnitID, 1, 5) == "party" then
									tNumber = tonumber(string.sub(aUnitID, 6))
									if tNumber then
										tNumber = tNumber + 1
									end
								elseif string.sub(aUnitID, 1, 4) == "raid" then
									tNumber = tonumber(string.sub(aUnitID, 5))
									if tNumber then
										tNumber = tNumber + 1
									end
								end
								if tNumber then
									local tTypeString = tDebuffTypesShort[i]
									if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle == 1 then
										tTypeString = i
									end

									SkuCore:MonitorOutputPlayerStatus({[1] = tTypeString, [2] = tNumber,}, SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.eventVolume, SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.instancesOnly, tVoices[SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.voice].path)								
									tPause = tPause + 0.3
								end
							end
						end)
						tPartyDebuffsMonitorPause = true
						tPlayerDebuffsMonitorPause = true
						C_Timer.After(SkuOptions.db.char[MODULE_NAME].aq[tSubR].debuffs.continouslyTimer, function()
							tPartyDebuffsMonitorPause = false
							tPlayerDebuffsMonitorPause = false
							end)
					end
				elseif tCurrentDebuffType[i] == 0 then
					tAuraRepo[tSubR][tUnitGUID][i].count = 0
					tAuraRepo[tSubR][tUnitGUID][i].start = 0
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MonitorOutputPlayerStatus(aStatusTable, aVol, aInstancesOnly, aVoice)
	local inInstance = IsInInstance() 
	if aInstancesOnly == true and inInstance ~= true then
		return
	end
	local tPause = 0
	for x = 1, #aStatusTable do
		C_Timer.After(tPause, function()
			PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..aVoice.."\\"..aVoice.."_"..aStatusTable[x].."_"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
		end)
		tPause = tPause + (string.len(aStatusTable[x]) * 0.03) + 0.3
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
function SkuCore:MonitorOutputPartyPercent(aHealthValues, aVolume, aInstancesOnly, aSpeed)
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
function SkuCore:MonitorOutputPartyPercent2(aUnitNumber, aVolume, aPitch)
	PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\jus\\pitch\\jus_"..aUnitNumber.."_"..aVolume.."_"..aPitch..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
end

---------------------------------------------------------------------------------------------------------------------------------------
local tRandomStC = 1
local tRandomSt = {
	[1] = "kimberlyteasesme",
	[2] = "iwantanicecream",
	[3] = "ineedtopee",
	[4] = "ifeeldizzy",
	[5] = "howarewedoing",
	[6] = "arewethereyet",
	[7] = "arewedoneyet",
}
local tPrevOutputHandle = {}
function SkuCore:MonitorOutputPlayerPercent(aValue, aVol, aInstancesOnly, aVoice, aPrefix)
	local inInstance = IsInInstance() 
	if aInstancesOnly == true and inInstance ~= true then
		return
	end

	if aValue >= 10 then
		aValue = 10--"full"
	elseif aValue < 0 then
		aValue = 0
	end

	if tPrevOutputHandle[aVoice] then
		StopSound(tPrevOutputHandle[aVoice])
	end

	local tPause = 0
	if aPrefix then
		PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..aVoice.."\\"..aVoice.."_"..aPrefix.."_"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")	
		tPause = tPause + (string.len(aPrefix) * 0.03) + 0.2	
	end
	C_Timer.After(tPause, function()
		_, tPrevOutputHandle[aVoice] = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..aVoice.."\\"..aVoice.."_"..aValue.."_"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
	end)

	if SkuOptions.db.char[MODULE_NAME].aq.player.health.iceCreamBought ~= true then
		if math.random(1, 750) == 750 then	
			C_Timer.After(tPause + 1, function()
				_, tPrevOutputHandle[aVoice] = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..aVoice.."\\"..aVoice.."_"..tRandomSt[tRandomStC].."_"..aVol..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
			end)
			tRandomStC = tRandomStC + 1
			if tRandomStC > 7 then
				tRandomStC = 1
			end
		end
	end

end

--menu

---------------------------------------------------------------------------------------------------------------------------------------
local function MonitorSpellMenuBuilder(self)
	local tUnitType = "player"
	if self.parent.parent.name == L["Party"] then
		tUnitType = "party"
	end

	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["ignored"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.isSelect = true
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		if aName ~= L["Empty"] then
			SkuOptions.db.char[MODULE_NAME].aq[tUnitType].debuffs.ignored[self.spellName] = nil
		end
	end
	tNewMenuEntry.BuildChildren = function(self)
		local tFound
		for spellName, _ in pairs(SkuOptions.db.char[MODULE_NAME].aq[tUnitType].debuffs.ignored) do
			local tSpellEntry = SkuOptions:InjectMenuItems(self, {spellName}, SkuGenericMenuItem)
			tSpellEntry.dynamic = true
			tSpellEntry.BuildChildren = function(self)
				local tActionEntry = SkuOptions:InjectMenuItems(self, {L["remove from ignore list"]}, SkuGenericMenuItem)
				tActionEntry.OnEnter = function(self, aValue, aName)
					self.selectTarget.spellName = spellName
				end
			end
			tFound = true
		end
		if not tFound then
			local tSpellEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
		end
	end

	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["not ignored"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.filterable = true
	tNewMenuEntry.isSelect = true
	tNewMenuEntry.OnAction = function(self, aValue, aName)
		SkuOptions.db.char[MODULE_NAME].aq[tUnitType].debuffs.ignored[self.spellName] = true
	end
	tNewMenuEntry.BuildChildren = function(self)
		local tFoundNames = {}
		for spellId, spellData in pairs(SkuDB.SpellDataTBC) do
			local spellName = spellData[Sku.Loc][SkuDB.spellKeys["name_lang"]]
			if not SkuOptions.db.char[MODULE_NAME].aq[tUnitType].debuffs.ignored[spellName] then
				if not tFoundNames[spellName] then
					tFoundNames[spellName] = true
					local tSpellEntry = SkuOptions:InjectMenuItems(self, {spellName}, SkuGenericMenuItem)
					tSpellEntry.dynamic = true
					tSpellEntry.BuildChildren = function(self)
						local tActionEntry = SkuOptions:InjectMenuItems(self, {L["add to ignore list"]}, SkuGenericMenuItem)
						tActionEntry.OnEnter = function(self, aValue, aName)
							self.selectTarget.spellName = spellName
						end
					end
				end
			end
		end
	end
end

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

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
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
				local willPlay, tPrevOutputHandle = PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aq\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."\\"..tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.health.voice].path.."_yay_"..SkuOptions.db.char[MODULE_NAME].aq.player.health.eventVolume..".mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
				SkuOptions.db.char[MODULE_NAME].aq.player.health.iceCreamBought = true
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

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
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

		--debuffs
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Debuffs"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["debuff types"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Enabled"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types[self.itemName] = true
				else
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types[self.itemName] = false
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				for i, v in pairs(tDebuffTypes) do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.itemName = i
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.types[i] == true then
							return L["Enabled"]
						else
							return L["disabled"]
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
						SkuOptions:InjectMenuItems(self, {L["disabled"]}, SkuGenericMenuItem)
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["ignored debuffs"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = MonitorSpellMenuBuilder

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enable in dungeons/raids only"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.instancesOnly = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end
			
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output starts after seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if aName == -1 then
					return L["Never"]
				else
					return SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Never"] then
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter = -1
				else
					SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyStartAfter = tonumber(aName)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
				for x = 0, 50 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.continouslyVolume = tonumber(aName)
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
				return SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.eventVolume = tonumber(aName)
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
				return tVoices[SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.voice].name
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for x = 1, #tVoices do
					if aName == tVoices[x].name then
						SkuOptions.db.char[MODULE_NAME].aq.player.debuffs.voice = x
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

	local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Pet"]}, SkuGenericMenuItem)
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
				if SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.enabled = true
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
				if SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.instancesOnly = true
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
					return SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Never"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt = -1
				else
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyStartAt = tonumber(aName)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
				for x = 0, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyTimer = tonumber(aName)
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
				if SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.pet.health.silentOn100and0 = true
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
				return SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.pet.health.continouslyVolume = tonumber(aName)
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
				return SkuOptions.db.char[MODULE_NAME].aq.pet.health.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.pet.health.eventVolume = tonumber(aName)
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
				return SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.pet.health.steps = tonumber(aName)
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
				return tVoices[SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice].name
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for x = 1, #tVoices do
					if aName == tVoices[x].name then
						SkuOptions.db.char[MODULE_NAME].aq.pet.health.voice = x
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

	--party
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Party"]}, SkuGenericMenuItem)
	tNewMenuEntry.dynamic = true
	tNewMenuEntry.BuildChildren = function(self)
		--health
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Health Chord Style"]}, SkuGenericMenuItem)
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

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
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

		--health 2
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Health Pitch style"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end


			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Role assignment"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = function(self)
				local tPartyMembers = {
					[1] = L["party member"].." "..1,
					[2] = L["party member"].." "..2,
					[3] = L["party member"].." "..3,
					[4] = L["party member"].." "..4,
					[5] = L["party member"].." "..5,
				}

				for x = 1, #tPartyMembers do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tPartyMembers[x]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[x] = 0
						for w = 1, #tRoles do
							if aName == tRoles[w] then
								SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[x] = w
							end
						end
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						if SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[x] == 0 then
							return L["Auto"]
						else
							return tRoles[SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[x]]
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions:InjectMenuItems(self, {L["Auto"]}, SkuGenericMenuItem)
						for q = 1, #tRoles do
							SkuOptions:InjectMenuItems(self, {tRoles[q]}, SkuGenericMenuItem)
						end
					end
				end

				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Set all to auto"]}, SkuGenericMenuItem)
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self, aValue, aName)
					for x = 1, #tPartyMembers do
						SkuOptions.db.char[MODULE_NAME].aq.party.health2.roleAssigments[x] = 0
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output start at"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tRoles do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tRoles[x]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						if aName == L["Never"] then
							SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt[x] = 0
						else
							SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt[x] = tonumber(aName)
						end
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						return SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyStartAt[x]
					end
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
						for x = 10, 100, 10 do
							SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
						end
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 2, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Event output filters"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tRoles do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tRoles[x]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.BuildChildren = function(self)
						for i, v in pairs(tEventOutputFilters) do
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v.name}, SkuGenericMenuItem)
							tNewMenuEntry.dynamic = true
							tNewMenuEntry.isSelect = true
							tNewMenuEntry.OnAction = function(self, aValue, aName)
								SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[x][v.id] = tonumber(aName)
							end
							tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
								return SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventOutputFilters[x][v.id]
							end
							tNewMenuEntry.BuildChildren = function(self)
								for i1, v1 in pairs(v.values) do
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v1}, SkuGenericMenuItem)
								end
							end
						end
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Prio output"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tRoles do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tRoles[x]}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self, aValue, aName)
						if aName == L["No"] then
							SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput[x] = false
						elseif aName == L["Yes"] then
							SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput[x] = true
						end
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						if SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput[x] == false then
							return L["No"]
						elseif SkuOptions.db.char[MODULE_NAME].aq.party.health2.prioOutput[x] == true then
							return L["Yes"]
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
						SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Silent on 100 and 0 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.silentOn100and0 = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Add sound on 100 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.addSoundOn100Percent = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end		
			
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Add Dead on 0 percent"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.health2.addDeadOn0Percent = true
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
				return SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.continouslyVolume = tonumber(aName)
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
				return SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.eventVolume = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 10, 100, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Percent delay for next output in queue"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.health2.outputQueueDelay = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 20, 150, 10 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end
		end		

		--debuffs
		local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Debuffs"]}, SkuGenericMenuItem)
		tNewMenuEntry.dynamic = true
		tNewMenuEntry.BuildChildren = function(self)
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.enabled = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["debuff types"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Enabled"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types[self.itemName] = true
				else
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types[self.itemName] = false
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				for i, v in pairs(tDebuffTypes) do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v}, SkuGenericMenuItem)
					tNewMenuEntry.dynamic = true
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.itemName = i
					end
					tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
						if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.types[i] == true then
							return L["Enabled"]
						else
							return L["disabled"]
						end
					end
					tNewMenuEntry.BuildChildren = function(self)
						SkuOptions:InjectMenuItems(self, {L["Enabled"]}, SkuGenericMenuItem)
						SkuOptions:InjectMenuItems(self, {L["disabled"]}, SkuGenericMenuItem)
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["ignored debuffs"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.BuildChildren = MonitorSpellMenuBuilder

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Enable in dungeons/raids only"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly == true then
					return L["Yes"]
				else
					return L["No"]
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["No"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly = false
				elseif aName == L["Yes"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.instancesOnly = true
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
				SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
			end
			
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output starts after seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				if aName == -1 then
					return L["Never"]
				else
					return SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter
				end
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				if aName == L["Never"] then
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter = -1
				else
					SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyStartAfter = tonumber(aName)
				end
			end
			tNewMenuEntry.BuildChildren = function(self)
				SkuOptions:InjectMenuItems(self, {L["Never"]}, SkuGenericMenuItem)
				for x = 0, 50 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Output style"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.toutputStyle = 1
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return tOutputStyles[SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle]
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.outputStyle = self.toutputStyle
				C_Timer.After(0.001, function()
					SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
				end)				
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, #tOutputStyles do
					local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tOutputStyles[x]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						self.selectTarget.toutputStyle = x
					end
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous output every seconds"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyTimer
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyTimer = tonumber(aName)
			end
			tNewMenuEntry.BuildChildren = function(self)
				for x = 1, 60 do
					SkuOptions:InjectMenuItems(self, {x}, SkuGenericMenuItem)
				end
			end

			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continuous volume"]}, SkuGenericMenuItem)
			tNewMenuEntry.dynamic = true
			tNewMenuEntry.filterable = true
			tNewMenuEntry.isSelect = true
			tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
				return SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.continouslyVolume = tonumber(aName)
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
				return SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.eventVolume
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.eventVolume = tonumber(aName)
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
				return tVoices[SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.voice].name
			end
			tNewMenuEntry.OnAction = function(self, aValue, aName)
				for x = 1, #tVoices do
					if aName == tVoices[x].name then
						SkuOptions.db.char[MODULE_NAME].aq.party.debuffs.voice = x
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
end
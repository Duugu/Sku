local SKUBEACON_MAJOR, SKUBEACON_MINOR = "SkuBeacon-1.0", 2
local SkuBeacon, oldminor = LibStub:NewLibrary(SKUBEACON_MAJOR, SKUBEACON_MINOR)
if not SkuBeacon then return end

local gDebugLevel = 0
local _G = _G
local CONST_DYNAME_PING_RATE1 = -1
local CONST_DYNAME_PING_RATE2 = -2
local CONST_DYNAME_PING_RATE3 = -3
local CONST_DYNAME_PING_RATE4 = -4
local CONST_DYNAME_PING_RATE5 = -5
local CONST_DYNAME_PING_RATE6 = -6
local CONST_DYNAME_PING_RATE7 = -7

---------------------------------------------------------------------------------------------------------
-- repos
---------------------------------------------------------------------------------------------------------
local gBeaconRepo = {}
local gSoundsetRepo = {}
local gClickClackSoundsetRepo = {}

---------------------------------------------------------------------------------------------------------
-- PRIVATE
---------------------------------------------------------------------------------------------------------
local function Debug(...)
	if gDebugLevel > 0 then
		local tArgs = {...}
		local tString = ""
		for i, v in pairs(tArgs) do 
			if v then
				if type(v) ~= "string" and type(v) ~= "number" then
					v = type(v)
				end
				tString = tString.." "..v
			end
		end
		print(tString)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetDirectionTo(aP1x, aP1y, aP2x, aP2y)
	if aP1x == nil or aP1y == nil or aP2x == nil or aP2y == nil or GetPlayerFacing() == nil then
		return 0
	end
	if aP2x == 0 and aP2y == 0 then
		return 0
	end
		
	local tEp2x = (aP2x - aP1x)
	local tEp2y = (aP2y - aP1y)
	
	local tWa = math.acos(tEp2x / math.sqrt(tEp2x^2 + tEp2y^2)) * (180 / math.pi)
	
	if tEp2y > 0 then
		tWa = tWa * -1
	end
	local tFacing = (GetPlayerFacing() * (180 / math.pi))
	local tFacingFinal = tFacing
	if tFacing > 180 then
		tFacingFinal = (360 - tFacing) * -1
	end

	local tFinal = tWa + tFacingFinal
	if tFinal > 180 then
		tFinal = tFinal - 360
	elseif tFinal < -180 then
		tFinal = 360 + tFinal
	end
	
	local tClockFloat = (tFinal + 15) / 30
	local tClock = math.floor((tFinal + 15) / 30)
	if tClock < 0 then
		tClock = 12 + tClock
	end
	if tClock == 0 then
		tClock = 12
	end

	if tWa == 0 then tFinal = 0 end

	return tClock, tClockFloat, tFinal
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetDistance(sx, sy, dx, dy)
	if not sx or not sy or not dx or not dy then
		return
	end
	return floor(sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)), sqrt((sx - dx) ^ 2 + (sy - dy) ^ 2)
end

---------------------------------------------------------------------------------------------------------------------------------------
local tTime = 0
local tPrevCleanedDirection = true
local tBeaconRunning = false
local function OnUpdate(self, aTime)
	tTime = tTime + aTime
	if tTime > 0.05 then
		if _G["SkuBeaconSkriptRecognizerTurn"] then
			local tDisable = false
			local tFrames = {
				"SkuAuctionConfirmEditBox",
				"SkuOptionsEditBoxEditBox",
				"SkuOptionsEditBoxPaste",
				"SkuNavMMMainEditBoxEditBox",
				"SkuNavMMMainFrameEditBox",
				"ChatFrame1EditBox",
				"MacroFrame",
			}

			for i, v in pairs(tFrames) do
				if _G[v] then
					if _G[v].HasFocus then
						if _G[v]:HasFocus() == true then
							tDisable = true
						end
					else
						if _G[v]:IsShown() then
							tDisable = true
						end
					end
				end
			end

			if SkuOptions:IsMenuOpen() == true then
				tDisable = true
			end
			if tBeaconRunning == true then
				if tDisable == true then
					if _G["SkuBeaconSkriptRecognizerTurn"]:IsShown() then
						_G["SkuBeaconSkriptRecognizerTurn"]:Hide()
					end
				else
					if not _G["SkuBeaconSkriptRecognizerTurn"]:IsShown() then
						_G["SkuBeaconSkriptRecognizerTurn"]:Show()
					end
				end
			else
				if _G["SkuBeaconSkriptRecognizerTurn"]:IsShown() then
					_G["SkuBeaconSkriptRecognizerTurn"]:Hide()
				end
			end
		end

		for iRefs, vRefs in ipairs(gBeaconRepo) do
			local tBeacons = gBeaconRepo[vRefs]
			for iBeacons, vBeacons in ipairs(tBeacons) do
				local tBeacon = tBeacons[vBeacons]
				if tBeacon.active == true then
					local tDoPing
					local tSoundSet = gSoundsetRepo[tBeacon.soundSet]
					local tPlayerPosX, tPlayerPosY = UnitPosition("player")
					local tDistance = GetDistance(tPlayerPosX, tPlayerPosY, tBeacon.posX, tBeacon.posY)
					local tDistanceYards = tDistance
					if not tDistance then
						SkuBeacon:DestroyBeacon(vRefs, vBeacons)
						return
					end

					if tDistance and (not tBeacon.maxDistance or tDistance < tBeacon.maxDistance) then
						if tBeacon.distanceChangedCallback and tDistanceYards ~= tBeacon.oldDistance and tDistanceYards <= tBeacon.maxDistance then
							tBeacon.oldDistance = tDistanceYards
							tBeacon.distanceChangedCallback(tBeacon, tDistanceYards)
						end
	
						local tDirection180 = math.floor(select(3, GetDirectionTo(tPlayerPosX, tPlayerPosY, tBeacon.posX, tBeacon.posY)))
						local tCleanedDirection = (math.floor(tDirection180 / tSoundSet.degreesStep) +1 ) * tSoundSet.degreesStep
						local tUnsignedCleanedDirection = tCleanedDirection
						if tUnsignedCleanedDirection < 0 then tUnsignedCleanedDirection = tUnsignedCleanedDirection * -1 end
						tBeacon.lastPing = tBeacon.lastPing or GetTime()

						if tBeacon.rate == CONST_DYNAME_PING_RATE1 then
							local tDynPingRate = tDistance / 30
							if tDynPingRate < 0.3 then tDynPingRate = 0.3 end
							if tDynPingRate > 5 then tDynPingRate = 5 end
							if GetTime() - tBeacon.lastPing > tDynPingRate then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 2)
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE2 then
							local tDynPingRate = tDistance / 30
							if tDynPingRate < 0.3 then tDynPingRate = 0.3 end
							if tDynPingRate > 5 then tDynPingRate = 5 end

							if GetTime() - tBeacon.lastPing > tDynPingRate then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 2)

							if tUnsignedCleanedDirection > 90 then
								local tMod = tUnsignedCleanedDirection - 90
								--tMod 0-90
								tDistance = tDistance + math.floor((tMod / (tSoundSet.maxDistance / 10)))
							end
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE3 then
							tDistance = tDistance + 4
							local tDynPingRate = 1.3
							local tMinDegree = 45
							if tUnsignedCleanedDirection < tMinDegree then
								tDynPingRate = tDynPingRate - (1 - (tUnsignedCleanedDirection / 45))
							end

							if tDynPingRate < 0.2 then tDynPingRate = 0.2 end
							if tDynPingRate > 0.7 then tDynPingRate = 0.7 end

							if GetTime() - tBeacon.lastPing > tDynPingRate then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 6)
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE4 then
							if GetTime() - tBeacon.lastPing > 1.0 then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 2)
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE5 then
							if GetTime() - tBeacon.lastPing > 0.5 then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 2)
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE6 then
							local tDynPingRate = tDistance / 15
							if tDynPingRate < 1.0 then tDynPingRate = 1.0 end
							if tDynPingRate > 5.5 then tDynPingRate = 5.5 end

							if GetTime() - tBeacon.lastPing > tDynPingRate then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 5)

							if tUnsignedCleanedDirection > 90 then
								local tMod = tUnsignedCleanedDirection - 90
								--tMod 0-90
								tDistance = tDistance + math.floor((tMod / (tSoundSet.maxDistance / 10)))
							end
							if tDistance < 0 then tDistance = 0 end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						elseif tBeacon.rate == CONST_DYNAME_PING_RATE7 then
							local tDynPingRate = tDistance / 15
							if tDynPingRate < 1.0 then tDynPingRate = 1.0 end
							if tDynPingRate > 5.5 then tDynPingRate = 5.5 end

							if GetTime() - tBeacon.lastPing > tDynPingRate then
								tDoPing = true
							end

							tDistance = math.floor((tDistance + 1) / 5)

							if tUnsignedCleanedDirection > 20 then
								local tMod = tUnsignedCleanedDirection - 20
								--tMod 0-90
								tDistance = tDistance + math.floor((tMod / (tSoundSet.maxDistance / 10)))
							end
							if tDistance < 0 then tDistance = 0 end
							if tDistance >= 30 then tDoPing = nil end
							if tDistance > tSoundSet.maxDistance then tDistance = tSoundSet.maxDistance end

						end

						if tBeacon.clickSoundType and tBeacon.clickSoundType ~= "off" and gClickClackSoundsetRepo[tBeacon.clickSoundType] then
							local tClickClackDeg = tBeacon.clickSoundRange or 10
							if tCleanedDirection > tClickClackDeg or tCleanedDirection < -tClickClackDeg then
								if tPrevCleanedDirection == true then
									local tWillPlay, tPlayingHandle = PlaySoundFile(gClickClackSoundsetRepo[tBeacon.clickSoundType].path.."\\"..gClickClackSoundsetRepo[tBeacon.clickSoundType].clackFileName, "Talking Head")
									tPrevCleanedDirection = false
								end
							else
								if tPrevCleanedDirection == false then
									local tWillPlay, tPlayingHandle = PlaySoundFile(gClickClackSoundsetRepo[tBeacon.clickSoundType].path.."\\"..gClickClackSoundsetRepo[tBeacon.clickSoundType].clickFileName, "Talking Head")
									tPrevCleanedDirection = true
								end
							end
						end

						if tDistance <= tBeacon.silenceRange and tBeacon.reachedCallback then
							tBeacon.reachedCallback(tBeacon, tDistanceYards)
						end

						if tDoPing then
							tBeacon.lastPing = GetTime()
							if tDistance >= tBeacon.silenceRange then
								local tVolumeMod = math.floor(tDistance + ((100 - tBeacon.volume) / 10)) --tDistance
								if tVolumeMod < 0 then tVolumeMod = 0 end
								if tVolumeMod > 30 then tVolumeMod = 30 end
								if tBeacon.rate == CONST_DYNAME_PING_RATE6 then
									tVolumeMod = math.floor((tVolumeMod / 100) * (200 - tBeacon.volume))
									if tVolumeMod < 0 then tVolumeMod = 0 end
									if tVolumeMod > 30 then tVolumeMod = 30 end
								end
								if tBeacon.pingCallback then
									tBeacon.pingCallback(tBeacon, tDistanceYards)
								end			
								if tBeacon.volume > 0 then
									local tFile = tSoundSet.path.."\\"..tSoundSet.fileName..";"..tCleanedDirection..";"..tVolumeMod..".mp3"
									local tWillPlay, tPlayingHandle = PlaySoundFile(tFile, "Talking Head")
								end
							end
							break
						end
					end
				end
			end
		end

		tTime = 0
	end
end

---------------------------------------------------------------------------------------------------------
-- lib instance
---------------------------------------------------------------------------------------------------------
function SkuBeacon:Create(aReference)
	Debug("SkuBeacon Create")
	Debug("  Reference:", aReference)

	-- create our frame for onupdate timer
	if not _G["SkuBeaconLibControlFrame"] then
		local f = _G["SkuBeaconLibControlFrame"] or CreateFrame("Frame", "SkuBeaconLibControlFrame", UIParent)
		f:SetScript("OnUpdate", OnUpdate)
	end

	--add caller to reference list
	if not gBeaconRepo[aReference] then
		table.insert(gBeaconRepo, aReference)
		gBeaconRepo[aReference] = {}
	end

	local tWidget = _G["SkuBeaconSkriptRecognizerTurn"]
	if not tWidget then
		tWidget = CreateFrame("Frame", "SkuBeaconSkriptRecognizerTurn", _G["UIParent"])
		tWidget:SetFrameStrata("TOOLTIP")
		tWidget:SetFrameLevel(10000)
		tWidget:SetWidth(10)  
		tWidget:SetHeight(20) 
		local tex = tWidget:CreateTexture(nil, "OVERLAY")
		tex:SetAllPoints()
		tex:SetColorTexture(1, 0, 0, 1)
		tWidget:SetPoint("TOPLEFT", 0, -10)
		tWidget:Hide()
	end

	return SkuBeacon
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:Release(aReference)
	Debug("SkuBeacon Release")
	Debug("  Reference:", aReference)
	
	SkuBeacon:DestroyBeacon(aReference)
	for i, v in ipairs(gBeaconRepo) do
		if v == aReference then
			gBeaconRepo[v] = nil
			table.remove(gBeaconRepo, i)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- PUBLIC
---------------------------------------------------------------------------------------------------------
-- mandatory sound file name format for soundsets:
--		<soundsetName>;<degreeNumber>;<distanceNumber>.mp3
--			int degreeNumber: -180 to 180 in aDegreesStep starting from 0)
--			int distanceNumber: 1 to aMaxDistance
--		Example file name: beacon_male_one;-1;15.mp3 
--			(soundset name "beacon_male_one", degree -1, distance 15)
function SkuBeacon:RegisterSoundSet(aBaseName, aPath, aDegreesStep, aMaxDistance, aFileName)
	if gSoundsetRepo[aBaseName] then return end

	--add the new soundset
	table.insert(gSoundsetRepo, aBaseName)
	gSoundsetRepo[aBaseName] = {
		path = aPath,
		degreesStep = aDegreesStep,
		maxDistance = aMaxDistance,
		fileName = aFileName,
	}
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:RegisterClickClackSoundSet(aFriendlyName, aInternalName, aPath, aClickFileName, aClackFileName)
	if gClickClackSoundsetRepo[aInternalName] then return end
	
	--add the new soundset
	table.insert(gClickClackSoundsetRepo, aInternalName)
	gClickClackSoundsetRepo[aInternalName] = {
		friendlyName = aFriendlyName,
		path = aPath,
		clickFileName = aClickFileName,
		clackFileName = aClackFileName,
	}
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:GetSoundSets()
	return gSoundsetRepo
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:GetClickClackSoundSets()
	return gClickClackSoundsetRepo
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:CreateBeacon(aReference, aBeaconName, aSoundSet, aPosX, aPosY, aRate, aSilenceRange, aVolume, aClickSoundRange, aMaxDistance, aReachedCallback, aDistanceChangedCallback, aPingCallback, aClickSoundType)
	if not gBeaconRepo[aReference] then return false end
	if gBeaconRepo[aReference][aBeaconName] then return false end
	if not gSoundsetRepo[aSoundSet] then return end
	
	--add new beacon
	table.insert(gBeaconRepo[aReference], aBeaconName)
	gBeaconRepo[aReference][aBeaconName] = {
		name = aBeaconName,
		active = false,
		soundSet = aSoundSet,
		posX = aPosX,
		posY = aPosY,
		rate = aRate,
		lastPing = GetTime() - 1000,
		silenceRange = aSilenceRange,
		volume = aVolume or 100,
		clickSoundRange = aClickSoundRange,
		maxDistance = aMaxDistance or 99999,
		reachedCallback = aReachedCallback,
		distanceChangedCallback = aDistanceChangedCallback,
		pingCallback = aPingCallback,
		clickSoundType = aClickSoundType,
	}
	
	return true
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:UpdateBeacon(aReference, aBeaconName, aSoundSet, aPosX, aPosY, aRate, aSilenceRange, aVolume, aNoPingReset)
	Debug("SkuBeacon UpdateBeacon")
	Debug("  aReference:", aReference)
	Debug("  aBeaconName:", aBeaconName)
	Debug("  aSoundSet:", aSoundSet)
	Debug("  aPosX:", aPosX)
	Debug("  aPosY:", aPosY)
	if not gBeaconRepo[aReference] then return false end
	if not gBeaconRepo[aReference][aBeaconName] then return false end

	--update beacon
	gBeaconRepo[aReference][aBeaconName].soundSet = aSoundSet or gBeaconRepo[aReference][aBeaconName].soundSet
	gBeaconRepo[aReference][aBeaconName].posX = aPosX or gBeaconRepo[aReference][aBeaconName].posX
	gBeaconRepo[aReference][aBeaconName].posY = aPosY or gBeaconRepo[aReference][aBeaconName].posY
	gBeaconRepo[aReference][aBeaconName].rate = aRate or gBeaconRepo[aReference][aBeaconName].rate
	if not aNoPingReset then
		gBeaconRepo[aReference][aBeaconName].lastPing = GetTime()
	end
	gBeaconRepo[aReference][aBeaconName].silenceRange = aSilenceRange or gBeaconRepo[aReference][aBeaconName].silenceRange
	gBeaconRepo[aReference][aBeaconName].volume = aVolume or gBeaconRepo[aReference][aBeaconName].volume
end

---------------------------------------------------------------------------------------------------------
-- destroys aBeaconName or all beacons of aReference if aBeaconName is nil
function SkuBeacon:DestroyBeacon(aReference, aBeaconName)
	Debug("SkuBeacon DestroyBeacon")
	Debug("  aReference:", aReference)
	Debug("  aBeaconName:", aBeaconName)
	if not gBeaconRepo[aReference] then return false end

	for i, v in ipairs(gBeaconRepo[aReference]) do
		if (aBeaconName and v == aBeaconName) or (not aBeaconName) then
			SkuBeacon:StopBeacon(aReference, aBeaconName)
			gBeaconRepo[aReference][v] = nil
			table.remove(gBeaconRepo[aReference], i)
		end
	end

end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:GetBeacons(aReference)
	if not gBeaconRepo[aReference] then return false end
	return ipairs(gBeaconRepo[aReference])
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:StartBeacon(aReference, aBeaconName)
	Debug("SkuBeacon StartBeacon")
	Debug("  aReference:", aReference)
	Debug("  aBeaconName:", aBeaconName)
	if not gBeaconRepo[aReference] then return false end
	if not gBeaconRepo[aReference][aBeaconName] then return false end

	gBeaconRepo[aReference][aBeaconName].active = true

	tBeaconRunning = true --_G["SkuBeaconSkriptRecognizerTurn"]:Show()
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:StopBeacon(aReference, aBeaconName)
	Debug("SkuBeacon StopBeacon")
	Debug("  aReference:", aReference)
	Debug("  aBeaconName:", aBeaconName)
	if not gBeaconRepo[aReference] then return false end
	if not gBeaconRepo[aReference][aBeaconName] then return false end

	gBeaconRepo[aReference][aBeaconName].active = false

	tBeaconRunning = false --_G["SkuBeaconSkriptRecognizerTurn"]:Hide()
end

---------------------------------------------------------------------------------------------------------
function SkuBeacon:GetBeaconStatus(aReference, aBeaconName)
	Debug("SkuBeacon GettBeaconStatus")
	Debug("  aReference:", aReference)
	Debug("  aBeaconName:", aBeaconName)
	if not gBeaconRepo[aReference] then return nil end
	if not gBeaconRepo[aReference][aBeaconName] then return nil end

	return gBeaconRepo[aReference][aBeaconName].active
end
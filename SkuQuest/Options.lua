local MODULE_NAME = "SkuQuest"
local L = Sku.L

SkuQuest.questMarkerBeaconsTypeValues = {
	[-1] = L["schneller je näher, lauter je näher"],
	[-2] = L["schneller je näher, lauter je näher; lauter in blickrichtung"],
	[-3] = L["schneller in blickrichtung, lauter je näher"],
	[-4] = L["gleichbleibend langsam, lauter je näher"],
	[-5] = L["gleichbleibend schnell, lauter je näher"],
	[-6] = L["sehr langsam, schneller je näher, lauter je näher; lauter in blickrichtung"],
	[-7] = L["sehr langsam, schneller je näher, lauter je näher; nur in blickrichtung"],
}

SkuQuest.options = {
	name = MODULE_NAME,
	type = "group",
	args = {
		showDifficultyColors = {
			name = L["show colors for difficulty"],
			order = 1,
			type = "toggle",
			desc = "",
			set = function(info,val)
				SkuOptions.db.profile[MODULE_NAME].showDifficultyColors = val
			end,
			get = function(info) 
				return SkuOptions.db.profile[MODULE_NAME].showDifficultyColors
			end,
		},
		questMarkerBeacons ={
			name = L["quest notifications"],
			type = "group",
			order = 2,
			args= {
				availableQuests ={
					name = L["available (can be accepted)"],
					type = "group",
					order = 1,
					args= {
						enabled = {
							order = 1,
							name = L["Enabled"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enabled = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enabled
							end
						},
						enableBeacons = {
							order = 1.4,
							name = L["enable Beacons"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enableBeacons = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enableBeacons
							end
						},
						enableClickClack = {
							order = 1.5,
							name = L["Ton für Klick bei Beacons"],
							desc = "",
							type = "select",
							values = SkuNav.ClickClackSoundsets,
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)			
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enableClickClack = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.enableClickClack
							end
						},						
						singlePing = {
							order = 1.75,
							name = L["only one beacon ping"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.singlePing = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.singlePing
							end
						},

						-- beacon sound
						beaconSoundSet = {
							order = 2,
							name = L["beacon sound"],
							desc = "",
							type = "select",
							values = SkuNav.BeaconSoundSetNames,
							OnAction = function(self, info, val)
								local tPlayerPosX, tPlayerPosY = UnitPosition("player")
								tPlayerPosX, tPlayerPosY = tPlayerPosX + 6, tPlayerPosY + 6
								if not SkuOptions.BeaconLib:CreateBeacon("SkuOptions", "sampleBeacon", SkuNav.BeaconSoundSetNames[val], tPlayerPosX + 10, tPlayerPosY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume, SkuOptions.db.profile[MODULE_NAME].clickClackRange) then
									return
								end
								SkuOptions.BeaconLib:StartBeacon("SkuOptions", "sampleBeacon")
								C_Timer.After(1, function()
									SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", "sampleBeacon")
								end)

								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,	
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconSoundSet = SkuNav.BeaconSoundSetNames[val]
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconSoundSet
							end
						},				
						-- beacon type
						beaconType = {
							order = 3,
							name = L["beacon type"],
							desc = "",
							type = "select",
							values = SkuQuest.questMarkerBeaconsTypeValues,
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconType = SkuQuest.questMarkerBeaconsTypeValues[val]
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconType
							end
						},									
						-- beacon volume
						beaconVolume = {
							order = 4,
							name = L["beacon volume"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconVolume = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.beaconVolume
							end
						},
				
						-- max range
						maxRange = {
							order = 5,
							name = L["max notification range"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.maxRange = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.maxRange
							end
						},
						-- chat output
						chatNotification = {
							order = 6,
							name = L["chat notification"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.chatNotification = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.chatNotification
							end
						},
						-- disable on
						disableOn = {
							order = 7,
							name = L["distance to quest giver for disabling quest notification"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.disableOn = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.disableOn
							end
						},						
						-- disable seen forever
						disableSeenForever = {
							order = 8,
							name = L["disable seen quest notifications forever"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.disableSeenForever = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.disableSeenForever
							end
						},
						minLevel = {
							order = 9,
							name = L["Ignore quests x levels below your level"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.minLevel = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.availableQuests.minLevel
							end
						},						

					},
				},
				currentQuests ={
					name = L["current (in your log, ready to hand in)"],
					type = "group",
					order = 1,
					args= {
						enabled = {
							order = 1,
							name = L["Enabled"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enabled = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enabled
							end
						},
						enableBeacons = {
							order = 1.4,
							name = L["enable Beacons"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enableBeacons = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enableBeacons
							end
						},
						enableClickClack = {
							order = 1.5,
							name = L["Ton für Klick bei Beacons"],
							desc = "",
							type = "select",
							values = SkuNav.ClickClackSoundsets,
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)			
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enableClickClack = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.enableClickClack
							end
						},						
						singlePing = {
							order = 1.75,
							name = L["only one beacon ping"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.singlePing = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.singlePing
							end
						},

						beaconSoundSet = {
							order = 2,
							name = L["beacon sound"],
							desc = "",
							type = "select",
							values = SkuNav.BeaconSoundSetNames,
							OnAction = function(self, info, val)
								local tPlayerPosX, tPlayerPosY = UnitPosition("player")
								tPlayerPosX, tPlayerPosY = tPlayerPosX + 6, tPlayerPosY + 6
								if not SkuOptions.BeaconLib:CreateBeacon("SkuOptions", "sampleBeacon", SkuNav.BeaconSoundSetNames[val], tPlayerPosX + 10, tPlayerPosY, -3, 0, SkuOptions.db.profile["SkuNav"].beaconVolume, SkuOptions.db.profile[MODULE_NAME].clickClackRange) then
									return
								end
								SkuOptions.BeaconLib:StartBeacon("SkuOptions", "sampleBeacon")
								C_Timer.After(1, function()
									SkuOptions.BeaconLib:DestroyBeacon("SkuOptions", "sampleBeacon")
								end)

								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,	
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconSoundSet = SkuNav.BeaconSoundSetNames[val]
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconSoundSet
							end
						},
						-- beacon type
						beaconType = {
							order = 3,
							name = L["beacon type"],
							desc = "",
							type = "select",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							values = SkuQuest.questMarkerBeaconsTypeValues,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconType = SkuQuest.questMarkerBeaconsTypeValues[val]
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconType
							end
						},							
						-- beacon volume
						beaconVolume = {
							order = 4,
							name = L["beacon volume"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconVolume = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.beaconVolume
							end
						},
				
						-- max range
						maxRange = {
							order = 5,
							name = L["max notification range"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.maxRange = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.maxRange
							end
						},
						-- chat output
						chatNotification = {
							order = 6,
							name = L["chat notification"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.chatNotification = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.chatNotification
							end
						},
						-- disable on
						disableOn = {
							order = 7,
							name = L["distance to quest giver for disabling quest notification"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.disableOn = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.disableOn
							end
						},						
						-- disable seen forever
						disableSeenForever = {
							order = 8,
							name = L["disable seen quest notifications forever"],
							desc = "",
							type = "toggle",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.disableSeenForever = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.disableSeenForever
							end
						},						
						minLevel = {
							order = 9,
							name = L["Ignore quests x levels below your level"],
							desc = "",
							type = "range",
							OnAction = function(self, info, val)
								SkuQuest:UpdateZoneAvailableQuestList(true)
							end,
							set = function(info,val)
								SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.minLevel = val
							end,
							get = function(info)
								return SkuOptions.db.profile[MODULE_NAME].questMarkerBeacons.currentQuests.minLevel
							end
						},						

					},
				},
			},
		},
	}
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuQuest.defaults = {
	enable = true,
	showDifficultyColors = true,
	questMarkerBeacons = {
		availableQuests = {
			enabled = false,
			enableBeacons = true,
			enableClickClack = "off",
			singlePing = false,
			beaconSoundSet = "Beacon 1",
			beaconType = -7,
			beaconVolume = 40,
			maxRange = 30,
			chatNotification = true,
			disableOn = 5,
			disableSeenForever = false,
			minLevel = 5,
		},
		currentQuests = {
			enabled = false,
			enableBeacons = true,
			enableClickClack = "off",
			singlePing = false,
			beaconSoundSet = "Beacon 3",
			beaconType = -7,
			beaconVolume = 40,
			maxRange = 60,
			chatNotification = true,
			disableOn = 5,			
			disableSeenForever = false,
			minLevel = 15,
		},
	},
}

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuSpairs(t, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, function(a,b) return order(t, a, b) end)
	else
		table.sort(keys)
	end
	local i = 0
	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local tStatesFriendly = {["false"] = L["No"], ["true"] = L["Yes"], ["nil"] = L["Unknown"],}
function SkuQuest:GetQuestDataStringFromDB(aQuestID, aZoneID)
	local tSections = {}

	if aQuestID then
		local i = aQuestID

		table.insert(tSections, L["Quest ID"]..": "..i)

		table.insert(tSections, SkuDB.questLookup[Sku.Loc][i][1]) --de name

		if aQuestID and SkuDB.questDataTBC[aQuestID] then
			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData] then
				local tTemptext = ""
				if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][1] and SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][1][1] == true then
					tTemptext = L["Warning: This quest is blacklisted"]
					if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][1][2] then
						for _, blacklistComment in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][1][2][Sku.Loc]) do
							tTemptext = tTemptext.."\r\n"..blacklistComment
						end
					end
				end
				if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][2] then
					if tTemptext ~= "" then
						tTemptext = tTemptext.."\r\n"
					end
					tTemptext = tTemptext..L["Sku quest comments:"]
					for _, skuComment in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.skuData][2][Sku.Loc]) do
						tTemptext = tTemptext.."\r\n"..skuComment
					end
				end
				table.insert(tSections, tTemptext)
			end
		end

		local tCurrentQuestLogQuestsTable = {}
		local numEntries = GetNumQuestLogEntries()
		if (numEntries > 0) then
			for questLogID = 1, numEntries do
				local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
				tCurrentQuestLogQuestsTable[questID] = true
			end
		end
		if not tCurrentQuestLogQuestsTable[aQuestID] then
			table.insert(tSections, L["Completed"]..": "..tStatesFriendly[tostring(C_QuestLog.IsQuestFlaggedCompleted(i))]) --https://wowpedia.fandom.com/wiki/API_C_QuestLog.GetAllCompletedQuestIDs
		else
			table.insert(tSections, L["Completed: In log"])
		end

		if SkuDB.InternalAreaTable[aZoneID] then
			table.insert(tSections, L["Zone"]..": "..SkuDB.InternalAreaTable[aZoneID].AreaName_lang[Sku.Loc])
		else
			table.insert(tSections, L["Zone: Unknown"])
		end

		table.insert(tSections, L["Level"]..": "..SkuDB.questDataTBC[i][SkuDB.questKeys["questLevel"]].." ("..SkuDB.questDataTBC[i][SkuDB.questKeys["requiredLevel"]]..")")

		if SkuDB.questLookup[Sku.Loc][i][3] then
			table.insert(tSections, L["Objectives"].."\r\n"..(SkuDB.questLookup[Sku.Loc][i][3][1] or ""))
		else
			table.insert(tSections, L["Objectives"].."\r\n")
		end
		--table.insert(tSections, "Questtext\r\n"..questDescription

		local rRaces = {}
		local tFlagH = nil
		local tFlagA = nil
		for iR, vR in pairs(SkuDB.raceKeys) do
			if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredRaces"]]) > 0 then
				table.insert(rRaces, iR)
				if iR == "ALL_HORDE" then
					tFlagH = true
				end
				if iR == "ALL_ALLIANCE" then
					tFlagA = true
				end
			end
		end
		local tRaceText = ""
		if tFlagH then
			tRaceText = tRaceText..SkuQuest.racesFriendly["ALL_HORDE"]..";"
		end
		if tFlagA then
			tRaceText = tRaceText..SkuQuest.racesFriendly["ALL_ALLIANCE"]..";"
		end
		if not tFlagA and not tFlagH then
			for i, v in pairs(rRaces) do
				--dprint(i, v)
				tRaceText = tRaceText..SkuQuest.racesFriendly[v]..";"
			end
		end
		table.insert(tSections, L["Races"]..": "..tRaceText)

		local tClasses = {}
		for iR, vR in pairs(SkuDB.classKeys) do
			if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
				if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]]) > 0 then
					table.insert(tClasses, iR)
				end
			end
		end
		local tClassText = ""
		for i, v in pairs(tClasses) do
			--dprint(i, v)
			tClassText = tClassText..SkuQuest.classesFriendly[v]..";"
		end
		table.insert(tSections, L["Classes"]..": "..tClassText)

		if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
			local preQuestGroup = ""
			for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]]) do
				preQuestGroup = preQuestGroup.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
			end
			table.insert(tSections, L["Pre Quests"]..": "..preQuestGroup)
		end
		if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
			local preQuestSingle = ""
			for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]]) do
				preQuestSingle = preQuestSingle.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
			end
			table.insert(tSections, L["Pre Quest"]..": "..preQuestSingle)
		end
		if SkuDB.questDataTBC[i][SkuDB.questKeys["inGroupWith"]] then -- table: {quest(int)} - to be completed additional to this before next in series
			local inGroupWith = ""
			for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["inGroupWith"]]) do
				inGroupWith = inGroupWith.."\r\n"..iR.." "..SkuDB.questLookup[Sku.Loc][vR][1]
			end
			table.insert(tSections, L["Quests group"]..": "..inGroupWith)
		end

		if SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]] then -- table: {quest(int)} - to be completed additional to this before next in series
			if SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]] then
				if SkuDB.questLookup[Sku.Loc][SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]]] then
					if SkuDB.questLookup[Sku.Loc][SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]]][1] then
						local parentQuest = ""
						parentQuest = parentQuest.."\r\n"..SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]].." "..SkuDB.questLookup[Sku.Loc][SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]]][1]
						table.insert(tSections, L["Parent quest"]..": "..parentQuest)
					end
				end
			end
		end


		--if SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]] then -- 
			--table.insert(tSections, "parentQuest: "..SkuDB.questDataTBC[i][SkuDB.questKeys["parentQuest"]])
		--end
		--if SkuDB.questDataTBC[i][SkuDB.questKeys["childQuests"]] then -- table: {quest(int)} - to be completed additional to this before next in series
			--local childQuests = ""
			--for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["childQuests"]]) do
				--childQuests = childQuests..";"..iR.."-"..vR
			--end
			--table.insert(tSections, "childQuests: "..childQuests)
		--end									

		local tFlags = {}
		for iR, vR in pairs(SkuDB.QuestFlags) do
			if SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]] then
				--dprint(iR, vR, SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]])
				if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["questFlags"]]) > 0 then
					table.insert(tFlags, iR)
				end
			end
		end
		local tFlagText = ""
		for i, v in pairs(tFlags) do
			tFlagText = tFlagText..SkuDB.QuestFlagsFriendly[v]..";"
		end
		table.insert(tSections, L["Attributes"]..": "..tFlagText)

		--[[
		['requiredSkill'] = 18, -- table: {skill(int), value(int)}
		['requiredMinRep'] = 19, -- table: {faction(int), value(int)}
		['requiredMaxRep'] = 20, -- table: {faction(int), value(int)}
		['requiredSourceItems'] = 21, -- table: {item(int), ...} Items that are not an objective but still needed for the quest.

		['specialFlags'] = 24, -- bitmask: 1 = Repeatable, 2 = Needs event, 4 = Monthly reset (req. 1). See https://github.com/cmangos/issues/wiki/Quest_template#specialflags

		['reputationReward'] = 26, -- table: {{FACTION,VALUE}, ...}, A list of reputation reward for factions
		]]
	end

	return tSections
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreatureIdHelper(aCreatureIds, aTargetTable, aOnly3, aOnlyUiMapId)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())

	for i, tNpcID in pairs(aCreatureIds) do
		--dprint("CreateRtWpSubmenu", i, tNpcID)		
		local i = tNpcID
		if SkuDB.NpcData.Data[i] then
			local tSpawns = SkuDB.NpcData.Data[i][7]
			if tSpawns then
				for is, vs in pairs(tSpawns) do
					local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
					--we don't care for stuff that isn't in the open world
					if isUiMap and (not aOnlyUiMapId or aOnlyUiMapId == isUiMap ) then
						local tData = SkuDB.InternalAreaTable[is]
						if tData then
							if SkuNav:GetContinentNameFromContinentId(tData.ContinentID) then
								if tData.ContinentID == tPlayerContinentID then
									local tNumberOfSpawns = #vs
									if tNumberOfSpawns > 3 and aOnly3 == true then
										tNumberOfSpawns = 3
									end
									if SkuDB.NpcData.Names[Sku.Loc][i] then
										local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
										local tRolesString = ""
										if not tSubname then
											local tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.Names[Sku.Loc][i], i)
											if #tRoles > 0 then
												for i, v in pairs(tRoles) do
													tRolesString = tRolesString..";"..v
												end
												tRolesString = tRolesString..""
											end
										else
											tRolesString = tRolesString..";"..tSubname
										end
										for sp = 1, tNumberOfSpawns do
											if not aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] then
												aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] = {}
											end
											table.insert(aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString], SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])
										end
									end
								else
									if SkuDB.NpcData.Names[Sku.Loc][i] then
										local tSubname = SkuDB.NpcData.Names[Sku.Loc][i][2]
										local tRolesString = ""
										if not tSubname then
											local tRoles = SkuNav:GetNpcRoles(SkuDB.NpcData.Names[Sku.Loc][i], i)
											if #tRoles > 0 then
												for i, v in pairs(tRoles) do
													tRolesString = tRolesString..";"..v
												end
												tRolesString = tRolesString..""
											end
										else
											tRolesString = tRolesString..";"..tSubname
										end
										if not aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] then
											aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString] = {}
										end
										table.insert(aTargetTable[SkuDB.NpcData.Names[Sku.Loc][i][1]..tRolesString], L["Anderer Kontinent"]..";"..SkuNav:GetContinentNameFromContinentId(tData.ContinentID)..";"..tData.AreaName_lang[Sku.Loc])
									end

								end
							end
						end
					end
				end
			end
		end
	end
	return aTargetTable
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetResultingWps(aSubIDTable, aSubType, aQuestID, tResultWPs, aOnly3, aOnlyUiMapId)
	--dprint("GetResultingWps", aSubIDTable, aSubType, aQuestID, tResultWPs, aOnly3)
	local _, _, tPlayerContinentID  = SkuNav:GetAreaData(SkuNav:GetCurrentAreaId())
	local tCurrentAreaId = SkuNav:GetCurrentAreaId()
	if aSubType == "item" then
		for i, tItemId in pairs(aSubIDTable) do
			--dprint("  i, tItemId", i, tItemId)
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]] then
				for x = 1, #SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]] do
					--dprint("     item drops from object", x, SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]][x])
					local tObjectId = SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["objectDrops"]][x]
					local tObjectData = SkuDB.objectDataTBC[tObjectId]
					if tObjectData then					
						local tObjectSpawns = tObjectData[SkuDB.objectKeys["spawns"]]
						local tObjectName = SkuDB.objectLookup[Sku.Loc][tObjectId] or SkuDB.objectDataTBC[tObjectId][1]
						if tObjectSpawns then
							for is, vs in pairs(tObjectSpawns) do
								local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
								if isUiMap and (not aOnlyUiMapId or aOnlyUiMapId == isUiMap ) then
									--if is == tCurrentAreaId then
										local tData = SkuDB.InternalAreaTable[is]
										if tData then
											if SkuNav:GetContinentNameFromContinentId(tData.ContinentID) then
												if tData.ContinentID == tPlayerContinentID then
													local tNumberOfSpawns = #vs
													if tNumberOfSpawns > 3 and aOnly3 == true then
														tNumberOfSpawns = 3
													end
													for sp = 1, tNumberOfSpawns do
														if not tResultWPs[tObjectName] then
															tResultWPs[tObjectName] = {}
														end
														table.insert(tResultWPs[tObjectName], L["OBJECT"]..";"..tObjectId..";"..tObjectName..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])
													end
												else
													local tNumberOfSpawns = #vs
													if tNumberOfSpawns > 3 and aOnly3 == true then
														tNumberOfSpawns = 3
													end
													for sp = 1, tNumberOfSpawns do
														if not tResultWPs[tObjectName] then
															tResultWPs[tObjectName] = {}
														end
														table.insert(tResultWPs[tObjectName], L["Anderer Kontinent"]..";"..SkuNav:GetContinentNameFromContinentId(tData.ContinentID)..";"..tData.AreaName_lang[Sku.Loc])
													end
												end
											end
										end
									--end
								end
							end
						end
					end
				end
			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["npcDrops"]] then
				CreatureIdHelper(SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["npcDrops"]], tResultWPs, aOnly3, aOnlyUiMapId)
			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["itemDrops"]] then
				--dprint("item drop from item")

			end
			if SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["vendors"]] then
				CreatureIdHelper(SkuDB.itemDataTBC[tItemId][SkuDB.itemKeys["vendors"]], tResultWPs, aOnly3, aOnlyUiMapId)
			end
		end
	elseif aSubType == "object" then
		local tWpList = {}
		for i, tObjectId in pairs(aSubIDTable) do
			if SkuDB.objectDataTBC[tObjectId] then
				local tSpawns = SkuDB.objectDataTBC[tObjectId][4]
				if tSpawns then
					for is, vs in pairs(tSpawns) do
						local isUiMap = SkuNav:GetUiMapIdFromAreaId(is)
						--we don't care for stuff that isn't in the open world
						if isUiMap then
							local tData = SkuDB.InternalAreaTable[is]
							if tData then
								if tPlayerContinentID == tData.ContinentID then
									if (not aAreaId) or aAreaId == isUiMap then
										local tNumberOfSpawns = #vs
										if tNumberOfSpawns > 3 and aOnly3 == true then
											tNumberOfSpawns = 3
										end
										for sp = 1, tNumberOfSpawns do
											local tObjectName = SkuDB.objectLookup[Sku.Loc][tObjectId] or SkuDB.objectDataTBC[tObjectId][1] or L["Object name missing"]
											if not tResultWPs[tObjectName] then
												tResultWPs[tObjectName] = {}
											end
											table.insert(tResultWPs[tObjectName], L["OBJECT"]..";"..tObjectId..";"..tObjectName..";"..tData.AreaName_lang[Sku.Loc]..";"..sp..";"..vs[sp][1]..";"..vs[sp][2])

										end
									end
								else
									if (not aAreaId) or aAreaId == isUiMap then
										local tNumberOfSpawns = #vs
										if tNumberOfSpawns > 3 and aOnly3 == true then
											tNumberOfSpawns = 3
										end
										for sp = 1, tNumberOfSpawns do
											local tObjectName = SkuDB.objectLookup[Sku.Loc][tObjectId] or SkuDB.objectDataTBC[tObjectId][1] or L["Object name missing"]
											if not tResultWPs[tObjectName] then
												tResultWPs[tObjectName] = {}
											end
											table.insert(tResultWPs[tObjectName], L["Anderer Kontinent"]..";"..SkuNav:GetContinentNameFromContinentId(tData.ContinentID)..";"..tData.AreaName_lang[Sku.Loc])

										end
									end
								end
							end
						end
					end
				end
			end
		end

	elseif aSubType == "creature" then
		CreatureIdHelper(aSubIDTable, tResultWPs, aOnly3, aOnlyUiMapId)

	elseif aSubType == "waypoint" then
		for i, tWaypointName in pairs(aSubIDTable) do
			local tData = SkuNav:GetWaypointData2(tWaypointName)
			if tData then
				local isUiMap = SkuNav:GetUiMapIdFromAreaId(tData.areaId)
				--we don't care for stuff that isn't in the open world
				if isUiMap then
					if not tResultWPs[tWaypointName] then
						tResultWPs[tWaypointName] = {}
					end			
					if tPlayerContinentID == tData.contintentId then
						table.insert(tResultWPs[tWaypointName], tWaypointName)
					else
						table.insert(tResultWPs[tWaypointName], L["Anderer Kontinent"]..";"..tWaypointName)
					end
				end
			end
		end
	end

end
---------------------------------------------------------------------------------------------------------------------------------------
local function CreateRtWpSubmenu(aParent, aSubIDTable, aSubType, aQuestID)
	dprint("CreateRtWpSubmenu aSubIDTable ", aSubIDTable, " - aSubType ", aSubType, " - aQuestID ", aQuestID)
	local tResultWPs = {}
	SkuQuest:GetResultingWps(aSubIDTable, aSubType, aQuestID, tResultWPs)

	local tPlayX, tPlayY = UnitPosition("player")
	local tRoutesInRange = SkuNav:GetAllLinkedWPsInRangeToCoords(tPlayX, tPlayY, SkuNav.MaxMetaEntryRange)--SkuOptions.db.profile["SkuNav"].nearbyWpRange)
	
	local tHasContent = false
	for unitGeneralName, wpTable in pairs(tResultWPs) do
		--dprint(unitGeneralName, wpTable)
		tHasContent = true
		local tNewMenuGeneralName = SkuOptions:InjectMenuItems(aParent, {unitGeneralName}, SkuGenericMenuItem)
		tNewMenuGeneralName.dynamic = true
		tNewMenuGeneralName.BuildChildren = function(self)
			if string.find(wpTable[1], L["Anderer Kontinent"]) then
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {wpTable[1]}, SkuGenericMenuItem)
			else
				local tCoveredWps = {}

				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {L["Route"]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.filterable = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--print("Route onaction", self, aValue, aName)
					if SkuOptions.db.profile["SkuNav"].routeRecording == true then
						SkuOptions.Voice:OutputStringBTtts(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputStringBTtts(L["Recording in progress"], false, true, 0.3, true)
						return
					end
					if SkuOptions.db.profile["SkuNav"].metapathFollowing == true or SkuOptions.db.profile["SkuNav"].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end
					SkuOptions.db.profile["SkuNav"].metapathFollowing = false

					if SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths then
						if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
							SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, aName)--
						if not SkuOptions.db.profile["SkuNav"].metapathFollowingTarget then
							SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = aName
						end
						SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
						SkuOptions.db.profile["SkuNav"].metapathFollowing = true
		
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
						SkuOptions.Voice:OutputStringBTtts(L["Following metaroute"], false, true, 0.2)
		
						SkuOptions:CloseMenu()
					end

				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					SkuOptions.SkuNav_MenuBuilder_WaypointSelectionMenu_CloseRoute = nil
					local tSortedWaypointList = {}
					for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
						local tFnd = false
						for tK, tV in pairs(tSortedWaypointList) do
							if tV == v.nearestWpRange..L[";Meter"].."#"..v.nearestWP then
								tFnd = true
							end
						end
						if tFnd == false then
							table.insert(tSortedWaypointList, v.nearestWpRange..L[";Meter"].."#"..v.nearestWP)
						end
					end

					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
					else
						local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs)--
						SkuOptions.db.profile["SkuNav"].metapathFollowingStart = tSortedWaypointList[1]
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = tMetapaths
						SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = nil

						do -- build route choices
							local tData = {}
							for i, v in pairs(tMetapaths) do
								for wpIndex, wpName in pairs(wpTable) do
									if string.find(i, wpName) then
										tData[i] = tMetapaths[i].distance
									end
								end
							end
							local tSortedList = {}
							for k,v in SkuSpairs(tData, function(t,a,b) return t[b] > t[a] end) do --nach wert
								table.insert(tSortedList, k)
							end
							if #tSortedList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedList) do
									for wpIndex, wpName in pairs(wpTable) do
										if string.find(tV, wpName) then
											local tDistText = tMetapaths[tV].distance..L[";Meter"]
											if tMetapaths[tV].distance >= SkuNav.MaxMetaRange then
												tDistText = L["weit"]
											end

											-- add direction to wp
											local tDirectionTargetWp = ""
											if SkuOptions.db.profile["SkuNav"].showGlobalDirectionInWaypointLists == true then
												local tWpData = SkuNav:GetWaypointData2(tV)
												local tDirectionString = SkuNav:GetDirectionToAsString(tWpData.worldX, tWpData.worldY)
												if tDirectionString then
													tDirectionTargetWp = ";"..tDirectionString
												end
											end
											tDistText = tDistText..tDirectionTargetWp

											local tNewMenuEntry = SkuOptions:InjectMenuItems(self, { SkuNav:getAnnotatedWaypointLabel(tDistText .. "#" .. tV, tV) }, SkuGenericMenuItem)
											tNewMenuEntry.OnEnter = function(self, aValue, aName)
												SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tV
											end
											tCoveredWps[tV] = true
											--tHasContent = true
										end
									end
								end
							end
						end
					end
				end

				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {L["Closest route"]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.filterable = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--dprint("OnAction", self.name, aValue, aName)
					if SkuOptions.db.profile["SkuNav"].routeRecording == true then
						SkuOptions.Voice:OutputStringBTtts(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputStringBTtts(L["Recording in progress"], false, true, 0.3, true)
						return
					end
					if SkuOptions.db.profile["SkuNav"].metapathFollowing == true or SkuOptions.db.profile["SkuNav"].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end
					SkuOptions.db.profile["SkuNav"].metapathFollowing = false
					if SkuOptions.db.profile["SkuNav"].metapathFollowingStart then
						if SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths then
							if string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") then
								SkuOptions.db.profile["SkuNav"].metapathFollowingStart = string.sub(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, string.find(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, "#") + 1)
							end
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, SkuOptions.db.profile["SkuNav"].metapathFollowingTarget, true)--
							--setmetatable(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths, SkuPrintMTWo)
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[#SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths+1] = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
							SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget] = SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingTarget]
							table.insert(SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths[SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget].pathWps, SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget)
							SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget
							SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp = 1
							SkuOptions.db.profile["SkuNav"].metapathFollowing = true
							SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].metapathFollowingStart, true)
							SkuOptions.Voice:OutputStringBTtts(L["Metaroute folgen gestartet"], false, true, 0.2)
							SkuOptions:CloseMenu()
						end
					end
				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					local tMaxAllowedDistanceToTargetWp = 500
					local tSortedWaypointList = {}
					for k, v in SkuSpairs(tRoutesInRange, function(t,a,b) return t[b].nearestWpRange > t[a].nearestWpRange end) do --nach wert
						local tFnd = false
						for tK, tV in pairs(tSortedWaypointList) do
							if tV == v.nearestWpRange..L[";Meter"].."#"..v.nearestWP then
								tFnd = true
							end
						end
						if tFnd == false then
							table.insert(tSortedWaypointList, v.nearestWpRange..L[";Meter"].."#"..v.nearestWP)
						end
					end
					if #tSortedWaypointList == 0 then
						local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
					else
						local tMetapaths = SkuNav:GetAllMetaTargetsFromWp4(SkuNav:GetCleanWpName(tSortedWaypointList[1]), SkuNav.MaxMetaRange, SkuNav.MaxMetaWPs, nil, true)
						SkuOptions.db.profile["SkuNav"].metapathFollowingStart = tSortedWaypointList[1]
						SkuOptions.db.profile["SkuNav"].metapathFollowingMetapaths = tMetapaths

						local tResults = {}
						for wpIndex, wpName in pairs(wpTable) do
							local tNearWps = SkuNav:GetNearestWpsWithLinksToWp(wpName, 10, tMaxAllowedDistanceToTargetWp)
							local tBestRouteWeightedLength = 100000
							for x = 1, #tNearWps do
								if tMetapaths[tNearWps[x].wpName] then
									local EndMetapathWpObj = SkuNav:GetWaypointData2(tNearWps[x].wpName)
									local tEndTargetWpObj = SkuNav:GetWaypointData2(wpName)
									local tDistToEndTargetWp = SkuNav:Distance(EndMetapathWpObj.worldX, EndMetapathWpObj.worldY, tEndTargetWpObj.worldX, tEndTargetWpObj.worldY)

									-- add direction to wp
									local tDirectionTargetWp = ""
									if SkuOptions.db.profile["SkuNav"].showGlobalDirectionInWaypointLists == true then
										local tDirectionString = SkuNav:GetDirectionToAsString(tEndTargetWpObj.worldX, tEndTargetWpObj.worldY)
										if tDirectionString then
											tDirectionTargetWp = ";"..tDirectionString
										end
									end					

									if (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp < tBestRouteWeightedLength then
										tBestRouteWeightedLength = (tMetapaths[tNearWps[x].wpName].distance / SkuNav.BestRouteWeightedLengthModForMetaDistance) + tDistToEndTargetWp
										tResults[wpName] = {
											metarouteIndex = tNearWps[x].wpName, 
											metapathLength = tMetapaths[tNearWps[x].wpName].distance, 
											distanceTargetWp = tNearWps[x].distance,
											targetWpName = wpName,
											weightedDistance = tBestRouteWeightedLength,
											direction = tDirectionTargetWp,
										}
									end
								end
							end
						end

						do -- build choices
							local tSortedList = {}
							for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].weightedDistance > t[a].weightedDistance end) do
								table.insert(tSortedList, k)
							end
							if #tSortedList == 0 then
								local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
							else
								for tK, tV in ipairs(tSortedList) do
									local tNewMenuEntry = SkuOptions:InjectMenuItems(self, { SkuNav:getAnnotatedWaypointLabel(tResults[tV].metapathLength .. ";" .. L["plus"] .. ";" .. tResults[tV].distanceTargetWp .. L[";Meter"] .. tResults[tV].direction .. "#" .. tV, tV) }, SkuGenericMenuItem)
									tNewMenuEntry.OnEnter = function(self, aValue, aName)
										SkuOptions.db.profile["SkuNav"].metapathFollowingTarget = tResults[tV].metarouteIndex
										SkuOptions.db.profile["SkuNav"].metapathFollowingEndTarget = tResults[tV].targetWpName
									end
									tCoveredWps[tV] = true
									--tHasContent = true
								end
							end
						end
					end
				end
			
				local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {L["Wegpunkt"]}, SkuGenericMenuItem)
				tNewMenuSubEntry1.dynamic = true
				tNewMenuSubEntry1.isSelect = true
				tNewMenuSubEntry1.filterable = true
				tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
					--dprint("OnAction Wegpunkt auswählen", self.name, aValue, aName)
					if SkuOptions.db.profile[MODULE_NAME].routeRecording == true then
						SkuOptions.Voice:OutputStringBTtts(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputStringBTtts(L["Recording in progress"], false, true, 0.3, true)
						return
					end

					if SkuOptions.db.profile[MODULE_NAME].metapathFollowing == true or SkuOptions.db.profile[MODULE_NAME].selectedWaypoint ~= "" then
						SkuNav:EndFollowingWpOrRt()
					end

					if SkuNav:GetWaypointData2(SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint) then
						SkuNav:SelectWP(SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint)
						SkuOptions:CloseMenu()
					else
						SkuOptions.Voice:OutputStringBTtts(L["Error"], false, true, 0.3, true)
						SkuOptions.Voice:OutputStringBTtts(L["Wegpunkt nicht ausgewählt"], false, true, 0.3, true)
					end

				end
				tNewMenuSubEntry1.BuildChildren = function(self)
					do -- build choices
						local tPlayX, tPlayY = UnitPosition("player")

						local tResults = {}
						for wpIndex, wpName in pairs(wpTable) do
							local tWpObj = SkuNav:GetWaypointData2(wpName)
							local tDistanceTargetWp = SkuNav:Distance(tPlayX, tPlayY, tWpObj.worldX, tWpObj.worldY)

							-- add direction to wp
							local tDirectionTargetWp = ""
							if SkuOptions.db.profile["SkuNav"].showGlobalDirectionInWaypointLists == true then
								local tDirectionString = SkuNav:GetDirectionToAsString(tWpObj.worldX, tWpObj.worldY)
								if tDirectionString then
									tDirectionTargetWp = ";"..tDirectionString
								end
							end

							tResults[wpName] = {wpName = wpName, distance = tDistanceTargetWp, direction = tDirectionTargetWp,}
						end

						local tSortedList = {}
						for k,v in SkuSpairs(tResults, function(t,a,b) return t[b].distance > t[a].distance end) do
							table.insert(tSortedList, k)
						end
						if #tSortedList == 0 then
							local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty;list"]}, SkuGenericMenuItem)
						else
							for tK, tV in ipairs(tSortedList) do
								local tNewMenuGeneralSp = SkuOptions:InjectMenuItems(self, {SkuNav:getAnnotatedWaypointLabel(tResults[tV].distance..L[";Meter"]..tResults[tV].direction.."#"..tV, tV)}, SkuGenericMenuItem)
								tNewMenuGeneralSp.OnEnter = function(self, aValue, aName)
									SkuOptions.db.profile["SkuNav"].menuFollowTargetWaypoint = tV
								end
								--tHasContent = true
							end
						end
					end
				end
			end
		end
	end

	if tHasContent == false then
		local tNewMenuGeneralName = SkuOptions:InjectMenuItems(aParent, {L["Empty"]}, SkuGenericMenuItem)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetQuestTargetIds(aQuestID, aList)
	local tTargets = {}
	local tTargetType = nil

	if aList[1] then --creatures
		for i, v in pairs(aList[1]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "creature"

	elseif aList[2] then --objects
		for i, v in pairs(aList[2]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "object"

	elseif aList[3] then --items
		for i, v in pairs(aList[3]) do
			if type(v) == "number" then
				tTargets[#tTargets+1] = v
			else
				tTargets[#tTargets+1] = v[1]
			end
		end
		tTargetType = "item"

	elseif aList[4] then--rep
		-- TO IMPLEMENT


	elseif aList[5] then--kills
		tTargets = aList[5][1]
		tTargetType = "creature"

	elseif SkuDB.questDataTBC[aQuestID][SkuDB.questKeys.triggerEnd] then--triggerEnd
		tTargets = SkuQuest:GetTriggerEndWps(aQuestID)
		tTargetType = "waypoint"
	end
	
	return tTargets, tTargetType
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetTriggerEndWps(aQuestId)
	local tWaypoints = {}
	if SkuDB.questDataTBC[aQuestId][SkuDB.questKeys["triggerEnd"]] ~= nil then 
		for zone, data in pairs(SkuDB.questDataTBC[aQuestId][SkuDB.questKeys["triggerEnd"]][2]) do
			local _, taName = SkuNav:GetAreaData(zone)
			if taName then
				if SkuDB.questLookup[Sku.Loc][aQuestId] then
					tWaypoints[#tWaypoints + 1] = SkuDB.questLookup[Sku.Loc][aQuestId][1]..";"..taName..";"..L["Questziel"]..";"..data[1][1]..";"..data[1][2]
				end
			end
		end
	end

	return tWaypoints
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreateQuestSubmenu(aParent, aQuestID)
	local tHasEntries
	--parent qs
	if aQuestID then
		if SkuDB.questDataTBC[aQuestID] then
			local tPreQuestTable = {}
			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
				local preQuestGroup = ""
				for iR, vR in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestGroup"]]) do
					tPreQuestTable[#tPreQuestTable+1] = vR
				end
			end
			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
				local preQuestSingle = ""
				for iR, vR in pairs(SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["preQuestSingle"]]) do
					tPreQuestTable[#tPreQuestTable+1] = vR
				end
			end

			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["parentQuest"]] then -- table: {quest(int)} - one to be completed before next in series
				local parentQuest = ""
				tPreQuestTable[#tPreQuestTable+1] = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["parentQuest"]]
			end

			if #tPreQuestTable > 0 then
				tHasEntries = true
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Pre Quests"]}, SkuGenericMenuItem)
				tNewMenuSubEntry.dynamic = true
				tNewMenuSubEntry.OnAction = function(self, aValue, aName)

				end
				tNewMenuSubEntry.BuildChildren = function(self)
					for i, v in pairs(tPreQuestTable) do
						local tNewMenuSubEntry1 = SkuOptions:InjectMenuItems(self, {SkuDB.questLookup[Sku.Loc][v][1]}, SkuGenericMenuItem)
						tNewMenuSubEntry1.dynamic = true
						tNewMenuSubEntry1.OnAction = function(self, aValue, aName)
							C_Timer.NewTimer(0.1, function()
								SkuOptions:SlashFunc("short,"..L["SkuQuest,Questdatenbank,Alle"]..","..self.name)
								SkuOptions.Voice:OutputStringBTtts(self.name, true, true, 0.3, true)
							end)
						end
					end
				end
			end

			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]] and (SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][1] 
				or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][2]
				or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][3])
			then
				tHasEntries = true
				local tstartedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]]
				if tstartedBy then
					local tTargets = {}
					local tTargetType = nil
					
					tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tstartedBy)

					local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Annahme"]}, SkuGenericMenuItem)
					tNewMenuSubEntry.dynamic = true
					tNewMenuSubEntry.filterable = true
					tNewMenuSubEntry.BuildChildren = function(self)
						tHasEntries = true
						CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
						--CreateRtWpSubmenu(self, SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["startedBy"]][1], "creature", aQuestID)
					end
				end
			end

			local tObjectives = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["objectives"]]
			if tObjectives then
				tHasEntries = true
				local tTargets = {}
				local tTargetType = nil

				tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tObjectives)

				if	tTargetType then
					local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Ziel"]}, SkuGenericMenuItem)
					tNewMenuSubEntry.dynamic = true
					--tNewMenuSubEntry.filterable = true
					tNewMenuSubEntry.OnAction = function(self, aValue, aName)
					end
					tNewMenuSubEntry.BuildChildren = function(self)
						tHasEntries = true
						CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
					end
				end
			end

			if SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]] and (SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][1] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][2] or SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]][3]) then
				tHasEntries = true
				local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Abgabe"]}, SkuGenericMenuItem)
				tNewMenuSubEntry.dynamic = true
				tNewMenuSubEntry.filterable = true
				local tFinishedBy = SkuDB.questDataTBC[aQuestID][SkuDB.questKeys["finishedBy"]]
				if tFinishedBy and tFinishedBy then
					local tTargets = {}
					local tTargetType = nil

					tTargets, tTargetType = SkuQuest:GetQuestTargetIds(aQuestID, tFinishedBy)

					tNewMenuSubEntry.BuildChildren = function(self)
						tHasEntries = true
						CreateRtWpSubmenu(self, tTargets, tTargetType, aQuestID)
					end
				end
			end
		end
	end

	if not tHasEntries then
		local tNewMenuSubEntry = SkuOptions:InjectMenuItems(aParent, {L["Empty"]}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = false
	end
	return tHasEntries
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:GetUnsortedAvailableQuestsTable()
	local tUiMap = SkuNav:GetAreaIdFromUiMapId(SkuNav:GetBestMapForUnit("player"))
	local tPlayX, tPlayY = UnitPosition("player")
	local tShowQuestsTable = {}

	tCurrentQuestLogQuestsTable = {}
	local numEntries, numQuests = GetNumQuestLogEntries()
	if (numEntries >= 0) then
		for questLogID = 1, numEntries do
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
			tCurrentQuestLogQuestsTable[questID] = true
		end
	end
	for i, v in pairs(SkuDB.questLookup[Sku.Loc]) do
		if SkuDB.questDataTBC[i] then
			local tZoneId
			if SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then --creatures
				--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1]
				tZoneId = SkuDB.NpcData.Data[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]][SkuDB.NpcData.Keys['zoneID']]
			elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then --objects
				--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]
				if SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]] then
					tZoneId = SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]]
				end
			elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3] then --items
				--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3]
			end

			if tZoneId == tUiMap then

				local tnextQuestInChain = SkuDB.questDataTBC[i][SkuDB.questKeys["nextQuestInChain"]]
				local tOutFlag = false
				if tnextQuestInChain then
					if tCurrentQuestLogQuestsTable[tnextQuestInChain] then
						tOutFlag = true
					end
					if C_QuestLog.IsQuestFlaggedCompleted(tonumber(tnextQuestInChain)) == true then
						tOutFlag = true
					end
				end
				if (C_QuestLog.IsQuestFlaggedCompleted(i) == false)
					and (SkuDB.questDataTBC[i][SkuDB.questKeys["requiredLevel"]] <= UnitLevel("player"))
					and not tCurrentQuestLogQuestsTable[i]
					and tOutFlag ~= true
				then
					local rRaces = {}
					local tFlagH = nil
					local tFlagA = nil
					local tFlagR = nil
					local tPlayerFactionEn, tPlayerFactionLoc = UnitFactionGroup("player")
					local tPlayerclassName, tPlayerclassFilename, tPlayerclassId = UnitClass("player")
					local tmpraceName, tmpraceFile, tmpraceID = UnitRace("player")
					local tRaceName = C_CreatureInfo.GetRaceInfo(tmpraceID)
					local tCount = 0
					if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredRaces"]] then
						for iR, vR in pairs(SkuDB.raceKeys) do
							if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredRaces"]]) > 0 then
								if iR == "ALL_HORDE" then
									tFlagH = true
								end
								if iR == "ALL_ALLIANCE" then
									tFlagA = true
								end
								if iR ~= "ALL_HORDE" and iR ~= "ALL_ALLIANCE" then
									local tCleanRaceName = string.upper(string.gsub(iR, "_", ""))
									if tCleanRaceName == "UNDEAD" then
										tCleanRaceName = "SCOURGE"
									end
									rRaces[tCleanRaceName] = true
									tCount = tCount + 1
								end
							else
								tFlagH = true
								tFlagA = true
							end
						end
					end
					if tRaceName then
						if rRaces[string.upper(tRaceName.clientFileString)] then
							tFlagR = true
						end
					end

					if not tFlagR then
						if tCount == 0 and ((tPlayerFactionEn == "Alliance" and tFlagA) or (tPlayerFactionEn == "Horde" and tFlagH)) then
							tFlagR = true
						end
					end

					if tFlagR then
						local tClasses = {}
						local tFlagClass = nil
						if not SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
							tFlagClass = true
						end
						for iR, vR in pairs(SkuDB.classKeys) do
							if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]] then
								if bit.band(vR, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredClasses"]]) > 0 then
									tClasses[#tClasses+1] = iR
								end
							end
						end
						for i, v in pairs(tClasses) do
							if tPlayerclassFilename == v then
								tFlagClass = true
							end
						end
						if tFlagClass == true then
							local tPreQuestsTable = {}
							if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]] then -- table: {quest(int)} - all to be completed before next in series
								for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestGroup"]]) do
									tPreQuestsTable[vR] = vR
								end
							end

							local tPreQuestSingleOk = false
							local tHasPreQuestSingle = false
							if SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]] then -- table: {quest(int)} - one to be completed before next in series
								for iR, vR in pairs(SkuDB.questDataTBC[i][SkuDB.questKeys["preQuestSingle"]]) do
									tHasPreQuestSingle = true
									if C_QuestLog.IsQuestFlaggedCompleted(tonumber(vR)) == true then
										tPreQuestSingleOk = true
									end
								end
							end

							local tAllCompletedFlag = true
							for iPQ, vPQ in pairs(tPreQuestsTable) do
								if C_QuestLog.IsQuestFlaggedCompleted(tonumber(vPQ)) == false then
									tAllCompletedFlag = false
								end
							end

							if tAllCompletedFlag == true and (tHasPreQuestSingle == false or (tHasPreQuestSingle == true and  tPreQuestSingleOk == true)) then
								
								local tIsOk = true
								--dprint(i, SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]])
								if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]] then
									local tFaction = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]][1]
									if tFaction then
										local tMinRep = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMinRep"]][2]
										local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(tFaction)
										if earnedValue then
											if earnedValue < tMinRep then
												tIsOk = false
											end
										else
											tIsOk = false
										end
									end
								end
								if SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]] then
									local tFaction = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]][1]
									if tFaction then
										local tMaxRep = SkuDB.questDataTBC[i][SkuDB.questKeys["requiredMaxRep"]][2]
										local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(tFaction)
										if earnedValue then
											if earnedValue > tMaxRep then
												tIsOk = false
											end
										else
											tIsOk = false
										end
									end
								end
									
								if SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]] then
									for x = 1, #SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]] do
										local tExQuestId = SkuDB.questDataTBC[i][SkuDB.questKeys["exclusiveTo"]][x]
										if C_QuestLog.IsQuestFlaggedCompleted(tExQuestId) == true then
											tIsOk = false
										end
										if tCurrentQuestLogQuestsTable[tExQuestId] then
											tIsOk = false
										end
									end
								end

								if tIsOk == true then
									local tIsEventOk = true
									if SkuQuest:IsEventQuest(i) == true then
										local tEventName = SkuQuest:GetEventNameFor(i)
										if SkuQuest:IsEventActive(tEventName) ~= true then
											tIsEventOk = false
										end
									end

									if tIsEventOk == true then
										--['requiredSkill'] = 18, -- table: {skill(int), value(int)}
										--['requiredSourceItems'] = 21, -- table: {item(int), ...} Items that are not an objective but still needed for the quest.


										tShowQuestsTable[i] = {textFull = SkuQuest:GetQuestDataStringFromDB(i, tZoneId)}
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local tcount = 0
	local tUnSortedTable = {}
	local tIdTable = {}
	local tPlayerTopAreaId = SkuNav:GetAreaIdFromUiMapId(tUiMap)
	for i, v in pairs(tShowQuestsTable) do
		local tDistanceToQuestGiver = 0
		if SkuDB.questDataTBC[i] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then
			local tQuestGiverID = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]
			if SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]] then
				if SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap] then
					local tSpawnX, tSpawnY = SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap][1][1], SkuDB.NpcData.Data[tQuestGiverID][SkuDB.NpcData.Keys["spawns"]][tUiMap][1][2]
					local tContintentId = select(3, SkuNav:GetAreaData(is))
					local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetUiMapIdFromAreaId(tUiMap), CreateVector2D(tonumber(tSpawnX) / 100, tonumber(tSpawnY) / 100))
					local tX, tY = worldPosition:GetXY()
					local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tX, tY)
					tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = {tDistance, tX, tY, i}
					tIdTable[tDistance..L[";Meter"].."#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
				end
			end
		elseif SkuDB.questDataTBC[i] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then
			local tObjectID = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]
			local tObjectData = SkuDB.objectDataTBC[tObjectID]
			local tObjectSpawns = tObjectData[SkuDB.objectKeys["spawns"]]
			if tObjectSpawns then
				if tObjectSpawns[tUiMap] then
					local tSpawnX, tSpawnY = tObjectSpawns[tUiMap][1][1], tObjectSpawns[tUiMap][1][2]
					local tContintentId = select(3, SkuNav:GetAreaData(is))
					local _, worldPosition = C_Map.GetWorldPosFromMapPos(SkuNav:GetUiMapIdFromAreaId(tUiMap), CreateVector2D(tonumber(tSpawnX) / 100, tonumber(tSpawnY) / 100))
					local tX, tY = worldPosition:GetXY()
					local tDistance, _  = SkuNav:Distance(tPlayX, tPlayY, tX, tY)
					tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = {tDistance, tX, tY, i}
					tIdTable[tDistance..L[";Meter"].."#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
				end
			end
		else
			--tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = 99999
			tIdTable["99999;"..L["Meter"].."#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
		end

		if not tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] then
			--tUnSortedTable[SkuDB.questLookup[Sku.Loc][i][1]] = 99999
			tIdTable["99999;"..L["Meter"].."#"..SkuDB.questLookup[Sku.Loc][i][1]] = i
		end
	end

	return tUnSortedTable, tIdTable, tCurrentQuestLogQuestsTable
end


---------------------------------------------------------------------------------------------------------------------------------------
local tDifficultyColors = {
	QuestDifficulty_Trivial = L["trivial"],
	QuestDifficulty_Standard = L["easy"],
	QuestDifficulty_Difficult = L["medium"],
	QuestDifficulty_VeryDifficult = L["optimal"],
	QuestDifficulty_Impossible = L["Red"],
}

function SkuQuest:MenuBuilder(aParentEntry)
	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Aktuelle Quests"]}, SkuGenericMenuItem)
	--Alle
	--Zonen
	--Entfernung Questgeber
	--Level
	tNewMenuParentEntry.dynamic = true
	--tNewMenuParentEntry.isSelect = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)

	end
	tNewMenuParentEntry.BuildChildren = function(self)
		if QuestLogFrame:IsVisible() ~= true then
			ToggleQuestLog()
		end
		if (QuestLogFrame:IsVisible()) then
			ExpandQuestHeader(0)
		end

		local numEntries, numQuests = GetNumQuestLogEntries()
		--numEntries = 0	
		if (numEntries == 0) then
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
		else
			local tQuestsByHeader = {}
			local tHeader = ""
			for questLogID = 1, numEntries do
				local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogID)
				local tAddTitle = ""
				local tDifficultyTitle = ""
				if SkuOptions.db.profile["SkuQuest"].showDifficultyColors == true then
					local tDiff = GetQuestDifficultyColor(level)
					if tDiff and tDiff.font and tDifficultyColors[tDiff.font] then
						tDifficultyTitle = " ("..tDifficultyColors[tDiff.font]..")"
					else
						tDifficultyTitle = " ("..L["nodifficulty"]..")"
					end
				end

				if isComplete == 1 then
					tAddTitle = L["(Fertig) "]
				elseif isComplete == -1 then
					tAddTitle = L["(Fehlgeschlagen) "]
				end
				if suggestedGroup then
					tAddTitle = tAddTitle.."("..suggestedGroup..") "
				end
				if frequency == 2 then
					tAddTitle = tAddTitle..L["(Daily) "]
				end
				if isHeader == false then
					tQuestsByHeader[tHeader][tAddTitle..title..tDifficultyTitle] = questLogID
				else
					tQuestsByHeader[title] = {}
					tHeader = title
				end
			end
			--all
			local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Alle"]}, SkuGenericMenuItem)
			tNewMenuEntry.filterable = true
			for ih, vh in pairs(tQuestsByHeader) do
				for iq, vq in pairs(vh) do
					local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntry, {iq}, SkuGenericMenuItem)
					tNewMenuEntry1.questLogId = vq
					tNewMenuEntry1.dynamic = true
					tNewMenuEntry1.OnAction = function(self, aValue, aName)
					end
					tNewMenuEntry1.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = SkuQuest:GetTTSText(self.questLogId)
					end
					local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(vq)
					tNewMenuEntry1.BuildChildren = function(self)
						CreateQuestSubmenu(self, questID)
					end
				end
			end
			--by zone
			for ih, vh in pairs(tQuestsByHeader) do
				local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {ih}, SkuGenericMenuItem)
				tNewMenuEntry.filterable = true
				for iq, vq in pairs(vh) do
					local tNewMenuEntry1 = SkuOptions:InjectMenuItems(tNewMenuEntry, {iq}, SkuGenericMenuItem)
					tNewMenuEntry1.questLogId = vq
					tNewMenuEntry1.dynamic = true
					tNewMenuEntry1.OnAction = function(self, aValue, aName)
					end
					tNewMenuEntry1.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = SkuQuest:GetTTSText(self.questLogId)
					end
					local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(vq)
					tNewMenuEntry1.BuildChildren = function(self)
						CreateQuestSubmenu(self, questID)
					end
				end
			end
		end
	end

	local tNewMenuParentEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Questdatenbank"]}, SkuGenericMenuItem)
	tNewMenuParentEntry.dynamic = true
	tNewMenuParentEntry.OnAction = function(self, aValue, aName)
	end
	tNewMenuParentEntry.BuildChildren = function(self)	
		local tNewMenuSubEntry =SkuOptions:InjectMenuItems(self, {L["Start in Zone"]}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		tNewMenuSubEntry.OnAction = function(self, aValue, aName)
		end
		tNewMenuSubEntry.BuildChildren = function(self)
			local tUnSortedTable, tIdTable = SkuQuest:GetUnsortedAvailableQuestsTable()

			local tNewMenuSubEntryDist =SkuOptions:InjectMenuItems(self, {L["By distance"]}, SkuGenericMenuItem)
			tNewMenuSubEntryDist.dynamic = true
			tNewMenuSubEntryDist.filterable = true
			tNewMenuSubEntryDist.OnAction = function(self, aValue, aName)
			end
			tNewMenuSubEntryDist.BuildChildren = function(self)
				local tSortedTable = {}
				for k,v in SkuSpairs(tUnSortedTable, function(t,a,b) return t[b][1] > t[a][1] end) do --nach wert
					tSortedTable[#tSortedTable+1] = v[1]..L[";Meter"].."#"..k
				end
				if #tSortedTable > 0 then
					for iS, vS in ipairs(tSortedTable) do
						local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {vS}, SkuGenericMenuItem)
						tNewSubMenuEntry2.OnEnter = function(self, aValue, aName)
							SkuOptions.currentMenuPosition.textFull = SkuQuest:GetQuestDataStringFromDB(tIdTable[vS])
						end
						CreateQuestSubmenu(tNewSubMenuEntry2, tIdTable[vS])--iS)
						tcount = tcount + 1
					end
				else
					local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
				end
			end

			--[[
			local tNewMenuSubEntryDist =SkuOptions:InjectMenuItems(self, {"Nach Schwierigkeit"}, SkuGenericMenuItem)
			tNewMenuSubEntryDist.dynamic = true
			tNewMenuSubEntryDist.filterable = true
			]]
		end

		local tNewMenuSubEntry =SkuOptions:InjectMenuItems(self, {L["Alle"]}, SkuGenericMenuItem)
		tNewMenuSubEntry.dynamic = true
		tNewMenuSubEntry.filterable = true
		tNewMenuSubEntry.OnAction = function(self, aValue, aName)
			--SkuOptions.db:SetSProfile(aName)
		end
		tNewMenuSubEntry.BuildChildren = function(self)
			local tNameCache = {}
			for i, v in pairs(SkuDB.questLookup[Sku.Loc]) do
				if SkuDB.questDataTBC[i] then
					local tZoneId
					if SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1] then --creatures
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1]
						tZoneId = SkuDB.NpcData.Data[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][1][1]][SkuDB.NpcData.Keys['zoneID']]
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2] then --objects
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2]
						if SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]] then
							tZoneId = SkuDB.objectDataTBC[SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][2][1]][SkuDB.objectKeys["zoneID"]]
						end
					elseif SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]] and SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3] then --items
						--local tIds = SkuDB.questDataTBC[i][SkuDB.questKeys["startedBy"]][3]
					end

					local tUniqueName = v[1]
					if not tNameCache[v[1]] then
						tNameCache[v[1]] = 0
					else
						tNameCache[v[1]] = tNameCache[v[1]] + 1
						tUniqueName = tUniqueName.." "..tNameCache[v[1]]
					end

					local tNewSubMenuEntry2 = SkuOptions:InjectMenuItems(self, {tUniqueName}, SkuGenericMenuItem)
					tNewSubMenuEntry2.OnEnter = function(self, aValue, aName)
						SkuOptions.currentMenuPosition.textFull = SkuQuest:GetQuestDataStringFromDB(i, tZoneId)
					end
					if not CreateQuestSubmenu(tNewSubMenuEntry2, i) then
						--self.dynamic = false
					end
				end
			end
		end
	end


	local tNewMenuEntry =  SkuOptions:InjectMenuItems(aParentEntry, {L["Options"]}, SkuGenericMenuItem)
	tNewMenuEntry.filterable = true
	SkuOptions:IterateOptionsArgs(SkuQuest.options.args, tNewMenuEntry, SkuOptions.db.profile[MODULE_NAME])
end


----------------------------------------------------------------------------------------------------------------------------------------
-- event utilities
----------------------------------------------------------------------------------------------------------------------------------------
function SkuQuest:LoadEventHandler()
	if QuestieLoader then
		SkuQuest.Event = QuestieLoader:ImportModule("QuestieEvent") 

		SkuQuest.Event.eventQuests = {}

		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8684}) -- Dreamseer the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8635}) -- Splitrock the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8883}) -- Valadar Starsong
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8713}) -- Starsong the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8867}) -- Lunar Fireworks
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8865}) -- Festive Lunar Pant Suits
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8868}) -- Elune's Blessing
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8642}) -- Silvervein the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8866}) -- Bronzebeard the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8643}) -- Highpeak the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8678}) -- Proudhorn the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8864}) -- Festive Lunar Dresses
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8670}) -- Runetotem the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8725}) -- Riversong the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8683}) -- Dawnstrider the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8879}) -- Large Rockets
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8716}) -- Starglade the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8650}) -- Snowcrown the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8876}) -- Small Rockets
		-- tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8874}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8880}) -- Cluster Rockets
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8722}) -- Meadowrun the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8652}) -- Graveborn the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8878}) -- Festive Recipes
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8873}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8720}) -- Skygleam the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8673}) -- Bloodhoof the Elder
		-- tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8875}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8862}) -- Elune's Candle
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8723}) -- Nightwind the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8681}) -- Thunderhorn the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8676}) -- Wildmane the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8651}) -- Ironband the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8863}) -- Festival Dumplings
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8672}) -- Stonespire the Elder
		-- tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8870}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8871}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8649}) -- Stormbrow the Elder
		-- tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8872}) -- The Lunar Festival
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8726}) -- Brightspear the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8877}) -- Firework Launcher
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8718}) -- Bladeswift the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8685}) -- Mistwalker the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8653}) -- Goldwell the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8671}) -- Ragetotem the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8677}) -- Darkhorn the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8882}) -- Cluster Launcher
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8714}) -- Moonstrike the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8645}) -- Obsidian the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8717}) -- Moonwarden the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8648}) -- Darkcore the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8715}) -- Bladeleaf the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8646}) -- Hammershout the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8724}) -- Morningdew the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8727}) -- Farwhisper the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8679}) -- Grimtotem the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8647}) -- Bellowrage the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8674}) -- Winterhoof the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8680}) -- Windtotem the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8686}) -- High Mountain the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8654}) -- Primestone the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8721}) -- Starweave the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8881}) -- Large Cluster Rockets
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8619}) -- Morndeep the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8688}) -- Windrun the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8682}) -- Skyseer the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8636}) -- Rumblerock the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8644}) -- Stonefort the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8675}) -- Skychaser the Elder
		tinsert(SkuQuest.Event.eventQuests, {"Lunar Festival", 8719}) -- Bladesing the Elder

		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8897}) -- Dearest Colara
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8898}) -- Dearest Colara
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8899}) -- Dearest Colara
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8900}) -- Dearest Elenia
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8901}) -- Dearest Elenia
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8902}) -- Dearest Elenia
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8903}) -- Dangerous Love
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8904}) -- Dangerous Love
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8979}) -- Fenstad's Hunch
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8980}) -- Zinge's Assessment
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8981}) -- Gift Giving
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8982}) -- Tracing the Source
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8983}) -- Tracing the Source
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8984}) -- The Source Revealed
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 8993}) -- Gift Giving
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9024}) -- Aristan's Hunch
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9025}) -- Morgan's Discovery
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9026}) -- Tracing the Source
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9027}) -- Tracing the Source
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9028}) -- The Source Revealed
		tinsert(SkuQuest.Event.eventQuests, {"Love is in the Air", 9029}) -- A Bubbling Cauldron

		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 171}) -- A Warden of the Alliance
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 5502}) -- A Warden of the Horde
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 172}) -- Children's Week
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 1468}) -- Children's Week
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 915}) -- You Scream, I Scream...
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 4822}) -- You Scream, I Scream...
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 1687}) -- Spooky Lighthouse
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 558}) -- Jaina's Autograph
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 925}) -- Cairne's Hoofprint
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 1800}) -- Lordaeron Throne Room
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 1479}) -- The Bough of the Eternals
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 1558}) -- The Stonewrought Dam
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 910}) -- Down at the Docks
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 911}) -- Gateway to the Frontier

		tinsert(SkuQuest.Event.eventQuests, {"Harvest Festival", 8149}) -- Honoring a Hero
		tinsert(SkuQuest.Event.eventQuests, {"Harvest Festival", 8150}) -- Honoring a Hero

		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8373}) -- The Power of Pine
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 1658}) -- Crashing the Wickerman Festival
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8311}) -- Hallow's End Treats for Jesper!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8312}) -- Hallow's End Treats for Spoops!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8322}) -- Rotten Eggs
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 1657}) -- Stinking Up Southshore
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8409}) -- Ruined Kegs
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8357}) -- Dancing for Marzipan
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8355}) -- Incoming Gumdrop
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8356}) -- Flexing for Nougat
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8358}) -- Incoming Gumdrop
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8353}) -- Chicken Clucking for a Mint
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8359}) -- Flexing for Nougat
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8354}) -- Chicken Clucking for a Mint
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 8360}) -- Dancing for Marzipan

		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6961}) -- Great-father Winter is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7021}) -- Great-father Winter is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7022}) -- Greatfather Winter is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7023}) -- Greatfather Winter is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7024}) -- Great-father Winter is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6962}) -- Treats for Great-father Winter
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7025}) -- Treats for Greatfather Winter
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7043}) -- You're a Mean One...
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6983}) -- You're a Mean One...
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6984}) -- A Smokywood Pastures' Thank You!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7045}) -- A Smokywood Pastures' Thank You!
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7063}) -- The Feast of Winter Veil
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7061}) -- The Feast of Winter Veil
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6963}) -- Stolen Winter Veil Treats
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7042}) -- Stolen Winter Veil Treats
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 7062}) -- The Reason for the Season
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8763}) -- The Hero of the Day
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8799}) -- The Hero of the Day
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 6964}) -- The Reason for the Season
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8762}) -- Metzen the Reindeer
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8746}) -- Metzen the Reindeer
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8744, "25/12", "2/1"}) -- A Carefully Wrapped Present
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8767, "25/12", "2/1"}) -- A Gently Shaken Gift
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8768, "25/12", "2/1"}) -- A Gaily Wrapped Present
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8769, "25/12", "2/1"}) -- A Ticking Present
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8788, "25/12", "2/1"}) -- A Gently Shaken Gift
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8803, "25/12", "2/1"}) -- A Festive Gift
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8827, "25/12", "2/1"}) -- Winter's Presents
		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 8828, "25/12", "2/1"}) -- Winter's Presents

		-- tinsert(SkuQuest.Event.eventQuests, {"-1006", 8861}) --New Year Celebrations!
		-- tinsert(SkuQuest.Event.eventQuests, {"-1006", 8860}) --New Year Celebrations!

		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7902}) -- Vibrant Plumes
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7903}) -- Evil Bat Eyes
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 8222}) -- Glowing Scorpid Blood
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7901}) -- Soft Bushy Tails
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7899}) -- Small Furry Paws
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7940}) -- 1200 Tickets - Orb of the Darkmoon
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7900}) -- Torn Bear Pelts
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7907}) -- Darkmoon Beast Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7927}) -- Darkmoon Portals Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7929}) -- Darkmoon Elementals Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7928}) -- Darkmoon Warlords Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7946}) -- Spawn of Jubjub
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 8223}) -- More Glowing Scorpid Blood
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7934}) -- 50 Tickets - Darkmoon Storage Box
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7981}) -- 1200 Tickets - Amulet of the Darkmoon
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7943}) -- More Bat Eyes
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7894}) -- Copper Modulator
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7933}) -- 40 Tickets - Greater Darkmoon Prize
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7898}) -- Thorium Widget
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7885}) -- Armor Kits
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7942}) -- More Thorium Widgets
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7883}) -- The World's Largest Gnome!
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7892}) -- Big Black Mace
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7937}) -- Your Fortune Awaits You...
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7939}) -- More Dense Grinding Stones
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7893}) -- Rituals of Strength
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7891}) -- Green Iron Bracers
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7896}) -- Green Fireworks
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7884}) -- Crocolisk Boy and the Bearded Murloc
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7882}) -- Carnival Jerkins
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7897}) -- Mechanical Repair Kits
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7895}) -- Whirring Bronze Gizmo
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7941}) -- More Armor Kits
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7881}) -- Carnival Boots
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7890}) -- Heavy Grinding Stone
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7889}) -- Coarse Weightstone
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7945}) -- Your Fortune Awaits You...
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7935}) -- 10 Tickets - Last Month's Mutton
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7938}) -- Your Fortune Awaits You...
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7944}) -- Your Fortune Awaits You...
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7932}) -- 12 Tickets - Lesser Darkmoon Prize
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7930}) -- 5 Tickets - Darkmoon Flower
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7931}) -- 5 Tickets - Minor Darkmoon Prize
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 7936}) -- 50 Tickets - Last Year's Mutton

		-- New TBC event quests

		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 10942}) -- Children's Week
		tinsert(SkuQuest.Event.eventQuests, {"Children's Week", 10943}) -- Children's Week

		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 9249}) -- 40 Tickets - Schematic: Steam Tonk Controller
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 10938}) -- Darkmoon Blessings Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 10939}) -- Darkmoon Storms Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 10940}) -- Darkmoon Furies Deck
		tinsert(SkuQuest.Event.eventQuests, {"Darkmoon Faire", 10941}) -- Darkmoon Lunacy Deck

		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11450}) -- Fire Training
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11356}) -- Costumed Orphan Matron
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11357}) -- Masked Orphan Matron
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11131}) -- Stop the Fires!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11135}) -- The Headless Horseman
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11220}) -- The Headless Horseman
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11219}) -- Stop the Fires!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11361}) -- Fire Training
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11360}) -- Fire Brigade Practice
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11449}) -- Fire Training
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11440}) -- Fire Brigade Practice
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11439}) -- Fire Brigade Practice
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12133}) -- Smash the Pumpkin
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12135}) -- Let the Fires Come!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12139}) -- Let the Fires Come!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12155}) -- Smash the Pumpkin
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12286}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12331}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12332}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12333}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12334}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12335}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12336}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12337}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12338}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12339}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12340}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12341}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12342}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12343}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12344}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12345}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12346}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12347}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12348}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12349}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12350}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12351}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12352}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12353}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12354}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12355}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12356}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12357}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12358}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12359}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12360}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12361}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12362}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12363}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12364}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12365}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12366}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12367}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12368}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12369}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12370}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12371}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12373}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12374}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12375}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12376}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12377}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12378}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12379}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12380}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12381}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12382}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12383}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12384}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12385}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12386}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12387}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12388}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12389}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12390}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12391}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12392}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12393}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12394}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12395}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12396}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12397}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12398}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12399}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12400}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12401}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12402}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12403}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12404}) -- Candy Bucket
		--tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12405}) -- Candy Bucket -- doesn't exist
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12406}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12407}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12408}) -- Candy Bucket
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12409}) -- Candy Bucket
		--tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 12410}) -- Candy Bucket -- doesn't exist
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11392}) -- Call the Headless Horseman
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11401}) -- Call the Headless Horseman
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11403}) -- Free at Last!
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11404}) -- Call the Headless Horseman
		tinsert(SkuQuest.Event.eventQuests, {"Hallow's End", 11405}) -- Call the Headless Horseman

		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11127}) -- <NYI>Thunderbrew Secrets
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12022}) -- Chug and Chuck!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11117}) -- Catch the Wild Wolpertinger!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11318}) -- Now This is Ram Racing... Almost.
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11409}) -- Now This is Ram Racing... Almost.
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11438}) -- [PH] Beer Garden B
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12020}) -- This One Time, When I Was Drunk...
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12192}) -- This One Time, When I Was Drunk...
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11437}) -- [PH] Beer Garden A
		--tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11454}) -- Seek the Saboteurs
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12420}) -- Brew of the Month Club
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12421}) -- Brew of the Month Club
		--tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12306}) -- Brew of the Month Club
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11120}) -- Pink Elekks On Parade
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11400}) -- Brewfest Riding Rams
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11442}) -- Welcome to Brewfest!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11447}) -- Welcome to Brewfest!
		--tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12278}) -- Brew of the Month Club
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11118}) -- Pink Elekks On Parade
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11320}) -- [NYI] Now this is Ram Racing... Almost.
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11441}) -- Brewfest!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11446}) -- Brewfest!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12062}) -- Insult Coren Direbrew
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12194}) -- Say, There Wouldn't Happen to be a Souvenir This Year, Would There?
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12191}) -- Chug and Chuck!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11293}) -- Bark for the Barleybrews!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11294}) -- Bark for the Thunderbrews!
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11407})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11412})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12022})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12491})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12492})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11118})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11122})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11293})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11408})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12191})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11294})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12192})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 11120})
		tinsert(SkuQuest.Event.eventQuests, {"Brewfest", 12020})	


		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9324}) -- Stealing Orgrimmar's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9325}) -- Stealing Thunder Bluff's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9326}) -- Stealing the Undercity's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9330}) -- Stealing Stormwind's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9331}) -- Stealing Ironforge's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9332}) -- Stealing Darnassus's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9339}) -- A Thief's Reward
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9365}) -- A Thief's Reward

		-- Removed in TBC
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9388}) -- Flickering Flames in Kalimdor
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9389}) -- Flickering Flames in the Eastern Kingdoms
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9319}) -- A Light in Dark Places
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9386}) -- A Light in Dark Places
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9367}) -- The Festival of Fire
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9368}) -- The Festival of Fire
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9322}) -- Wild Fires in Kalimdor
		--tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 9323}) -- Wild Fires in the Eastern Kingdoms

		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11580}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11581}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11583}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11584}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11691}) -- Summon Ahune
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11696}) -- Ahune is Here!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11731}) -- Torch Tossing
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11732}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11734}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11735}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11736}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11737}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11738}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11739}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11740}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11741}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11742}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11743}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11744}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11745}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11746}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11747}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11748}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11749}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11750}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11751}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11752}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11753}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11754}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11755}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11756}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11757}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11758}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11759}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11760}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11761}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11762}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11763}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11764}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11765}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11766}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11767}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11768}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11769}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11770}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11771}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11772}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11773}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11774}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11775}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11776}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11777}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11778}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11779}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11780}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11781}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11782}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11783}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11784}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11785}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11786}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11787}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11799}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11800}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11801}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11802}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11803}) -- Desecrate this Fire!
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11804}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11805}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11806}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11807}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11808}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11809}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11810}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11811}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11812}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11813}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11814}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11815}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11816}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11817}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11818}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11819}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11820}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11821}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11822}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11823}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11824}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11825}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11826}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11827}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11828}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11829}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11830}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11831}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11832}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11833}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11834}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11835}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11836}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11837}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11838}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11839}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11840}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11841}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11842}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11843}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11844}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11845}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11846}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11847}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11848}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11849}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11850}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11851}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11852}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11853}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11854}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11855}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11856}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11857}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11858}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11859}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11860}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11861}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11862}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11863}) -- Honor the Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11882}) -- Playing with Fire
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11886}) -- Unusual Activity
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11915}) -- Playing with Fire
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11921}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11922}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11923}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11924}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11925}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11926}) -- Midsummer
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11933}) -- Stealing the Exodar's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11935}) -- Stealing Silvermoon's Flame
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11954}) -- Striking Back (level 67)
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11955}) -- Ahune, the Frost Lord
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11972}) -- Shards of Ahune
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11964}) -- Incense for the Summer Scorchlings
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11966}) -- Incense for the Festival Scorchlings
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11970}) -- The Master of Summer Lore
		tinsert(SkuQuest.Event.eventQuests, {"Midsummer", 11971}) -- The Spinner of Summer Tales

		tinsert(SkuQuest.Event.eventQuests, {"Winter Veil", 11528}) -- A Winter Veil Gift

		SkuQuest.Event:Load() 

	else
		SkuQuest.Event = {
			GetEventNameFor = function()
				return nil
			end,
			IsEventQuest = function()
				return false
			end,
		}
	end

	SkuQuest.IsEventQuest = SkuQuest.Event.IsEventQuest
	SkuQuest.GetEventNameFor = SkuQuest.Event.GetEventNameFor
end

function SkuQuest:IsEventActive(aEventName)
	if not SkuQuest.Event then
		return
	end
	if not SkuQuest.Event.eventDates[aEventName] then
		return
	end

	local tStartDay, tStartMonth = strsplit("/", SkuQuest.Event.eventDates[aEventName].startDate)
	local tEndDay, tEndMonth = strsplit("/", SkuQuest.Event.eventDates[aEventName].endDate)
	dprint("  ", tStartDay, tStartMonth, "-", tEndDay, tEndMonth)
	local tResult = SkuQuest:WithinDates(tonumber(tStartDay), tonumber(tStartMonth),tonumber(tEndDay), tonumber(tEndMonth))
	return tResult
end

function SkuQuest:WithinDates(startDay, startMonth, endDay, endMonth)
	if (not startDay) and (not startMonth) and (not endDay) and (not endMonth) then
		 return true
	end
	local date = (C_DateAndTime.GetTodaysDate or C_DateAndTime.GetCurrentCalendarTime)()
	local day = date.day or date.monthDay
	local month = date.month
	if (month < startMonth) or -- Too early in the year
		 (month > endMonth) or -- Too late in the year
		 (month == startMonth and day < startDay) or -- Too early in the correct month
		 (month == endMonth and day > endDay) then -- Too late in the correct month
		 return false
	else
		 return true
	end
end

function SkuQuest:IsEventQuest()
	return false
end

function SkuQuest:GetEventNameFor()
	return nil
end

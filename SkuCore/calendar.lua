local MODULE_NAME, MODULE_PART = "SkuCore", "Calendar"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local tMultiShownSettingValues = {
   [1] = L["Start only"],
   [2] = L["Start and end"],
   [3] = L["All"],
}

SkuCore.Calendar = {}
SkuCore.Calendar.data = {}
SkuCore.Calendar.notified = {}
SkuCore.Calendar.MaxDays = 36
SkuCore.Calendar.CALENDAR_FILTER_CVARS = {
	{text = CALENDAR_FILTER_BATTLEGROUND, cvar = "calendarShowBattlegrounds"},
	{text = CALENDAR_FILTER_DARKMOON, cvar = "calendarShowDarkmoon"},
	{text = CALENDAR_FILTER_RAID_LOCKOUTS, cvar = "calendarShowLockouts"},
	{text = CALENDAR_FILTER_RAID_RESETS, cvar = "calendarShowResets"},
	{text = CALENDAR_FILTER_WEEKLY_HOLIDAYS, cvar = "calendarShowWeeklyHolidays"},
	--{text = L["CALENDAR_FILTER_ALL_HOLIDAYS"], cvar = "skuCalendarHideAllHolidays"},
}

Enum.CalendarStatusStrings = {
   [0] = L["Invited"],
   [1] = L["Available"],
   [2] = L["Declined"],
   [3] = L["Confirmed"],
   [4] = L["Out"],
   [5] = L["Standby"],
   [6] = L["Signed up"],
   [7] = L["Not Signed up"],
   [8] = L["Tentative"],
}

Enum.CalendarSequenceTypesStrings = {
   ["START"] = L["Start"],
   ["ONGOING"] = "",
   ["END"] = L["End"],
}

Enum.CalendarModStatusStrings = {
   ["CREATOR"] = L["Creator"],
   ["MODERATOR"] = L["Moderator"],
}

Enum.CalendarTypeStrings = {
   ["PLAYER"] = L["Player event"],
   ["GUILD_EVENT"] = L["Guild event"],
   ["GUILD_ANNOUNCEMENT"] = L["Guild announcement"],
   ["HOLIDAY"] = L["Holiday event"],
   ["RAID_LOCKOUT"] = L["Raid lockout"],
   ["RAID_RESET"] = L["Raid reset"],
}

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_CanInviteeRSVP(inviteStatus)
	return
		inviteStatus == Enum.CalendarStatus.Invited or
		inviteStatus == Enum.CalendarStatus.Available or
		inviteStatus == Enum.CalendarStatus.Declined or
		inviteStatus == Enum.CalendarStatus.Signedup or
		inviteStatus == Enum.CalendarStatus.NotSignedup or
		inviteStatus == Enum.CalendarStatus.Tentative
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_IsSignUpEvent(calendarType, inviteType)
	return (calendarType == "GUILD_EVENT" or calendarType == "COMMUNITY_EVENT") and inviteType == Enum.CalendarInviteType.Signup
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_CanRemoveEvent(modStatus, calendarType, inviteType, inviteStatus)
	return modStatus ~= "CREATOR" and (calendarType == "PLAYER" or ((calendarType == "GUILD_EVENT" or calendarType == "COMMUNITY_EVENT") and inviteType == Enum.CalendarInviteType.Normal))
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_GetFullDate(weekday, month, day, year)
	local weekdayName = CALENDAR_WEEKDAY_NAMES[weekday]
	local monthName = CALENDAR_FULLDATE_MONTH_NAMES[month]
	return weekdayName, monthName, day, year, month
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_GetFullDateFromDateInfo(dateInfo)
	return _CalendarFrame_GetFullDate(dateInfo.weekday, dateInfo.month, dateInfo.monthDay, dateInfo.year)
end

---------------------------------------------------------------------------------------------------------------------------------------
local CalendarEventDungeonCache = {}
local function _CalendarFrame_CacheEventDungeons_Internal(eventType, textures)
	wipe(CalendarEventDungeonCache)

	local numTextures = #textures
	if ( numTextures <= 0 ) then
		return false
	end

	local cacheIndex = 1
	for textureIndex = 1, numTextures do
		if ( not CalendarEventDungeonCache[cacheIndex] ) then
			CalendarEventDungeonCache[cacheIndex] = {}
		end

		local textureInfo = textures[textureIndex]

		local title = textureInfo.title
		local texture = textureInfo.iconTexture
		local expansionLevel = textureInfo.expansionLevel
		local difficultyID = textureInfo.difficultyId
		local mapID = textureInfo.mapId
		local isLFR = textureInfo.isLfr
		local difficultyName, instanceType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID = GetDifficultyInfo(difficultyID)
		
		if not difficultyName then
			difficultyName = ""
		end

		CalendarEventDungeonCache[cacheIndex].textureIndex = textureIndex
		CalendarEventDungeonCache[cacheIndex].title = title
		CalendarEventDungeonCache[cacheIndex].texture = texture
		CalendarEventDungeonCache[cacheIndex].expansionLevel = expansionLevel
		CalendarEventDungeonCache[cacheIndex].difficultyName = difficultyName
		CalendarEventDungeonCache[cacheIndex].isLFR = isLFR
		CalendarEventDungeonCache[cacheIndex].displayHeroic = displayHeroic
		CalendarEventDungeonCache[cacheIndex].displayMythic = displayMythic

		cacheIndex = cacheIndex + 1
	end

	local cacheIndex = 1
	while cacheIndex < #CalendarEventDungeonCache do
		-- insert headers between expansion levels
		local entry = CalendarEventDungeonCache[cacheIndex]
		local prevEntry = CalendarEventDungeonCache[cacheIndex - 1]

		if ( entry.expansionLevel and (not prevEntry or (prevEntry.expansionLevel and prevEntry.expansionLevel ~= entry.expansionLevel)) ) then
			-- insert empty entry...
			if ( prevEntry ) then
				--...only if we had a previous entry
				table.insert(CalendarEventDungeonCache, cacheIndex, {})
				cacheIndex = cacheIndex + 1
			end
			-- insert header
			table.insert(CalendarEventDungeonCache, cacheIndex, {
				title = _G["EXPANSION_NAME"..entry.expansionLevel],
				expansionLevel = entry.expansionLevel,
			})
			cacheIndex = cacheIndex + 1
		end

		cacheIndex = cacheIndex + 1
	end

	return true
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_CacheEventDungeons(eventType)
	if ( eventType ~= CalendarEventDungeonCacheType ) then
		CalendarEventDungeonCacheType = eventType
		if ( eventType ) then
			return  _CalendarFrame_CacheEventDungeons_Internal(eventType, C_Calendar.EventGetTextures(eventType))
		end
	end
	return true
end

---------------------------------------------------------------------------------------------------------------------------------------
local function _CalendarFrame_GetEventDungeonCacheEntry(index, eventType)
	if ( not _CalendarFrame_CacheEventDungeons(eventType) ) then
		return nil
	end
	for cacheIndex = 1, #CalendarEventDungeonCache do
		local entry = CalendarEventDungeonCache[cacheIndex]
		if ( entry.difficulties ) then
			for i, difficultyInfo in ipairs(entry.difficulties) do
				if difficultyInfo.textureIndex == index then
					return entry, difficultyInfo
				end
			end
		end
		if ( entry.textureIndex and index == entry.textureIndex ) then
			return entry
		end
	end
	return nil
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetDateStringFromEventDateData(aDateData)
   local weekdayName, monthName, day, year, month = _CalendarFrame_GetFullDateFromDateInfo(aDateData)
   return weekdayName.." "..day..". "..CALENDAR_FULLDATE_MONTH_NAMES[month].." "..GameTime_GetFormattedTime(aDateData.hour, aDateData.minute).." "..L["Uhr"]
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetDateStringFromCurrentMonth(aMonthFromNow, aDay)
   local tCurrentDate = C_DateAndTime.GetCurrentCalendarTime()
   local tThisMonthInfo = C_Calendar.GetMonthInfo(aMonthFromNow)
   local tWkd = (tThisMonthInfo.firstWeekday + aDay - (math.floor(aDay / 7) * 7)) - 1
   if tWkd > 7 then
      tWkd = tWkd - 7
   end
   local tWeekdayName = CALENDAR_WEEKDAY_NAMES[tWkd]
   local tMonthName = CALENDAR_FULLDATE_MONTH_NAMES[tThisMonthInfo.month]

   return tWeekdayName.." "..aDay..". "..tMonthName
end

---------------------------------------------------------------------------------------------------------------------------------------
local function BuildReactionsMenu(aEventID, aParent)
   aParent.dynamic = nil

   local tEvent = SkuCore.Calendar.data[aEventID]
   if not tEvent then
      return
   end

   local tReactionsAvailable = false
   if tEvent.calendarType == "PLAYER" or tEvent.calendarType == "GUILD_EVENT" then
      if tEvent.modStatus ~= "CREATOR" then
         if tEvent.isLocked ~= true then
            tReactionsAvailable = true
         end
      end
   end

   if tReactionsAvailable == true then
      if tEvent.numInvitees == L["Querying data..."] or tEvent.inviteStatus == L["Querying data..."] then
         local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["Is querying..."]}, SkuGenericMenuItem)
         aParent.dynamic = true
         return true
      else
         local tHasEntries = false
         if ( _CalendarFrame_CanInviteeRSVP(tEvent.inviteStatus) ) then
            if ( _CalendarFrame_IsSignUpEvent(tEvent.calendarType, tEvent.inviteType) ) then
               if ( tEvent.inviteStatus == Enum.CalendarStatus.NotSignedup ) then
                  -- sign up
                  local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {CALENDAR_SIGNUP}, SkuGenericMenuItem)
                  tSubNewMenuEntry.isSelect = true
                  tSubNewMenuEntry.OnAction = function(self, aValue, aName)
                     if ( tEvent.inviteType == Enum.CalendarInviteType.Signup ) then
                        SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                        C_Calendar.EventSignUp()
                     else
                        SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                        C_Calendar.EventAvailable()
                     end  
                     C_Timer.After(0.1, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                     end)                     
                  end                  
                  tHasEntries = true
               end
            elseif ( tEvent.modStatus ~= "CREATOR" ) then
               -- accept invitation
               if ( tEvent.inviteStatus ~= Enum.CalendarStatus.Available ) then
                  local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {ACCEPT}, SkuGenericMenuItem)
                  tSubNewMenuEntry.isSelect = true
                  tSubNewMenuEntry.OnAction = function(self, aValue, aName)
                     if ( tEvent.inviteType == Enum.CalendarInviteType.Signup ) then
                        SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                        C_Calendar.EventSignUp()
                     else
                        SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                        C_Calendar.EventAvailable()
                     end  
                     C_Timer.After(0.1, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                     end)
                  end   
                  tHasEntries = true
               end
               -- tentative invitation
               if ( tEvent.inviteStatus ~= Enum.CalendarStatus.Tentative ) then
                  local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {CALENDAR_VIEW_EVENT_TENTATIVE}, SkuGenericMenuItem)
                  tSubNewMenuEntry.isSelect = true
                  tSubNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                     C_Calendar.EventTentative()
                     C_Timer.After(0.1, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                     end)
                  end    
                  tHasEntries = true                 
               end
               -- decline invitation
               if ( tEvent.inviteStatus ~= Enum.CalendarStatus.Declined ) then
                  local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {DECLINE}, SkuGenericMenuItem)
                  tSubNewMenuEntry.isSelect = true
                  tSubNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
                     C_Calendar.EventDecline()
                     C_Timer.After(0.1, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                     end)
                  end     
                  tHasEntries = true                 
               end
            end
         end
         
         --if ( _CalendarFrame_CanRemoveEvent(tEvent.modStatus, tEvent.calendarType, tEvent.inviteType, tEvent.inviteStatus) ) then --
         if tEvent.inviteStatus == Enum.CalendarStatus.Signedup and tEvent.calendarType == "GUILD_EVENT" then
            -- remove event
            local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {CALENDAR_VIEW_EVENT_REMOVE}, SkuGenericMenuItem)
            tSubNewMenuEntry.isSelect = true
            tSubNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuCore:CalendarQueryQueueAddQuery(aEventID, tEvent.month, tEvent.day, tEvent.index, true, function() end)                        
               SkuCore.Calendar.data[aEventID] = nil
               C_Calendar.RemoveEvent()
               C_Timer.After(0.1, function()
                  SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
               end)
            end    
            tHasEntries = true           
         end
         
         if tHasEntries == false then
            local tSubNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["Empty"]}, SkuGenericMenuItem)
         end
         aParent.dynamic = true
         return true
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetEventTypeString(aEventTypeId)
   local tEventTypesData = C_Calendar.EventGetTypesDisplayOrdered()
   for x = 1, #tEventTypesData do
      if tEventTypesData[x].eventType == aEventTypeId then
         return _G[tEventTypesData[x].displayString]
      end
   end
end   

---------------------------------------------------------------------------------------------------------------------------------------
local function BuildEventInviteesTooltip(aEventID)
   local tReturnString = ""
   local tEvent = SkuCore.Calendar.data[aEventID]
   if tEvent.numInvitees and tEvent.numInvitees ~= L["No data"] and tEvent.numInvitees ~= L["Querying data..."] then
      for x = 1, tEvent.numInvitees do
         local tInviteeInfo = tEvent.invitees[x]
         if x > 1 then tReturnString = tReturnString.."\r\n" end
         if tInviteeInfo.name then
            tReturnString = tReturnString..x.." "..(tInviteeInfo.name)..", "..Enum.CalendarStatusStrings[tInviteeInfo.inviteStatus].." ("..(tInviteeInfo.className or L["No class info"]).." "..(tInviteeInfo.level or L["No level info"])..")"
         else
            tReturnString = tReturnString..x.." "..(tInviteeInfo.name or L["Querying data..."])
         end
      end
      return tReturnString
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function BuildEventTooltip(aEventID)
   local tTooltipText = L["Event id: "]..aEventID.."\r\n"
   local event = SkuCore.Calendar.data[aEventID]

   if event then
      local tDateString = GetDateStringFromCurrentMonth(event.month, event.day)
      --tTooltipText = tTooltipText..tDateString.."\r\n"
      tTooltipText = tTooltipText..L["Type: "]..Enum.CalendarTypeStrings[event.calendarType].."\r\n"

      if event.calendarType == "PLAYER" or event.calendarType == "GUILD_EVENT" then
         --
         tTooltipText = tTooltipText..L["Title: "]..event.title.."\r\n"
         --
         tTooltipText = tTooltipText..L["Start: "]..GetDateStringFromEventDateData(event.startTime).."\r\n"
         --
         if event.isLocked == true then
            tTooltipText = tTooltipText..L["Locked"].."\r\n"
         end
         --
         tTooltipText = tTooltipText..L["Invite status: "]..(Enum.CalendarStatusStrings[event.inviteStatus] or L["No data"]).."\r\n"
         --
         tTooltipText = tTooltipText..L["Description: "]..(event.description or L["No data"]).."\r\n"
         --
         local eventTitle = event.isCustomTitle and event.title or _G[event.title]
         local difftitle = GetDungeonNameWithDifficulty(eventTitle, event.difficultyName)
         difftitle = SkuChat:Unescape(difftitle)
         if difftitle ~= event.title then
            tTooltipText = tTooltipText..L["Difficulty: "]..tostring(difftitle).."\r\n"
         end
         --
         if BuildEventInviteesTooltip(aEventID) then
            tTooltipText = tTooltipText..L["Invitees: "]..event.numInvitees.."\r\n"..BuildEventInviteesTooltip(aEventID).."\r\n"
         end
         --
         tTooltipText = tTooltipText..L["Activity: "]..(GetEventTypeString(event.eventType) or L["None"]).."\r\n"
         --
         local targetstring = _CalendarFrame_GetEventDungeonCacheEntry(event.textureIndex, event.eventType)
         if targetstring then
            local tHeroic = ""
            if targetstring.displayHeroic then
               tHeroic = L["Heroic"]
            end
            tTooltipText = tTooltipText..L["Destination: "]..tHeroic.." "..targetstring.title.." "..targetstring.difficultyName.."\r\n" --" "..targetstring.expansionLevel..
         else
            if event.textureIndex == L["Querying data..."] then
               tTooltipText = tTooltipText..L["Destination: "]..L["Querying data..."].."\r\n"
            else
               tTooltipText = tTooltipText..L["Destination: "]..L["No data"].."\r\n"
            end
         end
         --
         tTooltipText = tTooltipText..L["Invited by: "]..tostring(event.invitedBy).."\r\n"
         --
         if Enum.CalendarModStatusStrings[event.modStatus] then
            tTooltipText = tTooltipText..L["Moderator status: "]..Enum.CalendarModStatusStrings[event.modStatus].."\r\n"
         end

         --tTooltipText = tTooltipText.."month: "..tostring(event.month).."\r\n"
         --tTooltipText = tTooltipText.."day: "..tostring(event.day).."\r\n"
         --tTooltipText = tTooltipText.."index: "..tostring(event.index).."\r\n"
         --tTooltipText = tTooltipText.."isCustomTitle: "..tostring(event.isCustomTitle).."\r\n"
         --tTooltipText = tTooltipText.."textureIndex: "..tostring(event.textureIndex).."\r\n"
         --tTooltipText = tTooltipText.."difficultyName: "..tostring(event.difficultyName).."\r\n"
         --tTooltipText = tTooltipText.."dontDisplayEnd: "..tostring(event.dontDisplayEnd).."\r\n"
         --tTooltipText = tTooltipText.."difficulty: "..tostring(event.difficulty).."\r\n"
         --tTooltipText = tTooltipText.."inviteL["Type: "]..tostring(event.inviteType).."\r\n"
         --tTooltipText = tTooltipText.."sequenceIndex: "..tostring(event.sequenceIndex).."\r\n"

      elseif event.calendarType == "GUILD_ANNOUNCEMENT" then
         tTooltipText = tTooltipText..L["Title: "]..event.title.."\r\n"
         tTooltipText = tTooltipText..L["Start: "]..GetDateStringFromEventDateData(event.startTime).."\r\n"

      elseif event.calendarType == "HOLIDAY" then
         tTooltipText = tTooltipText..L["Title: "]..event.title.."\r\n"
         tTooltipText = tTooltipText..L["Start: "]..GetDateStringFromEventDateData(event.startTime).."\r\n"
         tTooltipText = tTooltipText..L["End: "]..GetDateStringFromEventDateData(event.endTime).."\r\n"
         if event.sequenceType ~= "" then
            tTooltipText = tTooltipText..L["Start or end day: "]..(event.sequenceType ~= "" and event.sequenceType or L["None"]).."\r\n"
            tTooltipText = tTooltipText..L["Days duration: "]..event.numSequenceDays..L[" days"].."\r\n"
         end
         
      elseif event.calendarType == "RAID_LOCKOUT" then
         tTooltipText = tTooltipText..L["Title: "]..format(CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT, event.title).."\r\n"
         tTooltipText = tTooltipText..L["Start: "]..GetDateStringFromEventDateData(event.startTime).."\r\n"

      elseif event.calendarType == "RAID_RESET" then
         tTooltipText = tTooltipText..L["Title: "]..format(CALENDAR_EVENTNAME_FORMAT_RAID_RESET, event.title).."\r\n"
         tTooltipText = tTooltipText..L["Start: "]..GetDateStringFromEventDateData(event.startTime).."\r\n"
         
      else
         tTooltipText = tTooltipText..L["Error: unknown event type"]
      end
   else
      tTooltipText = tTooltipText..L["Error: No data"]
   end

   return tTooltipText
end

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.Calendar.queryQueue = {}
SkuCore.Calendar.queryQueuePending = false
function SkuCore:CalendarQueryQueueAddQuery(aEventID, aMonth, aDay, aIndex, aForce, aCallback)
   if not SkuCore.Calendar.data[aEventID] then return end

   if SkuCore.Calendar.queryQueue[aEventID] == nil or aForce == true then 
      if SkuCore.Calendar.data[aEventID].calendarType == "PLAYER" or SkuCore.Calendar.data[aEventID].calendarType == "GUILD_EVENT" then
         SkuCore.Calendar.data[aEventID].numInvitees = L["Querying data..."]
         SkuCore.Calendar.data[aEventID].textureIndex = L["Querying data..."]
         SkuCore.Calendar.data[aEventID].inviteStatus = L["Querying data..."]
         SkuCore.Calendar.data[aEventID].invitees = {}
      end
      
      if SkuCore.Calendar.queryQueue[aEventID] then
         for x = 1, #SkuCore.Calendar.queryQueue do
            if SkuCore.Calendar.queryQueue[x].id == aEventID then
               SkuCore.Calendar.queryQueue[x].callback = aCallback
            end
         end
      else
         table.insert(SkuCore.Calendar.queryQueue, {
            id = aEventID,
            month = aMonth, 
            day = aDay, 
            index = aIndex,
            callback = aCallback,
         })
         SkuCore.Calendar.queryQueue[aEventID] = true
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnQueue()
   if #SkuCore.Calendar.queryQueue == 0 then return end

   if SkuOptions:IsMenuOpen() == true then
      if SkuOptions.currentMenuPosition.name == L["Is querying..."] then
         SkuOptions.Voice:OutputStringBTtts("sound-notification24", false, false)--24
      end
   end

   if SkuCore.Calendar.queryQueuePending == false then
      local success = C_Calendar.OpenEvent(SkuCore.Calendar.queryQueue[1].month, SkuCore.Calendar.queryQueue[1].day, SkuCore.Calendar.queryQueue[1].index)
      if success ~= true then
         SkuCore.Calendar.queryQueue[SkuCore.Calendar.queryQueue[1].id] = nil
         table.remove(SkuCore.Calendar.queryQueue, 1)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_ACTION_PENDING(event, status)
   if status == false and SkuCore.Calendar.queryQueuePending == true then
      local numInvitees = C_Calendar.GetNumInvites()
      SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].numInvitees = numInvitees or L["No data"]
      if numInvitees then
         SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].invitees = {}
         for x = 1, numInvitees do
            local tInviteeInfo = C_Calendar.EventGetInvite(x)
            SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].invitees[x] = tInviteeInfo
         end
      end

      local eventInfo = C_Calendar.GetEventInfo()
      if eventInfo ~= nil then
         SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].textureIndex = eventInfo.textureIndex or L["No data"]
         SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].inviteStatus = eventInfo.inviteStatus or L["No data"]
         SkuCore.Calendar.data[SkuCore.Calendar.queryQueue[1].id].description = eventInfo.description or L["No data"]

         if SkuCore.Calendar.queryQueue[1].callback then
            SkuCore.Calendar.queryQueue[1].callback()
         end
      end
      SkuCore.Calendar.queryQueue[SkuCore.Calendar.queryQueue[1].id] = nil
      table.remove(SkuCore.Calendar.queryQueue, 1)
   end

   SkuCore.Calendar.queryQueuePending = status
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarOnLogin(event, isInitialLogin, isReloadingUi)
   SkuOptions.db.char[MODULE_NAME].calendar = SkuOptions.db.char[MODULE_NAME].calendar or {}
   SkuOptions.db.char[MODULE_NAME].calendar.seen = SkuOptions.db.char[MODULE_NAME].calendar.seen or {}
   SkuOptions.db.char[MODULE_NAME].calendar.filters = SkuOptions.db.char[MODULE_NAME].calendar.filters or {
      --skuCalendarHideAllHolidays = 1,
   }
   for i, v in pairs(SkuCore.Calendar.CALENDAR_FILTER_CVARS) do
      --if "skuCalendarHideAllHolidays" ~= v.cvar then
      SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = tonumber(GetCVar(v.cvar))
      --end
   end
   SkuOptions.db.char[MODULE_NAME].calendar.multiShown = SkuOptions.db.char[MODULE_NAME].calendar.multiShown or 1
   SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents = SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents or false
   SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents = SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents or false

   SkuDispatcher:RegisterEventCallback("GUILD_ROSTER_UPDATE", SkuCore.CalendarQueryQueueOnGUILD_ROSTER_UPDATE)
   SkuDispatcher:RegisterEventCallback("PLAYER_GUILD_UPDATE", SkuCore.CalendarQueryQueueOnPLAYER_GUILD_UPDATE)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_EVENT", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_EVENT)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_INVITE_LIST", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_INVITE_LIST)
   SkuDispatcher:RegisterEventCallback("CALENDAR_NEW_EVENT", SkuCore.CalendarQueryQueueOnCALENDAR_NEW_EVENT)
   SkuDispatcher:RegisterEventCallback("CALENDAR_OPEN_EVENT", SkuCore.CalendarQueryQueueOnCALENDAR_OPEN_EVENT)
   SkuDispatcher:RegisterEventCallback("CALENDAR_CLOSE_EVENT", SkuCore.CalendarQueryQueueOnCALENDAR_CLOSE_EVENT)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_PENDING_INVITES", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_PENDING_INVITES)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_ERROR", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_ERROR)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_ERROR_WITH_COUNT", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_ERROR_WITH_COUNT)
   SkuDispatcher:RegisterEventCallback("CALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME", SkuCore.CalendarQueryQueueOnCALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME)
   SkuDispatcher:RegisterEventCallback("CALENDAR_ACTION_PENDING", SkuCore.CalendarQueryQueueOnCALENDAR_ACTION_PENDING)
   SkuDispatcher:RegisterEventCallback("PLAYER_LOGOUT", SkuCore.CalendarQueryQueueOnPLAYER_LOGOUT)

   C_Timer.After(30, function()
      SkuCore:CalendarUpdateAllCalendarData()
      C_Timer.NewTicker(120, function()
         SkuCore:CalendarUpdateAllCalendarData()
      end)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnGUILD_ROSTER_UPDATE()
   SkuCore:CalendarUpdateAllCalendarData()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnPLAYER_GUILD_UPDATE()
   SkuCore:CalendarUpdateAllCalendarData()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_EVENT()
   --CalendarInviteStatusContextMenu_Initialize
   SkuCore:CalendarUpdateAllCalendarData()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_INVITE_LIST()
   -- C_Calendar.EventCanEdit() ) then CalendarFrame_ShowEventFrame(CalendarViewEventFrame);
   SkuCore:CalendarUpdateAllCalendarData()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_NEW_EVENT()
   --fired when you successfully create a calendar event

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_OPEN_EVENT()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_CLOSE_EVENT()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_PENDING_INVITES()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_ERROR(aEvent, aArg1, aArg2)
   print(L["Sku CALENDAR ERROR"], aEvent, _G[aArg1])
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_ERROR_WITH_COUNT(aEvent, aArg1, aArg2)
   print(L["Sku CALENDAR ERROR"], aEvent, _G[aArg1]:format(aArg2))
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnCALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME(aEvent, aArg1, aArg2)
   print(L["Sku CALENDAR ERROR"], aEvent, _G[aArg1]:format(aArg2))
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarQueryQueueOnPLAYER_LOGOUT()
   for i, _ in pairs(SkuCore.Calendar.data) do
      SkuOptions.db.char[MODULE_NAME].calendar.seen[i] = true
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarUpdateSeen(aEventID)
   SkuOptions.db.char[MODULE_NAME].calendar.seen[aEventID] = true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarNotifyOnEvent(aEventID, aCalendarType)
   if SkuOptions.db.char[MODULE_NAME].calendar.seen[aEventID] == nil and SkuCore.Calendar.notified[aEventID] == nil then
      local event = SkuCore.Calendar.data[aEventID]
      if ((aCalendarType == "PLAYER" or aCalendarType == "GUILD_EVENT" or aCalendarType == "GUILD_ANNOUNCEMENT") and SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents  == true) then
         local tTooltipText = ""--L["Event id: "]..aEventID..", "
         if event then
            tTooltipText = tTooltipText.." "..Enum.CalendarTypeStrings[event.calendarType]..", "
            tTooltipText = tTooltipText..event.title..", "
            tTooltipText = tTooltipText..GetDateStringFromEventDateData(event.startTime)
         end
         SkuCore.Calendar.notified[aEventID] = true
         print(L["New calendar event"]..":"..tTooltipText)
      end

      if (aCalendarType == "HOLIDAY") and SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents  == true then
         local tTooltipText = ""--L["Event id: "]..aEventID..", "
         if event then
            tTooltipText = tTooltipText.." "..event.title..", "
            tTooltipText = tTooltipText..GetDateStringFromEventDateData(event.startTime).." "
            tTooltipText = tTooltipText..L["to "]..GetDateStringFromEventDateData(event.endTime)..", "
            if event.sequenceType ~= "" then
               tTooltipText = tTooltipText..(event.sequenceType ~= "" and event.sequenceType or "")..", "
               tTooltipText = tTooltipText..event.numSequenceDays..L[" days"]..", "
            end
         end
         SkuCore.Calendar.notified[aEventID] = true
         print(L["New calendar event"]..":"..tTooltipText)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarOnInitialize()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarUpdateAllCalendarData()
   if SkuOptions:IsMenuOpen() == true then
      return
   end

   if SkuCore.Calendar.queryQueue[1] then
      return
   end

   local t = SkuCore:CalendarMenuBuilder()
   t:BuildChildren(t)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarMenuBuilder()
   local retVal

   local tNewMenuEntryNewEvents = SkuOptions:InjectMenuItems(self, {L["New events"]}, SkuGenericMenuItem)
   tNewMenuEntryNewEvents.dynamic = true
   tNewMenuEntryNewEvents.filterable = true

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Events"]}, SkuGenericMenuItem)
   retVal = tNewMenuEntry
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   --[[
   local tNumDayEvents = 0
   for x = 0, 2 do
      local tThisMonthInfo = C_Calendar.GetMonthInfo(x)
      tNumDayEvents = tNumDayEvents + C_Calendar.GetNumDayEvents(x, tThisMonthInfo.numDays)
   end
   tNewMenuEntry.textFull = "Number of events in calendar:\r\nPlayer events: "..tNumDayEvents.."\r\nGuild events: "..C_Calendar.GetNumGuildEvents().."\r\n"
   ]]
   tNewMenuEntry.BuildChildren = function(self)
      local tHasShownEvent = false

      C_Calendar.OpenCalendar()
      --C_Calendar.SetMonth(0)
      
      local tDaysLeft = SkuCore.Calendar.MaxDays
      local tCurrentDate = C_DateAndTime.GetCurrentCalendarTime()
      
      for month = 0, 2 do
         if tDaysLeft <= 0 then
            break
         end

         local tThisMonthInfo = C_Calendar.GetMonthInfo(month)
         local tDayStart
         if month == 0 then
            tDayStart = tCurrentDate.monthDay
         else
            tDayStart = 1
         end
         local tDaysLeftThisMonth = tThisMonthInfo.numDays - tDayStart
         if tDaysLeftThisMonth > tDaysLeft then
            tDaysLeftThisMonth = tDaysLeft
         end
         local tDayEnd = tDayStart + tDaysLeftThisMonth
         tDaysLeft = tDaysLeft - tDaysLeftThisMonth

         for day = tDayStart, tDayEnd do
            local numEvents = C_Calendar.GetNumDayEvents(month, day)
            for i = 1, numEvents do
               local event = C_Calendar.GetDayEvent(month, day, i)

               if event.eventID == 0 then
                  event.eventID = "NOEVENTID"..GetDateStringFromCurrentMonth(month, day)..": "..i.." "..event.calendarType.." "..event.sequenceType.." "..tostring(event.numSequenceDays).." "..event.title
               end

               if not SkuCore.Calendar.data[event.eventID] then
                  SkuCore.Calendar.data[event.eventID] = event
               end
               SkuCore.Calendar.data[event.eventID].month = month
               SkuCore.Calendar.data[event.eventID].day = day
               SkuCore.Calendar.data[event.eventID].index = i

               local tShow = true
               --if event.calendarType == "HOLIDAY" and SkuOptions.db.char[MODULE_NAME].calendar.filters.skuCalendarHideAllHolidays == 0 then
                  --tShow = false
               --end
               if event.sequenceType and event.sequenceType ~= "" then
                  if (SkuOptions.db.char[MODULE_NAME].calendar.multiShown == 1 and event.sequenceType ~= "START") or (SkuOptions.db.char[MODULE_NAME].calendar.multiShown == 2 and (event.sequenceType ~= "START" and event.sequenceType ~= "END")) then
                     tShow = false
                  end
               end

               if tShow == true then
                  local function tInjectHelper(aSelf)
                     if self.name ~= L["New events"] 
                        or 
                        (self.name == L["New events"] and (event.calendarType ~= "RAID_LOCKOUT" or event.calendarType ~= "RAID_RESET") and SkuOptions.db.char[MODULE_NAME].calendar.seen[event.eventID] == nil) 
                     then
                        tHasShownEvent = true
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(aSelf, {
                           GetDateStringFromCurrentMonth(month, day)..": "..
                           (Enum.CalendarTypeStrings[event.calendarType] or "").." "..
                           (Enum.CalendarSequenceTypesStrings[event.sequenceType] or "")..";"..
                           --tostring(event.numSequenceDays).." "..
                           event.title
                        }, SkuGenericMenuItem)
                        tNewMenuEntry.dynamic = true
                        tNewMenuEntry.filterable = true
                        tNewMenuEntry.month = month
                        tNewMenuEntry.day = day
                        tNewMenuEntry.eventIndex = i
                        tNewMenuEntry.event = event
                        tNewMenuEntry.BuildChildren = function(self)
                           local tMenuResult = BuildReactionsMenu(self.event.eventID, self)
                        end
                        tNewMenuEntry.OnEnter = function(self, aValue, aName)
                           if self.event.calendarType ~= "RAID_LOCKOUT" and self.event.calendarType ~= "RAID_RESET" then
                              SkuCore:CalendarUpdateSeen(self.event.eventID)
                           end
      
                           if self.event.calendarType == "PLAYER" or self.event.calendarType == "GUILD_EVENT" then
                              SkuCore:CalendarQueryQueueAddQuery(self.event.eventID, self.month, self.day, self.eventIndex, true, function()
                                 if SkuOptions:IsMenuOpen() == true then
                                    self.textFull = BuildEventTooltip(self.event.eventID)
                                    if self == SkuOptions.currentMenuPosition then
                                       local tMenuResult = BuildReactionsMenu(self.event.eventID, self)
                                    elseif self == SkuOptions.currentMenuPosition.parent then
                                       SkuOptions.Voice:OutputStringBTtts("sound-notification16", false, false)--24
                                       SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                                    end
                                 end
                              end)
                           end
                        end
                        tNewMenuEntry.textFull = BuildEventTooltip(event.eventID)                        
                        SkuCore:CalendarNotifyOnEvent(event.eventID, event.calendarType)
      
                        if event.calendarType == "PLAYER" or event.calendarType == "GUILD_EVENT" then
                           SkuCore:CalendarQueryQueueAddQuery(event.eventID, month, day, i, nil, function()
                              if SkuOptions:IsMenuOpen() == true then
                                 tNewMenuEntry.textFull = BuildEventTooltip(event.eventID)                        
                                 if tNewMenuEntry.name == SkuOptions.currentMenuPosition.name then
                                    local tMenuResult = BuildReactionsMenu(self.event.eventID, self)
                                 end
                              end
                           end)
                        end   
                     end
                  end

                  tInjectHelper(self)
               end
            end
         end
      end

      if self.name == L["New events"] and tHasShownEvent == false then
         SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
      end
   end

   tNewMenuEntryNewEvents.BuildChildren = tNewMenuEntry.BuildChildren

   --[[
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New event"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      
   end
   tNewMenuEntry.BuildChildren = function(self)

   end
   ]]

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Options"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)
      --
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Filter"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.BuildChildren = function(self)
         for i, v in pairs(SkuCore.Calendar.CALENDAR_FILTER_CVARS) do
            --if "skuCalendarHideAllHolidays" ~= v.cvar then
            SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = tonumber(GetCVar(v.cvar))
            --end
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v.text}, SkuGenericMenuItem)
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
               if SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] == 1 then
                  return L["Show"]
               else
                  return L["Hide"]
               end
            end
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               if aName == L["Show"] then
                  SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = 1
               else
                  SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = 0
               end   
               --if "skuCalendarHideAllHolidays" ~= v.cvar then
               SetCVar(v.cvar, SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar])
               --end
            end
            tNewMenuEntry.BuildChildren = function(self)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show"]}, SkuGenericMenuItem)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Hide"]}, SkuGenericMenuItem)
            end      
         end
      end   
      
      --
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Shown days for multi day events"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
         return tMultiShownSettingValues[SkuOptions.db.char[MODULE_NAME].calendar.multiShown]
      end
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         for x = 1, #tMultiShownSettingValues do
            if tMultiShownSettingValues[x] == aName then
               SkuOptions.db.char[MODULE_NAME].calendar.multiShown = x
            end
         end
      end
      tNewMenuEntry.BuildChildren = function(self)
         for x = 1, #tMultiShownSettingValues do
            SkuOptions:InjectMenuItems(self, {tMultiShownSettingValues[x]}, SkuGenericMenuItem)
         end
      end

      --
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Notify on new player and guild events"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
         if SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents == true then
            return L["On"]
         else
            return L["Off"]
         end
      end
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         if aName == L["On"] then
            SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents = true
         else
            SkuOptions.db.char[MODULE_NAME].calendar.notifyOnPlayerAndGuildEvents = false
         end   
      end
      tNewMenuEntry.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["On"]}, SkuGenericMenuItem)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Off"]}, SkuGenericMenuItem)
      end

      --
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Notify on new holiday events"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
         if SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents == true then
            return L["On"]
         else
            return L["Off"]
         end
      end
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         if aName == L["On"] then
            SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents = true
         else
            SkuOptions.db.char[MODULE_NAME].calendar.notifyOnHolidayEvents = false
         end   
      end
      tNewMenuEntry.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["On"]}, SkuGenericMenuItem)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Off"]}, SkuGenericMenuItem)
      end      
   end

   return retVal
end

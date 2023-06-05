local MODULE_NAME, MODULE_PART = "SkuCore", "Calendar"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.Calendar = {}
SkuCore.Calendar.CALENDAR_FILTER_CVARS = {
	{text = CALENDAR_FILTER_BATTLEGROUND, cvar = "calendarShowBattlegrounds"},
	{text = CALENDAR_FILTER_DARKMOON, cvar = "calendarShowDarkmoon"},
	{text = CALENDAR_FILTER_RAID_LOCKOUTS, cvar = "calendarShowLockouts"},
	{text = CALENDAR_FILTER_RAID_RESETS, cvar = "calendarShowResets"},
	{text = CALENDAR_FILTER_WEEKLY_HOLIDAYS, cvar = "calendarShowWeeklyHolidays"},
	{text = L["CALENDAR_FILTER_ALL_HOLIDAYS"], cvar = "skuCalendarHideAllHolidays"},
}
SkuCore.Calendar.MaxDays = 36

local tMultiShownSettingValues = {
   [1] = L["Start only"],
   [2] = L["Start and end"],
   [3] = L["All"],
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarOnLogin()
   SkuOptions.db.char[MODULE_NAME].calendar = SkuOptions.db.char[MODULE_NAME].calendar or {}
   SkuOptions.db.char[MODULE_NAME].calendar.filters = SkuOptions.db.char[MODULE_NAME].calendar.filters or {
      skuCalendarHideAllHolidays = 1,
   }
   for i, v in pairs(SkuCore.Calendar.CALENDAR_FILTER_CVARS) do
      if "skuCalendarHideAllHolidays" ~= v.cvar then
         SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = tonumber(GetCVar(v.cvar))
      end
   end
   SkuOptions.db.char[MODULE_NAME].calendar.multiShown = SkuOptions.db.char[MODULE_NAME].calendar.multiShown or 1
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarOnInitialize()
   dprint("CalendarOnInitialize")
   --[[
   SkuDispatcher:RegisterEventCallback("CALENDAR_OPEN_EVENT", function()
      print("CALENDAR_OPEN_EVENT", C_Calendar.GetNumInvites())
   end)
   ]]
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:CalendarMenuBuilder()
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Events"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      C_Calendar.OpenCalendar()
      --C_Calendar.SetMonth(0)
      
      local tDaysLeft = SkuCore.Calendar.MaxDays
      local tCurrentDate = C_DateAndTime.GetCurrentCalendarTime()
      --[[--test date
      local tCurrentDate = {
         monthDay=20,
         day=0,
         month=6,
         minute=51,
         year=2023,
         hour=22,
         weekday=1
       }
      ]]
      
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
            local tWkd = (tThisMonthInfo.firstWeekday + day - (math.floor(day / 7) * 7)) - 1
            if tWkd > 7 then
               tWkd = tWkd - 7
            end
            local tWeekdayName = CALENDAR_WEEKDAY_NAMES[tWkd]
            local tMonthName = CALENDAR_FULLDATE_MONTH_NAMES[tThisMonthInfo.month]
            --print(tWeekdayName, day, tMonthName, tWkd, month, C_Calendar.GetNumDayEvents(month, day))
               
            local numEvents = C_Calendar.GetNumDayEvents(month, day)
            for i = 1, numEvents do
               local event = C_Calendar.GetDayEvent(month, day, i);

               local tShow = true
               if event.calendarType == "HOLIDAY" and SkuOptions.db.char[MODULE_NAME].calendar.filters.skuCalendarHideAllHolidays == 0 then
                  tShow = false
               end
               if event.sequenceType and event.sequenceType ~= "" then
                  if
                     (SkuOptions.db.char[MODULE_NAME].calendar.multiShown == 1 and event.sequenceType ~= "START")
                     or 
                     (SkuOptions.db.char[MODULE_NAME].calendar.multiShown == 2 and (event.sequenceType ~= "START" and event.sequenceType ~= "END"))
                  then
                     tShow = false
                  end
               end

               if tShow == true then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tWeekdayName.." "..day..". "..tMonthName..": "..i.." "..event.calendarType.." "..event.sequenceType.." "..(numSequenceDays or "nil").." "..event.numSequenceDays.." "..event.title}, SkuGenericMenuItem)
                  tNewMenuEntry.month = month
                  tNewMenuEntry.day = day
                  tNewMenuEntry.eventIndex = i
                  tNewMenuEntry.event = event
                  tNewMenuEntry.OnEnter = function(self, aValue, aName)
                     --print("OnEnter day", day, "i", i, "event.calendarType", event.calendarType, "event.numSequenceDays", event.numSequenceDays, "event.title", event.title)
                     SkuDispatcher:RegisterEventCallback("CALENDAR_OPEN_EVENT", function(dispatcher, EVENT, calendarType)
                        if calendarType == "PLAYER" then
                           local num = C_Calendar.GetNumInvites()
                           SkuOptions.currentMenuPosition.textFull = self.event.title.."\rnum "..num
                           --[[
                           print("CALENDAR_OPEN_EVENT", C_Calendar.GetNumInvites())
                           print("   day", day, "i", i)
                           print("   calendarType", calendarType)
                           print("   num", num)
                           ]]
                        end
                     end, true)
                     local success = C_Calendar.OpenEvent(month, day, i)
                     if success == true then
                        if self.event.calendarType == "PLAYER" then
                           SkuOptions.currentMenuPosition.textFull = self.event.title.."\rsuccess "..tostring(success).."\rABFRAGE LÄUFT"
                        else
                           --print(" OnEnter success TRUE", success)
                           SkuOptions.currentMenuPosition.textFull = self.event.title.."\rsuccess "..tostring(success)
                        end
                     else
                        SkuOptions.currentMenuPosition.textFull = self.event.title.."\rERROR"
                     end
                  
                  end
               end
            end
            
         end
      end
   end

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
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Filter"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.BuildChildren = function(self)
         for i, v in pairs(SkuCore.Calendar.CALENDAR_FILTER_CVARS) do
            if "skuCalendarHideAllHolidays" ~= v.cvar then
               SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar] = tonumber(GetCVar(v.cvar))
            end
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
               if "skuCalendarHideAllHolidays" ~= v.cvar then
                  SetCVar(v.cvar, SkuOptions.db.char[MODULE_NAME].calendar.filters[v.cvar])
               end
            end
            tNewMenuEntry.BuildChildren = function(self)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show"]}, SkuGenericMenuItem)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Hide"]}, SkuGenericMenuItem)
            end      
         end
      end   
      
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




   end
end

--[[
to do:
   - merge options with db . debugOptions
   - add menus for:   
      debugLevel = 3, -- 0 to 3 (0 is nothing)
      maxRepeatingErrors = -1, -- -1 for all
   - add Sku.debugModule.OutputErrorsToCopy
   - add slash commands
      - use Sku.debugModule.ClearErrors
   - register events via dispatcher
   - implment audio output in Sku.debugModule.AudioError
   - handle ACTION_BLOCKED, ACTION_FORBIDDEN events
]]
local originalPrint = getprinthandler()
local BugGrabber = BugGrabber

Sku.debugModule = {
   debugLevel = 3, -- 0 to 3 (0 is nothing)
   maxRepeatingErrors = -1, -- -1 for all
   bugAudioNotificationOnePerSeconds = 5,
   bugAudioNotificationLastOutputTime = GetTimePreciseSec() - 100,
}

--[[
   global debug level consts for easier use with print() (we can't use just numbers for debug level, because print takes
   an unknown number of arguments and in our handler we do need to check if there is a debug level value)
]]
for x = 0, 3 do
   _G["SDL"..x] = "SkuDebugLevel"..x
   _G["sdl"..x] = "SkuDebugLevel"..x
end

local addonLoaded = nil
---------------------------------------------------------------------------------------------------------
function Sku.debugModule.Print(...)
   local debugLevel
   local tResultString = ""
   local tStringsTable = {...}
   for x = 1, #tStringsTable - 1 do
      tResultString = tResultString..tostring(tStringsTable[x]).." "
   end

   if tStringsTable[#tStringsTable] == SDL0 then
      debugLevel = 0
   elseif tStringsTable[#tStringsTable] == SDL1 then
      debugLevel = 1
   elseif tStringsTable[#tStringsTable] == SDL2 then
      debugLevel = 2
   elseif tStringsTable[#tStringsTable] == SDL3 then
      debugLevel = 3
   else
      tResultString = tResultString..tostring(tStringsTable[#tStringsTable]).." "
   end

   if not debugLevel then
      originalPrint(...)
   else
      if debugLevel <= Sku.debugModule.debugLevel then
         if tResultString:find("Sku Error") then
            originalPrint(tResultString)
         else
            --originalPrint("Sku debug ("..debugLevel..")", tResultString)
            originalPrint(tResultString)
         end
      end
   end
end
setprinthandler(Sku.debugModule.Print)

---------------------------------------------------------------------------------------------------------
function Sku.debugModule:Error(aMessage)
   if not aMessage then
      return
   end

   aMessage = "Sku error: "..aMessage

   if _G["BugGrabber"] then
      local findVersions = nil
      do
         local function scanObject(o)
            local version, revision = nil, nil
            for k, v in next, o do
               if type(k) == "string" and (type(v) == "string" or type(v) == "number") then
                  local low = k:lower()
                  if not version and low:find("version") then
                     version = v
                  elseif not revision and low:find("revision") then
                     revision = v
                  end
               end
               if version and revision then break end
            end
            return version, revision
         end
      
         local matchCache = setmetatable({}, { __index = function(self, object)
            if type(object) ~= "string" or #object < 3 then return end
            local found = nil
            -- First see if it's a library
            if LibStub then
               local _, minor = LibStub(object, true)
               found = minor
            end
            -- Then see if we can get some addon metadata
            if not found and IsAddOnLoaded(object) then
               found = GetAddOnMetadata(object, "X-Curse-Packaged-Version")
               if not found then
                  found = GetAddOnMetadata(object, "Version")
               end
            end
            -- Perhaps it's a global object?
            if not found then
               local o = _G[object] or _G[object:upper()]
               if type(o) == "table" then
                  local v, r = scanObject(o)
                  if v or r then
                     found = tostring(v) .. "." .. tostring(r)
                  end
               elseif o then
                  found = o
               end
            end
            if not found then
               found = _G[object:upper() .. "_VERSION"]
            end
            if type(found) == "string" or type(found) == "number" then
               self[object] = found
               return found
            end
         end })
      
         local tmp = {}
         local function replacer(start, object, tail)
            -- Have we matched this object before on the same line?
            -- (another pattern could re-match a previous match...)
            if tmp[object] then return end
            local found = matchCache[object]
            if found then
               tmp[object] = true
               return (type(start) == "string" and start or "") .. object .. "-" .. found .. (type(tail) == "string" and tail or "")
            end
         end
      
         local matchers = {
            "(\\)([^\\]+)(%.lua)",       -- \Anything-except-backslashes.lua
            "^()([^\\]+)(\\)",           -- Start-of-the-line-until-first-backslash\
            "()(%a+%-%d%.?%d?)()",       -- Anything-#.#, where .# is optional
            "()(Lib%u%a+%-?%d?%.?%d?)()" -- LibXanything-#.#, where X is any capital letter and -#.# is optional
         }
         function findVersions(line)
            if not line or line:find("FrameXML\\") then return line end
            for i = 1, 4 do
               line = line:gsub(matchers[i], replacer)
            end
            wipe(tmp)
            return line
         end
      end

      -- Scan for version numbers in the stack
      local tmp = {}
      local stack = debugstack(2)

      -- Scan for version numbers in the stack
      for line in stack:gmatch("(.-)\n") do
         tmp[#tmp+1] = findVersions(line)
      end
      local inCombat = IsEncounterInProgress() -- debuglocals can be slow sometimes (200ms+)
      local errorObject = {
         message = aMessage,
         stack = table.concat(tmp, "\n"),
         locals = inCombat and "Skipped (In Encounter)" or debuglocals(2),
         session = _G["BugGrabber"]:GetSessionId(),
         time = date("%Y/%m/%d %H:%M:%S"),
         counter = 1,
      }

      _G["BugGrabber"]:StoreError(errorObject)
   end

   if addonLoaded then
      Sku.debugModule.OutputLastError()
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule:SetErrorNotifications()
   if SkuOptions.db.profile["SkuOptions"].debugModule.bugsackAudioNotificationEnabled ~= nil then
      if SkuOptions.db.profile["SkuOptions"].debugModule.bugsackAudioNotificationEnabled == true and _G["BugSack"] then
         _G["BugSack"].db.mute = nil
      elseif SkuOptions.db.profile["SkuOptions"].debugModule.bugsackAudioNotificationEnabled == false and _G["BugSack"] then
         _G["BugSack"].db.mute = true
      end
   end
   if aSkuChatNotification ~= nil then
      SkuOptions.db.profile["SkuOptions"].debugModule.chatNotification = aSkuChatNotification
   end
   if aSkuAudioNotification ~= nil then
      SkuOptions.db.profile["SkuOptions"].debugModule.audioNotification = aSkuAudioNotification
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule.ClearErrors()
   db = {}
   if _G["BugSack"] then
      _G["BugSack"]:Reset()
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule.AudioError(aError, aDetailed, aForce)
   if SkuOptions.db.profile["SkuOptions"].debugModule.audioNotification ~= true then
      return
   end
   if GetTimePreciseSec() - Sku.debugModule.bugAudioNotificationLastOutputTime > Sku.debugModule.bugAudioNotificationOnePerSeconds then
      Sku.debugModule.bugAudioNotificationLastOutputTime = GetTimePreciseSec()
      if aError.counter < 2 then
         print("<insert bug audio notification here>")







      end
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule.PrintError(aError, aDetailed, aForce)
   --[[error = {number, session, counter, message, time, locals, stack}]]
   if SkuOptions.db.profile["SkuOptions"].debugModule.chatNotification ~= true then
      return
   end

   local tMessage
   if (aError.counter < Sku.debugModule.maxRepeatingErrors or Sku.debugModule.maxRepeatingErrors == -1) or aForce == true then
      tMessage = aError.number..": "..aError.counter.." x "..aError.message.." "..aError.time
   elseif aError.counter == Sku.debugModule.maxRepeatingErrors then
      tMessage = aError.number..": "..aError.counter.." x "..aError.message.." (repeating) "..aError.time
   end
   if tMessage then
      if aDetailed and aError.stack then
         print(tMessage.."\n"..aError.stack)
      else
         print(tMessage)
      end
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule:OutputErrors(aNumberOfErrors, aDetailed, aFromStart)
   if not BugGrabber then
      return
   end

   local errors = Sku.debugModule:GetErrors(BugGrabber:GetSessionId())
   if not errors or #errors == 0 then
      return
   end

   local tend = #errors
   local tstart = #errors - aNumberOfErrors + 1
   if tstart < 1 then
      tstart = 1
   end

   if aFromStart == true then
      tstart = 1
      tend = aNumberOfErrors
   end

   for x = tstart, tend do
      errors[x].number = x
      Sku.debugModule.PrintError(errors[x], aDetailed, true)
   end
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule.OutputLastError(aDetailed, aForce)
   if not BugGrabber then
      return
   end

   local errors = Sku.debugModule:GetErrors(BugGrabber:GetSessionId())
   if not errors or #errors == 0 then
      return
   end
   errors[#errors].number = #errors
   Sku.debugModule.PrintError(errors[#errors], aDetailed, aForce)
   Sku.debugModule.AudioError(errors[#errors], aDetailed, aForce)
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule.OnError()
   Sku.debugModule.OutputLastError()
end

---------------------------------------------------------------------------------------------------------
function Sku.debugModule:GetErrors(sessionId)
   if not BugGrabber then
      return
   end

   if sessionId then
      local errors = {}
      local db = BugGrabber:GetDB()
      for i, e in next, db do
         if sessionId == e.session then
            errors[#errors + 1] = e
         end
      end
      return errors
   end
end

---------------------------------------------------------------------------------------------------------
local events = {}
do
   local frame = CreateFrame("Frame")
   frame:SetScript("OnEvent", function(_, event, ...)
      events[event](events, event, ...)
   end)
   frame:RegisterEvent("ADDON_LOADED")
   frame:RegisterEvent("ADDON_ACTION_BLOCKED")
   frame:RegisterEvent("MACRO_ACTION_FORBIDDEN")
   frame:RegisterEvent("ADDON_ACTION_BLOCKED")
   frame:RegisterEvent("MACRO_ACTION_FORBIDDEN")
   frame:RegisterEvent("LUA_WARNING")
end

---------------------------------------------------------------------------------------------------------
function events:ADDON_LOADED(event, msg)
   if msg == "Sku" then
      addonLoaded = true

      if BugGrabber then
         local tSessionId = BugGrabber:GetSessionId()
         if tSessionId then
            local sessionData = Sku.debugModule:GetErrors(tSessionId)
            local sessionDataClean = {}
            if sessionData ~= nil and #sessionData > 0 then 
               print("--> Errors on loading:", #sessionDataClean, (#sessionData - 1))
               Sku.debugModule:OutputErrors(#sessionData - 1, nil, true)
               Sku.debugModule.OnError()
            end
            BugGrabber.RegisterCallback(Sku, "BugGrabber_BugGrabbed", Sku.debugModule.OnError)
         end
      end
   end
end

--[[
---------------------------------------------------------------------------------------------------------
function events:MACRO_ACTION_BLOCKED(event, msg)   
   --Sku.debugModule:Error(event..": "..msg)
end

---------------------------------------------------------------------------------------------------------
function events:ADDON_ACTION_BLOCKED(event, msg)
   --Sku.debugModule:Error(event..": "..msg)
end

---------------------------------------------------------------------------------------------------------
function events:MACRO_ACTION_FORBIDDEN(event, msg)
   --Sku.debugModule:Error(event..": "..msg)
end

---------------------------------------------------------------------------------------------------------
function events:ADDON_ACTION_FORBIDDEN(event, msg)
   --Sku.debugModule:Error(event..": "..msg)
end
]]
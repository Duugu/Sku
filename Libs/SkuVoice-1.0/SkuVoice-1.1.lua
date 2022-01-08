local SkuVoice_MAJOR, SkuVoice_MINOR = "SkuVoice-1.1", 1
local SkuVoice, oldminor = LibStub:NewLibrary(SkuVoice_MAJOR, SkuVoice_MINOR)

if not SkuVoice then return end -- No upgrade needed

local printMT = {
	__tostring = function(thisTable)
		local tStr = ""
		local function tf(ttable, tTab)
			for k, v in pairs(ttable) do
				if k ~= "parent" and v ~= "parent" and k ~= "prev" and v ~= "prev" and k ~= "next" and v ~= "next"  then
					if type(v) ~= "userdata" and k ~= "frame" and k ~= 0  then
						if type(v) == 'table' then
							print(tTab..k..": tab")
							tf(v, tTab.."  ")
						elseif type(v) == "function" then
							--dprint(tTab..k..": function")
						elseif type(v) == "boolean" then
							print(tTab..k..": "..tostring(v))
						else
							print(tTab..k..": "..v)
						end
					end
				end
			end
		end
		tf(thisTable, "")
	end,
	}

mSkuVoiceQueue = {}
setmetatable(mSkuVoiceQueue, printMT)
--setmetatable(mSkuVoiceQueue, SkuNav.PrintMT)

local mSkuVoiceAssignedUtteranceID

---------------------------------------------------------------------------------------------------------
local function SpeakTextHook(...)
   if mSkuVoiceAssignedUtteranceID then
      mSkuVoiceAssignedUtteranceID = mSkuVoiceAssignedUtteranceID + 1
   end
end

function SkuVoice:Create()
	local f = CreateFrame("Frame", "SkuVoiceMainFrame", UIParent)
   f:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FAILED")
   f:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FINISHED")
   f:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_STARTED")

   f:SetScript("OnEvent", function(self, event, ...)
      if (event == "VOICE_CHAT_TTS_PLAYBACK_FAILED") then
         local status, utteranceID, destination = ...
         for i, v in pairs(mSkuVoiceQueue) do
            if v.utteranceID == utteranceID then
               table.remove(mSkuVoiceQueue, i)
            end
         end
         --dprint("TTS_PLAYBACK_FAILED", status, utteranceID, destination)

      elseif (event == "VOICE_CHAT_TTS_PLAYBACK_FINISHED") then
         local numConsumers, utteranceID, destination = ...
         --dprint("TTS_PLAYBACK_FINISHED", numConsumers, utteranceID, destination)

      elseif (event == "VOICE_CHAT_TTS_PLAYBACK_STARTED") then
         local numConsumers, utteranceID, durationMS, destination = ...
         if not mSkuVoiceAssignedUtteranceID then
            mSkuVoiceAssignedUtteranceID = utteranceID - 1
         end
         for i, v in pairs(mSkuVoiceQueue) do
            if v.utteranceID == utteranceID then
               table.remove(mSkuVoiceQueue, i)
            end
         end
         --dprint("TTS_PLAYBACK_STARTED", numConsumers, utteranceID, durationMS, destination)

      end
   end)

   hooksecurefunc(C_VoiceChat, "SpeakText", SpeakTextHook)
   C_VoiceChat.SpeakText(0, "TTS initialisiert", 6, 4, 100)
      
	return SkuVoice
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:UtilRound(aNumber, aInterval)
	return (aInterval * math.floor( 10 * aNumber / aInterval ) / 10)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SplitString(aString)
	--dprint("split:", aString, SkuAudioFileIndex[aString])
	if SkuAudioFileIndex[aString] then
		return aString
	end
	if aString == nil then
		return ""
	end

	if aString == "" then
		return aString
	end
	aString = string.gsub(aString, "\"", ";"..L["backslash"]..";")
	aString = string.gsub(aString, "'", ";")
	aString = string.gsub(aString, "%.", ";"..L["period"]..";")
	aString = string.gsub(aString, ",", ";")
	aString = string.gsub(aString, "%?", ";"..L["question;mark"]..";")
	aString = string.gsub(aString, "!", ";"..L["exclamation;point"]..";")
	aString = string.gsub(aString, "|", ";")
	aString = string.gsub(aString, "%[", ";")
	aString = string.gsub(aString, "%]", ";")
	aString = string.gsub(aString, "%+", ";")
	aString = string.gsub(aString, "%*", ";")
	aString = string.gsub(aString, "#", ";")
	aString = string.gsub(aString, "%-", ";")
	aString = string.gsub(aString, ":", ";"..L["colon"]..";")
	aString = string.gsub(aString, "&", ";"..L["and"]..";")
	aString = string.gsub(aString, "%%", ";"..L["percent"]..";")
	aString = string.gsub(aString, "/", ";"..L["slash"]..";")
	aString = string.gsub(aString, "\\", ";\\;")
	aString = string.gsub(aString, "%(", ";(;")
	aString = string.gsub(aString, "%)", ";);")
	aString = string.gsub(aString, "=", ";=;")
	aString = string.gsub(aString, "<", ";<;")
	aString = string.gsub(aString, ">", ";>;")
	aString = string.gsub(aString, "	", ";")
	aString = string.gsub(aString, "  ", " ")
	aString = string.gsub(aString, " ", ";")
	aString = string.gsub(aString, ";;", ";")
	aString = string.lower(aString)

	if string.sub(aString, string.len(aString)) == ";" then
		aString = string.sub(aString, 1, string.len(aString)-1)
	end
	return aString
end

---------------------------------------------------------------------------------------------------------------------------------------
local function Unescape(aString)
	local tResult = tostring(aString)
	tResult = gsub(tResult, "|c........", "") -- Remove color start.
	tResult = gsub(tResult, "|r", "") -- Remove color end.
	tResult = gsub(tResult, "|H.-|h(.-)|h", "%1") -- Remove links.
	tResult = gsub(tResult, "|T.-|t", "") -- Remove textures.
	tResult = gsub(tResult, "{.-}", "") -- Remove raid target icons.
	return tResult
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:StopAllOutputs()
	for i = 1, table.getn(mSkuVoiceQueue) do
		if mSkuVoiceQueue[i] then
			if mSkuVoiceQueue[i].soundHandle then
				StopSound(mSkuVoiceQueue[i].soundHandle, 0)
			end
		end
	end
	mSkuVoiceQueue = {}
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:OutputString(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell) -- for strings with lookup in string index
	--dprint(aString)
	local tString = ""
	if aSpell == true then
		aString = string.lower(aString)
		for tChr in aString:gmatch("[\33-\127\192-\255]?[\128-\191]*") do
			tString = tString..tChr..";"
		end
		while string.find(tString, ";;") do
			tString = string.gsub(tString, ";;", ";")
		end
		aString = tString
	end


	aSoundChannel = aSoundChannel or SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head"

	if not aString then
		return
	end
	if aString == "" then
		return
	end

   -- don't vocalize numbers > 20000 or floats
   -- that is for the unique auto wp ids and the coords; we don't want hear them, but we still need them in the wp names
   local tNumberTest = tonumber(aString)
   if tNumberTest then
      local tFloat = math.floor(tNumberTest)
      if (tNumberTest > 20000) or (tNumberTest - tFloat > 0) then
         return
      end
   end

   aString = Unescape(aString)
   aString = aString:gsub("\"", "")

   local tStrings = {}
   if (string.find(aString, "sound-") or string.find(aString, "male%-")) then
      table.insert(tStrings, aString)
   else
      aString = string.lower(aString)
      aString= SplitString(aString)

      local sep, tSplittedString = ";", {}
      if type(aString) == "string" then
         local pattern = string.format("([^%s]+)", sep)
         aString:gsub(pattern, function(c) tSplittedString[#tSplittedString+1] = c end)
      else
         tSplittedString = {aString}
      end

      for x = 1, #tSplittedString do
         if tonumber(tSplittedString[x]) then
            local tFloatNumber = string.format("%.1f", tonumber(tSplittedString[x]))
            if tonumber(tFloatNumber) < 1000000 then
               if (tFloatNumber - string.format("%d", tFloatNumber)) > 0 then
                  --float
                  local tIVal = string.format("%d", tFloatNumber)
                  local tFVal = string.format("%d", string.format("%.1f", (tFloatNumber - tIVal) * 10))
                  table.insert(tStrings, tIVal)
                  table.insert(tStrings, "Komma")
                  table.insert(tStrings, tFVal)
               else
                  --int
                  local tNumber = math.floor(tonumber(tSplittedString[x]))
                  if tNumber == 0 then
                     table.insert(tStrings, 0)
                  else
                     local tRemaining = tNumber
                     if tNumber > 13000 then
                        --no audio available
                     end
                     if tNumber > 999 then
                        local tRound = SkuVoice:UtilRound(tRemaining, 10000)
                        table.insert(tStrings, tRound)
                        tRemaining = tRemaining - tRound
                     end
                     if tRemaining > 99 then
                        local tRound = SkuVoice:UtilRound(tRemaining, 1000)
                        table.insert(tStrings, tRound)
                        tRemaining = tRemaining - tRound
                     end
                     if tRemaining > 0 then
                        table.insert(tStrings, tRemaining)
                     end
                  end
               end
            end
         else
            table.insert(tStrings, tSplittedString[x])
         end
      end
   end


   local tFinalString = ""
   for x = 1, #tStrings do
      local tLength = SkuAudioDataLenIndex[tFile] or aLength
      tFinalString = tFinalString.." "..tStrings[x]
   end
   aOverwrite = aOverwrite or false
   aWait = aWait or false
   print("tts:", tFinalString)
   SkuVoice:UpdateQueue(tFinalString, aOverwrite)
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:UpdateQueue(aFinalString, aOverwrite)
   if aOverwrite == true then
      print("======= overwrite =============")
      C_VoiceChat.StopSpeakingText()
      local tIt = true
      while tIt == true do
         tIt = false
         for i, v in pairs(mSkuVoiceQueue) do
            if v.doNotOverwrite ~= true then
               table.remove(mSkuVoiceQueue, i)
               tIt = true
            end
         end
      end
      mSkuVoiceQueue[#mSkuVoiceQueue + 1] ={
         ["text"] = aFinalString,
         ["doNotOverwrite"] = aDoNotOverwrite or false,
         ["utteranceID"] = mSkuVoiceAssignedUtteranceID
      }

      for i = 1, table.getn(mSkuVoiceQueue) do
         --local willPlay, soundHandle = PlaySoundFile(mSkuVoiceQueue[i].file, mSkuVoiceQueue[i].soundChannel)
         C_VoiceChat.SpeakText(0, mSkuVoiceQueue[i].text, 6, 4, 100)
      end
   else
      C_VoiceChat.SpeakText(0, aFinalString, 6, 4, 100)

      mSkuVoiceQueue[#mSkuVoiceQueue + 1] ={
         ["text"] = aFinalString,
         ["doNotOverwrite"] = aDoNotOverwrite or false,
         ["utteranceID"] = mSkuVoiceAssignedUtteranceID
      }
   end

   --dprint("++++++++++++++++++++++++++++++++++++++++++++++++")
   --dprint(mSkuVoiceQueue)

end

---------------------------------------------------------------------------------------------------------
function SkuVoice:StopOutputEmptyQueue()
	-- fade all in SkuVoiceQueue
   C_VoiceChat.StopSpeakingText()
	mSkuVoiceQueue = {}
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:Output(file, overwrite, wait, length, doNotOverwrite, isMulti, soundChannel) -- for audio file names
	--dprint("SV OUTPUT")
   if 1 == 1 then return end
	soundChannel = soundChannel or SkuOptions.db.profiles["SkuOptions"].soundChannels.SkuChannel or "Talking Head"
	
	isMulti = isMulti or false

	if not file or not SkuAudioDataLenIndex then
		return
	end

	if not SkuAudioDataLenIndex[file] then --element is in string index
		if SkuCore and file then
			--SkuCore:Debug("SkuVoice:Output - missing audio file: "..file)
		end
	end

	local length = SkuAudioDataLenIndex[file] or length

	file = "Interface\\AddOns\\SkuAudioData\\assets\\audio\\"..file

	overwrite = overwrite or false
	wait = wait or false
	length = length or 0

	if overwrite == true then
		-- fade all in SkuVoiceQueue
		for i = 1, table.getn(mSkuVoiceQueue) do
			if mSkuVoiceQueue[i] then
				if mSkuVoiceQueue[i].soundHandle then
					StopSound(mSkuVoiceQueue[i].soundHandle)
				end
			end
		end
		mSkuVoiceQueue = {}
	end

	table.insert(mSkuVoiceQueue, {
		["file"] = file,
		["wait"] = wait,
		["length"] = length,
		["endTimestamp"] = 0,
		["soundHandle"] = nil,
		["doNotOverwrite"] = doNotOverwrite or false,
		["soundChannel"] = soundChannel,
		["tombstone"] = false,
})
end

function SkuVoice:Release()

end

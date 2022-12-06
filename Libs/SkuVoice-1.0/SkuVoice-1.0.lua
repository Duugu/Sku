local SkuVoice_MAJOR, SkuVoice_MINOR = "SkuVoice-1.0", 1
local SkuVoice, oldminor = LibStub:NewLibrary(SkuVoice_MAJOR, SkuVoice_MINOR)

--local L = Sku.L
local L = LibStub("AceLocale-3.0"):GetLocale("Sku", false)

if not SkuVoice then return end -- No upgrade needed

local SapiLangIds = {
	["deDE"] = 407,
	["enUS"] = 409,
	["enAU"] = 409,
	}

local mSkuVoiceQueue = {}
local mSkuVoiceQueueBTTS = {}
local mSkuVoiceQueueBTTS_Speaking = {}
SkuVoice.LastPlayedString = ""
--setmetatable(mSkuVoiceQueue, SkuNav.PrintMT)

function SkuVoice:Create()
	local f = CreateFrame("Frame", "SkuVoiceMainFrame", UIParent)
	f:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FINISHED")
	f:SetScript("OnEvent", function(self, aEventName)
		if aEventName == "VOICE_CHAT_TTS_PLAYBACK_FINISHED" then
			if mSkuVoiceQueueBTTS_Speaking[1] then
				table.remove(mSkuVoiceQueueBTTS_Speaking, 1)
			end
		end
	end)
	local fTime = 0
	local fTimeBTTS = 0
	local tLastWait = -1
	f:SetScript("OnUpdate", function(self, time)

		fTimeBTTS = fTimeBTTS + time
		if fTimeBTTS > 0.01 then
			fTimeBTTS = 0
			local tLastReset
			for x = 1, #mSkuVoiceQueueBTTS do
				if mSkuVoiceQueueBTTS[x] == "queuereset" then
					tLastReset = x
				end
			end
			if tLastReset then
				for x = 1, tLastReset - 1 do
					--print("  Q R: ", x, mSkuVoiceQueueBTTS[1])
					table.remove(mSkuVoiceQueueBTTS, 1)
				end
			end
			for x = 1, #mSkuVoiceQueueBTTS do
				--print("  Q: ", x, mSkuVoiceQueueBTTS[x])
			end
			if #mSkuVoiceQueueBTTS > 0 then
				--print("           ", tLastWait, mSkuVoiceQueueBTTS[1])
				local tValue = mSkuVoiceQueueBTTS[1]
				if tValue == "queuereset" then
						table.remove(mSkuVoiceQueueBTTS, 1)
						if SkuOptions.db.profile["SkuChat"].neverResetQueues ~= true then
							C_VoiceChat.StopSpeakingText()
						end
						mSkuVoiceQueueBTTS_Speaking = {}
						tLastWait = 0.10
				else
					if #mSkuVoiceQueueBTTS > 1 or tLastWait <= 0 then
						table.remove(mSkuVoiceQueueBTTS, 1)
						local tIsAlreadySpeakingThat
						for z = 1, #mSkuVoiceQueueBTTS_Speaking do
							--print(z, mSkuVoiceQueueBTTS_Speaking[z])
							if mSkuVoiceQueueBTTS_Speaking[z] == tValue then
								tIsAlreadySpeakingThat = true
							end
						end
						if not tIsAlreadySpeakingThat then
							table.insert(mSkuVoiceQueueBTTS_Speaking, tValue)
							C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, tValue, 4, SkuOptions.db.profile["SkuChat"].WowTtsSpeed, SkuOptions.db.profile["SkuChat"].WowTtsVolume)
						end
						--print("tLastWait = 0")
						tLastWait = 0.1
					else
						--print("tLastWait = 0.06")
						tLastWait = tLastWait - time

					end
				end
			end
		end

		fTime = fTime + time
		if fTime > 0.1 then
			fTime = 0
			--play everything that is not flagged for queuing (wait == true)
			for i = 1, table.getn(mSkuVoiceQueue) do
				if mSkuVoiceQueue[i].wait == false and not mSkuVoiceQueue[i].soundHandle then
					local willPlay, soundHandle = PlaySoundFile(mSkuVoiceQueue[i].file, mSkuVoiceQueue[i].soundChannel)
					if willPlay then
						SkuVoice.LastPlayedString = mSkuVoiceQueue[i].text
						mSkuVoiceQueue[i].soundHandle = soundHandle
						mSkuVoiceQueue[i].endTimestamp = GetTime() + mSkuVoiceQueue[i].length
					end
				end
			end

			--play everything that is flagged for dnq
			for i = 1, table.getn(mSkuVoiceQueue) do
				if mSkuVoiceQueue[i].dnq == true and not mSkuVoiceQueue[i].soundHandle then
					local willPlay, soundHandle = PlaySoundFile(mSkuVoiceQueue[i].file, mSkuVoiceQueue[i].soundChannel)
					if willPlay then
						SkuVoice.LastPlayedString = mSkuVoiceQueue[i].text
						mSkuVoiceQueue[i].soundHandle = soundHandle
						mSkuVoiceQueue[i].endTimestamp = GetTime() + mSkuVoiceQueue[i].length
					end
				end
			end		

			--check if there is something finished and should be tombstoned
			for i = 1, table.getn(mSkuVoiceQueue) do
				if mSkuVoiceQueue[i].soundHandle then
					if (GetTime() - mSkuVoiceQueue[i].endTimestamp) > 0 then
						mSkuVoiceQueue[i].tombstone = true
					end
				end
			end

			-- delete everything that is tombstoned
			local tIt = true
			while tIt == true do
				tIt = false
				for i, v in pairs(mSkuVoiceQueue) do
					if v.tombstone == true then
						--stop it first; just to be sure
						if v.soundHandle then
							StopSound(v.soundHandle, 0)
						end
						table.remove(mSkuVoiceQueue, i)
						tIt = true
					end
				end
			end

			--check if next could be played
			local tPlayNext = true
			for i = 1, table.getn(mSkuVoiceQueue) do
				if mSkuVoiceQueue[i].soundHandle and mSkuVoiceQueue[i].dnq ~= true then
					--is playing; check remaining time modifyed  by pause setting
					local tRemainingTime = (GetTime() - mSkuVoiceQueue[i].endTimestamp) + (mSkuVoiceQueue[i].length - (mSkuVoiceQueue[i].length * (SkuOptions.db.profile["SkuOptions"].TTSSepPause / 100)))
					if tRemainingTime < 0 then
						--nope
						tPlayNext = false
					end
				end
			end

			--it can play
			for i = 1, table.getn(mSkuVoiceQueue) do
				if not mSkuVoiceQueue[i].soundHandle and mSkuVoiceQueue[i].tombstone ~= true and tPlayNext == true and mSkuVoiceQueue[i].wait ~= false then
					local willPlay, soundHandle = PlaySoundFile(mSkuVoiceQueue[i].file, mSkuVoiceQueue[i].soundChannel)
					if willPlay then
						SkuVoice.LastPlayedString = mSkuVoiceQueue[i].text
						mSkuVoiceQueue[i].soundHandle = soundHandle
						mSkuVoiceQueue[i].endTimestamp = GetTime() + mSkuVoiceQueue[i].length
						tPlayNext = false
					else
						--there's something quite wrong with that entry
						mSkuVoiceQueue[i].tombstone = true
					end
				end
			end

		end

	end)

	return SkuVoice
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:UtilRound(aNumber, aInterval)
	return (aInterval * math.floor( 10 * aNumber / aInterval ) / 10)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SplitStringBTTS(aString)
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
	aString = string.gsub(aString, "\r\n", ";")
	aString = string.gsub(aString, "\r", ";")
	aString = string.gsub(aString, "\n", ";")
	aString = string.gsub(aString, "\"", ";")
	--aString = string.gsub(aString, "\"", ";backslash;")
	if Sku.Loc == "deDE" then
		aString = string.gsub(aString, "'", ";")
	end
	--aString = string.gsub(aString, "%.", L[";punkt;"])
	aString = string.gsub(aString, ",", ";")
	--aString = string.gsub(aString, "%?", L[";fragezeichen;"])
	--aString = string.gsub(aString, "!", L[";ausrufungszeichen;"])
	aString = string.gsub(aString, "|", ";")
	aString = string.gsub(aString, "%[", ";")
	aString = string.gsub(aString, "%]", ";")
	aString = string.gsub(aString, "%+", ";")
	aString = string.gsub(aString, "%*", ";")
	aString = string.gsub(aString, "#", ";")
	aString = string.gsub(aString, "%-", ";")
	--aString = string.gsub(aString, ":", L[";doppelpunkt;"])
	--aString = string.gsub(aString, "&", ";und;")
	--aString = string.gsub(aString, "%%", L[";prozent;"])
	aString = string.gsub(aString, "/", L[";slash;"])
	aString = string.gsub(aString, "\\", ";\\;")
	--aString = string.gsub(aString, "%(", L[";klammer;"])
	--aString = string.gsub(aString, "%)", L[";klammer;"])
	--aString = string.gsub(aString, "=", L[";gleich;"])
	aString = string.gsub(aString, "<", L[";spitze;klammer;"])
	aString = string.gsub(aString, ">", L[";spitze;klammer;"])
	aString = string.gsub(aString, "	", ";")
	aString = string.gsub(aString, "  ", " ")
	aString = string.gsub(aString, " ", " ")
	aString = string.gsub(aString, ";;", ";")
	aString = string.lower(aString)

	if string.sub(aString, string.len(aString)) == ";" then
		aString = string.sub(aString, 1, string.len(aString)-1)
	end
	return aString
end

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
	aString = string.gsub(aString, "\r\n", ";")
	aString = string.gsub(aString, "\r", ";")
	aString = string.gsub(aString, "\n", ";")
	aString = string.gsub(aString, "\"", ";")
	--aString = string.gsub(aString, "\"", ";backslash;")
	if Sku.Loc == "deDE" then
		aString = string.gsub(aString, "'", ";")
	end
	aString = string.gsub(aString, "%.", L[";punkt;"])
	aString = string.gsub(aString, ",", ";")
	aString = string.gsub(aString, "%?", L[";fragezeichen;"])
	aString = string.gsub(aString, "!", L[";ausrufungszeichen;"])
	aString = string.gsub(aString, "|", ";")
	aString = string.gsub(aString, "%[", ";")
	aString = string.gsub(aString, "%]", ";")
	aString = string.gsub(aString, "%+", ";")
	aString = string.gsub(aString, "%*", ";")
	aString = string.gsub(aString, "#", ";")
	aString = string.gsub(aString, "%-", ";")
	aString = string.gsub(aString, ":", L[";doppelpunkt;"])
	aString = string.gsub(aString, "&", ";und;")
	aString = string.gsub(aString, "%%", L[";prozent;"])
	aString = string.gsub(aString, "/", L[";slash;"])
	aString = string.gsub(aString, "\\", ";\\;")
	aString = string.gsub(aString, "%(", L[";klammer;"])
	aString = string.gsub(aString, "%)", L[";klammer;"])
	aString = string.gsub(aString, "=", L[";gleich;"])
	aString = string.gsub(aString, "<", L[";spitze;klammer;"])
	aString = string.gsub(aString, ">", L[";spitze;klammer;"])
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
	tResult = gsub(tResult, "|n", ";") -- Remove color start.
	tResult = gsub(tResult, "|c........", "") -- Remove color start.
	tResult = gsub(tResult, "|r", "") -- Remove color end.
	tResult = gsub(tResult, "|H.-|h(.-)|h", "%1") -- Remove links.
	tResult = gsub(tResult, "|T.-|t", "") -- Remove textures.
	tResult = gsub(tResult, "{.-}", "") -- Remove raid target icons.
	return tResult
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:GetLastPlayedString()
	return SkuVoice.LastPlayedString
end

---------------------------------------------------------------------------------------------------------
local tLinkIgnoreList = {
	L["Link History"],
	L["SkuNavMenuEntry"],
	L["SkuMobMenuEntry"],
	L["SkuChatMenuEntry"],
	L["SkuQuestMenuEntry"],
	L["SkuCoreMenuEntry"],
	L["SkuAurasMenuEntry"],
	L["SkuOptionsMenuEntry"],
	L["SkuAdventureGuideMenuEntry"],
	L["Links:"],
	L["Links"],
	L["Link History"],
	L["All entries"],
	L[" (Redirected from "],
	L["Links"],
	L["Wiki"],
	L["Options"],
	L["Parent quest"],
	L["Quests"],
	L["Close"],
	L["Loot roll"],
	L["Inspect"],
	L["Quest"],
	L["Taxi"],
	L["Gossip"],
	L["Merchant"],
	L["Popup 1"],
	L["Popup 2"],
	L["Popup 3"],
	L["Pet Stable"],
	L["Mail"],
	L["Bag 1"],
	L["Bag 2"],
	L["Bag 3"],
	L["Bag 4"],
	L["Bag 5"],
	L["Bag 6"],
	L["Dropdown List 2"],
	L["Dropdown List 1"],
	L["Talents"],
	L["Send Mail"],
	L["Auction house"],
	L["Class Trainer"],
	L["Character"],
	L["Reputation"],
	L["Skills"],
	L["Honor"],
	L["Bagnon Taschen"],
	L["Spellbook"],
	L["Player Talents"],
	L["Friends"],
	L["Trade"],
	L["Game Menu"],
	L["Bagnon Bank"],
	L["Bagnon Guild"],
	L["Bank"],
	L["Guild Bank"],
	L["Panel"],
	L["Sub panel"],
	L["Details"],
	L["Details panel"],
	L["Sub panel"],
	L["Rewards"],
	L["Money"],
	L["Attributes"],
	L["Resistance"],
	L["Items"],
	L["Progress"],
	L["Container"],
	L["Text"],
	L["Button"],
	L["Sent"],
	L["Send failed"],
	L["Enter text and press ENTER key"],
	L["Recepient missing"],
	L["Topic missing"],
	L["Auto follow"],
	L["Hunter"],
	L["Notice on pet starving"],
	L["Left Multi Bar"],
	L["Right Multi Bar"],
	L["Bottom Multi Bar Left"],
	L["Bottom Multi Bar Right"],
	L["Main Action Bar"],
	L["Pet Action Bar"],
	L["Stance Action Bar"],
	L["Macros"],
	L["Menu empty"],
	L["Assign nothing"],
	L["Macro"],
	L["Key"],
}
function SkuVoice:CheckIgnore(aString)
	for i, v in pairs(tLinkIgnoreList) do
		if aString == v then
			return true
		end
		if string.find(v, aString) then
			return true
		end
	end
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:OutputStringBTtts(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks)
	--print("OutputStringBTtts", aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks)
	if not aString then
		return
	end

	--SkuNav:NavigationModeWoCoordinatesCheckTaskTrigger(aString)

	if SkuVoice:CheckIgnore(aString) then
		aIgnoreLinks = true
	end

	if SkuOptions.db.profile["SkuOptions"].useBlizzTtsInMenu ~= true and not engine and SkuOptions.db.profile["SkuChat"].allChatViaBlizzardTts ~= true then
		SkuVoice:OutputString(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks)
		return
	end

	aDnQ = aDnQ or false

	if aVocalizeAsIs then
		aString = string.gsub(aString, "%-", "minus ")
	end


	aString = string.gsub(aString, "%.%.%.", ";"..L["period"]..";"..L["period"]..";"..L["period"]..";")

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


	-- don't vocalize numbers > 20000 or floats
	-- that is for the unique auto wp ids and the coords; we don't want hear them, but we still need them in the wp names
	if not aVocalizeAsIs then
		local tNumberTest = tonumber(aString)
		if tNumberTest then
			local tFloat = math.floor(tNumberTest)
			if (tNumberTest > 20000) or (tNumberTest - tFloat > 0) then
				return
			end
		end
	end

	--empty the queue
	if aOverwrite == true and SkuOptions.db.profile["SkuChat"].neverResetQueues ~= true then
		mSkuVoiceQueueBTTS[#mSkuVoiceQueueBTTS + 1] = "queuereset"
		--print("ADD RESET TO QUEUE")
		--[[
		local tIt = true
		while tIt == true do
			tIt = false
			for i, v in pairs(mSkuVoiceQueue) do
				if v.doNotOverwrite ~= true then
					--stop it first; just to be sure
					if v.soundHandle then
						StopSound(v.soundHandle, 0)
					end
					table.remove(mSkuVoiceQueue, i)
					tIt = true
				end
			end
		end
		]]
--[[
		if IsMacClient() == true then
			C_VoiceChat.StopSpeakingText()
		else
			print("C_VoiceChat.StopSpeakingText()")
			C_VoiceChat.StopSpeakingText()
		end
]]
	end

	--remove escape markup
	while string.find(aString, "|n") do
		aString = string.gsub(aString, "|n", ";")
	end
	while string.find(aString, "|") do
		aString = string.gsub(aString, "|", " ")
	end

	aString = Unescape(aString)
	aString = aString:gsub("\"", "")

	local tStrings = {}
	if (string.find(aString, "sound-") or string.find(aString, "male%-")) then
		table.insert(tStrings, aString)
	else
		aString = string.lower(aString)
		aString= SplitStringBTTS(aString)

		local sep, tSplittedString = ";", {}
		if type(aString) == "string" then
			local pattern = string.format("([^%s]+)", sep)
			aString:gsub(pattern, function(c) tSplittedString[#tSplittedString+1] = c end)
		else
			tSplittedString = {aString}
		end

		for x = 1, #tSplittedString do
			if tonumber(tSplittedString[x]) then
				--print(x, "  NUMBER", tSplittedString[x])
				if not aVocalizeAsIs then
					if not string.find(tostring(tSplittedString[x]), "%.") and not string.find(tostring(tSplittedString[x]), ",") then
						local tFloatNumber = string.format("%.1f", tonumber(tSplittedString[x]))
						--print("tFloatNumber", tFloatNumber)
						if tonumber(tFloatNumber) < 1000000 then
							if (tFloatNumber - string.format("%d", tFloatNumber)) > 0 then
								--float
								local tIVal = string.format("%d", tFloatNumber)
								local tFVal = string.format("%d", string.format("%.1f", (tFloatNumber - tIVal) * 10))
								--print("float tIVal, tFVal", tIVal, tFVal)
								--table.insert(tStrings, tIVal)
								--table.insert(tStrings, L["KommaNumbers"])
								--table.insert(tStrings, tFVal)
							else
								--int
								local tNumber = math.floor(tonumber(tSplittedString[x]))
								--print("int ", tNumber)
								if tNumber == 0 then
									table.insert(tStrings, 0)
								else
									local tRemaining = tNumber
									if tNumber > 13000 then
										--no audio available
										tRemaining = 0
										tNumber = 0
										--print(1)
									end
									if tNumber > 999 then
										local tRound = SkuVoice:UtilRound(tRemaining, 10000)
										table.insert(tStrings, tRound)
										tRemaining = tRemaining - tRound
										--print(2)
									end
									if tRemaining > 99 then
										local tRound = SkuVoice:UtilRound(tRemaining, 1000)
										table.insert(tStrings, tRound)
										tRemaining = tRemaining - tRound
										--print(4)
									end
									if tRemaining > 0 then
										table.insert(tStrings, tRemaining)
										--print(4)
									end
								end
							end
						end
					end
				else
					for z = 1, string.len(tSplittedString[x]) do
						table.insert(tStrings, string.sub(tSplittedString[x], z, z))
					end
				end
			else
				table.insert(tStrings, tSplittedString[x])
			end
		end
	end

	local tFinalStringForBTts = ""
	local tFinalStringForBTtsMac = ""

	for x = 1, #tStrings do
		if SkuOptions.db.profile["SkuChat"].WowTtsTags ~= false then
			tStrings[x] = string.gsub(tStrings[x], "§01", '<silence msec="100"/>')
		else
			tStrings[x] = string.gsub(tStrings[x], "§01", ', ')
		end

		--unmask bnet names
		tStrings[x] = string.gsub(tStrings[x], "$skuk1", "|K")
		tStrings[x] = string.gsub(tStrings[x], "$skuk2", "|k")

		tStrings[x] = string.gsub(tStrings[x], "§", " ")
		--dprint(" final",x, tStrings[x])

		if (string.find(tStrings[x], "sound%-") or string.find(tStrings[x], "male%-")) then
			--dprint("  FIND SOUND", tStrings[x])
			SkuVoice:OutputString(tStrings[x], aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks) -- for strings with lookup in string index
		else
			if (string.find(tStrings[x], "aura;sound")) then
				--tFinalStringForBTts = tFinalStringForBTts..'<silence msec="500"/>'..tStrings[x]
			end

			if SkuOptions.db.profile["SkuChat"].WowTtsTags ~= false then
				tFinalStringForBTts = tFinalStringForBTts..'<silence msec="100"/>'..tStrings[x]
				tFinalStringForBTtsMac = tFinalStringForBTtsMac..", "..tStrings[x]
			else
				tFinalStringForBTts = tFinalStringForBTts..' '..tStrings[x]
				tFinalStringForBTtsMac = tFinalStringForBTtsMac.." "..tStrings[x]
			end

		end

		--[[
		aWait = aWait or false
		aDoNotOverwrite = aDoNotOverwrite or false
		aSoundChannel
		aDnQ
		]]
	end

	if aVocalizeAsIs then
		tFinalStringForBTts = aString
		tFinalStringForBTtsMac = aString
	end

	--tFinalStringForBTts = '<voice required="Language='..SapiLangIds[Sku.Loc]..'">'..tFinalStringForBTts..'</LANG>'
	--tFinalStringForBTts = '<LANG LANGID="'..SapiLangIds[Sku.Loc]..'">'..tFinalStringForBTts..'</LANG>'
	if SkuOptions.db.profile["SkuChat"].WowTtsTags ~= false then
		tFinalStringForBTts = '<pitch middle="0">'..tFinalStringForBTts..'</pitch>'
	end
	tFinalStringForBTtsMac = tFinalStringForBTtsMac

	tFinalStringForBTts = string.gsub(tFinalStringForBTts, ";", " ")
	tFinalStringForBTtsMac = string.gsub(tFinalStringForBTtsMac, ";", " ")

	if IsMacClient() == true then
		if aInstant then
			mSkuVoiceQueueBTTS[#mSkuVoiceQueueBTTS + 1] = tFinalStringForBTtsMac
		else
			mSkuVoiceQueueBTTS[#mSkuVoiceQueueBTTS + 1] = tFinalStringForBTtsMac
		end
		if not aIgnoreLinks then
			SkuOptions.TTS:GetLinksTableFromString(tFinalStringForBTtsMac, "")
		end
	else
		if aInstant then
			mSkuVoiceQueueBTTS[#mSkuVoiceQueueBTTS + 1] = tFinalStringForBTts
		else
			mSkuVoiceQueueBTTS[#mSkuVoiceQueueBTTS + 1] = tFinalStringForBTts
		end

		if not aIgnoreLinks then
			SkuOptions.TTS:GetLinksTableFromString(tFinalStringForBTts, "")
		end

		--print(tFinalStringForBTts)
	end



end

---------------------------------------------------------------------------------------------------------
---@param aString string
---@param aOverwrite boolean
---@param aWait boolean
function SkuVoice:OutputString(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks) -- for strings with lookup in string index
	--print("OutputString", aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks)
	if not aString then
		return
	end
	
	--we need to skip checks, etc. for sounds to get better performance on aura output
	local tIsSound
	if string.sub(aString, 1, 6) == "sound-" then
		tIsSound = true
	end

	if not tIsSound then
		if SkuVoice:CheckIgnore(aString) then
			aIgnoreLinks = true
		end

		aDnQ = aDnQ or false

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


		if not (string.find(aString, "sound%-") or string.find(aString, "male%-")) and SkuOptions.db.profile["SkuChat"].allChatViaBlizzardTts == true then
			SkuVoice:OutputStringBTtts(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine, aSpell, aVocalizeAsIs, aInstant, aDnQ, aIgnoreLinks) -- for strings with lookup in string index
			return
		end


		aSoundChannel = aSoundChannel or SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head"

		aIsMulti = aIsMulti or false
		if string.find(aString, ";") then
			aIsMulti = true
		end

		if not aString or not SkuAudioDataLenIndex or not SkuAudioFileIndex then
			return
		end
		if aString == "" then
			return
		end
	else
		aSoundChannel = aSoundChannel or SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head"
	end

	if engine then
		--[[
		--dprint("engine", aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel, engine)
		local tIt = true
		while tIt == true do
			tIt = false
			for i, v in pairs(mSkuVoiceQueue) do
				if v.doNotOverwrite ~= true then
					--stop it first; just to be sure
					if v.soundHandle then
						StopSound(v.soundHandle, 0)
					end
					table.remove(mSkuVoiceQueue, i)
					tIt = true
				end
			end
		end
		if engine ~= 3 then
			if IsMacClient() == true then
				C_VoiceChat.StopSpeakingText()
				mSkuVoiceQueueBTTS_Speaking = {}
				table.insert(mSkuVoiceQueueBTTS_Speaking, tValue)
				C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, aString, 4, SkuOptions.db.profile["SkuChat"].WowTtsSpeed, SkuOptions.db.profile["SkuChat"].WowTtsVolume)
				if not aIgnoreLinks then
					SkuOptions.TTS:GetLinksTableFromString(aString, "")
				end
			else
				C_VoiceChat.StopSpeakingText()
				mSkuVoiceQueueBTTS_Speaking = {}
				C_Timer.After(0.05, function() 
					table.insert(mSkuVoiceQueueBTTS_Speaking, tValue)
					C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, aString, 4, SkuOptions.db.profile["SkuChat"].WowTtsSpeed, SkuOptions.db.profile["SkuChat"].WowTtsVolume)
					if not aIgnoreLinks then
						SkuOptions.TTS:GetLinksTableFromString(aString, "")
					end
				end)
			end
		end
		]]
	else
		if not tIsSound then
			-- don't vocalize numbers > 20000 or floats
			-- that is for the unique auto wp ids and the coords; we don't want hear them, but we still need them in the wp names
			if not aVocalizeAsIs then
				local tNumberTest = tonumber(aString)
				if tNumberTest then
					local tFloat = math.floor(tNumberTest)
					if (tNumberTest > 20000) or (tNumberTest - tFloat > 0) then
						return
					end
				end
			end
		end

		--empty the queue
		if aOverwrite == true then
			--[[
			for i = 1, table.getn(mSkuVoiceQueue) do
				if mSkuVoiceQueue[i] then
					if mSkuVoiceQueue[i].soundHandle then
						StopSound(mSkuVoiceQueue[i].soundHandle)
					end
				end
			end
			mSkuVoiceQueue = {}
			]]
			local tIt = true
			while tIt == true do
				tIt = false
				for i, v in pairs(mSkuVoiceQueue) do
					--print(i, v.text, aString, v.text == aString, #mSkuVoiceQueue)
					if v.doNotOverwrite ~= true or v.text == aString then
						--stop it first; just to be sure
						if v.soundHandle then
							StopSound(v.soundHandle, 0)
						end
						--mSkuVoiceQueue[i] = nil
						table.remove(mSkuVoiceQueue, i)
						--print(#mSkuVoiceQueue)
						tIt = true
					end
				end
			end
		end

		if not tIsSound then
			while string.find(aString, "|n") do
				aString = string.gsub(aString, "|n", ";")
			end
			while string.find(aString, "|") do
				aString = string.gsub(aString, "|", " ")
			end

			aString = Unescape(aString)
			aString = aString:gsub("\"", "")

			--collect links
			if not aIgnoreLinks then
				SkuOptions.TTS:GetLinksTableFromString(aString:gsub(";", " "), "")
			end
		end

		local tStrings = {}
		if (string.find(aString, "sound-") or string.find(aString, "male%-")) then
			table.insert(tStrings, aString)
		else
			aString = string.lower(aString)
			aString = SplitString(aString)

			local sep, tSplittedString = ";", {}
			if type(aString) == "string" then
				local pattern = string.format("([^%s]+)", sep)
				aString:gsub(pattern, function(c) tSplittedString[#tSplittedString+1] = c end)
			else
				tSplittedString = {aString}
			end

			for x = 1, #tSplittedString do
				if tonumber(tSplittedString[x]) then
					if not aVocalizeAsIs then
						local tFloatNumber = string.format("%.1f", tonumber(tSplittedString[x]))
						if tonumber(tFloatNumber) < 1000000 then
							if (tFloatNumber - string.format("%d", tFloatNumber)) > 0 then
								--float
								local tIVal = string.format("%d", tFloatNumber)
								local tFVal = string.format("%d", string.format("%.1f", (tFloatNumber - tIVal) * 10))
								table.insert(tStrings, tIVal)
								table.insert(tStrings, L["Komma"])
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
						for z = 1, string.len(tSplittedString[x]) do
							table.insert(tStrings, string.sub(tSplittedString[x], z, z))
						end
					end
				else
					table.insert(tStrings, tSplittedString[x])
				end
			end
		end

		for x = 1, #tStrings do
			local tFile
			if not tIsSound then
				--dprint("tStrings[x] sku", tStrings[x])
				if tStrings[x] == "§01" then
					tStrings[x] = "sound-silence0.1"
				end
				tFile = SkuAudioFileIndex[tostring(tStrings[x])]

				if tFile == nil then
					local tModString = string.lower(tostring(tStrings[x]))
					tFile = SkuAudioFileIndex[tModString]
				end
				if tFile == nil then
					local tModString = string.upper(string.sub(tostring(tStrings[x]),1,1))..string.sub(tostring(tStrings[x]),2)
					tFile = SkuAudioFileIndex[tModString]
				end
				--dprint(tStrings[x], "tFile", tFile)

				if tFile == nil then
					tFile = SkuAudioFileIndex["sound-audiofehltbeep"]
					if SkuOptions.db then

						if SkuOptions.db.realm.missingAudio == nil then
							SkuOptions.db.realm.missingAudio = {}
						end
						if not SkuOptions.db.realm.missingAudio[tStrings[x]] then
							SkuOptions.db.realm.missingAudio[tStrings[x]] = 1
						else
							SkuOptions.db.realm.missingAudio[tStrings[x]] = SkuOptions.db.realm.missingAudio[tStrings[x]] + 1
						end

					end
				end
			else
				tFile = SkuAudioFileIndex[tStrings[x]]
			end
			if tFile then
				if tFile ~= "" then
					local tLength = SkuAudioDataLenIndex[tFile] or aLength

					--if isMulti == true then
						--tLength = tLength - ((100 - tonumber(SkuOptions.db.profile["SkuOptions"].TTSSepPause)) / 100) -- - 0.15
					--end


					tFile = "Interface\\AddOns\\"..Sku.AudiodataPath.."\\assets\\audio\\"..tFile
					aOverwrite = aOverwrite or false
					aWait = aWait or false
					tLength = tLength or 0
					if x == 1 then
						--[[if overwrite == true then
							for i = 1, table.getn(SkuVoiceQueue) do
								if SkuVoiceQueue[i].soundHandle then
									StopSound(SkuVoiceQueue[i].soundHandle)
								end
							end
							SkuVoiceQueue = {}
						end]]
					end

					--dprint(tFile)

					if aInstant == true then
						table.insert(mSkuVoiceQueue, 0 + x, {
							["text"] = tStrings[x],
							["file"] = tFile,
							["wait"] = aWait,
							["length"] = tLength,
							["endTimestamp"] = 0,
							["soundHandle"] = nil,
							["doNotOverwrite"] = aDoNotOverwrite or false,
							["soundChannel"] = aSoundChannel,
							["dnq"] = aDnQ,
						})
					else
						table.insert(mSkuVoiceQueue, {
							["text"] = tStrings[x],
							["file"] = tFile,
							["wait"] = aWait,
							["length"] = tLength,
							["endTimestamp"] = 0,
							["soundHandle"] = nil,
							["doNotOverwrite"] = aDoNotOverwrite or false,
							["soundChannel"] = aSoundChannel,
							["dnq"] = aDnQ,
						})
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:CollectString(aString, aOverwrite, aWait, aLength, aDoNotOverwrite, aIsMulti, aSoundChannel) -- for strings with lookup in string index
	--dprint(aString)
	if not aString then
		return
	end
	aIsMulti = aIsMulti or false
	if string.find(aString, ";") then
		aIsMulti = true
	end

	if not aString or not SkuAudioDataLenIndex or not SkuAudioFileIndex then
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
						table.insert(tStrings, L["Komma"])
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

	for x = 1, #tStrings do
		local tFile = SkuAudioFileIndex[tostring(tStrings[x])]

		if tFile == nil then
			local tModString = string.lower(tostring(tStrings[x]))
			tFile = SkuAudioFileIndex[tModString]
		end
		if tFile == nil then
			local tModString = string.upper(string.sub(tostring(tStrings[x]),1,1))..string.sub(tostring(tStrings[x]),2)
			tFile = SkuAudioFileIndex[tModString]
		end
		if tFile == nil then
			tFile = SkuAudioFileIndex["sound-audiofehltbeep"]
			if SkuOptions.db then

				if SkuOptions.db.realm.missingAudio == nil then
					SkuOptions.db.realm.missingAudio = {}
				end
				if not SkuOptions.db.realm.missingAudio[tStrings[x]] then
					SkuOptions.db.realm.missingAudio[tStrings[x]] = 1
				else
					SkuOptions.db.realm.missingAudio[tStrings[x]] = SkuOptions.db.realm.missingAudio[tStrings[x]] + 1
				end

			end
		end
	end
end

---------------------------------------------------------------------------------------------------------
function SkuVoice:StopOutputEmptyQueue(aBlizz, aSku)
	if SkuOptions.db.profile["SkuChat"].neverResetQueues == true then
		return
	end

	if not aBlizz and not aSku then
		aBlizz, aSku = true, true
	end
	if aSku then
		for i = 1, table.getn(mSkuVoiceQueue) do
			if mSkuVoiceQueue[i] then
				if mSkuVoiceQueue[i].soundHandle then
					StopSound(mSkuVoiceQueue[i].soundHandle)
				end
			end
		end
		mSkuVoiceQueue = {}
	end
	if aBlizz then
		mSkuVoiceQueueBTTS_Speaking = {}
		C_VoiceChat.StopSpeakingText()
	end
end
--[[
---------------------------------------------------------------------------------------------------------
function SkuVoice:StopAllOutputs()
	--print("StopAllOutputs")
	for i = 1, table.getn(mSkuVoiceQueue) do
		if mSkuVoiceQueue[i] then
			if mSkuVoiceQueue[i].soundHandle then
				StopSound(mSkuVoiceQueue[i].soundHandle, 0)
			end
		end
	end
	mSkuVoiceQueue = {}
	mSkuVoiceQueueBTTS_Speaking = {}
	if IsMacClient() == true then
		table.insert(mSkuVoiceQueueBTTS_Speaking, tValue)
		C_VoiceChat.StopSpeakingText()
	else
		table.insert(mSkuVoiceQueueBTTS_Speaking, tValue)
		C_VoiceChat.StopSpeakingText()
	end	
end
]]
---------------------------------------------------------------------------------------------------------
function SkuVoice:Release()

end

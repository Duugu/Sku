---@diagnostic disable: undefined-field
local SkuTTS_MAJOR, SkuTTS_MINOR = "SkuTTS-1.0", 1
local SkuTTS, oldminor = LibStub:NewLibrary(SkuTTS_MAJOR, SkuTTS_MINOR)

local L = Sku.L

local LSM = LibStub("LibSharedMedia-3.0")

if not SkuTTS then return end -- No upgrade needed

local slower = string.lower

SkuTTS.MainFrame = nil
SkuTTS.CloseAt = 0
SkuTTS.AutoReadEventFlag = nil
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:Create()
	LSM:Register("font", "Playfair", [[Interface\AddOns\SkuCore\Libs\SkuTTS-1.0\fonts\PlayfairDisplay-Regular.ttf]])
	LSM:Register("font", "Raleway", [[Interface\AddOns\SkuCore\Libs\SkuTTS-1.0\fonts\Raleway-Regular.ttf]])

	local f = CreateFrame("Frame", "SkuTTSMainFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	local ttime = 0

	f:SetScript("OnEvent", function(self, event)
      if event == "VOICE_CHAT_TTS_PLAYBACK_FINISHED" then
			if SkuTTS.AutoReadMode == true and SkuTTS.AutoReadEventFlag == true then
				SkuTTS:ReadNextAutoRead()
			end
			if SkuTTS.AutoReadEventFlag ~= true then
				SkuTTS.AutoReadEventFlag = true
			end
		end
	end)
	f:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FINISHED")

	f:SetScript("OnUpdate", function(self, time) 
		ttime = ttime + time 
		if ttime > 0.25 then 
			if SkuTTS.MainFrame:IsVisible() and (GetTime() > SkuTTS.CloseAt) and SkuTTS.CloseAt ~= -1 then
				SkuTTS:Hide()
			end
			if SkuTTS.MainFrame:IsVisible() and SkuTTS.CloseAt == -1 then
				SkuTTS:Hide()
			end
			ttime = 0
		end
	end)
	f:SetFrameStrata("TOOLTIP")
	f:SetFrameLevel(129)
	f:SetAllPoints()
	f:SetBackdrop({
		bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 32,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	f:SetBackdropColor(0, 0, 0, 0.75)
	f:SetClampedToScreen(true)
	
	SkuTTS.MainFrame = f
	
	SkuTTS.MainFrame:Hide()
	
	local fs = f:CreateFontString("SkuTTSMainFrameFS")
	fs:SetFontObject(GameFontNormalSmall)
	fs:SetFont(LSM:Fetch("font", "Playfair"), 12, "")
	fs:SetTextColor(1, 1, 1, 1)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	fs:SetAllPoints()
	SkuTTS.MainFrame.FS = fs
	
	return SkuTTS
end

---------------------------------------------------------------------------------------------------------------------
local currentLine = 1
local currentSection = 1
sections = {}
function SkuTTS:NextSection(aEngine, aReset)
	--print("NextSection", currentSection, currentLine)	
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentSection < #sections then
			currentSection = currentSection + 1
			currentLine = 1
		end
		SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:PreviousSection(aEngine, aReset)
	--print("PreviousSection", currentSection, currentLine)	
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentSection > 1 then
			currentSection = currentSection - 1
			currentLine = 1
		end
		SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:ReadNextAutoRead()
	--print("ReadNextAutoRead", currentSection , #sections , currentLine , #sections[currentSection], SkuTTS.AutoReadMode)
	if SkuTTS.AutoReadMode == true then
		if currentSection < #sections or (currentSection == #sections and currentLine < #sections[currentSection]) then
			SkuTTS:NextLine(1)
		else
			SkuTTS.AutoReadMode = nil
			SkuTTS.AutoReadEventFlag = nil
			SkuTTS:Hide()
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:IsAutoRead()
	return SkuTTS.AutoReadMode
end
--------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:ToggleAutoRead(aEngine, aReset)
	--print("ToggleAutoRead", currentSection, currentLine)
	if SkuTTS.MainFrame:IsVisible() == true then
		if SkuTTS.AutoReadMode ~= true then
			SkuTTS.AutoReadEventFlag = nil
			SkuTTS.AutoReadMode = true
			SkuTTS.AutoReadEventFlag = nil
			SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
			C_Timer.After(0.6, function()
				SkuTTS.AutoReadEventFlag = true
				SkuTTS:CurrentLine(aEngine, false)
			end)
		else
			SkuTTS.AutoReadMode = nil
			SkuTTS.AutoReadEventFlag = nil
			--SkuOptions.Voice:StopOutputEmptyQueue()
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:CurrentLine(aEngine, aReset)
	--print("CurrentLine", currentSection, currentLine)	
	if SkuTTS.MainFrame:IsVisible() == true then
		SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:NextLine(aEngine, aReset)
	--print("NextLine", currentSection, currentLine)	
	if SkuTTS.MainFrame:IsVisible() == true then
		--SkuTTS:ReadLineNumber(currentSection, currentLine, nil, aEngine)
		if currentLine < #sections[currentSection] then
			currentLine = currentLine + 1
		elseif currentSection < #sections then
			currentSection = currentSection + 1
			currentLine = 1
		end
		SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:PreviousLine(aEngine, aReset)
	--print("PreviousLine", currentSection, currentLine)		
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentLine > 1 then
			currentLine = currentLine - 1
		elseif currentLine <= 1 then
			if currentSection > 1 then
				currentSection = currentSection - 1
				currentLine = #sections[currentSection]
			end
		end
		SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:NextLink(aEngine, aReset)
	if SkuTTS.MainFrame:IsVisible() == true then
		SkuTTS:ReadLinkNumber(SkuOptions.currentMenuPosition.linksSelected, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:PreviousLink(aEngine, aReset)
	if SkuTTS.MainFrame:IsVisible() == true then
		SkuTTS:ReadLinkNumber(SkuOptions.currentMenuPosition.linksSelected, aReset, aEngine)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:ReadLinkNumber(aLinkNumber, aNoReset, aEngine)
	if  aNoReset == nil then aNoReset = true end
	if SkuTTS.MainFrame:IsVisible() == true then
		if (SkuOptions.currentMenuPosition.links) then
			if SkuOptions.currentMenuPosition.links[aLinkNumber] then
				--if not aEngine then
					--SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.links[aLinkNumber], aNoReset, true)
				--else
					SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.links[aLinkNumber], aNoReset, true, nil, nil, false, nil, 1)
				--end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:IsLinkInLinkList(aLinkName, aLinkList)
	--check if we're currrently showing that link
	if not SkuOptions.currentMenuPosition then
		return
	end
	if SkuOptions.currentMenuPosition.currentLinkName then
		if SkuOptions.currentMenuPosition.currentLinkName ~= "" then
			if slower(SkuOptions.currentMenuPosition.currentLinkName) == slower(aLinkName) then
				return true
			end
		end
	end
	--check if that link already is in the list
	for x = 1, #aLinkList do
		if slower(aLinkList[x]) == slower(aLinkName) then
			return true
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:GetLinksTableFromString(aString, aCurrentLinkText, aDontSearchForLinks)
	local tLinks = {}

	if string.find(aString, "%[%[") then
		--this is a wiki page (line) with pre-build links; find links via markup
		for k, v in aString:gmatch("%[%[[^%]]+%]%]") do 
			local tLinkName = string.sub(k, 3, string.len(k) - 2)
			local tPos = string.find(tLinkName, "|")
			if tPos then
				tLinkName = string.sub(tLinkName, 1, tPos - 1)
			end

			local tStringLower = slower(tLinkName)
			if slower(aCurrentLinkText) ~= tStringLower then
				if SkuDB.Wiki[Sku.Loc].lookup[tStringLower]  then
					if not SkuTTS:IsLinkInLinkList(tLinkName, tLinks) then
						tLinks[#tLinks + 1] = tLinkName
						SkuAdventureGuide:AddLinkToHistory(tLinkName)
					end
				end
			end
		end
	else
		if not aDontSearchForLinks then
			--just a usual tooltip page; find links in free text
			local tStringLower = slower(aString)
			tStringLower = " "..tStringLower.." "
			tStringLower = string.gsub(tStringLower, "%.", " ")
			tStringLower = string.gsub(tStringLower, ",", " ")
			tStringLower = string.gsub(tStringLower, "%?", " ")
			tStringLower = string.gsub(tStringLower, "!", " ")
			tStringLower = string.gsub(tStringLower, "|", " ")
			tStringLower = string.gsub(tStringLower, "%[", " ")
			tStringLower = string.gsub(tStringLower, "%]", " ")
			tStringLower = string.gsub(tStringLower, "%+", " ")
			tStringLower = string.gsub(tStringLower, "%*", " ")
			tStringLower = string.gsub(tStringLower, "#", " ")
			tStringLower = string.gsub(tStringLower, "%%", " ")
			tStringLower = string.gsub(tStringLower, "\\", " ")
			tStringLower = string.gsub(tStringLower, "%(", " ")
			tStringLower = string.gsub(tStringLower, "%)", " ")
			tStringLower = string.gsub(tStringLower, "=", " ")
			tStringLower = string.gsub(tStringLower, "<", " ")
			tStringLower = string.gsub(tStringLower, ">", " ")
			tStringLower = string.gsub(tStringLower, " 	", " ")
			tStringLower = string.gsub(tStringLower, "   ", " ")
			tStringLower = string.gsub(tStringLower, "  ", " ")
			tStringLower = string.gsub(tStringLower, "  ", " ")
			tStringLower = string.gsub(tStringLower, "  ", " ")

			if SkuDB.Wiki[Sku.Loc].lookupLen then
				for x = 1, #SkuDB.Wiki[Sku.Loc].lookupLen do
					if string.find(tStringLower, " "..SkuDB.Wiki[Sku.Loc].lookupLen[x].." ") then
						if not SkuTTS:IsLinkInLinkList(SkuDB.Wiki[Sku.Loc].lookupLen[x], tLinks) then
							tLinks[#tLinks + 1] = SkuDB.Wiki[Sku.Loc].lookupLen[x]
							SkuAdventureGuide:AddLinkToHistory(SkuDB.Wiki[Sku.Loc].lookupLen[x])
							tStringLower = string.gsub(tStringLower, SkuDB.Wiki[Sku.Loc].lookupLen[x], "")
						end
					end
					if not string.find(tStringLower, "[^%s]") then
						break
					end
				end
			end	
		end
	end

	return tLinks
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuTTS:ReadLineNumber(aSectionNumber, aLineNumber, aNoReset, aEngine)
	--print("ReadLineNumber, aSectionNumber, aLineNumber", aSectionNumber, aLineNumber)	
	if aNoReset == nil then aNoReset = true end
	if SkuTTS.MainFrame:IsVisible() == true then
		aSectionNumber, aLineNumber = aSectionNumber or currentSection, aLineNumber or currentLine
		if (sections[aSectionNumber]) then
			if sections[aSectionNumber][aLineNumber] then
				--don't add links to the tooltip title if this is a wiki page
				if not SkuOptions.currentMenuPosition then
					SkuOptions.currentMenuPosition = {}
				end

				local tNoLinksPlease = SkuOptions.currentMenuPosition.parent
				if tNoLinksPlease then
					tNoLinksPlease = SkuOptions.currentMenuPosition.parent.name ~= L["All entries"]
				end

				if (aSectionNumber ~= 1 or aLineNumber ~= 1) == true or (not SkuOptions.currentMenuPosition.linksHistory and tNoLinksPlease == true) == true then
					if SkuOptions.currentMenuPosition.linksHistory then
						--this is a wiki page that was selected by the player. thus it must have markup. only use markup
						SkuOptions.currentMenuPosition.links = SkuTTS:GetLinksTableFromString(sections[aSectionNumber][aLineNumber], sections[1][1], true)
					else
						SkuOptions.currentMenuPosition.links = SkuTTS:GetLinksTableFromString(sections[aSectionNumber][aLineNumber], sections[1][1])
					end

					if #SkuOptions.currentMenuPosition.links > 0 then
						if SkuOptions.db.profile["SkuAdventureGuide"].links.enableLinksInTooltips == true then
							if SkuTTS:IsAutoRead() ~= true then
								local tOrg = sections[aSectionNumber][aLineNumber]
								if string.find(sections[aSectionNumber][aLineNumber], "§") then
									tOrg = string.sub(sections[aSectionNumber][aLineNumber], 0, string.find(sections[aSectionNumber][aLineNumber], "§")  -1)
								end
								if SkuOptions.db.profile["SkuAdventureGuide"].links.tooltipLinksIndicator ~= "sound" then
									sections[aSectionNumber][aLineNumber] = tOrg.."§".." : "..L["Links:"]..";"
								else
									SkuAdventureGuide:PlaySound(SkuAdventureGuide.HistoryNotifySounds[SkuOptions.db.profile["SkuAdventureGuide"].history.soundOnNewLinkInHistory])
									sections[aSectionNumber][aLineNumber] = tOrg.."§; ;"
								end
								for x = 1, #SkuOptions.currentMenuPosition.links do
									sections[aSectionNumber][aLineNumber] = sections[aSectionNumber][aLineNumber]..SkuOptions.currentMenuPosition.links[x]..";"
								end
							else
								if string.find(sections[aSectionNumber][aLineNumber], "§") then
									sections[aSectionNumber][aLineNumber] = string.sub(sections[aSectionNumber][aLineNumber], 0, string.find(sections[aSectionNumber][aLineNumber], "§")  -1)
								end
							end
						end
					end
				end

				-- remove markup tags before output
				local tCleanOutput = string.gsub(sections[aSectionNumber][aLineNumber], "%[%[", "")
				tCleanOutput = string.gsub(tCleanOutput, "|[^%]]+%]%]", "")
				tCleanOutput = string.gsub(tCleanOutput, "%]%]", "")

				--if not aEngine then
					--SkuOptions.Voice:OutputStringBTtts(tCleanOutput, aNoReset, true)
				--else
					SkuOptions.Voice:OutputStringBTtts(tCleanOutput, aNoReset, true, nil, nil, false, nil, 1)
				--end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------
function SkuTTS:Output(text, duration)
	--print("SkuTTS:Output")
	if type(text) == "function" then
		text = text()
	end

	currentLine = 1
	currentSection = 1

	--split text to sections
	sections = {}
	local tSections = {}

	if type(text) == "string" then
		tSections = {text}
	else
		tSections = text
	end

	for i, v in pairs(tSections) do
		local tBuildSection = {}
		if v ~= "" and  v ~= "\r\n" and v ~= " \r\n" then
			if string.find(v, "\r\n") then
				local sep = "\r\n"
				if type(v) == "string" then
					local tTv = string.gsub(v, "\r\n \r\n", "\r\n")
					tTv = string.gsub(tTv, "\r\n\r\n", "\r\n")
					local pattern = string.format("([^%s]+)", sep)
					tTv:gsub(pattern, function(c) 
						if c ~= "\r" then
							tBuildSection[#tBuildSection+1] = c
						end
					end)
				else
					tBuildSection = {v}
				end
			else
				tBuildSection = {v}
			end
			table.insert(sections, tBuildSection)
		end
	end

	--build string to show from sections
	text = "\n\n"
	for i, v in pairs(sections) do
		for i1, v1 in pairs(v) do
			--dprint(i, i1)
			text = text.."\n"..v1
		end
		text = text.."\n"
	end

	--show it
	duration = duration or 1
	SkuTTS.MainFrame.FS:SetText(text)
	if duration > 0 then
		if SkuTTS.MainFrame:IsVisible() == false then
			--SkuOptions.Voice:OutputString("sound-on3_1")
			SkuOptions.Voice:OutputString("sound-on3_1", true, true, 0.2, true)
			SkuTTS.MainFrame:Show()
		end
	end
	if duration == -1 then
		SkuTTS.CloseAt = -1
	else
		SkuTTS.CloseAt = GetTime() + duration
	end
	
end
function SkuTTS:Hide()
	--print("SkuTTS:Hide")
	--SkuTTS.MainFrame.FS:SetText("")
	if SkuTTS.MainFrame:IsVisible() == true then
		SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
		SkuOptions.Voice:OutputString("sound-off2", true, true, 0.2)
	end
	SkuTTS.MainFrame:Hide()
	SkuTTS.AutoReadMode = nil
end

function SkuTTS:Release()

end

function SkuTTS:IsVisible()
	return SkuTTS.MainFrame:IsVisible()
end




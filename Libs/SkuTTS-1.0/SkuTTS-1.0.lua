---@diagnostic disable: undefined-field
local SkuTTS_MAJOR, SkuTTS_MINOR = "SkuTTS-1.0", 1
local SkuTTS, oldminor = LibStub:NewLibrary(SkuTTS_MAJOR, SkuTTS_MINOR)

local LSM = LibStub("LibSharedMedia-3.0")

if not SkuTTS then return end -- No upgrade needed

SkuTTS.MainFrame = nil
SkuTTS.CloseAt = 0
function SkuTTS:Create()
	LSM:Register("font", "Playfair", [[Interface\AddOns\SkuCore\Libs\SkuTTS-1.0\fonts\PlayfairDisplay-Regular.ttf]])
	LSM:Register("font", "Raleway", [[Interface\AddOns\SkuCore\Libs\SkuTTS-1.0\fonts\Raleway-Regular.ttf]])

	local f = CreateFrame("Frame", "SkuTTSMainFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	local ttime = 0
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
	f:SetBackdropColor(0, 0, 0, 1)
	f:SetClampedToScreen(true)
	
	SkuTTS.MainFrame = f
	
	SkuTTS.MainFrame:Hide()
	
	local fs = f:CreateFontString("SkuTTSMainFrameFS")
	fs:SetFontObject(SystemFont_Huge1)
	fs:SetFont(LSM:Fetch("font", "Playfair"), 18, "")
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
local sections = {}
function SkuTTS:NextSection(aEngine, aReset)
	--dprint("NextSection")	
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentSection < #sections then
			currentSection = currentSection + 1
			currentLine = 1
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		else
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		end
	end
end
function SkuTTS:PreviousSection(aEngine, aReset)
	--dprint("PreviousSection")	
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentSection > 1 then
			currentSection = currentSection - 1
			currentLine = 1
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		else
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		end
	end
end
function SkuTTS:NextLine(aEngine, aReset)
	--dprint("NextLine")	
	if SkuTTS.MainFrame:IsVisible() == true then
		--SkuTTS:ReadLineNumber(currentSection, currentLine, nil, aEngine)
		if currentLine < #sections[currentSection] then
			currentLine = currentLine + 1
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		elseif currentSection < #sections then
				currentSection = currentSection + 1
				currentLine = 1
				SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		else
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		end
	end
end
function SkuTTS:PreviousLine(aEngine, aReset)
	--dprint("PreviousLine", currentSection, currentLine)		
	if SkuTTS.MainFrame:IsVisible() == true then
		if currentLine > 1 then
			currentLine = currentLine - 1
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		elseif currentLine <= 1 then
				if currentSection > 1 then
					currentSection = currentSection - 1
					currentLine = #sections[currentSection]
				end
				SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		else
			SkuTTS:ReadLineNumber(currentSection, currentLine, aReset, aEngine)
		end
	end
end
function SkuTTS:ReadLineNumber(aSectionNumber, aLineNumber, aNoReset, aEngine)
	--dprint("ReadLineNumber", aSectionNumber, aLineNumber, aNoReset, aEngine)
	if  aNoReset == nil then aNoReset = true end
	if SkuTTS.MainFrame:IsVisible() == true then
		aSectionNumber, aLineNumber = aSectionNumber or currentSection, aLineNumber or currentLine
		if (sections[aSectionNumber]) then
			if sections[aSectionNumber][aLineNumber] then
				if not aEngine then
					SkuOptions.Voice:OutputString(sections[aSectionNumber][aLineNumber], aNoReset, true)
				else
					--SkuOptions.Voice:OutputString(" ", true)
					SkuOptions.Voice:OutputString(sections[aSectionNumber][aLineNumber], aNoReset, true, nil, nil, false, nil, aEngine)
				end
			end
		end
	end
end
--[[
function SkuTTS:IsVisible()
	if SkuTTS.MainFrame:IsVisible() == true then
		return true
	end
end
]]
---------------------------------------------------------------------------------------------------------------------
function SkuTTS:Output(text, duration) --string, integer
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
		if v ~= "" then
			if string.find(v, "\r\n") then
				local sep = "\r\n"
				if type(v) == "string" then
					local pattern = string.format("([^%s]+)", sep)
					v:gsub(pattern, function(c) 
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
		end
		table.insert(sections, tBuildSection)
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
	--SkuTTS.MainFrame.FS:SetText("")
	if SkuTTS.MainFrame:IsVisible() == true then
		SkuOptions.Voice:OutputString("sound-off2", true, true, 0.2)
	end
	SkuTTS.MainFrame:Hide()
end

function SkuTTS:Release()

end

function SkuTTS:IsVisible()
	return SkuTTS.MainFrame:IsVisible()
end




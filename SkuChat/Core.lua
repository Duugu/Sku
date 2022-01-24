local MODULE_NAME = "SkuChat"
local _G = _G
local L = Sku.L

SkuChat = LibStub("AceAddon-3.0"):NewAddon("SkuChat", "AceConsole-3.0", "AceEvent-3.0")

SkuChatChatBuffer = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnInitialize()
	SkuChat:RegisterEvent("PLAYER_LOGIN")
	SkuChat:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuChat:RegisterEvent("PLAYER_REGEN_DISABLED")
	SkuChat:RegisterEvent("PLAYER_REGEN_ENABLED")
	SkuChat:RegisterEvent("CHAT_MSG_WHISPER")

	SkuChat.hooked = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnEnable()
	if SkuCore.inCombat == true then
		return
	end
	
	local b = _G["OnSkuChatToggle"] or CreateFrame("Button", "OnSkuChatToggle", UIParent, "UIPanelButtonTemplate")
	b:SetSize(80, 22)
	b:SetText("OnSkuChatToggle")
	b:SetPoint("CENTER")
	--b:SetScript("OnClick", SkuChat.OnSkuChatToggle)
	b:SetScript("OnClick", function(self, a, b)
		--dprint(a)
		if a == "LeftButton" or a == "ESCAPE" then
			C_VoiceChat.StopSpeakingText()
			SkuChat.OnSkuChatToggle()
			return
		end
		--dprint(SkuOptions.ChatCurrentLine)
		if not SkuChatChatBuffer[SkuOptions.ChatCurrentLine] then return end
		if not SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body then return end

		if SkuOptions.ChatOpen ~= true then return end

		if a == "Down" then
			SkuOptions.ChatCurrentLine = SkuOptions.ChatCurrentLine - 1
			if SkuOptions.ChatCurrentLine < 1 then
				SkuOptions.ChatCurrentLine = 1
			end
		elseif a == "Up" then
			SkuOptions.ChatCurrentLine = SkuOptions.ChatCurrentLine + 1
			if SkuOptions.ChatCurrentLine > table.getn(SkuChatChatBuffer) then
				SkuOptions.ChatCurrentLine = table.getn(SkuChatChatBuffer)
			end
		end

		if IsMacClient() == true then
			C_VoiceChat.StopSpeakingText()
			C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, (table.getn(SkuChatChatBuffer) - SkuOptions.ChatCurrentLine + 1).." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body.." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].timestamp, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
		else
			C_VoiceChat.StopSpeakingText()
			C_Timer.After(0.05, function() 
				C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, (table.getn(SkuChatChatBuffer) - SkuOptions.ChatCurrentLine + 1).." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body.." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].timestamp, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
			end)
		end
	end)
	b:Hide()

	b:SetScript("OnShow", function(self)
		--SetOverrideBindingClick(self, true, "ESCAPE", "OnSkuChatToggle", "ESCAPE")
	end)
	b:SetScript("OnHide", function(self)
		--ClearOverrideBindings(self)
	end)

	SetBindingClick("SHIFT-F2", b:GetName())
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnDisable()
	
end

---------------------------------------------------------------------------------------------------------------------------------------
local function unescape(String)
	local Result = tostring(String)
	Result = gsub(Result, "|c........", "") -- Remove color start.
	Result = gsub(Result, "|r", "") -- Remove color end.
	Result = gsub(Result, "|H.-|h(.-)|h", "%1") -- Remove links.
	Result = gsub(Result, "|T.-|t", "") -- Remove textures.
	Result = gsub(Result, "{.-}", "") -- Remove raid target icons.
	return Result
end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuChatNewLineInCombat = false
SkuChat.inCombat = false
function SkuChat:ChatFrame1AddMessageHook(...)
	local body = ...--, infor, infog, infob, infoid, accessID, typeID = ...
	if body then
		body = unescape(body)

		local h, m = GetGameTime()

		table.insert(SkuChatChatBuffer, 
		{
			["timestamp"] = string.format("%02d:%02d",h,m),
			["body"] = body,
			["data"] = ...,
		})

		if table.getn(SkuChatChatBuffer) > 100 then
			table.remove(SkuChatChatBuffer, 1) 
		end
	end

	if SkuOptions.db.profile[MODULE_NAME].audio == true then
		if SkuChat.inCombat == true then
			SkuChatNewLineInCombat = true
		else
			SkuOptions.Voice:OutputString("sound-newChatLine", false, true, 0.1)

			--SkuOptions.Voice:CollectString(body, false, true)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:PLAYER_REGEN_DISABLED(...)
	SkuChat.inCombat = true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:PLAYER_REGEN_ENABLED(...)
	SkuChat.inCombat = false
	if SkuChatNewLineInCombat == true then
		SkuChat:ChatFrame1AddMessageHook()
		SkuChatNewLineInCombat = false
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnSkuChatToggle(a, b, c)
	if SkuCore.inCombat == true then
		return
	end
	
	if SkuOptions.TTS:IsVisible() then
		SkuOptions.ChatOpen = false
		SkuOptions.TTS:Output("", -1)
		ClearOverrideBindings(_G["OnSkuChatToggle"])
		return
	end
	
	if SkuChatChatBuffer then
		
		local tText = ""
		for x = 1, table.getn(SkuChatChatBuffer) do
			local tBlank = string.rep(" ", x)
			local tRep = SkuChatChatBuffer[x].body
			tRep = tRep:gsub("%[", "")
			tRep = tRep:gsub("%]", "") 
		
			tText = "  "..tBlank.." "..tRep.." - "..SkuChatChatBuffer[x].timestamp.."\r\n\r\n"..tText
		end
		SkuOptions.ChatOpen = true
		SkuOptions.TTS:Output("\r\n"..tText, 10000)

		SkuOptions.ChatCurrentLine = table.getn(SkuChatChatBuffer)
		if SkuChatChatBuffer[SkuOptions.ChatCurrentLine] then
			if SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body then
				if IsMacClient() == true then
					C_VoiceChat.StopSpeakingText()
					C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, (table.getn(SkuChatChatBuffer) - SkuOptions.ChatCurrentLine + 1).." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body.." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].timestamp, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
				else
					C_VoiceChat.StopSpeakingText()
					C_Timer.After(0.05, function() 
						C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, (table.getn(SkuChatChatBuffer) - SkuOptions.ChatCurrentLine + 1).." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].body.." - "..SkuChatChatBuffer[SkuOptions.ChatCurrentLine].timestamp, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
					end)
				end
			end
		end

	else
		SkuOptions.TTS:Output("", 10000)
		SkuOptions.ChatOpen = false
	end
	SetOverrideBindingClick(_G["OnSkuChatToggle"], true, "ESCAPE", "OnSkuChatToggle", "ESCAPE")
	SetOverrideBindingClick(_G["OnSkuChatToggle"], true, "Down", "OnSkuChatToggle", "Down")
	SetOverrideBindingClick(_G["OnSkuChatToggle"], true, "Up", "OnSkuChatToggle", "Up")
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:PLAYER_LOGIN(...)
	SkuChat.WowTtsVoices = {}
	for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
		SkuChat.WowTtsVoices[i] = v.name
	end
	SkuChat.options.args.WowTtsVoice.values = SkuChat.WowTtsVoices

	C_Timer.After(5, function()
		if SkuChat.hooked == false then
			SkuChat.hooked = true
			hooksecurefunc(ChatFrame1, "AddMessage", SkuChat.ChatFrame1AddMessageHook)
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:CHAT_MSG_WHISPER(aEvent, aMsgBody, aSenderName)
	if aMsgBody == "inv" then
		SkuChat.InvitePlayerName = aSenderName

		if string.find(SkuChat.InvitePlayerName, "-") then
			SkuChat.InvitePlayerName = string.sub(SkuChat.InvitePlayerName, 1, string.find(SkuChat.InvitePlayerName, "-") - 1)
		end

		local tSpeakText = aSenderName.." hat eine Einladung angefordert. Mit /sku invite einladen."
		if IsMacClient() == true then
			C_VoiceChat.StopSpeakingText()
			C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, tSpeakText, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
		else
			C_VoiceChat.StopSpeakingText()
			C_Timer.After(0.05, function() 
				C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, tSpeakText, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
			end)
		end

	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...
end


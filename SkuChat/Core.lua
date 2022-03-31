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
	local body, infor, infog, infob, infoid, accessID, typeID = ...
	if body then
		body = unescape(body)

		if string.sub(body, 3, 3) == "." then
			body = string.sub(body, 1,2).." "..string.sub(body, 4)
		end

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

	--SkuOptions.ChatCurrentLine = table.getn(SkuChatChatBuffer)

	if SkuChatChatBuffer[table.getn(SkuChatChatBuffer)] then
		if infor and infog and infob then
			infor, infog, infob = math.floor(infor * 100), math.floor(infog * 100), math.floor(infob * 100)
			if ((infor == 66 and infog == 66 and infob == 100) or (infor == 46 and infog == 78 and infob == 100) and SkuOptions.db.profile[MODULE_NAME].autoPlayPartyChat == true) or
				((infor == 25 and infog == 100 and infob == 25) and SkuOptions.db.profile[MODULE_NAME].autoPlayGuildChat == true) or
				((infor == 100 and infog == 50 and infob == 100) and SkuOptions.db.profile[MODULE_NAME].autoPlayTellChat == true) or
				(string.find(SkuChatChatBuffer[table.getn(SkuChatChatBuffer)].body, "SkuChat") and SkuOptions.db.profile[MODULE_NAME].autoPlaySkuChannelChat == true) or
				(
					(
						(infor == 100 and infog == 100 and infob == 62) or 
						(infor == 100 and infog == 50 and infob == 25) or 
						(infor == 100 and infog == 25 and infob == 25) or 
						(infor == 100 and infog == 70 and infob == 92) or 
						(infor == 100 and infog == 85 and infob == 0) or 
						(infor == 100 and infog == 85 and infob == 0)
					) and 
					SkuOptions.db.profile[MODULE_NAME].autoPlayCreatureChat == true
				)
			then
				local tPlayerName = UnitName("player")
				if not string.find(body, "%["..tPlayerName.."%]") then
					if SkuChatChatBuffer[table.getn(SkuChatChatBuffer)].body then
						if IsMacClient() == true then
							--C_VoiceChat.StopSpeakingText()
							C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, SkuChatChatBuffer[table.getn(SkuChatChatBuffer)].body, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
						else
							--C_VoiceChat.StopSpeakingText()
							C_Timer.After(0.05, function() 
								C_VoiceChat.SpeakText(SkuOptions.db.profile["SkuChat"].WowTtsVoice - 1, SkuChatChatBuffer[table.getn(SkuChatChatBuffer)].body, 4, SkuOptions.db.profile[MODULE_NAME].WowTtsSpeed, SkuOptions.db.profile[MODULE_NAME].WowTtsVolume)
							end)
						end
					end
				end
			end
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

		local tSpeakText = aSenderName..L[" hat eine Einladung angefordert. Mit /sku invite einladen."]
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
function SkuChat:JoinOrLeaveSkuChatChannel()
	local id, name, instanceID, isCommunitiesChannel = GetChannelName("SkuChat")

	if SkuOptions.db.profile["SkuChat"].joinSkuChannel == true then
		if id == 0 then
			JoinPermanentChannel("SkuChat", nil, FCF_GetCurrentChatFrame():GetID())
			ChatFrame_AddChannel(ChatFrame1, "SkuChat")
		end
	else
		if id ~= 0 then
			LeaveChannelByName("SkuChat")
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local ChatFrame1EditBoxIsShown = false
function SkuChat:ChatFrame1EditBoxOnShow()
	if ChatFrame1EditBoxIsShown == false  then
		ChatFrame1EditBoxIsShown = true
		PlaySoundFile("Interface\\AddOns\\Sku\\SkuChat\\assets\\audio\\chateditbox_open.mp3", "Talking Head")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:ChatFrame1EditBoxOnHide()
	if ChatFrame1EditBoxIsShown == true  then
		ChatFrame1EditBoxIsShown = false
		PlaySoundFile("Interface\\AddOns\\Sku\\SkuChat\\assets\\audio\\chateditbox_close.mp3", "Talking Head")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuChatEditboxHookFlag = false
function SkuChat:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...

	ChatFrame1:HookScript("OnShow", function(self)
		C_Timer.After(5, function()
			SkuChat:JoinOrLeaveSkuChatChannel()
		end)
	end)

	ChatFrame1EditBox:HookScript("OnTextChanged", function(self, a, b, c)
		if SkuChatEditboxHookFlag == false then
			local tCurrentText = ChatFrame1EditBox:GetText() or ""
			tCurrentText = string.lower(tCurrentText)
			if tCurrentText == "/skuchat" then
				SkuChat:SetEditboxToSkuChat("")
			end
		end
	end)

	hooksecurefunc(ChatFrame1EditBox, "Show", SkuChat.ChatFrame1EditBoxOnShow)
	hooksecurefunc(ChatFrame1EditBox, "Hide", SkuChat.ChatFrame1EditBoxOnHide)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:SetEditboxToSkuChat(aMsg)
	SkuChatEditboxHookFlag = true
	local channelNum, channelName = GetChannelName("SkuChat")
	ChatFrame1EditBox:SetAttribute("channelTarget", channelNum)
	ChatFrame1EditBox:SetAttribute("chatType", "CHANNEL")
	ChatFrame1EditBox:SetText(aMsg)
	ChatEdit_UpdateHeader(ChatFrame1EditBox)
	SkuChatEditboxHookFlag = false
end
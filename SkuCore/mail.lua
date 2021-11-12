---@diagnostic disable: undefined-doc-name

local MODULE_NAME = "SkuCore"
SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")
local L = Sku.L

local gLastError = ""
------------------------------------------------------------------------------------------------------------
function SkuCore:MailOnInitialize()
	SkuCore:RegisterEvent("MAIL_SHOW")
	SkuCore:RegisterEvent("MAIL_INBOX_UPDATE")
	SkuCore:RegisterEvent("MAIL_CLOSED")
	SkuCore:RegisterEvent("MAIL_SEND_INFO_UPDATE")
	SkuCore:RegisterEvent("MAIL_SEND_SUCCESS")
	SkuCore:RegisterEvent("MAIL_FAILED")
	SkuCore:RegisterEvent("MAIL_SUCCESS")
	SkuCore:RegisterEvent("CLOSE_INBOX_ITEM")
	SkuCore:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
	SkuCore:RegisterEvent("MAIL_UNLOCK_SEND_ITEMS")

   hooksecurefunc(UIErrorsFrame, "AddMessage", function(self, text, r, g, b, messageGroup, holdTime)
      gLastError = text
	end)
end

------------------------------------------------------------------------------------------------------------
local MailboxOpenFlag = false
function SkuCore:MAIL_SHOW(...)
   --print("MAIL_SHOW", ...)
   MailboxOpenFlag = true
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_INBOX_UPDATE(...)
   --print("MAIL_INBOX_UPDATE", ...)
   if MailboxOpenFlag == true then
      SkuOptions:SlashFunc(L["short"]..",SkuCore,"..L["Mail"])
      --MailboxOpenFlag = false
   end
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_CLOSED(...)
   --print("MAIL_CLOSED", ...)
   if #SkuOptions.Menu == 0 or _G["OnSkuOptionsMain"]:IsVisible() == false then
      _G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], "SHIFT-F1")
   end
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SEND_INFO_UPDATE(...)
   --print("MAIL_SEND_INFO_UPDATE", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SEND_SUCCESS(...)
   --print("MAIL_SEND_SUCCESS", ...)
   SkuOptions.Voice:OutputString(L["Sent"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SUCCESS(...)
   --print("MAIL_SUCCESS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:CLOSE_INBOX_ITEM(...)
   --print("CLOSE_INBOX_ITEM", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_LOCK_SEND_ITEMS(...)
   --print("MAIL_LOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_UNLOCK_SEND_ITEMS(...)
   --print("MAIL_UNLOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_UNLOCK_SEND_ITEMS(...)
   --print("MAIL_UNLOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_FAILED(...)
   --print("MAIL_FAILED", ...)
   SkuOptions.Voice:OutputString(L["Send failed"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
   SkuOptions.Voice:OutputString(gLastError, false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MailEditor(aTargetValue)
	PlaySound(88)
	SkuOptions.Voice:OutputString(L["Enter text and press ENTER key"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int

	--SkuOptions:EditBoxPasteShow("", function(self)
   SkuOptions:EditBoxShow(" ", function(self)
		PlaySound(89)
      local tText = SkuOptionsEditBoxEditBox:GetText()
      SkuOptions.currentMenuPosition[aTargetValue] = tText
      if not SkuOptions.currentMenuPosition.TmpTo then
         SkuOptions.Voice:OutputString(L["No recepient"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
      end
      if not SkuOptions.currentMenuPosition.TmpSubject then
         SkuOptions.Voice:OutputString(L["Topic missing"], false, true, 0.2)-- file: string, reset: bool, wait: bool, length: int
      end

	end)
end

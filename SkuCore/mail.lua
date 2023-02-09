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
   SkuOptions:SlashFunc(L["short"]..",Core,"..L["Mail"])
   MailboxOpenFlag = true
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_INBOX_UPDATE(...)
   --print("MAIL_INBOX_UPDATE", ...)
   if MailboxOpenFlag == true then
      if SkuOptions.currentMenuPosition then
         SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
      else
         SkuOptions:SlashFunc(L["short"]..",Core,"..L["Mail"])
      end
   end
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_CLOSED(...)
   --dprint("MAIL_CLOSED", ...)
   if #SkuOptions.Menu == 0 or SkuOptions:IsMenuOpen() == false then
      _G["OnSkuOptionsMain"]:GetScript("OnClick")(_G["OnSkuOptionsMain"], SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_OPENMENU"].key)
   end
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SEND_INFO_UPDATE(...)
   --dprint("MAIL_SEND_INFO_UPDATE", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SEND_SUCCESS(...)
   --dprint("MAIL_SEND_SUCCESS", ...)
   SkuOptions.Voice:OutputStringBTtts(L["Sent"], false, true, 0.2)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_SUCCESS(...)
   --dprint("MAIL_SUCCESS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:CLOSE_INBOX_ITEM(...)
   --dprint("CLOSE_INBOX_ITEM", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_LOCK_SEND_ITEMS(...)
   --dprint("MAIL_LOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_UNLOCK_SEND_ITEMS(...)
   --dprint("MAIL_UNLOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_UNLOCK_SEND_ITEMS(...)
   --dprint("MAIL_UNLOCK_SEND_ITEMS", ...)
end

------------------------------------------------------------------------------------------------------------
function SkuCore:MAIL_FAILED(...)
   --dprint("MAIL_FAILED", ...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MailEditor(aTargetValue)
	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Enter text and press ENTER key"], false, true, 0.2)

	--SkuOptions:EditBoxPasteShow("", function(self)
   SkuOptions:EditBoxShow(" ", function(self)
		PlaySound(89)
      local tText = SkuOptionsEditBoxEditBox:GetText()
      SkuOptions.currentMenuPosition[aTargetValue] = tText
      if not SkuOptions.currentMenuPosition.TmpTo then
         SkuOptions.Voice:OutputStringBTtts(L["Recepient missing"], false, true, 0.2)
      elseif not SkuOptions.currentMenuPosition.TmpSubject then
         SkuOptions.Voice:OutputStringBTtts(L["Topic missing"], false, true, 0.2)
      else
         SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, false, true, 0.2)
      end
	end)
end

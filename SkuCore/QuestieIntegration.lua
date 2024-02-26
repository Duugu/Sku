local MODULE_NAME, MODULE_PART = "SkuCore", "QuestieIntegration"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestieIntegrationOnLogin()
   for x = 1, 8 do
      C_Timer.After(x * 30, function()
         local tQT = QuestieTutorialChooseObjectiveType
         if tQT and tQT:IsVisible() == true then
            for i, v in pairs({tQT:GetChildren()}) do
               if v.Text then
                  if string.find(v.Text:GetText(), "Questie") then
                     v:Click()
                  end
               end
            end
         end

         local tQT = _G["WorldMapFrameCloseButton"]
         if tQT and tQT:IsVisible() == true then
            _G["WorldMapFrameCloseButton"]:Click()
         end
      end)
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:QuestieIntegrationOnInitialize()

end



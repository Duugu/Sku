local MODULE_NAME, MODULE_PART = "SkuCore", "dialogkey"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
local function DialogkeyCreateControlFrame()
	local tFrame = CreateFrame("Frame", "SkuCoreDialogkeyControl", UIParent)
   tFrame:EnableKeyboard(true)
   tFrame:SetPropagateKeyboardInput(true)
   tFrame:SetScript("OnKeyDown", function(self, a, b)
      if SkuCore.inCombat == true then
         return
      end
      
      if a == "SPACE" then
         if QuestFrameAcceptButton and QuestFrameAcceptButton:IsShown() and QuestFrameAcceptButton:IsVisible() then
            if QuestFrameAcceptButton:IsEnabled() then
               QuestFrameAcceptButton:Click()
            else
               PlaySound(847)
            end
         end
         if QuestFrameCompleteButton and QuestFrameCompleteButton:IsShown() and QuestFrameCompleteButton:IsVisible() then
            if QuestFrameCompleteButton:IsEnabled() then
               QuestFrameCompleteButton:Click()
            else
               PlaySound(847)
            end
         end
         if QuestFrameCompleteQuestButton and QuestFrameCompleteQuestButton:IsShown() and QuestFrameCompleteQuestButton:IsVisible() then
            if QuestFrameCompleteQuestButton:IsEnabled() then
               QuestFrameCompleteQuestButton:Click()
            else
               PlaySound(847)
            end
         end

         if GossipFrame and GossipFrame.GreetingPanel and GossipFrame.GreetingPanel.ScrollBox and GossipFrame.GreetingPanel.ScrollBox:IsShown() and GossipFrame.GreetingPanel.ScrollBox:IsVisible() then
            local tActiveQuests = {}
            local tAvailableQuests = {}
            local tGossipOptions = {}
            local tHasActiveQuests = false
            local tHasAvailableQuests = false
            local tHasGossipOptions = false

            local tChild = GossipFrame.GreetingPanel.ScrollBox:GetChildren()
            local tButtons = {tChild:GetChildren()}
            for i, v in pairs(tButtons) do
               if v.GetElementData then
                  local tData = v:GetElementData()
                  if tData.buttonType == 3 then
                     tGossipOptions[tData.index] = tData.gossipOptionID or tData.titleOptionButton
                     tHasGossipOptions = true
                  elseif tData.buttonType == 4 then
                     tActiveQuests[tData.index] = tData.activeQuestButton
                     tHasActiveQuests = true
                  elseif tData.buttonType == 5 then
                     tAvailableQuests[tData.index] = tData.availableQuestButton
                     tHasAvailableQuests = true
                  end
               end
            end

            if tHasActiveQuests == true then
               for x = 1, 20 do
                  if tActiveQuests[x] then
                     tActiveQuests[x]:Click()
                     break
                  end
               end
            elseif tHasAvailableQuests == true then
               for x = 1, 20 do
                  if tAvailableQuests[x] then
                     tAvailableQuests[x]:Click()
                     break
                  end
               end
            elseif tHasGossipOptions == true then
               for x = 1, 20 do
                  if tGossipOptions[x] then
                     tGossipOptions[x]:Click()
                     break
                  end
               end
            end
         end
      end
      for x = 1, 9 do
         if a == tostring(x) then
            if _G["QuestInfoRewardsFrameQuestInfoItem"..x] and _G["QuestInfoRewardsFrameQuestInfoItem"..x]:IsShown() and _G["QuestInfoRewardsFrameQuestInfoItem"..x]:IsVisible() then
               if _G["QuestInfoRewardsFrameQuestInfoItem"..x]:IsEnabled() then
                  _G["QuestInfoRewardsFrameQuestInfoItem"..x]:Click()
               else
                  PlaySound(847)
               end
            end
         end
      end
   end)
   tFrame:Hide()
   tFrame:Show()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialogKeyLogin()
	DialogkeyCreateControlFrame()
end
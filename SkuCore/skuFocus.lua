local MODULE_NAME, MODULE_PART = "SkuCore", "SkuFocus"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")
SkuCore.SkuFocus = {}


local tFocusUnitIds = {
   player = true,
   pet = true,
   focus = true,
   target = true,
   pettarget = true,
   focustarget = true,
   playertargettarget = true,
   pettargettarget = true,
   focustargettarget = true,
   targettarget = true,
}
for x = 1, 8 do
   tFocusUnitIds["boss"..x] = true
end
for x = 1, 4 do
   tFocusUnitIds["party"..x] = true
   tFocusUnitIds["partypet"..x] = true
   tFocusUnitIds["party"..x.."target"] = true
   tFocusUnitIds["partypet"..x.."target"] = true
   tFocusUnitIds["party"..x.."targettarget"] = true
   tFocusUnitIds["partypet"..x.."targettarget"] = true
end
for x = 1, 25 do
   tFocusUnitIds["raid"..x] = true
   tFocusUnitIds["raidpet"..x] = true
   tFocusUnitIds["raid"..x.."target"] = true
   tFocusUnitIds["raidpet"..x.."target"] = true
   tFocusUnitIds["raid"..x.."targettarget"] = true
   tFocusUnitIds["raidpet"..x.."targettarget"] = true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore.SkuFocus:OnLogin()
   --print("SkuCore:SkuFocusOnLogin")
   local function setupHelper()
      --secure buttons
      for x = 1, 8 do
         local tmp = CreateFrame("Button", "focus"..x, _G["UIParent"], "SecureActionButtonTemplate")
         _G["focus"..x] = tmp
         _G["focus"..x]:SetAttribute("type1", "macro") 
         _G["focus"..x]:SetAttribute("macrotext1", "")
      end

      --control frame
      local tFrame = _G["SkuCoreSkuFocusControl"] or  CreateFrame("Button", "SkuCoreSkuFocusControl", _G["SkuCoreControl"], "UIPanelButtonTemplate")
      tFrame:SetSize(80, 22)
      tFrame:SetText("SkuCoreSkuFocusControl")
      tFrame:SetPoint("TOP", _G["SkuCoreControl"], "BOTTOM", 0, 0)
      tFrame:SetScript("OnClick", function(self, aKey, aB)
         for x = 1, 8 do
            if aKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSSET"..x].key then
               SkuCore.SkuFocus:SetFocusUnitName(x, UnitName("target"))
               return
            end
         end
      end)
      tFrame:SetScript("OnShow", function(self) 
         if SkuCore.inCombat == true then
            return
         end

      end)
      tFrame:SetScript("OnHide", function(self) 
         if SkuCore.inCombat == true then
            return
         end

         ClearOverrideBindings(self)
         for x = 1, 8 do
            ClearOverrideBindings(_G["focus"..x])
         end

         for x = 1, 8 do
            --set
            if SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSSET"..x].key ~= "" then
               SetOverrideBindingClick(self, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSSET"..x].key, "SkuCoreSkuFocusControl", SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSSET"..x].key)
            end
            --get
            if SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSGET"..x].key ~= "" then
               SetOverrideBindingClick(_G["focus"..x], true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_FOCUSGET"..x].key, "focus"..x)
            end
         end
      end)
      
      tFrame:Hide()

      for x = 1, 8 do
         SkuOptions:RegisterChatCommand("focus"..x, function(msg)
            if msg and msg ~= "" then
               if tFocusUnitIds[string.lower(msg)] then
                  SkuCore.SkuFocus:SetFocusUnitName(x, UnitName(string.lower(msg)))
               else
                  SkuCore.SkuFocus:SetFocusUnitName(x, msg)
               end
            else
               SkuCore.SkuFocus:SetFocusUnitName(x, UnitName("target"))
            end
         end)
      end
   end

   --set up or delay to leave combat
   if not InCombatLockdown() then
      setupHelper()
   else
      SkuDispatcher:RegisterEventCallback("PLAYER_LEAVE_COMBAT", setupHelper)
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore.SkuFocus:SetFocusUnitName(aFocusNumber, aFocusTargetName)
   if not InCombatLockdown() then
      if not aFocusTargetName or aFocusTargetName == "" then
         _G["focus"..aFocusNumber]:SetAttribute("macrotext1", "")
         print(L["focus"]..aFocusNumber..L[" set to nothing"])
         return
      else
         _G["focus"..aFocusNumber]:SetAttribute("macrotext1", "/tar "..aFocusTargetName)
         print(L["focus"]..aFocusNumber..L[" set to "]..aFocusTargetName)
      end
   else
      print(L["not available in combat"])
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore.SkuFocus:OnInitialize()
   --print("SkuFocusOnInitialize")
end


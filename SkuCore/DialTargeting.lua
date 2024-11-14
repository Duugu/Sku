local MODULE_NAME, MODULE_PART = "SkuCore", "DialTargeting"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.DialTargeting = {}


---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingOnLogin()
   SkuOptions.db.profile[MODULE_NAME].dialTargeting = SkuOptions.db.profile[MODULE_NAME].dialTargeting or {}
   SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled = SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled or L["Off"]
   SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound = SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound or L["On first and second key"]
   SkuOptions.db.profile[MODULE_NAME].dialTargeting.singleKeyinRaid10 = SkuOptions.db.profile[MODULE_NAME].dialTargeting.singleKeyinRaid10 or L["Off"]
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingOnInitialize()
   dprint("DialTargetingOnInitialize")

   --SkuSecureStateDriveFrame
   local tSkuSecureStateDriveFrame = CreateFrame("Frame", "SkuSecureStateDriveFrame", UIParent, "SecureHandlerStateTemplate")
   RegisterStateDriver(tSkuSecureStateDriveFrame, "targetstate", "[@target,noexists] notarget; [@target,exists] target")
   tSkuSecureStateDriveFrame:SetAttribute("_onstate-targetstate", [[
      -- arguments: self, stateid, newstate
      if self:GetFrameRef("SkuSecureTargetingFrame"):GetAttribute("enabled") == true then
         if self:GetFrameRef("SkuSecureTargetingFrame"):GetAttribute("groupType") == "raid" then
            if self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton") ~= "" then
               self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetAttribute("lastButton", "")
               self:GetFrameRef("SkuSecureTargetingFrame"):SetAttribute("unit", "none")
               for x = 0, 9 do
                  self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetBindingClick(true, "NUMPAD"..x, "SkuSecureTargetingToggleHandler", "Button"..x)
               end
            end
         end
      end
   ]])

   --SkuSecureTargetingFrame
   local tSkuSecureTargetingFrame = CreateFrame("Button", "SkuSecureTargetingFrame", UIParent, "SecureHandlerClickTemplate,SecureActionButtonTemplate")
   tSkuSecureTargetingFrame:SetAttribute("type", "target")
   tSkuSecureTargetingFrame:SetAttribute("unit", "player")
   tSkuSecureTargetingFrame:SetAttribute("groupType", nil)
   tSkuSecureTargetingFrame:SetAttribute("enabled", false)
   tSkuSecureTargetingFrame.Disable = function(self)
      if SkuCore.inCombat ~= true then
         if _G["SkuSecureTargetingFrame"] then
            SecureHandlerExecute(_G["SkuSecureTargetingFrame"], [=[
               self:ClearBindings()
            ]=])
         end
      end
   end
   tSkuSecureTargetingFrame:HookScript("OnClick", function()
      if SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound == L["On second key"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound == L["On first and second key"] then
         PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\blip_low.mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
      end
   end)

   SecureHandlerWrapScript(tSkuSecureTargetingFrame, "PreClick", tSkuSecureTargetingFrame, [=[
      if button ~= "Button100" then
         if button == "Button99" then
            self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetAttribute("lastButton", "")
            self:SetAttribute("unit", "none")
         else
            if button == "Button0" and (self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton") == "" or self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton") == "Button0") and self:GetAttribute("groupType") ~= "raid10" then
               self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetAttribute("lastButton", "")
               self:SetAttribute("unit", "player")
            else
               if self:GetAttribute("groupType") == "raid" then
                  if self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton") ~= "" then
                     if button == "Button0" and self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton") == "Button0" then
                        self:SetAttribute("unit", "player")
                     else
                        local tId = tonumber(string.sub(self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton"), 7)..string.sub(button, 7))
                        local tG = math.ceil(tId / 5)
                        local tS = tId - ((tG - 1) * 5)
                        self:SetAttribute("unit", self:GetAttribute("unitNameSlot"..string.format("%02d", tG).."-"..string.format("%02d", tS)))
                     end
                     self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetAttribute("lastButton", "")
                  end
               elseif self:GetAttribute("groupType") == "raid10" then
                  local tId = tonumber(string.sub(self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton"), 7)..string.sub(button, 7))
                  if button == "Button0" then
                     tId = 10
                     local tG = 2
                     local tS = 5
                     self:SetAttribute("unit", self:GetAttribute("unitNameSlot"..string.format("%02d", tG).."-"..string.format("%02d", tS)))
                  else
                     local tG = math.ceil(tId / 5)
                     local tS = tId - ((tG - 1) * 5)
                     self:SetAttribute("unit", self:GetAttribute("unitNameSlot"..string.format("%02d", tG).."-"..string.format("%02d", tS)))
                  end
               elseif self:GetAttribute("groupType") == "party" then
                  local tId = tonumber(string.sub(self:GetFrameRef("SkuSecureTargetingToggleHandler"):GetAttribute("lastButton"), 7)..string.sub(button, 7))
                  local tG = math.ceil(tId / 5)
                  local tS = tId - ((tG - 1) * 5)
                  self:SetAttribute("unit", self:GetAttribute("unitNameSlot"..string.format("%02d", tG).."-"..string.format("%02d", tS)))
               end
            end
         end
      else
         self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetAttribute("lastButton", "")
      end

      if self:GetAttribute("groupType") == "raid" then
         for x = 0, 9 do
            self:GetFrameRef("SkuSecureTargetingToggleHandler"):SetBindingClick(true, "NUMPAD"..x, "SkuSecureTargetingToggleHandler", "Button"..x)
         end
      end
   ]=])

   --SkuSecureTargetingToggleHandler
	local tSkuSecureTargetingToggleHandler = CreateFrame("Button", "SkuSecureTargetingToggleHandler", UIParent, "SecureHandlerClickTemplate")
	tSkuSecureTargetingToggleHandler:SetFrameRef("SkuSecureTargetingFrame", tSkuSecureTargetingFrame)
   tSkuSecureTargetingFrame:SetFrameRef("SkuSecureTargetingToggleHandler", tSkuSecureTargetingToggleHandler)
   tSkuSecureStateDriveFrame:SetFrameRef("SkuSecureTargetingFrame", tSkuSecureTargetingFrame)
   tSkuSecureStateDriveFrame:SetFrameRef("SkuSecureTargetingToggleHandler", tSkuSecureTargetingToggleHandler)
   tSkuSecureTargetingToggleHandler.Disable = function(self)
      if SkuCore.inCombat ~= true then
         if _G["SkuSecureTargetingFrame"] then
            SecureHandlerExecute(_G["SkuSecureTargetingFrame"], [=[
               self:ClearBindings()
            ]=])
         end
      end
   end   
	tSkuSecureTargetingToggleHandler:SetAttribute("lastButton", "")
	tSkuSecureTargetingToggleHandler:SetAttribute("_onclick", [=[
      if self:GetAttribute("lastButton") == "" then
         if tonumber(string.sub(button, 7)) <= 2 then
            self:SetAttribute("lastButton", button)
            for x = 0, 9 do
               self:GetFrameRef("SkuSecureTargetingFrame"):SetBindingClick(true, "NUMPAD"..x, "SkuSecureTargetingFrame", "Button"..x)
            end
         else
            self:SetAttribute("lastButton", "")
         end
      end
	]=])
   tSkuSecureTargetingToggleHandler:HookScript("OnClick", function()
      if SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound == L["On first key"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound == L["On first and second key"] then
         PlaySoundFile("Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\blip.mp3", SkuOptions.db.profile["SkuOptions"].soundChannels.SkuChannel or "Talking Head")
      end
   end)

	SkuDispatcher:RegisterEventCallback("PLAYER_ENTERING_WORLD", SkuCore.DialTargeting_PLAYER_ENTERING_WORLD)
   SkuDispatcher:RegisterEventCallback("PARTY_LEADER_CHANGED", SkuCore.DialTargeting_PARTY_LEADER_CHANGED)
   SkuDispatcher:RegisterEventCallback("GROUP_FORMED", SkuCore.DialTargeting_GROUP_FORMED)
   SkuDispatcher:RegisterEventCallback("GROUP_JOINED", SkuCore.DialTargeting_GROUP_JOINED)
   SkuDispatcher:RegisterEventCallback("GROUP_LEFT", SkuCore.DialTargeting_GROUP_LEFT)
   SkuDispatcher:RegisterEventCallback("GROUP_ROSTER_UPDATE", SkuCore.DialTargeting_GROUP_ROSTER_UPDATE)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingGetCurrentRoster()
   dprint("DialTargetingGetCurrentRoster")
   local tRoster = {}
   for x = 1, 10 do
      for y = 1, 5 do
         if _G["SkuSecureTargetingFrame"]:GetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y)) then
            tRoster[x] = tRoster[x] or {}
            tRoster[x][y] = _G["SkuSecureTargetingFrame"]:GetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y))
         end
      end
   end

   return tRoster
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingRosterUpdate()
   if 
      ((UnitInRaid("player") and (SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Raid"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party and Raid"]))) 
      or 
      (UnitInParty("player") == true  and (SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party and Raid"]))  
   then

      dprint("DialTargetingRosterUpdate")

      if _G["SkuSkriptRecognizer"] and _G["SkuSkriptRecognizer"]:IsShown() == true then
         _G["SkuSkriptRecognizer"]:Hide()
         _G["SkuSkriptRecognizerBottomLeft"]:Hide()
      end

      if SkuCore.inCombat == true then
         SkuDispatcher:RegisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingRosterUpdate, true)
         return
      end
      SkuDispatcher:UnregisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingRosterUpdate)

      local tPlayerName = UnitName("player")
      _G["SkuSecureTargetingFrame"]:SetAttribute("playername", tPlayerName)

      if UnitInRaid("player") then
         local tNumCurMembers = 0
         for x = 1, MAX_RAID_MEMBERS do
            local name = GetRaidRosterInfo(x)
            if name then
               tNumCurMembers = tNumCurMembers + 1
            end
         end

         if SkuOptions.db.profile[MODULE_NAME].dialTargeting.singleKeyinRaid10 == L["Off"] or tNumCurMembers > 10 then
            _G["SkuSecureTargetingFrame"]:SetAttribute("groupType", "raid")
            
            for x = 1, 10 do
               for y = 1, 5 do
                  _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y), nil)
               end
            end
            local tsubgroupcounter = {}
            for x = 1, MAX_RAID_MEMBERS do
               local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(x)
               if name and subgroup then
                  tsubgroupcounter[subgroup] = tsubgroupcounter[subgroup] or 0
                  tsubgroupcounter[subgroup] = tsubgroupcounter[subgroup] + 1
                  _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..string.format("%02d", subgroup).."-"..string.format("%02d", tsubgroupcounter[subgroup]), name)
               end
            end
            ClearOverrideBindings(_G["SkuSecureTargetingFrame"])
            ClearOverrideBindings(_G["SkuSecureTargetingToggleHandler"])
            for x = 0, 9 do
               SetOverrideBindingClick(_G["SkuSecureTargetingToggleHandler"], true, "NUMPAD"..x, "SkuSecureTargetingToggleHandler", "Button"..x)
            end
            SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADPLUS", "SkuSecureTargetingFrame", "Button100")
            SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADDECIMAL", "SkuSecureTargetingFrame", "Button99")
         else
            _G["SkuSecureTargetingFrame"]:SetAttribute("groupType", "raid10")
         
            for x = 1, 10 do
               for y = 1, 5 do
                  _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y), nil)
               end
            end
            local tsubgroupcounter = {}
            for x = 1, MAX_RAID_MEMBERS do
               local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(x)
               if name and subgroup then
                  tsubgroupcounter[subgroup] = tsubgroupcounter[subgroup] or 0
                  tsubgroupcounter[subgroup] = tsubgroupcounter[subgroup] + 1
                  _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..string.format("%02d", subgroup).."-"..string.format("%02d", tsubgroupcounter[subgroup]), name)
               end
            end
   
            ClearOverrideBindings(_G["SkuSecureTargetingFrame"])
            ClearOverrideBindings(_G["SkuSecureTargetingToggleHandler"])
            for x = 0, 9 do
               SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPAD"..x, "SkuSecureTargetingFrame", "Button"..x)
            end
            SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADPLUS", "SkuSecureTargetingFrame", "Button100")
            SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADDECIMAL", "SkuSecureTargetingFrame", "Button99")
         end

      elseif UnitInParty("player") == true then
         _G["SkuSecureTargetingFrame"]:SetAttribute("groupType", "party")
         
         for x = 1, 10 do
            for y = 1, 5 do
               _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y), nil)
            end
         end
         local tsubgroupcounter = {[1] = 0}
         for x = 1, 5 do
            local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(x)
            if name and subgroup then
               if name == _G["SkuSecureTargetingFrame"]:GetAttribute("playername") then
                  --_G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot"..1.."-"..string.format("%02d", tsubgroupcounter[subgroup]), name)
               else
                  tsubgroupcounter[subgroup] = tsubgroupcounter[subgroup] + 1
                  _G["SkuSecureTargetingFrame"]:SetAttribute("unitNameSlot01".."-"..string.format("%02d", tsubgroupcounter[subgroup]), name)
               end
            end
         end

         --[[
         for x = 1, 10 do
            for y = 1, 5 do
               if _G["SkuSecureTargetingFrame"]:GetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y)) then
                  print("G", x, "S", y, _G["SkuSecureTargetingFrame"]:GetAttribute("unitNameSlot"..string.format("%02d", x).."-"..string.format("%02d", y), nil))
               end
            end
         end
         ]]

         ClearOverrideBindings(_G["SkuSecureTargetingFrame"])
         ClearOverrideBindings(_G["SkuSecureTargetingToggleHandler"])
         for x = 0, 9 do
            SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPAD"..x, "SkuSecureTargetingFrame", "Button"..x)
         end
         SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADPLUS", "SkuSecureTargetingFrame", "Button100")
         SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADDECIMAL", "SkuSecureTargetingFrame", "Button99")
      
      else
         _G["SkuSecureTargetingFrame"]:SetAttribute("groupType", nil)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingEnable()
   dprint("DialTargetingEnable")
   if SkuCore.inCombat == true then
      SkuDispatcher:RegisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingEnable, true)
      return
   end
   SkuDispatcher:UnregisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingEnable)
   SkuDispatcher:UnregisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingDisable)

   if _G["SkuSkriptRecognizer"] and _G["SkuSkriptRecognizer"]:IsShown() == true then
      _G["SkuSkriptRecognizer"]:Hide()
      _G["SkuSkriptRecognizerBottomLeft"]:Hide()
      print(L["Dial Targeting"].." "..L["Enabled"])
   end

   for x = 0, 9 do
      SetOverrideBindingClick(_G["SkuSecureTargetingToggleHandler"], true, "NUMPAD"..x, "SkuSecureTargetingToggleHandler", "Button"..x)
   end
   SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADPLUS", "SkuSecureTargetingFrame", "Button100")
   SetOverrideBindingClick(_G["SkuSecureTargetingFrame"], true, "NUMPADDECIMAL", "SkuSecureTargetingFrame", "Button99")

   _G["SkuSecureTargetingFrame"]:SetAttribute("enabled", true)

   SkuCore:DialTargetingRosterUpdate()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingDisable()
   dprint("DialTargetingDisable")
   if SkuCore.inCombat == true then
      SkuDispatcher:RegisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingDisable, true)
      return
   end
   SkuDispatcher:UnregisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingEnable)
   SkuDispatcher:UnregisterEventCallback("PLAYER_REGEN_ENABLED", SkuCore.DialTargetingDisable)

   _G["SkuSecureTargetingFrame"]:SetAttribute("enabled", false)
   _G["SkuSecureTargetingFrame"]:Disable()
   _G["SkuSecureTargetingToggleHandler"]:Disable()
   ClearOverrideBindings(_G["SkuSecureTargetingFrame"])
   ClearOverrideBindings(_G["SkuSecureTargetingToggleHandler"])
   
   if _G["SkuSkriptRecognizer"] and _G["SkuSkriptRecognizer"]:IsShown() == false then
      _G["SkuSkriptRecognizer"]:Show()
      _G["SkuSkriptRecognizerBottomLeft"]:Show()
      print(L["Dial Targeting"].." "..L["disabled"])
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_PLAYER_ENTERING_WORLD()
   dprint("DialTargeting_PLAYER_ENTERING_WORLD")
   SkuCore:DialTargeting_EndableDisable()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_PARTY_LEADER_CHANGED()
   dprint("DialTargeting_PARTY_LEADER_CHANGED", UnitInRaid("player"), UnitInParty("player"))
   SkuCore:DialTargeting_EndableDisable()
   SkuCore:DialTargetingRosterUpdate()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_GROUP_FORMED()
   dprint("DialTargeting_PARTY_LEADER_CHANGED")
   SkuCore:DialTargeting_EndableDisable()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_GROUP_JOINED()
   dprint("DialTargeting_PARTY_LEADER_CHANGED")
   SkuCore:DialTargeting_EndableDisable() 
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_GROUP_LEFT()
   dprint("DialTargeting_PARTY_LEADER_CHANGED")
   SkuCore:DialTargeting_EndableDisable()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_GROUP_ROSTER_UPDATE()
   dprint("DialTargeting_PARTY_LEADER_CHANGED")
   SkuCore:DialTargeting_EndableDisable()
   SkuCore:DialTargetingRosterUpdate()
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargeting_EndableDisable()
   if 
      ((UnitInRaid("player") and (SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Raid"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party and Raid"]))) 
      or 
      (UnitInParty("player") == true  and (SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party"] or SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled == L["Party and Raid"]))  
   then
      SkuCore:DialTargetingEnable()
   else
      SkuCore:DialTargetingDisable()
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DialTargetingMenuBuilder()
   local tNewMenuEntry = InjectMenuItemsNew(self, {L["Enabled"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
      return SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled
   end
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuOptions.db.profile[MODULE_NAME].dialTargeting.enabled = aName
      SkuCore:DialTargeting_EndableDisable()
   end
   tNewMenuEntry.BuildChildren = function(self)
      InjectMenuItemsNew(self, {L["Party"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["Raid"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["Party and Raid"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["Off"]}, SkuGenericMenuItem)
   end

   local tNewMenuEntry = InjectMenuItemsNew(self, {L["Key Sound"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
      return SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound
   end
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuOptions.db.profile[MODULE_NAME].dialTargeting.keySound = aName
   end
   tNewMenuEntry.BuildChildren = function(self)
      InjectMenuItemsNew(self, {L["No sound"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["On first key"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["On second key"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["On first and second key"]}, SkuGenericMenuItem)
   end

   local tNewMenuEntry = InjectMenuItemsNew(self, {L["Single key action in raids up to 10 players"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
      return SkuOptions.db.profile["SkuCore"].dialTargeting.singleKeyinRaid10
   end
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuOptions.db.profile["SkuCore"].dialTargeting.singleKeyinRaid10 = aName
      SkuCore:DialTargeting_EndableDisable()
   end
   tNewMenuEntry.BuildChildren = function(self)
      InjectMenuItemsNew(self, {L["On"]}, SkuGenericMenuItem)
      InjectMenuItemsNew(self, {L["Off"]}, SkuGenericMenuItem)
   end
   

end
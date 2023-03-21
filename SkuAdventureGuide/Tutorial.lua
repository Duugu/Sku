---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuAdventureGuide", "Tutorial"
local L = Sku.L
local _G = _G

SkuAdventureGuide = SkuAdventureGuide or LibStub("AceAddon-3.0"):NewAddon("SkuAdventureGuide", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
SkuAdventureGuide.Tutorial = {}
SkuAdventureGuide.Tutorial.current = {
   title = nil, --"tutorial eins",
   step = nil, --1,
   source = SkuDB,
}
SkuAdventureGuide.Tutorial.positionReachedRange = 4
SkuAdventureGuide.Tutorial.triggers = {
   --[[
   numQuests            local numEntries, numQuests = GetNumQuestLogEntries()
   route selected       SkuOptions.db.profile["SkuNav"].metapathFollowing ~= true
   waypoint seletected  SkuOptions.db.profile["SkuNav"].metapathFollowing ~= true
   ]]
   VIEWING_DIRECTION = {
      uiString = L["VIEWING_DIRECTION"],
      values = {
         [1] = "north",
         [2] = "north-west",
         [3] = "west",
         [4] = "south-west",
         [5] = "south",
         [6] = "south-east",
         [7] = "east",
         [8] = "north-east",
      },
      validator = function(aValue)
         local x, y = UnitPosition("player")
			local _, _, afinal = SkuNav:GetDirectionTo(x, y, 30000, y)
			local tDeg = {
				[1] = {deg = 181, file = "south"},
				[2] = {deg = 157.5, file = "south-west"},
				[3] = {deg = 112.5, file = "west"},
				[4] = {deg = 67.5, file = "north-west"},
				[5] = {deg = 22.5, file = "north"},
				[6] = {deg = -22.5, file = "north-east"},
				[7] = {deg = -67.5, file = "east"},
				[8] = {deg = -112.5, file = "south-east"},
				[9] = {deg = -157.5, file = "south"},
				[10] = {deg = -181, file = "south"},
			}
			for x = 1, #tDeg do
				if afinal < tDeg[x].deg and afinal > tDeg[x + 1].deg then
               if tDeg[x].file == SkuAdventureGuide.Tutorial.triggers.VIEWING_DIRECTION.values[aValue] then
                  return true
               end
				end
			end         
         return false
      end,
      collector = {},
   },
   MODIFIER_KEY_DOWN = {
      uiString = L["MODIFIER_KEY_DOWN"],
      values = {
         [1] = "Shift",
         [2] = "Control",
         [3] = "Alt",
      },
      validator = function(aValue)
         if aValue == 1 and IsShiftKeyDown() == true then
            return true
         end
         if aValue == 2 and IsControlKeyDown() == true then
            return true
         end
         if aValue == 3 and IsAltKeyDown() == true then
            return true
         end
         return false
      end,
      collector = {},
   },  
   PLAYER_SKILL = {
      uiString = L["PLAYER_SKILL"],
      values = {
         [1] = "First Aid",
         [2] = "Fishing",
      },
      validator = function(aValue)
         local numSkills = GetNumSkillLines()
         for x = 1, numSkills do
            local locSkillName = GetSkillLineInfo(x) 
            if locSkillName == L[SkuAdventureGuide.Tutorial.triggers.PLAYER_SKILL.values[aValue]] then
               return true
            end
         end
         return false
      end,
      collector = {},
   },  
   PLAYER_FACTION = {
      uiString = L["PLAYER_FACTION"],
      values = {
         [1] = "Alliance",
         [2] = "Horde",
      },
      validator = function(aValue)
         local _, localizedFaction = UnitFactionGroup("player")
         if localizedFaction == L[SkuAdventureGuide.Tutorial.triggers.PLAYER_FACTION.values[aValue]] then
            return true
         end
         return false
      end,
      collector = {},
   },  
   PLAYER_RACE = {
      uiString = L["PLAYER_RACE"],
      values = {
         [1] = "Human",
         [2] = "Orc",
         [3] = "Dwarf",
         [4] = "Night Elf",
         [5] = "Undead",
         [6] = "Tauren",
         [7] = "Gnome",
         [8] = "Troll",
         [9] = "Goblin",
         [10] = "Blood Elf",
         [11] = "Draenei",
      },
      validator = function(aValue)
         local _, raceName = UnitRace("player")
         if L[raceName] == L[SkuAdventureGuide.Tutorial.triggers.PLAYER_RACE.values[aValue]] then
            return true
         end
         return false
      end,
      collector = {},
   },  
   PLAYER_CLASS = {
      uiString = L["PLAYER_CLASS"],
      values = {
         [1] = "Warrior",
         [2] = "Paladin",
         [3] = "Hunter",
         [4] = "Rogue",
         [5] = "Priest",
         [6] = "Deathknight",
         [7] = "Shaman",
         [8] = "Mage",
         [9] = "Warlock",
         [10] = "Druid",
      },
      validator = function(aValue)
         if string.lower(L[select(1, UnitClassBase("player"))]) == string.lower(L[SkuAdventureGuide.Tutorial.triggers.PLAYER_CLASS.values[aValue]]) then
            return true
         end
         return false
      end,
      collector = {},
   },  
   GAME_EVENT = {
      uiString = L["GAME_EVENT"],
      values = {
         [1] = "ACTIVE_TALENT_GROUP_CHANGED",
         [2] = "AUCTION_BIDDER_LIST_UPDATE",
         [3] = "AUCTION_ITEM_LIST_UPDATE",
         [4] = "AUCTION_OWNED_LIST_UPDATE",
         [5] = "AUTOFOLLOW_BEGIN",
         [6] = "AUTOFOLLOW_END",
         [7] = "BAG_UPDATE",
         [8] = "CANCEL_LOOT_ROLL",
         [9] = "CHARACTER_POINTS_CHANGED",
         [10] = "CHAT_MSG_CHANNEL",
         [11] = "CHAT_MSG_CHANNEL_NOTICE",
         [12] = "CHAT_MSG_LOOT",
         [13] = "CHAT_MSG_SAY",
         [14] = "CHAT_MSG_WHISPER",
         [15] = "CHAT_MSG_WHISPER_INFORM",
         [16] = "CURRENT_SPELL_CAST_CHANGED",
         [17] = "CURSOR_CHANGED",
         [18] = "FRIENDLIST_UPDATE",
         [19] = "GLYPH_ADDED",
         [20] = "GLYPH_REMOVED",
         [21] = "GLYPH_UPDATED",
         [22] = "GOSSIP_SHOW",
         [23] = "GROUP_JOINED",
         [24] = "GROUP_ROSTER_UPDATE",
         [25] = "INSPECT_READY",
         [26] = "LEARNED_SPELL_IN_TAB",
         [27] = "LFG_LIST_SEARCH_RESULT_UPDATED",
         [28] = "LFG_LIST_SEARCH_RESULTS_RECEIVED",
         [29] = "LOOT_SLOT_CHANGED",
         [30] = "MAIL_CLOSED",
         [31] = "MAIL_FAILED",
         [32] = "MAIL_INBOX_UPDATE",
         [33] = "MAIL_SEND_INFO_UPDATE",
         [34] = "MAIL_SEND_SUCCESS",
         [35] = "MAIL_SHOW",
         [36] = "MAIL_SUCCESS",
         [37] = "MERCHANT_CLOSED",
         [38] = "MERCHANT_SHOW",
         [39] = "MIRROR_TIMER_PAUSE",
         [40] = "MIRROR_TIMER_START",
         [41] = "MIRROR_TIMER_STOP",
         [42] = "PLAYER_CONTROL_GAINED",
         [43] = "PLAYER_CONTROL_LOST",
         [44] = "PLAYER_DEAD",
         [45] = "PLAYER_ENTERING_WORLD",
         [46] = "PLAYER_EQUIPMENT_CHANGED",
         [47] = "PLAYER_MOUNT_DISPLAY_CHANGED",
         [48] = "PLAYER_REGEN_DISABLED",
         [49] = "PLAYER_REGEN_ENABLED",
         [50] = "PLAYER_SOFT_ENEMY_CHANGED",
         [51] = "PLAYER_SOFT_FRIEND_CHANGED",
         [52] = "PLAYER_SOFT_INTERACT_CHANGED",
         [53] = "PLAYER_STARTED_MOVING",
         [54] = "PLAYER_TALENT_UPDATE",
         [55] = "PLAYER_TARGET_CHANGED",
         [56] = "PLAYER_UNGHOST",
         [57] = "PLAYER_UPDATE_RESTING",
         [58] = "QUEST_ACCEPTED",
         [59] = "QUEST_LOG_UPDATE",
         [60] = "QUEST_REMOVED",
         [61] = "QUEST_TURNED_IN",
         [62] = "SPELLS_CHANGED",
         [63] = "START_LOOT_ROLL",
         [64] = "TRADE_CLOSED",
         [65] = "TRADE_SHOW",
         [66] = "UI_ERROR_MESSAGE",
         [67] = "UI_INFO_MESSAGE",
         [68] = "UNIT_AURA",
         [69] = "UNIT_EXITED_VEHICLE",
         [70] = "UNIT_HAPPINESS",
         [71] = "UNIT_HEALTH",
         [72] = "UNIT_INVENTORY_CHANGED",
         [73] = "UNIT_OTHER_PARTY_CHANGED",
         [74] = "UNIT_POWER_FREQUENT",
         [75] = "UNIT_POWER_UPDATE",
         [76] = "UNIT_QUEST_LOG_CHANGED",
         [77] = "UNIT_SPELLCAST_CHANNEL_START",
         [78] = "UNIT_SPELLCAST_CHANNEL_STOP",
         [79] = "UNIT_SPELLCAST_CHANNEL_UPDATE",
         [80] = "UNIT_SPELLCAST_DELAYED",
         [81] = "UNIT_SPELLCAST_FAILED",
         [82] = "UNIT_SPELLCAST_FAILED_QUIET",
         [83] = "UNIT_SPELLCAST_INTERRUPTED",
         [84] = "UNIT_SPELLCAST_START",
         [85] = "UNIT_SPELLCAST_STOP",
         [86] = "UNIT_SPELLCAST_SUCCEEDED",
         [87] = "UPDATE_FACTION",
         [88] = "UPDATE_MOUSEOVER_UNIT",
         [89] = "UPDATE_STEALTH",
         [90] = "ZONE_CHANGED",
         [91] = "ZONE_CHANGED_INDOORS",
         [92] = "ZONE_CHANGED_NEW_AREA",
      },
      validator = function(aValue)
         for i, v in pairs(SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.collector) do
            if v == SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.values[aValue] then
               return true
            end
         end
         return false
      end,
      collector = {},
   },
   TTS_STRING = {
      uiString = L["TTS_STRING"],
      values = {
         [1] = "ENTER_TEXT",
      },
      validator = function(aValue)
         local tFound = false
         if _G["OnSkuOptionsMain"]:IsVisible() == true then
            local tTable = SkuOptions.currentMenuPosition
            while tTable.parent.name do
               tTable = tTable.parent
               if tTable.name == L["Tutorials"] then
                  return false
               end
            end
         end

         local tLastString = SkuOptions.Voice:GetLastPlayedString()
         if string.find(string.lower(tLastString), string.lower(aValue))  then
            return true
         end
         return false
      end,
      collector = {},
   },
   TARGET_UNIT_NAME = {
      uiString = L["TARGET_UNIT_NAME"],
      values = {
         [1] = "ENTER_TEXT",
         [2] = "CURRENT_TARGET",
      },
      validator = function(aValue)
         if tonumber(aValue) then
            local tId = SkuAdventureGuide.Tutorial:GetUnitCreatureId("target")
            if tId then
               if aValue == tId then
                  return true
               end
            end
            return false
         else
            local name = UnitName("target")
            if name then
               if string.find(string.lower(name), string.lower(aValue))  then
                  return true
               end
            end
            return false
         end
      end,
      collector = {},
   },
   KEY_PRESS = {
      uiString = L["KEY_PRESS"],
      values = {
         [1] = "0",
         [2] = "1",
         [3] = "2",
         [4] = "3",
         [5] = "4",
         [6] = "5",
         [7] = "6",
         [8] = "7",
         [9] = "8",
         [10] = "9",
         [11] = "#",
         [12] = "-",
         [13] = ",",
         [14] = ".",
         [15] = "/",
         [16] = "^",
         [17] = "'",
         [18] = "+",
         [19] = "<",
         [20] = "A",
         [21] = "ä",
         [22] = "B",
         [23] = "C",
         [24] = "D",
         [25] = "DOWN",
         [26] = "E",
         [27] = "ENTER",
         [28] = "ESCAPE",
         [29] = "F",
         [30] = "F1",
         [31] = "F10",
         [32] = "F11",
         [33] = "F12",
         [34] = "F2",
         [35] = "F3",
         [36] = "F4",
         [37] = "F5",
         [38] = "F6",
         [39] = "F7",
         [40] = "F8",
         [41] = "F9",
         [42] = "G",
         [43] = "H",
         [44] = "I",
         [45] = "J",
         [46] = "K",
         [47] = "L",
         [48] = "LEFT",
         [49] = "M",
         [50] = "N",
         [51] = "NUMPAD0",
         [52] = "NUMPAD1",
         [53] = "NUMPAD2",
         [54] = "NUMPAD3",
         [55] = "NUMPAD4",
         [56] = "NUMPAD5",
         [57] = "NUMPAD6",
         [58] = "NUMPAD7",
         [59] = "NUMPAD8",
         [60] = "NUMPAD9",
         [61] = "NUMPADDECIMAL",
         [62] = "NUMPADDIVIDE",
         [63] = "NUMPADMULTIPLY",
         [64] = "O",
         [65] = "ö",
         [66] = "P",
         [67] = "Q",
         [68] = "R",
         [69] = "RIGHT",
         [70] = "S",
         [71] = "SPACE",
         [72] = "ß",
         [73] = "T",
         [74] = "TAB",
         [75] = "U",
         [76] = "ü",
         [77] = "UP",
         [78] = "V",
         [79] = "W",
         [80] = "X",
         [81] = "Y",
         [82] = "Z",
      },
      validator = function(aValue)
         for i, v in pairs(SkuAdventureGuide.Tutorial.triggers.KEY_PRESS.collector) do
            if v == SkuAdventureGuide.Tutorial.triggers.KEY_PRESS.values[aValue] then
               return true
            end
         end
         return false
      end,
      collector = {},
   },
   PANEL_OPEN = {
      uiString = L["PANEL_OPEN"],
      values = {
         [1] = "QuestLogFrame",
         [2] = "GameMenuFrame",
         [3] = "CharacterFrame",
         [4] = "PlayerTalentFrame",
         [5] = "MerchantFrame",
         [6] = "GossipFrame",
         [7] = "ClassTrainerFrame",
         [8] = "StaticPopup1",
         [9] = "QuestFrame",
         [10] = "TaxiFrame",
         [11] = "SkillFrame",
         [12] = "HonorFrame",
         [13] = "DropDownList1",
         [14] = "InspectFrame",
         [15] = "PetStableFrame",
         [16] = "ContainerFrame1",
         [17] = "AuctionFrame",
         [18] = "GuildBankFrame",
         [19] = "BankFrame",
         [20] = "TradeFrame",
         [21] = "TradeSkillFrame",
         [22] = "FriendsFrame",
      },
      validator = function(aValue)
         if not _G[SkuAdventureGuide.Tutorial.triggers.PANEL_OPEN.values[aValue]] then
            return false
         end
         if _G[SkuAdventureGuide.Tutorial.triggers.PANEL_OPEN.values[aValue]]:IsVisible() == true then
            return true
         end
         return false
      end,
      collector = {},
   },   
   PANEL_CLOSED = {
      uiString = L["PANEL_OPEN"],
      values = {
         [1] = "QuestLogFrame",
         [2] = "GameMenuFrame",
         [3] = "CharacterFrame",
         [4] = "PlayerTalentFrame",
         [5] = "MerchantFrame",
         [6] = "GossipFrame",
         [7] = "ClassTrainerFrame",
         [8] = "StaticPopup1",
         [9] = "QuestFrame",
         [10] = "TaxiFrame",
         [11] = "SkillFrame",
         [12] = "HonorFrame",
         [13] = "DropDownList1",
         [14] = "InspectFrame",
         [15] = "PetStableFrame",
         [16] = "ContainerFrame1",
         [17] = "AuctionFrame",
         [18] = "GuildBankFrame",
         [19] = "BankFrame",
         [20] = "TradeFrame",
         [21] = "TradeSkillFrame",
         [22] = "FriendsFrame",
      },
      validator = function(aValue)
         if not _G[SkuAdventureGuide.Tutorial.triggers.PANEL_CLOSED.values[aValue]] then
            return false
         end
         if _G[SkuAdventureGuide.Tutorial.triggers.PANEL_CLOSED.values[aValue]]:IsVisible() == true then
            return true
         end
         return false
      end,
      collector = {},
   },      
   SKU_MENU_OPEN = {
      uiString = L["SKU_MENU_OPEN"],
      values = {
         [1] = "TRUE",
         [2] = "FALSE",
      },
      validator = function(aValue)
         if aValue == 1 and (#SkuOptions.Menu > 0 and SkuOptions:IsMenuOpen() == true) then
            return true
         elseif aValue == 2 and (#SkuOptions.Menu == 0 or SkuOptions:IsMenuOpen() == false)  then
            return true
         end
         return false
      end,
      collector = {},
   },
   PLAYER_POSITION = {
      uiString = L["PLAYER_POSITION"],
      values = {
         [1] = "CURRENT_COORDINATES",
      },
      validator = function(aValue)
         local x, y = UnitPosition("player")
         if x and y then
            x = string.format("%.1f", x)
            y = string.format("%.1f", y)      
            local xv, yv = string.match(aValue, "(.+);(.+)")      
            if xv and yv then
               if (x - xv < SkuAdventureGuide.Tutorial.positionReachedRange and x - xv > -(SkuAdventureGuide.Tutorial.positionReachedRange)) and (y - yv < SkuAdventureGuide.Tutorial.positionReachedRange and y - yv > -(SkuAdventureGuide.Tutorial.positionReachedRange)) then
                  return true
               end
            end
         end
         return false
      end,
      collector = {},
   },   
}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:PLAYER_ENTERING_WORLD(...)
   SkuOptions.db.global[MODULE_NAME].Tutorials = SkuOptions.db.global[MODULE_NAME].Tutorials or {prefix = "Custom", ["enUS"] = {}, ["deDE"] = {},}

   --SkuAdventureGuide.Tutorial:StartTutorial("tutorial eins", 1, SkuDB)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:OnInitialize()
   SkuDispatcher:RegisterEventCallback("PLAYER_ENTERING_WORLD", SkuAdventureGuide.Tutorial.PLAYER_ENTERING_WORLD)

   local f = _G["SkuAdventureGuideTutorialControl"] or CreateFrame("Frame", "SkuAdventureGuideTutorialControl", UIParent)
   local ttime = 0
   f:SetScript("OnUpdate", function(self, time)
      ttime = ttime + time
      if ttime < 0.33 then return end

      if SkuAdventureGuide.Tutorial.current.title ~= nil and SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title] then
         local tStepData = SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step]
         local tStepResult = true == tStepData.allTriggersRequired
         for x = 1, #tStepData.triggers do
            local tValidatorResult = SkuAdventureGuide.Tutorial.triggers[tStepData.triggers[x].type].validator(tStepData.triggers[x].value)
            if tStepData.allTriggersRequired == true and tValidatorResult == false then
               tStepResult = false
               break
            elseif tStepData.allTriggersRequired == false and tValidatorResult == true then
               tStepResult = true
            end
         end
         if tStepResult == true then
            SkuAdventureGuide.Tutorial:OnStepCompleted()
         end
      end

      for _, v in pairs(SkuAdventureGuide.Tutorial.triggers) do
         v.collector = {}
      end

      ttime = 0
   end)

   -- get events for GAME_EVENT
   local function tCallbackHelper(self, aEvent, ...)
      table.insert(SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.collector, aEvent)
   end
   for x = 1, #SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.values do
      SkuDispatcher:RegisterEventCallback(SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.values[x], tCallbackHelper)
   end

   -- get events for KEY_PRESS
	f:EnableKeyboard(true)
	f:SetPropagateKeyboardInput(true)
	f:SetPoint("TOP", _G["UIParent"], "BOTTOM", 0, 0)
	f:SetScript("OnKeyDown", function(self, aKey)
      --print(aKey)
      table.insert(SkuAdventureGuide.Tutorial.triggers.KEY_PRESS.collector, aKey)
	end)
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:MenuBuilderEdit(self)
   local tSource = self.parent.source
   local tTutorialName = self.parent.tutorialName
   local tPrefix = tSource.Tutorials.prefix

   if tPrefix ~= "Sku" then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         SkuOptions:EditBoxShow("", function(a, b, c) 
            local tText = SkuOptionsEditBoxEditBox:GetText()
            if tText then
               local tNameExists = false
               for x = 1, #tSource.Tutorials[Sku.Loc][tTutorialName].steps do
                  if tText ~= "" and tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].title == tText then
                     tNameExists = true
                     break
                  end
               end
               if tNameExists == true then
                  SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                  SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
               else
                  tSource.Tutorials[Sku.Loc][tTutorialName].steps[#tSource.Tutorials[Sku.Loc][tTutorialName].steps + 1] = {
                     title = tText,
                     allTriggersRequired = true,
                     dontSkipCurrentOutputs = true,
                     triggers = {},
                     beginText = "",
                     endText = "",
                  }
                  C_Timer.After(0.001, function()
                     SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                  end)
               end
            end
         end,
         false,
         function(a, b, c) 
            SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
         end)
         C_Timer.After(0.01, function()
            SkuOptions.Voice:OutputStringBTtts(L["Enter step name"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
         end)
      end
   end

   for x = 1, #tSource.Tutorials[Sku.Loc][tTutorialName].steps do
      local tStepData = tSource.Tutorials[Sku.Loc][tTutorialName].steps[x]
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["schritt "]..x..": "..tStepData.title}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start text"]..": "..tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText}, SkuGenericMenuItem)
         tNewMenuEntry.filterable = true
         if tPrefix ~= "Sku" then
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText, function(a, b, c) 
                  local tText = SkuOptionsEditBoxEditBox:GetText()
                  if tText then
                     tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText = tText
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                     end)
                  end
               end,
               false,
               function(a, b, c) 
                  SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
               end)
               C_Timer.After(0.01, function()
                  SkuOptions.Voice:OutputStringBTtts(L["Paste or edit text"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               SkuOptions:InjectMenuItems(self, {L["Edit"]}, SkuGenericMenuItem)
            end
         end

         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["End text"]..": "..tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].endText}, SkuGenericMenuItem)
         tNewMenuEntry.filterable = true
         if tPrefix ~= "Sku" then
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].endText, function(a, b, c) 
                  local tText = SkuOptionsEditBoxEditBox:GetText()
                  if tText then
                     tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].endText = tText
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                     end)
                  end
               end,
               false,
               function(a, b, c) 
                  SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
               end)
               C_Timer.After(0.01, function()
                  SkuOptions.Voice:OutputStringBTtts(L["Paste or edit text"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               SkuOptions:InjectMenuItems(self, {L["Edit"]}, SkuGenericMenuItem)
            end
         end

         if tPrefix ~= "Sku" then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Don't skip current outputs"]}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
               return (tStepData.dontSkipCurrentOutputs == true and L["Yes"] or L["No"])
            end
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               if aName == L["Yes"] then
                  tStepData.dontSkipCurrentOutputs = true
               else
                  tStepData.dontSkipCurrentOutputs = false
               end
            end
            tNewMenuEntry.BuildChildren = function(self)
               SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
               SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
            end
         else
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Don't skip current outputs"]..": "..(tStepData.dontSkipCurrentOutputs == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
         end

         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Triggers"]}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = true
         tNewMenuEntry.filterable = true
         tNewMenuEntry.BuildChildren = function(self)
            if tPrefix ~= "Sku" then
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All Required"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                  return (tStepData.allTriggersRequired == true and L["Yes"] or L["No"])
               end
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  if aName == L["Yes"] then
                     tStepData.allTriggersRequired = true
                  else
                     tStepData.allTriggersRequired = false
                  end
               end
               tNewMenuEntry.BuildChildren = function(self)
                  SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                  SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
               end
            else
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All Required"]..": "..(tStepData.allTriggersRequired == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
            end
   
            if tPrefix ~= "Sku" then
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  if aName == L["ENTER_TEXT"] then
                     SkuOptions:EditBoxShow("", function(a, b, c) 
                        local tText = SkuOptionsEditBoxEditBox:GetText()
                        if tText and tText ~= "" then
                           table.insert(tStepData.triggers, {type = self.triggerType, value = tText})
                           C_Timer.After(0.001, function()
                              SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                           end)
                        end
                     end,
                     false,
                     function(a, b, c) 
                        SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                     end)
                     C_Timer.After(0.01, function()
                        SkuOptions.Voice:OutputStringBTtts(L["Paste or edit text"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                     end)
                  elseif aName == L["CURRENT_TARGET"] then
                     local tId = SkuAdventureGuide.Tutorial:GetUnitCreatureId("target")
                     if tId then
                        table.insert(tStepData.triggers, {type = self.triggerType, value = tId})
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                        end)
                     end
                  elseif aName == L["CURRENT_COORDINATES"] then
                     local x, y = UnitPosition("player")
                     if x and y and x ~= 0 and y ~= 0 then
                        x = string.format("%.1f", x)
                        y = string.format("%.1f", y)
                        table.insert(tStepData.triggers, {type = self.triggerType, value = x..";"..y})
                     end
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                     end)
                  else
                     table.insert(tStepData.triggers, {type = self.triggerType, value = self.triggerValue})
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                     end)
                  end
               end            
               tNewMenuEntry.BuildChildren = function(self)
                  for i, v in pairs(SkuAdventureGuide.Tutorial.triggers) do
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v.uiString}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.filterable = true
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        self.selectTarget.triggerType = i
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        for q = 1, #v.values do
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[v.values[q]]}, SkuGenericMenuItem)
                           tNewMenuEntry.OnEnter = function(self, aValue, aName)
                              self.selectTarget.triggerType = i
                              self.selectTarget.triggerValue = q
                           end
                        end
                     end
                  end
               end
            end

            for y = 1, #tStepData.triggers do
               local tTriggerData = tStepData.triggers[y]
               local tText = y.." "..L[tTriggerData.type]
               if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "ENTER_TEXT" then
                  if tonumber(tTriggerData.value) then
                     tText = tText..": "..SkuDB.NpcData.Names[Sku.Loc][tonumber(tTriggerData.value)][1]
                  else
                     tText = tText..": "..tTriggerData.value
                  end
               elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
                  tText = tText..": "..tTriggerData.value
               elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" then
                  local x, y = string.match(tTriggerData.value, "(.+);(.+)")
                  tText = tText..": "..x.." "..y
               else
                  tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value]]
               end
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tText}, SkuGenericMenuItem)
               if tPrefix ~= "Sku" then
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     --delete trigger
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].triggers, y)
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                        end)
                     end            
                  end
               end
            end
         end
         if tPrefix ~= "Sku" then
            local tNumberSteps = #tSource.Tutorials[Sku.Loc][tTutorialName].steps
            local tNumberThisStep = x

            if tNumberSteps > 1 then
               --move step
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Move Step"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  local tStepDat = tSource.Tutorials[Sku.Loc][tTutorialName].steps
                  local tSingleStepDat = tStepDat[tNumberThisStep]
                  if self.movemenValue > 0 then
                     table.insert(tStepDat, tNumberThisStep + self.movemenValue + 1, tSingleStepDat)
                     table.remove(tStepDat, tNumberThisStep)
                  elseif self.movemenValue < 0 then
                     table.remove(tStepDat, tNumberThisStep)
                     table.insert(tStepDat, tNumberThisStep + self.movemenValue, tSingleStepDat)
                  end
                  C_Timer.After(0.001, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                  end)
               end
               tNewMenuEntry.BuildChildren = function(self)
                  if tNumberThisStep > 1 then
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["First pos"]}, SkuGenericMenuItem)
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        self.parent.movemenValue = -(tNumberThisStep - 1)
                     end
                     for q = 3, 1, -1 do
                        if (tNumberThisStep + 1) - q > 0 then
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {q.." "..L["Up"]}, SkuGenericMenuItem)
                           tNewMenuEntry.OnEnter = function(self, aValue, aName)
                              self.parent.movemenValue = -(q)
                           end
                        end
                     end
                  end
                  if tNumberThisStep < tNumberSteps then
                     for q = 1, 3 do
                        if tNumberThisStep + q < tNumberSteps then
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {q.." "..L["Down"]}, SkuGenericMenuItem)
                           tNewMenuEntry.OnEnter = function(self, aValue, aName)
                              self.parent.movemenValue = q
                           end
                        end
                     end
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Last pos"]}, SkuGenericMenuItem)
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        self.parent.movemenValue = tNumberSteps - tNumberThisStep
                     end
                  end
               end     
            end       

            --rename step
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow("", function(a, b, c) 
                  local tText = SkuOptionsEditBoxEditBox:GetText()
                  if tText then
                     local tExists = false
                     local tStepDat = tSource.Tutorials[Sku.Loc][tTutorialName].steps
                     for w = 1, #tStepDat do
                        if w ~= x and tStepDat[w].title == tText then
                           tExists = true
                        end
                     end
                     if tExists == true and tText ~= "" then
                        SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                        SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                     else
                        tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].title = tText
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                        end)
                     end
                  end
               end,
               false,
               function(a, b, c) 
                  SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
               end)
               C_Timer.After(0.01, function()
                  SkuOptions.Voice:OutputStringBTtts(L["Enter new name"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               end)
            end

            --delete step
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps, x)
               C_Timer.After(0.001, function()
                  SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
               end)
            end            
         end

         --copy step to
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Copy too"]}, SkuGenericMenuItem)
         tNewMenuEntry.dynamic = true
         tNewMenuEntry.filterable = true
         tNewMenuEntry.isSelect = true
         tNewMenuEntry.OnAction = function(self, aValue, aName)
            local tSourceStepDat = tSource.Tutorials[Sku.Loc][tTutorialName].steps[x]
            table.insert(self.source.Tutorials[Sku.Loc][self.tTargetTutorialName].steps,  self.tTargetStepNumber + 1, tSourceStepDat)
            C_Timer.After(0.001, function()
               SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
            end)
         end
         tNewMenuEntry.BuildChildren = function(self)
            function tSubMenuBuilderHelper(aSource)
               for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     if #v.steps > 0 then
                        for x = 1, #v.steps do
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert after"].." "..L["schritt "]..x..": "..v.steps[x].title}, SkuGenericMenuItem)
                           tNewMenuEntry.OnEnter = function(self, aValue, aName)
                              tNewMenuEntry.selectTarget.tTargetTutorialName = i
                              tNewMenuEntry.selectTarget.tTargetStepNumber = x
                              tNewMenuEntry.selectTarget.source = aSource
                           end
                        end
                     else
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert"]}, SkuGenericMenuItem)
                        tNewMenuEntry.OnEnter = function(self, aValue, aName)
                           tNewMenuEntry.selectTarget.tTargetTutorialName = i
                           tNewMenuEntry.selectTarget.tTargetStepNumber = 0
                           tNewMenuEntry.selectTarget.source = aSource
                        end
                     end
                  end
               end
            end
            tSubMenuBuilderHelper(SkuDB)
            tSubMenuBuilderHelper(SkuOptions.db.global[MODULE_NAME])
         end

         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start from this step"]}, SkuGenericMenuItem)
         tNewMenuEntry.isSelect = true
         tNewMenuEntry.OnAction = function(self, aValue, aName)
            SkuAdventureGuide.Tutorial:StopCurrentTutorial()
            SkuAdventureGuide.Tutorial:StartTutorial(tTutorialName, x, tSource)
         end

      end
   end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:EditorMenuBuilder(aParentEntry)
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["New"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuOptions:EditBoxShow("", function(a, b, c) 
         local tText = SkuOptionsEditBoxEditBox:GetText()
         if tText and tText ~= "" then
            if SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tText] then
               SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
            else
               SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tText] = {
                  steps = {},
               }
               C_Timer.After(0.001, function()
                  SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
               end)
            end
         end
      end,
      false,
      function(a, b, c) 
         SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
      end)
      C_Timer.After(0.01, function()
         SkuOptions.Voice:OutputStringBTtts(L["Enter tutorial name"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
      end)
   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Existing"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      function tSubMenuBuilderHelper(aSource)
         local tEmpty = 0
         for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
            tEmpty = tEmpty + 1
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i..(aSource.Tutorials.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.tutorialName = i
            tNewMenuEntry.source = aSource
            tNewMenuEntry.BuildChildren = function(self)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Steps"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.BuildChildren = SkuAdventureGuide.Tutorial.MenuBuilderEdit
   
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                  SkuAdventureGuide.Tutorial:StartTutorial(i, 1, aSource)
               end

               --rename tut
               if aSource.Tutorials.prefix ~= "Sku" then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuOptions:EditBoxShow("", function(a, b, c) 
                        local tText = SkuOptionsEditBoxEditBox:GetText()
                        if tText and tText ~= "" then
                           if self.parent.source.Tutorials[Sku.Loc][tText] then
                              SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                              SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                           else
                              local tOldData = self.parent.source.Tutorials[Sku.Loc][i]
                              self.parent.source.Tutorials[Sku.Loc][tText] = tOldData
                              self.parent.source.Tutorials[Sku.Loc][i] = nil

                              C_Timer.After(0.001, function()
                                 SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                              end)
                           end
                        end
                     end,
                     false,
                     function(a, b, c) 
                        SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                     end)
                     C_Timer.After(0.01, function()
                        SkuOptions.Voice:OutputStringBTtts(L["Enter new name"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                     end)
                  end

                  -- delete tutorial
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     self.parent.source.Tutorials[Sku.Loc][i] = nil
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                     end)
                  end
               end

               --export tutorial
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Export"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  C_Timer.After(0.001, function()
                     SkuAdventureGuide.Tutorial:ExportTutorial(i, v)
                  end)
               end
            end
         end
         return tEmpty
      end

      if tSubMenuBuilderHelper(SkuDB) + tSubMenuBuilderHelper(SkuOptions.db.global[MODULE_NAME]) == 0 then
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
      end

   end

   --import tutorial(s)
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Import"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      C_Timer.After(0.001, function()
         SkuAdventureGuide.Tutorial:ImportTutorial()
      end)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportTutorial(aTutorialName, aTutorialData)
	if not aTutorialName or not aTutorialData then
		return
	end
	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
		tutorialName = aTutorialName,
		tutorialData = aTutorialData,
	}
	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ImportTutorial()
	PlaySound(88)
   SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
   

	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))
		if tSerializedData ~= "" then
			local tSuccess, tTutorialData = SkuOptions:Deserialize(tSerializedData)
         if tSuccess == true and tTutorialData then
            if tTutorialData.tutorialName and tTutorialData.tutorialData then
               if not SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName] then
                  SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName] = tTutorialData.tutorialData
                  SkuOptions.Voice:OutputStringBTtts(L["Tutorial imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                  return
               else
                  SkuOptions.Voice:OutputStringBTtts(L["Error. Name already exists. Rename the existing tutorial and try again."], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                  return
               end
            end
         end
		end
      SkuOptions.Voice:OutputStringBTtts(L["Unknown error. Tutorial data corrupt?"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StartTutorial(aTutorialName, aStartAtStepNumber, aSource)
   --print("StartTutorial", aTutorialName, aStartAtStepNumber, aSource)
   SkuOptions:CloseMenu()

   SkuAdventureGuide.Tutorial.current.title = aTutorialName
   SkuAdventureGuide.Tutorial.current.step = aStartAtStepNumber
   SkuAdventureGuide.Tutorial.current.source = aSource

   SkuAdventureGuide.Tutorial:StartStep(aTutorialName, aStartAtStepNumber, aSource)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StartStep(aTutorialName, aStartAtStepNumber, aSource)
   --SkuAdventureGuide.Tutorial.current.title = aTutorialName
   SkuAdventureGuide.Tutorial.current.step = aStartAtStepNumber
   --SkuAdventureGuide.Tutorial.current.source = aSource

   local tStartText = SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step].beginText
   
   C_Timer.After(1, function()
      if SkuAdventureGuide.Tutorial.current.title and SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step] then
         SkuOptions.Voice:OutputStringBTtts(tStartText, {overwrite = SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step].dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StopCurrentTutorial()
   SkuAdventureGuide.Tutorial.current.title = nil
   SkuAdventureGuide.Tutorial.current.step = nil
   --SkuAdventureGuide.Tutorial.current.source = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:OnStepCompleted()
   local tEndText = SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step].endText
   --print("OnStepCompleted", SkuAdventureGuide.Tutorial.current.title, SkuAdventureGuide.Tutorial.current.step, SkuAdventureGuide.Tutorial.current.source)
   if SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step] then
      SkuOptions.Voice:OutputStringBTtts(tEndText, {overwrite = SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuAdventureGuide.Tutorial.current.step].dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
   end
   C_Timer.After(0.3, function()
      if SkuAdventureGuide.Tutorial.current.step < #SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps then
         SkuAdventureGuide.Tutorial:StartStep(SkuAdventureGuide.Tutorial.current.title, SkuAdventureGuide.Tutorial.current.step + 1, SkuAdventureGuide.Tutorial.current.source)
      else
         SkuAdventureGuide.Tutorial:StopCurrentTutorial()
      end
   end)
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:TutorialsMenuBuilder(aParentEntry)
   local function contentHelper(tNewMenuEntry, aSource)
      tNewMenuEntry.BuildChildren = function(self)
         local tEmpty
         for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
            tEmpty = false
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {i}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.tutorialName = i
            tNewMenuEntry.source = aSource
            tNewMenuEntry.BuildChildren = function(self)
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                  SkuAdventureGuide.Tutorial:StartTutorial(i, 1, aSource)
               end

               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Steps"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.BuildChildren = function(self)

               end
            end
         end
         if tEmpty ~= false then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
         end
      end
   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Sku"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   contentHelper(tNewMenuEntry, SkuDB)

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Custom"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   contentHelper(tNewMenuEntry, SkuOptions.db.global[MODULE_NAME])

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Stop current tutorial"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuAdventureGuide.Tutorial:StopCurrentTutorial()
   end
end

function SkuAdventureGuide.Tutorial:GetUnitCreatureId(unit)
	local guid = UnitGUID(unit)
	if guid then
		local unit_type = strsplit("-", guid)
		if unit_type == "Creature" or unit_type == "Vehicle" then
			local _, _, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid)
         return npc_id
		end
	end
end

--[[
---------------------------------------------------------------------------------------------------------------------------------------
local tCurrentlyPlaying = {}
function SkuAdventureGuide:TutorialPlayNextStepInstructions()
   local tCurrentStepNumber = SkuAdventureGuide.tutorial.currentStep
   for i, v in pairs(tCurrentlyPlaying) do
      StopSound(v, 0)
   end

   tCurrentlyPlaying = {}
   for x = 1, #SkuAdventureGuide.tutorial.data[tCurrentStepNumber].stepDescription do
      local file = ""
      local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\assets\\audio\\"..file)
      if willPlay then
         tCurrentlyPlaying[#tCurrentlyPlaying + 1] = soundHandle
      end
   end

end


---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide:TutorialStart()
   SkuAdventureGuide.tutorial.currentStep = 1
   for x = 1, #SkuAdventureGuide.tutorial.data[1].stepDescription do
      dprint(string.lower(SkuAdventureGuide.tutorial.data[1].stepDescription[x]))
      SkuOptions.Voice:OutputString(string.lower(SkuAdventureGuide.tutorial.data[1].stepDescription[x]), false, true, 0.3, true)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------


]]
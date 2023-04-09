---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuAdventureGuide", "Tutorial"
local L = Sku.L
local _G = _G

SkuAdventureGuide = SkuAdventureGuide or LibStub("AceAddon-3.0"):NewAddon("SkuAdventureGuide", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
local tRaceRequirementValues = {
	[1] = L["Mensch"],
	[2] = L["Ork"],
	[3] = L["Zwerg"],
	[4] = L["Nachtelf"],
	[5] = L["Untoter"],
	[6] = L["Taure"],
	[7] = L["Gnom"],
	[8] = L["Troll"],
	[10] = L["Blutelf"],
	[11] = L["Draenei"],
	[991] = L["Allianz"],
	[992] = L["Horde"],
	[993] = L["Alle"],
}
local tClassRequirementValues = {
	[1] = L["Krieger"],
	[2] = L["Paladin"],
	[3] = L["Jäger"],
	[4] = L["Schurke"],
	[5] = L["Priester"],
	[6] = L["todesritter"],
	[7] = L["Shamane"],
	[8] = L["Magier"],
	[9] = L["Hexer"],
	[10] = L["Druide"],
	[99] = L["Alle"],
}
local tSkillRequirementValues = {
   [2] = L["First Aid"],
   [3] = L["Fishing"],
	[999] = L["Alle"],
}
local tEditPlaceholders = {
   [1] = {
      tag = "%%target%%",
      value = function() 
         local tCreatureId = SkuAdventureGuide.Tutorial:GetUnitCreatureId("target")
         if tCreatureId then
            return "%%npc_id%:"..string.format("%06d", tCreatureId).."%%"
         end
         return nil, L["Error: No target or target has no not valid creature id"]
      end,
   },
}
local tPlaceholders = {
   [1] = {
      tag = "%%name%%",
      value = function(aString) 
         local tName = UnitName("player")
         aString = string.gsub(aString, "%%name%%", tName)
         return aString
      end,
   },
   [2] = {
      tag = "%%class%%",
      value = function(aString) 
         local tClass = UnitClass("player")
         aString = string.gsub(aString, "%%class%%", tClass)
         return aString
      end,
   },
   [3] = {
      tag = "%%SKU_KEY_TUTORIALSTEPFORWARD%%",
      value = function(aString) 
         aString = string.gsub(aString, "%%SKU_KEY_TUTORIALSTEPFORWARD%%", SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key)
         return aString
      end,
   },
   [4] = {
      tag = "%%SKU_KEY_TUTORIALSTEPREPEAT%%",
      value = function(aString) 
         aString = string.gsub(aString, "%%SKU_KEY_TUTORIALSTEPREPEAT%%", SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPREPEAT"].key)
         return aString
      end,
   },
   [4] = {
      tag = "%%(npc_id)%:(%d+)%%",
      value = function(aString) 
         local tType, tId = string.match(aString, "%%(npc_id)%:(%d+)%%")
         if tId then
            local tName = L["INCORRECT CREATURE ID"].." "..tId
            if SkuDB.NpcData.Names[Sku.Loc][tonumber(tId)] then
               tName = SkuDB.NpcData.Names[Sku.Loc][tonumber(tId)][1]
            end
            aString = string.gsub(aString, "%%(npc_id)%:"..tId.."%%", tName)
         end
         return aString
      end,
   },
}

---------------------------------------------------------------------------------------------------------------------------------------
SkuAdventureGuide.Tutorial = {}
SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps = 4
SkuAdventureGuide.Tutorial.currentStepCompleted = false
SkuAdventureGuide.Tutorial.evaluateNextStep = false
SkuAdventureGuide.Tutorial.current = {
   linkedStepData = nil,
   title = nil,
   source = nil,
   isUser = nil,
}
SkuAdventureGuide.Tutorial.positionReachedRange = 4
SkuAdventureGuide.Tutorial.triggers = {
   --[[
      todo
         numQuests            local numEntries, numQuests = GetNumQuestLogEntries()
         route started       SkuOptions.db.profile["SkuNav"].metapathFollowing == true
         waypoint started  SkuOptions.db.profile["SkuNav"].metapathFollowing == true
   ]]
   INFO_STEP = {
      uiString = L["INFO_STEP"],
      values = {
         [1] = "wait for player activating next step",
      },
      validator = function(aValue)
         return true
      end,
      collector = {},
   },
   MENU_ITEM = {
      uiString = L["MENU_ITEM"],
      values = {
         [1] = "WAIT_FOR_MENU_SELECT",
      },
      validator = function(aValue)
         local tcurrent = SkuOptions:GetMenuIndexAndBreadString(SkuOptions.currentMenuPosition)
         if tcurrent == aValue then
            return true
         end
         return false
      end,
      collector = {},
   },
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
            if string.lower(locSkillName) == string.lower(L[SkuAdventureGuide.Tutorial.triggers.PLAYER_SKILL.values[aValue]]) then
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
         [93] = "SKU_ROUTE_STARTED",
         [94] = "SKU_UNITROUTE_STARTED",
         [95] = "SKU_CLOSEROUTE_STARTED",
         [96] = "SKU_WAYPOINT_STARTED",
         [97] = "SKU_NAVIGATION_STOPPED",
         [98] = "SKU_QUICKWAYPOINT_UPDATED",
         [99] = "CHAT_MSG_MONEY",
         [100] = "PLAYER_MONEY",
         --[] = "",
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
         [2] = "CURRENT_COORDINATES_10",
         [3] = "CURRENT_COORDINATES_20",
      },
      validator = function(aValue)
         local x, y = UnitPosition("player")
         if x and y then
            local tRR = 4
            local xv, yv, tRR = string.match(aValue, "(.+);(.+)")
            if not tRR then
               xv, yv, tRR = string.match(aValue, "(.+);(.+) (.+)")
            end
            if not tRR then
               xv, yv, tRR = string.match(aValue, "(.+);(.+);(.+)")
            end

            xv, yv, tRR = tonumber(xv), tonumber(yv), tonumber(tRR)
            
            x = string.format("%.1f", x)
            y = string.format("%.1f", y)      
            --local xv, yv = string.match(aValue, "(.+);(.+)")   

            if xv and yv then
               if (x - xv < tRR and x - xv > -(tRR)) and (y - yv < tRR and y - yv > -(tRR)) then
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
   SkuOptions.db.char[MODULE_NAME] = SkuOptions.db.char[MODULE_NAME] or {}
   SkuOptions.db.char[MODULE_NAME].Tutorials = SkuOptions.db.char[MODULE_NAME].Tutorials or {}
   --upgrade char tutorial progress table
   SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience = SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience or 0
   --SkuOptions.db.char[MODULE_NAME].Tutorials = SkuOptions.db.char[MODULE_NAME].Tutorials or {progress = {}, logins = 0,}
   SkuOptions.db.char[MODULE_NAME].Tutorials.progress = SkuOptions.db.char[MODULE_NAME].Tutorials.progress or {}
   SkuOptions.db.char[MODULE_NAME].Tutorials.logins = SkuOptions.db.char[MODULE_NAME].Tutorials.logins or 0
   SkuOptions.db.global[MODULE_NAME].Tutorials = SkuOptions.db.global[MODULE_NAME].Tutorials or {prefix = "Custom", ["enUS"] = {}, ["deDE"] = {},}   

   --upgrade existing tutorials tables
   for i, v in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      v.GUID = v.GUID or SkuAdventureGuide.Tutorial:GetNewGUID()
      v.requirements = v.requirements or {race = 993, class = 99, skill = 999, }
      local tIsSkuNewbieTutorial = false
      if SkuOptions.db.global["SkuOptions"].devmode == true then
         tIsSkuNewbieTutorial = true
      end
      v.isSkuNewbieTutorial = v.isSkuNewbieTutorial or tIsSkuNewbieTutorial
      v.showAsTemplate = v.showAsTemplate or false

      for istep, vstep in pairs(v.steps) do
         vstep.GUID = vstep.GUID or SkuAdventureGuide.Tutorial:GetNewGUID()
         vstep.linkedFrom = vstep.linkedFrom or {}
         vstep.linkedIn = vstep.linkedIn or {}
      end
   end

   --add the tutorial help macro to MultiBarBottomLeftButton1 (F1)
   if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience == 0 then
      for x = 15, 60, 15 do
         C_Timer.After(x, function()
            SkuAdventureGuide.Tutorial.HelpMacroId = GetMacroIndexByName(L["Tutorial helper macro"])
            if not SkuAdventureGuide.Tutorial.HelpMacroId or SkuAdventureGuide.Tutorial.HelpMacroId == 0 then
               SkuAdventureGuide.Tutorial.HelpMacroId = CreateMacro(L["Tutorial helper macro"], "INV_MISC_QUESTIONMARK", '/script SkuAdventureGuide.Tutorial:OpenTutorialHelpMenu()', true)
               if SkuAdventureGuide.Tutorial.HelpMacroId then
                  local tType, tId = GetActionInfo(MultiBarBottomLeftButton1.action)
                  if not tType then
                     ClearCursor()
                     PickupMacro(SkuAdventureGuide.Tutorial.HelpMacroId)
                     PlaceAction(MultiBarBottomLeftButton1.action)
                     ClearCursor()
                  end
               end
            end
         end)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:EvaluateTriggers(aCallerString)
   if not SkuAdventureGuide.Tutorial.current.title or not SkuAdventureGuide.Tutorial.current.source or not SkuAdventureGuide.Tutorial.current.linkedStepData then
      return
   end
   if not SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title] then
      return
   end

   local tCurrentStep = SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title]
   if not SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[tCurrentStep] then
      return
   end

   local tStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[tCurrentStep].GUID)
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
      if SkuAdventureGuide.Tutorial.evaluateNextStep == true and SkuOptions.Voice.TutorialPlaying == 0 then
         SkuAdventureGuide.Tutorial:OnStepCompleted()
         return tStepResult
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:OnInitialize()

















   --temp disabled, until there are tutorials
   --SkuDispatcher:RegisterEventCallback("NAME_PLATE_UNIT_ADDED", SkuAdventureGuide.Tutorial.PlayFtuTutorialHint)
   SkuDispatcher:RegisterEventCallback("PLAYER_ENTERING_WORLD", SkuAdventureGuide.Tutorial.PLAYER_ENTERING_WORLD)

   --this frame is to catch all keys if tutorial output is running
	tFrame = _G["OnSkuOptionsKeyTrap"] or CreateFrame("Button", "OnSkuOptionsKeyTrap", _G["UIParent"], "UIPanelButtonTemplate")
	tFrame:SetSize(80, 22)
	tFrame:SetText("OnSkuOptionsKeyTrap")
	tFrame:SetPoint("TOP", _G["OnSkuOptionsMain"], "BOTTOM", 0, 0)
	tFrame:SetScript("OnKeyDown", function(self, aKey, aB)
      if SkuOptions.Voice.TutorialPlaying then
         if SkuOptions.Voice.TutorialPlaying > 0 then
            local tFullKey = aKey
            if IsAltKeyDown() == true then
               tFullKey = "ALT-"..tFullKey
            end
            if IsControlKeyDown() == true then
               tFullKey = "CTRL-"..tFullKey
            end
            if IsShiftKeyDown() == true then
               tFullKey = "SHIFT-"..tFullKey
            end

            if (tFullKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPBACK"].key or tFullKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPREPEAT"].key or tFullKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key) then
               self:SetPropagateKeyboardInput(true)
            elseif aKey == "7" and IsShiftKeyDown() == true then
               SkuOptions.Voice.TutorialPlaying = 0
               self:SetPropagateKeyboardInput(true)
               self:Hide()
            else
               if aKey ~= "LALT" and aKey ~= "RALT" and aKey ~= "RCTRL" and aKey ~= "LCTRL" and aKey ~= "LSHIFT" and aKey ~= "RSHIFT" then
                  PlaySound(88)
               end
            end
         end
      end
	end)
	tFrame:SetScript("OnKeyUp", function(self, aKey, aB)
		--print("OnKeyUp", aKey, aB, self:GetPropagateKeyboardInput())
      if SkuOptions.Voice.TutorialPlaying then
         if SkuOptions.Voice.TutorialPlaying > 0 then
            --print("   SetPropagateKeyboardInput false")
            self:SetPropagateKeyboardInput(false)
         end
      end
	end)
	tFrame:SetScript("OnChar", function(self, aKey, aB)
      --if (aKey = "a" or aKey = "s" or aKey = "d") and IsAltKeyDown() == true then
		--print("OnChar", aKey, aB, self:GetPropagateKeyboardInput())
	end)
	tFrame:Hide()
	tFrame:EnableKeyboard(true)
	tFrame:SetPropagateKeyboardInput(true)


   local f = _G["SkuAdventureGuideTutorialControl"] or CreateFrame("Frame", "SkuAdventureGuideTutorialControl", UIParent)
   local tNextCollectorCleanup = 0 
   local ttime = 0
   f:SetScript("OnUpdate", function(self, time)
      if SkuOptions.Voice.TutorialPlaying <= 0 then
         if _G["OnSkuOptionsKeyTrap"]:IsShown() == true then
            --print("hide trap")
            _G["OnSkuOptionsKeyTrap"]:Hide()
            _G["OnSkuOptionsKeyTrap"]:SetPropagateKeyboardInput(true)
         end
      else
         if _G["OnSkuOptionsKeyTrap"]:IsShown() == false then
            --print("show trap")
            _G["OnSkuOptionsKeyTrap"]:Show()
            _G["OnSkuOptionsKeyTrap"]:SetPropagateKeyboardInput(false)
         end
      end

      if SkuAdventureGuide.Tutorial.current.title then
         ttime = ttime + time
         if ttime < 0.33 then return end
         --print("TutorialPlaying", SkuOptions.Voice.TutorialPlaying)
         if tNextCollectorCleanup > 0 then
            if GetTimePreciseSec() - tNextCollectorCleanup > 20 then
               tNextCollectorCleanup = 0
               for _, v in pairs(SkuAdventureGuide.Tutorial.triggers) do
                  v.collector = {}
               end
            end
         end

         SkuAdventureGuide.Tutorial:EvaluateTriggers()
      
         ttime = 0
      end
   end)

   -- get events for GAME_EVENT
   local function tCallbackHelper(_, aEvent, ...)
      table.insert(SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.collector, aEvent)
      tNextCollectorCleanup = GetTimePreciseSec()
   end
   for x = 1, #SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.values do
      SkuDispatcher:RegisterEventCallback(SkuAdventureGuide.Tutorial.triggers.GAME_EVENT.values[x], tCallbackHelper)
   end

   -- get events for KEY_PRESS
	f:EnableKeyboard(true)
	f:SetPropagateKeyboardInput(true)
	f:SetPoint("TOP", _G["UIParent"], "BOTTOM", 0, 0)
	f:SetScript("OnKeyDown", function(self, aKey)
      table.insert(SkuAdventureGuide.Tutorial.triggers.KEY_PRESS.collector, aKey)
      tNextCollectorCleanup = GetTimePreciseSec()
	end)
end

--------------------------------------------------------------------------------------------------------------------------------------
local tNoAction
local SkuFoundtMenuPosString
function SkuAdventureGuide.Tutorial:MenuBuilderEdit(self)
   local tSource = self.parent.source
   local tTutorialName = self.parent.tutorialName
   local tPrefix = tSource.Tutorials.prefix

   --Insert new linked step
   if SkuOptions.db.global["SkuOptions"].devmode == true and tSource.Tutorials[Sku.Loc][tTutorialName].isSkuNewbieTutorial == true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert linked step"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         if aName == L["Add all steps as linked steps"] then
            for x = 1, #self.sourceSteps do
               dprint(x, "insert in", tTutorialName, "new:", #tSource.Tutorials[Sku.Loc][tTutorialName].steps + 1)
               local tStepData = self.sourceSteps[x]
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[#tSource.Tutorials[Sku.Loc][tTutorialName].steps + 1] = {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  linkedFrom = {},
                  linkedIn = {},
               }
               SkuAdventureGuide.Tutorial:LinkStep(
                  tSource.Tutorials[Sku.Loc][tTutorialName].GUID, 
                  tSource.Tutorials[Sku.Loc][tTutorialName].steps[#tSource.Tutorials[Sku.Loc][tTutorialName].steps].GUID, 
                  self.sourceTutorialGUID, 
                  self.sourceSteps[x].GUID
               )
            end

            C_Timer.After(0.01, function()
               SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
            end)
         else
            tSource.Tutorials[Sku.Loc][tTutorialName].steps[#tSource.Tutorials[Sku.Loc][tTutorialName].steps + 1] = {
               GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
               linkedFrom = {},
               linkedIn = {},
            }
            SkuAdventureGuide.Tutorial:LinkStep(tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tSource.Tutorials[Sku.Loc][tTutorialName].steps[#tSource.Tutorials[Sku.Loc][tTutorialName].steps].GUID, self.sourceTutorialGUID, self.sourceStepGUID)
            C_Timer.After(0.01, function()
               SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
            end)
         end
      end
      tNewMenuEntry.BuildChildren = function(self)
         local aSource = SkuOptions.db.global[MODULE_NAME]
         local tEmpty = 0
         for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
            if v.showAsTemplate == true and v.isSkuNewbieTutorial == true and v.GUID ~= tSource.Tutorials[Sku.Loc][tTutorialName].GUID then
               tEmpty = tEmpty + 1
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i..(aSource.Tutorials.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.OnEnter = function(self, aValue, aName)
                  local tTooltipText = ""
                  tTooltipText = tTooltipText..L["Play first time user intro"]..": "..(v.playFtuIntro == true and L["Yes"] or L["No"]).."\r\n"
                  tTooltipText = tTooltipText..L["Show for"].." "..L["Race"]..": "..tRaceRequirementValues[v.requirements.race]..", "..L["klasse"]..": "..v.requirements.class..", "..v.requirements.skill.."\r\n"
                  tTooltipText = tTooltipText..L["Lock keyboard if tutorial is playing"]..": "..(v.lockKeyboard == true and L["Yes"] or L["No"]).."\r\n"
                  tTooltipText = tTooltipText..L["Show in users tutorials list"]..": "..(v.showInUserList == true and L["Yes"] or L["No"]).."\r\n"
                  SkuOptions.currentMenuPosition.textFull = tTooltipText
               end

               tNewMenuEntry.BuildChildren = function(self)
                  for x = 1, #v.steps do
                     local tStepData = v.steps[x]
                     local tRealStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(v.steps[x].GUID)
                     local tMenuText
                     local tLinksFromText = ""
                     if SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID) > 0 then
                        tLinksFromText = " ("..SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID).." "..L["linking"]..") "
                     end          
                     if tStepData.title then
                        tMenuText = L["schritt "]..x.." "..tLinksFromText.." : "..tStepData.title
                     else
                        tMenuText = L["schritt "]..x.." ("..L["is link"]..") "..tLinksFromText.." : "..tRealStepData.title
                     end
                     local tTooltipText = tMenuText.."\r\n"
                     tTooltipText = tTooltipText..SkuAdventureGuide.Tutorial:CreateStepTooltipData(tStepData)

                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuText}, SkuGenericMenuItem)
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        SkuOptions.currentMenuPosition.textFull = tTooltipText
                        self.selectTarget.sourceStepGUID = v.steps[x].GUID
                        self.selectTarget.sourceTutorialGUID = v.GUID
                     end
                  end

                  if tEmpty ~= 0 then
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Add all steps as linked steps"]}, SkuGenericMenuItem)
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        SkuOptions.currentMenuPosition.textFull = tTooltipText
                        self.selectTarget.sourceSteps = v.steps
                        self.selectTarget.sourceTutorialGUID = v.GUID
                     end

                  end
               end
            end
         end


         
         if tEmpty == 0 then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
         end
      end
   end

   --Insert new step
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Create new step"]}, SkuGenericMenuItem)
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
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  title = tText,
                  allTriggersRequired = true,
                  dontSkipCurrentOutputs = true,
                  triggers = {},
                  beginText = "",
                  linkedFrom = {},
                  linkedIn = {},
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

   --existing steps list
   for x = 1, #tSource.Tutorials[Sku.Loc][tTutorialName].steps do
      local tStepData = tSource.Tutorials[Sku.Loc][tTutorialName].steps[x]
      local tSourceStepDataRef, tSourceStepDataVal = SkuAdventureGuide.Tutorial:GetLinkedStepData(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].GUID)

      local tTitleText
      local tLinksFromText = ""
      if SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID) > 0 then
         tLinksFromText = " ("..SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID).." "..L["linking"]..") "
      end                     
      if tStepData.title then
         tTitleText = L["schritt "]..x.." "..tLinksFromText.." : "..tStepData.title
      else
         tTitleText = L["schritt "]..x.." ("..L["is link"]..") "..tLinksFromText.." : "..tSourceStepDataRef.title
      end

      local tTooltipText = tTitleText.."\r\n"

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tTitleText}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.BuildChildren = function(self)
         --only linked steps
         if not tStepData.title then
            --convert from linked to real
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["convert from linked to real"]}, SkuGenericMenuItem)
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               local tFinalSourceStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(tStepData.GUID)
               local sourceTutI, sourceTutV = SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(tFinalSourceStepData.GUID)
               local tSTutGuid = sourceTutV.GUID
               SkuAdventureGuide.Tutorial:UnlinkStep(tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].GUID, tSTutGuid, tFinalSourceStepData.GUID)
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].title = tFinalSourceStepData.title
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].allTriggersRequired = tFinalSourceStepData.allTriggersRequired
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].dontSkipCurrentOutputs = tFinalSourceStepData.dontSkipCurrentOutputs
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText = tFinalSourceStepData.beginText
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].linkedFrom = {}
               tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].triggers = SkuOptions:TableCopy(tFinalSourceStepData.triggers, true)
               C_Timer.After(0.01, function()
                  SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
               end)
            end

            --[[
            --go to linked
            tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["go to linked"]}, SkuGenericMenuItem)
            ]]


            




         end

         --only real steps
         if tStepData.title then
            --start text
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start text"]..": "..tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText}, SkuGenericMenuItem)
            tNewMenuEntry.filterable = true
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText, function(a, b, c) 
                  local tText = SkuOptionsEditBoxEditBox:GetText()
                  if tText then
                     local tText, tError = SkuAdventureGuide.Tutorial:EditReplacePlaceholders(tText)
                     if not tText then
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
                           C_Timer.After(1, function()
                              print("error", tText, tError)
                              SkuOptions.Voice:OutputStringBTtts(tError, {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                           end)
                        end)
                     else
                        tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].beginText = tText
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
                  SkuOptions.Voice:OutputStringBTtts(L["Paste or edit text"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               SkuOptions:InjectMenuItems(self, {L["Enter text"]}, SkuGenericMenuItem)
            end

            --triggers
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Triggers"]}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.BuildChildren = function(self)
               --All Required
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["All Required"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                  self.menuStringUpdated = nil
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

               --new trigger
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["New"]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  if tNoAction then
                     return
                  end
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
                  elseif aName == L["CURRENT_COORDINATES_4"] or aName == L["CURRENT_COORDINATES_10"] or aName == L["CURRENT_COORDINATES_20"] then
                     local x, y = UnitPosition("player")
                     if x and y and x ~= 0 and y ~= 0 then
                        local tRR = 5
                        if aName == L["CURRENT_COORDINATES_10"] then
                           tRR = 10
                        elseif aName == L["CURRENT_COORDINATES_20"] then
                           tRR = 20
                        end

                        x = string.format("%.1f", x)
                        y = string.format("%.1f", y)
                        table.insert(tStepData.triggers, {type = self.triggerType, value = x..";"..y..";"..tRR})
                     end
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                     end)
                  elseif aName == L["WAIT_FOR_MENU_SELECT"] then
                     local tOldIndexString = SkuOptions:GetMenuIndexAndBreadString(SkuOptions.currentMenuPosition)
                     local function CallbackHelper(aEventName, aIndexString, aBreadString)
                        table.insert(tStepData.triggers, {type = self.triggerType, value = aIndexString})
                        C_Timer.After(0.4, function()
                           if SkuOptions:OpenMenuFromIndexString(tOldIndexString) then
                              C_Timer.After(0.001, function()
                                 SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                                 SkuFoundtMenuPosString = nil
                                 tNoAction = nil
                              end)
                           else
                              SkuFoundtMenuPosString = nil
                              tNoAction = nil
                           end
                        end)
                     end
                     SkuDispatcher:RegisterEventCallback("SKU_SLASH_MENU_ITEM_SELECTED", CallbackHelper, true)
                     tNoAction = true

                  else
                     for a, b in pairs(SkuAdventureGuide.Tutorial.triggers[self.triggerType].values) do
                        if L[b] == aName then
                           table.insert(tStepData.triggers, {type = self.triggerType, value = a})
                        end
                     end

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

               for y = 1, #tStepData.triggers do
                  local tTriggerData = tStepData.triggers[y]
                  local tText = y.." "..L[tTriggerData.type]
                  if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "ENTER_TEXT" then
                     if tonumber(tTriggerData.value) then
                        tText = tText..": "..SkuDB.NpcData.Names[Sku.Loc][tonumber(tTriggerData.value)][1].." ("..L["is creature ID"]..")"
                     else
                        tText = tText..": "..tTriggerData.value.." ("..L["is string"]..")"
                     end
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
                     tText = tText..": "..tTriggerData.value
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
                     local x, y, rr = string.match(tTriggerData.value, "(.+);(.+)")
                     local _, _, rr = string.match(tTriggerData.value, "(.+);(.+);(.+)")
                     rr = rr or 4
                     tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
                     tText = tText..": "..tTriggerData.value
                  else
                     tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value]]
                  end

                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tText}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     --resolve WAIT_FOR_MENU_SELECT trigger
                     if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Resolve menu entry"]}, SkuGenericMenuItem)
                        tNewMenuEntry.isSelect = true
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           local tOldIndexString = SkuOptions:GetMenuIndexAndBreadString(SkuOptions.currentMenuPosition)
                           if SkuFoundtMenuPosString == nil then
                              SkuFoundtMenuPosString = true
                              local tMenuPosString = SkuOptions:GetMenuStringFromIndexString(tTriggerData.value)
                              if not tMenuPosString then
                                 tMenuPosString = " > "..L["menu entry not available at the moment"]
                              end
                              C_Timer.After(0.4, function()
                                 if SkuOptions:OpenMenuFromIndexString(tOldIndexString) then
                                    C_Timer.After(0.001, function()
                                       SkuOptions.currentMenuPosition.name = SkuOptions.currentMenuPosition.name..tMenuPosString
                                       SkuOptions:VocalizeCurrentMenuName()
                                       SkuFoundtMenuPosString = nil
                                    end)
                                 else
                                    SkuFoundtMenuPosString = nil
                                 end
                              end)
                           end
                        end            
                     end

                     --delete trigger
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()                        
                        table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].triggers, y)
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                        end)
                     end            
                  end
               end
            end

            --Don't skip current outputs setting
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

            --rename step
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow(tSource.Tutorials[Sku.Loc][tTutorialName].steps[x].title, function(a, b, c) 
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
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()
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
                  local tCSub = 0
                  for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
                     if v.GUID ~= tSource.Tutorials[Sku.Loc][tTutorialName].GUID then
                        tCSub = tCSub + 1
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i}, SkuGenericMenuItem)
                        tNewMenuEntry.dynamic = true
                        tNewMenuEntry.filterable = true
                        tNewMenuEntry.BuildChildren = function(self)
                           if #v.steps > 0 then
                              for x = 1, #v.steps do
                                 local tvStepsData = SkuAdventureGuide.Tutorial:GetLinkedStepData(v.steps[x].GUID)
                                 local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert after"].." "..L["schritt "]..x..": "..tvStepsData.title}, SkuGenericMenuItem)
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
                  if tCSub == 0 then
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
                  end
               end
               --tSubMenuBuilderHelper(SkuDB)
               tSubMenuBuilderHelper(SkuOptions.db.global[MODULE_NAME])
            end
         end

         --both (real and linked) steps

         --move step
         local tNumberSteps = #tSource.Tutorials[Sku.Loc][tTutorialName].steps
         local tNumberThisStep = x
         if tNumberSteps > 1 then
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

         --insert new step here
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Create new step"].." ("..(x + 1)..") "..L["after this step"].." ("..x..")"}, SkuGenericMenuItem)
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
                     table.insert(tSource.Tutorials[Sku.Loc][tTutorialName].steps, x + 1, {
                        GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                        title = tText,
                        allTriggersRequired = true,
                        dontSkipCurrentOutputs = true,
                        triggers = {},
                        beginText = "",
                        linkedFrom = {},
                        linkedIn = {},                  
                     })
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition)
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

         --insert new link here
         if SkuOptions.db.global["SkuOptions"].devmode == true  and tSource.Tutorials[Sku.Loc][tTutorialName].isSkuNewbieTutorial == true  then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert linked step"].." ("..(x + 1)..") "..L["after this step"].." ("..x..")"}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               table.insert(tSource.Tutorials[Sku.Loc][tTutorialName].steps, x + 1, {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  linkedFrom = {},
                  linkedIn = {},
               })
         
               SkuAdventureGuide.Tutorial:LinkStep(tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tSource.Tutorials[Sku.Loc][tTutorialName].steps[x + 1].GUID, self.sourceTutorialGUID, self.sourceStepGUID)

               C_Timer.After(0.01, function()
                  SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition)
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               local aSource = SkuOptions.db.global[MODULE_NAME]
               local tEmpty = 0
               for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
                  if v.showAsTemplate == true and v.isSkuNewbieTutorial == true and v.GUID ~= tSource.Tutorials[Sku.Loc][tTutorialName].GUID then
                     tEmpty = tEmpty + 1
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i..(aSource.Tutorials.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.filterable = true
                     tNewMenuEntry.OnEnter = function(self, aValue, aName)
                        local tTooltipText = ""
                        tTooltipText = tTooltipText..L["Play first time user intro"]..": "..(v.playFtuIntro == true and L["Yes"] or L["No"]).."\r\n"
                        tTooltipText = tTooltipText..L["Show for"].." "..L["Race"]..": "..tRaceRequirementValues[v.requirements.race]..", "..L["klasse"]..": "..v.requirements.class..", "..v.requirements.skill.."\r\n"
                        tTooltipText = tTooltipText..L["Lock keyboard if tutorial is playing"]..": "..(v.lockKeyboard == true and L["Yes"] or L["No"]).."\r\n"
                        tTooltipText = tTooltipText..L["Show in users tutorials list"]..": "..(v.showInUserList == true and L["Yes"] or L["No"]).."\r\n"
                        SkuOptions.currentMenuPosition.textFull = tTooltipText
                     end
      
                     tNewMenuEntry.BuildChildren = function(self)
                        for x = 1, #v.steps do
                           local tStepData = v.steps[x]
                           local tRealStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(v.steps[x].GUID)
                           local tMenuText
                           local tLinksFromText = ""
                           if SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID) > 0 then
                              tLinksFromText = " ("..SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID).." "..L["linking"]..") "
                           end                     
                           if tStepData.title then
                              tMenuText = L["schritt "]..x.." "..tLinksFromText.." : "..tStepData.title
                           else
                              tMenuText = L["schritt "]..x.." ("..L["is link"]..") "..tLinksFromText.." : "..tRealStepData.title
                           end
                           local tTooltipText = tMenuText.."\r\n"
                           tTooltipText = tTooltipText..SkuAdventureGuide.Tutorial:CreateStepTooltipData(tStepData)
      
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tMenuText}, SkuGenericMenuItem)
                           tNewMenuEntry.OnEnter = function(self, aValue, aName)
                              SkuOptions.currentMenuPosition.textFull = tTooltipText
                              self.selectTarget.sourceStepGUID = v.steps[x].GUID
                              self.selectTarget.sourceTutorialGUID = v.GUID
                           end
                        end
                     end
                  end
               end
               
               if tEmpty == 0 then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
               end
            end
         end

         --delete step
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete"]}, SkuGenericMenuItem)
         local tNumberOfLinksToThisStep = 0
         for iLinkedinTutGuid, iLinkedinTutSteps in pairs(tStepData.linkedIn) do
            for xStepIndex = 1, #iLinkedinTutSteps do
               tNumberOfLinksToThisStep = tNumberOfLinksToThisStep + 1
            end
         end
         if tNumberOfLinksToThisStep == 0 then
            --just delete; no linked
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuAdventureGuide.Tutorial:StopCurrentTutorial()
              
               table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps, x)
               C_Timer.After(0.001, function()
                  SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
               end)
            end
         else
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.BuildChildren = function(self)
               --replace linked
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Copy this step data to all steps that are linking to this step, making them unlinked real steps. Then delete this step"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  SkuAdventureGuide.Tutorial:StopCurrentTutorial()

                  for iLinkedinTutGuid, iLinkedinTutSteps in pairs(tStepData.linkedIn) do
                     for xStepIndex = 1, #iLinkedinTutSteps do
                        if tStepData.linkedFrom.SourceTutorialGUID and tStepData.linkedFrom.SourceTutorialStepGUID then
                           --is linked
                           local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                           --unlink remote
                           SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID)
                           --relink remote
                           SkuAdventureGuide.Tutorial:LinkStep(iLinkedinTutGuid, tLinkedStepGuid, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                           --unlink this
                           SkuAdventureGuide.Tutorial:UnlinkStep(tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                        else
                           --is real
                           local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                           --unlink remote
                           SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID)
                           --update remote
                           SkuAdventureGuide.Tutorial:PutStepDataByGUID(tLinkedStepGuid, tStepData)
                        end
                     end
                  end

                  --now delete this step
                  table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps, x)
                  C_Timer.After(0.001, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                  end)
               end

               --delete linked
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete all steps that are linking this step. Then delete this step"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                  SkuAdventureGuide.Tutorial:DeleteStep(tStepData.GUID, 0)
                  C_Timer.After(0.001, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                  end)
               end
            end
         end

         --start from this step
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start from this step"]}, SkuGenericMenuItem)
         tNewMenuEntry.isSelect = true
         tNewMenuEntry.OnAction = function(self, aValue, aName)
            SkuAdventureGuide.Tutorial:StopCurrentTutorial()
            SkuOptions:CloseMenu()
            SkuAdventureGuide.Tutorial:StartTutorial(tTutorialName, x, tSource)
         end
      end

      --tooltip
      tTooltipText = tTooltipText..SkuAdventureGuide.Tutorial:CreateStepTooltipData(tStepData)
      tNewMenuEntry.OnEnter = function(self, aValue, aName)
         SkuOptions.currentMenuPosition.textFull = tTooltipText
      end
   end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:EditorMenuBuilder(aParentEntry)
   --new tutorial
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
               local tIsSkuNewbieTutorial = false
               if SkuOptions.db.global["SkuOptions"].devmode == true then
                  tIsSkuNewbieTutorial = true
               end

               SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tText] = {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  requirements = {race = 993, class = 99, skill = 999, },
                  steps = {},
                  playFtuIntro = false,
                  showInUserList = true,
                  lockKeyboard = true,
                  isSkuNewbieTutorial = tIsSkuNewbieTutorial,
                  showAsTemplate = false,
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

   --existing tutorials lists
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Existing"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   tNewMenuEntry.BuildChildren = function(self)
      function tSubMenuBuilderHelper(aSource)
         local tEmpty = 0
         for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
            --tutorial entry
            tEmpty = tEmpty + 1
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.Tutorials.prefix]..": "..i..(aSource.Tutorials.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.tutorialName = i
            tNewMenuEntry.source = aSource
            tNewMenuEntry.BuildChildren = function(self)
               --links count for steps menu option title
               local tLinkedCount = 0
               for x = 1, #aSource.Tutorials[Sku.Loc][i].steps do
                  if aSource.Tutorials[Sku.Loc][i].steps[x].linkedFrom.SourceTutorialGUID and aSource.Tutorials[Sku.Loc][i].steps[x].linkedFrom.SourceTutorialStepGUID then
                     tLinkedCount = tLinkedCount + 1
                  end
               end
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Steps"]..(tLinkedCount == 0 and "" or (" ("..tLinkedCount.." "..L["linked"]..")"))}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.BuildChildren = SkuAdventureGuide.Tutorial.MenuBuilderEdit
   
               --Start over
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start over"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                  SkuOptions:CloseMenu()                  
                  SkuAdventureGuide.Tutorial:StartTutorial(i, 1, aSource)
               end

               if tPrefix ~= "Sku" then
                  if SkuOptions.db.global["SkuOptions"].devmode == true then
                     --Show as link source
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show as link source"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.filterable = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                        return (self.parent.source.Tutorials[Sku.Loc][i].showAsTemplate == true and L["Yes"] or L["No"])
                     end
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        if aName == L["Yes"] then
                           self.parent.source.Tutorials[Sku.Loc][i].showAsTemplate = true
                        else
                           self.parent.source.Tutorials[Sku.Loc][i].showAsTemplate = false
                        end
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                        SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                     end

                     --Is Sku newbie tutorial
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Is Sku newbie tutorial"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.filterable = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                        return (self.parent.source.Tutorials[Sku.Loc][i].isSkuNewbieTutorial == true and L["Yes"] or L["No"])
                     end
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        if aName == L["Yes"] then
                           self.parent.source.Tutorials[Sku.Loc][i].isSkuNewbieTutorial = true
                        else
                           self.parent.source.Tutorials[Sku.Loc][i].isSkuNewbieTutorial = false
                        end
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                        SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                     end
                  end

                  --Play first time user intro
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Play first time user intro"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                     return (self.parent.source.Tutorials[Sku.Loc][i].playFtuIntro == true and L["Yes"] or L["No"])
                  end
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     if aName == L["Yes"] then
                        self.parent.source.Tutorials[Sku.Loc][i].playFtuIntro = true
                     else
                        self.parent.source.Tutorials[Sku.Loc][i].playFtuIntro = false
                     end
                  end
                  tNewMenuEntry.BuildChildren = function(self)
                     SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                     SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                  end
               else
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show as link source"]..": "..(self.parent.source.Tutorials[Sku.Loc][i].showAsTemplate == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Play first time user intro"]..": "..(self.parent.source.Tutorials[Sku.Loc][i].playFtuIntro == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
               end

               --Show for requirements               
               if tPrefix ~= "Sku" then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show for"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.BuildChildren = function(self)
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Race"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        for xI, xR in pairs(tRaceRequirementValues) do
                           if xR == aName then
                              self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.race = xI
                              return
                           end
                        end
                     end
                     tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                        return (tRaceRequirementValues[self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.race])
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        for xI, xR in pairs(tRaceRequirementValues) do
                           SkuOptions:InjectMenuItems(self, {xR}, SkuGenericMenuItem)
                        end
                     end

                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["klasse"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        for xI, xR in pairs(tClassRequirementValues) do
                           if xR == aName then
                              self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.class = xI
                              return
                           end
                        end
                     end
                     tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                        return (tClassRequirementValues[self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.class])
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        for xI, xR in pairs(tClassRequirementValues) do
                           SkuOptions:InjectMenuItems(self, {xR}, SkuGenericMenuItem)
                        end
                     end

                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Skill"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        for xI, xR in pairs(tSkillRequirementValues) do
                           if xR == aName then
                              self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.skill = xI
                              return
                           end
                        end
                     end
                     tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                        return (tSkillRequirementValues[self.parent.parent.source.Tutorials[Sku.Loc][i].requirements.skill])
                     end
                     tNewMenuEntry.BuildChildren = function(self)
                        for xI, xR in pairs(tSkillRequirementValues) do
                           SkuOptions:InjectMenuItems(self, {xR}, SkuGenericMenuItem)
                        end
                     end
                  end
               end

               --Lock keyboard if tutorial is playing
               if tPrefix ~= "Sku" then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Lock keyboard if tutorial is playing"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                     return (self.parent.source.Tutorials[Sku.Loc][i].lockKeyboard == true and L["Yes"] or L["No"])
                  end
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     if aName == L["Yes"] then
                        self.parent.source.Tutorials[Sku.Loc][i].lockKeyboard = true
                     else
                        self.parent.source.Tutorials[Sku.Loc][i].lockKeyboard = false
                     end
                  end
                  tNewMenuEntry.BuildChildren = function(self)
                     SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                     SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                  end
               else
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Lock keyboard if tutorial is playing"]..": "..(self.parent.source.Tutorials[Sku.Loc][i].lockKeyboard == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
               end

               --Show in users tutorials list
               if tPrefix ~= "Sku" then
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show in users tutorials list"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                     return (self.parent.source.Tutorials[Sku.Loc][i].showInUserList == true and L["Yes"] or L["No"])
                  end
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     if aName == L["Yes"] then
                        self.parent.source.Tutorials[Sku.Loc][i].showInUserList = true
                     else
                        self.parent.source.Tutorials[Sku.Loc][i].showInUserList = false
                     end
                  end
                  tNewMenuEntry.BuildChildren = function(self)
                     SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                     SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                  end
               else
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show in users tutorials list"]..": "..(self.parent.source.Tutorials[Sku.Loc][i].showInUserList == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
               end

               if aSource.Tutorials.prefix ~= "Sku" then
                  --rename tut
                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuOptions:EditBoxShow(i, function(a, b, c) 
                        local tText = SkuOptionsEditBoxEditBox:GetText()
                        if tText and tText ~= "" then
                           if self.parent.source.Tutorials[Sku.Loc][tText] then
                              SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                              SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                           else
                              SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                              local tOldData = self.parent.source.Tutorials[Sku.Loc][i]
                              self.parent.source.Tutorials[Sku.Loc][tText] = tOldData
                              self.parent.source.Tutorials[Sku.Loc][i] = nil

                              C_Timer.After(0.001, function()
                                 SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
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
                  local tNumberOfLinksToThisStep = 0
                  for tTSI = 1, #aSource.Tutorials[Sku.Loc][i].steps do
                     local tStepData = aSource.Tutorials[Sku.Loc][i].steps[tTSI]
                     for iLinkedinTutGuid, iLinkedinTutSteps in pairs(tStepData.linkedIn) do
                        for xStepIndex = 1, #iLinkedinTutSteps do
                           tNumberOfLinksToThisStep = tNumberOfLinksToThisStep + 1
                        end
                     end
                  end
                  if tNumberOfLinksToThisStep == 0 then
                     --just delete; no linked
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                        self.parent.source.Tutorials[Sku.Loc][i] = nil
                        C_Timer.After(0.001, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                        end)
                     end
                  else
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.BuildChildren = function(self)
                        --replace linked
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Copy data from steps in this tutorial to all steps that are linking to the steps in this tutorial, making them unlinked real steps. Then delete this tutorial"]}, SkuGenericMenuItem)
                        tNewMenuEntry.isSelect = true
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                           --for each step in this tut
                           for tTSI = #aSource.Tutorials[Sku.Loc][i].steps, 1, -1 do
                              --update all linked steps
                              local tStepData = aSource.Tutorials[Sku.Loc][i].steps[tTSI]
                              local tTutorialName = i
                              local tSource = self.parent.parent.source
                              for iLinkedinTutGuid, iLinkedinTutSteps in pairs(tStepData.linkedIn) do
                                 for xStepIndex = 1, #iLinkedinTutSteps do
                                    if tStepData.linkedFrom.SourceTutorialGUID and tStepData.linkedFrom.SourceTutorialStepGUID then --this is a linked step, we need to update the source for all steps that are linking to this step to the source of this step
                                       local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                                       --unlink remote
                                       SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID)
                                       --relink remote
                                       SkuAdventureGuide.Tutorial:LinkStep(iLinkedinTutGuid, tLinkedStepGuid, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                                       --unlink this
                                       SkuAdventureGuide.Tutorial:UnlinkStep(tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                                    else --this is a real step; no need to update the linking steps
                                       local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                                       --unlink remote
                                       SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.Tutorials[Sku.Loc][tTutorialName].GUID, tStepData.GUID)
                                       --update remote
                                       SkuAdventureGuide.Tutorial:PutStepDataByGUID(tLinkedStepGuid, tStepData)
                                    end
                                 end
                              end
                              --now delete this step
                              table.remove(tSource.Tutorials[Sku.Loc][tTutorialName].steps, tTSI)
                           end

                           --now delete this tut
                           self.parent.parent.source.Tutorials[Sku.Loc][i] = nil
                           C_Timer.After(0.001, function()
                              SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
                           end)
                        end
         
                        --delete linked steps
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete all steps that are linking a step in this tutorial. Then delete this tutorial"]}, SkuGenericMenuItem)
                        tNewMenuEntry.isSelect = true
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                           --delete all steps that are linking to this step
                           for tTSI = #aSource.Tutorials[Sku.Loc][i].steps, 1, -1 do
                              local tStepData = aSource.Tutorials[Sku.Loc][i].steps[tTSI]
                              SkuAdventureGuide.Tutorial:DeleteStep(tStepData.GUID, 0)
                           end
                           
                           --now delete this tut
                           self.parent.parent.source.Tutorials[Sku.Loc][i] = nil
                           C_Timer.After(0.001, function()
                              SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
                           end)
                        end
                     end
                  end
               end

               --export tutorial
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Export this tutorial"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  C_Timer.After(0.001, function()
                     SkuAdventureGuide.Tutorial:ExportTutorial(i, v)
                  end)
               end

               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Export this tutorial as text"]}, SkuGenericMenuItem)
               tNewMenuEntry.isSelect = true
               tNewMenuEntry.OnAction = function(self, aValue, aName)
                  C_Timer.After(0.001, function()
                     SkuAdventureGuide.Tutorial:ExportTutorialAsFriendlyList(i, v)
                  end)
               end
            end
         end
         return tEmpty
      end

      --if tSubMenuBuilderHelper(SkuDB) + tSubMenuBuilderHelper(SkuOptions.db.global[MODULE_NAME]) == 0 then
      if tSubMenuBuilderHelper(SkuOptions.db.global[MODULE_NAME]) == 0 then
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Empty"]}, SkuGenericMenuItem)
      end
   end

   --import tutorial(s)
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Import single tutorial"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      C_Timer.After(0.001, function()
         SkuAdventureGuide.Tutorial:ImportTutorial()
      end)
   end

   if SkuOptions.db.global["SkuOptions"].devmode == true then
      --export newb tutorials
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Export all custom Sku newbie tutorials"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         C_Timer.After(0.001, function()
            SkuAdventureGuide.Tutorial:ExportNewbieTutorials()
         end)
      end
      --import newb tutorials
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Import Sku newbie tutorials"]..". "..L["Warning: this will replace all existing custom newbie tutorials!)"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         C_Timer.After(0.001, function()
            SkuAdventureGuide.Tutorial:ImportNewbieTutorials()
         end)
      end
   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {"Reset FTU experience"}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      C_Timer.After(0.001, function()
         SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience = 0
      end)
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportTutorialAsFriendlyList(aTutorialName, aTutorialData)










   local tResult = ""
   tResult = tResult.."Titel: "..aTutorialName.."\r\n"
   tResult = tResult..L["Play first time user intro"]..": "..(aTutorialData.playFtuIntro == true and L["Yes"] or L["No"]).."\r\n"
   tResult = tResult..L["Don't skip current outputs"]..": "..(aTutorialData.steps.dontSkipCurrentOutputs == true and L["Yes"] or L["No"]).."\r\n"
   for x = 1, #aTutorialData.steps do
      local tStepData = aTutorialData.steps[x]
      tResult = tResult..""..L["schritt "]..x..": "..tStepData.title.."\r\n"
      tResult = tResult.."  "..L["Start text"]..": "..tStepData.beginText.."\r\n"
      tResult = tResult.."  "..L["Triggers"]..":".."\r\n"
      tResult = tResult.."    "..L["All Required"]..": "..(tStepData.allTriggersRequired == true and L["Yes"] or L["No"]).."\r\n"
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
         elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
            local x, y, rr = string.match(tTriggerData.value, "(.+);(.+)")
            local _, _, rr = string.match(tTriggerData.value, "(.+);(.+);(.+)")
            rr = rr or 4
            tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
         elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
            tText = tText..": "..tTriggerData.value
         else
            tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value]]
         end
         tResult = tResult.."    "..tText.."\r\n"
      end
   end

	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuOptions:EditBoxShow(tResult, function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportTutorial(aTutorialName, aTutorialData)
	if not aTutorialName or not aTutorialData then
		return
	end
	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
      lang = Sku.Loc,
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
               tTutorialData.lang = tTutorialData.lang or Sku.Loc
               if tTutorialData.lang == Sku.Loc then               
                  if not SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName] then
                     SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName] = tTutorialData.tutorialData
                     SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName].requirements = SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][tTutorialData.tutorialName].requirements or {race = 993, class = 99, skill = 999, }
                     SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()
                     SkuOptions.Voice:OutputStringBTtts(L["Tutorial imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                     return
                  else
                     SkuOptions.Voice:OutputStringBTtts(L["Error. Name already exists. Rename the existing tutorial and try again."], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                     return
                  end
               else
                  SkuOptions.Voice:OutputStringBTtts(L["Error: Data language is not current language"].." ("..tTutorialData.lang.." / "..Sku.Loc..")", {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                  return
               end
            end
         end
		end
      SkuOptions.Voice:OutputStringBTtts(L["Unknown error. Tutorial data corrupt?"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportNewbieTutorials()
   local tNewbieTutorials = {}
   for i, v in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if v.isSkuNewbieTutorial == true then
         tNewbieTutorials[i] = v
      end
   end
   
	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
      lang = Sku.Loc,
		isNewbieData = true,
		tutorialsData = tNewbieTutorials,
	}
	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ImportNewbieTutorials()
	PlaySound(88)
   SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))
		if tSerializedData ~= "" then
			local tSuccess, tTutorialData = SkuOptions:Deserialize(tSerializedData)
         if tSuccess == true and tTutorialData then
            if tTutorialData.isNewbieData and tTutorialData.isNewbieData == true then
               tTutorialData.lang = tTutorialData.lang or Sku.Loc
               if tTutorialData.lang == Sku.Loc then
                  --delete all existing newbie tuts
                  for i, v in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
                     if v.isSkuNewbieTutorial == true then
                        SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][i] = nil
                     end
                  end

                  --add imported newbie tuts
                  for i, v in pairs(tTutorialData.tutorialsData) do
                     SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][i] = v
                  end
                  SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()

                  SkuOptions.Voice:OutputStringBTtts(L["Tutorials imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                  return
               else
                  SkuOptions.Voice:OutputStringBTtts(L["Error: Data language is not current language"].." ("..tTutorialData.lang.." / "..Sku.Loc..")", {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
                  return
               end
            end
         end
		end
      SkuOptions.Voice:OutputStringBTtts(L["Unknown error. Tutorial data corrupt?"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CleanKeyBindStringHelper(aKeyBindText)
   aKeyBindText = string.gsub(aKeyBindText, "%-", " ")
   return " ("..aKeyBindText..") "
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StartTutorial(aTutorialName, aStartAtStepNumber, aSource, aSilent, aIsUser)
   dprint("StartTutorial", aTutorialName, aStartAtStepNumber, aSource, aSilent, aIsUser)
   SkuAdventureGuide.Tutorial.currentStepCompleted = false
   C_Timer.After(0.3, function()
      SkuAdventureGuide.Tutorial.current.title = aTutorialName
      SkuAdventureGuide.Tutorial.current.source = aSource
      SkuAdventureGuide.Tutorial.current.isUser = aIsUser
      SkuAdventureGuide.Tutorial.current.linkedStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(aSource.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[aStartAtStepNumber].GUID)
      
      SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title] = aStartAtStepNumber
      SkuOptions.Voice.TutorialPlaying = 0

      if aStartAtStepNumber == 1 and SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].playFtuIntro == true then
         SkuAdventureGuide.Tutorial:PlayFtuIntro()
      else
         SkuAdventureGuide.Tutorial:StartStep(SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title])
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ReReadCurrentStep()
   SkuOptions.Voice.TutorialPlaying = 0
   SkuOptions.Voice:StopOutputEmptyQueue()

   C_Timer.After(1.0, function()
      dprint("ReReadCurrentStep", SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title])

      if SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title] == 0 then
         SkuAdventureGuide.Tutorial:PlayFtuIntro()
      else
         local tCurrentStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title]].GUID)

         SkuOptions.Voice:OutputStringBTtts(SkuAdventureGuide.Tutorial:ReplacePlaceholders(tCurrentStepData.beginText), {overwrite = tCurrentStepData.dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         
         if SkuAdventureGuide.Tutorial.currentStepCompleted == true then
            C_Timer.After(0.5, function()
               SkuOptions.Voice:RegisterBttsCallback(function()
                  SkuOptions.Voice:OutputString("sound-notification8", false, true, 0.3, true)
                  if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience <= SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
                     C_Timer.After(0.4, function()
                        SkuOptions.Voice:OutputStringBTtts(SkuAdventureGuide.Tutorial:AddNextStepText(""), {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
                     end)
                  end
               end)
            end)
         end
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StartStep(aStartAtStepNumber)
   dprint("StartStep", aStartAtStepNumber)
   SkuAdventureGuide.Tutorial.evaluateNextStep = false
   SkuAdventureGuide.Tutorial.currentStepCompleted = false
   for _, v in pairs(SkuAdventureGuide.Tutorial.triggers) do
      v.collector = {}
   end

   C_Timer.After(0.1, function()
      SkuOptions.Voice:OutputString("sound-waterdrop5", false, false, 0.3, true)
      C_Timer.After(1.0, function()
         --print("StartStep", aStartAtStepNumber)
         local tCurrentStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title]].GUID)
         local tStartText = tCurrentStepData.beginText
         tStartText = SkuAdventureGuide.Tutorial:ReplacePlaceholders(tStartText)
         SkuOptions.Voice:OutputStringBTtts(tStartText, {overwrite = tCurrentStepData.dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         C_Timer.After(0.1, function()
            SkuAdventureGuide.Tutorial.evaluateNextStep = true
         end)
      end)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:PlayFtuTutorialHint(aevent)
   if not SkuOptions.db.char[MODULE_NAME].Tutorials.ftuTutorialHintPlayed then
      SkuOptions.db.char[MODULE_NAME].Tutorials.ftuTutorialHintPlayed = true
      SkuDispatcher:UnregisterEventCallback("NAME_PLATE_UNIT_ADDED", SkuAdventureGuide.Tutorial.PlayFtuTutorialHint)
      if UnitLevel("player") == 1 then
         C_Timer.After(3, function()
            local tIntroText = L["Attention, important before you get into action: If you are new to the game, you can get help with your first steps with the F1 key. If you do not know how to play the game, press F1 now to start a tutorial. Don't do other stuff first. The tutorial might fail if you do things on your own. So, if you would like assistance, press the F1 key now."]
            SkuOptions.Voice:OutputStringBTtts(tIntroText, {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         end)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:PlayFtuIntro()
   dprint("PlayFtuIntro")
   SkuAdventureGuide.Tutorial.evaluateNextStep = false
   for _, v in pairs(SkuAdventureGuide.Tutorial.triggers) do
      v.collector = {}
   end

   local tPlay = SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPREPEAT"].key ~= "" and CleanKeyBindStringHelper(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPREPEAT"].key) or " ("..L["No key bind for"].." "..L["SKU_KEY_TUTORIALSTEPREPEAT"]..") "
   local tNext = SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key ~= "" and CleanKeyBindStringHelper(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key) or " ("..L["No key bind for"].." "..L["SKU_KEY_TUTORIALSTEPFORWARD"]..") "
   local tPrev = SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPBACK"].key ~= "" and CleanKeyBindStringHelper(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPBACK"].key) or " ("..L["No key bind for"].." "..L["SKU_KEY_TUTORIALSTEPBACK"]..") "
   local tIntroText = 
   L["Hello, %name%. This is a tutorial. It will guide you step for step through how to do things in the game. In each step you will here some information or instruction on activities. Once you've complete the step activities you will hear a success sound. Then you can move on to the next tutorial step. There are 3 keyboard shortcuts in tutorials like this one:"]
   .." "..tPlay
   .." "..L["to play the instructions of the current step again."]
   .." "..tNext
   .." "..L["to move to the next step of the tutorial if you have completed the current step."]
   .." "..L["Whenever the tutorial speaks, all keys are locked. Wait until the tutorial has finished speaking. Then the keys are available again."]
   .." "..L["That's it for now. Now start the tutorial content by pressing %SKU_KEY_TUTORIALSTEPFORWARD%."] 

   tIntroText = SkuAdventureGuide.Tutorial:ReplacePlaceholders(tIntroText)
   --tIntroText = SkuAdventureGuide.Tutorial:AddNextStepText(tIntroText)

   SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title] = 0
   C_Timer.After(0.1, function()
      C_Timer.After(1.0, function()
         SkuOptions.Voice:OutputStringBTtts(tIntroText, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         SkuAdventureGuide.Tutorial.currentStepCompleted = true
      end)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:StopCurrentTutorial(aSilent)
   SkuAdventureGuide.Tutorial.evaluateNextStep = false
   SkuAdventureGuide.Tutorial.current.title = nil
   SkuAdventureGuide.Tutorial.current.source = nil
   SkuAdventureGuide.Tutorial.current.isUser = nil
   SkuAdventureGuide.Tutorial.current.linkedStepData = nil
   SkuAdventureGuide.Tutorial.currentStepCompleted = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:OnStepCompleted(aCompleteStepNumber)
   dprint("OnStepCompleted", aCompleteStepNumber)
   SkuAdventureGuide.Tutorial.evaluateNextStep = false
   SkuAdventureGuide.Tutorial.currentStepCompleted = true
   C_Timer.After(1, function()
      SkuOptions.Voice:OutputString("sound-notification8", false, false, 0.3, true)
      if not SkuAdventureGuide.Tutorial.current.source.Tutorials[Sku.Loc][SkuAdventureGuide.Tutorial.current.title].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.title] + 1] then
         SkuAdventureGuide.Tutorial:StopCurrentTutorial()
         C_Timer.After(1.5, function()
            SkuOptions.Voice:OutputStringBTtts(L["This was the last tutorial step. The tutorial is completed."], {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         end)
         return
      end
      if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience <= SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
         C_Timer.After(1.4, function()
            SkuOptions.Voice:OutputString("sound-waterdrop5", false, false, 0.3, true)
            C_Timer.After(0.1, function()
               SkuOptions.Voice:OutputStringBTtts(SkuAdventureGuide.Tutorial:AddNextStepText(""), {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
            end)
         end)      
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:EditReplacePlaceholders(aString)
   local tLastError = nil
   for x = 1, #tEditPlaceholders do
      if string.find(aString, tEditPlaceholders[x].tag) then
         local tValue, tError = tEditPlaceholders[x].value()
         if tValue then
            aString = string.gsub(aString, tEditPlaceholders[x].tag, tValue)
         else
            tLastError = tError
         end
      end
   end
   
   if tLastError then
      return nil, tLastError
   else
      return aString
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ReplacePlaceholders(aString)
   for x = 1, #tPlaceholders do
      aString = tPlaceholders[x].value(aString)
   end
   return aString
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:AddNextStepText(aString)
   if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience <= SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
      local tKey = CleanKeyBindStringHelper(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key)
      if tKey == "" then
         tKey = L["No key bind for"].." "..CleanKeyBindStringHelper(L["SKU_KEY_TUTORIALSTEPFORWARD"])..". "..L["You first need to set up that key bind in Core > Sku key binds to use this tutorial."]
         return tKey
      end
      aString = aString..". "..L["Tutorial step completed"]..". "..L["Press"].." "..tKey.." "..L["to continue with the next tutorial step"]
      if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience == SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
         aString = aString..". "..L["You won't hear this tip anymore from now on."]
      end

      SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience = SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience + 1
   end
   return aString
end

--------------------------------------------------------------------------------------------------------------------------------------
local function CheckRequirements(aRaceValue, aClassValue, aSkillValue)
   local _, _, raceID = UnitRace("player")
   local _, localizedFaction = UnitFactionGroup("player")
   local _, classId = UnitClassBase("player")
   if ((aRaceValue == raceID) or (aRaceValue == 993) or(string.lower(localizedFaction) == string.lower(tRaceRequirementValues[aRaceValue]))) and ((aClassValue == classId) or(aClassValue == 99)) then
      if aSkillValue == 999 then
         return true
      end
      local numSkills = GetNumSkillLines()
      for x = 1, numSkills do
         local locSkillName = GetSkillLineInfo(x) 
         if string.lower(locSkillName) == string.lower(tSkillRequirementValues[aSkillValue]) then
            return true
         end
      end
   end
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetBestTutorialNameForFirstTimeUser()
   local _, _, raceID = UnitRace("player")
   local _, classId = UnitClassBase("player")

   for i, v in pairs(SkuDB.Tutorials[Sku.Loc]) do
      if v.requirements.race == raceID and v.requirements.class == classId and v.isSkuNewbieTutorial == true then
         return i, tRaceRequirementValues[raceID], tClassRequirementValues[classId]
      end
   end
   return nil, tRaceRequirementValues[raceID], tClassRequirementValues[classId]
end

--------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:TutorialsMenuBuilder(aParentEntry, aIsUser)
   SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()

   local function contentHelper(tNewMenuEntry, aSource, aIsUser)
      tNewMenuEntry.BuildChildren = function(self)
         local tEmpty
         for i, v in pairs(aSource.Tutorials[Sku.Loc]) do
            if v.showInUserList ~= false and CheckRequirements(v.requirements.race, v.requirements.class, v.requirements.skill) == true then
               tEmpty = false
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {i}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.tutorialName = i
               tNewMenuEntry.source = aSource
               tNewMenuEntry.BuildChildren = function(self)
                  local tProgress = SkuOptions.db.char[MODULE_NAME].Tutorials.progress[i]
                  if tProgress and tProgress < #aSource.Tutorials[Sku.Loc][i].steps and tProgress ~= 0 then
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continue"].." ("..L["schritt "]..tProgress..")"}, SkuGenericMenuItem)
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                        SkuOptions:CloseMenu()                     
                        SkuAdventureGuide.Tutorial:StartTutorial(i, tProgress, aSource, nil, aIsUser)
                     end
                  end

                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start over"]}, SkuGenericMenuItem)
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                     SkuOptions:CloseMenu()                  
                     SkuAdventureGuide.Tutorial:StartTutorial(i, 1, aSource, nil, aIsUser)
                  end

                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Steps"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     local tSource = self.parent.source
                     local tTutorialName = self.parent.tutorialName
                     for x = 1, #tSource.Tutorials[Sku.Loc][tTutorialName].steps do
                        local tStepData = tSource.Tutorials[Sku.Loc][tTutorialName].steps[x]
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["schritt "]..x..": "..tStepData.title}, SkuGenericMenuItem)
                        tNewMenuEntry.BuildChildren = function(self)
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start from this step"]}, SkuGenericMenuItem)
                           tNewMenuEntry.isSelect = true
                           tNewMenuEntry.OnAction = function(self, aValue, aName)
                              SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                              SkuOptions:CloseMenu()                           
                              SkuAdventureGuide.Tutorial:StartTutorial(tTutorialName, x, tSource, nil, aIsUser)
                           end
                        end
                     end
                  end
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
   contentHelper(tNewMenuEntry, SkuDB, aIsUser)

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Custom"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.filterable = true
   contentHelper(tNewMenuEntry, SkuOptions.db.global[MODULE_NAME], aIsUser)

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Stop current tutorial"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuAdventureGuide.Tutorial:StopCurrentTutorial()
   end

   --import tutorial
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Import single tutorial"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      C_Timer.After(0.001, function()
         SkuAdventureGuide.Tutorial:ImportTutorial()
      end)
   end


end

--------------------------------------------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:OpenTutorialHelpMenu()
   SkuOptions:SlashFunc(L["short"]..","..L["SkuAdventureGuideMenuEntry"]..","..L["Tutorials"]..","..L["Tutorial help"])
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:LinkStep(aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
   dprint("LinkStep(", aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
   local tReturnValue = 0
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
            if sourceStepV.GUID == aSourceTutorialStepGUID then
               if not sourceStepV.linkedIn[aTargetTutorialGUID] then
                  sourceStepV.linkedIn[aTargetTutorialGUID] = {}
               end
               for x = 1, #sourceStepV.linkedIn[aTargetTutorialGUID] do
                  if sourceStepV.linkedIn[aTargetTutorialGUID][x] == aTargetTutorialStepGUID then
                     print("error. in link tut this tut step already exists. this should not happen", aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
                  end
               end
               sourceStepV.linkedIn[aTargetTutorialGUID][#sourceStepV.linkedIn[aTargetTutorialGUID] + 1] = aTargetTutorialStepGUID
               tReturnValue = tReturnValue + 1
               break
            end
         end
      end
   end

   for targetTutI, targetTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if targetTutV.GUID == aTargetTutorialGUID then
         for targetStepI, targetStepV in pairs(targetTutV.steps) do
            if targetStepV.GUID == aTargetTutorialStepGUID then
               targetStepV.linkedFrom = {
                  SourceTutorialGUID = aSourceTutorialGUID,
                  SourceTutorialStepGUID = aSourceTutorialStepGUID,
               }
               tReturnValue = tReturnValue + 1
               break
            end
         end
      end
   end

   return tReturnValue == 2 and true or nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:UnlinkStep(aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
   local tReturnValue = 0
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
            if sourceStepV.GUID == aSourceTutorialStepGUID then
               if not sourceStepV.linkedIn[aTargetTutorialGUID] then
                  print("error. aTargetTutorialGUID missing in source linkedIn.", aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
               end
               for x = 1, #sourceStepV.linkedIn[aTargetTutorialGUID] do
                  if sourceStepV.linkedIn[aTargetTutorialGUID][x] == aTargetTutorialStepGUID then
                     table.remove(sourceStepV.linkedIn[aTargetTutorialGUID], x)
                     tReturnValue = tReturnValue + 1
                     break
                  end
               end
            end
         end
      end
   end

   for targetTutI, targetTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if targetTutV.GUID == aTargetTutorialGUID then
         for targetStepI, targetStepV in pairs(targetTutV.steps) do
            if targetStepV.GUID == aTargetTutorialStepGUID then
               targetStepV.linkedFrom = {}
               tReturnValue = tReturnValue + 1
               break
            end
         end
      end
   end

   return tReturnValue == 2 and true or nil
end

---------------------------------------------------------------------------------------------------------------------------------------
local tNewGUIDSessionCounter = 0
function SkuAdventureGuide.Tutorial:GetNewGUID()
   tNewGUIDSessionCounter = tNewGUIDSessionCounter + 1
   local tNumber = string.gsub(tostring(GetServerTime()..format("%.2f", GetTimePreciseSec())), "%.", "")..format("%04d", tNewGUIDSessionCounter)
   tNumber = tNumber:gsub("%.", "")
   return tNumber
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      for y = 3, 1, -1 do --#sourceTutV.steps, 1, -1 do
         local sourceStepV = sourceTutV.steps[y]
         for targetTutorialGuidI, targetTutorialStepsGuidV in pairs(sourceStepV.linkedIn) do
            for x = #targetTutorialStepsGuidV, 1, -1 do
               if not SkuAdventureGuide.Tutorial:GetStepDataByGUID(targetTutorialStepsGuidV[x]) then
                  print("ERROR: VerifyAndCleanGUIDs: tar step guid is nil table.remove(targetTutorialStepsGuidV,", x, ")")
                  table.remove(targetTutorialStepsGuidV, x)
               else
                  local tTarD = SkuAdventureGuide.Tutorial:GetStepDataByGUID(targetTutorialStepsGuidV[x])
                  if tTarD.linkedFrom.SourceTutorialStepGUID ~= sourceStepV.GUID then
                     print("ERROR: VerifyAndCleanGUIDs: linkedin step guid isn't this step guid, remove,", sourceTutI, y, x, ")")
                     table.remove(targetTutorialStepsGuidV, x)
                  end
               end
            end
            if #targetTutorialStepsGuidV == 0 then
               --print("ERROR: VerifyAndCleanGUIDs: sourceStepV.linkedIn[", targetTutorialGuidI, "] = nil")
               --sourceStepV.linkedIn[targetTutorialGuidI] = nil
            end
         end

         if sourceStepV.linkedFrom.SourceTutorialGUID and not SkuAdventureGuide.Tutorial:GetTutorialDataByGUID(sourceStepV.linkedFrom.SourceTutorialGUID) then
            print("ERROR: VerifyAndCleanGUIDs: sourceStepV.linkedFrom.", SourceTutorialGUID, " = nil")
            sourceStepV.linkedFrom.SourceTutorialGUID = nil
         end
         if sourceStepV.linkedFrom.SourceTutorialStepGUID and not SkuAdventureGuide.Tutorial:GetStepDataByGUID(sourceStepV.linkedFrom.SourceTutorialStepGUID) then
            print("ERROR: VerifyAndCleanGUIDs: sourceStepV.linkedFrom.", SourceTutorialStepGUID, " = nil")
            sourceStepV.linkedFrom.SourceTutorialStepGUID = nil
         end
         if (not sourceStepV.linkedFrom.SourceTutorialGUID or not sourceStepV.linkedFrom.SourceTutorialStepGUID) and not sourceStepV.title then
            print("ERROR: VerifyAndCleanGUIDs: table.remove(sourceTutV.steps,", y, ")")
            table.remove(sourceTutV.steps, y)
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetTutorialDataByGUID(aSourceTutorialGUID)
   if not aSourceTutorialGUID then
      return
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         return sourceTutV, sourceTutI
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetStepDataByGUID(aSourceTutorialStepGUID)
   if not aSourceTutorialStepGUID then
      return
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            return sourceStepV, sourceStepI
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:PutStepDataByGUID(aSourceTutorialStepGUID, aNewStepData)
   if not aSourceTutorialStepGUID then
      return
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            sourceStepV.title = aNewStepData.title
            sourceStepV.allTriggersRequired = aNewStepData.allTriggersRequired
            sourceStepV.dontSkipCurrentOutputs = aNewStepData.dontSkipCurrentOutputs
            sourceStepV.triggers = aNewStepData.triggers
            sourceStepV.beginText = aNewStepData.beginText
            sourceStepV.linkedFrom = aNewStepData.linkedFrom
            --sourceStepV.linkedIn = aNewStepData.linkedIn
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(aSourceTutorialStepGUID)
   if not aSourceTutorialStepGUID then
      return
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            return sourceTutI, sourceTutV
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ResolveStepDataGUID(aStepGUID)
   local tDat = SkuAdventureGuide.Tutorial:GetStepDataByGUID(aStepGUID)
   if tDat.linkedFrom.SourceTutorialGUID and tDat.linkedFrom.SourceTutorialStepGUID then
      return tDat.linkedFrom.SourceTutorialStepGUID
   else
      return tDat
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetLinkedStepData(aTutorialStepGUID)
   if not aTutorialStepGUID then
      return
   end

   local tCount = 0
   local tResult = aTutorialStepGUID
   while type(tResult) ~= "table" do
      tResult = SkuAdventureGuide.Tutorial:ResolveStepDataGUID(tResult)
      tCount = tCount + 1
      if tCount > 100 then
         print("ERROR: This should not happen: GetLinkedStepData infinite loop", tResult, type(SkuAdventureGuide.Tutorial:ResolveStepDataGUID(tResult)))
         return
      end
   end
   return tResult, SkuOptions:TableCopy(tResult, true)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetLinkBreadText(aTutorialStepGUID)
   --print("GetLinkBreadText(", aTutorialStepGUID)
   if not aTutorialStepGUID then
      return
   end

   local tCount = 0
   local tResult = SkuAdventureGuide.Tutorial:ResolveStepDataGUID(aTutorialStepGUID)
   local tReturnText
   while type(tResult) ~= "table" do
      tCount = tCount + 1
      local tTutorialName, tTutorialData = SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(tResult)
      local tStepData, tStepNumber = SkuAdventureGuide.Tutorial:GetStepDataByGUID(tResult)
      if not tStepData.title then
         tReturnText = (tReturnText or "")..L["layer"].." "..tCount..": "..L["Step"].." "..tStepNumber..", "..L["in tutorial"]..", "..tTutorialName.."\r\n"
      else
         tReturnText = (tReturnText or "")..L["layer"].." "..tCount..": "..L["Step"].." "..tStepNumber..", "..tStepData.title..", "..L["in tutorial"]..", "..tTutorialName.."\r\n"
      end
      tResult = SkuAdventureGuide.Tutorial:ResolveStepDataGUID(tResult)
      if tCount > 100 then
         print("ERROR: This should not happen: GetLinkBreadText infinite loop", tResult, type(SkuAdventureGuide.Tutorial:ResolveStepDataGUID(tResult)))
         return
      end
   end
   return tReturnText, tCount
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(aTutorialStepGUID)
   local tStepData = SkuAdventureGuide.Tutorial:GetStepDataByGUID(aTutorialStepGUID)
   local tCount = 0
   local tLinksFromText = L["Linking to this step"]..":\r\n"
   for i, v in pairs(tStepData.linkedIn) do
      tCount = tCount + #v

      local tTutD, tTutI = SkuAdventureGuide.Tutorial:GetTutorialDataByGUID(i)
      for x = 1, #v do
         local tSd, tSi = SkuAdventureGuide.Tutorial:GetStepDataByGUID(v[x])
         tLinksFromText = tLinksFromText..tTutI..", "..L["Step"].." "..tSi.."\r\n"
      end
   end

   return tCount, tLinksFromText
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:CreateStepTooltipData(tStepData)
   local tTooltipText = ""
   local tSourceStepDataRef, tSourceStepDataVal = SkuAdventureGuide.Tutorial:GetLinkedStepData(tStepData.GUID)

   local tFinalStepData
   if tStepData.title then
      tFinalStepData = tStepData
   else
      tFinalStepData = tSourceStepDataRef
   end
   tTooltipText = tTooltipText..L["Start text"]..": "..tFinalStepData.beginText.."\r\n"
   tTooltipText = tTooltipText..L["Don't skip current outputs"]..": "..(tFinalStepData.dontSkipCurrentOutputs == true and L["Yes"] or L["No"]).."\r\n"
   tTooltipText = tTooltipText..L["Triggers"]..":".."\r\n"
   tTooltipText = tTooltipText..L["All Required"]..": "..(tFinalStepData.allTriggersRequired == true and L["Yes"] or L["No"]).."\r\n"
   for y = 1, #tFinalStepData.triggers do
      local tTriggerData = tFinalStepData.triggers[y]
      local tText = L["Trigger"].." "..y..": "..L[tTriggerData.type]
      if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "ENTER_TEXT" then
         if tonumber(tTriggerData.value) then
            tText = tText..": "..SkuDB.NpcData.Names[Sku.Loc][tonumber(tTriggerData.value)][1].." ("..L["is creature ID"]..")"
         else
            tText = tText..": "..tTriggerData.value.." ("..L["is string"]..")"
         end
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
         tText = tText..": "..tTriggerData.value
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
         local x, y, rr = string.match(tTriggerData.value, "(.+);(.+)")
         local _, _, rr = string.match(tTriggerData.value, "(.+);(.+);(.+)")
         rr = rr or 4
         tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
         tText = tText..": "..tTriggerData.value
      else
         tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value]]
      end
      tTooltipText = tTooltipText.."- "..tText.."\r\n"
   end
   local tBreadText, tCount = SkuAdventureGuide.Tutorial:GetLinkBreadText(tStepData.GUID)

   if tSourceStepDataRef and tBreadText then
      local tSourceText = L["Link history"].." ("..tCount.." "..(tCount == 1 and L["layer"] or L["layers"]).."): ".."\r\n"
      for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc]) do
         for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
            if sourceStepV.GUID == tSourceStepDataRef.GUID then
               tSourceText = tSourceText..tBreadText
            end
         end
      end
      tTooltipText = tTooltipText..tSourceText
   end

   if SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID) > 0 then
      local _, tLinksFromText = SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID)
      tTooltipText = tTooltipText..tLinksFromText.."\r\n"
   end

   return tTooltipText
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:DeleteStep(aStepGUID, aIntend)
   dprint(string.rep(" ", aIntend), "DeleteStep", aStepGUID)
   local tLinkedStepData = SkuAdventureGuide.Tutorial:GetStepDataByGUID(aStepGUID)
   for iLinkedinTutDeepGuid, iLinkedinTutDeepSteps in pairs(tLinkedStepData.linkedIn) do
      for xStepIndexDeep = 1, #iLinkedinTutDeepSteps do
         SkuAdventureGuide.Tutorial:DeleteStep(iLinkedinTutDeepSteps[xStepIndexDeep], aIntend + 2)
      end
   end

   local sourceStepV, sourceStepI = SkuAdventureGuide.Tutorial:GetStepDataByGUID(aStepGUID)
   sourceTutI, sourceTutV = SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(aStepGUID)
   dprint(string.rep(" ", aIntend), " table.remove", sourceTutI, sourceTutV.GUID, sourceStepI, sourceStepV.GUID)
   table.remove(SkuOptions.db.global[MODULE_NAME].Tutorials[Sku.Loc][sourceTutI].steps, sourceStepI)
end
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
	[990] = "hidden",
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
         local aKeyBindText = string.gsub(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPFORWARD"].key, "%-", " ")
         aKeyBindText = " ("..aKeyBindText..") "
         aString = string.gsub(aString, "%%SKU_KEY_TUTORIALSTEPFORWARD%%", aKeyBindText)
         return aString
      end,
   },
   [4] = {
      tag = "%%SKU_KEY_TUTORIALSTEPREPEAT%%",
      value = function(aString) 
         local aKeyBindText = string.gsub(SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_TUTORIALSTEPREPEAT"].key, "%-", " ")
         aKeyBindText = " ("..aKeyBindText..") "
         aString = string.gsub(aString, "%%SKU_KEY_TUTORIALSTEPREPEAT%%", aKeyBindText)
         return aString
      end,
   },
   [5] = {
      tag = "%%(npc_id)%:(%d+)%%",
      value = function(aString) 
         for tType, tId in string.gmatch(aString, "%%(npc_id)%:(%d+)%%") do 
            if tId then
               local tName = L["INCORRECT CREATURE ID"].." "..tId
               if SkuDB.NpcData.Names[Sku.Loc][tonumber(tId)] then
                  tName = SkuDB.NpcData.Names[Sku.Loc][tonumber(tId)][1]
               end
               aString = string.gsub(aString, "%%(npc_id)%:"..tId.."%%", tName)
            end
         end
         return aString
      end,
   },
   [6] = {
      tag = "%%race%%",
      value = function(aString) 
         local raceName = UnitRace("player")
         aString = string.gsub(aString, "%%race%%", raceName)
         return aString
      end,
   },

}

---------------------------------------------------------------------------------------------------------------------------------------
SkuAdventureGuide.Tutorial = {}
SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps = 3
SkuAdventureGuide.Tutorial.currentStepCompleted = false
SkuAdventureGuide.Tutorial.evaluateNextStep = false
SkuAdventureGuide.Tutorial.current = {
   linkedStepData = nil,
   guid = nil,
   current = nil,
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
      translate = true,
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
      translate = true,
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
   SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience = SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience or 0
   SkuOptions.db.char[MODULE_NAME].Tutorials.progress = SkuOptions.db.char[MODULE_NAME].Tutorials.progress or {}
   SkuOptions.db.char[MODULE_NAME].Tutorials.logins = SkuOptions.db.char[MODULE_NAME].Tutorials.logins or 0
   SkuOptions.db.global[MODULE_NAME].AllLangs = SkuOptions.db.global[MODULE_NAME].AllLangs or {}
   SkuOptions.db.global[MODULE_NAME].AllLangs.prefix = "Custom"
   SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials = SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials or {}   
   SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials.prefix = nil

   --upgrade existing tutorials tables
   for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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
   if not SkuAdventureGuide.Tutorial.current.guid or not SkuAdventureGuide.Tutorial.current.source or not SkuAdventureGuide.Tutorial.current.linkedStepData then
      return
   end
   if not SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid] then
      return
   end

   local tCurrentStep = SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid]
   if not SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[tCurrentStep] then
      return
   end

   local tStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[tCurrentStep].GUID)
   local tStepResult = true == tStepData.allTriggersRequired

   for x = 1, #tStepData.triggers do
      local tValidatorResult = SkuAdventureGuide.Tutorial.triggers[tStepData.triggers[x].type].validator(tStepData.triggers[x].value[Sku.Loc])
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
   SkuDispatcher:RegisterEventCallback("NAME_PLATE_UNIT_ADDED", SkuAdventureGuide.Tutorial.PlayFtuTutorialHint)
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

      if SkuAdventureGuide.Tutorial.current.guid then
         ttime = ttime + time
         if ttime < 0.33 then return end
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
   local tTutorialGuid = self.parent.tutorialGuid
   local tPrefix = tSource.AllLangs.prefix

   --Insert new linked step
   if SkuOptions.db.global["SkuOptions"].devmode == true and tSource.AllLangs.Tutorials[tTutorialGuid].isSkuNewbieTutorial == true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert linked step"]}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      tNewMenuEntry.filterable = true
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self, aValue, aName)
         if aName == L["Add all steps as linked steps"] then
            for x = 1, #self.sourceSteps do
               dprint(x, "insert in", tTutorialGuid, "new:", #tSource.AllLangs.Tutorials[tTutorialGuid].steps + 1)
               local tStepData = self.sourceSteps[x]
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps + 1] = {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  linkedFrom = {},
                  linkedIn = {},
               }
               SkuAdventureGuide.Tutorial:LinkStep(
                  tSource.AllLangs.Tutorials[tTutorialGuid].GUID, 
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps].GUID, 
                  self.sourceTutorialGUID, 
                  self.sourceSteps[x].GUID
               )
            end

            C_Timer.After(0.01, function()
               SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
            end)
         else
            tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps + 1] = {
               GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
               linkedFrom = {},
               linkedIn = {},
            }
            SkuAdventureGuide.Tutorial:LinkStep(tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps].GUID, self.sourceTutorialGUID, self.sourceStepGUID)
            C_Timer.After(0.01, function()
               SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
            end)
         end
      end
      tNewMenuEntry.BuildChildren = function(self)
         local aSource = SkuOptions.db.global[MODULE_NAME]
         local tEmpty = 0
         local tSortedList = {}
         for k, v in SkuSpairs(aSource.AllLangs.Tutorials, function(t,a,b) return t[b].tutorialTitle[Sku.Loc] > t[a].tutorialTitle[Sku.Loc] end) do tSortedList[#tSortedList+1] = {name = k, data = v} end
         for w = 1, #tSortedList do
            local iGuid, v = tSortedList[w].name,tSortedList[w].data         
            if v.showAsTemplate == true and v.isSkuNewbieTutorial == true and v.GUID ~= tSource.AllLangs.Tutorials[tTutorialGuid].GUID then
               tEmpty = tEmpty + 1
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.AllLangs.prefix]..": "..v.tutorialTitle[Sku.Loc]..(aSource.AllLangs.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
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
                        tMenuText = L["schritt "]..x.." : "..tStepData.title[Sku.Loc].." "..tLinksFromText
                     else
                        tMenuText = L["schritt "]..x.." ("..L["is link"]..") : "..tRealStepData.title[Sku.Loc].." "..tLinksFromText
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
            for x = 1, #tSource.AllLangs.Tutorials[tTutorialGuid].steps do
               if tText ~= "" and tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title and tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title[Sku.Loc] == tText then
                  tNameExists = true
               end
            end
            if tNameExists == true then
               SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
            else
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps + 1] = {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  title = {},
                  allTriggersRequired = true,
                  dontSkipCurrentOutputs = true,
                  triggers = {},
                  beginText = {},
                  linkedFrom = {},
                  linkedIn = {},
               }

               SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps].title, tText)
               SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[#tSource.AllLangs.Tutorials[tTutorialGuid].steps].beginText, "")

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
   for x = 1, #tSource.AllLangs.Tutorials[tTutorialGuid].steps do
      local tStepData = tSource.AllLangs.Tutorials[tTutorialGuid].steps[x]
      local tSourceStepDataRef, tSourceStepDataVal = SkuAdventureGuide.Tutorial:GetLinkedStepData(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].GUID)

      local tTitleText
      local tLinksFromText = ""
      if SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID) > 0 then
         tLinksFromText = " ("..SkuAdventureGuide.Tutorial:GetNumberOfStepsThatLinkToThisTep(tStepData.GUID).." "..L["linking"]..") "
      end                     
      if tStepData.title then
         tTitleText = L["schritt "]..x.." : "..tStepData.title[Sku.Loc].." "..tLinksFromText
      else
         tTitleText = L["schritt "]..x.." ("..L["is link"]..") : "..tSourceStepDataRef.title[Sku.Loc].." "..tLinksFromText
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
               SkuAdventureGuide.Tutorial:UnlinkStep(tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].GUID, tSTutGuid, tFinalSourceStepData.GUID)
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title = SkuOptions:TableCopy(tFinalSourceStepData.title, true)
               if tFinalSourceStepData.allTriggersRequired == true then
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].allTriggersRequired = true
               else
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].allTriggersRequired = false
               end
               if tFinalSourceStepData.dontSkipCurrentOutputs == true then
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].dontSkipCurrentOutputs = true
               else
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].dontSkipCurrentOutputs = false
               end
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].beginText = SkuOptions:TableCopy(tFinalSourceStepData.beginText, true)
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].linkedFrom = {}
               tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].triggers = SkuOptions:TableCopy(tFinalSourceStepData.triggers, true)
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
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start text"]..": "..tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].beginText[Sku.Loc]}, SkuGenericMenuItem)
            tNewMenuEntry.filterable = true
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               SkuOptions:EditBoxShow(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].beginText[Sku.Loc], function(a, b, c) 
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
                        SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].beginText, tText)
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
                           table.insert(tStepData.triggers, {
                              type = self.triggerType, 
                              value = {},
                           })

                           for langi, langv in pairs(Sku.Locs) do
                              if langv ~= Sku.Loc then
                                 if SkuAdventureGuide.Tutorial.triggers[self.triggerType].translate == true and tonumber(tText) == nil then
                                    tStepData.triggers[#tStepData.triggers].value[langv] = "UNTRANSLATED:"..tText
                                 else
                                    tStepData.triggers[#tStepData.triggers].value[langv] = tText
                                 end
                              end
                           end
                           tStepData.triggers[#tStepData.triggers].value[Sku.Loc] = tText

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
                        table.insert(tStepData.triggers, {
                           type = self.triggerType, 
                           value = {},
                        })
                        for langi, langv in pairs(Sku.Locs) do
                           if langv ~= Sku.Loc and (SkuAdventureGuide.Tutorial.triggers[self.triggerType].translate and not tonumber(tId)) == true then
                              tStepData.triggers[#tStepData.triggers].value[langv] = "UNTRANSLATED:"..tId
                           else
                              tStepData.triggers[#tStepData.triggers].value[langv] = tId
                           end
                        end                        
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
                        table.insert(tStepData.triggers, {
                           type = self.triggerType,
                           value = {},
                        })
                        for langi, langv in pairs(Sku.Locs) do
                           if langv ~= Sku.Loc and (SkuAdventureGuide.Tutorial.triggers[self.triggerType].translate and not tonumber(x..";"..y..";"..tRR)) == true then
                              tStepData.triggers[#tStepData.triggers].value[langv] = "UNTRANSLATED:"..x..";"..y..";"..tRR
                           else
                              tStepData.triggers[#tStepData.triggers].value[langv] = x..";"..y..";"..tRR
                           end
                        end                        
                     end
                     C_Timer.After(0.001, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)						
                     end)
                  elseif aName == L["WAIT_FOR_MENU_SELECT"] then
                     local tOldIndexString = SkuOptions:GetMenuIndexAndBreadString(SkuOptions.currentMenuPosition)
                     local function CallbackHelper(aSource, aEventName, aIndexString, aBreadString, a, b)
                        table.insert(tStepData.triggers, {
                           type = self.triggerType,
                           value = {},
                        })
                        for langi, langv in pairs(Sku.Locs) do
                           if langv ~= Sku.Loc and (SkuAdventureGuide.Tutorial.triggers[self.triggerType].translate and not tonumber(aIndexString)) == true then
                              tStepData.triggers[#tStepData.triggers].value[langv] = "UNTRANSLATED:"..aIndexString
                           else
                              tStepData.triggers[#tStepData.triggers].value[langv] = aIndexString
                           end
                        end                           
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
                           table.insert(tStepData.triggers, {
                              type = self.triggerType,
                              value = {},
                           })
                           for langi, langv in pairs(Sku.Locs) do
                              if langv ~= Sku.Loc and (SkuAdventureGuide.Tutorial.triggers[self.triggerType].translate and not tonumber(a)) == true then
                                 tStepData.triggers[#tStepData.triggers].value[langv] = "UNTRANSLATED:"..a
                              else
                                 tStepData.triggers[#tStepData.triggers].value[langv] = a
                              end
                           end                        
   
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
                     if tonumber(tTriggerData.value[Sku.Loc]) then
                        tText = tText..": "..SkuDB.NpcData.Names[Sku.Loc][tonumber(tTriggerData.value[Sku.Loc])][1].." ("..L["is creature ID"]..")"
                     else
                        tText = tText..": "..tTriggerData.value[Sku.Loc].." ("..L["is string"]..")"
                     end
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
                     tText = tText..": "..tTriggerData.value[Sku.Loc]
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
                     local x, y, rr = string.match(tTriggerData.value[Sku.Loc], "(.+);(.+)")
                     local _, _, rr = string.match(tTriggerData.value[Sku.Loc], "(.+);(.+);(.+)")
                     rr = rr or 4
                     tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
                  elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
                     tText = tText..": "..tTriggerData.value[Sku.Loc]
                  else
                     tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value[Sku.Loc]]]
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
                              local tMenuPosString = SkuOptions:GetMenuStringFromIndexString(tTriggerData.value[Sku.Loc])
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
                        table.remove(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].triggers, y)
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
               SkuOptions:EditBoxShow(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title[Sku.Loc], function(a, b, c) 
                  local tText = SkuOptionsEditBoxEditBox:GetText()
                  if tText then
                     local tExists = false
                     local tStepDat = tSource.AllLangs.Tutorials[tTutorialGuid].steps
                     for w = 1, #tStepDat do
                        if w ~= x and tStepDat[w].title and tStepDat[w].title[Sku.Loc] == tText then
                           tExists = true
                        end
                     end
                     if tExists == true and tText ~= "" then
                        SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                        SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                     else
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                        SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title, tText)
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
               local tSourceStepDat = tSource.AllLangs.Tutorials[tTutorialGuid].steps[x]
               table.insert(self.source.AllLangs.Tutorials[Sku.Loc][self.tTargetTutorialGuid].steps,  self.tTargetStepNumber + 1, tSourceStepDat)
               C_Timer.After(0.001, function()
                  SkuOptions.currentMenuPosition:OnUpdate(SkuOptions.currentMenuPosition)
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               function tSubMenuBuilderHelper(aSource)
                  local tCSub = 0
                  local tSortedList = {}
                  for k, v in SkuSpairs(aSource.AllLangs.Tutorials, function(t,a,b) return t[b].tutorialTitle[Sku.Loc] > t[a].tutorialTitle[Sku.Loc] end) do tSortedList[#tSortedList+1] = {name = k, data = v} end
                  for w = 1, #tSortedList do
                     local v = tSortedList[w].data                  
                     if v.GUID ~= tSource.AllLangs.Tutorials[tTutorialGuid].GUID then
                        tCSub = tCSub + 1
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.AllLangs.prefix]..": "..tSortedList[w].data.tutorialTitle[Sku.Loc]}, SkuGenericMenuItem)
                        tNewMenuEntry.dynamic = true
                        tNewMenuEntry.filterable = true
                        tNewMenuEntry.BuildChildren = function(self)
                           if #v.steps > 0 then
                              for x = 1, #v.steps do
                                 local tvStepsData = SkuAdventureGuide.Tutorial:GetLinkedStepData(v.steps[x].GUID)
                                 local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert after"].." "..L["schritt "]..x..": "..tvStepsData.title[Sku.Loc]}, SkuGenericMenuItem)
                                 tNewMenuEntry.OnEnter = function(self, aValue, aName)
                                    tNewMenuEntry.selectTarget.tTargetTutorialGuid = tSortedList[w].data.GUID
                                    tNewMenuEntry.selectTarget.tTargetStepNumber = x
                                    tNewMenuEntry.selectTarget.source = aSource
                                 end
                              end
                           else
                              local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert"]}, SkuGenericMenuItem)
                              tNewMenuEntry.OnEnter = function(self, aValue, aName)
                                 tNewMenuEntry.selectTarget.tTargetTutorialGuid = tSortedList[w].data.GUID
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

         --for both (real and linked) steps

         --move step
         local tNumberSteps = #tSource.AllLangs.Tutorials[tTutorialGuid].steps
         local tNumberThisStep = x
         if tNumberSteps > 1 then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Move Step"]}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               local tStepDat = tSource.AllLangs.Tutorials[tTutorialGuid].steps
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
                  for x = 1, #tSource.AllLangs.Tutorials[tTutorialGuid].steps do
                     if tText ~= "" and tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title and tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].title[Sku.Loc] == tText then
                        tNameExists = true
                     end
                  end
                  if tNameExists == true then
                     SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                     SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                  else
                     table.insert(tSource.AllLangs.Tutorials[tTutorialGuid].steps, x + 1, {
                        GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                        title = {},
                        allTriggersRequired = true,
                        dontSkipCurrentOutputs = true,
                        triggers = {},
                        beginText = {},
                        linkedFrom = {},
                        linkedIn = {},
                     })

                     SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x + 1].title, tText)
                     SkuAdventureGuide.Tutorial:UpdateTranslations(tSource.AllLangs.Tutorials[tTutorialGuid].steps[x + 1].beginText, "")

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
         if SkuOptions.db.global["SkuOptions"].devmode == true  and tSource.AllLangs.Tutorials[tTutorialGuid].isSkuNewbieTutorial == true  then
            local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Insert linked step"].." ("..(x + 1)..") "..L["after this step"].." ("..x..")"}, SkuGenericMenuItem)
            tNewMenuEntry.dynamic = true
            tNewMenuEntry.filterable = true
            tNewMenuEntry.isSelect = true
            tNewMenuEntry.OnAction = function(self, aValue, aName)
               table.insert(tSource.AllLangs.Tutorials[tTutorialGuid].steps, x + 1, {
                  GUID = SkuAdventureGuide.Tutorial:GetNewGUID(),
                  linkedFrom = {},
                  linkedIn = {},
               })
         
               SkuAdventureGuide.Tutorial:LinkStep(tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tSource.AllLangs.Tutorials[tTutorialGuid].steps[x + 1].GUID, self.sourceTutorialGUID, self.sourceStepGUID)

               C_Timer.After(0.01, function()
                  SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition)
               end)
            end
            tNewMenuEntry.BuildChildren = function(self)
               local aSource = SkuOptions.db.global[MODULE_NAME]
               local tEmpty = 0
               local tSortedList = {}
               for k, v in SkuSpairs(aSource.AllLangs.Tutorials, function(t,a,b) return t[b].tutorialTitle[Sku.Loc] > t[a].tutorialTitle[Sku.Loc] end) do tSortedList[#tSortedList+1] = {name = k, data = v} end
               for w = 1, #tSortedList do
                  local v = tSortedList[w].data               
                  if v.showAsTemplate == true and v.isSkuNewbieTutorial == true and v.GUID ~= tSource.AllLangs.Tutorials[tTutorialGuid].GUID then
                     tEmpty = tEmpty + 1
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L[aSource.AllLangs.prefix]..": "..tSortedList[w].data.tutorialTitle[Sku.Loc]..(aSource.AllLangs.prefix == "Sku" and " ("..L["read only"]..")" or "")}, SkuGenericMenuItem)
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
                              tMenuText = L["schritt "]..x.." : "..tStepData.title[Sku.Loc].." "..tLinksFromText
                           else
                              tMenuText = L["schritt "]..x.." ("..L["is link"]..") : "..tRealStepData.title[Sku.Loc].." "..tLinksFromText
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
              
               SkuAdventureGuide.Tutorial:UnlinkStep(
                  tSource.AllLangs.Tutorials[tTutorialGuid].GUID, 
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].GUID, 
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].linkedFrom.SourceTutorialGUID,
                  tSource.AllLangs.Tutorials[tTutorialGuid].steps[x].linkedFrom.SourceTutorialStepGUID
               )

               table.remove(tSource.AllLangs.Tutorials[tTutorialGuid].steps, x)
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
                           SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID)
                           --relink remote
                           SkuAdventureGuide.Tutorial:LinkStep(iLinkedinTutGuid, tLinkedStepGuid, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                           --unlink this
                           SkuAdventureGuide.Tutorial:UnlinkStep(tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                        else
                           --is real
                           local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                           --unlink remote
                           SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID)
                           --update remote
                           SkuAdventureGuide.Tutorial:PutStepDataByGUID(tLinkedStepGuid, tStepData)
                        end
                     end
                  end

                  --now delete this step
                  table.remove(tSource.AllLangs.Tutorials[tTutorialGuid].steps, x)
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
            SkuAdventureGuide.Tutorial:StartTutorial(tTutorialGuid, x, tSource)
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
            local tExists
            for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
               if v.tutorialTitle[Sku.Loc] == tText then
                  tExists = true
               end
            end

            if tExists then
               SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
            else
               local tIsSkuNewbieTutorial = false
               if SkuOptions.db.global["SkuOptions"].devmode == true then
                  tIsSkuNewbieTutorial = true
               end

               local tNewGuid = SkuAdventureGuide.Tutorial:GetNewGUID()
               SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tNewGuid] = {
                  GUID = tNewGuid,
                  tutorialTitle = {},
                  requirements = {race = 993, class = 99, skill = 999, },
                  steps = {},
                  playFtuIntro = false,
                  showInUserList = true,
                  lockKeyboard = true,
                  isSkuNewbieTutorial = tIsSkuNewbieTutorial,
                  showAsTemplate = false,
               }

               for langi, langv in pairs(Sku.Locs) do
                  if langv ~= Sku.Loc then
                     SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tNewGuid].tutorialTitle[langv] = "UNTRANSLATED:"..tText
                  else
                     SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tNewGuid].tutorialTitle[langv] = tText
                  end
               end      

               C_Timer.After(0.001, function()
                  SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
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

         local tSortedList = {}
         for k, v in SkuSpairs(aSource.AllLangs.Tutorials, function(t,a,b) return t[b].tutorialTitle[Sku.Loc] > t[a].tutorialTitle[Sku.Loc] end) do tSortedList[#tSortedList+1] = {name = k, data = v} end
         for w = 1, #tSortedList do
            local i, v = tSortedList[w].data.tutorialTitle[Sku.Loc], tSortedList[w].data
            if aSource.AllLangs.Tutorials[v.GUID] then
               --tutorial entry
               tEmpty = tEmpty + 1

               local tExportedText = ""
               if v.exported ~= nil then
                  tExportedText = " (locked, exported) "
               end

               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v.tutorialTitle[Sku.Loc]..(aSource.AllLangs.prefix == "Sku" and " ("..L["read only"]..")" or "")..tExportedText}, SkuGenericMenuItem)
               tNewMenuEntry.tutorialName = v.tutorialTitle[Sku.Loc]
               tNewMenuEntry.tutorialGuid = v.GUID
               tNewMenuEntry.source = aSource
               if v.exported == nil then
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     --links count for steps menu option title
                     local tLinkedCount = 0
                     for x = 1, #aSource.AllLangs.Tutorials[v.GUID].steps do
                        if aSource.AllLangs.Tutorials[v.GUID].steps[x].linkedFrom.SourceTutorialGUID and aSource.AllLangs.Tutorials[v.GUID].steps[x].linkedFrom.SourceTutorialStepGUID then
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
                        SkuAdventureGuide.Tutorial:StartTutorial(v.GUID, 1, aSource)
                     end

                     if tPrefix ~= "Sku" then
                        if SkuOptions.db.global["SkuOptions"].devmode == true then
                           --Show as link source
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show as link source"]}, SkuGenericMenuItem)
                           tNewMenuEntry.dynamic = true
                           tNewMenuEntry.filterable = true
                           tNewMenuEntry.isSelect = true
                           tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                              return (self.parent.source.AllLangs.Tutorials[v.GUID].showAsTemplate == true and L["Yes"] or L["No"])
                           end
                           tNewMenuEntry.OnAction = function(self, aValue, aName)
                              if aName == L["Yes"] then
                                 self.parent.source.AllLangs.Tutorials[v.GUID].showAsTemplate = true
                              else
                                 self.parent.source.AllLangs.Tutorials[v.GUID].showAsTemplate = false
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
                              return (self.parent.source.AllLangs.Tutorials[v.GUID].isSkuNewbieTutorial == true and L["Yes"] or L["No"])
                           end
                           tNewMenuEntry.OnAction = function(self, aValue, aName)
                              if aName == L["Yes"] then
                                 self.parent.source.AllLangs.Tutorials[v.GUID].isSkuNewbieTutorial = true
                              else
                                 self.parent.source.AllLangs.Tutorials[v.GUID].isSkuNewbieTutorial = false
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
                           return (self.parent.source.AllLangs.Tutorials[v.GUID].playFtuIntro == true and L["Yes"] or L["No"])
                        end
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           if aName == L["Yes"] then
                              self.parent.source.AllLangs.Tutorials[v.GUID].playFtuIntro = true
                           else
                              self.parent.source.AllLangs.Tutorials[v.GUID].playFtuIntro = false
                           end
                        end
                        tNewMenuEntry.BuildChildren = function(self)
                           SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                           SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                        end
                     else
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show as link source"]..": "..(self.parent.source.AllLangs.Tutorials[v.GUID].showAsTemplate == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Play first time user intro"]..": "..(self.parent.source.AllLangs.Tutorials[v.GUID].playFtuIntro == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
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
                                    self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.race = xI
                                    return
                                 end
                              end
                           end
                           tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                              return (tRaceRequirementValues[self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.race])
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
                                    self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.class = xI
                                    return
                                 end
                              end
                           end
                           tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                              return (tClassRequirementValues[self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.class])
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
                                    self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.skill = xI
                                    return
                                 end
                              end
                           end
                           tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                              return (tSkillRequirementValues[self.parent.parent.source.AllLangs.Tutorials[v.GUID].requirements.skill])
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
                           return (self.parent.source.AllLangs.Tutorials[v.GUID].lockKeyboard == true and L["Yes"] or L["No"])
                        end
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           if aName == L["Yes"] then
                              self.parent.source.AllLangs.Tutorials[v.GUID].lockKeyboard = true
                           else
                              self.parent.source.AllLangs.Tutorials[v.GUID].lockKeyboard = false
                           end
                        end
                        tNewMenuEntry.BuildChildren = function(self)
                           SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                           SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                        end
                     else
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Lock keyboard if tutorial is playing"]..": "..(self.parent.source.AllLangs.Tutorials[v.GUID].lockKeyboard == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
                     end

                     --Show in users tutorials list
                     if tPrefix ~= "Sku" then
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show in users tutorials list"]}, SkuGenericMenuItem)
                        tNewMenuEntry.dynamic = true
                        tNewMenuEntry.filterable = true
                        tNewMenuEntry.isSelect = true
                        tNewMenuEntry.GetCurrentValue = function(self, aValue, aName)
                           return (self.parent.source.AllLangs.Tutorials[v.GUID].showInUserList == true and L["Yes"] or L["No"])
                        end
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           if aName == L["Yes"] then
                              self.parent.source.AllLangs.Tutorials[v.GUID].showInUserList = true
                           else
                              self.parent.source.AllLangs.Tutorials[v.GUID].showInUserList = false
                           end
                        end
                        tNewMenuEntry.BuildChildren = function(self)
                           SkuOptions:InjectMenuItems(self, {L["Yes"]}, SkuGenericMenuItem)
                           SkuOptions:InjectMenuItems(self, {L["No"]}, SkuGenericMenuItem)
                        end
                     else
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Show in users tutorials list"]..": "..(self.parent.source.AllLangs.Tutorials[v.GUID].showInUserList == true and L["Yes"] or L["No"])}, SkuGenericMenuItem)
                     end

                     if aSource.AllLangs.prefix ~= "Sku" then
                        --rename tut
                        local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Rename"]}, SkuGenericMenuItem)
                        tNewMenuEntry.isSelect = true
                        tNewMenuEntry.OnAction = function(self, aValue, aName)
                           SkuOptions:EditBoxShow(i, function(a, b, c) 
                              local tText = SkuOptionsEditBoxEditBox:GetText()
                              if tText and tText ~= "" then
                                 local tNameExists = false
                                 for xi, xv in pairs(self.parent.source.AllLangs.Tutorials) do
                                    if tText ~= "" and xv.tutorialTitle[Sku.Loc] == tText then
                                       tNameExists = true
                                    end
                                 end
                                 if tNameExists == true then
                                    SkuOptions.Voice:OutputStringBTtts(L["name schon vorhanden"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
                                    SkuOptions.Voice:OutputStringBTtts(SkuOptions.currentMenuPosition.name, {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, })
                                 else
                                    SkuAdventureGuide.Tutorial:StopCurrentTutorial()

                                    C_Timer.After(0.05, function()
                                       SkuOptions.currentMenuPosition.parent:OnSelect(SkuOptions.currentMenuPosition.parent)
                                       SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                                    end)
                                    C_Timer.After(0.1, function()
                                       SkuAdventureGuide.Tutorial:UpdateTranslations(self.parent.source.AllLangs.Tutorials[v.GUID].tutorialTitle, tText)
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
                        for tTSI = 1, #aSource.AllLangs.Tutorials[v.GUID].steps do
                           local tStepData = aSource.AllLangs.Tutorials[v.GUID].steps[tTSI]
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

                              C_Timer.After(0.05, function()
                                 SkuOptions.currentMenuPosition.parent:OnSelect(SkuOptions.currentMenuPosition.parent)
                                 SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
                              end)
                              C_Timer.After(0.1, function()
                                 for tTSI = #aSource.AllLangs.Tutorials[v.GUID].steps, 1, -1 do
                                    --unlink and delete step
                                    local tStepData = aSource.AllLangs.Tutorials[v.GUID].steps[tTSI]
                                    SkuAdventureGuide.Tutorial:UnlinkStep(aSource.AllLangs.Tutorials[v.GUID].GUID, tStepData.GUID, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                                    table.remove(aSource.AllLangs.Tutorials[v.GUID].steps, x)
                                 end
                                 aSource.AllLangs.Tutorials[v.GUID] = nil
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

                                 C_Timer.After(0.05, function()
                                    SkuOptions.currentMenuPosition.parent.parent:OnSelect(SkuOptions.currentMenuPosition.parent.parent)
                                    SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
                                 end)

                                 C_Timer.After(0.1, function()
                                    --for each step in this tut
                                    for tTSI = #aSource.AllLangs.Tutorials[v.GUID].steps, 1, -1 do
                                       --update all linked steps
                                       local tStepData = aSource.AllLangs.Tutorials[v.GUID].steps[tTSI]
                                       local tTutorialGuid = i
                                       local tSource = self.parent.parent.source
                                       for iLinkedinTutGuid, iLinkedinTutSteps in pairs(tStepData.linkedIn) do
                                          for xStepIndex = 1, #iLinkedinTutSteps do
                                             if tStepData.linkedFrom.SourceTutorialGUID and tStepData.linkedFrom.SourceTutorialStepGUID then --this is a linked step, we need to update the source for all steps that are linking to this step to the source of this step
                                                local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                                                --unlink remote
                                                SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID)
                                                --relink remote
                                                SkuAdventureGuide.Tutorial:LinkStep(iLinkedinTutGuid, tLinkedStepGuid, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                                                --unlink this
                                                SkuAdventureGuide.Tutorial:UnlinkStep(tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID, tStepData.linkedFrom.SourceTutorialGUID, tStepData.linkedFrom.SourceTutorialStepGUID)
                                             else --this is a real step; no need to update the linking steps
                                                local tLinkedStepGuid = iLinkedinTutSteps[xStepIndex]
                                                --unlink remote
                                                SkuAdventureGuide.Tutorial:UnlinkStep(iLinkedinTutGuid, tLinkedStepGuid, tSource.AllLangs.Tutorials[tTutorialGuid].GUID, tStepData.GUID)
                                                --update remote
                                                SkuAdventureGuide.Tutorial:PutStepDataByGUID(tLinkedStepGuid, tStepData)
                                             end
                                          end
                                       end
                                       --now delete this step
                                       table.remove(tSource.AllLangs.Tutorials[tTutorialGuid].steps, tTSI)
                                    end

                                    --now delete this tut
                                    self.parent.parent.source.AllLangs.Tutorials[v.GUID] = nil
                                 end)
                              end
               
                              --delete linked steps
                              local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Delete all steps that are linking a step in this tutorial. Then delete this tutorial"]}, SkuGenericMenuItem)
                              tNewMenuEntry.isSelect = true
                              tNewMenuEntry.OnAction = function(self, aValue, aName)
                                 SkuAdventureGuide.Tutorial:StopCurrentTutorial()

                                 C_Timer.After(0.05, function()
                                    SkuOptions.currentMenuPosition.parent.parent:OnSelect(SkuOptions.currentMenuPosition.parent.parent)
                                    SkuOptions.currentMenuPosition.parent.parent:OnUpdate(SkuOptions.currentMenuPosition.parent.parent)
                                 end)

                                 C_Timer.After(0.1, function()
                                    --delete all steps that are linking to this step
                                    for tTSI = #aSource.AllLangs.Tutorials[v.GUID].steps, 1, -1 do
                                       local tStepData = aSource.AllLangs.Tutorials[v.GUID].steps[tTSI]
                                       SkuAdventureGuide.Tutorial:DeleteStep(tStepData.GUID, 0)
                                    end
                                    --now delete this tut
                                    self.parent.parent.source.AllLangs.Tutorials[v.GUID] = nil
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
                           SkuAdventureGuide.Tutorial:ExportTutorial(v.GUID, v)
                        end)
                     end

                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Export this tutorial as text"]}, SkuGenericMenuItem)
                     tNewMenuEntry.dynamic = true
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.BuildChildren = function(self)
                        for _, tLoc in pairs(Sku.Locs) do
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {tLoc}, SkuGenericMenuItem)
                        end
                     end
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        C_Timer.After(0.001, function()
                           SkuAdventureGuide.Tutorial:ExportTutorialAsFriendlyList(v.GUID, v, aName)
                        end)
                     end
                  end
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

   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParentEntry, {L["Delete all custom tutorials"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials = {}   
      SkuAdventureGuide.Tutorial:PLAYER_ENTERING_WORLD()
      C_Timer.After(0.01, function()
         SkuOptions.currentMenuPosition.parent:OnUpdate(SkuOptions.currentMenuPosition.parent)
      end)
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportTutorialAsFriendlyList(aTutorialGuid, aTutorialData, aLang)
   aLang = aLang or Sku.Loc
   local tResult = ""
   tResult = tResult.."Titel: "..aTutorialData.tutorialTitle[aLang].."\r\n"
   tResult = tResult..L["Play first time user intro"]..": "..(aTutorialData.playFtuIntro == true and L["Yes"] or L["No"]).."\r\n"
   tResult = tResult..L["Don't skip current outputs"]..": "..(aTutorialData.steps.dontSkipCurrentOutputs == true and L["Yes"] or L["No"]).."\r\n"
   for x = 1, #aTutorialData.steps do
      local tStepData = aTutorialData.steps[x]
      if tStepData.title then
         tResult = tResult..""..L["schritt "]..x..": "..tStepData.title[aLang].."\r\n"
         tResult = tResult.."  "..L["Start text"]..": "..tStepData.beginText[aLang].."\r\n"
         tResult = tResult.."  "..L["Triggers"]..":".."\r\n"
         tResult = tResult.."    "..L["All Required"]..": "..(tStepData.allTriggersRequired == true and L["Yes"] or L["No"]).."\r\n"
         for y = 1, #tStepData.triggers do
            local tTriggerData = tStepData.triggers[y]
            local tText = y.." "..L[tTriggerData.type]
            if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "ENTER_TEXT" then
               if tonumber(tTriggerData.value[aLang]) then
                  tText = tText..": "..SkuDB.NpcData.Names[aLang][tonumber(tTriggerData.value[aLang])][1]
               else
                  tText = tText..": "..tTriggerData.value[aLang]
               end
            elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
               tText = tText..": "..tTriggerData.value[aLang]
            elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
               local x, y, rr = string.match(tTriggerData.value[aLang], "(.+);(.+)")
               local _, _, rr = string.match(tTriggerData.value[aLang], "(.+);(.+);(.+)")
               rr = rr or 4
               tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
            elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
               tText = tText..": "..tTriggerData.value[aLang]
            else
               tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value[aLang]]]
            end
            tResult = tResult.."    "..tText.."\r\n"
         end
      end
   end

	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuOptions:EditBoxShow(tResult, function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportTutorial(aTutorialGuid, aTutorialData)
	if not aTutorialGuid or not aTutorialData then
		return
	end
	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
		tutorialGuid = aTutorialGuid,
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
            if tTutorialData.tutorialGuid and tTutorialData.tutorialData then
               SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tTutorialData.tutorialGuid] = tTutorialData.tutorialData
               SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tTutorialData.tutorialGuid].requirements = SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[tTutorialData.tutorialGuid].requirements or {race = 993, class = 99, skill = 999, }
               SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()
               SkuOptions.Voice:OutputStringBTtts(L["Tutorial imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
               return
            end
         end
		end
      SkuOptions.Voice:OutputStringBTtts(L["Unknown error. Tutorial data corrupt?"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ExportNewbieTutorials(aOverrideLocked)
   local tNewbieTutorials = {}
   for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      if v.isSkuNewbieTutorial == true then
         if v.exported ~= nil and not aOverrideLocked then
            print("Error: at least one newbie tutorial is exported to translation and locked")            
            return
         end
         tNewbieTutorials[i] = v
      end
   end
   
	local tExportDataTable = {
		version = GetAddOnMetadata("Sku", "Version"),
		isNewbieData = true,
		tutorialsData = tNewbieTutorials,
	}
	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuOptions:EditBoxShow(SkuOptions:Serialize(tExportDataTable), function(self) PlaySound(89) end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ImportNewbieTutorials(aOverrideLocked)
	PlaySound(88)
   SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))
		if tSerializedData ~= "" then
			local tSuccess, tTutorialData = SkuOptions:Deserialize(tSerializedData)
         if tSuccess == true and tTutorialData then
            if tTutorialData.isNewbieData and tTutorialData.isNewbieData == true then
               for i, v in pairs(tTutorialData.tutorialsData) do
                  if SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID] and SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID].exported ~= nil and not aOverrideLocked then
                     print("Error: at least one newbie tutorial is exported to translation and locked")            
                     return
                  end
               end


               --delete all existing newbie tuts
               for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
                  if v.isSkuNewbieTutorial == true then
                     SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID] = nil
                  end
               end

               --add imported newbie tuts
               for i, v in pairs(tTutorialData.tutorialsData) do
                  SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID] = v
               end
               SkuAdventureGuide.Tutorial:VerifyAndCleanGUIDs()

               SkuOptions.Voice:OutputStringBTtts(L["Tutorials imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
               return
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
function SkuAdventureGuide.Tutorial:StartTutorial(aTutorialGuid, aStartAtStepNumber, aSource, aSilent, aIsUser)
   SkuAdventureGuide.Tutorial.currentStepCompleted = false
   C_Timer.After(0.3, function()
      SkuAdventureGuide.Tutorial.current.guid = aTutorialGuid
      SkuAdventureGuide.Tutorial.current.source = aSource
      SkuAdventureGuide.Tutorial.current.isUser = aIsUser
      SkuAdventureGuide.Tutorial.current.linkedStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(aSource.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[aStartAtStepNumber].GUID)
      
      SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid] = aStartAtStepNumber
      SkuOptions.Voice.TutorialPlaying = 0

      if aStartAtStepNumber == 1 and SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].playFtuIntro == true then
         SkuAdventureGuide.Tutorial:PlayFtuIntro()
      else
         SkuAdventureGuide.Tutorial:StartStep(SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid])
      end
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ReReadCurrentStep()
   SkuOptions.Voice.TutorialPlaying = 0
   SkuOptions.Voice:StopOutputEmptyQueue()

   C_Timer.After(1.0, function()
      if SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid] == 0 then
         SkuAdventureGuide.Tutorial:PlayFtuIntro()
      else
         local tCurrentStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid]].GUID)
         SkuOptions.Voice:OutputString("sound-waterdrop5", false, false, 0.3, true)
         C_Timer.After(1.5, function()
   
            SkuOptions.Voice:OutputStringBTtts(SkuAdventureGuide.Tutorial:ReplacePlaceholders(tCurrentStepData.beginText[Sku.Loc]), {overwrite = tCurrentStepData.dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
            
            if SkuAdventureGuide.Tutorial.currentStepCompleted == true then
               C_Timer.After(1.5, function()
                  SkuOptions.Voice:RegisterBttsCallback(function()
                     SkuOptions.Voice:OutputString("sound-TutorialSuccess01", --false, false, 0.3, true)
                        {
                           overwrite = false,
                           wait = false,
                           length = 2.2,
                           doNotOverwrite = true,
                           audioFile = "Interface\\AddOns\\Sku\\SkuAudioData\\assets\\audio\\"..Sku.Loc.."\\Tutorial_Success_01.mp3"
                        }
                     )

                     if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience <= SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
                        C_Timer.After(2.4, function()
                           SkuOptions.Voice:OutputStringBTtts(SkuAdventureGuide.Tutorial:AddNextStepText(""), {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
                        end)
                     end
                  end)
               end)
            end
         end)
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
         if SkuAdventureGuide.Tutorial.current.source then
            local tCurrentStepData = SkuAdventureGuide.Tutorial:GetLinkedStepData(SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid]].GUID)
            local tStartText = tCurrentStepData.beginText[Sku.Loc]
            tStartText = SkuAdventureGuide.Tutorial:ReplacePlaceholders(tStartText)
            SkuOptions.Voice:OutputStringBTtts(tStartText, {overwrite = tCurrentStepData.dontSkipCurrentOutputs == false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
            C_Timer.After(0.1, function()
               SkuAdventureGuide.Tutorial.evaluateNextStep = true
            end)
         end
      end)
   end)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:PlayFtuTutorialHint(aevent)
   if not SkuOptions.db.char[MODULE_NAME].Tutorials.ftuTutorialHintPlayed then
      SkuOptions.db.char[MODULE_NAME].Tutorials.ftuTutorialHintPlayed = true
      SkuDispatcher:UnregisterEventCallback("NAME_PLATE_UNIT_ADDED", SkuAdventureGuide.Tutorial.PlayFtuTutorialHint)
      if UnitLevel("player") == 1 then
         C_Timer.After(7, function()
            local tIntroText = L["Important! Before you start playing: You may want to check out the help for newbies. If you don't know how to play the game, press F1 right now, to get more information, before you do anything else. So, if you do need help, press F1 now."]
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

   local tIntroText = 
   L["Hello, %name%. This tutorial will guide you step by step through the game and the Sku addon. In each step you will first hear some information or instructions. While these are played, the tutorial will lock the keyboard."]
   .." "..L["Then you will take action and carry out the instructions of that step. Once you have completed them, you will hear a success sound. Then you can proceed to the next tutorial step."]
   .." "..L["You will need the following two shortcut keys, that you should write down now:"]
   .." "..L["(%SKU_KEY_TUTORIALSTEPREPEAT%), to hear the instructions from the current step again."]
   .." "..L["(%SKU_KEY_TUTORIALSTEPFORWARD%), to proceed to the next step as soon as you have completed the current step. This only works if you have heard the success sound."]
   .." "..L["Always follow the instructions exactly. Never do anything other than the tutorial instructions are requesting, as long as you want to play the tutorial. It will break if you're doing anything else. Always proceed to the next step when you have completed a step."]
   .." "..L["Now press %SKU_KEY_TUTORIALSTEPFORWARD% to start with the first step. To hear this info again, and take note of the shortcuts, press (%SKU_KEY_TUTORIALSTEPREPEAT%)."]

   tIntroText = SkuAdventureGuide.Tutorial:ReplacePlaceholders(tIntroText)

   SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid] = 0
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
   SkuAdventureGuide.Tutorial.current.guid = nil
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
   C_Timer.After(1.5, function()
      SkuOptions.Voice:OutputString("sound-TutorialSuccess01", --false, false, 0.3, true)
         {
            overwrite = false,
            wait = false,
            length = 2.2,
            doNotOverwrite = true,
            audioFile = "Interface\\AddOns\\Sku\\SkuAudioData\\assets\\audio\\"..Sku.Loc.."\\Tutorial_Success_01.mp3"
         }
      )

      if not SkuAdventureGuide.Tutorial.current.source.AllLangs.Tutorials[SkuAdventureGuide.Tutorial.current.guid].steps[SkuOptions.db.char[MODULE_NAME].Tutorials.progress[SkuAdventureGuide.Tutorial.current.guid] + 1] then
         SkuAdventureGuide.Tutorial:StopCurrentTutorial()
         C_Timer.After(1.5, function()
            SkuOptions.Voice:OutputStringBTtts(L["This was the last tutorial step. The tutorial is completed."], {overwrite = false, wait = true, doNotOverwrite = true, engine = 2, isTutorial = true, })
         end)
         return
      end
      if SkuOptions.db.char[MODULE_NAME].Tutorials.ftuExperience <= SkuAdventureGuide.Tutorial.ftuExperienceMaxSteps then
         C_Timer.After(1.4, function()
            --SkuOptions.Voice:OutputString("sound-TutorialOpen01", false, false, 0.3, true)
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

   for i, v in pairs(SkuDB.AllLangs.Tutorials) do
      if v.requirements.race == raceID and v.requirements.class == classId and v.isSkuNewbieTutorial == true then
         return v.tutorialTitle[Sku.Loc], tRaceRequirementValues[raceID], tClassRequirementValues[classId], v.GUID
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
         local tSortedList = {}
         for k, v in SkuSpairs(aSource.AllLangs.Tutorials, function(t,a,b) return t[b].tutorialTitle[Sku.Loc] > t[a].tutorialTitle[Sku.Loc] end) do tSortedList[#tSortedList+1] = {name = k, data = v} end
         for w = 1, #tSortedList do
            local v = tSortedList[w].data         
            if v.showInUserList ~= false and CheckRequirements(v.requirements.race, v.requirements.class, v.requirements.skill) == true then
               tEmpty = false
               local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {v.tutorialTitle[Sku.Loc]}, SkuGenericMenuItem)
               tNewMenuEntry.dynamic = true
               tNewMenuEntry.filterable = true
               tNewMenuEntry.tutorialName = v.tutorialTitle[Sku.Loc]
               tNewMenuEntry.tutorialGuid = v.GUID
               tNewMenuEntry.source = aSource
               tNewMenuEntry.BuildChildren = function(self)
                  local tProgress = SkuOptions.db.char[MODULE_NAME].Tutorials.progress[v.GUID]
                  if tProgress and tProgress < #aSource.AllLangs.Tutorials[v.GUID].steps and tProgress ~= 0 then
                     local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Continue"].." ("..L["schritt "]..tProgress..")"}, SkuGenericMenuItem)
                     tNewMenuEntry.isSelect = true
                     tNewMenuEntry.OnAction = function(self, aValue, aName)
                        SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                        SkuOptions:CloseMenu()                     
                        SkuAdventureGuide.Tutorial:StartTutorial(v.GUID, tProgress, aSource, nil, aIsUser)
                     end
                  end

                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start over"]}, SkuGenericMenuItem)
                  tNewMenuEntry.isSelect = true
                  tNewMenuEntry.OnAction = function(self, aValue, aName)
                     SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                     SkuOptions:CloseMenu()                  
                     SkuAdventureGuide.Tutorial:StartTutorial(v.GUID, 1, aSource, nil, aIsUser)
                  end

                  local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Steps"]}, SkuGenericMenuItem)
                  tNewMenuEntry.dynamic = true
                  tNewMenuEntry.filterable = true
                  tNewMenuEntry.BuildChildren = function(self)
                     local tSource = self.parent.source
                     local tTutorialGuid = self.parent.tutorialGuid
                     
                     for x = 1, #tSource.AllLangs.Tutorials[tTutorialGuid].steps do
                        local tStepData = tSource.AllLangs.Tutorials[tTutorialGuid].steps[x]
                        if tStepData.title then
                           local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["schritt "]..x..": "..tStepData.title[Sku.Loc]}, SkuGenericMenuItem)
                           tNewMenuEntry.BuildChildren = function(self)
                              local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Start from this step"]}, SkuGenericMenuItem)
                              tNewMenuEntry.isSelect = true
                              tNewMenuEntry.OnAction = function(self, aValue, aName)
                                 SkuAdventureGuide.Tutorial:StopCurrentTutorial()
                                 SkuOptions:CloseMenu()                           
                                 SkuAdventureGuide.Tutorial:StartTutorial(tTutorialGuid, x, tSource, nil, aIsUser)
                              end
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
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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

   for targetTutI, targetTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
            if sourceStepV.GUID == aSourceTutorialStepGUID then
               if not sourceStepV.linkedIn[aTargetTutorialGUID] then
                  print("error. aTargetTutorialGUID missing in source linkedIn.", aTargetTutorialGUID, aTargetTutorialStepGUID, aSourceTutorialGUID, aSourceTutorialStepGUID)
               end
               if #sourceStepV.linkedIn[aTargetTutorialGUID] == 0 then
                  sourceStepV.linkedIn[aTargetTutorialGUID] = nil
               else
                  for x = 1, #sourceStepV.linkedIn[aTargetTutorialGUID] do
                     if sourceStepV.linkedIn[aTargetTutorialGUID][x] == aTargetTutorialStepGUID then
                        table.remove(sourceStepV.linkedIn[aTargetTutorialGUID], x)
                        tReturnValue = tReturnValue + 1
                        break
                     end
                  end
                  if #sourceStepV.linkedIn[aTargetTutorialGUID] == 0 then
                     sourceStepV.linkedIn[aTargetTutorialGUID] = nil
                  end
   
               end
            end
         end
      end
   end

   for targetTutI, targetTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      for y = #sourceTutV.steps, 1, -1 do
         local sourceStepV = sourceTutV.steps[y]
         for targetTutorialGuidI, targetTutorialStepsGuidV in pairs(sourceStepV.linkedIn) do
            for x = #targetTutorialStepsGuidV, 1, -1 do
               if not SkuAdventureGuide.Tutorial:GetStepDataByGUID(targetTutorialStepsGuidV[x]) then
                  print("ERROR: VerifyAndCleanGUIDs: tar step guid is nil table.remove(targetTutorialStepsGuidV,", x, ")")
                  table.remove(targetTutorialStepsGuidV, x)
               else
                  local tTarD = SkuAdventureGuide.Tutorial:GetStepDataByGUID(targetTutorialStepsGuidV[x])
                  if tTarD.linkedFrom.SourceTutorialStepGUID ~= sourceStepV.GUID then
                     print("ERROR: VerifyAndCleanGUIDs: linkedin step guid isn't this step guid, remove,", sourceTutV.tutorialTitle[Sku.Loc], y, x, ")")
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

   for sourceTutI, sourceTutV in pairs(SkuDB.AllLangs.Tutorials) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         return sourceTutV, sourceTutV.tutorialTitle[Sku.Loc]
      end
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      if sourceTutV.GUID == aSourceTutorialGUID then
         return sourceTutV, sourceTutV.tutorialTitle[Sku.Loc]
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetStepDataByGUID(aSourceTutorialStepGUID)
   if not aSourceTutorialStepGUID then
      return
   end

   for sourceTutI, sourceTutV in pairs(SkuDB.AllLangs.Tutorials) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            return sourceStepV, sourceStepI
         end
      end
   end

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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

   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            sourceStepV.title = aNewStepData.title
            sourceStepV.allTriggersRequired = aNewStepData.allTriggersRequired
            sourceStepV.dontSkipCurrentOutputs = aNewStepData.dontSkipCurrentOutputs
            sourceStepV.triggers = aNewStepData.triggers
            sourceStepV.beginText = aNewStepData.beginText
            sourceStepV.linkedFrom = aNewStepData.linkedFrom
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(aSourceTutorialStepGUID)
   if not aSourceTutorialStepGUID then
      return
   end
   
   for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      for sourceStepI, sourceStepV in pairs(sourceTutV.steps) do
         if sourceStepV.GUID == aSourceTutorialStepGUID then
            return sourceTutV.tutorialTitle[Sku.Loc], sourceTutV, sourceTutV.GUID
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
   if not aTutorialStepGUID then
      return
   end

   local tCount = 0
   local tResult = SkuAdventureGuide.Tutorial:ResolveStepDataGUID(aTutorialStepGUID)
   local tReturnText
   while type(tResult) ~= "table" do
      tCount = tCount + 1
      local tTutorialName, tTutorialData, tTutorialGuid = SkuAdventureGuide.Tutorial:GetTutorialDataByStepGUID(tResult)
      local tStepData, tStepNumber = SkuAdventureGuide.Tutorial:GetStepDataByGUID(tResult)
      if not tStepData.title then
         tReturnText = (tReturnText or "")..L["layer"].." "..tCount..": "..L["Step"].." "..tStepNumber..", "..L["in tutorial"]..", "..tTutorialName.."\r\n"
      else
         tReturnText = (tReturnText or "")..L["layer"].." "..tCount..": "..L["Step"].." "..tStepNumber..", "..tStepData.title[Sku.Loc]..", "..L["in tutorial"]..", "..tTutorialName.."\r\n"
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
   tTooltipText = tTooltipText..L["Start text"]..": "..tFinalStepData.beginText[Sku.Loc].."\r\n"
   tTooltipText = tTooltipText..L["Don't skip current outputs"]..": "..(tFinalStepData.dontSkipCurrentOutputs == true and L["Yes"] or L["No"]).."\r\n"
   tTooltipText = tTooltipText..L["Triggers"]..":".."\r\n"
   tTooltipText = tTooltipText..L["All Required"]..": "..(tFinalStepData.allTriggersRequired == true and L["Yes"] or L["No"]).."\r\n"
   for y = 1, #tFinalStepData.triggers do
      local tTriggerData = tFinalStepData.triggers[y]
      local tText = L["Trigger"].." "..y..": "..L[tTriggerData.type]
      if SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "ENTER_TEXT" then
         if tonumber(tTriggerData.value[Sku.Loc]) then
            tText = tText..": "..SkuDB.NpcData.Names[Sku.Loc][tonumber(tTriggerData.value[Sku.Loc])][1].." ("..L["is creature ID"]..")"
         else
            tText = tText..": "..tTriggerData.value[Sku.Loc].." ("..L["is string"]..")"
         end
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_TARGET" then
         tText = tText..": "..tTriggerData.value[Sku.Loc]
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_4" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_10" or SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "CURRENT_COORDINATES_20" then
         local x, y, rr = string.match(tTriggerData.value[Sku.Loc], "(.+);(.+)")
         local _, _, rr = string.match(tTriggerData.value[Sku.Loc], "(.+);(.+);(.+)")
         rr = rr or 4
         tText = tText..": "..x..";"..y.. " "..rr..";"..L["Meter"]
      elseif SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[1] == "WAIT_FOR_MENU_SELECT" then
         tText = tText..": "..tTriggerData.value[Sku.Loc]
      else
         tText = tText..": "..L[SkuAdventureGuide.Tutorial.triggers[tTriggerData.type].values[tTriggerData.value[Sku.Loc]]]
      end
      tTooltipText = tTooltipText.."- "..tText.."\r\n"
   end
   local tBreadText, tCount = SkuAdventureGuide.Tutorial:GetLinkBreadText(tStepData.GUID)

   if tSourceStepDataRef and tBreadText then
      local tSourceText = L["Link history"].." ("..tCount.." "..(tCount == 1 and L["layer"] or L["layers"]).."): ".."\r\n"
      for sourceTutI, sourceTutV in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
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
   dprint(string.rep(" ", aIntend), " table.remove", sourceTutI, sourceTutV.GUID, sourceStepI, sourceStepI)
   table.remove(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[sourceTutV.GUID].steps, sourceStepI)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:UpdateTranslations(aTranslationsTable, aNewText)
   if tonumber(aNewText) then
      for langi, langv in pairs(Sku.Locs) do
         aTranslationsTable[langv] = aNewText
      end
      return
   end

   if not aTranslationsTable[Sku.Loc] then
      aTranslationsTable[Sku.Loc] = ""
   end
      
   local tOldSourceCleanText = string.gsub(aTranslationsTable[Sku.Loc], "%%npc_id:%d%d%d%d%d%d%%", "TAG")
   local tNewSourceCleanText = string.gsub(aNewText, "%%npc_id:%d%d%d%d%d%d%%", "TAG")

   local tIsIdUpdate
   if tOldSourceCleanText == tNewSourceCleanText then
      tIsIdUpdate = true
   end
   dprint("tIsIdUpdate", tIsIdUpdate)

   local tOldSourceText = "§§"..aTranslationsTable[Sku.Loc].."§§"
   local tOldPreText, tOldTag, tOldPostText = string.match(tOldSourceText, "(.+)(%%npc_id:%d%d%d%d%d%d%%)(.+)")
   dprint("tOldPreText, tOldTag, tOldPostText", tOldPreText, "--", tOldTag, "--", tOldPostText)
   local tNewSourceText = "§§"..aNewText.."§§"
   local tNewPreText, tNewTag, tNewPostText = string.match(tNewSourceText, "(.+)(%%npc_id%:%d%d%d%d%d%d%%)(.+)")
   dprint("tNewPreText, tNewTag, tNewPostText", tNewPreText, "--", tNewTag, "--", tNewPostText)

   local tOldTagId = string.match(tOldTag or "", "(%d%d%d%d%d%d)")
   local tNewTagId = string.match(tNewTag or "", "(%d%d%d%d%d%d)")
   dprint("tOldTagId", tOldTagId)
   dprint("tNewTagId", tNewTagId)

   --update all other langs tag
   for langi, langv in pairs(Sku.Locs) do
      if langv ~= Sku.Loc then
         dprint("---old target:", aTranslationsTable[langv])
         if not aTranslationsTable[langv] then
            aTranslationsTable[langv] = ""
         end
         local tOldTargetText = "§§"..aTranslationsTable[langv].."§§"
         local tOldPreTargetText, tOldTargetTag, tOldPostTargetText = string.match(tOldTargetText, "(.+)(%%npc_id:%d%d%d%d%d%d%%)(.+)")
         local tUntranslated = string.match(aTranslationsTable[langv], "(UNTRANSLATED:)(.+)")
         local tUpdated = string.match(aTranslationsTable[langv], "(UPDATED:)(.+)")
         if tOldTagId == nil or tNewTagId == nil or tIsIdUpdate == nil or aTranslationsTable[langv] == "" or tUntranslated ~= nil or tUpdated ~= nil or tOldTargetTag == nil then
            aTranslationsTable[langv] = "UNTRANSLATED:"..Sku.Loc..":"..aNewText
            dprint("    copy + untranslated", aTranslationsTable[langv])
         else
            if tIsIdUpdate then                                 
               --update
               aTranslationsTable[langv] = string.gsub(aTranslationsTable[langv], tOldTagId, tNewTagId)
               dprint("    update id", aTranslationsTable[langv])
            else
               aTranslationsTable[langv] = "UPDATED:"..Sku.Loc..":"..aTranslationsTable[langv]
               dprint("    keep targt + updated", aTranslationsTable[langv])
            end
         end
         dprint("+++new target:", aTranslationsTable[langv])
      end
   end
   --update Sku.Loc
   aTranslationsTable[Sku.Loc] = aNewText
end

---------------------------------------------------------------------------------------------------------------------------------------
--[[
   Internal translation utilities
   Addon tutorials db: SkuDB.AllLangs.Tutorials[Sku.Loc]
   Custom tutorials db: SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[Sku.Loc]



]]
---------------------------------------------------------------------------------------------------------------------------------------
--[[
all without step titles
/script SkuAdventureGuide.Tutorial:ExportTutorialsToTranslation("deDE", "enUS", nil, true, nil, true, false, true)
step texts only
/script SkuAdventureGuide.Tutorial:ExportTutorialsToTranslation("deDE", "enUS", nil, true, nil, false, false, false)
]]
function SkuAdventureGuide.Tutorial:ExportTutorialsToTranslation(aSourceLang, aTargetLang, aUpdatedInteadOfUntranslated, aForce, aTutorialsTable, aIncludeTutorialTitles, aIncludeStepTitles, aIncludeTriggerValues)
   if aIncludeTutorialTitles == nil then
      aIncludeTutorialTitles = true
   end
   if aIncludeStepTitles == nil then
      aIncludeStepTitles = true
   end
   if aIncludeTriggerValues == nil then
      aIncludeTriggerValues = true
   end

   print("aIncludeTutorialTitles, aIncludeStepTitles, aIncludeTriggerValues", aIncludeTutorialTitles, aIncludeStepTitles, aIncludeTriggerValues)

   if not aSourceLang and not aTargetLang then
      aSourceLang, aTargetLang = "deDE", "enUS"
   end

   if not aTutorialsTable then
      aTutorialsTable = {}
      for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
         if v.isSkuNewbieTutorial == true then
            aTutorialsTable[i] = v
         end
      end
   end

   local tExportString = ""
   tExportString = tExportString.."DNT:sourceLang:"..aSourceLang.."\r\n"
   tExportString = tExportString.."DNT:targetLang:"..aTargetLang.."\r\n"


   for tutGuid, tutData in pairs(aTutorialsTable) do
      print("export:", tutData.tutorialTitle[aTargetLang])

      if tutData.exported ~= nil and not aForce then
         print("ERROR: already exported for", tutData.exported)
         return
      end

   end

   for tutGuid, tutData in pairs(aTutorialsTable) do
      print("export:", tutData.tutorialTitle[aTargetLang])

      if tutData.exported ~= nil and not aForce then
         print("ERROR: already exported for", tutData.exported)
      else

         tutData.exported = aTargetLang

         if aIncludeTutorialTitles == true then
            if string.match(tutData.tutorialTitle[aTargetLang], "UNTRANSLATED:") or aSourceLang == aTargetLang then
               tExportString = tExportString.."DNT:"..tutGuid..":tutorialTitle\r\n"
               tExportString = tExportString..string.gsub(tutData.tutorialTitle[aTargetLang], "UNTRANSLATED:....:", "").."\r\n"
            end
         end
            
         for x = 1, #tutData.steps do
            local stepData = tutData.steps[x]
            if stepData.title then

               if aIncludeStepTitles == true then
                  if string.match(stepData.title[aTargetLang], "UNTRANSLATED:") or aSourceLang == aTargetLang then
                     tExportString = tExportString.."DNT:"..stepData.GUID..":title".."\r\n"
                     tExportString = tExportString..string.gsub(stepData.title[aTargetLang], "UNTRANSLATED:....:", "").."\r\n"
                  end
               end

               if string.match(stepData.beginText[aTargetLang], "UNTRANSLATED:") or aSourceLang == aTargetLang then
                  tExportString = tExportString.."DNT:"..stepData.GUID..":beginText".."\r\n"
                  tExportString = tExportString..string.gsub(stepData.beginText[aTargetLang], "UNTRANSLATED:....:", "").."\r\n"
               end

               if aIncludeTriggerValues == true then
                  for y = 1, #stepData.triggers do
                     if string.match(stepData.triggers[y].value[aTargetLang], "UNTRANSLATED:") or aSourceLang == aTargetLang then
                        if SkuAdventureGuide.Tutorial.triggers[stepData.triggers[y].type].translate then
                           if not tonumber(stepData.triggers[y].value[Sku.Loc]) then
                              tExportString = tExportString.."DNT:"..stepData.GUID..":"..y..":value".."\r\n"
                              tExportString = tExportString..string.gsub(stepData.triggers[y].value[aTargetLang], "UNTRANSLATED:....:", "").."\r\n"
                           end
                        end
                     end
                  end
               end
            end
         end
         --tExportString = tExportString.."\r\n"
      end
   end

	PlaySound(88)
	SkuOptions.Voice:OutputStringBTtts(L["Jetzt Export Daten mit Steuerung plus C kopieren und Escape drücken"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
	SkuAdventureGuide:ExportImportEditBoxShow(tExportString, function(self) PlaySound(89) end)
end
---------------------------------------------------------------------------------------------------------------------------------------
--[[
/script SkuAdventureGuide.Tutorial:ImportTutorialsToTranslation()
]]
function SkuAdventureGuide.Tutorial:ImportTutorialsToTranslation()
   local function processHelper(aStringsDataTable)
      local aSourceLang = string.gsub(aStringsDataTable[1], "DNT:sourceLang:", "")
      local tExists
      for langi, langv in pairs(Sku.Locs) do
         if langv == aSourceLang then
            tExists = true
         end
      end
      if not tExists then
         print("import error 1: aSourceLang", aSourceLang)
         return
      end
      local aTargetLang = string.gsub(aStringsDataTable[2], "DNT:targetLang:", "")
      local tExists
      for langi, langv in pairs(Sku.Locs) do
         if langv == aSourceLang then
            tExists = true
         end
      end
      if not tExists then
         print("import error 2: aTargetLang", aTargetLang)
         return
      end      
      print("aSourceLang, aTargetLang", aSourceLang, aTargetLang)

      --check for locked tutorials
      for x = 3, #aStringsDataTable, 2 do
         local tDNT, tTutorialGUID, tVariableName = string.match(aStringsDataTable[x], "(.+):(.+):(.+)")
         if tVariableName == "tutorialTitle" then
            local tTutorialData = SkuAdventureGuide.Tutorial:GetTutorialDataByGUID(tTutorialGUID)
            if not tTutorialData.exported or tTutorialData.exported ~= aTargetLang then
               print("import error 3: tTutorialData is NOT locked for this import target lang", tVariableName, tTutorialData.exported, aTargetLang)
               return
            end
         end
      end


      --step data
      for x = 3, #aStringsDataTable, 2 do
         --print("processing:", x, aStringsDataTable[x])

         local tDNT, tTutorialGUID, tVariableName = string.match(aStringsDataTable[x], "(.+):(.+):(.+)")

         if tVariableName == "tutorialTitle" then
            --is tutorial title data

            print("NEXT TUTORIAL---------------------")
            print("  tTutorialGUID, tVariableName", tTutorialGUID, tVariableName)

            local tTutorialData = SkuAdventureGuide.Tutorial:GetTutorialDataByGUID(tTutorialGUID)
            print("  tTutorialData", tTutorialData, "tTutorialData.GUID", tTutorialData.GUID, "tTutorialData[tVariableName]", tTutorialData[tVariableName])

            if not tTutorialData then
               print("import error 4: tTutorialData = nil")
               return
            end

            if not tTutorialData.exported or tTutorialData.exported ~= aTargetLang then
               print("import error 5: tTutorialData is NOT locked for this import target lang", tTutorialData.exported, aTargetLang)
               return
            end

            tTutorialData.exported = nil


            local tTranslation = aStringsDataTable[x + 1]

            if not tTutorialData[tVariableName][aTargetLang] then
               print("import error 6: tTutorialData[tVariableName][aTargetLang] = nil", tVariableName)
               return
            end

            --print("  tTranslation", tTranslation)
            if tTutorialData[tVariableName][aTargetLang] ~= tTranslation then
               --print("  UPDATE:", tVariableName, tTutorialData[tVariableName][aTargetLang], tTranslation)
               --print("    old:", tTutorialData[tVariableName][aTargetLang])
               --print("    new:", tTranslation)




                  --update other to UNTRANSLATED?






               tTutorialData[tVariableName][aTargetLang] = tTranslation
            end
         
         else
            --is step data
            local tDNT, tStepGUID, tTriggerNumber, tVariableName = string.match(aStringsDataTable[x], "(.+):(.+):(.+):(.+)")
            if not tDNT then
               tDNT, tStepGUID, tVariableName = string.match(aStringsDataTable[x], "(.+):(.+):(.+)")
            end
            if not tDNT then
               print("import error 7:", x, aStringsDataTable[x])
               return
            end

            local tTranslation = aStringsDataTable[x + 1]
            --print("  tDNT, tStepGUID, tVariableName, tTriggerNumber", tDNT, tStepGUID, "-"..tVariableName.."-", tTriggerNumber)
            --print("    tTranslation:", tTranslation)

            local tStepV, tStepI = SkuAdventureGuide.Tutorial:GetStepDataByGUID(tStepGUID)
            --print("  tStepV, tStepI", tStepV, tStepI)

            if not tStepV then
               print("import error 8: tStepV == nil", x, tStepGUID)
               return
            end

            if not tTriggerNumber then
               --update step
               if not tStepV[tVariableName] then
                  print("import error 9: tStepV[tVariableName] = nil", x, tVariableName)
                  return
               end      

               --print("  tStepV[tVariableName]", tStepV[tVariableName])
               if not tStepV[tVariableName][aTargetLang] then
                  print("import error 10: tStepV[tVariableName][aTargetLang] = nil", x, tVariableName)
                  return
               end                

               --print("    tStepV[tVariableName][aTargetLang]", tStepV[tVariableName][aTargetLang])
               if tStepV[tVariableName][aTargetLang] ~= tTranslation then
                  --print("  UPDATE:", tVariableName)
                  --print("     old", tStepV[tVariableName][aTargetLang])
                  --print("     new", tTranslation)




                  --update other to UNTRANSLATED?






                  tStepV[tVariableName][aTargetLang] = tTranslation
               end
            else
               --update trigger

               if not tStepV.triggers[tonumber(tTriggerNumber)] then
                  print("import error 11: tStepV.triggers[tonumber(tTriggerNumber)] = nil", x, tTriggerNumber)
                  return
               end                

               if not tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang] then
                  print("import error 12: tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang] = nil", x, tTriggerNumber)
                  return
               end   

               --print("  tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang]", tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang])
               if tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang] ~= tTranslation then
                  --print("  UPDATE:", tTriggerNumber, tVariableName)
                  --print("     old", tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang])
                  --print("     new", tTranslation)



                  --update other to UNTRANSLATED?





                  tStepV.triggers[tonumber(tTriggerNumber)].value[aTargetLang] = tTranslation
               end
            end
         end
      end


      SkuOptions.Voice:OutputStringBTtts(L["Tutorial imported"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
   end


	PlaySound(88)
   SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
   SkuAdventureGuide:ExportImportEditBoxShow("", function(self)
		PlaySound(89)
      tImportedString = _G["SkuAdventureGuideEditBoxEditBox"]:GetText().."\r\n"
      local tStringsDataTable = {}
      for i in string.gmatch(tImportedString, "([^\r\n]+)") do
         tStringsDataTable[#tStringsDataTable + 1] = i
         print(i)
      end
      processHelper(tStringsDataTable)
	end, true)

   
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuAdventureGuideEditBoxOkScript(...) end
local function SkuAdventureGuideEditBoxEscScript(...) end
function SkuAdventureGuide:ExportImportEditBoxShow(aText, aOkScript, aMultilineFlag, aEscScript)
	if not SkuAdventureGuideEditBox then
		local f = CreateFrame("Frame", "SkuAdventureGuideEditBox", UIParent, "DialogBoxFrame")
		f:SetPoint("CENTER")
		f:SetSize(600, 500)

		f:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
			edgeSize = 16,
			insets = { left = 8, right = 6, top = 8, bottom = 8 },
		})
		f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue

		-- Movable
		f:SetMovable(true)
		f:SetClampedToScreen(true)
		f:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				self:StartMoving()
			end
		end)
		f:SetScript("OnMouseUp", f.StopMovingOrSizing)

		-- ScrollFrame
		local sf = CreateFrame("ScrollFrame", "SkuAdventureGuideEditBoxScrollFrame", SkuAdventureGuideEditBox, "UIPanelScrollFrameTemplate")
		sf:SetPoint("LEFT", 16, 0)
		sf:SetPoint("RIGHT", -32, 0)
		sf:SetPoint("TOP", 0, -16)
		sf:SetPoint("BOTTOM", SkuAdventureGuideEditBoxButton, "TOP", 0, 0)

		-- EditBox
		local eb = CreateFrame("EditBox", "SkuAdventureGuideEditBoxEditBox", SkuAdventureGuideEditBoxScrollFrame)
		eb:SetSize(sf:GetSize())

		eb:SetAutoFocus(false) -- dont automatically focus
		eb:SetFontObject("ChatFontNormal")
		eb:SetScript("OnEscapePressed", function() 
			PlaySound(89)
			f:Hide()
		end)
		eb:SetScript("OnTextSet", function(self)
			self:HighlightText()
		end)

		sf:SetScrollChild(eb)

		-- Resizable
		f:SetResizable(true)
      f:SetResizeBounds(150, 100)

		local rb = CreateFrame("Button", "SkuAdventureGuideEditBoxResizeButton", SkuAdventureGuideEditBox)
		rb:SetPoint("BOTTOMRIGHT", -6, 7)
		rb:SetSize(16, 16)

		rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
		rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
		rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

		rb:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				f:StartSizing("BOTTOMRIGHT")
				self:GetHighlightTexture():Hide() -- more noticeable
			end
		end)
		rb:SetScript("OnMouseUp", function(self, button)
			f:StopMovingOrSizing()
			self:GetHighlightTexture():Show()
			eb:SetWidth(sf:GetWidth())
		end)

		SkuAdventureGuideEditBoxEditBox:HookScript("OnEnterPressed", function(...)
			if aMultilineFlag ~= true then
				local tText = SkuAdventureGuideEditBoxEditBox:GetText()
				if string.find(tText, "\n") then
					tText = string.gsub(tText, "\n", " ")
					SkuAdventureGuideEditBoxEditBox:SetText(tText)
				end
			end
			SkuAdventureGuideEditBoxOkScript(...)
			SkuAdventureGuideEditBox:Hide()
		end)
		SkuAdventureGuideEditBoxEditBox:HookScript("OnEscapePressed", function(...)
			SkuAdventureGuideEditBoxEscScript(...)
			SkuAdventureGuideEditBox:Hide()
		end)
		SkuAdventureGuideEditBoxButton:HookScript("OnClick", SkuAdventureGuideEditBoxOkScript)

		f:Show()
	end

	SkuAdventureGuideEditBoxEditBox:SetMultiLine(true)
	--[[
	if aMultilineFlag == true then
		SkuAdventureGuideEditBoxEditBox:SetMultiLine(true)
	else
		SkuAdventureGuideEditBoxEditBox:SetMultiLine(false)
	end
	]]
	
	SkuAdventureGuideEditBoxEditBox:Hide()
	SkuAdventureGuideEditBoxEditBox:SetText("")
	if aText then
		SkuAdventureGuideEditBoxEditBox:SetText(aText)
		SkuAdventureGuideEditBoxEditBox:HighlightText()
	end
	SkuAdventureGuideEditBoxEditBox:Show()
	if aOkScript then
		SkuAdventureGuideEditBoxOkScript = aOkScript
	end
	if aEscScript then
		SkuAdventureGuideEditBoxEscScript = aEscScript
	end
	

	SkuAdventureGuideEditBox:Show()

	SkuAdventureGuideEditBoxEditBox:SetFocus()
end










---------------------------------------------------------------------------------------------------------------------------------------
--[[
   tmp stuff



]]
---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:CreateNewTableFormat(aTutorialsTable)
   if not aTutorialsTable then
      return
   end

   SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials = {}
   SkuAdventureGuide.Tutorial:PLAYER_ENTERING_WORLD()

   for i, v in pairs(aTutorialsTable) do
      SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID] = SkuOptions:TableCopy(v, true)
      SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID].tutorialTitle = {}

      for langi, langv in pairs(Sku.Locs) do
         SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID].tutorialTitle[langv] = "UNTRANSLATED:"..i
         SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID].tutorialTitle[Sku.Loc] = i
      end

      for isteps, vsteps in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials[v.GUID].steps) do
         if vsteps.title then
            local tdetitle, tdebeginText = vsteps.title, vsteps.beginText
            vsteps.title = {}
            vsteps.beginText = {}
            for langi, langv in pairs(Sku.Locs) do
               vsteps.title[langv] = "UNTRANSLATED:"..tdetitle
               vsteps.beginText[langv] = "UNTRANSLATED:"..tdebeginText
            end
            vsteps.title[Sku.Loc] = tdetitle
            vsteps.beginText[Sku.Loc] = tdebeginText
   
            for triggeri, triggerv in pairs(vsteps.triggers) do
               local detriggervalue = triggerv.value
               triggerv.value = {}
               for langi, langv in pairs(Sku.Locs) do
                  if (SkuAdventureGuide.Tutorial.triggers[triggerv.type].translate and not tonumber(detriggervalue)) == true then
                     triggerv.value[langv] = "UNTRANSLATED:"..detriggervalue
                  else
                     triggerv.value[langv] = detriggervalue
                  end
               end
               triggerv.value[Sku.Loc] = detriggervalue
            end
         end
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuAdventureGuide.Tutorial:ImportOldFormatNewbieTutorials()
	PlaySound(88)
   SkuOptions.Voice:OutputStringBTtts(L["Paste data to import now"], {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })
	SkuOptions:EditBoxPasteShow("", function(self)
		PlaySound(89)
		local tSerializedData = strtrim(table.concat(_G["SkuOptionsEditBoxPaste"].SkuOptionsTextBuffer))
		if tSerializedData ~= "" then
			local tSuccess, tTutorialData = SkuOptions:Deserialize(tSerializedData)
         if tSuccess == true and tTutorialData then
            if tTutorialData.isNewbieData and tTutorialData.isNewbieData == true then
               SkuAdventureGuide.Tutorial:CreateNewTableFormat(tTutorialData.tutorialsData)
               SkuOptions.Voice:OutputStringBTtts("imported", {overwrite = true, wait = true, doNotOverwrite = true, engine = 2, })		
            end
         end
		end
	end)
end

function tmphelper()
   for i, v in pairs(SkuOptions.db.global[MODULE_NAME].AllLangs.Tutorials) do
      --v.tutorialTitle["enUS"] = "UNTRANSLATED:deDE:"..v.tutorialTitle["deDE"]
      for isteps, vsteps in pairs(v.steps) do
         for index, _ in pairs(vsteps.linkedIn) do
            if #vsteps.linkedIn[index] == 0 then
               vsteps.linkedIn[index] = nil
            end
         end
         --[[
         if vsteps.title then
            vsteps.beginText["enUS"] = "UNTRANSLATED:deDE:"..vsteps.beginText["deDE"]
            vsteps.title["enUS"] = "UNTRANSLATED:deDE:"..vsteps.title["deDE"]
            for triggeri, triggerv in pairs(vsteps.triggers) do
               if SkuAdventureGuide.Tutorial.triggers[triggerv.type].translate and not tonumber(triggerv.value["deDE"]) then
                  triggerv.value["enUS"] = "UNTRANSLATED:deDE:"..triggerv.value["deDE"]
               else
                  triggerv.value["enUS"] = triggerv.value["deDE"]
               end
            end
         end
         ]]
      end
   end
end

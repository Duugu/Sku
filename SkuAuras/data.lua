local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L

------------------------------------------------------------------------------------------------------------------
SkuAuras.actions = {
   notifyAudioBing = {
      friendlyName = "audio benachrichtigung bing",
      func = function(tAuraName, tEvaluateData)
      	dprint("action func audio benachrichtigung DING")
         dprint(tAuraName)
         setmetatable(tEvaluateData, SkuPrintMTWo)
         dprint(tEvaluateData)
         SkuOptions.Voice:OutputString("sound-success1", true, true, 0.1, true)
      end,
   },
   notifyChat = {
      friendlyName = "chat benachrichtigung",
      func = function(tAuraName, tEvaluateData)
      	dprint("action func chat benachrichtigung")
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.outputs = {
   event = {
      friendlyName = "ereignis",
      func = function(tAuraName, tEvaluateData)
      	dprint("SkuAuras.outputs.event")
         dprint(tEvaluateData.event)
         if SkuAuras.values[tEvaluateData.event].friendlyNameShort then
            SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyNameShort, true, true, 0.1, true)
         else
            SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyName, true, true, 0.1, true)
         end
      end,
   },
   spellName = {
      friendlyName = "zauber name",
      func = function(tAuraName, tEvaluateData)
      	dprint("SkuAuras.outputs.spellName")
         dprint(tEvaluateData.spellName)
         SkuOptions.Voice:OutputString(tEvaluateData.spellName, true, true, 0.1, true)
      end,
   },
   itemName = {
      friendlyName = "gegenstand name",
      func = function(tAuraName, tEvaluateData)
      	dprint("SkuAuras.outputs.itemName")
         dprint(tEvaluateData.itemName)
         SkuOptions.Voice:OutputString(tEvaluateData.itemName, true, true, 0.1, true)
      end,
   },
   itemCount = {
      friendlyName = "gegenstand anzahl",
      func = function(tAuraName, tEvaluateData)
      	dprint("SkuAuras.outputs.itemCount")
         dprint(tEvaluateData.itemName)
         SkuOptions.Voice:OutputString(tEvaluateData.itemCount, true, true, 0.1, true)
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.valuesDefault = {

   --auraAmount;itemCount
   ["0"] = {friendlyName = "0",},
   ["1"] = {friendlyName = "1",},
   ["2"] = {friendlyName = "2",},
   ["3"] = {friendlyName = "3",},
   ["4"] = {friendlyName = "4",},
   ["5"] = {friendlyName = "5",},
   ["6"] = {friendlyName = "6",},
   ["7"] = {friendlyName = "7",},
   ["8"] = {friendlyName = "8",},
   ["9"] = {friendlyName = "9",},
   ["10"] = {friendlyName = "10",},
   ["11"] = {friendlyName = "11",},
   ["12"] = {friendlyName = "12",},
   ["13"] = {friendlyName = "13",},
   ["14"] = {friendlyName = "14",},
   ["15"] = {friendlyName = "15",},
   ["16"] = {friendlyName = "16",},
   ["17"] = {friendlyName = "17",},
   ["18"] = {friendlyName = "18",},
   ["19"] = {friendlyName = "19",},
   ["20"] = {friendlyName = "20",}, 
   ["30"] = {friendlyName = "30",}, 
   ["40"] = {friendlyName = "40",}, 
   ["50"] = {friendlyName = "50",}, 
   ["100"] = {friendlyName = "100",}, 
   --auraType
   ["BUFF"] = {friendlyName = "buff",},
   ["DEBUFF"] = {friendlyName = "debuff",},
   --destUnitId
   ["target"] = {friendlyName = "target",},
   ["player"] = {friendlyName = "selbst",},
   ["party"] = {friendlyName = "gruppenmitglied",},
   ["all"] = {friendlyName = "alle",},
   --class
   ["Warrior"] = {friendlyName = "krieger",},
   ["Paladin"] = {friendlyName = "priester",},
   ["Hunter"] = {friendlyName = "jäger",},
   ["Rogue"] = {friendlyName = "schurke",},
   ["Priest"] = {friendlyName = "priester",},
   --["Death Knight"] = {friendlyName = "todesritter",},
   ["Shaman"] = {friendlyName = "schamane",},
   ["Mage"] = {friendlyName = "magier",},
   ["Warlock"] = {friendlyName = "hexer",},
   --["Monk"] = {friendlyName = "mönch",},
   ["Druid"] = {friendlyName = "druide",},
   ["Demon Hunter"] = {friendlyName = "dämonenjäger",},
   --event
   ["SPELL_AURA_APPLIED;SPELL_AURA_REFRESH;SPELL_AURA_APPLIED_DOSE"] = {friendlyName = "aura erhalten",},
   ["SPELL_AURA_REMOVED"] = {friendlyName = "aura verloren",},
   ["SPELL_CAST_START"] = {friendlyName = "zauber start",},
   ["SPELL_CAST_SUCCESS"] = {friendlyName = "zauber erfolgreich",},
   ["SPELL_COOLDOWN_START"] = {friendlyName = "zauber cooldown start",  friendlyNameShort = "cooldown start",},
   ["SPELL_COOLDOWN_END"] = {friendlyName = "zauber cooldown ende", friendlyNameShort = "bereit",},
   ["ITEM_COOLDOWN_START"] = {friendlyName = "gegenstand cooldown start", friendlyNameShort = "bereit",},
   ["ITEM_COOLDOWN_END"] = {friendlyName = "gegenstand cooldown ende", friendlyNameShort = "cooldown start",},

   ["SWING_DAMAGE"] = {friendlyName = "nahkampf schaden",},
   ["SWING_MISSED"] = {friendlyName = "nahkampf verfehlt",},
   ["SWING_EXTRA_ATTACKS"] = {friendlyName = "nahkampf zusatz angriff",},
   ["SWING_ENERGIZE"] = {friendlyName = "nahkampf ressource",},
   ["RANGE_DAMAGE"] = {friendlyName = "fernkampf schaden",},
   ["RANGE_MISSED"] = {friendlyName = "fernkampf verfehlt",},
   ["RANGE_EXTRA_ATTACKS"] = {friendlyName = "fernkampf zusatz angriff",},
   ["RANGE_ENERGIZE"] = {friendlyName = "fernkampf ressource",},
   ["SPELL_DAMAGE"] = {friendlyName = "zauber schaden",},
   ["SPELL_MISSED"] = {friendlyName = "zauber verfehlt",},
   ["SPELL_HEAL"] = {friendlyName = "zauber heilung",},
   ["SPELL_ENERGIZE"] = {friendlyName = "zauber ressource",},
   ["SPELL_INTERRUPT"] = {friendlyName = "zauber unterbrochen",},
   ["SPELL_EXTRA_ATTACKS"] = {friendlyName = "zauber zusatz angriff",},
   ["SPELL_CAST_FAILED"] = {friendlyName = "zauber fehlgeschlagen",},
   ["SPELL_CREATE"] = {friendlyName = "zauber erstellen", friendlyNameShort = "erstellen",},
   ["SPELL_SUMMON"] = {friendlyName = "zauber beschwören", friendlyNameShort = "beschwören",},
   ["SPELL_RESURRECT"] = {friendlyName = "zauber wiederbeleben",  friendlyNameShort = "wiederbeleben",},
   ["UNIT_DIED"] = {friendlyName = "einheit tot",  friendlyNameShort = "tot",},
   ["UNIT_DESTROYED"] = {friendlyName = "einheit zerstört",  friendlyNameShort = "zerstört",},
   ["ITEM_USE"] = {friendlyName = "gegenstand verwenden",  friendlyNameShort = "verwenden",},
   --spellId
      --build from skudb on PLAYER_ENTERING_WORLD
   --itemId
      --build from skudb on PLAYER_ENTERING_WORLD
   ["itemCount"] = {friendlyName = "gegenstand anzahl",  friendlyNameShort = "anzahl",},
 }

SkuAuras.values = {
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.attributes = {
   action = {
      friendlyName = "aktion",
      evaluate = function()
      	dprint("SkuAuras.attributes.action.evaluate")
      end,
      values = {
         "notifyAudioBing",
         "notifyChat",
      },
   },
   destUnitId = {
      friendlyName = "ziel",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.destUnitId.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.destUnitId then
         	dprint("             aEventData.destUnitId", aEventData.destUnitId, "aValue", aValue)
            local tEvaluation = false
            if aValue == "all" then
               return true
            elseif aValue == "party" then
               if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "player") == true then
                  tEvaluation = true
               end
               dprint(tEvaluation, "check all units in party/raid")
               for x = 1, 4 do 
                  if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "party"..x) == true then
                     tEvaluation = true
                  end
               end
               dprint(tEvaluation, "check all units in party/raid")
               for x = 1, MAX_RAID_MEMBERS do 
                  if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "raid"..x) == true then
                     tEvaluation = true
                  end
               end
               dprint(tEvaluation, "check all units in party/raid")
            else
               tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, aValue)
            end
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
         "target",
         "player",
         "party",
         "all",
      },
   },
   event = {
      friendlyName = "ereignis",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.event.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.event then
         	dprint("             aEventData.event", aEventData.event, aValue)
            local tEvaluation
         	dprint(string.find(aValue, ";"))
            if string.find(aValue, ";") then
               local tEvents = {string.split(";", aValue)}
               for i, v in pairs(tEvents) do
                  local tSingleEvaluation = SkuAuras:ProcessEvaluate(aEventData.event, aOperator, v)
               	dprint("              multi events", v, tSingleEvaluation)
                  if tSingleEvaluation == true then
                     tEvaluation = true
                  end
               end
            else
               tEvaluation = SkuAuras:ProcessEvaluate(aEventData.event, aOperator, aValue)
            	dprint("              single event", tEvaluation)
            end
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
         "SPELL_AURA_APPLIED;SPELL_AURA_REFRESH;SPELL_AURA_APPLIED_DOSE",
         "SPELL_AURA_REMOVED",
         "SPELL_CAST_START",
         "SPELL_CAST_SUCCESS",
         "SPELL_COOLDOWN_START",
         "SPELL_COOLDOWN_END",
         "ITEM_COOLDOWN_START",
         "ITEM_COOLDOWN_END",
         "SWING_DAMAGE",
         "SWING_MISSED",
         "SWING_EXTRA_ATTACKS",
         "SWING_ENERGIZE",
         "RANGE_DAMAGE",
         "RANGE_MISSED",
         "RANGE_EXTRA_ATTACKS",
         "RANGE_ENERGIZE",
         "SPELL_DAMAGE",
         "SPELL_MISSED",
         "SPELL_HEAL",
         "SPELL_ENERGIZE",
         "SPELL_INTERRUPT",
         "SPELL_EXTRA_ATTACKS",
         "SPELL_CAST_FAILED",
         "SPELL_CREATE",
         "SPELL_SUMMON",
         "SPELL_RESURRECT",
         "UNIT_DIED",
         "UNIT_DESTROYED",
         "ITEM_USE",
      },
   },
   spellId = {
      friendlyName = "zauber nr",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.spellId.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.spellId then
         	dprint("             aEventData.spellId", aEventData.spellId, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.spellId), aOperator, tonumber(aValue))
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
      },      
   },   
   spellName = {
      friendlyName = "zauber name",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.spellName.evaluate")
      	dprint("            ", aEventData, aEventData.spellName, aOperator, aValue)
         if aEventData.spellName then
         	dprint("             aEventData.spellName", aEventData.spellName, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.spellName, aOperator, aValue)
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
      },      
   },   
   itemName = {
      friendlyName = "gegenstand name",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemName.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.itemName then
         	dprint("             aEventData.itemName", aEventData.itemName, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.itemName, aOperator, aValue)
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
      },      
   },   
   itemId = {
      friendlyName = "gegenstand nr",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemId.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.itemId then
         	dprint("             aEventData.itemId", aEventData.itemId, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.itemId), aOperator, tonumber(aValue))
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
      },      
   },
   itemCount = {
      friendlyName = "gegenstand anzahl",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemCount.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.itemCount then
         	dprint("             aEventData.itemCount", aEventData.itemCount, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.itemCount), aOperator, tonumber(aValue))
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
         "0",
         "1",
         "2",
         "3",
         "4",
         "5",
         "6",
         "7",
         "8",
         "9",
         "10",
         "11",
         "12",
         "13",
         "14",
         "15",
         "16",
         "17",
         "18",
         "19",
         "20",
         "30",
         "40",
         "50",
         "100",
      },      
   },   
   auraType = {
      friendlyName = "aura typ",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.auraType.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.auraType then
         	dprint("             aEventData.auraType", aEventData.auraType, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.auraType, aOperator, aValue)
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
         "BUFF",
         "DEBUFF",
      },      
   },
   auraAmount = {
      friendlyName = "aura stacks",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.auraAmount.evaluate")
      	dprint("            ", aEventData, aOperator, aValue)
         if aEventData.auraAmount then
         	dprint("             aEventData.auraamount", aEventData.auraAmount, aValue)
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.auraAmount), aOperator, tonumber(aValue))
            if tEvaluation == true then
            	dprint("             match!")
               return true
            end
         end
      end,
      values = {
         "0",
         "1",
         "2",
         "3",
         "4",
         "5",
         "6",
         "7",
         "8",
         "9",
         "10",
         "11",
         "12",
         "13",
         "14",
         "15",
         "16",
         "17",
         "18",
         "19",
         "20",
      },      
   },
   class = {
      friendlyName = "klasse",
      evaluate = function()
      	dprint("SkuAuras.attributes.class.evaluate")













      end,
      values = {
         "warrior",
         "priest",
         "Warrior",
         "Paladin",
         "Hunter",
         "Rogue",
         "Priest",
         --"Death Knight",
         "Shaman",
         "Mage",
         "Warlock",
         --"Monk",
         "Druid",
         "Demon Hunter",
      },      
   },      
}

------------------------------------------------------------------------------------------------------------------
local function RemoveTagFromValue(aValue)
   if not aValue then
      return
   end
   dprint("............................ CleanIdTag", aValue)
   local tCleanValue = string.gsub(aValue, "item:", "")
   tCleanValue = string.gsub(tCleanValue, "spell:", "")
   dprint("                             CleanIdTag 1", aValue)
   return tCleanValue
end

SkuAuras.Operators = {
   ["then"] = {
      friendlyName = "dann",
      func = function(a) 
      	dprint("action", a)
         return
      end,
   },
   ["is"] = {
      friendlyName = "gleich",
      func = function(aValueA, aValueB) 
      	dprint("                           SkuAuras.Operators is", aValueA, aValueB)
            if RemoveTagFromValue(aValueA) == RemoveTagFromValue(aValueB) then 
            return true 
         end
         return false
      end,
   },
   ["isNot"] = {
      friendlyName = "ungleich",
      func = function(aValueA, aValueB) 
      	dprint("SkuAuras.Operators isNot", aValueA, aValueB)
         if RemoveTagFromValue(aValueA) ~= RemoveTagFromValue(aValueB) then 
            return true 
         end
         return false
      end,
   },
   ["bigger"] = {
      friendlyName = "größer",
      func = function(aValueA, aValueB) 
      	dprint("SkuAuras.Operators >", aValueA, aValueB)
         if tonumber(RemoveTagFromValue(aValueA)) > tonumber(RemoveTagFromValue(aValueB)) then 
            return true 
         end
         return false
      end,
   },
   ["smaller"] = {
      friendlyName = "kleiner",
      func = function(aValueA, aValueB) 
      	dprint("SkuAuras.Operators <", aValueA, aValueB)
         if tonumber(RemoveTagFromValue(aValueA)) < tonumber(RemoveTagFromValue(aValueB)) then 
            return true 
         end
         return false
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.Types = {
   aura = {
      friendlyName = "Aura",
      attributes = {
         "auraType",
         "destUnitId",
         "spellName",
         "spellId",
         "event",
         "auraAmount",
         "action",
      },
   },
   spell = {
      friendlyName = "Zauber",
      attributes = {
         "spellName",
         "spellId",
         "event",
         "action",
      },
   },
   item = {
      friendlyName = "gegenstand",
      attributes = {
         "itemName",
         "itemId",
         "itemCount",
         "event",
         "action",
      },
   },
   unit = {
      friendlyName = "Einheit",
      attributes = {
         "destUnitId",
         "class",
         --"mana",
         --"health",
         "action",
      },
   },   
}
﻿local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L



--[[
["sound-silence_0.5s"] = L["silent"].." "..L["0.5s"],
["sound-silence_1s"] = L["silent"].." "..L["1s"],
["sound-silence0.1"] = L["silent"].." "..L["0.1s"],
]]

SkuAuras.OutputSounds = {
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aura\\Brass1.mp3"] = L["aura;sound"].."#".."Brass1",
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aura\\Glass1.mp3"] = L["aura;sound"].."#".."Glass1",
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\aura\\WaterDrop1.mp3"] = L["aura;sound"].."#".."WaterDrop1",
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["aura;sound"].."#"..L["brang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["aura;sound"].."#"..L["bring"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["aura;sound"].."#"..L["dang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["aura;sound"].."#"..L["drmm"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["aura;sound"].."#"..L["shhhup"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["aura;sound"].."#"..L["spoing"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["aura;sound"].."#"..L["swoosh"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["aura;sound"].."#"..L["tsching"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["aura;sound"].."#"..L["silent"],
}


------------------------------------------------------------------------------------------------------------------
local function KeyValuesHelper()
   local tKeys = {
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Ä", "Ö", "Ü", 
      "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
      "BACKSPACE", "BACKSPACE_MAC", "DELETE", "DELETE_MAC", "DOWN", "END", "ENTER", "ENTER_MAC", "ESCAPE", "HOME", 
      "INSERT", "INSERT_MAC", "LEFT", "NUMLOCK", "NUMLOCK_MAC", "NUMPAD0", "NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4", 
      "NUMPAD5", "NUMPAD6", "NUMPAD7", "NUMPAD8", "NUMPAD9", "NUMPADDECIMAL", "NUMPADDIVIDE", "NUMPADMINUS", "NUMPADMULTIPLY", 
      "NUMPADPLUS", "PAGEDOWN", "PAGEUP", "PAUSE", "PAUSE_MAC", "PRINTSCREEN", "PRINTSCREEN_MAC", "RIGHT", "SCROLLLOCK", 
      "SCROLLLOCK_MAC", "SPACE", "TAB", "TILDE", "'", "%+", "´", ",", "#",
      "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
   }

   local tModifiers = {"CTRL-", "SHIFT-", "ALT-", "CTRL-SHIFT-", "CTRL-ALT-", "SHIFT-ALT-", }
   local tResultTable = {}

   for x = 1, #tKeys do
      if SkuCore.Keys.LocNames[string.upper(tKeys[x])] then
         tResultTable[tKeys[x]] = SkuCore.Keys.LocNames[string.upper(tKeys[x])]
      else
         tResultTable[tKeys[x]] = tKeys[x]
      end
   end

   for y = 1, #tModifiers do
      local tLocModifier = string.gsub(tModifiers[y], "CTRL", SkuCore.Keys.LocNames["CTRL"])
      for x = 1, #tKeys do
         if SkuCore.Keys.LocNames[string.upper(tKeys[x])] then
            tResultTable[tModifiers[y]..tKeys[x]] = tLocModifier..SkuCore.Keys.LocNames[string.upper(tKeys[x])]
         else
            tResultTable[tModifiers[y]..tKeys[x]] = tLocModifier..tKeys[x]
         end
      end
   end
   return tResultTable
end

------------------------------------------------------------------------------------------------------------------
function SkuAuras:RemoveTags(aValue)
   if not aValue then
      return
   end
   if type(aValue) ~= "string" then
      return aValue
   end
   local tCleanValue = string.gsub(aValue, "item:", "")
   tCleanValue = string.gsub(tCleanValue, "spell:", "")
   tCleanValue = string.gsub(tCleanValue, "output:", "")
   return tCleanValue
end

------------------------------------------------------------------------------------------------------------------
SkuAuras.itemTypes = {
   ["type"] = {
      friendlyName = L["Aura Typ"],
   },
   ["attribute"] = {
      friendlyName = L["Attribut für Bedingung"],
   },
   ["operator"] = {
      friendlyName = L["Operator für Bedingung"],
   },
   ["value"] = {
      friendlyName = L["Wert für Bedingung"],
   },
   ["then"] = {
      friendlyName = L["Beginn des Dann Teils der Aura"],
   },
   ["action"] = {
      friendlyName = L["Aktion für Aura"],
   },
   ["output"] = {
      friendlyName = L["Ausgabe von Aura"],
   },
}
------------------------------------------------------------------------------------------------------------------
SkuAuras.actions = {
   notifyAudio = {
      tooltip = L["Die Ausgaben werden als Audio ausgegeben"],
      friendlyName = L["audio ausgabe"],
      func = function(tAuraName, tEvaluateData)
      	----dprint("    ","action func audio benachrichtigung DING")
      end,
      single = false,
   },
   notifyChat = {
      tooltip = L["Die Ausgaben werden als Text im Chat ausgegeben"],
      friendlyName = L["chat ausgabe"],
      func = function(tAuraName, tEvaluateData)
      	----dprint("    ","action func chat benachrichtigung")
      end,
      single = false,
   },
   notifyAudioSingle = {
      tooltip = L["Die Ausgaben werden als Audio ausgegeben. Die Aura wird jedoch nur einmal ausgelöst. Die nächste Auslösung der Aura erfolgt erst dann, wenn die Aura mindestens einmal nicht zugetroffen hat."],
      friendlyName = L["audio ausgabe einmal"],
      func = function(tAuraName, tEvaluateData)
      	----dprint("    ","action func audio benachrichtigung single")
      end,
      single = true,
   },
   --[[
   notifyAudioSingleInstant = {
      tooltip = L["Die Ausgaben werden als Audio ausgegeben und dabei vor allen anderen Ausgaben platziert. Die Aura wird jedoch nur einmal ausgelöst. Die nächste Auslösung der Aura erfolgt erst dann, wenn die Aura mindestens einmal nicht zugetroffen hat."],
      friendlyName = L["audio ausgabe einmal sofort",
      func = function(tAuraName, tEvaluateData)
      	--dprint("    ","action func audio benachrichtigung SingleInstant")
      end,
      single = true,
      instant = true,
   },
   ]]
   notifyChatSingle = {
      tooltip = L["Die Ausgaben werden als Text im Chat ausgegeben. Die Aura wird jedoch nur einmal ausgelöst. Die nächste Auslösung der Aura erfolgt erst dann, wenn die Aura mindestens einmal nicht zugetroffen hat."],
      friendlyName = L["chat ausgabe einmal"],
      func = function(tAuraName, tEvaluateData)
      	--dprint("    ","action func chat benachrichtigung single")
      end,
      single = true,
   },
}

------------------------------------------------------------------------------------------------------------------
local tPrevAuraPlaySoundFileHandle
SkuAuras.outputs = {
   event = {
      tooltip = L["Der Name des auslösenden Ereignisses der Aura"],
      friendlyName = L["ereignis"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aInstant)
            --dprint("    ","SkuAuras.outputs.event", tEvaluateData.event, aFirst, aInstant)
            if not tEvaluateData.event then return end
            if not SkuAuras.values[tEvaluateData.event] then return end
            if SkuAuras.values[tEvaluateData.event].friendlyNameShort then
               SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyNameShort, aFirst, true, 0.1, true)
            else
               SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyName, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if not tEvaluateData.event then return end
            if not SkuAuras.values[tEvaluateData.event] then return end
            if SkuAuras.values[tEvaluateData.event].friendlyNameShort then
               print(SkuAuras.values[tEvaluateData.event].friendlyNameShort)
            else
               print(SkuAuras.values[tEvaluateData.event].friendlyName)
            end
         end,
      },
   },
   sourceUnitId = {
      tooltip = L["Die Einheiten ID der Quelle für das ausgelöste Ereignis"],
      friendlyName = L["quell einheit"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.sourceUnitId then
               --dprint("    ","tEvaluateData.sourceUnitId", tEvaluateData.sourceUnitId)
               SkuOptions.Voice:OutputString(tEvaluateData.sourceUnitId[1], aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.sourceUnitId then
               print(tEvaluateData.sourceUnitId)
            end
         end,
      },
   },   
   destUnitId = {
      tooltip = L["Die Einheiten ID des Ziels für das ausgelöste Ereignis"],
      friendlyName = L["ziel einheit"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            --dprint("    ","tEvaluateData.destUnitId", tEvaluateData.destUnitId)
            if tEvaluateData.destUnitId then
               SkuOptions.Voice:OutputString(tEvaluateData.destUnitId[1], aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.destUnitId then
               print(tEvaluateData.destUnitId)
            end
         end,
      },
   },
   unitHealthPlayer = {
      tooltip = L["Dein Gesundheit in Prozent"],
      friendlyName = L["eigene Gesundheit"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitHealthPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitHealthPlayer, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.unitHealthPlayer then
               print(tEvaluateData.unitHealthPlayer)
            end
         end,
      },
   },      
   auraAmount = {
      tooltip = L["Die Stapel Anzahl der Aura"],
      friendlyName = L["aura stapel"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.auraAmount then
               SkuOptions.Voice:OutputString(tEvaluateData.auraAmount, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.auraAmount then
               print(tEvaluateData.auraAmount)
            end
         end,
      },
   },
   --[[
   class = {
      tooltip = L["Die Klasse der Einheit für das ausgelöste Ereignis",
      friendlyName = L["klasse",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.class then
               SkuOptions.Voice:OutputString(tEvaluateData.class, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.class then
               print(tEvaluateData.class)
            end
         end,
      },
   },
   ]]
   unitPowerPlayer = {
      tooltip = L["Deine Ressourcen Menge (Mana, Wut, Energie) für das ausgelöste Ereignis"],
      friendlyName = L["eigene Ressource"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitPowerPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitPowerPlayer, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.unitPowerPlayer then
               print(tEvaluateData.unitPowerPlayer)
            end
         end,
      },
   },
   unitComboPlayer = {
      tooltip = L["Deine combopunkte auf dein aktuelles ziel"],
      friendlyName = L["Eigene combopunkte"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitComboPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitComboPlayer, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.unitComboPlayer then
               print(tEvaluateData.unitComboPlayer)
            end
         end,
      },
   },

   unitHealthPlayer = {
      tooltip = L["Deine Gesundheits Menge für das ausgelöste Ereignis"],
      friendlyName = L["eigene gesundheit"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitHealthPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitHealthPlayer, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.unitHealthPlayer then
               print(tEvaluateData.unitHealthPlayer)
            end
         end,
      },
   },
   spellName = {
      tooltip = L["Der Name des Zaubers, der die Aura ausgelöst hat"],
      friendlyName = L["zauber name"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.spellName then
               SkuOptions.Voice:OutputString(tEvaluateData.spellName, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.spellName then
               print(tEvaluateData.spellName)
            end
         end,
      },
   },
   itemName = {
      tooltip = L["Der Name des Gegenstands, der die Aura ausgelöst hat"],
      friendlyName = L["gegenstand name"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.itemName then
               SkuOptions.Voice:OutputString(tEvaluateData.itemName, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.itemName then
               print(tEvaluateData.itemName)
            end
         end,
      },
   },
   itemCount = {
      tooltip = L["Die Anzahl in deiner Tasche des Gegenstands, der die Aura ausgelöst hat"],
      friendlyName = L["gegenstand anzahl"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.itemCount then
               SkuOptions.Voice:OutputString(tEvaluateData.itemCount, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.itemCount then
               print(tEvaluateData.itemCount)
            end
         end,
      },
   },
   buffListTarget = {
      tooltip = L["Aura, die in der Buff liste des Ziels gesucht oder ausgeschlossen wurde"],
      friendlyName = L["wert buff liste ziel"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.buffListTarget then
               SkuOptions.Voice:OutputString(tEvaluateData.buffListTarget, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.buffListTarget then
               print(tEvaluateData.buffListTarget)
            end
         end,
      },
   },
   debuffListTarget = {
      tooltip = L["Aura, die in der Debuff liste des Ziels gesucht oder ausgeschlossen wurde"],
      friendlyName = L["wert debuff liste ziel"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.debuffListTarget then
               SkuOptions.Voice:OutputString(tEvaluateData.debuffListTarget, aFirst, true, 0.1, true)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.debuffListTarget then
               print(tEvaluateData.debuffListTarget)
            end
         end,
      },
   },
}

local tOutputSoundFiles = {
   ["sound-brass1"] = L["aura;sound"].."#"..L["brass 1"],
   ["sound-brass2"] = L["aura;sound"].."#"..L["brass 2"],
   ["sound-brass3"] = L["aura;sound"].."#"..L["brass 3"],
   ["sound-brass4"] = L["aura;sound"].."#"..L["brass 4"],
   ["sound-brass5"] = L["aura;sound"].."#"..L["brass 5"],
   ["sound-error_brang"] = L["aura;sound"].."#"..L["brang"],
   ["sound-error_bring"] = L["aura;sound"].."#"..L["bring"],
   ["sound-error_dang"] = L["aura;sound"].."#"..L["dang"],
   ["sound-error_drmm"] = L["aura;sound"].."#"..L["drmm"],
   ["sound-error_shhhup"] = L["aura;sound"].."#"..L["shhhup"],
   ["sound-error_spoing"] = L["aura;sound"].."#"..L["spoing"],
   ["sound-error_swoosh"] = L["aura;sound"].."#"..L["swoosh"],
   ["sound-error_tsching"] = L["aura;sound"].."#"..L["tsching"],
   ["sound-glass1"] = L["aura;sound"].."#"..L["glass 1"],
   ["sound-glass2"] = L["aura;sound"].."#"..L["glass 2"],
   ["sound-glass3"] = L["aura;sound"].."#"..L["glass 3"],
   ["sound-glass4"] = L["aura;sound"].."#"..L["glass 4"],
   ["sound-glass5"] = L["aura;sound"].."#"..L["glass 5"],
   ["sound-waterdrop1"] = L["aura;sound"].."#"..L["waterdrop 1"],
   ["sound-waterdrop2"] = L["aura;sound"].."#"..L["waterdrop 2"],
   ["sound-waterdrop3"] = L["aura;sound"].."#"..L["waterdrop 3"],
   ["sound-waterdrop4"] = L["aura;sound"].."#"..L["waterdrop 4"],
   ["sound-waterdrop5"] = L["aura;sound"].."#"..L["waterdrop 5"],
   ["sound-notification1"] = L["aura;sound"].."#"..L["notification"].." 1",
   ["sound-notification2"] = L["aura;sound"].."#"..L["notification"].." 2",
   ["sound-notification3"] = L["aura;sound"].."#"..L["notification"].." 3",
   ["sound-notification4"] = L["aura;sound"].."#"..L["notification"].." 4",
   ["sound-notification5"] = L["aura;sound"].."#"..L["notification"].." 5",
   ["sound-notification6"] = L["aura;sound"].."#"..L["notification"].." 6",
   ["sound-notification7"] = L["aura;sound"].."#"..L["notification"].." 7",
   ["sound-notification8"] = L["aura;sound"].."#"..L["notification"].." 8",
   ["sound-notification9"] = L["aura;sound"].."#"..L["notification"].." 9",
   ["sound-notification10"] = L["aura;sound"].."#"..L["notification"].." 10",
   ["sound-notification11"] = L["aura;sound"].."#"..L["notification"].." 11",
   ["sound-notification12"] = L["aura;sound"].."#"..L["notification"].." 12",
   ["sound-notification13"] = L["aura;sound"].."#"..L["notification"].." 13",
   ["sound-notification14"] = L["aura;sound"].."#"..L["notification"].." 14",
   ["sound-notification15"] = L["aura;sound"].."#"..L["notification"].." 15",
   ["sound-notification16"] = L["aura;sound"].."#"..L["notification"].." 16",
   ["sound-notification17"] = L["aura;sound"].."#"..L["notification"].." 17",
   ["sound-notification18"] = L["aura;sound"].."#"..L["notification"].." 18",
   ["sound-notification19"] = L["aura;sound"].."#"..L["notification"].." 19",
   ["sound-notification20"] = L["aura;sound"].."#"..L["notification"].." 20",
   ["sound-notification21"] = L["aura;sound"].."#"..L["notification"].." 21",
   ["sound-notification22"] = L["aura;sound"].."#"..L["notification"].." 22",
   ["sound-notification23"] = L["aura;sound"].."#"..L["notification"].." 23",
   ["sound-notification24"] = L["aura;sound"].."#"..L["notification"].." 24",
   ["sound-notification25"] = L["aura;sound"].."#"..L["notification"].." 25",
   ["sound-notification26"] = L["aura;sound"].."#"..L["notification"].." 26",
   ["sound-notification27"] = L["aura;sound"].."#"..L["notification"].." 27",
}
for tOutputString, tFriendlyName in pairs(tOutputSoundFiles) do
   SkuAuras.outputs[tOutputString] = {
      tooltip = tFriendlyName,
      outputString = tOutputString,
      friendlyName = tFriendlyName,
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName, aDelay)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("sound-silence0.1", true, false, 0.3, true)
            end
            SkuOptions.Voice:OutputString(tOutputString, false, true, 0.3, true)
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print(tFriendlyName)
         end,
      },
   }
end

------------------------------------------------------------------------------------------------------------------
SkuAuras.valuesDefault = {
   --auraAmount;itemCount
      ["0"] = {friendlyName = "0"},
      ["1"] = {friendlyName = "1"},
      ["2"] = {friendlyName = "2"},
      ["3"] = {friendlyName = "3"},
      ["4"] = {friendlyName = "4"},
      ["5"] = {friendlyName = "5"},
      ["6"] = {friendlyName = "6"},
      ["7"] = {friendlyName = "7"},
      ["8"] = {friendlyName = "8"},
      ["9"] = {friendlyName = "9"},
      ["10"] = {friendlyName = "10"},
      ["11"] = {friendlyName = "11"},
      ["12"] = {friendlyName = "12"},
      ["13"] = {friendlyName = "13"},
      ["14"] = {friendlyName = "14"},
      ["15"] = {friendlyName = "15"},
      ["16"] = {friendlyName = "16"},
      ["17"] = {friendlyName = "17"},
      ["18"] = {friendlyName = "18"},
      ["19"] = {friendlyName = "19"},
      ["20"] = {friendlyName = "20"},
      ["21"] = {friendlyName = "21"},
      ["22"] = {friendlyName = "22"},
      ["23"] = {friendlyName = "23"},
      ["24"] = {friendlyName = "24"},
      ["25"] = {friendlyName = "25"},
      ["26"] = {friendlyName = "26"},
      ["27"] = {friendlyName = "27"},
      ["28"] = {friendlyName = "28"},
      ["29"] = {friendlyName = "29"},
      ["30"] = {friendlyName = "30"},
      ["31"] = {friendlyName = "31"},
      ["32"] = {friendlyName = "32"},
      ["33"] = {friendlyName = "33"},
      ["34"] = {friendlyName = "34"},
      ["35"] = {friendlyName = "35"},
      ["36"] = {friendlyName = "36"},
      ["37"] = {friendlyName = "37"},
      ["38"] = {friendlyName = "38"},
      ["39"] = {friendlyName = "39"},
      ["40"] = {friendlyName = "40"},
      ["41"] = {friendlyName = "41"},
      ["42"] = {friendlyName = "42"},
      ["43"] = {friendlyName = "43"},
      ["44"] = {friendlyName = "44"},
      ["45"] = {friendlyName = "45"},
      ["46"] = {friendlyName = "46"},
      ["47"] = {friendlyName = "47"},
      ["48"] = {friendlyName = "48"},
      ["49"] = {friendlyName = "49"},
      ["50"] = {friendlyName = "50"},
      ["51"] = {friendlyName = "51"},
      ["52"] = {friendlyName = "52"},
      ["53"] = {friendlyName = "53"},
      ["54"] = {friendlyName = "54"},
      ["55"] = {friendlyName = "55"},
      ["56"] = {friendlyName = "56"},
      ["57"] = {friendlyName = "57"},
      ["58"] = {friendlyName = "58"},
      ["59"] = {friendlyName = "59"},
      ["60"] = {friendlyName = "60"},
      ["61"] = {friendlyName = "61"},
      ["62"] = {friendlyName = "62"},
      ["63"] = {friendlyName = "63"},
      ["64"] = {friendlyName = "64"},
      ["65"] = {friendlyName = "65"},
      ["66"] = {friendlyName = "66"},
      ["67"] = {friendlyName = "67"},
      ["68"] = {friendlyName = "68"},
      ["69"] = {friendlyName = "69"},
      ["70"] = {friendlyName = "70"},
      ["71"] = {friendlyName = "71"},
      ["72"] = {friendlyName = "72"},
      ["73"] = {friendlyName = "73"},
      ["74"] = {friendlyName = "74"},
      ["75"] = {friendlyName = "75"},
      ["76"] = {friendlyName = "76"},
      ["77"] = {friendlyName = "77"},
      ["78"] = {friendlyName = "78"},
      ["79"] = {friendlyName = "79"},
      ["80"] = {friendlyName = "80"},
      ["81"] = {friendlyName = "81"},
      ["82"] = {friendlyName = "82"},
      ["83"] = {friendlyName = "83"},
      ["84"] = {friendlyName = "84"},
      ["85"] = {friendlyName = "85"},
      ["86"] = {friendlyName = "86"},
      ["87"] = {friendlyName = "87"},
      ["88"] = {friendlyName = "88"},
      ["89"] = {friendlyName = "89"},
      ["90"] = {friendlyName = "90"},
      ["91"] = {friendlyName = "91"},
      ["92"] = {friendlyName = "92"},
      ["93"] = {friendlyName = "93"},
      ["94"] = {friendlyName = "94"},
      ["95"] = {friendlyName = "95"},
      ["96"] = {friendlyName = "96"},
      ["97"] = {friendlyName = "97"},
      ["98"] = {friendlyName = "98"},
      ["99"] = {friendlyName = "99"},
      ["100"] = {friendlyName = "100"},
      ["110"] = {friendlyName = "110"},
      ["120"] = {friendlyName = "120"},
      ["130"] = {friendlyName = "130"},
      ["140"] = {friendlyName = "140"},
      ["150"] = {friendlyName = "150"},
      ["200"] = {friendlyName = "200"},
      ["300"] = {friendlyName = "300"},
      ["400"] = {friendlyName = "400"},
      ["500"] = {friendlyName = "500"},

   
      ["true"] = {
         tooltip = L["triff zu"],
         friendlyName = L["wahr"],
      },
      ["false"] = {
         tooltip = L["Trifft nicht zu"],
         friendlyName = L["falsch"],
      },

   --missType
      ["ABSORB"] = {
         tooltip = L["Absorbiert"],
         friendlyName = L["Absorbiert"],
      },
      ["BLOCK"] = {
         tooltip = L["Geblockt"],
         friendlyName = L["Geblockt"],
      },
      ["DEFLECT"] = {
         tooltip = L["Umgelenkt"],
         friendlyName = L["Umgelenkt"],
      },
      ["DODGE"] = {
         tooltip = L["Ausgewichen"],
         friendlyName = L["Ausgewichen"],
      },
      ["EVADE"] = {
         tooltip = L["Vermieden"],
         friendlyName = L["Vermieden"],
      },
      ["IMMUNE"] = {
         tooltip = L["Immun"],
         friendlyName = L["Immun"],
      },
      ["MISS"] = {
         tooltip = L["Verfehlt"],
         friendlyName = L["Verfehlt"],
      },
      ["PARRY"] = {
         tooltip = L["Pariert"],
         friendlyName = L["Pariert"],
      },
      ["REFLECT"] = {
         tooltip = L["Reflektiert"],
         friendlyName = L["Reflektiert"],
      },
      ["RESIST"] = {
         tooltip = L["Widerstanden"],
         friendlyName = L["Widerstanden"],
      },
   --auraType
      ["BUFF"] = {
         tooltip = L["Reagiert, wenn der Aura-Typ ein Buff ist"],
         friendlyName = L["buff"],
      },
      ["DEBUFF"] = {
         tooltip = L["Reagiert, wenn der Aura-Typ ein Debuff ist"],
         friendlyName = L["debuff"],
      },
   --destUnitId
      ["target"] = {
         tooltip = L["dein aktuelles Ziel. Beispiel: Ein Debuff, der auf deinem aktuelle Ziel ausgelaufen ist"],
         friendlyName = L["dein ziel"],
      },
      ["player"] = {
         tooltip = L["du selbst. Beispiel: Ein Buff, der auf dich gezaubert wurde"],
         friendlyName = L["selbst"],
      },
      ["focus"] = {
         tooltip = L["dein fokus. Beispiel: Ein Buff, der auf deinen focus gezaubert wurde"],
         friendlyName = L["fokus"],
      },
      ["partyWoPlayer"] = {
         tooltip = L["ein beliebiges Gruppenmitglied. Beispiel: Ein Buff, der auf einem Gruppenmitglied ausgelaufen ist"],
         friendlyName = L["gruppenmitglieder ohne dich"],
      },
      ["party"] = {
         tooltip = L["ein beliebiges Gruppenmitglied. Beispiel: Ein Buff, der auf einem Gruppenmitglied ausgelaufen ist"],
         friendlyName = L["gruppenmitglieder"],
      },
      ["party0"] = {
         tooltip = L["Gruppenmitglied 0 (du)."],
         friendlyName = L["gruppenmitglied 0"],
      },      
      ["party1"] = {
         tooltip = L["Gruppenmitglied 1."],
         friendlyName = L["gruppenmitglied 1"],
      },      
      ["party2"] = {
         tooltip = L["Gruppenmitglied 2."],
         friendlyName = L["gruppenmitglied 2"],
      },      
      ["party3"] = {
         tooltip = L["Gruppenmitglied 3."],
         friendlyName = L["gruppenmitglied 3"],
      },      
      ["party4"] = {
         tooltip = L["Gruppenmitglied 4."],
         friendlyName = L["gruppenmitglied 4"],
      },      
      ["all"] = {
         tooltip = L["eine beliebige Einheit. Beispiel: Irgendein Mob stirbt"],
         friendlyName = L["alle"],
      },


      ["targettarget"] = {
         tooltip = L["ziel deines Ziels"],
         friendlyName = L["ziel deines ziels"],
      },
      ["focustarget"] = {
         tooltip = L["ziel deines deines fokus"],
         friendlyName = L["ziel deines fokus"],
      },
      ["party0target"] = {
         tooltip = L["ziel von Gruppenmitglied 0 (du)."],
         friendlyName = L["ziel von gruppenmitglied 0"],
      },      
      ["party1target"] = {
         tooltip = L["ziel von Gruppenmitglied 1."],
         friendlyName = L["ziel von gruppenmitglied 1"],
      },      
      ["party2target"] = {
         tooltip = L["ziel von Gruppenmitglied 2."],
         friendlyName = L["ziel von gruppenmitglied 2"],
      },      
      ["party3target"] = {
         tooltip = L["ziel von Gruppenmitglied 3."],
         friendlyName = L["ziel von gruppenmitglied 3"],
      },      
      ["party4target"] = {
         tooltip = L["ziel von Gruppenmitglied 4."],
         friendlyName = L["ziel von gruppenmitglied 4"],
      },      








   --class
      ["Warrior"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Krieger hat"],
         friendlyName = L["krieger"],
      },
      ["Paladin"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Paladin hat"],
         friendlyName = L["paladin"],
      },
      ["Hunter"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Jäger hat"],
         friendlyName = L["jäger"],
      },
      ["Rogue"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Schurke hat"],
         friendlyName = L["schurke"],
      },
      ["Priest"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Priester hat"],
         friendlyName = L["priester"],
      },
      --["Death Knight"] = {
         --tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Todesritter hat"],
         --friendlyName = L["todesritter"],
      --},
      ["Shaman"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Schamane hat"],
         friendlyName = L["schamane"],
      },
      ["Mage"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Magier hat"],
         friendlyName = L["magier"],
      },
      ["Warlock"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Hexer hat"],
         friendlyName = L["hexer"],
      },
      --["Monk"] = {
         --tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Mönch hat"],
         --friendlyName = L["mönch"],
      --},
      ["Druid"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Druide hat"],
         friendlyName = L["druide"],
      },
      ["Demon Hunter"] = {
         tooltip = L["Reagiert, wenn die Zieleinheit die Klasse Dämonenjäger hat"],
         friendlyName = L["dämonenjäger"],
      },
   --event
      ["UNIT_TARGETCHANGE"] = {
         tooltip = L["Eine Einheit hat das Ziel gewechselt. Quell Einheit ID ist die Einheit, die das Ziel gewechselt hat. Ziel Einheit ID ist das neue Ziel von Quell einheit."],
         friendlyName = L["Ziel änderung"],
         friendlyNameShort = L["ziel änderung"],
      },
      ["UNIT_POWER"] = {
         tooltip = L["Ressource hat sich verändert (Mana, Energie, Wut etc."],
         friendlyName = L["Ressourcen änderung"],
         friendlyNameShort = L["ressource"],
      },
      ["UNIT_HEALTH"] = {
         tooltip = L["Gesundheit hat sich verändert"],
         friendlyName = L["Gesundheit änderung"],
         friendlyNameShort = L["gesundheit"],
      },
      ["SPELL_AURA_APPLIED;SPELL_AURA_REFRESH;SPELL_AURA_APPLIED_DOSE"] = {
         tooltip = L["Buff oder Debuff erhalten oder erneuert"],
         friendlyName = L["aura erhalten"],
         friendlyNameShort = L["erhalten"],
      },
      ["SPELL_AURA_REMOVED"] = {
         tooltip = L["Buff oder Debuff verloren"],
         friendlyName = L["aura verloren"],
         friendlyNameShort = L["verloren"],
      },
      ["SPELL_CAST_START"] = {
         tooltip = L["Ein Zauber wurde begonnen"],
         friendlyName = L["zauber start"],
      },
      ["SPELL_CAST_SUCCESS"] = {
         tooltip = L["Ein Zauber wurde erfolgreich gezaubert"],
         friendlyName = L["zauber erfolgreich"],
      },
      ["SPELL_COOLDOWN_START"] = {
         tooltip = L["Der Cooldown eines Zaubers hat begonnen"],
         friendlyName = L["zauber cooldown start"],  
         friendlyNameShort = L["cooldown"],
      },
      ["SPELL_COOLDOWN_END"] = {
         tooltip = L["Der Cooldown eines Zaubers ist beendet"],
         friendlyName = L["zauber cooldown ende"], 
         friendlyNameShort = L["bereit"],
      },
      ["ITEM_COOLDOWN_START"] = {
         tooltip = L["Der Cooldown eines Gegenstands hat begonnen"],
         friendlyName = L["gegenstand cooldown start"], 
         friendlyNameShort = L["cooldown"],
      },
      ["ITEM_COOLDOWN_END"] = {
         tooltip = L["Der Cooldown eines Gegenstands ist beendet"],
         friendlyName = L["gegenstand cooldown ende"], 
         friendlyNameShort = L["bereit"],
      },
      ["SWING_DAMAGE"] = {
         tooltip = L["Ein Nahkampfangriff hat Schaden verursacht"],
         friendlyName = L["nahkampf schaden"],
      },
      ["SWING_MISSED"] = {
         tooltip = L["Ein Nahkampfangriff hat verfehlt"],
         friendlyName = L["nahkampf verfehlt"],
      },
      ["SWING_EXTRA_ATTACKS"] = {
         tooltip = L["Ein Nahkampfangriff hat einen Extrangriff gewährt"],
         friendlyName = L["nahkampf zusatz angriff"],
      },
      ["SWING_ENERGIZE"] = {
         tooltip = L["Ein Nahkampfangriff hat eine Ressource (Wut, Energie, Kombopunkt) gewährt"],
         friendlyName = L["nahkampf ressource"],
      },
      ["RANGE_DAMAGE"] = {
         tooltip = L["Ein Fernkampfangriff hat Schaden verursacht"],
         friendlyName = L["fernkampf schaden"],
      },
      ["RANGE_MISSED"] = {
         tooltip = L["Ein Fernkampfangriff hat verfehlt"],
         friendlyName = L["fernkampf verfehlt"],
      },
      ["RANGE_EXTRA_ATTACKS"] = {
         tooltip = L["Ein Fernkampfangriff hat einen Extraangriff ausgelöst"],
         friendlyName = L["fernkampf zusatz angriff"],
      },
      --[[
      ["RANGE_ENERGIZE"] = {
         tooltip = L[""],
         friendlyName = L["fernkampf ressource"],
      },]]
      ["SPELL_DAMAGE"] = {
         tooltip = L["Ein Zauber hat Schaden verursacht"],
         friendlyName = L["zauber schaden"],
      },
      ["SPELL_MISSED"] = {
         tooltip = L["Ein Zauber hat Schaden verfehlt"],
         friendlyName = L["zauber verfehlt"],
      },
      ["SPELL_HEAL"] = {
         tooltip = L["Ein Zauber hat Heilung verursacht"],
         friendlyName = L["zauber heilung"],
      },
      ["SPELL_ENERGIZE"] = {
         tooltip = L["Ein Zauber hat eine Ressource (Mana) gewährt"],
         friendlyName = L["zauber ressource"],
      },
      ["SPELL_INTERRUPT"] = {
         tooltip = L["Ein Zauber wurde unterbrochen"],
         friendlyName = L["zauber unterbrochen"],
      },
      ["SPELL_EXTRA_ATTACKS"] = {
         tooltip = L["Ein Zauber hat einen Extraangriff gewährt"],
         friendlyName = L["zauber zusatz angriff"],
      },
      ["SPELL_CAST_FAILED"] = {
         tooltip = L["Ein Zauber ist fehlgeschlagen"],
         friendlyName = L["zauber fehlgeschlagen"],
      },
      ["SPELL_CREATE"] = {
         tooltip = L["Etwas wurde durch einen Zauber hergestellt (z. B. Berufe-Skill)"],
         friendlyName = L["zauber erstellen"], 
         friendlyNameShort = L["erstellen"],
      },
      ["SPELL_SUMMON"] = {
         tooltip = L["Etwas wurde duch einen Zauber beschworen (z. B. Leerwandler beim Hexer"],
         friendlyName = L["zauber beschwören"], 
         friendlyNameShort = L["beschwören"],
      },
      ["SPELL_RESURRECT"] = {
         tooltip = L["Ein Zauber hat etwas wiederbelebt"],
         friendlyName = L["zauber wiederbeleben"],  
         friendlyNameShort = L["wiederbeleben"],
      },
      ["UNIT_DIED"] = {
         tooltip = L["Eine Einheit (Spieler, NPC, Mob etc.) ist gestorben"],
         friendlyName = L["einheit tot"], 
         friendlyNameShort = L["tot"],
      },
      ["UNIT_DESTROYED"] = {
         tooltip = L["Etwas wurde zerstört (z. B. ein Totem)"],
         friendlyName = L["einheit zerstört"], 
         friendlyNameShort = L["zerstört"],
      },
      ["ITEM_USE"] = {
         tooltip = L["Ein Gegenstand wurde verwendet"],
         friendlyName = L["gegenstand verwenden"], 
         friendlyNameShort = L["verwenden"],
      },
      ["KEY_PRESS"] = {
         tooltip = L["Eine Taste wurde gedrückt"],
         friendlyName = L["Taste gedrückt"], 
         friendlyNameShort = L["Taste"],
      },
   --spellId
      --build from skudb on PLAYER_ENTERING_WORLD
   --itemId
      --build from skudb on PLAYER_ENTERING_WORLD
      ["itemCount"] = {
         tooltip = L["Die Anzahl der verbleibenden Gegenstände in deinen Taschen, vom Typ des Gegenstands, der das Ereignis ausgelöst hat"],
         friendlyName = L["gegenstand anzahl"], 
         friendlyNameShort = L["anzahl"],
      },
}
--add keys for pressedKey
local tKeys = KeyValuesHelper()
for i, v in pairs (tKeys) do
   SkuAuras.valuesDefault[i] = {friendlyName = v}
end


SkuAuras.values = {
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.attributes = {
   action = {
      tooltip = L["Du legst als nächstes die Aktion fest, die bei der Auslösung der Aura passieren soll"],
      friendlyName = L["aktion"],
      evaluate = function()
      	--dprint("    ","SkuAuras.attributes.action.evaluate")
      end,
      values = {
         "notifyAudio",
         "notifyAudioSingle",
         --"notifyAudioSingleInstant",
         "notifyChat",
         "notifyChatSingle",
      },
   },
   destUnitId = {
      tooltip = L["Die Ziel-Einheit, bei der die Aura ausgelöst werden soll"],
      friendlyName = L["ziel (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.destUnitId.evaluate", aEventData.destUnitId)
         if aOperator == "is" then
            aOperator = "contains"
         elseif aOperator == "isNot" then
            aOperator = "containsNot"
         end
   
         if aEventData.destUnitId then

            if aValue == "all" then
               return true
            end
            local tEvaluation = false

            if aOperator == "containsNot" or aOperator == "contains" then
               
               if aValue == "party" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, {"player", "party0", "party1", "party2", "party3", "party4"})
               elseif aValue == "partyWoPlayer" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, {"party1", "party2", "party3", "party4"})
               else
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, aValue)
               end
            else
               for x = 1, #aEventData.destUnitId do
                  if aValue == "all" then
                     return true
                  elseif aValue == "party" or aValue == "partyWoPlayer" then
                     if aValue == "party" then
                        if SkuAuras:ProcessEvaluate(aEventData.destUnitId[x], aOperator, "player") == true then
                           tEvaluation = true
                        end
                     end
                     local tStart = 0
                     if aValue == "partyWoPlayer" then
                        tStart = 1
                     end
                     for x = tStart, 4 do 
                        if SkuAuras:ProcessEvaluate(aEventData.destUnitId[x], aOperator, "party"..x) == true then
                           tEvaluation = true
                        end
                     end
                     for x = 1, MAX_RAID_MEMBERS do 
                        if SkuAuras:ProcessEvaluate(aEventData.destUnitId[x], aOperator, "raid"..x) == true then
                           tEvaluation = true
                        end
                     end
                  else
                     tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId[x], aOperator, aValue)
                  end
               end
            end
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
         "target",
         "player",
         "party",
         "partyWoPlayer",
         "all",
         "focus",
         "party0",
         "party1",
         "party2",
         "party3",
         "party4",
         "targettarget",
         "focustarget",
         "party0target",
         "party1target",
         "party2target",
         "party3target",
         "party4target",
         
      },
   },
   targetTargetUnitId = {
      tooltip = L["Die Einheit des Ziels deines Ziels"],
      friendlyName = L["ziel deines ziels (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.targetTargetUnitId.evaluate", aEventData.targetTargetUnitId)
         if aOperator == "is" then
            aOperator = "contains"
         elseif aOperator == "isNot" then
            aOperator = "containsNot"
         end

         if aEventData.targetTargetUnitId then
            if aValue == "all" then
               return true
            end
            local tEvaluation = false

            if aOperator == "containsNot" or aOperator == "contains" then
               
               if aValue == "party" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId, aOperator, {"player", "party0", "party1", "party2", "party3", "party4"})
               elseif aValue == "partyWoPlayer" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId, aOperator, {"party1", "party2", "party3", "party4"})
               else
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId, aOperator, aValue)
               end
            else            
               for x = 1, #aEventData.targetTargetUnitId do
                  if aValue == "all" then
                     return true
                  elseif aValue == "party" then
                     if aValue == "party" then
                        if SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId[x], aOperator, "player") == true then
                           tEvaluation = true
                        end
                     end
                     local tStart = 0
                     if aValue == "partyWoPlayer" then
                        tStart = 1
                     end
                     for x = tStart, 4 do 
                        if SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId[x], aOperator, "party"..x) == true then
                           tEvaluation = true
                        end
                     end
                     for x = 1, MAX_RAID_MEMBERS do 
                        if SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId[x], aOperator, "raid"..x) == true then
                           tEvaluation = true
                        end
                     end
                  else
                     tEvaluation = SkuAuras:ProcessEvaluate(aEventData.targetTargetUnitId[x], aOperator, aValue)
                  end
               end
            end
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
         "target",
         "player",
         "party",
         "partyWoPlayer",
         "all",
         "focus",
         "party0",
         "party1",
         "party2",
         "party3",
         "party4",
         "targettarget",
         "focustarget",
         "party0target",
         "party1target",
         "party2target",
         "party3target",
         "party4target",
         
      },
   },   
   pressedKey = {
      tooltip = L["Welche Taste das Ereignis ausgelöst hat"],
      friendlyName = L["Taste"],
      evaluate = function(self, aEventData, aOperator, aValue)
         if aEventData.pressedKey then
            --dprint("    ","SkuAuras.attributes.pressedKey.evaluate", string.upper(aEventData.pressedKey), aOperator, string.upper(aValue))
            return SkuAuras:ProcessEvaluate(string.upper(aEventData.pressedKey), aOperator,string.upper(aValue))
         end
      end,
      values = {}, --values are added below the attributes table
   },
   tInCombat = {
      tooltip = L["Ob das Event im Kampf auftritt"],
      friendlyName = L["Im Kampf"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.tInCombat.evaluate", aEventData.tInCombat, aOperator, true)
         if aEventData.tInCombat then
            return SkuAuras:ProcessEvaluate(aEventData.tInCombat, aOperator,true)
         end
      end,
      values = {
         "true",
         "false",
      },
   },
   tSourceUnitIDCannAttack = {
      tooltip = L["Ob die Quell-Einheit, für die Aura ausgelöst wird, angreifbar ist"],
      friendlyName = L["Quell Einheit angreifbar"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.tSourceUnitIDCannAttack.evaluate", aEventData.tSourceUnitIDCannAttack, aOperator, true)
         if aEventData.tSourceUnitIDCannAttack then
            return SkuAuras:ProcessEvaluate(aEventData.tSourceUnitIDCannAttack, aOperator,true)
         end
      end,
      values = {
         "true",
         "false",
      },
   },
   tDestinationUnitIDCannAttack = {
      tooltip = L["Ob die Ziel-Einheit, für die Aura ausgelöst wird, angreifbar ist"],
      friendlyName = L["Ziel Einheit angreifbar"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.tDestinationUnitIDCannAttack.evaluate", aEventData.tDestinationUnitIDCannAttack, aOperator, true)
         if aEventData.tDestinationUnitIDCannAttack then
            return SkuAuras:ProcessEvaluate(aEventData.tDestinationUnitIDCannAttack, aOperator,true)
         end
      end,
      values = {
         "true",
         "false",
      },
   },
   sourceUnitId = {
      tooltip = L["Die Quell Einheit, bei der die Aura ausgelöst werden soll"],
      friendlyName = L["Quelle (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.sourceUnitId.evaluate", aEventData.sourceUnitId, aOperator, aValue)
         if aOperator == "is" then
            aOperator = "contains"
         elseif aOperator == "isNot" then
            aOperator = "containsNot"
         end

         if aValue == "all" then
            return true
         end
         if aEventData.sourceUnitId then
            if type(aEventData.sourceUnitId) ~= "table" then
               aEventData.sourceUnitId = {aEventData.sourceUnitId}
            end

            if aValue == "all" then
               return true
            end
            local tEvaluation = false

            if aOperator == "containsNot" or aOperator == "contains" then
               
               if aValue == "party" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, {"player", "party0", "party1", "party2", "party3", "party4"})
               elseif aValue == "partyWoPlayer" then
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, {"party1", "party2", "party3", "party4"})
               else
                  tEvaluation = SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, aValue)
               end


            else
               for x = 1, #aEventData.sourceUnitId do
                  if aValue == "party" then
                     if aValue == "party" then
                        if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId[x], aOperator, "player") == true then
                           tEvaluation = true
                        end
                     end
                     local tStart = 0
                     if aValue == "partyWoPlayer" then
                        tStart = 1
                     end
                     for x = tStart, 4 do 
                        if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId[x], aOperator, "party"..x) == true then
                           tEvaluation = true
                        end
                     end
                     for x = 1, MAX_RAID_MEMBERS do 
                        if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId[x], aOperator, "raid"..x) == true then
                           tEvaluation = true
                        end
                     end
                  else
                     tEvaluation = SkuAuras:ProcessEvaluate(aEventData.sourceUnitId[x], aOperator, aValue)
                  end
               end
            end

            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
         "target",
         "player",
         "party",
         "partyWoPlayer",
         "all",
         "focus",
         "party0",
         "party1",
         "party2",
         "party3",
         "party4",
         "targettarget",
         "focustarget",
         "party0target",
         "party1target",
         "party2target",
         "party3target",
         "party4target",
         
      },
   },
   event = {
      tooltip = L["Das Ereignis, das die Aura auslösen soll"],
      friendlyName = L["ereignis"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.event.evaluate")
         if aEventData.event then
            local tEvaluation
            if string.find(aValue, ";") then
               local tEvents = {string.split(";", aValue)}
               for i, v in pairs(tEvents) do
                  local tSingleEvaluation = SkuAuras:ProcessEvaluate(aEventData.event, aOperator, v)
                  if tSingleEvaluation == true then
                     tEvaluation = true
                  end
               end
            else
               tEvaluation = SkuAuras:ProcessEvaluate(aEventData.event, aOperator, aValue)
            end
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
         "UNIT_TARGETCHANGE",
         "UNIT_POWER",
         "UNIT_HEALTH",
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
         --"RANGE_ENERGIZE",
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
         "KEY_PRESS",
      },
   },
   missType = {
      tooltip = L["Der Typ des Verfehlen Ereignisses"],
      friendlyName = L["Verfehlen Typ"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.missType.evaluate")
         if aEventData.missType then
            return SkuAuras:ProcessEvaluate(aEventData.missType, aOperator, aValue)
         end
      end,
      values = {
         "ABSORB",
         "BLOCK",
         "DEFLECT",
         "DODGE",
         "EVADE",
         "IMMUNE",
         "MISS",
         "PARRY",
         "REFLECT",
         "RESIST",
      },
   },
   unitPowerPlayer = {
      tooltip = L["Dein Ressourcen Level in Prozent, das die Aura auslösen soll (deine Primärressource wie Mana, Energie, Wut etc."],
      friendlyName = L["Eigene Ressource"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.unitPowerPlayer.evaluate")
         if aEventData.unitPowerPlayer then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.unitPowerPlayer), aOperator, tonumber(aValue))
            if tEvaluation == true then
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
         "21",
         "22",
         "23",
         "24",
         "25",
         "26",
         "27",
         "28",
         "29",
         "30",
         "31",
         "32",
         "33",
         "34",
         "35",
         "36",
         "37",
         "38",
         "39",
         "40",
         "41",
         "42",
         "43",
         "44",
         "45",
         "46",
         "47",
         "48",
         "49",
         "50",
         "51",
         "52",
         "53",
         "54",
         "55",
         "56",
         "57",
         "58",
         "59",
         "60",
         "61",
         "62",
         "63",
         "64",
         "65",
         "66",
         "67",
         "68",
         "69",
         "70",
         "71",
         "72",
         "73",
         "74",
         "75",
         "76",
         "77",
         "78",
         "79",
         "80",
         "81",
         "82",
         "83",
         "84",
         "85",
         "86",
         "87",
         "88",
         "89",
         "90",
         "91",
         "92",
         "93",
         "94",
         "95",
         "96",
         "97",
         "98",
         "99",
         "100",
                 
      },
   },
   unitComboPlayer = {
      tooltip = L["Dein combopunkte auf das aktuelle ziel, die die Aura auslösen sollen"],
      friendlyName = L["Eigene combopunkte"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("    ","SkuAuras.attributes.unitComboPlayer.evaluate", aEventData.unitComboPlayer)
         if aEventData.unitComboPlayer then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.unitComboPlayer), aOperator, tonumber(aValue))
            if tEvaluation == true then
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
      },
   },   
   unitHealthPlayer = {
      tooltip = L["Dein gesundheits Level in Prozent, das die Aura auslösen soll"],
      friendlyName = L["Eigene Gesundheit"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.unitHealthPlayer.evaluate")
         if aEventData.unitHealthPlayer then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.unitHealthPlayer), aOperator, tonumber(aValue))
            if tEvaluation == true then
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
         "21",
         "22",
         "23",
         "24",
         "25",
         "26",
         "27",
         "28",
         "29",
         "30",
         "31",
         "32",
         "33",
         "34",
         "35",
         "36",
         "37",
         "38",
         "39",
         "40",
         "41",
         "42",
         "43",
         "44",
         "45",
         "46",
         "47",
         "48",
         "49",
         "50",
         "51",
         "52",
         "53",
         "54",
         "55",
         "56",
         "57",
         "58",
         "59",
         "60",
         "61",
         "62",
         "63",
         "64",
         "65",
         "66",
         "67",
         "68",
         "69",
         "70",
         "71",
         "72",
         "73",
         "74",
         "75",
         "76",
         "77",
         "78",
         "79",
         "80",
         "81",
         "82",
         "83",
         "84",
         "85",
         "86",
         "87",
         "88",
         "89",
         "90",
         "91",
         "92",
         "93",
         "94",
         "95",
         "96",
         "97",
         "98",
         "99",
         "100",
                 
      },      
   },
   spellId = {
      tooltip = L["Die Zauber-ID, die die Aura auslösen soll"],
      friendlyName = L["zauber nr"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.spellId.evaluate")
         if aEventData.spellId then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.spellId), aOperator, tonumber(aValue))
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
      },      
   },


   spellNameOnCd = {
      tooltip = L["Ob ein Zauber gerade auf CD ist"],
      friendlyName = L["zauber auf cd (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.spellNameOnCd.evaluate", aEventData, aOperator, aValue)
         if aOperator == "is" then
            aOperator = "contains"
         elseif aOperator == "isNot" then
            aOperator = "containsNot"
         end

         if aEventData.spellsNamesOnCd then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.spellsNamesOnCd, aOperator, SkuAuras:RemoveTags(aValue))
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
      },      
   },


--[[
   spellNameNotOnCd = {
      tooltip = L["Ob ein Zauber gerade nicht auf CD ist"],
      friendlyName = L["zauber nicht auf cd (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.spellNameNotOnCd.evaluate", aValue)
         if aEventData.spellsNamesOnCd then
            --dprint("aEventData.spellsNamesOnCd")
            setmetatable(aEventData.spellsNamesOnCd, SkuPrintMTWo)
            --dprint(aEventData.spellsNamesOnCd)
      
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.spellsNamesOnCd[aValue], aOperator, aValue)
            if tEvaluation == false then
               return true
            end
         end
      end,
      values = {
      },      
   },
]]

   spellName = {
      tooltip = L["Der Zauber-name, der die Aura auslösen soll"],
      friendlyName = L["zauber name"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.spellName.evaluate")
         if aEventData.spellName then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.spellName, aOperator, aValue)
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
      },      
   },
   buffListTarget = {
      tooltip = L["Die Liste der Buffs des Ziels"],
      friendlyName = L["Buff Liste Ziel (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.buffListTarget.evaluate", aEventData, aOperator, aValue)
         if aEventData.buffListTarget then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.buffListTarget, aOperator, SkuAuras:RemoveTags(aValue))
            if tEvaluation == true then
               return true
            end
         end
         return false
      end,
      values = {
      },      
   },
   debuffListTarget = {
      tooltip = L["Die Liste der Debuffs  des Ziels"],
      friendlyName = L["Debuff Liste Ziel (L)"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.debuffListTarget.evaluate", aEventData.debuffListTarget)
         if aEventData.debuffListTarget then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.debuffListTarget, aOperator, SkuAuras:RemoveTags(aValue))
            if tEvaluation == true then
               return true
            end
         end
         return false
      end,
      values = {
      },      
   },
   itemName = {
      tooltip = L["Der Gegenstandsname, der die Aura auslösen soll"],
      friendlyName = L["gegenstand name"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.itemName.evaluate")
         if aEventData.itemName then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.itemName, aOperator, aValue)
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
      },      
   },
   itemId = {
      tooltip = L["Die Gegenstands-ID, die die Aura auslösen soll"],
      friendlyName = L["gegenstand nr"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.itemId.evaluate")
         if aEventData.itemId then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.itemId), aOperator, tonumber(aValue))
            if tEvaluation == true then
               return true
            end
         end
      end,
      values = {
      },      
   },
   itemCount = {
      tooltip = L["Die verbleibende Menge eines Gegenstands in deinen Taschen, bei der die auslösen soll"],
      friendlyName = L["gegenstand anzahl"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.itemCount.evaluate")
         if aEventData.itemCount then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.itemCount), aOperator, tonumber(aValue))
            if tEvaluation == true then
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
         "21",
         "22",
         "23",
         "24",
         "25",
         "26",
         "27",
         "28",
         "29",
         "30",
         "31",
         "32",
         "33",
         "34",
         "35",
         "36",
         "37",
         "38",
         "39",
         "40",
         "41",
         "42",
         "43",
         "44",
         "45",
         "46",
         "47",
         "48",
         "49",
         "50",
         "51",
         "52",
         "53",
         "54",
         "55",
         "56",
         "57",
         "58",
         "59",
         "60",
         "61",
         "62",
         "63",
         "64",
         "65",
         "66",
         "67",
         "68",
         "69",
         "70",
         "71",
         "72",
         "73",
         "74",
         "75",
         "76",
         "77",
         "78",
         "79",
         "80",
         "81",
         "82",
         "83",
         "84",
         "85",
         "86",
         "87",
         "88",
         "89",
         "90",
         "91",
         "92",
         "93",
         "94",
         "95",
         "96",
         "97",
         "98",
         "99",
         "100",
         "110",
         "120",
         "130",
         "140",
         "150",
         "200",
         "300",
         "400",
         "500",
         
      },      
   },
   auraType = {
      tooltip = L["Der Aura-Typ (Buff oder Debuff), der die Aura auslösen soll"],
      friendlyName = L["buff/debuff"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.auraType.evaluate")
         if aEventData.auraType then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.auraType, aOperator, aValue)
            if tEvaluation == true then
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
      tooltip = L["Die Anzahl der Stacks einer Aura (Buff oder Debuff), bei der die Aura auslösen soll"],
      friendlyName = L["aura stacks"],
      evaluate = function(self, aEventData, aOperator, aValue)
      	--dprint("    ","SkuAuras.attributes.auraAmount.evaluate")
         if aEventData.auraAmount then
            local tEvaluation = SkuAuras:ProcessEvaluate(tonumber(aEventData.auraAmount), aOperator, tonumber(aValue))
            if tEvaluation == true then
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
         "21",
         "22",
         "23",
         "24",
         "25",
         "26",
         "27",
         "28",
         "29",
         "30",
         "31",
         "32",
         "33",
         "34",
         "35",
         "36",
         "37",
         "38",
         "39",
         "40",
         "41",
         "42",
         "43",
         "44",
         "45",
         "46",
         "47",
         "48",
         "49",
         "50",
         "51",
         "52",
         "53",
         "54",
         "55",
         "56",
         "57",
         "58",
         "59",
         "60",
         "61",
         "62",
         "63",
         "64",
         "65",
         "66",
         "67",
         "68",
         "69",
         "70",
         "71",
         "72",
         "73",
         "74",
         "75",
         "76",
         "77",
         "78",
         "79",
         "80",
         "81",
         "82",
         "83",
         "84",
         "85",
         "86",
         "87",
         "88",
         "89",
         "90",
         "91",
         "92",
         "93",
         "94",
         "95",
         "96",
         "97",
         "98",
         "99",
         "100",
         
      },      
   },
   class = {
      tooltip = L["Der Klasse, die die Aura auslösen soll"],
      friendlyName = L["klasse"],
      evaluate = function()
      	--dprint("    ","SkuAuras.attributes.class.evaluate")













      end,
      values = {
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
local tKeys = KeyValuesHelper()
for i, v in pairs (tKeys) do
   table.insert(SkuAuras.attributes.pressedKey.values , i)
end

------------------------------------------------------------------------------------------------------------------
SkuAuras.Operators = {
   ["then"] = {
      tooltip = L[""],
      friendlyName = L["dann"],
      func = function(a) 
      	--dprint("    ","action", a)
         return
      end,
   },
   ["is"] = {
      tooltip = L["Gewähltes Attribut entspricht dem gewählten Wert"],
      friendlyName = L["gleich"],
      func = function(aValueA, aValueB) 
      	--dprint("      ","SkuAuras.Operators is", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         --if type(aValueA) == "table" then return false end
         --dprint("type", type(aValueA))
         if type(aValueA) == "table" then 
            --dprint("      ","TABLE")
            for tName, tValue in pairs(aValueA) do
               if type(aValueB) == "table" then
                  for tNameB, tValueB in pairs(aValueB) do
                     --dprint("      ","SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB)", tName, tValue, SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB), SkuAuras:RemoveTags(tName) == SkuAuras:RemoveTags(tValueB))
                     local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(tValueB)
                     if tResult == true then
                        return true
                     end
                  end
               else
                  --dprint("      ","SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB)", tName, tValue, SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(aValueB), SkuAuras:RemoveTags(tName) == SkuAuras:RemoveTags(aValueB))
                  local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(aValueB)
                  if tResult == true then
                     return true
                  end
               end
            end
         else
            --dprint("      ","SINGLE")
            if SkuAuras:RemoveTags(aValueA) == SkuAuras:RemoveTags(aValueB) then 
               return true 
            end
         end
         return false
      end,
   },
   ["isNot"] = {
      tooltip = L["Gewähltes Attribut entspricht nicht dem gewählten Wert"],
      friendlyName = L["ungleich"],
      func = function(aValueA, aValueB) 
      	----dprint("      ","SkuAuras.Operators isNot", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         --if type(aValueA) == "table" then return false end
         if type(aValueA) == "table" then 
            for tName, tValue in pairs(aValueA) do
               if type(aValueB) == "table" then
                  for tNameB, tValueB in pairs(aValueB) do
                     --dprint("      ","SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB)", tName, SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB))
                     local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(tValueB)
                     if tResult == true then
                        return true
                     end
                  end
               else
                  --dprint("      ","SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(tValueB)", tName, SkuAuras:RemoveTags(tValue), SkuAuras:RemoveTags(aValueB))
                  local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(aValueB)
                  if tResult == true then
                     return true
                  end
               end
            end
         else

            if SkuAuras:RemoveTags(aValueA) ~= SkuAuras:RemoveTags(aValueB) then 
               return true 
            end
         end
         return false
      end,
   },
   ["contains"] = {
      tooltip = L["Gewähltes Attribut enthält den gewählten Wert"],
      friendlyName = L["enthält"],
      func = function(aValueA, aValueB) 
      	----dprint("      ","SkuAuras.Operators contains", aValueA, aValueB)
         if not aValueA or not aValueB then return false end

         if type(aValueB) ~= "table" then 
            aValueB = {aValueB}
         end
         --dprint("      contains")
         --dprint("      ","type(aValueA) type(aValueB)", type(aValueA), type(aValueB))
         if type(aValueA) == "table" then 
            --dprint("      TABLE")
            for tName, tValue in pairs(aValueA) do
               for tNameB, tValueB in pairs(aValueB) do
                  --dprint("      tValue", SkuAuras:RemoveTags(tValue))
                  --dprint("      tValueB", SkuAuras:RemoveTags(tValueB))
                  --dprint("      tName", SkuAuras:RemoveTags(tName))
                  --dprint("      tNameB", SkuAuras:RemoveTags(tNameB))
                  --dprint("       result", SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(tValueB))
                  local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(tValueB)
                  if tResult == true then
                     return true
                  end
               end
            end
         else
            --dprint("      SINGLE")
            for tNameB, tValueB in pairs(aValueB) do
               --dprint("      ", SkuAuras:RemoveTags(tValueA))
               --dprint("      ", SkuAuras:RemoveTags(tValueB))
               --dprint("      ", SkuAuras:RemoveTags(tNameB))
               --dprint("        ", SkuAuras:RemoveTags(aValueA) == SkuAuras:RemoveTags(tValueB))
               if SkuAuras:RemoveTags(aValueA) == SkuAuras:RemoveTags(tValueB) then 
                  return true 
               end
            end
         end
         --return false
      end,
   },   
   ["containsNot"] = {
      tooltip = L["Gewähltes Attribut enthält nicht den gewählten Wert"],
      friendlyName = L["enthält nicht"],
      func = function(aValueA, aValueB) 
      	----dprint("      ","SkuAuras.Operators containsNot", aValueA, aValueB)
         if not aValueA or not aValueB then return false end

         if type(aValueB) ~= "table" then 
            aValueB = {aValueB}
         end


         if type(aValueA) == "table" then 
            local tFound = false
            for tName, tValue in pairs(aValueA) do
               for tNameB, tValueB in pairs(aValueB) do
                  --dprint("    ","tName", tName, tValue, tNameB, tValueB)
                  local tResult = SkuAuras:RemoveTags(tValue) == SkuAuras:RemoveTags(tValueB)
                  if tResult == true then
                     tFound = true
                  end
               end
            end
            if tFound == false then
               return true
            else
               return false
            end
         else
            local tFound = false
            for tNameB, tValueB in pairs(aValueB) do
               if SkuAuras:RemoveTags(aValueA) == SkuAuras:RemoveTags(tValueB) then 
                  tFound = true
               end
            end
            if tFound == false then
               return true
            else
               return false
            end            
         end
         --return true
      end,
   },   
   ["bigger"] = {
      tooltip = L["Gewähltes Attribut ist größer als der gewählte Wert"],
      friendlyName = L["größer"],
      func = function(aValueA, aValueB) 
      	----dprint("      ","SkuAuras.Operators >", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end
         if tonumber(SkuAuras:RemoveTags(aValueA)) > tonumber(SkuAuras:RemoveTags(aValueB)) then 
            return true 
         end
         return false
      end,
   },
   ["smaller"] = {
      tooltip = L["Gewähltes Attribut ist kleiner als der gewählte Wert"],
      friendlyName = L["kleiner"],
      func = function(aValueA, aValueB) 
      	----dprint("      ","SkuAuras.Operators <", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end
         if tonumber(SkuAuras:RemoveTags(aValueA)) < tonumber(SkuAuras:RemoveTags(aValueB)) then 
            return true 
         end
         return false
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.Types = {
   ["if"] = {
      tooltip = L["Wenn die Bedingungen dieser Aura zutreffen"],
      friendlyName = L["Wenn"],
      attributes = {
         "action",
         "destUnitId",
         "targetTargetUnitId",
         "sourceUnitId",
         "event",
         "unitPowerPlayer",
         "unitHealthPlayer",
         "spellId",
         "spellNameOnCd",
         "spellNameNotOnCd",
         "spellName",
         "buffListTarget",
         "debuffListTarget",
         "itemName",
         "itemId",
         "itemCount",
         "auraType",
         "auraAmount",
         "missType",
         "tSourceUnitIDCannAttack",
         "tDestinationUnitIDCannAttack",
         "tInCombat",
         "pressedKey",
         --"class",
      },
   },
   ["ifNot"] = {
      tooltip = L["Wenn die Bedingungen dieser Aura nicht zutreffen"],
      friendlyName = L["Wenn nicht"],
      attributes = {
         "action",
         "destUnitId",
         "sourceUnitId",
         "event",
         "unitPowerPlayer",
         "unitHealthPlayer",
         "spellId",
         "spellNameOnCd",
         "spellNameNotOnCd",
         "spellName",
         "buffListTarget",
         "debuffListTarget",
         "itemName",
         "itemId",
         "itemCount",
         "auraType",
         "auraAmount",
         "missType",
         "tSourceUnitIDCannAttack",
         "tDestinationUnitIDCannAttack",
         "tInCombat",
         "pressedKey",
         --"class",
      },
   },
}
--[[
------------------------------------------------------------------------------------------------------------------
SkuAuras.Types = {
   aura = {
      tooltip = L["Ein Ereignis im Zusammenhang mit einem Buff oder Debuff löst die Aura aus",
      friendlyName = L["Aura",
      attributes = {
         "auraType",
         "sourceUnitId",
         "destUnitId",
         "spellName",
         "spellId",
         "event",
         "auraAmount",
         "unitHealthPlayer",
         "unitPowerPlayer",
         "buffListTarget",
         "debuffListTarget",
         "action",
      },
   },
   spell = {
      tooltip = L["Ein Ereignis im Zusammenhang mit einem Zauber löst die Aura aus",
      friendlyName = L["Zauber",
      attributes = {
         "spellName",
         "spellId",
         "sourceUnitId",
         "destUnitId",
         "event",
         "unitHealthPlayer",
         "unitPowerPlayer",
         "buffListTarget",
         "debuffListTarget",
         "action",
      },
   },
   item = {
      tooltip = L["Ein Ereignis im Zusammenhang mit einem Gegenstand löst die Aura aus",
      friendlyName = L["gegenstand",
      attributes = {
         "itemName",
         "itemId",
         "itemCount",
         "sourceUnitId",
         "destUnitId",
         "event",
         "unitHealthPlayer",
         "unitPowerPlayer",
         "buffListTarget",
         "debuffListTarget",
         "action",
      },
   },
   unit = {
      tooltip = L["Ein Ereignis im Zusammenhang mit einer Einheit (Spieler, NPC, Mob) löst die Aura aus",
      friendlyName = L["Einheit",
      attributes = {
         "sourceUnitId",
         "destUnitId",
         "class",
         "event",
         "unitPowerPlayer",
         "unitHealthPlayer",
         "buffListTarget",
         "debuffListTarget",
         "action",
      },
   },   
}]]
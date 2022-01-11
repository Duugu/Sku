local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L

SkuAuras.OutputSounds = {
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
local function RemoveTags(aValue)
   if not aValue then
      return
   end
   local tCleanValue = string.gsub(aValue, "item:", "")
   tCleanValue = string.gsub(tCleanValue, "spell:", "")
   tCleanValue = string.gsub(tCleanValue, "output:", "")
   return tCleanValue
end

------------------------------------------------------------------------------------------------------------------
SkuAuras.itemTypes = {
   ["type"] = {
      friendlyName = "Aura Typ",
   },
   ["attribute"] = {
      friendlyName = "Attribut für Bedingung",
   },
   ["operator"] = {
      friendlyName = "Operator für Bedingung",
   },
   ["value"] = {
      friendlyName = "Wert für Bedingung",
   },
   ["then"] = {
      friendlyName = "Beginn des Dann Teils der Aura",
   },
   ["action"] = {
      friendlyName = "Aktion für Aura",
   },
   ["output"] = {
      friendlyName = "Ausgabe von Aura",
   },
}
------------------------------------------------------------------------------------------------------------------
SkuAuras.actions = {
   notifyAudio = {
      tooltip = "Die Ausgaben werden als Audio ausgegeben",
      friendlyName = "audio ausgabe",
      func = function(tAuraName, tEvaluateData)
      	dprint("action func audio benachrichtigung DING")
      end,
   },
   notifyChat = {
      tooltip = "Die Ausgaben werden als Text im Chat ausgegeben",
      friendlyName = "chat ausgabe",
      func = function(tAuraName, tEvaluateData)
      	dprint("action func chat benachrichtigung")
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
local tPrevAuraPlaySoundFileHandle
SkuAuras.outputs = {
   soundbrang = {
      tooltip = "Ein brang Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg",
      friendlyName = L["aura;sound"].."#"..L["brang"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("Bing")
         end,
      },
   },   
   soundbring = {
      tooltip = "Ein bring Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg",
      friendlyName = L["aura;sound"].."#"..L["bring"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("bring")
         end,
      },
   },
   sounddang = {
      tooltip = "Ein dang Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg",
      friendlyName = L["aura;sound"].."#"..L["dang"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("dang")
         end,
      },
   },   
   sounddrmm = {
      tooltip = "Ein drmm Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg",
      friendlyName = L["aura;sound"].."#"..L["drmm"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("drmm")
         end,
      },
   },   
   soundshhhup = {
      tooltip = "Ein shhhup Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg",
      friendlyName = L["aura;sound"].."#"..L["shhhup"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("shhhup")
         end,
      },
   },   
   soundspoing = {
      tooltip = "Ein spoing Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg",
      friendlyName = L["aura;sound"].."#"..L["spoing"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("spoing")
         end,
      },
   },   
   soundswoosh = {
      tooltip = "Ein swoosh Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg",
      friendlyName = L["aura;sound"].."#"..L["swoosh"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("swoosh")
         end,
      },
   },   
   soundtsching = {
      tooltip = "Ein tsching Sound",
      soundfile = "Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg",
      friendlyName = L["aura;sound"].."#"..L["tsching"],
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst, aOutputName)
            if aFirst == true then
               if tPrevAuraPlaySoundFileHandle then
                  StopSound(tPrevAuraPlaySoundFileHandle)
               end
               SkuOptions.Voice:OutputString("silence_0.5s", true, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            else
               SkuOptions.Voice:OutputString("silence_0.5s", false, true, 0.3, true)
               local willPlay, soundHandle = PlaySoundFile(SkuAuras.outputs[RemoveTags(aOutputName)].soundfile, "Talking Head")
               tPrevAuraPlaySoundFileHandle = soundHandle
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            print("tsching")
         end,
      },
   },   
   event = {
      tooltip = "Der Name des auslösenden Ereignisses der Aura",
      friendlyName = "ereignis",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            dprint("SkuAuras.outputs.event", tEvaluateData.event)
            if not tEvaluateData.event then return end
            if not SkuAuras.values[tEvaluateData.event] then return end
            if SkuAuras.values[tEvaluateData.event].friendlyNameShort then
               SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyNameShort, aFirst, true, 0.1, false)
            else
               SkuOptions.Voice:OutputString(SkuAuras.values[tEvaluateData.event].friendlyName, aFirst, true, 0.1, false)
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
   --[[
   auraType = {
      tooltip = "Der Typ der ausgelösten Aura",
      friendlyName = "aura typ",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.auraType then
               SkuOptions.Voice:OutputString(tEvaluateData.auraType, aFirst, true, 0.1, false)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.auraType then
               print(tEvaluateData.auraType)
            end
         end,
      },
   },
   ]]
   sourceUnitId = {
      tooltip = "Die Einheiten ID der Quelle für das ausgelöste Ereignis",
      friendlyName = "quell einheit",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.sourceUnitId then
               dprint("tEvaluateData.sourceUnitId", tEvaluateData.sourceUnitId)
               SkuOptions.Voice:OutputString(tEvaluateData.sourceUnitId, aFirst, true, 0.1, false)
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
      tooltip = "Die Einheiten ID des Ziels für das ausgelöste Ereignis",
      friendlyName = "ziel einheit",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            dprint("tEvaluateData.destUnitId", tEvaluateData.destUnitId)
            if tEvaluateData.destUnitId then
               SkuOptions.Voice:OutputString(tEvaluateData.destUnitId, aFirst, true, 0.1, false)
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
      tooltip = "Dein Gesundheit in Prozent",
      friendlyName = "eigene Gesundheit",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitHealthPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitHealthPlayer, aFirst, true, 0.1, false)
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
      tooltip = "Die Stapel Anzahl der Aura",
      friendlyName = "aura stapel",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.auraAmount then
               SkuOptions.Voice:OutputString(tEvaluateData.auraAmount, aFirst, true, 0.1, false)
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
      tooltip = "Die Klasse der Einheit für das ausgelöste Ereignis",
      friendlyName = "klasse",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.class then
               SkuOptions.Voice:OutputString(tEvaluateData.class, aFirst, true, 0.1, false)
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
      tooltip = "Deine Ressourcen Menge (Mana, Wut, Energie) für das ausgelöste Ereignis",
      friendlyName = "eigene Ressource",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitPowerPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitPowerPlayer, aFirst, true, 0.1, false)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.unitPowerPlayer then
               print(tEvaluateData.unitPowerPlayer)
            end
         end,
      },
   },
   unitHealthPlayer = {
      tooltip = "Deine Gesundheits Menge für das ausgelöste Ereignis",
      friendlyName = "eigene gesundheit",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.unitHealthPlayer then
               SkuOptions.Voice:OutputString(tEvaluateData.unitHealthPlayer, aFirst, true, 0.1, false)
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
      tooltip = "Der Name des Zaubers, der die Aura ausgelöst hat",
      friendlyName = "zauber name",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.spellName then
               SkuOptions.Voice:OutputString(tEvaluateData.spellName, aFirst, true, 0.1, false)
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
      tooltip = "Der Name des Gegenstands, der die Aura ausgelöst hat",
      friendlyName = "gegenstand name",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.itemName then
               SkuOptions.Voice:OutputString(tEvaluateData.itemName, aFirst, true, 0.1, false)
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
      tooltip = "Die Anzahl in deiner Tasche des Gegenstands, der die Aura ausgelöst hat",
      friendlyName = "gegenstand anzahl",
      functs = {
         ["notifyAudio"] = function(tAuraName, tEvaluateData, aFirst)
            if tEvaluateData.itemCount then
               SkuOptions.Voice:OutputString(tEvaluateData.itemCount, aFirst, true, 0.1, false)
            end
         end,
         ["notifyChat"] = function(tAuraName, tEvaluateData)
            if tEvaluateData.itemCount then
               print(tEvaluateData.itemCount)
            end
         end,
      },
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
      ["60"] = {friendlyName = "60",}, 
      ["70"] = {friendlyName = "70",}, 
      ["80"] = {friendlyName = "80",}, 
      ["90"] = {friendlyName = "90",}, 
      ["100"] = {friendlyName = "100",}, 
   --missType
      ["ABSORB"] = {
         tooltip = "Absorbiert",
         friendlyName = "Absorbiert",
      },
      ["BLOCK"] = {
         tooltip = "Geblockt",
         friendlyName = "Geblockt",
      },
      ["DEFLECT"] = {
         tooltip = "Umgelenkt",
         friendlyName = "Umgelenkt",
      },
      ["DODGE"] = {
         tooltip = "Ausgewichen",
         friendlyName = "Ausgewichen",
      },
      ["EVADE"] = {
         tooltip = "Vermieden",
         friendlyName = "Vermieden",
      },
      ["IMMUNE"] = {
         tooltip = "Immun",
         friendlyName = "Immun",
      },
      ["MISS"] = {
         tooltip = "Verfehlt",
         friendlyName = "Verfehlt",
      },
      ["PARRY"] = {
         tooltip = "Pariert",
         friendlyName = "Pariert",
      },
      ["REFLECT"] = {
         tooltip = "Reflektiert",
         friendlyName = "Reflektiert",
      },
      ["RESIST"] = {
         tooltip = "Widerstanden",
         friendlyName = "Widerstanden",
      },
   --auraType
      ["BUFF"] = {
         tooltip = "Reagiert, wenn der Aura-Typ ein Buff ist",
         friendlyName = "buff",
      },
      ["DEBUFF"] = {
         tooltip = "Reagiert, wenn der Aura-Typ ein Debuff ist",
         friendlyName = "debuff",
      },
   --destUnitId
      ["target"] = {
         tooltip = "Reagiert auf ein Ereignis, das für dein aktuelles Ziel aufgetreten ist. Beispiel: Ein Debuff, der auf deinem aktuelle Ziel ausgelaufen ist",
         friendlyName = "target",
      },
      ["player"] = {
         tooltip = "Reagiert auf ein Ereignis, das für dich selbst aufgetreten ist. Beispiel: Ein Buff, der auf dich gezaubert wurde",
         friendlyName = "selbst",
      },
      ["party"] = {
         tooltip = "Reagiert auf ein Ereignis, das für ein Gruppenmitglied aufgetreten ist. Beispiel: Ein Buff, der auf einem Gruppenmitglied ausgelaufen ist",
         friendlyName = "gruppenmitglied",
      },
      ["all"] = {
         tooltip = "Reagiert auf ein Ereignis, dass für eine beliebige Einheit aufgetreten ist. Beispiel: Irgendein Mob stirbt",
         friendlyName = "alle",
      },
   --class
      ["Warrior"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Krieger hat",
         friendlyName = "krieger",
      },
      ["Paladin"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Paladin hat",
         friendlyName = "paladin",
      },
      ["Hunter"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Jäger hat",
         friendlyName = "jäger",
      },
      ["Rogue"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Schurke hat",
         friendlyName = "schurke",
      },
      ["Priest"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Priester hat",
         friendlyName = "priester",
      },
      --["Death Knight"] = {
         --tooltip = "Reagiert, wenn die Zieleinheit die Klasse Todesritter hat",
         --friendlyName = "todesritter",
      --},
      ["Shaman"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Schamane hat",
         friendlyName = "schamane",
      },
      ["Mage"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Magier hat",
         friendlyName = "magier",
      },
      ["Warlock"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Hexer hat",
         friendlyName = "hexer",
      },
      --["Monk"] = {
         --tooltip = "Reagiert, wenn die Zieleinheit die Klasse Mönch hat",
         --friendlyName = "mönch",
      --},
      ["Druid"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Druide hat",
         friendlyName = "druide",
      },
      ["Demon Hunter"] = {
         tooltip = "Reagiert, wenn die Zieleinheit die Klasse Dämonenjäger hat",
         friendlyName = "dämonenjäger",
      },
   --event
      ["UNIT_TARGETCHANGE"] = {
         tooltip = "Eine Einheit hat das Ziel gewechselt. Quell Einheit ID ist die Einheit, die das Ziel gewechselt hat. Ziel Einheit ID ist das neue Ziel von Quell einheit.",
         friendlyName = "Ziel änderung",
      },
      ["UNIT_POWER"] = {
         tooltip = "Ressource hat sich verändert (Mana, Energie, Wut etc.",
         friendlyName = "Ressourcen änderung",
      },
      ["UNIT_HEALTH"] = {
         tooltip = "Gesundheit hat sich verändert",
         friendlyName = "Gesundheit änderung",
      },
      ["SPELL_AURA_APPLIED;SPELL_AURA_REFRESH;SPELL_AURA_APPLIED_DOSE"] = {
         tooltip = "Buff oder Debuff erhalten oder erneuert",
         friendlyName = "aura erhalten",
         friendlyNameShort = "erhalten",
      },
      ["SPELL_AURA_REMOVED"] = {
         tooltip = "Buff oder Debuff verloren",
         friendlyName = "aura verloren",
         friendlyNameShort = "verloren",
      },
      ["SPELL_CAST_START"] = {
         tooltip = "Ein Zauber wurde begonnen",
         friendlyName = "zauber start",
      },
      ["SPELL_CAST_SUCCESS"] = {
         tooltip = "Ein Zauber wurde erfolgreich gezaubert",
         friendlyName = "zauber erfolgreich",
      },
      ["SPELL_COOLDOWN_START"] = {
         tooltip = "Der Cooldown eines Zaubers hat begonnen",
         friendlyName = "zauber cooldown start",  
         friendlyNameShort = "cooldown",
      },
      ["SPELL_COOLDOWN_END"] = {
         tooltip = "Der Cooldown eines Zaubers ist beendet",
         friendlyName = "zauber cooldown ende", 
         friendlyNameShort = "bereit",
      },
      ["ITEM_COOLDOWN_START"] = {
         tooltip = "Der Cooldown eines Gegenstands hat begonnen",
         friendlyName = "gegenstand cooldown start", 
         friendlyNameShort = "cooldown",
      },
      ["ITEM_COOLDOWN_END"] = {
         tooltip = "Der Cooldown eines Gegenstands ist beendet",
         friendlyName = "gegenstand cooldown ende", 
         friendlyNameShort = "bereit",
      },
      ["SWING_DAMAGE"] = {
         tooltip = "Ein Nahkampfangriff hat Schaden verursacht",
         friendlyName = "nahkampf schaden",
      },
      ["SWING_MISSED"] = {
         tooltip = "Ein Nahkampfangriff hat verfehlt",
         friendlyName = "nahkampf verfehlt",
      },
      ["SWING_EXTRA_ATTACKS"] = {
         tooltip = "Ein Nahkampfangriff hat einen Extrangriff gewährt",
         friendlyName = "nahkampf zusatz angriff",
      },
      ["SWING_ENERGIZE"] = {
         tooltip = "Ein Nahkampfangriff hat eine Ressource (Wut, Energie, Kombopunkt) gewährt",
         friendlyName = "nahkampf ressource",
      },
      ["RANGE_DAMAGE"] = {
         tooltip = "Ein Fernkampfangriff hat Schaden verursacht",
         friendlyName = "fernkampf schaden",
      },
      ["RANGE_MISSED"] = {
         tooltip = "Ein Fernkampfangriff hat verfehlt",
         friendlyName = "fernkampf verfehlt",
      },
      ["RANGE_EXTRA_ATTACKS"] = {
         tooltip = "Ein Fernkampfangriff hat einen Extraangriff ausgelöst",
         friendlyName = "fernkampf zusatz angriff",
      },
      --[[
      ["RANGE_ENERGIZE"] = {
         tooltip = "",
         friendlyName = "fernkampf ressource",
      },]]
      ["SPELL_DAMAGE"] = {
         tooltip = "Ein Zauber hat Schaden verursacht",
         friendlyName = "zauber schaden",
      },
      ["SPELL_MISSED"] = {
         tooltip = "Ein Zauber hat Schaden verfehlt",
         friendlyName = "zauber verfehlt",
      },
      ["SPELL_HEAL"] = {
         tooltip = "Ein Zauber hat Heilung verursacht",
         friendlyName = "zauber heilung",
      },
      ["SPELL_ENERGIZE"] = {
         tooltip = "Ein Zauber hat eine Ressource (Mana) gewährt",
         friendlyName = "zauber ressource",
      },
      ["SPELL_INTERRUPT"] = {
         tooltip = "Ein Zauber wurde unterbrochen",
         friendlyName = "zauber unterbrochen",
      },
      ["SPELL_EXTRA_ATTACKS"] = {
         tooltip = "Ein Zauber hat einen Extraangriff gewährt",
         friendlyName = "zauber zusatz angriff",
      },
      ["SPELL_CAST_FAILED"] = {
         tooltip = "Ein Zauber ist fehlgeschlagen",
         friendlyName = "zauber fehlgeschlagen",
      },
      ["SPELL_CREATE"] = {
         tooltip = "Etwas wurde durch einen Zauber hergestellt (z. B. Berufe-Skill)",
         friendlyName = "zauber erstellen", 
         friendlyNameShort = "erstellen",
      },
      ["SPELL_SUMMON"] = {
         tooltip = "Etwas wurde duch einen Zauber beschworen (z. B. Leerwandler beim Hexer",
         friendlyName = "zauber beschwören", 
         friendlyNameShort = "beschwören",
      },
      ["SPELL_RESURRECT"] = {
         tooltip = "Ein Zauber hat etwas wiederbelebt",
         friendlyName = "zauber wiederbeleben",  
         friendlyNameShort = "wiederbeleben",
      },
      ["UNIT_DIED"] = {
         tooltip = "Eine Einheit (Spieler, NPC, Mob etc.) ist gestorben",
         friendlyName = "einheit tot", 
         friendlyNameShort = "tot",
      },
      ["UNIT_DESTROYED"] = {
         tooltip = "Etwas wurde zerstört (z. B. ein Totem)",
         friendlyName = "einheit zerstört", 
         friendlyNameShort = "zerstört",
      },
      ["ITEM_USE"] = {
         tooltip = "Ein Gegenstand wurde verwendet",
         friendlyName = "gegenstand verwenden", 
         friendlyNameShort = "verwenden",
      },
   --spellId
      --build from skudb on PLAYER_ENTERING_WORLD
   --itemId
      --build from skudb on PLAYER_ENTERING_WORLD
      ["itemCount"] = {
         tooltip = "Die Anzahl der verbleibenden Gegenstände in deinen Taschen, vom Typ des Gegenstands, der das Ereignis ausgelöst hat",
         friendlyName = "gegenstand anzahl", 
         friendlyNameShort = "anzahl",
      },
}

SkuAuras.values = {
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.attributes = {
   action = {
      tooltip = "Du legst als nächstes die Aktion fest, die bei der Auslösung der Aura passieren soll",
      friendlyName = "aktion",
      evaluate = function()
      	dprint("SkuAuras.attributes.action.evaluate")
      end,
      values = {
         "notifyAudio",
         "notifyChat",
      },
   },
   destUnitId = {
      tooltip = "Die Ziel-Einheit, für die die Aura ausgelöst werden soll",
      friendlyName = "ziel",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("SkuAuras.attributes.destUnitId.evaluate", aEventData.destUnitId)
         if aEventData.destUnitId or aValue == "all" then
            local tEvaluation = false
            if aValue == "all" then
               return true
            elseif aValue == "party" then
               if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "player") == true then
                  tEvaluation = true
               end
               for x = 0, 4 do 
                  if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "party"..x) == true then
                     tEvaluation = true
                  end
               end
               for x = 1, MAX_RAID_MEMBERS do 
                  if SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, "raid"..x) == true then
                     tEvaluation = true
                  end
               end
            else
               tEvaluation = SkuAuras:ProcessEvaluate(aEventData.destUnitId, aOperator, aValue)
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
         "all",
      },
   },
   sourceUnitId = {
      tooltip = "Die Quell Einheit, für die die Aura ausgelöst werden soll",
      friendlyName = "Quelle",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("SkuAuras.attributes.sourceUnitId.evaluate", aEventData.sourceUnitId)
         if aEventData.sourceUnitId or aValue == "all" then
            local tEvaluation = false
            if aValue == "all" then
               return true
            elseif aValue == "party" then
               if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, "player") == true then
                  tEvaluation = true
               end
               for x = 0, 4 do 
                  if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, "party"..x) == true then
                     tEvaluation = true
                  end
               end
               for x = 1, MAX_RAID_MEMBERS do 
                  if SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, "raid"..x) == true then
                     tEvaluation = true
                  end
               end
            else
               tEvaluation = SkuAuras:ProcessEvaluate(aEventData.sourceUnitId, aOperator, aValue)
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
         "all",
      },
   },
   event = {
      tooltip = "Das Ereignis, das die Aura auslösen soll",
      friendlyName = "ereignis",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.event.evaluate")
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
      },
   },
   missType = {
      tooltip = "Der Typ des Verfehlen Ereignisses",
      friendlyName = "Verfehlen Typ",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.missType.evaluate")
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
      tooltip = "Dein Ressourcen Level in Prozent, das die Aura auslösen soll (deine Primärressource wie Mana, Energie, Wut etc.",
      friendlyName = "Eigene Ressource",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.unitPowerPlayer.evaluate")
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
         "30",
         "40",
         "50",
         "60",
         "70",
         "80",
         "90",
         "100",         
      },      
   },
   unitHealthPlayer = {
      tooltip = "Dein gesundheits Level in Prozent, das die Aura auslösen soll",
      friendlyName = "Eigene Gesundheit",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.unitHealthPlayer.evaluate")
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
         "30",
         "40",
         "50",
         "60",
         "70",
         "80",
         "90",
         "100",         
      },      
   },
   spellId = {
      tooltip = "Die Zauber-ID, die die Aura auslösen soll",
      friendlyName = "zauber nr",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.spellId.evaluate")
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
   spellName = {
      tooltip = "Der Zauber-name, der die Aura auslösen soll",
      friendlyName = "zauber name",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.spellName.evaluate")
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
      tooltip = "Die Liste der Buffs des Ziels",
      friendlyName = "Buff Liste Ziel",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.buffListTarget.evaluate")
         if aEventData.buffListTarget then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.buffListTarget, aOperator, aValue)
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
      tooltip = "Die Liste der Debuffs  des Ziels",
      friendlyName = "Debuff Liste Ziel",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("         SkuAuras.attributes.debuffListTarget.evaluate", aEventData.debuffListTarget)
         if aEventData.debuffListTarget then
            local tEvaluation = SkuAuras:ProcessEvaluate(aEventData.debuffListTarget, aOperator, aValue)
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
      tooltip = "Der Gegenstandsname, der die Aura auslösen soll",
      friendlyName = "gegenstand name",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemName.evaluate")
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
      tooltip = "Die Gegenstands-ID, die die Aura auslösen soll",
      friendlyName = "gegenstand nr",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemId.evaluate")
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
      tooltip = "Die verbleibende Menge eines Gegenstands in deinen Taschen, bei der die auslösen soll",
      friendlyName = "gegenstand anzahl",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.itemCount.evaluate")
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
         "30",
         "40",
         "50",
         "60",
         "70",
         "80",
         "90",
         "100",
      },      
   },   
   auraType = {
      tooltip = "Der Aura-Typ (Buff oder Debuff), der die Aura auslösen soll",
      friendlyName = "buff/debuff",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.auraType.evaluate")
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
      tooltip = "Die Anzahl der Stacks einer Aura (Buff oder Debuff), bei der die Aura auslösen soll",
      friendlyName = "aura stacks",
      evaluate = function(self, aEventData, aOperator, aValue)
      	dprint("           SkuAuras.attributes.auraAmount.evaluate")
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
      },      
   },
   class = {
      tooltip = "Der Klasse, die die Aura auslösen soll",
      friendlyName = "klasse",
      evaluate = function()
      	dprint("SkuAuras.attributes.class.evaluate")













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

SkuAuras.Operators = {
   ["then"] = {
      tooltip = "",
      friendlyName = "dann",
      func = function(a) 
      	dprint("action", a)
         return
      end,
   },
   ["is"] = {
      tooltip = "Gewähltes Attribut entspricht dem gewählten Wert",
      friendlyName = "gleich",
      func = function(aValueA, aValueB) 
      	--dprint("                           SkuAuras.Operators is", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end

         if RemoveTags(aValueA) == RemoveTags(aValueB) then 
            return true 
         end
         return false
      end,
   },
   ["isNot"] = {
      tooltip = "Gewähltes Attribut entspricht nicht dem gewählten Wert",
      friendlyName = "ungleich",
      func = function(aValueA, aValueB) 
      	dprint("SkuAuras.Operators isNot", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end
         if RemoveTags(aValueA) ~= RemoveTags(aValueB) then 
            return true 
         end
         return false
      end,
   },
   ["contains"] = {
      tooltip = "Gewähltes Attribut enthält den gewählten Wert",
      friendlyName = "enthält",
      func = function(aValueA, aValueB) 
      	--dprint("                           SkuAuras.Operators contains", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then 
            for tName, _ in pairs(aValueA) do
               local tResult = RemoveTags(tName) == RemoveTags(aValueB)
               if tResult == true then
                  return true
               end
            end
         else
            if RemoveTags(aValueA) == RemoveTags(aValueB) then 
               return true 
            end
         end
         return false
      end,
   },   
   ["containsNot"] = {
      tooltip = "Gewähltes Attribut enthält nicht den gewählten Wert",
      friendlyName = "enthält nicht",
      func = function(aValueA, aValueB) 
      	dprint("                           SkuAuras.Operators containsNot", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then 
            for tName, _ in pairs(aValueA) do
               dprint("tName", tName)
               local tResult = RemoveTags(tName) == RemoveTags(aValueB)
               if tResult == true then
                  return false
               end
            end
         else
            if RemoveTags(aValueA) == RemoveTags(aValueB) then 
               return true 
            end
         end
         return true
      end,
   },   
   ["bigger"] = {
      tooltip = "Gewähltes Attribut ist größer als der gewählte Wert",
      friendlyName = "größer",
      func = function(aValueA, aValueB) 
      	dprint("SkuAuras.Operators >", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end
         if tonumber(RemoveTags(aValueA)) > tonumber(RemoveTags(aValueB)) then 
            return true 
         end
         return false
      end,
   },
   ["smaller"] = {
      tooltip = "Gewähltes Attribut ist kleiner als der gewählte Wert",
      friendlyName = "kleiner",
      func = function(aValueA, aValueB) 
      	dprint("-----------------------------------------SkuAuras.Operators <", aValueA, aValueB)
         if not aValueA or not aValueB then return false end
         if type(aValueA) == "table" then return false end
         if tonumber(RemoveTags(aValueA)) < tonumber(RemoveTags(aValueB)) then 
            return true 
         end
         return false
      end,
   },
}

------------------------------------------------------------------------------------------------------------------
SkuAuras.Types = {
   ["if"] = {
      tooltip = "Wenn die Bedingungen dieser Aura zutreffen",
      friendlyName = "Wenn",
      attributes = {
         "action",
         "destUnitId",
         "sourceUnitId",
         "event",
         "unitPowerPlayer",
         "unitHealthPlayer",
         "spellId",
         "spellName",
         "buffListTarget",
         "debuffListTarget",
         "itemName",
         "itemId",
         "itemCount",
         "auraType",
         "auraAmount",
         "missType",
         --"class",
      },
   },
   ["ifNot"] = {
      tooltip = "Wenn die Bedingungen dieser Aura nicht zutreffen",
      friendlyName = "Wenn nicht",
      attributes = {
         "action",
         "destUnitId",
         "sourceUnitId",
         "event",
         "unitPowerPlayer",
         "unitHealthPlayer",
         "spellId",
         "spellName",
         "buffListTarget",
         "debuffListTarget",
         "itemName",
         "itemId",
         "itemCount",
         "auraType",
         "auraAmount",
         "missType",
         --"class",
      },
   },
}
--[[
------------------------------------------------------------------------------------------------------------------
SkuAuras.Types = {
   aura = {
      tooltip = "Ein Ereignis im Zusammenhang mit einem Buff oder Debuff löst die Aura aus",
      friendlyName = "Aura",
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
      tooltip = "Ein Ereignis im Zusammenhang mit einem Zauber löst die Aura aus",
      friendlyName = "Zauber",
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
      tooltip = "Ein Ereignis im Zusammenhang mit einem Gegenstand löst die Aura aus",
      friendlyName = "gegenstand",
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
      tooltip = "Ein Ereignis im Zusammenhang mit einer Einheit (Spieler, NPC, Mob) löst die Aura aus",
      friendlyName = "Einheit",
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
---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "Tutorial"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
SkuCore.tutorial = {}
SkuCore.tutorial.currentStep = 0
SkuCore.tutorial.data = {
   [1] = {
      completed = false,
      stepDescription = {
         [1] = "Willkommen zum Tutorial. Du lernst jetzt das Wichtigste zum Spielen von W o W und zum Addon.",
         [2] = "Du stehst im Startgebiet der Menschen, dem Nordhaintal. 20 Meter vor dir steht der erste Questgeber. Sein Name lautet Stellvertreter Willem.",
         [3] = "Du gehst nun zu diesem Questgeber, und nimmst von ihm deine erste Quest an.",
         [4] = "Freundlich gesinnte NPCs nimmst du mit der Tastenkombination STRG SHIFT TABULATOR ins Ziel.",
         [5] = "Mit jedem Druck auf STRG SHIFT TABULATOR wechselst du zum nächsten freundlichen NPC in deinem direkten Sichtfeld.",
         [6] = "Drücke jetzt so lange STRG SHIFT TABULATOR, bis du Stellvertreter Willem im Ziel hast.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            local name, realm = UnitName("target")
            if name == "Stellvertreter Willem" then
               return true
            end
         end,
      },
   },
   [2] = {
      completed = false,
      stepDescription = {
         [1] = "Sehr gut. Nun musst du zu Stellvertreter Willem laufen.",
         [2] = "Drücke die Taste, G, um  automatisch zu deinem aktuellen Ziel zu laufen, und mit diesem zu interagieren.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if _G["QuestFrameDetailPanel"]:IsShown() == true then
               return true
            end
         end,
      },
   },   
   [3] = {
      completed = false,
      stepDescription = {
         [1] = "perfekt! wenn du mit einem questgeber wie stellvertreter willem interagierst, öffnet sich das audiomenü mit den bei diesem questgeber verfügbaren quests.",
         [2] = "In diesem Audiomenü befindest du dich jetzt. Solange du im Audiomenü bist, bewegst du dich mit den Tasten im Audiomenü, statt in der Spielwelt.",
         [3] = "Jetzt bist du im Untermenü Quest, denn Stellvertreter Willem hat eine Quest für dich, die wir jetzt annehmen wollen.",
         [4] = "Mit PFEIL RECHTS gelangst du in die weiteren Untermenüs des Quest Menüs. Drücke jetzt PFEIL RECHTS.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Schließen" then
                  return true
               end
            end
         end,
      },
   },
   [4] = {
      completed = false,
      stepDescription = {
         [1] = "Das hier ist das Untermenü von Quests. Es enthält zwei Elemente namens Schließen und Details.",
         [2] = "Mit dem ersten Element, Schließen, würdest du das Menü schließen. Das wollen wir nicht.",
         [3] = "Drücke Pfeil RUNTER, um zum zweiten Menüelement, Details, zu wechseln.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Details" then
                  return true
               end
            end
         end,
      },
   },   
   [5] = {
      completed = false,
      stepDescription = {
         [1] = "Auch Details hat wieder ein Untermenü. Drücke wieder PFEIL RECHTS, um in das Untermenü von Details zu wechseln.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Ablehnen" then
                  return true
               end
            end
         end,
      },
   },   
   [6] = {
      completed = false,
      stepDescription = {
         [1] = "In diesem Untermenü findest du Optionen, um die Quest abzulehnen, anzunehmen und zu lesen. Wir wollen zuerst die Questbeschreibung lesen.",
         [2] = "Geh mit PFEIL RUNTER zum Titel der Quest. Er lautet, Die Bedrohung von innen.",
         [3] = "Geh dann mit PFEIL RECHTS in das Untermenü der Quest.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Text: Die Bedrohung von innen" then
                  return true
               end
            end
         end,
      },
   },   
   [7] = {
      completed = false,
      stepDescription = {
         [1] = "Im Untermenü der Quest findest du Text für die Questbeschreibung, die Belohnungen und die Ziele.",
         [2] = "Der erste Menüpunkt, Text, doppelpunkt, Die Bedrohung von innen, ist der Questtitel.",
         [3] = "Geh mit PFEIL RUNTER zum nächsten Menüpunkt, der Questbeschreibung.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Text: Ich hoffe, Ihr habt Euren Gürtel festgezurrt, ..." then
                  return true
               end
            end
         end,
      },
   },   
   [8] = {
      completed = false,
      stepDescription = {
         [1] = "Die Questbeschreibung ist ein Text, der zu lang ist, um ihn im Audiomenü komplett vorzulesen. Daher endet dieser Menüpunkt auf Punkt Punkt Punkt.",
         [2] = "Immer, wenn ein Text-Menüpunkt auf, Punkt Punkt Punkt endet, enthält er noch weiteren Text.",
         [3] = "Den vollständigen Text, den sogenannten Tooltipp, kannst du dir bei jedem Menüelement mit der Tastenkombination SHIFT LINKS PFEIL HOCH anzeigen lassen.",
         [4] = "Solange du dabei die linke SHIFT-Taste festhälst, bleibt die vollständige Anzeige offen. Wenn du SHIFT loslässt, landest du wieder in der Menünavigation.",
         [5] = "Drücke SHIFT LINKS PFEIL HOCH und halte SHIFT LINKS so lange gedrückt, bis dir der gesamte Questtext vorgelesen wurde. Lass erst dann SHIFT los",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "abtei" then
                  return true
               end
            end
         end,
         [2] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "hinter" then
                  return true
               end
            end
         end,
         [3] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "mir" then
                  return true
               end
            end
         end,
         [4] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "punkt" then
                  return true
               end
            end
         end,         
         [5] = function()
            if IsShiftKeyDown() == false and SkuTTSMainFrame:IsShown() == false then
               return true
            end
         end,
      },
   },   
   [9] = {
      completed = false,
      stepDescription = {
         [1] = "Prima. Geht jetzt mit PFEIL RUNTER die weiteren Menüelemente bis nach unten durch, und sieh dir an, was das Questziel ist.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Text: Sprecht mit Marschall McBride." then
                  return true
               end
            end
         end,
      },
   },   
   [10] = {
      completed = false,
      stepDescription = {
         [1] = "Nun kennen wir die Questbeschreibung und das Ziel. Jetzt wollen wir die Quest annehmen.",
         [2] = "Geht mit PFEIL LINKS eine Menüebene zurück, zum Questtitel.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Die Bedrohung von innen" then
                  return true
               end
            end
         end,
      },
   },   
   [11] = {
      completed = false,
      stepDescription = {
         [1] = "In dieser Menüebene findest du einen Menüpunkt weiter oben die Annehmen-Option.",
         [2] = "Drücke ein mal PFEIL HOCH, um zu, Annehmen, zu gelangen.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Annehmen" then
                  return true
               end
            end
         end,
      },
   },   
   [12] = {
      completed = false,
      stepDescription = {
         [1] = "Vor dem Menüpunkt, Annehmen steht nicht, Text doppeltpunkt. Das bedeutet, es gibt ein Untermenü.",
         [2] = "Drücke PFEIL RECHTS, um in das Untermenü zu gelangen.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Linksklick" then
                  return true
               end
            end
         end,
      },
   },   
   [13] = {
      completed = false,
      stepDescription = {
         [1] = "Nun kannst du einen Linksklick oder Rechtsklick auf, Annehmen durchführen.",
         [2] = "Ein Linksklick bedeutet in W o W normalerweise, das du etwas auswählst. Ein Rechtsklick ist meistens, etwas benutzen.",
         [3] = "Wir wollen die Annehmen-Option auswählen. Geh dazu auf Linksklick, und drücke die EINGABE-Taste, um den Menüpunkt auszuwählen.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            local numEntries, numQuests = GetNumQuestLogEntries()
            if numQuests then
               if numQuests > 0 then
                  return true
               end
            end
         end,
      },
   },   
   [14] = {
      completed = false,
      stepDescription = {
         [1] = "Glückwunsch. Du hast deine erste Quest angenommen. Das Audiomenü hat sich automatisch geschlossen. Du interagierst nun wieder mit der Spielwelt.",
         [2] = "Du kannst dir deine angenommenen Quests und ihren Status jederzeit ansehen.",
         [2] = "Das geschieht über dein Questbuch. Das Questbuch öffnest du mit der Taste L.. Öffne jetzt dein Questbuch.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if _G["QuestLogFrame"]:IsShown() == true then
               return true
            end
         end,
      },
   },   
   [15] = {
      completed = false,
      stepDescription = {
         [1] = "Wie immer, wenn sich Fenster im Spiel öffnen, oder du es mit Textinhalten zu tun bekommst, öffnet sich das Audiomenü.",
         [2] = "Diesmal jedoch direkt im Untermenü, Aktuelle Quests.. Dort siehst du deine Quests. Geh nach rechts ins Untermenü.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Alle" then
                  return true
               end
            end
         end,
      },
   },   
   [16] = {
      completed = false,
      stepDescription = {
         [1] = "Du kannst dir alle aktuellen Quests anzeigen lassen, oder, indem du weiter runter gehst, Quests für einzelne Zonen des Spiels.",
         [2] = "Geh nach unten zu, Nordhaintal, und dann nach rechts, um alle Quests im Nordhaintal zu sehen.",
         [3] = "Der Titel deiner ersten und einzigen Quest lautet, Die Bedrohung von innen.",
         [4] = "Auch hier kannst du dir wieder mit SHIFT PFEIL HOCH einen Tooltipp mit allen Informationen zur Quest anzeigen lassen.",
         [5] = "Drücke SHIFT PFEIL HOCH, um den Tooltipp zur Quest zu öffnen. Lass SHIFT jedoch nicht los, um den Tooltipp geöffnet zu halten.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "innen" then
                  return true
               end
            end
         end,
      },
   },   
   [17] = {
      completed = false,
      stepDescription = {
         [1] = "Dieser Tooltipp ist umfangreicher. Er hat viele Zeilen. Die erste Zeile wird dir automatisch vorgelesen.",
         [2] = "Zur zweiten Zeile kommst du bei weiterhin gedrückter SHIFT-Taste mit PFEIL NACH unten.",
         [3] = "Geh mit SHIFT PFEIL RUNTER die Zeilen des Tooltipps durch, bist du bei den Zielen bist. Halte dann weiterhin SHIFT gedrückt, um den Tooltipp offen zu halten.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "ziele" then
                  return true
               end
            end
         end,
      },
   },   
   [18] = {
      completed = false,
      stepDescription = {
         [1] = "Die Tooltipp-Inhalte sind in logische Abschnitte gegliedert. Hier sind zum Beispiel, Level, Fortschritt, Ziele, und, Questtext jeweils ein Abschnitt.",
         [2] = "Statt mit PFEIL HOCH/RUNTER immer nur eine Zeile runter oder hoch zu gehen, kannst du mit STRG SHIFT PFEIL HOCH/RUNTER, auch Abschnittsweise weitergehen.",
         [3] = "Geh mit STRG SHIFT PFEIL HOCH zum ersten Abschnitt, dem Questtitel, und lass dann SHIFT los, um das Tooltipp zu schließen und wieder ins Menü zu gelangen.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "level" then
                  return true
               end
            end
         end,
         [2] = function()
            if IsShiftKeyDown() == true and SkuTTSMainFrame:IsShown() == true then
               local tLastString = SkuOptions.Voice:GetLastPlayedString()
               if tLastString == "bedrohung" then
                  return true
               end
            end
         end,
         [3] = function()
            if IsShiftKeyDown() == false and SkuTTSMainFrame:IsShown() == false then
               return true
            end
         end,
      },
   },   
   [19] = {
      completed = false,
      stepDescription = {
         [1] = "In deinem Questbuch kannst du dir zu jeder Quest anzeigen lassen, wo du sie angenommen hast, wo die Ziele der Quest sind, und wo du sie abgeben musst.",
         [2] = "Gehe nach rechts in das Untermenü. Geh dann runter zum Menüpunkt namens Abgabe. Geh dann erneut nach rechts.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if SkuOptions.currentMenuPosition.name == "Marschall McBride;Questgeber" then
                  return true
               end
            end
         end,
      },
   },   
   [20] = {
      completed = false,
      stepDescription = {
         [1] = "Du sollst die Quest bei, Marshall Mcbride abgeben.",
         [2] = "Zu Marshall Mcbride kannst du dich über eine Route führen lassen. Geh dazu wieder ein Untermenü weiter nach rechts, und dann im Untermenü, Route, erneut nach rechts.",
         [3] = "Von deinem aktuellen Standpunkt aus verfügbare Routen kannst du nach der Entfernung oder nach dem Namen des Ziels sortiert anzeigen lassen. Wir interessieren uns jetzt für die Sortierung nach Entfernung. Geh also erneut nach rechts.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.currentMenuPosition then
               if string.find(SkuOptions.currentMenuPosition.name, "Meter#Marschall McBride;Questgeber;Wald von Elwynn;1;48.92;41.61") then
                  return true
               end
            end
         end,
      },
   },   
   [21] = {
      completed = false,
      stepDescription = {
         [1] = "In diesem Untermenü findest du alle Routen zum Questziel, Marshall Mcbride, inklusive einer Entferungsangabe.",
         [2] = "Wir nehmen gleich die erste Route. Geh auf die erste Route, und drück, EINGABE, um die Route auszuwählen.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp == 1 then
               return true
            end
         end,
      },
   },   
   [22] = {
      completed = false,
      stepDescription = {
         [1] = "Sehr gut. Du hast nun die Navigation über eine Route zu einem Zielpunkt gestartet. Das Audiomenü schließt sich automatisch.",
         [2] = "Du hörst ein 3D Audiobeacon, das sich wie ein Herzschlag anhört. Dieses Beacon befindet sich in der Spielwelt an der Position deines Ziels (Marshall Mcbride).",
         [3] = "Das Beacon ist dreidimensional zu hören. Dreh dich ein paar mal komplett im Kreis. Achte darauf, wie sich die Richtung, aus der das Beacon zu hören ist, verändert.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            local x, y = UnitPosition("player")
            local tDirection = SkuNav:GetDirectionTo(x, y, 30000, y)
            tDirection = 12 - tDirection if tDirection == 0 then tDirection = 12 end
            tSkuTutorialGlobalTmpVar1 = tSkuTutorialGlobalTmpVar1 or tDirection
            tSkuTutorialGlobalTmpVar2 = tSkuTutorialGlobalTmpVar2 or 0
            if tSkuTutorialGlobalTmpVar1 ~= tDirection then
               tSkuTutorialGlobalTmpVar2 = tSkuTutorialGlobalTmpVar2 + 1
            end

            if tSkuTutorialGlobalTmpVar2 > 600 then
               tSkuTutorialGlobalTmpVar1 = nil
               tSkuTutorialGlobalTmpVar2 = nil
               return true
            end

         end,
      },
   },   
   [23] = {
      completed = false,
      stepDescription = {
         [1] = "Hörst du, wie sich die Richtung verändert? So kannst du feststellen in welche Richtung du laufen musst, um das Beacon bzw. dein Ziel zu erreichen.",
         [2] = "Vielleicht hast du beim Drehen ein Klick- bzw. Klack-Geräusch gehört. Außerdem hast du vermutlich bemerkt, dass die Frequenz des Beacons schneller wurde.",
         [3] = "Wenn du dich in die Richtung des Beacons drehst, wird es schneller. Wenn du plusminus 5 Grad in die Richtung des Beacons blickst, hörst du ein Klick Geräusch. Wenn du den plusminus 5 Grad Bereich verlässt, hörst du das Klack.",
         [4] = "Zusätzlich kannst du mit der Taste, ALTGR, jederzeit deine aktuelle Entferung zum Beacon, sowie die Richtung abfragen. Drücke jetzt ALTGR.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if tSkuTutorialGlobalTmpVar1 then
               tSkuTutorialGlobalTmpVar1 = nil
               return true
            end
         end,
      },
   },   
   [24] = {
      completed = false,
      stepDescription = {
         [1] = "Die Richtung wird als Uhrzeit angegeben. 12 Uhr bedeutet, das Beacon ist genau vor dir. 9 Uhr bedeutet, es ist links von dir. 6 Uhr ist hinter dir. Und so weiter.",
         [2] = "Dreh dich jetzt anhand des Beacon-Sounds, der Klick-Klack-Markierungen und der Richtungsangaben von ALTGR, zum Beacon und laufe zum Beacon.",
      
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.db.profile["SkuNav"].metapathFollowingCurrentWp == 2 then
               return true
            end
         end,
      },
   },   
   [25] = {
      completed = false,
      stepDescription = {
         [1] = "Super! Du hast den ersten Wegpunkt deiner Route zu Marshall Mcbride erreicht. Die Routennavigation zeigt das mit einem ,Ding-Sound, an..",
         [2] = "Sie schaltet automatisch zum nächsten Wegpunkt auf der Route, und sagt dir, wie viele Wegpunkte bis zum Ziel du noch zurücklegen musst.",
         [3] = "Laufe jetzt so lange immer zum nächsten Wegpunkt, bis du dein Ziel, Marshall Mcbride, erreicht hast.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if SkuOptions.db.profile["SkuNav"].metapathFollowing ~= true then
               return true
            end
         end,
      },
   },   
   [26] = {
      completed = false,
      stepDescription = {
         [1] = "Perfekt. Du bist bei Marshall Mcbride, dem Questziel, in der Abtei angekommen.",
         [2] = "Nun musst du ihn ins Ziel nehmen, um mit ihm zu interagieren.",
         [3] = "Drücke erneut STRG SHIFT TABULATOR für die freundlichen Ziele, bis du Marshall Mcbride im Ziel hast.",
         [4] = "Drücke dann die Taste G, um mit ihm zu interagieren.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            if _G["GossipFrame"]:IsShown() == true then
               return true
            end
         end,
      },
   },   
   [26] = {
      completed = false,
      stepDescription = {
         [1] = "Glückwunsch! Das war der letzte Schritt im Tutorial. Ab hier musst du dich alleine durchschlagen. Viel Erfolg.",
      },
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()
            return true
         end,
      },
   },   


}

--[[
["QuestLogFrame"] = "QuestLogFrameCloseButton",
["GameMenuFrame"] = "GameMenuButtonContinue",
["CharacterFrame"] = "CharacterFrameCloseButton",
["PlayerTalentFrame"] = "PlayerTalentFrameCloseButton",
["MerchantFrame"] = "MerchantFrameCloseButton",
["GossipFrame"] = "GossipFrameCloseButton",
["ClassTrainerFrame"] = "ClassTrainerFrameCloseButton",
StaticPopup1
["QuestFrame"] = "QuestFrameCloseButton",
["TaxiFrame"] = "TaxiCloseButton",
["SkillFrame"] = "CharacterFrameCloseButton",
["HonorFrame"] = "CharacterFrameCloseButton",
["DropDownList1"] = "DropDownList1",
["InspectFrame"] = "InspectFrameCloseButton",
	"QuestFrame",--o
	"TaxiFrame",--o
	"GossipFrame",--o
	"MerchantFrame",--o
	"StaticPopup1",
	"StaticPopup2",
	"StaticPopup3",
	"PetStableFrame",
	"ContainerFrame1",
	"ContainerFrame2",
	"ContainerFrame3",
	"ContainerFrame4",
	"ContainerFrame5",
	"ContainerFrame6",
	"DropDownList1",
	"TalentFrame",
	--"AuctionFrame",
	"ClassTrainerFrame",
	"CharacterFrame",
	"ReputationFrame",
	"SkillFrame",
	"HonorFrame",
	"PlayerTalentFrame",
	"InspectFrame",
	"BagnonInventoryFrame1",
	"BagnonBankFrame1",
	"GuildBankFrame",
	"BankFrame",
	"CraftFrame",
	--"GroupLootContainer",
	"TradeFrame",
	"TradeSkillFrame",
	--"DropDownList2",
	--"FriendsFrame",
	--"GameMenuFrame",
	--"SpellBookFrame",
	--"MultiBarLeft",
	--"MultiBarRight",
	--"MultiBarBottomLeft",
	--"MultiBarBottomRight",
	"BagnonGuildFrame1",
	--"MainMenuBar",
   	["BagnonInventoryFrame1"] = "BagnonInventoryFrame1",
	["BagnonBankFrame1"] = "BagnonBankFrame1",
	["ContainerFrame1"] = "ContainerFrame1",
	["ContainerFrame2"] = "ContainerFrame2",
	["ContainerFrame3"] = "ContainerFrame3",
	["ContainerFrame4"] = "ContainerFrame4",
	["ContainerFrame5"] = "ContainerFrame5",

}
local friendlyFrameNamesParts = {
	["FrameGreetingPanel"] = L["Panel"],
	["GreetingScrollFrame"] = L["Sub panel"],
	["DetailPanel"] = L["Details"] ,
	["DetailScrollFrame"] = L["Details panel"],
	["ScrollFrame"] = L["Sub panel"],
	["RewardsFrame"] = L["Rewards"],
	["MoneyFrame"] = L["Money"],
	["PaperDollFrame"] = L["Equiment"] ,
	["CharacterAttributesFrame"] = L["Attributes"],
	["CharacterResistanceFrame"] = L["Resistance"],
	["PaperDollItemsFrame"] = L["Items"],
	["ProgressPanel"] = L["Progress"],




   [9] = {
      completed = false,
      stepDescription = {
         [1] = "Prima. Geht jetzt mit PFEIL RUNTER ein Menüelement nach unten, zu Belohnungen.",
      }
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()

         end,
      },
   },   
   [10] = {
      completed = false,
      stepDescription = {
         [1] = "Wie du hörst, steht vor diesem Menüpunkt nicht, Text doppelpunkt.",
         [2] = "Das bedeutet, das ist nicht nur ein Text, den du lesen kannst, sondern es handelt sich um eine Option, die du auswählen kannst, oder um ein Untermenü.",
         [3] = "Das ist im gesamten Audiomenü so. Steht, Text doppelpunkt, vor einem Menüelement, kannst du etwas lesen. Steht nichts davor, kannst du die Option auswählen oder mit PFEIL RECHTS in ein Untermenü wechseln.",
         [4] = "Das Menüelement, Belohnungen hat ein Untermenü. Geh mit PFEIL RECHTS in das Untermenü.",
      }
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()

         end,
      },
   },   
   [11] = {
      completed = false,
      stepDescription = {
         [1] = "Geh mit PFEIL RUNTER durch die Menüelement, bis zum letzten Element, und sieh dir dabei an, welche Belohnungen du bekommst.",
      }
      currentSuccessCondition = 1,
      successConditions = {
         [1] = function()

         end,
      },
   },      
]]
---------------------------------------------------------------------------------------------------------------------------------------
local tCurrentlyPlaying = {}
function SkuCore:TutorialPlayNextStepInstructions()
   local tCurrentStepNumber = SkuCore.tutorial.currentStep
   for i, v in pairs(tCurrentlyPlaying) do
      StopSound(v, 0)
   end

   tCurrentlyPlaying = {}
   for x = 1, #SkuCore.tutorial.data[tCurrentStepNumber].stepDescription do
      local file = ""
      local willPlay, soundHandle = PlaySoundFile("Interface\\AddOns\\Sku\\assets\\audio\\"..file)
      if willPlay then
         tCurrentlyPlaying[#tCurrentlyPlaying + 1] = soundHandle
      end
   end

end

---------------------------------------------------------------------------------------------------------------------------------------
local f = _G["SkuCoreTutorialControl"] or CreateFrame("Frame", "SkuCoreTutorialControl", UIParent)
local ttime = 0
f:SetScript("OnUpdate", function(self, time)
   ttime = ttime + time
   if ttime < 0.0 then return end

   local tCurrentStepNumber = SkuCore.tutorial.currentStep

   if tCurrentStepNumber == 0 then 
      return
   end

   if tCurrentStepNumber > #SkuCore.tutorial.data then
      return
   end
   
   local tCurrentSCondNumber = SkuCore.tutorial.data[tCurrentStepNumber].currentSuccessCondition
   
   if SkuCore.tutorial.data[tCurrentStepNumber].successConditions[tCurrentSCondNumber]() == true then
      dprint("step", tCurrentStepNumber, "success condition", tCurrentSCondNumber, "completed")
      SkuCore.tutorial.data[tCurrentStepNumber].currentSuccessCondition = SkuCore.tutorial.data[tCurrentStepNumber].currentSuccessCondition + 1
      if SkuCore.tutorial.data[tCurrentStepNumber].currentSuccessCondition >= #SkuCore.tutorial.data[tCurrentStepNumber].successConditions then
         dprint("step", tCurrentStepNumber, "completed")
         SkuCore.tutorial.data[tCurrentStepNumber].currentSuccessCondition = 1
         SkuCore.tutorial.currentStep = SkuCore.tutorial.currentStep + 1
         --SkuCore:TutorialPlayNextStepInstructions()
         for x = 1, #SkuCore.tutorial.data[SkuCore.tutorial.currentStep].stepDescription do
            dprint(string.lower(SkuCore.tutorial.data[SkuCore.tutorial.currentStep].stepDescription[x]))
            SkuOptions.Voice:OutputString(string.lower(SkuCore.tutorial.data[SkuCore.tutorial.currentStep].stepDescription[x]), false, true, 0.3, true)
         end
      end
   end


end)

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TutorialOnInitialize()
   --SkuCore:TutorialPlayNextStepInstructions()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:TutorialStart()
   SkuCore.tutorial.currentStep = 1
   for x = 1, #SkuCore.tutorial.data[1].stepDescription do
      dprint(string.lower(SkuCore.tutorial.data[1].stepDescription[x]))
      SkuOptions.Voice:OutputString(string.lower(SkuCore.tutorial.data[1].stepDescription[x]), false, true, 0.3, true)
   end
end


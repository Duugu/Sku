local L = Sku.L

SkuDB.Tutorials = {
   ["prefix"] = "Sku",
   ["enUS"] = {
      ["Warrior Human 1"] = {
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 1,
         },
         ["playFtuIntro"] = true,         
         ["steps"] = {
            {
               ["playFtuIntro"] = "",
               ["title"] = "Let's start",
               ["beginText"] = "Welcome to Azeroth %name%. You must want to grow big and strong. If you excel in battle, you will soon explore the world and enjoy incredible adventures. To get more experience you should complete tasks. This will reward you with better equipment.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [1]
            {
               ["title"] = "Target deputy",
               ["beginText"] = "Directly in front of you is an NPC who gives a task to you. Tasks are also called quests. You need to target this NPC. You can target friendly NPCs in your field of view by pressing a shortcut key. Hold down the (control) key and the (shift) key and then press the (tab) key once.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Deputy",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [2]
            {
               ["title"] = "Interact with target",
               ["beginText"] = "To talk to this NPC and to find out what task he has, you need to move to him and interact with him. To do this, press the G key. So now press G once.",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [3]
            {
               ["title"] = "Window open",
               ["beginText"] = "A window has opened. You might have heard a (clack) sound and the NPC has also been talking to you. You are now in on the first entry of the window. You always get to the contents of a window by going to the right. Press the right arrow.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "details",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [4]
            {
               ["title"] = "Navigate in the window",
               ["beginText"] = "You have now moved from the previous menu item (Quests) to the right. You now heared the voice saying (Details) (Plus). This means you are on the (Details) menu item. The (Plus) indicates that you can move one menu level deepe by pressing the (right Arrow) key. Press (right arrow).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "A Threat Within",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [5]
            {
               ["title"] = "Read quest text",
               ["beginText"] = "This is your first quest. You can read the content step by step using the arrow down key. Find the (Accept) button.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Accept",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [6]
            {
               ["title"] = "Accept quest with accept button",
               ["beginText"] = "Correct. This is the button. The plus at the end of the output indicates that there is a submenu. Get into the submenu using the (arrow right) key.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [7]
            {
               ["title"] = "click submenu",
               ["beginText"] = "This is the menu for the button. You will have to use buttons a lot. To use the button select (left click) by pressing the (enter) key. (Left click) is at the top and you already have it selected. So just press the (enter) key. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 58,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [8]					
         },
      },
   },
   ["deDE"] = {
      ["Krieger mensch 1"] = {
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 1,
         },
         ["playFtuIntro"] = true,         
         ["steps"] = {
            {
               ["playFtuIntro"] = "",
               ["title"] = "Fangen wir an",
               ["beginText"] = "Willkommen in Azeroth %name% . Du möchtest sicher groß und stark werden. Wenn du dich im Kampf beweist, dann wirst du bald in die Welt hinausgehen können und unglaubliche Abenteuer erleben. Um Erfahrung zu erhalten und größer zu werden, solltest du Aufgaben erledigen. Oft bekommst du dafür dann auch bessere Ausrüstung zur Belohnung.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [1]
            {
               ["title"] = "Stellvertreter ins Ziel nehmen",
               ["endText"] = "Gut gemacht. Du hast ihn im Ziel",
               ["beginText"] = "Direkt vor dir steht ein NPC mit der ersten Aufgabe für dich. Aufgaben nennt man auch Quests. Du musst diesen NPC ins Ziel nehmen. Mit einer Tastenkombination nimmst du freundliche NPCs in deinem Sichtfeld ins Ziel. Halte die (Steuerungstaste) und die (Umschalttaste) gedrückt und drücke dann einmal auf die (Tabulatortaste).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Stellvertreter",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [2]
            {
               ["title"] = "Mit Ziel interagieren",
               ["endText"] = "",
               ["beginText"] = "Um mit diesem NPC zu sprechen und um herauszufinden, welche Aufgabe er für dich hat, musst du zu ihm laufen und mit ihm interagieren. Das machst du mit der Taste G.   Drücke nun also einmal G",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [3]
            {
               ["title"] = "Öffnungsfeld",
               ["beginText"] = "Es hat sich ein Fenster geöffnet. du konntest möglicherweise ein (klack) Geräusch hören und der NPC hat auch mit dir gesprochen. Du stehst nun auf dem ersten Feld vor dem Fenster. Den Inhalt eines Fensters erreichst du immer, indem du nach rechts gehst. Drücke Pfeil rechts",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "details",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [4]
            {
               ["title"] = "Im Fenster navigieren",
               ["endText"] = "Du stehst nun ganz oben auf der Überschrift. Mit Pfeil hoch und runter kannst du in diesem Fenster lesen.",
               ["beginText"] = "Du bist nun vom Menüpunkt (Quests) nach rechts gegangen. Jetzt sagte die Stimme (Details) (Plus). Das bedeutet, du stehst auf dem menüpunkt (Details). Das (Plus) verrät dir, dass du mit Pfeil rechts in das Menü hineingehen kannst. Drücke (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Bedrohung von innen",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [5]
            {
               ["title"] = "Questtext lesen",
               ["beginText"] = "Dies ist deine erste aufgabe. Du kannst mit Pfeil nach unten den Inhalt Stück für Stück lesen. Suche nach der Schaltfläche (Annehmen).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Annehmen",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [6]
            {
               ["title"] = "Quest annehmen mit annehmen Schaltfläche",
               ["endText"] = "Nun hast du die Quest angenommen. Das Fenster hat sich automatisch geschlossen.",
               ["beginText"] = "Richtig. Dies ist die Schaltfläche. Das Plus am Ende vom Text sagt dir, dass ein untermenü vorhanden ist. Öffne das Untermenü mit (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [7]
            {
               ["title"] = "untermenü klicken",
               ["beginText"] = "Das ist das menü für die Schaltfläche. Du wirst sehr häufig Schaltflächen bestätigen müssen. Wähle zum bestätigen in diesem Untermenü bitte (Linksklick) mit der Taste (enter) aus. (Linksklick) ist ganz oben und du stehst schon darauf. Also drücke einfach nur (Enter). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 58,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [8]
            {
               ["title"] = "Questbuch öffnen",
               ["endText"] = "Du hast mit L dein Questbuch geöffnet.",
               ["beginText"] = "Deine Quests werden in deinem Questbuch gesammelt. Öffne es mit der Taste L.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [9]
            {
               ["title"] = "zur gebietsübersicht",
               ["endText"] = "Diese Ebene funktioniert wie ein Filter. Die Quests werden nach Gebiet einsortiert. Du kannst mit Pfeil runter ein Gebiet wählen und dann darin die Quests dieses Gebietes finden.",
               ["beginText"] = "Dein Questbuch hat sich geöffnet. Es gibt eine Übersicht, in der deine Quests in Regionen und Kategorien einsortiert werden. Um dort hin zu gelangen drücke einmal (Pfeil rechts)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = "Alle",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [3]
               },
            }, -- [10]
            {
               ["title"] = "Quest finden und im Questbuch lesen.",
               ["endText"] = "Hier sind die Quests aufgelistet, die du bereits angenommen hast.",
               ["beginText"] = "Hier bist du richtig. Wenn du viele Quests hast, kannst du hier mit Pfeil hoch und runter die Kategorie deiner Region wählen und nur die Quests dieser Region anzeigen lassen. du hast nur eine Quest. Du stehst auf der Kategorie (Alle). Gehe jetzt in diese Kategorie, und drücke dafür (Pfeil rechts).  ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [11]
            {
               ["title"] = "Die Bedrohung von Innen im Questbuch lesen.",
               ["endText"] = "Sehr gut. Deine Aufgabe ist es, mit dem Marschal zu sprechen.",
               ["beginText"] = "Du stehst nun auf der Quest. Hier in deinem Questbuch hast du für jede Quest die Tooltip-Funktion. Um den Inhalt der Quest mit der Tooltip-Funktion zu lesen, sollst du nun die Umschalttaste dauerhaft festhalten und den Tooltip durch einmaliges drücken der (Pfeil runter) Taste öffnen. Es ertönt ein Pling. Der Tooltip hat sich geöffnet. Jedesmal, wenn du nun (Pfeil runter) drückst, wird ein neuer Absatz vorgelesen. Dabei hälst du die (Umschalttaste) die ganze Zeit lang fest. Wenn du die (Umschalttaste) loslässt hörst du wieder ein Pling und der Tooltip schließt sich. Versuche, die ganze Quest nun nochmal zu lesen. Drücke also die (Umschalttaste) dauerhaft und drücke so oft auf (Pfeil runter) bis du ganz unten angekommen bist.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "hinter mir",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [12]
            {
               ["title"] = "Navigationnsmenü im Questbuch nutzen",
               ["endText"] = "Hier kannst du verschiedene Zielnavigationen starten. Zur questannahme, zur Abgabe und auch zu Zielen, falls ein Ziel notwendig ist.",
               ["beginText"] = "Du kennst nun deine Aufgabe. Um zum Marschal zu gelangen solltest du das Navigationssystem benutzen. Immer wenn du auf einer Quest im Questbuch stehst, kannst du einmal nach rechts gehen um in das Navigationsmenü zu gelangen. Drücke dafür bitte jetzt (Pfeil rechts)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Annahme",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [13]
            {
               ["title"] = "Zur Questabgabe navigieren",
               ["endText"] = "Bei diesem NPC sollst du die Quest abgeben. ",
               ["beginText"] = "hier im Navigationsmenü kannst du verschiedene Navigationsziele wählen. Es kann  Den Ort der (Questannahme), später auch den ort der (Gegner) und ganz unten den Ort der (Questabgabe) geben. Du hast die Quest bereits angenommen. Du möchtest die Quest nun abgeben. Gehe also bitte auf (Abgabe) mit (Pfeil runter).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Abgabe",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [14]
            {
               ["title"] = "rein in die Abgabe",
               ["beginText"] = "Du möchtest ja wissen, wo du hinlaufen musst um die Quest abzugeben. Das Navigationssystem bietet dir unter (Abgabe) Ziele für die Questabgabe an. drücke einmal (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "Bride",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [15]
            {
               ["title"] = "auf dem Navivorschlag nach rechts",
               ["beginText"] = "Das ist der Vorschlag vom Navigationssystem. Es könnten auch mehrere sein. Du könntest die ganzen Vorschläge hier mit Pfeil hoch und runter begutachten. In diesem Fall ist der Marshall, auf dem du jetzt stehst, das richtige Ziel. Du möchtest zum Marshall und deshalb drückst du nun (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Route",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [3]
               },
            }, -- [16]
            {
               ["title"] = "Was sind routen?",
               ["endText"] = "Das ist dein Ziel.",
               ["beginText"] = "Hier findest du verschiedene Arten der Navigation. Es gibt (Ruten), (nahe Ruten) und (Wegpunkte). Du möchtest eine Rute, die dich sicher von A nach B führt. gehe also einfach noch ein letztes mal nach rechts und drücke dafür (Pfeil rechts). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
                  {
                     ["value"] = "Bride",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [17]
            {
               ["title"] = "Navigation starten.",
               ["endText"] = "Du hörst nun ein neues Geräusch. Es ist ein Audiobeacon, der dir sagt, wohin du laufen musst.",
               ["beginText"] = "Dies ist nun ein Auswählbares Navigationsziel. Es kann mehrere geben, welche du über Pfeil hoch und runter anwählen könntest. Den Marshall gibt es hier aber nur einmal. Du hast die Entfernung gehört und am ende wurde kein Plus angehängt. Es gibt also kein Untermenü. Starte die Navigation indem du (Eingabe) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 27,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [18]
            {
               ["title"] = "Navigationsstart",
               ["endText"] = "Geschafft! Gut gemacht!",
               ["beginText"] = "Die Navigation wurde gestartet. Das neue Geräusch ist ein Audiobeacon. Wenn du dich mit (A) und (D) drehst, hörst du, wo es sich befindet. Wenn du dir nicht sicher bist, kannst du durch drücken der Taste Alt(Gr) (rechts neben der Leertaste) erfahren, in welche Richtung du dich drehen musst und wie weit es weg ist. 11 Uhr bedeutet schräg links vor dir. 3 Uhr bedeutet rechts neben dir. Drehe dich mit den Tasten A und D oder den Pfeiltasten, bis das Beacon auf 12 Uhr liegt. Laufe dann mit W oder Pfeil hoch vorwärts, bis du den beacon erreicht hast.",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8924.4;-116.8;5",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [19]
            {
               ["playFtuIntro"] = "",
               ["title"] = "Weiterlaufen bis zum Ziel",
               ["beginText"] = "Gut gemacht. du hast den Beacon erreicht, es hat Pling gemacht und der Beacon ist verschwunden. Dafür ist ein neuer Beacon erschienen, den du erreichen musst. Du läufst relativ frei in der Welt herum. Es gibt ein Warngeräusch, welches dir sagen soll, wenn du feststeckst. Es macht dann Piep Piep Piep. Gehe dann kurz rückwärts und mache einen kleinen Bogen. Manchmal hilft es auch, mit der Leertaste zu springen. Du musst auf jeden Fall selbständig zum nächsten Beacon kommen. Erinner dich. Mit der Taste Alt (GR) rechts neben der Leertaste kannst du fragen, wo er genau ist. Im Notfall kannst du mit (Steuerungstaste) (Umschalttaste) und einen druck auf (S) den vorherigen Beacon wieder anschalten. Laufe jetzt weiter zum nächsten Beacon und dann die Rute bis zum Ende.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8903.0;-163.0;5",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [20]
            {
               ["title"] = "Ende der Rute",
               ["beginText"] = "Du bist am ende der Rute angekommen. du solltest nun kein Beacon mehr hören. Wenn du nicht genau getroffen hast, versuche zuerst, genau bis zu dem Beacon zu laufen, so dass die rute beendet wird. Schalte das Tutorial dann manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [21]
            {
               ["title"] = "Marschal ansprechen",
               ["endText"] = "Getroffen!",
               ["beginText"] = "Versuche nun, den Marschal ins Ziel zu nehmen. Sollte es nicht funktionieren, stehst du möglicherweise nicht so, dass er sich vor dir befindet. Gehe ein paar Schritte zurück oder drehe dich. Versuche wiederholt den Marschal mit der Tastenkombination Steuerung und Umschalttaste und einen Druck auf Tabulator zu finden.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Bride",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [22]
            {
               ["title"] = "Interagieren mit NPC",
               ["endText"] = "Das Dialogfenster hat sich geöffnet.",
               ["beginText"] = "Mit der Taste (G) kannst du NPCs ansprechen. Du interagierst sozusagen mit deinem Ziel. Drücke jetzt (G)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [23]
            {
               ["title"] = "Dialogfenster start",
               ["beginText"] = "Das Dialogfenster hat sich geöffnet. Du stehst auf (Dialog) (plus). Das (plus) sagt dir, dass du nach rechts weitergehen kannst. Drücke (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Hilfe gut gebrauchen",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [24]
            {
               ["title"] = "Navigation im Dialogfenster",
               ["endText"] = "Hier kannst du die Quest abgeben.",
               ["beginText"] = "Dieses Dialogfenster könnte viele verschiedene Optionen bieten. Hier hat der Questgeber nur eine Option für dich. Es ist deine Quest, die du abgeben möchtest. Gehe nach unten auf deine Quest. Drücke dafür einmal Pfeil runter. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "angenommene Quest",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [25]
            {
               ["title"] = "In die q zum abgeben gehen",
               ["beginText"] = "Der Hinweis (angenommene Quest) sagt dir, Dass du diese Quest bereits angenommen hast und sie sich in deinem Questbuch befindet. Du musst sie nun auswählen um sie hier bei diesem NPC abzugeben. Öffne dafür das Untermenü. Das (Plus) am Ende des Questnamen sagt dir, dass es ein Untermenü gibt. Um es zu öffnen drücke (Pfeil rechts).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "linksklick",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [26]
            {
               ["title"] = "ins questfenster springen",
               ["beginText"] = "Das Untermenü hat sich geöffnet. Du stehst auf der Schaltfläche (Linksklick). Dieser menüpunkt heißt so, weil sehende Spieler mit der Maus einen Linksklick ausführen. Du führst den Linksklick aus, indem du jetzt (enter) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [27]
            {
               ["title"] = "Quest abgeben",
               ["endText"] = "Gratuliere! Du hast deine erste Aufgabe gemeistert.",
               ["beginText"] = "Du kannst den Text in diesem Fenster lesen, indem du mit den Pfeiltasten nach unten gehst. Suche die Schaltfläche Abgeben und bestätige sie wie eben schon, mit der Schaltfläche (Linksklick) im Untermenü. alternativ kannst du einfach Leertaste drücken ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 61,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [28]
            {
               ["title"] = "Quest annehmen",
               ["endText"] = "Jetzt hast du eine neue Aufgabe.",
               ["beginText"] = "Du hast deine erste Quest abgegeben und Erfahrung dafür erhalten. Der NPC bietet dir sofort eine neue Quest an. nehm sie an, indem du das Fenster mit den Pfeiltasten liest und auf (Annehmen) im Untermenü wieder auf (Linksklick) gehst und (Enter) drückst oder drücke alternativ einfach (Leertaste) ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 58,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [29]
            {
               ["title"] = "Welche Zauber hast du?",
               ["endText"] = "Dies ist das Menü für deine Aktionsleisten. Hier kannst du sie auch verändern.",
               ["beginText"] = "Auf in den Kampf %class%. Doch, um zu kämpfen, musst du zuerst wissen, welche Tasten mit Aktionen belegt sind. Schauen wir uns also zuerst die Aktionsleiste an. Öffne das Menü dafür mit Umschalttaste und F 11",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Aktionsleiste",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
               },
            }, -- [30]
            {
               ["title"] = "Aktionsleiste betrachten",
               ["endText"] = "Mit den Pfeiltasten hoch und runter kannst du alle Tasten dieser Leiste anwählen.",
               ["beginText"] = "Du stehst nun auf der Übersicht der Aktionsleisten. Nach Unten findest du die verschiedenen Leisten aufgelistet. Du möchtest dir die erste leiste ansehen. Diese entspricht den Tasten Ziffer 1 bis Apostroph neben der Löschentaste. Gehe dafür nach rechts.  ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [31]
            {
               ["playFtuIntro"] = "",
               ["title"] = "Automatischer Angriff",
               ["beginText"] = "Auf Button 1 befindet sich also der automatische Angriff. Das bedeutet, dass du damit das automatische Zuschlagen ein und ausschalten kannst. Du solltest den button erst einmal nicht nutzen. Wenn du einen Gegner angreifst, startet das automatische Zuschlagen sowieso von allein. Gehe jetzt runter auf button 2 ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = "Heldenhafter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [32]
            {
               ["title"] = "Einen Zauber im Detail lesen.",
               ["endText"] = "Du findest hier auch die Reichweite für einen Zauber.",
               ["beginText"] = "auf Taste 2 befindet sich dein hauptangriff Heldenhafter Stoß. Um ihn auszuführen benötigst du Wut. Immer wenn du Schaden austeilst, erhälst du dafür Wut. Wenn du genug Wut durch deine Angriffe erhalten hast, kannst du diesen Schlag dann ausführen. Die Details vom Heldenhaften Stoß und von allem anderen, was sich auf den Tasten befindet, kannst du mit der Tooltipfunktion lesen. Es ist die gleiche Funktion wie in deinem Questbuch. Halte die (Umschalttaste) gedrückt und gehe Schritt für Schritt mit der Taste (Pfeil runter) nach unten.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [33]
            {
               ["title"] = "Aktionsleiste schließen",
               ["endText"] = "Die ESC Taste hat folgende Funktion in einer festen Reihenfolge. Zuerst werden Taschen, Questlog, dialoge oder andere Fenster geschlossen. Zweitrangig wird dein Ziel gelöscht. Wenn du kein Ziel hast und alle Fenster geschlossen sind, dann öffnet die ESC Taste das Spielmenü von Wow. Dann hörst du Walgeräusche. Um dieses Menü wieder zu schließen musst du erneut ESC drücken. ",
               ["beginText"] = "Du kannst jetzt die Details von Fähigkeiten lesen. Mit Pfeil hoch und runter kannst du dir die ganze Aktionsleiste ansehen und nachlesen, welche Fähigkeit auf welcher Taste liegt. Wenn du einen ungefähren Überblick über deine Fähigkeiten hast, dann schließe das Menü mit ESC.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 28,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [34]
            {
               ["title"] = "Ins Questbuch ins Navigationsmenü kommen",
               ["endText"] = "Hier kannst du die Quest nochmal lesen, indem du Umschalttaste und Pfeil runter benutzt. Du kannst übrigens auch zu den Überschriften springen, indem du die Steuerungstaste hinzunimmst. Wenn du fertig bist, gehe nach rechts in die Questnavigation.",
               ["beginText"] = "%name% Nun wollen wir endlich etwas töten! Dafür musst du zuerst auf deine Quest im Questbuch gelangen. Drücke dafür (L) und zwei mal nach rechts. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Säuberung im Koboldlager",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [35]
            {
               ["title"] = "Säuberung im Koboldlager Navigation starten",
               ["endText"] = "Hier bist du richtig. Prequest bedeutet, unter diesem Menü sind die Quests aufgelistet, die du erledigt haben musst, um diese Quest zu erhalten. Das ist später wichtig für die Recherche.",
               ["beginText"] = "Du kannst die Quest natürlich nochmal lesen, indem du die Tooltipfunktion benutzt. halte dafür die Umschalttaste fest und drücke (Pfeil runter). Das Questziel lautet, Koboldgezücht zu töten. Um die Navigation zu diesen Gegnern zu starten, musst du in das Navigationssystem gehen. Drücke dafür (Pfeil rechts). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "annahme",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [3]
               },
            }, -- [36]
            {
               ["title"] = "Zielnavigation starten",
               ["endText"] = "Drücke Enter und starte so eine Route zum Ziel.",
               ["beginText"] = "Dich interessiert in dieser Liste (Annahme) (Ziel) (abgabe) und (Pre quest) zuerst der Punkt (Ziel). du möchtest ja nun zum Quest(Ziel) gelangen. Gehe also runter und dann bei Ziel ganz nach rechts. also einmal (Pfeil runter) und dann drei mal nach rechts mit (Pfeil rechts)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "Koboldgezücht",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [37]
            {
               ["title"] = "Route zum ersten Gegner",
               ["endText"] = "Gleich bist du bei deinem ersten gegner. Hier im Startgebiet greifen die Gegner dich nicht von allein an. Erst, wenn du angreifst, kämpfen sie gegen dich. Solltest du ein Magier, Hexenmeister oder Priester sein, dann bleib trotzdem schon hier stehen. Diese 3 Klassen beginnen den Kampf mit Fernkampfzaubern aus der maximalen Entfernung heraus. Suche in jedem Fall, egal welche Klasse du spielst, kurz bevor du beim vorletzten oder letzten Punkt ankommst nach einem Koboldgezücht. Drücke dafür einfach nur die Tabulatortaste. Wenn du nicht fündig wirst, gehe etwas näher ran und drehe dich im Zweifel auch, während du die Tabulatortaste immer wieder drückst. ",
               ["beginText"] = "Das ist der Ziel-Vorschlag, den dir das Navigationssystem macht. Darunter finden sich weitere vorschläge. die vorschläge sind nach Entfernung sortiert. Du möchtest eine Rute zum nächsten Koboldgezücht. um die Rute zum nächsten Koboldgezücht zu starten drücke jetzt die (Eingabetaste). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 93,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [38]
            {
               ["playFtuIntro"] = "",
               ["title"] = "Rute folgen beginnen",
               ["beginText"] = "Die rute wurde gestartet und du hörst nun wieder das Beacon. Erinnere dich daran, dass du mit der Taste (Alt(G)(R)) rechts neben der (Leertaste) hören kannst, wo es sich genau befindet. Laufe die Beacons nun alle ab um zu den Koboldgezüchten zu gelangen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8899.7;-119.9;10",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [39]
            {
               ["playFtuIntro"] = "",
               ["title"] = "Kobold suchen.",
               ["beginText"] = "Schon hier könnten sich Gegner vor dir befinden. Mit der Tabulatortaste kannst du Gegner vor dir ins Ziel nehmen. Wenn du einen Wolf ins Ziel bekommst, ignoriere ihn. Hier im Startgebiet sind sie noch nicht aggressiv. Sie greifen dich nicht an. Wenn du möchtest, dann lösche dein Ziel durch einmaliges drücken der Taste Escape oder nehme dich selbst mit (E) ins Ziel. Du kannst auch einfach Tabulator drücken um nach weiteren Zielen zu suchen. Wenn du ein Ziel hast, sagt eine Männliche Stimme die Entfernung zum Ziel an. Folge weiter der Rute und suche mit Tabulator nach einem Kobold.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 55,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
                  {
                     ["value"] = "Kobold",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [40]
            {
               ["playFtuIntro"] = "",
               ["title"] = "Angriff",
               ["beginText"] = "Das ist ein Kobold. Greife ihn an, indem du die Taste (G) für Interagieren drückst. Du als %class% läufst dann automatisch an die Position des Gegners und schlägst zu. Da sich der Kobold selbst auch bewegt, solltest du im Kampf nochmal (G) drücken, damit du dich neu ausrichtest. Jeder Druck (G) sagt deiner Spielfigur (laufe zum Ziel oder drehe dich in die richtige Richtung zum Gegner und starte den automatischen Angriff)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 49,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [41]
            {
               ["title"] = "Plündern",
               ["beginText"] = "Glückwunsch. Der Kobold ist tot! Du kannst nun Beute erhalten, indem du den Leichnam plünderst. Dies kannst du auf verschiedene Weisen tun. Versuche nach dem Kampf auf (H) zu drücken. Dadurch bekommst du den letzten Gegner wieder ins Ziel, denn dein Ziel wird nach dem Kampf automatisch gelöscht. Drücke dann (G) und interagiere mit der Leiche. Du erhälst dann die Beute. Wenn nicht, dann zeige ich dir beim nächsten Gegner eine andere Variante. Versuche es nun. Drücke erst (H) und dann (G). Schalte das tutorial danach manuell weiter.",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [42]
            {
               ["title"] = "Navigation beenden",
               ["beginText"] = "Hinweis: Möglicherweise bist du nicht bis zum ende der Rute gelaufen. Wenn das Beacon noch eingeschaltet ist und dich das laute Geräusch ablenkt, kannst du es mit Umschalt F(12) einfach ausschalten. Achte außerdem bei der Wahl des Gegners darauf, dass es unterschiedliche Kobolde gibt. Die Quest verlangt von dir, dass du Koboldgezücht tötest. Schalte das tutorial manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [43]
            {
               ["title"] = "Hinweis Kobold finden",
               ["beginText"] = "Hinweis: Wenn du kein Koboldgezücht finden kannst, kannst du dein Questbuch öffnen und über die Navigation und dort über (Ziel) eine Rute zum nächsten Koboldgezücht starten. Die Koboldgezüchte sollten aber überall um dich herum sein. schalte das tutorial manuell weiter. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [44]
            {
               ["title"] = "Kobold nummer 2",
               ["beginText"] = "Töte jetzt einen weiteren Gegner. Drücke wieder die (Tabulatortaste) um ein Ziel zu finden. du kannst dich auch mit (A) und (D) drehen um in andere Richtungen zu suchen. Wenn du ein Koboldgezücht gefunden hast, greife an, indem du (G) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 49,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [45]
            {
               ["title"] = "SoftTarget für Loot",
               ["beginText"] = "Du wirst nun mit Softtarget plündern. Das bedeutet, dass das Spiel dir Ziele vorschlägt. Dies kann hilfreich aber auch hinderlich sein. Wir unterscheiden zwischen Softtarget für (Feinde), (Freunde) und für (Objekte). Objekte sind alle Dinge, mit denen du interagieren kannst. Also auch Leichen die du plündern kannst. Mit eingeschaltetem Softtarget hörst du ein Schmatzgeräusch, weil das Spiel dir ein Ziel vorschlägt. Drücke Umschalttaste und (O), um das Softtarget einzuschalten und höre genau hin.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = 64,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [46]
            {
               ["title"] = "Softtarget erklären",
               ["beginText"] = "Drücke (G), wenn du das Geräusch gehört hast. Das Ziel wird automatisch ausgewählt und geplündert. Drehe dich im Kreis und schau nach ob noch mehr Beute herumliegt. Sammel alles mit (G) ein. Das Softtargeting lassen wir nun eingeschaltet und nach dem nächsten Kampf wird das Geräusch sofort zu hören sein. Du kannst dann auch sofort durch einmaliges drücken von (G) plündern. Töte einen weiteren Kobold.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 49,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [47]
            {
               ["title"] = "Erklärung der ansagen",
               ["beginText"] = "Vergesse nicht mit (G) zu plündern, wenn du das Schmatzgeräusch gehört hast. Im Kampf hörst du viele Ansagen. Die Weibliche Stimme sagt in 10er Schritten, wieviel Prozent Leben der Gegner noch hat. Die Jungenstimme sagt einstellig in 10 Schritten dein Leben an. Das Mädchen sagt dir, wieviel Wut du hast. Schalte das tutorial jetzt manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [48]
            {
               ["title"] = "Quest zuende spielen",
               ["beginText"] = "Töte nun die restlichen Kobolde und plünder sie. Um zu erfahren, ob du die aufgabe erledigt hast, öffne dein Questbuch mit (L) und sehe in der Quest unter (Fortschritt) nach. Bei jedem Questfortschritt hörst du auch ein (Pling) und bei Questabschluss ein (Pling Pling). Wenn du ein Lautes Gongähnliches Geräusch hörst, oder dir unsicher bist, dann schalte das Tutorial manuell weiter. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [49]
            {
               ["title"] = "Level Up und die Übersichtsseite",
               ["beginText"] = "Möglicherweise hast du das Gonggeräusch gehört. Das bedeutet, du bist auf Stufe 2 aufgestiegen. Schau nach, wie viel Erfahrung du hast. das kannst du auf der Übersichtsseite. Du öffnest die Übersichtsseite mit Umschalttaste und Pfeil runter. Die Übersichtseite bedienst du so, wie den Tooltip. Halte (Umschalttaste) fest und gehe mit (Pfeil runter) Zeile für Zeile nach unten, bis du deinen Erfahrungsfortschritt findest",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = "xp",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [50]
            {
               ["title"] = "Tooltip Steuerungsfunktion",
               ["beginText"] = "Hinweis: Die Tooltipfunktion hat eine weitere möglichkeit, um von Überschrift zu Überschrift zu springen. Dafür nimmst du zu der (Umschalttaste) die du ja festhälst, die (Steuerungstaste) hinzu. Wenn du dann die Pfeiltasten nach unten oder oben drückst, springst du zu den Überschriften. lasse dann nur die (Steuerungstaste) los und halte die (Umschalttaste) weiter fest. Gehe dann mit der Pfeiltaste nach unten um unter der Überschrift zu lesen. Du kannst das auf der Übersichtsseite ausprobieren und sie entdecken. Du wirst später aber weitere erklärungen dazu erhalten, wenn es dir jetzt zu kompliziert ist. Schalte das Tutorial jetzt manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [51]
            {
               ["title"] = "Quest erledigt",
               ["beginText"] = "Hast du deine Quest erledigt? Alle Koboldgezücht getötet. In deinem Questbuch steht vor der Quest das Wort (Fertig) und unter Fortschritt kannst du lesen, dass du 8 von 8 getötet hast. Das ist gut. Dann schalte das Tutorial weiter um nun zurück zum Questgeber zu laufen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [52]
            {
               ["title"] = "Softtarget ausschalten",
               ["beginText"] = "Wunderbar! Du bist nun fertig. Du könntest das Softtarget zwar eingeschaltet lassen, es würden aber sehr viele Vorschläge auftauchen, die störend sind. Schalte das Softtarget deshalb nun aus indem du Shift (o) drückst. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = 64,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [53]
            {
               ["title"] = "Questbuch öffnen und auf die q gehen",
               ["beginText"] = "Öffne nun dein Questbuch mit (L) und gehe nach rechts auf die Quest. Dort sollte vor der Quest ein FERTIG gesagt werden. Falls das nicht so ist, dann musst du noch mehr Kobolde töten.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "fertig",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [54]
            {
               ["title"] = "Navigation zur Abgabe starten",
               ["beginText"] = "Gehe nach rechts und dann nach unten bis auf (Abgabe). Dann gehe nach rechts, bis du den Namen des Questgebers mit Entfernungsangabe hörst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = "Bride",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [55]
            {
               ["title"] = "Route starten und zum Ziel laufen",
               ["beginText"] = "Starte die Navigation und folge den Beacons bis zum Questgeber. Drücke zum starten die (Eingabetaste) und laufe los",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Quest verfügbar",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = "-8826.8;-160.5;10",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [2]
                  {
                     ["value"] = "-8924.8;-110.4;20",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [3]
               },
            }, -- [56]
            {
               ["title"] = "Erklärung verfügbare quest",
               ["beginText"] = "Wenn du durch die Welt läufst, kann es sein, dass in deiner Nähe ein NPC steht, der eine Aufgabe für dich hat. Du hörst dann die automatische Ansage. Das Addon sagt dann sowas wie (Verfügbare) (Quest) (Questname). Später gibt dir das wichtige Hinweise. Jetzt kannst du das ignorieren. Laufe weiter bis zum Questgeber.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8902.0;-161.7;5",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [57]
            {
               ["title"] = "Ansage von verfügbaren Quests",
               ["beginText"] = "Du bist angekommen. Versuche so genau zu treffen, dass auch das letzte Beacon abgeschaltet wird. Nehme dann den Marshall ins Ziel indem du (Steuerungstaste) und (Umschalttaste) festhälst und auf (Tabulator) drückst. Wenn du ihn nicht findest, drehe dich und drücke die Tasten nochmal. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Bride",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [58]
            {
               ["title"] = "Quest abgeben Ansprechen",
               ["beginText"] = "Interagiere mit dem Questgeber indem du (G) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [59]
            {
               ["title"] = "Dialogfenster erklären",
               ["beginText"] = "Wenn ein Questgeber nur eine Quest für dich hat, öffnet sich sofort die Quest. In den meisten Fällen öffnet sich aber ein Dialogfenster mit verschiedenen Optionen. Gehe einmal nach rechts. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [60]
            {
               ["title"] = "Im dialogfenster navigieren",
               ["beginText"] = "In einem Dialogfenster findest du Quests, die zur Abgabe bereit sind oder auch verfügbare Quests. Es kann auch andere Angebote von NPCs geben. Händler und Trainer haben auch oft dialogfenster. Im Dialogfenster musst du auf die gewünschte Option (also die Quest, die du nun abgeben möchtest) gehen. Wenn du dann das Menü öffnest, indem du nach rechts gehst, kannst du auf der Schaltfläche (Linksklick) mit Enter bestätigen und diese Option wählen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [61]
            {
               ["title"] = "Quest im Dialogfenster bedienen",
               ["beginText"] = "Nun ist die Quest geöffnet. du kannst sie abgeben, indem du die Schaltfläche (Abschließen) bestätigst oder indem du einfach Leertaste drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 61,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [62]
            {
               ["title"] = "Erneut mit dem NPC sprechen",
               ["beginText"] = "Das NPC Fenster schließt sich automatisch, wenn keine weitere Option vorhanden ist. Hier hat der NPC aber 2 weitere Quests für dich. Deshalb hat sich das Dialogfenster wieder geöffnet. Du stehst auf dem Feld (Dialog) (Plus) und musst einmal nach rechts gehen um den Dialog und die Optionen zu sehen. Drücke einmal Pfeil rechts. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [63]
            {
               ["title"] = "Dialogfeld mit 2 Quests",
               ["beginText"] = "Du bist jetzt wieder im Dialogfenster. unten sind 2 Quests, die (Verfügbar) sind. Das bedeutet, du kannst sie annehmen und dann sind sie in deinem Questbuch. Gehe jetzt einmal nach unten mit Pfeil runter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "verfügbar",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [64]
            {
               ["title"] = "Quest eins annehmen",
               ["beginText"] = "Dies ist die erste Quest. Wähle sie aus. Gehe  nach rechts und drücke im Untermenü dann auf (Linksklick) die (entertaste).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [65]
            {
               ["title"] = "Annahme von der ersten",
               ["beginText"] = "Dies ist das Questfenster. Du kennst es schon. Du musst wie immer einmal nach rechts gehen. Dann kannst du die Quest lesen. Nehme sie an indem du die schaltfläche (Annehmen) im (Untermenü) mit (Linksklick) bestätigst oder drück einfach einmal die (Leertaste).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 58,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [66]
            {
               ["title"] = "Annahme der zweiten",
               ["beginText"] = "Du hast die erste Quest angenommen. Das Fenster hat sich geschlossen. Der NPC hat aber eine weitere Quest für dich. Spreche ihn also nochmal an, indem du (G) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [67]
            {
               ["title"] = "in die zweite reingehen",
               ["beginText"] = "Das Dialogfenster hat sich wieder geöffnet. Du musst nochmal das gleiche tun, wie bei der ersten Quest, die du angenommen hast. Gehe nach rechts und nach unten auf die (verfügbare) Quest.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "verfügbare",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [68]
            {
               ["title"] = "in die zweite quest klgehen",
               ["beginText"] = "Gehe wieder nach rechts in das (Untermenü) und drücke auf (Linksklick) wieder (Enter). Dann öffnet sich die zweite Quest zur Annahme. Lese die Quest, wenn du möchtest und suche die Schaltfläche (Annahme) oder drücke einfach (Leertaste)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 58,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [69]
            {
               ["title"] = "Prüfen ob due 2 Quests hast.",
               ["beginText"] = "Prüfe nun in deinem Questbuch (öffnen mit (L)) ob du zwei Quests hast. Wenn ja, schließe das questbuch mit Escape und schalte das Tutorial manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [70]
            {
               ["title"] = "Taschen",
               ["beginText"] = "Bevor du dich den weiteren Quests widmest, solltest du nachsehen, was du bei den Kobolden gefunden hast. Öffne deine Taschen mit der Taste (B).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 16,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [71]
            {
               ["title"] = "Inhalt",
               ["beginText"] = "Anfangs hast du nur eine Tasche. Deinen Rucksack mit 16 Plätzen. gehe nach rechts und dann auf (Tasche 1) nochmal nach rechts. Dann bist du auf dem ersten Taschenplatz.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Ruhestein",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = 16,
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [72]
            {
               ["title"] = "Bedienung der Taschen eins",
               ["beginText"] = "Hier auf dem ersten Platz in deinem Rucksack findest du deinen Ruhestein. Er ist ein benutzbares Objekt. Du kannst informationen bekommen, indem du die Umschalttaste festhälst und Pfeil runter drückst. Manchmal musst du die Umschalttaste loslassen und dann den Tooltip nochmal öffnen, damit der gesamte Text angezeigt wird. Tue das. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [73]
            {
               ["title"] = "Bedienung der Taschen 2",
               ["beginText"] = "Wie du gelesen hast, kann dein Ruhestein dich zum Ruheort zurückteleportieren. Später wird das dann ein von dir gewähltes Gasthaus sein. Jetzt ist es der Punkt, an dem du das Spiel gestartet hast.  Schalte manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [74]
            {
               ["title"] = "Bedienung der Tasche drei",
               ["beginText"] = "Jeder Taschenplatz hat ein Bedienmenü. Du erreichst es, indem du nach rechts gehst. darin findest du viele Optionen. Mit Linksklick nimmst du einen Gegenstand auf und er klebt praktisch an deinem Mauspfeil. Du könntest ihn dann durch linksklick auf einem anderen Taschenplatz wieder ablegen. Schalte manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [75]
            {
               ["title"] = "Bedienung der Tasche vier",
               ["beginText"] = "Wenn du auf einem Objekt in deiner Tasche im Objektmenü einen Rechtsklick ausführst, Interagierst du mit dem Objekt. Das bedeutet, du benutzt den Gegenstand, du isst das Essen, trinkst das Getränk, ziehst die Waffe an und  wenn ein Händlerfenster geöffnet ist, dann verkaufst du den Gegenstand. Schalte manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [76]
            {
               ["title"] = "Bedienung der Tasche fünf",
               ["beginText"] = "Du kannst nun mit Pfeil hoch und runter den Tascheninhalt begutachten. Mit Umschalttaste und Pfeil runter kannst du jeweils die Informationen des Objektes bekommen. Wenn du einen Gegenstand anziehst, verschwindet er aus der Tasche. Manchmal aktualisieren die Taschen nicht korrekt. Schließe sie dann mit Escape und öffne sie neu. Schalte manuell weiter, wenn du alles angesehen hast.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [77]
            {
               ["title"] = "Taschen schließen und Charakterfenster öffnen",
               ["beginText"] = "Schließe deine Taschen mit Escape und öffne dein Charakterfenster nun mit (C).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 3,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [78]
            {
               ["title"] = "Charakterfenster",
               ["beginText"] = "In diesem Fenster bekommst du alle Informationen zu deinem Charakter. gehe einmal nach rechts um auf die Überschrift zu gelangen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "Stufe",
                     ["type"] = "TTS_STRING",
                  }, -- [1]
               },
            }, -- [79]
            {
               ["title"] = "Ausrüstung ansehen",
               ["beginText"] = "Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 3,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Kopf",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [80]
            {
               ["title"] = "Die Ausrüstungsplätze",
               ["beginText"] = "Das ist der Platz für den Kopf. Du trägst keinen Hut. du kannst nach unten gehen und alle möglichen Plätze begutachten. Wenn ein Gegenstand angezogen ist, wird er sofort forgelesen. Du kannst auch hier jeweils mit Umschalttaste und Pfeil runter genauere Informationen zum Gegenstand erhalten. Schließe das Charakterfenster wenn du fertig bist.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 28,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [81]
            {
               ["title"] = "Zum verkaufen gehen",
               ["beginText"] = "Möglicherweise hast du Dinge in deiner Tasche, die du nicht mehr brauchst. Du brauchst aber jeden einzelnen Kupfer. Du solltest einen Händler besuchen, um Überflüssiges zu verkaufen. Öffne dafür die manuelle Navigation mit (Umschalttaste) und (F 10)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [82]
            {
               ["title"] = "Navigationsmenü manuell",
               ["beginText"] = "Das ist der Startpunkt für deine Navigation. Hier beginnt deine Rute. gehe nach rechts um das Ziel festzulegen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [83]
            {
               ["title"] = "Navi Liste erläutern",
               ["beginText"] = "Du stehst nun auf dem obersten Feld einer langen Liste. In der Liste stehen alle Ziele nach Entfernung sortiert, die du von hier erreichen könntest. mit (Pfeil runter) kannst du auf ein Ziel gehen und mit (Enter) kannst du es auswählen. höre dir weitere Erklärungen dazu an und schalte jetzt manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [84]
            {
               ["title"] = "Navi Filter erläutern",
               ["beginText"] = "Der Filter erleichtert dir die Suche nach einem bestimmten Ziel. Um den Filter zu aktivieren schreibst du einfach einen Teil des namens deines Ziels und gehst dann mit den Pfeiltasten nach unten auf die Ergebnisse. Mit der (Löschen-Taste) kannst du den Filter löschen. Die ersten zwei buchstaben musst du relativ schnell schreiben, damit sich der filter aktiviert. Schalte jetzt manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [85]
            {
               ["title"] = "Navi Auftrag geben Rodric zu finden",
               ["beginText"] = "Suche jetzt nach dem Rüstungsschmied (Godric) (Rothgahr). Gehe Feld für Feld nach unten und bestätige die Auswahl mit (Enter). Du kannst auch den Filter Nutzen. Schreibe dafür die buchstaben (R) (Ü) (S) und gehe dann mit (Pfeil runter) auf das Ergebnis. Drücke zum auswählen (Enter). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 93,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [86]
            {
               ["title"] = "Zum Händler laufen",
               ["beginText"] = "Du hast die Rute gestartet. Folge den Beacons bis zum Rüstungsschmied.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8898.6;-119.5;5",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [87]
            {
               ["title"] = "Angekommen beim Händler",
               ["beginText"] = "Godric (den Rüstungsschmied) kannst du genau so wie die anderen NPCs ins Ziel nehmen. Wenn der letzte Wegpunkt noch aktiviert ist, kannst du ihn mit (Umschalttaste) und (F12) ausschalten. Drücke dann wie immer (Umschalttaste) und (Steuerungstaste) und (Tabulator) ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "odri",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [88]
            {
               ["title"] = "Ansprechen des Händlers",
               ["beginText"] = "Wenn du den Händler ansprichst, wird sich das Händlerfenster öffnen. Das SkuAddon wird automatisch Schrott verkaufen und deine Ausrüstung reparieren. Interagiere nun mit dem Händler indem du (G) drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [89]
            {
               ["title"] = "Ebenen beim Händler",
               ["beginText"] = "Du stehst nun auf Händler. nach unten kommst du auf das Taschenmenü. tue das als erstes. Gehe runter auf Tasche und dann nach rechts in deine Tasche.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Ruhestein",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [90]
            {
               ["title"] = "Verkaufen beim Händler",
               ["beginText"] = "Deinen Ruhestein kannst du nicht verkaufen. Auch Questgegenstände lassen sich nicht verkaufen. Solltest du weitere Gegenstände in deinen Taschen finden, dann verkaufe sie nun, indem du im Objektmenü einen (Rechtsklick) ausführst. Gehe dafür auf dem Objekt nach rechts in das Objektmenü und dann eins nach unten auf (Rechtsklick). Drücke dann Enter. Du solltest Münzenklimpern hören. Wenn du fertig bist, schalte das Tutorial manuell weiter.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [91]
            {
               ["title"] = "Von Tasche in Händlermenü wechseln",
               ["beginText"] = "Gehe nach links auf (Tasche 1) und nochmal nach links auf (Taschen).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Taschen",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [92]
            {
               ["title"] = "In das Händlerfenster wechseln",
               ["beginText"] = "Gehe hoch auf (Händler). Dort bist du gestartet. Gehe diesmal, wenn du auf (Händler) stehst einfach mit den Pfeiltasten nach rechts, um in das Händlerfenster zu gelangen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 69,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "Rodric",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [93]
            {
               ["title"] = "Händlermenü erklären",
               ["beginText"] = "Du befindest dich auf der Überschrift. Gehe mit den Pfeiltasten nach unten um das Angebot des Händlers zu sehen. Schalte das tutorial dann manuell weiter, damit du lernen kannst, wie mandieses Fenster bedient. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [94]
            {
               ["title"] = "Gegenstand begutachten",
               ["beginText"] = "Gehe auf einem beliebigen Gegenstand nach rechts in das Gegenstandsmenü. Du hörst dann die Menü-Überschrift. die Überschrift ist mit dem Wort (Text) markiert.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Text",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [95]
            {
               ["title"] = "Gegenstand weiter inspizieren",
               ["beginText"] = "Dieses Menü hat 3 Einträge. Die Überschrift, Den Gegenstand selbst und ganz unten den Preis. Auf dem Gegenstand kannst du den Tooltip wie gewohnt mit (Umschalttaste) und (Pfeil runter) lesen). Versuche das.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Gegenstandsstufe",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [96]
            {
               ["title"] = "Kaufen",
               ["beginText"] = "Du befindest dich also auf dem Gegenstand. hier kannst du das Gegenstandsmenü (so wie in den Taschen auch) erreichen, indem du nach rechts gehst. Dort findest du verschiedene Optionen die du dir ansehen solltest.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 5,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "kaufen",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [97]
            {
               ["title"] = "lieber doch nicht kaufen",
               ["beginText"] = "Auf Kaufen kannst du nach rechts gehen, die Menge wählen und Enter drücken. Dann wird der Einkauf getätigt, wenn du genug Kupfer hast. unter (Kaufen) findest du (linksklick) und (Rechtsklick). (Rechtsklick) hat eine wichtige funktion. Damit kaufst du einen einzigen Gegenstand. Du möchtest jedoch sparsam sein. Du brauchst all dein Kupfer, um dir beim Klassenlehrer neue Fähigkeiten beibringen zu lassen. Schließe deshalb das Fenster nun mit (Escape). ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 28,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [98]
            {
               ["title"] = "Aufbruch zum Klassenlehrer.",
               ["beginText"] = "Du solltest nun genug Kupfer haben, um beim Klassenlehrer neue 'Fähigkeiten zu erlernen. Wenn du mehr Kupfer brauchst, kannst du einfach Gegner töten und die Beute bei einem Händler verkaufen. Später erlernst du, wie du zu mehr Kupfer, Silber und auch Gold kommst. Zunächst solltest du deinen Klassenlehrer aufsuchen. Eine der zwei Quests, die du angenommen hast, führt dich zu ihm. Öffne dein Questbuch mit (L).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [99]
            {
               ["title"] = "In Ebene 1 die Klassenquest finden.",
               ["beginText"] = "Gehe nach rechts in die erste Ebene. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du (Krieger) findest.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Krieger",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [100]
            {
               ["title"] = "Navigation über die Kriegerquest zum Lehrer.",
               ["beginText"] = "Gehe nach Rechts auf die Quest. Lese sie gern nochmal indem du die Tooltip-Funktion benutzt. Drücke dafür wie gewohnt (Umschalttaste) und (Pfeil runter). Wenn du die Quest gelesen hast, gehe nach rechts in das Quest-Navigationsmenü.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Annahme",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [101]
            {
               ["title"] = "Pre Quest erklären",
               ["beginText"] = "Was bedeutet eigentlich (Pre Quest). In diesem Menü kannst du sehen, welche vorherigen Quests du erledigt hast, um diese Quest zu erhalten. Das wird später im Spiel noch wichtig.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [102]
            {
               ["title"] = "Zielnavigation Klassenlehrer",
               ["beginText"] = "Du hast die Quest bereits angenommen. Du möchtest sie beim Kriegerlehrer abgeben. Gehe also nach unten bis auf (Abgabe) und dann mehrmals nach rechts, bis du den Wegpunkt mit Entfernungsangabe hörst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [103]
            {
               ["title"] = "zum lehrer laufen",
               ["beginText"] = "Starte die Rute wie gewohnt mit Enter und laufe nun den wegpunkten nach bis zum Lehrer.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8904.8;-159.2;5",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [104]
            {
               ["title"] = "Hinweis nah weit",
               ["beginText"] = "Wenn das Addon bei einem Wegpunkt (nah) sagt, bedeutet das, du solltest sehr genau laufen. Sagt das Addon (weit), dann kannst du wieder normal laufen. Es handelt sich dabei oft um Engstellen, Rampen oder ähnliche Gegebenheiten. Laufe nun bis zum Lehrer.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = "-8917.4;-205.9;10",
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [105]
            {
               ["title"] = "Stecken bleiben und so",
               ["beginText"] = "Manchmal hörst du ein Piepen. Das bedeutet, dass du läufst, deine Figur sich aber nicht bewegt. Dies ist der einzige Hinweis für dich, ob du die Rute gut triffst oder ob du am Türrahmen hängengeblieben bist. Gebe nicht auf. du kannst den Wegpunkt auch zum vorherigen Wegpunkt zurückwechseln, indem du (Steuerung) (Umschalttaste) und (S) drückst. Wenn du den vorherigen WEgpunkt dann wieder erreicht hast, kannst du neu Zielen und es neu versuchen. Mit der Leertaste kannst du springen und so über Hindernisse hüpfen, an denen du möglicherweise hängenbleibst. Schalte das Menü manuell weiter, wenn du angekommen bist. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [106]
            {
               ["title"] = "Kriegerlehrer anvisieren und ansprechen",
               ["beginText"] = "nehme deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das dialogfenster zu öffnen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Kriegerlehrer",
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [107]
            {
               ["title"] = "Das Lehrerfenster",
               ["beginText"] = "Im Dialogfenster findest du den Menüpunkt (Ich benötige eine Kriegerausbildung) und die angenommene Quest. Wähle zuerst die angenommene Quest aus, indem du auf sie gehst, dann nach rechts und dann bei dem Menüeintrag (Linksklick) Enter drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 9,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [108]
            {
               ["title"] = "Diese Quest abgeben",
               ["beginText"] = "Dir ist bekannt, wie eine Quest abgegeben wird. Falls du mal eine Quest abgeben möchtest und ein lauter (Dong) Ton ist zu hören, bedeutet das folgendes. du musst eine Questbelohnung wählen, bevor du die quest abgeben kannst. Hier in diesem Fall ist aber alles wie gewohnt. Suche also entweder die (Abgeben) Schaltfläche oder drücke einfach Leertaste.",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 71,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = "weiter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [109]
            {
               ["title"] = "ein zwischenschritt",
               ["beginText"] = "Oh, es ist doch nicht ganz, wie gewohnt. die Questabgabe hat hier einen Zwischenschritt. Der NPC Empfängt dich mit einem dialog und dir wird gezeigt, was du brauchst, um die quest abzugeben. Nur wenn du die Quest wirklich erledigt hast, dann geht es weiter. Im nächsten Fenster kannst du dann auf Abschließen gehen. Tue das oder drücke nochmal Leertaste. ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 61,
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [110]
            {
               ["title"] = "zur Ausbildung",
               ["beginText"] = "",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
               },
            }, -- [111]
            {
               ["title"] = "Fenster wurde geschlossen",
               ["beginText"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 6,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [112]
            {
               ["title"] = "Ins Trainerfenster gelangen",
               ["beginText"] = "Wähle nun (Ich benötige eine Kriegerausbildung). Das Lehrerfenster wird sich dann öffnen.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 7,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [113]
            {
               ["title"] = "Das Fenster erklären",
               ["beginText"] = "Gehe einmal nach rechts, um in das Lehrerfenster zu gelangen. dieses Fenster ist in zwei Teilbereiche aufgeteilt. Oben findest du Kategorien mit erlernbaren Fähigkeiten. Weiter unten findest du die ausgewählte Fähigkeit mit dem Hinweis (Text) davor. auf diesem Objekt kannst du mit (Umschalttaste) und (Pfeil runter) die Details der Fähigkeit lesen. Tue das jetzt.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = 7,
                     ["type"] = "PANEL_OPEN",
                  }, -- [3]
               },
            }, -- [114]
            {
               ["title"] = "Ausbilden",
               ["beginText"] = "Falls du genug Kupfer mitgebracht hast, dann kannst du diese Fähigkeit nun erlernen. Gehe dafür nach unten auf (Ausbilden) und bestätige die Schaltfläche wie gewohnt mit dem Untermenü (Linksklick). Schließe dann das Lehrerfenster mit Escape.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 28,
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [115]
            {
               ["title"] = "Fähigkeit in die Leiste bringen",
               ["beginText"] = "Wenn du die neue Fähigkeit benutzen möchtest, musst du sie auf die Aktionsleiste legen. öffne das aktionsleistenmenü mit (umschalttaste) und (F 11).",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 1,
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [2]
                  {
                     ["value"] = 32,
                     ["type"] = "KEY_PRESS",
                  }, -- [3]
               },
            }, -- [116]
            {
               ["title"] = "Auf leiste gehen und Platz suchen",
               ["beginText"] = "Gehe einmal nach rechts auf die Leiste und dann runter auf einen Knopf, auf dem die neue Fähigkeit liegen soll. Gehe dann nach rechts in das untermenü für den Knopf.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "keine Aktion zuweisen",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["title"] = "knopf leer machen",
               ["beginText"] = "(keine Aktion festlegen) ist der menüpunkt, um diesen Button wieder leer zu machen. Man kann damit Aktionen von der Leiste runternehmen. Nach unten findest du verschiedene Kategorien. wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber und Fähigkeiten der Kategorie, welche auf den Button gelegt werden können. Suche nach dem Schlachtruf.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "Schlachtruf",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [118]
            {
               ["title"] = "Schlachtruf lesen und dann auf die Leiste legen",
               ["beginText"] = "Super! du hast den Schlachtruf gefunden. Du kannst die Details der Fähigkeit auch hier mit (Umschalttaste) und (Pfeil runter) lesen. Lege den Schlachtruf nun auf den button indem du Enter drückst.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 27,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [119]
            {
               ["title"] = "Menü schließen und Questdatenbank öffnen",
               ["beginText"] = "Schließe das Menü der Aktionsleisten nun und öffne dein Questbuch mit (L)",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [120]
            {
               ["title"] = "auf nahe quests bewegen",
               ["beginText"] = "Du stehst nun im Questbuch auf der ersten Position. Du weißt bereits, dass du nach rechts gehen kannst um deine Quests zu sehen. Gehe jetzt einmal nach unten, um die Datenbank zu nutzen.  ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = 25,
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = "Questdatenbank",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [121]
            {
               ["title"] = "Einfach halten",
               ["beginText"] = "Hier hast du diverse Möglichkeiten, um Recherche zu betreiben. Halte es vorerst aber simpel und gehe drei mal nach rechts.",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "meter",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [122]
            {
               ["title"] = "Übersicht der verfügbaren quests",
               ["beginText"] = "In dieser Liste findest du alle Quests, welche für dich in deiner Umgebung verfügbar sind. Mit der Tooltip-Funktion (Wie immer Umschalt Pfeil runter) kannst du eine Kurzinfo zur Quest abrufen. Wenn du nach rechts gehst, bist du wieder auf der Navigationsebene. Tue das.",
               ["allTriggersRequired"] = false,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = "pre quest",
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = "annahme",
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [123]
            {
               ["title"] = "neue Aufgaben finden",
               ["beginText"] = "Du bist wieder in der gewohnten Navigationsebene mit (Pre quest) (annahme) (ziel) und (abgabe). Da du diese Quest noch nicht hast und ja genau deshalb in der Datenbank suchst, musst du diesmal auf (Annahme) nach rechts gehen. Ganz am Ende wird dir der Questgeber mit einer Entfernungsangabe genannt. mit Enter kannst du eine Rute starten und dir die Quest schnappen. Schalte das Tutorial nun manuell weiter ",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = 1,
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [124]
            {
               ["title"] = "Herzlichen Glückwunsch",
               ["beginText"] = "Herzichen Glückwunsch! du bist bereit, dich ins Abenteuer zu stürzen. Viel Spaß!",
               ["allTriggersRequired"] = true,
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
               },
            }, -- [125]
         },
      },
   },
}
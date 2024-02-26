local L = Sku.L
SkuDB.AllLangs = {
   prefix = "Sku",
   ["Tutorials"] = {
      ["168388788465100001"] = {
         ["GUID"] = "168388788465100001",
         ["steps"] = {
            {
               ["GUID"] = "1683887948128850002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "1683887948128850003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "1683887948128850004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "1683887948128850005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "1683887948128850006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "1683887948128850007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "1683887948128850008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "1683887948128850009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "1683887948128850010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050033",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "1683887948128850011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050034",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Button 1 Zorn",
                  ["enUS"] = "UNTRANSLATED:deDE:Button 1 Zorn",
               },
               ["GUID"] = "1683888135315920001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du befindest dich jetzt auf Button 1. Dieser button entspricht der Taste (Eins) über dem Buchstaben (Q). Der button ist mit dem Zauber Zorn belegt. dies ist ein Zauber, mit dem du aus größerer Entfernung auf Gegner schießen kannst. Wenn du ihn wirkst, während du von einem Gegner geschlagen wirst, dann wird die Zauberzeit verlängert. Nutze ihn also vorrangig, bevor der Gegner zu dir gelaufen ist und dich schlägt. Betrachte die Details des Zaubers nun mit der Tooltipfunktion. Halte also die (Umschalttaste) fest und drücke zum lesen der Zeilen (Pfeil runter)",
                  ["enUS"] = "You are now on button 1. this button corresponds to the button (one) above the letter (Q). The button is assigned with the spell Wrath. this is a spell that allows you to shoot enemies from a greater distance. If you cast it while being hit by an enemy, the spell time will be extended. So use it before the enemy has moved to you and hit you. Now see the details of the spell with the tooltip feature. So hold the (shift) key and press (down arrow) to read the lines.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 25,
                        ["deDE"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["enUS"] = "5,4,1,1",
                        ["deDE"] = "5,4,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [11]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Button 2 druide",
                  ["enUS"] = "UNTRANSLATED:deDE:Button 2 druide",
               },
               ["GUID"] = "1683888545725940002",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Mit (Pfeil runter) kannst du auf button 2 gelangen. Dort findest du den Zauber (Heilende Berührung. Dieser Zauber ist ein Heilzauber. Auch dieser hat eine Zauberzeit, welche verlängert wird, wenn dich ein Gegner schlägt. Drücke Pfeil runter um auf button 2 zu gelangen und lese auch die Details von Heilende Berührung mit der tooltipfunktion",
                  ["enUS"] = "With (down arrow) you can get to button 2. There you will find the spell (Healing Touch). This spell is a healing spell. It also has a casting time, which is extended whenever an enemy hits you. Press down arrow to get to button 2 and also read the details of Healing Touch with the tooltip feature.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 25,
                        ["deDE"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["enUS"] = "5,4,1,2",
                        ["deDE"] = "5,4,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [12]
            {
               ["GUID"] = "1683887948128850015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050037",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "1683887948128850016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050010",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "1683887948128850017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050011",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "1683887948128850018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050012",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "1683887948128850019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050013",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "1683887948128850020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050014",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "1683887948128850021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050015",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "1683887948128850022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050016",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "1683887948128850023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050017",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "1683887948128850024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050018",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "1683887948128850025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050019",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "1683887948128850026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050020",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "1683887948128850027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050021",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "1683887948128850028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050022",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "1683887948128850029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050043",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "1683887948128850030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050044",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "1683887948128850031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050045",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "1683887948128850032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050046",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "1683887948128850033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050047",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "1683887948128850034",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Angriff",
                  ["enUS"] = "UNTRANSLATED:deDE:Angriff",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist einer der gesuchten Gegner. Du hast verschiedene Möglichkeiten um anzugreifen. Die Taste (G) lässt dich mit dem Ziel interagieren. Das bedeutet bei einem angreifbaren Ziel, du greifst an. Du kannst die Taste (G) auch nutzen, um dich vor dem zaubern zum Gegner zu drehen. Dafür drückst du (G) und sofort danach (S). Dadurch macht deine Figur einen Schritt auf den Gegner zu und bleibt dann ausgerichtet zum Gegner stehen. Wenn du (S) nicht drückst, läuft deine Figur zum Gegner und schlägt ihn mit dem Stock.  Da sich die Gegner auch bewegen, ist es im nahkampf ratsam, entweder ein paar wenige Schritte rückwärts zu machen, wenn der Kampf läuft oder nochmal (G) zu drücken. Das verhindert, dass der Gegner hinter dir steht. Am besten ist es, wenn du dich ausrichtest und dann solange auf (Eins) für (Zorn) drückst, bis der Gegner bei dir ist und dich schlägt. Dann mache einfach nichts. Deine Figur schlägt den Gegner dann solang automatisch mit dem Stock, bis du ihn besiegt hast.",
                  ["enUS"] = "This is one of the enemies you are looking for. You have several ways to attack. The key (G) lets you interact with the target. This means with an attackable target, you attack. You can also use the (G) key to turn around to the enemy before casting the spell. To do this, press (G) and then immediately press (S). This will make your character take a step towards the enemy and then stop while facing the enemy. If you don't press (S), your character will move towards the enemy and hit him with the staff.  Since enemies also move, in close combat it is advisable to either take a few steps backwards when the fight is in progress or press (G) again. This will prevent the enemy from standing behind you. It is best to align yourself and then press (One) for (Wrath) until the enemy is with you and hits you. Then just do nothing. Your character will then automatically hit the enemy with the stick until you defeat him.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [32]
            {
               ["GUID"] = "1683887948128850035",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050049",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Heilen erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Heilen erklären",
               },
               ["GUID"] = "1683890845967220001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf Taste 2 hast du den zauber (Heilende Berührung). Damit kannst du dich und andere Spieler heilen. Wenn du nichts oder einen Gegner im ziel hast, wird die Heilung automatisch auf dich selbst gewirkt. Wenn du einen anderen spieler im Ziel hast, heilst du den anderen Spieler. Gruppenmitglieder kannst du mit dem Nummernblock anwählen. Nummernblock Eins bist du selbst und die weiteren Zahlen bis nummernblock 5 sind die anderen Gruppenmitglieder. Schalte das tutorial nun manuell weiter.",
                  ["enUS"] = "On key 2 you have the spell (Healing Touch). With this you can heal yourself and other players. If you don't have a target or an enemy target, the healing is automatically cast on yourself. If you are targeting another player, you will heal the other player. Party members can be selected with the numpad. Numpad one is you and the numbers up to numpad 5 are the other party members. Continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [34]
            {
               ["GUID"] = "1683887948128850036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050050",
               },
               ["linkedIn"] = {
               },
            }, -- [35]
            {
               ["GUID"] = "1683887948128850037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050053",
               },
               ["linkedIn"] = {
               },
            }, -- [36]
            {
               ["GUID"] = "1683887948128850038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050054",
               },
               ["linkedIn"] = {
               },
            }, -- [37]
            {
               ["GUID"] = "1683887948128850039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050055",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "1683887948128850040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050056",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "1683887948128850041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "16837256168152870001",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "1683887948128850042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "1683802070358370001",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "1683887948128850043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "1683802230518200002",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "1683887948128850044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "1683802509797260003",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "1683887948128850045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "1683802670957730004",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "1683887948128850046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050057",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "1683887948128850047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978050058",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "1683887948128850048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060059",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "1683887948128850049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060060",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "1683887948128850050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060061",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "1683887948128850051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060062",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "1683887948128850052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060063",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "1683887948128850053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060064",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "1683887948128850054",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060065",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "1683887948128850055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060066",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "1683887948128850056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060067",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "1683887948128850057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060069",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["GUID"] = "1683887948128850058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168373127713814160001",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "1683887948128850059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168373155214089040002",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "1683887948128850060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060070",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "1683887948128850061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060071",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "1683887948128850062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060072",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "1683887948128850063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060073",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "1683887948128850064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060074",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "1683887948128850065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060076",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "1683887948128850066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060077",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "1683887948128850067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060078",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "1683887948128850068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060079",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "1683887948128850069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060080",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "1683887948128850070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060081",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "1683887948128850071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060082",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "1683887948128850072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060083",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "1683887948128850073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060084",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "1683887948128850074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060085",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "1683887948128850075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060086",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "1683887948128850076",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du (Stoffrüstung) und (Lederrüstung) tragen. Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As %class% you can wear (cloth armor) and (leather armor). You probably want to see what equipment you are currently wearing. To do so, go to (equipment) to the right to (items) and then to the right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [75]
            {
               ["GUID"] = "1683887948128850077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060088",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "1683887948128850078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060089",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "1683887948128850079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060090",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "1683887948128850080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060091",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "1683887948128850081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060092",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "1683887948128850082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060093",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "1683887948128850083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060094",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "1683887948128850084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060095",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "1683887948128850085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060096",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "1683887948128850086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060097",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "1683887948128850087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060098",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "1683887948128850088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060099",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["GUID"] = "1683887948128850089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060100",
               },
               ["linkedIn"] = {
               },
            }, -- [88]
            {
               ["GUID"] = "1683887948128850090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060101",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "1683887948128850091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060102",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "1683887948128850092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060103",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "1683887948128850093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060104",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "1683887948128850094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060105",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "1683887948128850095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060106",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "1683887948128850096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060107",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "1683887948128850097",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach (rechts) in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf Druide befindest.",
                  ["enUS"] = "Go to (right) to the first submenu. You already know that the quests are sorted by region or category. Then go down from (All) until you find Druid.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "druid",
                        ["deDE"] = "Druide",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [96]
            {
               ["GUID"] = "1683887948128850098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060109",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "1683887948128850099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060110",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "1683887948128850100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060111",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "1683887948128850101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060112",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "1683887948128850102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060113",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "1683887948128850103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060114",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "1683887948128850104",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now move along the waypoints until you reach the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "10465.0;829.0;5",
                        ["deDE"] = "10465.0;829.0;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [103]
            {
               ["GUID"] = "1683887948128850105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060116",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "1683887948128850106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060117",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "1683887948128850107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060118",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "1683887948128860108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060119",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "1683887948128860109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060120",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["GUID"] = "1683887948128860110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060121",
               },
               ["linkedIn"] = {
               },
            }, -- [109]
            {
               ["GUID"] = "1683887948128860111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060122",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "1683887948128860112",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Zuerst findest du jeweils die Kategorie und darunter den Zauber. für dich hat dieser Lehrer in der Kategorie (Wiederherstellung) den Zauber (Mal der Wildnis). Der Zauber ist bereits ausgewählt. Weiter unten wiederholt sich der Zaubername (Mal der wildnis). Davor wird (text) angesagt. Das ist der (Button) für den Zauber, der ausgewählt ist. Suche nun diesen button.",
                  ["enUS"] = "This is the trainer dialog box. First, you will find the category for each, and below that, the spell. for you, this trainer has the spell (Mark of the Wild) in the (Restoration) category. The spell is already selected. Further down, the spell name is repeated (Mark of the Wild). Before that (text) is pronounced. This is the (button) for the spell that is selected. Now find this button.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [111]
            {
               ["GUID"] = "1683887948128860113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060124",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "1683887948128860114",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060125",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "1683887948128860115",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060126",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "1683887948128860116",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060127",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["GUID"] = "1683887948128860117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060128",
               },
               ["linkedIn"] = {
               },
            }, -- [116]
            {
               ["GUID"] = "1683887948128860118",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche den zauber (Mal der wildnis)",
                  ["enUS"] = "(Do not assign action) is the menu item to remove an assigned action from the button. Under the menu item you can find different categories. If you go to the right on a category, you will find the spells of the category that can be assigned to the button. Find the spell (Mark of the Wild)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "Mark of the Wild",
                        ["deDE"] = "Mal der Wildnis",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["GUID"] = "1683887948128860119",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060130",
               },
               ["linkedIn"] = {
               },
            }, -- [118]
            {
               ["GUID"] = "1683887948128860120",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060131",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["GUID"] = "1683887948128860121",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060132",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["GUID"] = "1683887948128860122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060133",
               },
               ["linkedIn"] = {
               },
            }, -- [121]
            {
               ["GUID"] = "1683887948128860123",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060134",
               },
               ["linkedIn"] = {
               },
            }, -- [122]
            {
               ["GUID"] = "1683887948128860124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060135",
               },
               ["linkedIn"] = {
               },
            }, -- [123]
            {
               ["GUID"] = "1683887948128860125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060136",
               },
               ["linkedIn"] = {
               },
            }, -- [124]
            {
               ["GUID"] = "1683887948128860126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060137",
               },
               ["linkedIn"] = {
               },
            }, -- [125]
            {
               ["GUID"] = "1683887948128860127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060138",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "1683887948128860128",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060139",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "1683887948128860129",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060140",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["GUID"] = "1683887948128860130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060141",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["GUID"] = "1683887948128860131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168370330453520001",
                  ["SourceTutorialStepGUID"] = "168370332978060142",
               },
               ["linkedIn"] = {
               },
            }, -- [130]
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Nachtelf Druide eins",
            ["enUS"] = "Night elf druid one",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["lockKeyboard"] = true,
         ["playFtuIntro"] = true,
         ["requirements"] = {
            ["race"] = 4,
            ["skill"] = 999,
            ["class"] = 11,
         },
      },
      ["168113131451930001"] = {
         ["lockKeyboard"] = true,
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 8,
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Magier 1",
            ["enUS"] = "Human Mage 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["playFtuIntro"] = true,
         ["GUID"] = "168113131451930001",
         ["steps"] = {
            {
               ["GUID"] = "16811365965003560001",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "16811365965003560002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "16811365965003560003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "16811365965003560004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "16811365965003560005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "16811365965003560006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "16811365965003560007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "16811365965003560008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "16811365965003560009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "16811365965003560010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "16811365965003560011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "16811365965003560012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "16811365965003560013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "16811365965003560014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "16811365965003560015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "16811365965003560016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "16811365965003560017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837016421612550003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "16811365965003560018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "16811365965003560019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "16811365965003560020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "16811365965003560021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "16811365965003560022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "16811365965003560023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "16811365965003560024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "16811365965003560025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "16811365965003560026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "16811365965003560027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "16811365965003560028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "16811365965003560029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "16811365965003560030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "16811365965003560031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "16811365965003560032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["GUID"] = "16811373645771830001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Feuerball Details",
                  ["enUS"] = "UNTRANSLATED:deDE:Feuerball Details",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier auf button 1 liegt der zauber (Feuerball). Es handelt sich um einen Zauber, den du wirken kannst, wenn du nicht läufst. Wirken bedeutet, er hat eine Zauberzeit. Wenn du ihn vollständig gezaubert hast, erhält dein Gegner Schaden. Wenn du während des wirkens Schaden erhällst, wird die Zauberzeit jedesmal verlängert. Versuche also zu zaubern, wenn der Gegner noch weit entfernt ist, sodass dieser erst zu dir laufen muss. lese die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "Here on button 1 is the spell (Fireball). It is a spell that you can cast when you are not moving. It has a casting time. When you finish casting it, your enemy will take damage. If you receive damage while casting it, the cast time will be extended. So try to cast it when the enemy is still far away and has to move to you first. Read the details with the tooltip feature (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [34]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Auf Button 2 wechseln",
                  ["enUS"] = "UNTRANSLATED:deDE:Auf Button 2 wechseln",
               },
               ["GUID"] = "16811365965003560033",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe mit (Pfeil runter) auf Button 2.",
                  ["enUS"] = "Go to button 2 with (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1,2",
                        ["enUS"] = "5,4,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [35]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit Button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
               },
               ["GUID"] = "16811365965003560034",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf button 2 befindet sich der Zauber (Frostrüstung). Lies auch hier die Details mit der Tooltipfunktion. Drücke (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "On button 2 you will find the spell (Frost Armor). Read the details with the tooltip feature. Press (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [36]
            {
               ["GUID"] = "16811365965003560035",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [37]
            {
               ["GUID"] = "16811365965003560036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "16811365965003560037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "16811365965003560038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "16811365965003560039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "16811365965003560040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "16811365965003560041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "16811365965003560042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "16811365965003560043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "16811365965003560044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "16811365965003560045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "16811494086456060006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900048",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "16811365965003560047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "16811365965003560048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "16811365965003560049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "16811495036551100007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900052",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "16811365965003560051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "16811365965003560052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "16811496716718650008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900055",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "16811365965003560054",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["GUID"] = "16811365965003560055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "16811365965003560056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "16811365965003560057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "16811365965003560058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "16811365965003560059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "16811365965003560060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "16811365965003560061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "16811365965003560062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "16811365965003560063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "16811365965003560064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "16811365965003560065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "16811365965003560066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "16811365965003560067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "16811365965003560068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "16811365965003560069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "16811365965003560070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "16811365965003560071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "16811365965003560072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "16811365965003560073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "16811365965003560074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "16811365965003560075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "16811365965003560076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "16811365965003560077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "16811365965003560078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "16811365965003560079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "16811365965003560080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "16811365965003560081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "16811365965003560082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "16811365965003560083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "16811365965003560084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["GUID"] = "16811365965003560085",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du nur (Stoffrüstung) tragen. Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As %class% you can only wear cloth armor. You will probably want to see what equipment you are currently wearing. To do so, go to (Equipment) and right to (Items) and then to the right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [87]
            {
               ["GUID"] = "16811365965003560086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [88]
            {
               ["GUID"] = "16811365965003560087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "16811365965003560088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "16811365965003560089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "16811365965003560090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "16811365965003560091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "16811365965003560092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "16811365965003560093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "16811365965003560094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "16811365965003560095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "16811365965003560096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "16811365965003560097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "16811365965003560098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "16811365965003560099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "16811365965003560100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "16811365965003560101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "16811365965003560102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "16811365965003560103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "16811365965003560104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "16811365965003560105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["GUID"] = "16811365965003560106",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach rechts in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf Magier befindest.",
                  ["enUS"] = "Go right. You already know that the quests there are sorted by region or category. Then go down from (All) until you find (Mage).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Magier",
                        ["enUS"] = "Mage",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [108]
            {
               ["GUID"] = "16811365965003560107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [109]
            {
               ["GUID"] = "16811365965003560108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "16811365965003560109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "16811365965003560110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "16811365965003560111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "16811365965003560112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["GUID"] = "16811365965003560113",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now follow the waypoints to the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8852.4;-187.1;5",
                        ["enUS"] = "-8852.4;-187.1;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [115]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Magierlehrer anvisieren und ansprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Magierlehrer anvisieren und ansprechen",
               },
               ["GUID"] = "16811365965003560114",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nimm deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "198",
                        ["enUS"] = "198",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [116]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["GUID"] = "16811365965003560115",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Ich bin an einer Magierausbildung interessiert) und die angenommene Quest. Wähle zuerst die angenommene Quest aus, indem du nach rechts gehst und im untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
                  ["enUS"] = "In the dialog pane you will find the menu item (I am interested in mage training) and the accepted quest. First select the accepted quest. You can do that by going to the right and confirming with (enter) in the submenu (left click). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [117]
            {
               ["GUID"] = "16811365965003560116",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [118]
            {
               ["GUID"] = "16811365965003560117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["GUID"] = "16811365965003560118",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
                  ["enUS"] = "Here the dialog closed automatically after the quest was completed. Interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "198",
                        ["enUS"] = "198",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [120]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["GUID"] = "16811365965003560119",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Ich bin an einer Magierausbildung interessiert), um das Lehrerfenster zu öffnen.",
                  ["enUS"] = "Now select (I am interested in mage training). The trainer dialog box will open.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [121]
            {
               ["GUID"] = "16811365965003560120",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [122]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["GUID"] = "16811365965003560121",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Die momentan für dich erlernbaren Zauber werden hier in einer Liste angezeigt, die in Kategorien sortiert ist. Dieser Lehrer bietet dir in der Kategorie (Arkan) den Zauber (Arkane Intelligenz) an. Dieser Zauber ist bereits ausgewählt. Weiter unten findest du erneut (Arkane Intelligenz). Davor wird (Text) angesagt. Das ist der Menüpunkt für den Zauber, der momentan ausgewählt ist. Suche jetzt diesen Menüpunkt. ",
                  ["enUS"] = "This is the trainer dialog box. First you will find the category and below that the spell. For you, this trainer has the ability (Arcane Intellect) in the category (Arcane). The ability is already selected. Further down, (Arcane Intellect) is repeated. Before that, (text) is pronounced. This is the button for the ability that is selected. Find that entry.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [123]
            {
               ["GUID"] = "16811365965003560122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
               },
            }, -- [124]
            {
               ["GUID"] = "16811365965003560123",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
               },
            }, -- [125]
            {
               ["GUID"] = "16811365965003560124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "16811365965003560125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "16811365965003560126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["GUID"] = "16811365965003560127",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nach (Arkane Intelligenz).",
                  ["enUS"] = "(Assign no action) is the menu item to make this button empty again. You can use it to remove actions from the bar. Down you will find different categories. If you go to the right on a category, you will find the spells and abilities of the category, which can be place on the button. Search for the spell (Arcane Intellect).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Intelligenz",
                        ["enUS"] = "Intellect",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [129]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["GUID"] = "16811365965003560128",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! du hast den Zauber (Arkane Intelligenz) gefunden. Du kannst die Details des Zaubers auch hier mit der Tooltipfunktion lesen. Lege den Zauber (Arkane Intelligenz) nun auf den button, indem du die (Eingabetaste) drückst. Schließe das Aktionsleistenmenü dann mit (Escape).",
                  ["enUS"] = "Great! You have found the spell (Arcane Intellect). You can also read the details of the ability here with the tooltip feature. Now place the spell (Arcane Intellect) on the button by pressing (Enter). Then close the action bar menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [130]
            {
               ["GUID"] = "16811365965003560129",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [131]
            {
               ["GUID"] = "16811365965003560130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [132]
            {
               ["GUID"] = "16811365965003560131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [133]
            {
               ["GUID"] = "16811365965003560132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [134]
            {
               ["GUID"] = "16811365965003560133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [135]
            {
               ["GUID"] = "16811365965003560134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [136]
            {
               ["GUID"] = "16811365965003560135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "16811365965003560136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [138]
            {
               ["GUID"] = "16811365965003560137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "16811365965003560138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "16811365965003560139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
            {
               ["GUID"] = "16811365965003560140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [142]
         },
      },
      ["168111678387860001"] = {
         ["lockKeyboard"] = true,
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 2,
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Paladin 1",
            ["enUS"] = "Human Paladin 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["playFtuIntro"] = true,
         ["GUID"] = "168111678387860001",
         ["steps"] = {
            {
               ["GUID"] = "1681116816120390002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "1681116816120390003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "1681116816120390004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "1681116816120390005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "1681116816120390006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "1681116816120390007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "1681116816120390008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "1681116816120390009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "1681116816120390010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "1681116816120390011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "1681116816120390012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "1681116816120390013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "1681116816120390014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "1681116816120390015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "1681116816120390016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "1681116816120390017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "1681116816120390018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837016761646800004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "1681116816120390019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "1681116816120390020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "1681116816120390021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "1681116816120390022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "1681116816120390023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "1681116816120390024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "1681116816120390025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "1681116816120390026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "1681116816120390027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "1681116816120390028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "1681116816120400029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "1681116816120400030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "1681116816120400031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "1681116816120400032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "1681116816120400033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["GUID"] = "1681116816120400034",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490034",
               },
               ["linkedIn"] = {
               },
            }, -- [34]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit Button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
               },
               ["GUID"] = "1681116816120400035",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf Button 2 findest du die Fähigkeit (Siegel der Rechtschaffenheit). Dies ist ein Stärkungszauber, den du alle 30 Minuten auf dich selbst wirken kannst. Einen Stärkungszauber nennt man auch Buff. Lese die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "On button 2 you will find the ability (Seal of Righteousness). This is a helpful spell that you should cast on yourself every 30 minutes. Helpful spells are called (Buffs). Read the details using the tooltip feature (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [35]
            {
               ["GUID"] = "16811195482852830001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit auf Button 3",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit auf Button 3",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Mit Pfeil runter gelangst du auf Button drei. Dort findest du die Fähigkeit (Heiliges Licht). Das ist ein Heilzauber. Lese die Details mit der Tooltipfunktion. ",
                  ["enUS"] = "Use down arrow to get to button number three. There you will find the ability (Holy Light). This is a healing spell. Read the details with the tooltip feature. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "Reichweite",
                        ["enUS"] = "Range",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [36]
            {
               ["GUID"] = "16811201863490990002",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Heilzauber Zielfunktion erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Heilzauber Zielfunktion erklären",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Einen Heilzauber wirkst du natürlich auf dich selbst, wenn du dich selbst im Ziel hast. Wenn du aber ein feindliches Ziel oder gar kein Ziel hast bist du auch automatisch das Ziel. Das bedeutet, dass du im Kampf einfach nur den Button drücken musst, um dich selbst zu heilen. Wenn du ein freundliches Ziel hast, heilst du dieses freundliche Ziel wie beispielsweise ein Gruppenmitglied. Schalte jetzt manuell weiter.",
                  ["enUS"] = "If you are targeting yourself, you will cast all healing spells on yourself. However, if you have are targeting an enemy or have no target at all, you are automatically the target of all healing spells. This means that in combat you just have to press the button to heal yourself. If you have a friendly target, you heal that friendly target, such as a party member. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [37]
            {
               ["GUID"] = "1681116816120400036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "1681116816120400037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "1681116816120400038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "1681116816120400039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "1681116816120400040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "1681116816120400041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "1681116816120400042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "1681116816120400043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "1681116816120400044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "1681116816120400045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "1681116816120400046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "1681116816120400047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490047",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "1681116816120400048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "1681116816120400049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "1681116816120400050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "1681116816120400051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490051",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "1681116816120400052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "1681116816120400053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "16811500887135480012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900055",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["GUID"] = "1681116816120400055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "1681116816120400056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "1681116816120400057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "1681116816120400058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "1681116816120400059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "1681116816120400060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "1681116816120400061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "1681116816120400062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "1681116816120400063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "1681116816120400064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "1681116816120400065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "1681116816120400066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "1681116816120400067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "1681116816120400068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "1681116816120400069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "1681116816120400070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "1681116816120400071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "1681116816120400072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "1681116816120400073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "1681116816120400074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "1681116816120400075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "1681116816120400076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "1681116816120400077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "1681116816120400078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "1681116816120400079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "1681116816120400080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "1681116816120400081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "1681116816120400082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "1681116816120400083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "1681116816120400084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "1681116816120400085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["GUID"] = "1681116816120400086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490086",
               },
               ["linkedIn"] = {
               },
            }, -- [88]
            {
               ["GUID"] = "1681116816120400087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "1681116816120400088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "1681116816120400089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "1681116816120400090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "1681116816120400091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "1681116816120400092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "1681116816120400093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "1681116816120400094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "1681116816120400095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "1681116816120400096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "1681116816120400097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "1681116816120400098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "1681116816120400099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "1681116816120400100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "1681116816120400101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "1681116816120400102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "1681116816120400103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "1681116816120400104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "1681116816120400105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "1681116816120400106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["GUID"] = "1681116816120400107",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach rechts in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf (Paladin) befindest.",
                  ["enUS"] = "Go right. You already know that the quests are sorted by region or category. Then go down from (All) until you find Paladin.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "paladin",
                        ["enUS"] = "paladin",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [109]
            {
               ["GUID"] = "1681116816120400108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "1681116816120400109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "1681116816120400110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "1681116816120400111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "1681116816120400112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "1681116816120400113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["GUID"] = "1681116816120400114",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den Wegpunkten nach bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now follow the waypoints until you reach the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8916.1;-212.6;5",
                        ["enUS"] = "-8916.1;-212.6;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [116]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Paladinlehrer ins Ziel nehmen",
                  ["enUS"] = "UNTRANSLATED:deDE:Paladinlehrer ins Ziel nehmen",
               },
               ["GUID"] = "1681116816120400115",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nimm deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das Dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog panel.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "925",
                        ["enUS"] = "925",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["GUID"] = "1681116816120400116",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Ich möchte weiter in den Wegen des Lichts unterwiesen werden) und die angenommene Quest. Wähle zuerst die angenommene Quest aus. Das machst du, indem du nach rechts gehst und im untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
                  ["enUS"] = "In the dialog panel you will find the menu item (I want to be instructed further in the path of light) and the accepted quest. First select the accepted quest. You can do this by going to the right and confirming with (enter) in the submenu (left click). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [118]
            {
               ["GUID"] = "1681116816120400117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["GUID"] = "1681116816120400118",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["GUID"] = "1681116816120400119",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
                  ["enUS"] = "Here the dialog closed automatically after the quest was completed. Interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "925",
                        ["enUS"] = "925",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [121]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["GUID"] = "1681116816120400120",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Ich möchte weiter in den Wegen des lichts unterwiesen werden), um das Lehrerfenster zu öffnen.",
                  ["enUS"] = "Now select (I want to be further instructed in the path of light). The trainer dialog box will open.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [122]
            {
               ["GUID"] = "1681116816120400121",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [123]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["GUID"] = "1681116816120400122",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Die momentan für dich erlernbaren Zauber werden hier in einer Liste angezeigt, die in Kategorien sortiert ist. Dieser Lehrer bietet dir in der Kategorie (Schutz) den Zauber (Aura der Hingabe) an. Dieser Zauber ist bereits ausgewählt. Weiter unten findest du erneut (Aura der Hingabe). Davor wird (Text) angesagt. Das ist der Menüpunkt für den Zauber, der momentan ausgewählt ist. Suche jetzt diesen Menüpunkt. ",
                  ["enUS"] = "This is the trainer dialog box. First you will find the category and below that the spell. For you, this trainer has the ability (Aura of Devotion) in the category (Protection). The ability is already selected. Further down (Devotion Aura) is repeated. Before that, (text) is pronounced. This is the button for the ability that is selected. Find that button.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [124]
            {
               ["GUID"] = "1681116816120400123",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
               },
            }, -- [125]
            {
               ["GUID"] = "1681116816120400124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "1681116816120400125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "1681116816120400126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["GUID"] = "1681116816120400127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["GUID"] = "1681116816120400128",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nach (Aura der Hingabe).",
                  ["enUS"] = "(Assign no action( is the menu item to make this button empty again. You can use it to remove actions from the bar. Down you will find different categories. If you go to the right on a category, you will find the spells and abilities of the category, which can be placed on the action button. Find Devotion Aura.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Schlachtruf",
                        ["enUS"] = "Battle Shout",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [130]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["GUID"] = "1681116816120400129",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! du hast die Aura der Hingabe gefunden. Du kannst die Details des Zaubers auch hier mit der Tooltipfunktion lesen. Lege die Aura der Hingabe nun auf den button indem du die (Eingabetaste) drückst. Mit dem Button kannst du dann die Aura aktivieren. Sie gibt dir und deinen Gruppenmitgliedern einen Stärkungszauber. Das aktivieren der Aura wird durch ein Zaubergeräusch untermalt. Nochmaliges drücken deaktiviert die Aura wieder. Schließe das Aktionsleistenmenü dann mit (Escape).",
                  ["enUS"] = "Great! You have found Devotion Aura. You can also read the details of the ability here with the tooltip feature. Now place Devotion Aura on the action button by pressing (Enter). With the action button you can activate the aura. It will give you and your party members a buff. The activation of the aura is emphasized by a spell sound. Pressing it again deactivates the aura. Close the action bar menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [131]
            {
               ["GUID"] = "1681116816120400130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [132]
            {
               ["GUID"] = "1681116816120400131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [133]
            {
               ["GUID"] = "1681116816120400132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [134]
            {
               ["GUID"] = "1681116816120400133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [135]
            {
               ["GUID"] = "1681116816120400134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [136]
            {
               ["GUID"] = "1681116816120400135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "1681116816120400136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [138]
            {
               ["GUID"] = "1681116816120400137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "1681116816120400138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "1681116816120400139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
            {
               ["GUID"] = "1681116816120400140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [142]
            {
               ["GUID"] = "1681116816120400141",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [143]
         },
      },
      ["16811221545459280001"] = {
         ["lockKeyboard"] = true,
         ["steps"] = {
            {
               ["GUID"] = "16811222675571670001",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "16811222675571670002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "16811222675571670003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "16811222675571670004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "16811222675571670005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "16811222675571670006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "16811222675571670007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "16811222675571670008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "16811222675571670009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "16811222675571670010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "16811222675571670011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "16811222675571670012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "16811222675571670013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "16811222675571670014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "16811222675571670015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "16811222675571670016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "16811222675571680017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837017261696420006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "16811222675571680018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "16811222675571680019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "16811222675571680020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "16811222675571680021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "16811222675571680022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "16811222675571680023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "16811222675571680024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "16811222675571680025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "16811222675571680026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "16811222675571680027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "16811222675571680028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "16811222675571680029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "16811222675571680030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "16811222675571680031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "16811222675571680032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["GUID"] = "16811222675571680033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490034",
               },
               ["linkedIn"] = {
               },
            }, -- [34]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit Button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
               },
               ["GUID"] = "16811222675571680034",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf Taste 2 befindet sich der (finstere Stoß). Er verbraucht Energie und gibt dir einen Kombopunkt. Lese die Details mit der Tooltipfunktion (umschalttaste) und (Pfeil runter) und gehe danach auf Button 3 mit (Pfeil runter).",
                  ["enUS"] = "On button 2 you will find (Sinister Strike). This requires energy and gives you a combo point. Read the details with the tooltip feature (Shift) and (down arrow) and then go to button 3 with down arrow.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [35]
            {
               ["GUID"] = "1681126369312010001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klassenfähigkeit auf Button 3",
                  ["enUS"] = "UNTRANSLATED:deDE:Klassenfähigkeit auf Button 3",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "hier auf button 3 befindet sich der Zauber (ausweiden). Dieser benötigt Energie und der Gegner muss mindestens einen Kombopunkt haben, dann kannst du ihn wirken. Lese die Details mit der Tooltipfunktion und gehe dann auf Button 4 mit (Pfeil runter).",
                  ["enUS"] = "Here on button 3 is the ability (Eviscerate). It requires energy and at least one combo point. Then you can use it. Read the details with the tooltip feature and then go to button 4 with (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [36]
            {
               ["GUID"] = "1681126492435460002",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klassenfähigkeit button 4",
                  ["enUS"] = "UNTRANSLATED:deDE:Klassenfähigkeit button 4",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Mit Taste 4 kannst du ein Messer werfen. Das macht den Gegner auf dich aufmerksam. Wenn er keinen Fernkampfangriff hat, kommt er zu dir und du kannst dann gegen ihn kämpfen. Das nennt man auch (Pullen). lese die Details mit der Tooltipfunktion und schalte das Tutorial dann weiter.",
                  ["enUS"] = "With button 4 you can throw a knife. This will draw the enemy's attention to you. If he doesn't have a ranged attack, he will move to you and you can then fight him. Read the details with the tooltip feature and then continue the tutorial.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [37]
            {
               ["GUID"] = "1681126693636100003",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Funktion der Klasse",
                  ["enUS"] = "UNTRANSLATED:deDE:Funktion der Klasse",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Die Klasse Schurke hat am Anfang eines Kampfes 100 energie. Sie wird durch deine Angriffe verbraucht. Die Energie füllt sich aber langsam wieder auf. Wenn du keine Energie mehr hast, musst du warten, bis sie sich wieder aufgefüllt hat, damit du einen weiteren Angriff ausführen kannst. Manche Zauber fügen einem Gegner Kombopunkte hinzu. Du kannst sie auf einem Gegner sammeln. Die Fähigkeiten, die Kombopunkte verbrauchen, löschen dann den Punktestand und wandeln ihn um. Du erfährst die Details jeweils im Zaubertooltip. Schalte nun weiter.",
                  ["enUS"] = "The Rogue class has 100 energy at the beginning of a fight. It is consumed by your attacks. However, the energy slowly replenishes. When you run out of energy, you have to wait for it to replenish so you can do another attack. Some abilities provide combo points. You can collect them per enemy. The abilities that consume combo points will take all existing combo points. You can find the details in the spell tooltip. Now continue the tutorial.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [38]
            {
               ["GUID"] = "16811222675571680035",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "16811222675571680036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "16811222675571680037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "16811222675571680038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "16811222675571680039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "16811222675571680040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "16811222675571680041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "16811222675571680042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "16811222675571680043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "16811222675571680044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "16811222675571680045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "16811222675571680046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490047",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "16811222675571680047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "16811222675571680048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "16811222675571680049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "16811222675571680050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490051",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "16811222675571680051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "16811222675571680052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erklärung der ansagen",
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung der ansagen",
               },
               ["GUID"] = "16811222675571680053",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Vergesse nicht mit (G) zu plündern, wenn du das Schmatzgeräusch gehört hast. Im Kampf hörst du viele Ansagen. Die Weibliche Stimme sagt in 10er Schritten, wieviel Prozent Leben der Gegner noch hat. Die Jungenstimme sagt einstellig in 10 Schritten dein Leben an. Das Mädchen sagt dir, wieviel Energie du hast. Wenn die Energieansage aktiv ist, kann das Mädchen sehr redseelig sein. Daran erkennst du, wie schnell sich Energie wieder auffüllt. Schalte das tutorial jetzt manuell weiter.",
                  ["enUS"] = "Don't forget to loot with (G) when you hear the smacking sound. In battle you will hear many outputs. The female voice tells in increments of 10 how many percent health the enemy has left. The boy's voice tells your health in in 10 steps. The girl voice tells you how much energy you have. When the energy announcement is active, the girl can be very talkative. This tells you how quickly energy is replenishing. Continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [57]
            {
               ["GUID"] = "16811222675571680054",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "16811222675571680055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "16811222675571680056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "16811222675571680057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "16811222675571680058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "16811222675571680059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "16811222675571680060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "16811222675571680061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "16811222675571680062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "16811222675571680063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "16811222675571680064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "16811222675571680065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "16811222675571680066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "16811222675571680067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "16811222675571680068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "16811222675571680069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "16811222675571680070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "16811222675571680071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "16811222675571680072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "16811222675571680073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "16811222675571680074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "16811222675571680075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "16811222675571680076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "16811222675571680077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "16811222675571680078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "16811222675571680079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "16811222675571680080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "16811222675571680081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "16811222675571680082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "16811222675571680083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["GUID"] = "16811222675571680084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [88]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["GUID"] = "16811222675571680085",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du (Stoffrüstung) und (Lederrüstung) tragen. Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As %class% you can wear cloth armor and leather armor. You might want to see what equipment you are currently wearing. To do so, on (Equipment) go to the right to (Items) and then to the right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [89]
            {
               ["GUID"] = "16811222675571680086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "16811222675571680087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "16811222675571680088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "16811222675571680089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "16811222675571680090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "16811222675571680091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "16811222675571680092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "16811222675571680093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "16811222675571680094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "16811222675571680095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "16811222675571680096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "16811222675571680097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "16811222675571680098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "16811222675571680099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "16811222675571680100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "16811222675571680101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "16811222675571680102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "16811222675571680103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "16811222675571680104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["GUID"] = "16811222675571680105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [109]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["GUID"] = "16811222675571680106",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach rechts in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf Schurke befindest.",
                  ["enUS"] = "Go right. You already know that the quests there are sorted by region or category. Go down from (All) until you find Rogue.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Schurke",
                        ["enUS"] = "Rogue",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [110]
            {
               ["GUID"] = "16811222675571680107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "16811222675571680108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "16811222675571680109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "16811222675571680110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "16811222675571680111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["GUID"] = "16811222675571680112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [116]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["GUID"] = "16811222675571680113",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now follow the waypoints until you reach the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8864.4;-214.2;5",
                        ["enUS"] = "-8864.4;-214.2;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [117]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Schurkenlehrer anvisieren und interagieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Schurkenlehrer anvisieren und interagieren",
               },
               ["GUID"] = "16811222675571680114",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nimm deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das Dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "915",
                        ["enUS"] = "915",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [118]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["GUID"] = "16811222675571680115",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Könnt ihr mir beibringen, wie man die Schurkenfertigkeiten anwendet) und die angenommene Quest. Wähle zuerst die angenommene Quest aus. Das machst du, indem du nach rechts gehst und im untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
                  ["enUS"] = "In the dialog pane you will find the menu item (Can you teach me how to use the rogue skills) and the accepted quest. First select the accepted quest. Do that by going to the right and confirming in the submenu (left click) with the (enter) key. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [119]
            {
               ["GUID"] = "16811222675571680116",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["GUID"] = "16811222675571680117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [121]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["GUID"] = "16811222675571680118",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
                  ["enUS"] = "Here the dialog closed automatically after the quest was completed. Interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "915",
                        ["enUS"] = "915",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [122]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["GUID"] = "16811222675571680119",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Könnt ihr mir beibringen wie man die Schurkenfertigkeiten anwendet), um das Lehrerfenster zu öffnen.",
                  ["enUS"] = "Now select (Can you teach me how to use the rogue skills). The trainer dialog box will then open.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [123]
            {
               ["GUID"] = "16811222675571680120",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [124]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["GUID"] = "16811222675571680121",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Die momentan für dich erlernbaren Zauber werden hier in einer Liste angezeigt, die in Kategorien sortiert ist. Dieser Lehrer bietet dir in der Kategorie (Täuschung) den Zauber (Verstohlenheit) an. Dieser Zauber ist bereits ausgewählt. Weiter unten findest du erneut (Machtwort Seelenstärke). Davor wird (Text) angesagt. Das ist der Menüpunkt für den Zauber, der momentan ausgewählt ist. Suche jetzt diesen Menüpunkt. ",
                  ["enUS"] = "This is the trainer dialog box. First you will find the category and below that the spell. For you, this trainer has the skill (Stealth) in the category (Subtlety). The ability is already selected. Further down the word (Stealth) is repeated. Before that, (text) is pronounced. This is the button for the skill that is selected. Find that button.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [125]
            {
               ["GUID"] = "16811222675571680122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "16811222675571680123",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "16811222675571680124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["GUID"] = "16811222675571680125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["GUID"] = "16811222675571680126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [130]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["GUID"] = "16811222675571680127",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nach (Verstohlenheit)",
                  ["enUS"] = "(Assign no action) is the menu item to make this button empty again. You can use it to remove actions from the bar. Down you will find different categories. If you go to the right on a category, you will find the spells and abilities of the category, which can be placed on the button. Find (Stealth). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Verstohlenheit",
                        ["enUS"] = "Stealth",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [131]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["GUID"] = "16811222675571680128",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! du hast (Verstohlenheit) gefunden. Du kannst die Details des Zaubers auch hier mit der Tooltipfunktion lesen. Lege (Verstohlenheit) nun auf den button indem du die (Eingabetaste) drückst. Schließe das Aktionsleistenmenü dann mit (Escape).",
                  ["enUS"] = "Great! You have found (Stealth). You can also read the details of the ability here with the tooltip feature. Now put (Stealth) on the button by pressing (Enter). Then close the action bar menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [132]
            {
               ["GUID"] = "16811286052548010001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zusatzleiste erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Zusatzleiste erklären",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Es gibt eine Besonderheit beim Schurken. Wenn du (Verstohlenheit) benutzt, wirst du unsichtbar. Im Modus (Unsichtbar) wird eine deiner Aktionsleisten zu einer Spezialleiste. die Tasten 1 bis Apostroph sind dann wieder leer und können mit Aktionen belegt werden, die du bei Verstohlenheit benutzen kannst. Dafür musst du erst den Zauber (Verstohlenheit) benutzen und dann die Aktionsleiste mit (Umschalttaste) und (F 11) öffnen. Du kannst dieser leeren Leiste dann später diese speziellen Fähigkeiten hinzufügen, die du noch erlernen wirst. Möglicherweise hast du (Verstohlenheit) auf der normalen Leiste auf einem dieser Buttons. Lege den Zauber dann auch auf der Verstohlenheitsleiste auf den selben Button, damit du dich auch wieder aus der Verstohlenheit rausholen kannst. Wenn du verstohlen bist, läufst du deutlich langsamer. Gegner können dich erkennen, wenn du zu nah bist. Die Leiste wechselt aktiv, je nachdem, welchen Zustand du hast. Schalte jetzt manuell weiter. ",
                  ["enUS"] = "There is a special feature with the rogue. When you use (Stealth), you become invisible. In (Invisible) mode, one of your action bars becomes a special bar. The keys 1 to 9 are then empty again and can be filled with actions that you can use with Stealth enabled. To do this, you first have to use the spell (Stealth) and then open the action bar with (Shift) and F 11). You can then populate the new empty bar with the special abilities you will learn. You may have (Stealth) on the regular bar on one of the buttons. Then put the Stealth spell on the same button on the stealth bar so you can get out of stealth. When you are stealthed, you will move much slower. Enemies can spot you if you are too close. The bar automatically changes depending on your stealth state. Continue manually.   ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [133]
            {
               ["GUID"] = "16811222675571680129",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [134]
            {
               ["GUID"] = "16811222675571680130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [135]
            {
               ["GUID"] = "16811222675571680131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [136]
            {
               ["GUID"] = "16811222675571680132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "16811222675571680133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [138]
            {
               ["GUID"] = "16811222675571680134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "16811222675571680135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "16811222675571680136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
            {
               ["GUID"] = "16811222675571680137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [142]
            {
               ["GUID"] = "16811222675571680138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [143]
            {
               ["GUID"] = "16811222675571680139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [144]
            {
               ["GUID"] = "16811222675571680140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [145]
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Schurke 1",
            ["enUS"] = "Human Rogue 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["playFtuIntro"] = true,
         ["GUID"] = "16811221545459280001",
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 4,
         },
      },
      ["168370330453520001"] = {
         ["GUID"] = "168370330453520001",
         ["steps"] = {
            {
               ["GUID"] = "168370332978050002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850002", -- [1]
                  },
               },
            }, -- [1]
            {
               ["GUID"] = "168370332978050003",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:NPC ins Ziel nehmen",
                  ["deDE"] = "NPC ins Ziel nehmen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850003", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Right in front of you is %npc_id:002079% with the first quest for you. Quests are tasks that you can complete. As a reward you get experience points, items and or money. You have to target %npc_id:002079% first. To do this, press and hold the (control) key and the (shift) key, then press the (tab) key once. You can target friendly targets with this shortcut.",
                  ["deDE"] = "Direkt vor dir steht %npc_id:002079% mit der ersten Quest für dich. Quests sind aufgaben, die du erledigen kannst. Zur belohnung erhälst du Erfahrungspunkte, Items und oder Geld. Du musst %npc_id:002079% zunächst ins Ziel nehmen. Halte hierfür die (Steuerungstaste) und die (Umschalttaste) gedrückt und drücke dann einmal auf die (Tabulatortaste). Mit dieser Tastenkombination kannst du freundliche Ziele ins Ziel nehmen.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "2079",
                        ["enUS"] = "2079",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [2]
            {
               ["GUID"] = "168370332978050004",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Mit Ziel interagieren",
                  ["deDE"] = "Mit Ziel interagieren",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850004", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["enUS"] = "Find out what he wants from you %name%. To talk to %npc_id:002079% you need to move to him and interact with him. You do that with the G key. So now press (G) once.",
                  ["deDE"] = "Finde heraus, was er von dir möchte %name%. Um mit %npc_id:002079% zu sprechen musst du zu ihm laufen und mit ihm interagieren. Das machst du mit der Taste G. Drücke nun also einmal (G)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 6,
                        ["deDE"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [3]
            {
               ["GUID"] = "168370332978050005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850005", -- [1]
                  },
               },
            }, -- [4]
            {
               ["GUID"] = "168370332978050006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850006", -- [1]
                  },
               },
            }, -- [5]
            {
               ["GUID"] = "168370332978050007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850007", -- [1]
                  },
               },
            }, -- [6]
            {
               ["GUID"] = "168370332978050008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850008", -- [1]
                  },
               },
            }, -- [7]
            {
               ["GUID"] = "168370332978050009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850009", -- [1]
                  },
               },
            }, -- [8]
            {
               ["GUID"] = "168370332978050033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850010", -- [1]
                  },
               },
            }, -- [9]
            {
               ["GUID"] = "168370332978050034",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850011", -- [1]
                  },
               },
            }, -- [10]
            {
               ["GUID"] = "168370332978050035",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490034",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "168370332978050036",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
                  ["deDE"] = "Klasse Fähigkeit Button 2",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "on button 2 there is a melee attack. To perform it you need mana. Your mana is usually full and regenerates by itself. Only if you are using a lot of spells that consume a lot of mana, it will be exhausted at some point. You can then replenish mana in combat with mana potions and out of combat by drinking drinks. You can read the details of the attack spell and anything else on the buttons with the tooltip feature. It's the same feature as in your quest log. Hold down the (shift) key and go down step by step with the (down arrow) key.",
                  ["deDE"] = "auf Taste 2 befindet sich ein Nahkampfangriff. Um ihn auszuführen benötigst du Mana. Dein mana ist in der Regel voll und regeneriert sich auch von allein. Nur wenn du viele zauber nutzt, die viel mana verbrauchen, wird es irgendwann erschöpft sein. Du kannst Mana dann im kampf mit Manatränken und außerhalb des Kampfes durch das Trinken von Getränken auffüllen. Die Details des angriffs und von allem anderen, was sich auf den Tasten befindet, kannst du mit der Tooltipfunktion lesen. Es ist die gleiche Funktion wie in deinem Questbuch. Halte die (Umschalttaste) gedrückt und gehe Schritt für Schritt mit der Taste (Pfeil runter) nach unten.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 25,
                        ["deDE"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [12]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Automatischer schuss",
                  ["deDE"] = "Automatischer schuss",
               },
               ["GUID"] = "1683717643179880001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "If you go with (down arrow) to button 3 and then even further to button 4, you will find the Auto Shot and your racial skills. For the Auto Shot you should know that it works similar to the Auto Attack on button 1. Once pressed, the hunter starts shooting. Pressed again, it stops. Later, when you have learned other shooting skills, you can start with another shot, which will also activate the Auto Shot. Read these spells with the tooltip feature and continue the tutorial manually afterwards. ",
                  ["deDE"] = "Wenn du mit (Pfeil runter) auf button 3 und danach noch weiter auf Button 4 gehst, wirst du den Automatischen Schuss und deine volksfähigkeit finden. Zum automatischen Schuss solltest du wissen, dass er, ähnlich wie der Automatische angriff auf Button 1 funktioniert. einmal gedrückt, fängt der Jäger an, zu schießen. Nochmal gedrückt, hört er wieder auf. Wenn du später andere Schüsse gelernt hast, kannst du mit einem anderen Schuss eröffnen, was dann auch den Automatischen Schuss aktiviert. Lese auch diese Zauber mit der Tooltipfunktion und schalte das tutorial danach manuell weiter. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [13]
            {
               ["GUID"] = "168370332978050037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850015", -- [1]
                  },
               },
            }, -- [14]
            {
               ["GUID"] = "168370332978050010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850016", -- [1]
                  },
               },
            }, -- [15]
            {
               ["GUID"] = "168370332978050011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850017", -- [1]
                  },
               },
            }, -- [16]
            {
               ["GUID"] = "168370332978050012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850018", -- [1]
                  },
               },
            }, -- [17]
            {
               ["GUID"] = "168370332978050013",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest im Buch lesen",
                  ["deDE"] = "Quest im Buch lesen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850019", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is the quest you just accepted. Here in your quest log you have the tooltip feature for each quest. To read the content of the quest with the tooltip feature, you should now hold down the shift key and open the tooltip by pressing the (down arrow) key once. You will hear a pling. The tooltip has opened. Each time you now press (down arrow), a new paragraph is read out. You hold down the (Shift) key the whole time. When you release (Shift) you will hear a pling again and the tooltip will close. Now try to read the whole quest again. So press (Shift) permanently and press (Down arrow) repeatedly until you reach the bottom.",
                  ["deDE"] = "Das ist die Quest, die du eben angenommen hast. Hier in deinem Questbuch hast du für jede Quest die Tooltip-Funktion. Um den Inhalt der Quest mit der Tooltip-Funktion zu lesen, sollst du nun die Umschalttaste dauerhaft festhalten und den Tooltip durch einmaliges drücken der (Pfeil runter) Taste öffnen. Es ertönt ein Pling. Der Tooltip hat sich geöffnet. Jedesmal, wenn du nun (Pfeil runter) drückst, wird ein neuer Absatz vorgelesen. Dabei hälst du die (Umschalttaste) die ganze Zeit lang fest. Wenn du die (Umschalttaste) loslässt hörst du wieder ein Pling und der Tooltip schließt sich. Versuche, die ganze Quest nun nochmal zu lesen. Drücke also die (Umschalttaste) dauerhaft und drücke so oft auf (Pfeil runter) bis du ganz unten angekommen bist.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "Balance of Nature",
                        ["deDE"] = "Gleichgewicht der Natur",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [18]
            {
               ["GUID"] = "168370332978050014",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationnsmenü im Questbuch nutzen",
                  ["deDE"] = "Navigationnsmenü im Questbuch nutzen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850020", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "You now know your quest. To move to a location, you should use the navigation system. Whenever you are on a quest in the quest log, you can go right once to get to the navigation menu. To do this, please press (right arrow) now.",
                  ["deDE"] = "Du kennst nun deine Quest. Um zu einem Ziel zu laufen, solltest du das Navigationssystem benutzen. Immer wenn du auf einer Quest im Questbuch stehst, kannst du einmal nach rechts gehen, um in das Navigationsmenü zu gelangen. Drücke dafür bitte jetzt (Pfeil rechts)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,1",
                        ["deDE"] = "4,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [19]
            {
               ["GUID"] = "168370332978050015",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Zum questziel 1 Navigieren",
                  ["deDE"] = "Zum questziel 1 Navigieren",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850021", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Here in the navigation menu you can choose different ways of navigation, which you can find under the main menu items. the menu item (Quest start) contains the location of the (quest start). under the menu item (target) you can find the location of the (enemies) or the quest goals and at the very bottom there is the menu item (Quest end), which contains the location of the (quest end). You have already accepted the quest and now you want to get to the quest target. So please go to (target) with (down arrow).",
                  ["deDE"] = "Hier im Navigationsmenü kannst du verschiedene Navigationen wählen, die du unter den einzelnen Hauptmenüpunkten finden kannst. der Menüpunkt (Annahme) beinhaltet den Ort der (Questannahme). unter dem Menüpunkt (Ziel) findest du den ort der (Gegner) oder der Questziele und ganz unten befindet sich der Menüpunkt (Abgabe), der den Ort der (Questabgabe) beinhaltet. Du hast die Quest bereits angenommen  und möchtest nun zum Questgegner gelangen. Gehe also bitte auf (Ziel) mit (Pfeil runter).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2",
                        ["deDE"] = "4,1,1,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [20]
            {
               ["GUID"] = "168370332978050016",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Rein ins Questziel",
                  ["deDE"] = "Rein ins Questziel",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850022", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "In this menu you will find the destinations you have to go to in order to complete the quest. Go right with (right arrow).",
                  ["deDE"] = "In diesem Hauptmenü findest du die Ziele, die du anlaufen musst, um die Quest zu erfüllen. Gehe einmal nach rechts mit (Pfeil rechts).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,1",
                        ["deDE"] = "4,1,1,1,2,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [21]
            {
               ["GUID"] = "168370332978050017",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Disteleber wählen",
                  ["deDE"] = "Disteleber wählen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850023", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is the list of suggested destinations. There can be more than one suggested destination here. You can check the suggestions with up arrow and down arrow. You have to kill different enemies for the quest. However, first we will focus on %npc_id:001984%. Therefore, the suggestion you are on now is the right destination. Now press (right arrow).",
                  ["deDE"] = "Das ist die Liste mit Zielvorschlägen. Hier können auch mehrere Ziele vorgeschlagen werden. Du kannst die Vorschläge mit Pfeil hoch und runter begutachten. Du musst für die Quest unterschiedliche Gegner töten. Zuerst konzentrieren wir uns jedoch auf %npc_id:001984% -. Deshalb ist der Vorschlag auf dem du jetzt stehst, das richtige Ziel. Drücke nun (Pfeil rechts).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2,1,1",
                        ["enUS"] = "4,1,1,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [22]
            {
               ["GUID"] = "168370332978050018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850024", -- [1]
                  },
               },
            }, -- [23]
            {
               ["GUID"] = "168370332978050019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850025", -- [1]
                  },
               },
            }, -- [24]
            {
               ["GUID"] = "168370332978050020",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation starten.",
                  ["deDE"] = "Navigation starten.",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850026", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is a selectable navigation target. There can be more than one. They are sorted by distance and you can select them with up arrow and down arrow. You want to find a %npc_id:001984% first. You have heard the distance and at the end there was no plus appended. So there is no submenu. Start the navigation to %npc_id:001984% by pressing (Enter).",
                  ["deDE"] = "Dies ist nun ein auswählbares Navigationsziel. Es kann mehrere geben, welche nach entfernung sortiert sind und die du über Pfeil hoch und runter anwählen könntest. Du möchtest nun zuerst einen %npc_id:001984% finden. Du hast die Entfernung gehört und am ende wurde kein Plus angehängt. Es gibt also kein Untermenü. Starte die Navigation zum %npc_id:001984% indem du die (Eingabetaste) drückst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 27,
                        ["deDE"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2,1,1,1,1",
                        ["enUS"] = "4,1,1,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [25]
            {
               ["GUID"] = "168370332978050021",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationsstart",
                  ["deDE"] = "Navigationsstart",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850027", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["enUS"] = "Navigation has been started. The new sound is an audio beacon. If you turn around with (A) and (D) you will hear where it is. If you are not sure, pressing (Control) and (Alt) will tell you which direction to turn around and how far away it is. 11 o'clock means diagonally left in front of you. 3 o'clock means to the right of you. Turn around with the A and D keys or the arrow keys until the beacon is at 12 o'clock. You can also hear a beep-puup sound when you hit 12 o'clock. Then move forward with W or up arrow until you reach the beacon.",
                  ["deDE"] = "Die Navigation wurde gestartet. Das neue Geräusch ist ein Audiobeacon. Wenn du dich mit (A) und (D) drehst, hörst du, wo sich der Audiobeacon befindet. Wenn du dir nicht sicher bist, kannst du durch drücken der Taste Alt(Gr), die sich (rechts) neben der (Leertaste) befindet, erfahren, in welche Richtung du dich drehen musst und wie weit der weg bis zum Nächsten Beacon ist. 11 Uhr bedeutet schräg links vor dir. 3 Uhr bedeutet rechts neben dir, also genau wie bei einer Uhr. Drehe dich mit den Tasten A und D oder den Pfeiltasten, bis das Beacon auf 12 Uhr liegt. Du kannst auch ein Piep-Puup-signalgeräusch hören, wenn du 12 Uhr triffst. Laufe dann mit W oder Pfeil hoch vorwärts, bis du den Beacon erreicht hast.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "10326.8;826.8;5",
                        ["enUS"] = "10326.8;826.8;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [26]
            {
               ["GUID"] = "168370332978050022",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Weiterlaufen bis zum Ziel",
                  ["deDE"] = "Weiterlaufen bis zum Ziel",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850028", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Good job. You've reached the beacon, it went pling. This is the audio signal that tells you that you have reached the beacon. Now a new beacon has appeared that you have to reach. You are moving around relatively freely in the world. There is a warning sound that should tell you when you are stuck. you can then hear a high pitched beep beep beep. Then walk backwards for a moment and do a small arc. Sometimes it also helps to jump with the spacebar. You have to get to the next beacon on your own in any case. Remember. With the (control) plus (alt) you can check where exactly the audio beacon is located. In case of emergency you can switch the route back by pressing (control) (shift) and (S) to activate the previous beacon. Continue manually. because you need more important information before the first fight.",
                  ["deDE"] = "Gut gemacht. Du hast den Beacon erreicht, es hat Pling gemacht. Dies ist das Audiosignal, woran du erkennst, dass du den Beacon erreicht hast. nun ist ein neuer Beacon erschienen, den du erreichen musst. Du läufst relativ frei in der Welt herum. Es gibt ein Warngeräusch, welches dir sagen soll, wenn du feststeckst. du kannst dann ein hohes Piep Piep Piep hören. Gehe dann kurz rückwärts und mache einen kleinen Bogen. Manchmal hilft es auch, mit der Leertaste zu springen. Du musst auf jeden Fall selbständig zum nächsten Beacon gelangen. Erinnere dich. Mit der Taste Alt (GR) (rechts) neben der (Leertaste) kannst du abfragen, wo sich der Audiobeacon genau befindet. Im Notfall kannst du die Rute zurückschalten, indem du mit (Steuerungstaste) (Umschalttaste) und einen druck auf (S) den vorherigen Beacon aktivierst. Schalte das tutorial jetzt aber manuell weiter, da du noch weitere wichtige Informationen vor dem ersten Kampf benötigst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [27]
            {
               ["GUID"] = "168370332978050043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850029", -- [1]
                  },
               },
            }, -- [28]
            {
               ["GUID"] = "168370332978050044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850030", -- [1]
                  },
               },
            }, -- [29]
            {
               ["GUID"] = "168370332978050045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850031", -- [1]
                  },
               },
            }, -- [30]
            {
               ["GUID"] = "168370332978050046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850032", -- [1]
                  },
               },
            }, -- [31]
            {
               ["GUID"] = "168370332978050047",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Gegner suchen",
                  ["deDE"] = "Gegner suchen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850033", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["enUS"] = "Already here there could be enemies in front of you. Use the (Tab) key to target enemies in front of you. Search for a %npc_id:001984%. Here in the starting area, the enemies are not aggressive yet. They do not attack you. If you want, clear your target by pressing (Escape) or target yourself with (E). You can also just press (Tab) to search for more targets. When you find a target, the name and level of the target is pronounced. In parallel, a male voice pronounces the distance to the target. As long as you have the target in sight, the male voice output will always tell you the distance to the target when it changes. Keep following the route and search with (tab) for a %npc_id:001984% or a %npc_id:002031%.",
                  ["deDE"] = "Schon hier könnten sich Gegner vor dir befinden. Mit der (Tabulatortaste) kannst du Gegner vor dir ins Ziel nehmen. Suche einen %npc_id:001984% -. Hier im Startgebiet sind die Gegner noch nicht aggressiv. Sie greifen dich nicht an. Wenn du möchtest, dann lösche dein Ziel durch einmaliges drücken der Taste (Escape) oder nehme dich selbst mit (E) ins Ziel. Du kannst auch einfach (Tabulator) drücken um nach weiteren Zielen zu suchen. Wenn du ein Ziel findest, wird der Name und die Stufe des Ziels angesagt. Parallel dazu sagt eine Männliche Sprachausgabe die Entfernung zum Ziel an. Solange du das Ziel im visier hast, sagt die männliche Sprachausgabe bei Veränderung immer die entfernung zum Ziel. Folge weiter der Rute und suche mit (Tabulator) nach einem %npc_id:001984%  oder einem %npc_id:002031% -.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "2031",
                        ["enUS"] = "2031",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "1984",
                        ["enUS"] = "1984",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [32]
            {
               ["GUID"] = "168370332978050048",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Angriff",
                  ["deDE"] = "Angriff",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is one of the enemies you are looking for. You have several ways to attack. The (G) key lets you interact with the target. Attackable targets will then be attacked automatically. For the hunter, (G) activates the Auto Shot. If you are too far away, you automatically move close enough. Then your charakter will start shooting and the enemy moves to you. When the enemy is with you, you can't shoot anymore. Then Auto Shot changes to Auto Attack. you can then press key 2 to boost your melee attacks. Hunters are not automatically turning towards the enemy. Make sure you have the combat sound in front of you and use (A) and (D) to align yourself while fighting. Try it now and attack with (G)!",
                  ["deDE"] = "Das ist einer der gesuchten Gegner. Du hast verschiedene Möglichkeiten um anzugreifen. Die Taste (G) lässt dich mit dem Ziel interagieren. Angreifbare Ziele werden dann automatisch angegriffen. Beim Jäger wird durch (G) der Automatische Schuss aktiviert. Falls du zu weit weg bist, läufst du automatisch nah genug ran. Dann fliegen Pfeile und der Gegner kommt zu dir gelaufen. Wenn der Gegner bei dir ist, kannst du nicht mehr schießen. Dann wechselt der automatische Schuss zum automatischen Angriff. du kannst dann Taste 2 drücken um deine nahkampfangriffe zu verstärken. Jäger drehen sich nicht automatisch in die Richtung des Gegners. Achte darauf, dass du das Kampfgeräusch vor dir hast und nutze (A) und (D) um dich auszurichten während du kämpfst. Versuche es jetzt und greife mit (G) an!",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 49,
                        ["deDE"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [33]
            {
               ["GUID"] = "168370332978050049",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Plündern",
                  ["deDE"] = "Plündern",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850035", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["enUS"] = "Congratulations %name%! The enemy is dead! You can now get loot by looting the corpse. You can do this in several ways. Try to press (H) after the fight. This will re-target the last enemy, because your target is automatically cleared after the fight. Then press (G) and interact with the corpse. You will then get the loot. If it works, you'll know by the jingling of coins or a sound that sounds like you're pocketing something. If not, I'll show you another variation on the next enemy. Try it now. First press (H) and then (G). Continue the tutorial manually with %SKU_KEY_TUTORIALSTEPFORWARD%.",
                  ["deDE"] = "Glückwunsch %name%! Der Gegner ist tot! Du kannst nun Beute erhalten, indem du den Leichnam plünderst. Dies kannst du auf verschiedene Weisen tun. Versuche nach dem Kampf auf (H) zu drücken. Dadurch bekommst du den letzten Gegner wieder ins Ziel, denn dein Ziel wird nach dem Kampf automatisch gelöscht. Drücke dann (G) und interagiere mit der Leiche. Du erhälst dann die Beute. Wenn es funktioniert, erkennst du das am klimpern von Münzen oder einem Geräusch, dass klingt, als ob man etwas einsteckt. Wenn nicht, dann zeige ich dir beim nächsten Gegner eine andere Variante. Versuche es nun. Drücke erst (H) und dann (G). Schalte das tutorial danach manuell mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [34]
            {
               ["GUID"] = "168370332978050050",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Zweiten Gegner erlegen",
                  ["deDE"] = "Zweiten Gegner erlegen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850036", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "you haven't moved to the end of the route yet. So just keep following it and look for another enemy. then attack him and finish him off.",
                  ["deDE"] = "du bist noch nicht bis zum ende der Rute gelaufen. Folge ihr also einfach weiter und suche einen weiteren Gegner. greife ihn dann an und erledige ihn.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 49,
                        ["deDE"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [35]
            {
               ["GUID"] = "168370332978050053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850037", -- [1]
                  },
               },
            }, -- [36]
            {
               ["GUID"] = "168370332978050054",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Softtarget erklären",
                  ["deDE"] = "Softtarget erklären",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850038", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Press (G) when you hear the sound. The target will be automatically selected and looted. Turn around in a circle and see if there is more loot lying around. Collect everything with (G). We now leave the soft targeting on and after the next fight the sound will be heard immediately. You can also loot immediately by pressing (G) once. Kill another enemy after looting.",
                  ["deDE"] = "Drücke (G), wenn du das Geräusch gehört hast. Das Ziel wird automatisch ausgewählt und geplündert. Drehe dich im Kreis und schau nach, ob noch mehr Beute herumliegt. Sammel alles mit (G) ein. Das Softtargeting lassen wir nun eingeschaltet und nach dem nächsten Kampf wird das Geräusch sofort zu hören sein. Du kannst dann auch sofort durch einmaliges drücken von (G) plündern. Töte nach dem Plündern einen weiteren Gegner.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 49,
                        ["deDE"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [37]
            {
               ["GUID"] = "168370332978050055",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung der ansagen",
                  ["deDE"] = "Erklärung der ansagen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850039", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Don't forget to loot with (G) when you heard the smacking sound. In battle, you'll hear a lot of prompts. The female voice says in increments of 10 how much percent health the enemy has left. The boy voice pronounces your health in single digits in 10 steps. The girl voice tells you how much mana you have. Continue the tutorial manually.",
                  ["deDE"] = "Vergesse nicht mit (G) zu plündern, wenn du das Schmatzgeräusch gehört hast. Im Kampf hörst du viele Ansagen. Die Weibliche Sprachausgabe sagt in 10er Schritten, wieviel Prozent Leben der Gegner noch hat. Die Jungenstimme sagt einstellig in 10 Schritten dein Leben an. Das Mädchen sagt dir, wieviel Mana du hast. Schalte das tutorial jetzt manuell weiter.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [38]
            {
               ["GUID"] = "168370332978050056",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest zuende spielen",
                  ["deDE"] = "Quest zuende spielen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850040", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Now kill the remaining enemies and loot them. To know if you have completed the quest, open your quest log with (L) and check the quest under (progress). At each quest progress you will also hear a (Pling) and at quest completion a (Pling Pling). If you hear a loud gong-like sound, or are unsure, manually advance the tutorial. ",
                  ["deDE"] = "Töte nun die restlichen Gegner und plünder sie. Um zu erfahren, ob du die Quest erledigt hast, öffne dein Questbuch mit (L) und sieh in der Quest unter (Fortschritt) nach. Bei jedem Questfortschritt hörst du auch ein (Pling) und bei Questabschluss ein (Pling Pling). Wenn du ein Lautes Gongähnliches Geräusch hörst, oder dir unsicher bist, dann schalte das Tutorial manuell weiter. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [39]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850041", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationshinweis",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationshinweis",
               },
               ["GUID"] = "16837256168152870001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "vielleicht hast du Schwierigkeiten, die richtigen Gegner zu finden. Öffne dein Questbuch mit (L) und gehe zwei mal nach rechts auf die Quest.",
                  ["enUS"] = "you may have trouble finding the correct enemies. Open your quest log with (L) and go right two times on the quest.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1",
                        ["deDE"] = "4,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [40]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850042", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationshinweis 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationshinweis 2",
               },
               ["GUID"] = "1683802070358370001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier kannst du mit der tooltipfunktion (umschalttaste) und (Pfeil runter) nachsehen, wie dein Fortschritt ist. sicher musst du noch %npc_id:002031% erlegen. um zu einem %npc_id:002031% zu gelangen, gehe bitte nach rechts und einmal runter auf (Ziel)",
                  ["enUS"] = "here you can use the tooltip feature (shift) and (down arrow) to see what your progress is. for sure you still have to kill %npc_id:002031%. to get to a %npc_id:002031% please go right and down arrow once on (target)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2",
                        ["deDE"] = "4,1,1,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [41]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850043", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationshinweis 3",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationshinweis 3",
               },
               ["GUID"] = "1683802230518200002",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Menü für die Questziele. Gehe einmal nach rechts, um dort einen der verschiedenen Gegnertypen zu wählen. Auf Position 1 wirst du die %npc_id:001984% finden. Auf Position 2 findest du %npc_id:002031% - Genau zu diesem wollen wir nun navigieren. Suche also nach dem Menüpunkt %npc_id:002031% ",
                  ["enUS"] = "This is the menu for the quest goals. Go right once to select one of the different enemy types there. On position 1 you will find %npc_id:001984%. On position 2 you will find %npc_id:002031%. This is the one we want to navigate to now. So search for the menu item %npc_id:002031%. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,2",
                        ["deDE"] = "4,1,1,1,2,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [42]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850044", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zu Nachtsäbler navigieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Zu Nachtsäbler navigieren",
               },
               ["GUID"] = "1683802509797260003",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Genau hier bist du richtig. Gehe nun ganz nach rechts, bis du den gegnernamen mit entfernungsangabe hörst. Drücke dann die (Eingabetaste) um eine Rute zu dem nächsten %npc_id:002031% zu starten.",
                  ["enUS"] = "This is it. Now go all the way to the right until you hear the enemy name with distance. Then press (Enter) to start a route to the next %npc_id:002031%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 27,
                        ["deDE"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,2,1,1,1",
                        ["deDE"] = "4,1,1,1,2,2,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [43]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850045", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Gelernt - erledige die quest",
                  ["enUS"] = "UNTRANSLATED:deDE:Gelernt - erledige die quest",
               },
               ["GUID"] = "1683802670957730004",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Jetzt kannst du zu den unterschiedlichen Gegnern navigieren. Beende deine Jagd erst, wenn du die Aufgabe erledigt hast. du kannst jederzeit im Questbuch nachsehen, welche Art von Gegner noch erledigt werden muss. Falls du unsicher bist oder ein gongähnliches Geräusch hörst, welches bedeutet, dass du auf stufe 2 aufgestiegen bist, dann schalte das Tutorial einfach manuell weiter.",
                  ["enUS"] = "Now you can navigate to the different enemies. Do not stop your hunt until you have completed the task. you can always check the quest log to see what type of enemies still need to be completed. If you are unsure or hear a gong-like sound that means you have advanced to level 2, just manually continue the tutorial.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [44]
            {
               ["GUID"] = "168370332978050057",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Level Up und die Übersichtsseite",
                  ["deDE"] = "Level Up und die Übersichtsseite",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850046", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "You may have heard the gong sound. This means you have advanced to level 2. If that's not the case, then it will probably happen soon. Check how much experience you have. You can do that on the overview page. You open the overview page with (shift) and (down arrow). You operate the overview page in the same way as the tooltip. Hold (Shift) and go down line by line with (Down arrow), until you find your experience.",
                  ["deDE"] = "Möglicherweise hast du das Gonggeräusch gehört. Das bedeutet, du bist auf Stufe 2 aufgestiegen. Falls das nicht der Fall ist, dann wird es wohl bald passieren. Schau nach, wie viel Erfahrung du hast. das kannst du auf der Übersichtsseite. Du öffnest die Übersichtsseite mit (Umschalttaste) und (Pfeil runter). Die Übersichtseite bedienst du so, wie den Tooltip. Halte (Umschalttaste) fest und gehe mit (Pfeil runter) Zeile für Zeile nach unten, bis du deinen Erfahrungsfortschritt findest",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "xp",
                        ["deDE"] = "xp",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [45]
            {
               ["GUID"] = "168370332978050058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850047", -- [1]
                  },
               },
            }, -- [46]
            {
               ["GUID"] = "168370332978060059",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest erledigt",
                  ["deDE"] = "Quest erledigt",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850048", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Have you completed your quest and killed all enemies? In your quest log you will see the word (Completed) in front of the quest and under progress you can read that you killed all the enemies you needed. Continue manually. if you have really completed everything.",
                  ["deDE"] = "Hast du deine Quest erledigt und Alle Gegner getötet? In deinem Questbuch steht vor der Quest das Wort (Fertig) und unter Fortschritt kannst du lesen, dass du alle der benötigten Gegner getötet hast. Schalte das tutorial dann manuell weiter, wenn du wirklich alles erledigt hast.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [47]
            {
               ["GUID"] = "168370332978060060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850049", -- [1]
                  },
               },
            }, -- [48]
            {
               ["GUID"] = "168370332978060061",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Questbuch öffnen und auf die q gehen",
                  ["deDE"] = "Questbuch öffnen und auf die q gehen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850050", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Now open your quest log with (L) and go right to the quest. There you should see (Completed) before the quest. If it doesn't, then you have to kill more enemies.",
                  ["deDE"] = "Öffne nun dein Questbuch mit (L) und gehe nach rechts auf die Quest. Dort sollte vor der Quest ein (FERTIG) gesagt werden. Falls das nicht so ist, dann musst du noch weitere Gegner töten.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "Completed",
                        ["deDE"] = "fertig",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1",
                        ["deDE"] = "4,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [49]
            {
               ["GUID"] = "168370332978060062",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation zur Abgabe starten",
                  ["deDE"] = "Navigation zur Abgabe starten",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850051", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Go to the right and then down to (Quest End). Then go right until you hear %npc_id:002079% with the distance.",
                  ["deDE"] = "Gehe nach rechts und dann nach unten bis auf (Abgabe). Dann gehe nach rechts, bis du %npc_id:002079% mit Entfernungsangabe hörst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,3,1,1,1,1",
                        ["enUS"] = "4,1,1,1,3,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [50]
            {
               ["GUID"] = "168370332978060063",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Route starten und zum Ziel laufen",
                  ["deDE"] = "Route starten und zum Ziel laufen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850052", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Start navigation and follow the beacons to the quest giver. Press the (Enter) key to start and then move",
                  ["deDE"] = "Starte die Navigation und folge den Audiobeacons bis zum Questgeber. Drücke zum starten die (Eingabetaste) und laufe los",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "10316.6;829.3;5",
                        ["deDE"] = "10316.6;829.3;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [51]
            {
               ["GUID"] = "168370332978060064",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung verfügbare quest",
                  ["deDE"] = "Erklärung verfügbare quest",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850053", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "As you move through the world, there may be an NPC standing near you who has a quest for you. You will hear a beacon and the automatic announcement: (quest available) the (quest title) and the name of the (quest giver). Later this will give you important notes. For now you can ignore the prompts. Continue manually.",
                  ["deDE"] = "Wenn du durch die Welt läufst, kann es sein, dass in deiner Nähe ein NPC steht, der eine Quest für dich hat. Du hörst dann einen Beacon und die automatische Ansage: (Quest verfügbar) den (Questnamen) und den Namen des (Questgebers). Später gibt dir das wichtige Hinweise. Jetzt kannst du die ansage ignorieren. Schalte das tutorial manuell weiter.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [52]
            {
               ["GUID"] = "168370332978060065",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Questgeber anvisieren nach erster quest",
                  ["deDE"] = "Questgeber anvisieren nach erster quest",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850054", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "You arrived. Try to move so that the last beacon is reached. Then target %npc_id:002079% by holding (control key) and (shift key) and pressing (tab). If you don't find him, turn around and press the keys again. ",
                  ["deDE"] = "Du bist angekommen. Versuche so genau zu treffen, dass auch das letzte Audiobeacon abgeschaltet wird. Nehme dann %npc_id:002079% ins Ziel indem du (Steuerungstaste) und (Umschalttaste) festhälst und auf (Tabulator) drückst. Wenn du ihn nicht findest, drehe dich und drücke die Tasten nochmal. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "2079",
                        ["deDE"] = "2079",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [53]
            {
               ["GUID"] = "168370332978060066",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest abgeben Ansprechen",
                  ["deDE"] = "Quest abgeben Ansprechen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850055", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Interact with the quest giver by pressing (G).",
                  ["deDE"] = "Interagiere mit dem Questgeber indem du (G) drückst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "2079",
                        ["deDE"] = "2079",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [54]
            {
               ["GUID"] = "168370332978060067",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Dialogfenster erklären",
                  ["deDE"] = "Dialogfenster erklären",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850056", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "If a quest giver has only one quest for you, the quest will open immediately. In most cases, however, a dialog pane with various options will open. Go to the right once. ",
                  ["deDE"] = "Wenn ein Questgeber nur eine Quest für dich hat, öffnet sich sofort die Quest. In den meisten Fällen öffnet sich aber ein Dialogfenster mit verschiedenen Optionen. Gehe einmal nach rechts. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,1",
                        ["deDE"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [55]
            {
               ["GUID"] = "168370332978060069",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest im Dialogfenster bedienen",
                  ["deDE"] = "Quest im Dialogfenster bedienen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850057", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "The quest panel will open immediately. You are now on Quest end Plus. Go right again to get to the quest panel. Then go down until you hear rewards (plus).",
                  ["deDE"] = "Hier hat sich sofort das questfenster geöffnet. du stehst nun auf Abgabe Plus. Gehe noch einmal nach rechts um ins questfenster zu kommen. Dann gehe nach unten bis du Belohnungen (plus) hörst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "2079",
                        ["deDE"] = "2079",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,1,3",
                        ["deDE"] = "9,1,1,3",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [56]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850058", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins belohnungsfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins belohnungsfenster",
               },
               ["GUID"] = "168373127713814160001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist nun im Fenster für die Belohnungsauswahl. Du findest hier 2 Gegenstände die du mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter) genauer inspizieren kannst. Außerdem wird dir angesagt, wieviel Geld und Erfahrung du erhalten wirst. Führe auf den Handschuhen aus Leder, dem ersten Gegenstand, ein Linksklick aus. Dafür gehst du auf den Gegenstand und dann nach rechts. Dort drückst du die (Eingabetaste). Der gegenstand ist nun ausgewählt.",
                  ["enUS"] = "You are now in the reward selection panel. You will find 2 items that you can inspect more with the tooltip feature (shift) and (down arrow). You will also be pronounced how much money and experience you will receive. Left-click on the leather gloves, the first item. To do this, go to the item and then to the right. There you press the (Enter) key. The item is now selected.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,1,3,2,1",
                        ["deDE"] = "9,1,1,3,2,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 27,
                        ["deDE"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [57]
            {
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850059", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erste Quest jetzt abgeben",
                  ["enUS"] = "UNTRANSLATED:deDE:Erste Quest jetzt abgeben",
               },
               ["GUID"] = "168373155214089040002",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nun hast du deine Belohnung ausgewählt. Gebe die Quest ab, indem du die Schaltfläche (Abgeben) suchst und diese im untermenü auf (Linksklick) mit der (Eingabetaste) bestätigst oder drücke einfach nur die (Leertaste)",
                  ["enUS"] = "Now you have selected your reward. Turn in the quest by finding the (Complete Quest) button and confirming it in the submenu on (Left click) with (Enter) or just press (Spacebar)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 61,
                        ["deDE"] = 61,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [58]
            {
               ["GUID"] = "168370332978060070",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Erneut mit dem NPC sprechen",
                  ["deDE"] = "Erneut mit dem NPC sprechen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850060", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "The dialog pane will close automatically if there is no other option. But here the NPC has 2 more quests for you. Therefore the dialog pane has opened again. You have to go to the right to get to the main window. Press (right arrow) until you hear the heading text.",
                  ["deDE"] = "Das Dialogfenster schließt sich automatisch, wenn keine weitere Option vorhanden ist. Hier hat der NPC aber 2 weitere Quests für dich. Deshalb hat sich das Dialogfenster wieder geöffnet. Du musst nun nach rechts gehen, um in das hauptfenster zu gelangen. Drücke (Pfeil rechts) bis du den Überschriftstext hörst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,1,1",
                        ["deDE"] = "9,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [59]
            {
               ["GUID"] = "168370332978060071",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Dialogfeld mit 2 Quests",
                  ["deDE"] = "Dialogfeld mit 2 Quests",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850061", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "You are now back in the dialog pane. Below are 2 quests that are (Available). That means you can accept them and then they are in your quest log. Now go down arrow once.",
                  ["deDE"] = "Du bist jetzt wieder im Dialogfenster. unten sind 2 Quests, die (Verfügbar) sind. Das bedeutet, du kannst sie annehmen und dann sind sie in deinem Questbuch. Gehe jetzt einmal nach unten mit (Pfeil runter).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 25,
                        ["deDE"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "available",
                        ["deDE"] = "verfügbar",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [3]
               },
            }, -- [60]
            {
               ["GUID"] = "168370332978060072",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Quest eins annehmen",
                  ["deDE"] = "Quest eins annehmen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850062", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is the first quest. Select it. Go to the right and press (Enter) in the submenu on the button (Left click). ",
                  ["deDE"] = "Dies ist die erste Quest. Wähle diese nun aus. Gehe dafür nach rechts und drücke im Untermenü dann auf der Schaltfläche (Linksklick) die (Eingabetaste). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 27,
                        ["enUS"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [61]
            {
               ["GUID"] = "168370332978060073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850063", -- [1]
                  },
               },
            }, -- [62]
            {
               ["GUID"] = "168370332978060074",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Annahme der zweiten",
                  ["deDE"] = "Annahme der zweiten",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850064", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "You have accepted the first quest. The panel has closed. But the NPC has another quest for you. So talk to him again by pressing (G).",
                  ["deDE"] = "Du hast die erste Quest angenommen. Das Fenster hat sich geschlossen. Der NPC hat aber eine weitere Quest für dich. Spreche ihn also nochmal an, indem du (G) drückst.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [63]
            {
               ["GUID"] = "168370332978060076",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:die zweite Quest annehmen",
                  ["deDE"] = "die zweite Quest annehmen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850065", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "The panels are different for the NPC. You may have to search and select the available quest in the dialog pane first to open the quest panel. Or maybe the second quest will open directly for you to accept. Read it if you want and then confirm the (Accept) button or just press (Spacebar) to accept this quest as well.",
                  ["deDE"] = "Die Fenster der NPC sind unterschiedlich. Möglicherweise musst du erst im Dialogfenster die verfügbare Quest suchen und auswählen um das questfenster zu öffnen. Vielleicht öffnet sich aber auch direkt die zweite Quest zur Annahme. Lese diese wenn du möchtest und bestätige dann die Schaltfläche (Annahme) oder drücke einfach (Leertaste), um auch diese Quest anzunehmen.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 58,
                        ["deDE"] = 58,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [64]
            {
               ["GUID"] = "168370332978060077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850066", -- [1]
                  },
               },
            }, -- [65]
            {
               ["GUID"] = "168370332978060078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850067", -- [1]
                  },
               },
            }, -- [66]
            {
               ["GUID"] = "168370332978060079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850068", -- [1]
                  },
               },
            }, -- [67]
            {
               ["GUID"] = "168370332978060080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850069", -- [1]
                  },
               },
            }, -- [68]
            {
               ["GUID"] = "168370332978060081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850070", -- [1]
                  },
               },
            }, -- [69]
            {
               ["GUID"] = "168370332978060082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850071", -- [1]
                  },
               },
            }, -- [70]
            {
               ["GUID"] = "168370332978060083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850072", -- [1]
                  },
               },
            }, -- [71]
            {
               ["GUID"] = "168370332978060084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850073", -- [1]
                  },
               },
            }, -- [72]
            {
               ["GUID"] = "168370332978060085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850074", -- [1]
                  },
               },
            }, -- [73]
            {
               ["GUID"] = "168370332978060086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850075", -- [1]
                  },
               },
            }, -- [74]
            {
               ["GUID"] = "168370332978060087",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
                  ["deDE"] = "Ausrüstung ansehen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "As %class% you can wear (cloth armor) and (leather armor). Later, from level 40 also chain armor. You will probably want to see what equipment you are currently wearing. To do so, go to (equipment) to the right to (items) and then to the right again.",
                  ["deDE"] = "Als %class% kannst du (Stoffrüstung) und (Lederrüstung) tragen. Später, ab Level 40 auch schwere rüstung. Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 3,
                        ["deDE"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,2,1,1",
                        ["deDE"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [75]
            {
               ["GUID"] = "168370332978060088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850077", -- [1]
                  },
               },
            }, -- [76]
            {
               ["GUID"] = "168370332978060089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850078", -- [1]
                  },
               },
            }, -- [77]
            {
               ["GUID"] = "168370332978060090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850079", -- [1]
                  },
               },
            }, -- [78]
            {
               ["GUID"] = "168370332978060091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850080", -- [1]
                  },
               },
            }, -- [79]
            {
               ["GUID"] = "168370332978060092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850081", -- [1]
                  },
               },
            }, -- [80]
            {
               ["GUID"] = "168370332978060093",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Bogenmacher finden",
                  ["deDE"] = "Bogenmacher finden",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850082", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Now find the Bowyer %npc_id:003589%. Use the (arrow keys) to go down field by field. You can also use the filter. For this write the word (bow) and then go with (down arrow) to the result.",
                  ["deDE"] = "Suche jetzt nach der Bogenmacherin %npc_id:003589% -. Gehe dafür mit den (Pfeiltasten) Feld für Feld nach unten. Du kannst auch den Filter Nutzen. Schreibe dafür das Wort (Bogen) und gehe dann mit (Pfeil runter) auf das Ergebnis.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "1,3,1,1,8",
                        ["enUS"] = "1,3,1,1,8",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [81]
            {
               ["GUID"] = "168370332978060094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850083", -- [1]
                  },
               },
            }, -- [82]
            {
               ["GUID"] = "168370332978060095",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Zum Händler laufen",
                  ["deDE"] = "Zum Händler laufen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850084", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Note: Sometimes you hear a sound while moving, which is sometimes shorter or sometimes longer. It means that your character has lost contact with the ground and may fall down. It is very sensitive, so that you can react quickly and also notice when you fall down from a staircase just one meter. It's an important element in finding your way in this world aurally. You can also hear the sound if you just jump on the spot. Just press the (spacebar) several times to do so. You've started the route. Follow the beacons to the Bowyer.",
                  ["deDE"] = "Hinweis: Manchmal hörst du während dem Laufen ein Geräusch, welches mal kürzer oder mal länger ist. Es bedeutet, dass deine Spielfigur den Kontakt zum Boden verloren hat und möglicherweise herunterfällt. Es ist sehr fein eingestellt, damit du schnell reagieren kannst und damit du auch merkst, wenn du von einer Treppe nur einen Meter herunterfällst. Es ist ein wichtiges Element, um sich auditiv in dieser Welt zurechtzufinden. Du kannst das Geräusch auch hören, wenn du einfach auf der Stelle springst. Drücke dafür einfach mehrmals die (Leertaste). (Auftrag): Du hast die Rute gestartet. Folge den Beacons bis zur bogenmacherin.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "10436.2;795.5;5",
                        ["enUS"] = "10436.2;795.5;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [83]
            {
               ["GUID"] = "168370332978060096",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Angekommen beim Händler",
                  ["deDE"] = "Angekommen beim Händler",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850085", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "When you are moving to a destination, be careful not to move beyond the last waypoint. If you are moving beyond the point, you will be behind the merchant, for example. The audio beacon is placed exactly on the NPC's position. Always approach the last route point slowly by carefully tapping the (W) key. you can target the Bowyer %npc_id:003589% just like the other NPCs. If the last waypoint is still activated, you can turn it off with (Shift) and (F12). Then press (Shift) and (Control) and (Tab) as usual. ",
                  ["deDE"] = "Wenn du zu einem Ziel läufst, solltest du genau darauf achten, nicht über den letzten Wegpunkt hinaus zu laufen. Wenn du den Punkt überläufst, stehst du beispielsweise hinter dem Händler. Der Audiobeacon ist exakt auf der Position des NPC's platziert. Taste dich an den letzten Wegpunkt der Rute immer langsam mit vorsichtigem Tippen der Taste (W) heran. die bogenmacherin %npc_id:003589% kannst du genau so wie die anderen NPCs ins Ziel nehmen. Wenn der letzte Wegpunkt noch aktiviert ist, kannst du ihn mit (Umschalttaste) und (F12) ausschalten. Drücke dann wie immer (Umschalttaste) und (Steuerungstaste) und (Tabulator) ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "3589",
                        ["enUS"] = "3589",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [84]
            {
               ["GUID"] = "168370332978060097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850086", -- [1]
                  },
               },
            }, -- [85]
            {
               ["GUID"] = "168370332978060098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850087", -- [1]
                  },
               },
            }, -- [86]
            {
               ["GUID"] = "168370332978060099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850088", -- [1]
                  },
               },
            }, -- [87]
            {
               ["GUID"] = "168370332978060100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850089", -- [1]
                  },
               },
            }, -- [88]
            {
               ["GUID"] = "168370332978060101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850090", -- [1]
                  },
               },
            }, -- [89]
            {
               ["GUID"] = "168370332978060102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850091", -- [1]
                  },
               },
            }, -- [90]
            {
               ["GUID"] = "168370332978060103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850092", -- [1]
                  },
               },
            }, -- [91]
            {
               ["GUID"] = "168370332978060104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850093", -- [1]
                  },
               },
            }, -- [92]
            {
               ["GUID"] = "168370332978060105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850094", -- [1]
                  },
               },
            }, -- [93]
            {
               ["GUID"] = "168370332978060106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850095", -- [1]
                  },
               },
            }, -- [94]
            {
               ["GUID"] = "168370332978060107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850096", -- [1]
                  },
               },
            }, -- [95]
            {
               ["GUID"] = "168370332978060108",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Go to (right) in the first submenu. You already know that the quests there are sorted by regions or categories. Then go down from (All) until you find yourself on Hunters.",
                  ["deDE"] = "Gehe nach (rechts) in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf Jäger befindest.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "Hunter",
                        ["deDE"] = "Jäger",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [96]
            {
               ["GUID"] = "168370332978060109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850098", -- [1]
                  },
               },
            }, -- [97]
            {
               ["GUID"] = "168370332978060110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850099", -- [1]
                  },
               },
            }, -- [98]
            {
               ["GUID"] = "168370332978060111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850100", -- [1]
                  },
               },
            }, -- [99]
            {
               ["GUID"] = "168370332978060112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850101", -- [1]
                  },
               },
            }, -- [100]
            {
               ["GUID"] = "168370332978060113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850102", -- [1]
                  },
               },
            }, -- [101]
            {
               ["GUID"] = "168370332978060114",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850103", -- [1]
                  },
               },
            }, -- [102]
            {
               ["GUID"] = "168370332978060115",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
                  ["deDE"] = "zum lehrer laufen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now move along the waypoints until you reach the trainer.",
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "10456.6;828.3;5",
                        ["deDE"] = "10456.6;828.3;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [103]
            {
               ["GUID"] = "168370332978060116",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Jägerlehrer anvisieren und ansprechen",
                  ["deDE"] = "Jägerlehrer anvisieren und ansprechen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850105", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
                  ["deDE"] = "nehme deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das dialogfenster zu öffnen.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 6,
                        ["deDE"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "3596",
                        ["deDE"] = "3596",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [104]
            {
               ["GUID"] = "168370332978060117",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
                  ["deDE"] = "Das Lehrerfenster",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850106", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "In the dialog pane you will find the menu item I want to be trained and the accepted quest. First select the accepted quest. You can do that by going to the right and confirming with (enter) in the submenu (left click). ",
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt Ich möchte ausgebildet werden und die angenommene Quest. Wähle zuerst die angenommene Quest aus. Das machst du, indem du nach rechts gehst und im untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 9,
                        ["deDE"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [105]
            {
               ["GUID"] = "168370332978060118",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128850107", -- [1]
                  },
               },
            }, -- [106]
            {
               ["GUID"] = "168370332978060119",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860108", -- [1]
                  },
               },
            }, -- [107]
            {
               ["GUID"] = "168370332978060120",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
                  ["deDE"] = "Fenster wurde geschlossen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860109", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Here the dialog closed automatically after the quest was turned in. Interact with the NPC again by pressing the (G) key.",
                  ["deDE"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 6,
                        ["deDE"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "3596",
                        ["deDE"] = "3596",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [108]
            {
               ["GUID"] = "168370332978060121",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
                  ["deDE"] = "Ins Trainerfenster gelangen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860110", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Now select (I want to be trained). Then the trainer dialog box will open.",
                  ["deDE"] = "Wähle nun (Ich möchte ausgebildet werden. Dann öffnet sich das Lehrerfenster.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 7,
                        ["deDE"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [109]
            {
               ["GUID"] = "168370332978060122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860111", -- [1]
                  },
               },
            }, -- [110]
            {
               ["GUID"] = "168370332978060123",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
                  ["deDE"] = "Navigation im Lehrerfenster",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "This is the trainer dialog box. First you will find the category and below that the spell. For you this trainer has in the category (Survival) the spell (Track Beasts). The spell is already selected. Further down, the spell name is repeated (Track Beasts). Before that, (text) is pronounced. This is the (button) for the spell that is selected. Now search for this button.",
                  ["deDE"] = "Dies ist das Lehrerfenster. Zuerst findest du jeweils die Kategorie und darunter den Zauber. für dich hat dieser Lehrer in der Kategorie (Überleben) den Zauber (Wildtiere aufspüren). Der Zauber ist bereits ausgewählt. Weiter unten wiederholt sich der Zaubername (Wildtiere aufspüren). Davor wird (text) angesagt. Das ist der (Button) für den Zauber, der ausgewählt ist. Suche nun diesen button.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 7,
                        ["deDE"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "9,1,4",
                        ["deDE"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [111]
            {
               ["GUID"] = "168370332978060124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860113", -- [1]
                  },
               },
            }, -- [112]
            {
               ["GUID"] = "168370332978060125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860114", -- [1]
                  },
               },
            }, -- [113]
            {
               ["GUID"] = "168370332978060126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860115", -- [1]
                  },
               },
            }, -- [114]
            {
               ["GUID"] = "168370332978060127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860116", -- [1]
                  },
               },
            }, -- [115]
            {
               ["GUID"] = "168370332978060128",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860117", -- [1]
                  },
               },
            }, -- [116]
            {
               ["GUID"] = "168370332978060129",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
                  ["deDE"] = "knopf leer machen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "(Assign no action) is the menu item to remove an assigned action from the button. Under the menu item you can find different categories. If you go to the right on a category, you will find the spells of the category that can be assigned to the button. Search for the spell Track Beasts ",
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche den zauber Wildtiere aufspüren ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "beasts",
                        ["deDE"] = "Wildtiere",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["GUID"] = "168370332978060130",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860119", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "Great! You have found the spell. You can also read the details here with the tooltip feature. Now put the spell on the button by pressing (Enter). Then close the action bar menu with (Escape).",
                  ["deDE"] = "Super! du hast den Zauber gefunden. Du kannst die Details auch hier mit der Tooltipfunktion lesen. Lege den Zauber nun auf den button indem du die (Eingabetaste) drückst. Schließe das Aktionsleistenmenü dann mit (Escape).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 28,
                        ["deDE"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = 2,
                        ["deDE"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [118]
            {
               ["GUID"] = "168370332978060131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860120", -- [1]
                  },
               },
            }, -- [119]
            {
               ["GUID"] = "168370332978060132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860121", -- [1]
                  },
               },
            }, -- [120]
            {
               ["GUID"] = "168370332978060133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860122", -- [1]
                  },
               },
            }, -- [121]
            {
               ["GUID"] = "168370332978060134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860123", -- [1]
                  },
               },
            }, -- [122]
            {
               ["GUID"] = "168370332978060135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860124", -- [1]
                  },
               },
            }, -- [123]
            {
               ["GUID"] = "168370332978060136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860125", -- [1]
                  },
               },
            }, -- [124]
            {
               ["GUID"] = "168370332978060137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860126", -- [1]
                  },
               },
            }, -- [125]
            {
               ["GUID"] = "168370332978060138",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["enUS"] = "UNTRANSLATED:deDE:Was dich erwartet",
                  ["deDE"] = "Was dich erwartet",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860127", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["enUS"] = "There in the next village, that is called Dolanaar, it won't be the same as here. Here no enemy will attack you by himself. But there you will find much more dangerous enemies in the forest. Aggressive night-sabers and other animals. You may even be attacked on the road by the wayfarers of the creaky claws. When you target an enemy here, it is pronounced before the enemy's name (passive). All enemies that are aggressive and attack you as soon as you come near them do not have this addition. By the way, if an enemy attacks you, you automatically have him in the target. You only have to press (G) to attack him. You might have to align yourself as a hunter in the right direction and turn around. Continue manually.",
                  ["deDE"] = "Dort in der nächsten Ortschaft, welche Dolanaar heißt, wird es nicht mehr so sein wie hier. Hier greift dich kein Gegner von allein an. Dort finden sich im Wald aber weitaus gefährlichere Gegner. Aggressive Nachtsäbler und sonstiges Getier. Es kann sogar sein, dass du auf der Straße von Wegelagern der Knarzklauen angegriffen wirst. Wenn du hier einen Gegner ins Ziel nimmst, wird vor dem Namen des Gegners (passiv) angesagt. Alle Gegner, die aggressiv sind und dich angreifen, sobald du in ihre Nähe kommst, haben diesen Zusatz nicht. Wenn dich ein Gegner angreift hast du ihn übrigens automatisch im Ziel. Du musst dann nur (G) drücken um ihn anzugreifen. Möglicherweise musst du dich dann als Jäger noch in die richtige Richtung ausrichten und dich also drehen. Schalte manuell weiter.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = 1,
                        ["deDE"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [126]
            {
               ["GUID"] = "168370332978060139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860128", -- [1]
                  },
               },
            }, -- [127]
            {
               ["GUID"] = "168370332978060140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860129", -- [1]
                  },
               },
            }, -- [128]
            {
               ["GUID"] = "168370332978060141",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860130", -- [1]
                  },
               },
            }, -- [129]
            {
               ["GUID"] = "168370332978060142",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
                  ["168388788465100001"] = {
                     "1683887948128860131", -- [1]
                  },
               },
            }, -- [130]
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Nachtelf Jäger eins",
            ["enUS"] = "Night elf hunter one",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = true,
         ["lockKeyboard"] = true,
         ["playFtuIntro"] = true,
         ["requirements"] = {
            ["race"] = 4,
            ["skill"] = 999,
            ["class"] = 3,
         },
      },
      ["168111672832530001"] = {
         ["lockKeyboard"] = true,
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 1,
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Krieger 1",
            ["enUS"] = "Human Warrior 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["playFtuIntro"] = true,
         ["GUID"] = "168111672832530001",
         ["steps"] = {
            {
               ["GUID"] = "168111674145670002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "168111674145670003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "168111674145670004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "168111674145670005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "168111674145670006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "168111674145670007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "168111674145670008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "168111674145670009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "168111674145670010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "168111674145670011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "168111674145670012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "168111674145670013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "168111674145670014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "168111674145670015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "168111674145670016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "168111674145670017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "168111674145670018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837016041575950002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "168111674145670019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "168111674145670020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "168111674145670021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "168111674145670022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "168111674145670023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "168111674145670024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "168111674145670025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "168111674145670026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "168111674145670027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "168111674145670028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "168111674145670029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "168111674145670030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "168111674145670031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "168111674145670032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "168111674145670033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["GUID"] = "168111674145670034",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490034",
               },
               ["linkedIn"] = {
               },
            }, -- [34]
            {
               ["GUID"] = "168111674145670035",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490035",
               },
               ["linkedIn"] = {
               },
            }, -- [35]
            {
               ["GUID"] = "168111674145670036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [36]
            {
               ["GUID"] = "168111674145670037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [37]
            {
               ["GUID"] = "168111674145670038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "168111674145670039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "168111674145670040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "168111674145670041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "168111674145670042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "168111674145670043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "168111674145670044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "168111674145670045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "168111674145670046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "168111674145670047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490047",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "168111674145670048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "168111674145670049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "168111674145670050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "168111674145670051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490051",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "168111674145670052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "168111674145670053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "168111674145670054",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490054",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "168111674145670055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "168111674145670056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["GUID"] = "168111674145670057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "168111674145670058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "168111674145670059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "168111674145670060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "168111674145670061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "168111674145670062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "168111674145670063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "168111674145670064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "168111674145670065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "168111674145670066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "168111674145670067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "168111674145670068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "168111674145670069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "168111674145670070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "168111674145670071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "168111674145670072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "168111674145670073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "168111674145670074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "168111674145670075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "168111674145670076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "168111674145670077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "168111674145670078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "168111674145670079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "168111674145670080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "168111674145670081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "168111674145670082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "168111674145670083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "168111674145670084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "168111674145670085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "168111674145670086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490086",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "168111674145670087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["GUID"] = "168111674145670088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [88]
            {
               ["GUID"] = "168111674145670089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "168111674145670090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "168111674145670091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "168111674145670092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "168111674145670093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "168111674145670094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "168111674145670095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "168111674145670096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "168111674145670097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "168111674145670098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "168111674145670099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "168111674145670100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "168111674145670101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "168111674145670102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "168111674145670103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "168111674145670104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "168111674145670105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "168111674145670106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "168111674145670107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490107",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "168111674145670108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["GUID"] = "168111674145670109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [109]
            {
               ["GUID"] = "168111674145670110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "168111674145670111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "168111674145670112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "168111674145670113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "168111674145670114",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490111",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "168111674145670115",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490114",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["GUID"] = "168111674145670116",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490115",
               },
               ["linkedIn"] = {
               },
            }, -- [116]
            {
               ["GUID"] = "168111674145670117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [117]
            {
               ["GUID"] = "168111674145670118",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [118]
            {
               ["GUID"] = "168111674145670119",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490118",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["GUID"] = "168111674145670120",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490119",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["GUID"] = "168111674145670121",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [121]
            {
               ["GUID"] = "168111674145670122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490121",
               },
               ["linkedIn"] = {
               },
            }, -- [122]
            {
               ["GUID"] = "168111674145670123",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
               },
            }, -- [123]
            {
               ["GUID"] = "168111674145670124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
               },
            }, -- [124]
            {
               ["GUID"] = "168111674145670125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
               },
            }, -- [125]
            {
               ["GUID"] = "168111674145670126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "168111674145670127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "168111674145670128",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490127",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["GUID"] = "168111674145670129",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490128",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["GUID"] = "168111674145670130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [130]
            {
               ["GUID"] = "168111674145670131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [131]
            {
               ["GUID"] = "168111674145670132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [132]
            {
               ["GUID"] = "168111674145670133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [133]
            {
               ["GUID"] = "168111674145670134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [134]
            {
               ["GUID"] = "168111674145670135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [135]
            {
               ["GUID"] = "168111674145670136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [136]
            {
               ["GUID"] = "168111674145670137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "168111674145670138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [138]
            {
               ["GUID"] = "168111674145670139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "168111674145670140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "168111674145670141",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
         },
      },
      ["16807134034490001"] = {
         ["GUID"] = "16807134034490001",
         ["showAsTemplate"] = true,
         ["steps"] = {
            {
               ["GUID"] = "16807134034490002",
               ["beginText"] = {
                  ["deDE"] = "Ein Held wurde geboren! Willkommen in Azeroth %name%. Helden vollführen Heldentaten. Wenn du dich im Kampf beweist, dann wirst du bald in die Welt hinausgehen können und unglaubliche Abenteuer erleben. Um Erfahrung zu erhalten und größer zu werden, solltest du Quests erledigen. Oft bekommst du dafür dann auch bessere Ausrüstung zur Belohnung. Schalte das Tutorial jetzt mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter.",
                  ["enUS"] = "A hero has been born! Welcome to Azeroth %name%. Heroes perform heroic deeds. If you prove yourself in battle, you will soon be able to go out into the world and experience incredible adventures. To gain experience and grow, you should complete quests. Often you'll get better equipment as a reward. Continue the tutorial now with %SKU_KEY_TUTORIALSTEPFORWARD%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890003", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050002", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560001", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610002", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390002", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670001", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670002", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fangen wir an",
                  ["enUS"] = "UNTRANSLATED:deDE:Fangen wir an",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [1]
            {
               ["GUID"] = "16807134034490003",
               ["beginText"] = {
                  ["deDE"] = "Direkt vor dir steht %npc_id:000823% mit der ersten Quest für dich. Quests sind aufgaben, die du erledigen kannst. Zur belohnung erhälst du Erfahrungspunkte, Items und oder Geld. Du musst %npc_id:000823% zunächst ins Ziel nehmen. Halte hierfür die (Steuerungstaste) und die (Umschalttaste) gedrückt und drücke dann einmal auf die (Tabulatortaste). Mit dieser Tastenkombination kannst du freundliche Ziele ins Ziel nehmen.",
                  ["enUS"] = "Right in front of you is %npc_id:000823% with the first quest for you. Quests are tasks that you can complete. As a reward you get experience points, items and or money. You have to target %npc_id:000823% first. To do this, press and hold the (control) key and the (shift) key, then press the (tab) key once. You can target friendly targets with this shortcut.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890004", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670003", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670002", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390003", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610003", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560002", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "NPC ins Ziel nehmen",
                  ["enUS"] = "UNTRANSLATED:deDE:NPC ins Ziel nehmen",
               },
               ["endText"] = "Gut gemacht. Du hast ihn im Ziel",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "823",
                        ["enUS"] = "823",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [2]
            {
               ["GUID"] = "16807134034490004",
               ["beginText"] = {
                  ["deDE"] = "Finde heraus, was er von dir möchte %name%. Um mit %npc_id:000823% zu sprechen musst du zu ihm laufen und mit ihm interagieren. Das machst du mit der Taste G. Drücke nun also einmal (G)",
                  ["enUS"] = "Find out what he wants from you %name%. To talk to %npc_id:000823% you need to move to him and interact with him. You do that with the G key. So now press (G) once.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890005", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670004", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670003", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390004", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610004", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560003", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Mit Ziel interagieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Mit Ziel interagieren",
               },
               ["endText"] = "",
               ["allTriggersRequired"] = false,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [3]
            {
               ["GUID"] = "16807134034490005",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Öffnungsfeld",
                  ["enUS"] = "UNTRANSLATED:deDE:Öffnungsfeld",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890006", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050005", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560004", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610005", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390005", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670004", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670005", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Sicher hast du bemerkt, dass sich ein Dialogfenster geöffnet hat. du konntest möglicherweise ein (klack) Geräusch hören und der NPC hat auch mit dir gesprochen. um den Inhalt eines Fensters zu lesen, gehe nach Rechts durch das drücken der (Pfeil rechts) Taste.",
                  ["enUS"] = "Surely you noticed that a dialog pane opened. you might have heard a (clack) sound and the NPC also talked to you. to read the contents of a window, go to the right by pressing the (right arrow) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [4]
            {
               ["GUID"] = "16807134034490006",
               ["beginText"] = {
                  ["deDE"] = "Du bist nun vom Menüpunkt (Quests) nach rechts gegangen. Du hast bemerkt, dass die Sprachausgabe (Details) (Plus) vorgelesen hat. Das bedeutet, du stehst auf dem menüpunkt (Details). Das (Plus) verrät dir, dass du mit Pfeil rechts in das Menü hineingehen kannst. Drücke (Pfeil rechts).",
                  ["enUS"] = "You have now moved from the menu item (Quests) to the right. You noticed that the voice output (Details) read out (Plus). This means you are on the menu item (Details). The (Plus) tells you that you can enter the menu with right arrow. Press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890007", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050006", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560005", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610006", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390006", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670005", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670006", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Im Fenster navigieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Im Fenster navigieren",
               },
               ["endText"] = "Du stehst nun ganz oben auf der Überschrift. Mit Pfeil hoch und runter kannst du in diesem Fenster lesen.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 69,
                        ["enUS"] = 69,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1,1",
                        ["enUS"] = "9,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [5]
            {
               ["GUID"] = "16807134034490007",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Questtext lesen",
                  ["enUS"] = "UNTRANSLATED:deDE:Questtext lesen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890008", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050007", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560006", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610007", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390007", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670006", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670007", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist deine erste Quest. Du kannst mit (Pfeil Runter) den Inhalt Stück für Stück lesen. Suche nach der Schaltfläche (Annehmen).",
                  ["enUS"] = "This is your first quest. You can use (Down arrow) to read the content part by part. Look for the (Accept) button.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1,6",
                        ["enUS"] = "9,1,1,6",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [6]
            {
               ["GUID"] = "16807134034490008",
               ["beginText"] = {
                  ["deDE"] = "Richtig. Dies ist die Schaltfläche. Das Plus am Ende vom Text sagt dir, dass ein untermenü vorhanden ist. Öffne das Untermenü mit (Pfeil rechts).",
                  ["enUS"] = "Right. This is the button. The plus at the end of the text tells you that there is a submenu. Open the submenu with (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890009", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050008", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560007", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610008", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390008", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670007", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670008", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest annehmen mit annehmen Schaltfläche",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest annehmen mit annehmen Schaltfläche",
               },
               ["endText"] = "Nun hast du die Quest angenommen. Das Fenster hat sich automatisch geschlossen.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 69,
                        ["enUS"] = 69,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1,6,1",
                        ["enUS"] = "9,1,1,6,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [7]
            {
               ["GUID"] = "16807134034490009",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "untermenü klicken",
                  ["enUS"] = "UNTRANSLATED:deDE:untermenü klicken",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890010", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050009", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560008", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610009", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390009", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670008", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670009", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist das Untermenü für die Schaltfläche. Du wirst sehr häufig Schaltflächen bestätigen müssen. Bestätige also in diesem Untermenü bitte (Linksklick) mit der (eingabetaste). (Linksklick) ist ganz oben und du stehst schon darauf. Also drücke einfach nur die (Eingabetaste). ",
                  ["enUS"] = "This is the submenu for the button. You will have to confirm buttons very often. So please confirm (left click) with (enter) in this submenu. (Left click) is at the top and you are already on it. So just press (enter). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 58,
                        ["enUS"] = 58,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [8]
            {
               ["GUID"] = "16807134034490010",
               ["beginText"] = {
                  ["deDE"] = "%name% - du hast deine erste Quest angenommen. Im Questbuch kannst du alle Quests sehen, die du angenommen hast. Öffne das Questbuch mit der Taste (L).",
                  ["enUS"] = "%name% - you have accepted your first quest. In the quest log you can see all the quests you have accepted. Open the quest log with the (L) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890011", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050010", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560009", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610010", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390010", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670009", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670010", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Questbuch öffnen",
                  ["enUS"] = "UNTRANSLATED:deDE:Questbuch öffnen",
               },
               ["endText"] = "Du hast mit L dein Questbuch geöffnet.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [9]
            {
               ["GUID"] = "16807134034490011",
               ["beginText"] = {
                  ["deDE"] = "Dein Questbuch hat sich geöffnet. Es gibt eine Übersicht, in der deine Quests in Regionen und Kategorien einsortiert werden. Um dort hin zu gelangen drücke einmal (Pfeil rechts)",
                  ["enUS"] = "Your quest log has opened. There is an overview where your quests are sorted into regions and categories. To get there press once (right arrow)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890012", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050011", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560010", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610011", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390011", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670010", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670011", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zur gebietsübersicht",
                  ["enUS"] = "UNTRANSLATED:deDE:zur gebietsübersicht",
               },
               ["endText"] = "Diese Ebene funktioniert wie ein Filter. Die Quests werden nach Gebiet einsortiert. Du kannst mit Pfeil runter ein Gebiet wählen und dann darin die Quests dieses Gebietes finden.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1",
                        ["enUS"] = "4,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [10]
            {
               ["GUID"] = "16807134034490012",
               ["beginText"] = {
                  ["deDE"] = "Hier bist du richtig. Wenn du viele Quests hast, kannst du hier mit Pfeil hoch und runter die Kategorie deiner Region wählen und nur die Quests dieser Region anzeigen lassen. du hast nur eine Quest. Du stehst auf der Kategorie (Alle). Gehe jetzt in diese Kategorie, und drücke dafür (Pfeil rechts).",
                  ["enUS"] = "Here you are right. If you have a lot of quests, you can use up arrow and down arrow here to choose the category of your region and show only the quests of your region. you have only one quest. You are on the category (All). Now go to this category and press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890013", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050012", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560011", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610012", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390012", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670011", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670012", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest finden und im Questbuch lesen.",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest finden und im Questbuch lesen.",
               },
               ["endText"] = "Hier sind die Quests aufgelistet, die du bereits angenommen hast.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1",
                        ["enUS"] = "4,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [11]
            {
               ["GUID"] = "16807134034490013",
               ["beginText"] = {
                  ["deDE"] = "Das ist die Quest, die du eben angenommen hast. Hier in deinem Questbuch hast du für jede Quest die Tooltip-Funktion. Um den Inhalt der Quest mit der Tooltip-Funktion zu lesen, sollst du nun die Umschalttaste dauerhaft festhalten und den Tooltip durch einmaliges drücken der (Pfeil runter) Taste öffnen. Es ertönt ein Pling. Der Tooltip hat sich geöffnet. Jedesmal, wenn du nun (Pfeil runter) drückst, wird ein neuer Absatz vorgelesen. Dabei hälst du die (Umschalttaste) die ganze Zeit lang fest. Wenn du die (Umschalttaste) loslässt hörst du wieder ein Pling und der Tooltip schließt sich. Versuche, die ganze Quest nun nochmal zu lesen. Drücke also die (Umschalttaste) dauerhaft und drücke so oft auf (Pfeil runter) bis du ganz unten angekommen bist.",
                  ["enUS"] = "This is the quest you just accepted. Here in your quest log you have the tooltip feature for each quest. To read the content of the quest with the tooltip feature, you should now hold down the shift key and open the tooltip by pressing the (down arrow) key once. You will hear a pling. The tooltip has opened. Each time you now press (down arrow), a new paragraph is read out. You hold down the (Shift) key the whole time. When you release (Shift) you will hear a pling again and the tooltip will close. Now try to read the whole quest again. So press (Shift) permanently and press (Down arrow) repeatedly until you reach the bottom.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890014", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560012", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610013", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390013", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670012", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670013", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest im Buch lesen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest im Buch lesen",
               },
               ["endText"] = "Sehr gut. Deine Aufgabe ist es, mit dem Marschal zu sprechen.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "hinter mir",
                        ["enUS"] = "behind me",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [12]
            {
               ["GUID"] = "16807134034490014",
               ["beginText"] = {
                  ["deDE"] = "Du kennst nun deine Quest. Du sollst mit %npc_id:000197% sprechen. Um zu einem Ziel zu laufen, solltest du das Navigationssystem benutzen. Immer wenn du auf einer Quest im Questbuch stehst, kannst du einmal nach rechts gehen, um in das Navigationsmenü zu gelangen. Drücke dafür bitte jetzt (Pfeil rechts)",
                  ["enUS"] = "You now know your quest. You should talk to %npc_id:000197%. To move to a destination, you should use the navigation system. Whenever you are on a quest in the quest log, you can go right once to get to the navigation menu. To do this, press (right arrow) now.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890015", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560013", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610014", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390014", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670013", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670014", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationnsmenü im Questbuch nutzen",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationnsmenü im Questbuch nutzen",
               },
               ["endText"] = "Hier kannst du verschiedene Zielnavigationen starten. Zur questannahme, zur Abgabe und auch zu Zielen, falls ein Ziel notwendig ist.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,1",
                        ["enUS"] = "4,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [13]
            {
               ["GUID"] = "16807134034490015",
               ["beginText"] = {
                  ["deDE"] = "Hier im Navigationsmenü kannst du verschiedene Navigationsziele wählen, die du unter verschiedenen Menüpunkten finden kannst. der Menüpunkt (Annahme) beinhaltet den Ort der (Questannahme). unter dem Menüpunkt (Ziel) der später auftauchen wird findest du den ort der (Gegner) und ganz unten befindet sich der Menüpunkt (Abgabe), der den Ort der (Questabgabe) beinhaltet. Du hast die Quest bereits angenommen. Du möchtest die Quest nun abgeben. Gehe also bitte auf (Abgabe) mit (Pfeil runter).",
                  ["enUS"] = "Here in the navigation menu you can choose different navigation destinations, which you can find under different menu items. the menu item (Acceptance) contains the location of the (Quest start). under the menu item (Quest target) which will appear later you will find the location of the (Enemies) and at the very bottom there is the menu item (Quest end), which contains the location of the (Quest end). You have already accepted the quest. Now you want to turn in the quest. So please go to (Quest end) with (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890016", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560014", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610015", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390015", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670014", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670015", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zur Questabgabe navigieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Zur Questabgabe navigieren",
               },
               ["endText"] = "Bei diesem NPC sollst du die Quest abgeben. ",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2",
                        ["enUS"] = "4,1,1,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [14]
            {
               ["GUID"] = "16807134034490016",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "rein in die Abgabe",
                  ["enUS"] = "UNTRANSLATED:deDE:rein in die Abgabe",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890017", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670016", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670015", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390016", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610016", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560015", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du möchtest nun wissen, wohin du laufen musst, um die Quest abzugeben. Das Navigationsmenü bietet dir unter dem Menüpunkt (Abgabe) Ziele für die Questabgabe an. drücke einmal (Pfeil rechts).",
                  ["enUS"] = "You now want to know where to move in order to turn in the quest. The navigation menu offers you destinations for the quest end under the menu item (Quest end). press once (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2,1",
                        ["enUS"] = "4,1,1,1,2,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [15]
            {
               ["GUID"] = "16807134034490017",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "auf dem Navivorschlag nach rechts",
                  ["enUS"] = "UNTRANSLATED:deDE:auf dem Navivorschlag nach rechts",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890018", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670017", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571670016", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390017", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610017", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560016", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist ein Zielvorschlag vom Navigationssystem. Hier können auch mehrere Ziele vorgeschlagen werden. Du könntest die ganzen Vorschläge hier mit Pfeil hoch und runter begutachten. In diesem Fall ist der Vorschlag auf dem du jetzt stehst, das richtige Ziel. Du sollst ja zu %npc_id:000197% laufen und deshalb drückst du nun (Pfeil rechts).",
                  ["enUS"] = "This is a destination suggestion from the navigation system. You can also have multiple suggested destinations here. You could examine all the suggestions here with up arrow and down arrow. In this case the suggestion you are on now is the right destination. You should move to %npc_id:000197% and so you press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2,1,1",
                        ["enUS"] = "4,1,1,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [16]
            {
               ["GUID"] = "16807134034490018",
               ["beginText"] = {
                  ["deDE"] = "Hier findest du verschiedene Arten der Navigation. Es gibt (Ruten), (nahe Ruten) und (Wegpunkte). Du möchtest eine Rute, die dich sicher von A nach B führt. gehe also auf Rute einmal nach rechts um Einstiegspunkt und Ziel zu definieren. Drücke (Pfeil rechts).",
                  ["enUS"] = "Here you will find different types of navigation. There are (routes), (close routes) and (waypoints). You want a route that leads you safely from A to B. So go to route once to the right to define entry point and destination. Press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890019", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050018", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560017", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610018", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390018", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680017", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670018", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Was sind routen?",
                  ["enUS"] = "UNTRANSLATED:deDE:Was sind routen?",
               },
               ["endText"] = "Das ist dein Ziel.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,2,1,1,1",
                        ["enUS"] = "4,1,1,1,2,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [17]
            {
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "16837017021672600005", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050019", -- [1]
                  },
                  ["168111672832530001"] = {
                     "16837016041575950002", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16837015631534460001", -- [1]
                  },
                  ["168111678387860001"] = {
                     "16837016761646800004", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16837017261696420006", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16837016421612550003", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Einstiegspunkt erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Einstiegspunkt erklären",
               },
               ["GUID"] = "1683700188158850001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist der vorletzte Schritt im Navigationsmenü. Du kannst hier deinen einstiegspunkt auswählen. Damit ist der Startpunkt deiner Rutennavigation gemeint. In der regel kannst du einfach den obersten Punkt nehmen. Nur später, wenn Gebäude mehrere Etagen haben, dann musst du darauf achten, dass du einen Einstiegspunkt wählst, der auch auf deiner Ebene liegt. Gehe nun einfach einmal mit (Pfeil rechts) nach rechts.",
                  ["enUS"] = "This is the second last step in the navigation menu. You can select your starting point here. This is the starting point of your route navigation. Usually you can just take the topmost point. Only later, if buildings have several floors, then you must pay attention to the fact that you select an entry point, which is located on your level. Now just go once with (right arrow) to the right.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,1,1,1,1",
                        ["deDE"] = "4,1,1,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [18]
            {
               ["GUID"] = "16807134034490019",
               ["beginText"] = {
                  ["deDE"] = "Dies ist nun ein auswählbares Navigationsziel. Es kann mehrere geben, welche du über Pfeil hoch und runter anwählen könntest. %npc_id:000197% gibt es hier aber nur einmal. Du hast die Entfernung gehört und am ende wurde kein Plus angehängt. Es gibt also kein Untermenü. Starte die Navigation indem du die (Eingabetaste) drückst.",
                  ["enUS"] = "This is now a selectable navigation destination. There can be more than one, which you can select via up arrow and down arrow. %npc_id:000197% exists only once here. You heard the distance and at the end no plus was added. So there is no submenu. Start the navigation by pressing (Enter).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890020", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670019", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680018", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390019", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610019", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560018", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation starten.",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation starten.",
               },
               ["endText"] = "Du hörst nun ein neues Geräusch. Es ist ein Audiobeacon, der dir sagt, wohin du laufen musst.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 27,
                        ["enUS"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,1,1,1,1",
                        ["deDE"] = "4,1,1,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [19]
            {
               ["GUID"] = "16807134034490020",
               ["beginText"] = {
                  ["deDE"] = "Die Navigation wurde gestartet. Das neue Geräusch ist ein Audiobeacon. Wenn du dich mit (A) und (D) drehst, hörst du, wo sich der Audiobeacon befindet. Wenn du dir nicht sicher bist, kannst du durch drücken der Taste Alt(Gr), die sich (rechts) neben der (Leertaste) befindet, erfahren, in welche Richtung du dich drehen musst und wie weit der weg bis zum Nächsten Beacon ist. 11 Uhr bedeutet schräg links vor dir. 3 Uhr bedeutet rechts neben dir, also genau wie bei einer Uhr. Drehe dich mit den Tasten A und D oder den Pfeiltasten, bis das Beacon auf 12 Uhr liegt. Du kannst auch ein Piep-Puup-signalgeräusch hören, wenn du 12 Uhr triffst. Laufe dann mit W oder Pfeil hoch vorwärts, bis du den Beacon erreicht hast.",
                  ["enUS"] = "Navigation has been started. The new sound is an audio beacon. If you turn around with (A) and (D) you will hear where it is. If you are not sure, pressing (Control) and (Alt) will tell you which direction to turn around and how far away it is. 11 o'clock means diagonally left in front of you. 3 o'clock means to the right of you. Turn around with the A and D keys or the arrow keys until the beacon is at 12 o'clock. You can also hear a beep-puup sound when you hit 12 o'clock. Then move forward with W or up arrow until you reach the beacon.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890021", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670020", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680019", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390020", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610020", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560019", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationsstart",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationsstart",
               },
               ["endText"] = "Geschafft! Gut gemacht!",
               ["allTriggersRequired"] = false,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8924.4;-116.8;5",
                        ["enUS"] = "-8924.4;-116.8;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [20]
            {
               ["GUID"] = "16807134034490021",
               ["beginText"] = {
                  ["deDE"] = "Gut gemacht. Du hast den Beacon erreicht, es hat Pling gemacht. Dies ist das Audiosignal, woran du erkennst, dass du den Beacon erreicht hast. nun ist ein neuer Beacon erschienen, den du erreichen musst. Du läufst relativ frei in der Welt herum. Es gibt ein Warngeräusch, welches dir sagen soll, wenn du feststeckst. du kannst dann ein hohes Piep Piep Piep hören. Gehe dann kurz rückwärts und mache einen kleinen Bogen. Manchmal hilft es auch, mit der Leertaste zu springen. Du musst auf jeden Fall selbständig zum nächsten Beacon gelangen. Erinnere dich. Mit der Taste Alt (GR) (rechts) neben der (Leertaste) kannst du abfragen, wo sich der Audiobeacon genau befindet. Im Notfall kannst du die Rute zurückschalten, indem du mit (Steuerungstaste) (Umschalttaste) und einen druck auf (S) den vorherigen Beacon aktivierst. Laufe jetzt weiter zum nächsten Beacon und dann die Rute bis zum Ende.",
                  ["enUS"] = "Well done. You reached the beacon, there was a pling and the beacon disappeared. A new beacon has appeared instead, and you have to reach it. You are moving around relatively freely in the world. There is a warning sound that tells you when you are stuck. It then makes beep beep beep. Then walk backwards for a second and do a small turn. Sometimes it also helps to jump with the spacebar. You have to get to the next beacon on your own. Remember. With (Control) and (Alt) you can query where the beacon is. If necessary you can switch one waypoint back by pressing (control) (shift) and (S) to activate the previous beacon. Now move on to the next beacon and then follow the route to the end.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890022", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670021", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680020", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390021", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610021", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560020", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Weiterlaufen bis zum Ziel",
                  ["enUS"] = "UNTRANSLATED:deDE:Weiterlaufen bis zum Ziel",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8903.0;-163.0;5",
                        ["enUS"] = "-8903.0;-163.0;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [21]
            {
               ["GUID"] = "16807134034490022",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ende der Rute",
                  ["enUS"] = "UNTRANSLATED:deDE:Ende der Rute",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890023", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670022", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680021", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390022", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610022", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560021", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist am ende der Rute angekommen. du solltest nun keinen Audiobeacon mehr hören. Wenn du nicht genau getroffen hast, versuche zuerst, genau bis zu dem Beacon zu laufen, so dass die rute beendet wird. Schalte das Tutorial dann mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter.",
                  ["enUS"] = "You have reached the end of the route. you should not hear any more Beacon now. If you didn't hit it exactly, first try to move exactly to the beacon so that the route stops. Then continue the tutorial with %SKU_KEY_TUTORIALSTEPFORWARD%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [22]
            {
               ["GUID"] = "16807134034490023",
               ["beginText"] = {
                  ["deDE"] = "Versuche nun, %npc_id:000197% ins Ziel zu nehmen. Sollte es nicht funktionieren, stehst du möglicherweise nicht so, dass er sich vor dir befindet. Gehe dann ein paar Schritte zurück oder drehe dich. Versuche wiederholt %npc_id:000197% mit der Tastenkombination (Steuerung) und (Umschalttaste) und einen Druck auf (Tabulator) zu finden.",
                  ["enUS"] = "Now try to target %npc_id:000197%. If it doesn't work, you may not be facing him. Then take a few steps back or turn around. Repeatedly try to find %npc_id:000197% with the shortcut Control and Shift and Tab.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890024", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670023", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680022", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390023", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610023", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560022", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ziel - NPC ansprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ziel - NPC ansprechen",
               },
               ["endText"] = "Getroffen!",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "197",
                        ["enUS"] = "197",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [23]
            {
               ["GUID"] = "16807134034490024",
               ["beginText"] = {
                  ["deDE"] = "Mit der Taste (G) kannst du NPCs ansprechen. Du interagierst sozusagen mit deinem Ziel. Drücke jetzt (G)",
                  ["enUS"] = "With the (G) key you can interact with NPCs. You are interacting with your target, so to speak. Now press (G)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890025", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670024", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680023", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390024", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610024", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560023", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Interagieren mit NPC",
                  ["enUS"] = "UNTRANSLATED:deDE:Interagieren mit NPC",
               },
               ["endText"] = "Das Dialogfenster hat sich geöffnet.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "197",
                        ["enUS"] = "197",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [24]
            {
               ["GUID"] = "16807134034490025",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Dialogfenster start",
                  ["enUS"] = "UNTRANSLATED:deDE:Dialogfenster start",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890026", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670025", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680024", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390025", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610025", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560024", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das Dialogfenster ist nun geöffnet. Du stehst auf (Dialog) (plus). Das (plus) sagt dir, dass du nach rechts weitergehen kannst. Drücke (Pfeil rechts).",
                  ["enUS"] = "The dialog pane has opened. You are on (dialog) (plus). The (plus) tells you that you can go to the right. Press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [25]
            {
               ["GUID"] = "16807134034490026",
               ["beginText"] = {
                  ["deDE"] = "Dieses Dialogfenster bietet normalerweise viele verschiedene Optionen an. Hier hat der Questgeber nur eine Option für dich. Es ist deine Quest, die du abgeben möchtest. Gehe nach unten auf deine Quest. Drücke dafür einmal (Pfeil runter). ",
                  ["enUS"] = "This dialog pane could have many different options. Here the quest giver has only one option for you. It is your quest that you want to turn in. Go down to your quest. Press down arrow once. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890027", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670026", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680025", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390026", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610026", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560025", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Dialogfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Dialogfenster",
               },
               ["endText"] = "Hier kannst du die Quest abgeben.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2",
                        ["enUS"] = "9,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [26]
            {
               ["GUID"] = "16807134034490027",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In die q zum abgeben gehen",
                  ["enUS"] = "UNTRANSLATED:deDE:In die q zum abgeben gehen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890028", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670027", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680026", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390027", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610027", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560026", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Der Hinweis (angenommene Quest) sagt dir, dass du diese Quest bereits angenommen hast und sie sich in deinem Questbuch befindet. Du musst sie nun auswählen, um sie hier bei diesem NPC abzugeben. Öffne dafür das Untermenü. Das (Plus) am Ende des Questnamen sagt dir, dass es ein Untermenü gibt. Um es zu öffnen drücke (Pfeil rechts).",
                  ["enUS"] = "The notice (accepted quest) tells you that you have already accepted this quest and it is in your quest log. You have to select it now to turn it in to this NPC. Open the submenu for it. The (plus) at the end of the quest title tells you that there is a submenu. To open it press (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1",
                        ["enUS"] = "9,1,2,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [27]
            {
               ["GUID"] = "16807134034490028",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "ins questfenster springen",
                  ["enUS"] = "UNTRANSLATED:deDE:ins questfenster springen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890029", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670028", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680027", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120390028", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610028", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560027", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das Untermenü hat sich geöffnet. Du stehst auf der Schaltfläche (Linksklick). Dieser menüpunkt heißt so, weil sehende Spieler mit der Maus einen (Linksklick) ausführen. Du führst den (Linksklick) aus, indem du jetzt die (Eingabetaste) drückst.",
                  ["enUS"] = "The submenu has opened. You are on the button (left click). This menu item is called that because sighted players perform a left click with the mouse. You perform the left click by pressing the (Enter) key now.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [28]
            {
               ["GUID"] = "16807134034490029",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Auf Belohnung hinweisen",
                  ["enUS"] = "UNTRANSLATED:deDE:Auf Belohnung hinweisen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890030", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670029", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680028", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400029", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610029", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560028", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist wieder das Questfenster. Zuerst musst du zwei mal nach rechts gehen, um zum Fensterinhalt zu gelangen. Dann kannst du den Text in diesem Fenster lesen, indem du mit den Pfeiltasten nach unten gehst. Du solltest in diesem Fenster auch das Feld (Belohnungen) finden. Wenn du auf (Belohnungen) nach rechts gehst, kannst du sehen, was du für das Erledigen der Quest erhälst. später musst du unter (Belohnungen) zwischen verschiedenen Gegenständen wählen, indem du auf dem Gegenstand, den du wählen möchtest, einen (Linksklick) im Untermenü des Gegenstandes ausführst. Jetzt bleibt aber alles noch ganz einfach und du musst nichts auswählen. Schalte das tutorial mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter.",
                  ["enUS"] = "This is the quest panel again. First you have to go right twice to get to the content. Then you can read the text in this panel by moving down with the arrow keys. You should also find the (Rewards) section in this panel. If you go to (Rewards) to the right, you can see what you'll get for completing the quest. later you'll have to choose between different items under (Rewards). You do that then by performing a (left click) on the item you want to choose in the item's submenu. Now everything remains simple and you don't have to select anything. Continue the tutorial with %SKU_KEY_TUTORIALSTEPFORWARD%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [29]
            {
               ["GUID"] = "16807134034490030",
               ["beginText"] = {
                  ["deDE"] = "Wenn es für eine Quest mehrere Questbelohnungen gibt , dann kannst du die Quest auch nicht abgeben, ohne vorher eine Belohnung ausgewählt zu haben. Wenn du es trotzdem versuchst, dann kannst du ein lautes Gonggeräusch hören, das dir signalisiert, dass die (Quest) nicht abgegeben wurde. Gebe diese Quest nun ab und suche dafür jetzt die Schaltfläche (Abgeben) und bestätige sie wie eben schon mit der Schaltfläche (Linksklick) im Untermenü. alternativ kannst du einfach (Leertaste) drücken ",
                  ["enUS"] = "If a quest requires you to choose between different rewards, then you can't turn in the quest without doing that either. If you try anyway, you will hear a loud gong sound. Now turn in the quest and look for the (Complete Quest) button and confirm it with the button (left click) in the submenu. Alternatively you can just press spacebar. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890031", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670030", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680029", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400030", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610030", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560029", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest abgeben",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest abgeben",
               },
               ["endText"] = "Gratuliere! Du hast deine erste Aufgabe gemeistert.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 61,
                        ["enUS"] = 61,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [30]
            {
               ["GUID"] = "16807134034490031",
               ["beginText"] = {
                  ["deDE"] = "Gut gemacht %name%. Du hast deine erste Quest abgegeben und Erfahrung dafür erhalten. %npc_id:000197% bietet dir sofort eine neue Quest an, die du jetzt annehmen kannst. Lese dafür das Fenster mit den Pfeiltasten und gehe auf (Annehmen) in das Untermenü. Dort musst du die Schaltfläche (Linksklick) mit (Enter) bestätigen. Alternativ kannst du wieder (leertaste) drücken.",
                  ["enUS"] = "Well done %name%. You turned in your first quest and got experience for it. %npc_id:000197% immediately offers you a new quest. Accept it. To do that, read the panel with the arrow keys and go to (Accept) in the submenu. There you have to confirm the button (left click) with (enter). Alternatively you can press (spacebar) again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890032", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670031", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680030", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400031", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610031", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560030", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest annehmen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest annehmen",
               },
               ["endText"] = "Jetzt hast du eine neue Aufgabe.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 58,
                        ["enUS"] = 58,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [31]
            {
               ["GUID"] = "16807134034490032",
               ["beginText"] = {
                  ["deDE"] = "Auf in den Kampf %class%. Doch um zu kämpfen, musst du zuerst wissen, welche Tasten mit Aktionen belegt sind. Schauen wir uns also zuerst die Aktionsleiste an. Öffne das Menü dafür mit (Umschalttaste) und (F11).",
                  ["enUS"] = "Let's go to battle %class%. But, to fight, you first need to know which keys have actions assigned to them. So let's take a look at the action bar first. Open the menu for it with Shift and F 11",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890033", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050033", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560031", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610032", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400032", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680031", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670032", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Welche Zauber hast du?",
                  ["enUS"] = "UNTRANSLATED:deDE:Welche Zauber hast du?",
               },
               ["endText"] = "Dies ist das Menü für deine Aktionsleisten. Hier kannst du sie auch verändern.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1",
                        ["enUS"] = "5,4,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [32]
            {
               ["GUID"] = "16807134034490033",
               ["beginText"] = {
                  ["deDE"] = "Du befindest dich nun auf der Übersicht der Aktionsleisten. Nach (Unten) findest du die verschiedenen Leisten aufgelistet. Du möchtest dir die erste leiste ansehen. Diese entspricht den Tasten Ziffer 1 bis Apostroph neben der Löschentaste. Drücke jetzt (Pfeil rechts) um auf den ersten Button der ersten Leiste zu gelangen. ",
                  ["enUS"] = "You are now on the action bar overview. At the bottom you will find the different bars listed. You want to look at the first bar. This corresponds to the keys number 1 to 9. Now press (right arrow) to get to the first button of the first bar. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890034", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050034", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560032", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610033", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400033", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680032", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670033", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Aktionsleiste betrachten",
                  ["enUS"] = "UNTRANSLATED:deDE:Aktionsleiste betrachten",
               },
               ["endText"] = "Mit den Pfeiltasten hoch und runter kannst du alle Tasten dieser Leiste anwählen.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1,1",
                        ["enUS"] = "5,4,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [33]
            {
               ["GUID"] = "16807134034490034",
               ["beginText"] = {
                  ["deDE"] = "Auf Button 1 befindet sich also der automatische Angriff. Das bedeutet, dass du damit das automatische Zuschlagen ein und ausschalten kannst. Du solltest den button erst einmal nicht nutzen. Wenn du einen Gegner angreifst, startet das automatische Zuschlagen sowieso von allein. Gehe jetzt runter auf button 2 ",
                  ["enUS"] = "So on button 1 is the auto attack. This means that you can switch the automatic attack on and off. You should not use this button at first. If you attack an enemy, the Auto Attack will start by itself anyway. Now go down to button 2 ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168370330453520001"] = {
                     "168370332978050035", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400034", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680033", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670034", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Automatischer Angriff",
                  ["enUS"] = "UNTRANSLATED:deDE:Automatischer Angriff",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1,2",
                        ["enUS"] = "5,4,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [34]
            {
               ["GUID"] = "16807134034490035",
               ["beginText"] = {
                  ["deDE"] = "auf Taste 2 befindet sich dein hauptangriff (Heldenhafter Stoß). Um ihn auszuführen benötigst du (Wut). Immer wenn du Schaden austeilst, erhälst du dafür (Wut). Wenn du genug (Wut) durch deine Angriffe erhalten hast, kannst du den Angriff (Heldenhafter Stoß) ausführen. Die Details vom (Heldenhaften Stoß) und von allem anderen, was sich auf den Tasten befindet, kannst du mit der Tooltipfunktion lesen. Es ist die gleiche Funktion wie in deinem Questbuch. Halte die (Umschalttaste) gedrückt und gehe Schritt für Schritt mit der Taste (Pfeil runter) nach unten.",
                  ["enUS"] = "On button 2 is your main attack Heroic Strike. To execute it you need rage. Whenever you deal damage, you receive rage in return. When you have received enough rage from your attacks, you can then perform this strike. You can read the details of the Heroic Strike and everything else on the keys with the tooltip feature. It is the same feature as in your quest log. Hold down the (shift) key and go down step by step with the (down arrow) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670035", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit Button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
               },
               ["endText"] = "Du findest hier auch die Reichweite für einen Zauber.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [35]
            {
               ["GUID"] = "16807134034490036",
               ["beginText"] = {
                  ["deDE"] = "Du kannst jetzt die Details der Zauber lesen. Mit (Pfeil hoch) und (Pfeil runter) kannst du dir die ganze Aktionsleiste ansehen und nachlesen, welcher Zauber auf welcher Taste liegt. Wenn du einen ungefähren Überblick über deine Fähigkeiten hast, dann schließe das Menü mit (Escape).",
                  ["enUS"] = "You can now read the details of skills. With up arrow and down arrow you can look at the whole action bar and read which ability is on which key. When you have a rough overview of your abilities, close the menu with ESC.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890037", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050037", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560035", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610036", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400036", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680035", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670036", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Aktionsleiste schließen",
                  ["enUS"] = "UNTRANSLATED:deDE:Aktionsleiste schließen",
               },
               ["endText"] = "Die ESC Taste hat folgende Funktion in einer festen Reihenfolge. Zuerst werden Taschen, Questlog, dialoge oder andere Fenster geschlossen. Zweitrangig wird dein Ziel gelöscht. Wenn du kein Ziel hast und alle Fenster geschlossen sind, dann öffnet die ESC Taste das Spielmenü von Wow. Dann hörst du Walgeräusche. Um dieses Menü wieder zu schließen musst du erneut ESC drücken. ",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [36]
            {
               ["GUID"] = "16807134034490037",
               ["beginText"] = {
                  ["deDE"] = "%name% Nun möchtest du sicher endlich etwas töten! Um die richtigen Gegner zu finden, sollst du die Navigation über das Questbuch benutzen. Drücke also zuerst (L) und dann zwei mal nach (rechts). ",
                  ["enUS"] = "%name% Now you probably want to finally kill something! To find the appropriate enemies, you should use the navigation via the quest log. So press (L) first and then press right twice. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890038", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670037", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680036", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400037", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610037", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560036", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Questbuch ins Navigationsmenü kommen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Questbuch ins Navigationsmenü kommen",
               },
               ["endText"] = "Hier kannst du die Quest nochmal lesen, indem du Umschalttaste und Pfeil runter benutzt. Du kannst übrigens auch zu den Überschriften springen, indem du die Steuerungstaste hinzunimmst. Wenn du fertig bist, gehe nach rechts in die Questnavigation.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1",
                        ["enUS"] = "4,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [37]
            {
               ["GUID"] = "16807134034490038",
               ["beginText"] = {
                  ["deDE"] = "Du kannst die Quest natürlich nochmal lesen, indem du die Tooltipfunktion benutzt. halte dafür die (Umschalttaste) fest und drücke (Pfeil runter). Das Questziel lautet, %npc_id:000006% zu töten. Um die Navigation zu starten, musst du in das Navigationssystem gehen. Drücke dafür (Pfeil rechts). ",
                  ["enUS"] = "You can of course read the quest again using the tooltip feature. To do this, hold down the shift key and press (down arrow). The quest goal is to kill %npc_id:000006%. To start the navigation you have to go to the navigation. Press (right arrow) to do that. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890039", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670038", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680037", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400038", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610038", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560037", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Säuberung im Koboldlager Navigation starten",
                  ["enUS"] = "UNTRANSLATED:deDE:Säuberung im Koboldlager Navigation starten",
               },
               ["endText"] = "Hier bist du richtig. Prequest bedeutet, unter diesem Menü sind die Quests aufgelistet, die du erledigt haben musst, um diese Quest zu erhalten. Das ist später wichtig für die Recherche.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,1",
                        ["enUS"] = "4,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [38]
            {
               ["GUID"] = "16807134034490039",
               ["beginText"] = {
                  ["deDE"] = "Dich interessiert in dieser Liste die Menüpunkte (Annahme) (Ziel) (abgabe) und (Pre quest). Zuerst der Punkt (Ziel). du möchtest ja nun zum Quest(Ziel) gelangen. Gehe also runter und dann bei (Ziel) ganz nach rechts. also einmal (Pfeil runter) und dann vier mal (Pfeil rechts)",
                  ["enUS"] = "In this list you are interested in the menu items (Quest start) (target) (Quest end) and (Pre quest). You want to get to the quest (target) now. So go down and then at (target) all the way to the right. so once (down arrow) and then four times (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890040", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670039", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680038", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400039", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610039", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560038", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zielnavigation starten",
                  ["enUS"] = "UNTRANSLATED:deDE:Zielnavigation starten",
               },
               ["endText"] = "Drücke Enter und starte so eine Route zum Ziel.",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,1,1,1,1",
                        ["deDE"] = "4,1,1,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [39]
            {
               ["GUID"] = "16807134034490040",
               ["beginText"] = {
                  ["deDE"] = "Das ist der Ziel-Vorschlag, den dir das Navigationssystem gibt. Darunter finden sich weitere vorschläge. die vorschläge sind nach Entfernung sortiert. Du möchtest eine Rute zum nächsten %npc_id:000006%. Starte die Rute und drücke dafür die (eingabetaste) auf dem obersten Feld dieser Liste. ",
                  ["enUS"] = "This is the suggested destination that the navigation system makes for you. Below you will find more suggestions. the suggestions are sorted by distance. You want a route to the next %npc_id:000006%. Start the route and press (enter) on the top of this list. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890041", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670040", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680039", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400040", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610040", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560039", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Route zum ersten Gegner",
                  ["enUS"] = "UNTRANSLATED:deDE:Route zum ersten Gegner",
               },
               ["endText"] = "Gleich bist du bei deinem ersten gegner. Hier im Startgebiet greifen die Gegner dich nicht von allein an. Erst, wenn du angreifst, kämpfen sie gegen dich. Solltest du ein Magier, Hexenmeister oder Priester sein, dann bleib trotzdem schon hier stehen. Diese 3 Klassen beginnen den Kampf mit Fernkampfzaubern aus der maximalen Entfernung heraus. Suche in jedem Fall, egal welche Klasse du spielst, kurz bevor du beim vorletzten oder letzten Punkt ankommst nach einem Koboldgezücht. Drücke dafür einfach nur die Tabulatortaste. Wenn du nicht fündig wirst, gehe etwas näher ran und drehe dich im Zweifel auch, während du die Tabulatortaste immer wieder drückst. ",
               ["allTriggersRequired"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 27,
                        ["enUS"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [40]
            {
               ["GUID"] = "16807134034490041",
               ["beginText"] = {
                  ["deDE"] = "Die rute wurde gestartet und du hörst nun wieder das Audiobeacon. Erinnere dich daran, dass du mit der Taste (Alt(G)(R)) rechts neben der (Leertaste) hören kannst, wo es sich genau befindet. Laufe die Beacons nun alle ab um zu einem %npc_id:000006% zu gelangen.",
                  ["enUS"] = "The route has been started and you will hear the beacon again. Remember that you can hear exactly where it is by pressing (Control) plus (Alt). Now move along all the beacons to get to a %npc_id:000006%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890042", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670041", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680040", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400041", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610041", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560040", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Rute folgen beginnen",
                  ["enUS"] = "UNTRANSLATED:deDE:Rute folgen beginnen",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8899.7;-119.9;10",
                        ["enUS"] = "-8899.7;-119.9;10",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [41]
            {
               ["GUID"] = "16807134034490042",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Sterben 1",
                  ["enUS"] = "UNTRANSLATED:deDE:Sterben 1",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890043", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050043", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560041", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610042", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400042", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680041", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670042", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Halt %class%! Bevor du dich in den Kampf stürzt, gibt es noch eine wichtige Information. Du bist sterblich. Jetzt erfährst du in wenigen worten, wass passiert, wenn es dich erwischt. Schalte manuell weiter.",
                  ["enUS"] = "Stop %class%! Before you get into the fight, there's one more important information. You are mortal. Now you'll learn in a few words what will happen if you get killed. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [42]
            {
               ["GUID"] = "16807134034490043",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Sterben 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Sterben 2",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188890044", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050044", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560042", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610043", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400043", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680042", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670043", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Für den sehr unwahrscheinlichen Fall, dass dich ein Gegner tötet, wirst du es sicher erfahren. Es öffnet sich dann ein Fenster mit nur einer Schaltfläche. Damit lässt du deinen (Geist) frei. Du stehst danach in Form einer geisterhaften Erscheinung auf dem nächstgelegenen friedhof direkt neben einem (Geistheiler). Dann hast du 2 Optionen. Schalte manuell weiter.",
                  ["enUS"] = "In the very unlikely event that an enemy kills you, there will a panel open with only one button. With that, you release your spriit. You will then be teleported as a ghost to the closest graveyard right next to a spirit healer. There you have 2 options. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [43]
            {
               ["GUID"] = "16807134034490044",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Sterben 3",
                  ["enUS"] = "UNTRANSLATED:deDE:Sterben 3",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900045", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050045", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560043", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610044", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400044", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680043", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670044", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Option 1 ist, den Geistheiler neben dir anzusprechen und ihn zu bitten, dich an Ort und Stelle wiederzubeleben. Leider bekommst du dann einen Debuff, also einen (Schwächungszauber) für einige Minuten. Dieser Zauber macht dich so schwach, dass du solange nicht kämpfen kannst, solange du von diesem beeinflusst wirst. Du bist damit jedem Gegner unterlegen. Wenn du wartest, kannst du danach aber wieder normal weiterspielen. Natürlich wird deine Ausrüstung durch diesen Extraservice etwas beschädigt. du kannst vom Friedhof aus aber eine Rute starten und tun, was immer du möchtest. Nur das kämpfen solltest du verschieben, bis der Debuff abgelaufen ist. Du kannst auf der Übersichtsseite (Umschalttaste) und (Pfeil runter) sehen, welche Buffs und Debuffs du hast und wie lange sie noch laufen. Schalte manuell weiter. ",
                  ["enUS"] = "Option 1 is to talk to the spirit healer next to you and ask him to resurrect you. Unfortunately, you will then get a debuff (that is, a negative spell) for a few minutes. This spell makes you so weak that you can't fight as long as it's on you. You will be inferior to any enemy. If you wait, however, you can continue playing normally afterwards. Of course your equipment will be damaged a bit by this extra service. but you can start a route from the graveyard and do whatever you want. But you shouldn't fight until the debuff is gone. You can see what buffs and debuffs you have and how long they will stay on the overview page with (shift) and (down arrow). Continue manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "16807134034490045",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Sterben 4",
                  ["enUS"] = "UNTRANSLATED:deDE:Sterben 4",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900046", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050046", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560044", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610045", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400045", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680044", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670045", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Option 2 ist, der Rute zu folgen, die automatisch ausgewählt wurde. sie führt vom Friedhof bis zu deiner Leiche. wenn du bei deiner Leiche angekommen bist, öffnet sich wieder ein Fenster. In diesem Fenster kannst du die Schaltfläche (wiederbeleben) bestätigen. Die Geisterscheinung verwandelt sich dann wieder in deinen Charakter. Wenn aggressive Feinde in der Nähe sind, werden sie dich auch sofort angreifen. Also sei vorsichtig. du kannst dich maximal 40 meter entfernt von deinem leichnam beleben. Das war schon alles, was du wissen musst. Schalte jetzt manuell weiter. ",
                  ["enUS"] = "Option 2 is to follow the route that was automatically selected. it leads from the graveyard to your corpse. when you arrive at your corpse, a panel will open again. In this panel you can confirm the button (resurrect). The ghost will then turn back into your character. If there are aggressive enemies nearby, they will also attack you immediately. So be careful. you can resurrect at most 40 meters away from your corpse. That's all you need to know. Continue manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [45]
            {
               ["GUID"] = "16807134034490046",
               ["beginText"] = {
                  ["deDE"] = "Schon hier könnten sich Gegner vor dir befinden. Mit der (Tabulatortaste) kannst du Gegner vor dir ins Ziel nehmen. Wenn du einen Wolf ins Ziel bekommst, ignoriere ihn. Hier im Startgebiet sind sie noch nicht aggressiv. Sie greifen dich nicht an. Wenn du möchtest, dann lösche dein Ziel durch einmaliges drücken der Taste (Escape) oder nehme dich selbst mit (E) ins Ziel. Du kannst auch einfach (Tabulator) drücken um nach weiteren Zielen zu suchen. Wenn du ein Ziel findest, wird der Name und die Stufe des Ziels angesagt. Parallel dazu sagt eine Männliche Sprachausgabe die Entfernung zum Ziel an. Solange du das Ziel im visier hast, sagt die männliche Sprachausgabe die entfernung zum Ziel, sobald sich die Entfernung verändert. Folge weiter der Rute und suche mit (Tabulator) nach einem %npc_id:000006%",
                  ["enUS"] = "Already here there could be enemies in front of you. Use the tabulator key to target enemies in front of you. If you get a wolf into the target, ignore it. Here in the starting area they are not aggressive yet. They do not attack you. If you want, clear your target by pressing Escape once or target yourself with (E). You can also just press the Tab key to find more targets. When you find a target, the name and level of the target is pronounced. A male voice pronounces the distance to the target. As long as you have the target locked, the male voice will tell you the distance as soon as the distance changes. Continue to follow the route and tab to a %npc_id:000006%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900047", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670046", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680045", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400046", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610046", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560045", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Kobold suchen.",
                  ["enUS"] = "UNTRANSLATED:deDE:Kobold suchen.",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "6",
                        ["enUS"] = "6",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [46]
            {
               ["GUID"] = "16807134034490047",
               ["beginText"] = {
                  ["deDE"] = "Das ist ein %npc_id:000006%. Greif an, indem du die Taste (G) für Interagieren drückst. Du als %class% läufst dann automatisch an die Position des Gegners und schlägst zu. Da sich der Gegner selbst auch bewegt, solltest du im Kampf nochmal (G) drücken, damit du dich neu ausrichtest. Jeder Druck (G) sagt deiner Spielfigur (laufe zum Ziel oder drehe dich in die richtige Richtung zum Gegner und starte den automatischen Angriff) ",
                  ["enUS"] = "This is a %npc_id:000006% . Attack by pressing the (G) key for interact. You, as the %class%, will then automatically move to the enemy's position and start a melee attack. Since the enemy itself is also moving, you should press (G) again in combat to realign yourself. Each use of the (G) key lets your character move to the target or turn around in the right direction to the enemy and start the auto attack. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["linkedIn"] = {
                  ["168111678387860001"] = {
                     "1681116816120400047", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680046", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670047", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Angriff",
                  ["enUS"] = "UNTRANSLATED:deDE:Angriff",
               },
               ["allTriggersRequired"] = true,
               ["playFtuIntro"] = "",
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [47]
            {
               ["GUID"] = "16807134034490048",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Plündern",
                  ["enUS"] = "UNTRANSLATED:deDE:Plündern",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900049", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560047", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610048", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400048", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680047", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670048", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "Glückwunsch %name%! Der Gegner ist tot! Du kannst nun Beute erhalten, indem du den Leichnam plünderst. Dies kannst du auf verschiedene Weisen tun. Versuche nach dem Kampf auf (H) zu drücken. Dadurch bekommst du den letzten Gegner wieder ins Ziel, denn dein Ziel wird nach dem Kampf automatisch gelöscht. Drücke dann (G) und interagiere mit der Leiche. Du erhälst dann die Beute. Wenn es funktioniert, erkennst du das am klimpern von Münzen. Wenn nicht, dann zeige ich dir beim nächsten Gegner eine andere Variante. Versuche es nun. Drücke erst (H) und dann (G). Schalte das tutorial danach manuell mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter.",
                  ["enUS"] = "Congratulations %name%! The enemy is dead! You can now get loot by looting the corpse. You can do this in several ways. Try pressing (H) after the fight. This will get you to target the last enemy again, because your target is automatically cleared after the fight. Then press (G) and interact with the corpse. You will then get the loot. If it works, you can tell by the jingling of coins. If not, then I'll show another way after killing the next enemy. Try it now. First press (H) and then (G). Then continue the tutorial manually with %SKU_KEY_TUTORIALSTEPFORWARD%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [48]
            {
               ["GUID"] = "16807134034490049",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation beenden",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation beenden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900050", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560048", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610049", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400049", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680048", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670049", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hinweis: Möglicherweise bist du nicht bis zum ende der Rute gelaufen. Wenn der Audiobeacon noch eingeschaltet ist und dich das laute Geräusch ablenkt, kannst du es mit Umschalt F(12) einfach ausschalten. Achte außerdem bei der Wahl des Gegners darauf, dass sich um dich herum viele verschiedene Gegner befinden. Die Quest verlangt von dir, dass du %npc_id:000006% tötest. Schalte das tutorial jetzt nochmal mit %SKU_KEY_TUTORIALSTEPFORWARD% manuell weiter.",
                  ["enUS"] = "Note: You may not have moved to the end of the route. If the Beacon is still active and the loud noise distracts you, you can simply turn it off with Shift plus (F 12). Also, when choosing an enemy, be aware that there are many enemies around you. The quest requires you to kill %npc_id:000006%. Now manually continue the tutorial with %SKU_KEY_TUTORIALSTEPFORWARD%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [49]
            {
               ["GUID"] = "16807134034490050",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Hinweis Kobold finden",
                  ["enUS"] = "UNTRANSLATED:deDE:Hinweis Kobold finden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900051", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560049", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610050", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400050", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680049", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670050", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hinweis: Wenn du kein %npc_id:000006% finden kannst, kannst du dein Questbuch öffnen und über die Navigation und dort über (Ziel) eine Rute zum nächsten %npc_id:000006% starten. %npc_id:000006% sollten aber überall um dich herum sein. schalte das tutorial nochmal manuell weiter. ",
                  ["enUS"] = "Note: If you can't find %npc_id:000006%, you can open your quest log and start a route to the next %npc_id:000006% via navigation and there via (Quest target). %npc_id:000006% should be all around you though. Continue the tutorial manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [50]
            {
               ["GUID"] = "16807134034490051",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Kobold nummer 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Kobold nummer 2",
               },
               ["linkedIn"] = {
                  ["168111678387860001"] = {
                     "1681116816120400051", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680050", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670051", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Töte jetzt einen weiteren Gegner. Drücke wieder die (Tabulatortaste) um ein Ziel zu finden. du kannst dich auch mit (A) und (D) drehen um in andere Richtungen zu suchen. Wenn du ein %npc_id:000006% gefunden hast, greife an, indem du (G) drückst. Direkt nach Kampfbeginn solltest du einen oder zwei Schritte rückwärts gehen. Drücke dafür (S). Das bewirkt, dass der Gegner vor dir steht. es könnte sonst sein, dass er sich Seitlich oder hinter dir befindet. Also suche dein Ziel mit (Tabulator), greife es mit (G) an und mache dann wenige Schritte rückwärts mit (S). ",
                  ["enUS"] = "Now kill another enemy. Press the (Tab) key again to find a target. You can also turn around with (A) and (D) to search in other directions. When you have found a %npc_id:000006%, attack by pressing (G). Right after the fight starts, it's a good idea to get one or two steps backwards. Press (S) to do this. This will make the enemy stand in front of you. Otherwise he might stand to the side or behind you. So find your target with (Tab), attack it with (G) and then take few steps backwards with (S). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [51]
            {
               ["GUID"] = "16807134034490052",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "SoftTarget für Loot",
                  ["enUS"] = "UNTRANSLATED:deDE:SoftTarget für Loot",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900053", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050053", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560051", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610052", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400052", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680051", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670052", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du wirst nun mit der so genanten Softtarget-Funktion plündern. Das bedeutet, dass das Spiel dir Ziele vorschlägt. Dies kann hilfreich aber auch hinderlich sein. Wir unterscheiden zwischen Softtarget für (Feinde), (Freunde) und für (Objekte). Objekte sind alle Dinge, mit denen du interagieren kannst. Also auch Leichen die plünderbar sind. Mit eingeschaltetem Softtarget hörst du ein Schmatzgeräusch, weil das Spiel dir ein Ziel vorschlägt. Drücke (Umschalttaste) und (O), um das Softtarget einzuschalten und höre genau hin.",
                  ["enUS"] = "You will now loot using the softtarget feature. This means that the game will suggest targets to you. This can be helpful but also a hindrance. We distinguish between softtarget for (enemies), (friends) and for (objects). Objects are all things you can interact with. So also corpses you can loot. With soft target (on), you will hear a smacking sound if the game suggests a target. Press Shift and (O) to turn on the soft target feature and listen carefully.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 64,
                        ["enUS"] = 64,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [52]
            {
               ["GUID"] = "16807134034490053",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Softtarget erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Softtarget erklären",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900054", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560052", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610053", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400053", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680052", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670053", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Drücke (G), wenn du das Geräusch gehört hast. Das Ziel wird automatisch ausgewählt und geplündert. Drehe dich im Kreis und schau nach, ob noch mehr Beute herumliegt. Sammel alles mit (G) ein. Das Softtargeting lassen wir nun eingeschaltet und nach dem nächsten Kampf wird das Geräusch sofort zu hören sein. Du kannst dann auch sofort durch einmaliges drücken von (G) plündern. Töte nach dem Plündern ein weiteres %npc_id:000006%. ",
                  ["enUS"] = "Press (G) when you have heard the sound. The target will be automatically selected and looted. Turn around in and see if there is more loot on the ground. Collect everything with (G). We now leave the soft targeting on and after the next fight the sound will be heard immediately. You can also loot immediately by pressing (G) once. After looting, kill another %npc_id:000006%. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [53]
            {
               ["GUID"] = "16807134034490054",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erklärung der ansagen",
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung der ansagen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670054", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Vergesse nicht mit (G) zu plündern, wenn du das Schmatzgeräusch gehört hast. Im Kampf hörst du viele Ansagen. Die Weibliche Sprachausgabe sagt in 10er Schritten, wieviel Prozent Leben der Gegner noch hat. Die Jungenstimme sagt einstellig in 10 Schritten dein Leben an. Das Mädchen sagt dir, wieviel Wut du hast. Schalte das tutorial jetzt manuell weiter.",
                  ["enUS"] = "Don't forget to loot with (G) after you hear the smacking sound. In combat, you'll hear a lot of outputs. The female voice says in increments of 10 how many percent health the enemy has left. The boy's voice pronounces your health in 10 steps. The girl tells you how much rage you have. Now continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [54]
            {
               ["GUID"] = "16807134034490055",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest zuende spielen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest zuende spielen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900056", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560054", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610055", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400055", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680054", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670055", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Töte nun die restlichen %npc_id:000006% und plünder sie. Um zu erfahren, ob du die Quest erledigt hast, öffne dein Questbuch mit (L) und sieh in der Quest unter (Fortschritt) nach. Bei jedem Questfortschritt hörst du auch ein (Pling) und bei Questabschluss ein (Pling Pling). Wenn du ein Lautes Gongähnliches Geräusch hörst, oder dir unsicher bist, dann schalte das Tutorial manuell weiter. ",
                  ["enUS"] = "Now kill the remaining %npc_id:000006% and loot them. To know if you have completed the task, open your quest log with (L) and find in the quest under (progress). At each quest progress you will also hear a (Pling) and at quest completion a (Pling Pling). If you hear a loud, unique success sound after killing an enemy, or are unsure, manually continue the tutorial. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [55]
            {
               ["GUID"] = "16807134034490056",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Level Up und die Übersichtsseite",
                  ["enUS"] = "UNTRANSLATED:deDE:Level Up und die Übersichtsseite",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900057", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670056", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680055", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400056", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610056", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560055", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Möglicherweise hast du das Gonggeräusch gehört. Das bedeutet, du bist auf Stufe 2 aufgestiegen. Schau nach, wie viel Erfahrung du hast. das kannst du auf der Übersichtsseite. Du öffnest die Übersichtsseite mit (Umschalttaste) und (Pfeil runter). Die Übersichtseite bedienst du so, wie den Tooltip. Halte (Umschalttaste) fest und gehe mit (Pfeil runter) Zeile für Zeile nach unten, bis du deinen Erfahrungsfortschritt findest",
                  ["enUS"] = "You may have heard the success sound. This means you have advanced to level 2. Check how much experience you have. You can do that on the overview page. You open the overview page with shift and down arrow. You are using the overview page in the same way as the tooltip. Hold (Shift) and go down line by line with (Down arrow) until you find your experience details.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "xp",
                        ["enUS"] = "xp",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [56]
            {
               ["GUID"] = "16807134034490057",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Tooltip Steuerungsfunktion",
                  ["enUS"] = "UNTRANSLATED:deDE:Tooltip Steuerungsfunktion",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900058", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978050058", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560056", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610057", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400057", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680056", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670057", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hinweis: Die Tooltipfunktion hat eine weitere möglichkeit, um von Überschrift zu Überschrift zu springen. Dafür nimmst du zu der (Umschalttaste) die du ja festhälst, die (Steuerungstaste) hinzu. Wenn du dann die Pfeiltasten nach unten oder oben drückst, springst du zu den Überschriften. Lasse dann nur die (Steuerungstaste) los und halte die (Umschalttaste) weiter fest. Gehe dann mit der Pfeiltaste nach unten um unter der Überschrift zu lesen. Du kannst das auf der Übersichtsseite ausprobieren und sie entdecken. Du wirst später aber weitere erklärungen dazu erhalten, wenn es dir jetzt zu kompliziert ist. Probiere es aus und schalte das Tutorial weiter, wenn du bereit bist. ",
                  ["enUS"] = "Note: The tooltip feature has another way to jump from section to section. For this you add the (control) key to the (shift) key you are holding down. If you then press the arrow keys down or up, you will jump to the sections. Then release only the (control) key and continue to hold the (shift) key. Then go down with the arrow key to read the section. You can try this on the overview page and get used it. You will get more explanations later if it is too complex for you now. Try it out and continue the tutorial when you're ready. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [57]
            {
               ["GUID"] = "16807134034490058",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest erledigt",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest erledigt",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900059", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560057", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610058", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400058", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680057", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670058", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hast du deine Quest erledigt und Alle %npc_id:000006% getötet? In deinem Questbuch steht vor der Quest das Wort (Fertig) und unter Fortschritt kannst du lesen, dass du 8 von 8 der benötigten Gegner getötet hast. Schalte das tutorial mit %SKU_KEY_TUTORIALSTEPFORWARD% weiter, wenn du wirklich alles erledigt hast.",
                  ["enUS"] = "Did you complete your quest? Killed all %npc_id:000006% ? In your quest log there is the word (Completed) in front of the quest and under progress you can read that you killed 8 out of 8. Continue the tutorial with %SKU_KEY_TUTORIALSTEPFORWARD% when you have really finished everything.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [58]
            {
               ["GUID"] = "16807134034490059",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Softtarget ausschalten",
                  ["enUS"] = "UNTRANSLATED:deDE:Softtarget ausschalten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900060", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060060", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560058", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610059", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400059", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680058", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670059", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wunderbar %name%! Du bist nun fertig. Du könntest das Softtarget zwar eingeschaltet lassen, es würden aber sehr viele Vorschläge auftauchen, die störend sind. Benutze zukünftig das SoftTarget aktiv. Schalte es ein, wenn du etwas suchst, einen Gegner plündern möchtest, wenn du einen NPC in deiner nähe suchst oder wenn du einen Gegenstand einsammeln möchtest. schalte es aus, wenn du herumläufst oder wenn du gegen mehrere Gegner gleichzeitig kämpfst. Die softtargetfunktion unterbricht mit jedem Vorschlag auch die Ausgabe deines Chats oder der allgemeinen Ansagen. Da du nun zum Questgeber laufen möchtest, schalte das Softtarget deshalb nun aus, indem du (Umschalttaste) und (o) drückst. ",
                  ["enUS"] = "Wonderful %name%! You are now done. You could leave the soft target on, but it would bring up a lot of suggestions that are annoying. Use the SoftTarget actively in the future. Turn it on when you are searching for something, looting an enemy, searching for an NPC near you, or when you want to collect an item. turn it off when you are moving around or when you are fighting multiple enemies at once. The softtarget function also interrupts your chat or general outputs with each suggestion. Since you now want to move to the quest giver, turn off the softtarget by pressing Shift (O). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 64,
                        ["enUS"] = 64,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [59]
            {
               ["GUID"] = "16807134034490060",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Questbuch öffnen und auf die q gehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Questbuch öffnen und auf die q gehen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900061", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560059", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610060", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400060", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680059", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670060", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Öffne nun dein Questbuch mit (L) und gehe nach rechts auf die Quest. Dort sollte vor der Quest ein (FERTIG) gesagt werden. Falls das nicht so ist, dann musst du noch mehr %npc_id:000006% töten.",
                  ["enUS"] = "Now open your quest log with (L) and go right to the quest. There should be (Completed) before the quest. If it doesn't, then you have to kill more %npc_id:000006%.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "fertig",
                        ["enUS"] = "Completed",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1",
                        ["enUS"] = "4,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [60]
            {
               ["GUID"] = "16807134034490061",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation zur Abgabe starten",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation zur Abgabe starten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900062", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560060", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610061", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400061", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680060", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670061", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach rechts und dann nach unten bis auf (Abgabe). Dann gehe nach rechts, bis du %npc_id:000197% mit Entfernungsangabe hörst.",
                  ["enUS"] = "Go to the right and then down to (Quest End). Then go right until you hear %npc_id:000197% with the distance.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,3,1,1,1,1",
                        ["enUS"] = "4,1,1,1,3,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [61]
            {
               ["GUID"] = "16807134034490062",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Route starten und zum Ziel laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:Route starten und zum Ziel laufen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900063", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560061", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610062", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400062", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680061", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670062", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "Starte die Navigation und folge den Audiobeacons bis zum Questgeber. Drücke zum starten die (Eingabetaste) und laufe los",
                  ["enUS"] = "Start navigation and follow the beacons to the quest giver. Press the (Enter) key to start and then move",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "Quest verfügbar",
                        ["enUS"] = "Quest verfügbar",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "-8826.8;-160.5;10",
                        ["enUS"] = "-8826.8;-160.5;10",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "-8924.8;-110.4;20",
                        ["enUS"] = "-8924.8;-110.4;20",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [3]
               },
            }, -- [62]
            {
               ["GUID"] = "16807134034490063",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erklärung verfügbare quest",
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung verfügbare quest",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900064", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560062", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610063", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400063", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680062", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670063", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du durch die Welt läufst, kann es sein, dass in deiner Nähe ein NPC steht, der eine Quest für dich hat. Du hörst dann die automatische Ansage: (Quest verfügbar) den (Questnamen) und den Namen des (Questgebers). Später gibt dir das wichtige Hinweise. Jetzt kannst du die ansage ignorieren. Laufe weiter bis zum Questgeber.",
                  ["enUS"] = "As you move through the world, there may be an NPC standing near you with a quest for you. You will hear the automatic announcement: (quest available) the (quest title) and the name of the quest giver. Later this will give you important notes. For now you can ignore the announcements. Move on to the quest giver.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8902.0;-161.7;5",
                        ["enUS"] = "-8902.0;-161.7;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [63]
            {
               ["GUID"] = "16807134034490064",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ansage von verfügbaren Quests",
                  ["enUS"] = "UNTRANSLATED:deDE:Ansage von verfügbaren Quests",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900065", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560063", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610064", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400064", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680063", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670064", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist angekommen. Versuche so genau zu treffen, dass auch das letzte Audiobeacon abgeschaltet wird. Nehme dann %npc_id:000197% ins Ziel indem du (Steuerungstaste) und (Umschalttaste) festhälst und auf (Tabulator) drückst. Wenn du ihn nicht findest, drehe dich und drücke die Tasten nochmal. ",
                  ["enUS"] = "You arrived. Try to move so that the last beacon is reached. Then target %npc_id:000197% by holding (control key) and (shift key) and pressing (tab). If you don't find him, turn around and press the keys again. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "197",
                        ["enUS"] = "197",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [64]
            {
               ["GUID"] = "16807134034490065",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest abgeben Ansprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest abgeben Ansprechen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900066", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560064", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610065", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400065", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680064", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670065", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Interagiere mit dem Questgeber indem du (G) drückst.",
                  ["enUS"] = "Interact with the quest giver by pressing (G).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "197",
                        ["enUS"] = "197",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [65]
            {
               ["GUID"] = "16807134034490066",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Dialogfenster erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Dialogfenster erklären",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900067", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560065", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610066", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400066", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680065", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670066", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn ein Questgeber nur eine Quest für dich hat, öffnet sich sofort die Quest. In den meisten Fällen öffnet sich aber ein Dialogfenster mit verschiedenen Optionen. Gehe einmal nach rechts. ",
                  ["enUS"] = "If a quest giver has only one quest for you, the quest will open immediately. In most cases, however, a dialog pane with various options will open. Go to the right once. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [66]
            {
               ["GUID"] = "16807134034490067",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Im dialogfenster navigieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Im dialogfenster navigieren",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900068", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560066", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610067", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400067", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680066", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670067", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "In einem Dialogfenster findest du sowohl Quests, die du abgeben kannst als auch verfügbare Quests. Es kann auch andere Angebote von NPCs geben. Händler und Trainer haben auch oft dialogfenster. Jetzt gehe auf die gewünschte Option (also die Quest, die du nun abgeben möchtest). Gehe dann nach (rechts) in das (Untermenü). Bestätige dann die Schaltfläche (Linksklick) mit der (Eingabetaste).",
                  ["enUS"] = "In a dialog pane you will find quests ready for turn in or available quests. There may also be other dialog options or activities. Merchants and trainers often have dialog pane as well. Now go to the option you want (the quest you want to turn in). Then go to (right) in the (submenu). Then confirm the (left click) button with the (enter) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [67]
            {
               ["GUID"] = "16807134034490068",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest im Dialogfenster bedienen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest im Dialogfenster bedienen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900069", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560067", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610068", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400068", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680067", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670068", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das Questfenster hat sich geöffnet. du kannst abgeben, indem du die Schaltfläche (Abschließen) bestätigst oder indem du einfach Leertaste drückst.",
                  ["enUS"] = "The quest panel has opened. You can turn in by confirming the (Complete Quest) button or by simply pressing spacebar.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 61,
                        ["enUS"] = 61,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [68]
            {
               ["GUID"] = "16807134034490069",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erneut mit dem NPC sprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Erneut mit dem NPC sprechen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900070", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560068", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610069", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400069", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680068", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670069", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das Dialogfenster schließt sich automatisch, wenn keine weitere Option vorhanden ist. Hier hat der NPC aber 2 weitere Quests für dich. Deshalb hat sich das Dialogfenster wieder geöffnet. Du stehst auf dem Feld (Dialog) (Plus) und musst einmal nach rechts gehen um den Dialog und die Optionen zu sehen. Drücke einmal (Pfeil rechts). ",
                  ["enUS"] = "The dialog pane will close automatically if there is no other option. But here the NPC has 2 more quests for you. Therefore the dialog pane opened again. You are on the field (Dialog) (Plus) and have to go right once to see the dialog and the options. Press right arrow once. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [69]
            {
               ["GUID"] = "16807134034490070",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Dialogfeld mit 2 Quests",
                  ["enUS"] = "UNTRANSLATED:deDE:Dialogfeld mit 2 Quests",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900071", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670070", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680069", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400070", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610070", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560069", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist jetzt wieder im Dialogfenster. unten sind 2 Quests, die (Verfügbar) sind. Das bedeutet, du kannst sie annehmen und dann sind sie in deinem Questbuch. Gehe jetzt einmal nach unten mit (Pfeil runter).",
                  ["enUS"] = "You are now back in the dialog pane. Below are 2 quests that are (Available). That means you can accept them and then they are in your quest log. Now go down arrow once.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "verfügbar",
                        ["enUS"] = "available",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [70]
            {
               ["GUID"] = "16807134034490071",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Quest eins annehmen",
                  ["enUS"] = "UNTRANSLATED:deDE:Quest eins annehmen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900072", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670071", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680070", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400071", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610071", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560070", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist die erste Quest. Wähle diese nun aus. Gehe dafür nach rechts und drücke im Untermenü dann auf der Schaltfläche (Linksklick) die (Eingabetaste). ",
                  ["enUS"] = "This is the first quest. Select it. Go to the right and press (Enter) in the submenu on the button (Left click). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [71]
            {
               ["GUID"] = "16807134034490072",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Annahme von der ersten",
                  ["enUS"] = "UNTRANSLATED:deDE:Annahme von der ersten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900073", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060073", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560071", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610072", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400072", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680071", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670072", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Questfenster. Du kennst es schon. Du musst wie immer einmal nach rechts gehen. Dann kannst du die Quest lesen. Nehme sie an indem du die schaltfläche (Annehmen) im (Untermenü) mit (Linksklick) bestätigst oder drücke einfach einmal die (Leertaste).",
                  ["enUS"] = "This is the quest panel. You know it already. You have to go to the right once, as usual. Then you can read the quest. Accept it by clicking the (Accept) button in the (submenu) with (left click) or just press the (spacebar) once.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 58,
                        ["enUS"] = 58,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [72]
            {
               ["GUID"] = "16807134034490073",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Annahme der zweiten",
                  ["enUS"] = "UNTRANSLATED:deDE:Annahme der zweiten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900074", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670073", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680072", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400073", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610073", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560072", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du hast die erste Quest angenommen. Das Fenster hat sich geschlossen. Der NPC hat aber eine weitere Quest für dich. Spreche ihn also nochmal an, indem du (G) drückst.",
                  ["enUS"] = "You have accepted the first quest. The panel has closed. But the NPC has another quest for you. So talk to him again by pressing (G).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [73]
            {
               ["GUID"] = "16807134034490074",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "in die zweite reingehen",
                  ["enUS"] = "UNTRANSLATED:deDE:in die zweite reingehen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900075", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670074", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680073", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400074", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610074", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560073", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das Dialogfenster hat sich wieder geöffnet. Du musst nochmal das gleiche tun, wie bei der ersten Quest, die du angenommen hast. Gehe nach rechts und nach unten auf die (verfügbare) Quest.",
                  ["enUS"] = "The dialog pane has opened again. You have to do again the same as the first quest you accepted. Go to the right and down to the (available) quest.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "verfügbare",
                        ["enUS"] = "available",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [74]
            {
               ["GUID"] = "16807134034490075",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "die zweite Quest annehmen",
                  ["enUS"] = "UNTRANSLATED:deDE:die zweite Quest annehmen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900076", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670075", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680074", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400075", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610075", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560074", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe auf der verfügbaren Quest nach rechts in das (Untermenü) und drücke auf (Linksklick) wieder die (eingabetaste). Dann öffnet sich erneut das Questfenster. Lese die zweite Quest, wenn du möchtest und bestätige die Schaltfläche (Annahme) oder drücke einfach (Leertaste), um auch diese Quest anzunehmen.",
                  ["enUS"] = "On the available quest go right to the (submenu) and press (left click) again the (enter key). Then the quest panel opens again. Read the second quest if you want and confirm the (accept quest) button or just press (spacebar) to accept this quest as well.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 58,
                        ["enUS"] = 58,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [75]
            {
               ["GUID"] = "16807134034490076",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Prüfen ob due 2 Quests hast.",
                  ["enUS"] = "UNTRANSLATED:deDE:Prüfen ob due 2 Quests hast.",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900077", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060077", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560075", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610076", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400076", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680075", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670076", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Prüfe nun in deinem Questbuch, dass du mit (L) öffnen kannst, ob du zwei Quests hast. Wenn ja, schließe das questbuch mit Escape und schalte das Tutorial manuell weiter.",
                  ["enUS"] = "Now check in your quest log (open with (L)) if you have two quests. If yes, close the quest log with Escape and Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [76]
            {
               ["GUID"] = "16807134034490077",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Taschen",
                  ["enUS"] = "UNTRANSLATED:deDE:Taschen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900078", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060078", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560076", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610077", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400077", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680076", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670077", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Bevor du dich den weiteren Quests widmest, solltest du nachsehen, was du bei den Gegnern geplündert hast. Öffne deine Taschen mit der Taste (B).",
                  ["enUS"] = "Before you are doing the new quests, check what you looted from the enemies. Open your bags with the (B) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 16,
                        ["enUS"] = 16,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [77]
            {
               ["GUID"] = "16807134034490078",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Inhalt",
                  ["enUS"] = "UNTRANSLATED:deDE:Inhalt",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900079", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060079", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560077", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610078", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400078", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680077", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670078", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Anfangs hast du nur eine Tasche. Deinen Rucksack mit 16 Plätzen. gehe nach rechts und dann auf (Tasche 1) nochmal nach rechts. Dann bist du auf dem ersten Taschenplatz.",
                  ["enUS"] = "At the beginning you have only one bag. Your backpack with 16 slots. Go to the right and then to (bag 1) again to the right. Then you are on the first bag slot.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "Ruhestein",
                        ["enUS"] = "Hearthstone",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 16,
                        ["enUS"] = 16,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [78]
            {
               ["GUID"] = "16807134034490079",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Bedienung der Taschen eins",
                  ["enUS"] = "UNTRANSLATED:deDE:Bedienung der Taschen eins",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900080", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060080", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560078", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610079", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400079", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680078", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670079", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier auf dem ersten Platz in deinem Rucksack findest du deinen Ruhestein. Er ist ein benutzbares Objekt. Du kannst informationen bekommen, indem du die (Umschalttaste) festhälst und (Pfeil runter) drückst. Manchmal musst du die Umschalttaste loslassen und dann den Tooltip nochmal öffnen, damit der gesamte Text angezeigt wird. Leider dauert es auch manchmal länger, bis die Gegenstandsinformationen geladen sind. Das erneute öffnen der Taschen behebt diesen Fehler möglicherweise auch. Wenn alles richtig ist, kannst du lesen, dass dich dein Ruhestein an einen bestimmten Ort zurückbringen kann. Lese den Tooltip mit (Umschalttaste) und (Pfeil runter). ",
                  ["enUS"] = "Here on the first slot in your backpack you will find your Hearthstone. It is a usable object. You can get information by holding down the shift key and pressing down arrow. Sometimes you have to release the Shift key and then open the tooltip again to see all the text. Unfortunately, it also sometimes takes longer for the item information to load. Re-opening the bags may also fix this error. If everything is correct, you can read that your Hearthstone can return you to a specific location. Read the tooltip with (shift) and (down arrow). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [79]
            {
               ["GUID"] = "16807134034490080",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Bedienung der Taschen 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Bedienung der Taschen 2",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900081", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060081", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560079", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610080", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400080", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680079", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670080", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dein Ruhestein teleportiert dich zum Ruheort zurück. Wenn du ihn benutzen möchtest, musst du ins Gegenstands-Untermenü vom Ruhestein gehen und einen (Rechtsklick) ausführen. Dein ruheort ist momentan der Startpunkt, an dem du das Spiel gestartet hast. Später wird das dann ein von dir gewähltes (Gasthaus) sein. Im Notfall, falls du also feststeckst, kannst du den Ruhestein benutzen, und vom Startpunkt aus eine neue Rute starten. Schalte manuell weiter.",
                  ["enUS"] = "Your Hearthstone will teleport you back to the resting place. If you want to use it, you need to go to the item submenu of the Hearthstone and perform a (right-click). Your resting place is currently the starting point where you started the game. Later it will be one of your choice (inn). So in an emergency, if you get stuck, you can use the Hearthstone, and start a new route from the starting point. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [80]
            {
               ["GUID"] = "16807134034490081",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Bedienung der Tasche drei",
                  ["enUS"] = "UNTRANSLATED:deDE:Bedienung der Tasche drei",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900082", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060082", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560080", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610081", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400081", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680080", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670081", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Jeder Gegenstand hat ein Untermenü. Du erreichst es, indem du nach (rechts) gehst. darin findest du viele Optionen. Mit (Linksklick) nimmst du einen Gegenstand auf, sodass dieser an deinem Mauspfeil klebt. Du könntest ihn dann durch linksklick auf einem anderen Taschenplatz wieder ablegen. Hinweis: Am Ende des Gegenstandnamens wird die Qualität angehängt. (Schlecht) bedeutet, der Gegenstand ist zwar am Anfang zu gebrauchen, du solltest ihn aber möglichst bald austauschen. Er ist immerhin besser als nichts zu tragen. Gegenstände der Kategorie (schlecht) werden automatisch verkauft, wenn du einen Händler ansprichst. Schalte manuell weiter.",
                  ["enUS"] = "Each item has a submenu. You can reach it by going to the right. In it you will find many options. By left clicking you pick up an item and it sticks to your mouse pointer. You could then left-click it to drop it on another bag slot. Note: At the end of the item name, the quality is appended. (Poor) means the item is usable at the beginning, but you should replace it as soon as possible. After all, it is better than wearing nothing. Items in the (Poor) category are automatically sold when you approach a merchant. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [81]
            {
               ["GUID"] = "16807134034490082",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Bedienung der Tasche vier",
                  ["enUS"] = "UNTRANSLATED:deDE:Bedienung der Tasche vier",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900083", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060083", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560081", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610082", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400082", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680081", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670082", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du auf einem Objekt in deiner Tasche im Objektmenü einen Rechtsklick ausführst, benutzt du diesen Gegenstand. Du isst das Essen. Du trinkst das Getränk. Du ziehst die Ausrüstung oder Waffe an. Beachte unbedingt: Wenn ein (Händlerfenster) geöffnet ist, dann verkaufst du den Gegenstand. Schalte manuell weiter.",
                  ["enUS"] = "When you right-click on an item in your bag in the item menu, you interact with the item. That means: you use the object. You eat the food. You drink the drink. You put on the equipment or weapon. Be sure to note: If a merchant window is open, you sell the item. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [82]
            {
               ["GUID"] = "16807134034490083",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Bedienung der Tasche fünf",
                  ["enUS"] = "UNTRANSLATED:deDE:Bedienung der Tasche fünf",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900084", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060084", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560082", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610083", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400083", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680082", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670083", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du kannst nun mit (Pfeil hoch und runter) den Tascheninhalt begutachten. Mit der (Umschalttaste) und (Pfeil runter) kannst du jeweils die Informationen des Objektes nachlesen. Wenn du einen Gegenstand anziehst, verschwindet er aus der Tasche. Der Taschenplatz ist dann leer. Wenn du bereits einen Gegenstand dieser Art getragen hast, wird er ausgetauscht. Auf dem Taschenplatz befindet sich dann der Gegenstand, der vorher ausgerüstet war. Manchmal aktualisieren die Taschen nicht korrekt. Schließe sie dann mit Escape und öffne sie mit der Taste (B) erneut. Schalte manuell weiter, wenn du alles angesehen hast und die gefundene Ausrüstung angelegt ist.",
                  ["enUS"] = "You can now use up arrow and down arrow to inspect the contents of the bag. With Shift and Down arrow you can get the information of the object respectively. If you are equipping an item, it disappears from the bag. The bag slot will be empty. If you have already been wearing an item of this type, it will be replaced. The bag slot will then have the item that was equipped before. Sometimes the bags do not update correctly. In this case, close them with Escape and open them again with the (B) key. Continue manually. when you have checked everything and the equipment you have found has been equipped.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [83]
            {
               ["GUID"] = "16807134034490084",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Taschen schließen und Charakterfenster öffnen",
                  ["enUS"] = "UNTRANSLATED:deDE:Taschen schließen und Charakterfenster öffnen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900085", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060085", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560083", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610084", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400084", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680083", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670084", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Schließe deine Taschen mit (Escape) und öffne dein Charakterfenster nun mit (C).",
                  ["enUS"] = "Close your bags with Escape and now open your character window with (C).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [84]
            {
               ["GUID"] = "16807134034490085",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Charakterfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Charakterfenster",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900086", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060086", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560084", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610085", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400085", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680084", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670085", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "In diesem Fenster bekommst du alle Informationen zu deinem Charakter. gehe einmal nach rechts um auf die Überschrift zu gelangen.",
                  ["enUS"] = "In this panel you get all the information about your character. Go right once to get to the title.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [85]
            {
               ["GUID"] = "16807134034490086",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670086", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400086", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du (Stoffrüstung), (Lederrüstung) und (Schwere rüstung) tragen. Später, ab Level 40 auch (Plattenrüstung). Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As %class% you can wear cloth armor, leather armor and mail armor. Later, at level 40, you can also wear plate armor. You will probably want to see what equipment you are currently wearing. To do this, go to (Equipment), right to (Items) and then right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [86]
            {
               ["GUID"] = "16807134034490087",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Die Ausrüstungsplätze",
                  ["enUS"] = "UNTRANSLATED:deDE:Die Ausrüstungsplätze",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900088", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060088", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560086", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610087", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400087", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680086", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670087", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist der Platz für den Kopf. Du trägst im Moment noch keinen Hut oder Helm. du kannst nach unten gehen und alle möglichen Plätze begutachten. Wenn ein Gegenstand angezogen ist, wird er sofort forgelesen. Du kannst auch hier jeweils mit (Umschalttaste) und (Pfeil runter) genauere Informationen zum Gegenstand erhalten. Schließe das Charakterfenster wenn du fertig bist.",
                  ["enUS"] = "This is the slot for the head. You're not wearing a hat or helmet right now. You can go down and examine all the other slots. If an item is equipped in a slot, it will be read out. You can also get more detailes about the item by pressing the shift key and down arrow. Close the character window when you are done.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [87]
            {
               ["GUID"] = "16807134034490088",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zum verkaufen gehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Zum verkaufen gehen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900089", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060089", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560087", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610088", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400088", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680087", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670088", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "%name%, möglicherweise hast du Dinge in deiner Tasche, die du nicht mehr brauchst. Du brauchst aber jedes einzelne Kupfer. Du solltest einen Händler besuchen, um Überflüssiges zu verkaufen. Öffne dafür die manuelle Navigation mit (Umschalttaste) und (F 10)",
                  ["enUS"] = "%name%, you may have items in your bag that you no longer need. However, you need every single copper. You should visit a merchant to sell unnecessary stuff. To do this, open the navigation with (Shift) and (F 10)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "1,3,1,1",
                        ["enUS"] = "1,3,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [88]
            {
               ["GUID"] = "16807134034490089",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigationsmenü manuell",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigationsmenü manuell",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900090", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060090", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560088", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610089", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400089", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680088", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670089", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist der Startpunkt für deine Navigation. Hier beginnt deine Rute. gehe nach rechts um das Ziel festzulegen.",
                  ["enUS"] = "This is the starting point for your navigation. This is where your route starts. go right to set the destination.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 69,
                        ["enUS"] = 69,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "1,3,1,1,1",
                        ["enUS"] = "1,3,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
               },
            }, -- [89]
            {
               ["GUID"] = "16807134034490090",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navi Liste erläutern",
                  ["enUS"] = "UNTRANSLATED:deDE:Navi Liste erläutern",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900091", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060091", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560089", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610090", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400090", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680089", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670090", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du stehst nun auf dem obersten Feld einer langen Liste. In der Liste stehen alle Ziele nach Entfernung sortiert, die du von hier erreichen kannst. mit (Pfeil runter) kannst du auf ein Ziel gehen und mit der (Eingabetaste) kannst du es auswählen. höre dir weitere Erklärungen dazu an und schalte jetzt manuell weiter.",
                  ["enUS"] = "You are now on the top of a long list. In the list are all targets sorted by distance, that you could reach from here. With (down arrow) you can go to a destination and with (Enter) you can select it. Continue manually, to get more details on the navigation.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [90]
            {
               ["GUID"] = "16807134034490091",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navi Filter erläutern",
                  ["enUS"] = "UNTRANSLATED:deDE:Navi Filter erläutern",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900092", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060092", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560090", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610091", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400091", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680090", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670091", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Der Filter erleichtert dir die Suche nach einem bestimmten Ziel. Schreibe einfach einen Teil des Zielnamens und gehe dann mit den (Pfeiltasten) nach unten auf die Ergebnisse. Du kannst auch nach Objekten, Orten, Titel oder dem Beruf eines NPCs suchen. Mit der (Rücktaste) kannst du den Filter löschen. Die ersten zwei buchstaben musst du relativ schnell schreiben, damit sich der filter aktiviert. Tip: Auch ein Teil eines Wortes kann zu guten Treffern führen. Die Buchstabenfolge muss nicht am Anfang des Suchwortes stehen. Einen (Hyppogryphenmeister) kannst du beispielsweise mit (P) (P) (o) finden. Schalte jetzt manuell weiter.",
                  ["enUS"] = "The filter makes it easier for you to search for a specific destination. Just type some parts of the destination name you are looking for (type the first two letters fast) and then use the down arrow keys to go to the results. You can also search for objects, places, titles or the profession of an NPC. With the (Backspace) key you can clear the filter. You have to type the first two letters relatively fast to activate the filter mode. Hint: also a part of a word can give good result. It is not necessary that the search term is the start of a word. For example, you can find a hyppogryph master with typing (P) (P) (o). Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [91]
            {
               ["GUID"] = "16807134034490092",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navi Auftrag geben Rodric zu finden",
                  ["enUS"] = "UNTRANSLATED:deDE:Navi Auftrag geben Rodric zu finden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900093", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560091", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610092", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400092", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680091", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670092", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Suche jetzt nach dem Rüstungsschmied und Schildmacher %npc_id:001213%. Gehe dafür mit den (Pfeiltasten) Feld für Feld nach unten. Du kannst auch den Filter Nutzen. Schreibe dafür die buchstaben (R) (Ü) (S) und gehe dann mit (Pfeil runter) auf das Ergebnis.",
                  ["enUS"] = "Now search for the (armorer and shieldcrafter). That is %npc_id:001213% Use the arrow keys to go down field by field. You can also use the filter. Write the letters (A) (R) (M) and go with (down arrow) to the result.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "1,3,1,1,8",
                        ["enUS"] = "1,3,1,1,8",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [92]
            {
               ["GUID"] = "16807134034490093",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Manueller Navi start",
                  ["enUS"] = "UNTRANSLATED:deDE:Manueller Navi start",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900094", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060094", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560092", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610093", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400093", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680092", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670093", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Drücke zum starten der Rutennavigation die (Eingabetaste).",
                  ["enUS"] = "Press (Enter) to start the route navigation.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 27,
                        ["enUS"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
               },
            }, -- [93]
            {
               ["GUID"] = "16807134034490094",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zum Händler laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:Zum Händler laufen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900095", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560093", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610094", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400094", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680093", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670094", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hinweis: Manchmal hörst du während dem Laufen ein Geräusch, welches mal kürzer oder mal länger ist. Es bedeutet, dass deine Spielfigur den Kontakt zum Boden verloren hat und möglicherweise herunterfällt. Es ist sehr fein eingestellt, damit du schnell reagieren kannst und damit du auch merkst, wenn du von einer Treppe nur einen Meter herunterfällst. Es ist ein wichtiges Element, um sich auditiv in dieser Welt zurechtzufinden. Du kannst das Geräusch auch hören, wenn du einfach auf der Stelle springst. Drücke dafür einfach mehrmals die (Leertaste). (Auftrag): Du hast die Rute gestartet. Folge den Beacons bis zum Rüstungsschmied.",
                  ["enUS"] = "Note. Sometimes while moving you hear a sound, which is sometimes shorter or sometimes longer. It means that your character has lost contact with the ground and may fall down. It is very sensitive, so you can react quickly and also notice if you fall from a staircase just one meter. It's an important part of being able to navigate in this world. You can also hear the sound if you just jump. Just press the (spacebar) several times to do so. You've started the route. Follow the beacons to the Armorer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8898.6;-119.5;5",
                        ["enUS"] = "-8898.6;-119.5;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [94]
            {
               ["GUID"] = "16807134034490095",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Angekommen beim Händler",
                  ["enUS"] = "UNTRANSLATED:deDE:Angekommen beim Händler",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900096", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560094", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610095", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400095", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680094", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670095", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du zu einem Ziel läufst, solltest du genau darauf achten, nicht über den letzten Wegpunkt hinaus zu laufen. Wenn du den Punkt überläufst, stehst du beispielsweise hinter dem Händler. Der Audiobeacon ist exakt auf der Position des NPC's platziert. Taste dich an den letzten Wegpunkt der Rute immer langsam mit vorsichtigem Tippen der Taste (W) heran. %npc_id:001213% den Rüstungsschmied und schildmacher kannst du genau so wie die anderen NPCs ins Ziel nehmen. Wenn der letzte Wegpunkt noch aktiviert ist, kannst du ihn mit (Umschalttaste) und (F12) ausschalten. Drücke dann wie immer (Umschalttaste) und (Steuerungstaste) und (Tabulator) ",
                  ["enUS"] = "While traveling to a destination, you should be careful not to move beyond the last waypoint. If you run past that point, you'll be behind the merchant, for example. The audio beacon is placed exactly on the position of the NPC. So always approach the last waypoint of the route slowly by tapping the (W) key. You can target the armorer and shieldmaker, %npc_id:001213% ,  just like the other NPCs. If the last waypoint is still enabled, you can turn it off with (Shift) and (F12). Then press (Shift) and (Control) and (Tab) as usual. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "1213",
                        ["enUS"] = "1213",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [1]
               },
            }, -- [95]
            {
               ["GUID"] = "16807134034490096",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ansprechen des Händlers",
                  ["enUS"] = "UNTRANSLATED:deDE:Ansprechen des Händlers",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900097", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060097", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560095", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610096", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400096", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680095", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670096", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du den NPC ansprichst, verkauft das Sku-Addon automatisch Schrott und repariert deine Ausrüstung. Es gibt viele Händler. Nicht jeder kann reparieren. Dafür solltest du bevorzugt zu Rüstungshändlern oder einem Schmied gehen. Interagiere nun mit dem NPC indem du (G) drückst.",
                  ["enUS"] = "On interacting with the NPC, the SkuAddon will automatically sell scrap items and repair your equipment. There are many merchants. Not everyone can repair. For that, you should preferably go to armor merchants or a blacksmith. Now interact with the NPC by pressing (G).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [96]
            {
               ["GUID"] = "16807134034490097",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ebenen beim Händler",
                  ["enUS"] = "UNTRANSLATED:deDE:Ebenen beim Händler",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900098", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060098", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560096", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610097", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400097", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680096", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670097", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Es sind nun 2 Fenster geöffnet. Das Händlerfenster und deine Taschen. Du stehst nun auf dem Feld Händler. nach (unten) kommst du auf das Feld Taschen. tue das als erstes. Gehe (runter) auf (Tasche) und dann nach (rechts) in deine (Tasche) hinein.",
                  ["enUS"] = "2 panels have opened. The merchant window and your bags. You are now on the Merchant panel. Go down to the Bags panel. Do this first. Go down to bag and then right into your bag.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,2,1,1",
                        ["enUS"] = "9,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [97]
            {
               ["GUID"] = "16807134034490098",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Verkaufen beim Händler",
                  ["enUS"] = "UNTRANSLATED:deDE:Verkaufen beim Händler",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900099", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060099", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560097", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610098", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400098", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680097", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670098", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Sowohl deinen (Ruhestein) als auch Questgegenstände kannst du nicht verkaufen. Solltest du weitere Gegenstände in deinen Taschen finden, dann verkaufe sie, indem du im Objektmenü einen (Rechtsklick) ausführst. Gehe dafür auf dem Objekt nach rechts in das Objektmenü und dann eins nach unten auf (Rechtsklick). Drücke dann die (Eingabetaste). Du solltest Münzenklimpern hören. Beim ersten Verkaufsversuch werden die Taschen aktualisiert. Hier ist es sehr wahrscheinlich, dass der gesammte Schrott schon automatisch beim Ansprechen des Händlers verkauft wurde. Wenn du fertig bist, schalte das Tutorial manuell weiter.",
                  ["enUS"] = "You can't sell your Hearthstone. Quest items cannot be sold either. If you find other items in your bags, then sell them now by doing a (right click) in the items submenu. To do this, go right on the item to the item menu and then one down on (right click). Then press the (Enter) key. You should hear coins jingling. The first time you try to sell, the bags will be updated. Here, it's very likely that all the junk was already sold automatically when you approached the merchant. When you're done, manually continue the tutorial.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [98]
            {
               ["GUID"] = "16807134034490099",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Von Tasche in Händlermenü wechseln",
                  ["enUS"] = "UNTRANSLATED:deDE:Von Tasche in Händlermenü wechseln",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900100", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060100", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560098", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610099", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400099", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680098", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670099", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach links auf (Tasche 1) und nochmal nach links auf (Taschen).",
                  ["enUS"] = "Go left to (bag 1) and left again to (bags).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,2",
                        ["enUS"] = "9,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [99]
            {
               ["GUID"] = "16807134034490100",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In das Händlerfenster wechseln",
                  ["enUS"] = "UNTRANSLATED:deDE:In das Händlerfenster wechseln",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900101", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060101", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560099", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610100", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400100", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680099", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670100", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe hoch auf (Händler), auf deinen Startpunkt. Gehe diesmal, wenn du auf (Händler) stehst einfach mit den Pfeiltasten nach rechts, um in das Händlerfenster zu gelangen.",
                  ["enUS"] = "Go up to (Merchant). That's where you started. This time, on (merchant), just go right with the arrow keys to get to the merchant window.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [100]
            {
               ["GUID"] = "16807134034490101",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Händlermenü erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Händlermenü erklären",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900102", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060102", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560100", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610101", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400101", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680100", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670101", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du befindest dich auf der Überschrift. Gehe mit den (Pfeiltasten) nach (unten) um das Angebot des Händlers zu sehen. Schalte das tutorial dann manuell weiter, damit du lernen kannst, wie man dieses Fenster bedient. ",
                  ["enUS"] = "You are on the title. Go down with the arrow keys to see the merchant's listings. Continue manually, to learn how to use this panel. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [101]
            {
               ["GUID"] = "16807134034490102",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Gegenstand begutachten",
                  ["enUS"] = "UNTRANSLATED:deDE:Gegenstand begutachten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900103", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060103", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560101", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610102", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400102", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680101", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670102", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Bitte suche den Gegenstand, der sich ganz oben unter der Schaltfläche (Schließen) befindet. dort gehst du einmal nach (rechts) in das Gegenstandsmenü. Du hörst dann die Überschrift vom Gegenstandsmenü. die Überschrift ist auch in diesem menü mit dem Wort (Text) markiert. Von ganz oben (Der Händlerüberschrift) musst du also (drei) mal nach (unten) und (einmal) nach (rechts) gehen. ",
                  ["enUS"] = "Find the item that is located at the very top of the list. Right after the (Close) button. There you go right into the item menu. You will then hear the title of the item menu. The title in this menu has the word (Text). So from the very top (the merchants titel) you have to go down three times and once to the right. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4,1",
                        ["enUS"] = "9,1,4,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [102]
            {
               ["GUID"] = "16807134034490103",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Gegenstand weiter inspizieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Gegenstand weiter inspizieren",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900104", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060104", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560102", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610103", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400103", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680102", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670103", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dieses Menü hat 3 Einträge. Die (Überschrift), den (Gegenstand) und ganz (unten) den (Preis). Auf dem Gegenstand kannst du den Tooltip wie gewohnt mit (Umschalttaste) und (Pfeil runter) lesen. Probiere es doch einfach mal aus. Gehe einmal nach (unten) und benutze auf dem Gegenstand dann die (Tooltipfunktion) mit (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "This menu has 3 entries. The titel. The item itself and at the bottom the (price). On the item you can read the tooltip as usual with (shift) and (down arrow)). Try this. Go down once and then on the item use the tooltip feature with (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Gegenstandslevel",
                        ["enUS"] = "Item Level",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [103]
            {
               ["GUID"] = "16807134034490104",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Kaufen",
                  ["enUS"] = "UNTRANSLATED:deDE:Kaufen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900105", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060105", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560103", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610104", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400104", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680103", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670104", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du befindest dich nun auf dem Gegenstand. hier kannst du das (Gegenstandsmenü), so wie in den Taschen auch, erreichen, indem du nach rechts gehst. Dort findest du verschiedene (Optionen) die du dir ansehen solltest. Gehe also einmal nach (rechts).",
                  ["enUS"] = "So you are on the item. Here you can access the item menu (like in the bags) by going to the right. There you will find several options that you should explore. So go to the right once.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 5,
                        ["enUS"] = 5,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4,2,1",
                        ["enUS"] = "9,1,4,2,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [104]
            {
               ["GUID"] = "16807134034490105",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "lieber doch nicht kaufen",
                  ["enUS"] = "UNTRANSLATED:deDE:lieber doch nicht kaufen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900106", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060106", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560104", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610105", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400105", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680104", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670105", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Kaufen ist die (Option), um mehrere Gegenstände eines Typs zu kaufen. Dafür gehst du nach (rechts), wählst die (Kaufmenge) mit (Pfeil hoch) und (runter) und drückst dann die (Eingabetaste). Die Gegenstände werden dann gekauft, wenn du genug Kupfer besitzt. unter (Kaufen) findest du (linksklick) und (Rechtsklick). (Rechtsklick) hat eine wichtige funktion. Damit kaufst du einen einzigen Gegenstand. Du möchtest jedoch sparsam sein. Du brauchst anfangs all dein Kupfer, um deinen Klassenlehrer für neue Fähigkeiten zu bezahlen. Schließe deshalb das Fenster nun mit (Escape). ",
                  ["enUS"] = "Buy is the option to buy several items of the same type. To do this, go to the right, select the quantity with up arrow and down arrow, then press the (enter) key. The items will be bought when you have enough copper. Below (Buy) you will find (left click) and (right click). (Right click) has an important feature. With this you will buy a single item. However, we would like to save our money. You will need all your copper in the beginning to spend on new skills from your class trainer. So close the panel with (Escape). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [105]
            {
               ["GUID"] = "16807134034490106",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Aufbruch zum Klassenlehrer.",
                  ["enUS"] = "UNTRANSLATED:deDE:Aufbruch zum Klassenlehrer.",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900107", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060107", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560105", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610106", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400106", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680105", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670106", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du solltest nun genug Kupfer haben, um beim Klassenlehrer neue 'Fähigkeiten zu erlernen. Wenn du mehr Kupfer brauchst, kannst du einfach Gegner töten und die Beute bei einem Händler verkaufen. Später erlernst du, wie du zu mehr Kupfer, Silber und auch Gold kommst. Zunächst solltest du deinen Klassenlehrer aufsuchen. Eine der zwei Quests, die du angenommen hast, führt dich zu ihm. Öffne dein Questbuch mit (L).",
                  ["enUS"] = "You should now have enough copper to learn new skills from the class trainer. If you need more copper, you can simply kill enemies and sell the loot at a merchant. Later you will learn how to get more copper, silver and also gold. First, you should visit your class trainer. One of the two quests you have accepted will lead you to him. Open your quest log with (L).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [106]
            {
               ["GUID"] = "16807134034490107",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670107", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach (rechts) in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du dich auf (Krieger) befindest.",
                  ["enUS"] = "Go to the right. You already know that the quests are sorted by regions or categories. Go down from (All) until you find (Warrior).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "Krieger",
                        ["enUS"] = "Warrior",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
               },
            }, -- [107]
            {
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900109", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060109", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670108", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610108", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400108", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680107", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560107", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Nach rechts auf Klassenquest und ankündigung",
                  ["enUS"] = "UNTRANSLATED:deDE:Nach rechts auf Klassenquest und ankündigung",
               },
               ["GUID"] = "1681073540576310001",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist die Kategorie für deine Klassenquests. Gehe nach (rechts) und höre dir wichtige Hinweise an, bevor du zu deinem Klassenlehrer läufst.",
                  ["enUS"] = "This is the category for your class quests. Go to the right and listen to important notes before moving to your class trainer",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 69,
                        ["enUS"] = 69,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [108]
            {
               ["GUID"] = "16807134034490112",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Hinweis 1 Nah weit",
                  ["enUS"] = "UNTRANSLATED:deDE:Hinweis 1 Nah weit",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900110", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060110", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560108", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610109", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400109", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680108", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670109", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Während du einer Rute folgst, kann es vorkommen, dass bei einem Wegpunkt (nah) angesagt wird. Das bedeutet, dass du ab diesem Punkt sehr genau laufen solltest. Wird dann wieder (weit) angesagt, kannst du wieder normal laufen. Es handelt sich dabei oft um Engstellen, Rampen, türen oder ähnliche Gegebenheiten. Du solltest dich in Gebäuden grundsätzlich so genau wie möglich von Wegpunkt zu Wegpunkt bewegen. Tip: Mit den Tasten (Komma) und (Punkt) kannst du Seitwärtsschritte machen. Um dich langsam zu bewegen tippe immer nur kurz auf die Bewegungstasten und taste dich stück für Stück vor. schalte manuell weiter. ",
                  ["enUS"] = "As you follow a route, you may hear the word (Near) at a waypoint. This means that you should move very precisely from this point on. If (far) is announced again, you can move normally again. These are often narrow places, ramps, doors or similar places. You should always move as accurately as possible from waypoint to waypoint in buildings. Tip: You can use the (comma) and (dot) keys to strafe to left or right. To move slowly, tap the movement keys and move forward one step at a time. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [109]
            {
               ["GUID"] = "16807134034490113",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Hinweis 2 steckenbleiben",
                  ["enUS"] = "UNTRANSLATED:deDE:Hinweis 2 steckenbleiben",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900111", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060111", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560109", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610110", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400110", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680109", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670110", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Während du läufst, hörst du manchmal ein (Piepen). Das bedeutet, dass du laufen willst, deine Figur sich aber nicht bewegt. Dies ist der einzige Hinweis für dich, ob du die Rute gut triffst oder ob du am Türrahmen hängengeblieben bist. %class%! Gebe dann nicht auf. Der Türrahmen wird dich sicher nicht besiegen! du kannst den Wegpunkt auch zum vorherigen Wegpunkt zurückwechseln, indem du die Tastenkombination (Steuerung) (Umschalttaste) und (S) drückst. Wenn du den vorherigen WEgpunkt dann wieder erreicht hast, kannst du neu Zielen und es nochmal versuchen. Mit der (Leertaste) kannst du springen und so über Hindernisse hüpfen, an denen du möglicherweise hängenbleibst. Wenn nichts mehr hilft und du feststeckst, kannst du deinen (Ruhestein) in deiner Tasche benutzen und die Rute vom Startpunkt aus neu beginnen. Schalte manuell weiter. ",
                  ["enUS"] = "While you are moving, you sometimes hear a beep. This means that you are trying to move, but your character is not making any movement. This is the only note for you to know if you are stuck. For example because you are missing a doorway. %class%! Don't give up if you are stuck. The doorway will certainly not defeat you! You can also select the previous waypoint by pressing the shortcut (Control) (Shift) and (S). You then can try again, starting from that waypoint. You can use the spacebar to jump over obstacles that you might get stuck on. If everything doesn't help and you get stuck, you can use your Hearthstone in your bag and restart the route from the starting point. Continue manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [110]
            {
               ["GUID"] = "16807134034490108",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Navi für Trainernavigation",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Navi für Trainernavigation",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900112", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060112", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560110", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610111", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400111", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680110", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670111", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "Wenn du möchtest, dann lese deine Quest nun nochmal. Nutze dafür einfach die (Tooltip-Funktion). Drücke dafür wie gewohnt (Umschalttaste) und (Pfeil runter). Dein Klassenlehrer erwartet dich. Um zu ihm zu gelangen startest du eine (Rute) über das (Navigationsmenü). Dieses erreichst du von der Quest aus immer mit (Pfeil rechts). Gehe also nach dem lesen ins Navigationsmenü mit (Pfeil rechts).",
                  ["enUS"] = "If you want, read your quest again now. Just use the tooltip feature. Press (Shift) and (Down arrow) as usual. Your class trainer is waiting for you. To get to him you start a route via the navigation menu. You can always reach it from the quest with (right arrow). So after reading the quest go to the navigation menu with (right arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,2,1,1",
                        ["enUS"] = "4,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,1,1,1",
                        ["enUS"] = "4,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "4,1,3,1,1",
                        ["enUS"] = "4,1,3,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]                  
               },
            }, -- [111]
            {
               ["GUID"] = "16807134034490109",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Vollständigkeit Pre Quest erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:Vollständigkeit Pre Quest erklären",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900113", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060113", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560111", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610112", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400112", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680111", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670112", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Zur Vollständigkeit: Ganz unten in dieser Navigationsliste findest du manchmal auch den Menüpunkt (Pre Quests). Was bedeutet das? In dem Untermenü findest du die Vorquest dieser Quest. Das wird später im Spiel zur Recherche noch wichtig. Schalte nun manuell weiter.",
                  ["enUS"] = "Just if you are wondering: At the end of this navigation list you can sometimes find the menu item (Pre Quests). What does this mean? In the submenu you will find the prequest of this quest. This will be important later in the game to find quests. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [112]
            {
               ["GUID"] = "16807134034490110",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zielnavigation Klassenlehrer",
                  ["enUS"] = "UNTRANSLATED:deDE:Zielnavigation Klassenlehrer",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900114", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060114", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560112", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610113", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400113", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680112", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670113", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "Du hast die Quest bereits angenommen. Du möchtest sie beim Klassenlehrer abgeben. Gehe also auf (Abgabe) und dann mehrmals nach (rechts), bis du den Wegpunkt mit Entfernungsangabe hörst. ",
                  ["enUS"] = "You have already accepted the quest. You would like to turn it at the class trainer. So go to (Quest End) and then right several times until you hear the waypoint with distance information. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,2,1,2,1,1,1,1",
                        ["deDE"] = "4,1,2,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,3,1,2,1,1,1,1",
                        ["deDE"] = "4,1,3,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,1,2,1,1,1,1",
                        ["deDE"] = "4,1,1,1,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [3]
                  {
                     ["value"] = {
                        ["enUS"] = "4,1,1,2,2,1,1,1,1",
                        ["deDE"] = "4,1,1,2,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [4]
               },
            }, -- [113]
            {
               ["GUID"] = "16807134034490111",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670114", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and now move along the waypoints until you reach the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8918.7;-207.8;5",
                        ["enUS"] = "-8918.7;-207.8;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [114]
            {
               ["GUID"] = "16807134034490114",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Kriegerlehrer anvisieren und ansprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Kriegerlehrer anvisieren und ansprechen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670115", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "nehme deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "911",
                        ["enUS"] = "911",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [115]
            {
               ["GUID"] = "16807134034490115",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670116", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Ich benötige eine Kriegerausbildung) und die angenommene Quest. Wähle zuerst die angenommene Quest aus. Das machst du, indem du nach rechts gehst und im untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
                  ["enUS"] = "In the dialog pane you will find the menu item (I need warrior training) and the accepted quest. First select the accepted quest. You do this by going to the right and confirming in the submenu (left click) with the (enter) key. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [116]
            {
               ["GUID"] = "16807134034490116",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "questfenster mit 2 Stufen eins",
                  ["enUS"] = "UNTRANSLATED:deDE:questfenster mit 2 Stufen eins",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900118", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060118", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560116", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610117", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400117", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680116", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670117", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "Du weißt bereits, wie man eine Quest abgibt. Das Questfenster ist relativ übersichtlich. Hier in diesem Fall gibt es 2 Fenster. Das erste fenster, welches geöffnet ist, zeigt dir, was du brauchst, um die Quest abgeben zu können. Wenn du den Gegenstand nicht bei dir trägst, kannst du die Quest nicht abgeben. Es ist dann ein Gongton zu hören. Du solltest den Brief für deinen Klassenlehrer aber in der Tasche haben. Unten befindet sich die Schaltfläche (weiter). du kannst auch einfach (Leertaste) drücken, um weiter zu schalten.",
                  ["enUS"] = "You know how to turn in a quest. The quest panel should be quite clear. Here in this case it has 2 steps. The first panel, which is now open, welcomes you and shows you what you need to turn in the quest. If you do not have the item with you, this panel will not let you continue. Then there will be a gong sound. However, you should have the letter for your class trainer in your bag. At the bottom is the (Continue) button. You can also just press (spacebar) to continue.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 71,
                        ["enUS"] = 71,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 27,
                        ["enUS"] = 27,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["GUID"] = "16807134034490117",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "questfenster mit 2 stufen zwei",
                  ["enUS"] = "UNTRANSLATED:deDE:questfenster mit 2 stufen zwei",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900119", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060119", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560117", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610118", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400118", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680117", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670118", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = " Das ist das Fenster für die (Questabgabe). Du weißt bereits, wie man eine Quest abgibt. Suche die Schaltfläche (Abschließen). Questfenster lassen sich auch immer mit der (Leertaste) bestätigen. Gebe die Quest nun ab. ",
                  ["enUS"] = "This is the panel for (quest turn in). You already know how to turn in a quest. Find the (Complete quest) button. Quest panels can also always be confirmed with the (spacebar). Turn in the quest now. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 61,
                        ["enUS"] = 61,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [118]
            {
               ["GUID"] = "16807134034490118",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670119", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier hat sich der Dialog automatisch nach der Questabgabe geschlossen. Interagiere mit dem NPC erneut durch drücken der Taste (G).",
                  ["enUS"] = "Here the dialog closed automatically after the quest was turned in. Interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "911",
                        ["enUS"] = "911",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [119]
            {
               ["GUID"] = "16807134034490119",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670120", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Ich benötige eine Kriegerausbildung). Das Lehrerfenster öffnet sich dann.",
                  ["enUS"] = "Now select (I need warrior training). The trainer dialog box will then open.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [120]
            {
               ["GUID"] = "16807134034490120",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "nach rechts ins Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:nach rechts ins Lehrerfenster",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900122", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060122", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560120", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610121", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400121", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680120", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670121", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe einmal nach (rechts), um in das Lehrerfenster zu gelangen. ",
                  ["enUS"] = "Go right once to get to the trainer dialog box. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,1",
                        ["enUS"] = "9,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [121]
            {
               ["GUID"] = "16807134034490121",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670122", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Zuerst findest du die Kategorie und darunter den Zauber. für dich hat dieser Lehrer in der Kategorie (Furor) den Zauber (Schlachtruf). Der Zauber ist bereits ausgewählt. Weiter unten wiederholt sich das Wort (Schlachtruf). Davor wird (text) angesagt. Das ist der (Button) für den Zauber, der ausgewählt ist. Suche nun diesen button.",
                  ["enUS"] = "This is the trainer dialog box. First you will find the category and below that a spell. For you, this trainer has the ability (Battle Shout) in the category (Fury). The ability is already selected. Further down the word (Battle Shout) is repeated. Before that, (text) is pronounced. This is the button for the ability that is selected. Find it.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [122]
            {
               ["GUID"] = "16807134034490122",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900124", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670123", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060124", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400123", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680122", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560122", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier auf dem Zauber kannst du die (Tooltip-Funktion) nutzen, um die Details des Zaubers zu lesen. Probiere es doch einfach mal aus. ",
                  ["enUS"] = "Here on the ability you can use the tooltip feature to read the details of the ability. Try this. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [3]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [4]
               },
            }, -- [123]
            {
               ["GUID"] = "16807134034490123",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausbilden",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausbilden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900125", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670124", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060125", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400124", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680123", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560123", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Falls du genug Kupfer mitgebracht hast, dann kannst du diese Fähigkeit nun erlernen. Falls du nicht genug hast, kannst du die Fähigkeit auch bei einem späteren Besuch erlernen. Der Lehrer bietet dir alle zwei Stufen neue Zauber an. Unten findest du die Schaltfläche (Ausbilden). Klicke sie an, indem du wie üblich einen (Linksklick) im (Untermenü) mit der (Eingabetaste) ausführst. Wenn du einen Zauber erfolgreich erlernt hast, signalisiert dir das ein besonderes Geräusch. Daran kannst du erkennen, ob es funktioniert hat. Schließe dann das Lehrerfenster mit (Escape).",
                  ["enUS"] = "If you have enough copper with you, then you can now learn this skill. If you don't have enough, you can learn the skill during a later visit. The trainer will offer you new skills every two levels. At the bottom you will find the (Train) button. Click it by (left-clicking) in the (submenu) with the (Enter) key as usual. Each time you learn a skill, you will hear a special sound. This is how you can tell if it worked. Then close the trainer dialog box with Escape.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [124]
            {
               ["GUID"] = "16807134034490124",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit in die Leiste bringen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit in die Leiste bringen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900126", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670125", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060126", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400125", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680124", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560124", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du den neuen Zauber benutzen möchtest, musst du diesen auf die Aktionsleiste legen. öffne das aktionsleistenmenü mit (umschalttaste) und (F 11).",
                  ["enUS"] = "If you want to use the new ability, you have to put it on the action bar. Open the action bar menu with (shift) and (F 11).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1",
                        ["enUS"] = "5,4,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [125]
            {
               ["GUID"] = "16807134034490125",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Auf leiste gehen und Platz suchen",
                  ["enUS"] = "UNTRANSLATED:deDE:Auf leiste gehen und Platz suchen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900127", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060127", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560125", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610126", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400126", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680125", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670126", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist nun wieder im Auswahlmenü für die Aktionsleisten. Gehe einmal nach unten auf die untere linke Aktionsleiste. und dort einmal nach rechts in die Leiste hinein. Dann  gehe dort ganz nach unten auf den Button 12 (leer) Taste F12.",
                  ["enUS"] = "You are now back in the action bar selection menu. Go down once to the lower left action bar. and there once to the right into the bar. Then go all the way down there to the button 12 (empty) key F12.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,2,12",
                        ["enUS"] = "5,4,2,12",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [126]
            {
               ["GUID"] = "16807134034490126",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Untermenü der buttons",
                  ["enUS"] = "UNTRANSLATED:deDE:Untermenü der buttons",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900128", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060128", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560126", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610127", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400127", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680126", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670127", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Jeder button hat ein (Untermenü). du erreichst es, indem du auf dem Button nach rechts gehst. Drücke also einmal (Pfeil rechts).",
                  ["enUS"] = "Each button has a submenu. You can reach it by moving to the right on the button. So press right arrow once.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "keine aktion zuweisen",
                        ["enUS"] = "Assign no action",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [127]
            {
               ["GUID"] = "16807134034490127",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670128", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nachSchlachtruf.",
                  ["enUS"] = "(Assign no action) is the menu item to make this button empty again. You can use it to remove actions from the bar. Further down you will find different categories. If you go to the right on a category, you will find the spells and abilities of the category, which can be placed on the button. Search for Battle Shout.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Schlachtruf",
                        ["enUS"] = "Battle Shout",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [128]
            {
               ["GUID"] = "16807134034490128",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["linkedIn"] = {
                  ["168111672832530001"] = {
                     "168111674145670129", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! du hast den (Schlachtruf) gefunden. Du kannst die Details des Zaubers auch hier mit der Tooltipfunktion lesen. Lege den Schlachtruf nun auf den button indem du die (Eingabetaste) drückst. Schließe das Aktionsleistenmenü dann mit (Escape).",
                  ["enUS"] = "Great! You have found Battle Shout. You can also read the details of the ability here with the tooltip feature. Now put the Battle Shout on the button by pressing (Enter). Then close the action bar menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [129]
            {
               ["GUID"] = "16807134034490129",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fast alles erlernt",
                  ["enUS"] = "UNTRANSLATED:deDE:Fast alles erlernt",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900131", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060131", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560129", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610130", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400130", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680129", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670130", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das hast du gut gemacht %name%. Du hast das tutorial fast abgeschlossen. Das nötige Handwerkszeug hast du bereits erlernt. Du kannst nun noch ein paar wenige Infos hören und dann frei spielen. Schalte das tutorial manuell weiter.",
                  ["enUS"] = "You did a good job %name%. You have almost completed the tutorial. You have already learned the necessary tools. You can now listen to a few more infos and then play on your own. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [130]
            {
               ["GUID"] = "16807134034490130",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Menü schließen und Questdatenbank öffnen",
                  ["enUS"] = "UNTRANSLATED:deDE:Menü schließen und Questdatenbank öffnen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900132", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060132", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560130", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610131", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400131", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680130", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670131", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du musst wissen, wie du Quests finden kannst, die in deiner Umgebung für dich verfügbar sind. Öffne dein Questbuch bitte mit (L)",
                  ["enUS"] = "You need to know how to find quests that are available for you in your area. Please open your quest log with (L)",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [131]
            {
               ["GUID"] = "16807134034490131",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "auf nahe quests bewegen",
                  ["enUS"] = "UNTRANSLATED:deDE:auf nahe quests bewegen",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900133", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060133", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560131", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610132", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400132", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680131", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670132", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du stehst nun im Questbuch auf der ersten Position. Du weißt bereits, dass du nach rechts gehen kannst um deine Quests zu sehen. Gehe jetzt einmal nach unten, um die (Datenbank) zu nutzen.",
                  ["enUS"] = "You are now on the first item in the quest log. You already know that you can go to the right to see your quests. Now go down once to use the database.  ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,2",
                        ["enUS"] = "4,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [132]
            {
               ["GUID"] = "16807134034490132",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Einfach halten",
                  ["enUS"] = "UNTRANSLATED:deDE:Einfach halten",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900134", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060134", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560132", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610133", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400133", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680132", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670133", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier hast du diverse Möglichkeiten zur Recherche. Halte es vorerst aber simpel und gehe drei mal nach (rechts).",
                  ["enUS"] = "Here you have several options for research. But keep it simple for now and go right three times.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,2,1,1,1",
                        ["enUS"] = "4,2,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [133]
            {
               ["GUID"] = "16807134034490133",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Übersicht der verfügbaren quests",
                  ["enUS"] = "UNTRANSLATED:deDE:Übersicht der verfügbaren quests",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900135", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060135", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560133", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610134", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400134", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680133", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670134", -- [1]
                  },
               },
               ["allTriggersRequired"] = false,
               ["beginText"] = {
                  ["deDE"] = "In dieser Liste findest du alle Quests, die für dich in deiner Umgebung verfügbar sind. Mit der Tooltip-Funktion, (Umschalt Pfeil runter), kannst du die Kurzinfo zur Quest abrufen. Wenn du nach rechts gehst, bist du wieder auf der Navigationsebene. Gehe auf der obersten Quest nach (rechts).",
                  ["enUS"] = "In this list you will find all quests, which are available for you in your area. With the tooltip feature (Shift down arrow as always) you can get details about the quest. If you go to the right, you are back on the navigation level. Go right on the top quest.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "4,2,1,1,1,1",
                        ["enUS"] = "4,2,1,1,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [134]
            {
               ["GUID"] = "16807134034490134",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "neue Aufgaben finden",
                  ["enUS"] = "UNTRANSLATED:deDE:neue Aufgaben finden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900136", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060136", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560134", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610135", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400135", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680134", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670135", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du bist nun wieder in der gewohnten Navigationsebene mit (annahme) (ziel) (abgabe) und wenn vorhanden auch (Pre quest). Da du diese Quest noch nicht hast und ja genau deshalb in der Datenbank suchst, müsstest du diesmal auf (Annahme) nach rechts gehen. Ganz am Ende würde dir der (Questgeber) mit einer Entfernungsangabe genannt werden. mit Eingabetaste könntest du eine Rute starten und dir die Quest holen. Höre dir aber zuerst den Rest vom Tutorial an, indem du weiterschaltest. ",
                  ["enUS"] = "You are now back in the usual navigation men with (Quest Start) (Quest Target) (Quest End) and if available also (pre quest). Since you don't have this quest yet, that's why you're searching in the database, you would have to go to (Quest start) and to the right. At the very end you would be told the quest giver with a distance. With enter you could start a route and get to the quest giver. However, listen to the rest of the tutorial first. Please Continue manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [135]
            {
               ["GUID"] = "16807134034490135",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Info zum Ende",
                  ["enUS"] = "UNTRANSLATED:deDE:Info zum Ende",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900137", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060137", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560135", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610136", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400136", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680135", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670136", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Du kannst jetzt entscheiden, ob du dir eine neue Quest abholen möchtest oder ob du erst die eine Quest in deinem Questbuch erledigen willst. Es ist immer eine gute Idee, erst alle Quests in der nahen Umgebung von ungefähr 100 Metern einzusammeln, sie dann zu lesen und dann abzuarbeiten. Wenn du alle Aufgaben im Startgebiet erledigt hast solltest du ungefähr das Level 5 erreicht haben. Die NPCs werden dich dann mit weiteren Quests in die nächste Ortschaft schicken. Schalte das tutorial weiter.",
                  ["enUS"] = "You can now decide if you want to pick up a new quest or if you want to do the already accepted quest in your quest log first. It's always a good idea to first collect all the quests in range of about 100 meters, then read them and then proceed. When you have completed all the quests in the starting area you should have reached about level 5. The NPCs will then send you to the next settlement, where you will find more quests. Continue the tutorial.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [136]
            {
               ["GUID"] = "16807134034490136",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Was dich erwartet",
                  ["enUS"] = "UNTRANSLATED:deDE:Was dich erwartet",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900138", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560136", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610137", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400137", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680136", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670137", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dort im Wald von Elwyn wird es nicht mehr so sein wie hier. Hier greift dich kein Gegner von allein an. Dort finden sich im Wald aber wilde Wölfe, Murlocs und anderes Getier. Es kann sogar sein, dass du auf der Straße von Dieben angegriffen wirst. Wenn du hier einen Gegner ins Ziel nimmst, wird vor dem Namen des Gegners (passiv) angesagt. Alle Gegner, die aggressiv sind und dich angreifen, sobald du in ihre Nähe kommst, haben diesen Zusatz nicht. Wenn dich ein Gegner angreift hast du ihn übrigens automatisch im Ziel. Du musst dann nur (G) drücken um ihn anzugreifen. Schalte manuell weiter.",
                  ["enUS"] = "There, in Elwynn Forest, it won't be the same as here. Here, no enemy will attack you without being attacked. But there you will find wild wolves, murlocs and other creatures. You may even be attacked by thieves on the road. If you target an enemy here in the starting area, you'll hear the word (passive) before the enemy's name. All enemies that are aggressive and attack you as soon as you get close to them do not have this (passive) addition. By the way, if an enemy is attacking you, it automatically will get your target. You then only have to press (G) to fight it. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [137]
            {
               ["GUID"] = "16807134034490137",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wie du dich vorbereiten kannst",
                  ["enUS"] = "UNTRANSLATED:deDE:Wie du dich vorbereiten kannst",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900139", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060139", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560137", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610138", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400138", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680137", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670138", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "%class%, versuche immer, möglichst gute ausrüstung zu tragen. Habe außerdem immer Essen und Trinken dabei. Essen füllt dein (leben) auf und Trinken dein (Mana). Beides geht jedoch nur außerhalb eines Kampfes. Krieger und Schurken haben kein Mana und brauchen folglich auch keine Getränke. Lege dir die verzehrbaren Gegenstände gern auch auf einen Button. gegenstände findest du im Untermenü eines Aktionsleistenbuttons. Dann musst du zukünftig nur einen Knopf drücken, um zu regenerieren. Schalte manuell weiter.",
                  ["enUS"] = "%class%, always try to wear as good equipment as possible. Also, always have food and drink with you. Food restores your health and drink restores your mana. However, both can only be used out of combat. Warriors and rogues don't have mana and therefore don't need drinks. You can also add those consumable items to an action button. Items can be found in the submenu of an action bar button. Then you only have to press one button to regenerate. Continue manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [138]
            {
               ["GUID"] = "16807134034490138",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wo du mehr Informationen erhalten kannst",
                  ["enUS"] = "UNTRANSLATED:deDE:Wo du mehr Informationen erhalten kannst",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900140", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060140", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560138", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610139", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400139", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680138", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670139", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Grundsätzlich ist es eine gute Idee, dich einer (Gilde), also einem Zusammenschluss anderer Spieler, anzuschließen. World of Warcraft ist ein Multiplayer-Spiel und allein würdest du es nicht leicht haben. In einer (Gilde) kannst du auch immer andere erfahrenere Spieler erreichen, falls du Fragen hast. Du kannst natürlich auch in den allgemeinen Chatkanälen mit anderen Spielern in Kontakt treten. Außerdem findest du viele tips und Kontakte auf dem SkuAddon-Discordserver. Dort kannst du natürlich auch Fragen stellen, die sich auf das SkuAddon oder das blind Spielen im Allgemeinen beziehen. Spiele gern eine weile für dich allein, wenn du es möchtest. Behalte aber einfach im Hinterkopf, dass es eine gute Idee ist, Kameraden zu finden. Schalte jetzt weiter.",
                  ["enUS"] = "It's a good idea to join a guild. That is a community of players. World of Warcraft is a multiplayer game and you would not have an easy time alone. In a guild you can always talk to other more experienced players if you have questions. Of course, you can also get in touch with other players in the general chat channels. You can also find many tips and contacts on the SkuAddon discord server. There you can also ask questions about SkuAddon or blind gaming in general. Feel free to play alone for a while if you like. Just keep in mind that it's a good idea to find fellow players. Continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [139]
            {
               ["GUID"] = "16807134034490139",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Tutorials finden",
                  ["enUS"] = "UNTRANSLATED:deDE:Tutorials finden",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900141", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060141", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560139", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394610140", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400140", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680139", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670140", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das SkuAddon hat weitere Hilfen zur Bedienung in Form von tutorials an bord. Es ist auch eine Wiki mit Informationen über die Welt integriert. Den Tutorial und Wiki Bereich findest du, im SkuMenü. Öffne es mit (Umschalttaste) und (F 1). Es bietet dir alle Funktionen des SkuAddons in einem großen AudioMenü. (Tutorials und wiki) erreichst du mit (Pfeil runter) auf der siebten Position. Wie üblich kannst du mit (Pfeil rechts) in das Untermenü gelangen. Schalte noch einmal weiter. ",
                  ["enUS"] = "The SkuAddon has additional tutorials. There is also a wiki with information about the world. You can find the tutorial and wiki section in the SkuMenu. Open it with (Shift) and (F 1). All features of the SkuAddon are available in one big Audio Menu. (Tutorials and wiki) can be reached with (down arrow) to the seventh menu item. As usual you can reach the submenu with right arrow. Continue the tutorial. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [140]
            {
               ["GUID"] = "16807134034490140",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Lebe wohl!",
                  ["enUS"] = "UNTRANSLATED:deDE:Lebe wohl!",
               },
               ["linkedIn"] = {
                  ["168113133067660002"] = {
                     "168113135188900142", -- [1]
                  },
                  ["168370330453520001"] = {
                     "168370332978060142", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811365965003560140", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811389877394620141", -- [1]
                  },
                  ["168111678387860001"] = {
                     "1681116816120400141", -- [1]
                  },
                  ["16811221545459280001"] = {
                     "16811222675571680140", -- [1]
                  },
                  ["168111672832530001"] = {
                     "168111674145670141", -- [1]
                  },
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "%name%! Es ist nun Zeit, vorerst Abschied zu nehmen. Sei tapfer und halte durch. Diese Welt ist riesig und es gibt unendlich viel zu entdecken. Eines Tages wirst du Drachen töten, Dämonen besiegen und neue Länder erforschen. Auf ins Abenteuer und gehabt euch wohl!",
                  ["enUS"] = "%name%! It is now time to say goodbye for now. Be brave and keep fighting. This world is huge and there is endless stuff to explore. One day you will slay dragons, defeat demons and explore new lands. Off you go on your adventure and farewell!",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
               },
            }, -- [141]
         },
         ["isSkuNewbieTutorial"] = false,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Basistutorial 1",
            ["enUS"] = "Human Base Tutorial 1",
         },
         ["requirements"] = {
            ["race"] = 990,
            ["skill"] = 999,
            ["class"] = 99,
         },
      },
      ["16811389677374010001"] = {
         ["lockKeyboard"] = true,
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 9,
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Hexenmeister 1",
            ["enUS"] = "Human Warlock 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = false,
         ["playFtuIntro"] = true,
         ["GUID"] = "16811389677374010001",
         ["steps"] = {
            {
               ["GUID"] = "16811389877394610002",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "16811389877394610003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "16811389877394610004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "16811389877394610005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "16811389877394610006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "16811389877394610007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "16811389877394610008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "16811389877394610009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "16811389877394610010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "16811389877394610011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "16811389877394610012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "16811389877394610013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "16811389877394610014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "16811389877394610015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "16811389877394610016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "16811389877394610017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "16811389877394610018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837015631534460001",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "16811389877394610019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "16811389877394610020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "16811389877394610021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "16811389877394610022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "16811389877394610023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "16811389877394610024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "16811389877394610025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "16811389877394610026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "16811389877394610027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "16811389877394610028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "16811389877394610029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "16811389877394610030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "16811389877394610031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "16811389877394610032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "16811389877394610033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["GUID"] = "16811391757581940001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Schattenblitz auf Button 1",
                  ["enUS"] = "UNTRANSLATED:deDE:Schattenblitz auf Button 1",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier auf Button 1 liegt der Zauber (Schattenblitz). Es handelt sich um einen Zauber, den du wirken kannst, wenn du dich nicht bewegst. Wirken bedeutet, er hat eine Zauberzeit. Wenn du ihn vollständig gezaubert hast, bekommt dein Gegner Schaden. Wenn du während des Wirkens Schaden erhälst, wird die Zauberzeit verlängert. Versuche also zu zaubern, wenn der Gegner noch weit entfernt ist und erst zu dir laufen muss. lese die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "Here on button 1 is the spell (Shadow Bolt). It is a spell that you can cast when you are not moving. Casting it means that it has a casting time. When you cast it completed, your enemy will get damage. If you receive damage while casting it, the casting time is extended. So try to cast when the enemy is still far away and has to move to you first. read the details with the tooltip feature (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [34]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Auf Button 2 gehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Auf Button 2 gehen",
               },
               ["GUID"] = "16811389877394610034",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe mit (Pfeil runter) auf Button 2, welcher der Taste 2 entspricht.",
                  ["enUS"] = "Go to button 2 with (down arrow), which corresponds to button 2.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1,2",
                        ["enUS"] = "5,4,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [35]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Klasse Fähigkeit Button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Klasse Fähigkeit Button 2",
               },
               ["GUID"] = "16811389877394610035",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf Button 2 befindet sich der Zauber (Dämonenhaut). Dieser Zauber stärkt dich für eine gewisse Zeit. Stärkungszauber nennt man auch Buffs. Lies die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "On button 2 you will find the spell (Demon Skin). This spell strengthens you for a certain time. Strengthening spells are also called buffs. Read the details with the tooltip feature (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [36]
            {
               ["GUID"] = "16811389877394610036",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [37]
            {
               ["GUID"] = "16811389877394610037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "16811389877394610038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "16811389877394610039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "16811389877394610040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "16811389877394610041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "16811389877394610042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "16811389877394610043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "16811389877394610044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "16811389877394610045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "16811389877394610046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "16811498166863300009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900048",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["GUID"] = "16811389877394610048",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [49]
            {
               ["GUID"] = "16811389877394610049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "16811389877394610050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "16811499146961710010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900052",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["GUID"] = "16811389877394610052",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [53]
            {
               ["GUID"] = "16811389877394610053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "16811499977044460011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "168113133067660002",
                  ["SourceTutorialStepGUID"] = "168113135188900055",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["GUID"] = "16811389877394610055",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [56]
            {
               ["GUID"] = "16811389877394610056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "16811389877394610057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "168115417611224140001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Hexenmeistervermögen",
                  ["enUS"] = "UNTRANSLATED:deDE:Hexenmeistervermögen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hinweis: Der Klassenlehrer der Hexenmeister verlangt im Vergleich zu anderen mehr Kupfer für seine Lehrstunden. Um dir alle Zauber leisten zu können, musst du unbedingt mehr Beute einsammeln. Töte ungefähr 15 weitere Gegner und plündere sie. Das Tutorial führt dich vor dem Besuch des Klassenlehrers zur Questabgabe und zu einem Händler, bei dem du deine Beute zu Kupfer machen kannst. Beim Klassenlehrer benötigst du 1 Silber und 5 Kupfer. Bevor du zum Klassenlehrer aufbrichst, überprüfe zunächst dein derzeitiges Vermögen auf der Übersichtseite. Schalte das Tutorial manuell weiter. ",
                  ["enUS"] = "Note: The class trainer of warlocks charges more copper for his lessons compared to others. In order to afford all the spells, it is imperative that you collect more loot. Kill about 15 more enemies and loot them. The tutorial will take you to the quest drop and a merchant where you can turn your loot into copper before visiting the class trainer. At the class trainer, you will need 1 silver and 5 coppers. Before you leave for the class trainer, first check your current bankroll on the overview page. Continue the tutorial manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [59]
            {
               ["GUID"] = "16811389877394610058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "16811389877394610059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "16811389877394610060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "16811389877394610061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "16811389877394610062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "16811389877394610063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "16811389877394610064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "16811389877394610065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "16811389877394610066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "16811389877394610067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "16811389877394610068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "16811389877394610069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "16811389877394610070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "16811389877394610071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "16811389877394610072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "16811389877394610073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "16811389877394610074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "16811389877394610075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "16811389877394610076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "16811389877394610077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "16811389877394610078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "16811389877394610079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "16811389877394610080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "16811389877394610081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "16811389877394610082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "16811389877394610083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "16811389877394610084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "16811389877394610085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["GUID"] = "16811389877394610086",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du nur Stoffrüstung tragen. Sicher möchtest du sehen, welche Ausrüstung du aktuell angezogen hast. Gehe dafür auf (Ausrüstung) nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As a %class%, you can only wear cloth armor. You may want to see what equipment you are currently wearing. To do so, go to (Equipment) to the right to (Items) and then to the right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [88]
            {
               ["GUID"] = "16811389877394610087",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "16811389877394610088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "16811389877394610089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "16811389877394610090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "16811389877394610091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "16811389877394610092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "16811389877394610093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "16811389877394610094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "16811389877394610095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "16811389877394610096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "16811389877394610097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "16811389877394610098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "16811389877394610099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "16811389877394610100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "16811389877394610101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "16811389877394610102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "16811389877394610103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "16811389877394610104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "16811389877394610105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "16811389877394610106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["GUID"] = "16811389877394610107",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nach rechts in das erste Untermenü. Du weißt bereits, das die Quests dort nach Regionen oder Kategorien sortiert sind. Gehe dann von (Alle) nach unten, bis du (Hexenmeister) findest.",
                  ["enUS"] = "Go right to the first submenu. You already know that the quests are sorted by region or category. Then go down from (All) until you find (Warlock).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Hexenmeister",
                        ["enUS"] = "Warlock",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [109]
            {
               ["GUID"] = "16811389877394610108",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "16811389877394610109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "16811389877394610110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "16811389877394610111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "16811389877394610112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "16811389877394610113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["GUID"] = "16811389877394610114",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and follow the waypoints to the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8926.6;-195.4;5",
                        ["enUS"] = "-8926.6;-195.4;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [116]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Hexenmeisterlehrer anvisieren und ansprechen",
                  ["enUS"] = "UNTRANSLATED:deDE:Hexenmeisterlehrer anvisieren und ansprechen",
               },
               ["GUID"] = "16811389877394610115",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nehme deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G) um das Dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "459",
                        ["enUS"] = "459",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["GUID"] = "16811389877394610116",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Ich bin an einer Hexenmeister ausbildung interessiert) und die angenommene Quest. Wähle zuerst die angenommene Quest aus, indem du nach rechts gehst und im Untermenü (Linksklick) mit der (eingabetaste) bestätigst. ",
                  ["enUS"] = "In the dialog pane you will find the menu item (I am interested in becoming a warlock) and the accepted quest. First select the accepted quest by going to the right and confirming in the submenu (left click) with the (enter) key. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [118]
            {
               ["GUID"] = "16811389877394610117",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["GUID"] = "16811389877394610118",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["GUID"] = "16811389877394610119",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wie du bemerkt hast, ist das Dialogfenster jetzt geschlossen. Interagiere nun erneut mit dem NPC, indem du die Taste (G) drückst.",
                  ["enUS"] = "As you noticed, the dialog pane is now closed. Now interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "459",
                        ["enUS"] = "459",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [121]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["GUID"] = "16811389877394610120",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Ich bin an einer Hexenmeister ausbildung interessiert), um das Lehrerfenster zu öffnen.",
                  ["enUS"] = "Now select (I am interested in a warlock training) to open the trainer dialog box.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [122]
            {
               ["GUID"] = "16811389877394610121",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [123]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["GUID"] = "16811389877394610122",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Die momentan für dich erlernbaren Zauber werden hier in einer Liste angezeigt, die in Kategorien sortiert ist. Dieser Lehrer bietet dir in der Kategorie (Dämonologie) den Zauber (Wichtel beschwören) an, ferner den Zauber (Feuerbrand) in der Kattegorie (Zerstörung). der Erste Zauber, in diesem Fall (Wichtel beschwören) wird automatisch vom Spiel ausgewählt. Weiter unten wiederholt sich der Begriff (Wichtel beschwören). Davor wird (text) angesagt. Das ist der Menüpunkt für die ausgewählte Fähigkeit oder den ausgewählten Zauber. Suche jetzt diesen Menüpunkt.",
                  ["enUS"] = "This is the trainer dialog box. The spells you can currently learn are displayed here in a list, sorted into categories. This trainer offers you the spell (Summon Imp) in the category (Demonology), and the spell (Immolate) in the category (Destruction). The first spell, in this case (Summon Imp), is automatically selected by the game. Further down, the term (Summon Imp) is repeated. Before that, (text) is pronounced. This is the menu item for the selected ability or spell. Now search for this menu item.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Text",
                        ["enUS"] = "Text",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "Wichtel beschwören",
                        ["enUS"] = "Summon Imp",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [124]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen",
               },
               ["GUID"] = "16811389877394610123",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du den Menüpunkt der Fähigkeit / des Zaubers ausgewählt hast, kannst du die Tooltipfunktion verwenden, um Details über die Fähigkeit oder den Zauber zu erfahren. Probiere es doch gleich mal aus. ",
                  ["enUS"] = "Once you have selected the menu item for the spell, you can use the tooltip feature to get details about the ability or spell. Why don't you try it out now? ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [3]
               },
            }, -- [125]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausbilden",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausbilden",
               },
               ["GUID"] = "16811389877394610124",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Falls du genug Kupfer verdient hast, kannst du diesen Zauber nun erlernen. Falls du derzeit über zu wenig Kupfer verfügst, ist die gewünschte Schaltfläche nicht vorhanden. Dies könntest du dann aber ohne Weiteres bei einem späteren Besuch nachholen. Der Lehrer bietet dir alle zwei Stufen neu erlernbare Fähigkeiten oder Zauber an. Unten findest du die Schaltfläche (Ausbilden). Klicke sie an, indem du wie üblich einen (Linksklick) im (Untermenü) mit der (Eingabetaste) ausführst. Wenn du eine Fähigkeit oder einen Zauber erlernst, wird dies durch ein Geräusch akustisch rückgemeldet. Daran kannst du erkennen, ob es funktioniert hat. Schalte das tutorial dann manuell weiter. ",
                  ["enUS"] = "If you have earned enough copper, you can now learn this spell. If you currently have too little copper, the desired button is not available. You can easily do this on a later visit. The trainer offers you new skills or spells every two levels. At the bottom you will find the button (Train). Click it by (left-clicking) in the (submenu) with the (Enter) key as usual. When you learn an ability or a spell, you will hear a sound. This tells you if it worked or not. Then continue the tutorial manually. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [126]
            {
               ["GUID"] = "16811404378844010002",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Zweite Fähigkeit kaufen",
                  ["enUS"] = "UNTRANSLATED:deDE:Zweite Fähigkeit kaufen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Der zweite Zauber, den du bei deinem Klassenlehrer lernen kannst, heißt (Feuerbrand). dieser ist, wenn du alles bisherige richtig gemacht hast, nun automatisch ausgewählt. Du musst also nur auf (ausbilden) gehen und wieder im Untermenü die Schaltfläche (Linksklick) mit der (Eingabetaste) bestätigen. Schließe das Fenster danach mit (Escape).",
                  ["enUS"] = "The second spell you can learn from your class trainer is called (Immolate). If you have done everything correctly so far, it is now automatically selected. So you only have to go to (train) and again in the submenu confirm the button (left click) with the (enter) key. Close the panel afterwards with (Escape).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [127]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit in die Leiste bringen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit in die Leiste bringen",
               },
               ["GUID"] = "16811389877394610125",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du einen neuen Zauber verwenden möchtest, musst du diesen auf die Aktionsleiste legen. öffne das aktionsleistenmenü mit (umschalttaste) und (F 11).",
                  ["enUS"] = "If you want to use a new spell, you have to put it on the action bar. open the action bar menu with (shift) and (F 11).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1",
                        ["enUS"] = "5,4,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [128]
            {
               ["GUID"] = "16811389877394610126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["GUID"] = "16811389877394610127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [130]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["GUID"] = "16811389877394610128",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nach dem zauber (Wichtel beschwören).",
                  ["enUS"] = "(Do not assign action) is the menu item to remove an assigned action from the button. Under the menu item you can find different categories. If you go to the right on a category, you will find the spells of the category that can be assigned to the button. Search for the spell (Summon Imp).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Wichtel",
                        ["enUS"] = "Imp",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [131]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["GUID"] = "16811389877394610129",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! du hast den Zauber gefunden. Du kannst die Details des Zaubers auch hier mit der Tooltipfunktion lesen. Lege den Zauber (Wichtel beschwören) nun auf den button indem du die (Eingabetaste) drückst. Schalte das tutorial dann manuell weiter.",
                  ["enUS"] = "Great! You have found the spell. You can also read the details of the spell here with the tooltip feature. Now put the spell (Summon Imp) on the button by pressing (Enter). Then continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [132]
            {
               ["GUID"] = "1681143475522720001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zweiten Zauber auf die Leiste bringen",
                  ["enUS"] = "UNTRANSLATED:deDE:zweiten Zauber auf die Leiste bringen",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nun musst du den Zauber (Feuerbrand) noch auf die Leiste legen. Suche dir dafür einen leeren Button und gehe in das (Untermenü) des buttons. Suche dort in den Kategorien den Zauber und lege ihn mit (eingabetaste) auf den button. Schließe das Menü dann mit (ESC).",
                  ["enUS"] = "Now you have to put the spell (Immolate) on the bar. Find an empty button and go to the (submenu) of the button. Search for the spell in the categories and put it on the button with (enter). Close the menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [133]
            {
               ["GUID"] = "16811457172765060001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wichtel 1",
                  ["enUS"] = "UNTRANSLATED:deDE:Wichtel 1",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "%class% - Du kannst nun deinen Begleiter rufen! Drücke dafür auf die Taste mit dem Zauber (Wichtel beschwören). das der Zauber beendet ist, erkennst du daran, dass dein Wichtel ein geräusch macht. Wenn du überprüfen möchtest, ob dein Wichtel wirklich gerufen wurde, dann drücke die Taste (E). Mit (E) nimmst du dich selbst ins Ziel. Bei wiederholtem druck auf (E) wird dann dein Begleiter ins Ziel genommen. Das Ziel wechselt mit jedem Druck auf (E) zwischen dir und deinem Begleiter. Schalte das Tutorial weiter, wenn dein Begleiter da ist. ",
                  ["enUS"] = "%class% - You can now call your pet! Press the button with the spell (Summon Imp). You can tell that the spell is completed when your imp makes a noise. If you want to check whether your Imp has really been summoned, press the (E) key. With (E) you target yourself. If you press (E) again, your pet will be targeted. The target switches between you and your pet each time you press (E). Continue the tutorial when your pet is there. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [134]
            {
               ["GUID"] = "16811457462793410002",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wichtel 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Wichtel 2",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Zuerst solltest du nun nachsehen, wie du den Begleiter steuern kannst. öffne dafür die Begleiterleiste. Öffne das Aktionsleistenmenü mit (Umschalttaste) und (F 11) und gehe ganz nach unten.",
                  ["enUS"] = "First, you should now look up how to control the pet. To do this, open the pet bar. Open the action bar menu with (Shift) and (F 11) and go to the bottom.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "begleiter",
                        ["enUS"] = "pet",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
                  {
                     ["value"] = {
                        ["deDE"] = "aktionsleiste",
                        ["enUS"] = "action bar",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [3]
               },
            }, -- [135]
            {
               ["GUID"] = "16811457682815340003",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wichtel 3",
                  ["enUS"] = "UNTRANSLATED:deDE:Wichtel 3",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Gehe nun mit (Pfeil rechts) auf die Buttons der Begleiteraktionsleiste. lese dort mit der Tooltipfunktion die Details alle Fähigkeiten. Achte dabei besonders auf die ersten 3 und die letzten 3 Buttons. Alle buttons dazwischen werden Automatisch zugewiesen. Alles zwischen Button 3 und Button 8 ist automatisch eingeschaltet und wird vom Wichtel auch automatisch ausgeführt. Schalte das Tutorial nach dem Lesen manuell weiter. ",
                  ["enUS"] = "Now go with (right arrow) to the buttons of the pet action bar. read there with the tooltip feature the details of all skills. Pay special attention to the first 3 and the last 3 buttons. All buttons in between will be assigned automatically. Everything between button 3 and button 8 is automatically turned on and will be automatically executed by the imp. Continue the tutorial manually after reading. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [136]
            {
               ["GUID"] = "16811457812828940004",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wichtel 4",
                  ["enUS"] = "UNTRANSLATED:deDE:Wichtel 4",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Besonders wichtig sind folgende Einstellungen. Mit (Steuerungstaste) und (9) schaltest du den Wichtel auf defensiv. Das bedeutet, der Wichtel wird automatisch angreifen, sobald einer von euch angegriffen wird. Mit (Steuerungstaste) und (0) kannst du ihn auf passiv schalten. Dann greift er nur an, wenn du ihm das befiehlst. Du solltest die beiden Einstellungsvarianten auf jeden Fall ausprobieren, wenn du wieder kämpfst. Tip: Wenn du deinen Wichtel zuerst in den Kampf schickst, werden die Gegner auch zuerst den wichtel angreifen. Klingt das nicht nach einer guten Idee, %class% ? Schalte das Tutorial manuell weiter.",
                  ["enUS"] = "The following settings are very important. With (control key) and (9) you switch the imp to defensive. This means the imp will automatically attack as soon as one of you is attacked. With (control key) and (0) you can switch him to passive. Then he will only attack when you tell him to. You should definitely try out the two settings when you fight again. Hint: If you send your imp into battle first, the enemies will also attack the imp first. Doesn't that sound like a good idea, %class% ? Continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "168115603713084560001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Wichtel 5",
                  ["enUS"] = "UNTRANSLATED:deDE:Wichtel 5",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Experimentiere gern mit den einstellungen (defensiv), (passiv) und (aggressiv) und nutze aktiv die Kombination (Steuerungstaste) und Taste (1), um den Wichtel in den Kampf zu schicken. Beachte aber: Diese kreatur kann auch sterben. Dann musst du den Dämon neu beschwören. Wenn er einen Gegner tötet, ohne, dass du ihm geholfen hast, wirst du dafür leider keine Erfahrung und auch keine Beute erhalten. Ja, Wichtel sind nützlich, so nützlich aber nun dann doch nicht. %class%, habe viel freude beim quälen des Dämons. Schalte das Tutorial nun manuell weiter.",
                  ["enUS"] = "Feel free to play around with the settings (defensive), (passive) and (aggressive) and actively use the combination (control key) and key (1) to send the imp into battle. Note, however, that this creature can also die. Then you have to summon the minion again. Unfortunately, if it kills an enemy without you helping it, you won't get any experience or loot for it. Yes, imps are useful, but not that useful after all. %class%, have fun torturing the demon. Now continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [138]
            {
               ["GUID"] = "16811389877394610130",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "16811389877394610131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "16811389877394610132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
            {
               ["GUID"] = "16811389877394610133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [142]
            {
               ["GUID"] = "16811389877394610134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [143]
            {
               ["GUID"] = "16811389877394610135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [144]
            {
               ["GUID"] = "16811389877394610136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [145]
            {
               ["GUID"] = "16811389877394610137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [146]
            {
               ["GUID"] = "16811389877394610138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [147]
            {
               ["GUID"] = "16811389877394610139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [148]
            {
               ["GUID"] = "16811389877394610140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [149]
            {
               ["GUID"] = "16811389877394620141",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [150]
         },
      },
      ["168113133067660002"] = {
         ["lockKeyboard"] = true,
         ["requirements"] = {
            ["race"] = 1,
            ["skill"] = 999,
            ["class"] = 5,
         },
         ["isSkuNewbieTutorial"] = true,
         ["tutorialTitle"] = {
            ["deDE"] = "Mensch Priester 1",
            ["enUS"] = "Human Priest 1",
         },
         ["showInUserList"] = true,
         ["showAsTemplate"] = true,
         ["playFtuIntro"] = true,
         ["GUID"] = "168113133067660002",
         ["steps"] = {
            {
               ["GUID"] = "168113135188890003",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490002",
               },
               ["linkedIn"] = {
               },
            }, -- [1]
            {
               ["GUID"] = "168113135188890004",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490003",
               },
               ["linkedIn"] = {
               },
            }, -- [2]
            {
               ["GUID"] = "168113135188890005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490004",
               },
               ["linkedIn"] = {
               },
            }, -- [3]
            {
               ["GUID"] = "168113135188890006",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490005",
               },
               ["linkedIn"] = {
               },
            }, -- [4]
            {
               ["GUID"] = "168113135188890007",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490006",
               },
               ["linkedIn"] = {
               },
            }, -- [5]
            {
               ["GUID"] = "168113135188890008",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490007",
               },
               ["linkedIn"] = {
               },
            }, -- [6]
            {
               ["GUID"] = "168113135188890009",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490008",
               },
               ["linkedIn"] = {
               },
            }, -- [7]
            {
               ["GUID"] = "168113135188890010",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490009",
               },
               ["linkedIn"] = {
               },
            }, -- [8]
            {
               ["GUID"] = "168113135188890011",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490010",
               },
               ["linkedIn"] = {
               },
            }, -- [9]
            {
               ["GUID"] = "168113135188890012",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490011",
               },
               ["linkedIn"] = {
               },
            }, -- [10]
            {
               ["GUID"] = "168113135188890013",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490012",
               },
               ["linkedIn"] = {
               },
            }, -- [11]
            {
               ["GUID"] = "168113135188890014",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490013",
               },
               ["linkedIn"] = {
               },
            }, -- [12]
            {
               ["GUID"] = "168113135188890015",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490014",
               },
               ["linkedIn"] = {
               },
            }, -- [13]
            {
               ["GUID"] = "168113135188890016",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490015",
               },
               ["linkedIn"] = {
               },
            }, -- [14]
            {
               ["GUID"] = "168113135188890017",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490016",
               },
               ["linkedIn"] = {
               },
            }, -- [15]
            {
               ["GUID"] = "168113135188890018",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490017",
               },
               ["linkedIn"] = {
               },
            }, -- [16]
            {
               ["GUID"] = "168113135188890019",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490018",
               },
               ["linkedIn"] = {
               },
            }, -- [17]
            {
               ["GUID"] = "16837017021672600005",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1683700188158850001",
               },
               ["linkedIn"] = {
               },
            }, -- [18]
            {
               ["GUID"] = "168113135188890020",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490019",
               },
               ["linkedIn"] = {
               },
            }, -- [19]
            {
               ["GUID"] = "168113135188890021",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490020",
               },
               ["linkedIn"] = {
               },
            }, -- [20]
            {
               ["GUID"] = "168113135188890022",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490021",
               },
               ["linkedIn"] = {
               },
            }, -- [21]
            {
               ["GUID"] = "168113135188890023",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490022",
               },
               ["linkedIn"] = {
               },
            }, -- [22]
            {
               ["GUID"] = "168113135188890024",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490023",
               },
               ["linkedIn"] = {
               },
            }, -- [23]
            {
               ["GUID"] = "168113135188890025",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490024",
               },
               ["linkedIn"] = {
               },
            }, -- [24]
            {
               ["GUID"] = "168113135188890026",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490025",
               },
               ["linkedIn"] = {
               },
            }, -- [25]
            {
               ["GUID"] = "168113135188890027",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490026",
               },
               ["linkedIn"] = {
               },
            }, -- [26]
            {
               ["GUID"] = "168113135188890028",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490027",
               },
               ["linkedIn"] = {
               },
            }, -- [27]
            {
               ["GUID"] = "168113135188890029",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490028",
               },
               ["linkedIn"] = {
               },
            }, -- [28]
            {
               ["GUID"] = "168113135188890030",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490029",
               },
               ["linkedIn"] = {
               },
            }, -- [29]
            {
               ["GUID"] = "168113135188890031",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490030",
               },
               ["linkedIn"] = {
               },
            }, -- [30]
            {
               ["GUID"] = "168113135188890032",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490031",
               },
               ["linkedIn"] = {
               },
            }, -- [31]
            {
               ["GUID"] = "168113135188890033",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490032",
               },
               ["linkedIn"] = {
               },
            }, -- [32]
            {
               ["GUID"] = "168113135188890034",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490033",
               },
               ["linkedIn"] = {
               },
            }, -- [33]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Göttliche Pein Button 1",
                  ["enUS"] = "UNTRANSLATED:deDE:Göttliche Pein Button 1",
               },
               ["GUID"] = "168113135188890035",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Hier auf Button 1 befindet sich der Zauber (Göttliche Pein). Diesen Zauber kannst du nur dann wirken, wenn du dich nicht bewegst. Wirken bedeutet, er hat eine Zauberzeit. Wenn der Zauber beendet ist, erhält dein Gegner Schaden. Wenn du während des Wirkens Schaden erhältst, wird die Zauberzeit jedes Mal verlängert. Versuche zu zaubern, wenn der Gegner noch weit entfernt ist, da dieser erst zu dir laufen muss. Lies die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "Here on button 1 is the spell (Smite). You can cast this spell only when you are not moving. Casting it means it has a casting time. When the spell is stopped, your enemy will receive damage. If you receive damage while casting, the casting time will be extended each time. Try to cast when the enemy is still far away, because he has to move to you first. Read the details with the tooltip feature (shift) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [34]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Auf button 2 gehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Auf button 2 gehen",
               },
               ["GUID"] = "168113135188890036",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Mit Pfeil runter kannst du auf den Button 2 gelangen. Sieh nach, welcher Zauber auf Taste 2 liegt. Drücke (Pfeil runter).",
                  ["enUS"] = "Use down arrow to get to button 2. See what spell is on button 2. Press (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "5,4,1,2",
                        ["enUS"] = "5,4,1,2",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [1]
               },
            }, -- [35]
            {
               ["GUID"] = "16811334381845640001",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Geringes Heilen button 2",
                  ["enUS"] = "UNTRANSLATED:deDE:Geringes Heilen button 2",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Auf Button 2 befindet sich der Zauber (Geringes Heilen). Das ist ein Heilzauber. Ließ die Details mit der Tooltipfunktion (Umschalttaste) und (Pfeil runter).",
                  ["enUS"] = "On button 2 there is the spell (Lesser Healing). This is a healing spell. Read the details using the tooltip feature (shift key) and (down arrow).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "MODIFIER_KEY_DOWN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 25,
                        ["enUS"] = 25,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [2]
               },
            }, -- [36]
            {
               ["GUID"] = "16811335911998260002",
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "heilen erklären",
                  ["enUS"] = "UNTRANSLATED:deDE:heilen erklären",
               },
               ["linkedIn"] = {
               },
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wenn du dich selbst im Ziel hast, wirkst du Heilzauber automatisch auf dich selbst. Wenn du ein feindliches Ziel oder gar kein Ziel hast bist du ebenfalls automatisch das Ziel. Das bedeutet, dass du im Kampf einfach nur die Taste drücken musst, um dich selbst zu heilen. Wenn du ein freundliches Ziel hast, heilst du dieses freundliche Ziel - wie beispielsweise ein Gruppenmitglied. Schalte jetzt manuell weiter.",
                  ["enUS"] = "When you target yourself, you automatically cast healing spells on yourself. If you have an enemy target or no target at all, you are also automatically the target. This means that in combat you just have to press the button to heal yourself. If you have a friendly target, you heal that friendly target - such as a party member. Now switch manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [37]
            {
               ["GUID"] = "168113135188890037",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490036",
               },
               ["linkedIn"] = {
               },
            }, -- [38]
            {
               ["GUID"] = "168113135188890038",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490037",
               },
               ["linkedIn"] = {
               },
            }, -- [39]
            {
               ["GUID"] = "168113135188890039",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490038",
               },
               ["linkedIn"] = {
               },
            }, -- [40]
            {
               ["GUID"] = "168113135188890040",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490039",
               },
               ["linkedIn"] = {
               },
            }, -- [41]
            {
               ["GUID"] = "168113135188890041",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490040",
               },
               ["linkedIn"] = {
               },
            }, -- [42]
            {
               ["GUID"] = "168113135188890042",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490041",
               },
               ["linkedIn"] = {
               },
            }, -- [43]
            {
               ["GUID"] = "168113135188890043",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490042",
               },
               ["linkedIn"] = {
               },
            }, -- [44]
            {
               ["GUID"] = "168113135188890044",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490043",
               },
               ["linkedIn"] = {
               },
            }, -- [45]
            {
               ["GUID"] = "168113135188900045",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490044",
               },
               ["linkedIn"] = {
               },
            }, -- [46]
            {
               ["GUID"] = "168113135188900046",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490045",
               },
               ["linkedIn"] = {
               },
            }, -- [47]
            {
               ["GUID"] = "168113135188900047",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490046",
               },
               ["linkedIn"] = {
               },
            }, -- [48]
            {
               ["linkedIn"] = {
                  ["16811389677374010001"] = {
                     "16811498166863300009", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811494086456060006", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Angriff als caster",
                  ["enUS"] = "UNTRANSLATED:deDE:Angriff als caster",
               },
               ["GUID"] = "168113135188900048",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Das ist ein %npc_id:000006%. Greife an, indem du deinen Angriffszauber wirkst. Als %class% solltest du den Gegner aus maximal erreichbarer Entfernung angreifen, damit er möglichst viele Lebenspunkte verloren hat, bis er zu dir gelaufen ist. Versuche, nach dem ersten Zauber gleich den nächsten Zauber zu wirken. Zaubere so, dass keine Pausen entstehen. Da sich der Gegner bewegt, kann es passieren, dass er sich nicht mehr vor dir befindet. Wenn er nicht im Sichtfeld ist, kannst du nicht auf ihn zaubern. Mit der Taste (G) drehst du dich zum Gegner. Dein Charakter läuft dann aber auch auf den Gegner zu. Stoppe, indem du die Taste (S) drückst und zaubere dann wieder. Nutze nun deinen Zauber und töte ihn! ",
                  ["enUS"] = "This is a %npc_id:000006%. Attack by casting your attack spell. As a %class%, you should attack the enemy from the maximum distance so that they have lost as many life as possible by the time they have moved to you. Try to cast the next spell right after the first one. Cast spells in such a way that there are no pauses. Since the enemy is moving, he may not be in front of you anymore. If he is not in your line of sight, you can't cast a spell on him. With the key (G) you turn around to the enemy. Your character will move towards the enemy. Stop by pressing the (S) key and then cast again. Now use your spell and kill him! ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [49]
            {
               ["GUID"] = "168113135188900049",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490048",
               },
               ["linkedIn"] = {
               },
            }, -- [50]
            {
               ["GUID"] = "168113135188900050",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490049",
               },
               ["linkedIn"] = {
               },
            }, -- [51]
            {
               ["GUID"] = "168113135188900051",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490050",
               },
               ["linkedIn"] = {
               },
            }, -- [52]
            {
               ["linkedIn"] = {
                  ["16811389677374010001"] = {
                     "16811499146961710010", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811495036551100007", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Kobold zwei als Caster",
                  ["enUS"] = "UNTRANSLATED:deDE:Kobold zwei als Caster",
               },
               ["GUID"] = "168113135188900052",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Töte jetzt einen weiteren Gegner. Drücke wieder die (Tabulatortaste) um ein Ziel zu finden. Drehe dich mit (A) und (D), um in anderen Richtungen zu suchen. Wenn du ein %npc_id:000006% gefunden hast, kannst du (G) und dann gleich (S) drücken. Dann schaust du in die richtige Richtung. Gehe dann mit der Taste (S) ein paar Schritte rückwärts. Du hörst die männliche Stimme, die die Entfernung zum Gegner ansagt. Versuche, aus größerer Distanz anzugreifen. Drücke dazu die (Tabulatortaste) bis du den richtigen Gegner gefunden hast. Drücke dann (G) und sofort (S). Finde die Distanz und nutze dann deinen Zauber. ",
                  ["enUS"] = "Now kill another enemy. Press (Tab) again to find a target. Turn around with (A) and (D) to search in other directions. When you find a %npc_id: 000006% you can press (G) and then immediately (S). Then you are looking to the right direction. Then go backwards a few steps with the (S) key. You will hear the male voice pronouncing the distance to the enemy. Try to attack from a greater distance. Press (Tab) until you find the right enemy. Then press (G) and immediately (S). Find the right distance and then use your spell. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 49,
                        ["enUS"] = 49,
                     },
                     ["type"] = "GAME_EVENT",
                  }, -- [1]
               },
            }, -- [53]
            {
               ["GUID"] = "168113135188900053",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490052",
               },
               ["linkedIn"] = {
               },
            }, -- [54]
            {
               ["GUID"] = "168113135188900054",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490053",
               },
               ["linkedIn"] = {
               },
            }, -- [55]
            {
               ["linkedIn"] = {
                  ["168111678387860001"] = {
                     "16811500887135480012", -- [1]
                  },
                  ["16811389677374010001"] = {
                     "16811499977044460011", -- [1]
                  },
                  ["168113131451930001"] = {
                     "16811496716718650008", -- [1]
                  },
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Erklärung der Ansagen mit Mana",
                  ["enUS"] = "UNTRANSLATED:deDE:Erklärung der Ansagen mit Mana",
               },
               ["GUID"] = "168113135188900055",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Vergiss nicht mit (G) zu plündern, wenn du das Schmatzgeräusch gehört hast. Im Kampf hörst du viele Sprachausgaben. Die weibliche Stimme sagt in 10er Schritten, wieviel Prozent Lebenspunkte der Gegner noch hat. Die Jungenstimme sagt einstellig in 10er Schritten deine Lebenspunkte an. Das Mädchen sagt dir, wieviel Mana du hast. Schalte das Tutorial jetzt manuell weiter.",
                  ["enUS"] = "Don't forget to loot with (G) when you heard the smacking sound. In battle, you'll hear a lot of voice output. The female voice says in increments of 10 how many percent health the enemy has left. The boy's voice pronounces your life points in single digits in increments of 10. The girl voice tells you how much mana you have. Now continue the tutorial manually.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "INFO_STEP",
                  }, -- [1]
               },
            }, -- [56]
            {
               ["GUID"] = "168113135188900056",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490055",
               },
               ["linkedIn"] = {
               },
            }, -- [57]
            {
               ["GUID"] = "168113135188900057",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490056",
               },
               ["linkedIn"] = {
               },
            }, -- [58]
            {
               ["GUID"] = "168113135188900058",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490057",
               },
               ["linkedIn"] = {
               },
            }, -- [59]
            {
               ["GUID"] = "168113135188900059",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490058",
               },
               ["linkedIn"] = {
               },
            }, -- [60]
            {
               ["GUID"] = "168113135188900060",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490059",
               },
               ["linkedIn"] = {
               },
            }, -- [61]
            {
               ["GUID"] = "168113135188900061",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490060",
               },
               ["linkedIn"] = {
               },
            }, -- [62]
            {
               ["GUID"] = "168113135188900062",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490061",
               },
               ["linkedIn"] = {
               },
            }, -- [63]
            {
               ["GUID"] = "168113135188900063",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490062",
               },
               ["linkedIn"] = {
               },
            }, -- [64]
            {
               ["GUID"] = "168113135188900064",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490063",
               },
               ["linkedIn"] = {
               },
            }, -- [65]
            {
               ["GUID"] = "168113135188900065",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490064",
               },
               ["linkedIn"] = {
               },
            }, -- [66]
            {
               ["GUID"] = "168113135188900066",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490065",
               },
               ["linkedIn"] = {
               },
            }, -- [67]
            {
               ["GUID"] = "168113135188900067",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490066",
               },
               ["linkedIn"] = {
               },
            }, -- [68]
            {
               ["GUID"] = "168113135188900068",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490067",
               },
               ["linkedIn"] = {
               },
            }, -- [69]
            {
               ["GUID"] = "168113135188900069",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490068",
               },
               ["linkedIn"] = {
               },
            }, -- [70]
            {
               ["GUID"] = "168113135188900070",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490069",
               },
               ["linkedIn"] = {
               },
            }, -- [71]
            {
               ["GUID"] = "168113135188900071",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490070",
               },
               ["linkedIn"] = {
               },
            }, -- [72]
            {
               ["GUID"] = "168113135188900072",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490071",
               },
               ["linkedIn"] = {
               },
            }, -- [73]
            {
               ["GUID"] = "168113135188900073",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490072",
               },
               ["linkedIn"] = {
               },
            }, -- [74]
            {
               ["GUID"] = "168113135188900074",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490073",
               },
               ["linkedIn"] = {
               },
            }, -- [75]
            {
               ["GUID"] = "168113135188900075",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490074",
               },
               ["linkedIn"] = {
               },
            }, -- [76]
            {
               ["GUID"] = "168113135188900076",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490075",
               },
               ["linkedIn"] = {
               },
            }, -- [77]
            {
               ["GUID"] = "168113135188900077",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490076",
               },
               ["linkedIn"] = {
               },
            }, -- [78]
            {
               ["GUID"] = "168113135188900078",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490077",
               },
               ["linkedIn"] = {
               },
            }, -- [79]
            {
               ["GUID"] = "168113135188900079",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490078",
               },
               ["linkedIn"] = {
               },
            }, -- [80]
            {
               ["GUID"] = "168113135188900080",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490079",
               },
               ["linkedIn"] = {
               },
            }, -- [81]
            {
               ["GUID"] = "168113135188900081",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490080",
               },
               ["linkedIn"] = {
               },
            }, -- [82]
            {
               ["GUID"] = "168113135188900082",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490081",
               },
               ["linkedIn"] = {
               },
            }, -- [83]
            {
               ["GUID"] = "168113135188900083",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490082",
               },
               ["linkedIn"] = {
               },
            }, -- [84]
            {
               ["GUID"] = "168113135188900084",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490083",
               },
               ["linkedIn"] = {
               },
            }, -- [85]
            {
               ["GUID"] = "168113135188900085",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490084",
               },
               ["linkedIn"] = {
               },
            }, -- [86]
            {
               ["GUID"] = "168113135188900086",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490085",
               },
               ["linkedIn"] = {
               },
            }, -- [87]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ausrüstung ansehen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ausrüstung ansehen",
               },
               ["GUID"] = "168113135188900087",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Als %class% kannst du nur Stoffrüstung tragen. Außerdem ist es dir möglich, Zauberstäbe zu verwenden. Tipp: Du solltest dir den ersten Zauberstab möglichst schon mit erreichen der Stufe 5 besorgen. Mit einem Zauberstab kannst du schießen. Dabei kannst du nicht unterbrochen werden. Sicher möchtest du sehen, welche Ausrüstung du momentan trägst. Geh hierfür auf (Ausrüstung), dann nach rechts auf (Gegenstände) und dann nochmal nach rechts.",
                  ["enUS"] = "As %class% you can only wear cloth armor. You are also able to use wands. Tip: You should get your first wand when you reach level 5. You can shoot with a wand. You can't be interrupted while doing so. You will probably want to see what equipment you are currently wearing. Go to (Equipment), then right to (Items) and then right again.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 3,
                        ["enUS"] = 3,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,2,1,1",
                        ["enUS"] = "9,1,2,1,1",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [88]
            {
               ["GUID"] = "168113135188900088",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490087",
               },
               ["linkedIn"] = {
               },
            }, -- [89]
            {
               ["GUID"] = "168113135188900089",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490088",
               },
               ["linkedIn"] = {
               },
            }, -- [90]
            {
               ["GUID"] = "168113135188900090",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490089",
               },
               ["linkedIn"] = {
               },
            }, -- [91]
            {
               ["GUID"] = "168113135188900091",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490090",
               },
               ["linkedIn"] = {
               },
            }, -- [92]
            {
               ["GUID"] = "168113135188900092",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490091",
               },
               ["linkedIn"] = {
               },
            }, -- [93]
            {
               ["GUID"] = "168113135188900093",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490092",
               },
               ["linkedIn"] = {
               },
            }, -- [94]
            {
               ["GUID"] = "168113135188900094",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490093",
               },
               ["linkedIn"] = {
               },
            }, -- [95]
            {
               ["GUID"] = "168113135188900095",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490094",
               },
               ["linkedIn"] = {
               },
            }, -- [96]
            {
               ["GUID"] = "168113135188900096",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490095",
               },
               ["linkedIn"] = {
               },
            }, -- [97]
            {
               ["GUID"] = "168113135188900097",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490096",
               },
               ["linkedIn"] = {
               },
            }, -- [98]
            {
               ["GUID"] = "168113135188900098",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490097",
               },
               ["linkedIn"] = {
               },
            }, -- [99]
            {
               ["GUID"] = "168113135188900099",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490098",
               },
               ["linkedIn"] = {
               },
            }, -- [100]
            {
               ["GUID"] = "168113135188900100",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490099",
               },
               ["linkedIn"] = {
               },
            }, -- [101]
            {
               ["GUID"] = "168113135188900101",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490100",
               },
               ["linkedIn"] = {
               },
            }, -- [102]
            {
               ["GUID"] = "168113135188900102",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490101",
               },
               ["linkedIn"] = {
               },
            }, -- [103]
            {
               ["GUID"] = "168113135188900103",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490102",
               },
               ["linkedIn"] = {
               },
            }, -- [104]
            {
               ["GUID"] = "168113135188900104",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490103",
               },
               ["linkedIn"] = {
               },
            }, -- [105]
            {
               ["GUID"] = "168113135188900105",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490104",
               },
               ["linkedIn"] = {
               },
            }, -- [106]
            {
               ["GUID"] = "168113135188900106",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490105",
               },
               ["linkedIn"] = {
               },
            }, -- [107]
            {
               ["GUID"] = "168113135188900107",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490106",
               },
               ["linkedIn"] = {
               },
            }, -- [108]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "In Ebene 1 die Klassenquest finden.",
                  ["enUS"] = "UNTRANSLATED:deDE:In Ebene 1 die Klassenquest finden.",
               },
               ["GUID"] = "168113135188900108",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Geh nach rechts in das erste Untermenü. Du weißt bereits, dass die Quests dort nach Regionen oder Kategorien sortiert sind. Geh von (Alle) nach unten, solange, bis du auf (Priester) bist.",
                  ["enUS"] = "Go right to the first submenu. You already know that the quests there are sorted by region or category. Go down from (All) until you are on (Priest).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Priester",
                        ["enUS"] = "Priester",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [109]
            {
               ["GUID"] = "168113135188900109",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "1681073540576310001",
               },
               ["linkedIn"] = {
               },
            }, -- [110]
            {
               ["GUID"] = "168113135188900110",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490112",
               },
               ["linkedIn"] = {
               },
            }, -- [111]
            {
               ["GUID"] = "168113135188900111",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490113",
               },
               ["linkedIn"] = {
               },
            }, -- [112]
            {
               ["GUID"] = "168113135188900112",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490108",
               },
               ["linkedIn"] = {
               },
            }, -- [113]
            {
               ["GUID"] = "168113135188900113",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490109",
               },
               ["linkedIn"] = {
               },
            }, -- [114]
            {
               ["GUID"] = "168113135188900114",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490110",
               },
               ["linkedIn"] = {
               },
            }, -- [115]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "zum lehrer laufen",
                  ["enUS"] = "UNTRANSLATED:deDE:zum lehrer laufen",
               },
               ["GUID"] = "168113135188900115",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Starte die Rute wie gewohnt mit der (Eingabetaste) und folge den Wegpunkten bis zum Lehrer.",
                  ["enUS"] = "Start the route as usual by pressing (Enter) and follow the waypoints to the trainer.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = "-8853.8;-193.5;5",
                        ["enUS"] = "-8853.8;-193.5;5",
                     },
                     ["type"] = "PLAYER_POSITION",
                  }, -- [1]
               },
            }, -- [116]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Priesterlehrerin anvisieren",
                  ["enUS"] = "UNTRANSLATED:deDE:Priesterlehrerin anvisieren",
               },
               ["GUID"] = "168113135188900116",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Nimm deinen Klassenlehrer nun wie gewohnt mit (Steuerung) (Umschalttaste) und (Tabulatortaste) ins Ziel. Drücke dann (G), um das Dialogfenster zu öffnen.",
                  ["enUS"] = "Now target your class trainer as usual with (Control) (Shift) and (Tab). Then press (G) to open the dialog pane.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "375",
                        ["enUS"] = "375",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [117]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Das Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Das Lehrerfenster",
               },
               ["GUID"] = "168113135188900117",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Im Dialogfenster findest du den Menüpunkt (Ich suche Unterweisung auf dem Weg des Priesters) und die angenommene Quest. Wähle zuerst die angenommene Quest aus, indem du nach rechts gehst und im Untermenü mit der (Eingabetaste) (Linksklick) auswählst. ",
                  ["enUS"] = "In the dialog pane you will find the menu item (I seek instruction on the way of the priest) and the accepted quest. First select the accepted quest by going to the right and selecting it from the submenu with the (Enter) key (Left click). ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 9,
                        ["enUS"] = 9,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [118]
            {
               ["GUID"] = "168113135188900118",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490116",
               },
               ["linkedIn"] = {
               },
            }, -- [119]
            {
               ["GUID"] = "168113135188900119",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490117",
               },
               ["linkedIn"] = {
               },
            }, -- [120]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fenster wurde geschlossen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fenster wurde geschlossen",
               },
               ["GUID"] = "168113135188900120",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wie du bemerkt hast, ist das Dialogfenster jetzt geschlossen. Interagiere nun erneut mit dem NPC, indem du die Taste (G) drückst.",
                  ["enUS"] = "As you noticed, the dialog pane is now closed. Now interact with the NPC again by pressing the (G) key.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 6,
                        ["enUS"] = 6,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "375",
                        ["enUS"] = "375",
                     },
                     ["type"] = "TARGET_UNIT_NAME",
                  }, -- [2]
               },
            }, -- [121]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Ins Trainerfenster gelangen",
                  ["enUS"] = "UNTRANSLATED:deDE:Ins Trainerfenster gelangen",
               },
               ["GUID"] = "168113135188900121",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Wähle nun (Ich suche Unterweisung auf dem Weg des Priesters) aus, um das Lehrerfenster zu öffnen.",
                  ["enUS"] = "Now select (I seek instruction in the way of the priest) to open the trainer dialog box.",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
               },
            }, -- [122]
            {
               ["GUID"] = "168113135188900122",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490120",
               },
               ["linkedIn"] = {
               },
            }, -- [123]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Navigation im Lehrerfenster",
                  ["enUS"] = "UNTRANSLATED:deDE:Navigation im Lehrerfenster",
               },
               ["GUID"] = "168113135188900123",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Dies ist das Lehrerfenster. Die momentan für dich erlernbaren Zauber werden hier in einer Liste angezeigt, die in Kategorien sortiert ist. Dieser Lehrer bietet dir in der Kategorie (Disziplin) den Zauber (Machtwort Seelenstärke) an. Dieser Zauber ist bereits ausgewählt. Weiter unten findest du erneut (Machtwort Seelenstärke). Davor wird (Text) angesagt. Das ist der Menüpunkt für den Zauber, der momentan ausgewählt ist. Suche jetzt diesen Menüpunkt. ",
                  ["enUS"] = "This is the trainer dialog box. The spells that you can currently learn are displayed here in a list, sorted into categories. This trainer offers you the spell (Power Word Fortitude) in the category (Discipline). This spell is already selected. Further down you will find (Power Word Fortitude) again. Before that, (Text) is pronounced. This is the menu item for the spell that is currently selected. Now search for this menu item. ",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 7,
                        ["enUS"] = 7,
                     },
                     ["type"] = "PANEL_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "9,1,4",
                        ["enUS"] = "9,1,4",
                     },
                     ["type"] = "MENU_ITEM",
                  }, -- [2]
               },
            }, -- [124]
            {
               ["GUID"] = "168113135188900124",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490122",
               },
               ["linkedIn"] = {
               },
            }, -- [125]
            {
               ["GUID"] = "168113135188900125",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490123",
               },
               ["linkedIn"] = {
               },
            }, -- [126]
            {
               ["GUID"] = "168113135188900126",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490124",
               },
               ["linkedIn"] = {
               },
            }, -- [127]
            {
               ["GUID"] = "168113135188900127",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490125",
               },
               ["linkedIn"] = {
               },
            }, -- [128]
            {
               ["GUID"] = "168113135188900128",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490126",
               },
               ["linkedIn"] = {
               },
            }, -- [129]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "knopf leer machen",
                  ["enUS"] = "UNTRANSLATED:deDE:knopf leer machen",
               },
               ["GUID"] = "168113135188900129",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "(Keine Aktion zuweisen) ist der Menüpunkt, um eine zugewiesene Aktion vom Button zu entfernen. Unter dem Menüpunkt findest du verschiedene Kategorien. Wenn du auf einer Kategorie nach rechts gehst, findest du die Zauber der Kategorie, die dem Button zugewiesen werden können. Suche nach (Machtwort Seelenstärke).",
                  ["enUS"] = "(Do not assign action) is the menu item to remove an assigned action from the button. Under the menu item you can find different categories. If you go to the right on a category, you will find the spells of the category that can be assigned to the button. Search for (Power Word Fortitude).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 1,
                        ["enUS"] = 1,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = "Seelenstärke",
                        ["enUS"] = "Fortitude",
                     },
                     ["type"] = "TTS_STRING",
                  }, -- [2]
               },
            }, -- [130]
            {
               ["linkedIn"] = {
               },
               ["linkedFrom"] = {
               },
               ["title"] = {
                  ["deDE"] = "Fähigkeit lesen und auf Button legen",
                  ["enUS"] = "UNTRANSLATED:deDE:Fähigkeit lesen und auf Button legen",
               },
               ["GUID"] = "168113135188900130",
               ["allTriggersRequired"] = true,
               ["beginText"] = {
                  ["deDE"] = "Super! Du hast (Machtwort Seelenstärke) gefunden. Du kannst die Details des Zaubers mit der Tooltipfunktion lesen. Weise nun dem Button (Machtwort Seelenstärke) zu, indem du die (Eingabetaste) drückst. Schließe dann das Aktionsleistenmenü mit (ESC).",
                  ["enUS"] = "Great! You have found (power word fortitude). You can read the details of the spell with the tooltip feature. Now assign (Power Word Fortitude) to the button by pressing (Enter). Then close the action bar menu with (ESC).",
               },
               ["dontSkipCurrentOutputs"] = true,
               ["triggers"] = {
                  {
                     ["value"] = {
                        ["deDE"] = 28,
                        ["enUS"] = 28,
                     },
                     ["type"] = "KEY_PRESS",
                  }, -- [1]
                  {
                     ["value"] = {
                        ["deDE"] = 2,
                        ["enUS"] = 2,
                     },
                     ["type"] = "SKU_MENU_OPEN",
                  }, -- [2]
               },
            }, -- [131]
            {
               ["GUID"] = "168113135188900131",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490129",
               },
               ["linkedIn"] = {
               },
            }, -- [132]
            {
               ["GUID"] = "168113135188900132",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490130",
               },
               ["linkedIn"] = {
               },
            }, -- [133]
            {
               ["GUID"] = "168113135188900133",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490131",
               },
               ["linkedIn"] = {
               },
            }, -- [134]
            {
               ["GUID"] = "168113135188900134",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490132",
               },
               ["linkedIn"] = {
               },
            }, -- [135]
            {
               ["GUID"] = "168113135188900135",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490133",
               },
               ["linkedIn"] = {
               },
            }, -- [136]
            {
               ["GUID"] = "168113135188900136",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490134",
               },
               ["linkedIn"] = {
               },
            }, -- [137]
            {
               ["GUID"] = "168113135188900137",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490135",
               },
               ["linkedIn"] = {
               },
            }, -- [138]
            {
               ["GUID"] = "168113135188900138",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490136",
               },
               ["linkedIn"] = {
               },
            }, -- [139]
            {
               ["GUID"] = "168113135188900139",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490137",
               },
               ["linkedIn"] = {
               },
            }, -- [140]
            {
               ["GUID"] = "168113135188900140",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490138",
               },
               ["linkedIn"] = {
               },
            }, -- [141]
            {
               ["GUID"] = "168113135188900141",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490139",
               },
               ["linkedIn"] = {
               },
            }, -- [142]
            {
               ["GUID"] = "168113135188900142",
               ["linkedFrom"] = {
                  ["SourceTutorialGUID"] = "16807134034490001",
                  ["SourceTutorialStepGUID"] = "16807134034490140",
               },
               ["linkedIn"] = {
               },
            }, -- [143]
         },
      },


   },
}
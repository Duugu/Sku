# Downloads

Wenn du Sku noch nie installiert hattest, musst du dir alle Addons unten herunterladen. Ansonsten vermutlich nur die aktualisierten Addons.

*Aktualisiert:* <br>
[Sku 20.11](https://github.com/Duugu/Sku/releases/download/r20.11/Sku-r20.11-bcc.zip) <br>

*Nicht aktualisiert:*<br>
[SkuAudioData 22](https://github.com/Duugu/SkuAudioData/releases/download/r22/SkuAudioData-r22-bcc.zip) <br>
[SkuBeaconSoundsets 19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[SkuFluegel 5.3](https://github.com/Duugu/SkuFluegel/releases/download/r5.3/SkuFluegel-r5.3-bcc.zip) <br>
[BugGrabber + Bugsack](https://1drv.ms/u/s!Aqgp3J_s6MM7iKN7LiGYcuZzzTTdGw?e=c5c4c7) <br>

# Bug- und Todo-Liste
[Bug-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Abug) <br>
[Todo-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement) <br>

# Versionshinweise

## Änderungen in Version 20.11

### SkuMob
*Neuerungen*
- Bei gelben Gegnern (die einen nicht von sich aus angreifen), sagt das Addon jetzt "passiv" vor dem Namen.

### SkuCore
*Fehlerkorrekturen*
- Es wurde (hoffentlich) ein Fehler beim automatischen Folgen nach dem Kampf behoben.

### SkuOptions
*Fehlerkorrekturen*
- "Verwüstete Lande" zur Wortliste für Wegpunkte hinzugefügt.
- Auch, wenn es niemand bemerkt hat, wurde ein Problem behoben, dass die Anzeige der Liste aller NPC-Wegpunkte unter SkuNav > Wegpunkt > Auswählen > Alle NPCs" verhindert hat.
- Bei Filtern in Menüs werden Umlaute jetzt korrekt buchstabiert.

### SkuNav
*Fehlerkorrekturen*
- Alle Standardwegpunkte (beginnen mit "s;") in Feralas wurden gelöscht, da sie offensichtlich falsch waren.

## Änderungen in Version 20.10

### SkuQuest
*Fehlerkorrekturen*
- Vergessene Debug-Meldngen entfernt.

### SkuCore
*Fehlerkorrekturen*
- Fehler mit Dauer-Fehlermeldungen in Instanzen behoben.

## Änderungen in Version 20.9

### SkuQuest
*Fehlerkorrekturen*
- Es wurde in Fehler behoben, durch den Objekte und Gegenstände nicht unter "Abgabe" aufgeführt wurden.

### SkuCore
*Neuerungen*
- Es gibt jetzt eine Entfernungsansage für dein Ziel. Du findest sie unter "SkuCore > Entfernung".<br>
    - Standardmäßig sind alle Entfernungsansagen aus.<br>
    - Funktionsweise:<br>
            Die Entfernung wird damit nicht wirklich gemessen. Das ist nicht möglich. <br>
            Stattdessen verwendet das Addon bestimmte Aktionen (Betrachten, Handeln etc.) und deine Zauber, um festzustellen welche davon für das Ziel funktionieren. <br>
            Da das alles eine bestimmte Reichweite hat, kann es so zumindest gewisse Entfernungen erkennen.<br>
            Dieser "Trick" führt dazu, dass du die Entfernung immer nur in bestimmten Schritten ansagen kannst. Zum Beispiel, 5, 8, 15, 22, 30, 40 Meter.<br>
            Welche Entfernungen abgefragt/angesagt werden können, hängt von deinem Char, seinen Skill, seinen Zauber, seinen Gegenständen und vor allem vom Ziel ab (einen Feind kann man z. B. nicht anhandeln).<br>
            Im Menü unter "Entfernung" sind drei Kategorien für verschiedene Zieltypen: Freundlich, Feindlich, Unbekannt. <br>
            Unter jeder Kategorie werden die Entfernungen aufgeführt, die du mit deinem aktuellen Char für die Kategorie messen kannst.<br>
            Unter den verschiedenen Entfernungen findest du dann jeweils ein Untermenü mit Sounds, die du abspielen kannst, wenn das Ziel in der entsprechenden Entfernung ist.<br>
            Mit "Gesprochen" wird die Entfernung alternativ von Hans als Zahl angesagt.<br>
            Achtung: Die messbaren Entfernungen können sich im Laufe der Zeit verändern. Wenn du z. B. einen neuen Zauber lernst. Oder ein Item zerstörst.<br>
            Wenn sich die Liste der messbaren Entfernungen verändert, sagt das Addon dies an.

## Änderungen in Version 20.8

### SkuCore
*Fehlerkorrekturen*
- Ein Fehler mit der Hochscrollen-Taste für Berufefenster wurde behoben.
- Der Feststecken-Sound funktioniert jetzt auch wenn man rückwärts läuft.
- Bei Briefen mit mehreren angehängten Gegenständen werden jetzt unter "Anhänge" alle angehängten Gegenstände und nicht nur der erste angezeigt.

*Neuerungen*
- Alle gesprochenen Fehler-Sounds sind jetzt zusätzlich in der männlichen Stimme "Hans" verfügbar (dem Namen ist jeweils "Hans" vorangestellt).
- SkuCore kann jetzt über STRG + SHIFT + TAB auch NPCs anvisieren, die nicht anvisierbar sind (Startgebiete etc.).<br>
Dazu übernimmt es dauerhaft die Tastenkombination STRG + SHIFT + TAB (war vorher "vorherigen Freund anvisieren").<br>
Das Addon steuert das Anvisieren über die Namensbalken der NPCs. Du bekommst daher mit STRG + SHIFT + TAB immer den nächsten NPC aus allen ins Ziel deren Namensbalken gerade sichbar sind. Das muss _nicht_ (wie beim normalen Anvisieren) ein NPC vor dir sein.<br>
Außerdem werden die Namensbalken standardmäßig erst ab 20 Meter Entfernung eingeblendet. Das Anvisieren mit STRG + SHIFT + TAB hat also eine deutlich kleinere Reichweite als das normale Anvisieren.<br>
Du solltest auch weiterhin mit STRG + TAB das nächste freundliches Ziel anvisieren. Es sei denn, du bist in einem Startgebiet, und bekommst es damit nicht ins Ziel.<br>
Dann kannst du jetzt die neue Funktion mit STRG + SHIFT + TAB verwenden.
- Der Panikmodus ist wieder da!<br>
Diesmal mit der Tastenkombination STRG + SHIFT + Y zur Aktivierung, einem ein Drittel leiseren Beacon, und der Titelmelodien aus "Der weiße Hai" im Hintergrund.<br>
Ansonsten funktioniert er exakt so wie vorher. Hier die alte Beschreibung:<br>

    - Die Panik-Taste versetzt das Addon in den Panikmodus bzw. schaltet diesen wieder aus.
    - Der Panikmodus ist für Situationen gedacht, in denen schnell du den Weg zurücklaufen möchtest, den du gekommen bist. Zum Beispiel, weil du aus einem Kampf fliehen möchtest.
    - Sobald du den Panikmodus gestartet hast, führt dich das Addon über ein dynamisch großzügig positioniertes Beacon über den Weg zurück, den du gekommen bist (bis zu 500 Meter).
    - Du erreichst das Beacon nie. Es gibt keine "Wegpunkt erreicht"-Plings. Sobald du bis auf 20 Meter an das Beacon herankommst, wir es automatisch auf den nächsten Punkt deiner Rücklaufstrecke gesetzt.
    - Sobald du aus dem Kampf kommst, endet der Panik-Modus automatisch.
    - Bei jeder Benutzung der Panik-Taste wird die aufgezeichnete Wegstrecke zurückgesetzt und beginnt ab deiner aktuellen Position.

    Das mit dem weißen Hai war btw nur ein Witz.

### SkuOptions
*Fehlerkorrekturen*
- Ein angewendeter Filter wird jetzt korrekt entfernt, wenn man die Menüebene mit PFEIL LINKS verlässt.

## Änderungen in Version 20.7

### SkuNav
*Fehlerkorrekturen*
- Es wurde etwas am Cachen geändert.

### SkuCore
*Neuerungen*
- Es gibt einen neuen Menüpunkt "SkuCore > Optionen > Fehler Feedback".<br>
In diesem Menü kannst du für acht verschiedene Fehlertypen Audiomeldungen einstellen:
    - Nicht in Reichweite (Ziel ist zu weit entfernt für die Fähigkeit)
    - Nicht in Bewegung (Fähigkeit kann nicht in Bewegung verwendet werden)
    - Keine Sichtlinie (keine Sichtlinie zu Ziel)
    - Ziel ungültig (Ziel ist nicht angreifbar)
    - In kampf (Fähigkeit ist nicht im Kampf möglich)
    - Ressource fehlt (Mana, Wut, Energie reicht nicht)
    - Objekt beschäftigt (Interaktion mit Ziel nicht möglich, weil es von einer anderen Person verwendet wird)
    - Richtung falsch (Ziel ist nicht vor dir)
    - Gestunnt (du bist gestunnt und kannst die Fähigkeit nicht nutzen)
    - Unterbrochen (die Fähigkeit wie z. B. ein Zauber wurde unterbrochen - von dir, einem Mob etc.)
- Du kannst im Menü für jeden Fehlertyp einen Sound auswählen.<br>
Dazu stehen Töne zur Verfügung (Beep, Wusch, Bonk etc.), und es gibt eine gesprochene Meldung (mit einer neuen Stimme) pro Fehlertyp ("Sichtlinie", "Bewegung", "Reichweite" etc.)<br>
Wenn du im Untermenü für einen Fehlertyp durch die Sounds blätterst, wird der jeweilige Sound zu Demonstration abgespielt.<br>
Außerdem kannst du ganz oben unter "Sound Kanal" den Kanal für diese Sounds auswählen.

*Fehlerkorrekturen*
- Die Infoseite wurde leicht verändert.
    - Der eingestellte Plündertyp wurde unter den Abschnitt "Gruppe" verschoben.
    - Alle Einzelzeilen wie Reparatur, Geld etc. wurden unter einen gemeinsamen Abschnitt "Allgemein" verschoben.

## Änderungen in Version 20.6

### SkuCore
*Fehlerkorrekturen*
- Lobet den Herrn, werft Blumen, opfert eure Erstgeborenen ... nach langer Fehlersuche funktioniert das Infofenster jetzt endlich normal. :)<br>
Es geht, wie vorgesehen, zuverlässig beim Loslassen der Shift-Taste statt nach 30 Sekunden zu.
- Außerdem mach das Infofenster jetzt beim Öffnen "Bing" und beim Schließen "Bong". Wie der Chat.

### SkuOptions
*Fehlerkorrekturen*
- Das TTS spricht jetzt "klammer auf/zu" im Text nur noch als "klammer" aus.

## Änderungen in Version 20.5

### SkuCore
*Fehlerkorrekturen*
- Die Meldung "Noch x" beim Erreichen eines Wegpunktes auf einer Route kann jetzt nicht mehr unerwünscht durch andere Audioausgaben abgebrochen/überschrieben werden.

### SkuCore
*Fehlerkorrekturen*
- Das Infofenster funktioniert nun auch, wenn man keine Ruhe-XP hat.
- Die Gildenmitglieder im Infofenster werden jetzt bei jeder Anzeige des Fensters aktualisiert.<br>
Da diese Informationen vom Server kommen, und nicht sofort verfügbar sind, kann es trotzdem sein, dass die Informationen nicht sekundengenau aktuell sind.

### SkuQuest
*Fehlerkorrekturen*
- Die Quest "Vahlarriels suche" wird jetzt korrekt im Questlog angezeigt.

### SkuOptions
*Fehlerkorrekturen*
- SHIFT und STRG haben bei der Anzeige von Detailinformationen erneut die Funktionen getauscht.<br>
Nun ist wieder SHIFT + PFEIL eine Zeile weiter und SHIFT + STRG + PFEIL einen Abschnitt weiter - wie vorher.<br>
Dafür geht das Infofenster jetzt nach 30 Sekunden ohne Zeilen- oder Abschnittswechsel automatisch zu.
- Beim TTS wurde Fehler mit verschiedenen Zeichen behoben (z. B. > und <). Daher sollten jetzt weniger Piepser für fehlende Wörter zu hören sein.
- Fehler beim Durchschreiten von Instanz-Portalen (z. B. Eingang Tiefenbahn) wurden behoben.

## Änderungen in Version 20.4

### SkuNav
*Fehlerkorrekturen*
- In Maraudon wurde ein Kartenproblem behoben.

*Neuerungen*
- Im Menü unter "SkuNav > Daten" gibt es eine neue Option "Export aktueller Kontinent".
- Im Ordner "Sku > SkuNav > routedata" gibt es jetzt Routen-Einzeldateien für die drei Kontinente: Kalimdor, Östliche Königreiche, Scherbenwelt.<br>
Eine Gesamtdatei mit allen Routen gibt es nicht mehr (diese wurde mit der steigenden Routenzahl zu groß).

### SkuQuest
*Fehlerkorrekturen*
- Die NPC-, Objekt-, Item- und Questdatenbanken wurden mit einer vierstelligen Anzahl von Updates/Fixes aus Questie aktualisiert. 

### SkuOptions
*Fehlerkorrekturen*
- Aufgrund von Problemen mit NVDA und der Shift-Taste, haben SHIFT und STRG bei der Anzeige von Detailinformationen die Funktionen getauscht.<br>
Ab sofort ist eine Zeile vor oder zurück blättern STRG + PFEIL RUNTER/HOCH (statt wie bisher SHIFT + PFEIL).<br>
Einen ganzen Abschnitt vor oder zurück blättern bleibt wie bisher STRG + SHIFT + PFEIL RUNTER/HOCH.
Dies gilt für alle Bereiche, in denen Detailinformationen gelesen werden können (Quest, Infofenster, Tooltips, Lokal-Menü etc).

### SkuCore
*Fehlerkorrekturen*
- Beim Würfeln sagt das Addon jetzt zur besseren Wahrnehmbarkeit "gewürfelt gier/bedarf/gepasst" statt nur "gier/bedarf/gepasst".

*Neuerungen*
- Änderungen an der Übersichtsseite:
  - Der Spieler selbst ist jetzt in der Gruppenübersicht.
  - Was in einer Zeile dargestellt werden kann ist jetzt in einer Zeile.
  - Neue Inhalte:
    - Uhrzeit
    - Post
    - Ruhestein
    - XP/Erholung
    - Plündern Einstellung
    - Fertigkeiten
    - Ruf
    - Gildenmitglieder online
    - Tier XP
     
## Änderungen in Version 20.3

### SkuCore
*Neuerungen*
- Neues Feature: Übersichtsseite<br>Mit SHIFT + PFEIL RUNTER kannst du eine Übersichtsseite aufrufen. Du kannst, wie bei allen anderen Ausgaben, mit PFEIL + HOCH/RUNTER zur nächsten/vorherigen Zeile blättern und mit SHIFT + PFEIL HOCH/RUNTER zum nächsten/vorherigen Abschnitt.<br>Die Seite zeigt die folgenden Informationen an:
  - Gruppenmitglieder (nur in Gruppen)
  - Reparaturstatus
  - Gold
  - Freie Taschenplätze

### SkuNav
*Fehlerkorrekturen*
- Die Ansage der globale Himmelsrichtung mit STRG + ALT wurde wieder entfernt.

## Änderungen in Version 20.2

###	SkuChat
*Fehlerkorrekturen*
- Der Chat-Verlauf hat jetzt 100 Zeilen.

###	SkuOptions
*Fehlerkorrekturen*
- Die rechte Shift-Taste beendet jetzt auch die Sprachausgabe vom Ingame-TTS (Wegpunkthinweise).

###	SkuNav
*Neuerungen*
- Zur besseren Beacon-Ortung gibt es jetzt ein "Klick"-Geräusch, wenn du dich in die Richtung eines Beacons drehst. Achtung: Dazu benötigst du SkuBeaconSoundsets 19.7!
Sobald du +/- 5 Grad in die Richtung des Beacons schaust, mach es "Klick". Wenn du den 5-Grad-Bereich wieder verlässt, macht es "Klack".
Dazu gibt es unter "SkuNav > Optionen" drei neue Einstellungsmöglichkeiten:
  - "Klick bei Beacons": Damit kannst du das "Klick"-Feature ein-/ausschalten (Standard: Ein)
  - "Winkel für Klick bei Beacons": Damit kannst du den Grad-Bereich verändern, in dem der Klick auftritt (Standard: 5). Der Gradbereich gilt nur in Fünferschritten. 8, 9 oder 10 macht also keinen Unterschied. 5, 10 und 15 schon.
  - "Ton für Klick bei Beacons": Damit kannst du zwischen zwei Sound-Sets wählen. "Klick" ist ein "Klick"/"Klack"-Geräusch. "Beep" ist das gleiche mit einem Piep-Geräusch (Standard: Klick).

*Fehlerkorrekturen*
- Die globale Himmelsrichtung kann jetzt auch mit STRG + ALT statt nur über ALTGr angesagt werden.


## Änderungen in Version 20.1

### SkuOptions
*Fehlerkorrekturen*
- Das ö kann jetzt genau wie alle anderen Umlaute zum Filtern im Menü verwendet werden.

### SkuCore
*Fehlerkorrekturen*
- BILD-HOCH scrollt jetzt nicht nur in Berufefenstern, sondern aktualisiert auch das Menü entsprechend.
- Scrollen mit BILD-HOCH/RUNTER sollte jetzt in allen Handwerksfenstern funktionieren.
- Das Lokal-Menü geht jetzt nicht mehr auf solange Bewegungstasten gedrückt sind. Geist freilassen und danach ungewollt automatisch laufen sollte daher nicht mehr vorkommen.
- Diverse Änderungen am Post-Menü:
  - Das Post-Menü ist jetzt filterbar.
  - Das Senden von Gegenständen per Post sollte jetzt funktionieren.
  - Das Gegenstände-Menü bei einem neuen Brief ist jetzt filterbar.
  - Fehlender Empfänger und/oder Betreff werden jetzt beim Senden angesagt.
- Der Zugriff auf die Gildenbank funktioniert jetzt wieder.

### SkuNav
*Fehlerkorrekturen*
- Karten-Bug für die eigenartige Zone zwischen Ödland und sengende Schlucht behoben.
- Karten-Bug im Steinwerkpass behoben. Gebiet wurde Loch Modan zugeschlagen.
- STRG + rechte Maustaste (Wegpunkt löschen) und STRG + Maustaste 5 (neuer Zonenpunkt) haben ihre Funktion getauscht.
- Routen mit identischem Start- und Endpunkt und ohne weitere Zwischenwegpunkte werden jetzt ohne weitere Info automatisch gelöscht.
- Bei eingeblendeter Sku-Minimap werden jetzt bei nicht sichtbaren Wegpunkten keine Tooltips mehr angezeigt.

## Änderungen in Version 20

+++ ACHTUNG: Wenn du deine Einstellungen behalten möchtest, lies zwingend unten die Infos dazu! +++

+++ ACHTUNG: Für Version 20 musst du unbedingt vor der Installation erst alle alten Sku-Addons löschen! +++

*Die Organisationsstruktur der Sku-Addons wurde stark verändert*

  Ab sofort gibt es nur noch ein Sku-Addon (also auch noch einen Odern), in dem sich alle Sku-Module befinden.<br>
  Es muss nur noch dieses eine Sku-Addon aktualisiert werden.<br>
  "SkuAudioData" und "SkuBeaconSoundsets" bleiben davon ausgeschlossen und getrennte Einzeladdons.<br>
  Das hat mehrere Vorteile:<br>
  - Die Addonliste und die Struktur werden übersichtlicher.
  - Beim Aktualisieren muss man nicht mehr mit vielen Ordnern hantieren.
  - Die Sku-Addons und die Audiodaten (SkuAudioData, SkuBeaconSoundsets) können problemlos getrennt voneinander aktualisiert werden.

*Einstellungen übernehmen*

  Durch die Neuorganisation werden alle deine Einstellungen, Profile und Daten der Sku-Addons beim ersten Anmelden mit Version 20 gelöscht.<br>
  Wenn du sie behalten möchtest, muss du VOR DEM ERSTEN START mit Version 20 eine Datei umbenennen:<br>
  - Rufe folgenden Ordnern auf: ```<Dein-World-of-Warcraft-Ordner>\_classic_\WTF\Account\<DEIN-ACCOUNTNAME>\SavedVariables```
  - Benenne in diesem Ordner die Datei ```SkuZOptions.lua``` in ```Sku.lua``` um.
  - Starte dann erst das Spiel.

Wenn du das vor dem ersten Spielstart machst, bleiben alle Einstellungen erhalten. Wenn nicht, hast du ein komplett jungfräuliches Sku-Addon.

### SkuCore
*Neuerungen*
- Das Berufefenster ist im Lokal-Menü verfügbar.
- Im offenen Berufefenster kannst du jetzt mit BILD-HOCH und BILD-RUNTER in der Liste scrollen.
- Das Ausbildungsfenster für Jägertiere ist im Lokal-Menü verfügbar.
- Das Stall-Fenster für Jägertiere ist im Lokal-Menü verfügbar.

### SkuDB
*Fehlerkorrekturen*
- Einige Kartendaten wurden entfern. Daher funktionieren jetzt alle Zonen vor Instanzen korrekt (z. B. Gnomeregan, Uldaman etc.)

## Änderungen in Version 19.11

### SkuOptions
*Fehlerkorrekturen*
- Das Filtern sollte jetzt auch für die Aktionsleisten korrekt funktionieren und den richtigen Untermenüpunkt hervorbringen.
- Bei verringerter Beacon-Maximallautstärke geht das Beacon jetzt nicht mehr komplett aus wenn du weit weg bist.


# Downloads

Aktualisiert: <br>
<!-- [Sku 20.3](https://github.com/Duugu/Sku/releases/download/r20.3/Sku-r20.3-bcc.zip) <br>-->
 <br>Nicht aktualisiert: <br>
[SkuBeaconSoundsets 19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[SkuAudioData 20](https://github.com/Duugu/SkuAudioData/releases/download/r20/SkuAudioData-r20-bcc.zip) <br>
[SkuFluegel 5.3](https://github.com/Duugu/SkuFluegel/releases/download/r5.3/SkuFluegel-r5.3-bcc.zip) <br>

# Bugs und Todo
[Bug-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Abug) <br>
[Todo-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement) <br>

# Versionshinweise

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


# Downloads

[Sku 20](https://github.com/Duugu/Sku/releases/download/r20/Sku-r20-bcc.zip) <br>
[SkuAudioData 20](https://github.com/Duugu/SkuAudioData/releases/download/r20/SkuAudioData-r20-bcc.zip) <br>
[SkuBeaconSoundsets 19.6](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.6/SkuBeaconSoundsets-r19.6-bcc.zip) <br>
[SkuFluegel 5.3](https://github.com/Duugu/SkuFluegel/releases/download/r5.3/SkuFluegel-r5.3-bcc.zip) <br>

# Bugs und Todo
[Bug-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Abug) <br>
[Todo-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement) <br>

# Versionshinweise

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

*Addon-Download*

  Alle Addons (Sku, SkuAudiodata, SkuBeaconSoundsets, SkuFluegel) stehen ab sofort nicht mehr über Discord, sondern die zentrale Webseite zum Download bereit.
  
  Die URL dieser Downloadseite lautet: [https://duugu.github.io/Sku/](https://duugu.github.io/Sku/)
  
  Die Seite ist extrem einfach gehalten und kann problemlos mit einem Screenreader gelesen werden.<br>
  In Discord gibt es weiterhin den Channel "newsticker-sku-addon". Dort wird neben allgemeinen Infos zum Addon bei jeder neuen Version der Sku-Addons automatisch eine Meldung gepostet.<br>
  Der Download findet jetzt jedoch über die zentrale neue Webseite statt.

### SkuCore
*Neuerungen*
- Das Berufefenster ist im Lokal-Menü verfügbar.
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

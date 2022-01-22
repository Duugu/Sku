# Downloads

Wenn du Sku noch nie installiert hattest, musst du dir alle Addons unten herunterladen. Ansonsten vermutlich nur die aktualisierten Addons.

*Aktualisiert:* <br>
[Sku 23.1](https://github.com/Duugu/Sku/releases/download/r23.1/Sku-r23.1-bcc.zip) <br>
[SkuAudioData 28](https://github.com/Duugu/SkuAudioData/releases/download/r28/SkuAudioData-r28-bcc.zip) <br>

*Nicht aktualisiert:*<br>
[SkuBeaconSoundsets 19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[BugGrabber + Bugsack](https://1drv.ms/u/s!Aqgp3J_s6MM7iKN7LiGYcuZzzTTdGw?e=c5c4c7) <br>
[Sku-Maus Autohotkey-Skript 2](https://1drv.ms/u/s!Aqgp3J_s6MM7iKQcVpcR3IBws7QRuQ?e=GMli2f) <br>
[SkuFluegel 5.4](https://github.com/Duugu/SkuFluegel/releases/download/r5.4/SkuFluegel-r5.4-bcc.zip) <br>

# Bug- und Todo-Liste
[Bug-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Abug) <br>
[Todo-Liste](https://github.com/Duugu/Sku/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement) <br>

# Versionshinweise

## Änderungen in Version 23.1

### SkuCore
*Fehlerkorrekturen*
- Die Abfragegeschwindigkeit im Auktionshaus wurde gesenkt, um "Aufhängen" zu vermeiden. Bitte melden, wenn es weiter hängt.
- Die Tooltips bei Items passen jetzt.
- Den Tooltips in den Taschen wurden Auktionsdaten hinzugefügt.
- Wie Wortlängen von neuen Wörtern wurden korrigiert.
- Es wird jetzt nicht mehr immer wieder zum Taschenplatz 3 sondern zum korrekten Taschenplatz zurückgegangen.
- Die Händler funktioniert wieder.

## Änderungen in Version 23

Achtung: Es gab nicht nur neue Features wie das Auktionshaus, sondern auch erhebliche interne Optimierungen am Menü.	Fehler sind möglich bzw. wahrscheinlich. Bitte alles testen und Fehler melden. Danke!

### SkuCore
*Fehlerkorrekturen*
- Das Post-Menü springt jetzt nicht mehr zum ersten Menüpunkt, wenn man einen noch ungelesenen Brief auswählt.
- Das Taschen-Menü springt jetzt bei einem Klick nicht mehr immer wieder zum ersten Taschenplatz, sondern bleibt auf dem aktuellen Taschenplatz.

### Neuerungen
- Unter "SkuCore > Auktionshaus" kannst du jetzt das Auktionshaus verwenden.
- Das Auktionshaus-Menü enthält die folgenden Untermenüs:
  - Auktionen: Das sind die Auktionen im AH. Es wird nur angezeigt, wenn an einem Auktionator stehst und das Auktionsfenster offen ist.<br>
    Darunter findest du als ersten Punkt "Filter und Sortierung", unter dem du Filtereinstellungen machen kannst.<br>
    Dann kommen die einzelnen Auktionskategorien und darunter jeweils Unterkategorien und Unter-Unterkategorien (falls es diese gibt).<br>
    Darunter findest du dann die eigentlichen Auktionen.<br>
    Die Daten der Auktionen werden vom Server abgefragt. Das kann bei großen Kategorien (z. B. "Verbrauchsmaterialien") eine ganze Weile dauern (zwischen 0 und 30-60 Sekunden).<br>
    Solange die Abfrage läuft, und noch keine Daten vorhanden sind, wird dir "Warten auf Abfrage" angezeigt. Es wird gleichzeitig ein Sound abgespielt.<br>
    Sobald die Abfrage abgeschlossen ist, verschwindet "Warten auf Abfrage" und es wird automatisch die erste Auktion der Kategorie angezeigt.<br>
    Mehrere Auktionen mit identischem Gegenstand, Preis und Stack werden zusammengefasst. Dann steht in der Liste z. B. "5 mal ...".
  - Gebote: Das sind die laufenden Auktionen auf die du geboten hast. <br>
      Sofern du mindestens einmal bei einem Auktionator warst, kannst du diese Liste auch unterwegs einsehen. Aber natürlich ist die Liste in diesem Fall möglicherweise nicht mehr aktuell.
  - Verkäufe: Das sind deine laufenden Verkaufsauktionen. <br>
      Sofern du mindestens einmal bei einem Auktionator warst, kannst du diese Liste auch unterwegs einsehen. Aber natürlich ist die Liste in diesem Fall möglicherweise nicht mehr aktuell.
  - Offline Datenbank: Das sind alle Auktionen aus dem AH, die du dir auch dann ansehen kannst, wenn du nicht an einem Auktionator stehst.<br>
    Bei jedem Öffnen des Auktionshauses werden alle Auktionen gescannt und für die Offline Datenbank gespeichert. Dieser Scan ist jedoch nur alle 15 Minuten möglich.<br>
    Je länger der letzte Scan her ist, desto weniger aktuell sind die Offlinedaten logischerweise.<br>
    Die Offlinedaten werden pro Fraktion pro Server gespeichert. Alle Allianz-Chars auf einem Server teilen sich also eine Datenbank. Genauso alle Hordler.<br>
  - Offline Datenbank aktualisieren: Damit kannst du an einem Auktionator die Offline Datenbank manuell aktualisieren (wie gesagt, geht nur alle 15 Minuten).
- KAUFEN: Du wählst im AH eine Kategorie und dann eine Auktion aus. Dann gehst du nach rechts gehst und wählst "Kaufen" oder "Bieten" aus.<br>
  Dann gehst du wieder nach rechts und wählst die Anzahl Auktionen aus, auf die du kaufen/bieten möchtest (falls es die Auktion mehrmals gab).<br>
  Dann drückst du ENTER. Dann wirst du aufgefordert ENTER zur Bestätigung oder ESCAPE zum Abbrechen zu drücken (mehrmals, wenn du mehr als einen ausgewählst hast). Wenn du ENTER drückst, kaufst/bietest du.
- VERKAUFEN: Du verkaufst aus deinem Taschenmenü heraus ("Lokal > ...").<br>
  Jeder Gegenstand in deinen Taschen hat jetzt zusätzlich zu "Linksklick" und "Rechtsklick" noch ein "Verkaufen" Untermenü. Dieses wird nur angezeigt, wenn das Auktionsfenster offen ist.<br>
  Im Verkaufen-Menü gehst du wie bei der Aura-Erstellung immer weiter nach rechts und legst so die Parameter für die Auktion fest. Zum Schluss kommt die Laufzeit. Da drückst du dann EINGABE, und die Auktion wird erstellt.
- Historische Auktionshausdaten: Bei jedem Scan und jeder Suche im Auktionshauses werden die Daten in einer Datenbank mit historischen Daten gespeichert. Auch dies geschieht pro Fraktion pro Server.<br>
  Die historischen Daten aus dieser Datenbank (Durchschnittspreis, niedrigster/höchster Preis, Preistendenz etc.) werden dir zu jedem Gegenstand im Tooltip angezeigt.<br>
  Die Daten sind natürlich erst dann wirklich aussagekräftig, wenn du über mehrere Tage oder Wochen hinweg mindestens einmal täglich das AH gescannt hast.
- Die "Gebote"- und "Verkäufe"-Listen berücksichtigen zurzeit nur maximal 50 Einträge.<br>
  Darauf, was passiert, wenn du gleichzeitig auf mehr als 50 Auktionen bietest oder mehr als 50 Verkäufe laufen hast, bin ich selbst gespannt. :)

### SkuAuras
*Neuerungen*
- Aufgrund weiterer Änderungen am Aura-System werden erneut einmalig alle bestehenden Auren gelöscht. Mindestens eine weitere Komplettlöschung in einer der nächsten Versionen ist wahrscheinlich.
- Es wurden (hoffentlich) diverse Fehler behoben. Zum Bespiel bei fehlenden Benachrichtigungen, wenn man sich selbst im Ziel hat.
- Es sind 5 Sounds hinzugekommen ("Trompete", "Glas", "Tropfen"), die es in jeweils 5 verschiedenen Tonhöhen gibt.
- Es sind 24 Sounds hinzugekommen ("Hinweis 1-24"), die es jeweils nur in einer Tonhöhe gibt.
- Das Aura-Set für Schattenpriester wurde überarbeitet und verwendet jetzt weniger nervige Sounds.<br>
  Für Vampirumarmung, Schattenwort: Schmerz und Vampirberührung wird derselbe Sound verwendet. Jedoch in drei unterschiedlichen und klar zu unterscheidenden Tonhöhen.<br>
  Die Sounds werden ausgelöst, wenn einer der drei Dots auf deinem Ziel ausläuft oder wenn du das Ziel wechselst.

### SkuNav
*Neuerungen*
- Die Routendatenbank enthält jetzt standardmäßig die Daten aus Macs Version "V22Plus-11-AlleKarten-2022-01-16.txt"

*Fehlerkorrekturen*
- Der Feststecken-Sound wird jetzt parallel zu allen Anderen Audioausgaben ausgegeben und bricht andere Ausgaben nicht mehr ab.
- Die kaputte Zone "Auchindoun" wurde repariert.
- "Schmiedevaters Grabmal" und "Schwarzfelsspitze" gehören jetzt zur brennenden Steppe.
- Die Darstellung der Sku-Minimap wurde optimiert. Sie wird jetzt weniger häufig gerendert wenn mehr Punkte und Links anzuzeigen sind (beim Rauszoomen).<br>
  Bei sehr weitem Rauszoomen ist es immer noch enorm ruckelig. Aber immerhin friert der Client jetzt nicht mehr vollkommen ein. :)

## Änderungen in Version 22.7

### SkuAuras
*Neuerungen*
- Es gibt zwei neu Attribute für Bedingungen: 
  - Im Kampf (wahr/falsch)
  - Ziel-Einheit angreifbar (wahr/falsch)

*Änderungen am Aura-Set Schattenpriester*
- Die Aura für Schattenschild wurde entfernt, da es sich um eine Troll-Rassenfähigkeit für Priester handelt.
- Die Auren für den Cooldown von Gedankenschlag und Vampirberührung sind jetzt standardmäßig deaktiviert.
- Die Dot-Auren für "Schattenwort: Schmerz", "Vampirberührung" und "Vampirumarmung" melden jetzt das Auslaufen auf dem aktuellen Target, statt auf allen Gegnern.
- Es wurden drei weitere Auren hinzugefügt, die beim Zielwechsel im Kampf melden, wenn das neue Ziel keinen Dot "Schattenwort: Schmerz", "Vampirberührung" oder "Vampirumarmung" hat.

*Fehlerkorrekturen*
- Beim Attribute "Ziel" werden jetzt alle Ziele geprüft, nicht nur das erste Zutreffende (z. B. wenn eine Bedingung für den Spieler gilt, und dieser sich selbst im Target hat).

## Änderungen in Version 22.6

### SkuAuras
*Neuerungen*
- Es gibt jetzt unter "SkuAuras > Auren > Aura Sets verwalten" ein erstes Aura-Set für Schattenpriester. <br>
Welche Buffs/Debuffs, Cooldowns etc. enthalten sind, steht im Tooltip des Sets (SHIFT + PFEIL RUNTER).<br>
Bitte ausprobieren und Feedback geben. Danke.

## Änderungen in Version 22.5

### SkuOptions
*Neuerungen*
- Die Übersichtsseite zeigt jetzt für Gildenmitglieder zusätzlich deren aktuelle Zone an.
- Die Übersichtsseite zeigt jetzt deine Buffs und Debuffs an.

*Fehlerkorrekturen*
- Die Übersichtsseite verursacht jetzt in Istanzen keinen Fehler mehr.
- Die Übersichtsseite verursacht jetzt keinen Fehler mehr, wenn du sie öffnest ohne vorher mindestens einmal deine Taschen geöffnet zu haben.

###SkuAuras
*Neuerungen*
- Da es Änderungen am Aura-System gab, werden alle bestenden Pre-22.5-Auren beim ersten Einloggen mit 22.5 gelöscht.
- Die Aura-Erstellung kann jetzt erst mit ENTER abgeschlossen werden, wenn mindestens "Aktion" und eine Ausgabe ausgewählt wurden. Drückst du vorher ENTER, so geht es einfach normal in das nächste Untermenü (wie bei PFEIL RECHTS).
- Den ersten Parameter "Typ" einer Aura (war bisher "Einheit", "Gegenstand", "Zauber" oder "Aura") gibt es nicht mehr.<br>
  Stattdessen lauten die Werte für den ersten parameter nun "Wenn" und "Wenn nicht".<br>
  Das heißt, du wählst jetzt im ersten Schritt einer Aura aus, ob die Aura ausgelöst werden soll, wenn alle Bedingungen zutreffen oder alle Bedigngungen nicht zutreffen.
- Einheiten-IDs werden jetzt von der "größten" zur "kleinsten" ausgewertet: Alle, Raid, Gruppe, Ziel, Spieler
- Wird ein Attribut in einer Aura mehrmals verwendet, so gilt jetzt für die identischen Attribute automatisch der Operator "Oder". Beispiel: "wenn zauber name gleich machtwort seelenstärke oder zauber name gleich heiliges wort seelenstärke ..."<br>
  Für alle anderen Attribute der Aura gilt weiter automatisch der Operator "Und". Beispiel: "wenn ereignis gleich aura erhalten und zauber name gleich machtwort seelenstärke oder zauber name gleich heiliges wort seelenstärke
- Neue Attribute: 
  - "Buff Liste Ziel" und "Debuff Liste Ziel", mit denen du in Bedingungen prüfen kannst, ob dein Ziel einen bestimmten Buff oder Debuff hat.
  - "Verfehlen Typ" enthält bei einem Verfehlen-Ereignis den genauen Typ (Ausweichen, Parieren etc.).
- Neue Operatoren: 
  - "enthält" und "enthält nicht" (z. B. zur Verwendung mit "Buff Liste")
- Neue Werte: 
  - Ereignis "Zielwechsel". Tritt immer auf, wenn eine bekannte Einheit ("player", "target", "party1-4" usw.) sein Ziel wechselt.
- Neue Ausgabeattribute: 
  -"Eigene Ressource" (Mana, Wut, Energie) und "Eigene Gesundheit". Beides sind Prozentwerte.

*Fehlerkorrekturen*
- Das Attribut "Ziel" wurde nicht korrekt ausgewertet. Das wurde behoben.
- Vergessene Debug-Ausgaben beim Auraerstellen wurden entfernt.
- "Alle" bei "Qeuell Einheit" und "Ziel Einheit" gilt jetzt wirklich füer alle.

## Änderungen in Version 22.4

### SkuAuras
*Neuerungen*
- Das SkuAuras-Modul ist jetzt in seiner Grundfunktion fertig und kann getestet werden. <br>
  Warnung: Fehler sind zwar nicht bekannt, aber wahrscheinlich. Es kann daher gut sein, dass wir die jetzt erstellten Auren später noch mal löschen müssen.<br>
  Sollten euch weitere Attribute, Ereignisse oder Werte einfallen, die in Auren für Bedigungen verwenden möchtet, dann her damit.
- Alle Auren werden fest pro Char gespeichert.
- Auren können deaktiviert werden, wenn du sie gerade nicht verwenden möchtest. Neue Auren sind standardmäßig aktiviert.
- Unter "SkuAuras > Auren" findest du folgende Untermenüpunkte:
  - Neue Aura: Funktioniert wie bisher. Du kannst dir jedoch zu jedem Schritt der Aura-Zusammenstellung mit SHIFT + PFEIL RUNTER Detailinformationen anzeigen lassen.<br>
   Zum Beispiel, welches Element du gerade auswählst und was der aktuelle Wert bedeutet.<br>
   Außerdem siehst du darunter welche Attribute und Werte du für die Aura schon ausgewählt hast.<br>
   Im letzten Schritt der Erstellung (die Werte für die Ausgabe), nach "Aktion dann", entscheidest du dich jetzt zuerst für eine Chat- oder Audioausgabe. Danach kannst du wie bisher beliebig viele Parameter und jetzt auch Sounds in die Ausgabe aufnehmen. <br>
   Die Sounds sind dieselben wie bei der Fehler-Funktion. Sie werden im Menü zur Verdeutlichung jeweils abspielt, wenn du den Menüpunkt auswählst. <br>
   Wenn ihr weitere Sounds benötigt, gebt mir bitte welche. Oder sagt mir alternativ genau, was für Sounds ihr möchtet.
  - Auren verwalten: Hier findest du die drei Untermenüs "Aktivierte", "Deaktiviert" und "Alle". Darunter findest du die entsprechenden Auren.<br>
    Unter der jeweiligen Aura findest du jeweils Optionen, um die entsprechende Aura zu aktivieren/deaktivieren, zu bearbeiten (noch nicht implementier), zu löschen oder zu exportieren.
  - Aura importieren: Selbsterklärend. Eine Aura aus einer externen Textdatei importieren. Das Importieren und Exportieren funktioniert genauso wie bei den Routen.
  - Alle Auren löschen: Ohne weitere Nachfrage werden alle deine Auren gelöscht.
  - Aura Sets verwalten: Noch nicht implementiert.
  - Aura Sets importieren: Noch nicht implementiert.

### SkuOptions
*Fehlerkorrekturen*
  - Das Menü wird jetzt nicht mehr beim Zielwechsel automatisch geschossen.
  - Aufgrund eines unbemerkten Zeichensatzproblems hat die Audioausgabe bisher viele Wörter mit Umlauten falsch ausgesprochen. Daher wurden 12000 Wörter neu aufgenommen.
  - Außerdem wurden 1000 fehlende Wörter aufgenommen.

### SkuQuest
*Fehlerkorrekturen*
  - Für die Quest "Lar'korwis Fährte" sind jetzt die Weibchen als Ziele vorhanden.

## Änderungen in Version 22.3

### SkuOptions
*Fehlerkorrekturen*
- Die Eingabe im Menü ist immer noch schnell, aber alle dadurch entstandenen Fehler sollten behoben sein (Einfügen beim Import, Tasten zuweisen etc.).

## Änderungen in Version 22.2

### SkuOptions
*Fehlerkorrekturen*
- Die Eingabegeschwindigkeit im Menü wurde erheblich optimiert. Es hakt jetzt nicht mehr und verschluckt auch keine Buchstaben mehr (z. B. beim Filtern). Egal wie schnell man tippt.

## Änderungen in Version 22.1

### SkuAuras

*Neuerungen*

Das SkuAuras-Modul ist jetzt in einer ersten Testversion funktionsfähig.<br> 
Es geht aber nur darum das grundlegende Konzept zu testen. Es ist nicht für den Einsatz geeignet oder gedacht.<br>
Dieses Konzept sieht folgendermaßen aus:<br>
- Unter "SkuAuras > Neu" kannst du beliebig viele "SkuAuren" neu definieren. SkuAuren sind quasi einzelne kleine Beobachtungselemente, die bei bestimmten Dingen aktiv werden.<br>
Eine definierte "SkuAura" hat einen oder mehrere Auslöser, Bedingungen und Aktionen. (Wie bei WeakAuras.)<br>
Tritt der definierte Auslöser einer SkuAura ein, und treffen die definierten Bedingungen der SkuAura zu, dann werden die Aktionen der SkuAura ausgeführt.<br>
  - Auslöser: Das sind Ereignisse wie "Buff/Debuff erhalten", "Gegenstand benutzt", "Zauber-Cooldown startet" usw.
  - Bedingungen: Das können Dinge die "Zaubername", "Gegenstandsname", "Ziel" etc. sein.
  - Aktionen: Damit kannst du dir entweder einen Hinweis als Audio oder im Chat ausgeben lassen. Inklusive was gerade ausgelöst wurde usw.

So funktioniert die Erstellung:
- Zuerst wählst du unter "Neu" einen der vier Grundtypen für SkuAuren aus: 
  - Einheit: Das sind SkuAuren, die sich auf Informationen von Spielern, NPCs und Mobs beziehen. Beispiel: "Ansagen wenn HP des Spielers unter 50 % fällt".
  - Zauber: Das sind SkuAuren, die sich auf Informationen zu Zaubern beziehen. Beispiel: "Ansagen wenn der Cooldown von Eisblock beendet ist".
  - Gegenstand: Diese SkuAuren beziehen sich auf Gegenstände. Beispiel: "Ansagen wenn der Cooldown von Insignie beendet ist".
  - Aura: Das sind SkuAuren, die sich auf Buffs und Debuffs (übergreifend als "Auren" bezeichnet, nicht zu verwechseln mit den grundlegenden SkuAuren) beziehen. Beispiel: "Ansagen, wenn Seelenstärke auf einem Gruppenmitglied der Spielers ausläuft".<br>

  Wähle einfach den Typ aus der Liste und geh mit der PFEILTASTE nach rechts in das nächste Untermenü.<br>
  WICHTIG: In diesem Menü haben die Tasten ENTER und PFEIL RECHTS/LINKS unterschiedliche Funktionen. Bewege dich immer mit den Pfeilen. ENTER schließst die Erstellung ab.
- Nach dem SkuAura-Typ gehst du im Menü nach rechts und legst du eine oder mehrere Bedingungen fest.<br>
  Eine Bedingung besteht immer aus drei Elementen:
    - Attribut: Die Eigenschaft, auf die sich die Bedingung bezieht. Beispiele: Zaubername, Auraart (Buff oder Debuff), Ereignistyp
    - Operator: Der Vergleich, der für den aktuellen Attributtyp mit dem von dir definierten Wert vorgenommen wird. Beispiele "gleich", "ungleich", "größer", "kleiner"
    - Wert: Der Wert, der über den Operator mit dem aktuellen Wert des Attributs verglichen wird.
  
  Ein Beispiel für eine Bedingung aus diesen drei Elementen: "Attribut" ist "Zaubername", "Operator" ist "gleich" und "Wert" ist "Arkane Intelligenz". Das ergibt die fertige Bedingung "Wenn Zaubername gleich Arkane Intelligenz".<br>
  
  Du musst also zuerst ein Attribut auswählen. Dann gehst du nach rechts und wählst einen Operator aus. Dann gehst du nach rechts und wählst einen Wert aus. <br>
  Damit ist die erste Bedingung erstellt. Wenn du wieder nach rechts gehst, kommen wieder die Attribute und du könntest eine weitere Bedingung (aus den drei Elementen) für die SkuAura festlegen.
- Wenn du keine weiteren Bedigungen festlegen möchtest, musst du nun noch die Aktion festlegen, die ausgeführt werden woll, wenn alle Bedigungen zutreffen.<br>
  Dazu wählst du in der Attributliste das Attribut "Aktion" aus und gehst erneut nach rechts.<br>
  Dann findest du alle Aktionen, die verfügbar sind (z. B. Audioausgabe, Chatausgabe).<br>
  Nach der Auswahl der Aktion gehst du erneut nach rechts. Im folgenden Untermenü findest du alle Attributwerte, die du zusätzlich ausgeben kannst. Beispiel: Bei einem Zauber "Zaubername", "Ziel" etc.<br>
  Wähle einen zusätzlich auszugebenenden Attributwert aus. Wenn du erneut nach rechts gehst, kommen wieder alle Attributwerte, und du kannst einen weiteren Attributwert für die Ausgabe auswählen.
- Wenn du den SkuAura-Typ, mindestens eine Bedingung (Attribut, Operator, Wert) und eine Aktion festlegt hast, kannst du die Erstellung der neuen Aura jederzeit abschließen.<br>
  Zum Abschließen der Erstellung der SkuAura drückst du einfach ENTER.


### SkuNav
*Neuerungen*
- Ab sofort werden beim ersten Anmelden mit einer veralteten Version (vor 22) die Routendaten automatisch mit den jeweils aktuellen Routendaten überschrieben (statt die veralteten einfach nur zu löschen).<br>
Du musst also nicht mehr zwingend Daten importieren.  Du kannst natürlich trotzdem weiterhin Routendaten importieren, falls es neue Daten gibt, und du nicht auf die nächste Addonversion mit neueren Daten warten möchtest.
- Mit dem neuen Slash-Befehl "/sku rdatareset" kannst du nun die Routendaten im aktuellen Profil jederzeit auf die jeweils aktuellen (zum Zeitpunkt der Addon-Version) im Addon enthaltenen Routendaten zurücksetzen.

*Fehlerkorrekturen*
- Die Schnellwegpunkte funktionieren jetzt wieder wie gewohnt.

### SkuQuest
*Fehlerkorrekturen*
- Echeyakee erscheint jetzt als normaler Wegpunkt und sollte auch als Ziel für die Quest angezeigt werden.
- Aus irgendeinem Grund waren bei Questzielen Gegenstände die aus Objekten droppen auf die aktuelle Zone beschränkt. Das wurde behoben.<br>
Die Quest "Gestohlene Beute" sollte jetzt z. B. korrekt Questziele anzeigen.
- Für "Beschmutzt durch Satyrn" ist jetzt korrekt die erforderlich Pre-Quest "Allianzbeziehungen" (Teil 2) aus OG eingetragen.
- Für "Martek der Verbannte" wurden die Quests "Salziges Gift" und "Gehärtete Schalen" als Pre-Quest eingetragen. Ich weiß nicht, ob das stimmt. Aber die Wowhead-Kommentare behaupten es.

-------------------------------------------------------------------------------------------------------	
## Änderungen in Version 22

### Allgemein
Das alte Routensystem wurde entfernt. Es gibt nun keine vordefinierten, langen Routen über mehrere Wegpunkte mehr.<br>
Stattdessen gibt es jetzt nur noch sehr viele Einzelverbindungen (Links) zwischen jeweils zwei einzelnen Wegpunkten. Aus diesen werden alle Routen dynamisch berechnet (Metarouten).<br>
Beim Verwenden von Routen ändert sich nicht viel, da ihr eh immer nur dynamisch erstellte Metarouten verwendet habt ("Route folgen").<br>
Durch die Entferung dieser Altlast konnte ich jedoch die Performance des Addons erheblich optimieren.<br>
Darum ist jetzt kein Cachen mehr notwendig. Lags in Menüs sollte nicht mehr vorkommen (bzw. nur in minimalem Umfang). Import und Export sind erheblich schneller.<br>
Beim ersten Verwenden eines Profils mit Version 22 oder höher werden alle (nun veralten) Wegpunkte und Routen aus dem Profil gelöscht.<br>
Du musst danach die aktuellen Routen und Wegpunkte mit der neuen einzelnen Routendatei von Mac neu importieren.

### SkuNav
*Neuerungen/Änderungen*
- Der Import und Export von Wegpunkten/Routen wurde verändert.<br>
  Es gibt nur noch eine Import- und eine Export-Funktion für die gesamte Welt. Es ist nicht mehr möglich Zonen oder Kontinente einzeln zu ex- oder importieren.<br>
  Beim Import werden grundsätzliche alle vorhandenen Wegpunkt- und Routendaten gelöscht und durch die importierten Daten ersetzt. Es wird nicht mehr additiv importiert.<br>
  Es werden beim Import nur noch Daten akzeptiert, die mit Version 22 oder höher erstellt wurden. Beim Import alter Routendaten meckert das Addon und ignoriert diese.
- Optionen wie "Route folgen", "Nahe Route" etc. zeigen ab sofort alle Wegpunkten bzw. über das Routennetz erreichbaren Ziele auf dem gesamten Kontinent an.
- Bei der Routenauswahl sagt das Addon nun bis zu einer Entfernung von 3000 Metern bzw. 200 abzulaufenden Routenpunkten zum Ziel die tatsächliche Entfernung an.<br>
  Alles darüber wird nur noch mit "Weit" statt mit "x Meter" angesagt. <br>
  Wenn dir eine Route als "Weit" angesagt wird, kannst du sie aber natürlich trotzdem normal auswählen und ablaufen - wenn du wirklich einer so langen Route folgen willst. :)
- Da es keine Routen mehr gibt, sind alle Menüpunkte zur Routenerstellung und -verwaltung aus dem Audiomenü entfernt worden.
- "SkuNav > Route" wurde in "SkuNav > Route folgen" umbenannt. Darin landet ihr nun direkt bei "Ziele Entfernung" und "Einheiten Route".
- Die "Nahe Routen"-Funktion (bei Questzielen und dem Auswählen von Einzelwegpunkten) wurde dank der Umstellung deutlich optimiert und wählt nun erheblich bessere/nähere Routen aus.
- Unter "Wegpunkt > Auswählen" wurden die meisten Menüpunkte entfernt, da sie redundant waren.<br>
  Es gibt dort jetzt nur noch "Letzte", "Aktuelle Karte Entfernung", "Alle aktueller Kontinent" und "Aktuelle Karte Entfernung mit Auto".
- Wenn du einer Einheiten-Route für sich bewegende NPCs folgst, sagt das Addon nun, wenn der Namensbalken des NPCs in deinem Sichtfeld erscheint bzw. dieses verlässt.<br>
  Dein Sichtfeld beträgt dabei ca. 20 Meter. Wenn du "xyz sichbar" hörst, dann bedeutet das also nicht, dass der NPC vor dir steht. Nur, dass er irgendwo in bis zu 20 Meter Entfernung ins Bild gekommen ist.

### SkuOptions
*Neuerungen/Änderungen*
- Es gibt einen neuen Slash-Befehl: /sku chatcover<br>
  Damit kannst du den Chat beim Streamen mit einem schwarzen Rechteck verdecken. Erneutes /sku chatcover schalte die Verdeckung wieder aus.

## Änderungen in Version 21.14

### SkuNav
*Fehlerkorrekturen*
- Thrall ist wieder da. Er war nur Zigaretten holen, und hatte vergessen bescheid zu sagen.
- Der Bereich (Südstrom) am Hinterausgang von Orgrimmar gehört jetzt zum Brachland.
- Wegpunkte aus unterschiedlichen Zonen können jetzt verbunden werden ohne das was kaputt geht.
      
## Änderungen in Version 21.13

### SkuOptions
*Fehlerkorrekturen*
- Ein Fehler im Menü zur Wegpunktbenennung wurde behoben.

### SkuNav
*Neuerungen*
- Es gibt jetzt eine Funktion, um bei sich bewegenden NPCs deren Laufweg als Route abzulaufen und so nach ihnen zu suchen.<br>
  Du findest diese unter "SkuNav > Route > Route folgen > Einheiten Route".<br>
  In diesem Menü ist eine Liste aller NPCs aus der aktuellen Zone mit Laufwegen enthalten. Sortiert nach deiner Entfernung zum NPC.<br>
  Wenn du einen der NPCs auswählst, startet das Folgen einer normalen Metaroute über den Laufweg des ausgewählten NPCs.<br>
  Das Folgen der Route funktioniert wie bei allen anderen Routen auch.

*Fehlerkorrekturen*
- Ein Fehler bei verschobenen Standard-Wegpunkten auf der Sku-MM wurde behoben.
      
## Änderungen in Version 21.12

## SkuQuest
*Neuerungen*
- Wenn bei Quests Wegpunkte unter "Annahme", "Ziel" und "Abgabe" auf einem anderen Kontinent liegen, wird ab sofort nicht mehr nur "leer" angezeigt.<br>
  Stattdessen werden wie gewohnt die Wegpunkte als Untermenü angezeigt. <br>
  Unter den Wegpunkten findest du dann aber nicht "Route", "Nahe Route" und "Wegpunkt" (das ist nicht möglich, denn das Ziel ist ja auf einem anderen Kontinent).<br>
  Stattdessen gibt es darunter nur einen Menüeintrag ohne Funktion, der dir sagt auf welchem Kontinent und in welcher Zone das Ziel liegt. Beispiel: "Anderer Kontinent Schwerbenwelt Höllenfeuerhalbinsel".

*Fehlerkorrekturen*
- Der "Solarsal Pavilion" in Feralas wurde für Quest "Die Ruinen von Solarsal" als Ziel eintragen.
- Die vier Flammen und der Monolith in Feralas wurden als Ziele für die Quest "Der Stock von Equinex" eingetragen.
- Stalvan Dunstmantel ist jetzt ein Questziel.
- Die Quest "Das Geheimnis des Morgenkorns" in Feralas hat jetzt die Quest "Lebenshands Bitte" als Pre-Quest eingetragen.

## SkuNav
*Fehlerkorrekturen*
- Solange die Sku-Minimap offen ist, wird jetzt nicht mehr gecached. Das sollte die Performance der Sku-Minimap deutlich verbessern.
- Weil Stalvan eine olle Petze ist, wurde gleich noch ein Problem mit vielen NPCs in Southshore in Hillsbrad behoben, die jetzt alle angezeigt werden.


## Änderungen in Version 21.11

### SkuCore
*Neuerungen*
- Das Jäger-Tierausbildungsfenster kann jetzt im Lokal-Menü verwendet werden.

### SkuOptions
*Neuerungen*
- Das Wort "Käfig" wurde zur Wortliste für Wegpunktnamen hinzugefügt.
      
## Änderungen in Version 21.10

### SkuNav
*Fehlerkorrekturen*
- STRG + SHIFT + I und STRG + SHIFT + U zur Routenerstellung wurden entfernt.

### SkuCore
*Neuerungen*
- Der Stallmeister für Jäger-Tiere kann jetzt über das Lokal-Menü benutzt werden.

## Änderungen in Version 21.9

### SkuNav
*Neuerungen*
- Wenn die Erreichen-Reichweite für Wegpunkte auf "Auto" steht, sagt das Addon jetzt bei jedem Wechsel auf 1 bzw 3 Meter die Worte "Nah" und "Weit".

*Fehlerkorrekturen*
- Die Holzschlundfeste gehört jetzt komplett zum Teufelswald.
- Bei einem neuen Wegpunkt starten Beacons jetzt direkt mit einem Sound, statt wie bisher mit einer Pause.
- Aber sofort sagt das Addon "Routen aktualisierung abgeschlossen", sobald das anfängliche Cachen der Routen beendet ist.
- Das anfängliche Cachen von Routen wird jetzt korrekt fortgeführt bis der Cache erstellt ist.
  Bisher wurde es ungewollte beim Folgen einer Route abgebrochen und nicht wieder neu gestartet.
- Das Cachen wird nun dynamisch gesteuert und versucht möglichst schnell zu rechnen, die Frame-Rate des Spiels dabei aber nicht unter 35 sinken zu lassen. <br>
  Sinkt die Frame-Rate durch den Cache-Vorgang unter 35, so wird der Cache-Prozess gedrosselt.<br>
  Er kann daher schwanken und, je nach Computer und Routenmenge, deutlich schneller oder langsamer als bisher sein. (Zwischen 30 Sekunden und 15 Minuten oder mehr.)

### SkuOptions
*Neuerungen*
- Der Wortliste für Wegpunktnamen wurden die Wörter "Rettung", "Hilfe" und "Punkt" hinzugefügt.
- Es gibt einen neuen Slash-Befehl: /sku mmreset<br>
  Dieser setzt die Sku-Minimap auf ihre Ursprungsgröße zurück.

*Fehlerkorrekturen*
- Es wurde ein Fehler behoben, der für viele eigenartige Piepser in der Sprachausgabe bei eigentlich bekannten Worten verantwortlich war.

### SkuCore
*Fehlerkorrekturen*
- Es wurde ein unfassbar vertrackter Fehler behoben, der dafür verantwortlich war, dass bei Händlern unter Gegenständen mit einstelligen Preisen keine Preisangaben zu sehen waren. (Für diese Zeile waren 5 Stunden Arbeit erforderlich * knurr *.)

## Änderungen in Version 21.8

### SkuCore
*Fehlerkorrekturen*
- Es wurd ein Fehler im Menü "SkuCore > Entfernung" behoben. <br>
  Solange die möglichen Entferungen nach dem Einloggen/Reload noch ermittelt werden (dauert bis zu 2 Minuten), wird jetzt unter "Freundlich", "Feindlich" und "Unbekannt" im Untermenü "leer" angezeigt.<br>
  Erst, wenn Entfernungen verfügbar sind (das Addon sagt "Neue Entfernungen verfügbar"), tauchen in dem Menü Einträge auf.
- Beim Einstellen der Spiel-Tastenbelegungen auf die Sku-Standardeinstellungen ("SkuCore > Spiel Tastenbelegungen > Alles zurücksetzen") werden jetzt folgende Tastenkombinationen neu zugewiesen:<br>
  **Kameraperspektiven**:<br>
            - STRG + NUMMERNBLOCK 7: Kamerperspektive 2 (nah, Ansicht geradeaus)<br>
            - STRG + NUMMERNBLOCK 8: Kamerperspektive 4 (weit entfernt, Ansicht von schräg oben)<br>
            - STRG + NUMMERNBLOCK 9: Kamerperspektive 5 (weit entfernt, Ansicht geradeaus)<br>
  **Zielmarkierungen**:<br>
            - STRG + NUMMERNBLOCK 1: Totenkopf<br>
            - STRG + NUMMERNBLOCK 2: X<br>
            - STRG + NUMMERNBLOCK 3: Grünes Dreieck<br>
            - STRG + NUMMERNBLOCK 4: Blaues Quadrat<br>
            - STRG + NUMMERNBLOCK 5: Mond<br>
            - STRG + NUMMERNBLOCK 0: Keine Markierung<br>
- Auf der Addon-Downloadseite steht ein Autohotkey-Skript zur Positionierung des Mauszeigers für diese Kameraperspektiven zur Verfügung. (sku_maus.zip)<br>
  Falls du nicht weißt, wie das mit den Autohotkey-Skripten geht, frag bitte jemanden.<br>
  Das Skript belegt die Tasten NUMMERNBLOCK 7-9.<br>
  Es sendet jeweils die Tastenkombination STRG + NUMMERNBLOCK 7-9 an das Spiel (und ruft so die passende Kameraperspektive auf, siehe oben). Dann positioniert es die Maus passend. Und dann klickt es.<br>
  Mit dem Autohotkey-Skript kannst du also künftig mit einem Tastendruck auf NUMMERNBLOCK 7-9 in drei verschiedenen Kameraperspektiven automatisch looten, Objekte einsammeln etc.

### SkuNav
*Neuerungen*
- Es gibt jetzt drei Einstellungen für die Reichweite in der ein Wegpunkt als erreicht gilt: 1, 3 und Auto.<br>
  Du kannst weiterhin mit STRG + SHIFT + Q zwischen "1 Meter" und "3 Meter" umschalten. Jetzt kommt nach 3 jedoch nicht wieder 1, sondern erst "Auto".<br>
  Bei der Einstellung "Auto" entscheidet das Addon anhand der Entferung zum nächsten Wegpunkt selbst, welche Entfernung für das Erreichen des Wegpunktes verwendet wird.<br>
            - Ist der nächste Wegpunkt 9 oder weniger Meter entfernt, so verwendet es "Erreichen bei 1 Meter".<br>
            - Ist der nächste Wegpunkt 14 oder mehr Meter entfernt, so verwendet es "Erreichen bei 3 Meter".

*Fehlerkorrekturen*
- Es sollten beim Import jetzt auch Wegpunkte berücksichtigt werden, die aktualisierte Kommentare haben.<br>
Wenn du also über einen bestehenden Wegpunkt den identischen erneut importierst, und diese einen Kommentar bekommen hat, so sollte diese neue Kommentar importiert werden.<br>
Diese Funktion muss gründlich getestet werden.

## Änderungen in Version 21.7

### SkuCore
*Fehlerkorrekturen*
- Ein Fehler mit installierten Addons und Tastenbelegungen wurde behoben.

## Änderungen in Version 21.6

### SkuCore
*Neuerungen*
- Über "SkuCore > Spiel Tastenbelegung" kann man nun die Tastenbelegungen für alle Funktionen in WoW festlegen/ändern.<br>
Die Nutzung ist quasi mit der Tastenbelegung für Aktionsleisten identisch.<br>
Achtung: Die Funktion überprüft nicht, ob eine neue Tastenkombination bereits für andere Funktionen verwendet wird. Das musst du selbst überblicken.<br>
Sollte die Tastenkombination bereits für andere Funktionen verwendet werden, so wird sie dort kommentarlos entfernt.<br>
Es gibt außerdem unter "Spiel Tastenbelegung > Alles zurücksetzen" die Möglichkeit alle Tastenbelegungen auf die Standardtastenbelegungen zurückzusetzen. <br>
Dabei handelt es sich um die von _uns_ genutzten Standardtastenbelegungen. _Nicht_ um die normalen WoW-Standardtastenbelegungen.

Fehlerkorrekturen
- Das kleine ö kann jetzt Aktionsleisten zugeweisen werden.
- ENTER wurde bei den Aktionsleisten als Tastenbelegung blockiert.

### SkuNav
*Fehlerkorrekturen*
- Es wurde ein Fehler bei identischen Routennamen behoben.<br>
Einer neu erstellten Route wird ab sofort eine Nummer angehängt, sollte es den Namen schon geben.
- Es wurde ein Fehler mit diversen Unterzonen vor Instanzen behoben (z. B. Düsterbruch draußen).
- Das Rabenholdtanwesen hat eine gerichtliche Verfügung gegen die geplante Zuordnung zum Vorgebirge erwirkt. Es bleibt daher Teil des Alteracgebirges.
- Beim Routenimport werden nun Routen, die bereits identisch (inkl. Zwischenwegpunkte) vorhanden sind, nicht mehr als Detailfehler ausgegeben.

### SkuOptions
*Fehlerkorrekturen*
- Ein fehlendes Leerzeichen bei der Audioausgabe hinter "Würfeln für" beim Würfeln wurde hinzugefügt.<br>
Das Addon hat immer den Gegenstandsnamen direkt an das "für" angefügt. <br>
Das so entstehene Wort "für..." ohne Leerzeichen zwischen "für" und dem Gegenstandsnamen war natürlich unbekannt. Daher gab es dafür immer nur einen Piepser.


## Änderungen in Version 21.5

### SkuNav
*Fehlerkorrekturen*
- Vergessene Debug-Meldungen im Chat entfernt.

### SkuAuras
*Fehlerkorrekturen*
- Vergessene Debug-Infos im Tooltip entfernt.
            
## Änderungen in Version 21.4

### SkuNav
*Neuerungen*
- Im Hinterland wurden Fraktionszonen (Städte von Allianz und Horde) definiert, die beim Betreten angesagt werden.
- Es gibt jetzt eine Funktion, um die laufende Route oder die zuletzt beendete Route umzukehren und diese zum Ausgangspunkt zurückzulaufen.<br>
Du aktivierst die Rück-Folgen Funktion mit STRG + SHIFT + Z.
- Bei der Wegpunktauswahl unter "SkuNav > Wegpunkt > Auswählen > Aktuelle Karte Entfernung" gibt es jetzt zusätzlich die Möglichkeit "Nahe Routen" zu einem Wegpunkt auszuwählen.<br>
Daher wählst du jetzt nicht mehr einfach den Namen des Wegpunktes aus. Stattdessen gibt es unter jedem Wegpunkt ein weiteres Untermenü mit zwei Elementen:

    - **Auswählen**: Damit wählst du wie bisher einfach nur den Wegpunkt aus.
    - **Nahe Routen**: Damit landest du in einem weiteren Untermenü mit nahen Routen zum Wegpunkt. Dieses funktioniert genauso wie die schon bestehenden "Nahe Routen"-Menüs (z. B. bei den Quests).
    
    Damit auch Schnellwegpunkte über Nahe Routen erreicht werden können (z. B. die Leiche), wurden die Schnellwegpunkte wieder mit in die Liste "Aktuelle Karte Entfernung" aufgenommen.

### SkuCore
*Fehlerkorrekturen*
- Es wurde ein Lua-Fehler behoben, der manchmal bei Ruhestein oder Portalen auftrat.

## Änderungen in SkuFluegel Version 5.4
*Neuerungen*
- Mit STRG + SHIFT + F kannst du jetzt alle festgelegten blinden Flügel dir folgen lassen.

## Änderungen in Sku Version 21.3

### SkuNav
*Fehlerkorrekturen*
- Fehler beim Einloggen mit geöffneter Sku-Minimap behoben.
- Der Kartenfehler vor Onys Hort wurde behoben.

### SkuCore
*Neuerungen*
- Wer das SkuFluegel-Addon 5.4 hat, kann dich jetzt von sich aus mit einem Tastendruck auf Folgen setzen. Du kannst also AFK gehen. ;P

*Fehlerkorrekturen*
- Das Problem mit der unfreiwilligen Dauer-Drehung beim Öffnen des Menüs (z. B. beim Questlog, am Briefkasten etc.) wurde beseitigt.


## Änderungen in Version 21.2

### SkuNav
*Fehlerkorrekturen*
- Im Ausklappmenü der Sku-Minimap wurden die Filteroptionen bearbeitet. Sie filtern jetzt korrekt.

## Änderungen in Version 21.1

### SkuOptions
*Fehlerkorrekturen*<br>
- Ein Fehler bei "SkuNav > Daten > Import nach Karte" wurde behoben, bei dem eine Menge Falschmeldungen zu Importfehlern angezeigt wurden.

### SkuNav
*Neuerungen*<br>

Im Ausklappmenü der Sku-Minimap gibt es fünf neue Schalter, um die angezeigten Wegpunkte zu filtern. Diese dienen zur einfacheren Routenerstellung und sind nur für Mac interessant.
- **Filter** <br>
    Standard: aktiv <br>
    Schaltet das Filtern insgesamt an und aus. Wenn aktiviert, werden immer alle Wegpunkte gefiltert, die kein Quest-Start, -Ziel oder -Abgabe sind.<br>
    Custom-Wegpunkte und Wegpunkte mit Route werden niemals gefiltert.
- **Starts**<br>
    Standard: aktiv<br>
    Zeigt bei _aktiviertem_ Filter alle Wegpunkte an, die ein Quest-Start sind.<br>
- **Objectives** <br>
    Standard: aktiv<br>
    Zeigt bei _aktiviertem_ Filter alle Wegpunkte an, die ein Quest-Ziel sind.<br>
- **Finish** <br>
    Standard: aktiv<br>
    Zeigt bei _aktiviertem_ Filter alle Wegpunkte an, die eine Quest-Abgabe sind.<br>
- **Limit** <br>
    Standard: inaktiv<br>
    Begrenzt die angezeigten Wegpunkte bei _aktiviertem_ Filter auf die ersten drei pro Typ (z. B. "Verstörter Hölleneber 1-3").<br>
    Die ersten drei sind, wie bisher, die, die in rosa angezeigt werden.<br>

## Änderungen in Version 21

### SkuAuras
*Neuerungen*
- Es gibt ein neues Modul im Menü: SkuAuras. Allerdings ist es noch ohne Funktion.

### SkuNav
*Fehlerkorrekturen*
- Ein Fehler beim Löschen von Wegpunkten wurde behoben, durch den es nicht möglich war einen neuen Wegpunkt mit demselben Namen wie ein bereits gelöschter Wegpunkt zu erstellen.

*Neuerungen*
- Unter "SkuNav > Daten" gibt es einen neuen Menüpunkt "Alle Routen und Wegpunkte löschen". Dieser löscht ohne weitere Nachfrage alle Custom-Wegpunkte und Routen für die gesamte Welt. <br>
Danach hast du nur noch die jungfräuliche Wegpunkt- und Routen-Liste (also nur noch Standard-Wegpunkte). Wie nach einem Zurücksetzen des Profils.
- In der SkuMinimap gibt es links im Ausklappmenü zwei neue Buttons:
    - Custom w/o: Zeigt auf der SkuMinimap nur noch die selbst erstellten Wegpunkte (rot) an, die nicht in einer Route verwendet werden.
    - Default w/o: Zeigt auf der SkuMinimap nur noch die Standard-Wegpunkte (rosa, grün, türkis) an, die nicht in einer Route verwendet werden.<br>
Bei beiden Buttons kannst du erneut auf den Button klicken, um zur Normaldarstellung zurückzukehren. Das passiert ebenfalls beim Schließen der SkuMinimap.
Bei beiden Buttons wird zusätzlich im Textfeld darunter eine Liste der entsprechenden Wegpunktnamen ausgegeben. Die kannst du dir dann da raus kopieren.
- Importfehler werden vorläufig einzeln im Chat ausgegeben, statt nur gezählt. Sollten welche auftauchen, musst du dich vor einem Export mit den Ursachen befassen.<br>
Rote Fehlermeldungen musst du unbedingt beheben. Gelbe solltest du überprüfen. Weiße sind nur zur Informationen und vermutlich kein Problem.

### SkuQuest
*Fehlerkorrekturen*
- Lady Jaina Prachtmeer ist nach Theramore zurückgekehrt. Sie war nur eben Bier holen.
- Es wurden ein paar Haufen lockere Erde im Sumpfland hinzugefügt. Außerdem habe ich im Meer an der Küste eine warme Stelle gefunden.
- Es wurde eine fehlende Information zu erforderlichen Pre-Quest in die Abfrage implementiert (Beispiel: "Graben in der Erde").

### SkuCore
*Fehlerkorrekturen*
- Die Entfernungseinstellungen werden jetzt gespeichert. Auch zwischen Spielesitzungen.<br>
Da die entsprechenden Informationen vom Server abgerufen werden müssen, und dies zwischen 10 und 90 Sekunden dauern kann, ist die Entfernungsfunktion immer erst nach 10-90 Sekunden nach dem Anmelden verfügbar.<br>
Bis dahin zeigt das Menü "Entfernung" nichts an, und es werden auch keine Reichweiten angesagt.

## Änderungen in Version 20.13

### SkuNav
*Fehlerkorrekturen*
- Einen Fehler mit "Rokaro;Champion der Horde;Feralas" behoben.

## Änderungen in Version 20.12

### SkuQuest
*Neuerungen*
- Ab sofort ist es für uns möglich eigene Korrekturen an der Questdatenbank vorzunehmen (statt nur die von Questie zu übernehmen.)
Den Anfang machen die Quests "Schlammpanzersuppe mit Käfern" ("Morgan Stern" ist keine erforderliche Pre-Quest mehr) und "Bergt die Fracht" (Ziel hinzugefügt).

### SkuNav
*Fehlerkorrekturen*
- Kaputte Routen in Importdaten konnten dafür sorgen, dass der Import für die aktuelle Zone mit einem Fehler abgebrochen wurde.<br>
Das passiert jetzt nicht mehr. Die kaputten Routen werden beim Import entfernt.

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


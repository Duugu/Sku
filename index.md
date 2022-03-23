If you are a first time user of the Sku addon, you need to follow the installation / setup instructions before installing updates from this page:<br>
ENGLISH - First Steps Guide:<br>
<a href="https://duugu.github.io/Sku/first_steps_en.html">https://duugu.github.io/Sku/first_steps_en.html</a><br>
DEUTSCH/GERMAN - Erste Schritte:<br>
<a href="https://duugu.github.io/Sku/first_steps_de.html">https://duugu.github.io/Sku/first_steps_de.html</a><br>

# Updates

*Recent updates:* <br>

IMPORTANT:<br>
Below are two download packages with updates of all addons that are included in our standard installation package for the new WoW patch 2.5.4 (on 22nd). That are all Sku addons and others like Buggrabber, Bagnon, DialogKey, AudioQs, etc.<br>
You shouldn't get any errors if you have updated your addons with that package.<br>
If you are still getting errors or "outdated addons" messages in the game, then you've most probably intentionally have installed additional addons that are not covered and fixed by our addon package. Either update those additional addons manually, delete them, or live with those errors. ;)<br>
[EN - Updated Addon Package for Patch 2.5.4]() (23.03.2022)<br>
[DE - Updated Addon Package for Patch 2.5.4]() (23.03.2022)<br>

*Old updates:* <br>
[Sku-Maus Script r1.7](https://1drv.ms/u/s!Aqgp3J_s6MM7iKVWnPR7b6j42QFL4Q?e=Y7rRmd) (19.03.2022)<br>
[Sku r25.8](https://github.com/Duugu/Sku/releases/download/r25.8/Sku-r25.8-bcc.zip) (18.03.2022)<br>
[SkuFluegel r5.5](https://github.com/Duugu/SkuFluegel/releases/download/r5.5/SkuFluegel-r5.5-bcc.zip) (09.03.2022) (addon for sighted players)<br>
[SkuAudioData ENGLISH r3](https://github.com/Duugu/SkuAudioData_en/releases/download/r3/SkuAudioData_en-r3-bcc.zip) (06.03.2022)<br>
[SkuAudioData DEUTSCH r30](https://github.com/Duugu/SkuAudioData/releases/download/r30/SkuAudioData-r30-bcc.zip) <br>
[SkuBeaconSoundsets r19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[BugGrabber + Bugsack](https://1drv.ms/u/s!Aqgp3J_s6MM7iKN7LiGYcuZzzTTdGw?e=c5c4c7) <br>

# Release notes

-------------------------------------------------------------------------------------------------------	

## Changes in Sku-Maus Skript (wow_menu) r1.7
- Added addition gaming mode detection pixel at lower left corner of the screen, just in case that the upper left corner is covered by overlays from streaming software (requires Sku r25.9).
- Optimized the detection. Script shouldn't unintentionally click on "Delete character" anymore.

## Changes in Sku r25.8

### SkuChat
- The addon now leaves the Looking For Group channel on first login.
- Changed the default value for "Sound on chat message" to "On".

### SkuCore
- Fixed a bug with missing option to choose a reward for some quests with multiple rewards.
- Fixed a bug with missing "auto loot" and other default settings.
- Changed "toggle auto run" in Sku default key bindings from numlock to "ALT + W".
- Fixed a bug with constant "Pet happy" message spam. 
- Fixed an issue with new messages if the chat is open.

### SkuMob
- Your pet / companion now should be read as "your companion" (instead of "other companion").

### SkuNav
- Added faction areas for Horde and Alliance to Kalimdor and Eastern Kingdoms.
- Added the newest map data for english and german.
- Fixed an issue with missing audio for "nah" (German only).
- Fixed an issue with zone "The Dead Scar" / "Die Todesschneise"

### SkuOptions
- Changed the default values for "Speak menu numbers" and "Announce submenus" in "SkuOptions > Options" to "On".

## Changes in Sku-Maus Skript r1.6

IMPORTANT: Instead of just on script there are now 3 scripts for different languages and regions. 
Use the correct script for your region/language:
U.S. realms in English: wow-menu_EN_US.ahk
EU realms in English: wow-menu_EN_EU.ahk
U.S. realms in German: wow-menu_DE_EU.ahk

- Optimized the recognition of "Login" and "Game" mode
- Fixed a bunch of issues with mode detection
- Added support for English
- Added EN EU and EN US region / realm lists
- Splitted the script into separate script for EN_EU, EN_US, DE_EU.

## Changes in Sku release 25.7

### SkuAuras
*Bug fixes*
- Next try to fix that issue with the "contains" operator. Tested with "target change with debuff" and "melee damage". Both working. But I am sure there's something else broken now. :D

### SkuOptions
*Bug fixes*
- Fixed a bug with updating the money on the overview page.

### SkuMob
*New*
- The addon now uses generic terms for player controlled units with unkown names, instead of playing the "beep" for missing words:
	- "you" (targeting yourself)
	- "your companion" (targeting your companion / pet)
	- "friendly player" (targeting a player from your faction)
	- "unfriendly player" (targeting a player from other faction)
	- "other companion" (targeting a companion / pet of another player)

## Changes in SkuFluegel release 5.5

New:
- Added tooltips with descriptions to the unit panels.

## Changes in Sku release 25.6
	
### SkuAuras
*Bug fixes*
- (Again) fixed an issue with "contains" operator.

### SkuChat
*Bug fixes*
- Fixed an issue with "Automatically read SkuChat channel". Should be read now.

### SkuNav
*Bug fixes*
- Added Silvermoon to the list of words for waypoint names.
- Fixed the zone ID for Shadowfang Keep area.
			
## Changes in release 25.5
	
### SkuNav
*Bug fixes*
- Fixed an issue with missing waypoints in Nagrand.

## Changes in Sku release 25.4

### SkuChat
*New features*
- The default value for "SkuChat > Options > Automatically read whisper chat" now is On.
- There is a new option: "Automatically read SkuChat channel". The default value is On.

### SkuNav
*Bug fixes*
- EN only: Waypoints for herbs like "Silverleaf" and minining nodes like "Copper Veign" are now filtered from all lists, as intended.
- Waypoints with "[DND]" in their names are now filtered from any lists and should not be visible anymore.
- Additional fix for metaroute calculation via SkuQuest.

## Changes in Sku release 25.3
	
### SkuNav
*Bug fixes*
- Fixed an issue with metaroute calculation that caused lag with "SkuNav > Route > Follow route" in Hellfire Peninsula. The range for available entry waypoint was lowered from 1000 to 300 yards. That means, if there isn't any waypoint in a range of 300 meters linked to the route network, then "SkuNav > Route > Follow route" will show an empty list (no entry point). Move closer to a linked waypoint in such cases.

## Changes in Sku release 25.2
	
### SkuNav
*Bug fixes*
- Fixed an issue with missing route data for first time users. Route data should be available on next login.

## Changes in Sku release 25.1
	
The localization is completed. The addon is ready to test with language set to "English" (in the Battle.Net client). Please report all missing words and issues!<br>
How to move from German to English:
- You need to delete the "Account" folder in "World of Warcraft\_classic_\WTF\Account". You will lose all existing profiles, settings, etc. for all addons.
- You need to download "SkuAudioData_en 3" via https://duugu.github.io/Sku/
- You either need to deactivate "SkuAudioData 30" in the addon list ingame, or to delete the folder "SkuAudioData" from you addons folder.

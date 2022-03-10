If you are a first time user of the Sku addon, you need to follow the installation / setup instructions before installing updates from this page:<br>
ENGLISH - First Steps Guide:<br>
<a href="https://duugu.github.io/Sku/first_steps_en.html">https://duugu.github.io/Sku/first_steps_en.html</a><br>
DEUTSCH/GERMAN - Erste Schritte:<br>
<a href="https://duugu.github.io/Sku/first_steps_de.html">https://duugu.github.io/Sku/first_steps_de.html</a><br>

# Updates

*Recent updates:* <br>
[SkuFluegel r5.5](https://github.com/Duugu/SkuFluegel/releases/download/r5.5/SkuFluegel-r5.5-bcc.zip) (09.03.2022)<br>
[Sku r25.6](https://github.com/Duugu/Sku/releases/download/r25.6/Sku-r25.6-bcc.zip) (09.03.2022)<br>
[SkuAudioData ENGLISH r3](https://github.com/Duugu/SkuAudioData_en/releases/download/r3/SkuAudioData_en-r3-bcc.zip) (06.03.2022)<br>
[Sku-Maus Skript r1.5](https://1drv.ms/u/s!Aqgp3J_s6MM7iKUcyl-kVsg6_VJA9w?e=0Dnayt) (20.02.2022)<br>
[SkuAudioData DEUTSCH r30](https://github.com/Duugu/SkuAudioData/releases/download/r30/SkuAudioData-r30-bcc.zip) <br>
[SkuBeaconSoundsets r19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[BugGrabber + Bugsack](https://1drv.ms/u/s!Aqgp3J_s6MM7iKN7LiGYcuZzzTTdGw?e=c5c4c7) <br>

# Release notes

-------------------------------------------------------------------------------------------------------	

## Changes in SkuFluegel release 5.5

New:
- Added tooltips with descriptions to the unit panels.

## Changes in release 25.6
	
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

## Changes in release 25.4

### SkuChat
*New features*
- The default value for "SkuChat > Options > Automatically read whisper chat" now is On.
- There is a new option: "Automatically read SkuChat channel". The default value is On.

### SkuNav
*Bug fixes*
- EN only: Waypoints for herbs like "Silverleaf" and minining nodes like "Copper Veign" are now filtered from all lists, as intended.
- Waypoints with "[DND]" in their names are now filtered from any lists and should not be visible anymore.
- Additional fix for metaroute calculation via SkuQuest.

## Changes in release 25.3
	
### SkuNav
*Bug fixes*
- Fixed an issue with metaroute calculation that caused lag with "SkuNav > Route > Follow route" in Hellfire Peninsula. The range for available entry waypoint was lowered from 1000 to 300 yards. That means, if there isn't any waypoint in a range of 300 meters linked to the route network, then "SkuNav > Route > Follow route" will show an empty list (no entry point). Move closer to a linked waypoint in such cases.

## Changes in release 25.2
	
### SkuNav
*Bug fixes*
- Fixed an issue with missing route data for first time users. Route data should be available on next login.

## Changes in release 25.1
	
The localization is completed. The addon is ready to test with language set to "English" (in the Battle.Net client). Please report all missing words and issues!<br>
How to move from German to English:
- You need to delete the "Account" folder in "World of Warcraft\_classic_\WTF\Account". You will lose all existing profiles, settings, etc. for all addons.
- You need to download "SkuAudioData_en 3" via https://duugu.github.io/Sku/
- You either need to deactivate "SkuAudioData 30" in the addon list ingame, or to delete the folder "SkuAudioData" from you addons folder.

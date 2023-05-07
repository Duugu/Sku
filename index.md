If you are a first time user of the Sku addon, you need to follow the installation / setup instructions before installing updates from this page:<br>
ENGLISH - First Steps Guide:<br>
<a href="https://duugu.github.io/Sku/first_steps_en.html">https://duugu.github.io/Sku/first_steps_en.html</a><br>
DEUTSCH - Erste Schritte:<br>
<a href="https://duugu.github.io/Sku/first_steps_de.html">https://duugu.github.io/Sku/first_steps_de.html</a><br>
Русский - Первые шаги:<br>
<a href="https://duugu.github.io/Sku/first_steps_ru.html">https://duugu.github.io/Sku/first_steps_ru.html</a><br>

# Updates

*Recent updates:* <br>
- [Sku r34.3](https://github.com/Duugu/Sku/releases/download/r34.3/Sku-r34.3-wrath.zip)) (May 7th 2023)<br>
- [Wow Menu r3.12](https://github.com/Duugu/wow_menu/releases/download/r3.12/wow_menu-r3.12-wrath.zip) (May 7th 2023)<br>

*Older updates:* <br>
- [SkuAudioData_en r10 (ENGLISH)](https://github.com/Duugu/SkuAudioData_en/releases/download/r10/SkuAudioData_en-r10-wrath.zip) (April 15th 2023)<br>
- [SkuAudioData fast de r3 (GERMAN)](https://github.com/Duugu/SkuAudioData_fast_de/releases/download/r3/SkuAudioData_fast_de-r3-wrath.zip) (April 15th 2023)<br>
- [SkuAudioData r38 (GERMAN)](https://github.com/Duugu/SkuAudioData/releases/download/r38/SkuAudioData-r38-wrath.zip) (April 15th 2023)<br>

*Updates for sighted players:* <br>
- [SkuMapper r3](https://github.com/Duugu/SkuMapper/releases/download/r3/SkuMapper-r3-wrath.zip) (April 25th 2023), mapping addon for sighted players<br>
- [SkuFluegel r6](https://github.com/Duugu/SkuFluegel/releases/download/r6a/SkuFluegel-r6a-wrath.zip) (Sep 1st, 2022), addon for sighted players<br>

# Release notes
-------------------------------------------------------------------------------------------------------
## Changes in Sku r34.3
- Fixed a bug that was causing an error on changing actions bar sets (on switching stance, entering vehicles, etc). Thx @Chaosbringer.
- Slightly changed the "Toggle player, party, raid health monitor" key bind. If you are solo it is toggleing the player health monitor on/off. If you are in a party, it is switching between party health and player health monitor. If you are in a raid it is switching between player health and raid health.
- Added better chat outputs for the "Toggle player, party, raid health monitor" key bind.

## Changes in Wow Menu r3.12
- Added support for auto pause if dial targeting is enabled.
- Social contract will be auto accepted again.

## Changes in Sku r34.2
- Added a new option Core > Range > Range for group members in range checks (default: 10), and a new key bind "Do group members in range check" (default: not bound). This is to output the number of party or raid members that a inside the selected range to you.
- Added a new option: Mob > Options > Sound if target is in combat, to change the default beep sound on targeting enemies that are already in combat to something else. Default value: "Default beep sound".
- Added the spells from patch 3.4.1 to the database (hc+ stuff etc.).
- Fixed a bug with adding all steps from an existing tutorial as linked steps.
- Fixed an issue with creating multi line macros.
- The raid roster on the overview page (default on overview page 2 with shift + up), has been fixed to use the same order as the games standard raid frame.
- Several changes in Core > Monitor:
	- Removed the party health chord style monitor
	- Added raid health and debuff monitors. There are options for enabling/disabling outputs per subgroup, new roles like MTs, etc. Please adjust them to restrict the number of outputs in raids to a level that is useful for you.
	- Player Health, Player Power, and Pet Health outputs are slightly changed to announce the expected numbers. Examples: down from 81% hp to 79% hp the monitor is now announcing "8" instead of "7" as before
	- The player, party, and raid health monitors are now automatically used depending on the group type (if the appropiate monitor is set to On in the settings). If you are solo, its player, if you are in a party, its party, etc.
	- Added a new sku key bind: "Toggle player, party, raid health monitor". Default set to nothing. It is to toggle the currently active health monitor (player, party, raid) on/off.
- Added a new targeting feature for party/raid members. I am calling it "dial targeting", because you are "dialing" the target via the numpad using the raid members number.<br>
	It is disabled as default. You need to explicit enable the feature via Core > Dial Targeting. Can be set to auto enable in parties, raids, both or never.<br>
	With Dial Targeting you're using the numpad to target any specific raid member in any raid size (10, 25, 40) by just typing the raid members number.<br>
	The raid members number is just a running number. Members 1-5 in raid group 1 have the raid member numbers 1 to 5. Members 1-5 in raid group 2 are 6 to 10. Members in raid group 3 are 11 to 15, and so on.<br>
	Typing the raid members number always uses two digits, with a leading zero for numbers below 10. So, to target raid member 1, you will enter 0 1 (zero one). Two is 0 2 (zero two) and raid member 9 is 0 9 (zero nine). Raid member 10 is 1 0 (one zero), and so on.<br>
	As stated, Dial Targeting is disabled as default. To enable the feature, go to Core > Dial Targeting. You will also find other self explaining options there.<br>
	Dial Targeting has three numpad keys with custom actions:
	
	- Numpad zero twice (aka raid member number 0 0) is always you.
	- Numpad decimal separator (English) or Numpad comma (German) is resetting the input and clearing your target. That is, for example, if you started with typing 1, and then, before typing in the second number for the raid member, would like to start over to choose 0 and 1 instead. With resetting the input the addon then will take the next number not as the second, but as the first.
	- Numpad Enter is to re-target the the last target you've selected via Dial Targeting
		
	If Dial Targeting is enabled, all existing key binds on numpad keys will be temporary disabled. The old key binds will be restored after Dial Targeting was disabled.<br>
	If you are enabling dial targeting, you of course can't use the sku menu script shortcuts for numpad 7-9 (clicking on the ground, turning to beacon). With menu script r3.12 or higher they will be automatically disabled while Dial Targeting is enabled. With older menu script versions you need to manually exit the script (ALT + ESCAPE) to have dial targeting working.<br>
	In parties (if enabled for parties) Dial Targeting is using one digit party member numbers (1-4 for party member 1 to 4, and 0 for yourself).<br>
	Any feedback and suggestion to improve the feature is appreciated.

## Changes in Sku r34.1
- Added waypoint layer infos to Stormwind, Elwynn and Westfall
- Added a route to DM dungeon entrance, fixed the tower in Elwynn, and a bunch of other things
- Fixed an issue that could lead to a "constant table overflow" error and losing all settings on closing the game with Alt + F4
- Target outputs now should be in one line (irrelvant if you're not using nvda sapi)
	
## Changes in Sku r34
- Fixed the "available/accepted" text in npc greetings dialogs that questie was breaking with its latest release
- Auto waypoint names changed<br>
	All existing Auto waypoints have been renamed to make them distinguishable. The word "Auto" has been appended with the zone name and a sequence number. 
	New auto waypoint names (created by mappers from this update onwards) can also contain additional information. 
	Example: "auto inside first floor lions inn goldshire elwyn 83". 
	However, the naming of the auto waypoints is up to the mapper. 
	We will try to add more information to new waypoints where this is appropriate. 
	Not on all waypoints. (That is too much work and it would provide no value).
- New: waypoint layers<br>
	Waypoints can now have layer numbers.
	Layer numbers need to be manually assigned by the mapper. By default, they are neither there for existing waypoints nor for new waypoints.
	The layer number or just "layer" of a waypoint indicates its elevation. 
	"Layer 0" means that this waypoint is at the default level. This usually is the ground level/floor.
	"Layer 1" is one level above the ground level. And "Layer minus 1" is one level below ground level.
	So in the inn, the ground floor would be "Layer 0", the basement would be "Layer minus 1" and stairs up would be "Layer 1".
	The layer numbers are not real height information in the world. They only represent "logical waypoint levels".
	They are not meant to show you how high up in meters you are. They are meant to show you which waypoints are on the same layer. At places where several waypoints or routes are on top of each other.
	So, for example, if you are in the basement of the inn, you should find an entry point with "layer -1" upon starting a route in order to get a working route.
	The layer numbers are pronounced to you at several points:<br>
	- In route and quest navigation before waypoints as abbreviations: Examples: "L 0" stands for "layer 0", "L minus 1" stands for "layer minus 1", etc.<br>
	- When you target an NPC or mob, the layer number is appended to the end of the name.<br>
	
	Unfortunately, for technical reasons, the addon can only determine the precise layer number for unique names (names that only exist once). This is the case with all navigation lists (route, close route, quest destinations, etc.), but not with NPCs/mobs in the world that you are targeting.
	If the name of your target is there several times (for example, a guard in Dalaran), the addon tries to find the matching NPC/mob. However, this can be inaccurate.
	If this is the case, there is a "U" after the layer number. For "uncertain". Example: "L 0 U". This means that you should take the layer number with a certain amount of scepticism. :)<br>
	We will assign layer numbers only at places where several waypoints/routes can overlap. Examples: Buildings with several floor, mines and caves where there are also routes above on the ground level, towers with several floors, etc.
	If a waypoint has no layer information, then nothing is pronounced.
	Therefore, no layer information before a waypoint does _not_ mean that it is on the default layer (0), but that the waypoint simply has no layer information.
	If the waypoint had layer information and was on the standard layer, then there explicit "L 0" would be pronounced.
	We will try to add layers to the existing waypoints/routes where this is necessary (buildings, caves, etc.).

## Changes in Sku r33.25
- There some important changes for route entry points (see below). They are in preparation for an upcoming update, where I will rename auto points to something more usefull than just "auto". If don't know what an entry point is: it's the first point that is shown on shift + f10. If you still don't know what that means, then I _strongly_ suggest to read https://github.com/Duugu/Sku/wiki/How-To-Navigation#how-do-i-navigate-using-waypoints-routes-and-close-routes
- Route navigation (shift + f10) is now showing a list of up to 10 entry points (sorted by range) instead of just a single entry point (the closest). So, on shift + f10, if you are unsure if you could start a route from there, go down and check other entry points in range, that could make a better starting point for your route.
- The quest navigation menus (Start, Targets, End) now too have an Entry point list under Routes and Close Routes. (Instead of just silently taking the closest entry point.) Therefore you won't find the destinations directly under Routes/Close Routes anymore, but instead a list of entry points in between. Just like with shift + 10. Choose an appropiate entry point from the list, then go right, and there is the destination waypoints list. 
- Available quests will now start announcing 60 seconds after login and not immediately after login
- Fixed a bug with filters in Aura > Manage > Active
- Made the menu for editing exiting auras outputs filterable

## Changes in Sku r33.24
- added some new aura output sounds (you need to download the new audiodata_en (r9, English) or  audiodata (r38, German) update to use them). The new sounds are: axe 01, blaze 01, interface 01 - 06, shot 01, sword 01 - 03, Tutorial Close 01, Tutorial Open 01, Tutorial Success 01

## Changes in Sku r33.23
- Added an "Audio notification on chat message" settings to every chat tab
- Fixed a bunch of errors with the new internal tutorial storage structure
- Implemented an internal translation feature for tutorials

## Changes in Sku r33.22
- Fixed a bug with creating a new step

## Changes in Sku r33.21
- Available tutorial lists are now sorted by name
- Changed the internal tutorial storage to be language independant
	
## Changes in Sku r33.20
- More bugfixes for the tutorial editor. Didn't saw that coming? :P
	
## Changes in Sku r33.19
- Another bugfix for the tutorial editor
	
## Changes in Sku r33.18
- Fixed 3 bugs in the tutorial editor
	
## Changes in Sku r33.17
- Some changes in tutorial editor
	
## Changes in Sku r33.16
- Added updated map data for Blasted lands, Azshara, Thousand Needles, mapped by Emily
- Fixed a bug with unintentionall removing an aura on "Auto generate aura name" and Auras that don't have a custom name.
- Removed the "Auto generate aura name" option for auras that don't have a custom name (aka where the name already _is_ auto generated).
- Linking of tutorial steps implemented
- "There could be tutorials" hint on first login temporary disabled, as there are not tutorials yet. We are still in development for that feature.

## Changes in Sku r33.15
- Fixed an issue with the sku event dispatcher and new sku events
- Removed default tutorials ("Sku") from Tutorial Editor > Existing

## Changes in Sku r33.14
- Fixed the sku game event triggers for tutorials
	
## Changes in Sku r33.13
- Added support for the following characters for key binds: caret, backquote, tilde, degree
- Added "Continue tutorial" to f1 help menu if player already has started the tutorial
- Changed some default sound volume settings for new players
- Renamed the "Adventure Guide" menu entry to "Tutorials and Wiki"
- Repaired the tutorial trigger "menu item"

## Changes in Sku r33.12
- Added a new tutorial trigger type: Menu item. 
	Creating a new trigger with that type will not instantly create the trigger. Instead it will wait for you to choose the required menu item from the real sku menu.<br>
	To choose the required menu item get to that menu item. Then use /sku menuselect. The addon will create the new trigger and get you back to the Tiggers menu of your tutorial step.<br>
	The trigger will have a name like "Menu item: 1,2,1,1,6". The the menu item numbers. 1,2,1,1,6 means first item in menu root (Navigation), second item under Navigation (Waypoint), first item under Waypoint (Select), and so on.<br>
	If you need to check what actual menu path the numbers are, then there is a "Resolve" menu option under each "Menu item" trigger.

## Changes in Sku r33.11
- Added the placeholder %target% to use in tutorial step start texts. Will be replaced by the npc/creature id of the unit you are targeting while editing the start text.
- Fixed a bug with tutorial shortcuts not working if ALT + J and ALT + K.
- Fixed a bug with tutorial shortcuts and leading to filter inputs in menüs.
- Added an tutorial end text that will be played if the last tutorial step is completed.

## Changes in Sku r33.10
- Restricted the "first login hint" to level 1 characters.

## Changes in Sku r33.9
- A lot of internal bug fixes and updates for the tutorial feature. Added a default basic example tutorial for Human Warriors. This is just for testing and has very few steps.

## Changes in Sku r33.8
- Moved the Pre Quests menu option in quest navigation to the end of the list.
- (Hopefully) fixed an issue where the addon was not always leaving the LFG channel and hiding the details damagemeter addon setup panel for new characters.
- More fixes and changes for the tutorial feature. Still in development.

## Changes in Sku r33.7
- Fixed the falling sound if the player is falling for more than 5 seconds.
- More tutorial testing fixes (feature still in development)
	
## Changes in Sku r33.6
- Fixed the voice output setting for fall detection. :)
	
## Changes in Sku r33.5
- Changed the fall detection and output. The addon will now default make a rising sound as soon as you start falling. Even if it only is like falling down a step. The sound will start small and get higher fast. There are new settings under Core > Options > Fall detection settings. They are pretty self explaining. To set up the old behavior (voice and delay of 1 sec), set Sound output to off and Delay to 1000.

## Changes in wow menu 3.11
- Tried to fix an issue with ultra wide screens with higher ratio than 1.77.

## Changes in Sku r33.4
- Fixed a bug with some distance outputs in Close routes reading random zeros.
- A bunch of changes and fixes on the tutorial feature. Still in development / testing. Not ready to use yet.

## Changes in Sku r33.3
- Added the first public version of the tutorial editor/player (Adventure Guide > Tutorials). Not available tutorials there yet. More details and instructions/guide to come next week.

## Changes in Sku r33.2
- Fixed the END key feature for menu navigation :)
	
## Changes in Sku r33.1
- Added the END key to menu navigation to jump to the last menu item.
- Fixed a bug with current quest in range notification, showing the quest giver waypoint instead of the quest end waypoint in chat.
	
## Changes in Sku r33
- Fixed a bug with the class trainer leading to UI errors.
	
## Changes in Sku r32.23
- Fixed a bug with the resource notifications
- New routes and waypoints added for Thousand Needles, Azshara, Blasted Lands, and Silithus by Emilylorange

## Changes in SkuAudioData fast de r2
- This is faster version of the audiodata file for German with 225% speed. To use it just add this SkuAudioData_fast_de folder instead of SkuAudioData to Addons as usual.

## Changes in SkuAudioData r37
- Added 6.5k new audio files for missing German words.

## Changes in Sku r32.22
- Fixed a bug with the soft interact enable/disable key bind and chat notifications. Was not working correctly while targeting a friendly or hostile unit.
	
## Changes in Sku r32.21
- Tried to fix a bug where the notificaton on resources was breaking Blizzard tts output in instanced zones (like dungeons).
	
## Changes in Sku r32.20
- The addon now is notifying you on resources if you are on follow.
- Fixed an issue with not working resource notifications for resources with umlauts. ("Lichblüte", "Feuerblüte", etc.)
- Fixed a bug where the click/clack sound was going crazy with multiple audio beacons at the same time (quest notifications).
- Fixed a bug that was leading to incomplete spec lists in the bis menu.
	
## Changes in Sku r32.19
- Removed an overlooked debug chat output from Quests > All
- Added waypoint names to quest available/current notifications in chat.
- Fixed a bug that was showing incorrect monitor "Event steps" parameters
- Fixed a bug that was breaking the guild bank menu.
- Changed a lot of default settings to more appropiate values. The most important changes are:
	- The chat has now 3 tabs as default (Default, Communication, and Other) with the appropiate message types enabled.
	- The default key binds for small scans (SHIFT U/O/P/I) are removed.
	- The default key bind for Enable/disable Enemy Soft Targeting has been set to SHIFT I.
	- The default key bind for Enable/disable Interac Soft Targeting has been set to SHIFT O.
	- The default key bind for Enable/disable Friends Soft Targeting has been set to SHIFT P.
	- Core > Monitor > Player > Health & Resource and Pet > Health are enabled as default.

## Changes in Sku r32.18
- Fixed a bug with not working quest tooltips in the quest log.
- Added an option to enemy/friend/interact soft targeting settings: "Sound on empty soft target" (default: silent).

## Changes in Sku r32.17
- Emilylorange mapped routes, graveyards, and about 1/2 the existing quests in Azshara, and parts of Blasted Lands.
- Fixed some bugs with the dialog-key replacement (space to auto/complete accept quests, etc.). It is now selecting current quests only if the quest objectives are actually completed and ready to finish. Additionally the feature now should work with all quest windows.
- Fixed a bug with quest notifications where setting Available Quests > Enabled to Off also was disabling notifications for Current Quests.
- Removed "Ignore quests x levels below your level" for option current quests notifications, as that wasn't making much sense.
- Added you PvP status to the General section on the overview page.
- Fixed a bug where the resource scanning feature Notify on resources was reading not only the found resource, but also names of nearby group members, npcs, etc.
- Fixed a bug with the DK start quest "Death comes from above". Special task now should start regardless of the chat settings for Creatures > Whisper.

## Changes in Sku r32.16
- Fixed a bug with quest notification for completed quests that was breaking the feature.
- Fixed a bug with the auction house that was leading to an empty Auctions from full scan list.
- Fixed a bug with Monitor > Player > Health continous output that was unintentionally outputting 1 if the player was dead.
- Added a new soft targeting setting for enemies: Options > Options > Soft Targeting > Enemy > Mute Names in Combat. Default: Off. With On the addon will not output enemy names for soft targets in combat. This setting is to avoid audio clutter in fights with a lot of enemies.
- Fixed a bug with the BIS Show your class only setting.
- Fixed a bug with BIS details in loot roll tooltips.
- Added BIS details to char equipment tooltips.
	
## Changes in Sku r32.15
- Added best in slot lists for max level chars per class and spec under Core > Best In Slot > Lists. As default the addon only shows lists for your current class. Go to Core > Best In Slot > Options to change that. First item in lists is BIS. Second is second best, etc. The loot roll tooltip has a new section named "BIS info" with BIS details for the item (if that item is on any BIS lists).

## Changes in Sku r32.14
- Tried to fix the bug with not working "contains" auras. Again.

## Changes in Sku r32.13
- Fixed a bug with the four new "duration" aura attributes, that was breaking them and all auras using the Contains operator in any condition. The new attributes should work now, and existing auras shouldn't be triggered unintentionally anymore.
- Fixed a bug with quest notifications that was causing errors.
- Fixed a bug with friendlist that was causing errors.

## Changes in Sku r32.12
- Added four new attributes for aura conditions: "Buff list target remaining duration", "Debuff list target remaining duration", "Your buff list remaining duration", "Your debuff list remaining duration". You can use them to evaluate the remaining duration of the buff/debuff from the "buff/debuff list (L) contains" conditions for you/your target. They have no effect if there isn't the appropiate "buff/debuff list (L) contains" condition in your aura.
- Added a Core > AtlasLoot > Loot history menu with all blue (rare) or better items you've looted. As the addon explicit needs to record looted items, the list of course only has items that you've looted from now on.

## Changes in Sku r32.11
- Added a "Buy" menu option (additionally to Left click and Right click) for items at vendors to buy stacks. If you're buying more than 20 items the addon needs to buy them in steps of 20 every 0.25 seconds. That may take a while with lager stacks. The addon plays the auction house scan progress sound on every bought stack of 20 items.
- Fixed the missing translations for beacon types in quest notifications settings.
- Fixed a bug that was still printing available quests to chat if quest notifications were disabled.
- Removed "level unknown" output for objects on interact soft targeting with sku tts.
- Auction house filters are now working for auctions from full scan too.
	
## Changes in Sku r32.10
- Disabled quest notifications while you are on taxi via a flight master.
- Fixed a bug with quest notifications distance that is printed to the chat.
- Fixed a bug with quest notification for some daily quests that don't have a level.

## Changes in Sku r32.9
- New: Quest notifications, under Quests > Options > Quest notifications. (default: off)<br>
	Quest notifications are auto anouncing quests nearby you that are available to accept or ready for hand in.<br>
	The idea is, to not only "play the list of available quests", but instead realize that there are available quests around by just walking around and exploring the area.<br>
	For that there are audio beacons added to the quest givers with available quest / quests to turn in and the addon is printing the quest in chat.<br>
	I tried to design the beacons as conservative as possible, as in some areas could be several available quests at one place, and therefore serveral simultanous beacons.<br>
	As default the beacons at 50 volume of usual beacons, and they are only active in 180 degrees in front of you. The maximum range for available quests is 30 meters. The maximum range for quests to hand in is 60 meters.<br>
	That should keep the audio clutter in areas with many quests low. If you still uncomforable with the beacons, there are a lot of options to change their appearance under Quests > Options > Quest notifications. Separately for available quests and completed quests. The options should be pretty self explaining.<br>
	So, as stated, for now the feature is disabled for both types as default. Get to Quests > Options > Quest notifications, enable it, adjust the settings if required, and please provide feedback if the feature provides any value and/or what should be changed.
- New: AtlasLoot favorites. Added favorites lists for all slot types (head, feet, weapon, etc.) under Core > Atlasloot. Every item in Atlasloot lists has a "Add to favorites" sub menu entry, to add the item to the favorites list. All favorites lists can have a unlimited number of items. They are numbered. The number is the priority for the item. You can move items up and down in the priority lists. The item priority in a list is are just fyi. For organisation. The addon will let you know if you are rolling on an item that is in your favorite list ("item xy, prio x in atlasloot...")
- Added the currently worn item to vendor item tooltips.
- Fixed a bug with posting auctions in the auction house. The addon was ignoring the duration parameter and posting all auctions with 24 hours. It now should correctly post auctions for 12, 24, or 48 hours.
- Fixed a bug with the pet section on the overview pages, that was blocking all sections below the Pet section if there was no pet (for example the Cooldowns section with default settings).
- Fixed a bug with sending a new mail that was leading to a fatality sound. Bug had no negative effects, though.


## Changes in Sku r32.8
- Next try to fix the Interact Soft targeting:<br>
	I have fixed some code that sometimes was missing target changes and was outputting incorrect "enabled/disabled" messages to chat in some scenarios. That should have fixed the interact soft targeting issues.<br>
	Additionally I've renamed the global soft targeting option "Do soft targeting if" to "Do interact soft targeting if" to make clear that it is just about interact and not for enemy and friends. <br>
	Important: as it turned out some of you are not aware of the "Do interact soft targeting if" option or its impact, and therefore by mistake assuming that interact soft targeting unintended was disabled.<br>
	That is not the case. If you have the "Do interact soft targeting if" setting set to "No hard target locked" (that is the default), then interact soft targeting will be paused as long as you are hard targeting something (by pressing tab or control tab).<br>
	That is intended. You wouldn't be able to use G for enemies without having interact soft targeting paused while hard targeting some unit.<br>
	Therefore you need to clear your hard target (escape) to continue interact soft targeting.<br>
	So, interact soft targeting not working while hard targeting something is no error. Interact soft targeting is not disabled in that case. It is just paused. There is no sense in pressing the Enable interact soft targeting key. It is enabled. Just paused. You just need to clear your hard target.<br>
	As it sometimes is required to have a friendly hard target locked and still to do interact soft targeting (for example if you are /follow a player and still would like to find objects), I have added a third available option to the "Do interact soft targeting if" setting. That is "No attackable hard target locked" (from now on that is the default for new profiles). That one is pausing interact soft targeting only if you are hard targeting an _attackable_ unit.

## Changes in Sku r32.7
- Emilylorange fixed a lot of map bugs in Northrend, mapped Ashenvale, partly mapped Azshara, and added alliance friendly mailboxes to Dalaran.
- Tried to fix the issue where the soft targeting settings are sometimes not correctly applied. Unfortunately I have no clear idea when that happens. Apparently on some unkown combination of login/reload/teleport/targeting. But I can't find out, and therefore not test. Please report if it still happens. Thanks!
- Editing an aura won't change the name of renamed auras auras anymore.
- In editing an existing auras there is a new option "Auto generate aura name" to set renamed auras to the old auto-generated name that is build from the auras conditions.
- Fixed bugs with buying items from the auction house.
- Fixed a bug with auras containing the conditions Buff List Target, Debuff List Target, or Spell Name On Cooldown. With multiple auras containing those conditions only the first aura was triggered.

## Changes in Sku r32.6
- Tried to enhance the loading times. Initial loading on login and reload is still the same, but changing zones (transition in / out of dungeons, taking portals, ships, etc.) should be a bit faster.
- Added a new option "Rename" to each aura under Auras > Manage auras to edit the aura name (that is just build from the auras conditions by default).
- Added options to ignore debuffs by name under Core > Monitor > Player and Party > Debuff. The menu with not ignored debuffs is slow. That is expected, as it has a massive list of all spells in the game. Not a bug! :)
- Fixed a bug with the class trainer window, where not some not available skill could have been selected as default unless you manually selected any skill to train.
- Resource scanning with ruRU locale should work now?

## Changes in Sku r32.5
- Fixed a typo that prevented the full addon from being loaded. Pardon. Always a good idea to last minute change stuff if you are tired and should go to sleep anyway. :D
	
## Changes in Sku r32.4
- Added DialogKey-like keys for quest and dialog windows. Space key in dialog windows (quest list, dialog options, flight master, innkeeper, etc.) will select the first active quest. If there isn't any active it will select the first available quest. If there isn't any available it will select the first gossip/dialog option. Space in quest dialogs will accept/complete/finish the quest (depending on what window is open). Number key 1 to 4 in the quest reward choice window will select the quest reward number x.
- Added Russian translations for resource names (herbs, mining nodes, gas)

## Changes in Sku r32.3
- Fixed an issue with enabling/disabling the soft targeting categories via key binds or changing settings via the menu where settings were not applied correctly on login/reload.
- Changed the maximum range for interact soft targeting from 18 to 15 meters, as it turned out that this is the maximum.
- Fixed the "Do soft targeting if > No hard target locked" option (that is the default value) to ignore interact soft targets if you are targeting something. This should fix the issue where you could not attack hard targets using G if there was some interactable soft target (corpse, box, etc.) in front of you.
- Fixed an issue where the addon was not playing the target sound/name for corpses on interact soft targeting
- Added CTRL + SHIFT + N as the default key bind for Enable/disable Interact Soft Targeting. Only applies to new users or users who not already have bound a key for this.
- Added the option "Chat notification on enabling/disabling soft targeting categories" to the overall soft targeting settings (default: on).
- Fixed (hopefully) an issue with minimap scanning 
- Again (hopefully) fixed another bug with minimap scanning and notifications on resources, that was leading to scans not working, resource notification not working, and a load of other strange things.
- Removed a bunch of Ulduar maps from the database. Should fix the error spam in Ulduar raid.
- Removed the Options > Options > Debug Options > Show error menu item, as there now is /sku errors, and this is the prefered way to show errors.
	
## Changes in Sku r32.2
- Changed the default setting for "Options > Options > Soft targeting > Interact > Output sound for" from "Objects and lootable/skinnable and units" to "Objects and lootable/skinnable"
- Fixed a bug with minimap scanning and notifications on resources	

## Changes in Sku r32.1
[Deutsche Patch-Notes / German patch notes](https://duugu.github.io/Sku/index_de): [https://duugu.github.io/Sku/index_de](https://duugu.github.io/Sku/index_de)
- Added AtlasLoot integration/accessibility. There is a new menu entry Core > Atlas Loot to access AtlasLoot database. You need to have AtlasLootClassic installed for that [https://www.curseforge.com/wow/addons/atlaslootclassic/download/4352422](https://www.curseforge.com/wow/addons/atlaslootclassic/download/4352422). All data is directly taken from the AtlasLoot addon. The Search submenu has just a long list of all items to filter for any specific item. The Lists submenu has the AtlasLoot categories, etc. Item Sets and Items have the usual Sku tooltips with more info (set item list, set bonus, dropped by, currently equipped, etc.). This is just the first implementation with raw access to the data. I will add more features like favorites, filters, etc. in a later step.
- Fixed a bug with Core > Auction house > Sales > New Auction. Menu shouldn't show "Empty" anymore
- Fixed a bug with the overview pages and some section that were cutting the page off (raid, pet)
- Fixed a bug with hearthstone cooldown on overview page
- Fixed a bug with the friends list that was cause a single error on login.
- Fixed a bug with trainer windows, that was showing not available skills
- Fixed a bug with role check buttons
- Added settings to enable and configure soft targeting. Please read the whole description below. I know it is a lot of text. But it is important to understand the feature!<br>
	Soft Targeting is a new way to automatically target items like enemies, players, NPCs and objects without scanning or pressing a button. With Soft Targeting, the game will automatically target anything that is in a certain area in front of you.<br>
	<br>
	Overview:<br>
	In traditional targeting, you press TAB or CTRL + TAB to target something. This target is locked until you remove it with ESC or switch to another target with TAB. All your activities (spells, attacks, etc.) are performed on this locked target. This traditional target or targeting still exists. From now on, however, we no longer call it „target“ (or „targeting“) but „Hard Target“ or „Hard Targeting“ for better differentiation.<br>
	Soft Targeting is an additional target or an additional way to target something. With the old Hard Target and the new Soft Target you can have two targets at the same time.<br>
	You do not actively select the Soft Target via TAB. It is always automatically the next appropiate item in your line of sight. If Soft Targeting is enabled, the game permanently selects the next item in front of you as the Soft Target. The Hard Target, the one you select using TAB, remains unaffected. If you have not selected a Hard Target with TAB, all actions go to the automatically selected Soft Target. If you have explicitly selected a Hard Target, all actions go to this Hard Target as before.<br>
	If Soft Targeting is activated, you can always make the automatically selected Soft Target become your Hard Target by pressing TAB (or CTRL + TAB for friends).
	So, there are now two "targets". The previous Hard Target that you select, and a dynamically changing Soft Target that the game automatically selects and changes.<br>
	<br>
	How it works:<br>
	Soft Targeting is performed separately for enemies (mobs, hostile players), friends (NPCs, friendly players) and interaction items (quest items, herbs, mining nodes, portals, quest givers, etc. - simply everything you can interact with) and can be separately enabled and configured for all three categories. So, for example, you can enable it for enemies, disable it for friends and enable it for interaction items. By default, it is disabled for enemies and friends, and enabled for interaction items.<br>
	You can enable and disable Soft Targeting via three new key bindings. These are not assigned by default. You will find them under Core > Sku key bindings. And you can enable/disable Soft Targeting via the menu under Options > Options > Soft Targeting. In this menu you will also find settings for the Soft Targeting categories (enemy, friend, interaction). The settings are mostly the same for all three. You can set a range in front of you in which the game selects Soft Targets (5, 15 or 180 degrees) and a max distance (enemy and friend up to 60 meters, interact up to 18 meters).<br>
	Since the Soft Targets are selected automatically by the game without your intervention, the addon announces the Soft Target in the same way as the Hard Targets (that are explicitly selected by you), with name, level, etc., when the Soft Target is changing. In addition, it does play a short sound before each Soft Target output so that you can distinguish between the hard and soft target outputs.<br>
	The settings in the menu are mostly to control when and how the game plays these outputs on new soft targets. You can disable the sound. Or use only the sound and disable the name. Or change the sound. Or have no announcement at all for certain Soft Targets. (For example, Friend Soft Targets have "Players" and "Pets" disabled by default. Otherwise you would have a lot of spam in crowded places with a lot of Soft Target changes). Just review the settings. <br>
	As there can now be two targets with (the Hard Target and the Soft Target), and there could be a lot of Soft Target changes, depending on the amount of items around you, there are also two new key bindings under Core > Sku Key Bindings to provide more overview. One to announce your current Hard Target again, and one to announce the current Soft Target again. Both are unassigned by default.<br>
	There are also two general settings for Soft Targeting in the menu:
	- "Auto set hard target to soft target for". By default, the game does not automatically make a new Soft Target your Hard Target. With this option you can activate this for enemies or friends (not for both). Your Hard Target will automatically change with every Soft Target change. Unless you have locked a Hard Target by pressing TAB or CTRL + TAB. In this case, the Hard Target will no longer change automatically.
	- "No soft targeting if". As mentioned, as long as Soft Targeting is enabled, the game permanently selects the items in front of you as Soft Targets. Even if you have actively selected (locked) a Hard Target. If new/more items enter or leave the field of view, the Soft Target changes automatically. And the new Soft Target is announced. With this setting, this no longer happens as long as you have a locked Hard Target (i.e. you have actively pressed TAB or CTRL + TAB to hard target something).<br>
	<br>
	Additional information:
	
	- Important: If you exclude specific items (e.g. "units" in interaction, or „players“ in enemies), then Soft Targeting for these items will still be done by the game, and may block other Soft Targets. There is just no announcement of the Soft Target change anymore. That's all. Example: If you have enabled Soft Targeting for Interaction, the game automatically is soft targeting all interactable items. This could be a mailbox or a quest giver. If you are turning towards a mailbox, it becomes the Soft Target (because you can interact with it). However, if there is a quest giver in straight line between you and the mailbox, then the quest giver becomes the Soft Target (because you can interact with it too, and Soft Targeting always selects the closest matching item in line of sight). The quest giver therefore blocks the mailbox as a soft target. This happens _even_ if you have only selected "Objects and lootable/skinnable" for Interact and not "Objects and lootable/skinnable and _units_". This setting only applies to the outputs. Not to the actual selection of targets by the soft targeting feature.
	- You can interact with Interact Soft Targets as usual with the G key. Without having to take them to the Hard Target with TAB / CTRL+ TAB. However, this is not possible with enemies or friends Soft Targets. You have to take them to your Hard Target using TAB / CTRL + TAB.
	- As mentioned, Interact Soft Targeting applies not only to objects in the game world, but also to NPCs you can interact with in some way. Vendors, quest givers, guards (they have a dialogue), corpses (can be looted), etc.
	- When fishing, Interact Soft Targeting immediately will find the bobber (and you can press G without scanning). However, sometimes the the bobber will fly a little further than the maximum range of 18 meters for Interact Soft Targeting. In this case, Soft Targeting will not detect it. Just cast again until the bobber ends up within the 18 meters range.
	- All old scan features are still available. You usually just should don’t need them anymore.

## Changes in Sku r32
- Updated the interface version to Ulduar patch.
- Added support for resource scanning (mining, herbalism) for Chinese (Simplified).

## Changes in Sku r31.41
- Changes for Core > Monitor > Party > Health Pitch style:
	- Renamed "Silent on 100 and 0 percent" to "Continous silent on 100 and 0 percent", as it applies on continous outputs only and not on event outputs.
	- Added a new setting: Add sound on 100 percent. Default: Yes. Adds a very short pop sound to the number if the party member is at 100 percent health.
	- Added a new setting: Add Dead on 0 percent. Default: Yes. Adds the word Dead  to the number if the party member is at 0 percent health.
	- A triggered full output (via the "Trigger monitor party continous output" key bind) now ignores the Prio settings and outputs members ordered from 1-5.
	- Added a new slash command to enable/disable the party health monitor: /sku mon,party,health
	- Added a new slash command to print the auto-detected roles to chat: /sku mon,party,roles,print
	- Added a new slash command to reset the auto-detected roles: /sku mon,party,roles,reset

## Changes in Sku r31.40
- Added a new slash command: /sku errors. It is printing the last 5 errors as single lines to chat. (If Buggrabber and Bugsack are installed.)
- Fixed an issue with Core > Action Bars > Totem Set 1-3 > Key Binding. Should work now.
- Map updates
	- Added waypoints for Ulduar flight master and repair
	- Added a lot of Argent Tournament Grounds waypoints
	- Added a waypoint for ulduar meeting stone
- Added the raid members list to the overview page(s) (see next bullet)
- Added a second overview page. The second overview page is exactly working as the first one, except that you need to press SHIFT + UP instead of SHIFT + DOWN to open it. The idea is to split information on to pages, instead of having a long and growing list on a single page. As default the second page only shows the raid members, if you are in a raid. Get to Options > Options > Overview pages, to show/hide contents on the second or first page.
- Jus, Kim and Kev got their overall voice volume raised by ~20%.
- Renamed the "Blizzard whisper" chat type to "Battle net whisper"
- Fixed a bug with auction house full scan data where the lowest buyout price was 0 copper
- Added a aura log recorder to debug lag issues. Don't use it without being requested to do so. Enable with /sku record,start and disable with /sku record,stop. All data is cleared on login/reload.
- Fixed a bug with missing outputs for some debuffs in Core > Monitor > Party > Debuffs. Should now work with all debuffs and debuff types.
- Renamed "Core > Monitor > Party > Health" to "Health Chord Style"
- Added a second experimental style to monitor the health of party members: "Core > Monitor > Party > Health Pitch style".<br>
	This concept again is to lower the clutter and output spam to a level where you would be able to use it to monitor and heal even in raids of 10, 15 or even more members without being overloaded by the audio outputs. At the moment it is just for partys with 5 players. I will extend it to 10 player raids in the next step, if the concept turns out to be usefull.<br>
	This party health output style is outputting numbers (1, 2, 3, 4, 5) in different pitch levels for party members.<br>
	However, is it not speed up on low health like Audio QS. Instead it is outputting the party members number once on every event (damage or healing). Example: if party member 2 is taking damage (or is healed) it doing a single "2" output.<br>
	Each number is recorded in 15 different pitch levels. There is a very, very low pitched "2" and a very high pitched "2" (and 13 pitch levels in between). Very low means very high health. Very high means very low heals.<br>
	So, the output for party member 2 starts with a very low "2" at 100% and gets higher and higher every time the party member 2 is taking damage. <br>
	That way there is less audio spam, as the addon has not to constantly repeat the unit number, but you are still able to get the current health from the outputs pitch level if something happens.<br>
	To conclude: The outputs are not continously, as with Audio QS. Instead they are event based. There is (or can be, depending on your setting) a single output on every event (unit is getting damage or is being healed). If nothing happens, a unit taking damage or heal, there is no output for that unit.<br>
	There are several settings to control/restrict the output, to minimize the amount of outputs to what you actually need to know, avoiding clutter from stuff that isn't important.<br>
	Most of those setting are per role (tank, heal, damager). That way are able to set different values per role. Example: Output on every event for tanks, only on +/- 5% health change for healers, and only on +/- 20% heal change for damagers.<br>
	The addon is auto detecting the role of each party member. It is using a combination of amount of damage taken in all previous fights and overall max health for each member. <br>
	As there is no damage if you just joined a party, there will be no role assigned during the first few fights. If the addon "learns" more, it will start to assign roles to party members.<br>
	The auto role assignment may not be 100% accurate at all times. (For example if there boosting groups and players with much higher levels and therefore much more health than the tank. Or of some non-tank party member is taking massive amounts of damage. Or if there just isn't enough data from fights.) Your can alternatively use the Role assignment option to manually assign fixed roles to the party members.<br>
	Additionally to the single party member number output on each event (damage or heal) you can set up a continous output starting at a specific health percentage at a specific rate. Example: You can set up the pitched number output starting from 50% or less health every 3 seconds.<br>
	The "Continuous output start at" setting is role specific, and provides an option to set the percent health value to start the continous output from.<br>
	The "Continuous output every seconds" settings is for all roles, and just is the amount of seconds between the continuous outputs.<br>
	The "Event output limitation" setting again is role specific. It is to limit the amount of events (damage/healing) with outputs. It provides two settings per role:<br>	
		  - "minimum percent health difference since previous event": This is the minimum percentage of health change since the previous output. Example: if a unit has 100% health, and this is set to 15, then the first output will be at 85%, the second at 70%, and so on.<br>
		  - "minimum pitch steps difference since previous event": As mentioned, there are 15 different pitch levels (roughly every 6% health). This is the minimum pitch level change since the previous output. Example: If a unit has 100% health, and this is set to 2, then the first output will be at 88% (2 x 6 = 12), the next at 76%, and so on.<br>
	The two event output setting need to be both true to have an output triggered. If percent health is set to 1% and pitch steps is set to 0, there would be an output on every 1% change (percent is >= 1, and step is >= 0). However, if pitch steps is set to 1, then there won't be any output if the pitch hasn't been changing by at least 1 step, no matter if the percent health has been changed by 1% or more.<br>
	Both settings may sound similar, but they are not. Always consider both values, and what will happen if you are changing them.<br>
	The "Prio output" setting is role specific. It controls if outputs for roles are priorized. Usually outputs will happen in the order they are occurring. If the damager is hitted first, and then the tank, the addon will ouput the damagers number and than the tanks number. If you set Prio Output for some role to Yes, then those outputs are always placed at the first position of the output queue.<br>
	The "Percent delay for next output in queue" setting is for all roles. It controls how "fast" the addon is outputting numbers if there is more than one output in the queue (for example if all party members are taking aoe damage at the same time). The addon tries to not overlap the outputs. There is a delay of 0.2 seconds after each output before the next number is outputted. That is 100%. If you lower this setting the next number will be outputted early. The outputs can start overlapping at ~80%. <br>
	As usual you are always party member 1. The party leader is always party member 2 (except if your are the leader, of course). Therefore it could be a great idea to make the tank the party leader. That way you always have the tank as party member 2.<br>
	As stated, the outputs are event based. If nothing happens, there is no output. But sometimes it can be helpful to have a quick overview of the partys health, even if nothing happens. Therefore there is a new Sku key bind for this feature, Trigger monitor party continous output, that is not bound as default. Bind it, to trigger a single full party health output on request at any time.


## Changes in Sku r31.39
- Removed not longer required map files. Should have reduced the download size and the required time for extracting the .zip file a lot.
- Sku now is auto-hiding the Details News window on first login and the default details panel for alts.
- Added a dispell / debuff monitor under Core > Monitor > Player / Party > Debuffs. Default: disabled.<br>
	It is basically working as Health, Mana, etc. and is announcing dispellable debuffs for you and/or group members.<br>
	No debuffs types are enabled as default. You explicit need to select the debuff types that you would like to monitor. (Magic, Diseases, Poison, Curse)<br>
	There is only a single output if a debuff of some type is applied, renewed, or if the stack number changes. No continous output as default. Use "Continuous output starts after seconds" to have a continous output started if the debuff type wasn't removed after x seconds.<br>
	The default output for Player is the full word (Magic, Disease, Poison, Curse).<br>
	The default output for Party is just the first character (M for Magic, D for Disease, P for Poison, C for Curse) and the party members number. Example: D3 means, party member 3 has some disease debuff. There is on option to switch to full words instead of just the first character.<br>
	For Party you are always party member 1. Other party members are 2 to 5<br>
	I did a lot of test for the debuff / dispell monitor feature, but it is of course difficult to test. Even more for parties. Please test and provide feedback / report errors
- Added a health monitor for your pet under Core > Monitor > Pet > Health
- Added a new voice for monitor outputs: Kevin
- Changed monitor voice Kimberly a little bit, to better distinguish from Justin
- Changed the output for 100% from "full" to "10"
- Added slash commands for monitors to switch them on/off:<br>
	/sku mon player health<br>
	/sku mon player power<br>
	/sku mon player debuffs<br>
	/sku mon pet health<br>
	/sku mon party debuffs
		
## Changes in Sku r31.37
- Added a new submenu Options > Options > Overview page sections to set up what sections in what order are shown on the overview page (Shift + Down). Get to the sections submenu, there are options to move each section up/down or hide/show.
- Removed an overlooked debug output on login
	
## Changes in Sku r31.36
- Added basic support for the Details! damage meter addon to Sku. Download the Details! addon here: [https://www.curseforge.com/wow/addons/details/download/4175900](https://www.curseforge.com/wow/addons/details/download/4175900)
	- The Details! addon has a setup assistent, that is shown on first login and that isn't accessible. The sku addon is auto-completing the assistent for your and is hiding the visual Details! window.
	- There is a new menu entry: Core > Damage meter. Under Reports are all fights. Each fight has a tooltip with damage data (DPS, damage total, damage taken).
	- Please test. I will add more stuff later.

## Changes in Sku r31.35
- Fixed the broken engineer auction house in Dalaran.
- Added a new option to Core > Monitor > Player > Health/Power: "Continuous output start at". Possible values are "Never" and 0-10. The default is never. The continuous output starts if the health/mana is equal/below the value. The old "Continuous output" Yes/No option was removed, as it is not longer required with this change. If you had "Continuous output" enabled, you need to set up that again via the new "Continuous output start at".
- Added a new section "Cooldowns" to the bottom of the overview page with all spells from your spellbook that are currently on cooldown and their remaining cooldown.

## Changes in Sku r31.34
- Added Shaman totem sets to Core > Action bars. There are 3 sets, with 4 totem buttons each.
- Added the set number to all totem button key bindings under Core > Game Key Binds, for clarification.

## Changes in Sku r31.33
- Added Core > Monitor > Player > Power to monitor your power ressource (Mana, Rage, Energy, Runic Power). Works the same way as Player > Health, except there is an option to choose the power/resource type. The default is your main resource. Default voice is Kimberly. To avoid extensive audio clutter the addon tries to speak both, continuous health and power at the same time, if both are enabled. That of course only works if the "Continuous output seconds" setting for both is the same or a multiple. (hp 3 secs / power 3 secs, 3 / 6, 3 / 9, etc.)
- Added an "Event Steps" setting to Core > Monitor > Player > Health and Power. That is the number of steps on from 0 to 100 the addon is announcing values. 10 means every 10 percent, 5 means every 20 percent, 2 means every 50 percent. The default value for Health is 10, the default for Power is 5.
- Added a new experimental feature to monitor the health of party members: Core > Monitor > Party > Health</br>
	This is just a first test on an idea for an audio concept. Not a final feature. I would appreciate feedback if the concept provides any value and if it is worth or not to put more work into it.<br>
	The feature is constantly outputting the health of all 5 party members by playing 5 fast beep sounds in different pitches. The first beep stands for party member 1, the second beep for party member two, and so on. The last beep (the fifth in a full party) is you. If there are less than 5 party members you are always the last one.<br>
	The pitch of each beep indicates the health of the specific party member. Very low pitch means 100% health. Very high pitch means very low health. Reverted sound with very high pitch means dead / 0% health. There are 8 different pitch levels from 0 to 100 percent health.<br>
	Example: low, low, low, high, low means, party member 1, 2, 3 are at 100% health. party member 4 is at low health, party member 5 (you) is at 100% health.</br>
	As default the monitor starts if at least one party member is below 100% health and stops of everyone is at 100%.<br>
	The feature is off by default. There are options to enable it and more under Core > Monitor > Party > Health.<br>
	Remember: This is a test to evaluate different concepts for party (and probably raid) health status. Please provide feedback on the value of this specific concept. Suggestion on enhancements or changes, or even different concepts, are more than welcome.<br>
	The idea is to have a more constant, less cluttered/annoying, and more intuitive output than the one, one, one, etc. from Audio QS. I would assume that, if one gets used to the output style, the output speed could be much faster (if you would like to try, lower the "Speed" option to 20, the default is 50).<br>
	I could add more options, like volume settings, and an "event" setting where the output isn't continously but event based (if party health actually changes), as with the player > health outputs, and more.

## Changes in Sku r31.32
- Removed overlooked debug outputs

## Changes in Sku r31.31
- Fixed a bug with Core > Action bars in vehicles.
- Renamed the incorreclty "share quest" sku keybind to "show tooltip for current loot item"
- Added the currently equipped item to the current loot roll tooltip
	
## Changes in Sku r31.30
- Fixed the item rating issue with death knights and item tooltips in bags.
	
## Changes in Sku r31.29
- Lil Kimberly and Justin are here to monitor your health.
	- There is a new feature under Core > Monitor to monitor different values. Right now there only is Player > Health. There could be more in future.
	- Core > Monitor > Player > Health is to output your current health. It is mainly intended for raid scenarios, where AudioQs isn't that useful. It is disabled as default.
	- There are two output volumes (Continuous, Event) that are adjustable from 10% to 100%.
	- The feature is continuously outputting your health from 0 to 9 using the "Continuous" volume, where 0 means 0% and 9 means 90% health. 100% health is announced as "full". If you health actually changes it is outputting your new health using the "Event" volume. The default value for "Continuous" is 50%, the default for "Event" is 80%.
	- There are some more settings, like the voice, only in dungeons/raids, etc.
	- All settings are saved per character.
	- The slash command to enable/disable the feature is "/sku mon,health"

## Changes in Sku r31.28
- Implemented the equipment manager features under Core > Equipment manager
- Bug with equipment sets on action buttons fixed
- Added the players gearscore to the overview page (General section)
- Appended the buffs and debuffs tooltip text to the buffs/debuffs list on overview page.

## Changes in Sku r31.27
- Chat context menu "send to channel" now is available for additional channels like guild, party, say etc.
- There is a new chat context menu entry: send item link to channel. There is a sub menu with a list of all items in your bags and all currently equiped items. Select an item in that list (as usual with Control + Enter) to open the chat edit box with the channel selected and the item link pasted in the edit box.
- There is a new sub menu entry for bag items and equipped items in the character menu: Add Link to chat. It is opening the chat edit box with the last used channel selected and the item link pasted in the edit box. Then add your message text or just send the link via enter.
- Fixed a bug with action bars (Core > Action bars) and equipment sets
- Added Bloodthistle to the list of resources for scanning

## Changes in Sku r31.26
- A lot of map fixes for Dragonblight by emilylorange
- More fixes for German mining resources names
- More big performance fixes for auras
- More fixes for upcoming Ulduar patch
	
## Changes in Sku r31.25
- Fixed the German names of some mining nodes for scanning

## Changes in Sku r31.24
- Enhanced the aura output code to improve the addon performance in raids with 25 players and/or aoe scenarios with a lot of events/mobs
- Fixed an issue with item use events in auras
- Updated map data: a lot of fixes for borean tundra, more ashenvale routes, more darkshore routes, Mayor Quimby in DK starting area fixed, inscription trainer darnasus linked, minor corrections Darkshore
- Removed an overlooked debug chat output for sending mail
- Added more item price values (1k-10k gold in steps of 100 gold) to the auction house sell menu
	
## Changes in Sku r31.23
- New menu option Navigation > Waypoints > Set Quick Waypoint to coordinates. To set quick waypoints to x and y coordinates. Coordinates are always for your current zone! It is not possible to set waypoints to coordinates in other zones.
- Added the value Your pet to Source (L), Target (L), and Target of yor target (L)
- Evaluation of auras for units throttled to 2 times per second (from evaluation on every game tick), to increase performance on slow computers.
- Fixed Source (L), Target (L), and Target of yor target (L) sometimes giving false positives when there are multiple units with the same name
- Source (L), Target (L), and Target of yor target (L) should now work with all available values
- Source unit attackable and Target unit attackable should now be available for all events
- New aura attributes: Critical, Overhealing percentage
- New aura outputs: Damage amount, Healing amount, Overhealing amount, Overhealing percentage
- Lots of fixes in preparation for stuff that will break with the upcoming Ulduar patch changes.

## Changes in Sku r31.22
- Added weapon buffs (for example from shaman totems) to values for your buff/debuff aura conditions. Example aura to check if the player has shamans Windfury buffed: If your buff list (L) contains Windfury Weapon (Passive) then audio output single and sound brass 5. Weapon buffs are only working for the player. Not for your target.
- Added weapon buffs to the buff list on the overview page (shift + down)
- Added a new sub menu: Options > Options > Sound Settings. It has 5 different game sound settings. All are Off as default:
	- Reverb: Enables reverb in certain areas that have reverb zones such as some indoors, underwater, etc.
	- Positional Low Pass Filter: This cuts off highs from sounds as you get further away from them. It's a subtle change, but neat nonetheless.
	- DSP Effects: This has to be enabled for the lowpass to work.
	- Sound When Game Is In Background: This plays sounds while the game is not in focus.
	- Zone Music No Delay: This immediately plays music when changing zones, and also stops random silence between music tracks when a music track for a zone finishes playing.
- Fixed a bug with the minimap resource scanner (control + shift + r) where setting herbs to Off under Core > Options > resource scanning > Herbs were disabling the scans for mining nodes too.
- Added gas resources to Core > Options > resource scanning.
- There is a new experimental feature: notify on resources (mining nodes, herbs). If you are moving the feature is permanently scanning for resource that are popping up on the minimap. You are notified If there are new resources, and can then do the usual resource scan to get it.
	- The default setting is Off. Enable it under core > options > resource scanning > notify on resources.
	- There is a new key bind for this feature: core > sku key binds > bind key > toggle notify on resources
	- It is scanning for the same resources that are enabled for the usual scans (core > options > resource scanning > mining/herbs).
	- As stated, it is experimental. I've tested it, but issues with mouseover notifications wouldn't be totally unexpected. Please test and report. Thanks!

## Changes in Sku r31.21
- Removed some currency icon links in the statistics menu.
- Core > Social menu will now auto-open on the wow default key for Open Social Pane (O).
- Added 6 more menu quick access key binds (5-10). Default: bound to nothing.
- Sorted the list of sku key binds.
- Added the description to the selected enchantments tooltip.
- Added a "Have materials" filter checkbox to the crafting/profession menus. Default: disabled.
- Added a "Filter" option to enter filter terms to the crafting/profession menus. Do a left click on "Filter" and just follow the instructions.

## Changes in Sku r31.20
- Added a basic social menu under Core > Social. At the moment only Core > Social > Contacts > Friend list is implemented. Every friend has more info in the tooltip and a sub menu with remove, invite, send whisper and take note. Ignore list, who, guild and other sub menus will be added later.
- Fixed a bug with Chat context menu "Whisper to sender".
- Fixed a bug with the Quest database > Start in Zone menu.
	
## Changes in SkuMapper r2.3
- There is a new input box to enter filter terms for waypoints. Found waypoints are shown in white with double size.
	
## Changes in Sku r31.19
- Control + Shift + Alt + F5 to F8 is now updating the quick waypoint with the position of the party member and auto-starting a close route to that waypoint.
- Tried to fix some issues with chat line context menu and Battle.net names. No idea if that worked.
- Fixed an auction house bug with buying/bidding via Auctions > auctions from full scan
- Quests now can be flagged as "blacklisted". Blacklisted quests are impossible to do for blind players or only with sighted help. The blacklisted flag and optional details on the cause are shown in all quest tooltips/details and in accept dialogs.
- Quests now can have extra sku comments. Those comments contain information that you should know to complete the quest. The sku extra comments are shown in all quest tooltips/details.
- Added the item level to item tooltips
- Added a new Sku key binding: stop following route or waypoint. Default: not bound
- Added a lot of map fixes for quest in howling fjord
- Added blacklist flag for some quest in howling fjord
- New aura attributes: Your target's health, Your target's resource, Your target is attackable
- New aura outputs: Your target's health, Your target's resource
	
## Changes in Sku r31.18
### Core
- Achievements and Statistics frame added: Core > Achievements

## Changes in Sku r31.17
### Core
- Fixed a bug with displayed auction bid prices (some were incorrect) and bidding on auctions (did no work in some scenarios).
- Fixed some audio outputs in auction house to use the blizzard tts
- Fixed a bug with not working roles assignment in LFG on enlisting without being in a party

## Changes in Sku r31.16
### Chat
- Another bug with the chat output fixed: the "addon" chat type will now work with all chat tabs, not only with the first one.
	
## Changes in Sku r31.15
### Core
- Two overlooked debug outputs for auction house and actionbars removed
- Bug with ascend/descend keys and the menu opening fixed
- Option Core > Mail > x > Reply fixed
- 7th available scan type named "360+180 3-10 fast" added. That is 360 degrees from top to bottom, 3-10 meters, in 15 seconds. Detection quality is medium to low.
- Hearthstone (Scourgestone) for deathknights on overview page fixed
- Gas resources are added to the resource scan

### Chat
- There is a new chat type for addon chat outputs: SYSTEM > ADDONS. The default is "text". "Addon chat outputs" is every chat output from Sku and other addons. (Example: results for resource scans.)
- Due to the new chat type "Addons" the settings for all chat types under "Chat types > SYSTEM" are resetted to the default values for all existing tabs.
- New option in chat tabs menu: "set all message types and channels to text"
- New option: Chat > Options > All voice output via blizzard tts (default: off)

### Auras
- New aura attribute: "your buff list"
- New aura attribute: "your debuff list (l)"

### Options
- Options > Options > Profiles > New fixed
- Options > Options > Profiles > Delete fixed
	
## Changes in Sku r31.14
- The operators list in aura conditions is now showing only valid operators for the selected attribut
- Fix for aura attributes in combat, source unit attackable, and target unit attackable to work with equal false and unequal operators
- Option to bind a new key to action buttons re-added to the action bar menu
- Tooltips for auction house items are now showing names and stats for items with random enchantments (x of the Whale, Owl, Wolf, etc)
	
## Changes in Sku r31.13
- Outlands - Blade's Edge Mountains map data added, mapped by Lironah and Emilylorange
- The auction house history data is back. :) There _should_ be no more risk for errors with lost settings/auras/etc. However, it is a complex topic, and I would suggest to backup your WTF folder before using this update. Just to be on the safe side. Even if it shouldn't be required. :)
- Fixed a bug that prevented the addon from loading without questie or bugsack installed.

## Changes in Sku r31.12
### Auction house
- The auction house history data is disabled for now as it is again leading to issues with lost setting. That means, there are not historic price data in item tooltips for now. 

## Changes in Sku r31.11
### General
- Action bar names under Core > Actions bars renamed to be more consistent with the names under Core > Game key bindings.

### Maps
- Northrend Icecrown mapped
- Slightly changed the waypoints and added a rescue point in the deeprun tram to make riding the tram easier.

### Mail
- Quest items and soulbound items in Mail > New letter > Items are filtered out.
- Bug with stuck in endless loop with Mail > Open all while bags are full fixed.

### Auction house
The full auction house feature was updated. The "processing" sound has been changed. An additional sound for "processing completed" has been added.<br>
The general speed has not been changed. That is not possible. Blizzard is throtteling addons on querying the auction house. That throtteling is dynamic. It depends on the number of players on the server, on the auction house workload and more. The same query can take 5 seconds or 25 seconds. That is expected and no error. It is dynamic and depends on the current workload!<br>
The required time for queries also depends on the amount of auctions (and therefore on the server population, as high pop servers will have much more auctions than low pop servers).<br>
The more auctions a query is returning, the longer the query takes. Querying all auctions from "Trade goods" with tens of thousands of auctions swill of course take much more time than querying the "Shields" category with just a few auctions.<br>
To overcome this there are new menus to show, find and filter auctions. Those will speed up the process for most items/queries by just using more specific queries.<br>
The auctions menu still has 3 main menus: Auctions, Bids, and Sales. <br>
Bids (auctions that you have bid on) and Sales (auctions you have posted) are unchanged. The are working as before. The Auctions menu has been changed. It now has 5 entries: 
- Filter and sort (unchanged): <br>
	To filter the queried auctions in the lists below.
- Auctions by item: <br>
	This menu is to query the auction house for a specific item that you are interested in (faster than querying all items from a category).<br>
	It contains all auction house categories and a fixed list of all items of each category. <br>
	The items list in each category is NOT what is in the auction house. It is just a fixed list of all items in that category from the items database. You need to go into the submenu of an item to see the actual running auctions for that item.<br>
	The first menu entry "all" is listing all auctions from that category (as before).<br>
	On selecting an item the addon will output the number of actual auctions for each item in that list. That may take a few seconds.
- Auctions by seach string: <br>
	this menu is querying the auction house for some search term of your choice. Select "enter search string", type in the search term, and wait. Go down if the search is completed, to see the returned auctions. Repeat to search for something else.
- Auctions from full scan: 
	This menu contains all auction house categories and all auctions in each category from the last full scan (see next bullet point below).<br>
	As the data is from a full scan, the menu is extremly fast and there are no queries. You don't need to wait.<br>
	However, as the data is from the last full scan, the auctions in this menu could be quite outdated. That depends on when you did the last full scan. Keep that in mind, if you are using the menu. If you want up to date data, do a full scan first.<br>
	If you haven't done a full scan since login, the menu is empty. In that case, start a full scan first.
- Start full scan: <br>
	This is starting a full auction house scan. A full scan is getting all auctions at once. Therefore the full scan can take a few seconds or several minutes. That totally depends on the server population, the number of auctions, the workload, etc. If the full scan is running, just wait for it to be completed. Do not do other stuff or try to check auction house categories.<br>
	A full scan can be done once once in 15 minutes. If you are trying to do it earlier, it will fail.<br>
	Logging out to the character selection screen and back in with the character will reset the 15 minutes timer.

Price data in item tooltips:<br>
- The recent item price data is from the last full scan. If you haven't done a full scan in the current session, then there is no recent price data. The recent item price data is cleared on logout/reload.
- The history item price data is from all previous full scans. Every full scan data is added to the history data (up to 500 auctions per item). The history data is saved between game sessions/reloads.

### Auras
- "dot tick" and "hot tick" events to aura attibutes added.
- Aura output "Output audio and chat single" added.

## Changes in Sku r31.8
- Northrend Storm Peaks is mapped.
- There is a new key bind: Core > Sku key binds > Bind key > Announce distance to target. There is no key bound as default.
- There is a new menu Core > Macros to create and edit macros. Thanks a lot to Birkentau.
- There is a new option: Quest > Options > show colors for difficulty. Default: on. Shows the quest difficulty color in lists (grey, green, yellow, etc.).
- Menus under Core > Game key binds > Bind key are now sorted alphabetically.
- The option to bind keys under Core > Action bar is removed. The Core > Game key binds > Bind key menu has options to bind keys to all action buttons (categories "Action Bar" for the main bar and "Multi action bar" for additional action bars and side action bars).
- Renamed the "Assign nothing" menu entry in the action bar menu to "Assign no action"
- Fixed a bug with some specific quest rewards like venture coins.

## Changes in Sku r31.7
- Fixed a bug with guild bank tabs that are locked for the player
	
## Changes in Sku r31.6
- Fixed a bug with missing waypoints for corpse
	
## Changes in Sku r31.5
- The auction history database is disabled and empty until the auction house re-work is done.

## SkuMapper r2.2
- Object waypoints (green): first 3 are now shown in yellow and the "limit" filter is applied to them
- Added a check for existing names on renaming waypoints

## Changes in Sku r31.4
Changes in Sku r31.4
- grizzly hills and zul'drak are mapped
- more map fixes for howling fjord, tundra and dragonblight	
- added some fix to remove disconnected waypoints that are causing empty routes lists

## Changes in Sku r31.3
- Dalaran waypoints and routes are added. Dalaran is the most complex zone ever, with lots of layers and overlapping routes and waypoints. You better don't even try to start a route using an auto waypoint there. That won't work. Always use named waypoints for NPCs that you can tab target as an entry point.
- A lot of fixes for howling fjord, tundra and dragonblight.
- A bug with the deeprun tram is fixed. Tram will work again.
- Free bag slots on the overview page are only counted for unspecialized bags (quiver, herbalism bag, key ring, etc. are excluded).

## Changes in Sku r31.2
- Map and quest data:
	- vrykul hawk roost waypoint in howling fjord added. quest requires sighted help to get the eggs.
	- habichtfelsen 1-x added. there are habichte on the ground at those felsen. use them for the quest.
	- waypoints for eisenrunengravur 1 + 2 added
	- waypoints for lebronskis teppich added
	- routes in wyrmskull Village and utgard catacombs in howling fjord alliance starting area fixed
	- waypoints for ring des richturteils in utgard catacombs added
	- "Alliance Banner drop waypoint" added. Still not in quests target list. This is intended.
	- more waypoints for Prisoners of Wormskull added
	- waypoint named "Wyrmskull Incense Burner use point" for "The Echo of Ymiron" added
	- waypoint named "nifflevar Incense Burner use point" for "Anguish of Nifflevar" added
	- waypoints for ship howling fjord in to wetlands renamed
	- fixed the route to the First Aid Supplies for "A Soldier in Need" in the tundra
- Addon:
	- Item comparison for guns/crossbows added
	- bank items filtered fom All Bags menu
	- Item comparison for quest rewards added
	- Item comparison for"receive" quest rewards added

## Changes in Sku r31.1
- Fixed a bug with the Howling Fjord map.
	
## Changes in Sku r31

This is the Northrend release update. All kind of bugs, errors, etc. are possible.
The databases are still in a bad shape. Missing quests, missing start/target/end lists are possible.
All routes and waypoints are 100% untested.
There are a lot of phasing, vehicle and other quests. Those are untested too.
Most graveyards are not linked with routes. Please report every unlinked graveyard.

Please report all issues to the specific channels in discord. If you don't report them, they won't be fixed. :)

- Recommendated starting areas in Northrend:
	- Alliance: Howling Fjord or Borean Tundra
	- Horde: Borean Tundra (or Howling Fjord if you have sighted help, as there is a silent elevator in the horde start area)
- The item, quest, creature and object databases are updated.
- Map data for Northrend:
	- Mapped: 
		- Howling Fjord (68-72)
		- Borean Tundra (68-72)
		- Dragonblight (71-74)
		- Sholazar Basin (75-78)
		- Crystalsong Forest (77-80)
	- Partly mapped:
		- Grizzly Hills (73-75)
	- Unmapped:
		- Dalaran (Sanctuary)
		- Zul'Drak (74-77)
		- The Storm Peaks (76-80)
		- Hrothgar's Landing (77-80)
		- Icecrown (77-80)
		- Wintergrasp (77-80) (Outdoor PvP)
	
## Changes in Sku r30.24
- Fixed the missing map data.

## Changes in Sku r30.23
- Removed the Import and Export menu entries under Navigation > Data
- Removed the Navigation > Waypoint > Manage menu.
- The addon is now auto deleting all customized map data that was manually imported (if there is any) on first login after starting the client. That means, if you do import custom map data, it will only exist for the current game session. If you do exit and restart the game client, you need to re-import that data.
- Removed the key binds to open the Sku Minimap for mapping or to show routes on the game minimap.

## Changes in Sku r30.22
- Fixed a bunch of waypoints and waypoint names in the dk starting area to be more clear.
- Fixed another bug with special tasks for players that don't have the pet message set to text or audio.
- Fixed more bugs with deathknight quests not showing in the list of available quests.

## Changes in Sku r30.21
- Fixed a bug with deathknight quests not showing in the list of available quests starting in zone.
- Fixed a bug with special tasks for players that don't have the chat set to auto-read.
- There is a new option under Auras: Export all auras. It is exporting all auras from the current character in one big chunk.

## Changes in Sku r30.20
- Added mapping data for death knight starting area.

## Changes in wow menu 3.9
- Fixed an issue with the EN US script.

## Changes in Sku r30.19
- Removed overlooked debug chat output on login/reload.
- Removed a lot of virtual trigger spawn points from Northrend maps.

## Changes in wow menu r3.8
- Added the missing sound file for US East Eranikus.

## Changes in Sku r30.18
- Fixed an issue with game key bindings, that caused all key bindings to be mixed up on new installs.

## Changes in wow menu r3.7
- Server lists for US and EU updated
- Missing Bloodelfs re-added to the character creation menu
- Added server types to the server names

## Changes in SkuMapper r1.1
- Initial release

## Changes in Sku r30.17
- Fixed a bug with the overview page. Should work again.
- Added Northrend herb and mining resources to lists and waypoints.

## Changes in Sku r30.16
- Fixed a map id issue for hellfire citadel and other areas.
- Re-added the hunter pet infos to the overview page (SHIFT + DOWN).
- The bag will again auto open if the trade window opens.
- Removed a bug with line feeds in comments of LFG entries.

## Changes in Sku r30.15
- Added map data for stormwind harbor, ship from menethil to northrend, zeppelin from orgrimmar to thunder bluff, zeppelins from orgrimmar to northrend, and other stuff
- Fixed a lot of map ids with issues.

## Changes in Sku r30.14
- Fixed an issue with the category list in the LFG tool.
- Fixed the not working do not hide tooltip feature.

## Changes in wow menu r3.6
- Fixed a bug with creating a new character and class Mage.

## Changes in wow menu r3.5
- Updated the US East server list.


## Changes in Sku r30.13
- Fixed the issue with closing auction house on posting multiple auctions. Thanks, @samalam.
- Fixed the issue with closing menu on changing chat tab configs.
- Removed the overlooked debug output on action bar configuration.
- The "all bags" menu will not show keys from the keyring anymore.
- The auras property "spell name" should again list each spell name only once.

## Changes in Sku r30.12
- There are new key bindings under Core > Game key bindings:<br>
	- Under the existing category interface:
		- TOGGLE LFG WINDOW
		- TOGGLE LFG LISTING TAB
		- TOGGLE LFG BROWSE TAB
		- TOGGLE ACHIEVEMENT WINDOW
		- TOGGLE STATISTICS WINDOW<
	- Under the new category: vehicle control
		- VEHICLE EXIT
		- VEHICLE PREV SEAT
		- VEHICLE NEXT SEAT
		- VEHICLE AIM UP
		- VEHICLE AIM DOWN
		- VEHICLE AIM INCREMENT
		- VEHICLE AIM DECREMENT
- New feature: the LFG tool is accessible<br>
The LFG tool is a very complex feature. I did a bunch of test, but of course not in every situation.<br>
Please carefully test every possible scenario. Solo, in parties, as a leader, as a party member, etc. If possible do that with assistance of a sighted player, to check if everything is working as intended!<br>
Usage:<br>
The LFG window is bound to the key I as default. As that key is used by the sku addon for the "turn to beacon" feature, you need to bind the LFG windows to a new key to use it. There is a new binding named "TOGGLE LFG WINDOW" (under Core > Game key binds > assign key > interface). <br>
	- To enlist yourself (if not in a party) or the full party (as a leader):<br>
		- open the LFG window
		- go to "Enlist" and select your role(s)
		- go down and select a category for your post (dungeons, raids, Quest & zones, PvP, Custom)
		- go down and select actions from that category. Cou can check/uncheck as much categories as you want. You need to select at least one activity.
		- go down and enter a commen for your post (option, except for category "custom"). Caution: you need to exit the comment enter mode with Escape. Not with Enter!
		- Go down and select "List self" or "List group" if you are in a party
		- Your LFG request will be listed. There will be a addon error. That seems to be a bug in the Blizzard interface. Please just ignore that.<
	- To browse the list of available LFG posts:
		- go to browse
		- go down and select a category
		- (Option) select the activities you are interested in. If you don'T select activities the list will contain all activities from the selected category (for example all dungeons in the world).
		- go down to "results", go right and down to see the list of found LFG requests. If there is only one entry "Refresh list", then the list is empty. Select another category with more LFG posts (dungeons should be quite busy). Each result entry has a tooltip with more details.
		- Go right on any result entry and do a left click to open the context menu and select actions for that entry (Request invite, Whisper party leader, etc.)
- The Local menu now shows options on the LFG role poll popup.
- Added all spells from Wrath to the spell database. That should fix issues with auras using new spells.
- Auras using "own resource" are now covering death knights rune power too.
- Menu items like bag slots, talents, etc. are dynamically updated on changes like left/right click, split, destroy, etc.
- Fixed the role selection in the talent menu.
- Added a new option "Chat > Options > Never reset audio queues". Default: Off. Don't enable it if you don't know what it means.
- Fixed a bug with item rating for death knights that was blocking item tooltips. Now there are just no ratings for this class. :)
- Fixed an issue that was occuring on reload.
- Fixed a bug where Core > Action bars failed to show bars/button if the player was controling a pet or vehicle and the main action bar was replaced by the pet/vehicle bar.
- New feature: special tasks
This feature is guiding you in tasks/quest/scenarios where no coordinates and therefore waypoints and routes available.<br>
An example is one of the very first death knight quests, "Death comes from above", in the death knight starting area.<br>
The feature automatically detects those scenarios and is starting the correspondant special task. It then is providing instructions via voice. All instructions are added to the chat too, if you need to re-check them.<br>
The feature is telling you how much you need to turn left and right and move forward.<br>
You need to exactly follow the instructions. If the feature says "do not use any other keys except left, right and forward", then do not use any other keys until the task is completed or canceled. Under no circumstances. The feature will break if you are using other movement keys (like backward, strafe, autorun, etc.).<br>
The feature will output your direction and forward movement every time you are stopping turning/movement.<br>
For the example quest "Death comes from above" in the death knight starting area, the special task will start if you are entering the orb, and getting control over the orb (will take a few seconds, just wait).<br>
The first step will be to turn to 144 degrees. Use left/right to turn exactly (+/- 2 degrees) to turn to 144. DO NOT MOVE. Only turn. On turn steps do not use any other keys than left and right.<br>
If you have hit 114 the feature detects that an moves to step 2. That will be to move forward from 3.4 to 0. 3.4 is the overall time you need to press the forward key in seconds. You can do that in small incremental steps. Press forward very short. The number will decrease. Do that again, and again, until the number is 0. Do not move further than 0. Caution! You need to hit 0 EXACTLY, or the feature will break! Do not move further. No even 0.1 seconds. On move forward steps do not use any other keys than Forward. Not backward, not left/right, not strafe... nothing. just forward.<br>
If you reach 0 the feature will move to step 3 and will provide the relevant instructions on what to do. Step 3 will be a turning step again. Proceede as above.
Just complete all steps, and the quest should be done.<br>
Remember: do not use any other keys than the key or keys that are valid for the current step while on a special task. If the step is turning, use turn left/right only. If the step is moving forward, use moving forward only. If you use other keys, the feature will break. You would have to abort the quest and start over.

## Initial update for the Wrath of the Lich King pre-patch

Caution: Do not install the new addon before the server maintenance is completed (tuesday/wednesday, depending on your region. It won't work with the current game version.

### Setup
- Delete all addons from your addons folder. If you really would like to keep addons, please feel free to do so. But they most probably will be broken anyway. <br>
A fresh start would be better. You can re-install working versions of other addons later.<br>
Important: If you don't delete everything from Addons, then you still need to delete at least all Bagnon addons. We don't use them anymore, and the new Sku version won't work with Bagnon installed!
- Download the Wrath package for your language. It contains available versions of all sku addons and some other addons.
	- Englisch: [https://1drv.ms/u/s!Aqgp3J_s6MM7iKh7_zgA75Pee4Tl2A?e=oeQIK6](https://1drv.ms/u/s!Aqgp3J_s6MM7iKh7_zgA75Pee4Tl2A?e=oeQIK6)
	- German/deutsch: [https://1drv.ms/u/s!Aqgp3J_s6MM7iKh64sj6j31Oa0io8g?e=CXKTka](https://1drv.ms/u/s!Aqgp3J_s6MM7iKh64sj6j31Oa0io8g?e=CXKTka)
- Extract everything from the downloaded package to the addons folder.
- You need to setup the script wow_menu again for Wrath. It is part of the packages and should just have been copied to your addons folder.<br>
Follow the known steps to setup the script again. There is a readme in the wow_menu folder, just in case you can't remember.<br>
Don't forget to move the wow_menu folder out of Addons if you are done.
- Then get back to this page and download and install all latest updates listed above.

### Bugs:
- There was almost zero time to test. Errors, issues, bugs and other quirks should be expected. .
- Blizzard will add two "fresh" servers with the pre-patch. Unfortunately they forgot to tell where. Therefore I can pre-adjust the script. if the dedice to add those server to the region where your server is located, the they most probably will mix-up the list and switching the server won't work anymore. Even with the new script. If that happens please wait for the script to be updated.

### Not implemented yet:
- All death knight features like runes and rune power
- The full death knight starting area
- Equipment manager
- Calendar
- Archivements

### Good to know:
- Mounts/pets (critters, not hunter pets): they are now added to your spellbook. Use the mount/pet item in your bag. It will disappear and appear as a new spell in your action bar configuration.
- Bank bags are now shown under "Bags". Don't look for a "Bank" menu under local. Get to "Bags" and arrow down, if you are at a bank.
- Hunter pets now have a talent tree. The pet talent tree is available under your talent menu if the pet is there.
- In vehicle combat your standard action bar is replaced with up to 8 new skills. The key binds are the same. Check the actionbar menu to see the available skills if you are in a vehicle.

## Changes in Sku r30.11
- Random enchantments items in bags are shown with the actual enchantment again.
- Fixed the auction house sell bug. Selling is working again. But still only one auction per use. Need more time to fix it.
	
## Changes in Sku r30.10
- Fixed an issue with the The dark Portal area in Blasted lands, winterspring and a bunch of other zones. Please keep reporting broken zones/areas.
- Removed "Navigation > Waypoint > New.

## Changes in Sku r30.9a
- The character menu shows the Stats tab
- The character menu shows Currencies/tokens tab
- Added a sixth scan type: "360 10 very fast". It scans 360 degrees 0-10 meters in 2 seconds max. 
Because it is faster, it is also more inaccurate. It is good on detecting larger objects that are close to you. Results are getting words the smaller and the more far away object are.
Go to "Core > Scan settings > [one of the 8 pre-defined scans] > type" and select the new type "360 10 very fast"" for that scan.
- Added a new option "Core > Options > do not hide game tooltip" (default: off)
For players with some level of sight. As default the addon is hiding the visual tooltip instantly. That is speeding up the scan feature.
If you have some sight and would like to read the visual tooltip, set this to on, to keep the visual tooltip.
- The addon now should load a bit faster.
- Again tried to fix the "table constants overflow" issue that leads to losing all sku settings.
- Core > Options > "Auto following" and "Temporarily stop following upon casting" have been removed and won't work any longer.
Blizzard has intentionally removed the option to start/stop following for addons. (https://us.forums.blizzard.com/en/wow/t/re-addons-still-able-to-execute-remote-follow-commands/1298614)

## Changes in SkuFluegel 6
- The options to remotely set blind players on follow/unfollow has been removed. Blizzard has removed that feature for addons. (https://us.forums.blizzard.com/en/wow/t/re-addons-still-able-to-execute-remote-follow-commands/1298614)


## Changes in wow_menu 3.4
- Fixed a bug with the EN US version of the script.

## Changes in wow_menu 3.3
- Tried to fix the auto accept for the contract. I can't test the fix, as I already have accepted the contract. Any feedback would be welcome.
- Actions for numpad 7 and 8 changed:
	- numpad7: right click in front of you (was right click at your feet)
	- numpad8: left click at your feet (to use area of effect spells that need to be targeted on the ground via left clicking in the game world)

## Changes in wow_menu 3.2
- Social contract on first login will be auto accepted
- Loading outdated addons will be auto accepted
- Removed Shazzrah from the english EU server list

# Old (pre Wrath) release notes

## Changes in wow_menu 2.14
- Updated the server list for EU EN.
		
## Changes in Sku r28.8b
- Re-added the unintentionally removed option "Announce friendly and hostile players".

## Changes in Sku r28.8a
	
- Clearing the audio queue of the Blizzard tts or the Sku tts was unintentionally clearing the queue for both. That is fixed. Blizzard and sku tts should now play in parallel and not skip each others outputs. One effect is, that weypoint comments do work again.
- Removed the cut-off of long menu entries with ... in audio menus. The audio menu now always reads the full text line.
- New option "generic outputs for player controled units via Sku" under Mob > Options. (Default: off) With this option outputs on targeting players or player controled units are done via the sku tts, using generic texts like "friendly player".

## Changes in Sku Script (wow_menu) r2.13
- Updated the regions and server lists to reflect the recent server changes. Switching server is working again.

## Changes in Sku r28.7
	
### Chat
- Fixed a bug that caused messages to show twice in the chat.

## Changes in Sku r28.6

### Navigation
- Fixed a bug with numpad 9 / i not working with some addons that are modifying the chat input box.

### Options
- The menu now mandatory uses the Blizzard TTS. It is not possible to get back Sku TTS for the menu. The option to set Blizzard tts for the menu to on/off under Options > Options was removed.

### Chat
The chat module now is already using the new chat system from the Wrath version of the Sku addon.<br>
- How to use the new chat<br>
	The chat and all features described below are now usable in combat.<br>
	The chat now has all chat messages sorted in tabs. That way you can create different tabs for different chat content and get more overview.<br>
	As default there is only one chat tab named "Default", with all chat messages. You could for example create a second chat tab, named "Party and Raid", with only that chat it.<br>
	The chat still opens with Shift + F2.<br>
	On Shift + F2 the addon first reads the name of the current tab and then the first (newest) chat line.<br>
	You can use arrow down/up to move to the next/previous chat line.<br>
	If you have more tabs then just Default (you need to create them), you can use arrow Right and Left to switch to those other tabs. Then just use Down/Up to read the chat lines in that tab.<br>
- Chat tabs<br>
	To see all current tabs go to Chat > Tabs. If you haven't created additional tabs, then the only tab there is "Default".<br>
	You can create additional tabs using the New Tab menu under Chat > Tabs.<br>
- Message types for tabs<br>
	Every tab has its own settings for what messages should be shown in that specific tab.<br>
	Go to Chat > Tabs > Default > Message Types to see what message types are shown in this tab.<br>
	The categories like Combat, PvP, Other, etc. and the different chat types under those categories are the same that the blizzard interface is using.<br>
	Every chat typ can have a specific action assigned. "Text" means, that the message type is shown in the specific tab. "Audio" means, the tab shows the message type, AND the messages are read out loud. And "Silent" means, that chat tab is not showning those messages, and they are not read out.<br>
	Just browse the categories and message types of the Default chat tab, and set them to actions that you find appropiate.<br>
- Chat channels for tabs<br>
	The same system is there for all chat channels you've joined.<br>
	Go to Chat > Tabs > Default > Channels and see what channels have what action for this tab.<br>
- Whispers<br>
	There are a bunch of new settings for the chat under Chat > Options > Chat settings.<br>
	One of those is "Show whispers in new tab", which is On as default.<br>
	Every whisper that your are receiving (or you are sending) will be shown in a new tab with this setting.<br>
	So, if you do receive a whisper from Palabob, then that whisper (and the full following conversation, if there is any) is not shown in your "Default" tab, but in a new tab with the name of that player.<br>
	Turn "Show whispers in new tab" off, to have all whispers in the default tab inline, instead in new tabs.<br>
- chat Line context menu<br>
	Every chat line in every tab has a new audio context menu with actions.<br>
	To open the line context menu press Control + Enter. Then use arrow Down/up as usual, to browse the options. To select/use an option, press Control + Enter on that option. To leave the line context menu and get back to the chat lines use arrow left.<br>
	Some context menu options are:<br>
		- send message to channel<br>
		- whisper sender<br>
		- invite sender<br>
		- copy sender name<br>
		- copy this chat line<br>
		- copy all chat lines<br>
		- add sender to friend list<br>
		- ignore sender<br>
	Not all of them are always availabe. Example: "Ignore sender" isn't available for System chat messages. :D<br>
- History<br>
	And finally, the chat history for all tabs is saved between sessions. There are up to 100 old messages in each tab.

## Changes in Sku r28.5

### Auras
- Fixed an issue with combo points.

## Changes in Sku r28.4
### Core
- Fixed the German text in socketing menu.
- Fixed the enchanting menu. Should now work again.
- Fixed the Popup menu. Example: yes/no on warning for enchanting an already enchanted item. Should now work as intended, without anything blocked. Even with the "Do you want to allow custom scrips..." thing and such stuff should work. But it is untested.

## Changes in Sku r28.3
### Core
- Manually rebuilded the Socketing menu.
- Fixed a bug with the trainer frame for weapon masters.

### Options
- Fixed and issue with bank bags.

## Changes in Sku r28.2
### Navigation
- The addon now plays a continous low volume warning sound (ping & purr) if routes on the minimap and/or the additional sku mimimap are (unintentionally) enabled. <br>
	The current default key binds for those features are Alt + K and Alt + L. Both features are only used for mapping and do generate a lot of lag, leading to bad gameplay.<br>
	If you hear the constant ping in the background, then please use Alt + K and/or Alt + L to disable them.<br>
	If Alt + K/L isn't working, the features are probably bound to other keys. Go to Core > Sku key binds > Bind key > Open Sku minimap / Show routes on minimap, to check what keys they are bound to.

### Auras
- Added a new attribute and output "Your combo points" to evaluate/output your combo points on the current target.

## Changes in Sku r28.1

### Core
- Fixed an issue with the turn to beacon feature and very low (1024x768 or lower) and very high (4k) screen resolutions.
- Fixed an issue with minimap ressource scanning (Control + Shift F/R) and mining nodes.
- Fixed an issue with mouseover scaSkuAuctionConfirmEditBoxnning on herbs/mining nodes (control + U, control + shift + U).
- All "xy mouse over" readouts are now read by the Blizzard TTS voice.
- Fixed a very rare issue with the I key and some input boxes (for example mail recipient, subject, body), that was mixing up what you typed in the input box.
- The class trainer menu now has scroll down/up options.
- Manually re-builded the profession trainer menu. Should now appear and work like other menu (crafting, etc.)
- Added the tooltip of the item that will be crafted to the selected skill in the profession menu.
- Added an option to read all tooltips. Core > Options > Read all tooltips (default: off). That will read out every single thing your mouse is getting over. Could generate a lot of audio spam.

### Options
- All option menus (xx > options) are now filterable.

## Changes in Sku r28

Release notes in German: Diese Veröffentlichungshinweise findest im heruntergeladenen Sku-Ordner in Deutsch. Dateiname: release notes DE.txt

### ATTENTION:
You do need the new script (wow_menu) version 2.12 for this release. You can't use older scripts with this Sku release.
Thus downloading wow_menu r2.12 is mandatory.

### Options
- Changed the default key bind for stopping the TTS output from Right Shift key to Control + V.
- Added 11 new sounds to Options > Options > Background sound.
- Fixed a bug with reseting the sku addon profiles (Options > Options > Profile > Reset).

### Navigation
- Fixed a bug with routes via quest log or shift + f10 were the routes list was empty if the entry point was the same as the destination point.
- New feature: auto turn towards the current beacon<br>
	Note: You need to install and use the newest script version for this feature. Wow menu 2.11 or higher.<br>
	You now can use the I key or Numpad 9 to automatically turn your character towards the current beacon. Both keys are fixed and can't be adjusted.<br>
	Turning your character takes around 0.3 seconds on each use. <br>
	The feature isn't 100% accurate. It is possible, that the character sometimes isn't heading excactly at the beacon, but a few degrees left or right from the beacon. Repeatingly pressing the key could help.<br>
	The feature heavily depends on your game frame rate. High frame rates will make it more accurate. With low frame rates it is getting less accurate.<br>
	The feature can be used while you are moving and is spammable. You can move and constantly press I or Numpad9 to turn towards the current beacon every 0.3 seconds.<br>
	That will work quite good if the beacons are not to close to each other or if you are moving slowly.<br>
	Spamming it while moving can be difficult if the beacons are very close and/or you are moving fast (riding or flying).<br>
	You should use this feature wisely. For sighted players it could look slightly like a bot in some scenarios. Especially if the waypoints are very close to each other. I would suggest to avoid running and spamming it in crowed placed with lots of players. Stop and using it to turn is no problem. Beside that running and spamming could look strange to sighted players, it isn't working that good at places like cities, as waypoints there are usually quite close.

### Core
- Changes on error notifications (under Core > Options > Error Feedback):
	- Several error notification types are now enabled as default.
	- The error notification output is now using the Blizzard TTS voice if an output is set to "spoken".
	- A new "other" error type was added to error notifications list. "Other" errors are all error types that are not explicit in the list.
- The resource scan feature for herbs and mining nodes had some bug fixes and was been significantly enhanced:
	- There are still two scan types: <br>
		CTRL + SHIFT + R: do a 50 meters range scan around your position<br>
		CTRL + SHIFT + F: do a 120 meters range scan around your position
	- The found resources (herbs, mining nodes) are now listed with a number, direction and distance for each. Example: 1 Peacebloom northwest 35 meter<br>
		And the 4 quick waypoints are automatically set to the first 4 found resources per scan. resource one is quick waypoint one, two is two and so on.<br>
		You then can just start a usual navigation to that quick waypoint (Shift F5 to F8 for Quick Waypoint 1 to 4) to get to the resource.
	- The directions, distances and quick waypoint positions are not 100% accurate. Depending on the distance they could be differ by up to 10 meters from the actual position of the herb or mining node.<br>
		As a rule of thumb: the close a resource is, the less accurate the direction, distance and position.<br>
		The accuracy of that information also highly depends on the scan speed. The faster the scan speed, the more unreliable the direction, distance and position.<br>
		There is a setting to adjust the resource scanning speed: Core > Options > resource scanning > Accuracy. The default value is 3, which is a good tradoff between speed and accuracy. You can adjust that setting from 1 (very accurate, but very slow) to 5 (quite inaccurate, but very fast) if you would like to have more accurate or faster resource scans.

- New feature: there are now options to adjust the sku addon key binds: Core > Sku key binds
	- Sku addon key binds are all key binds that are specific to the sku addon itself. Like Shift + F1 to open the menu. 
	- The Sku key binds are saved in the Sku profiles. Thus all characters with the same profile share the same Sku key binds.
- Added Shift + G for "Interact with mouseover" to the default game key binds. You need that for the new scan looting/interacting feature below.
- New feature: Scan and interact with mouseover for interacting with objects like mailboxes, objects in the game world, fishing, finding corpses and more.<br>
	From now on you will use a scan feature and Shift + G for "Interact with mouseover" to find and use objects in the game world. You won't need the old turning and press numpad 7-9 feature anymore.<br>
	How to use it:<br>
		First of all: If you haven't done that yet, go to Core > Game Key binds > Bind Key > Targeting and set up a shortcut for "Interact with mouseover". (Default is Shift + G, but you can choose any other shortcut of your choice.)<br>
		Scanning is automatically turning your camera around you (and thus the mouse pointer) very fast.<br>
		While doing that it is constantly checking if the mouse pointer is getting over an object.<br>
		if that is the case it instantly stops turning, and thus your mouse pointer will be on the object.<br>
		With the mouse pointing on the object you then can press the new shortcut Shift + G (interact with mouse over) to right click on that object.<br>
		Shift + G is working like the known shortcut G (interact with target), except it is interacting with the object under your mouse, instead of your current target.<br>
		Your character will either directly use the object (if you are in use range), or move to the object and use it then.<br>
		The scan stops on the first found object (see below for what objects the different scans are looking for).<br>
		You then can either press SHIFT + G to interact with that object, or using SHIFT + L to continue the scan to find another object of that type.<br>
		A running scan will be instantly stopped if you do start moving.<br>
	The different scans:<br>
		There are 8 different scans available. They have different ranges and accuracies and they are scanning for different objects. You will find details on them below this list.<br>
			- Scan 1: SHIFT + U, 360 10 fast, herbs, mining nodes<br>
			- Scan 2: SHIFT + I, 100 Front, fishing bobber<br>
			- Scan 3: SHIFT + O, 360 10 fast, usable objects<br>
			- Scan 4: SHIFT + P, 360 10 fast, lootable corpse, skinnable corpse<br>
			- Scan 5: CONTROL + SHIFT + U, 360 30 fast, herb, mining nodes<br>
			- Scan 6: CONTROL + SHIFT + O, 360 30 fast, usable objects<br>
			- Scan 7: CONTROL + SHIFT + P, 360 30 fast, lootable corpse, skinnable corpse<br>
			- Scan 8: CONTROL + SHIFT + I, 360 30 accurate, any<br>
	Details on the scans:<br>
		Each scan (1-8) consists of a specific scan type and a list of objects it is scanning for.<br>
		You can assign or adjust any combination of scan type and object(s) to each of those 8 scans. To do that go to Core > Scan settings and to the specific scan (1-8).<br>
		There are 5 different scan types to choose from. They differ in scan range, accuracy and speed.
			- Scan type 1: 100 front - 100 degrees in front of you, 5-45 meters range, takes up to 22 seconds. Used for fishing.<br>
			- Scan type 2: 360 10, fast - 360 degrees around you, 0-10 meters, takes up to 10 seconds. Used for usual quick scanning of objects near you.<br>
			- Scan type 3: 360 30, fast - 360 degrees around you, 3-30 meters, takes up to 15 seconds. Used for usual quick scanning of objects in up to 30 meters range.<br>
			- Scan type 4: 360 10, accurate - 360 degrees degrees around you, 0-10 meters, takes up to 15 seconds. The more accurate version of scan type 2, if you can't find an object with scan 2.<br>
			- Scan type 5: 360 30, accurate - 360 degrees degrees around you, 3-30 meters, takes up 28 seconds. The more accurate version of scan type 3, if you can't find an object with scan 3.<br>
		And there are 12 different object types you can choose to scan for:<br>
			- corpse lootable: any corpse that is lootable<br>
			- corpse skinnable: any corpse that is skinnable<br>
			- corpse not lootable: any corpse that is NOT lootable<br>
			- any creature: any creature (mob, npc, player, etc.)<br>
			- quest object: any object in the game world that is required for any of your current quests<br>
			- herb: any herb for herbalism (only herbs are considered that are set to On under Core > Options > Resource scanning > Herbs)<br>
			- vein: any mining node (only mining nodes are considered that are set to On under Core > Options > Resource scanning > Mining nodes)<br>
			- bobber: the fishing bobber<br>
			- usable object: any object that is usable/clickable (for example a mailbox)<br>
			- any object: any object in the game world<br>
			- target creature: the creature your are currently targeting (mob, npc, player, etc.)<br>
			- any: any object in the game world<br>
		Just go to Core > Scan settings and to the scan (1-8) you would like to configure/adjust. Then select a new scan type and/or add/remove object categories, to adjust that scan.<br>
	Helpful information on scanning:<br>
		Some "objects" don't count as objects. Examples are mage portals, meeting stones, dungeon portals. To find them, use a scan that is scanning for "any". (default: scan 8, Control + Shift + I)<br>
		Scanning is turning the camera. That is working perfect on flat terrain. It can be problematic if there slopes, in buildings, etc. If a fast scan isn't detecting an object, just try an accurate scan.<br>
		It can also be difficult if objects are covered by other objects (like mobs or players). Or if there are several objects at the same place (like 2 or 3 corpses almost at the same position).<br>
		Small objects can be easily overlooked by fast scans. Set up scans to use an "accurate" scan type (4 or 5) to find those objects.<br>
		Scanning can fail in some cases. Then the camera is turning slightly to far. If you do a scan, and there is an object, but nothing happens with Shift + G, just retry the scan.<br>
		Scanning is finding a mob or object at the position where it is right now. If a mob is moving, then it naturally will move away from the mouse cursor if you don't press Shift + G as fast as possible on finding it.<br>
		If you are continuing a scan, then only the first object of each type will be found, as the addon can't differentiate between more objects of the same type. This only applies to objects. Not to corpses, mobs, etc.<br>
		If you would like to choose a new key binding for a specific scan, go to Core > Sku key binds > Bind key and filter for "scan".<br>
		To change the sound on scanning go to Core > Options > Scan Background Sound<br>

- Numpad 7 and numpad 8 are still available with their old functionality. But Numpad 9 isn't available anymore, as it is used for the auto turn towards the current beacon feature.
- The old alternative "mouse click" key binds for Numpad 7-9 (CONTROL + SHIFT + I/O/P) are not longer working, as they are now assigned to scans.

- New feature: Items in the character menu (C) and the bags manu (B) now have an additional submenu "Socketing" to open the socketing panel for that item. The socketing panel will be shown under Local, like all other panels.<br>
	Workflow for socketing: <br>
		- Pick up the gem that should be placed in some socket from your bag with left click. Then the gem is attached to the cursor.<br>
		- Open the character panel or bags, get to the relevant item and choose Socketing.<br>
		- Go left to the Local menu level. Get to Local > Socketing.<br>
		- Find the intended socket for the gem and do a left click to place the gem at the cursor in that socket.<br>
		- Go down to Socket Gems and do a left click to finally socket the new gem.<br>

- Moved the All Bags menu entry in the bags menu below the single bags, to provide the option to jump to the single bags with the 1-5 keys. If you would like to get to All Bags with arrowing down, just press the A key, to jump to the first menu entry that starts with A (All Bags).

- The key binding menu (Core > Game key binds) now provides a warning if you are trying to bind a key that already is bound to some other action. <br>
	You then can either press a new key to make a new choice, or again press the already bound key, to confirm the re-binding of that already bound key.<br>
	In the later case the already bound key will be rebound to the new action and the previously bound action will be unbound.
- Removed the second (alternative) key for a binding from the key bind lists, as it does not provide any value.
- Key bindings F7-F12 are now as default (for new players or on reset) assigned to the action buttons 7-12 of the left additional action bar instead to the right additional action bar buttons 1-6.

- The setting to add the item quality color like grey, green, blue is now enabled as default for new players/profiles. (Core > Options > Item settings > Show item quality)
- Added an option to the external SkuFluegel addon for sighted players to remotely set you on unfollow. That will only work if you have this update installed.
- Fixed a bug with the panic mode. It is working again. Happy panicking.
- Fixed a bug with the minimap scan that was breaking the "mouse over" notification on first use of the scan.
- Fixed a bug with Escape to cancel the key binding process.
- Fixed a bug with the overview page that was releated to the guild members list.
- Fixed a bug with missing pet action bar in Core > Action bars.

### Mapping: 
- changed Add small waypoint from CTRL + SHIFT + P to ALT + P
- changed Add large waypoint from CTRL + SHIFT + O to ALT + O
- changed Show routes on minmap from CTRL + SHIFT + L to ALT + L
- changed Show sku minmap from CTRL + SHIFT + K to ALT + K

## Changes in Sku Script (wow_menu) r2.12
- Numpad 9 has been changed. It now is turning your character towards the current beacon.<br>
The I key is an alternative key bind for numpad 9.
- Control + Shift + I / O / P have been removed as alternative keys for numpad 7, 8, 9.


## Changes in SkuFluegel r5.7
 - CAUTION: Blind players need to use Sku r27.15 to have the new features working!
 - There is a new key bind CTRL + SHIFT + V to remotely set blind players on unfollow. 
 - It now is possible to set all blind players or a specific blind player on follow/unfollow. If you are targeting a blind player, then only that player will be set on follow/unfollow. If you are targeting nothing, or something else than one of the blind players (tracked targets 1-4), then all blind players will follow/unfollow.	
 - The status will now update instantly.
 - Fixed a bug with the C status (casting). Sometimes that status wasn't updated correctly. It still can happen, if the blind player is starting a cast and stopps that cast instantly.

## Changes in Sku Script (wow_menu) r2.10
- Added a "Delete character" menu option. 
	The character in the currently selected slot will be deleted. 
	All characters below the deleted character will be moved one slot up.
- Added a voice output to script termination.
- Fixed a bug with unusual portrait screen resolutions like 1250 x 1440 (width/height ratio <1). Script should now recognize login mode with those resolutions.


## Changes in Sku r27.14

### Local
- "all bags" menu added to bags menu by SamKacer. Lists all items alphabetically, with newly acquired items on top and flagged with the term "new".

### Core
- Fixed a bug with the minimap scan that caused errors on starting combat.

## Changes in Sku r27.13

### Options
- The menu is now playing a dedicated sound if you go on the first menu entry up or on the last down, to indicate that the current entry is the first/last one in a list.

### Navigation
- Fixed an issue that caused map data not being updated on new addon releases in specific scenarios.

### Quest
- Fixed an issues with Quests > starts in zone.

## Changes in Sku r27.12

### Core
- New feature: Scanning for herbs and mineral veins<br>
	If you have mining and/or herbalism, then you have the Find Herbs/Find Minerals skills/spells. On enabeling those, nearby spawns of herbs/mineral veins will appear on the minimap, if you're getting close to them. "Close" can be something between 60 and 140 meters.<br>
	There are two new shortcuts to let the addon automatically scan and find those herbs and mineral veins on the minimap, and output the results:<br>
	- CTRL + SHIFT + R: do a 50 meters range scan around your position
	- CTRL + SHIFT + F: do a 140 meters range scan around your position
	
	As long as the check is running there is a sound.<br>
	The check can only done out of combat. It is automatically stopped if you get in combat during check.<br>
	The 50 meters range takes <1 second. The 140 meters range takes 4 seconds.<br>
	The addon will voice output all found ressource types.<br>
	Caution: Please don't hold Control durching the check. That will lead to empty results! (The scan is based on the game tooltip, and that is cleared while you hold Control.)<br>
	There are new options to control the herb/mineral vein types that the scan is detecting: Core > Options > Ressource Scan<br>
	There you can enable all different herb/mineral vein node types. As default all herbs and nodes are enabled.
- Fixed a bug in the key bind menu. Missing bind options (like B for Toggle Backpack) should now be availabe.
- The pet action bar is available for configuration (Core > Action bars).<br>
	You can't remove the six default pet control actions (aggressive, passive, defensive and attack, wait follow). But you can move those actions to other action buttons.<br>
	That means, there are only up to 4 action buttons left for special pet spells. (Pet bar has 10 slots.)<br>
	If you are trying to remove the default control action, they will be automatically set to the bar again.
- Fixed an issue with auction house scanning on high populated servers. Scan process should not get stuck anymore.
- Limited the amount of auction house history price data that is recorded.<br>
	Unlimited storage of history data is most probably the reason for unexpected resets of all addon settings.<br>
	The addon now stores a maximum of 1.5M price data records. If there are more records, then the oldest records are deleted.
- The addon isn't doing automatic auction house full scans anymore.<br>
	Previously there was a full scan on opening the auction house, if a full scan was possible (only once every 15 minutes). That feature is removed, as is leads to issues on high populated servers (with a lot of auctions).<br>
	Now full scans need to be triggered manually via the Update offline database option in the auction house menu.<br>
	The offline database in the auction house menu and the price history data in item tooltips are based on those full scan data. If you don't manually trigger full scans, it won't be populated/updated. So, if you are using the offline database and/or the price history data, and if you would like to have up-to-date data, then you regulary need to use the Update offline database option.
- Fixed a missing translation in action house bid workflow.
- Fixed the bid/buy workflow for multiple actions to (hopefully) prevent the addon from bidding/buying incorrect auctions.

### Navigation
- Added the terms "herbalism" and "mining" to waypoint names for herbs and mineral veins for easier filtering.
- Changed the key binds to open the visual route data maps, to avoid unintenional use.<br>
	CTRL + SHIFT + F changed to CTRL + SHIFT + K <br>
	CTRL + SHIFT + R changed to CTRL + SHIFT + L

### Map
- Fixed another bug with the translation of route data. There shouldn't be any more broken routes.
- Fixed missing routes in Ghostlands.
- Added more routes all over the world.

### Quest
- Fixed the warlock Incubus quests (Devourer of Souls quest chain).
- Fixed quest log errors in dungeons.
		
## Changes in Sku r27.11

### Core
- Added the ready check frame to the interact frames list. Ready checks now should open the Local menu.
- Pet health is now displayed below player mana in general section.
- Pet details added to the bottom of overview page.
- Pet happiness is not more announced when the player is dead
- Pet happiness is announced ASAP if it has increased
- Pet happiness is announced once a minute when not happy.

### Quest
- Fixed a bug with quest target waypoints for areas or positions.

### Options
- Added difficulty colors to Crafting frame (Enchanting).
- Fixed Page-Down/Up buttons for scrolling in class and profession trainer lists. Should work now.

### Map
- Added comments and new waypoints to routes for aldor/Scryer rise (silent elevator). 
	Take the elevator up. To get down you need to take another way. Don't take the elevator. Find the waypoint named "aldor/Scryer...to down". Then follow the instructions.
- Fixed the broken route to Captain Keelhaul and Fleet Master Fireallon.
- Fixed a waypoint translation issue with Weapon Container objects.
- Added a waypoints for the shaman quest to ashenvale.
- Added some routes to southern ashenvale.
- Added a waypoint to the moonwell in ashenvale.

## Changes in Sku r27.10

### Quest
- Fixed german translations for "Accepted Quest" and "Available Quest" in quest dialogs.

### Options
- Fixed the slow response for Blizzard TTS output (overview, tooltips, etc.)

## Changes in Sku r27.9

### Core
- Fixed a bug with the "Create all" button in the profession menu.
- Fixed a bug with the list of recipes that sometimes showed recipes from other professions. 
- Added the PageDown and PageUp buttons to the class trainer panel, to scroll down/up in the list of available skills.

### Quest
- Added a load of waypoints and quest targets to quests that require to get to some specific area or position.

### Options
- Fixed a bug where the menu was opened after combat if the overview page (shift down) was used in combat.
- Fixed a bug with Sku TTS in menus and (partly) lost output of menu strings.

### Maps
- Mac has completed the mapping for Darkshore. Routes are not fully tested yet.
- Fixed an issue with missing/broken routes in english maps that was caused by hares, rabbits, snow bunnys and snowshoe rabbits.
- Added waypoints for forges in Booty Bay, Stormwind, and Ironforge.
- Added Neeru Fireblade as a quest target to Hidden Enemies.
- Fixed the route to Clopper Wizbang in Bloodmyst Isle.
- Tried to fix the route for Tree's Company to Geezle in Azuremyst Isle. Not sure if that worked. Needs to be veryfied.
- Added a route to Need for a Cure in Durotar.
- Added some more routes to weapon containers in quel'danas
- Added route to follow Prospector Anvilward after talking to him.
- Added a waypoint for Murkdeep in Darkshore.
		
## Changes in Sku r27.8

### Core
- All profession menus are overhauled and manually created, with reagents, colors for receipe level, etc.


## Changes in Sku Script (wow_menu) r2.9

- Changed the alternative key binds for the numpad 7-9 from Shift to Ctrl + Shift, because just Shift is interfering with chat inputs:<br>
	Control + Shift + I for numpad 7<br>
	Control + Shift + O for numpad 8<br>
	Control + Shift + P for numpad 9

## Changes in Sku r27.7

### Core
- The auto bid price for new actions was adjusted from 50% to 90% of your selected buyout price.

### Navigation
- New feature by Talon: 
	There are two new options to select beacons sounds: Navigation > Options > Sound for small beacons / Sound for large beacons.<br>
	On changing those options the new beacon sound will be played for one second.<br>
	The available beacon sounds depend on what additional sound set addons are installed. As default there are only 4 base sounds from the SkuBeaconSoundsets addon.<br>
	The additional addons SkuCustomBeaconsEssential 0.1 and SkuCustomBeaconsAdditional 0.1 (via the regular Sku download page) from Talon add more sounds sets. Install those two addons as usual, and there are more beacon sounds available.

### Quests
- Fixed the quest target for "Plundering the Plunderers".

### Maps
- Updated the route from Menethil to Loch Modan. Low level characters (level 10+) who need to get to Loch Modan or Westfall to continue leveling, shouldn't die at all, or at least only one time. Of course only if you are navigating precisely. As usual. :)
- Updated the rescue route in Booty Bay. You still need to navigate very precisely to get out of the water.

## Changes in Sku Script (wow_menu) r2.8

- Added alternative key binds for the numpad 7-9 feature:<br>
	Shift + I for numpad 7<br>
	Shift + O for numpad 8<br>
	Shift + P for numpad 9
- Fixed an issue with switching servers and 1024x768 resolution

## Changes in Sku r27.6
	
### Core
- New feature by Samalam: tooltips in bags are now showing the currently equiped item(s) in a new section under the bag item.
- Fixed an issue with merchants and page 2.

### Navigation
- Added some routes to different zones.
- Fixed route to warlock level 30 quest in 1k needles.
- Fixed a route in Westfall to avoid Dust Devil.

## Changes in release 27.5

### Core
- Fixed an issue with item comparison in tooltips and bag slot items.
- Fixed another issue with quest dialogs.
- Fixed an issue with creating auctions.
- Christoph fixed an issue with empty waypoint comments.

## Changes in Sku r27.4

### Navigation
- Fixed the missing waypoint to Sunken Chest.

### Core
- Added a "Cancel" option to the submenus of your current auctions in Core > Auction house > Sales
- Fixed a bug with bags and auction data.
- Fixed a (taint) issu that caused errors on switching stance in combat.

### Quest
- Fixed a but with not responding quest menu on interacting with npcs.

## Changes in Sku r27.3

### Core
- Fixed the missing Left click option for choosing quest rewards.
- Fixed a bug with current auction house price data in item tooltips. Current price data now should be shown, if there was at least one full scan completed in the current session (login or reload).
- The average price in auction house tooltip data now is the Median value (instead of just the average, as before). The median is more robust against outliers (scam auctions with extreme high buy out prices). Thus the average value now is a realistic and usefull value.
- The highest price in auction house tooltip data now ignores any auctions with prices > 10 times the median value. That should limit the highest price on auctions that are non-scam, and make that value usable.
- Full scan starts and ends (every 15 minutes) on auction house open are now announced in voice and chat.
- Fixed a but with vendor price in tooltips, where the vendor price line was shown multiple times.

### Navigation
- For map editors only: fixed a bug with showing the additional Minimap.
		
## Changes in Sku 27.2

### Navigation
- Samalam contributed a new feature to have visited waypoints flagged as "visited" in waypoint lists. Thanks a million! :)<br>
	The feature is intended for farming stuff (killing mobs of a specific type, or collecting/gathering objects). It is enabled as default. <br>
	On reaching a waypoint (via routes or just waypoint navigation) it internally flags that waypoint as "visited" for 5 minutes.<br>
	Visited waypoints have the word "visited" added in all waypoint lists.<br>
	There are two options to control the feature: Navigation > Options > Track whether waypoints were visited and Visited automatically expires after.<br>
	And there is a new menu entry to instantly clear all "visited" flags on request: Navigation > Waypoints > Clear visited.
- The "By name" lists for Waypoints and routes were removed. There are only the default "By distance" lists left, as apparently no one was using "By name" at all. :)
- There is a new option Navigation > Options > Show herb and mining node waypoints. Default: Off
- Fixed an issue with hearthstone on active route navigation.

### Core
- There are now audio outputs for Breath (on diving), Feign Death (hunter), and Exhaustion (on leaving the world boundaries).<br>
	The spoken numbers are percent values. Example: "Breath 25" means, there is 25% breath left, before you start drowning.
- Texts from books, letters, etc. in your bags are now readable using right click. The text will be shown via the Local menu.
- Manually implemented the NPC dialog menu (that is the one that every NPC opens if he provides more than one option, like multiple quests, quests and vendor, etc.)<br>
	The audio menu for Dialog is now much clearer and in the correct order, without any mysterious and complex "sub sections", "containers" etc.
- Manually implemented all quest dialog menus (select, accept, progress, complete). Should be much more user friendly now.
- Removed the categories "Quest Items" and "WoW Token (China Only)" from the auction house list.
- Fixed an issue with bags that occured on opening the bags without using the audio menu at least once in the current session.
- Fixed an issue with the mailbox and letters from auction house.

### Quest
- Fixed an issue with the quest log in Orgrimmar.

### Chat
- Fixed an issue with Chat > Options > TTS pause tags. Should now work as expected if set to Off.

### Options
- There is a new line with the vendor price in item tooltips (below the action house price data).
- Fixed issues with unwanted outputs and/or missing outputs via Blizzard TTS in menus.
- Fixed an issue with missing "period period period" output for long texts in menu via the Blizzard TTS.

### Maps
- Added more waypoints to the caves in Stonesplinter Valley.
- Added waypoint comments to portals in Darnassus and Rut'theran.
- Added routes to quest targets in moonglade lake.
- Added a route for the alliance druid class quest (poison) in darkshore.

## Changes in Sku 27

### Options
- All tooltips are now read by the Blizzard TTS, no matter if you have enabled the "Use Blizzard TTS for audio menu" option or not.
- There is a new key for showing/reading tooltips: SHIFT + PAGE DOWN
	SHIFT + PAGE DOWN starts automatically reading the full tooltip from the current line without having to hold down the SHIFT key or arrowing down to the next line.<br>
	You can use SHIFT + PAGE DOWN at any place with a tooltip to have it opened and read from the first line.<br>
	Or you could use SHIFT (hold) + DOWN as before, arrowing down through tooltip lines and use SHIFT + PAGE DOWN at any line to start auto reading from that line.<br>
	If the auto read mode is active, then you can use SHIFT (hold) + UP/DOWN at any point to stop the auto read and manually go through the lines as usual.<br>
	Or you can just use SHIFT + PAGE DOWN again to stop the auto-read.
- Changed the keybind for spelling out the current menu entry from SHIFT + RIGHT to CTRL + RIGHT.
- Fixed an issue with reputation at Exalted/Hostile on the overview page.
- The audio menu will not longer speak speak menu numbers for bag items, as the bag items have their own numbering. (Avoiding that irritating "1 1 <itemname>" spam.)
- Fixed a bug with background sound (spooky whale song) on open Game Menu.
- Added a new slash command "/sku version" to output the version number of the installed sku addon in the chat.

### Adventure Guide
- This is a new main menu entry (SHIFT + F1, then DOWN to Adventure Guide). It is intended to provide additional/complementary information, that is not directly related to actual gameplay.<br>
  For now there is only a wiki with a lot of articles from wowpedia.com, providing more information and context on the game world. <br>
  Other planned, but not yet implemented, features are: a browsable history/log of all of your activities in the game, and our FAQ ingame.<br>
  There is a new key bind, to access the Link History (see below): SHIFT + F4
- The wiki and links to wiki articles in tooltips:
	- Wiki articles:
		You will find a list of available wiki articles under Adventure Guide > Wiki > All articles. There are almost 16k articles for english and almost 4k german articles.<br>
		Just go to the list, and arrow down to see the available articles. Or, probably better, as there are a _lot_ of articles, filter the list as usual.<br>
		The actual article for each entry can be read via its tooltip. You can use all common tooltip features (SHIFT + UP/DOWN to get to the next line, CTRL + SHIFT for sections, etc.) - including the new SHIFT + PAGE DOWN feature to read the full tooltip without holding the shift key.<br>
		The content of the articles was auto-imported from wowpedia.com. There was an automatic clean-up on the wiki content, to remove everything that can't be shown/read (like tables, images, videos, etc.). That automatic clean-up should have removed most parts that can't be read in our tooltips. However, there can be things left. Like HTML tags, external URLs and more. That is expected and shouldn't happen much. If you find articles that can't be read due to a lot of clutter, please report them.<br>
		Most of the content provides details on the game you are playing. But it virtually could be anything. Even on external stuff like the WoW trading card game or trivia or whatever. It's just what the wiki had. There was no human review.<br>
		It even could be that there are some wiki articles that are related to later Warcraft addons (like the upcoming Lich King).<br>
		Wiki articles can have any size - from a single line to many hundreds of lines.
	- Links in wiki articles:
		As with any wiki the articles have lot of links, referencing other articles. If you are reading an article, the TTS will list all links in the current line at the end of that line.<br>
		It will say "Links: x, y, z...".<br>
		You then can use the new key binds SHIFT + RIGHT and SHIFT + LEFT to scroll through the links in the current line.<br>
		If you would like to follow a link, then select the link with SHIFT RIGHT/LEFT and then, on the link, press the new key bind SHIFT + ENTER. That instantly loads the linked article to the tooltip.<br>
		Then just read the new article in the tooltip as usual.<br>
		If you would like to get back to the previous article, you can use the new key bind SHIFT + BACKSPACE. That loads the previous article to the tooltip.<br>
		Tip: You don't have to wait until the current line is fully read to access the links. You can use SHIFT + LEFT/RIGHT at any point to select the links of that line. Even if the TTS still is reading.
	- Links in other parts of the game:
		As the main idea of the wiki was to provide you more context on the game while you're playing, from now on every term that has an article will be linked to the wiki article.<br>
		All tooltip texts in the game are continously parsed on terms with wiki articles. If there is such a term, you will find the link listed in the tooltip.<br>
		That applies to all tooltips. Items in your bags, items at vendors, text on the overview page, etc. Just to every text that is shown by Sku.<br>
		It also applies to every audio output that is played by the sku addon. No matter if it is an area name on entering a new area, or a mob name on targeting that mob, or what ever.<br>
		If the addon recognizes a wiki term in such outputs, it plays a sound and adds that term to a list of recent seen links.<br>
		You will find that list under Adventure Guide > Wiki > Link history. It has all recently seen terms with wiki articles. The most recent term is at the top of the list. The oldest at the bottom.<br>
		Just open the tooltip of an entry in the link history list to read the wiki article.<br>
		Some additionl details on links:
			- The addon plays an audio notification on every linked term in outputs. But only once for each new term. The second time that a term appears somethere, it will be added to the link history list, but there won't be the link sound. The list of those "seen" links (no sound) is account wide (not just per character).
			- The sound on links can be changed or even silenced: Adventure Guide > Options > Link History > Sound on new link in history.
			- You can disable the announcement of links at the end of tooltip lines: Adventure Guide > Options > Links > List links in tooltips. The links are still be available, but the addon won't auto-read them anymore.
			- If you are using the new auto-read feature for tooltips (SHIFT + PAGE DOWN), then the addon never reads links at the end of the a line. But the links are still there and can be used.
			- There are more options. For example to use the link sound in tooltip lines, instead of having the addon read the word "Links".					
### Navigation
- New waypoint and map data added for DE and EN (V23, 2022-05-01).
- Fixed an issue with missing waypoints in "The Wailing Caverns".
- Fixed an issue with broken routes in English data (due to incorrect translated waypoint names). Example: Jasperload Mine - should now be attached to the routes network.
- Fixed an issue with broken routes that are connected to any Enchanting Supplier in English data. Example: route to shaman trainer in Exodar.

### Chat
- All options to automatically read chat messages for different channels have been moved into a new submenu: Chat > Options > Auto read.<br>Due to that all your current settings for those options are resetted to their defaults. (That is On for all of them.)
- Added two new options to "Auto read": Raid chat and Raid Warning Chat. Both are On as default.
- Fixed a bug with option "Automatically read SkuChat channel" if you manually joined the SkuChat channel.
- New option "Chat > Options > TTS pause tags" (default: on). That option is to disable invisible (internal) "pause" and "pitch" tags (SAML) in TTS outputs.<br>If you set that to Off, then the addon will play all TTS outputs without those tags. The effect will be minimal, as there are not that many strings containing a dedicated pause (prices in Auction house would be an example).<br>The second use is if you're using the NVDA voice via Sapi. Set the option to Off, to have those tags (pitch, silence) removed, to avoid that NVDA is speaking them.

### Core
- The addon now speaks the names of players and their pets via the Blizzard TTS. (Instead of the general "friendly player", etc. placeholders.)<br>As it is not possible to integreate the Blizzard TTS into the TTS queue of the Sku addon, that output will be in parallel to all other outputs. There is not way to avoid that.
- Fixed an issue with the missing removal of greeting audio on targeting NPCs in the English version.<br>Actually everything those NPCs are saying to greet you should be silenced, as the audio menu will get active at the same time, and it is difficult to follow that if both outputs are played simultaniously. <br>That was not working and now should work. You won't hear such greetings anymore.
- Added a new option Core > Options > Play NPC greetings to disable the removal of NPC greetings and have them played. Default: Off

### Core
- There is a new option for bag items. Each bag item has an additional sub menu "Split" to split items stacks. (Only available if the item amount is > 1)
<br>Go to "Split", go to the submenu of Split and select the amount of items to split from that stack. 
<br>The splitted items will be added to the mouse cursor. Then go to an empty bag slot, and select Left Click there, to place the splitted items in that empty slot.
- It is now possible to send less than 1 gold via mail. There are new numbers in the list for the amount of gold to send. Those are:
<br>0.01 to 0.09 (gold) - that is 1 silver to 9 silver
<br>0.1 to 0.9 (gold) - that is 10 silver to 90 silver
- There is a new option "Core > Options > Item settings > Show item quality". The default value is Off. With that option set to On there will be the quality of an item added to every item name in lists, tooltips, etc.
<br>Example: "Robes of the Lich (Rare)". The item quality levels are: Poor (grey), Common (white), Uncommon (green), Rare (blue), Epic (pink). 
- The options "Auto sell junk at vendors" and "Auto repair at vendors" under "Core > Options" have been moved to the new submenu "Core > Options > Item settings".
<br>Thus those two settings are resetted to their default values (On for both). If you had set them to Off, you need to do that again.

### Sku Minimap - only for route/waypoint editors (not relevant for players): 
- Adjusted the waypoint size of the Sku MM on zooming in/out.


## Changes in Sku 26.2

### Navigation
- Fixed an issue that lead to incorrect compass directions with "Show global direction in waypoint lists" enabled in some regions.

### DB
- Added coordinates to npc Lillith Nefara in Tirisfal Glades.
- Added a Start to the Quest Demon Scarred Cloak. (Not that useful, as that creature is wandering around.)

### Quest
- Fixed a bug with quest start/target/end for objects and items that are on other continents (example: "Until Death Do Us Part", starts in Kalimdor, ends in Eastern Kingdoms). List was shown as Empty. Now there is an entry, letting you know the continent and zone name. You can't navigate there, tough, as one can't directly navigate from one continent to another. But you at least know what continent you need to  go to use a route to that waypoint.

### Core
- Fixed CTRL + SHIFT + T to read tooltips of items you're currently rolling on.
- Fixed missing en translations for "On" and "Off" for "Usable only" in action filters.
- Fixed a bug with popup windows (like someone is inviting you to a group or guild). The addon was always selecting "Accept", not matter if you did a left click on "Accept" or "Decline". Now "Decline" is working as intended.
- New option: "Auto sell junk at vendors" (default: On)
- New option: "Auto repair at vendors" (default: On)

## Changes in release 26.1

### SkuOptions
- The "Use Blizzard TTS for audio menu" should now respect the settings from "Chat > Options > TTS voice" and "> TTS speed".

### SkuMob
- Removed all outputs for players with "Announce player controled units with generic descriptions" set to Off.
- Removed the in-combat-sound for player controlled units.

## Changes in Sku 26

### SkuOptions
- New option: SkuOptions > Options > Use Blizzard TTS for audio menu. The default value is Off.<br>
With that option the audio menu will use the Blizzard TTS engine for everything, instead of the usual custom Sku TTS engine. (Using settings in "Chat > Options > TTS voice and TTS speed".)<br>
Please enable the new option, and test that carefully. Feedback on how useful that is would be appreciated. If it turns out to be better, I could set that option to On as default.
- I've changed the names of the top level menu items and removed the "Sku" part from each name. The new menu item names are: Navigation, Mob, Chat, Quest, Core, Auras, Options, Local<br>
  Because of that names change, all menu shortcuts (Shift + F9-F12) are resetted to their defaults. If you had other menu items assigned to those shortcuts, you need to do that again.
- Added the realm/server name to the line with the player name on the overview page.

### SkuQuest
- Fixed a bug with available quests for Undead characters. The list shouldn't be empty anymore.

### SkuAuras
- Fixed an issue with "item use"/"item count" and "output once". Should work as expected now.

### SkuNav
- Fixed an issue with english localization of mailboxes. All mailboxes should now be available in waypoint and route lists.

### SkuChat
- New option: while reading the chat you now can use Arrow Right to to tell/whisper the sender of the current chat line. You don't need to type the recipients name. Just press Arrow Right on any chat line and start typing your message + Enter to send. This feature needs to be tested carefully!
- Fixed an issue with the click sound at the end of audio messages via the Blizzard TTS. If you've disabled that, it won't get re-enabled on reload/login anymore.

### SkuMob
- New option SkuMob > Options > Announce player controled units with generic descriptions. The default value is On. With this option set to Off the addon won't speak generic descriptions for players. (Example: "friendly player" on targeting a friendly player.)
- New option SkuMob > Options > Repeat target markers on units. The default value is Off. With that option set to On each raid target marker will be repeated. (Example: "Skull, Skull, Level 60")

### SkuAuras
- Added more number values to the "Item count" attribute (110, 120, 130, 140, 150, 200, 300, 400, 500).

## Changes in release 25.16

### SkuQuest
- Another bug fix for the list of available quests.

## Changes in release 25.15

### SkuChat
- New option "SkuChat > Options > Audio Setting > Audio notification on the end of chat messages". Contributed by chpross. Thanks a lot! :)

### SkuQuest
- Fixed another bug with the list of available quests. Quests with multiple pre-quests, where only one of those pre-quests needs to be completed, are now correctly shown.

### SkuNav
- Added an option "Show global direction in waypoint lists" to "SkuNav > Options" (default: off). With that option enabled the global direction to the target will be added to all lists with waypoints or routes. (Example: "147 meter north Corrupted Scorpid...")
- Fixed the "Auto announce global direction". The outputs are not queued anymore and will play in parallel to the queued outputs.

### SkuOptions
- Added a new slash command /pquit to leave a group.


## Changes in release 25.14

### SkuQuest
- Fixed a bug with the filter for the available quests that lead to an empty quest list.

## Changes in release 25.13

### SkuQuest
- Event / seasonal / holiday quest are now filtered from the "Available Quests" list if the event isn't active.
- Fixed a bug with filtering the available quests by the players class and race.
- Stumbled upon a lot of AQ war efforts quests (not available anymore) and removed them from the quest db.

## Changes in release 25.12

### SkuCore
- Fixed a bug with the key ring in bags. (Don't care if you hadn't any issues with bags in r25.11)

## Changes in release 25.11

### SkuCore
- Fixed a bug with right click on items in bags.

## Changes in release 25.10

### SkuCore
- Added a new feature for collecting objects (like the well known cactus apples) via mouse click / numpad: The addon now outputs the objects name if the mouse cursor is over such an collectible object.
- The addon now is playing a background sound (whale song) if the game menu is open. That is, because the game menu easily can be opended unintentionally with Escape, and is blocking almost all other things. So, if you are suddenly hearing whales, press Escape to close that stupid game menu. :)
- The stable masters union strike has come to an end. All their demands were accepted. As a result, starting from today, hunters will get the pet and the pets poop in a plastic bag on unstabling a pet.
- Updated the bag menu. The bag menu now has much less confusing sub menus and buttons and is a lot clearer and easier to use.
- The bag menu now has an additional sub menu "Bags" to manage your bag-item slots. This is how to replace an existing bag:
	- Pick up the new bag-item from one of you bags with left click, to get that new bag-item to the cursor.
	- Go to "Bags" and to the target bag-item slot for that new bag-item.
	- Go right and do a left click, to place the new bag-item in the bag-item slot. The new bag-item and the existing bag-item will swap places.<br>
	Replacing bags will only work if the existing bag is empty or the new bag-item has at least the same number of item-slots.
- Items in bags now have an additional submenu "Destroy". CAUTION: The item will be destroyed without any additional confirmation!

### SkuNav
- On death and release the spirit the addon now starts a close route to your corpse (quick waypoint 4), instead of just selecting the quick waypoint 4.
- Fixed a bug in the English map data that caused some routes to be broken. Rabbits are the root of all evil. Trust me on this one! Just kill'em on sight!
- Map data updated for English and German (current version: V22Plus-21c-AlleKarten-2022-03-26)
	- Silverpine Forest: completed
	- Eversong Woods: completed
	- Barrens and Azuremyst Isle: fixes
- The default sound (for new characters) on entering/leaving the 5 degree range of beacons was changed from "click" to "beep".
- The default values (for new characters) for all range check distances and target type are now set to "vocalized".
- The range check now should be instantly triggered on every target change (even on mobs with same names). There's still that 45 seconds delay after login, where no range checks are available.
- Additionally to CTRL + SHIFT + F5-F8 to set the quick waypoints 1-4 to your own current position, you can now use CTRL + SHIFT + ALT + F5-F8 to set the quick waypoints to the position of your current target.<br>
  You can use that to navigate to party members. Just target the party member, use CTRL + SHIFT + ALT + F5 to set quick waypoint 1 to that party member, and the start a close route to quick waypoint 1.<br>
  That feature is only working if you're targeting party members, as the addon hasn't any access to the coordinates of non-party members.
- There is a new option: SkuNav > Options > Auto announce global direction (default: off). With that enabled the addon automatically is announcing the global direction if you're turning.

### SkuChat
- Added a sound for open/close of the chat input box.
- Added the new command /sc to write to the SkuChat channel (additionally to the existing /skuchat).

### SkuOptions
- Removed the option "SkuOptions > Options > Visual audio menu".

## Changes in Sku-Maus Skript (wow_menu) r2.7

- Follow the installation steps in the readme.txt file!
- Re-designed the script to be more reliable and much faster.
- The script stops auto switching between gaming/login mode if you do use ALT + F1 to manually switch the mode. You need to restart the script to turn auto switching on again.
- Changed the "script is processing" sound to something (water drop) that is better to hear is there's ingame music playing.
- The script now is replacing a lot of textures on login and char selection screens. If a sighted person asks why the UI looks that "broken", that is the reason. It's a feature, not a bug.

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

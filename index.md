If you are a first time user of the Sku addon, you need to follow the installation / setup instructions before installing updates from this page:<br>
ENGLISH - First Steps Guide:<br>
<a href="https://duugu.github.io/Sku/first_steps_en.html">https://duugu.github.io/Sku/first_steps_en.html</a><br>
DEUTSCH/GERMAN - Erste Schritte:<br>
<a href="https://duugu.github.io/Sku/first_steps_de.html">https://duugu.github.io/Sku/first_steps_de.html</a><br>

# Updates

*Recent updates:* <br>
[Sku r27.1](https://github.com/Duugu/Sku/releases/download/r27.1/Sku-r27.1-bcc.zip) (14.05.2022)<br>
[SkuAudioData ENGLISH r5](https://github.com/Duugu/SkuAudioData_en/releases/download/r5/SkuAudioData_en-r5-bcc.zip) (05.05.2022)<br>
[SkuAudioData DEUTSCH r32](https://github.com/Duugu/SkuAudioData/releases/download/r32/SkuAudioData-r32-bcc.zip) (05.05.2022)<br>

*Old updates:* <br>
[Sku-Maus Skript (wow_menu) r2.7](https://github.com/Duugu/wow_menu/releases/download/r2.7/wow_menu-r2.7-bcc.zip) (27.03.2022) FOLLOW THE INSTALLATION STEPS IN THE README.TXT!<br>
[SkuFluegel r5.5](https://github.com/Duugu/SkuFluegel/releases/download/r5.5/SkuFluegel-r5.5-bcc.zip) (09.03.2022) (addon for sighted players)<br>
[SkuBeaconSoundsets r19.7](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r19.7/SkuBeaconSoundsets-r19.7-bcc.zip) <br>
[BugGrabber + Bugsack](https://1drv.ms/u/s!Aqgp3J_s6MM7iKN7LiGYcuZzzTTdGw?e=c5c4c7) <br>

# Release notes

-------------------------------------------------------------------------------------------------------	
## Changes in release 27.1

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

## Changes in release 27

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


## Changes in release 26.2

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

## Changes in release 26

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

If you are a first time user of the Sku addon, you need to follow the installation / setup instructions before installing updates from this page:<br>
ENGLISH - First Steps Guide:<br>
<a href="https://duugu.github.io/Sku/first_steps_en.html">https://duugu.github.io/Sku/first_steps_en.html</a><br>
DEUTSCH/GERMAN - Erste Schritte:<br>
<a href="https://duugu.github.io/Sku/first_steps_de.html">https://duugu.github.io/Sku/first_steps_de.html</a><br>

# Updates

*Recent updates:* <br>
- **Sku for Wrath of the Lich King. Read the release notes below!** <br>
- [SkuMapper r1.1](https://github.com/Duugu/SkuMapper/releases/download/r1.1/SkuMapper-r1.1-wrath.zip) (Sep 13th, 2022, mapping addon for sighted players)
- [Sku r30.17](https://github.com/Duugu/Sku/releases/download/r30.17/Sku-r30.17-wrath.zip) (Sep 13th, 2022)<br>
- [wow_menu r3.6](https://github.com/Duugu/wow_menu/releases/download/r3.6/wow_menu-r3.6-wrath.zip) (Sep 10th, 2022)

*Older updates:* <br>
- [SkuFluegel r6](https://github.com/Duugu/SkuFluegel/releases/download/r6a/SkuFluegel-r6a-wrath.zip) (Sep 1st, 2022) (addon for sighted players)<br>

# Release notes

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

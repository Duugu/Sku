# Beta Updates

[SkuBeaconSoundsets r20](https://github.com/Duugu/SkuBeaconSoundsets/releases/download/r20/SkuBeaconSoundsets-r20-bcc.zip) <br>
[Sku r27.5-beta2](https://github.com/Duugu/Sku/releases/download/27.7-beta1/Sku-27.7-beta1-bcc.zip) (23.05.2022)<br>

# Release notes

## Changes in release 27.7-beta1

### Navigation
- New feature by Talon: 
	There are two new options to select beacons sounds: Navigation > Options > Sound for small beacons / Sound for large beacons.
	The available beacons sounds depend on what you have installed. As default there are 4 sounds.
	The additional addon SkuCustomBeacons from Talon provides more sounds.
	Download the SkuCustomBeacons addon here:
	Install the SkuCustomBeacons addon as usual, and you should find more beacon sounds under the two options.

## Changes in Sku 27.5-beta2

### Core
- Fixed an issue with item comparison in tooltips and bag slot items.
- Fixed another issue with quest dialogs.

## Changes in Sku 27.5-beta1
	
### Core
- New feature by Samalam: tooltips in bags are now showing the currently equiped item(s) in a new section under the bag item.

## Changes in Sku 27.3-beta2

### Core
- Fixed missing vendor price.
    
## Changes in Sku r27.3-beta1a

### Core
- Fixed the missing Left click option for choosing quest rewards.
- Fixed a bug with current auction house price data in item tooltips. Current price data now should be shown, if there was at least one full scan completed in the current session (login or reload).
- The average price in auction house tooltip data now is the Median value (instead of just the average, as before). The median is more robust against outliers (scam auctions with extreme high buy out prices). Thus the average value now is a realistic and usefull value.
- The highest price in auction house tooltip data now ignores any auctions with prices > 10 times the median value. That should limit the highest price on auctions that are non-scam, and make that value usable.
- Full scan starts and ends (every 15 minutes) on auction house open are now announced in voice and chat.
- Fixed a but with vendor price in tooltips, where the vendor price line was shown multiple times.

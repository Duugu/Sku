# Beta Updates

[Sku r27.3-beta1](https://github.com/Duugu/Sku/releases/download/r27.3-beta1/Sku-r27.3-beta1-bcc.zip) (15.05.2022)<br>

# Release notes

-------------------------------------------------------------------------------------------------------	

## Changes in Sku r27.3-beta1

### Core
- Fixed the missing Left click option for choosing quest rewards.
- Fixed a bug with current auction house price data in item tooltips. Current price data now should be shown, if there was at least one full scan completed in the current session (login or reload).
- The average price in auction house tooltip data now is the Median value (instead of just the average, as before). The median is more robust against outliers (scam auctions with extreme high buy out prices). Thus the average value now is a realistic and usefull value.
- The highest price in auction house tooltip data now ignores any auctions with prices > 10 times the median value. That should limit the highest price on auctions that are non-scam, and make that value usable.
- Full scan starts and ends (every 15 minutes) on auction house open are now announced in voice and chat.
- Fixed a but with vendor price in tooltips, where the vendor price line was shown multiple times.

local MODULE_NAME = "SkuOptions"
local L = Sku.L
local _G = _G


---------------------------------------------------------------------------------------------------------------------------------------
function TooltipLines_helper(...)
   local tQualityString = nil

	local itemName, ItemLink = _G["SkuScanningTooltip"]:GetItem()
	if not ItemLink then
		itemName, ItemLink = GameTooltip:GetItem()
	end
	if ItemLink then
      for x = 0, #ITEM_QUALITY_COLORS do
         local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
         if tItemCol == "ffa334ee" then 
            tItemCol = "ffa335ee"
         end
         if string.find(ItemLink, tItemCol) then
            if _G["ITEM_QUALITY"..x.."_DESC"] then
               tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
            end
         end
      end
   end

	local tHasTextFlag = false
	local rText = ""
   for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
            if tHasTextFlag == false and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
               rText = rText..text.." ("..tQualityString..")\r\n"
            else
				   rText = rText..text.."\r\n"
            end
				tHasTextFlag = true
			end
		end
	end
	return rText
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuSpairs(t, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then
		table.sort(keys, function(a,b) return order(t, a, b) end)
	else
		table.sort(keys)
	end
	local i = 0
	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---@param tbl table
---@param indent string
local function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		local formatting = string.rep("  ", indent)..k..": "
		if k == 'obj' then
			if v ~= nil then
				print(formatting.."<obj>")
			else
				print(formatting.."nil")
			end
		elseif k == 'func' then
			if v ~= nil then
				print(formatting.."<func>")
			else
				print(formatting.."nil")
			end
		elseif k == 'onActionFunc' then
			if v ~= nil then
				print(formatting.."<onActionFunc>")
			else
				print(formatting.."nil")
			end
		else
			if type(v) == "table" then
				print(formatting)
				tprint(v, indent+1)
			elseif type(v) == 'boolean' then
				print(formatting..tostring(v))      
			elseif type(v) == 'string' then
				print(formatting..string.gsub(v, "\r\n", " "))
			else
				print(formatting..v)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
--elevator timer test
function GetElTime()
	local guid    = UnitGUID("target")
	--local guid    = "Creature-0-4468-530-15-18922-0004A6D8E1"

	if not guid then
		return
  end

	local prefix  = string.match(guid, "^([CVP][^l][^-]+)")

	if not prefix then
		 return
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff)
		 --local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3)
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23)
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1)
		 end

		 --local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime)
		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 dprint("noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667))
		 
	end
end

function GTT_CreatureInspect(self)
	local _, unit = self:GetUnit();
	local guid    = UnitGUID(unit or "none");
	local prefix  = string.match(guid, "^([CVP][^l][^-]+)");

	if not guid or not prefix then
		 return;
	end

	if string.find(prefix, "^[CV]") then
		 local guidSpawnOffset  = bit.band(tonumber(string.sub(guid, -6), 16), 0x7fffff);
		 local guidSpawnIndex   = bit.rshift(bit.band(tonumber(string.sub(guid, -10, -6), 16), 0xffff8), 3);
		 local serverSpawnEpoch = GetServerTime() - (GetServerTime() % 2^23);
		 local guidSpawnTime    = serverSpawnEpoch + guidSpawnOffset;

		 if guidSpawnTime > GetServerTime() then
			  -- Correction for units that survived the last epoch.
			  guidSpawnTime = guidSpawnTime - ((2^23) - 1);
		 end

		 local guidSpawnDate = date("%Y-%m-%d %H:%M:%S", guidSpawnTime);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Date/Time", guidSpawnDate, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Time Data", string.format("%.6X", guidSpawnTime), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index Data", string.format("%.5X", guidSpawnIndex), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnOffset", guidSpawnOffset, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "serverSpawnEpoch", serverSpawnEpoch, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "guidSpawnTime", guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, GetServerTime(), (GetServerTime() % 2^23), NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "curr time", GetServerTime() - guidSpawnTime, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);

		 local timeSinceServerStart = GetServerTime() - guidSpawnTime

		 GameTooltip_AddColoredDoubleLine(self, "noch", timeSinceServerStart - (math.floor(timeSinceServerStart / 36.667) * 36.667) - 10, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 

		 
		 
	elseif prefix == "Pet" then
		 local guidPetUID     = string.sub(guid, -8);
		 local guidSpawnIndex = tonumber(string.sub(guid, -10, -9), 16);

		 GameTooltip_AddBlankLineToTooltip(self);
		 GameTooltip_AddColoredDoubleLine(self, "GUID", guid, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Pet UID", guidPetUID, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
		 GameTooltip_AddColoredDoubleLine(self, "Spawn Index", guidSpawnIndex, NORMAL_FONT_COLOR, HIGHLIGHT_FONT_COLOR);
	end
end

if not GTT_CreatureInspectHooked then
	GTT_CreatureInspectHooked = true;
	--GameTooltip:HookScript("OnTooltipSetUnit", function(...) return GTT_CreatureInspect(...); end);
end


---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- localization helpers
---------------------------------------------------------------------------------------------------------------------------------------
local tAdditionalTranslations = {
	--incorrect old translations from default waypoints
	["Aschenschwingens Bau"] = "Emberstrife's Den",
	["Hof der Stonefields"] = "The Stonefield Farm",
	["Sitz der Naaru"] = "Seat of the Naaru",
	["Mor'shan-Stützpunkt"] = "Mor'shan Base Camp",
	["Taverne Zum roten Raben"] = "Tavern \"The Red Raven\"",
	["Die alte Hafenbehörde"] = "The Old Port Authority",
	["Die Rustmaul-Grabungsstätte"] = "The Rustmaul Dig Site",
	["Die Stormrage Grabhügel"] = "Stormrage Barrow Dens",
	["Taverne zum salzigen Seemann"] = "Salty Sailor Tavern",
	["Die versiegelte Halle"] = "the sealed hall",
	["Außenposten der Silverwing"] = "Silverwing Outpost",
	["Helmsbedsee"] = "Helm's Bed Lake",
	["tal"] = "valley",
	["Die heißen Quellen von Frostfire"] = "Frostfire Hot Springs",
	["Das Grosh'gok Lager"] = "Grosh'gok Compound",
	["Stagalboghöhle"] = "Stagalbog Cave",
	["Marshals Zuflucht"] = "Marshal's Refuge",
	["vorgebirge von hillsbrad"] = "Hillsbrad Foothills",
	["Das Basislager von Grom'gol"] = "Grom'gol Base Camp",
	["Demonfall-Canyon"] = "Demon Fall Canyon",
	["Hauptstadt"] = "capital",
	["Ashenvale"] = "Ashenvale",
	["Zoram'gar-Außenposten"] = "Zoram'gar Outpost",
	["Tidefury-Bucht"] = "Tidefury Cove",
	["Die Höhlen des Wehklagens"] = "Wailing Caverns",
	["Der Dor'danil-Grabhügel"] = "The Dor'Danil Barrow Den",
	["Das Brachland"] = "The Barrens",
	["Der Elune'ara See"] = "Lake Elune'ara",
	["Vorgebirge von Hillsbrad"] = "Hillsbrad Foothills",
	["Stagalbog"] = "Stagalbog",
	["Holzschlundfeste"] = "Timbermaw Hold ",
	["Der Wildbend"] = "Wildbend River",
	["Tresor von Eisenschmiede"] = "Vault of Ironforge",
	["Prügel-Eiland"] = "Fray Island",
	["Der Steinkrallenpfad B"] = "Talondeep Path B",
	["Kavernen der Twilight"] = "Twilight's Run",
	["Scrabblescrews Lager"] = "Scrabblescrew's Camp",
	["Der Steinkrallenpfad A"] = "Talondeep Path A",
	["Das Coldridgetal"] = "Coldridge Valley",
	["Gastwirt Fizzgrimble"] = "Innkeeper Fizzgrimble",
	["Gastwirt Boorand Plainswind"] = "Innkeeper Boorand Plainswind",
	["Chillwind-Lager"] = "Chillwind Camp",
	["Verwüsteter Twilight-Stützpunkt"] = "Ravaged Twilight Camp",
	["Splintertreeposten"] = "Splintertree Post",
	["Terrorweb-Tunnel"] = "Terrorweb Tunnel",
	["Der Hafen von Menethil"] = "Menethil Harbor",
	["Mine der Venture Co,"] = "The Venture Co. Mine",
	["Thunder Bluff"] = "Thunder Bluff",
	["Twilight-Posten"] = "Twilight Post",
	["Firewatchgrat"] = "Firewatch Ridge",
	["Crushridgehöhle"] = "Crushridge Hold",
	["Fallenskysee"] = "Fallen Sky Lake",
	["Tore der Dragonmaw"] = "Dragonmaw Gates",
	["Steelgrills Depot"] = "Steelgrill's Depot",
	["Ironbands Truppenlager"] = "Ironband's Compound",
	["Hain der Silverwing"] = "Silverwing Grove",
	["Holzschlundfeste A"] = "Timbermaw Hold A",
	["Shadowsong-Schrein"] = "Shadowsong Shrine",
	["Gastwirt Firebrew"] = "Innkeeper Firebrew",
	["Lager der Warsongarbeiter"] = "Warsong Labor Camp",
	["Mannorocs Koven"] = "Mannoroc Coven",
	["Aldrassil A"] = "Aldrassil A",
	["OBJEKT"] = "OBJECT",
	["Schnellwegpunkt"] = "quick waypoint",
	["das brachland"] = "The Barrens",
	["Gol'Bolarmine"] = "Gol'Bolar Quarry",
	["Staghelms Stätte"] = "Staghelm Point",
	["Gastwirt Hearthstove"] = "Innkeeper Hearthstove",
	["Twilight-Außenposten"] = "Twilight Post",
	["Grabung eins"] = "dig site one",
	["Schrein von Remulos"] = "Shrine of Remulos",
	["Swamplight-Anwesen"] = "Swamplight Manor",
	["Klassentrainer"] = "class trainer",
	["Die Stonemaul Ruinen"] = "Stonemaul Ruins",
	["Das Laster"] = "The vice",
	["Der Mor'shan-Schutzwall"] = "The Mor'shan Rampart",
	["Wellspringsee"] = "Wellspring Lake",
	["Basislager der Twilight"] = "Twilight Base Camp",
	["Un'Goro-Krater"] = "Un'Goro Crater",
	["Gasthaus Zur Höhle des Löwen"] = "Lion's Pride Inn",
	["Lost-Rigger-Bucht"] = "Lost Rigger Cove",
	["Marschen von Dustwallow"] = "Dustwallow Marsh",
	["Mazthoril"] = "Mazthoril",
	["Südliche Bankenhalle"] = "South Common Hall",
	["Unbekannt"] = "unknown",
	["Postbox"] = "postbox",
	["Bronzebeards Lager"] = "Bronzebeard Encampment",
	["Gastwirt Skindle"] = "Innkeeper Skindle",
	--comments from route data
	["Achtung Trollwelpe"] = "Attention: troll whelp",-- [1]
	["Achtung, der Gastwirt läuft immer von der einen Seite zur anderen!"] = "Attention: the innkeeper walks from one side to the other!",-- [2]
	["Achtung der Questgeber bewegt sich. Allenfalls beim anderen Wegpunkt suchen!"] = "Attention: the quest giver is moving. Look at the other waypoint!",-- [3]
	["Hier auf das Schiff warten !"] = "Wait here for the ship!",-- [4]
	["Hier ist auch das Stammesfeuer!"] = "The tribal fire is here too!",-- [5]
	["Hier auf das Schiff warten !"] = "Wait here for the ship!",-- [6]
	["Achtung, der Weg zur Hauptroute führt an mehreren Bäumlingen Level 52 bis 53"] = "Attention: the path to the main route crosses several creatures Level 52 and 53",-- [7]
	["Kreuzung der Hauptstrasse und dem Weg zur Burg Stromgarde. ... Vorsicht vor dem Kurier der Verlassenen und seiner Leibwache"] = "Crossing of the main road and the path to Stromgarde Castle. Beware of the courier pat",-- [8]
	["Achtung: ab hier vorsichtig laufen!"] = "Attention: move carefully from here on!",-- [9]
	["Achtung: Dieser Questnpc bewegt sich!"] = "Attention: this quest npc is moving!",-- [10]
	["Hier tauchen !"] = "Dive here!",-- [11]
	["Beim nächsten Punkt warten !"] = "Wait at the next point!",-- [12]
	["Hier warten bis die Fahr zu Ende ist !!"] = "Wait here until the ride is over!",-- [13]
	["Von hier müsst ihr wirklich sehr weit nach Süden schwimmen, bis ein Aufgang/Rampe kommt."] = "From here you need to swim really far south until you get to a stairway/ramp.",-- [14]
	["Um den Schlüssel zu diesem Tor zu bekommen, musst du Margol töten und das Horn holen."] = "For getting the key to this gate you need to kill Margol and get the horn.",-- [15]
	["Achtung: Questgeber bewegt sich!"] = "Attention: Quest giver is moving!",-- [16]
	["Achtung: Questgeber bewegt sich!"] = "Attention: Quest giver is moving!",-- [17]
	["Achtung: Questgeber bewegt sich!"] = "Attention: Quest giver is moving!",-- [18]
	["Achtung: Läufer der Winterquell auf dem Weg!"] = "Attention: Creature crossing!",-- [19]
	["Hängebrücke Ende / Questzone"] = "bridge end / quest zone",-- [20]
	["Hier auf das Schiff warten !"] = "Wait here for the ship!",-- [22]
	["Hier auf den Zeppelin warten!"] = "Wait here for the zeppelin!",-- [23]
	["Gegenstand in Tasche mit rechts anklicken und dann Kristall mit links anklicken!"] = "Right click on item in your bag and then left click on crystal!",-- [24]
	["Fahrstuhl!"] = "Elevator!",-- [26]
	["Achtung, der Mob bewegt sich!"] = "Attention: the creature is moving!",-- [27]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [28]
	["Hier auf das Schiff warten!"] = "Wait here for the ship!",-- [29]
	["Hier auf den Aufzug warten !"] = "Wait here for the elevator!",-- [30]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [31]
	["Achtung hier links ist gleich ein Horde Posten mit Wachen."] = "Attention: on the left side is a horde output with guards.",-- [32]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [33]
	["Achtung: Nach Westen kommt die nächsten 2 Wegpunkte eine extrem schmale Brücke mit Abgrund."] = "Attention: To the west the next 2 waypoints on an very small bridge.",-- [34]
	["Brückenkopf Jägerlagerbrücke"] = "Bridgehead hunter camp bridge",-- [35]
	["Umleitung an der Horde vorbei, durch die Wildniss. Vorsicht vor Wildtieren. Ende/Anfang"] = "Detour, passing the horde camp, through the wilderness. Beware of wild animals. End/Start",-- [36]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [37]
	["Hier auf das Schiff warten!"] = "Wait here for the ship!",-- [38]
	["Achtung: hier geht eine Rampe runter. Daher vorsichtig laufen bis zum unteren Punkt."] = "Attention: there is a ramp going down here. Move carefully to the lower point.",-- [39]
	["Fahrstuhl!"] = "Elevator!",-- [40]
	["Brückenkopf mittlere Brücke"] = "Bridgehead middle bridge",-- [41]
	["Achtung der Questgeber bewegt sich. Allenfalls beim andern Wegpunkt suchen!"] = "Attention: the quest giver is moving. Find him at the other waypoint if he's not here!",-- [43]
	["Achtung der Questgeber bewegt sich. Allenfalls beim anderen Wegpunkt suchen!"] = "Attention: the quest giver is moving. Find him at the other waypoint if he's not here!",-- [44]
	["Ab diesem Punkt kann man den Weg nicht mehr zurücklaufen!"] = "Starting from this point you can't go back the way you came!",-- [45]
	["Kreuzung Hauptweg, und der Weg nach Tarrens Mühle und Arathi Hochgebirge ... Achtung! Auf dem Weg von Tarrens Mühle zum Araatchi Hochland läuft der Kurier der Verlassenen mit seiner Leibwache herum. Sehr gefährlich, wenn man nicht bereit ist."] = "Crossing of the main path, and the path to Tarren's Mill and Arathi foothills. Attention! The Courier is roaming between Tarren's Mill and Araatchi Highlands. Very dangerous.",-- [46]
	["Hier auf Zeppelin warten!"] = "Wait here for Zeppelin!",-- [47]
	["Achtung: Ab hier genau laufen weiter in die Höhle laufen, da gleich ein grosses Loch in der Mitte ist!"] = "Attention: Move precisely. There's a big hole in the middle!",-- [48]
	["Hier einmal vorwärts Springen!"] = "Jump forward once here!",-- [49]
	["Achtung der NPC bewegt sich hier im Kreis!"] = "Attention: the NPC moves in a circle!",-- [50]
	["Der Erzmagier läuft zwischen den beiden Routenpunkten."] = "The archmage moves between the two route points.",-- [51]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [52]
	["Achtung: nächster Wegpunkt ist der Zeppelin Anleger!"] = "Attention: next waypoint is the Zeppelin jetty!",-- [54]
	["Achtung die Trollwelpen hier können dich auch zuerst angreifen, wenn du ihnen zu nahe kommst. Da sie Humanoide sind, rennen sie kurz vor dem Sterben weg, So können sie aber auch neue Trolle/Gegner holen. Also Vorsicht!"] = "Attention: the troll whelps will attack you if you get too close to them. Be careful!",-- [55]
	["Hier einmal vorwärts Springen!"] = "Jump forward once here!",-- [56]
	["Achtung: Mob bewegt sich !"] = "Attention: creature is moving!",-- [57]
	["Achtung der Geistgeber bewegt sich. Allenfalls beim Anderen Wegpunkt suchen!"] = "Attention: the creature moves.",-- [58]
	["Kreuzung vom Hauptweg, und dem Weg nach Süderstade"] = "Crossing of the main path and the path to southshore",-- [59]
	["Achtung: Dieser Mob läuft über den ganzen Strand von Norden nach Süden"] = "Attention: This creature moves on the beach from north to south.",-- [60]
	["Sucht Gammerita zwischen dem südlichem und dem nördlichem Punkt!"] = "Look between the southern and the northern point for Gammerita!",-- [61]
	["Achtung: Hier geht eine Rampe hoch. Daher vorsichtig laufen bis zum oberen Punkt."] = "Attention: There is a ramp going up here. Therefore move carefully up to the upper point.",-- [62]
	["Achtung, links ist ein Abgrund. Rechts halten und genau laufen!"] = "Attention: There's a precipice at the left. Keep right and move carefully!",-- [63]
	["Brückenkopf Jägerlagerbrücke, Kreuzung zum Jägerlager"] = "Bridgehead hunter camp bridge, crossing to hunter camp",-- [64]
	["Achtung: Dieser Weg wird meistens von einem Dschungeldonnerer Level 38 verstellt !"] = "Attention: There is a hostile level 38 creature in your way!",-- [65]
	["Gehe zum den Wegpunkt \"Kotka erste Hilfe eins\", wenn du Starttipps haben möchtest"] = "",-- [67]
	["Gehe zum den Wegpunkt \"Kotka erste Hilfe eins\", wenn du Starttipps haben möchtest"] = "",-- [68]
	["Achtung: NPC bewegt sich!"] = "Attention: NPC is moving!",-- [69]
	["Die Rampe zum Glutnebelgipfel vorsichtig rauf laufen!"] = "Carefully move up the ramp to the Ember Peak!",-- [70]
	["Auf Schiff Warten"] = "Wait for ship",-- [71]
	["Warten auf Schiff"] = "Wait for ship",-- [72]
	["Hier auf das Schiff warten, und wenn es angekommen ist, dann zum nächsten Punkt gehen (Schiff)"] = "Wait for the ship here. When it arrives, move to the next point (ship).",-- [73]
	["Achtung: der Mob bewegt sich über die ganze Karte. -> Am besten sehende Hilfe suchen!"] = "Attention: the creature moves all over the map. Get sighted help!",-- [74]
	["Achtung: Anfang oder Ende der Brücke!"] = "Attention: beginning or end of the bridge!",-- [75]
	["Brückenkopf südliche Brücke"] = "Bridgehead southern bridge",-- [77]
	["Questgeber bewegt sich!"] = "Quest giver is moving!",-- [78]
	["Achtung: Abhang ist rechts. Den Weg zum Questgeber vorsichtig laufen. "] = "Attention: there's a slope on the right. Carefully move to the quest giver. ",-- [79]
	["Achtung: Priesterin bewegt sich zwischen Höhle und Altar"] = "Attention: Priest moves between cave and shrine.",-- [80]
	["Achtung: Nach Osten kommt die nächsten 2 Wegpunkte eine extrem schmale Brücke mit Abgrund."] = "Caution: The next 2 waypoints eastward are on a very slim bridge.",-- [81]
	["Achtung: Händler läuft hier im Kreis um den See herum!"] = "Attention: Merchant moves in a circle around the lake!",-- [82]
	["Achtung Hängebrücke Anfang."] = "Attention: rope bridge beginning.",-- [84]
	["Vorsicht: Ab hier geht es eine extrem schmale und verwinkelte Rampe ohne Geländer hoch."] = "Attention: From here the path leads up an extremely slim and twisted ramp without a railing.",-- [85]
	["Achtung: NPC bewegt sich!"] = "Attention: NPC is moving!",-- [86]
	["Ab diesem Punkt ganz besonders vorsichtig laufen!"] = "Move very carefully starting from this point!",-- [87]
	["Achtung der Questgeber bewegt sich. Allenfalls beim anderen Wegpunkt suchen!"] = "Attention: The quest giver is moving.",-- [88]
	["Achtung: nächster Wegpunkt ist der Zeppelin Anleger!"] = "Attention: next waypoint is the Zeppelin jetty!",-- [89]
	["Brückenkopf mittlere Brücke"] = "Bridgehead middle bridge",-- [90]
	["Hier Pulver auf den Stein anwenden, dann Mondklaue töten und mit dem Geist von Mondklaue sprechen. (/tar Geist)  "] = "Apply powder to the stone here. Then kill Moonclaw and talk to Moonclaw's ghost. (/tar ghost)  ",-- [91]
	["Hier auf Zeppelin warten!"] = "Wait here for Zeppelin!",-- [92]
	["Hier auf den Zeppelin warten!"] = "Wait here for Zeppelin!",-- [93]
	["Achtung: Questgeber bewegt sich!"] = "Attention: Quest giver is moving!",-- [94]
	["Vorsicht vor dem Kurier der Verlassenen und seiner Leibwache"] = "Beware of the Courier and his bodyguard",-- [95]
	["Du bist im Käfig gelandet. Willst du wirklich raus ?"] = "You've landed in the cage. Do you really want to get out ?",-- [96]
	["Achtung: Der NPC Hund bewegt sich hier sehr schnell!"] = "Attention: dog moves very fast here!",-- [97]
	["NPC bewegt sich!"] = "NPC is moving!",-- [98]
	["Vorsicht vor dem Kurier der Verlassenen und seiner Leibwache"] = "Beware of the courier and his bodyguard",-- [99]
	["Achtung: Vorsicht, gleich kommt eine hohe Brücke!"] = "Attention: be careful, very high bridge ahead!",-- [100]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [101]
	["Achtung Gefahr von den Todeswachen von Tarrens Mühle, die an diese Kreuzung ran kommen"] = "Attention: Danger from the death guards of Tarren's Mill at this crossing",-- [102]
	["Achtung: Questgeber bewegt sich!"] = "Attention: Quest giver is moving!",-- [103]
	["Ab hier reitet der Level 18 Elite \"Matis der Grausame\""] = "level 18 elite \"Matis the Cruel\" could be here.",-- [104]
	["Turm von Burg Cenarius,... unten (Erdgeschoss)"] = "Tower of Cenarius Castle,... downstairs (first floor)",-- [105]
	["Fahrstuhl Freiwindposten!"] = "Elevator Freewind Post!",-- [106]
	["Achtung: Hier musst du mindestens den Ruf \"Unfreundlich\" bei der Holzschlunderfeste haben!"] = "Attention: You need at least reputation level \"unfriendly\" with Timbermaw Hold!",-- [107]
	["Kreuzung Hauptweg und Burg Durnholde"] = "Crossing main path and castle Durnholde",-- [108]
	["Achtung dieser Übergang wird von der Horde bewacht. Durchgang bei einem defekten Palisadenstück."] = "Attention: this crossing is guarded by the horde.",-- [109]
	["Achtung: Dieser Questgeber bewegt sich! (Howin Schmeichelfeder)"] = "Attention: This quest giver is moving!",-- [110]
	["Der Erzmagier läuft zwischen den beiden Routenpunkten."] = "The Archmage moves between the two waypoints.",-- [111]
	["Falls ihr ins Wasser fällt, dann nach Gewässer, Unten oder Rettungs Punkt suchen!"] = "Search for \"Waters, below\" or \"Rescue Point\" to get out of the water!",-- [112]
	["Achtung: Hier vorsichtig die Rampe rauf laufen!"] = "Attention: Here carefully move up the ramp!",-- [113]
	["Achtung: Steg start/ende oben"] = "Attention: bridge start/end top",-- [114]
	["Questgeber bewegt sich!"] = "Quest giver moves!",-- [116]
	["Achtung: Steg start/ende unten"] = "Attention: bridge start/end down",-- [117]
	["Brückenkopf südliche Brücke"] = "Bridgehead southern bridge",-- [118]
	["Sanath ansprechen um nach oben teleportiert zu werden. Oben nach Nyrill suchen!"] = "Talk to Sanath to be teleported. Then look for Nyrill!",-- [119]
	["Questmob bewegt sich (etwas)!"] = "Creature moves!",-- [120]
	["Hier warten!"] = "Wait here!",-- [121]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [122]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [123]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [124]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [125]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [126]
	["Hier auf das Schiff warten !"] = "Wait here for the ship!",-- [127]
	["Hier auf den Fahrstuhl warten!"] = "Wait here for the elevator!",-- [128]
	["Nach der Flamme weiterlaufen und nach dem fallen unten neuen Routenpunkt aufnehmen!"] = "Move one beyond the flame. After falling down pick up a new route!",-- [129]
	["Der Aufzug wird von der Horde bewacht, gwählt ist der LINKE Aufzug. Beim Anleger warten bist der Aufzug da ist."] = "The elevator is guarded by the horde. At the jetty wait until the elevator is there.",-- [130]
	["Kreuzung vom Hauptweg, und dem Weg zur Zuflucht ... Vorsicht vor dem Kurier der Verlassenen und seiner Leibwache"] = "Intersection of the main path, and the path to the refuge. Beware of the courier.",-- [131]
	["Du bist im Fahrstuhl. Warte bis die Fahrt zu Ende ist!"] = "You are in the elevator. Wait until the ride is over!",-- [133]
	["Hier beim Laufen springen um raus zu kommen!"] = "Jump here while running to get out!",-- [134]
	["Brückenkopf nördliche Brücke"] = "Bridgehead northern bridge",-- [135]
	["Achtung: Anfang oder Ende der Brücke!"] = "Attention: Start or end of the bridge!",-- [136]
	["Suche und töte Margol, wenn du Kotka's Weg folgen willst ... Margol's Horn verschaft dir den Durchgang"] = "",-- [137]
	["Achtung: Hier gibt es Räuber Level 4 in der Druchgangshöhle nach Thelsamar Dun Morogh. "] = "Attention: There are creatures level 4 on the way to Thelsamar Dun Morogh. ",-- [138]
	["Umleitung an der Horde vorbei, durch die Wildniss. Vorsicht vor Wildtieren. Ende/Anfang"] = "Detour avoiding the horde, through the wilderness. Beware of wild animals. End/Start",-- [139]
	["Nyrill ansprechen, um wieder nach unten teleportiert zu werden. "] = "Talk to Nyrill to be teleported back down. ",-- [140]
	["Brückenkopf nördliche Brücke"] = "Bridgehead northern bridge",-- [141]
	["Achtung: NPC bewegt sicht!"] = "Attention: NPC moves!",-- [143]
	["Um rauszugehen laufe auf Sicht zum \"Rettung, Punkt,  Höhle, Die blühende Oase, Brachland\""] = "To get out select the waypoint \"Rescue, Point, Cave, Lushwater Oasis, Barrens\"",-- [144]
	["Allgemein:Beschaffe dir, so bald wie möglich, grössere Taschen. Es ist möglich 6er Taschen hier im Startgebiet zu finden, aber weit besser ist es von Anfang an 14er oder 16er Taschen zu tragen. 20er sind die grössten Taschen in AzerothWenn möglich mache die Quests im Tandem mit einem zweiten Spieler zusammen. Ein Heiler im Tandem vereinfacht das Überleben gegen Gegnergruppen ungemein.Alle Waffen, so auch Zauberstäbe, benötigen Trainig für maximle Wirkung. Bedenke dies, wenn du eine neue Waffenart beim Waffenmeister lernst, da jede neue Waffenart beim ersten Einsatz kaum Schaden macht."] = "",
	["Priester:Priester sind die Heilerklasse schlecht hin hier im Spiel. Sie können zwar auch nur Stoff tragen, dafür aber sich selber gut Schützen oder auch heilen.Für Priester ist der Zauberstab, ab Level 5, am Anfang die Hauptwaffe.Suche nun den \"Zentralpunkt Eisklammtal\""] = "",
	["Für Tipps zu deiner Klasse suche nach dem Wergpunkt \"Klassenname erste Hilfe eins\", so zum Beispiel \"Krieger erste Hilfe eins\""] = "",
	["Paladin:Paladine können genau so wie Krieger alle Rüstungen und Schilde tragen. Dazu auch die meisten Waffen.Allerdings keine Fernkampfwaffen. Der Paladin ist gut als Heiler in einem Tandem spielbar. Alleine allerings eher eine der schwereren Klassen.Suche nun den \"Zentralpunkt Eisklammtal\""] = "",
	["Schurke:Schurken können Einhand Waffen tragen. Schwerter, Dolche oder Hämmer. Dazu Leder oder Stoff -Rüstungen.Leider ist der grösste Vorteil der Schurken, aus der Verstohlenheit von hinten anzugreifen, für Blinde kaum zu machen.Daher ist der Schurke kaum zu spielen.Suche nun den \"Zentralpunkt Eisklammtal\""] = "",
	["Eisklammtal : Das Eisklammtal ist die Hochebene, in Dun Morogh, der Heimat der Zwerge und Gnome.Hier starten auch die Helden beider Rassen mit ihren ersten Aufgaben.Ambossar:Ambossar ist deine Startsiedlung. Hier findest du Waffen/Rüstungschmiede oder Veräufer, die deine Sachen reparieren können, oder Gemischtwarenhändler für Essen, Wasser und Munition "] = "",
	["Physische Klassen:Krieger,Schurken, aber auch Jäger machen vor allem physischen Schaden.Dieser kann durch einen besseren Rüstungswert vermindert werden.Nach möglichkeit alle Waffenarten beim Waffenmeister lernen"] = "",
	["Jäger:Jäger haben den Vorteil, das sie aus der Ferne kämpfen können. Allerdings funktioniert die Fernwaffe erst bei einem Abstand von mindestens 8 Metern.Dazu braucht es noch die Munition. Am Anfang bis Level 10 sind daher die Jäger nicht einfach zu spielen. Erst mit einem gezähmten Tier, wird der Jäger zu einer einfachen Klasse.Mit seinem Tier auch gut alleine spielbar, Sie tragen Leder oder später auch KettenrsütungenSuche nun den \"Zentralpunkt Eisklammtal\""] = "",
	["Zauberklassen: Diese verbrauchen Mana um die Zauber wirken zu lassen. Je nach dem brauchen sie mehrere Sekunden Zauberzeit.Der Schaden ist magisch. Daher entweder Feuer, Eis, Arkan, Schatten, Natur oder Heilig -Schaden.Manche Gegner haben gegen bestimmte Magiearten eine Resistenz, oder sind völlig immun dagegen. Ab lvl 5 umbedingt von einem Verzauberer einen Zauberstab machen lassen, um auch ohne Mana Schaden machen zu können. "] = "",
	["Hexer:Hexer sind änlich wie Magier auf ihr Mana angewiesen, das sie später durch Aderlass auch aus dem Leben gewinnen können.Sie haben wie auch die Jäger einen Begleiter, der sie unterstützen kann.Suche nun den \"Zentralpunkt Eisklammtal\""] = "",

	["Hier springen um rauf zu kommen !"] = "Jump here to get to the upper point",
	["Warnung: Lifte können tödlich sein. Sicherer sind Gneis Wege!"] = " ",
	["Zauberklassen: Diese verbrauchen Mana um die Zauber wirken zu lassen. Je nach dem brauchen sie mehrere Sekunden Zauberzeit.Der Schaden ist magisch. Daher entweder Feuer, Eis, Arkan, Schatten, Natur oder Heilig -Schaden.Manche Gegner haben gegen bestimmte Magiearten eine Resistenz, oder sind völlig immun dagegen. Ab lvl 5 umbedingt von einem Verzauberer einen Zauberstab machen lassen, um auch ohne Mana Schaden machen zu können.  "] = " ",
	["Bitte die Translokationskugel benutzen um das Stockwerk zu wechseln"] = "Use the translocation sphere to be teleported.",
	["Ab hier musst du extrem vorsichtig sein. Brücke, Schlucht und Tod lauern."] = "Be extremely careful from here on. There is a bridge. Don't fall down.",
	["Ein- und Ausgang Schlucht"] = "Entrance and exit of the gorge",
	["rettungspunkt unten schlucht 1"] = "Rescue point at the bottom of gorge 1",
	["Fahrstuhleingang mitte unten. Bei Route in den Fahrstuhl: Ignoriere den Fahrstuhl einfach. Lauf von hier geradeaus weiter, egal ob der Fahrstuhl da ist. Du fällst eine Etage nach unten und erreichst dort den Fahrstuhleingang unten, von dem du normal die Route weiter läufst. "] = "Elevator entry lower middle. If you are on a route into the elevator: Just ignore the elevator. Run straight ahead from here, regardless of whether the elevator is there. You will fall down one floor and reach the elevator entrance at the bottom. Continue the route from there. ",
	["Vorsicht! Nach Süden geht es über eine schmale Brücke. Nach Osten geh es am Rand einer Schlucht entlang. Nach Norden ist eine sichere Straße."] = "Caution. To the south you will cross a very narrow bridge. To the east you walk along the edge of a gorge. To the north is a safe road.",
	["Vorsicht: Extrem schmale Brücke mit Schlucht!"] = "Caution: Extremely narrow bridge.",
	["Um das Tor für die Zerschmetternden Hallen aufzumachen, brauchst du einen Schlüssel."] = " ",
	["Vorsicht! Ab hier geht es auf diesem Weg im Uhrzeigersinn um eine Schlucht herum. Du läufst am Rand. Präzise laufen!"] = "Caution. From here on this route is a the edge of a gorge. Move very precisely!",
	["Achtung: Ab hier zum nächsten Punkt springen!"] = "Attention: From here jump to the next point!",
	["rettungspunkt unten schlucht"] = "rescue point at the bottom of the gorge",
	["Vorsicht. Extrem schmale Brücke mit Schlucht."] = "Caution. Extremely narrow bridge. Don't fall down.",
	["Hier ist der Höhleneingang"] = "Here is the cave entrance",
	["Nächster Punkt ist der Fahrstuhleingang. Der Fahrstuhl hat vier Haltestellen: unten, mitte unten, mitte oben, oben. Er macht beim Ankommen ein lautes Knallgeräusch. Beim Abfahren ein Heulgeräusch. Im Fahrstuhl gibt es ein dauerhaftes Maschinengeräusch. Die Maschine befindet sich zwischen Mitte unten und Mitte oben. Lautstärke an den Haltestellen: unten leises Geräusch, mitte unten und mitte oben laut, oben kein Geräusch."] = "Next waypoint is the elevator entrance. The elevator has four stops: bottom, lower middle, upper middle, top. It makes a loud banging noise when arriving. When departing, it makes a howling noise. There is a constant machine noise in the elevator. The machine is between lower middle and upper middle. Volume at the stops: bottom quiet noise, lower middle and upper middle loud, top no noise.",
	["Östlicher Ein- und Ausgang Schlucht"] = "Eastern entrance and exit of the gorge",
	["Hier auf den Lift warten !"] = "Wait for the elevator here",
	["Steinbruchtor. Klicken zum Öffnen."] = "Gate. Click to open.",
	["Hier das Questitem einsetzen !"] = "Put the questitem here",
	["Inneres Portal des Sanktums"] = "Inner portal of the sanctum",
	["Hier auf den Zeppelin warten !"] = "Wait for the zeppelin here",
	["Hier kommt der Teleportpunkt aus der Höhle zu Haleh. Einfach ab hier ein paar Schritte vorlaufen."] = "Next is the teleport waypoint to Haleh. Just walk a few steps forward from here.",
	["Um den Schlüssel für dieses Tor zu bekommen, musst du Margol töten und das Horn holen."] = "To get the key for this gate you have to kill Margol and get the horn.",
	["Unterer höhleneingang"] = "Lower cave entrance",
	["Fahrstuhleingang unten. Bei Route in den Fahrstuhl: Warte, bis das Knallgeräusch vom ankommenden Fahrstuhl direkt vor dir zu hören ist (maximal laut). Geh zum nächsten Punkt, der im Fahrstuhl ist. Fahr nur eine Etage hoch bis mitte unten. Geh dann geradeaus wieder aus dem Fahrstuhl raus zum Fahrstuhleingang mitte unten."] = "Elevator entrance at the bottom. If you're on a route into elevator: wait until you hear the slamming sound from the arriving elevator right in front of you (maximum volume). Move to the next point, which is in the elevator. Ride one floor up to the lower middle floor. Then move straight out of the elevator to the waypoint elevator entrance lower middle.",
	["Achtung, gleich springen!"] = "Be careful, you need to jump at next waypoint!",
	["Vorsicht! Nach Norden geht es über eine enge Brücke. Nach Osten geht es gegen den Urhzeigersinn an einer einem Schluchtrand entlang. Nach Westen geht es im Uhrzeigersinn am Schluchtrand entlang."] = "Be careful! To the south you will cross a very narrow bridge. To the east you walk along the edge of a gorge. To the west you walk along the edge of a gorge too.",
	["Tapoke \"Slim\" Jahn"] = 'Tapoke "Slim" Jahn',	
	["Überprüfe nochmals ob du wirklich alle Quests im Eisklamm-Tal erledigt hast, bevor du in die nächste Stadt aufbrichst."] = "",
	["Benutze hier die Translokationskugel, um wieder nach unten zu kommen."] = "Use the translocation sphere here to get back down.",
	["Benutze die Translokationskugel beim nächsten Wegpunkt um nach oben zu kommen."] = "Use the translocation sphere at the next waypoint to get back up.",
	["Für die Rückkehr nach unten, mache eine neue Route auf, mit dem Ziel das Portal Oben."] = "To get back down, start a new route to the upper portal.",
	["Töte die beiden Kerkermeister und öffne mit den Schlüsseln die Schlösser zu den Füssen der Gefangenen mit rechtklick. "] = "Kill the two jailers and use the keys to open the locks at the feet of the prisoners via right click. ",
	["Im Fahrstuhl"] = "in the elevator",
	["Moonglade"] = "Moonglade",
	["Winterspring"] = "Winterspring",
	["Sonnenhof"] = "Court of the Sun",
	["h"] = "h",
	["Ironforge"] = "Ironforge",
	["Undercity"] = "Undercity",
	["s"] = "s",
	["u"] = "u",
	["Slaughter Hollow"] = "Slaughter Hollow",
	["Everlook"] = "Everlook",
	["Der Basar"] = "The Bazaar",
	["Mördergasse"] = "Murder Row",
	["Stormwind"] = "Stormwind",
	["Fungal Rock"] = "Fungal Rock",
	["moonglade"] = "moonglade",
	["Sonnenzornturm"] = "Sunfury Spire",
	["Avelina Lilly"] = "Avelina Lilly",
	["Gneis"] = "Gneis",
	["Kotka"] = "Kotka",		
	["Von hier 2 sekunden geradeaus laufen, um durch das portal zu gehen."] = "From here move 1 second forward, to get through the portal.",
	["Hier Questgegenstand benutzen"] = "Use quest item here",
	["Von hier eine Sekunde geradeaus laufen, um durch das Portal zu gehen."] = "From here move 1 second forward, to get through the portal.",
	["Stopp. Wenn du unter level 20 bist, und von menethil nach loch modan willst, bleib hier steht. Prüfe, ob vor dir ein mob ist. Wenn das der fall ist, warte hier bis dieser sich wegbewegt hat. laufe erst dann weiter! Solltest du trotzdem angegriffen werden, bleib nicht stehen. lauf weiter der route nach."] = "Stop. If you are under level 20 and want to go from menethil to loch modan, stop here. Check if there is a mob in front of you. If that is the case, wait here until it has moved away and can't be targeted anymore. Then continue! If you are attacked anyway, don't stop. keep following the route to get as far as possible before you are dead.",	
}


SkuTranslatedData = {}
local slower = string.lower
function SkuTranslateStringDeToEn(aString)
	local tTranslation

	--split by semicolon
	local tInd = 0
	for str in string.gmatch(aString, "([^;]+)") do
		local tTarget = str
		tInd = tInd + 1
		if not tonumber(str) and str ~= "auto" and (tInd == 1 and str == "Tal") == false then
			local tstrlower = slower(str)
			local tFound = false

			if tFound == false then
				for i, v in pairs(tAdditionalTranslations) do
					if slower(i) == tstrlower then
						tTarget = v
						tFound = true
						break
					end
				end
			end

			--maps.lua
			if tFound == false then
				for i, v in pairs(SkuDB.ExternalMapID) do
					local tToTest = slower(v.Name_lang.deDE)
					if tToTest == tstrlower then
						tTarget = v.Name_lang.enUS
						tFound = true
						break
					end
				end
				if tFound == false then
					for i, v in pairs(SkuDB.InternalAreaTable) do
						local tToTest = slower(v.AreaName_lang.deDE)
						if tToTest == tstrlower then
							tTarget = v.AreaName_lang.enUS
							tFound = true
							break
						end
					end
				end
			end

			--creatures.lua
			if tFound == false then
				for i, v in pairs(SkuDB.NpcData.Names.deDE) do
					if SkuDB.NpcData.Names.enUS[i] then
						if v[1] then
							local tToTest = slower(v[1])
							if tToTest == tstrlower then
								tTarget = SkuDB.NpcData.Names.enUS[i][1]
								tFound = true
								break
							end
						end
						if tFound == false then
							if v[2] then
								local tToTest = slower(v[2])
								if tToTest == tstrlower then
									tTarget = SkuDB.NpcData.Names.enUS[i][2]
									tFound = true
									break
								end
							end
						end
					end
					--[[
					local tI = string.gsub(i, "'", "\'")
					if SkuDB.NpcData.Names.enUS[tI] then
						if v[1] then
							local tToTest = slower(v[1])
							if tToTest == tstrlower then
								tTarget = SkuDB.NpcData.Names.enUS[tI][1]
								tFound = true
								break
							end
						end
						if tFound == false then
							if v[2] then
								local tToTest = slower(v[2])
								if tToTest == tstrlower then
									tTarget = SkuDB.NpcData.Names.enUS[tI][2]
									tFound = true
									break
								end
							end
						end
					end
					]]
				end
			end

			--objects.lua
			if tFound == false then
				for i, v in pairs(SkuDB.objectLookup.deDE) do
					if SkuDB.objectLookup.enUS[i] then
						if v then
							local tToTest = slower(v)
							if tToTest == tstrlower then
								tTarget = SkuDB.objectLookup.enUS[i]
								tFound = true
								break
							end
						end
					end
					--[[
					local tI = string.gsub(i, "'", "\'")
					if SkuDB.objectLookup.enUS[tI] then
						if v then
							local tToTest = slower(v)
							if tToTest == tstrlower then
								tTarget = SkuDB.objectLookup.enUS[tI]
								tFound = true
								break
							end
						end
					end
					]]
				end	
			end

			--glossary
			if tFound == false then
				local tDeToEnIndex = {
					["Routen Wörter"] = "routes",
					["Orte"] = "locations",
					["Bindewörter"] = "connective words",
					["Orientierung"] = "orientation",
					["Klassen"] = "classes",
					["Gegnertypen"] = "enemy types",
					["Berufe"] = "professions",
					["Tätigkeiten"] = "activities",
					["Spezial"] = "special",
					["Maßeinheiten"] = "measurement units",
					["Farben"] = "colors",
					["Zahlen"] = "numbers",
				}
				for i, v in pairs(SkuOptions.Glossary1.deDE) do
					for y = 1, #SkuOptions.Glossary1.deDE[i] do
						local tToTest = slower(SkuOptions.Glossary1.deDE[i][y])
						if tToTest == tstrlower then
							tTarget = slower(SkuOptions.Glossary1.enUS[tDeToEnIndex[i]][y])
							tFound = true
							break
						end
					end
				end
			end

			--items.lua
			if tFound == false then
				for i, v in pairs(SkuDB.itemLookup.deDE) do
					if SkuDB.itemLookup.enUS[i] then
						if v then
							local tToTest = slower(v)
							if tToTest == tstrlower then
								tTarget = SkuDB.itemLookup.enUS[i]
								tFound = true
								break
							end
						end
					end
					--[[
					local tI = string.gsub(i, "'", "\'")
					if SkuDB.itemLookup.enUS[tI] then
						if v then
							local tToTest = slower(v)
							if tToTest == tstrlower then
								tTarget = SkuDB.itemLookup.enUS[tI]
								tFound = true
								break
							end
						end
					end	
					]]				
				end
			end

			--spells.lua
			if tFound == false then
				for i, v in pairs(SkuDB.SpellDataTBC) do
					local tToTest = slower(v.deDE[1])
					if tToTest == tstrlower then
						tTarget = v.enUS[1]
						tFound = true
						break
					end
				end	
			end

			--quest.lua
			if tFound == false then		
				for i, v in pairs(SkuDB.questLookup.deDE) do
					if SkuDB.questLookup.enUS[i] then
						if SkuDB.questLookup.enUS[i][1] then
							if v[1] then
								local tToTest = slower(v[1])
								if tToTest == tstrlower then
									tTarget = SkuDB.questLookup.enUS[i][1]
									tFound = true
									break
								end
							end
						end
					end
					--[[
					local tI = string.gsub(i, "'", "\'")
					if SkuDB.questLookup.enUS[tI] then
						if SkuDB.questLookup.enUS[tI][1] then
							if v[1] then
								local tToTest = slower(v[1])
								if tToTest == tstrlower then
									tTarget = SkuDB.questLookup.enUS[tI][1]
									tFound = true
									break
								end
							end
						end
					end	
					]]				
				end	
			end

			if tFound == false then
				SkuTranslatedData.untranslatedTerms = SkuTranslatedData.untranslatedTerms or {}
				if not SkuTranslatedData.untranslatedTerms[str] then
					SkuTranslatedData.untranslatedTerms[str] = true
					--print("UNTRANSLATED:", str)
				end
			end
		end

		--add translated term
		if not tTranslation then
			tTranslation = tTarget
		else
			tTranslation = tTranslation..";"..tTarget
		end
	end

	return tTranslation
end

---------------------------------------------------------------------------------------------------------------------------------------
local tSkuCoroutineControlFrameOnUpdateTimer = 0
function SkuDefaultWp2DeToEn()
	SkuTranslatedData.DefaultWaypoints2 = SkuTranslatedData.DefaultWaypoints2 or {}
	SkuTranslatedData.DefaultWaypoints2 = {}

	local co = coroutine.create(function ()
		print("test")
		--for q = 1, #SkuDB.DefaultWaypoints["deDE"] do
			local tIndex = SkuDB.DefaultWaypoints["deDE"][4]
			local tIndexEN = SkuTranslateStringDeToEn(tIndex)
			local tValue = SkuDB.DefaultWaypoints["deDE"][SkuDB.DefaultWaypoints["deDE"][4]]
			print(3, tIndex, tValue)
			print("TEST 1", tIndex, #SkuTranslatedData.DefaultWaypoints2, tIndexEN)
			table.insert(SkuTranslatedData.DefaultWaypoints2, #SkuTranslatedData.DefaultWaypoints2 + 1, tIndexEN)
			SkuTranslatedData.DefaultWaypoints2[tIndexEN] = {}

			for x = 1, #tValue do
				local tIndex1 = tValue[x]
				local tIndex1EN = SkuTranslateStringDeToEn(tIndex1)
				local tValue1 = tValue[tValue[x]]
				print("  ", 2, tIndex1, tValue1, #tValue1)
				print("TEST 1 1", tIndex)
				print("TEST 1 2", #SkuTranslatedData.DefaultWaypoints2[tIndexEN])
				print("TEST 1 3", tIndex1EN)
				table.insert(SkuTranslatedData.DefaultWaypoints2[tIndexEN], #SkuTranslatedData.DefaultWaypoints2[tIndexEN] + 1, tIndex1EN)
				print("TEST 2")
				SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN] = {}			
				print("TEST 3", tValue1)
				if tValue1.createdAt then
					SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN] = tValue1
					setmetatable(tValue1, SkuPrintMTWo)
					print("tValue1.createdAt", tValue1)	
				else
					print("NOT tValue1.createdAt")
					for y = 1, #tValue1 do
						local tIndex2 = tValue1[y]
						local tIndex2EN = SkuTranslateStringDeToEn(tIndex2)
						local tValue2 = tValue1[tValue1[y]]
						print("    ",3 , tIndex2, tValue2)
						table.insert(SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN], #SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN] + 1, tIndex2EN)
						SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN] = {}			
						if tValue2.createdAt then
							SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN] = tValue2
							setmetatable(tValue2, SkuPrintMTWo)
							print(tValue2)	
						else
							for z = 1, #tValue2 do
								local tIndex3 = tValue2[z]
								local tIndex3EN = SkuTranslateStringDeToEn(tIndex3)
								local tValue3 = tValue2[tValue2[z]]
								print("      ", 4 , tIndex3, tValue3)
								table.insert(SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN], #SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN] + 1, tIndex3EN)
								SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN] = {}										
								if tValue3.createdAt then
									SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN] = tValue3
									setmetatable(tValue3, SkuPrintMTWo)
									print(tValue3)	
								else
									for i = 1, #tValue3 do
										local tIndex4 = tValue3[i]
										local tIndex4EN = SkuTranslateStringDeToEn(tIndex4)
										local tValue4 = tValue3[tValue3[i]]
										print("        ", 5 , tIndex4, tValue4)
										table.insert(SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN], #SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN] + 1, tIndex4EN)
										SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN][tIndex4EN] = {}									
										if tValue4.createdAt then
											SkuTranslatedData.DefaultWaypoints2[tIndexEN][tIndex1EN][tIndex2EN][tIndex3EN][tIndex4EN] = tValue4
											setmetatable(tValue3, SkuPrintMTWo)
											print(tValue3)											
										else
											print("          WTF??")
										end
						
									end		
								end
							end		
						end
						coroutine.yield()
					end
				end
				print("TEST 4")
			end
		--end
	end)

	local tCoCompleted = false
	local tSkuCoroutineControlFrame = _G["SkuCoroutineControlFrame"] or CreateFrame("Frame", "SkuCoroutineControlFrame", UIParent)
	tSkuCoroutineControlFrame:SetPoint("CENTER")
	tSkuCoroutineControlFrame:SetSize(50, 50)
	tSkuCoroutineControlFrame:SetScript("OnUpdate", function(self, time)
		tSkuCoroutineControlFrameOnUpdateTimer = tSkuCoroutineControlFrameOnUpdateTimer + time
		if tSkuCoroutineControlFrameOnUpdateTimer < 0.1 then return end

		if coroutine.status(co) == "suspended" then
			coroutine.resume(co)
		else
			if tCoCompleted == false then
				print("completed")
				tCoCompleted = true
			end
		end

	end)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuObjectResourceNamesDeToEn()
	SkuTranslatedData.objectResourceNames = SkuTranslatedData.objectResourceNames or {}
	SkuTranslatedData.objectResourceNames = {}

	local co = coroutine.create(function ()
		for i, v in pairs(SkuDB.objectResourceNames) do
			local tIndex = i
			local tIndexEN = SkuTranslateStringDeToEn(i)
			local tValue = v
			print(tIndex, tValue)
			SkuTranslatedData.objectResourceNames[tIndexEN] = true
			
		end
	end)

	local tCoCompleted = false
	local tSkuCoroutineControlFrame = _G["SkuCoroutineControlFrame"] or CreateFrame("Frame", "SkuCoroutineControlFrame", UIParent)
	tSkuCoroutineControlFrame:SetPoint("CENTER")
	tSkuCoroutineControlFrame:SetSize(50, 50)
	tSkuCoroutineControlFrame:SetScript("OnUpdate", function(self, time)
		tSkuCoroutineControlFrameOnUpdateTimer = tSkuCoroutineControlFrameOnUpdateTimer + time
		if tSkuCoroutineControlFrameOnUpdateTimer < 0.01 then return end

		if coroutine.status(co) == "suspended" then
			coroutine.resume(co)
		else
			if tCoCompleted == false then
				print("completed")
				tCoCompleted = true
			end
		end

	end)	
end









---------------------------------------------------------------------------------------------------------------------------------------
-- rt link data
local tSkuCoroutineControlFrameOnUpdateTimer = 0
local tCounter = 0
function SkuRtLinkDataDeToEn()
	tCounter = 0
	SkuTranslatedData.Links = SkuTranslatedData.Links or {}
	SkuTranslatedData.Links = {}

	local co = coroutine.create(function ()
		local tNumberDone = 0
		for i, v in pairs(SkuDB.routedata[Sku.Loc].Links) do
			local tIndex = i
			local tIndexEN = SkuTranslateStringDeToEn(i)
			local tValue = v

			--print(1, tIndex, tValue)
			SkuTranslatedData.Links[tIndexEN] = {}

			for i1, v1 in pairs(tValue) do
				local tIndex1 = i1
				local tIndex1EN = SkuTranslateStringDeToEn(i1)
				local tValue1 = v1
				--print("  ", 2, tIndex1, tValue1)
				SkuTranslatedData.Links[tIndexEN][tIndex1EN] = v1
			end
			tCounter = tCounter + 1
			--print(tCounter)
			tNumberDone = tNumberDone + 1
			if tNumberDone > 100 then
				tNumberDone = 0
				print(tCounter)
				coroutine.yield()
			end

		end
	end)

	local tCoCompleted = false
	local tSkuCoroutineControlFrame = _G["SkuCoroutineControlFrame"] or CreateFrame("Frame", "SkuCoroutineControlFrame", UIParent)
	tSkuCoroutineControlFrame:SetPoint("CENTER")
	tSkuCoroutineControlFrame:SetSize(50, 50)
	tSkuCoroutineControlFrame:SetScript("OnUpdate", function(self, time)
		tSkuCoroutineControlFrameOnUpdateTimer = tSkuCoroutineControlFrameOnUpdateTimer + time
		if tSkuCoroutineControlFrameOnUpdateTimer < 0.01 then return end

		if coroutine.status(co) == "suspended" then
			print("res")
			coroutine.resume(co)
		else
			if tCoCompleted == false then
				print("completed")
				tCoCompleted = true
			end
		end

	end)

end

---------------------------------------------------------------------------------------------------------------------------------------
-- rt link data
local tSkuCoroutineControlFrameOnUpdateTimer = 0
local tCounter = 0
function SkuRtWpDataDeToEn()--Tal!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	tCounter = 0
	SkuTranslatedData.Waypoints = SkuTranslatedData.Waypoints or {}
	SkuTranslatedData.Waypoints = {}
	SkuTranslatedData.Comments = SkuTranslatedData.Comments or {}
	SkuTranslatedData.Comments = {}

	local co = coroutine.create(function ()

		local tNumberDone = 0
		for q = 1, #SkuDB.routedata[Sku.Loc].Waypoints do
			local tIndex = SkuDB.routedata[Sku.Loc].Waypoints[q]
			local tIndexEN = SkuTranslateStringDeToEn(tIndex)
			local tValue = SkuDB.routedata[Sku.Loc].Waypoints[SkuDB.routedata[Sku.Loc].Waypoints[q]]
			--print(1, tIndex, tValue)
			table.insert(SkuTranslatedData.Waypoints, #SkuTranslatedData.Waypoints + 1, tIndexEN)
			SkuTranslatedData.Waypoints[tIndexEN] = SkuDB.routedata[Sku.Loc].Waypoints[SkuDB.routedata[Sku.Loc].Waypoints[q]]
			if SkuDB.routedata[Sku.Loc].Waypoints[SkuDB.routedata[Sku.Loc].Waypoints[q]].comments then
				for x = 1, #SkuDB.routedata[Sku.Loc].Waypoints[SkuDB.routedata[Sku.Loc].Waypoints[q]].comments do
					SkuTranslatedData.Waypoints[tIndexEN].comments = SkuTranslatedData.Waypoints[tIndexEN].comments or {}
					SkuTranslatedData.Waypoints[tIndexEN].comments[x] = SkuTranslateStringDeToEn(SkuDB.routedata[Sku.Loc].Waypoints[SkuDB.routedata[Sku.Loc].Waypoints[q]].comments[x])
				end
			end
			tCounter = tCounter + 1
			tNumberDone = tNumberDone + 1
			if tNumberDone > 500 then
				tNumberDone = 0
				print(tCounter)
				coroutine.yield()
			end
		end
	end)

	local tCoCompleted = false
	local tSkuCoroutineControlFrame = _G["SkuCoroutineControlFrame"] or CreateFrame("Frame", "SkuCoroutineControlFrame", UIParent)
	tSkuCoroutineControlFrame:SetPoint("CENTER")
	tSkuCoroutineControlFrame:SetSize(50, 50)
	tSkuCoroutineControlFrame:SetScript("OnUpdate", function(self, time)
		tSkuCoroutineControlFrameOnUpdateTimer = tSkuCoroutineControlFrameOnUpdateTimer + time
		if tSkuCoroutineControlFrameOnUpdateTimer < 0.01 then return end

		if coroutine.status(co) == "suspended" then
			print("res")
			coroutine.resume(co)
		else
			if tCoCompleted == false then
				print("completed")
				tCoCompleted = true
				--SkuRtLinkDataDeToEn()
			end
		end

	end)

end

